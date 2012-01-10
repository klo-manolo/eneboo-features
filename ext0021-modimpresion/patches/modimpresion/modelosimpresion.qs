/***************************************************************************
                 modelosimpresion.qs  -  description
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
    function init() { this.ctx.interna_init(); }
	function calculateCounter():String { return this.ctx.interna_calculateCounter(); }
	function validateForm():Boolean {
		return this.ctx.interna_validateForm();
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var tInternos:Array = [];
	function oficial( context ) { interna( context ); } 
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function cambiarReport():String { 
		return this.ctx.oficial_cambiarReport(); 
	}
	function cambiarConsulta():String { 
		return this.ctx.oficial_cambiarConsulta(); 
	}
	function cambiarModeloDefecto():Boolean { 
		return this.ctx.oficial_cambiarModeloDefecto();
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
	connect(this.child("pbnCambiarReport"), "clicked()", this, "iface.cambiarReport()");
	connect(this.child("pbnCambiarConsulta"), "clicked()", this, "iface.cambiarConsulta()");
	connect(this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged");
	
	this.child("fdbReport").setDisabled("true");
	this.child("fdbConsulta").setDisabled("true");
	
	this.iface.tInternos["Presupuesto de cliente"] = "presupuestoscli";
	this.iface.tInternos["Pedido de cliente"] = "pedidoscli";
	this.iface.tInternos["Albaran de cliente"] = "albaranescli";
	this.iface.tInternos["Factura de cliente"] = "facturascli";
	this.iface.tInternos["Recibo de cliente"] = "reciboscli";
	this.iface.tInternos["Pedido de proveedor"] = "pedidosprov";
	this.iface.tInternos["Albaran de proveedor"] = "albaranesprov";
	this.iface.tInternos["Factura de proveedor"] = "facturasprov";
	this.iface.tInternos["Recibo de proveedor"] = "recibosprov";
}

/** \D Calcula un nuevo código de modelo
\end */
function interna_calculateCounter()
{
	var util:FLUtil = new FLUtil();
	return util.nextCounter("codmodelo", this.cursor());	
}

function interna_validateForm():Boolean
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	
	var report:String = cursor.valueBuffer("report") + ".kut";
	if (!util.sqlSelect("flfiles", "nombre", "nombre = '" + report + "'")) {
		MessageBox.critical(util.translate("scripts", "El fichero de report no pertenece a niguno de los\n módulos cargados en la base de datos"), MessageBox.Ok);
		return false;
	}
	
	var consulta:String = cursor.valueBuffer("consulta");
	if (consulta && consulta != "") {
		consulta += ".qry";
		if (!util.sqlSelect("flfiles", "nombre", "nombre = '" + consulta + "'")) {
			MessageBox.critical(util.translate("scripts", "El fichero de consulta no pertenece a niguno de los\n módulos cargados en la base de datos"), MessageBox.Ok);
			return false;
		}
	}
	
	if (!this.iface.cambiarModeloDefecto()) {
		return false;
	}
	return true;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_cambiarModeloDefecto():Boolean
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	
	if (cursor.valueBuffer("modelodefecto")) {
		var tipoInterno:String = this.iface.tInternos[cursor.valueBuffer("tipo")];
		var codModelo:String = cursor.valueBuffer("codmodelo");
		if (!util.sqlUpdate("modelosimpresion", "modelodefecto", "false", "tipointerno = '" + tipoInterno + "' AND codmodelo <> '" + codModelo + "'")) {
			return false;
		}
	}
	return true;
}

/** \D Cambia el fichero .kut
\end */
function oficial_cambiarReport()
{
	var util:FLUtil = new FLUtil();
	
	var ruta:Object = new FLFormSearchDB("flfiles");
	var curFicheros:FLSqlCursor = ruta.cursor();
	var cursor:FLSqlCursor = this.cursor();
	
	curFicheros.setMainFilter("nombre LIKE '%.kut'");
	ruta.setMainWidget();
	var nombre:String = ruta.exec("nombre");

	if (!nombre) {
		return;
	}
	nombre = nombre.left(nombre.length - 4);
	this.child("fdbReport").setValue(nombre);
}

/** \D Cambia el fichero .qry
\end */
function oficial_cambiarConsulta()
{
	var util:FLUtil = new FLUtil();
	var ruta:Object = new FLFormSearchDB("flfiles");
	var curFicheros:FLSqlCursor = ruta.cursor();
	var cursor:FLSqlCursor = this.cursor();
	
	curFicheros.setMainFilter("nombre LIKE '%.qry'");
	ruta.setMainWidget();
	var nombre:String = ruta.exec("nombre");

	if (!nombre) {
		return;
	}
	nombre = nombre.left(nombre.length - 4);
	this.child("fdbConsulta").setValue(nombre);
}

/** \D Establece el tipo interno del reporte con la nomenclatura facturascli.kut
\end */
function oficial_establecerTipoInterno()
{
	
	var util:FLUtil = new FLUtil();
	var ruta:String = FileDialog.getOpenFileName("*.kut", util.translate("scripts","Elegir fichero de report"));
	
	if ( !File.exists( ruta ) ) {
		MessageBox.information( util.translate( "scripts", "Archivo inexistente" ),
								MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return;
	}
	var fichero = new File(ruta);
	this.child("fdbReport").setValue(fichero.baseName);
}

function oficial_bufferChanged(fN:String)
{
	var util:FLUtil = new FLUtil();
	switch (fN) {
		case "tipo":
			this.cursor().setValueBuffer("tipointerno", this.iface.tInternos[this.cursor().valueBuffer("tipo")]);
			debug(this.cursor().valueBuffer("tipointerno"));
			break;
	}
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
