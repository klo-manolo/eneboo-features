
/** @class_declaration jasperPlus */
/////////////////////////////////////////////////////////////////
/////// JASPERPLUS /////////////////////////////////////////////////
class jasperPlus extends envioMail {
	function jasperPlus( context ) { envioMail( context ); }

	function enviarDocumento(codAlbaran:String, codCliente:String) {
		return this.ctx.jasperPlus_enviarDocumento(codAlbaran, codCliente);
	}
}
//// JASPERPLUS /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition jasperPlus */
/////////////////////////////////////////////////////////////////
//// JASPERPLUS /////////////////////////////////////////////////
function jasperPlus_enviarDocumento(codAlbaran:String, codCliente:String)
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();

	if (!codAlbaran) {
		codAlbaran = cursor.valueBuffer("codigo");
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
	var asunto:String = util.translate("scripts", "Albaran %1").arg(codAlbaran);
	var rutaDocumento:String = rutaIntermedia + "A_" + codAlbaran + ".pdf";

	var util:FLUtil = new FLUtil;
	var codigo:String;
	if (codAlbaran) {
		codigo = codAlbaran;
	} else {
		if (!cursor.isValid()) {
			return;
		}
		codigo = cursor.valueBuffer("codigo");
	}
	
	var numCopias:Number = util.sqlSelect("albaranescli a INNER JOIN clientes c ON c.codcliente = a.codcliente", "c.copiasfactura", "a.codigo = '" + codigo + "'", "albaranescli,clientes");
	if (!numCopias) {
		numCopias = 1;
	}
		
	var curImprimir:FLSqlCursor = new FLSqlCursor("i_albaranescli");
	curImprimir.setModeAccess(curImprimir.Insert);
	curImprimir.refreshBuffer();
	curImprimir.setValueBuffer("descripcion", "temp");
	curImprimir.setValueBuffer("d_albaranescli_codigo", codigo);
	curImprimir.setValueBuffer("h_albaranescli_codigo", codigo);

	var arrayDest:Array = [];
	arrayDest[0] = [];
	arrayDest[0]["tipo"] = "to";
	arrayDest[0]["direccion"] = emailCliente;

	flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_albaranescli", "", "", false, false, "", "i_albaranescli", 1, rutaDocumento, true, arrayDest);
}
//// JASPERPLUS /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
