
/** @class_declaration envioMail */
/////////////////////////////////////////////////////////////////
//// ENVIO_MAIL ////////////////////////////////////////////////
class envioMail extends oficial {
    function envioMail( context ) { oficial ( context ); }
	function init() { 
		return this.ctx.envioMail_init(); 
	}
	function enviarDocumento(codPresupuesto, codCliente) {
		return this.ctx.envioMail_enviarDocumento(codPresupuesto, codCliente);
	}
	function imprimir(codPresupuesto:String) {
		return this.ctx.envioMail_imprimir(codPresupuesto);
	}
	function dameParamInformeMail(idFactura) {
		return this.ctx.envioMail_dameParamInformeMail(idFactura);
	}
}

//// ENVIO_MAIL ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubEnvioMail */
/////////////////////////////////////////////////////////////////
//// PUB_ENVIO_MAIL /////////////////////////////////////////////
class pubEnvioMail extends head {
    function pubEnvioMail( context ) { head( context ); }
	function pub_enviarDocumento(codPresupuesto:String, codCliente:String) {
		return this.enviarDocumento(codPresupuesto, codCliente);
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

function envioMail_enviarDocumento(codPresupuesto, codCliente)
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
	
	if (!codPresupuesto) {
		codPresupuesto = cursor.valueBuffer("codigo");
	}

	if (!codCliente) {
		codCliente = cursor.valueBuffer("codcliente");
	}
	var codigo, idPresupuesto;
	if (codPresupuesto) {
		codigo = codPresupuesto;
		idPresupuesto = util.sqlSelect("presupuestoscli", "idpresupuesto", "codigo = '" + codigo + "'");
	} else {
		if (!cursor.isValid()) {
			return;
		}
		codigo = cursor.valueBuffer("codigo");
		idPresupuesto = cursor.valueBuffer("idpresupuesto");
	}
	
	var curImprimir:FLSqlCursor = new FLSqlCursor("i_presupuestoscli");
	curImprimir.setModeAccess(curImprimir.Insert);
	curImprimir.refreshBuffer();
	curImprimir.setValueBuffer("descripcion", "temp");
	curImprimir.setValueBuffer("d_presupuestoscli_codigo", codigo);
	curImprimir.setValueBuffer("h_presupuestoscli_codigo", codigo);	
	var oParam = this.iface.dameParamInformeMail(idPresupuesto);
	
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
	var asunto:String = util.translate("scripts", "Presupuesto %1").arg(codPresupuesto);
	var rutaDocumento:String = rutaIntermedia + "Pr_" + codPresupuesto + ".pdf";

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

function envioMail_dameParamInformeMail(idFactura)
{
	var oParam = this.iface.dameParamInforme(idFactura);
	return oParam;
}

function envioMail_imprimir(codPresupuesto:String)
{
	var util:FLUtil = new FLUtil;
	
	var datosEMail:Array = [];
	datosEMail["tipoInforme"] = "presupuestoscli";
	var codCliente:String;
	if (codPresupuesto && codPresupuesto != "") {
		datosEMail["codDestino"] = util.sqlSelect("presupuestoscli", "codcliente", "codigo = '" + codPresupuesto + "'");
		datosEMail["codDocumento"] = codPresupuesto;
	} else {
		var cursor:FLSqlCursor = this.cursor();
		datosEMail["codDestino"] = cursor.valueBuffer("codcliente");
		datosEMail["codDocumento"] = cursor.valueBuffer("codigo");
	}
	flfactinfo.iface.datosEMail = datosEMail;
	this.iface.__imprimir(codPresupuesto);
}

//// ENVIO_MAIL /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
