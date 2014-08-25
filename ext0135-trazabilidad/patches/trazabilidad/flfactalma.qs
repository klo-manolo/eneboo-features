
/** @class_declaration lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
class lotes extends oficial
{
  function lotes(context)
  {
    oficial(context);
  }
  function beforeCommit_almacenes(curAlmacen: FLSqlCursor): Boolean {
    return this.ctx.lotes_beforeCommit_almacenes(curAlmacen);
  }
  function comprobarCambioTrazaAlmacen(curAlmacen: FLSqlCursor): Boolean {
    return this.ctx.lotes_comprobarCambioTrazaAlmacen(curAlmacen);
  }
  function cambiarStock(codAlmacen: String, referencia: String, variacion: Number, campo: String): Boolean {
    return this.ctx.lotes_cambiarStock(codAlmacen, referencia, variacion, campo);
  }
  function afterCommit_movilote(curMoviLote: FLSqlCursor): Boolean {
    return this.ctx.lotes_afterCommit_movilote(curMoviLote);
  }
  function beforeCommit_movilote(curMoviLote: FLSqlCursor): Boolean {
    return this.ctx.lotes_beforeCommit_movilote(curMoviLote);
  }
  //  function controlStockLineasTrans(curLTS:FLSqlCursor):Boolean {
  //    return this.ctx.lotes_controlStockLineasTrans(curLTS);
  //  }
  function afterCommit_lineastrazabilidadinterna(curLA: FLSqlCursor): Boolean {
    return this.ctx.lotes_afterCommit_lineastrazabilidadinterna(curLA);
  }
  function controlStockTrazabilidadInterna(curLTI: FLSqlCursor): Boolean {
    return this.ctx.lotes_controlStockTrazabilidadInterna(curLTI);
  }
  function validarConsistenciaML(curMoviLote: FLSqlCursor): Boolean {
    return this.ctx.lotes_validarConsistenciaML(curMoviLote);
  }
  function controlStockLote(curMoviLote: FLSqlCursor): Boolean {
    return this.ctx.lotes_controlStockLote(curMoviLote);
  }
  function actualizarCantidadLote(codLote: String): Boolean {
    return this.ctx.lotes_actualizarCantidadLote(codLote);
  }
  function controlCantidadLote(curMoviLote: FLSqlCursor): Boolean {
    return this.ctx.lotes_controlCantidadLote(curMoviLote);
  }
}
//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubLotes */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class pubLotes extends ifaceCtx
{
  function pubLotes(context)
  {
    ifaceCtx(context);
  }
}
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
/** \C El calculo de los stocks se realizará de la forma normal en el caso de que los artículo no estén bajo control por lotes
\end */
function lotes_cambiarStock(codAlmacen: String, referencia: String, variacion: Number, campo: String): Boolean {
  var util: FLUtil = new FLUtil();
  var almacenTrazable: Boolean = util.sqlSelect("almacenes", "trazabilidad", "codalmacen = '" + codAlmacen + "'");
  var articuloTrazable: Boolean = util.sqlSelect("articulos", "porlotes", "referencia = '" + referencia + "'");

  if (almacenTrazable && articuloTrazable)
  {
    return true;
  } else {
    return this.iface.__cambiarStock(codAlmacen, referencia, variacion, campo);
  }
}

function lotes_afterCommit_movilote(curMoviLote: FLSqlCursor): Boolean {
  if (!this.iface.controlCantidadLote(curMoviLote))
  {
    return false;
  }
  if (!this.iface.controlStockLote(curMoviLote))
  {
    return false;
  }
  return true;
}

/** \C El campo en almacén del lote correspondiente se actualizará. De la misma forma, el campo cantidad del stock asociado se calculará como la suma del campo cantidad de los movimientos que lo componen.
\end */
function lotes_controlCantidadLote(curMoviLote: FLSqlCursor): Boolean {
  var util = new FLUtil();
  var codLote = curMoviLote.valueBuffer("codlote");

  if (curMoviLote.cursorRelation() && curMoviLote.cursorRelation().action() == "lotes")
  {
  } else {
    if (!this.iface.actualizarCantidadLote(codLote))
    {
      return false;
    }
    var codLoteAnterior: String = curMoviLote.valueBufferCopy("codlote");
    if (curMoviLote.modeAccess() == curMoviLote.Edit && codLote != codLoteAnterior)
    {
      if (!this.iface.actualizarCantidadLote(codLoteAnterior)) {
        return false;
      }
    }
  }

  return true;
}

/** \C El campo en almacén del lote correspondiente se actualizará. De la misma forma, el campo cantidad del stock asociado se calculará como la suma del campo cantidad de los movimientos que lo componen.
\end */
function lotes_controlStockLote(curMoviLote: FLSqlCursor): Boolean {
  var util: FLUtil = new FLUtil();
  var idStock: Number = curMoviLote.valueBuffer("idstock");

  //  var hoy:Date = new Date();
  //  var cantidadStock:Number = util.sqlSelect("movilote INNER JOIN lotes ON movilote.codlote = lotes.codlote", "SUM(movilote.cantidad)", "movilote.idstock = " + idStock + " AND caducidad >= '" + hoy + "' AND caducidad IS NOT NULL", "movilote,lotes");
  //  cantidadStock = (isNaN(cantidadStock) ? 0 : cantidadStock);

  var curStock: FLSqlCursor = new FLSqlCursor("stocks");
  curStock.select("idstock = " + idStock);
  if (!curStock.first())
  {
    return false;
  }
  curStock.setModeAccess(curStock.Edit);
  curStock.refreshBuffer();
  curStock.setValueBuffer("cantidad", formRecordregstocks.iface.pub_commonCalculateField("cantidad", curStock));
  curStock.setValueBuffer("disponible", formRecordregstocks.iface.pub_commonCalculateField("disponible", curStock));
  if (!curStock.commitBuffer())
  {
    return false;
  }

  return true;
}

/** \D Actualiza el campo enalmacen de un lote como suma de sus movimientos
@param  codLote: Código del lote a actualizar
\end */
function lotes_actualizarCantidadLote(codLote: String): Boolean {
  var util: FLUtil = new FLUtil();

  var enAlmacen: Number = util.sqlSelect("movilote", "SUM(cantidad)", "codlote = '" + codLote + "'");
  enAlmacen = (isNaN(enAlmacen) ? 0 : enAlmacen);

  if (!util.sqlUpdate("lotes", "enalmacen", enAlmacen, "codlote = '" + codLote + "'"))
  {
    return false;
  }
  return true;
}

function lotes_beforeCommit_movilote(curMoviLote: FLSqlCursor): Boolean {
  var util: FLUtil = new FLUtil();
  var curRelacionado: FLSqlCursor = curMoviLote.cursorRelation();

  if (!this.iface.validarConsistenciaML(curMoviLote))
  {
    return false;
  }

  if (curRelacionado && curRelacionado.action() == "lotes")
  {
    if (curMoviLote.valueBuffer("tipo") != "Regularización") {
      if (curMoviLote.modeAccess() == curMoviLote.Del) {
        MessageBox.warning(util.translate("scripts", "Sólo puede borrar registros de tipo Regularización"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
        return false;
      }
    }
  }
  return true;
}

/** \D Comprueba que las referencias del lote y el stock del movimiento coinciden
@param curMoviLote: Cursor del movimiento de lote
\end */
function lotes_validarConsistenciaML(curMoviLote: FLSqlCursor): Boolean {
  var util: FLUtil = new FLUtil();

  switch (curMoviLote.modeAccess())
  {
    case curMoviLote.Insert:
    case curMoviLote.Edit: {
      var refStock: String = util.sqlSelect("stocks", "referencia", "idstock = " + curMoviLote.valueBuffer("idstock"));
      var refLote: String = util.sqlSelect("lotes", "referencia", "codlote = '" + curMoviLote.valueBuffer("codlote") + "'");
      if (refStock != refLote) {
        MessageBox.warning(util.translate("scripts", "Error al crear o modificar el movimiento de lote:\nLa referencia del lote (%1) no coincide con la del stock (%2)").arg(refLote).arg(refStock), MessageBox.Ok, MessageBox.NoButton);
        return false;
      }
      break;
    }
  }
  return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
// function lotes_controlStockLineasTrans(curLTS:FLSqlCursor):Boolean
// {
//  var util:FLUtil = new FLUtil();
//
//  var referencia:String = curLTS.valueBuffer("referencia");
//  if (!util.sqlSelect("articulos", "porlotes", "referencia = '" + referencia + "'")) {
//    return this.iface.__controlStockLineasTrans(curLTS);
//  }
//  var codAlmacenOrigen:String = util.sqlSelect("transstock", "codalmaorigen", "idtrans = " + curLTS.valueBuffer("idtrans"));
//  if (!codAlmacenOrigen || codAlmacenOrigen == "") {
//    return true;
//  }
//  var idStockOrigen:String = util.sqlSelect("stocks", "idstock", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacenOrigen + "'");
//  if (!idStockOrigen) {
//    idStockOrigen = this.iface.crearStock(codAlmacenOrigen, referencia);
//    if (!idStockOrigen) {
//      return false;
//    }
//  }
//
//  var codAlmacenDestino:String = util.sqlSelect("transstock", "codalmadestino", "idtrans = " + curLTS.valueBuffer("idtrans"));
//  if (!codAlmacenDestino || codAlmacenDestino == "") {
//    return true;
//  }
//  var idStockDestino:String = util.sqlSelect("stocks", "idstock", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacenDestino + "'");
//  if (!idStockDestino) {
//    idStockDestino = this.iface.crearStock(codAlmacenDestino, referencia);
//    if (!idStockDestino) {
//      return false;
//    }
//  }
//
//  var cantidad:Number = parseFloat(curLTS.valueBuffer("cantidad"));
//  var codLote:String = curLTS.valueBuffer("codlote");
//  var idLinea:String = curLTS.valueBuffer("idlinea");
//
//  switch(curLTS.modeAccess()) {
//    case curLTS.Insert: {
//      var fechaTrans:String = curLTS.cursorRelation().valueBuffer("fecha");
//      var curMoviLote:FLSqlCursor = new FLSqlCursor("movilote");
//      with(curMoviLote) {
//        setModeAccess(Insert);
//        refreshBuffer();
//        setValueBuffer("codlote", codLote);
//        setValueBuffer("idstock", idStockOrigen);
//        setValueBuffer("cantidad", (-1 * cantidad));
//        setValueBuffer("descripcion", util.translate("scripts", "Traspaso a almacén %1").arg(codAlmacenDestino));
//        setValueBuffer("fecha", fechaTrans);
//        setValueBuffer("tipo", "Transferencia");
//        setValueBuffer("docorigen", "TR");
//        setValueBuffer("idlineats", idLinea);
//        if (!commitBuffer())
//          return false;
//      }
//      with(curMoviLote) {
//        setModeAccess(Insert);
//        refreshBuffer();
//        setValueBuffer("codlote", codLote);
//        setValueBuffer("idstock", idStockDestino);
//        setValueBuffer("cantidad", cantidad);
//        setValueBuffer("descripcion", util.translate("scripts", "Traspaso desde almacén %1").arg(codAlmacenOrigen));
//        setValueBuffer("fecha", fechaTrans);
//        setValueBuffer("tipo", "Transferencia");
//        setValueBuffer("docorigen", "TR");
//        setValueBuffer("idlineats", idLinea);
//        if (!commitBuffer())
//          return false;
//      }
//      break;
//    }
//    case curLTS.Del: {
//      if (!util.sqlDelete("movilote", "docorigen = 'TR' AND idlineats = " + idLinea + " AND idstock = " + idStockOrigen)) {
//        return false;
//      }
//      if (!util.sqlDelete("movilote", "docorigen = 'TR' AND idlineats = " + idLinea + " AND idstock = " + idStockDestino)) {
//        return false;
//      }
//      break;
//    }
//    case curLTS.Edit: {
//      if (cantidad != curLTS.valueBufferCopy("cantidad")) {
//        var cantidadPrevia:Number = parseFloat(curLTS.valueBufferCopy("cantidad"));
//        if (!util.sqlUpdate("movilote", "cantidad", (-1 * cantidad), "docorigen = 'TR' AND idlineats = " + idLinea + " AND idstock = " + idStockOrigen)) {
//          return false;
//        }
//        if (!util.sqlUpdate("movilote", "cantidad", cantidad, "docorigen = 'TR' AND idlineats = " + idLinea + " AND idstock = " + idStockDestino)) {
//          return false;
//        }
//      }
//      break;
//    }
//  }
//
//  return true;
// }

/** \C
Actualización del stock correspondiente al artículo seleccionado en la línea
\end */
function lotes_afterCommit_lineastrazabilidadinterna(curLTI: FLSqlCursor): Boolean {
  if (!flfactalma.iface.controlStockTrazabilidadInterna(curLTI))
  {
    return false;
  }

  return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function lotes_controlStockTrazabilidadInterna(curLTI: FLSqlCursor): Boolean {
  var util: FLUtil = new FLUtil();

  if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLTI.valueBuffer("referencia") + "'"))
  {
    return true;
  }

  var codAlmacen: String = util.sqlSelect("trazabilidadinterna", "codalmacen", "codigo = '" + curLTI.valueBuffer("codtrazainterna") + "'");
  if (!codAlmacen || codAlmacen == "")
  {
    return true;
  }

  if (!this.iface.controlStock(curLTI, "cantidad", 1, codAlmacen))
  {
    return false;
  }

  return true;
}

function lotes_beforeCommit_almacenes(curAlmacen: FLSqlCursor): Boolean {
  if (!this.iface.comprobarCambioTrazaAlmacen(curAlmacen))
  {
    return false;
  }
  return true;
}

function lotes_comprobarCambioTrazaAlmacen(curAlmacen: FLSqlCursor): Boolean {
  var util: FLUtil = new FLUtil();
  switch (curAlmacen.modeAccess())
  {
    case curAlmacen.Edit: {
      var codAlmacen: String = curAlmacen.valueBuffer("codalmacen");
      if (curAlmacen.valueBuffer("trazabilidad") != curAlmacen.valueBufferCopy("trazabilidad")) {
        if (util.sqlSelect("stocks s INNER JOIN movilote ml ON s.idstock = ml.idstock", "ml.id", "s.codalmacen = '" + codAlmacen + "'", "stocks,movilote")) {
          MessageBox.warning(util.translate("scripts", "No puede cambiar la trazabilidad del almacén %1. Hay movimientos de lote asociados a dicho almacén").arg(codAlmacen), MessageBox.Ok, MessageBox.NoButton);
          return false;
        }
      }
      break;
    }
  }
  return true;
}
//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
