
/** @class_declaration reportUnico */
/////////////////////////////////////////////////////////////////
//// REPORT UNICO ///////////////////////////////////////////////
class reportUnico extends oficial {
	function reportUnico( context ) { oficial( context ); }
	function imprimir(codFactura:String) {
		return this.ctx.reportUnico_imprimir(codFactura);
	}
}
//// REPORT UNICO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition reportUnico */
/////////////////////////////////////////////////////////////////
//// REPORT UNICO ///////////////////////////////////////////////
function reportUnico_imprimir(codFactura:String)
{
	if (sys.isLoadedModule("flfactinfo")) {

		var util:FLUtil = new FLUtil;
		var codigo:String;
		if (codFactura) {
			codigo = codFactura;
		} else {
			if (!this.cursor().isValid())
				return;
			codigo = this.cursor().valueBuffer("codigo");
		}

		var numCopias:Number = util.sqlSelect("facturascli f INNER JOIN clientes c ON c.codcliente = f.codcliente", "c.copiasfactura", "f.codigo = '" + codigo + "'", "facturascli,clientes");
		if (!numCopias)
			numCopias = 1;

		var curImprimir:FLSqlCursor = new FLSqlCursor("i_facturascli");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_facturascli_codigo", codigo);
		curImprimir.setValueBuffer("h_facturascli_codigo", codigo);
		var whereFijo:String = "PARAM_titulo\nFactura\nPARAM_tabla\nfacturascli\nPARAM_subtabla\nfactura\nPARAM_orderdef\nfacturascli.codigo\nPARAM_tablareldoc\nalbaranescli\nPARAM_reldoc\nalbaran\n";
		flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_facturascli", "", "", false, false, whereFijo, "i_facturascli", numCopias);
	} else
		flfactppal.iface.pub_msgNoDisponible("Informes");
}
//// REPORT UNICO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

