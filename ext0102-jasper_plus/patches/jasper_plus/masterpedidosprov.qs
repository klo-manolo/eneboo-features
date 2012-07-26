
/** @class_declaration jasperPlus */
/////////////////////////////////////////////////////////////////
/////// JASPERPLUS /////////////////////////////////////////////////
class jasperPlus extends envioMail {
	function jasperPlus( context ) { envioMail( context ); }

	function enviarDocumento(codPedido:String, codCliente:String) {
		return this.ctx.jasperPlus_enviarDocumento(codPedido, codCliente);
	}
}
//// JASPERPLUS /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition jasperPlus */
/////////////////////////////////////////////////////////////////
//// JASPERPLUS /////////////////////////////////////////////////
function jasperPlus_enviarDocumento(codPedido:String, codProveedor:String)
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();

	if (!codPedido) {
		codPedido = cursor.valueBuffer("codigo");
	}

	if (!codProveedor) {
		codProveedor = cursor.valueBuffer("codproveedor");
	}

	var tabla:String = "proveedores";
	var emailProveedor:String = flfactppal.iface.pub_componerListaDestinatarios(codProveedor, tabla);
	if (!emailProveedor) {	
		return;
	}

	var rutaIntermedia:String = util.readSettingEntry("scripts/flfactinfo/dirCorreo");
	if (!rutaIntermedia.endsWith("/")) {
		rutaIntermedia += "/";
	}

	var cuerpo:String = "";
	var asunto:String = util.translate("scripts", "Pedido %1").arg(codPedido);
	var rutaDocumento:String = rutaIntermedia + "P_" + codPedido + ".pdf";

	var codigo:String;
	if (codPedido) {
		codigo = codPedido;
	} else {
		if (!cursor.isValid()) {
			return;
		}
		codigo = cursor.valueBuffer("codigo");
	}
	
	var curImprimir:FLSqlCursor = new FLSqlCursor("i_pedidosprov");
	curImprimir.setModeAccess(curImprimir.Insert);
	curImprimir.refreshBuffer();
	curImprimir.setValueBuffer("descripcion", "temp");
	curImprimir.setValueBuffer("d_pedidosprov_codigo", codigo);
	curImprimir.setValueBuffer("h_pedidosprov_codigo", codigo);

	var arrayDest:Array = [];
	arrayDest[0] = [];
	arrayDest[0]["tipo"] = "to";
	arrayDest[0]["direccion"] = emailProveedor;

	flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_pedidosprov", "", "", false, false, "", "i_pedidosprov", 1, rutaDocumento, true, arrayDest);
}
//// JASPERPLUS /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
