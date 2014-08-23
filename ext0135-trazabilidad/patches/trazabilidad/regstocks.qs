
/** @class_declaration traza */
/////////////////////////////////////////////////////////////////
//// TRAZABILIDAD ///////////////////////////////////////////////
class traza extends oficial
{
  function traza(context)
  {
    oficial(context);
  }
  function init()
  {
    return this.ctx.traza_init();
  }
  function commonCalculateField(fN, cursor, oParam)
  {
    return this.ctx.traza_commonCalculateField(fN, cursor, oParam);
  }
}
//// TRAZABILIDAD ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition traza */
/////////////////////////////////////////////////////////////////
//// TRAZABILIDAD ///////////////////////////////////////////////
function traza_init()
{
  this.iface.__init();

  var util: FLUtil = new FLUtil;
  var cursor: FLSqlCursor = this.cursor();
  var referencia: String = cursor.valueBuffer("referencia");
  var codAlmacen: String = cursor.valueBuffer("codalmacen");
  var almacenTrazable: Boolean = util.sqlSelect("almacenes", "trazabilidad", "codalmacen = '" + codAlmacen + "'");
  var articuloTrazable: Boolean = util.sqlSelect("articulos", "porlotes", "referencia = '" + referencia + "'");

  if (almacenTrazable && articuloTrazable) {
    MessageBox.information(util.translate("scripts", "El artículo del stock seleccionado se controla por lotes.\nPara regularizar el stock debe crear un movimiento de regularización en el lote correspondiente."), MessageBox.Ok, MessageBox.NoButton);
    this.child("gbxRegStocks").close();
  }
}

function traza_commonCalculateField(fN, cursor, oParam)
{
  var util = new FLUtil;
  var valor;
  switch (fN) {
    case "cantidad": {
      var referencia: String = cursor.valueBuffer("referencia");
      var codAlmacen: String = cursor.valueBuffer("codalmacen");

      var almacenTrazable: Boolean = util.sqlSelect("almacenes", "trazabilidad", "codalmacen = '" + codAlmacen + "'");
      var articuloTrazable: Boolean = util.sqlSelect("articulos", "porlotes", "referencia = '" + referencia + "'");
      var porLotes: Boolean = almacenTrazable && articuloTrazable;
      if (porLotes) {
        var idStock: Number = cursor.valueBuffer("idstock");
        valor = util.sqlSelect("movilote INNER JOIN lotes ON movilote.codlote = lotes.codlote", "SUM(movilote.cantidad)", "movilote.idstock = " + idStock, "movilote,lotes");
        if (!valor) {
          valor = 0;
        }
      } else {
        valor = this.iface.__commonCalculateField(fN, cursor, oParam);
      }
      break;
    }
    default: {
      valor = this.iface.__commonCalculateField(fN, cursor, oParam);
    }
  }
  return valor;
}
//// TRAZABILIDAD ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
