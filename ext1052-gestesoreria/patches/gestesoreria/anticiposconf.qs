/***************************************************************************
                 anticiposconf.qs  -  description
                             -------------------
    begin                : vie ago 12 2011
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
    function validateForm() { 
        return this.ctx.interna_validateForm(); 
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
    function oficial( context ) { interna( context ); }
    function bufferChanged(fN:String) {
        return this.ctx.oficial_bufferChanged(fN);
    }
    function seleccionarRecibo() {
        return this.ctx.oficial_seleccionarRecibo();
    }
    function filtroRecibos():String{
        return this.ctx.oficial_filtroRecibos();
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
    Solo puede ejecutarse en modo insert desde el formulario relacionado de remesasprov
    Desde recibosprov la tabla anticiposconf es de solo lectura
    El formulario pagorecibosremprov también hace una inserción automática de registros en esta tabla
\end */
function interna_init()
{
    var util:FLUtil = new FLUtil();
    var cursor:FLSqlCursor = this.cursor();
    this.iface.curRelacionado = cursor.cursorRelation();
    
    this.iface.noGenAsiento = false;
     this.child("tdbPartidas").setReadOnly(true);

    this.iface.contabActivada = sys.isLoadedModule("flcontppal") && util.sqlSelect("empresa", "contintegrada", "1 = 1");
    if (!this.iface.contabActivada) {
        this.child("gbxAsientos").SetEnabled(false);
    }

    connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
    connect(this.child("pbnBuscarRecibo"), "clicked()", this, "iface.seleccionarRecibo");
    connect(form, "closed()", this, "iface.desconexion");
    
    if (cursor.modeAccess() == cursor.Browse){
        this.child("pbnBuscarRecibo").setDisabled(true);
    }
}

function interna_calculateField(fN:String):String
{
    var util:FLUtil = new FLUtil();
    var cursor:FLSqlCursor = this.cursor();
    var valor:String;
    switch (fN) {
        case "":
            break;
    }
    return valor;
}

function interna_validateForm():Boolean
{
    var cursor:FLSqlCursor = this.cursor();
    var util:FLUtil = new FLUtil();

     if (cursor.isNull("documento") || cursor.valueBuffer("documento") == "") {
        MessageBox.warning(util.translate("scripts", "Para generar un registro de Anticipo, es obligatorio indicar el documento"), MessageBox.Ok, MessageBox.NoButton);
        return false;
    }
        
    return true;
}
/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_bufferChanged(fN:String)
{
    var util:FLUtil = new FLUtil();    
    var cursor:FLSqlCursor = this.cursor();
    switch (fN) {
    }
}

function oficial_seleccionarRecibo()
{
    var util:FLUtil;

    var filtroRecibos:String = this.iface.filtroRecibos();
    debug("filtroRecibos="+filtroRecibos);
    var f:Object = new FLFormSearchDB("recibosprovsearch");
    var curRecibos:FLSqlCursor = f.cursor();
    curRecibos.setMainFilter("idrecibo IN("+filtroRecibos+")");
    f.setMainWidget();
    var idRecibo = f.exec("idrecibo");
    if (!idRecibo) {
        return false;
    }

    this.cursor().setValueBuffer("idrecibo",idRecibo);
}

function oficial_filtroRecibos():String{
    
    var idRecibos = formRecordremesasprov.iface.idRecibosRemesa(this.cursor().valueBuffer("idremesa"));
    if (!idRecibos || idRecibos =="-1"){
        MessageBox.warning("ocurrió un error leyendo la lista de recibos remesados");
        return "-1";
    }
    
    var qryRecibos:FLSqlQuery = new FLSqlQuery();
    qryRecibos.setTablesList("recibosprov,anticiposconf");
    qryRecibos.setSelect("r.idrecibo")
    qryRecibos.setFrom("recibosprov r left outer join anticiposconf a on r.idrecibo = a.idrecibo")
    qryRecibos.setWhere("r.idrecibo IN("+idRecibos+") AND a.idrecibo is null AND r.estado ='Remesado'");
    debug("qryRecibos="+qryRecibos.sql());
    if (!qryRecibos.exec()){
        MessageBox.warning("ocurrió un error leyendo la lista de recibos remesados");
        return "-1";
    }
    
    if (qryRecibos.size()<=0){
        return "-1";
    }else {
        var inRecibos:String = "";
        while (qryRecibos.next()){
            if (inRecibos) inRecibos += ",";
            inRecibos += qryRecibos.value("r.idrecibo");
        }
        return inRecibos;
    }
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
