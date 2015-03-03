
/** @class_declaration envioMail */
/////////////////////////////////////////////////////////////////
//// ENVIO_MAIL ////////////////////////////////////////////////
class envioMail extends oficial {
    function envioMail( context ) { oficial ( context ); }
	function init() { 
		return this.ctx.envioMail_init(); 
	}
	function enviarDocumento(codAlbaran, codProveedor) {
		return this.ctx.envioMail_enviarDocumento(codAlbaran, codProveedor);
	}
	function imprimir(codAlbaran) {
		return this.ctx.envioMail_imprimir(codAlbaran);
	}
	function dameParamInformeMail(idAlbaran) {
		return this.ctx.envioMail_dameParamInformeMail(idAlbaran);
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

function envioMail_enviarDocumento(codAlbaran, codProveedor)
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
	
	if (!codAlbaran) {
		codAlbaran = cursor.valueBuffer("codigo");
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
	var asunto = sys.translate("Albarán %1").arg(codAlbaran);
	var rutaDocumento = rutaIntermedia + "A_" + codAlbaran + ".pdf";

	var codigo, idAlbaran;
	if (codAlbaran) {
		codigo = codAlbaran;
		idAlbaran = AQUtil.sqlSelect("albaranesprov", "idalbaran", "codigo = '" + codigo + "'");
	} else {
		if (!cursor.isValid()) {
			return;
		}
		codigo = cursor.valueBuffer("codigo");
		idAlbaran = cursor.valueBuffer("idalbaran");
	}
	
	var curImprimir = new FLSqlCursor("i_albaranesprov");
	curImprimir.setModeAccess(curImprimir.Insert);
	curImprimir.refreshBuffer();
	curImprimir.setValueBuffer("descripcion", "temp");
	curImprimir.setValueBuffer("d_albaranesprov_codigo", codigo);
	curImprimir.setValueBuffer("h_albaranesprov_codigo", codigo);
	var oParam = _i.dameParamInformeMail(idAlbaran);
	
	if(!oParam){
		return;
	}
	
	var oDatosPdf = new Object();
	oDatosPdf["pdf"] = true;
	oDatosPdf["ruta"] = rutaDocumento;
	oParam.datosPdf = oDatosPdf;
	flfactinfo.iface.pub_lanzaInforme(curImprimir, oParam);
	
	if(!usarSMTP) {
	     var arrayDest:Array = [];
	     arrayDest[0] = [];
	     arrayDest[0]["tipo"] = "to";
	     arrayDest[0]["direccion"] = emailProveedor;

	     var arrayAttach:Array = [];
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

function envioMail_dameParamInformeMail(idAlbaran)
{
	var _i = this.iface;
	var oParam = _i.dameParamInforme(idAlbaran);
	return oParam;
}

function envioMail_imprimir(codAlbaran)
{	
	var _i = this.iface;
	var datosEMail = [];
	datosEMail["tipoInforme"] = "albaranesprov";
	
	if (codAlbaran && codAlbaran != "") {
		datosEMail["codDestino"] = AQUtil.sqlSelect("albaranesprov", "codproveedor", "codigo = '" + codAlbaran + "'");
		datosEMail["codDocumento"] = codPedido;
	} else {
		var cursor = this.cursor();
		datosEMail["codDestino"] = cursor.valueBuffer("codproveedor");
		datosEMail["codDocumento"] = cursor.valueBuffer("codigo");
	}
	flfactinfo.iface.datosEMail = datosEMail;
	_i.__imprimir(codAlbaran);
}

//// ENVIO_MAIL /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
