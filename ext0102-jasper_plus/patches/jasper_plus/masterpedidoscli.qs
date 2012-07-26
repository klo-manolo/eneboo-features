
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
function jasperPlus_enviarDocumento(codPedido:String, codCliente:String)
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();

	if (!codPedido) {
		codPedido = cursor.valueBuffer("codigo");
	}

	if (!codCliente) {
		codCliente = cursor.valueBuffer("codcliente");
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

	var codigo:String;
	if (codPedido) {
		codigo = codPedido;
	} else {
		if (!cursor.isValid()) {
			return;
		}
		codigo = cursor.valueBuffer("codigo");
	}
	
	var numCopias:Number = util.sqlSelect("pedidoscli p INNER JOIN clientes c ON c.codcliente = p.codcliente", "c.copiasfactura", "p.codigo = '" + codigo + "'", "pedidoscli,clientes");
	if (!numCopias) {
		numCopias = 1;
	}
		
	var curImprimir:FLSqlCursor = new FLSqlCursor("i_pedidoscli");
	curImprimir.setModeAccess(curImprimir.Insert);
	curImprimir.refreshBuffer();
	curImprimir.setValueBuffer("descripcion", "temp");
	curImprimir.setValueBuffer("d_pedidoscli_codigo", codigo);
	curImprimir.setValueBuffer("h_pedidoscli_codigo", codigo);

	var arrayDest:Array = [];
	arrayDest[0] = [];
	arrayDest[0]["tipo"] = "to";
	arrayDest[0]["direccion"] = emailCliente;

	flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_pedidoscli", "", "", false, false, "", "i_pedidoscli", numCopias, rutaDocumento, true, arrayDest);
}
//// JASPERPLUS /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
