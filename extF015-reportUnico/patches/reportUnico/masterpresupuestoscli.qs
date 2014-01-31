
/** @class_declaration reportUnico */
/////////////////////////////////////////////////////////////////
//// REPORT UNICO ///////////////////////////////////////////////
class reportUnico extends oficial {
	function reportUnico( context ) { oficial( context ); }
	function imprimir(codPresupuesto:String) {
		return this.ctx.reportUnico_imprimir(codPresupuesto);
	}
}
//// REPORT UNICO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition reportUnico */
/////////////////////////////////////////////////////////////////
//// REPORT UNICO ///////////////////////////////////////////////
function reportUnico_imprimir(codPresupuesto:String)
{
	if (sys.isLoadedModule("flfactinfo")) {

		var codigo:String;
		if (codPresupuesto) {
			codigo = codPresupuesto;
		} else {
			if (!this.cursor().isValid())
				return;
			codigo = this.cursor().valueBuffer("codigo");
		}
		var curImprimir:FLSqlCursor = new FLSqlCursor("i_presupuestoscli");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_presupuestoscli_codigo", codigo);
		curImprimir.setValueBuffer("h_presupuestoscli_codigo", codigo);
		var whereFijo:String = "PARAM_titulo\nPresupuesto\nPARAM_tabla\npresupuestoscli\nPARAM_subtabla\npresupuesto\nPARAM_orderdef\npresupuestoscli.codigo\nPARAM_tablareldoc\npresupuestoscli\nPARAM_reldoc\npresupuesto\n";
		flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_presupuestoscli", "", "", false, false, whereFijo, "i_presupuestoscli");
		return;
	}

	var tipoDoc:String = "presupuestoscli";
	var f:Object = new FLFormSearchDB("facturas_imp");
	var cursor:FLSqlCursor = f.cursor();

	cursor.setActivatedCheckIntegrity(false);
	cursor.select();
	if (!cursor.first())
		cursor.setModeAccess(cursor.Insert);
	else
		cursor.setModeAccess(cursor.Edit);

	f.setMainWidget();
	cursor.refreshBuffer();
	var acpt:String = f.exec("desde");
	if (acpt) {
		cursor.commitBuffer();
		var q:FLSqlQuery = new FLSqlQuery(tipoDoc);
		q.setValueParam("from", cursor.valueBuffer("desde"));
		q.setValueParam("to", cursor.valueBuffer("hasta"));
		var rptViewer = new FLReportViewer();
		rptViewer.setReportTemplate(tipoDoc);
		rptViewer.setReportData(q);
		rptViewer.renderReport();
		rptViewer.exec();
		f.close();
	}
}
//// REPORT UNICO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

