/***************************************************************************
                      informeprevpagos.qs  -  description
                             -------------------
    begin                : vie jun 26 2004
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
  var tedResultados: Object;
  function oficial(context)
  {
    interna(context);
  }
  function lanzarResultados()
  {
    return this.ctx.oficial_lanzarResultados();
  }
  function imprimirResultados()
  {
    return this.ctx.oficial_imprimirResultados();
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
  this.iface.tedResultados = this.child("tedResultados");
  this.iface.tedResultados.clear();

  connect(this.child("pbnLanzarResultados"), "clicked()", this, "iface.lanzarResultados");
  connect(this.child("pbnImprimirResultados"), "clicked()", this, "iface.imprimirResultados");
}


//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_lanzarResultados()
{
  this.iface.tedResultados.clear();

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
    q.setSelect("codigo,fechav,importe,proveedores.codproveedor,codcuentapago");
    q.setWhere(where);
    debug(where);

    q.exec();
    while (q.next()) {
      curTab.setModeAccess(curTab.Insert);
      curTab.refreshBuffer();
      curTab.setValueBuffer("descripcion", util.translate("scripts", "Recibo ") + q.value("codigo"));
      curTab.setValueBuffer("importe", q.value("importe"));
      curTab.setValueBuffer("fechav", q.value("fechav"));
      curTab.setValueBuffer("codproveedor", q.value(3));
      curTab.setValueBuffer("codcuenta", q.value("codcuentapago"));
      curTab.commitBuffer();
    }
  }


  texto += "<table>";
  texto += "<tr>";
  texto += "<th>" + util.translate("scripts", "Descripción") + "</th>";
  texto += "<th>" + util.translate("scripts", "Vencimiento") + "</th>";
  texto += "<th>" + util.translate("scripts", "Proveedor") + "</th>";
  texto += "<th>" + util.translate("scripts", "Cuenta") + "</th>";
  texto += "<th align=\"right\">" + util.translate("scripts", "Importe") + "</th>";
  texto += "</tr>";

  q.setFrom("i_prevpagos_buffer");
  q.setTablesList("i_prevpagos_buffer");
  q.setSelect("descripcion,fechav,importe,codproveedor,codcuenta");
  q.setWhere("1=1 order by fechav, importe");
  q.exec();

  while (q.next()) {
    texto += "<tr>";
    texto += "<td>" + q.value("descripcion") + "</td>";
    texto += "<td>" + util.dateAMDtoDMA(q.value("fechav")) + "</td>";
    texto += "<td>" + q.value("codproveedor") + "</td>";
    texto += "<td>" + q.value("codcuenta") + "</td>";
    texto += "<td align=\"right\">" + util.buildNumber(q.value("importe"), "f", 2) + "</td>";
    texto += "</tr>";
    total += parseFloat(q.value("importe"));
  }

  texto += "<tr>";
  texto += "<th colspan=\"4\">" + util.translate("scripts", "Total") + "</th>";
  texto += "<th align=\"right\">" + util.buildNumber(total, "f", 2) + "</th>";
  texto += "</tr>";
  texto += "</table>";

  this.iface.tedResultados.append(texto);
}

function oficial_imprimirResultados()
{
  var tedResultados = this.child("tedResultados");

  if (tedResultados.text.isEmpty())
    return;

  sys.printTextEdit(tedResultados);
}


//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
