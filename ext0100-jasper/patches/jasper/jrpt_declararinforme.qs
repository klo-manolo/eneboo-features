/***************************************************************************
                 fichatecnica_config.qs  -  description
                             -------------------
    begin                : vie jul 21 2006
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
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_declaration interna */
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
        var txtquery:String;
	function oficial( context ) { interna( context ); }

        function habilitarPorFiltro() {
                this.ctx.oficial_habilitarPorFiltro();
        }
        function soloLectura() {
                this.ctx.oficial_soloLectura();
        }     
        function establecerFichero() {
                return this.ctx.oficial_establecerFichero();
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

////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_definition interna */
//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////

function interna_init()
{
	connect(this.cursor(), "newBuffer()", this, "iface.habilitarPorFiltro");
        this.iface.habilitarPorFiltro();
        connect(this.cursor(), "newBuffer()", this, "iface.soloLectura");
        this.iface.soloLectura();
        connect(this.child("btnDescargar"), "clicked()", this, "iface.establecerFichero");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \C
Cambia el directorio local de Python para el usuario
\end */
function oficial_habilitarPorFiltro()
{
        if (!this.child("gbxArgumentos")) return; // Para evitar que se lance desde el master.
	var cursor:FLSqlCursor = this.cursor();
	
        var hide:Boolean = (cursor.valueBuffer("automatico") == true)
        var show:Boolean = !hide;

        this.child("gbxArgumentos").setHidden(hide);
        this.child("gbxPlantilla").setHidden(show);
        this.child("fdbSolicitaKut").setDisabled(show);
        this.child("fdbSolicitaJrxml").setDisabled(show);
        
        if (hide) 
        {
            this.iface.txtquery = "";
            var util:FLUtil = new FLUtil();  
            existeQry = util.sqlSelect("flfiles","nombre","nombre = '" + cursor.valueBuffer("codinforme") + ".qry'");            
            if (existeQry)
            {                
                var q:FLSqlQuery = new FLSqlQuery(cursor.valueBuffer("codinforme"));
                this.iface.txtquery = this.iface.txtquery + "SELECT " + q.select();
                this.iface.txtquery = this.iface.txtquery + " \nFROM " + q.from();
                var whereS: String = q.where();
                if (whereS && whereS!="") this.iface.txtquery = this.iface.txtquery + " \nWHERE " + whereS;
                else this.iface.txtquery = this.iface.txtquery + " \nWHERE 1=1";
                var orderbyS: String = q.orderBy();
                if (orderbyS && orderbyS!="") this.iface.txtquery = this.iface.txtquery + " \nORDER BY " +orderbyS;
                else this.iface.txtquery = this.iface.txtquery + " \nORDER BY 1";       
            }
            else
            {                
                this.iface.txtquery = this.iface.txtquery + "No existe una consulta para el report <" + cursor.valueBuffer("codinforme") + ">";                
            }                
            this.child("txtQuery").setText(this.iface.txtquery);
            if(!(util.sqlSelect("flfiles","nombre","nombre = '" + cursor.valueBuffer("codinforme") + ".jrxml'")))
            {        
                this.child("btnDescargar").setDisabled(true);
                this.child("fdbSolicitaJrxml").setDisabled(true);
            }        
            else
            {        
                this.child("btnDescargar").setDisabled(false);  
                this.child("fdbSolicitaJrxml").setDisabled(false);
            }
            if(!(util.sqlSelect("flfiles","nombre","nombre = '" + cursor.valueBuffer("codinforme") + ".kut'")))
            {
                this.child("fdbSolicitaKut").setDisabled(true);
            }
            else
            {
                this.child("fdbSolicitaKut").setDisabled(false);
            }                                                                     
        }
        
}


function oficial_soloLectura()
{    
        var cursor:FLSqlCursor = this.cursor();
        this.child("fdbTablejrpt_modeloinforme").setEditOnly(true);        
}

        

function oficial_establecerFichero()
{
        var cursor:FLSqlCursor = this.cursor();
        var util:FLUtil = new FLUtil();
        if(!(util.sqlSelect("flfiles","nombre","nombre = '" + cursor.valueBuffer("codinforme") + ".jrxml'")))
        {            
            MessageBox.information(util.translate( "scripts", "No Existe El Fichero" ), MessageBox.Ok, MessageBox.NoButton);
            return;            
        }     
        var descargar:String = FileDialog.getSaveFileName("*.*");              
        var file = new File(descargar);             
        file.open(File.WriteOnly);
        file.write(util.sqlSelect("flfiles","contenido","nombre = '" + cursor.valueBuffer("codinforme") + ".jrxml'"));
        file.close();                                
}


//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////



//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////




