
/** @class_declaration lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
class lotes extends oficial
{
  function lotes(context)
  {
    oficial(context);
  }
  function copiaLineaAlbaran(curLineaAlbaran: FLSqlCursor, idFactura: Number): Number {
    return this.ctx.lotes_copiaLineaAlbaran(curLineaAlbaran, idFactura);
  }
}
//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
function lotes_copiaLineaAlbaran(curLineaAlbaran: FLSqlCursor, idFactura: Number): Number {
  var util: FLUtil;

  var idLineaFactura: Number = this.iface.__copiaLineaAlbaran(curLineaAlbaran, idFactura);
  if (!idLineaFactura)
  {
    return false
  }

  var idLineaAlbaran: Number = curLineaAlbaran.valueBuffer("idlinea");
  if (!idLineaAlbaran)
  {
    return false;
  }

  if (!util.sqlUpdate("movilote", "idlineafp", idLineaFactura, "idlineaap = " + idLineaAlbaran))
  {
    return false;
  }

  return this.iface.curLineaFactura.valueBuffer("idlinea");
}
//// LOTES /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
