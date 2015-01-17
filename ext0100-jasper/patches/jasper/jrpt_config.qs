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
        var barras:Number;       
	function interna( context ) { this.ctx = context; }
	function init() {
		this.ctx.interna_init();
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	function oficial( context ) { interna( context ); }
	function RutaServer() {
		return this.ctx.oficial_RutaServer();
	}
	function buscarVisor() {
		return this.ctx.oficial_buscarVisor();
	}
        function cambiarBarras() {
                return this.ctx.oficial_cambiarBarras();
        }
        function guardarConfiguracion(){
                return  this.ctx.oficial_guardarConfiguracion();
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
	var util:FLUtil = new FLUtil();
                      
        var informe:String = util.readSettingEntry("scripts/flfactinfo/RutaServer");
        if (informe) this.child("lblRutaServer").text = informe;
        
        var visor:String = util.readSettingEntry("scripts/flfactinfo/RutaVisor");
        if (visor) this.child("lblRutaVisor").text = visor;
        
        var cambio = util.readSettingEntry("scripts/flfactinfo/CambiarBarras");
        if (!cambio && isNaN(cambio)) this.iface.barras = 0;
        else this.iface.barras = cambio;
        
        if (this.iface.barras==1) this.child("cbnCambiarBarras").checked = true;
        else if (this.iface.barras==0) this.child("cbnCambiarBarras").checked = false;  

        connect( this.child( "pbnBuscar" ), "clicked()", this, "iface.RutaServer" );
	connect( this.child( "pbnVisorPdf" ), "clicked()", this, "iface.buscarVisor" );
        connect( this.child( "cbnCambiarBarras" ), "clicked()", this, "iface.cambiarBarras" );
        connect( this.child( "pbnGuardar" ), "clicked()", this, "iface.guardarConfiguracion" );
        
        this.child("pushButtonCancel").setHidden(true);
	
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \C
Cambia el directorio local de Python para el usuario
\end */
function oficial_RutaServer()
{
	var util:FLUtil = new FLUtil();
	var informe:String = FileDialog.getExistingDirectory("");
	if ( !File.isDir( informe ) ) 
        {            
		MessageBox.information(util.translate( "scripts", "Ruta errónea" ), MessageBox.Ok, MessageBox.NoButton);
		return;                
	}

	var ultimoCaracter:String = informe.substring(informe.length-1, informe.length);
	if(ultimoCaracter!="/") informe+="/";
	this.child("lblRutaServer").text = informe;
        	
}

function oficial_buscarVisor()
{
	var util:FLUtil = new FLUtil();
	var visor:String = FileDialog.getOpenFileName("*");
	
	if ( !File.isFile( visor ) ) {
		MessageBox.information(util.translate( "scripts", "Ruta errónea" ), MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	this.child("lblRutaVisor").text = visor;
	
}

function oficial_cambiarBarras()
{
        
        var util:FLUtil = new FLUtil();
        if (this.child( "cbnCambiarBarras" ).checked) {
            this.iface.barras =  1;
        }
        else {
            this.iface.barras = 0;
        }
        return true;
   
}

function oficial_guardarConfiguracion()
{       
        var util:FLUtil = new FLUtil();
        
        util.writeSettingEntry("scripts/flfactinfo/RutaServer", this.child("lblRutaServer").text);
        util.writeSettingEntry("scripts/flfactinfo/RutaVisor", this.child("lblRutaVisor").text);
        util.writeSettingEntry("scripts/flfactinfo/CambiarBarras",  this.iface.barras);
        
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////



//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
