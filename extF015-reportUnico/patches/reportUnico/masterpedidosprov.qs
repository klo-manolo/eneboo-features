
/** @class_declaration reportUnico */
/////////////////////////////////////////////////////////////////
//// REPORT UNICO ///////////////////////////////////////////////
class reportUnico extends oficial {
	function reportUnico( context ) { oficial( context ); }
	function imprimir(codPedido:String) {
		return this.ctx.reportUnico_imprimir(codPedido);
	}
}
//// REPORT UNICO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition reportUnico */
/////////////////////////////////////////////////////////////////
//// REPORT UNICO ///////////////////////////////////////////////
function reportUnico_imprimir(codPedido:String)
{
	if (sys.isLoadedModule("flfactinfo")) {
		var codigo:String;
		if (codPedido) {
			codigo = codPedido;
		} else {
			if (!this.cursor().isValid())
				return;
			codigo = this.cursor().valueBuffer("codigo");
		}
		var curImprimir:FLSqlCursor = new FLSqlCursor("i_pedidosprov");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_pedidosprov_codigo", codigo);
		curImprimir.setValueBuffer("h_pedidosprov_codigo", codigo);
		var whereFijo:String = "PARAM_titulo\nPedido\nPARAM_tabla\npedidosprov\nPARAM_subtabla\npedido\nPARAM_orderdef\npedidosprov.codigo\nPARAM_tablareldoc\npresupuestosprov\nPARAM_reldoc\npresupuesto\n";
		flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_pedidosprov", "", "", false, false, whereFijo, "i_pedidosprov");
	} else
			flfactppal.iface.pub_msgNoDisponible("Informes");
}
//// REPORT UNICO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

