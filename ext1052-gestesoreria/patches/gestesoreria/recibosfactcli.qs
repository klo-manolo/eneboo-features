/***************************************************************************
                recibosfactcli.qs  -  description
                             -------------------
    begin                : jue nov 19 2009
    copyright            : (C) 2004 by InfoSiAL S.L.
                               gestiweb
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
     
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration recibosmanuales */
//////////////////////////////////////////////////////////////////
//// RECIBOSMANUALES /////////////////////////////////////////////
class recibosmanuales extends oficial {
 
    var delRecibos:Boolean;
    var idFacturaRel:String;
    var totalFra:Number;
    var tdbRecibos:Object;
    var cancelManual:Boolean;
    var lblEtiqueta:Object;
    var tdbRecibosCli:Object;
    
    function recibosmanuales( context ) { oficial( context ); }
    
    function init() { return this.ctx.recibosmanuales_init(); }
    
    function iniciarFormulario(){
        return this.ctx.recibosmanuales_iniciarFormulario();
    }
    
    function insertarRecibos(){
        return this.ctx.recibosmanuales_insertarRecibos();
    }
    
    function editarRecibos(){
        return this.ctx.recibosmanuales_editarRecibos();
    }
    
    function borrarRecibos(){
        return this.ctx.recibosmanuales_borrarRecibos();
    }
    
    function verRecibos(){
        return this.ctx.recibosmanuales_verRecibos();
    }
    
    function etiquetaRecibos(){
        return this.ctx.recibosmanuales_etiquetaRecibos();
    }

    function aceptarFormulario() { 
        return this.ctx.recibosmanuales_aceptarFormulario(); 
    }
    
    function cancelarFormulario() { 
        return this.ctx.recibosmanuales_cancelarFormulario(); 
    }
    
    function cerrarFormulario(){
        return this.ctx.recibosmanuales_cerrarFormulario();
    }
}
//// RECIBOSMANUALES //////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends recibosmanuales {
    function head( context ) { recibosmanuales ( context ); }
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
Este formulario gestiona los recibos de cliente relacionados a una factura
\end */

function interna_init() {

        return true;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial \end */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition recibosmanuales */
/////////////////////////////////////////////////////////////////
//// RECIBOSMANUALES ///////////////////////////////////////////
function recibosmanuales_init()
{
    
    var cursor:FLSqlCursor = this.cursor();
       
    this.iface.idFacturaRel = formfacturascli.iface.idFacturaCli;
    this.iface.delRecibos=false;
    this.iface.tdbRecibosCli = this.child("tdbRecibosCli");
    this.iface.tdbRecibosCli.setEditOnly(true);
    //this.child("pushButtonCancel").close();
    this.iface.cancelManual = false;
    this.iface.lblEtiqueta = this.child("lblRecibos");
    
    connect(this.child("toolButtomInsertRecibos"), "clicked()", this, "iface.insertarRecibos");
    connect(this.child("toolButtonEditRecibos"), "clicked()", this, "iface.editarRecibos");
    connect(this.child("toolButtonDeleteRecibos"), "clicked()", this, "iface.borrarRecibos");
    connect(this.child("toolButtonBrowseRecibos"), "clicked()", this, "iface.verRecibos");
    connect(formRecordreciboscli, "closed()", this, "iface.etiquetaRecibos");
    connect(this.child("pushButtonAccept"), "clicked()", this, "iface.aceptarFormulario");
    connect(this.child("pushButtonCancel"), "clicked()", this, "iface.cancelarFormulario");
    connect(form, "closed()",this, "iface.cerrarFormulario");
    this.iface.iniciarFormulario();
    this.iface.etiquetaRecibos();

}

function recibosmanuales_iniciarFormulario()
{   
    var cursor:FLSqlCursor = this.cursor();
    this.cursor().transaction(false);
    var curFacturasCli:FLSqlCursor = new FLSqlCursor("facturascli");
    curFacturasCli.select("idfactura = '" + this.iface.idFacturaRel +"'");
   
    var hayFra:Boolean = curFacturasCli.first();
    if (!hayFra) {
            MessageBox.warning("No es posible abrir el formulario",MessageBox.Ok, MessageBox.NoButton);
            return false;
    }
    
    curFacturasCli.setModeAccess(curFacturasCli.Browse);
    curFacturasCli.refreshBuffer();
    cursor.setValueBuffer("idfactura", curFacturasCli.valueBuffer("idfactura"));
    this.iface.totalFra = curFacturasCli.valueBuffer("total");
    
    this.child("fdbCodigo").setValue(curFacturasCli.valueBuffer("codigo"));
    this.child("fdbFecha").setValue(curFacturasCli.valueBuffer("fecha"));
    this.child("fdbNombreCliente").setValue(curFacturasCli.valueBuffer("nombrecliente"));
    this.child("fdbTotal").setValue(this.iface.totalFra);

    this.iface.tdbRecibosCli.cursor().setMainFilter("idfactura='"+this.iface.idFacturaRel+"'");
}

function recibosmanuales_insertarRecibos()
{   
    var curR:FLSqlCursor =  new FLSqlCursor("reciboscli");
    curR.insertRecord();
    
    this.iface.etiquetaRecibos();
    
}

function recibosmanuales_editarRecibos()
{    
    var curR:FLSqlCursor = this.iface.tdbRecibosCli.cursor();
    curR.editRecord();
    this.iface.etiquetaRecibos();
    
}

function recibosmanuales_borrarRecibos()
{    
    
    var ok = MessageBox.information("El registro activo será borrado. ¿Esta seguro?", MessageBox.Ok, MessageBox.Cancel);
    if (ok!=MessageBox.Ok) return;
    
    this.iface.delRecibos=true;
    var idRecibo = this.iface.tdbRecibosCli.cursor().valueBuffer("idrecibo");
    
    if (!formreciboscli.iface.borrarRecibosManuales(idRecibo)){
            MessageBox.information("No es posible eliminar el recibo",MessageBox.Ok, MessageBox.NoButton);
    }

    this.iface.etiquetaRecibos();
    
}

function recibosmanuales_verRecibos()
{    
    var curR:FLSqlCursor = this.iface.tdbRecibosCli.cursor();
    curR.browseRecord();
    
}

function recibosmanuales_etiquetaRecibos()
{    
    var util:FLUtil = new FLUtil();    
    
    var sumrecibos:Number = parseFloat(util.sqlSelect("reciboscli","sum(importe)","idfactura='"+this.iface.idFacturaRel+"'"));
    if (sumrecibos!=this.iface.totalFra)
        this.iface.lblEtiqueta.text="Precaución: la suma del importe de los recibos relacionados es diferente al total de la factura.";
    else
        this.iface.lblEtiqueta.text=" ";
        
    this.iface.tdbRecibosCli.refresh();

}

function recibosmanuales_aceptarFormulario()
{
    this.cursor().commit();
}

function recibosmanuales_cancelarFormulario()
{
    this.cursor().rollback();
}

function recibosmanuales_cerrarFormulario()
{
    formfacturascli.iface.idFacturaCli = "";
}
//// RECIBOSMANUALES /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////