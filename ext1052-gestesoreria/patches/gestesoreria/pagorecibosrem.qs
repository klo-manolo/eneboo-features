/**************************************************************************
                 pagorecibosrem.qs  -  description
                             -------------------
    begin                : mie nov 09 2011
    copyright            : (C) 2006 by InfoSiAL S.L.
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
    function validateForm():Boolean { return this.ctx.interna_validateForm(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
    var tdbRecibos:Object;
    var tdbRecibosSel:Object;
    var pbnGenerar:Object;
    function oficial( context ) { interna( context ); } 
    function refrescarTablas() {
        return this.ctx.oficial_refrescarTablas();
    }
    function filtroRecibos():String {
        return this.ctx.oficial_filtroRecibos();
    }
    function bufferChanged(fN:String) {
        return this.ctx.oficial_bufferChanged(fN);
    }
    function seleccionar() {
        return this.ctx.oficial_seleccionar();
    }
    function quitar() {
        return this.ctx.oficial_quitar();
    }
    function tbnTodos_clicked() {
        return this.ctx.oficial_tbnTodos_clicked();
    }
    function tbnNinguno_clicked() {
        return this.ctx.oficial_tbnNinguno_clicked();
    }
    function tbnTodosSel_clicked() {
        return this.ctx.oficial_tbnTodosSel_clicked();
    }
    function tbnNingunoSel_clicked() {
        return this.ctx.oficial_tbnNingunoSel_clicked();
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
/** \C
Este formulario muestra una lista de recibos de cliente que cumplen un determinado filtro, y permite al usuario seleccionar uno o más recibos de la lista
\end */
function interna_init()
{
    this.child("pushButtonAcceptContinue").close();
    this.child("pushButtonNext").close();
    this.child("pushButtonPrevious").close();
    this.child("pushButtonFirst").close();
    this.child("pushButtonLast").close();
    
    this.iface.tdbRecibos = this.child("tdbRecibos");
    this.iface.tdbRecibosSel = this.child("tdbRecibosSel");
    
    this.iface.tdbRecibos.setReadOnly(true);
    this.iface.tdbRecibosSel.setReadOnly(true);
    
    this.iface.pbnGenerar = this.child("pbnGenerar");
    
    connect(this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged");
    connect(this.iface.tdbRecibos.cursor(), "recordChoosed()", this, "iface.seleccionar()");
    connect(this.iface.tdbRecibosSel.cursor(), "recordChoosed()", this, "iface.quitar()");
    connect(this.child("tbnSeleccionar"), "clicked()", this, "iface.seleccionar()");
    connect(this.child("tbnQuitar"), "clicked()", this, "iface.quitar()");
    connect(this.child("tbnTodos"), "clicked()", this, "iface.tbnTodos_clicked()");
    connect(this.child("tbnNinguno"), "clicked()", this, "iface.tbnNinguno_clicked()");
    connect(this.child("tbnTodosSel"), "clicked()", this, "iface.tbnTodosSel_clicked()");
    connect(this.child("tbnNingunoSel"), "clicked()", this, "iface.tbnNingunoSel_clicked()");
    
    this.iface.refrescarTablas();
    
}

/** \C
Si el tipo de registro a generar es anticipo, el campo documento es obligatorio
\end */

function interna_validateForm():Boolean
{

    return true;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Refresca las tablas, en función del filtro y de los recibos seleccionados hasta el momento
*/
function oficial_refrescarTablas()
{
    var recibos:String = this.cursor().valueBuffer("recibos");
    var filtro:String = this.iface.filtroRecibos();

    if (!recibos || recibos == "") {
        this.iface.tdbRecibos.cursor().setMainFilter("idrecibo IN(" + filtro + ")");
        this.iface.tdbRecibosSel.cursor().setMainFilter("1 = 2");
    } else {
        this.iface.tdbRecibos.cursor().setMainFilter("idrecibo IN(" + filtro + ") AND idrecibo NOT IN (" + recibos + ")");
        this.iface.tdbRecibosSel.cursor().setMainFilter("idrecibo IN (" + recibos + ")");
    }
    
    this.iface.tdbRecibos.refresh();
    this.iface.tdbRecibosSel.refresh();
}

function oficial_filtroRecibos():String{
    
    var cursor:FLSqlCursor = this.cursor();
    var where:String = "r.fechav <= '"+cursor.valueBuffer("fechafiltro")+"' AND m.cerrada = true";
    
    if (cursor.valueBuffer("idremesa")) {
        where += " AND m.idremesa = "+cursor.valueBuffer("idremesa");
    }
    
    if (cursor.valueBuffer("codcliente")) {
        where += " AND r.codcliente = '"+cursor.valueBuffer("codcliente")+"'";
    }

    var qryRecibos:FLSqlQuery = new FLSqlQuery();
    qryRecibos.setTablesList("reciboscli,remesas,reciboscliremesa");
    qryRecibos.setSelect("r.idrecibo");
    qryRecibos.setFrom("reciboscli r INNER JOIN reciboscliremesa rm ON r.idrecibo = rm.idrecibo INNER JOIN remesas m ON m.idremesa = rm.idremesa AND (m.tipoconta='200' OR m.tipoconta='300') AND m.idremesa = r.idremesa");
    qryRecibos.setWhere(where);
    //debug("qryRecibosRem>>> "+qryRecibos.sql());
    if (!qryRecibos.exec()){
        return "";
    }
    
    var filtrados:String = "-1";
    while (qryRecibos.next()){
        if (filtrados) filtrados += ",";
        filtrados += qryRecibos.value("r.idrecibo");
    }
    
    return filtrados;

}

function oficial_bufferChanged(fN:String)
{
    var util:FLUtil = new FLUtil();
    var cursor:FLSqlCursor = this.cursor();
    switch (fN) {
        case "idremesa":
        case "codcliente":
        case "fechafiltro":
            var valor = cursor.valueBuffer(fN);
            if (!valor) break;
            this.iface.refrescarTablas();
            break;
    }
}

/** \D Incluye un recibo en la lista de recibos
*/
function oficial_seleccionar()
{
    var cursor:FLSqlCursor = this.cursor();
    var recibos:String = cursor.valueBuffer("recibos");

    var aRecibos:Array = this.iface.tdbRecibos.primarysKeysChecked();
    if (aRecibos && aRecibos.length > 0) {
        var listaRecibos:String = aRecibos.join(",");
        if (!recibos || recibos == "") {
            recibos = listaRecibos;
        } else {
            recibos += "," + listaRecibos;
        }
        for (var i:Number = 0; i < aRecibos.length; i++) {
            this.iface.tdbRecibos.setPrimaryKeyChecked(aRecibos[i], false);
        }
    }

    cursor.setValueBuffer("recibos", recibos);
        
    this.iface.refrescarTablas();
}

/** \D Quita un recibo de la lista de recibos
*/
function oficial_quitar()
{
    var cursor:FLSqlCursor = this.cursor();
    var recibos:String = cursor.valueBuffer("recibos");

    if (!recibos || recibos == "") {
            return;
    }
    var recibos:Array = recibos.split(",");
    var aRecibos:Array = this.iface.tdbRecibosSel.primarysKeysChecked();
    if (!aRecibos || aRecibos.length == 0) {
            return;
    }
    var recibosNuevos:String = "";
    
    var quitar:Boolean;
    for (var i:Number = 0; i < recibos.length; i++) {
        quitar = false;
        for (var iRecibo:Number = 0; iRecibo < aRecibos.length; iRecibo++) {
            if (recibos[i] == aRecibos[iRecibo]) {
                    quitar = true;
                    break;
            }
        }
        if (quitar) {
            this.iface.tdbRecibosSel.setPrimaryKeyChecked(recibos[i], false);
            continue;
        }
        if (recibosNuevos == "") {
            recibosNuevos = recibos[i];
        } else {
            recibosNuevos += "," + recibos[i];
        }
    }
    cursor.setValueBuffer("recibos", recibosNuevos);

    this.iface.refrescarTablas();
    
}


function oficial_tbnTodos_clicked()
{
    var filtro:String = this.iface.tdbRecibos.cursor().mainFilter();
    if (!filtro || filtro == "") {
            return;
    }
    
    var qryRecibos:FLSqlQuery = new FLSqlQuery();
    qryRecibos.setTablesList("reciboscli");
    qryRecibos.setSelect("idrecibo");
    qryRecibos.setFrom("reciboscli");
    qryRecibos.setWhere(filtro);
    qryRecibos.setForwardOnly(true);
    if (!qryRecibos.exec()) {
            return false;
    }
    
    while (qryRecibos.next()) {
        this.iface.tdbRecibos.setPrimaryKeyChecked(qryRecibos.value("idrecibo"), true);
    }
    
    this.iface.tdbRecibos.refresh();
}

/** \D Elimina la selección de todos los recibos de la tabla superior
\end */
function oficial_tbnNinguno_clicked()
{
    this.iface.tdbRecibos.clearChecked();
    this.iface.tdbRecibos.refresh();
}
/** \D Selecciona todos los recibos de la tabla inferior
\end */
function oficial_tbnTodosSel_clicked()
{
    var filtro:String = this.iface.tdbRecibosSel.cursor().mainFilter();
    if (!filtro || filtro == "") {
            return;
    }
    
    var qryRecibos:FLSqlQuery = new FLSqlQuery();
    qryRecibos.setTablesList("reciboscli");
    qryRecibos.setSelect("idrecibo");
    qryRecibos.setFrom("reciboscli");
    qryRecibos.setWhere(filtro);
    qryRecibos.setForwardOnly(true);
    if (!qryRecibos.exec()) {
        return false;
    }
    
    while (qryRecibos.next()) {
        this.iface.tdbRecibosSel.setPrimaryKeyChecked(qryRecibos.value("idrecibo"), true);
    }
    
    this.iface.tdbRecibosSel.refresh();
}
/** \D Elimina la selección de todos los recibos de la tabla inferior
\end */
function oficial_tbnNingunoSel_clicked()
{
    this.iface.tdbRecibosSel.clearChecked();
    this.iface.tdbRecibosSel.refresh();
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
