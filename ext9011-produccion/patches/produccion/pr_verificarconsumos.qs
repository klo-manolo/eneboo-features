/***************************************************************************
                 pr_verificarconsumos.qs  -  description
                             -------------------
    begin                : mar oct 16 2007
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

/** \C
\end */
/** @class_declaration interna */
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna {
	var ctx:Object;
	var tbnCorregir:Object;
	function interna( context ) { this.ctx = context; }
	function init() {
		this.ctx.interna_init();
	}
	function calculateField(fN:String):String {
		return this.ctx.interna_calculateField(fN);
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	function oficial( context ) { interna( context ); }
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function corregirConsumo_clicked() {
		return this.ctx.oficial_corregirConsumo_clicked();
	}
	function corregirConsumo(idMovimiento:String):Boolean {
		return this.ctx.oficial_corregirConsumo(idMovimiento);
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
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	//this.child("tdbMoviStock").cursor().setAction("comsumoprod");

	this.iface.tbnCorregir = this.child("tbnCorregir");

	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.iface.tbnCorregir, "clicked()", this, "iface.corregirConsumo_clicked");
}

function interna_validateForm():Boolean
{
	return true;
}

function interna_calculateField(fN:String):String
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var valor:String;
	switch (fN) {
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
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	switch (fN) {
		case "x": {
			break;
		}
	}
}

function oficial_corregirConsumo_clicked()
{
	var util:FLUtil = new FLUtil;

	var curMS:FLSqlCursor = this.child("tdbMoviStock").cursor();
	var idMovimiento:String = curMS.valueBuffer("idmovimiento");
	if (!idMovimiento)
		return false;

	curMS.transaction(false);
	try {
		if (this.iface.corregirConsumo(idMovimiento))
			curMS.commit();
		else 
			curMS.rollback();
	} catch (e) {
		curMS.rollback();
		MessageBox.critical(util.translate("scripts", "Hubo un error al modificar el consumo: ") + e, MessageBox.Ok, MessageBox.NoButton);
	}
}

function oficial_corregirConsumo(idMovimiento:String):Boolean
{
	var util:FLUtil = new FLUtil;

	var f:Object = new FLFormSearchDB("consumoprod");
	var curConsumo:FLSqlCursor = f.cursor();

	curConsumo.select("idmovimiento = " + idMovimiento);
	if (!curConsumo.first())
		return false;
	curConsumo.setModeAccess(curConsumo.Edit);
	curConsumo.refreshBuffer();

	f.setMainWidget();
	var ok:String = f.exec("idmovimiento");
	
	if (!ok)
		return false;

	if (curConsumo.valueBuffer("cantidad") != curConsumo.valueBufferCopy("cantidad")) {
		var res:Number = MessageBox.information(util.translate("scripts", "¿Desea que en adelante se use esta cantidad (%1) para el consumo de %1 en esta tarea?").arg(curConsumo.valueBuffer("cantidad")).arg(curConsumo.valueBuffer("referencia")), MessageBox.No, MessageBox.Yes);
		if (res == MessageBox.Yes) {
			if (!util.sqlUpdate("articuloscomp", "cantidad", curConsumo.valueBuffer("cantidad"), "id = " + curConsumo.valueBuffer("idarticulocomp")))
				return false;
		}
	}
	if (!curConsumo.commitBuffer())
		return false;
	
	return true;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////