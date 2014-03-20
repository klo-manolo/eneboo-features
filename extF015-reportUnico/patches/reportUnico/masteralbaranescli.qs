
/** @class_declaration reportUnico */
/////////////////////////////////////////////////////////////////
//// REPORT UNICO ///////////////////////////////////////////////
class reportUnico extends oficial {
	function reportUnico( context ) { oficial( context ); }
	function imprimir(codAlbaran:String) {
		return this.ctx.reportUnico_imprimir(codAlbaran);
	}
}
//// REPORT UNICO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition reportUnico */
/////////////////////////////////////////////////////////////////
//// REPORT UNICO ///////////////////////////////////////////////
function reportUnico_imprimir(codAlbaran:String)
{
	var util:FLUtil;
	if (sys.isLoadedModule("flfactinfo")) {
		var codigo:String;
		if (codAlbaran) {
			codigo = codAlbaran;
		} else {
			if (!this.cursor().isValid())
				return;
			codigo = this.cursor().valueBuffer("codigo");
		}

		var nombreInforme:String = "i_albaranescli";
		var idAlbaran:Number = util.sqlSelect("albaranescli","idalbaran","codigo = '" + codigo + "'");
		if (!idAlbaran) {
			return;
		}

		var curImprimir:FLSqlCursor = new FLSqlCursor("i_albaranescli");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_albaranescli_codigo", codigo);
		curImprimir.setValueBuffer("h_albaranescli_codigo", codigo);
		var whereFijo:String = "PARAM_titulo\nAlbarán\nPARAM_tabla\nalbaranescli\nPARAM_subtabla\nalbaran\nPARAM_orderdef\nalbaranescli.codigo\nPARAM_tablareldoc\npedidoscli\nPARAM_reldoc\npedido\n";
		flfactinfo.iface.pub_lanzarInforme(curImprimir, nombreInforme, "", "", false, false, whereFijo, nombreInforme);
	} else {
		flfactppal.iface.pub_msgNoDisponible("Informes");
	}
}
//// REPORT UNICO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

