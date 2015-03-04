/***************************************************************************
                 i_masterpagaresprov.qs  -  description
                             -------------------
    begin                : vie feb 01 2007
    copyright            : (C) 2007 by InfoSiAL S.L.
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
  function oficial(context)
  {
    interna(context);
  }
  function lanzar()
  {
    return this.ctx.oficial_lanzar();
  }
  function lugarFecha(nodo: FLDomNode, campo: String): String {
    return this.ctx.oficial_lugarFecha(nodo, campo);
  }
  function fechaEnTexto(fecha: Date): String {
    return this.ctx.oficial_fechaEnTexto(fecha);
  }
  function lineaNumImp(nodo: FLDomNode, campo: String): String {
    return this.ctx.oficial_lineaNumImp(nodo, campo);
  }
  function ibanCompleto(nodo: FLDomNode, campo: String): String {
    return this.ctx.oficial_ibanCompleto(nodo, campo);
  }
  function fechaTexto(nodo: FLDomNode, campo: String): String {
    return this.ctx.oficial_fechaTexto(nodo, campo);
  }
  function importeAsterisco(nodo: FLDomNode, campo: String): String {
    return this.ctx.oficial_importeAsterisco(nodo, campo);
  }
  function paraAbonar(nodo: FLDomNode, campo: String): String {
    return this.ctx.oficial_paraAbonar(nodo, campo);
  }
  function importeTexto(nodo: FLDomNode, campo: String): String {
    return this.ctx.oficial_importeTexto(nodo, campo);
  }
  function codCMC7(nodo: FLDomNode, campo: String): String {
    return this.ctx.oficial_codCMC7(nodo, campo);
  }
  function secuencia(nodo: FLDomNode, campo: String): String {
    return this.ctx.oficial_secuencia(nodo, campo);
  }
  function marcarImpresos(cursor: FLSqlCursor, nombreInforme: String): Boolean {
    return this.ctx.oficial_marcarImpresos(cursor, nombreInforme);
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
  var cursor: FLSqlCursor = this.cursor()
                            var seleccion: String = cursor.valueBuffer("id");
  if (!seleccion)
    return;
  var nombreInforme: String = cursor.action();

  var intervalo: Array = [];
  if (cursor.valueBuffer("codintervaloe")) {
    intervalo = flfactppal.iface.pub_calcularIntervalo(cursor.valueBuffer("codintervaloe"));
    cursor.setValueBuffer("d_pagaresprov_fecha", intervalo.desde);
    cursor.setValueBuffer("h_pagaresprov_fecha", intervalo.hasta);
  }
  if (cursor.valueBuffer("codintervalov")) {
    intervalo = flfactppal.iface.pub_calcularIntervalo(cursor.valueBuffer("codintervalov"));
    cursor.setValueBuffer("d_pagaresprov_fechav", intervalo.desde);
    cursor.setValueBuffer("h_pagaresprov_fechav", intervalo.hasta);
  }

  flfactinfo.iface.pub_lanzarInforme(cursor, nombreInforme);
  this.iface.marcarImpresos(cursor);
}

function oficial_marcarImpresos(cursor: FLSqlCursor, nombreInforme: String): Boolean {
  var qryPagares: FLSqlQuery = flfactinfo.iface.establecerConsulta(cursor, nombreInforme);
  var filtro: String = qryPagares.where();
  formpagaresprov.iface.pub_marcarImpreso(filtro);
}

function oficial_lugarFecha(nodo: FLDomNode, campo: String): String {
  var lugar: String = nodo.attributeValue("empresa.ciudad");
  var hoy: Date = new Date();
  return lugar + ", " + this.iface.fechaEnTexto(hoy);
}

function oficial_lineaNumImp(nodo: FLDomNode, campo: String): String {
  var util: FLUtil = new FLUtil;
  var secuencia: String = Math.round(nodo.attributeValue("pagaresprov.secuencia"));
  secuencia = flfactppal.iface.cerosIzquierda(secuencia, 7);
  var importe: String = nodo.attributeValue("pagaresprov.total");
  importe = util.roundFieldValue(importe, "pagaresprov", "total");
  importe = importe.replace(".", ",");
  var linea: String = util.translate("scripts", "Por la presente le adjuntamos pagaré nº %1 por importe de %2 Euros").arg(secuencia).arg(importe);
  return linea;
}

function oficial_ibanCompleto(nodo: FLDomNode, campo: String): String {
  var texto: String = nodo.attributeValue("cuentasbanco.iban") + " " + nodo.attributeValue("pagaresprov.ctaentidad") + " " + nodo.attributeValue("pagaresprov.ctaagencia") + " " + nodo.attributeValue("pagaresprov.dc") + nodo.attributeValue("pagaresprov.cuenta");
  return texto;
}

function oficial_fechaTexto(nodo: FLDomNode, campo: String): String {
  var texto: String = this.iface.fechaEnTexto(nodo.attributeValue(campo));
  return texto;
}

function oficial_importeAsterisco(nodo: FLDomNode, campo: String): String {
  var util: FLUtil = new FLUtil;
  var importe: String = nodo.attributeValue("pagaresprov.total");
  importe = util.roundFieldValue(importe, "pagaresprov", "total");
  importe = importe.replace(".", ",");
  return "***" + importe + "***";
}

function oficial_fechaEnTexto(f: Date): String {
  var fecha: Date = new Date(Date.parse(f.toString()));
  var indexToMonth = [ "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre" ];
  var indexToDay = [ "Uno", "Dos", "Tres", "Cuatro", "Cinco", "Seis", "Siete", "Ocho", "Nueve", "Diez", "Once", "Doce", "Trece", "Catorce", "Quince", "Dieciseis", "Diecisiete", "Dieciocho", "Diecinueve", "Veinte", "Veintiuno", "Veintidos", "Veintitres", "Veinticuatro", "Veinticinco", "Veintiseis", "Veintisiete", "Veintiocho", "Veintinueve", "Treinta", "Treinta y uno" ];
  var texto: String = indexToDay[fecha.getDate(fecha) - 1] + " de " + indexToMonth[ fecha.getMonth() - 1] + " de " + fecha.getYear();
  return texto;
}

function oficial_paraAbonar(nodo: FLDomNode, campo: String): String {
  var util: FLUtil = new FLUtil;
  var empresa: String = nodo.attributeValue("pagaresprov.nombreproveedor");
  var linea: String = util.translate("scripts", "%1 PARA ABONAR EN CUENTA").arg(empresa);
  return linea;
}

function oficial_importeTexto(nodo: FLDomNode, campo: String): String {
  var util: FLUtil = new FLUtil;
  var texto: String = "       " + util.enLetraMonedaEuro(nodo.attributeValue("pagaresprov.total"));
  for (var i: Number = 0; i < 15; i = i + 2)
    texto += " -";
  return texto;
}

function oficial_codCMC7(nodo: FLDomNode, campo: String): String {
  var util: FLUtil = new FLUtil;
  var secuencia: String = Math.round(nodo.attributeValue("pagaresprov.secuencia"));
  secuencia = flfactppal.iface.cerosIzquierda(secuencia, 7);

  var texto: String = "C" + secuencia + "E" + nodo.attributeValue("pagaresprov.ctaentidad") + "C  " + nodo.attributeValue("pagaresprov.ctaagencia") + "E " + nodo.attributeValue("pagaresprov.cuenta") + "B " + nodo.attributeValue("pagaresprov.prefijo") + "A";
  return texto;
}

function oficial_secuencia(nodo: FLDomNode, campo: String): String {
  var secuencia: String = Math.round(nodo.attributeValue("pagaresprov.secuencia"));
  secuencia = flfactppal.iface.cerosIzquierda(secuencia, 7);
  return secuencia;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
