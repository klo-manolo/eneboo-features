/***************************************************************************
                 calcunecesidades.qs  -  description
                             -------------------
    begin                : mie jun 18 2007
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
class interna {
    var ctx:Object;
    function interna( context ) { this.ctx = context; }
    function init() { this.ctx.interna_init(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var datosStock:Array;
	var NB:Number = 0;
	var D:Number = 1;
	var RP:Number = 2;
	var SS:Number = 3;
	var NN:Number = 4;
	var RPP:Number = 5;
	var LPP:Number = 6;

	var currentRow_:Number;
    function oficial( context ) { interna( context ); } 
	function tblCalculo_currentChanged(row:Number, col:Number) {
		return this.ctx.oficial_tblCalculo_currentChanged(row, col);
	}
	function calcular():Boolean {
		return this.ctx.oficial_calcular();
	}
	function informarTabla() {
		return this.ctx.oficial_informarTabla();
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
/** \C
Este formulario agrupa distintos pedidos del mismo proveedor un único albarán. Es posible especificar los criterios que deben cumplir los pedidos a incluir. De la lista de pedidos que cumplen los criterios de búsqueda se generará un albarán por proveedor (ej. si los pedidos corresponden a dos proveedores se generarán dos albaranes).
\end */
function interna_init()
{
	var util:FLUtil = new FLUtil();
	var tblCalculo:QTable = this.child("tblCalculo");
	var cursor:FLSqlCursor = this.cursor();

	connect(tblCalculo, "currentChanged(int, int)", this, "iface.tblCalculo_currentChanged");

	var hoy:Date = new Date;
debug(1);
	this.iface.datosStock = formSearchroturastock.iface.pub_datosEvolStockActual();
	if (!this.iface.datosStock) {
debug(2);
		var codAlmacen:String = cursor.valueBuffer("codalmacen");
		if (!codAlmacen || codAlmacen == "")
			return false;
debug(codAlmacen);
		var referencia:String = cursor.valueBuffer("referencia");
		if (!referencia || referencia == "")
			return false;
debug(referencia);
		var idStock:String = util.sqlSelect("stocks", "idstock", "codalmacen = '" + codAlmacen + "' AND referencia = '" + referencia + "'");
debug(idStock);
		if(!idStock)
			return false;
debug(5);
		this.iface.datosStock = flfactalma.iface.pub_datosEvolStock(idStock, hoy.toString(), true);
debug(this.iface.datosStock);
		if (!this.iface.datosStock)
			return false;
debug(6);
	}
debug(this.iface.datosStock.length);
	/*
	this.iface.datosStock = flfactalma.iface.pub_datosEvolStock(false, cursor.valueBuffer("referencia"), cursor.valueBuffer("codalmacen"), hoy.toString());
	if (!this.iface.datosStock)
		this.close();
		
	this.iface.calcular();
	*/

	tblCalculo.setNumCols(this.iface.datosStock.length + 1);
	var cabecera:String = " ";
	var fecha:Date;
	tblCalculo.setColumnWidth(0, 250);
	for (var i:Number = 0; i < this.iface.datosStock.length; i++) {
		tblCalculo.setColumnWidth(i + 1, 45);
		fecha = this.iface.datosStock[i]["fecha"].toString();
		cabecera += "/" + fecha.substring(8, 10) + "-" + fecha.substring(5, 7);
	}
	tblCalculo.setColumnLabels("/", cabecera);

	this.iface.informarTabla();
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_tblCalculo_currentChanged(row:Number, col:Number)
{
	this.iface.currentRow_ = row;
}

function oficial_calcular():Boolean
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var plazo:Number = parseFloat(util.sqlSelect("articulosprov", "plazo", "referencia = '" + cursor.valueBuffer("referencia") + "' AND pordefecto = true"));
	if (!plazo || isNaN(plazo))
		plazo = 0;

	this.iface.datosStock = flfactalma.iface.pub_planificarPedStock(this.iface.datosStock, plazo)
	if (!this.iface.datosStock)
		return false;

	return true;
}

function oficial_informarTabla()
{
	var util:FLUtil = new FLUtil;
	var tblCalculo:QTable = this.child("tblCalculo");
	tblCalculo.insertRows(0, 7);

	tblCalculo.setText(this.iface.NB, 0, util.translate("scripts", "Necesidades brutas (NB)"));
	for (var i:Number = 0; i < this.iface.datosStock.length; i++) {
		if (this.iface.datosStock[i]["NB"] != 0)
			tblCalculo.setText(this.iface.NB, i + 1, this.iface.datosStock[i]["NB"]);
	}
	tblCalculo.setText(this.iface.D, 0, util.translate("scripts", "Disponibilidades (D)"));
	for (var i:Number = 0; i < this.iface.datosStock.length; i++) {
		if (this.iface.datosStock[i]["D"] != 0)
			tblCalculo.setText(this.iface.D, i + 1, this.iface.datosStock[i]["D"]);
	}
	tblCalculo.setText(this.iface.RP, 0, util.translate("scripts", "Recepciones programadas (RP)"));
	for (var i:Number = 0; i < this.iface.datosStock.length; i++) {
		if (this.iface.datosStock[i]["RP"] != 0)
			tblCalculo.setText(this.iface.RP, i + 1, this.iface.datosStock[i]["RP"]);
	}
	tblCalculo.setText(this.iface.SS, 0, util.translate("scripts", "Stock de seguridad (SS)"));
	for (var i:Number = 0; i < this.iface.datosStock.length; i++) {
		if (this.iface.datosStock[i]["SS"] != 0)
			tblCalculo.setText(this.iface.SS, i + 1, this.iface.datosStock[i]["SS"]);
	}
	tblCalculo.setText(this.iface.NN, 0, util.translate("scripts", "Necesidades netas (NN)"));
	for (var i:Number = 0; i < this.iface.datosStock.length; i++) {
		if (this.iface.datosStock[i]["NN"] != 0)
			tblCalculo.setText(this.iface.NN, i + 1, this.iface.datosStock[i]["NN"]);
	}
	tblCalculo.setText(this.iface.RPP, 0, util.translate("scripts", "Recepción pedidos planif. (RPP)"));
	for (var i:Number = 0; i < this.iface.datosStock.length; i++) {
		if (this.iface.datosStock[i]["RPP"] != 0)
			tblCalculo.setText(this.iface.RPP, i + 1, this.iface.datosStock[i]["RPP"]);
	}
	tblCalculo.setText(this.iface.LPP, 0, util.translate("scripts", "Lanzamiento pedidos planif. (LPP)"));
	for (var i:Number = 0; i < this.iface.datosStock.length; i++) {
		if (this.iface.datosStock[i]["LPP"] != 0)
			tblCalculo.setText(this.iface.LPP, i + 1, this.iface.datosStock[i]["LPP"]);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
