/**************************************************************************
                 agruparrecpagprov.qs  -  description
                             -------------------
    begin                : mie ene 31 2006
    copyright            : (C) 2006 by InfoSiAL S.L.
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
  var estado: String;
  var currentRow: Number;
  function oficial(context)
  {
    interna(context);
  }
  function tblRecibos_currentChanged(row: Number, col: Number)
  {
    return this.ctx.oficial_tblRecibos_currentChanged(row, col);
  }
  function pbnAddDel_clicked()
  {
    return this.ctx.oficial_pbnAddDel_clicked();
  }
  function incluirFila(fila: Number, col: Number)
  {
    return this.ctx.oficial_incluirFila(fila, col);
  }
  function bufferChanged(fN: String)
  {
    return this.ctx.oficial_bufferChanged(fN);
  }
  function gestionEstado()
  {
    return this.ctx.oficial_gestionEstado();
  }
  function actualizar()
  {
    return this.ctx.oficial_actualizar();
  }
  function descontarExcepciones(): Boolean {
    return this.ctx.oficial_descontarExcepciones();
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
/** \C
Este formulario agrupa distintos recibos del mismo proveedor en un único pagaré. Si no se establece la fecha de vencimiento del pagaré se crea un pagaré por proveedor y fecha de vencimiento. Es posible especificar los criterios que deben cumplir los recibos a incluir. De la lista de recibos que cumplen los criterios de búsqueda se generará un pagaré por proveedor y fecha de vencimiento (si dicha fecha no está establecida).
\end */
function interna_init()
{
  this.iface.estado = "Buscando";
  this.iface.gestionEstado();
  var tblRecibos: QTable = this.child("tblRecibos");
  var cursor: FLSqlCursor = this.cursor();

  connect(this.child("pbnRefresh"), "clicked()", this, "iface.actualizar");
  connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
  connect(tblRecibos, "doubleClicked(int, int)", this, "iface.incluirFila");
  connect(tblRecibos, "currentChanged(int, int)", this, "iface.tblRecibos_currentChanged");
  connect(this.child("pushButtonAccept"), "clicked()", this, "iface.descontarExcepciones");
  connect(this.child("pbnAddDel"), "clicked()", this, "iface.pbnAddDel_clicked");

  var util: FLUtil = new FLUtil();
  var hoy: Date = new Date();
  this.child("fdbFechaE").setValue(hoy);
  this.child("fdbFechaVHasta").setValue(hoy);
  this.child("fdbFechaVDesde").setValue(hoy);

  tblRecibos.setNumCols(8);
  tblRecibos.setColumnWidth(0, 60);
  tblRecibos.setColumnWidth(1, 130);
  tblRecibos.setColumnWidth(2, 100);
  tblRecibos.setColumnWidth(3, 100);
  tblRecibos.setColumnWidth(4, 100);
  tblRecibos.setColumnWidth(5, 80);
  tblRecibos.setColumnWidth(6, 220);
  tblRecibos.setColumnLabels("/", "Incluir/Código/Emisión/Vencimiento/Total/Proveedor/Nombre/idrecibo");
  tblRecibos.hideColumn(7);

  cursor.setValueBuffer("excepciones", "");
  this.iface.bufferChanged("sinfechav");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_tblRecibos_currentChanged(row: Number, col: Number)
{
  this.iface.currentRow = row;
}

function oficial_pbnAddDel_clicked()
{
  this.iface.incluirFila(this.iface.currentRow, 0);
}

function oficial_incluirFila(fila: Number, col: Number)
{
  var tblRecibos: QTable = this.child("tblRecibos");

  if (tblRecibos.numRows() == 0) return;

  if (tblRecibos.text(fila, 0) == "Sí")
    tblRecibos.setText(fila, 0, "No");
  else
    tblRecibos.setText(fila, 0, "Sí");
}

function oficial_bufferChanged(fN: String)
{
  var cursor: FLSqlCursor = this.cursor();
  switch (fN) {
      /** \C
      La modificación de alguno de los criterios de búsqueda habilita el botón 'Actualizar', de forma que puede realizarse una búsqueda de acuerdo a los nuevos criterios utilizados.
      \end */
    case "codproveedor":
    case "fechavdesde":
    case "fechavhasta": {
      if (this.iface.estado == "Seleccionando") {
        this.iface.estado = "Buscando";
        this.iface.gestionEstado();
      }
      break;
    }
    case "sinfechav": {
      if (cursor.valueBuffer("sinfechav")) {
        //cursor.setNull("fechav");
        this.child("fdbFechaV").setValue("");
        this.child("fdbFechaV").setDisabled(true);
      } else {
        var hoy: Date = new Date;
        this.child("fdbFechaV").setValue(hoy);
        this.child("fdbFechaV").setDisabled(false);
      }
      break;
    }
  }
}

/** \D
El estado 'Buscando' define la situación en la que el usuario está especificando los criterios de búsqueda.
El estado 'Seleccionando' define la situación en la que el usuario ya ha buscado y puede generar la factura o facturas
\end */
function oficial_gestionEstado()
{
  switch (this.iface.estado) {
    case "Buscando": {
      this.child("pbnRefresh").enabled = true;
      this.child("pushButtonAccept").enabled = false;
      break;
    }
    case "Seleccionando": {
      this.child("pbnRefresh").enabled = false;
      this.child("pushButtonAccept").enabled = true;
      break;
    }
  }
}

/** \D
Actualiza la lista de albaranes en función de los criterios de búsqueda especificados
\end */
function oficial_actualizar()
{
  var curRecibos: FLSqlCursor = new FLSqlCursor("recibosprov");
  var tblRecibos: QTable = this.child("tblRecibos");
  var util: FLUtil = new FLUtil;
  var fila: Number;
  var numFilas: Number = tblRecibos.numRows();

  for (fila = 0; fila < numFilas; fila++)
    tblRecibos.removeRow(0);

  var where: String = formpagaresprov.iface.pub_whereAgrupacion(this.cursor());
  where += " ORDER BY codproveedor,codigo DESC";
  if (!curRecibos.select(where))
    return;

  while (curRecibos.next()) {
    curRecibos.setModeAccess(curRecibos.Browse);
    curRecibos.refreshBuffer();
    with(tblRecibos) {
      insertRows(0);
      setText(0, 0, "Sí");
      setText(0, 1, curRecibos.valueBuffer("codigo"));
      setText(0, 2, util.dateAMDtoDMA(curRecibos.valueBuffer("fecha")));
      setText(0, 3, util.dateAMDtoDMA(curRecibos.valueBuffer("fechav")));
      setText(0, 4, util.roundFieldValue(curRecibos.valueBuffer("importe"), "recibosprov", "importe"));
      setText(0, 5, curRecibos.valueBuffer("codproveedor"));
      setText(0, 6, curRecibos.valueBuffer("nombreproveedor"));
      setText(0, 7, curRecibos.valueBuffer("idrecibo"));
    }
  }
  this.iface.estado = "Seleccionando";
  this.iface.gestionEstado();

  if (tblRecibos.numRows() == 0)
    this.child("pushButtonAccept").enabled = false;
}

/** \D
Elabora un string en el que figuran, separados por comas, los identificadores de aquellos albaranes que el usuario haya marcado como 'No' (no incluir en la factura). Este string se usará para ser incluido en una sentencia NOT IN en el select de los albaranes.

@return String con la lista de excepciones
\end */
function oficial_descontarExcepciones(): Boolean {
  var valor: Boolean = true;
  var cursor: FLSqlCursor = this.cursor();
  var tblRecibos: QTable = this.child("tblRecibos");
  var excepciones: String = "";
  var fila: Number;
  for (fila = 0; fila < tblRecibos.numRows(); fila++)
  {
    if (tblRecibos.text(fila, 0) == "No") {
      if (excepciones != "")
        excepciones += ", ";
      excepciones += tblRecibos.text(fila, 7);
    }
  }
  cursor.setValueBuffer("excepciones", excepciones);
  return valor;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
