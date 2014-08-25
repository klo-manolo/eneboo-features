
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
  var referencia: String = util.sqlSelect("stocks", "referencia", "idstock = " + cursor.valueBuffer("idstock"));
  var codAlmacen: String = util.sqlSelect("stocks", "codalmacen", "idstock = " + cursor.valueBuffer("idstock"));
  var almacenTrazable: Boolean = util.sqlSelect("almacenes", "trazabilidad", "codalmacen = '" + codAlmacen + "'");
  var articuloTrazable: Boolean = util.sqlSelect("articulos", "porlotes", "referencia = '" + referencia + "'");

  if (almacenTrazable && articuloTrazable) {
    MessageBox.information(util.translate("scripts", "El artículo del stock seleccionado se controla por lotes.\nPara regularizar el stock debe crear un movimiento de regularización en el lote correspondiente."), MessageBox.Ok, MessageBox.NoButton);
    this.child("pushButtonCancel").animateClick();
  }
}
//// TRAZABILIDAD ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
