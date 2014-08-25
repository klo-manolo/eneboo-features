
/** @class_declaration lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
class lotes extends oficial
{
  var curLote: FLSqlCursor;
  var curMoviLote: FLSqlCursor;
  function lotes(context)
  {
    oficial(context);
  }
  function copiaLineaPedido(curLineaPedido: FLSqlCursor, idAlbaran: Number): Number {
    return this.ctx.lotes_copiaLineaPedido(curLineaPedido, idAlbaran);
  }
  function buscarLoteLineaAlbaran(curLineaPedido: FLSqlCursor, idAlbaran: Number, idLineaAlbaran: Number, canTotal: Number): Number {
    return this.ctx.lotes_buscarLoteLineaAlbaran(curLineaPedido, idAlbaran, idLineaAlbaran, canTotal);
  }
  function masDatosSelecLote(curLineaPedido: FLSqlCursor): Boolean {
    return this.ctx.lotes_masDatosSelecLote(curLineaPedido);
  }
  function masDatosMoviLote(curLineaPedido: FLSqlCursor): Boolean {
    return this.ctx.lotes_masDatosMoviLote(curLineaPedido);
  }
  function esTrazable(curLineaPedido: FLSqlCursor, idAlbaran: Number): Boolean {
    return this.ctx.lotes_esTrazable(curLineaPedido, idAlbaran);
  }
  function obtenerAlmacenPedido(curLineaPedido: FLSqlCursor): String {
    return this.ctx.lotes_obtenerAlmacenPedido(curLineaPedido);
  }
}
//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
/** \C Generación de facturas y albaranes a partir de pedidos: La selección de los lotes a los que se asociarán las líneas de factura o albarán se llevará a cabo de la siguiente forma: Se buscarán los lotes ordenados por fecha de caducidad, y deberán pertenecer todos al almacén consignado en pedido. Los lotes se irán añadiendo (creando movimientos de salida de lote) hasta alcanzar la cantidad especificada en la línea de pedido. Si no hay lotes suficientes en el almacén consignado en el documento origen el sistema dará un aviso y permitirá stocks negativos en el último lote hasta completar el pedido.
\end */
function lotes_init()
{
}

function lotes_esTrazable(curLineaPedido: FLSqlCursor, idAlbaran: Number): Boolean {
  var util: FLUtil;
  var referencia: String = curLineaPedido.valueBuffer("referencia");
  var codAlmacen: String = util.sqlSelect("albaranescli", "codalmacen", "idalbaran = " + idAlbaran);
  var almacenTrazable: Boolean = util.sqlSelect("almacenes", "trazabilidad", "codalmacen = '" + codAlmacen + "'");
  var articuloTrazable: Boolean = util.sqlSelect("articulos", "porlotes", "referencia = '" + referencia + "'");
  if (!almacenTrazable || !articuloTrazable)
    return false;

  return true;
}

function lotes_copiaLineaPedido(curLineaPedido: FLSqlCursor, idAlbaran: Number): Number {

  var util: FLUtil = new FLUtil;
  var idLineaAlbaran: Number = this.iface.__copiaLineaPedido(curLineaPedido, idAlbaran);

  if (!this.iface.esTrazable(curLineaPedido, idAlbaran))
    return idLineaAlbaran;

  var canLinea: Number = parseFloat(curLineaPedido.valueBuffer("cantidad")) - parseFloat(curLineaPedido.valueBuffer("totalenalbaran"));
  if (!canLinea || canLinea == 0)
  {
    return idLineaAlbaran;
  }

  var canTotal: Number = 0;

  while (canTotal < canLinea)
  {
    canTotal = this.iface.buscarLoteLineaAlbaran(curLineaPedido, idAlbaran, idLineaAlbaran, canTotal);
    if (!canTotal)
      return false;
  }

  return idLineaAlbaran;
}

function lotes_buscarLoteLineaAlbaran(curLineaPedido: FLSqlCursor, idAlbaran: Number, idLineaAlbaran: Number, canTotal: Number): Number {
  var  util: FLUtil;

  var idUsuario: String = sys.nameUser();
  var canLote: Number;
  var descArticulo: String = curLineaPedido.valueBuffer("descripcion");
  var referencia: String = curLineaPedido.valueBuffer("referencia");
  var codAlmacen: String = this.iface.obtenerAlmacenPedido(curLineaPedido);
  var canLinea: Number = parseFloat(curLineaPedido.valueBuffer("cantidad")) - parseFloat(curLineaPedido.valueBuffer("totalenalbaran"));
  if (!canLinea)
    canLinea = 0;

  var f: Object = new FLFormSearchDB("seleclote");
  delete this.iface.curLote;
  this.iface.curLote = f.cursor();
  this.iface.curLote.select("idusuario = '" + idUsuario + "'");
  if (!this.iface.curLote.first())
  {
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
  if (!this.iface.masDatosSelecLote(curLineaPedido))
    return false;

  var acpt: String = f.exec("id");
  if (acpt)
  {
    var nuevaCantidad: Number = parseFloat(this.iface.curLote.valueBuffer("canlote"));
    var codLote: String = this.iface.curLote.valueBuffer("codlote");

    delete this.iface.curMoviLote;
    this.iface.curMoviLote = new FLSqlCursor("movilote");
    var fecha: Date = util.sqlSelect("albaranescli", "fecha", "idalbaran = " + idAlbaran);
    var idStock: Number = util.sqlSelect("stocks", "idstock", "codalmacen = '" + codAlmacen + "' AND referencia = '" + referencia + "'");
    if (!idStock) {
      var oArticulo = new Object();
      oArticulo.referencia = referencia;
      idStock = flfactalma.iface.pub_crearStock(codAlmacen, oArticulo);
    }
    if (!idStock) {
      return false;
    }
    this.iface. curMoviLote.setModeAccess(this.iface.curMoviLote.Insert);
    this.iface.curMoviLote.refreshBuffer();
    this.iface.curMoviLote.setValueBuffer("codlote", codLote);
    this.iface.curMoviLote.setValueBuffer("fecha", fecha);
    this.iface.curMoviLote.setValueBuffer("tipo", "Salida");
    this.iface.curMoviLote.setValueBuffer("docorigen", "AC");
    this.iface.curMoviLote.setValueBuffer("idlineaac", idLineaAlbaran);
    this.iface.curMoviLote.setValueBuffer("idstock", idStock);
    this.iface.curMoviLote.setValueBuffer("cantidad", (nuevaCantidad * -1));
    if (!this.iface.masDatosMoviLote())
      return false;
    if (!this.iface.curMoviLote.commitBuffer()) {
      return false;
    }
    canTotal += nuevaCantidad;
  } else {
    return false;
  }

  return canTotal;
}

function lotes_masDatosSelecLote(curLineaPedido: FLSqlCursor): Boolean {
  return true;
}

function lotes_masDatosMoviLote(): Boolean {
  return true;
}

function lotes_obtenerAlmacenPedido(curLineaPedido: FLSqlCursor): String {
  var util: FLUtil;

  var codAlmacen = util.sqlSelect("pedidoscli", "codalmacen", "idpedido = " + curLineaPedido.valueBuffer("idpedido"));
  if (!codAlmacen)
    codAlmacen = "";

  return codAlmacen;
}
//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
