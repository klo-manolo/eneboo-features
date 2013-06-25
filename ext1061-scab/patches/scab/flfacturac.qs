
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
    debug("KLO==================> Nivel de transaccion (2 no ejecuta afterCommit): "+sys.transactionLevel());
    if (sys.transactionLevel() == 2) 
        return true;

    this.iface.__afterCommit_lineaspedidoscli(curLP);

    return true;
}

function scab_afterCommit_lineasalbaranescli(curLA:FLSqlCursor):Boolean
{
    debug("KLO==================> Nivel de transaccion (2 no ejecuta afterCommit): "+sys.transactionLevel());
    if (sys.transactionLevel() == 2) 
        return true;

    this.iface.__afterCommit_lineasalbaranescli(curLA);

    return true;
}

function scab_afterCommit_lineasfacturascli(curLF:FLSqlCursor):Boolean
{
    debug("KLO==================> Nivel de transaccion (2 no ejecuta afterCommit): "+sys.transactionLevel());
    if (sys.transactionLevel() == 2) 
        return true;

    this.iface.__afterCommit_lineasfacturascli(curLF);

    return true;
}

function scab_afterCommit_lineaspedidosprov(curLP:FLSqlCursor):Boolean
{
    debug("KLO==================> Nivel de transaccion (2 no ejecuta afterCommit): "+sys.transactionLevel());
    if (sys.transactionLevel() == 2) 
        return true;

    this.iface.__afterCommit_lineaspedidosprov(curLP);

    return true;
}

function scab_afterCommit_lineasalbaranesprov(curLA:FLSqlCursor):Boolean
{
    debug("KLO==================> Nivel de transaccion (2 no ejecuta afterCommit): "+sys.transactionLevel());
    if (sys.transactionLevel() == 2) 
        return true;

    this.iface.__afterCommit_lineasalbaranesprov(curLA);

    return true;
}

function scab_afterCommit_lineasfacturasprov(curLF:FLSqlCursor):Boolean
{
    debug("KLO==================> Nivel de transaccion (2 no ejecuta afterCommit): "+sys.transactionLevel());
    if (sys.transactionLevel() == 2) 
        return true;

    this.iface.__afterCommit_lineasfacturasprov(curLF);

    return true;
}
/////////////////////////////////////////////////////////////////
//// CONTROL STOCK CABECERA /////////////////////////////////////

