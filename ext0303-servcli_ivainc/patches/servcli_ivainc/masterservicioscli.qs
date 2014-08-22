
/** @class_declaration servIvaInc */
/////////////////////////////////////////////////////////////////
//// SERV_IVAINC ////////////////////////////////////////////////
class servIvaInc extends oficial
{
  function servIvaInc(context)
  {
    oficial(context);
  }
  function datosLineaServicio(curLineaServicio: FLSqlCursor, curLineaAlbaran: FLSqlCursor, idAlbaran: Number): Boolean {
    return this.ctx.servIvaInc_datosLineaServicio(curLineaServicio, curLineaAlbaran, idAlbaran);
  }
}
//// SERV_IVAINC ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition servIvaInc */
/////////////////////////////////////////////////////////////////
//// SERV_IVAINC ////////////////////////////////////////////////
function servIvaInc_datosLineaServicio(curLineaServicio: FLSqlCursor, curLineaAlbaran: FLSqlCursor, idAlbaran: Number): Boolean {
  with(curLineaAlbaran)
  {
    setValueBuffer("ivaincluido", curLineaServicio.valueBuffer("ivaincluido"));
    setValueBuffer("pvpunitarioiva", curLineaServicio.valueBuffer("pvpunitarioiva"));
    setValueBuffer("pvpsindtoiva", curLineaServicio.valueBuffer("pvpsindtoiva"));
    setValueBuffer("pvptotaliva", curLineaServicio.valueBuffer("pvptotaliva"));
  }

  return this.iface.__datosLineaServicio(curLineaServicio, curLineaAlbaran, idAlbaran);;
}

//// SERV_IVAINC ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
