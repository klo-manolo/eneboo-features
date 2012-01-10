/***************************************************************************
                 transferenciastock.qs  -  description
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
class interna {
    var ctx:Object;
    function interna( context ) { this.ctx = context; }
    function init() { return this.ctx.interna_init(); }
	function calculateField(fN:String):String { return this.ctx.interna_calculateField(fN); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var tbnArriba:Object;
	var tbnAbajo:Object;
	var pbnAceptar:Object;
	var modo:String;
    function oficial( context ) { interna( context ); } 
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function restarCantidad() {
		return this.ctx.oficial_restarCantidad();
	}
	function sumarCantidad(fN:String) {
		return this.ctx.oficial_sumarCantidad();
	}
	function transferir(cantidad:Number) {
		return this.ctx.oficial_transferir(cantidad);
	}
	function cambiarModo(nuevoModo:String) {
		return this.ctx.oficial_cambiarModo(nuevoModo);
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
	this.iface.tbnArriba = this.child("tbnArriba");
	this.iface.tbnAbajo = this.child("tbnAbajo");
	this.iface.pbnAceptar = this.child("pushButtonAccept");
	
	var cursor:FLSqlCursor = this.cursor();
	
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.iface.tbnArriba, "clicked()", this, "iface.sumarCantidad");
	connect(this.iface.tbnAbajo, "clicked()", this, "iface.restarCantidad");
	
	this.child("fdbCantidad").setValue(0);
	this.child("fdbCantidadActual1").setValue(this.iface.calculateField("cantidadactual1"));
	this.child("fdbCantidadNueva1").setValue(this.iface.calculateField("cantidadactual1"));
	this.child("fdbCodAlmacen2").setValue("");
	this.child("fdbCodAlmacen2").setFilter("codalmacen <> '" + this.child("fdbCodAlmacen1").value() + "'");
	this.iface.cambiarModo("buscando");
}

function interna_calculateField(fN:String):String
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var valor:String;
	switch(fN) {
		case "cantidadactual1": {
			valor = util.sqlSelect("stocks", "cantidad", "idstock = " + cursor.valueBuffer("idstock1"));
			break;
		}
		case "cantidadactual2": {
			valor = util.sqlSelect("stocks", "cantidad", "referencia = '" + cursor.valueBuffer("referencia") + "' AND codalmacen = '" + cursor.valueBuffer("codalmacen2") + "'");
			if (!valor)
				valor = 0;
			break;
		}
	}
	return valor;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();
	switch(fN) {
		case "codalmacen2": {
			this.child("fdbCantidadActual2").setValue(this.iface.calculateField("cantidadactual2"));
			this.iface.cambiarModo("buscando");
			break;
		}
		case "cantidad": {
			this.iface.cambiarModo("buscando");
			break;
		}
	}
}

/** \C Controla la habilitación del botón Aceptar para que sólo pueda realizarse la transferencia cuando los datos de cantidad y almacén estén establecidos y el usuario indique la dirección de la transferencia 
\end */
function oficial_cambiarModo(nuevoModo:String)
{
	this.iface.modo = nuevoModo;
	var cursor:FLSqlCursor = this.cursor();
	switch (this.iface.modo) {
		case "buscando": {
			this.child("pushButtonAccept").enabled = false;
			this.child("fdbCantidadNueva1").setValue(cursor.valueBuffer("cantidadactual1"));
			this.child("fdbCantidadNueva2").setValue(cursor.valueBuffer("cantidadactual2"));
			break;
		}
		case "transfiriendo": {
			this.child("pushButtonAccept").enabled = true;
			break;
		}
	}
}


	/** \D Suma la cantidad al almacén 1 (y la resta del 2)
\end */
function oficial_sumarCantidad()
{
	var cantidad:Number = parseFloat(this.cursor().valueBuffer("cantidad"));
	this.iface.transferir(cantidad);
}

/** \D Resta la cantidad del almacén 1 (y la suma al 2)
\end */
function oficial_restarCantidad()
{
	var cantidad:Number = parseFloat(this.cursor().valueBuffer("cantidad"));
	this.iface.transferir(cantidad * -1);
}

function oficial_transferir(cantidad:Number)
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	
	if (!util.sqlSelect("almacenes", "codalmacen", "codalmacen = '" + cursor.valueBuffer("codalmacen2") + "'"))
		return;
		
	if (cantidad == 0)
		return;
		
	this.iface.cambiarModo("transfiriendo");
	
	var cantNueva1:Number = parseFloat(cursor.valueBuffer("cantidadactual1")) + cantidad;
	var cantNueva2:Number = parseFloat(cursor.valueBuffer("cantidadactual2")) - cantidad;
	
	this.child("fdbCantidadNueva1").setValue(cantNueva1);
	this.child("fdbCantidadNueva2").setValue(cantNueva2);
}


//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
