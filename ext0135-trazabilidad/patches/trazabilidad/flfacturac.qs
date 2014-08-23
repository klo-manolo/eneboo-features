
/** @class_declaration lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
class lotes extends oficial
{
  function lotes(context)
  {
    oficial(context);
  }
  //  function afterCommit_lineasalbaranesprov(curLA:FLSqlCursor):Boolean {
  //    return this.ctx.lotes_afterCommit_lineasalbaranesprov(curLA);
  //  }
  function beforeCommit_lineasfacturasprov(curLF: FLSqlCursor): Boolean {
    return this.ctx.lotes_beforeCommit_lineasfacturasprov(curLF);
  }
  //  function afterCommit_lineasalbaranescli(curLA:FLSqlCursor):Boolean {
  //    return this.ctx.lotes_afterCommit_lineasalbaranescli(curLA);
  //  }
  function beforeCommit_lineasfacturascli(curLF: FLSqlCursor): Boolean {
    return this.ctx.lotes_beforeCommit_lineasfacturascli(curLF);
  }
  function lineaPorLotes(curLinea)
  {
    return this.ctx.lotes_lineaPorLotes(curLinea);
  }
}
//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubPorLotes */
/////////////////////////////////////////////////////////////////
//// PUB POR LOTES //////////////////////////////////////////////
class pubPorLotes extends ifaceCtx
{
  function pubPorLotes(context)
  {
    ifaceCtx(context);
  }
  function pub_lineaPorLotes(curLinea)
  {
    return this.lineaPorLotes(curLinea);
  }
}
//// PUB POR LOTES //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
// function lotes_afterCommit_lineasalbaranesprov(curLA:FLSqlCursor):Boolean
// {
//  var util:FLUtil = new FLUtil;
//  /*
//  switch (curLA.modeAccess()) {
//    case curLA.Del: {
//      if (util.sqlSelect("articulos", "porlotes", "referencia = '" + curLA.valueBuffer("referencia") + "'")) {
//        if (!util.sqlDelete("movilote", "docorigen = 'AP' AND idorigen = " + curLA.valueBuffer("idlinea")))
//          return false;
//      }
//      break;
//    }
//
//  }
//  */
//  return interna_afterCommit_lineasalbaranesprov(curLA);
// }

function lotes_beforeCommit_lineasfacturasprov(curLF: FLSqlCursor): Boolean {
  var util: FLUtil = new FLUtil;

  switch (curLF.modeAccess())
  {
    case curLF.Del: {
      if (util.sqlSelect("movilote", "idlineaap", "idlineafp = " + curLF.valueBuffer("idlinea"))) {
        if (!util.sqlUpdate("movilote", "idlineafp", "NULL", "idlineafp = " + curLF.valueBuffer("idlinea")))
          return false;
      }
      break;
    }

  }
  return true;
}

// function lotes_afterCommit_lineasalbaranescli(curLA:FLSqlCursor):Boolean
// {
//  var util:FLUtil = new FLUtil;
//  /*
//  switch (curLA.modeAccess()) {
//    case curLA.Del: {
//      if (util.sqlSelect("articulos", "porlotes", "referencia = '" + curLA.valueBuffer("referencia") + "'")) {
//        if (!util.sqlDelete("movilote", "docorigen = 'AC' AND idorigen = " + curLA.valueBuffer("idlinea")))
//          return false;
//      }
//      break;
//    }
//  }
//  */
//  return interna_afterCommit_lineasalbaranescli(curLA);
// }

function lotes_beforeCommit_lineasfacturascli(curLF: FLSqlCursor): Boolean {
  var util: FLUtil = new FLUtil;

  switch (curLF.modeAccess())
  {
    case curLF.Del: {
      if (util.sqlSelect("movilote", "idlineaac", "idlineafc = " + curLF.valueBuffer("idlinea"))) {
        if (!util.sqlUpdate("movilote", "idlineafc", "NULL", "idlineafc = " + curLF.valueBuffer("idlinea")))
          return false;
      }
      break;
    }

  }

  return true;
}

/** \D Indica si el artículo de la línea de albarán o factura va por lotes o no
@param  curLinea: Cursor de la línea
\end */
function lotes_lineaPorLotes(curLinea)
{
  var util = new FLUtil;
  var curCabecera = curLinea.cursorRelation();
  if (!curCabecera) {
    switch (curLinea.table()) {
      case "lineaspresupuestoscli": {
        curCabecera = new FLSqlCursor("presupuestoscli");
        curCabecera.select("idpresupuesto = " + curLinea.valueBuffer("idpresupuesto"));
        break;
      }
      case "lineaspedidoscli": {
        curCabecera = new FLSqlCursor("pedidoscli");
        curCabecera.select("idpedido = " + curLinea.valueBuffer("idpedido"));
        break;
      }
      case "lineaspedidosprov": {
        curCabecera = new FLSqlCursor("pedidosprov");
        curCabecera.select("idpedido = " + curLinea.valueBuffer("idpedido"));
        break;
      }
      case "lineasalbaranescli": {
        curCabecera = new FLSqlCursor("albaranescli");
        curCabecera.select("idalbaran = " + curLinea.valueBuffer("idalbaran"));
        break;
      }
      case "lineasalbaranesprov": {
        curCabecera = new FLSqlCursor("albaranesprov");
        curCabecera.select("idalbaran = " + curLinea.valueBuffer("idalbaran"));
        break;
      }
      case "lineasfacturascli": {
        curCabecera = new FLSqlCursor("facturascli");
        curCabecera.select("idfactura = " + curLinea.valueBuffer("idfactura"));
        break;
      }
      case "lineasfacturasprov": {
        curCabecera = new FLSqlCursor("facturasprov");
        curCabecera.select("idfactura = " + curLinea.valueBuffer("idfactura"));
        break;
      }
      default: {
        return false;
      }
    }
    if (!curCabecera.first()) {
      return false;
    }
    curCabecera.setModeAccess(curCabecera.Browse);
    curCabecera.refreshBuffer();
  }
  var almacenTrazable = util.sqlSelect("almacenes", "trazabilidad", "codalmacen = '" + curCabecera.valueBuffer("codalmacen") + "'");
  var articuloTrazable = util.sqlSelect("articulos", "porlotes", "referencia = '" + curLinea.valueBuffer("referencia") + "'");
  return almacenTrazable && articuloTrazable;
}

//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
