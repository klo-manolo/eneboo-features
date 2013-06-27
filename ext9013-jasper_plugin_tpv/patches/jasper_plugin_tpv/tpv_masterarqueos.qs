
/** @class_declaration jasperPluginTpv */
/////////////////////////////////////////////////////////////////
//// JASPERPLUGIN_TPV ///////////////////////////////////////////
class jasperPluginTpv extends oficial /** %from: oficial */ {
    function jasperPluginTpv( context ) { oficial ( context ); }
	function imprimirQuick( codArqueo:String, impresora:String ) {
                return this.ctx.jasperPluginTpv_imprimirQuick( codArqueo, impresora );
        }
}
//// JASPERPLUGIN_TPV ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition jasperPluginTpv */
/////////////////////////////////////////////////////////////////
//// JASPERPLUGIN_TPV ///////////////////////////////////////////

function jasperPluginTpv_imprimirQuick( codArqueo:String, impresora:String )
{
	var util:FLUtil = new FLUtil();
	var q:FLSqlQuery = new FLSqlQuery( "tpv_i_arqueos" );
	var codPuntoVenta:String = util.readSettingEntry("scripts/fltpv_ppal/codTerminal");

	q.setWhere( "tpv_arqueos.idtpv_arqueo = '" + codArqueo + "'" );
	if (q.exec() == false) {
		MessageBox.critical(util.translate("scripts", "Falló la consulta"), MessageBox.Ok, MessageBox.NoButton);
		return;
	} else {
		if (q.first() == false) {
			MessageBox.warning(util.translate("scripts", "No hay registros que cumplan los criterios de búsqueda establecidos"), MessageBox.Ok, MessageBox.NoButton);
			return;
		}
	}

	var tipoImpresora:String = util.sqlSelect("tpv_puntosventa", "tipoimpresora", "codtpv_puntoventa = '" + codPuntoVenta + "'");
	if (tipoImpresora == "ESC-POS") {
		this.iface.imprimirArqueoPOS(codArqueo, impresora, q);
	} else {

		if (sys.isLoadedModule("flfactinfo")) {
		if (!this.cursor().isValid())
			return;
		var curImprimir:FLSqlCursor = new FLSqlCursor("tpv_i_arqueos");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_tpv__arqueos_idtpv__arqueo", codArqueo);
		curImprimir.setValueBuffer("h_tpv__arqueos_idtpv__arqueo", codArqueo);
		flfactinfo.iface.pub_lanzarInforme(curImprimir, "tpv_i_arqueos", "", "", false, true, "", "", 0, impresora);
	} else
		flfactppal.iface.pub_msgNoDisponible("Informes");

	}
}
//// JASPERPLUGIN_TPV ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

