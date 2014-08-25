
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
  //  function generarAlbaran(where:String, cursor:FLSqlCursor):Number {
  //    return this.ctx.lotes_generarAlbaran(where, cursor);
  //  }
  //  function comprobarAlbaran(idAlbaran:Number,idPedido:Number):Boolean {
  //    return this.ctx.lotes_comprobarAlbaran(idAlbaran,idPedido);
  //  }
  function esTrazable(curLineaPedido: FLSqlCursor, idAlbaran: Number): Boolean {
    return this.ctx.lotes_esTrazable(curLineaPedido, idAlbaran);
  }
  function copiaLineaPedido(curLineaPedido: FLSqlCursor, idAlbaran: Number): Number {
    return this.ctx.lotes_copiaLineaPedido(curLineaPedido, idAlbaran);
  }
  function masDatosSelecLote(curLineaPedido: FLSqlCursor): Boolean {
    return this.ctx.lotes_masDatosSelecLote(curLineaPedido);
  }
  function masDatosMoviLote(): Boolean {
    return this.ctx.lotes_masDatosMoviLote();
  }
  function generarLoteLineaAlbaran(idAlbaran: Number, idLineaAlbaran: Number): Boolean {
    return this.ctx.lotes_generarLoteLineaAlbaran(idAlbaran, idLineaAlbaran);
  }
}
//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
/*
function lotes_generarAlbaran(where:String, cursor:FLSqlCursor):Number
{
  var util:FLUtil = new FLUtil;
  var qryPedidos:FLSqlQuery = new FLSqlQuery();
  qryPedidos.setTablesList("pedidosprov");
  qryPedidos.setSelect("idpedido,codproveedor,codigo");
  qryPedidos.setFrom("pedidosprov");
  qryPedidos.setWhere(where);
  if (!qryPedidos.exec())
    return false;

  if (qryPedidos.size() == 1) {
    qryPedidos.first();
    if (util.sqlSelect("lineaspedidosprov INNER JOIN articulos ON lineaspedidosprov.referencia = articulos.referencia", "idlinea", "idpedido = " + qryPedidos.value(0) + " AND porlotes = true", "lineaspedidosprov,articulos")) {
      var res:Number = MessageBox.warning(util.translate("scripts", "Este pedido (%1) contiene artículos por lotes.\nPara asociar un albarán a este pedido debe crearlo manualmente para luego seleccionarlo\n¿Desea continuar?").arg(qryPedidos.value("codigo")), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
      if(res != MessageBox.Yes)
        return false;
      var f:Object = new FLFormSearchDB("albaranesprov");
      var curForm:FLSqlCursor = f.cursor();
      curForm.select();

      var qryLAlbaran:FLSqlQuery = new FLSqlQuery();
      qryLAlbaran.setTablesList("lineasalbaranesprov");
      qryLAlbaran.setSelect("idalbaran");
      qryLAlbaran.setFrom("lineasalbaranesprov");
      qryLAlbaran.setWhere("idpedido <> 0 GROUP BY idalbaran");
      if (!qryLAlbaran.exec())
        return false;

      var lista:String = "";
      while(qryLAlbaran.next()){
        lista += qryLAlbaran.value(0) + ",";
      }

      f.setMainWidget();
      if (lista == "")
        curForm.setMainFilter("codproveedor = '" + qryPedidos.value(1) + "' AND ptefactura = true");
      else {
        lista = lista.left(lista.length -1);
        curForm.setMainFilter("codproveedor = '" + qryPedidos.value(1) + "' AND ptefactura = true AND idalbaran NOT IN (" + lista + ")");
      }

      curForm.refreshBuffer();
      var acpt:String = f.exec("codejercicio");
      var idAlbaran:Number;
      if (!acpt)
        return false;
      idAlbaran = curForm.valueBuffer("idalbaran");
      if (!this.iface.comprobarAlbaran(idAlbaran, qryPedidos.value(0))) {
        MessageBox.warning(util.translate("scripts", "No se puede asociar al albaran ") + util.sqlSelect("albaranesprov","codigo","idalbaran = " + idAlbaran) + ("scripts", " porque los datos no coinciden con los del pedido"), MessageBox.Ok, MessageBox.NoButton);
        return false;
      }
      formRecordlineasalbaranesprov.iface.pub_actualizarEstadoPedido(qryPedidos.value(0));
      this.iface.procesarEstado();
      return true;
    }
  } else {
    while (qryPedidos.next()) {
      if (util.sqlSelect("lineaspedidosprov INNER JOIN articulos ON lineaspedidosprov.referencia = articulos.referencia", "idlinea", "idpedido = " + qryPedidos.value(0) + " AND porlotes = true", "lineaspedidosprov,articulos")) {
      MessageBox.warning(util.translate("scripts", "No puede generar el albarán porque alguno de los pedidos que lo forman contiene artículos gestionados por lotes"), MessageBox.Ok, MessageBox.NoButton);
      return false;
      }
    }
  }
  return this.iface.__generarAlbaran(where, cursor);
}

function lotes_comprobarAlbaran(idAlbaran:Number,idPedido:Number):Boolean
{
  var qryLPedido:FLSqlQuery = new FLSqlQuery();
  qryLPedido.setTablesList("lineaspedidosprov");
  qryLPedido.setSelect("idlinea,referencia,cantidad");
  qryLPedido.setFrom("lineaspedidosprov");
  qryLPedido.setWhere("idpedido = " + idPedido);
  if (!qryLPedido.exec())
    return false;

  var qryLAlbaran:FLSqlQuery = new FLSqlQuery();
  qryLAlbaran.setTablesList("lineasalbaranesprov");
  qryLAlbaran.setSelect("idlinea,referencia,cantidad");
  qryLAlbaran.setFrom("lineasalbaranesprov");
  qryLAlbaran.setWhere("idalbaran = " + idAlbaran);
  if (!qryLAlbaran.exec())
    return false;

  if(qryLPedido.size() != qryLAlbaran.size())
    return false;

  var curLPedido:FLSqlCursor = new FLSqlCursor("lineaspedidosprov");
  var curLAlbaran:FLSqlCursor = new FLSqlCursor("lineasalbaranesprov");

  var encontrado:Boolean = false;
  while(qryLPedido.next()){
    encontrado = false;
    qryLAlbaran.first();
    do{
      if(qryLPedido.value(1) == qryLAlbaran.value(1)){
        encontrado = true;
        if(parseFloat(qryLPedido.value(2)) != parseFloat(qryLAlbaran.value(2)))
          encontrado = false;
      }
      if(encontrado){
        curLPedido.select("idlinea = " + qryLPedido.value(0));
        curLPedido.first();
        curLPedido.setModeAccess(curLPedido.Edit);
        curLPedido.refreshBuffer();
        curLPedido.setValueBuffer("totalenalbaran", qryLAlbaran.value(2));
        if (!curLPedido.commitBuffer())
          return false;

        curLAlbaran.select("idlinea = " + qryLAlbaran.value(0));
        curLAlbaran.first();
        curLAlbaran.setModeAccess(curLAlbaran.Edit);
        curLAlbaran.refreshBuffer();
        curLAlbaran.setValueBuffer("idpedido", idPedido);
        curLAlbaran.setValueBuffer("idlineapedido", qryLPedido.value(0));
        if (!curLAlbaran.commitBuffer())
          return false;
      }
    } while(qryLAlbaran.next() && !encontrado);
  }
  if(!encontrado)
    return false;
  return true;
}*/

function lotes_esTrazable(curLineaPedido: FLSqlCursor, idAlbaran: Number): Boolean {
  var util: FLUtil;
  var referencia: String = curLineaPedido.valueBuffer("referencia");
  var codAlmacen: String = util.sqlSelect("albaranesprov", "codalmacen", "idalbaran = " + idAlbaran);
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

  var canLote: Number;
  var referencia: String = curLineaPedido.valueBuffer("referencia");
  var descArticulo: String = curLineaPedido.valueBuffer("descripcion");
  var canTotal: Number = 0;

  var idUsuario: String = sys.nameUser();
  while (canTotal < canLinea)
  {
    var f: Object = new FLFormSearchDB("seleclote");
    delete this.iface.curLote
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
    if (!this.iface.masDatosSelecLote(curLineaPedido))
      return false;

    var acpt: String = f.exec("id");
    if (acpt) {
      if (!this.iface.generarLoteLineaAlbaran(idAlbaran, idLineaAlbaran))
        return false;

      canTotal += parseFloat(this.iface.curLote.valueBuffer("canlote"));
    } else {
      return false;
    }
  }

  return idLineaAlbaran;
}

function lotes_generarLoteLineaAlbaran(idAlbaran: Number, idLineaAlbaran: Number): Boolean {
  var util: FLUtil;
  var nuevaCantidad: Number = parseFloat(this.iface.curLote.valueBuffer("canlote"));
  var codLote: String = this.iface.curLote.valueBuffer("codlote");
  var referencia = this.iface.curLote.valueBuffer("referencia");
  var codAlmacen: String = util.sqlSelect("albaranesprov", "codalmacen", "idalbaran = " + idAlbaran);

  delete this.iface.curMoviLote;
  this.iface.curMoviLote = new FLSqlCursor("movilote");
  var fecha: Date = util.sqlSelect("albaranesprov", "fecha", "idalbaran = " + idAlbaran);
  var idStock: Number = util.sqlSelect("stocks", "idstock", "codalmacen = '" + codAlmacen + "' AND referencia = '" + referencia + "'");
  if (!idStock)
  {
    var oArticulo = new Object();
    oArticulo.referencia = referencia;
    idStock = flfactalma.iface.pub_crearStock(codAlmacen, oArticulo);
  }
  if (!idStock)
  {
    return false;
  }
  this.iface.curMoviLote.setModeAccess(this.iface.curMoviLote.Insert);
  this.iface.curMoviLote.refreshBuffer();
  this.iface.curMoviLote.setValueBuffer("codlote", codLote);
  this.iface.curMoviLote.setValueBuffer("fecha", fecha);
  this.iface.curMoviLote.setValueBuffer("tipo", "Entrada");
  this.iface.curMoviLote.setValueBuffer("docorigen", "AP");
  this.iface.curMoviLote.setValueBuffer("idlineaap", idLineaAlbaran);
  this.iface.curMoviLote.setValueBuffer("idstock", idStock);
  this.iface.curMoviLote.setValueBuffer("cantidad", nuevaCantidad);

  if (!this.iface.masDatosMoviLote())
    return false;

  if (!this.iface.curMoviLote.commitBuffer())
  {
    return false;
  }

  return true;
}

function lotes_masDatosSelecLote(curLineaPedido: FLSqlCursor): Boolean {
  return true;
}

function lotes_masDatosMoviLote(): Boolean {
  return true;
}
//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
