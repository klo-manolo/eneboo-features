
/** @class_declaration envioMail */
/////////////////////////////////////////////////////////////////
//// ENVIO_MAIL ////////////////////////////////////////////////
class envioMail extends oficial {
	var correo_;
  	function envioMail( context ) { oficial ( context ); }
	function enviarMail(datosMail) {
		return this.ctx.envioMail_enviarMail(datosMail);
	}
	function statusChanged(msg, code) {
	     return this.ctx.envioMail_statusChanged(msg, code);
	}
}

//// ENVIO_MAIL ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubEnvioMail */
/////////////////////////////////////////////////////////////////
//// PUB ENVIO_MAIL ////////////////////////////////////////////////
class pubEnvioMail extends ifaceCtx
{
  function pubEnvioMail(context)
  {
    ifaceCtx(context);
  }
  function pub_enviarMail(datosMail) {
		return this.enviarMail(datosMail);
	}
}

//// PUB ENVIO_MAIL ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition envioMail */
/////////////////////////////////////////////////////////////////
//// ENVIO_MAIL /////////////////////////////////////////////////
function envioMail_enviarMail(datosMail)
{
	var _i = this.iface;
	
	if(!datosMail) {
		return false;
	}
	if(!datosMail.to || datosMail.to == "") {
		return;
	}
	var arrayTo = datosMail.to.split(",");
	var usuario = sys.nameUser();	
	var curSmtp = new FLSqlCursor("usuarios");
	curSmtp.select("idusuario = '" + usuario + "'");
	if (!curSmtp.first()) {
		return false;
	}
	var vB = curSmtp.valueBuffer;
	
	var dialog = new Dialog;
	dialog.caption = "Introduzca los datos para el email";
	dialog.okButtonText = "Aceptar";
	dialog.cancelButtonText = "Cancelar";	
	
	var gbEmail = new GroupBox; 
	gbEmail.title = "Introduzca los datos para el email";

	var gbDireccion = new GroupBox;	
	gbDireccion.title = "Dirección/es (separadas por comas)";	
	var direccion = new LineEdit;
	direccion.label ="";
	direccion.text = datosMail.to;
	gbDireccion.add(direccion);

	var gbAsunto = new GroupBox;	
	gbAsunto.title = "Asunto";	
	var asunto = new LineEdit;
	asunto.label ="";
	asunto.text = datosMail.subject;
	gbAsunto.add(asunto);

	
	var cuerpo = new TextEdit;	
	var gbCuerpo = new GroupBox;
	gbCuerpo.title = "Cuerpo";
	gbCuerpo.add(cuerpo);
	gbEmail.add(gbDireccion);
	gbEmail.add(gbAsunto);
	gbEmail.add(gbCuerpo);
	dialog.add(gbEmail);
    
	if(!dialog.exec() ) {
		sys.warnMsgBox(sys.translate("Envío de email cancelado por el usuario."));
		return false;
	}
	
	if (_i.correo_) {
		_i.correo_ = undefined;
	}	
	_i.correo_ = new AQSmtpClient;		
	connect(_i.correo_, "statusChanged(QString, int)", _i, "statusChanged()");		
	_i.correo_.setMailServer(vB("hostcorreosaliente"));		
	_i.correo_.setPort(vB("puertosmtp"));
	switch (vB("tipocxsmtp")) {
		case "SSL": {
			_i.correo_.setConnectionType(AQS.SmtpSslConnection);  
		 	break;
		}
		case "TLS": {
		 	_i.correo_.setConnectionType(AQS.SmtpTlsConnection);
		 	break;
	  	}
		default: {
		     
		}
	}
			
	switch (vB("tipoautsmtp")) {
		case "Plain": {
			_i.correo_.setAuthMethod(AQS.SmtpAuthPlain);
			break;
		}
		case "Login": {
			_i.correo_.setAuthMethod(AQS.SmtpAuthLogin);
			break;
		}
		default: {
			return false;
		}
	}
	//** Tambien se puede usar el método Login
	//** Algunos servidores sólo soportan Login
	//** GMail soporta los dos Plain y Login
	//** _i.correo_.setAuthMethod(AQS.SmtpAuthLogin);

	_i.correo_.setUser(vB("usuariosmtp"));  
	_i.correo_.setPassword(vB("passwordsmtp")); 		
		
	try {
		_i.correo_.setMimeType("text/plain");		
		_i.correo_.setBody(cuerpo.text);

	} catch (e) {
		_i.correo_.setBody(cuerpo.text);
	}
	_i.correo_.setFrom(datosMail.from);	
	_i.correo_.setTo(direccion.text);
	_i.correo_.setSubject(asunto.text);
	if ("attach" in datosMail) {
			
		for (var a = 0; a < datosMail.attach.length; a++) {
			_i.correo_.addAttachment(datosMail.attach[a]);
		}
	}
	_i.correo_.startSend();
	
	return true;
}
function envioMail_statusChanged(msg, code)
{
	var _i = this.iface;
	switch(code) {
		case AQS.SmtpSendOk: {
			sys.infoMsgBox("El email se ha enviado correctamente");
			break;
		}
		case AQS.SmtpError:
		case AQS.SmtpMxDnsError:
		case AQS.SmtpSocketError:
		case AQS.SmtpAttachError:
		case AQS.SmtpServerError:
		case AQS.SmtpClientError: {
			sys.errorMsgBox(sys.translate("Error al enviar el email"));
			break;
		}
	}
  debug("STATUS CHANGED " + msg + " :  " + code);
}
//// ENVIO_MAIL /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
