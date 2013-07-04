
/** @class_declaration scab */
/////////////////////////////////////////////////////////////////
//// CONTROL STOCK CABECERA /////////////////////////////////////
class scab extends oficial {
    function scab( context ) { oficial ( context ); }
    function afterCommit_lineaspedidoscli(curLA:FLSqlCursor):Boolean {
        return this.ctx.scab_afterCommit_lineaspedidoscli(curLA);
    }
    function afterCommit_lineasalbaranescli(curLA:FLSqlCursor):Boolean {
        return this.ctx.scab_afterCommit_lineasalbaranescli(curLA);
    }
    function afterCommit_lineasfacturascli(curLF:FLSqlCursor):Boolean {
        return this.ctx.scab_afterCommit_lineasfacturascli(curLF);
    }
    function afterCommit_lineaspedidosprov(curLA:FLSqlCursor):Boolean {
        return this.ctx.scab_afterCommit_lineaspedidosprov(curLA);
    }
    function afterCommit_lineasalbaranesprov(curLA:FLSqlCursor):Boolean {
        return this.ctx.scab_afterCommit_lineasalbaranesprov(curLA);
    }
    function afterCommit_lineasfacturasprov(curLF:FLSqlCursor):Boolean {
        return this.ctx.scab_afterCommit_lineasfacturasprov(curLF);
    }
}
//// CONTROL STOCK CABECERA /////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition scab */
/////////////////////////////////////////////////////////////////
//// CONTROL STOCK CABECERA /////////////////////////////////////
function scab_afterCommit_lineaspedidoscli(curLP:FLSqlCursor):Boolean
{
    debug("KLO==================> Nivel de transaccion pedidosCli (2 no ejecuta afterCommit): "+sys.transactionLevel());
    if (sys.transactionLevel() == 2) 
        return true;

    this.iface.__afterCommit_lineaspedidoscli(curLP);

    return true;
}

function scab_afterCommit_lineasalbaranescli(curLA:FLSqlCursor):Boolean
{
    debug("KLO==================> Nivel de transaccion albaranesCli (2 no ejecuta afterCommit pero si actualiza servido en pedido): "+sys.transactionLevel());
    if (sys.transactionLevel() == 2) { 
        if (!this.iface.actualizarPedidosLineaAlbaranCli(curLA)) {
            return false;
        }
        return true;
    }

    this.iface.__afterCommit_lineasalbaranescli(curLA);

    return true;
}

function scab_afterCommit_lineasfacturascli(curLF:FLSqlCursor):Boolean
{
    debug("KLO==================> Nivel de transaccion facturasCli (2 no ejecuta afterCommit): "+sys.transactionLevel());
    if (sys.transactionLevel() == 2) 
        return true;

    this.iface.__afterCommit_lineasfacturascli(curLF);

    return true;
}

function scab_afterCommit_lineaspedidosprov(curLP:FLSqlCursor):Boolean
{
    debug("KLO==================> Nivel de transaccion pedidosProv(2 no ejecuta afterCommit): "+sys.transactionLevel());
    if (sys.transactionLevel() == 2) 
        return true;

    this.iface.__afterCommit_lineaspedidosprov(curLP);

    return true;
}

function scab_afterCommit_lineasalbaranesprov(curLA:FLSqlCursor):Boolean
{
    debug("KLO==================> Nivel de transaccion albaranesProv (2 no ejecuta afterCommit pero si actualiza servido en pedido): "+sys.transactionLevel());
    if (sys.transactionLevel() == 2) {
        if (!this.iface.actualizarPedidosLineaAlbaranProv(curLA)) {
            return false;
        }
        return true;
    }

    this.iface.__afterCommit_lineasalbaranesprov(curLA);

    return true;
}

function scab_afterCommit_lineasfacturasprov(curLF:FLSqlCursor):Boolean
{
    debug("KLO==================> Nivel de transaccion facturasProv (2 no ejecuta afterCommit pero si cambia coste medio): "+sys.transactionLevel());
    if (sys.transactionLevel() == 2) {
        var curF:FLSqlCursor = curLF.cursorRelation();
        if (!curF || curF.action() != "lineasfacturasprov") {
            var referencia:String, refAnterior:String;
            referencia = curLF.valueBuffer("referencia");
            if (referencia && referencia != "") {
                if (!flfactalma.iface.pub_cambiarCosteMedio(referencia)) {
                    return false;
                }
            }
            if (curLF.modeAccess() == curLF.Edit) {
                refAnterior = curLF.valueBufferCopy("referencia");
                if (refAnterior && refAnterior != "" && refAnterior != referencia) {
                    if (!flfactalma.iface.pub_cambiarCosteMedio(refAnterior)) {
                        return false;
                    }
                }
            }
        }
        return true;
    }

    this.iface.__afterCommit_lineasfacturasprov(curLF);

    return true;
}
/////////////////////////////////////////////////////////////////
//// CONTROL STOCK CABECERA /////////////////////////////////////

