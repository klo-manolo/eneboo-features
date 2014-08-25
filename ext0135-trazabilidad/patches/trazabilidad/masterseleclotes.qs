/***************************************************************************
                 masterseleclotes.qs  -  description
                             -------------------
    begin                : mie nov 22 2006
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
  var chkOcultarCaducados;
  var chkMostrarTodos;
  var tbnImprimir;
  var tdbRecords;
  var filtroPrevio: String;

  function oficial(context)
  {
    interna(context);
  }
  function filtrarLotes()
  {
    return this.ctx.oficial_filtrarLotes();
  }
  function imprimir()
  {
    return this.ctx.oficial_imprimir();
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
/** \C La tabla de regularizaciones de stocks se muestra en modo de sólo lectura
\end */
function interna_init()
{
  var _i = this.iface;
  _i.chkOcultarCaducados = this.child("chkOcultarCaducados");
  _i.chkMostrarTodos = this.child("chkMostrarTodos");
  _i.tdbRecords = this.child("tableDBRecords");
  _i.tbnImprimir = this.child("toolButtonPrint");
  _i.filtroPrevio = this.cursor().mainFilter();

  connect(_i.chkOcultarCaducados, "clicked()", _i, "filtrarLotes()");
  connect(_i.chkMostrarTodos, "clicked()", _i, "filtrarLotes()");
  connect(_i.tbnImprimir, "clicked()", _i, "imprimir()");

  _i.filtrarLotes();
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_filtrarLotes()
{
  var _i = this.iface;
  var cursor = this.cursor();
  var filtro = _i.filtroPrevio;

  if (!_i.chkMostrarTodos.checked) {
    if (filtro && filtro != "") {
      filtro += " AND "
    }
              filtro += "enalmacen > 0";
  }

  if (this.iface.chkOcultarCaducados.checked) {
    if (filtro && filtro != "") {
      filtro += " AND "
    }
              filtro += "(caducidad IS NULL OR caducidad > CURRENT_DATE)";
  }

  cursor.setMainFilter(filtro);
  debug("filtro " + filtro);
  _i.tdbRecords.refresh();
}


/** \C
Al pulsar el botón imprimir se lanzará el informe correspondiente a la factura seleccionada (en caso de que el módulo de informes esté cargado)
\end */
function oficial_imprimir()
{
  if (sys.isLoadedModule("flfactinfo")) {
    var util: FLUtil = new FLUtil;
    var codLote: String = this.cursor().valueBuffer("codlote");

    var curImprimir: FLSqlCursor = new FLSqlCursor("i_movilote");
    curImprimir.setModeAccess(curImprimir.Insert);
    curImprimir.refreshBuffer();
    curImprimir.setValueBuffer("descripcion", "temp");
    curImprimir.setValueBuffer("i_lotes_codlote", codLote);
    flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_movilote");
  } else
    flfactppal.iface.pub_msgNoDisponible("Informes");
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
