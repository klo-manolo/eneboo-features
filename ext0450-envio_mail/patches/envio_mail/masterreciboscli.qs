
/** @class_declaration envioMail */
/////////////////////////////////////////////////////////////////
//// ENVIO_MAIL ////////////////////////////////////////////////
class envioMail extends oficial {
    function envioMail( context ) { oficial ( context ); }
	function init() { 
		return this.ctx.envioMail_init(); 
	}
	function enviarDocumento(codRecibo, codCliente) {
		return this.ctx.envioMail_enviarDocumento(codRecibo, codCliente);
	}
	function imprimir(codRecibo) {
		return this.ctx.envioMail_imprimir(codRecibo);
	}
	function dameParamInformeMail(idRecibo) {
		return this.ctx.envioMail_dameParamInformeMail(idRecibo);
	}
}
//// ENVIO_MAIL ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubEnvioMail */
/////////////////////////////////////////////////////////////////
//// PUB_ENVIO_MAIL /////////////////////////////////////////////
class pubEnvioMail extends head {
    function pubEnvioMail( context ) { head( context ); }
	function pub_enviarDocumento(codRecibo:String, codCliente:String) {
		return this.enviarDocumento(codRecibo, codCliente);
	}
}

//// PUB_ENVIO_MAIL /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition envioMail */
/////////////////////////////////////////////////////////////////
//// ENVIO_MAIL /////////////////////////////////////////////////
function envioMail_init()
{
	this.iface.__init();
	connect(this.child("tbnEnviarMail"), "clicked()", this, "iface.enviarDocumento()");
	//this.child("tbnEnviarMail").close();
}

function envioMail_enviarDocumento(codRecibo:String, codCliente:String)
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();
	var usuario = sys.nameUser();
	var usarSMTP;
	
	var clienteCorreo = AQUtil.readSettingEntry("scripts/flfactinfo/clientecorreo");
	if (clienteCorreo == "Eneboo") {
		usarSMTP = true;
	}
	else{
		usarSMTP = AQUtil.sqlSelect("usuarios", "utilizarsmtp", "idusuario='" + usuario + "'");
	}

	if (!codRecibo) {
		codRecibo = cursor.valueBuffer("codigo");
	}

	if (!codCliente) {
		codCliente = cursor.valueBuffer("codcliente");
	}

	var tabla:String = "clientes";
	var emailCliente:String = flfactppal.iface.pub_componerListaDestinatarios(codCliente, tabla);
	var rutaIntermedia:String = util.readSettingEntry("scripts/flfactinfo/dirCorreo");
	if (!rutaIntermedia.endsWith("/")) {
		rutaIntermedia += "/";
	}

	var cuerpo:String = "";
	var asunto:String = util.translate("scripts", "Recibo %1").arg(codRecibo);
	var rutaDocumento:String = rutaIntermedia + "R_" + codRecibo + ".pdf";

	var codigo, idRecibo;
	if (codRecibo) {
		codigo = codRecibo;
		idRecibo = util.sqlSelect("reciboscli", "idrecibo", "codigo = '" + codigo + "'");
	} else {
		if (!cursor.isValid()) {
			return;
		}
		codigo = cursor.valueBuffer("codigo");
		idRecibo = cursor.valueBuffer("idrecibo");
	}
	
	var curImprimir:FLSqlCursor = new FLSqlCursor("i_reciboscli");
	curImprimir.setModeAccess(curImprimir.Insert);
	curImprimir.refreshBuffer();
	curImprimir.setValueBuffer("descripcion", "temp");
	curImprimir.setValueBuffer("d_reciboscli_codigo", codigo);
	curImprimir.setValueBuffer("h_reciboscli_codigo", codigo);
	var oParam = this.iface.dameParamInformeMail(idRecibo);
	var oDatosPdf = new Object();
	oDatosPdf["pdf"] = true;
	oDatosPdf["ruta"] = rutaDocumento;
	oParam.datosPdf = oDatosPdf;
	flfactinfo.iface.pub_lanzaInforme(curImprimir, oParam);

	if(!usarSMTP) {
		var arrayDest:Array = [];
		arrayDest[0] = [];
		arrayDest[0]["tipo"] = "to";
		arrayDest[0]["direccion"] = emailCliente;

		var arrayAttach:Array = [];
		arrayAttach[0] = rutaDocumento;	

		flfactppal.iface.pub_enviarCorreo(cuerpo, asunto, arrayDest, arrayAttach);
	} else {
	     var datosMail = [];
	     datosMail["subject"] = asunto;
	     datosMail["body"] = cuerpo;
	     datosMail["from"] = AQUtil.sqlSelect("usuarios", "usuariosmtp", "idusuario='" + usuario + "'");
	     datosMail["to"] = emailCliente;   	
	     var arrayAttach = [];
	     arrayAttach[0] = rutaDocumento;
	     datosMail["attach"] = arrayAttach;
	     flfacturac.iface.pub_enviarMail(datosMail); 

	}
}

function envioMail_dameParamInformeMail(idRecibo)
{
	var oParam = this.iface.dameParamInforme(idRecibo);
	return oParam;
}

function envioMail_imprimir(codRecibo:String)
{
	var util:FLUtil = new FLUtil;
	
	var datosEMail:Array = [];
	datosEMail["tipoInforme"] = "reciboscli";
	var codCliente:String;
	if (codRecibo && codRecibo != "") {
		datosEMail["codDestino"] = util.sqlSelect("reciboscli", "codcliente", "codigo = '" + codRecibo + "'");
		datosEMail["codDocumento"] = codRecibo;
	} else {
		var cursor:FLSqlCursor = this.cursor();
		datosEMail["codDestino"] = cursor.valueBuffer("codcliente");
		datosEMail["codDocumento"] = cursor.valueBuffer("codigo");
	}
	flfactinfo.iface.datosEMail = datosEMail;
	this.iface.__imprimir(codRecibo);
}

//// ENVIO_MAIL /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
