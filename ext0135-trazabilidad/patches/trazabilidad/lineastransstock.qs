
/** @class_declaration lotes */
/////////////////////////////////////////////////////////////////
//// TRAZABILIDAD ///////////////////////////////////////////////
class lotes extends oficial
{
  var curLote: FLSqlCursor;
  var curMoviLote: FLSqlCursor;
  var trazabilidadActiva_;
  var almaOrigenTrazable_;
  var almaDestinoTrazable_;
  var articuloTrazable_;
  function lotes(context)
  {
    oficial(context);
  }
  function init()
  {
    return this.ctx.lotes_init();
  }
  function iniciarMoviLote()
  {
    return this.ctx.lotes_iniciarMoviLote();
  }
  function habilitarCantidad()
  {
    return this.ctx.lotes_habilitarCantidad();
  }
  function bufferChanged(fN: String)
  {
    return this.ctx.lotes_bufferChanged(fN);
  }
  function validateForm()
  {
    return this.ctx.lotes_validateForm();
  }
  function calcularTrazabilidadActiva()
  {
    return this.ctx.lotes_calcularTrazabilidadActiva();
  }
  function validarTrazabilidad()
  {
    return this.ctx.lotes_validarTrazabilidad();
  }
  function tbnLotes_clicked()
  {
    return this.ctx.lotes_tbnLotes_clicked();
  }
  //  function validarConsistenciaMoviLote() {
  //    return this.ctx.lotes_validarConsistenciaMoviLote();
  //  }
  function masDatosSelecLote()
  {
    return this.ctx.lotes_masDatosSelecLote();
  }
  function masDatosMoviLote()
  {
    return this.ctx.lotes_masDatosMoviLote();
  }
  function generarLoteLineaTransStock()
  {
    return this.ctx.lotes_generarLoteLineaTransStock();
  }
  function calcularCantidadO()
  {
    return this.ctx.lotes_calcularCantidadO();
  }
  function calcularCantidadD()
  {
    return this.ctx.lotes_calcularCantidadD();
  }
  function calculateField(fN)
  {
    return this.ctx.lotes_calculateField(fN);
  }
}
//// TRAZABILIDAD ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition lotes */
/////////////////////////////////////////////////////////////////
//// TRAZABILIDAD ///////////////////////////////////////////////
function lotes_init()
{
  this.iface.__init();

  var util = new FLUtil();
  var cursor = this.cursor();

  //  this.child("tdbMoviLote").setReadOnly(true);

  this.iface.calcularTrazabilidadActiva();
  this.iface.habilitarCantidad();
  this.iface.iniciarMoviLote();

  connect(this.child("tbnLotes"), "clicked()", this, "iface.tbnLotes_clicked");

}

function lotes_calculateField(fN)
{
  var util = new FLUtil;
  var cursor = this.cursor();
  var curTS = cursor.cursorRelation();
  var _i = this.iface;
  var valor;
  switch (fN) {
    case "cantidado": {
      var referencia = cursor.valueBuffer("referencia");
      var idStock = util.sqlSelect("stocks", "idstock", "codalmacen = '" + curTS.valueBuffer("codalmaorigen") + "' AND referencia = '" + referencia + "'");
      if (!idStock) {
        valor = 0;
        break;
      }
      valor = util.sqlSelect("movilote", "SUM(cantidad)", "idlineats = " + cursor.valueBuffer("idlinea") + " AND idstock = " + idStock);
      valor = isNaN(valor) ? 0 : valor;
      valor *= -1;
      break;
    }
    case "cantidadd": {
      var referencia = cursor.valueBuffer("referencia");
      var idStock = util.sqlSelect("stocks", "idstock", "codalmacen = '" + curTS.valueBuffer("codalmadestino") + "' AND referencia = '" + referencia + "'");
      if (!idStock) {
        valor = 0;
        break;
      }
      valor = util.sqlSelect("movilote", "SUM(cantidad)", "idlineats = " + cursor.valueBuffer("idlinea") + " AND idstock = " + idStock);
      valor = isNaN(valor) ? 0 : valor;
      break;
    }
    default: {
      valor = this.iface.__calculateField(fN);
    }
  }
  return valor;
}

function lotes_iniciarMoviLote()
{
  var util = new FLUtil;
  var cursor = this.cursor();
  var curTS = cursor.cursorRelation();

  var codOrigen = curTS.valueBuffer("codalmaorigen");
  var codDestino = curTS.valueBuffer("codalmadestino");
  var origen = util.sqlSelect("almacenes", "nombre", "codalmacen = '" + codOrigen + "'");
  var destino = util.sqlSelect("almacenes", "nombre", "codalmacen = '" + codDestino + "'");
  this.child("gbxOrigen").title = codOrigen + " - " + origen;
  this.child("gbxDestino").title = codDestino + " - " + destino;

  this.child("tdbMoviLoteO").cursor().setAction("moviloteo");
  this.child("tdbMoviLoteO").cursor().setMainFilter("idstock IN (SELECT idstock FROM stocks WHERE codalmacen = '" + codOrigen + "')");
  this.child("tdbMoviLoteD").cursor().setMainFilter("idstock IN (SELECT idstock FROM stocks WHERE codalmacen = '" + codDestino + "')");
  this.child("tdbMoviLoteO").refresh();
  this.child("tdbMoviLoteD").refresh();
}

function lotes_habilitarCantidad()
{
  var cursor = this.cursor();
  if (cursor.modeAccess() != cursor.Insert && this.iface.trazabilidadActiva_) {
    this.child("fdbCantidad").setDisabled(true);
    this.child("fdbReferencia").setDisabled(true);
  } else {
    this.child("fdbCantidad").setDisabled(false);
    this.child("fdbReferencia").setDisabled(false);
  }
}

function lotes_bufferChanged(fN: String)
{
  var util = new FLUtil;
  var cursor = this.cursor();

  switch (fN) {
    case "referencia": {
      this.iface.calcularTrazabilidadActiva();
      this.iface.__bufferChanged(fN);
      break;
    }
    default: {
      this.iface.__bufferChanged(fN);
    }
  }
}

function lotes_validarTrazabilidad()
{
  var util = new FLUtil;
  var cursor = this.cursor();
  var _i = this.iface;

  if (!_i.trazabilidadActiva_) {
    return true;
  }
  var cantidad = cursor.valueBuffer("cantidad");
  if (_i.almaOrigenTrazable_) {
    var cantidadO = _i.calculateField("cantidado");
    if (cantidadO != cantidad) {
      MessageBox.warning(util.translate("scripts", "Error de consistencia en los movimientos de lotes del almacén origen"), MessageBox.Ok, MessageBox.NoButton);
      return false;
    }
  }
  if (_i.almaDestinoTrazable_) {
    var cantidadD = _i.calculateField("cantidadd");
    if (cantidadD != cantidad) {
      MessageBox.warning(util.translate("scripts", "Error de consistencia en los movimientos de lotes del almacén destino"), MessageBox.Ok, MessageBox.NoButton);
      return false;
    }
  }
  return true;
}

function lotes_calcularTrazabilidadActiva()
{
  var util = new FLUtil;
  var cursor = this.cursor();
  var referencia = cursor.valueBuffer("referencia");
  var curRel = cursor.cursorRelation();

  var _i = this.iface;
  _i.almaOrigenTrazable_ = util.sqlSelect("almacenes", "trazabilidad", "codalmacen = '" + curRel.valueBuffer("codalmaorigen") + "'");
  _i.almaDestinoTrazable_ = util.sqlSelect("almacenes", "trazabilidad", "codalmacen = '" + curRel.valueBuffer("codalmadestino") + "'");
  _i.articuloTrazable_ = util.sqlSelect("articulos", "porlotes", "referencia = '" + referencia + "'");

  _i.trazabilidadActiva_ = _i.articuloTrazable_ && (_i.almaOrigenTrazable_ || _i.almaDestinoTrazable_);

  disconnect(this.child("tdbMoviLoteO").cursor(), "bufferCommited()", this, "iface.calcularCantidadO");
  disconnect(this.child("tdbMoviLoteD").cursor(), "bufferCommited()", this, "iface.calcularCantidadD");
  if (_i.trazabilidadActiva_) {
    //    this.child("fdbCantidad").setDisabled(true);
    this.child("tbnLotes").enabled = true;
    this.child("gbxMoviLote").enabled = true;
    this.child("gbxOrigen").enabled = _i.almaOrigenTrazable_;
    this.child("gbxDestino").enabled = _i.almaDestinoTrazable_;
    if (_i.almaOrigenTrazable_) {
      connect(this.child("tdbMoviLoteO").cursor(), "bufferCommited()", this, "iface.calcularCantidadO");
    } else {
      connect(this.child("tdbMoviLoteD").cursor(), "bufferCommited()", this, "iface.calcularCantidadD");
    }
  } else {
    //    this.child("fdbCantidad").setDisabled(false);
    this.child("tbnLotes").enabled = false;
    this.child("gbxMoviLote").enabled = false;
  }
}

function lotes_calcularCantidadO()
{
  var _i = this.iface;
  this.child("fdbCantidad").setValue(_i.calculateField("cantidado"));
}

function lotes_calcularCantidadD()
{
  var _i = this.iface;
  this.child("fdbCantidad").setValue(_i.calculateField("cantidadd"));
}

function lotes_validateForm()
{
  var util = new FLUtil;
  var cursor = this.cursor();

  /** \C El lote y artículo especificados deben coincidir
  \end */
  //  if (!this.iface.validarConsistenciaMoviLote()) {
  //    return false;
  //  }
  if (!this.iface.validarTrazabilidad()) {
    return false;
  }

  return true;
}

// function lotes_validarConsistenciaMoviLote()
// {
//  var util= new FLUtil;
//  var cursor= this.cursor();
//
//  var canMovimientos:Number;
//  if (!this.iface.trazabilidadActiva_) {
//    canMovimientos = this.child("tdbMoviLote").cursor().size();
//    if (canMovimientos != 0) {
//      MessageBox.warning(util.translate("scripts", "No puede haber movimientos de lote para una transferencia sin trazabilidad"), MessageBox.Ok, MessageBox.NoButton);
//      return false;
//    }
//    return true;
//  }
//
//  var idLinea= cursor.valueBuffer("idlinea");
//  var referencia= cursor.valueBuffer("referencia");
//  var cantidad= cursor.valueBuffer("cantidad");
//
//  var curRel= cursor.cursorRelation();
//  var codAlmaOrigen= curRel.valueBuffer("codalmaorigen");
//  var codAlmaDestino= curRel.valueBuffer("codalmadestino");
//
//  var almaOrigenTrazable= util.sqlSelect("almacenes", "trazabilidad", "codalmacen = '" + curRel.valueBuffer("codalmaorigen") + "'");
//  var almaDestinoTrazable= util.sqlSelect("almacenes", "trazabilidad", "codalmacen = '" + curRel.valueBuffer("codalmadestino") + "'");
//
//  if (almaOrigenTrazable) {
//    var idStockOrigen= util.sqlSelect("stocks", "idstock", "codalmacen = '" + codAlmaOrigen + "' AND referencia = '" + referencia + "'");
//    if (!idStockOrigen) {
//      MessageBox.warning(util.translate("scripts", "Error al obtener el stock para el almacén %1 y el artículo %2.").arg(codAlmaOrigen).arg(referencia), MessageBox.Ok, MessageBox.NoButton);
//      return false;
//    }
//    var canOrigen= parseFloat(util.sqlSelect("movilote", "SUM(cantidad)", "idlineats = " + idLinea + " AND idstock = " + idStockOrigen));
//    canOrigen *= -1;
//    if (canOrigen != cantidad) {
//      MessageBox.warning(util.translate("scripts", "La cantidad a restar al almacén origen %1 (%2) es distinta de la cantidad a transferir (%3)").arg(codAlmaOrigen).arg(canOrigen).arg(cantidad), MessageBox.Ok, MessageBox.NoButton);
//      return false;
//    }
//  }
//  if (almaDestinoTrazable) {
//    var idStockDestino= util.sqlSelect("stocks", "idstock", "codalmacen = '" + codAlmaDestino + "' AND referencia = '" + referencia + "'");
//    if (!idStockDestino) {
//      MessageBox.warning(util.translate("scripts", "Error al obtener el stock para el almacén %1 y el artículo %2.").arg(codAlmaDestino).arg(referencia), MessageBox.Ok, MessageBox.NoButton);
//      return false;
//    }
//    var canDestino= parseFloat(util.sqlSelect("movilote", "SUM(cantidad)", "idlineats = " + idLinea + " AND idstock = " + idStockDestino));
//    if (canDestino != cantidad) {
//      MessageBox.warning(util.translate("scripts", "La cantidad a sumar al almacén destino %1 (%2) es distinta de la cantidad a transferir (%3)").arg(codAlmaDestino).arg(canDestino).arg(cantidad), MessageBox.Ok, MessageBox.NoButton);
//      return false;
//    }
//  }
//  return true;
// }
function lotes_tbnLotes_clicked()
{
  var util = new FLUtil;
  var cursor = this.cursor();

  if (cursor.modeAccess() == cursor.Insert) {
    if (!this.child("tdbMoviLoteO").cursor().commitBufferCursorRelation()) {
      return false;
    }
    this.child("fdbCantidad").setDisabled(true);
    this.child("fdbReferencia").setDisabled(true);
  }

  var canTotal = 0;
  var canLinea = parseFloat(cursor.valueBuffer("cantidad"));
  var canLote: Number;
  var idUsuario = sys.nameUser();
  var referencia = cursor.valueBuffer("referencia");
  var descArticulo = cursor.valueBuffer("descripcion");

  while (canTotal < canLinea) {
    var f = new FLFormSearchDB("seleclote");
    delete this.iface.curLote;
    this.iface.curLote = f.cursor();
    this.iface.curLote.select("idusuario = '" + idUsuario + "'");
    if (!this.iface.curLote.first()) {
      this.iface.curLote.setModeAccess(this.iface.curLote.Insert);
    } else {
      this.iface.curLote.setModeAccess(this.iface.curLote.Edit);
    }
    f.setMainWidget();

    canLote = canLinea - canTotal;

    this.iface.curLote.refreshBuffer();
    this.iface.curLote.setValueBuffer("idusuario", idUsuario);
    this.iface.curLote.setValueBuffer("referencia", referencia);
    this.iface.curLote.setValueBuffer("descripcion", descArticulo);
    this.iface.curLote.setValueBuffer("canlinea", canLinea);
    this.iface.curLote.setValueBuffer("canlote", canLote);
    this.iface.curLote.setValueBuffer("resto", canLote);
    if (!this.iface.masDatosSelecLote())
      return false;

    var acpt = f.exec("id");
    if (acpt) {
      if (!this.iface.generarLoteLineaTransStock())
        return false;

      canTotal += parseFloat(this.iface.curLote.valueBuffer("canlote"));
    } else {
      return false;
    }
  }
  this.child("tdbMoviLoteO").refresh();
  this.child("tdbMoviLoteD").refresh();
}

function lotes_generarLoteLineaTransStock()
{
  var util: FLUtil;
  var cursor = this.cursor();
  var curRel = cursor.cursorRelation();
  var idLinea = cursor.valueBuffer("idlinea");
  var codAlmaOrigen = curRel.valueBuffer("codalmaorigen");
  var codAlmaDestino = curRel.valueBuffer("codalmadestino");
  var referencia = cursor.valueBuffer("referencia");
  var almaOrigenTrazable = util.sqlSelect("almacenes", "trazabilidad", "codalmacen = '" + codAlmaOrigen + "'");
  var almaDestinoTrazable = util.sqlSelect("almacenes", "trazabilidad", "codalmacen = '" + codAlmaDestino + "'");
  var idStockOrigen: String;
  var idStockDestino: String;

  var nuevaCantidad = parseFloat(this.iface.curLote.valueBuffer("canlote"));
  var codLote = this.iface.curLote.valueBuffer("codlote");

  delete this.iface.curMoviLote;
  this.iface.curMoviLote = new FLSqlCursor("movilote");
  var fecha = curRel.valueBuffer("fecha");
  if (almaOrigenTrazable) {
    idStockOrigen = util.sqlSelect("stocks", "idstock", "codalmacen = '" + codAlmaOrigen + "' AND referencia = '" + referencia + "'");
    if (!idStockOrigen) {
      var oArticulo = new Object();
      oArticulo.referencia = referencia;
      idStockOrigen = flfactalma.iface.pub_crearStock(codAlmaOrigen, oArticulo);
    }
    if (!idStockOrigen) {
      return false;
    }
    this.iface.curMoviLote.setModeAccess(this.iface.curMoviLote.Insert);
    this.iface.curMoviLote.refreshBuffer();
    this.iface.curMoviLote.setValueBuffer("codlote", codLote);
    this.iface.curMoviLote.setValueBuffer("fecha", fecha);
    this.iface.curMoviLote.setValueBuffer("tipo", "Transferencia");
    this.iface.curMoviLote.setValueBuffer("descripcion", util.translate("scripts", "Transfer. desde almacén %1").arg(codAlmaOrigen));
    this.iface.curMoviLote.setValueBuffer("docorigen", "TR");
    this.iface.curMoviLote.setValueBuffer("idlineats", idLinea);
    this.iface.curMoviLote.setValueBuffer("idstock", idStockOrigen);
    this.iface.curMoviLote.setValueBuffer("cantidad", (nuevaCantidad * -1));
    if (!this.iface.masDatosMoviLote())
      return false;
    if (!this.iface.curMoviLote.commitBuffer()) {
      return false;
    }
  }
  if (almaDestinoTrazable) {
    idStockDestino = util.sqlSelect("stocks", "idstock", "codalmacen = '" + codAlmaDestino + "' AND referencia = '" + referencia + "'");
    if (!idStockDestino) {
      var oArticulo = new Object();
      oArticulo.referencia = referencia;
      idStockDestino = flfactalma.iface.pub_crearStock(codAlmaDestino, oArticulo);
    }
    if (!idStockDestino) {
      return false;
    }
    this.iface.curMoviLote.setModeAccess(this.iface.curMoviLote.Insert);
    this.iface.curMoviLote.refreshBuffer();
    this.iface.curMoviLote.setValueBuffer("codlote", codLote);
    this.iface.curMoviLote.setValueBuffer("fecha", fecha);
    this.iface.curMoviLote.setValueBuffer("tipo", "Transferencia");
    this.iface.curMoviLote.setValueBuffer("descripcion", util.translate("scripts", "Transfer. a almacén %1").arg(codAlmaDestino));
    this.iface.curMoviLote.setValueBuffer("docorigen", "TR");
    this.iface.curMoviLote.setValueBuffer("idlineats", idLinea);
    this.iface.curMoviLote.setValueBuffer("idstock", idStockDestino);
    this.iface.curMoviLote.setValueBuffer("cantidad", nuevaCantidad);
    if (!this.iface.masDatosMoviLote())
      return false;
    if (!this.iface.curMoviLote.commitBuffer()) {
      return false;
    }
  }

  return true;
}

function lotes_masDatosSelecLote()
{
  return true;
}

function lotes_masDatosMoviLote()
{
  return true;
}
//// TRAZABILIDAD ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
