
/** @class_declaration jasperPlus */
/////////////////////////////////////////////////////////////////
/////// JASPERPLUS /////////////////////////////////////////////////
class jasperPlus extends envioMail {
	function jasperPlus( context ) { envioMail( context ); }

	function enviarDocumento(codFactura:String, codCliente:String) {
		return this.ctx.jasperPlus_enviarDocumento(codFactura, codCliente);
	}
}
//// JASPERPLUS /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition jasperPlus */
/////////////////////////////////////////////////////////////////
//// JASPERPLUS /////////////////////////////////////////////////
function jasperPlus_enviarDocumento(codFactura:String, codCliente:String)
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();

	if (!codFactura) {
		codFactura = cursor.valueBuffer("codigo");
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
	var asunto:String = util.translate("scripts", "Factura %1").arg(codFactura);
	var rutaDocumento:String = rutaIntermedia + "F_" + codFactura + ".pdf";

	var codigo:String;
	if (codFactura) {
		codigo = codFactura;
	} else {
		if (!cursor.isValid()) {
			return;
		}
		codigo = cursor.valueBuffer("codigo");
	}
	
	var numCopias:Number = util.sqlSelect("facturascli f INNER JOIN clientes c ON c.codcliente = f.codcliente", "c.copiasfactura", "f.codigo = '" + codigo + "'", "facturascli,clientes");
	if (!numCopias) {
		numCopias = 1;
	}
		
	var curImprimir:FLSqlCursor = new FLSqlCursor("i_facturascli");
	curImprimir.setModeAccess(curImprimir.Insert);
	curImprimir.refreshBuffer();
	curImprimir.setValueBuffer("descripcion", "temp");
	curImprimir.setValueBuffer("d_facturascli_codigo", codigo);
	curImprimir.setValueBuffer("h_facturascli_codigo", codigo);

	var arrayDest:Array = [];
	arrayDest[0] = [];
	arrayDest[0]["tipo"] = "to";
	arrayDest[0]["direccion"] = emailCliente;

	flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_facturascli", "", "", false, false, "", "i_facturascli", 1, rutaDocumento, true, arrayDest);
}
//// JASPERPLUS /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
