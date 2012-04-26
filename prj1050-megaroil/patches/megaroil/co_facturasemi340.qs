/***************************************************************************
                 co_facturasemi340.qs  -  description
                             -------------------
    begin                : mie ene 25 2012
    copyright            : (C) 2005 by InfoSiAL S.L.
    email                : info@gestiweb.com
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
    function oficial( context ) { interna( context ); }
    function bufferChanged(fN:String) {
        return this.ctx.oficial_bufferChanged(fN);
    }
    function mostrarDesSituacion() {
        return this.ctx.oficial_mostrarDesSituacion();
    }
    function validarAlquileres(cursor:FLSqlCursor):Boolean {
        return this.ctx.oficial_validarAlquileres(cursor);
    }
    function validarSubvenciones(cursor:FLSqlCursor):Boolean { 
        return this.ctx.oficial_validarSubvenciones(cursor);
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
/** \C El ejercicio por defecto al crear un nuevo modelo es el ejercicio marcado como actual en el formulario de empresa
\end */
function interna_init() 
{
    var cursor:FLSqlCursor = this.cursor();
    connect (cursor, "bufferChanged(QString)", this, "iface.bufferChanged");

    this.iface.mostrarDesSituacion();
}

function interna_validateForm():Boolean
{
    var cursor:FLSqlCursor = this.cursor();

    if (!this.iface.validarAlquileres(cursor)){
        return false;
    }
    
    if (!this.iface.validarSubvenciones(cursor)){
        return false;
    }
    
    return true;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_bufferChanged(fN:String)
{
    switch (fN) {
            case "situacioninmueble": {
                    this.iface.mostrarDesSituacion();
                    break;
            }
    }
}

function oficial_mostrarDesSituacion()
{
    var util:FLUtil = new FLUtil;
    var cursor:FLSqlCursor = this.cursor();

    var situacion:String = cursor.valueBuffer("situacioninmueble");
    var texto:String;
    switch (situacion) {
            case "1": {
                    texto = util.translate("scripts", "Inmueble con referencia catastral situado en cualquier punto del territorio español, excepto País Vasco y Navarra.");
                    break;
            }
            case "2": {
                    texto = util.translate("scripts", "Inmueble situado en la Comunidad Autónoma del País Vasco o en la Comunidad Foral de Navarra.");
                    break;
            }
            case "3": {
                    texto = util.translate("scripts", "Inmueble en cualquiera de las situaciones anteriores pero sin referencia catastral.");
                    break;
            }
            case "4": {
                    texto = util.translate("scripts", "Inmueble situado en el extranjero.");
                    break;
            }
    }
    this.child("lblSituacion").text = texto;
}

function oficial_validarAlquileres(cursor:FLSqlCursor):Boolean {

    if (cursor.valueBuffer("operacion") == "R" && (cursor.isNull("situacioninmueble") || cursor.valueBuffer("situacioninmueble") == " " || cursor.isNull("refcatastral") || cursor.valueBuffer("refcatastral") == "")) {
        MessageBox.warning("Las operaciones con clave R, tienen como obligatorios consignar los campos:\n- Situación\n- Referencia catastral",MessageBox.Ok,MessageBox.NoButton);
        return false;
    }
    return true;
}

function oficial_validarSubvenciones(cursor:FLSqlCursor):Boolean {
    
    if (cursor.valueBuffer("operacion") == "S") {
        if (!cursor.isNull("baseimponible") || cursor.valueBuffer("tipoimpositivo") != 0 || cursor.valueBuffer("cuotaimpuesto") != 0 || !cursor.isNull("baseimponiblecoste")){
            MessageBox.warning("Las operaciones con clave S, Han de tener las siguientes características:\nNo cumplimentar el campo Base Imponible\nLos valores de Tipo Impositivo y Cuota han de cumplimentarse a 0\nNo cumplimentar el campo Base Imponible a Coste",MessageBox.Ok,MessageBox.NoButton);
            return false;
        }
    }
    return true;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
