/***************************************************************************
                 movilote.qs  -  description
                             -------------------
    begin                : lun sep 26 2005
    copyright            : (C) 2005 by InfoSiAL S.L.
    email                : mail@infosial.com
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

/** @file */

/** @class_declaration interna */
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna
{
  var ctx: Object;
  function interna(context)
  {
    this.ctx = context;
  }
  function init()
  {
    return this.ctx.interna_init();
  }
  function validateForm()
  {
    return this.ctx.interna_validateForm();
  }
  function calculateField(fN)
  {
    return this.ctx.interna_calculateField(fN);
  }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
/////////////////////////////////////////////////////////////////
//// OFICIAL ////////////////////////////////////////////////////
class oficial extends interna
{
  var pbnCrearLote: Object;
  function oficial(context)
  {
    interna(context);
  }
  function bufferChanged(fN: String)
  {
    this.ctx.oficial_bufferChanged(fN);
  }
  function docJustificativo()
  {
    return this.ctx.oficial_docJustificativo();
  }
  function pbnConsultarDocClicked()
  {
    return this.ctx.oficial_pbnConsultarDocClicked();
  }
  function datosMoviLote(accion: String)
  {
    return this.ctx.oficial_datosMoviLote(accion);
  }
  function tratarCantidad(accion: String)
  {
    return this.ctx.oficial_tratarCantidad(accion);
  }
  function crearLote_clicked()
  {
    return this.ctx.oficial_crearLote_clicked();
  }
  function filtrarPorLote(accion: String)
  {
    return this.ctx.oficial_filtrarPorLote(accion);
  }
}
//// OFICIAL ////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial
{
  function head(context)
  {
    oficial(context);
  }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head
{
  function ifaceCtx(context)
  {
    head(context);
  }
}

const iface = new ifaceCtx(this);
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
/** \C Los movimientos de lote son creados al dar de alta una línea de factura o albarán, o al generar manualmente un movimiento de regularización. Los valores de  --tipo-- y --docorigen-- se seleccionarán automáticamente en base al tipo de documento que se esté creando, pudiendo modificarse el campo --tipo-- de entrada a salida o viceversa (p.e. en el caso de facturas de abono).

El --idstock-- será el correspondiente a la referencia del artículo introducido en la línea del documento y al almacén establecido para el documento.

En el caso de las regularizaciones el --docorigen-- tendrá el valor NO (sin documento de origen).
\end */
function interna_init()
{
  var util = new FLUtil();
  var curMoviLotes = this.cursor();
  var curRelacionado = curMoviLotes.cursorRelation();
  this.iface.pbnCrearLote = this.child("pbnCrearLote");

  connect(this.iface.pbnCrearLote, "clicked()", this, "iface.crearLote_clicked");
  connect(this.child("pbnConsultarDoc"), "clicked()", this, "iface.pbnConsultarDocClicked");
  connect(curMoviLotes, "bufferChanged(QString)", this, "iface.bufferChanged");

  switch (curMoviLotes.modeAccess()) {
    case curMoviLotes.Insert: {
      var tipo: String;
      var docOrigen: String;
      var idStock: String;
      //var idorigen:Number;
      var codAlmacen: String;
      var referencia = curRelacionado.valueBuffer("referencia");
      var datosMovimiento = this.iface.datosMoviLote(curRelacionado.action());
      if (!datosMovimiento) {
        MessageBox.critical(util.translate("scripts", "Ha habido un error al obtener los datos del movimiento de lotes actual.\nEl formulario se cerrará"), MessageBox.Ok, MessageBox.NoButton);
        this.child("pushButtonCancel").animateClick();
        return true;
      }

      curMoviLotes.setValueBuffer("tipo", datosMovimiento.tipo);
      curMoviLotes.setValueBuffer("docorigen", datosMovimiento.docOrigen);
      /*
      if (curRelacionado.action() != "lotes")
        curMoviLotes.setValueBuffer("idorigen", datosMovimiento.idorigen);
      */
      curMoviLotes.setValueBuffer("idstock", datosMovimiento.idStock);
      if (curMoviLotes.valueBuffer("docorigen") == "FC" || curMoviLotes.valueBuffer("docorigen") == "AC") {
        curMoviLotes.setValueBuffer("codlote", this.iface.calculateField("codlotesalidadefecto"));
      }
      break;
    }
  }
  this.iface.filtrarPorLote(curRelacionado.action());

  this.child("fdbDocOrigen").setDisabled(true);
  this.child("fdbTipo").setDisabled(true);
  switch (curRelacionado.action()) {
    case "lotes": {
      this.child("pbnCrearLote").close();
      if (curMoviLotes.valueBuffer("tipo") != "Regularización" && curMoviLotes.modeAccess() == curMoviLotes.Edit) {
        MessageBox.information(util.translate("scripts", "El tipo del movimiento seleccionado no es de regularización.\nPara editar este movimiento debe hacerlo desde el correspondiente albarán o factura."), MessageBox.Ok, MessageBox.NoButton);
        this.child("pushButtonCancel").animateClick();
      }
      if (curMoviLotes.modeAccess() == curMoviLotes.Insert)
        this.child("fdbIdStock").setFilter("referencia = '" + curRelacionado.valueBuffer("referencia") + "'");
      else
        this.child("fdbIdStock").setDisabled(true);
      break;
    }
    default: {
      this.child("fdbIdStock").setDisabled(true);
    }
  }

  this.iface.tratarCantidad(curRelacionado.action());

  var cursor = this.cursor();
  var curRelacionado = cursor.cursorRelation();
  var referencia = curRelacionado.valueBuffer("referencia");

  this.iface.docJustificativo();
  this.iface.bufferChanged("codlote");
}

/** \C Si el --tipo-- de un lote es Entrada, la --cantidad-- deberá ser positiva, y si es Salida, deberá ser negativa
\end */
function interna_validateForm()
{
  var curMoviLotes = this.cursor();
  var curRelacionado = curMoviLotes.cursorRelation();
  var util = new FLUtil();

  var codLote = curMoviLotes.valueBuffer("codlote");
  if (!codLote || codLote == "") {
    MessageBox.warning(util.translate("scripts", "Debe establecer el lote"), MessageBox.Ok, MessageBox.NoButton);
    return false;
  }

  var referencia = curRelacionado.valueBuffer("referencia");
  if (!util.sqlSelect("lotes", "codlote", "codlote = '" + codLote + "' AND referencia = '" + referencia + "'")) {
    MessageBox.warning(util.translate("scripts", "El lote %1 no está asociado a la referencia %2").arg(codLote).arg(referencia), MessageBox.Ok, MessageBox.NoButton);
    return false;
  }

  if (!this.iface.tratarCantidad(curRelacionado.action()))
    return false;

  if (curMoviLotes.valueBuffer("tipo") == "Regularización"  && !curRelacionado.valueBuffer("codlote")) {
    MessageBox.warning(util.translate("scripts", "El movimiento debe ser de Entrada o Salida"), MessageBox.Ok, MessageBox.NoButton);
    this.iface.tratarCantidad(curRelacionado.action());
    return false;
  }

  if (curMoviLotes.valueBuffer("tipo") != "Regularización"  && curRelacionado.valueBuffer("codlote") && curMoviLotes.valueBuffer("tipo") == "NO") {
    MessageBox.warning(util.translate("scripts", "El movimiento debe ser de Regularización"), MessageBox.Ok, MessageBox.NoButton);
    this.iface.tratarCantidad(curRelacionado.action());
    return false;
  }

  if (curMoviLotes.valueBuffer("tipo") == "Entrada" && curMoviLotes.valueBuffer("cantidad") <= 0) {
    var res = MessageBox.warning(util.translate("scripts", "Se va a generar un movimiento con cantidad negativa para un documento de Entrada.\n¿Desea continuar?"), MessageBox.Yes, MessageBox.No);
    if (res != MessageBox.Yes)
      return false;
    this.iface.tratarCantidad(curRelacionado.action());
  }

  if (curMoviLotes.valueBuffer("tipo") == "Salida" && curMoviLotes.valueBuffer("cantidad") >= 0) {
    var res = MessageBox.warning(util.translate("scripts", "Se va a generar un movimiento con cantidad positiva para un documento de Salida.\n¿Desea continuar?"), MessageBox.Yes, MessageBox.No);
    if (res != MessageBox.Yes)
      return false;
    //this.iface.tratarCantidad(curRelacionado.action());
  }

  if (curMoviLotes.valueBuffer("docorigen") == "AC") {
    var cantidadLote = util.sqlSelect("movilote", "SUM(cantidad)", "idstock = " + curMoviLotes.valueBuffer("idstock") + " AND codlote = '" + codLote + "' AND (idlineaac IS NULL OR idlineaac <> " + curMoviLotes.valueBuffer("idlineaac") + ")");
    if ((curMoviLotes.valueBuffer("cantidad") * -1) > cantidadLote) {
      var resp = MessageBox.warning(util.translate("scripts", "No hay suficiente cantidad de artículos con referencia %1 del lote %2\nen el almacén %3 \n¿Desea continuar generando un stock negativo?").arg(curRelacionado.valueBuffer("referencia")).arg(codLote).arg(curRelacionado.cursorRelation().valueBuffer("codalmacen")), MessageBox.Yes, MessageBox.No);
      if (resp != MessageBox.Yes) {
        this.iface.tratarCantidad(curRelacionado.action());
        return false;
      }
    }
  }
  if (curMoviLotes.valueBuffer("docorigen") == "FC") {
    var cantidadLote = util.sqlSelect("movilote", "SUM(cantidad)", "idstock = " + curMoviLotes.valueBuffer("idstock") + " AND codlote = '" + codLote + "' AND (idlineafc IS NULL OR idlineaac <> " + curMoviLotes.valueBuffer("idlineafc") + ")");
    if ((curMoviLotes.valueBuffer("cantidad") * -1) > cantidadLote) {
      var resp = MessageBox.warning(util.translate("scripts", "No hay suficiente cantidad de artículos con referencia %1 del lote %2\nen el almacén %3 \n¿Desea continuar generando un stock negativo?").arg(curRelacionado.valueBuffer("referencia")).arg(codLote).arg(curRelacionado.cursorRelation().valueBuffer("codalmacen")), MessageBox.Yes, MessageBox.No);
      if (resp != MessageBox.Yes) {
        this.iface.tratarCantidad(curRelacionado.action());
        return false;
      }
    }
  }

  return true;
}

function interna_calculateField(fN)
{
  var cursor = this.cursor();
  var valor;

  switch (fN) {
    case "codlotesalidadefecto": { /// Propone como lote a vender el lote con caducidad anterior que tenga cantidad > 0 para el stock del documento. Toma el que menor cantidad tenga
      var curRelacionado = cursor.cursorRelation();
      var idStock = cursor.valueBuffer("idstock");
      var referencia = curRelacionado.valueBuffer("referencia");
      var qryLote = new FLSqlQuery;
      qryLote.setTablesList("lotes,movilote");
      qryLote.setSelect("l.codlote, l.caducidad, SUM(ml.cantidad)");
      qryLote.setFrom("lotes l INNER JOIN movilote ml ON l.codlote = ml.codlote");
      qryLote.setWhere("l.referencia = '" + referencia + "' AND caducidad >= CURRENT_DATE AND ml.idstock = " + idStock + " GROUP BY l.codlote, l.caducidad HAVING SUM(ml.cantidad) > 0 ORDER BY l.caducidad, SUM(ml.cantidad)");
      qryLote.setForwardOnly(true);
      if (!qryLote.exec()) {
        return false;
      }
      if (qryLote.first()) {
        valor = qryLote.value("l.codlote");
      }
      //var codLoteDefecto = util.sqlSelect("lotes", "codlote", "referencia = '" + referencia + "' AND (enalmacen > 0 AND caducidad >= CURRENT_DATE) ORDER BY caducidad ASC, enalmacen ASC");
      break;
    }
  }
  return valor;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/** @class_definition oficial */
/////////////////////////////////////////////////////////////////
//// OFICIAL ////////////////////////////////////////////////////
function oficial_bufferChanged(fN: String)
{
  var util: FLUtil;
  var cursor = this.cursor();

  switch (fN) {
    case "codlote": {
      var codLote = cursor.valueBuffer("codlote");
      if (!codLote || codLote == "") {
        this.child("tlbCaducidad").setText("");
        break;
      }

      if (util.sqlSelect("lotes", "codlote", "codlote = '" + codLote + "'")) {
        var fCaducidad = util.sqlSelect("lotes", "caducidad", "codlote = '" + codLote + "'");
        if (!fCaducidad)
          fCaducidad = "";

        var cantAlmacen = parseFloat(util.sqlSelect("lotes", "enalmacen", "codlote = '" + codLote + "'"));

        if (!cantAlmacen && cantAlmacen != 0)
          cantAlmacen = "";
        this.child("tlbCaducidad").setText("F. Caducidad: " + util.dateAMDtoDMA(fCaducidad) + "                           Cant. en almacén: " + cantAlmacen);
        break;

      }
      this.child("tlbCaducidad").setText("El lote especificado no existe");

      break;
    }
  }
}

/** \D Muestra los datos del documento justificativo del movimiento en la etiqueta correspondiente
\end */
function oficial_docJustificativo()
{
  var util = new FLUtil;
  var cursor = this.cursor();

  switch (cursor.valueBuffer("docorigen")) {
    case "AC" : {
      var idAlbaran = util.sqlSelect("lineasalbaranescli", "idalbaran", "idlinea = " + cursor.valueBuffer("idlineaac"));
      if (idAlbaran)
        this.child("lblDocumento").text = util.translate("scripts", "Albarán: %1 del cliente %2").arg(util.sqlSelect("albaranescli", "codigo", "idalbaran = " + idAlbaran)).arg(util.sqlSelect("albaranescli", "nombrecliente", "idalbaran = " + idAlbaran));
      break;
    }
    case "FC" : {
      var idFactura = util.sqlSelect("lineasfacturascli", "idfactura", "idlinea = " + cursor.valueBuffer("idlineafc"));
      if (idFactura)
        this.child("lblDocumento").text = util.translate("scripts", "Factura: %1 del cliente %2").arg(util.sqlSelect("facturascli", "codigo", "idfactura = " + idFactura)).arg(util.sqlSelect("facturascli", "nombrecliente", "idfactura = " + idFactura));
      break;
    }
    case "AP" : {
      var idAlbaran = util.sqlSelect("lineasalbaranesprov", "idalbaran", "idlinea = " + cursor.valueBuffer("idlineaap"));
      if (idAlbaran)
        this.child("lblDocumento").text = util.translate("scripts", "Albarán: %1 del proveedor %2").arg(util.sqlSelect("albaranesprov", "codigo", "idalbaran = " + idAlbaran)).arg(util.sqlSelect("albaranesprov", "nombre", "idalbaran = " + idAlbaran));
      break;
    }
    case "FP" : {
      var idFactura = util.sqlSelect("lineasfacturasprov", "idfactura", "idlinea = " + cursor.valueBuffer("idlineafp"));
      if (idFactura)
        this.child("lblDocumento").text = util.translate("scripts", "Factura: %1 del proveedor %2").arg(util.sqlSelect("facturasprov", "codigo", "idfactura = " + idFactura)).arg(util.sqlSelect("facturasprov", "nombre", "idfactura = " + idFactura));
      break;
    }
    case "TR" : {
      var idTrans = util.sqlSelect("lineastransstock", "idtrans", "idlinea = " + cursor.valueBuffer("idlineats"));
      if (idTrans) {
        var fechaTrans = util.sqlSelect("transstock", "fecha", "idtrans = " + idTrans);
        this.child("lblDocumento").text = util.translate("scripts", "Transferencia día %1").arg(util.dateAMDtoDMA(fechaTrans));
      }
      break;
    }
    default : {
      this.child("lblDocumento").text = util.translate("scripts", "(Sin documento)");
      this.child("pbnConsultarDoc").setDisabled(true);
      break;
    }
  }
}

/** \D Muestra los datos del documento justificativo del movimiento en la etiqueta correspondiente
\end */
function oficial_pbnConsultarDocClicked()
{
  var util = new FLUtil;
  var cursor = this.cursor();

  switch (cursor.valueBuffer("docorigen")) {
    case "AC" : {
      var idAlbaran = util.sqlSelect("lineasalbaranescli", "idalbaran", "idlinea = " + cursor.valueBuffer("idlineaac"));
      if (idAlbaran) {
        var curDocumento = new FLSqlCursor("albaranescli");
        curDocumento.select("idalbaran = " + idAlbaran);
        if (curDocumento.first()) {
          try {
            curDocumento.browseRecord();
          } catch (e) {}
        }
      }
      break;
    }
    case "FC" : {
      var idFactura = util.sqlSelect("lineasfacturascli", "idfactura", "idlinea = " + cursor.valueBuffer("idlineafc"));
      if (idFactura) {
        var curDocumento = new FLSqlCursor("facturascli");
        curDocumento.select("idfactura = " + idFactura);
        if (curDocumento.first()) {
          try {
            curDocumento.browseRecord();
          } catch (e) {}
        }
      }
      break;
    }
    case "AP" : {
      var idAlbaran = util.sqlSelect("lineasalbaranesprov", "idalbaran", "idlinea = " + cursor.valueBuffer("idlineaap"));
      if (idAlbaran) {
        var curDocumento = new FLSqlCursor("albaranesprov");
        curDocumento.select("idalbaran = " + idAlbaran);
        if (curDocumento.first()) {
          try {
            curDocumento.browseRecord();
          } catch (e) {}
        }
      }
      break;
    }
    case "FP" : {
      var idFactura = util.sqlSelect("lineasfacturasprov", "idfactura", "idlinea = " + cursor.valueBuffer("idlineafp"));
      if (idFactura) {
        var curDocumento = new FLSqlCursor("facturasprov");
        curDocumento.select("idfactura = " + idFactura);
        if (curDocumento.first()) {
          try {
            curDocumento.browseRecord();
          } catch (e) {}
        }
      }
      break;
    }
    case "TR" : {
      var idTrans = util.sqlSelect("lineastransstock", "idtrans", "idlinea = " + cursor.valueBuffer("idlineats"));
      if (idTrans) {
        var curDocumento = new FLSqlCursor("transstock");
        curDocumento.select("idtrans = " + idTrans);
        if (curDocumento.first()) {
          try {
            curDocumento.browseRecord();
          } catch (e) {}
        }
      }
      break;
    }
  }
}

/** \D Calcula los datos del movimiento en función de la acción desde donde se llama al formulario
@param  accion: Acción
@return Datos del movimiento
* Tipo (Entrada, Salida, Regularización, etc)
* DocOrigen (AC -Albarán de cliente-, FC -Factura de cliente-, etc.)
* codAlmacen
* idStock
\end */
function oficial_datosMoviLote(accion)
{
  var util = new FLUtil;
  var cursor = this.cursor();
  var curRelacionado = cursor.cursorRelation();

  var datos = [];
  var referencia = curRelacionado.valueBuffer("referencia");
  switch (accion) {
    case "lineasalbaranescli": {
      datos.tipo = "Salida";
      datos.docOrigen = "AC";
      //datos.idorigen = curRelacionado.valueBuffer("idlinea");
      datos.codAlmacen = util.sqlSelect("albaranescli", "codalmacen", "idalbaran = " + curRelacionado.valueBuffer("idalbaran"));
      datos.idStock = util.sqlSelect("stocks", "idstock", "codalmacen = '" + datos.codAlmacen + "' AND referencia = '" + referencia + "'");
      if (!datos.idStock) {
        var oArticulo = new Object();
        oArticulo.referencia = referencia;
        datos.idStock = flfactalma.iface.pub_crearStock(datos.codAlmacen, oArticulo);
        if (!datos.idStock)
          return false;
      }
      break;
    }
    case "lineasalbaranesprov": {
      datos.tipo = "Entrada";
      datos.docOrigen = "AP";
      //datos.idorigen = curRelacionado.valueBuffer("idlinea");
      datos.codAlmacen = util.sqlSelect("albaranesprov", "codalmacen", "idalbaran = " + curRelacionado.valueBuffer("idalbaran"));
      datos.idStock = util.sqlSelect("stocks", "idstock", "codalmacen = '" + datos.codAlmacen + "' AND referencia = '" + referencia + "'");
      if (!datos.idStock) {
        var oArticulo = new Object();
        oArticulo.referencia = referencia;
        datos.idStock = flfactalma.iface.pub_crearStock(datos.codAlmacen, oArticulo);
        if (!datos.idStock)
          return false;
      }
      break;
    }
    case "lineasfacturascli": {
      datos.tipo = "Salida";
      datos.docOrigen = "FC";
      //datos.idorigen = curRelacionado.valueBuffer("idlinea");
      datos.codAlmacen = util.sqlSelect("facturascli", "codalmacen", "idfactura = " + curRelacionado.valueBuffer("idfactura"));
      datos.idStock = util.sqlSelect("stocks", "idstock", "codalmacen = '" + datos.codAlmacen + "' AND referencia = '" + referencia + "'");
      if (!datos.idStock) {
        var oArticulo = new Object();
        oArticulo.referencia = referencia;
        datos.idStock = flfactalma.iface.pub_crearStock(datos.codAlmacen, oArticulo);
        if (!datos.idStock)
          return false;
      }
      break;
    }
    case "lineasfacturasprov": {
      datos.tipo = "Entrada";
      datos.docOrigen = "FP";
      //datos.idorigen = curRelacionado.valueBuffer("idlinea");
      datos.codAlmacen = util.sqlSelect("facturasprov", "codalmacen", "idfactura = " + curRelacionado.valueBuffer("idfactura"));
      datos.idStock = util.sqlSelect("stocks", "idstock", "codalmacen = '" + datos.codAlmacen + "' AND referencia = '" + referencia + "'");
      if (!datos.idStock) {
        var oArticulo = new Object();
        oArticulo.referencia = referencia;
        datos.idStock = flfactalma.iface.pub_crearStock(datos.codAlmacen, oArticulo);
        if (!datos.idStock)
          return false;
      }
      break;
    }
    case "lineastransstock": {
      if (cursor.action() == "moviloteo") {
        datos.codAlmacen = util.sqlSelect("transstock", "codalmaorigen", "idtrans = " + curRelacionado.valueBuffer("idtrans"));
      } else {
        datos.codAlmacen = util.sqlSelect("transstock", "codalmadestino", "idtrans = " + curRelacionado.valueBuffer("idtrans"));
      }
      datos.tipo = "Transferencia";
      datos.docOrigen = "TR";
      //datos.idorigen = curRelacionado.valueBuffer("idlinea");
      datos.idStock = util.sqlSelect("stocks", "idstock", "codalmacen = '" + datos.codAlmacen + "' AND referencia = '" + referencia + "'");
      if (!datos.idStock) {
        var oArticulo = new Object();
        oArticulo.referencia = referencia;
        datos.idStock = flfactalma.iface.pub_crearStock(datos.codAlmacen, oArticulo);
        if (!datos.idStock)
          return false;
      }
      break;
    }
    case "lineastrazabilidadinterna": {
      datos.tipo = "T.Interna";
      datos.docOrigen = "TI";
      //datos.idorigen = curRelacionado.valueBuffer("idlinea");
      datos.codAlmacen = util.sqlSelect("trazabilidadinterna", "codalmacen", "codigo = '" + curRelacionado.valueBuffer("codtrazainterna") + "'");
      datos.idStock = util.sqlSelect("stocks", "idstock", "codalmacen = '" + datos.codAlmacen + "' AND referencia = '" + referencia + "'");
      if (!datos.idStock) {
        var oArticulo = new Object();
        oArticulo.referencia = referencia;
        datos.idStock = flfactalma.iface.pub_crearStock(datos.codAlmacen, oArticulo);
        if (!datos.idStock)
          return false;
      }
      break;
    }
    case "lotes": {
      datos.idStock = curRelacionado.valueBuffer("idstock");
      datos.tipo = "Regularización";
      datos.docOrigen = "NO";
      break;
    }
  }
  return datos;
}

/** \D Establece los filtros del control de lote en función del cursor relacionado.
@param  accion: Acción
\end */
function oficial_filtrarPorLote(accion: String)
{
  var util = new FLUtil;
  var cursor = this.cursor();
  var curRelacionado = cursor.cursorRelation();

  var datos = [];
  var referencia = curRelacionado.valueBuffer("referencia");
  this.child("fdbCodLote").setFilter("referencia = '" + referencia + "'");
  //  switch (accion) {
  //    case "lineasalbaranescli": {
  //      this.child("fdbCodLote").setFilter("referencia = '" + referencia + "' AND enalmacen > 0");
  //      break;
  //    }
  //    case "lineasalbaranesprov":{
  //      this.child("fdbCodLote").setFilter("referencia = '" + referencia + "'");
  //      break;
  //    }
  //    case "lineasfacturascli":{
  //      this.child("fdbCodLote").setFilter("referencia = '" + referencia + "' AND enalmacen > 0");
  //      break;
  //    }
  //    case "lineasfacturasprov":{
  //      this.child("fdbCodLote").setFilter("referencia = '" + referencia + "'");
  //      break;
  //    }
  //    case "lineastransstock": {
  //      this.child("fdbCodLote").setFilter("referencia = '" + referencia + "'");
  //      break;
  //    }
  //    case "lineastrazabilidadinterna":{
  //      this.child("fdbCodLote").setFilter("referencia = '" + referencia + "'");
  //      break;
  //    }
  //    case "lotes": {
  //      this.child("fdbCodLote").setFilter("referencia = '" + referencia + "'");
  //      break;
  //    }
  //  }
  return true;
}

/** \D En los documentos de cliente la cantidad se muestra cambiada de signo para facilitar su edición. Para ello se cambia el signo al iniciarse y cerrarse el formulario.
@param accion: Nombre de la acción desde la que se llama al formulario de movimiento de lotes
\end */
function oficial_tratarCantidad(accion: String)
{
  var cursor = this.cursor();
  switch (accion) {
    case "lineasalbaranescli":
    case "lineasfacturascli":
    case "tpv_lineascomanda": {
      this.child("fdbCantidad").setValue(parseFloat(cursor.valueBuffer("cantidad")) * -1);
      break;
    }
  }
  return true;
}

function oficial_crearLote_clicked()
{

  var util: FLUtil;
  var cursor = this.cursor();

  var codNuevoLote = "";
  var referencia = cursor.cursorRelation().valueBuffer("referencia");
  var descripcion = AQUtil.sqlSelect("articulos", "descripcion", "referencia = '" + referencia + "'");
  var f = new FLFormSearchDB("insertarlotes");
  var curLotes = f.cursor();
  curLotes.setModeAccess(curLotes.Insert);
  curLotes.refreshBuffer();
  curLotes.setValueBuffer("referencia", referencia);
  curLotes.setValueBuffer("descripcion", descripcion);
  f.setMainWidget();
  curLotes.setValueBuffer("referencia", referencia);
  curLotes.setValueBuffer("descripcion", descripcion);
  f.exec("codlote");

  if (f.accepted()) {
    if (!curLotes.commitBuffer())
      return false;
    codNuevoLote = curLotes.valueBuffer("codlote");
  }

  if (codNuevoLote && codNuevoLote != "")
    cursor.setValueBuffer("codlote", codNuevoLote);

  return true;
}
//// OFICIAL ////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////