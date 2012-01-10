/***************************************************************************
                 jrpt_generarinforme.qs  -  description
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
    var tblArgumentos:Object;
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

    var COL_NOMBRE:Number;
    var COL_ALIAS:Number;
    var COL_VALOR:Number;
    var COL_XDEFECTO:Number;
    var COL_IDARG:Number;
 
    function oficial( context ) { interna( context ); } 
    
    function generarTabla() {
            return this.ctx.oficial_generarTabla();
    }
    
    function insertarLineatblArgumentos(qryArgumentos:FLSqlQuery, numLinea:Number):Boolean{
            return this.ctx.oficial_insertarLineatblArgumentos(qryArgumentos, numLinea);
    }
    
    function seleccionarFilaArgumentos(fila:Number, col:Number) {
                return this.ctx.oficial_seleccionarFilaArgumentos(fila, col);
    }
    
    function cambiarValor(fila:Number, col:Number) {
                return this.ctx.oficial_cambiarValor(fila, col);
    }
    
    function guardarValoresArgumentos():Boolean{
            return this.ctx.oficial_guardarValoresArgumentos();
    }
    function bufferChanged(fN:String) { this.ctx.oficial_bufferChanged(fN); }

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
        this.iface.tblArgumentos = this.child("tblArgumentos");
        connect(this.iface.tblArgumentos, "clicked(int, int)", this, "iface.seleccionarFilaArgumentos");
        connect(this.iface.tblArgumentos, "valueChanged(int, int)", this, "iface.cambiarValor");
    	connect(this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged");

        this.iface.generarTabla();
}

function interna_validateForm():Boolean
{
        var util:FLUtil = new FLUtil();
        var esAuto:Boolean = util.sqlSelect("jrpt_declararinforme","automatico","codinforme='"+this.cursor().valueBuffer("codinforme")+"'");

        if (esAuto==true){
                MessageBox.warning("Error, el informe seleccionado es automático de AbanQ.\nPor favor seleccione un codigo de informe Personalizado",MessageBox.Ok, MessageBox.NoButton);
                return false;
        }
        
        
        if (!this.iface.guardarValoresArgumentos()){
                return false;
        }
        
        return true;

}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_generarTabla()
{
        var util:FLUtil = new FLUtil();
        var cursor:FLSqlCursor = this.cursor();


        
        this.iface.COL_ALIAS = 0;
        this.iface.COL_VALOR = 1;
        this.iface.COL_XDEFECTO = 2;
        this.iface.COL_NOMBRE = 3;
        this.iface.COL_IDARG = 4;
        
        this.iface.tblArgumentos.setNumCols(5);
        this.iface.tblArgumentos.setColumnWidth(this.iface.COL_ALIAS, 200);
        this.iface.tblArgumentos.setColumnWidth(this.iface.COL_VALOR, 150);
        this.iface.tblArgumentos.setColumnWidth(this.iface.COL_XDEFECTO, 60);
        this.iface.tblArgumentos.setColumnWidth(this.iface.COL_NOMBRE, 0);
        this.iface.tblArgumentos.setColumnWidth(this.iface.COL_IDARG, 0);
        this.iface.tblArgumentos.setColumnLabels("/", "Alias/Valor/Defecto");
        this.iface.tblArgumentos.setColumnReadOnly(this.iface.COL_ALIAS, true);
        this.iface.tblArgumentos.setColumnReadOnly(this.iface.COL_VALOR, false);
        this.iface.tblArgumentos.setColumnReadOnly(this.iface.COL_XDEFECTO, true);
        this.iface.tblArgumentos.hideColumn(this.iface.COL_NOMBRE);
        this.iface.tblArgumentos.hideColumn(this.iface.COL_IDARG);

        try {
                this.iface.tblArgumentos.clear(); // Función disponible a partir de AbanQ 2.3
        } catch(e)      {
                var numFilas:Number = this.iface.tblArgumentos.numRows();
                for (var i:Number = (numFilas - 1); i >= 0; i--) {
                                this.iface.tblArgumentos.removeRow(i);
                }
        }

        var qryArgumentos:FLSqlQuery = new FLSqlQuery;
        qryArgumentos.setTablesList("jrpt_argumentoinforme,jrpt_argugenerarinforme");
        qryArgumentos.setSelect("i.nombre, i.alias, g.id, g.valor, g.valordefecto");
        qryArgumentos.setFrom("jrpt_argumentoinforme i " 
                    + " LEFT OUTER JOIN jrpt_generarinforme gi ON gi.codinforme = i.codinforme "
                    + " LEFT OUTER JOIN jrpt_argugenerarinforme g ON i.nombre = g.nombreargumento AND gi.nombre = g.nombreinforme "
                    
                    );
        qryArgumentos.setWhere("i.codinforme ='"+cursor.valueBuffer("codinforme")+"'");

        if (!qryArgumentos.exec()) {
                return false;
        }
        var n:Number=0;
        util.createProgressDialog("Cargando Argumentos", qryArgumentos.size());
        this.iface.tblArgumentos.insertRows(0, qryArgumentos.size());
        while (qryArgumentos.next()) {
                util.setProgress(n);
                if (!this.iface.insertarLineatblArgumentos(qryArgumentos, n)) {
                        return false;
                }
                n++;
        }
        util.destroyProgressDialog();
}

function oficial_insertarLineatblArgumentos(qryArgumentos:FLSqlQuery, numLinea:Number):Boolean
{
        var util:FLUtil = new FLUtil;
        var porDefecto:String="X";
        
        if (qryArgumentos.value("g.id"))
        {
            if (qryArgumentos.value("g.valordefecto") == false) porDefecto="";
        }
        
        this.iface.tblArgumentos.setText(numLinea, this.iface.COL_NOMBRE, qryArgumentos.value("i.nombre"));
        if (qryArgumentos.value("i.alias"))
        {
        
            this.iface.tblArgumentos.setText(numLinea, this.iface.COL_ALIAS, qryArgumentos.value("i.alias"));
        
        }
        else 
        {
        
            this.iface.tblArgumentos.setText(numLinea, this.iface.COL_ALIAS, qryArgumentos.value("i.nombre"));
        
        }
        this.iface.tblArgumentos.setText(numLinea, this.iface.COL_VALOR, qryArgumentos.value("g.valor"));
        this.iface.tblArgumentos.setText(numLinea, this.iface.COL_XDEFECTO, porDefecto);
        this.iface.tblArgumentos.setText(numLinea, this.iface.COL_IDARG,  qryArgumentos.value("g.id"));
        return true;
}

function oficial_seleccionarFilaArgumentos(fila:Number, col:Number)
{
        if(col==this.iface.COL_ALIAS) return;
        if (this.iface.tblArgumentos.numRows() == 0) return;
               
        if (col == this.iface.COL_XDEFECTO){
                if (this.iface.tblArgumentos.text(fila, this.iface.COL_XDEFECTO) == "X")
                        this.iface.tblArgumentos.setText(fila, this.iface.COL_XDEFECTO, "");
                else{
                        this.iface.tblArgumentos.setText(fila, this.iface.COL_XDEFECTO, "X");
                        this.iface.tblArgumentos.setText(fila, this.iface.COL_VALOR, "");
                }
        }
 
}

function oficial_cambiarValor(fila:Number, col:Number)
{
        if (this.iface.tblArgumentos.numRows() == 0) return;
        if(col!=this.iface.COL_VALOR) return;
        
        var nuevoValor = this.iface.tblArgumentos.text(fila, col);
        if (nuevoValor!=""){
                this.iface.tblArgumentos.setText(fila, this.iface.COL_XDEFECTO, "");       
        }else{
                this.iface.tblArgumentos.setText(fila, this.iface.COL_XDEFECTO, "X");
        }
 
}

function oficial_guardarValoresArgumentos():Boolean{
                
        var curArgumentos:FLSqlCursor = new FLSqlCursor("jrpt_argugenerarinforme");
        var modo:Number;
        for(var fila=0;fila<this.iface.tblArgumentos.numRows();fila++){
                var idArg = parseFloat(this.iface.tblArgumentos.text(fila, this.iface.COL_IDARG));
                if (idArg && idArg!="") {
                        curArgumentos.setModeAccess(curArgumentos.Edit);
                        // curArgumentos.select("id = '"+idArG+"'");
                        curArgumentos.select("nombreinforme='" + this.cursor().valueBuffer("nombre") + "' AND nombreargumento='"+this.iface.tblArgumentos.text(fila, this.iface.COL_NOMBRE)+"'");
                        curArgumentos.refreshBuffer();
                        if (!curArgumentos.first())
                        {
                            // debug("¡¡No encontramos id = " + idArG + " !!");
                            debug("¡¡No encontramos nombreargumento = " + this.iface.tblArgumentos.text(fila, this.iface.COL_NOMBRE) + " !!");
                            idArg = "";
                        }
                } else idArg = ""
                if (idArg=="") {
                
                        curArgumentos.setModeAccess(curArgumentos.Insert);
                        curArgumentos.refreshBuffer();
                        curArgumentos.setValueBuffer("nombreargumento",this.iface.tblArgumentos.text(fila, this.iface.COL_NOMBRE));
                }
                curArgumentos.setValueBuffer("nombreinforme", this.cursor().valueBuffer("nombre"));
                curArgumentos.setValueBuffer("valor",this.iface.tblArgumentos.text(fila, this.iface.COL_VALOR));
                porDefecto = this.iface.tblArgumentos.text(fila, this.iface.COL_XDEFECTO) == "X";
                
                curArgumentos.setValueBuffer("valordefecto",porDefecto);
                
                if (!curArgumentos.commitBuffer())
                {
                        debug("Error al guardar argumento: " + this.iface.tblArgumentos.text(fila, this.iface.COL_NOMBRE) + "; con valor: " + this.iface.tblArgumentos.text(fila, this.iface.COL_VALOR));
                        if (idArg && idArg!="") {
                            debug("en modo edicion");
                        }
                        else {
                            debug("en modo inserción");
                        
                        }
                        //return false;
                }
                
        }
        return true;
}


function oficial_bufferChanged(fN)
{
    var cursor:FLSqlCursor = this.cursor();
    switch(fN)
    {
        case "codinforme": {
            this.iface.generarTabla();
            break;
        }
        default: {
            //debug("bc -> " +fN);
            break;
        }
    }
}



//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
