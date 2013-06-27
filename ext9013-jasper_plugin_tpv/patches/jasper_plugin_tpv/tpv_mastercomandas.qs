
/** @class_declaration jasperPluginTpv */
/////////////////////////////////////////////////////////////////
//// JASPERPLUGIN_TPV ///////////////////////////////////////////
class jasperPluginTpv extends oficial /** %from: oficial */ {
    function jasperPluginTpv( context ) { oficial ( context ); }
	function imprimirQuick( codComanda:String, impresora:String ) {
                return this.ctx.jasperPluginTpv_imprimirQuick( codComanda, impresora );
        }
}
//// JASPERPLUGIN_TPV ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition jasperPluginTpv */
/////////////////////////////////////////////////////////////////
//// JASPERPLUGIN_TPV ///////////////////////////////////////////

function jasperPluginTpv_imprimirQuick( codComanda:String, impresora:String )
{
        var util:FLUtil = new FLUtil();
        var q:FLSqlQuery = new FLSqlQuery( "tpv_i_comandas" );
        var codPuntoVenta:String = util.readSettingEntry("scripts/fltpv_ppal/codTerminal");

        q.setWhere( "codigo = '" + codComanda + "'" );
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
                this.iface.imprimirTiquePOS(codComanda, impresora, q);
        } else {
               if (sys.isLoadedModule("flfactinfo")) {
                if (!this.cursor().isValid())
                        return;
                var curImprimir:FLSqlCursor = new FLSqlCursor("tpv_i_comandas");
                curImprimir.setModeAccess(curImprimir.Insert);
                curImprimir.refreshBuffer();
                curImprimir.setValueBuffer("descripcion", "temp");
                curImprimir.setValueBuffer("d_tpv__comandas_codigo", codComanda);
                curImprimir.setValueBuffer("h_tpv__comandas_codigo", codComanda);
                flfactinfo.iface.pub_lanzarInforme(curImprimir, "tpv_i_comandas", "", "", false, true, "", "", 0, impresora);
        } else
                flfactppal.iface.pub_msgNoDisponible("Informes");
        }
}

//// JASPERPLUGIN_TPV ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

