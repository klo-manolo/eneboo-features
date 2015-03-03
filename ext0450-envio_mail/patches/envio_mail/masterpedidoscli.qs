
/** @class_declaration envioMail */
/////////////////////////////////////////////////////////////////
//// ENVIO_MAIL ////////////////////////////////////////////////
class envioMail extends oficial {
    function envioMail( context ) { oficial ( context ); }
	function init() { 
		return this.ctx.envioMail_init(); 
	}
	function enviarDocumento(codPedido, codCliente) {
		return this.ctx.envioMail_enviarDocumento(codPedido, codCliente);
	}
	function imprimir(codPedido:String) {
		return this.ctx.envioMail_imprimir(codPedido);
	}
	function dameParamInformeMail(idPedido) {
		return this.ctx.envioMail_dameParamInformeMail(idPedido);
	}
}

//// ENVIO_MAIL ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubEnvioMail */
/////////////////////////////////////////////////////////////////
//// PUB_ENVIO_MAIL /////////////////////////////////////////////
class pubEnvioMail extends head {
    function pubEnvioMail( context ) { head( context ); }
	function pub_enviarDocumento(codPedido:String, codCliente:String) {
		return this.enviarDocumento(codPedido, codCliente);
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
	//this.child("tbnEnviarMail").close();
	connect(this.child("tbnEnviarMail"), "clicked()", this, "iface.enviarDocumento()");
}

function envioMail_enviarDocumento(codPedido, codCliente)
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
	
	if (!codPedido) {
		codPedido = cursor.valueBuffer("codigo");
	}

	if (!codCliente) {
		codCliente = cursor.valueBuffer("codcliente");
	}

	var codigo, idPedido;
	if (codPedido) {
		codigo = codPedido;
		idPedido = util.sqlSelect("pedidoscli", "idpedido", "codigo = '" + codigo + "'");
	} else {
		if (!cursor.isValid()) {
			return;
		}
		codigo = cursor.valueBuffer("codigo");
		idPedido = cursor.valueBuffer("idpedido");
	}
	
	var curImprimir:FLSqlCursor = new FLSqlCursor("i_pedidoscli");
	curImprimir.setModeAccess(curImprimir.Insert);
	curImprimir.refreshBuffer();
	curImprimir.setValueBuffer("descripcion", "temp");
	curImprimir.setValueBuffer("d_pedidoscli_codigo", codigo);
	curImprimir.setValueBuffer("h_pedidoscli_codigo", codigo);
	var oParam = this.iface.dameParamInformeMail(idPedido);
	
	if(!oParam){
		return;
	}

	var tabla:String = "clientes";
	var emailCliente:String = flfactppal.iface.pub_componerListaDestinatarios(codCliente, tabla);
	if (!emailCliente) {
		return;
	}

	var rutaIntermedia:String = util.readSettingEntry("scripts/flfactinfo/dirCorreo");
	if (!rutaIntermedia.endsWith("/")) {
		rutaIntermedia += "/";
	}

	var cuerpo:String = "";
	var asunto:String = util.translate("scripts", "Pedido %1").arg(codPedido);
	var rutaDocumento:String = rutaIntermedia + "P_" + codPedido + ".pdf";
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

function envioMail_dameParamInformeMail(idPedido)
{
	var oParam = this.iface.dameParamInforme(idPedido);
	return oParam;
}

function envioMail_imprimir(codPedido:String)
{
	var util:FLUtil = new FLUtil;
	
	var datosEMail:Array = [];
	datosEMail["tipoInforme"] = "pedidoscli";
	var codCliente:String;
	if (codPedido && codPedido != "") {
		datosEMail["codDestino"] = util.sqlSelect("pedidoscli", "codcliente", "codigo = '" + codPedido + "'");
		datosEMail["codDocumento"] = codPedido;
	} else {
		var cursor:FLSqlCursor = this.cursor();
		datosEMail["codDestino"] = cursor.valueBuffer("codcliente");
		datosEMail["codDocumento"] = cursor.valueBuffer("codigo");
	}
	flfactinfo.iface.datosEMail = datosEMail;
	this.iface.__imprimir(codPedido);
}
//// ENVIO_MAIL /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
