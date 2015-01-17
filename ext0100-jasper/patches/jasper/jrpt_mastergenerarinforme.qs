/***************************************************************************
                 jrpt_mastergenerarinforme.qs  -  description
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
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
    function oficial( context ) { interna( context ); } 
		function lanzar() {
				return this.ctx.oficial_lanzar();
		}
		function obtenerOrden(nivel:Number, cursor:FLSqlCursor, tabla:String):String {
				return this.ctx.oficial_obtenerOrden(nivel, cursor, tabla);
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
		function pub_obtenerOrden(nivel:Number, cursor:FLSqlCursor, tabla:String):String {
				return this.obtenerOrden(nivel, cursor, tabla);
		}
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
		connect (this.child("toolButtonPrint"), "clicked()", this, "iface.lanzar()");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_lanzar()
{
    var util:FLUtil = new FLUtil();
    var cursor:FLSqlCursor = this.cursor();
    var seleccion:String = cursor.valueBuffer("codinforme");
    var nombre_generar:String = cursor.valueBuffer("nombre");
    if (!seleccion)
        return;
    var nombreInforme:String = seleccion;        
    var dialog:Dialog = new Dialog;
    dialog.okButtonText = util.translate("scripts","Aceptar");
    dialog.cancelButtonText = util.translate("scripts","Cancelar");
    var bgroup:GroupBox = new GroupBox;
    dialog.add(bgroup);
    
    var cursorModelos:FLSqlCursor = new FLSqlCursor("jrpt_modeloinforme");
    cursorModelos.select("codinforme = '"+seleccion+"' ORDER BY orden");
    var i:Number = 0;
    var lstRB:Array=[];
    var lstRBcod:Array=[];
    
    while (cursorModelos.next()) {
        var rB:Object;
        rB = new RadioButton;
        bgroup.add(rB);
        rB.text = cursorModelos.valueBuffer("descripcion");
        if( i == 0)
            rB.checked = true;
        else
            rB.checked = false;
        lstRB[i]=rB;
        lstRBcod[i]=cursorModelos.valueBuffer("nombre");
        i++;
        
        
    }        
    var numOpciones = i;
    var opcionElegida = -1;
    if (numOpciones==0)
    {
        MessageBox.information("No hay ningún modelo asociado a este informe. No se puede imprimir", MessageBox.Ok, MessageBox.NoButton);
        return;
    } 
    else if (numOpciones==1)
    {
        opcionElegida = 0;
    }
    else
    {
        if(!dialog.exec()) return;                                                                                  
        for (i=0;i<numOpciones;i++)
        {
            rB =  lstRB[i];
            if (rB.checked)
            {
                opcionElegida = i;
                break;
            }
        }
    }    
    var modelo = lstRBcod[opcionElegida];
    var qryConsulta:FLSqlQuery = new FLSqlQuery;
    qryConsulta.setTablesList("jrpt_generarinforme,jrpt_argumentoinforme,jrpt_argugenerarinforme");
    qryConsulta.setSelect("ai.nombre,ai.valordefecto, agi.valor, agi.valordefecto");
    qryConsulta.setFrom("jrpt_generarinforme gi INNER JOIN jrpt_argumentoinforme ai ON gi.codinforme = ai.codinforme " + 
                            "LEFT JOIN jrpt_argugenerarinforme agi ON ai.nombre = agi.nombreargumento");                            
    qryConsulta.setWhere("gi.nombre = '" + nombre_generar + "'");    
    if(!qryConsulta.exec()) {       
    
            return false;
    }
    
    var argumentos = "";    
    while (qryConsulta.next())
    {      

        if (qryConsulta.value("agi.valordefecto") == false)
        {
            argumentos += qryConsulta.value("ai.nombre")+"="+qryConsulta.value("agi.valor")+"\n";
        }
        else
        {
            argumentos += qryConsulta.value("ai.nombre")+"="+qryConsulta.value("ai.valordefecto")+"\n";
        }
        
    }     

    flfactinfo.iface.lanzarJRXML(nombreInforme,modelo,argumentos);
}


//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
