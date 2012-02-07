/***************************************************************************
                recibosmulticli.qs  -  description
                             -------------------
    begin                : lun jun 16 2008
    copyright            : (C) 2008 by Gestiweb, Integración de soluciones Web, S.L.
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
        function validateForm() { return this.ctx.interna_validateForm(); }
        function calculateField(fN:String):String { return this.ctx.interna_calculateField(fN); }
        function acceptedForm() { return this.ctx.interna_acceptedForm(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
        var ejercicioActual:String;
        var divisaEmpresa:String;
        
        function oficial( context ) { interna( context ); } 
        function desconexion() {
                return this.ctx.oficial_desconexion();
        }
        function bufferChanged(fN:String) {
                return this.ctx.oficial_bufferChanged(fN);
        }
        function eliminarRecibo() {
                return this.ctx.oficial_eliminarRecibo();
        }
        function refrescarTablaRecibos() {
                return this.ctx.oficial_refrescarTablaRecibos();
        }
        function agregarRecibo():Boolean {
                return this.ctx.oficial_agregarRecibo();
        }
        function asociarReciboMulti(idRecibo:String, curReciboMulti:FLSqlCursor):Boolean {
                return this.ctx.oficial_asociarReciboMulti(idRecibo, curReciboMulti);
        }
        function establecerHabilitaciones() {
                return this.ctx.oficial_establecerHabilitaciones();
        }
        function excluirDeReciboMulti(idRecibo:String):Boolean {
                return this.ctx.oficial_excluirDeReciboMulti(idRecibo);
        }
        function obtenerTasaCambioFact():String {
                return this.ctx.oficial_obtenerTasaCambioFact();
        }
        function habilitarTasaConv() {
                return this.ctx.oficial_habilitarTasaConv();
        }
        function generarReciboAgrupado(tabla:String, cursor:FLSqlCursor):String {
                return this.ctx.oficial_generarReciboAgrupado(tabla, cursor);
        }
        function generarCodigo(codEjercicio:String, codSerie:String):String {
                return this.ctx.oficial_generarCodigo(codEjercicio, codSerie);
        }
        function modificarReciboAgrupado(tabla:String, cursor:FLSqlCursor):Boolean {
                return this.ctx.oficial_modificarReciboAgrupado(tabla, cursor);
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
//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
function interna_init()
{
        this.iface.refrescarTablaRecibos();
        
        var cursor:FLSqlCursor = this.cursor();
        var util:FLUtil = new FLUtil();
        this.iface.divisaEmpresa = util.sqlSelect("empresa", "coddivisa", "1 = 1");
        this.iface.bufferChanged("codcuentapago");
        
        connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
        connect(form, "closed()", this, "iface.desconexion");
        connect(this.child("tbInsert"), "clicked()", this, "iface.agregarRecibo");
        connect(this.child("tbDelete"), "clicked()", this, "iface.eliminarRecibo");
        
        if (cursor.modeAccess()==cursor.Insert){
                cursor.setValueBuffer("codejercicio",flfactppal.iface.pub_ejercicioActual());
                this.child("fdbTasaConv").setDisabled(true);
                this.child("tdbRecibos").setReadOnly(true);
                this.child("fdbCodEjercicio").setDisabled(true);
                this.iface.habilitarTasaConv();
        }
    
        if (cursor.modeAccess()==cursor.Edit){
                    this.child("fdbCodSerie").setDisabled(true);
                    var qryRecibos:FLSqlQuery = new FLSqlQuery;
                    qryRecibos.setTablesList("reciboscli");
                    qryRecibos.setSelect("estado");
                    qryRecibos.setFrom("reciboscli");
                    qryRecibos.setWhere("codigo LIKE '"+cursor.valueBuffer("codigo")+"%' AND estado!='Emitido'");
                    if (!qryRecibos.exec())
                        return false;
                        
                    if (qryRecibos.size()>0){
                            cursor.setModeAccess(cursor.Browse);
                            cursor.refresh();
                            this.child("gbxRecibos").setDisabled(true);
                    }
        }
}
function interna_validateForm():Boolean
{
        var cursor:FLSqlCursor = this.cursor();
        var util:FLUtil = new FLUtil();

        /** Si se escoge la tasa de conversión de las facturas se vuelve a comprobar que todas tienen la misma tasa*/
        if (cursor.valueBuffer("origentasaconv") == "Facturas") {
                if (!this.iface.obtenerTasaCambioFact()) {
                        cursor.setValueBuffer("origentasaconv", "Tasa actual");
                        return false;
                }
        }
    
    /** Si el cursor esta en modo insert, genera un recibo nuevo*/
    if (cursor.modeAccess()==cursor.Insert){
        var curRecibosSel:FLSqlCursor = this.child("tdbRecibos").cursor();
        if (!curRecibosSel.size())
            return false;
        
        if (cursor.valueBuffer("codserie") && cursor.valueBuffer("codserie")!=""){
            /*Validar primero si la serie existe*/
            var res = util.sqlSelect("series","codserie","codserie='"+cursor.valueBuffer("codserie")+"'");
            if (res && res!=""){
                    cursor.setValueBuffer("codigo",this.iface.generarCodigo(cursor.valueBuffer("codejercicio"),cursor.valueBuffer("codserie")));
            }else{
                    MessageBox.information("Por favor seleccione una serie valida para el recibo",MessageBox.Ok);
                    return false;
            }
        }else {
            MessageBox.information("Por favor seleccione la serie del recibo",MessageBox.Ok);
            return false;
        }
              
        var idrecibogen=this.iface.generarReciboAgrupado("reciboscli",cursor);
        if (idrecibogen)
            cursor.setValueBuffer("idrecibogen",idrecibogen); 
    }
    
    /** Si el cursor esta en modo edit, genera los cambios*/
    if (cursor.modeAccess()==cursor.Edit){
        if (cursor.isModifiedBuffer()){
            if(!util.sqlDelete("reciboscli","codigo LIKE '"+cursor.valueBuffer("codigo")+"%' AND numero>1"))
                return false;
            if(!this.iface.modificarReciboAgrupado("reciboscli",cursor))
                return false;
        }
    }
    return true;
}
function interna_calculateField(fN:String):String
{
        var util:FLUtil = new FLUtil();
        var cursor:FLSqlCursor = this.cursor();
        var res:String;
        switch (fN) {
                /** \La cuenta bancaria por defecto será la asociada al cliente (Cuenta 'Remesar en') */
                case "codcuenta":
                        res = false;
                        var codCliente:String = cursor.valueBuffer("codcliente");
                        if (codCliente){
                            res = util.sqlSelect("clientes", "codcuentadom", "codcliente = '" + codCliente + "'");
                        if (!res)
                            res = util.sqlSelect("cuentasbcocli", "codcuenta", "codcliente = '" + codCliente + "'");
                        }
                        if(!res){
                            cursor.setValueBuffer("ctaentidad","");
                            cursor.setValueBuffer("ctaagencia","");
                            cursor.setValueBuffer("dc","");
                            cursor.setValueBuffer("cuenta","");
                            cursor.setValueBuffer("descripcion","");
                        }
                        break;
                case "dc":
                        var entidad:String = cursor.valueBuffer("ctaentidad");
                        var agencia:String = cursor.valueBuffer("ctaagencia");
                        var cuenta:String = cursor.valueBuffer("cuenta");
                        if ( !entidad.isEmpty() && !agencia.isEmpty() && ! cuenta.isEmpty() 
                                        && entidad.length == 4 && agencia.length == 4 && cuenta.length == 10 ) {
                                var util:FLUtil = new FLUtil();
                                var dc1:String = util.calcularDC(entidad + agencia);
                                var dc2:String = util.calcularDC(cuenta);
                                res = dc1 + dc2;
                        }
                        break;
                case "importe": {
                        res = util.sqlSelect("reciboscli","SUM(importe)","idrecibomulti = " + cursor.valueBuffer("idrecibomulti"));
                        res = util.roundFieldValue(res, "reciboscli", "importe");
                        break;
                }
                case "importeeuros": {
                        var importe:Number = parseFloat(cursor.valueBuffer("importe"));
                        var tasaConv:Number = parseFloat(cursor.valueBuffer("tasaconv"));
                        res = importe * tasaConv;
                        res = parseFloat(util.roundFieldValue(res, "recibosmulticli", "importeeuros"));
                        break;
                }
                case "coddir":{
                        var codCliente:String = cursor.valueBuffer("codcliente");
                        if (codCliente)
                                res = util.sqlSelect("dirclientes", "id", "codcliente = '" + codCliente + "' AND domfacturacion=true");
                        break;
                }
                case "codcuentapago":{
                        res = false;
                        var codCliente:String = cursor.valueBuffer("codcliente");
                        if (codCliente)
                                res = util.sqlSelect("clientes", "codcuentarem", "codcliente = '" + codCliente + "'");
                        break;
                }
                case "dcpago":
                        var entidad:String = this.child("fdbCtaEntidadPago").value();
                        var agencia:String = this.child("fdbCtaAgenciaPago").value();
                        var cuenta:String = this.child("fdbCuentaPago").value();
                        if ( !entidad.isEmpty() && !agencia.isEmpty() && ! cuenta.isEmpty() 
                                        && entidad.length == 4 && agencia.length == 4 && cuenta.length == 10 ) {
                                var util:FLUtil = new FLUtil();
                                var dc1:String = util.calcularDC(entidad + agencia);
                                var dc2:String = util.calcularDC(cuenta);
                                res = dc1 + dc2;
                        }
        }
        return res;
}
function interna_acceptedForm()
{
        var util:FLUtil = new FLUtil();
        /** \Actualiza el riesgo del cliente */
        var codCliente:String = this.cursor().valueBuffer("codcliente");
        if (codCliente)
                flfactteso.iface.pub_actualizarRiesgoCliente(codCliente);
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_desconexion()
{
        disconnect(this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged");
}
function oficial_bufferChanged(fN:String)
{
        var util:FLUtil = new FLUtil();
        var cursor:FLSqlCursor = this.cursor();
        switch (fN) {
                case "codcuenta":
                case "ctaentidad":
                case "ctaagencia":
                case "cuenta": {
                        this.child("fdbDc").setValue(this.iface.calculateField("dc"));
                        break;
                }
                case "importe":
                case "tasaconv": {
                        this.child("fdbImporteEuros").setValue(this.iface.calculateField("importeeuros"));
                        break;
                }
                case "codcliente": {
                        this.child("fdbCodCuenta").setValue(this.iface.calculateField("codcuenta"));
                        var coddir = this.iface.calculateField("coddir");
                        if (coddir && coddir != "") this.child("fdbCodDir").setValue(coddir);
                        this.child("fdbCodCuentaPago").setValue(this.iface.calculateField("codcuentapago"));
                        break;
                }
                case "origentasaconv": {
                        var origenTasaConv:String = cursor.valueBuffer("origentasaconv");
                        var tasaConv:String;
                        if (origenTasaConv == "Facturas") {
                                tasaConv = this.iface.obtenerTasaCambioFact();
    debug("devuelve tasaconv = "+tasaConv);                       
                                if (!tasaConv) {
                                        cursor.setValueBuffer("origentasaconv", "Tasa actual");
                                        return;
                                }
                        } else {
                                tasaConv = util.sqlSelect("divisas", "tasaconv", "coddivisa = '" + cursor.valueBuffer("coddivisa") + "'");
                        }
                        this.child("fdbTasaConv").setValue(tasaConv);
                        this.iface.habilitarTasaConv();
                        break;
                }
                case "codcuentapago": {
                        this.child("dcpago").setText(this.iface.calculateField("dcpago"));
                        break;
                }
        }
}
function oficial_habilitarTasaConv()
{
        var cursor:FLSqlCursor = this.cursor();
        var origenTasaConv:String = cursor.valueBuffer("origentasaconv");
        if (origenTasaConv == "Facturas") {
                this.child("fdbTasaConv").setDisabled(true);
        } else {
                this.child("fdbTasaConv").setDisabled(false);
        }
}
function oficial_obtenerTasaCambioFact():String
{
        var util:FLUtil = new FLUtil;
        var cursor:FLSqlCursor = this.cursor();
        var error:Boolean = false;       
        
        var qryRecibos:FLSqlQuery = new FLSqlQuery;
        qryRecibos.setTablesList("reciboscli");
        qryRecibos.setSelect("tasaconv");
        qryRecibos.setFrom("reciboscli");
        qryRecibos.setWhere("idrecibomulti='"+cursor.valueBuffer("idrecibomulti")+"' GROUP BY tasaconv");
        
        if (!qryRecibos.exec()){
                error = true;
        }
        
        if (qryRecibos.size() > 1){
                error = true;
        }
        
        if (error){
                MessageBox.warning(util.translate("scripts", "No se ha encontrado la tasa de conversión para los recibos incluidos en el agrupado,\n ó la tasa de cambio no es la misma para todos los recibos"), MessageBox.Ok, MessageBox.NoButton);
                return false;
        }
        
        qryRecibos.first();
        return qryRecibos.value("tasaconv");
        
}
/** \D Se elimina el recibo activo de la agrupacion*/
function oficial_eliminarRecibo()
{
        var util:FLUtil = new FLUtil;
        if (!this.child("tdbRecibos").cursor().isValid())
                return;
        
    var idRecibo:String = this.child("tdbRecibos").cursor().valueBuffer("idrecibo");
        
        if (!this.iface.excluirDeReciboMulti(idRecibo))
                return false;
                
        this.iface.refrescarTablaRecibos();
}
/** \D Elimina la asociación de un recibo con la agrupacion.
@param        idreciboMulti: Identificador del recibo agrupado
@param        idRecibo: Identificador del Recibo 
\end */
function oficial_excluirDeReciboMulti(idRecibo:String):Boolean
{
        var util:FLUtil = new FLUtil;
        
    var qryPagosDevol:FLSqlQuery = new FLSqlQuery();
        qryPagosDevol.setTablesList("pagosdevolcli");
        qryPagosDevol.setSelect("idrecibo");
        qryPagosDevol.setFrom("pagosdevolcli");
        qryPagosDevol.setWhere("idrecibo = " + idRecibo);
        if (!qryPagosDevol.exec())
                return false;
        
        var estado:String;
    if (qryPagosDevol.size()) {estado='Devuelto';}
    else {estado='Emitido';}
            
        var curRecibos:FLSqlCursor = new FLSqlCursor("reciboscli");
        curRecibos.select("idrecibo = " + idRecibo);
        if (curRecibos.next()) {
                curRecibos.setModeAccess(curRecibos.Edit);
                curRecibos.refreshBuffer();
                curRecibos.setValueBuffer("estado", estado);
                curRecibos.setValueBuffer("idrecibomulti", 0);
                if (!curRecibos.commitBuffer())
                        return false;
        }
        return true;
}
function oficial_refrescarTablaRecibos()
{
        this.child("tdbRecibos").refresh();
        this.iface.establecerHabilitaciones();
        this.child("fdbImporte").setValue(this.iface.calculateField("importe"));
}
/** \C Si hay uno o más recibos, ciertos campos deben deshabilitarse, como el código de cliente, la divisa, o el código de cuenta*/
function oficial_establecerHabilitaciones()
{
        if (this.child("tdbRecibos").cursor().size() > 0) {
                this.child("fdbCodCliente").setDisabled(true);
                this.child("fdbCodDivisa").setDisabled(true);
                this.child("fdbFecha").setDisabled(true);
        } else {
                this.child("fdbCodCliente").setDisabled(false);
                this.child("fdbCodDivisa").setDisabled(false);
                this.child("fdbFecha").setDisabled(false);
        }
}
/** \D Se agrega un recibo al recibo múltiple*/
function oficial_agregarRecibo():Boolean
{
        var util:FLUtil = new FLUtil();
        var cursor:FLSqlCursor = this.cursor();
        
        if (cursor.valueBuffer("coddivisa") == "") {
                MessageBox.warning(util.translate("scripts", "Debe especificar la divisa antes de agregar recibos"), MessageBox.Ok, MessageBox.NoButton);
                return false;
        }
        
        var filtro:String = "estado IN ('Emitido', 'Devuelto') AND (idrecibomulti<> "+cursor.valueBuffer("idrecibomulti")+" OR idrecibomulti IS NULL)";
        if (cursor.valueBuffer("codcliente") != "")
                filtro += " AND codcliente = '" + cursor.valueBuffer("codcliente") + "'";
        else 
                filtro += " AND (codcliente = '' OR codcliente IS NULL)"; 
        
         if (cursor.modeAccess()==cursor.Edit){
                filtro += "AND codigo not like '"+cursor.valueBuffer("codigo")+"%'";
        }
        
        var f:Object = new FLFormSearchDB("seleccionreciboscli");
        var curRecibos:FLSqlCursor = f.cursor();
                
        curRecibos.select();
        if (!curRecibos.first())
                curRecibos.setModeAccess(curRecibos.Insert);
        else
                curRecibos.setModeAccess(curRecibos.Edit);
                
        f.setMainWidget();
        curRecibos.refreshBuffer();
        curRecibos.setValueBuffer("datos", "");
        curRecibos.setValueBuffer("filtro", filtro);
        var datos:String = f.exec("datos");
        if (!datos || datos == "") 
                return false;
    var recibos:Array = datos.toString().split(",");
        for (var i:Number = 0; i < recibos.length; i++) {
                if (!this.iface.asociarReciboMulti(recibos[i], cursor))
                return false;
        }
        this.iface.refrescarTablaRecibos();
}
/** \D Crea la asociación de un recibo a el recibo múltiple.
@param        idRerciboMulti: Identificador del recibo agrupado
@param        curReciboMulti: Cursor del recibo Multi 
\end */
function oficial_asociarReciboMulti(idRecibo:String, curReciboMulti:FLSqlCursor):Boolean
{
        var util:FLUtil = new FLUtil;
        
        if (util.sqlSelect("reciboscli", "coddivisa", "idrecibo = " + idRecibo) != curReciboMulti.valueBuffer("coddivisa")) {
                var codRecibo = util.sqlSelect("reciboscli","codigo","idrecibo='"+idRecibo+"'");                
                MessageBox.warning(util.translate("scripts", "No es posible incluir el recibo %1.\nLa divisas del recibo y del agrupado deben coincidir.").arg(codRecibo), MessageBox.Ok, MessageBox.NoButton);
                return true;
        }
        var s:String;
        var curRecibos:FLSqlCursor = new FLSqlCursor("reciboscli");
        curRecibos.select("idrecibo = " + idRecibo);
        if (curRecibos.next()) {
                curRecibos.setModeAccess(curRecibos.Edit);
                curRecibos.refreshBuffer();
                curRecibos.setValueBuffer("estado", "Agrupado");
                curRecibos.setValueBuffer("idrecibomulti",curReciboMulti.valueBuffer("idrecibomulti"));
                if (!curRecibos.commitBuffer())
                        return false;
        }
        return true;
}
/** \D Genera el nuevo recibo agrupado para el cliente/proveedor
@param        tabla:Nombre de la tabla de recibos a crear (reciboscli/recibosprov)
@param        cursor: Cursor de recibosmulticli/recibosmultiprov
return  Devuelve el id del recibo generado
\end */
function oficial_generarReciboAgrupado(tabla,cursor):String
{
    var util:FLUtil = new FLUtil;
    var codcliprov:String;
    var nombre:String;
    
    if (tabla=="reciboscli"){
        codcliprov="codcliente";
        nombre="nombrecliente";     
    }
    if (tabla=="recibosprov"){
        codcliprov="codproveedor";
        nombre="nombreproveedor";
    } 
        
    var divisa:String = util.sqlSelect("divisas", "descripcion", "coddivisa = '" + cursor.valueBuffer("coddivisa") + "'");
    var curRecibos:FLSqlCursor = new FLSqlCursor(tabla);
    
    curRecibos.setModeAccess(curRecibos.Insert);
    curRecibos.refreshBuffer();
    curRecibos.setValueBuffer("codigo",cursor.valueBuffer("codigo")+"-01");
    curRecibos.setValueBuffer("estado","Emitido");
    curRecibos.setValueBuffer("importe", cursor.valueBuffer("importe"));
    curRecibos.setValueBuffer("fecha", cursor.valueBuffer("fecha"));
    curRecibos.setValueBuffer("fechav", cursor.valueBuffer("fechav"));
    if (tabla=="reciboscli") curRecibos.setValueBuffer("fechamate", cursor.valueBuffer("fechav"));
    curRecibos.setValueBuffer(codcliprov, cursor.valueBuffer(codcliprov));
    curRecibos.setValueBuffer(nombre, cursor.valueBuffer("nombre"));
    curRecibos.setValueBuffer("cifnif", cursor.valueBuffer("cifnif"));
    curRecibos.setValueBuffer("importeeuros", cursor.valueBuffer("importeeuros"));
    curRecibos.setValueBuffer("coddivisa", cursor.valueBuffer("coddivisa"));
    curRecibos.setValueBuffer("tasaconv", cursor.valueBuffer("tasaconv"));
    curRecibos.setValueBuffer("codcuenta", cursor.valueBuffer("codcuenta"));
    curRecibos.setValueBuffer("descripcion", cursor.valueBuffer("descripcion"));
    curRecibos.setValueBuffer("ctaentidad", cursor.valueBuffer("ctaentidad"));
    curRecibos.setValueBuffer("ctaagencia", cursor.valueBuffer("ctaagencia"));
    curRecibos.setValueBuffer("dc", cursor.valueBuffer("dc"));
    curRecibos.setValueBuffer("cuenta", cursor.valueBuffer("cuenta"));
    if (cursor.valueBuffer("coddir")) {
            curRecibos.setValueBuffer("coddir", cursor.valueBuffer("coddir"));
    } else {
            curRecibos.setNull("coddir");
    }
    curRecibos.setValueBuffer("direccion", cursor.valueBuffer("direccion"));
    curRecibos.setValueBuffer("codpostal", cursor.valueBuffer("codpostal"));
    curRecibos.setValueBuffer("ciudad", cursor.valueBuffer("ciudad"));
    curRecibos.setValueBuffer("provincia", cursor.valueBuffer("provincia"));
    curRecibos.setValueBuffer("codpais",cursor.valueBuffer("codpais"));
    curRecibos.setValueBuffer("texto", util.enLetraMoneda(cursor.valueBuffer("importe"), divisa));
    curRecibos.setValueBuffer("codejercicio", cursor.valueBuffer("codejercicio"));
    curRecibos.setValueBuffer("codserie", cursor.valueBuffer("codserie"));
    curRecibos.setValueBuffer("numero", 1);
    curRecibos.setValueBuffer("codcuentapago",cursor.valueBuffer("codcuentapago"));
    curRecibos.setValueBuffer("automatico",true);
    curRecibos.setValueBuffer("tipopago",cursor.valueBuffer("tipopago"));  
    
    if (!curRecibos.commitBuffer())
        return false;
    
    return curRecibos.valueBuffer("idrecibo");
}
/** \D Genera el codigo para el nuevo recibo
@param        cursor: Identificador del recibo
@param        tabla:Nombre de la tabla de recibos a crear (reciboscli/recibosprov)
\end */
function oficial_generarCodigo(codEjercicio:String, codSerie:String):String
{
    var util:FLUtil = new FLUtil;
    var inicio:String=flfacturac.iface.pub_cerosIzquierda(codEjercicio,4)+flfacturac.iface.pub_cerosIzquierda(codSerie,2)+"G";
    var num=util.sqlSelect("reciboscli","MAX(cast(substring(codigo from 8 for 5) as integer))+1","codigo LIKE '"+inicio+"%'");
        if (!num) num=1;
        
        var codigo:String=inicio+flfacturac.iface.pub_cerosIzquierda(num,5);
    return codigo;  
}
/** \D Modifica los cambios para un recibo agrupado de cliente/proveedor
@param        tabla:Nombre de la tabla de recibos a modificar (reciboscli/recibosprov)
@param        cursor: Cursor de recibosmulticli/recibosmultiprov
Return  Devuelve true si se guardan los cambios correctamente
\end */
function oficial_modificarReciboAgrupado(tabla,cursor):String
{
    var util:FLUtil = new FLUtil;
    var codcliprov:String;
    var nombre:String;
    
    if (tabla=="reciboscli"){
        codcliprov="codcliente";
        nombre="nombrecliente";     
    }
    if (tabla=="recibosprov"){
        codcliprov="codproveedor";
        nombre="nombreproveedor";
    }
        
    var divisa:String = util.sqlSelect("divisas", "descripcion", "coddivisa = '" + cursor.valueBuffer("coddivisa") + "'");
    var curRecibos:FLSqlCursor = new FLSqlCursor(tabla);
    curRecibos.select("idrecibo='"+cursor.valueBuffer("idrecibogen")+"'");
    if (!curRecibos.first())
        return false;
    
    
    curRecibos.setModeAccess(curRecibos.Edit);
    curRecibos.refreshBuffer();
    curRecibos.setValueBuffer("importe", cursor.valueBuffer("importe"));
    curRecibos.setValueBuffer("fechav", cursor.valueBuffer("fechav"));
    if (tabla=="reciboscli") curRecibos.setValueBuffer("fechamate", cursor.valueBuffer("fechav"));       
    curRecibos.setValueBuffer("importeeuros", cursor.valueBuffer("importeeuros"));
    curRecibos.setValueBuffer("codcuenta", cursor.valueBuffer("codcuenta"));
    curRecibos.setValueBuffer("descripcion", cursor.valueBuffer("descripcion"));
    curRecibos.setValueBuffer("ctaentidad", cursor.valueBuffer("ctaentidad"));
    curRecibos.setValueBuffer("ctaagencia", cursor.valueBuffer("ctaagencia"));
    curRecibos.setValueBuffer("dc", cursor.valueBuffer("dc"));
    curRecibos.setValueBuffer("cuenta", cursor.valueBuffer("cuenta"));
    if (cursor.valueBuffer("coddir")) {
            curRecibos.setValueBuffer("coddir", cursor.valueBuffer("coddir"));
    } else {
            curRecibos.setNull("coddir");
    }
    curRecibos.setValueBuffer("direccion", cursor.valueBuffer("direccion"));
    curRecibos.setValueBuffer("codpostal", cursor.valueBuffer("codpostal"));
    curRecibos.setValueBuffer("ciudad", cursor.valueBuffer("ciudad"));
    curRecibos.setValueBuffer("provincia", cursor.valueBuffer("provincia"));
    curRecibos.setValueBuffer("codpais",cursor.valueBuffer("codpais"));
    curRecibos.setValueBuffer("texto", util.enLetraMoneda(cursor.valueBuffer("importe"), divisa));
    curRecibos.setValueBuffer("codcuentapago",cursor.valueBuffer("codcuentapago"));
    curRecibos.setValueBuffer("tipopago",cursor.valueBuffer("tipopago"));         
    
    if (!curRecibos.commitBuffer())
        return false;
    
    return true;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
