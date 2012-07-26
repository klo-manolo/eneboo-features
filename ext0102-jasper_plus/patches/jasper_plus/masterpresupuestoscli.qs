
/** @class_declaration jasperPlus */
/////////////////////////////////////////////////////////////////
/////// JASPERPLUS /////////////////////////////////////////////////
class jasperPlus extends envioMail {
	function jasperPlus( context ) { envioMail( context ); }

	function enviarDocumento(codPresupuesto:String, codCliente:String) {
		return this.ctx.jasperPlus_enviarDocumento(codPresupuesto, codCliente);
	}
}
//// JASPERPLUS /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition jasperPlus */
/////////////////////////////////////////////////////////////////
//// JASPERPLUS /////////////////////////////////////////////////
function jasperPlus_enviarDocumento(codPresupuesto:String, codCliente:String)
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();

	if (!codPresupuesto) {
		codPresupuesto = cursor.valueBuffer("codigo");
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
	var asunto:String = util.translate("scripts", "Presupuesto %1").arg(codPresupuesto);

	var rutaDocumento:String = rutaIntermedia + "Pr_" + codPresupuesto + ".pdf";
	var codigo:String;
	if (codPresupuesto) {
		codigo = codPresupuesto;
	} else {
		if (!cursor.isValid()) {
			return;
		}
		codigo = cursor.valueBuffer("codigo");
	}
	var numCopias:Number = util.sqlSelect("presupuestoscli p INNER JOIN clientes c ON c.codcliente = p.codcliente", "c.copiasfactura", "p.codigo = '" + codigo + "'", "presupuestoscli,clientes");
	if (!numCopias) {
		numCopias = 1;
	}
		
	var curImprimir:FLSqlCursor = new FLSqlCursor("i_presupuestoscli");
	curImprimir.setModeAccess(curImprimir.Insert);
	curImprimir.refreshBuffer();
	curImprimir.setValueBuffer("descripcion", "temp");
	curImprimir.setValueBuffer("d_presupuestoscli_codigo", codigo);
	curImprimir.setValueBuffer("h_presupuestoscli_codigo", codigo);

	var arrayDest:Array = [];
	arrayDest[0] = [];
	arrayDest[0]["tipo"] = "to";
	arrayDest[0]["direccion"] = emailCliente;

	flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_presupuestoscli", "", "", false, false, "", "i_presupuestoscli", 1, rutaDocumento, true, arrayDest);
}
//// JASPERPLUS /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////
