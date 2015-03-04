/***************************************************************************
                 i_masterprevpagos.qs  -  description
                             -------------------
    begin                : lun abr 26 2004
    copyright            : (C) 2004 by InfoSiAL S.L.
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
    this.ctx.interna_init();
  }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna
{
  var meses: Array;
  function oficial(context)
  {
    interna(context);
  }
  function lanzar()
  {
    return this.ctx.oficial_lanzar();
  }
  function popularDatos()
  {
    return this.ctx.oficial_popularDatos();
  }
  function obtenerOrden(nivel: Number, cursor: FLSqlCursor): String {
    return this.ctx.oficial_obtenerOrden(nivel, cursor);
  }
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

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
function interna_init()
{
  connect(this.child("toolButtonPrint"), "clicked()", this, "iface.lanzar()");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_lanzar()
{
  var cursor: FLSqlCursor = this.cursor();
  var seleccion: String = cursor.valueBuffer("id");
  if (!seleccion)
    return;
  var nombreInforme: String = cursor.action();
  var orderBy: String = "";
  var o: String = "";
  for (var i: Number = 1; i < 3; i++) {
    o = this.iface.obtenerOrden(i, cursor);
    if (o) {
      if (orderBy == "")
        orderBy = o;
      else
        orderBy += ", " + o;
    }
  }

  this.iface.popularDatos();

  switch (cursor.valueBuffer("agruparfecha")) {
    case "Dia":
    case "Mes":
      nombreInforme = "i_prevpagos_agr";
      break;
  }

  flfactinfo.iface.pub_lanzarInforme(cursor, nombreInforme, orderBy);
}

function oficial_popularDatos()
{
  var util: FLUtil = new FLUtil();
  var cursor: FLSqlCursor = this.cursor();

  var fechaDesde: String;
  if (cursor.valueBuffer("fechadesde"))
    fechaDesde = cursor.valueBuffer("fechadesde");

  var fechaHasta: String;
  if (cursor.valueBuffer("fechahasta"))
    fechaHasta = cursor.valueBuffer("fechahasta");

  var codProveedor: String;
  if (cursor.valueBuffer("codproveedor"))
    codProveedor = cursor.valueBuffer("codproveedor");

  var codCuenta: String;
  if (cursor.valueBuffer("codcuenta"))
    codCuenta = cursor.valueBuffer("codcuenta");


  var where: String = "1=1";
  if (fechaDesde)
    where += " AND fechav >= '" + fechaDesde + "'";
  if (fechaHasta)
    where += " AND fechav <= '" + fechaHasta + "'";
  if (codProveedor)
    where += " AND codproveedor = '" + codProveedor + "'";
  if (codCuenta)
    where += " AND codcuenta = '" + codCuenta + "'";

  where += " order by fechav";

  var total: Number = 0;
  var texto: String = "";

  var curTab: FLSqlCursor = new FLSqlCursor("i_prevpagos_buffer");
  util.sqlDelete("i_prevpagos_buffer", "1=1");

  var q: FLSqlQuery = new FLSqlQuery();
  q.setTablesList("pagospuntuales");
  q.setFrom("pagospuntuales");
  q.setSelect("descripcion,fechav,importe,codproveedor,codcuenta");
  q.setWhere(where);

  q.exec();
  while (q.next()) {

    curTab.setModeAccess(curTab.Insert);
    curTab.refreshBuffer();
    curTab.setValueBuffer("descripcion", q.value("descripcion"));
    curTab.setValueBuffer("importe", q.value("importe"));
    curTab.setValueBuffer("fechav", q.value("fechav"));
    curTab.setValueBuffer("codproveedor", q.value("codproveedor"));
    curTab.setValueBuffer("codcuenta", q.value("codcuenta"));

    switch (cursor.valueBuffer("agruparfecha")) {
      case "Dia":
        curTab.setValueBuffer("agrupacion", util.dateAMDtoDMA(q.value("fechav")));
        break;
      case "Mes":
        mes = q.value("fechav").toString().left(7).right(2);
        agno = q.value("fechav").toString().left(4);
        curTab.setValueBuffer("agrupacion", mes + " " + agno);
        break;
    }

    curTab.commitBuffer();
  }


  // II. PAGOS PERIÓDICOS
  where = "(fechahasta IS NULL OR fechahasta >= '" + fechaDesde + "')";
  if (fechaHasta)
    where += " AND fechadesde <= '" + fechaHasta + "'";
  if (codProveedor)
    where += " AND codproveedor = '" + codProveedor + "'";
  if (codCuenta)
    where += " AND codcuenta = '" + codCuenta + "'";

  var incMeses: Number;

  q.setTablesList("pagosperiodicos");
  q.setFrom("pagosperiodicos");
  q.setSelect("descripcion,importe,codproveedor,codcuenta,fechadesde,fechahasta,diapago,periodicidad");
  q.setWhere(where);

  q.exec();

  while (q.next()) {

    switch (q.value("periodicidad")) {
      case "Mensual":
        numMeses = 1;
        break;
      case "Bimensual":
        numMeses = 2;
        break;
      case "Trimestral":
        numMeses = 3;
        break;
      case "Cuatrimestral":
        numMeses = 4;
        break;
      case "Semestral":
        numMeses = 6;
        break;
      case "Anual":
        numMeses = 12;
        break;
      case "Bienal":
        numMeses = 24;
        break;
    }

    fechaPago = q.value("fechadesde");
    fechaPago.setDate(q.value("diapago"));
    while (fechaPago < fechaDesde)
      fechaPago = util.addMonths(fechaPago, numMeses);

    while (fechaPago <= fechaHasta) {
      if (q.value("fechahasta"))
        if (fechaPago > q.value("fechahasta"))
          break;

      curTab.setModeAccess(curTab.Insert);
      curTab.refreshBuffer();
      curTab.setValueBuffer("descripcion", q.value("descripcion"));
      curTab.setValueBuffer("importe", q.value("importe"));
      curTab.setValueBuffer("fechav", fechaPago);
      curTab.setValueBuffer("codproveedor", q.value("codproveedor"));
      curTab.setValueBuffer("codcuenta", q.value("codcuenta"));

      switch (cursor.valueBuffer("agruparfecha")) {
        case "Dia":
          curTab.setValueBuffer("agrupacion", util.dateAMDtoDMA(fechaPago));
          break;
        case "Mes":
          mes = fechaPago.getMonth();
          agno = fechaPago.getYear();
          curTab.setValueBuffer("agrupacion", mes + "-" + agno);
          break;
      }

      curTab.commitBuffer();

      fechaPago = util.addMonths(fechaPago, numMeses);

    }
  }


  // III. RECIBOS DE PROVEEDOR
  if (cursor.valueBuffer("incluirrecibos")) {
    where = "estado <> 'Pagado'";
    if (fechaDesde)
      where += " AND fechav >= '" + fechaDesde + "'";
    if (fechaHasta)
      where += " AND fechav <= '" + fechaHasta + "'";
    if (codProveedor)
      where += " AND proveedores.codproveedor = '" + codProveedor + "'";
    if (codCuenta) //// CUENTA DE PAGO DEL PROVEEDOR
      where += " AND proveedores.codcuentapago = '" + codCuenta + "'";

    q.setTablesList("recibosprov,proveedores");
    q.setFrom("recibosprov INNER JOIN proveedores on recibosprov.codproveedor = proveedores.codproveedor");
    q.setSelect("codigo,fechav,importe,proveedores.codproveedor,proveedores.codcuentapago");
    q.setWhere(where);
    debug(where);

    if (!q.exec())
      return false;

    while (q.next()) {
      curTab.setModeAccess(curTab.Insert);
      curTab.refreshBuffer();
      curTab.setValueBuffer("descripcion", util.translate("scripts", "Recibo ") + q.value("codigo"));
      curTab.setValueBuffer("importe", q.value("importe"));
      curTab.setValueBuffer("fechav", q.value("fechav"));
      curTab.setValueBuffer("codproveedor", q.value(3));
      curTab.setValueBuffer("codcuenta", q.value("proveedores.codcuentapago"));

      switch (cursor.valueBuffer("agruparfecha")) {
        case "Dia":
          curTab.setValueBuffer("agrupacion", util.dateAMDtoDMA(q.value("fechav")));
          break;
        case "Mes":
          mes = q.value("fechav").toString().left(7).right(2);
          agno = q.value("fechav").toString().left(4);
          curTab.setValueBuffer("agrupacion", mes + "-" + agno);
          break;
      }

      curTab.commitBuffer();
    }
  }
}




function oficial_obtenerOrden(nivel: Number, cursor: FLSqlCursor): String {
  var ret: String = "";
  var orden: String = cursor.valueBuffer("orden" + nivel.toString());
  switch (nivel)
  {
    case 1:
    case 2: {
      switch (orden) {
        case "Fecha": {
          ret += "fechav";
          break;
        }
        case "Importe": {
          ret += "importe";
          break;
        }
        case "Proveedor": {
          ret += "codproveedor";
          break;
        }
        case "Cuenta bancaria": {
          ret += "codcuenta";
          break;
        }
      }
      break;
    }
    break;
  }
  if (ret != "")
  {
    var tipoOrden: String = cursor.valueBuffer("tipoorden" + nivel.toString());
    switch (tipoOrden) {
      case "Descendente": {
        ret += " DESC";
        break;
      }
    }
  }

  return ret;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
