/***************************************************************************
                 artículoslp.qs  -  description
                             -------------------
    begin                : martes abr 01 2008
    copyright            : (C) 2008 by KLO Ingeniería Informática S.L.L.
    email                : software@klo.es
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
class interna {
    var ctx:Object;
    function interna( context ) { this.ctx = context; }
    function init() { this.ctx.interna_init(); }
    function bufferChanged(fN:String) { return this.ctx.interna_bufferChanged(fN); }
    function calculateField(fN:String):String { return this.ctx.interna_calculateField(fN); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	function oficial( context ) { interna( context ); } 
	function calcularTotalAlbaranado() {
		return this.ctx.oficial_calcularTotalAlbaranado();
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial {
    function head( context ) { oficial ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
}

const iface = new ifaceCtx( this );
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
	var cursor:FLSqlCursor = this.cursor();

	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	
	this.iface.calcularTotalAlbaranado();
	this.iface.calculateField("pvpconiva");
}

function interna_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();

	switch (fN) {
		case "pvp": {
			this.iface.calculateField("pvpconiva");
			break;
		}
	}
}

function interna_calculateField(fN:String):String
{
	var hoy:Date = new Date();
	if (fN == "pvpconiva") {
		var cursor:FLSqlCursor = this.cursor();
		var util:FLUtil = new FLUtil();
		var codImpuesto:Number = util.sqlSelect("articulos", "codimpuesto", "referencia = '" + cursor.valueBuffer("referencia") + "'");
		var iva:Number = flfacturac.iface.pub_campoImpuesto("iva", codImpuesto, util.dateAMDtoDMA(hoy));
		
		var pvpConIva:Number = ((iva/100)*cursor.valueBuffer("pvp"))+parseFloat(cursor.valueBuffer("pvp"));
		pvpConIva = util.roundFieldValue(pvpConIva, "articulos", "pvp");
		cursor.setValueBuffer("pvpconiva", pvpConIva);
	}
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//KLO////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_calcularTotalAlbaranado()
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil;
	var hoy:Date = new Date();
	var label:String = this.child("lblTotalAlbaranesConIva");
	var codImpuesto:Number = util.sqlSelect("articulos", "codimpuesto", "referencia = '" + cursor.valueBuffer("referencia") + "'");
	var iva:Number = flfacturac.iface.pub_campoImpuesto("iva", codImpuesto, util.dateAMDtoDMA(hoy));

	var totalUnidades:Number = util.sqlSelect("lineasalbaranescli l INNER JOIN albaranescli a ON l.idalbaran = a.idalbaran", "SUM(l.cantidad)", "l.referencia = '" + cursor.valueBuffer("referencia")+"'AND a.fecha = '"+cursor.valueBuffer("fecha")+"'", "lineasalbaranescli");
	var total:Number = util.sqlSelect("lineasalbaranescli l INNER JOIN albaranescli a ON l.idalbaran = a.idalbaran", "SUM(l.pvptotal)", "l.referencia = '" + cursor.valueBuffer("referencia")+"'AND a.fecha = '"+cursor.valueBuffer("fecha")+"'", "lineasalbaranescli");
	
	cursor.setValueBuffer("totalunidades", totalUnidades);
	cursor.setValueBuffer("totalalbaranes", total);
	
	var pvpConIva:Number = ((iva/100)*cursor.valueBuffer("totalalbaranes"))+parseFloat(cursor.valueBuffer("totalalbaranes"));
	pvpConIva = util.roundFieldValue(pvpConIva, "albaranescli", "total");
	label.setText(pvpConIva);
}
//// OFICIAL /////////////////////////////////////////////////////
//KLO///////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
