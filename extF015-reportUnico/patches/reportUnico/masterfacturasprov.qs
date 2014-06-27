
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
		var codigo:String;
		if (codFactura) {
			codigo = codFactura;
		} else {
			if (!this.cursor().isValid())
				return;
			codigo = this.cursor().valueBuffer("codigo");
		}
		var curImprimir:FLSqlCursor = new FLSqlCursor("i_facturasprov");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_facturasprov_codigo", codigo);
		curImprimir.setValueBuffer("h_facturasprov_codigo", codigo);
		var whereFijo:String = "PARAM_titulo\nFactura\nPARAM_tabla\nfacturasprov\nPARAM_subtabla\nfactura\nPARAM_orderdef\nfacturasprov.codigo\nPARAM_tablareldoc\nalbaranesprov\nPARAM_reldoc\nalbaran\n";
		flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_facturasprov", "", "", false, false, whereFijo, "i_facturasprov", "");
	} else
		flfactppal.iface.pub_msgNoDisponible("Informes");
}
//// REPORT UNICO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

