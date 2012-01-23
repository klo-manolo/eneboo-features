
/** @class_declaration visorexterno */
/////////////////////////////////////////////////////////////////
//// VISOREXTERNO /////////////////////////////////////////////////
class visorexterno extends oficial {
    function visorexterno( context ) { oficial ( context ); }
	function lanzarInforme(cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String, etiquetas:Boolean, impDirecta:Boolean, whereFijo:String, nombreReport:String, numCopias:Number, impresora:String, pdf:Boolean) {
		return this.ctx.visorexterno_lanzarInforme(cursor, nombreInforme, orderBy, groupBy, etiquetas, impDirecta, whereFijo, nombreReport, numCopias, impresora, pdf);
	}
	function sysexecVisor(comando:String):Array {
		return this.ctx.visorexterno_sysexecVisor(comando);
	}
}
//// VISOREXTERNO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition visorexterno */
/////////////////////////////////////////////////////////////////
//// VISOREXTERNO /////////////////////////////////////////////////
function visorexterno_lanzarInforme(cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String, etiquetas:Boolean, impDirecta:Boolean, whereFijo:String, nombreReport:String, numCopias:Number, impresora:String, pdf:Boolean)
{
	var util:FLUtil = new FLUtil();
	var visorExterno:String = util.readSettingEntry("scripts/flfactinfo/visorexterno", "");
	
	if (impDirecta || pdf || visorExterno == "") {
		return this.iface.__lanzarInforme(cursor, nombreInforme, orderBy, groupBy, etiquetas, impDirecta, whereFijo, nombreReport, numCopias, impresora, pdf);
	}

	var usoVisor:String = util.readSettingEntry("scripts/flfactinfo/usovisor", "");
	
	// Siempre pregunta por el uso del visor externo.
	if (usoVisor == "siempre") {
		var res:Number = MessageBox.information(util.translate("scripts", "¿Usar visor externo?"), MessageBox.Yes, MessageBox.No);
		if (res == MessageBox.No) {
			return this.iface.__lanzarInforme(cursor, nombreInforme, orderBy, groupBy, etiquetas, impDirecta, whereFijo, nombreReport, numCopias, impresora, pdf);
		}
	}
	
	this.iface.ultIdDocPagina = "";

	var q:FLSqlQuery = this.iface.establecerConsulta(cursor, nombreInforme, orderBy, groupBy, whereFijo);
debug("------ CONSULTA -------" + q.sql());
	if (q.exec() == false) {
		MessageBox.critical(util.translate("scripts", "Falló la consulta"), MessageBox.Ok, MessageBox.NoButton);
		return;
	} else {
		if (q.first() == false) {
			MessageBox.warning(util.translate("scripts", "No hay registros que cumplan los criterios de búsqueda establecidos"), MessageBox.Ok, MessageBox.NoButton);
			return;
		}
	}

	if (!nombreReport) 
		nombreReport = nombreInforme;
			
	var rptViewer:FLReportViewer = new FLReportViewer();
	rptViewer.setReportTemplate(nombreReport);
	rptViewer.setReportData(q);
	rptViewer.renderReport(0, 0);
	if (numCopias)
		rptViewer.setNumCopies(numCopias);

	var dirTmpVisor:String = util.readSettingEntry("scripts/flfactinfo/dirtmpvisor", "");
	var dirInforme:String = dirTmpVisor+nombreInforme;
	rptViewer.printReportToPDF(dirInforme);
	
	debug(flfactinfo.iface.sysexecVisor([visorExterno,dirInforme]));
}

function visorexterno_sysexecVisor(comando:String):Array
{
	var res:Array = [];
	Process.execute(comando);
	if (Process.stderr != "") {
		res["ok"] = false;
		res["salida"] = "!" + Process.stderr + "(" + Process.stdout + ")";
	} else {
		res["ok"] = true;
		res["salida"] = Process.stdout;
	}
	return res["salida"];
}
//// VISOREXTERNO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
