
/** @class_declaration envioMail */
/////////////////////////////////////////////////////////////////
//// ENVIO_MAIL ////////////////////////////////////////////////
class envioMail extends oficial {
    function envioMail( context ) { oficial ( context ); }
	function init() { 
		return this.ctx.envioMail_init(); 
	}
	function enviarDocumento(codFactura, codProveedor) {
		return this.ctx.envioMail_enviarDocumento(codFactura, codProveedor);
	}
	function imprimir(codFactura) {
		return this.ctx.envioMail_imprimir(codFactura);
	}
	function dameParamInformeMail(idFactura) {
		return this.ctx.envioMail_dameParamInformeMail(idFactura);
	}
}
//// ENVIO_MAIL ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition envioMail */
/////////////////////////////////////////////////////////////////
//// ENVIO_MAIL /////////////////////////////////////////////////
function envioMail_init()
{
	var _i = this.iface;
	_i.__init();	
	connect(this.child("tbnEnviarMail"), "clicked()", _i, "enviarDocumento()");
}

function envioMail_enviarDocumento(codFactura, codProveedor)
{
	var _i = this.iface;
	var cursor = this.cursor();	
	var usuario = sys.nameUser();
	var usarSMTP;
	
	var clienteCorreo = AQUtil.readSettingEntry("scripts/flfactinfo/clientecorreo");
	if (clienteCorreo == "Eneboo") {
		usarSMTP = true;
	}
	else{
		usarSMTP = AQUtil.sqlSelect("usuarios", "utilizarsmtp", "idusuario='" + usuario + "'");
	}
	
	if (!codFactura) {
		codFactura = cursor.valueBuffer("codigo");
	}

	if (!codProveedor) {
		codProveedor = cursor.valueBuffer("codproveedor");
	}

	var tabla = "proveedores";
	var emailProveedor = flfactppal.iface.pub_componerListaDestinatarios(codProveedor, tabla);
	if (!emailProveedor) {	
		return;
	}	                               
	var rutaIntermedia = AQUtil.readSettingEntry("scripts/flfactinfo/dirCorreo");
	if (!rutaIntermedia.endsWith("/")) {
		rutaIntermedia += "/";
	}

	var cuerpo = "";
	var asunto = sys.translate("Factura %1").arg(codFactura);
	var rutaDocumento = rutaIntermedia + "F_" + codFactura + ".pdf";

	var codigo, idFactura;
	if (codFactura) {
		codigo = codFactura;
		idAlbaran = AQUtil.sqlSelect("facturasprov", "idfactura", "codigo = '" + codigo + "'");
	} else {
		if (!cursor.isValid()) {
			return;
		}
		codigo = cursor.valueBuffer("codigo");
		idFactura = cursor.valueBuffer("idfactura");
	}
	
	var curImprimir = new FLSqlCursor("i_facturasprov");
	curImprimir.setModeAccess(curImprimir.Insert);
	curImprimir.refreshBuffer();
	curImprimir.setValueBuffer("descripcion", "temp");
	curImprimir.setValueBuffer("d_facturasprov_codigo", codigo);
	curImprimir.setValueBuffer("h_facturasprov_codigo", codigo);
	var oParam = _i.dameParamInformeMail(idFactura);
	
	if(!oParam){
		return;
	}
	
	var oDatosPdf = new Object();
	oDatosPdf["pdf"] = true;
	oDatosPdf["ruta"] = rutaDocumento;
	oParam.datosPdf = oDatosPdf;
	flfactinfo.iface.pub_lanzaInforme(curImprimir, oParam);
	     
	if(!usarSMTP) {
	     var arrayDest = [];
	     arrayDest[0] = [];
	     arrayDest[0]["tipo"] = "to";
	     arrayDest[0]["direccion"] = emailProveedor;

	     var arrayAttach = [];
	     arrayAttach[0] = rutaDocumento;

	     flfactppal.iface.pub_enviarCorreo(cuerpo, asunto, arrayDest, arrayAttach);
	} else {
	     var datosMail = [];
	     datosMail["subject"] = asunto;
	     datosMail["body"] = cuerpo;
	     datosMail["from"] = AQUtil.sqlSelect("usuarios", "usuariosmtp", "idusuario='" + usuario + "'");
	     datosMail["to"] = emailProveedor;   	
	     var arrayAttach = [];
	     arrayAttach[0] = rutaDocumento;
	     datosMail["attach"] = arrayAttach;
	     flfacturac.iface.pub_enviarMail(datosMail);  
	     
	}
}

function envioMail_dameParamInformeMail(idFactura)
{
	var _i = this.iface;
	var oParam = _i.dameParamInforme(idFactura);
	return oParam;
}

function envioMail_imprimir(codFactura)
{	
	var _i = this.iface;
	
	var datosEMail = [];
	datosEMail["tipoInforme"] = "facturasprov";
	
	if (codFactura && codFactura != "") {
		datosEMail["codDestino"] = AQUtil.sqlSelect("facturasprov", "codproveedor", "codigo = '" + codFactura + "'");
		datosEMail["codDocumento"] = codFactura;
	} else {
		var cursor = this.cursor();
		datosEMail["codDestino"] = cursor.valueBuffer("codproveedor");
		datosEMail["codDocumento"] = cursor.valueBuffer("codigo");
	}
	flfactinfo.iface.datosEMail = datosEMail;
	_i.__imprimir(codFactura);
}

//// ENVIO_MAIL /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////