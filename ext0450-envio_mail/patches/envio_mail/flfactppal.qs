
/** @class_declaration envioMail */
/////////////////////////////////////////////////////////////////
//// ENVIO MAIL /////////////////////////////////////////////////
class envioMail extends oficial {
	var oCorreo_;
	function envioMail( context ) { oficial ( context ); }
	function enviarCorreo(cuerpo, asunto, arrayDest, arrayAttach) {
		return this.ctx.envioMail_enviarCorreo(cuerpo, asunto, arrayDest, arrayAttach);
	}
	function componerCorreo(cuerpo:String, asunto:String, arrayDest:Array, arrayAttach:Array) {
		return this.ctx.envioMail_componerCorreo(cuerpo, asunto, arrayDest, arrayAttach);
	}
	function componerListaDestinatarios(codigo:String, tabla:String) {
		return this.ctx.envioMail_componerListaDestinatarios(codigo, tabla);
	}
	function existeEnvioMail() {
		return this.ctx.envioMail_existeEnvioMail();
	}
	function dameMailTo(cuerpo, asunto, arrayDest, arrayAttach) {
		return this.ctx.envioMail_dameMailTo(cuerpo, asunto, arrayDest, arrayAttach);
	}
	function extension(nE) {
		return this.ctx.envioMail_extension(nE);
	}
	function datosSMTPUsuario() {
		return this.ctx.envioMail_datosSMTPUsuario();
	}
	function enviaCorreoSMTP(cuerpo, asunto, arrayDest, arrayAttach, oDM) {
		return this.ctx.envioMail_enviaCorreoSMTP(cuerpo, asunto, arrayDest, arrayAttach, oDM);
	}
	function smtpClient_statusChanged(msg, code) {
		return this.ctx.envioMail_smtpClient_statusChanged(msg, code);
	}
}
//// ENVIO MAIL /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubEnvioMail */
/////////////////////////////////////////////////////////////////
//// PUB ENVIO MAIL /////////////////////////////////////////////
class pubEnvioMail extends envioMail {
	function pubEnvioMail( context ) { envioMail ( context ); }
	function pub_enviarCorreo(cuerpo:String, asunto:String, arrayDest:Array, arrayAttach:Array) {
		return this.enviarCorreo(cuerpo, asunto, arrayDest, arrayAttach);
	}
	function pub_componerListaDestinatarios(codigo:String, tabla:String) {
		return this.componerListaDestinatarios(codigo, tabla);
	}
	function pub_existeEnvioMail() {
		return this.existeEnvioMail();
	}
	function pub_enviaCorreoSMTP(cuerpo, asunto, arrayDest, arrayAttach, oDM) {
		return this.enviaCorreoSMTP(cuerpo, asunto, arrayDest, arrayAttach, oDM);
	}
}

//// PUB ENVIO MAIL /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/** @class_definition envioMail */
/////////////////////////////////////////////////////////////////
//// ENVIO MAIL /////////////////////////////////////////////////
function envioMail_componerListaDestinatarios(codigo:String, tabla:String)
{debug(tabla);
	var util= new FLUtil();
	var arrayMails= [];
	var listaDestinatarios:String;
	var emailPrincipal:String;
	var nombrePrincipal:String;
	var dialog;
	var q= new FLSqlQuery();

	switch (tabla) {
		case "clientes": {
			emailPrincipal = util.sqlSelect("clientes", "email", "codcliente = '" + codigo + "'");
			nombrePrincipal = util.sqlSelect("clientes", "nombre", "codcliente = '" + codigo + "'");
					
			q.setTablesList("contactosclientes,crm_contactos");
			q.setFrom("contactosclientes INNER JOIN crm_contactos ON contactosclientes.codcontacto = crm_contactos.codcontacto");
			q.setSelect("crm_contactos.email,crm_contactos.nombre");
			q.setWhere("contactosclientes.codcliente = '" + codigo + "' AND (crm_contactos.email <> '' AND crm_contactos.email IS NOT NULL)");
			if (!q.exec()) {
				return false;
			}
			dialog = new Dialog(util.translate ( "scripts", "Contactos del cliente" ), 0);
			break;
		}
		case "proveedores": {
			emailPrincipal = util.sqlSelect("proveedores", "email", "codproveedor = '" + codigo + "'");
			nombrePrincipal = util.sqlSelect("proveedores", "nombre", "codproveedor = '" + codigo + "'");
					
			q.setTablesList("contactosproveedores,crm_contactos");
			q.setFrom("contactosproveedores INNER JOIN crm_contactos ON contactosproveedores.codcontacto = crm_contactos.codcontacto");
			q.setSelect("crm_contactos.email,crm_contactos.nombre");
			q.setWhere("contactosproveedores.codproveedor = '" + codigo + "' AND (crm_contactos.email <> '' AND crm_contactos.email IS NOT NULL)");
			if (!q.exec()) {
				return false;
			}
			dialog = new Dialog(util.translate ( "scripts", "Contactos del proveedor" ), 0);
			break;
		}
	}
debug("emailPrincipal " + emailPrincipal);
	dialog.caption = "Selecciona el destinatario";
	dialog.OKButtonText = util.translate ( "scripts", "Aceptar" );
	dialog.cancelButtonText = util.translate ( "scripts", "Cancelar" );
	
	var bgroup:GroupBox = new GroupBox;
	dialog.add( bgroup );
	var cB= [];
	var nEmails= 0;	
	
	cB[nEmails] = new CheckBox;
	cB[nEmails].text = util.translate ( "scripts", nombrePrincipal + " (" + emailPrincipal + ")");
	arrayMails[nEmails] = emailPrincipal;
	cB[nEmails].checked = true;
	bgroup.add( cB[nEmails] );
	nEmails ++;
	
	while (q.next())  {
		cB[nEmails] = new CheckBox;
		cB[nEmails].text = util.translate ( "scripts", q.value(1) + " (" + q.value(0) + ")");
		arrayMails[nEmails] = q.value(0);
		cB[nEmails].checked = false;
		bgroup.add( cB[nEmails] );
		nEmails ++;
	}
debug("nEmails " + nEmails);
	if (nEmails > 1) {
		nEmails --;
		var lista = "";
		if(dialog.exec()) {
			for (var i= 0; i <= nEmails; i++) {
				if (cB[i].checked == true) {
debug("arrayMails[i] " + arrayMails[i]);
					if(lista == "") {
						lista = arrayMails[i] + ",";
					}
					else {
						lista += arrayMails[i] + ",";
					}
				}
			}
		} else {
			return false;
		}
		if (lista != "") {
			lista = lista.left(lista.length -1)
		}
		listaDestinatarios = lista;
	}
	else {
		listaDestinatarios = emailPrincipal;
	}
	listaDestinatarios = listaDestinatarios && listaDestinatarios != "" ? listaDestinatarios : " ";
	debug("listaDestinatarios '" + listaDestinatarios + "'");
	return listaDestinatarios;
}

function envioMail_enviarCorreo(cuerpo, asunto, arrayDest, arrayAttach)
{
	var _i = this.iface;
	
	var clienteCorreo = AQUtil.readSettingEntry("scripts/flfactinfo/clientecorreo");
	if (clienteCorreo == "Eneboo") {
		return _i.enviaCorreoSMTP(cuerpo, asunto, arrayDest, arrayAttach);
	}
	var comando= _i.componerCorreo(cuerpo, asunto, arrayDest, arrayAttach);
	if (!comando) {
		return false;
	}
	if (!sys.launchCommand(comando)) {
		var url = _i.dameMailTo(cuerpo, asunto, arrayDest, arrayAttach);
		if (!url) {
			return false;
		}
		sys.openUrl(url)
	}

	return true;
}

function envioMail_datosSMTPUsuario()
{
	var oDM = {};
	var curUsuario = new FLSqlCursor("usuarios");
	curUsuario.select("idusuario = '" + sys.nameUser() + "'");
	if (!curUsuario.first()) {
		return false;
	}
	curUsuario.setModeAccess(curUsuario.Browse);
	curUsuario.refreshBuffer();
	var datos = ["hostcorreosaliente", "puertosmtp", "tipocxsmtp", "tipoautsmtp", "usuariosmtp", "passwordsmtp"];
	for (i = 0; i < datos.length; i++) {
		oDM[datos[i]] = curUsuario.valueBuffer(datos[i]);
	}
	return oDM;
}

function envioMail_enviaCorreoSMTP(cuerpo, asunto, arrayDest, arrayAttach, oDM)
{
	var _i = this.iface;
	
	if (!oDM) {
		oDM = _i.datosSMTPUsuario();
		if (!oDM) {
			sys.warnMsgBox(sys.translate("Error al obtener los datos de cliente de correo asociadoas al usuario conectado"));
			return false;	
		}
	}
	_i.oCorreo_ = new AQSmtpClient;  
	var oCorreo = _i.oCorreo_;
	connect(oCorreo, "statusChanged(QString, int)", _i, "smtpClient_statusChanged");

	oCorreo.setMailServer(oDM.hostcorreosaliente);
	oCorreo.setPort(oDM.puertosmtp);
	switch (oDM.tipocxsmtp) {
		case "SSL": {
			oCorreo.setConnectionType(AQS.SmtpSslConnection);  
			break;
		}
		case "TLS": {
			oCorreo.setConnectionType(AQS.SmtpTlsConnection);
			break;
		}
		default: {
			//return false;
		}
	}
		
	switch (oDM.tipoautsmtp) {
		case "Plain": {
			oCorreo.setAuthMethod(AQS.SmtpAuthPlain);
			break;
		}
		case "Login": {
			oCorreo.setAuthMethod(AQS.SmtpAuthLogin);
			break;
		}
		default: {
			//return false;
		}
	}
	//** Tambien se puede usar el método Login
	//** Algunos servidores sólo soportan Login
	//** GMail soporta los dos Plain y Login
	//** _i.correo_.setAuthMethod(AQS.SmtpAuthLogin);

	oCorreo.setUser(oDM.usuariosmtp);  
	oCorreo.setPassword(oDM.passwordsmtp);  
	try {
		oCorreo.setMimeType("text/plain");
		oCorreo.setBody(cuerpo);
	} catch (e) {
		oCorreo.setBody(cuerpo);
	}
	oCorreo.setFrom(oDM.usuariosmtp);
	var to = arrayDest.join(",");
	oCorreo.setTo(to);
	oCorreo.setSubject(asunto);
	
	if (arrayAttach && arrayAttach.length > 0) {
		for (var a = 0; a < arrayAttach.length; a++) {
			oCorreo.addAttachment(arrayAttach[a]);
		}
	}
//debug("Correo " + oDM.usuariosmtp + " - " +  to + " " +  asunto + " " + oDM.passwordsmtp + " " + oDM.hostsmtp + " " + oDM.puertosmtp + " " + oDM.tipocxsmtp + " " + oDM.tipoautsmtp);
	oCorreo.startSend();
}

function envioMail_dameMailTo(cuerpo, asunto, arrayDest, arrayAttach)
{
	var url = "mailto:";
  var dest = "";
  if (arrayDest) {
    for (var i = 0; i < arrayDest.length; i++) {
      dest += dest != "" ? ";" : "";
      dest += arrayDest[i]["direccion"];
    }
  }
  url += dest;
  url += "?subject=" + asunto;
  url += "&body=" + cuerpo;
  if (arrayAttach) {
    for (var i = 0; i < arrayAttach.length; i++) {
      url += "&attachment=" + arrayAttach[i];
		}
  }
  return url;
}

function envioMail_smtpClient_statusChanged(msg, code)
{
	var _i = this.iface;
	switch(code) {
		case AQS.SmtpSendOk: {
		debug("SmtpSendOk");
			sys.infoMsgBox(sys.translate("Email enviado correctamente"));
			break;
		}
		case AQS.SmtpError: {
		debug("SmtpError");
			sys.infoMsgBox(sys.translate("Error en el envío del email"));
			break;
		}
		case AQS.SmtpMxDnsError: {
		debug("SmtpMxDnsError");
			sys.infoMsgBox(sys.translate("Error MX DNS  en el envío del email"));
			break;
		}
		case AQS.SmtpSocketError: {
		debug("SmtpSocketError");
			sys.infoMsgBox(sys.translate("Error de socket en el envío del email"));
			break;
		}
		case AQS.SmtpAttachError: {
		debug("SmtpAttachError");
			sys.infoMsgBox(sys.translate("Error al adjuntar archivos en el envío del email"));
			break;
		}
		case AQS.SmtpServerError: {
		debug("SmtpServerError");
			sys.infoMsgBox(sys.translate("Error de servidor en el envío del email"));
			break;
		}
		case AQS.SmtpClientError: {
				debug("SmtpClientError");
			sys.infoMsgBox(sys.translate("Error de cliente en el envío del email"));
			break;
			//sys.errorMsgBox(sys.translate("Error al enviar el email al proveedor %1 %2").arg(code).arg(msg));
			break;
		}
	}
  debug("STATUS CHANGED " + msg + " :  " + code);
// sys.warnMsgBox("STATUS CHANGED " + msg + " :  " + code);
}


function envioMail_componerCorreo(cuerpo:String, asunto:String, arrayDest:String, arrayAttach:String)
{
	var util= new FLUtil();
	var clienteCorreo = util.readSettingEntry("scripts/flfactinfo/clientecorreo");
	if (!clienteCorreo || clienteCorreo == "") {
		MessageBox.warning(util.translate("scripts", "No tiene establecido el tipo de cliente de correo.\nDebe establecer este valor en la pestaña Correo del formulario de empresa"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	var nombreCorreo = util.readSettingEntry("scripts/flfactinfo/nombrecorreo");
	if (!nombreCorreo || nombreCorreo == "") {
		MessageBox.warning(util.translate("scripts", "No tiene establecido el nombre del ejecutable del programa de correo.\nDebe establecer este valor en la pestaña Correo del formulario de empresa"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	var destinatarios= "";
	for (var i= 0; i < arrayDest.length; i++) {
		if (i > 0) {
			destinatarios += " ";
		}
		if(destinatarios == "") {
			destinatarios = arrayDest[i]["direccion"];
		}
		else {
			destinatarios += arrayDest[i]["direccion"];
		}
	}
	var documentos= "";
	if (arrayAttach) {
		documentos = arrayAttach.join(" ");
	}
	
 	var comando:Array;
	switch (clienteCorreo) {
		case "Thunderbird": {
			if (arrayAttach) {
				documentos = arrayAttach.join(",");
			}
			if (documentos != "") {
				comando = [nombreCorreo, "-compose", "to=\'" + destinatarios + "\',subject=\'" + asunto + "\',body=\'" + cuerpo + "\',attachment=\'file://" + documentos + "\'"];
			} else {
				comando = [nombreCorreo, "-compose", "to=\'" + destinatarios + "\',subject=\'" + asunto + "\',body=\'" + cuerpo + "\'"];
			}
			break;
		}
		case "Outlook": {
			if (documentos != "") {
 				documentos = Dir.convertSeparators(documentos);
				comando = ["\"" + nombreCorreo + "\" /c", "ipm.note", "/m", destinatarios, "/a", documentos];
			} else {
				comando = ["\"" + nombreCorreo + "\" /c", "ipm.note", "/m" , destinatarios];
			}
			break;
		}
		case "KMail": {
			if (documentos != "") {
				comando = [nombreCorreo , destinatarios, "-s", asunto, "--body", cuerpo, documentos];
			} else {
				comando = [nombreCorreo , destinatarios, "-s", asunto, "--body", cuerpo];
			}
			break;
		}
		default: {
			
		}
	}
	return comando;
}

function envioMail_existeEnvioMail()
{
	return true;
}

function envioMail_extension(nE)
{
	var _i = this.iface;
	
	switch(nE) {
		case "envio_mail": {
			return true;
		}
		default: return _i.__extension(nE);
	}
}
//// ENVIO MAIL /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
