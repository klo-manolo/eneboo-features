
/** @class_declaration reportUnico */
/////////////////////////////////////////////////////////////////
//// REPORT UNICO ///////////////////////////////////////////////
class reportUnico extends oficial {
	function reportUnico( context ) { oficial( context ); }
	function lanzar() {
		return this.ctx.reportUnico_lanzar();
	}
}
//// REPORT UNICO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition reportUnico */
/////////////////////////////////////////////////////////////////
//// REPORT UNICO ///////////////////////////////////////////////
function reportUnico_lanzar()
{
	var cursor:FLSqlCursor = this.cursor();
	var pI = this.iface.obtenerParamInforme();
	if (!pI) {
		return;
	}
	var whereFijo:String = "PARAM_titulo\nPresupuesto\nPARAM_tabla\npresupuestoscli\nPARAM_subtabla\npresupuesto\nPARAM_orderdef\npresupuestoscli.codigo\nPARAM_tablareldoc\npresupuestoscli\nPARAM_reldoc\npresupuesto\n";
	pI.whereFijo = whereFijo + pI.whereFijo;
	flfactinfo.iface.pub_lanzarInforme(cursor, pI.nombreInforme, pI.orderBy, "", false, false, pI.whereFijo);
}
//// REPORT UNICO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

