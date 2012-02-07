/***************************************************************************
                 gastospmprov.qs  -  description
                             -------------------
    begin                : mar jul 19 2011
    copyright            : (C) 2007 by InfoSiAL S.L.
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

/** @ file */

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
    var ejercicioActual:String;
    var contabActivada:Boolean;
    var noGenAsiento:Boolean;
    var curRelacionado:FLSqlCursor;
    var divisaEmp:String;
    var bloqueoSubcuenta:Boolean;
    var longSubcuenta:Number;
    var posActualPuntoSubcuenta:Number;
    function oficial( context ) { interna( context ); }
    function bufferChanged(fN:String) {
        return this.ctx.oficial_bufferChanged(fN);
    }
    function importe_lostFocus(){
        return this.ctx.oficial_importe_lostFocus();
    }
    function formatearValor(vsinformato:String):String{
        return this.ctx.oficial_formatearValor(vsinformato);
    }
    function desconexion() {
        return this.ctx.oficial_desconexion();
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
/** \C El marco 'Asiento' se habilitará en caso de que esté cargado el módulo principal de contabilidad.
\end */
function interna_init()
{
    var util:FLUtil = new FLUtil();
    var cursor:FLSqlCursor = this.cursor();
    if (!this.iface.curRelacionado){
        this.iface.curRelacionado = cursor.cursorRelation();
    }
    this.iface.noGenAsiento = false;
     this.child("tdbPartidas").setReadOnly(true);

    this.iface.contabActivada = sys.isLoadedModule("flcontppal") && util.sqlSelect("empresa", "contintegrada", "1 = 1");
    this.iface.ejercicioActual = flfactppal.iface.pub_ejercicioActual();
    this.iface.longSubcuenta = util.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + this.iface.ejercicioActual + "'");
    this.child("fdbIdSubcuenta").setFilter("codejercicio = '" + this.iface.ejercicioActual + "'");
    this.iface.posActualPuntoSubcuenta = -1; 
    if (!this.iface.contabActivada) {
        this.child("gbxAsientos").SetEnabled(false);
        this.child("fdbIdSubcuenta").SetEnabled(false);
        this.child("fdbCodSubcuenta").SetEnabled(false);
    }
    
    this.iface.divisaEmp = util.sqlSelect("empresa","coddivisa","1 = 1");
    if (cursor.modeAccess() == cursor.Insert){
        this.child("fdbFecha").setValue(this.iface.curRelacionado.valueBuffer("fecha"));
        if (this.iface.divisaEmp) {
            this.child("fdbCoddivisa").setValue(this.iface.divisaEmp);
        }
        if (this.iface.contabActivada) {
            var idSD = this.iface.calculateField("idsubcuentadefecto");
            if (idSD && idSD!=0) {
                this.child("fdbIdSubcuenta").setValue(idSD);
            }
        }
    }
    
    connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
    connect(this.child("fdbImporte").editor(), "lostFocus()", this, "iface.importe_lostFocus");
    connect(form, "closed()", this, "iface.desconexion");
    
}

function interna_calculateField(fN:String):String
{
    var util:FLUtil = new FLUtil();
    var cursor:FLSqlCursor = this.cursor();
    var valor:String;
    switch (fN) {
        case "importeeuros":
            var importe:Number = parseFloat(cursor.valueBuffer("importe"));
            var tasaConv:Number = parseFloat(cursor.valueBuffer("tasaconv"));
            if (cursor.valueBuffer("coddivisa") == this.iface.divisaEmp && tasaConv == 1){
                valor = cursor.valueBuffer("importe");
            } else {
                valor = importe * tasaConv;
                valor = parseFloat(util.roundFieldValue(valor, "gastospmprov", "importeeuros"));
            }
            if (!valor) valor = 0;
            break;
        
        case "idsubcuenta":
            valor = 0;
            var codSubcuenta:String = cursor.valueBuffer("codsubcuenta").toString();
            if (codSubcuenta.length == this.iface.longSubcuenta){
                var idS = util.sqlSelect("co_subcuentas", "idsubcuenta","codsubcuenta = '" + codSubcuenta +"' AND codejercicio = '" +this.iface.ejercicioActual +"'");
                if (idS) valor = idS;
            }
            break;
                                
        case "idsubcuentadefecto":
            var idS = util.sqlSelect("co_subcuentas s INNER JOIN cuentasbanco c on c.codsubctacomision = s.codsubcuenta","s.idsubcuenta","s.codejercicio='"+this.iface.ejercicioActual+"' AND c.codcuenta = '"+this.iface.curRelacionado.valueBuffer("codcuenta")+"'","co_subcuentas,cuentasbanco");
            if (idS){
                valor = idS;
            }else {
                valor = 0;
            }
            break;
            
        default: {
                valor = false;
                break;
        }
    }
    return valor;
}

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_bufferChanged(fN:String)
{
    var util:FLUtil = new FLUtil();    
    var cursor:FLSqlCursor = this.cursor();
    switch (fN) {
        case "nogenerarasiento":
            this.child("gbxAsiento").setEnabled(cursor.valueBuffer("nogenerarasiento"));
            break;
        
        case "importe":
        case "tasaconv":
            this.child("fdbImporteEuros").setValue(this.iface.calculateField("importeeuros"));
        
        /** \C
        Si el usuario pulsa la tecla del punto '.', la subcuenta se informa automaticamente con el código de cuenta más tantos ceros como sea necesario para completar la longitud de subcuenta asociada al ejercicio actual.
        \end */
        case "codsubcuenta":
            if (!this.iface.bloqueoSubcuenta) {
                this.iface.bloqueoSubcuenta = true;
                this.iface.posActualPuntoSubcuenta = flcontppal.iface.pub_formatearCodSubcta(this, "fdbCodSubcuenta", this.iface.longSubcuenta, this.iface.posActualPuntoSubcuenta);
                this.iface.bloqueoSubcuenta = false;
            }
            if (!this.iface.bloqueoSubcuenta && this.child("fdbCodSubcuenta").value().length == this.iface.longSubcuenta) {
                var idS = this.iface.calculateField("idsubcuenta");
                if (idS && idS!= 0) {
                    this.child("fdbIdSubcuenta").setValue(idS);
                }
            }
            break;
        
        default: {
            break;
        }
    }
}

function oficial_importe_lostFocus(){
    
    var cursor = this.cursor();
    var vformat = this.iface.formatearValor(cursor.valueBuffer("importe"));
    this.child("fdbImporte").setValue(vformat);

}

function oficial_formatearValor(vsinformato:String):String{

    var util:FLUtil = new FLUtil();
    return util.formatoMiles(util.buildNumber(vsinformato, "f", 2));

}

function oficial_desconexion()
{
    disconnect(this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged");
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////

//// INTERFACE  /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
