
/** @class_declaration reportUnico */
/////////////////////////////////////////////////////////////////
//// REPORT UNICO ///////////////////////////////////////////////
class reportUnico extends oficial {
    function reportUnico( context ) { oficial ( context ); }
    function whereFijoExtendido(nombreInforme:String):String {
        return this.ctx.reportUnico_whereFijoExtendido(nombreInforme);
    }
}
//// REPORT UNICO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition reportUnico */
/////////////////////////////////////////////////////////////////
//// REPORT UNICO ///////////////////////////////////////////////
/** Agrega parametros directamente al whereFijo
\end */
function reportUnico_whereFijoExtendido(nombreInforme:String)
{
    var params:String;
    switch (nombreInforme) {
        case "i_presupuestoscli": {
            params = "PARAM_tabla\npresupuestoscli\nPARAM_subtabla\npresupuesto\nPARAM_orderdef\npresupuestoscli.codigo\nPARAM_tablareldoc\npresupuestoscli\nPARAM_reldoc\npresupuesto\n";
            break;
        }
        case "i_pedidoscli": {
            params = "PARAM_tabla\npedidoscli\nPARAM_subtabla\npedido\nPARAM_orderdef\npedidoscli.codigo\nPARAM_tablareldoc\npresupuestoscli\nPARAM_reldoc\npresupuesto\n";
            break;
        }
        case "i_albaranescli": {
            params = "PARAM_tabla\nalbaranescli\nPARAM_subtabla\nalbaran\nPARAM_orderdef\nalbaranescli.codigo\nPARAM_tablareldoc\npedidoscli\nPARAM_reldoc\npedido\n";
            break;
        }
        case "i_facturascli": {
            params = "PARAM_tabla\nfacturascli\nPARAM_subtabla\nfactura\nPARAM_orderdef\nfacturascli.codigo\nPARAM_tablareldoc\nalbaranescli\nPARAM_reldoc\nalbaran\n"
            break;
        }
        case "i_pedidosprov": {
            params = "PARAM_tabla\npedidosprov\nPARAM_subtabla\npedido\nPARAM_orderdef\npedidosprov.codigo\nPARAM_tablareldoc\npresupuestosprov\nPARAM_reldoc\npresupuesto\n";
            break;
        }
        case "i_albaranesprov": {
            params = "PARAM_tabla\nalbaranesprov\nPARAM_subtabla\nalbaran\nPARAM_orderdef\nalbaranesprov.codigo\nPARAM_tablareldoc\npedidosprov\nPARAM_reldoc\npedido\n";
            break;
        }
        case "i_facturasprov": {
            params = "PARAM_tabla\nfacturasprov\nPARAM_subtabla\nfactura\nPARAM_orderdef\nfacturasprov.codigo\nPARAM_tablareldoc\nalbaranesprov\nPARAM_reldoc\nalbaran\n";
            break;
        }
    }

    if (!this.iface.whereFijoExt || this.iface.whereFijoExt == "") {
        this.iface.whereFijoExt = params;
    } else {
        this.iface.whereFijoExt = this.iface.whereFijoExt + params;
    }

    this.iface.__whereFijoExtendido(nombreInforme);
    return;
}

//// REPORT UNICO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

