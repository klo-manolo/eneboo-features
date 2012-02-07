
/** @class_declaration gestesoreria */
/////////////////////////////////////////////////////////////////
//// GESTESORERIA ////////////////////////////////////////////////
class gestesoreria extends norma34 {
    var tdbRemesas:Object;
    var tipoRemesa:String;
    function gestesoreria( context ) { norma34 ( context ); }

    function init() { this.ctx.gestesoreria_init(); }

    function abrirCerrarRemesaClicked(){
            return this.ctx.gestesoreria_abrirCerrarRemesaClicked();
    }

    function abrirCerrarRemesa(idRemesa:String, ac:String):Boolean{
            return this.ctx.gestesoreria_abrirCerrarRemesa(idRemesa, ac);
    }

    function borrarRegistro(){
            return this.ctx.gestesoreria_borrarRegistro();
    }

    function registroCerrado(){
            return this.ctx.gestesoreria_registroCerrado();
    }
}
//// GESTESORERIA ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration tiposremprov */
//////////////////////////////////////////////////////////////////
//// TIPOSREMPROV ////////////////////////////////////////////////
class tiposremprov extends gestesoreria {
    var tdbRecords:FLTableDB;
    var pbnImprimirP:Object;
    function tiposremprov( context ) { gestesoreria ( context ); }
    function init() {
        this.ctx.tiposremprov_init();
    }
    function abrirCerrarRemesa(idRemesa:String, ac:String):Boolean {
        return this.ctx.tiposremprov_abrirCerrarRemesa(idRemesa, ac);
    }
    function habilitarImprimirP(){
        return this.ctx.tiposremprov_habilitarImprimirP();
    }
    function imprimirP() {
        return this.ctx.tiposremprov_imprimirP();
    }
}
//// TIPOSREMPROV /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition gestesoreria */
//////////////////////////////////////////////////////////////////
//// GESTESORERIA ///////////////////////////////////////////////
function gestesoreria_init()
{
        this.iface.__init();

        connect(this.child("tbnAbrirCerrar"), "clicked()", this, "iface.abrirCerrarRemesaClicked");

}


/*La remesa tendra los tres estados en orden estricto:
Emitida para la inclusión y exclusión de recibos
Cerrada para verificar los datos de domiciliación y generar el asiento correspondiente
Pagada cuando el importe de la remesa ha sido ingresado en el banco y se da por finalizada la transacción*/

function gestesoreria_abrirCerrarRemesaClicked(){

        var cursor:FLSqlCursor = this.cursor();
        if (cursor.size() == 0)
                return;

        var ok:Boolean = true;
        cursor.transaction(false);

        var util:FLUtil = new FLUtil();
        var idRemesa:Number = cursor.valueBuffer("idremesa");
        var cerrada = cursor.valueBuffer("cerrada");

        if (cerrada == false){
                if (!this.iface.abrirCerrarRemesa(cursor, "cerrar")){
                        MessageBox.information("No ha sido posible cerrar la remesa", MessageBox.Ok, MessageBox.NoButton);
                        ok = false;
                }
        }else if (cerrada == true){
                var res = MessageBox.information("La remesa está Cerrada, ¿Desea abrirla?",MessageBox.Ok, MessageBox.Cancel);
                if (res != MessageBox.Ok){
                        ok = false;
                }else{
                        if (!this.iface.abrirCerrarRemesa(cursor, "abrir")){
                                MessageBox.information("No ha sido posible re-abrir la remesa", MessageBox.Ok, MessageBox.NoButton);
                                ok = false;
                        }
                }
        }

        if (ok){
                cursor.commit();
        }else{
                cursor.rollback();
        }

}

function gestesoreria_abrirCerrarRemesa(curRemesa:FLSqlCursor, ac:String):Boolean
{

        var util:FLUtil = new FLUtil();
        var msn:String;
        if (ac == "cerrar") msn = "Cerrando";
        if (ac == "abrir") msn = "Abriendo";
        util.createProgressDialog(msn +" remesa número "+curRemesa.valueBuffer("idremesa"),7);
        util.setProgress(1);
        var cerrada:Boolean;

        var idRemesa = curRemesa.valueBuffer("idremesa");
        var tipoConta = curRemesa.valueBuffer("tipoconta");
        if (!tipoConta || tipoConta == "") {
                util.destroyProgressDialog();
                return false;
        }

        util.setProgress(2);
        if (ac == "cerrar"){
                util.setProgress(3);
                cerrada = true;
                util.setProgress(4);
        }

        if (ac == "abrir"){
                util.setProgress(3);
                var idPagoRem = util.sqlSelect("pagosdevolremprov","idpagoremprov","idremesa='"+idRemesa+"'");
                if (idPagoRem && idPagoRem!=""){
                        if (tipoConta=="200"){
                                MessageBox.warning("La remesa no puede abrirse, por favor elimine el pago",MessageBox.Ok, MessageBox.NoButton);
                                util.destroyProgressDialog();
                                return false;
                        }
                }

                if (tipoConta == "100"){
                        var qryRecibos:FLSqlQuery = new FLSqlQuery;
                        qryRecibos.setTablesList("pagosdevolprov");
                        qryRecibos.setSelect("DISTINCT(idrecibo)");
                        qryRecibos.setFrom("pagosdevolprov");
                        qryRecibos.setWhere("idremesa = " + idRemesa);
                        if (!qryRecibos.exec()){
                                util.destroyProgressDialog();
                                return false;
                        }
                        var errorRecibos:String="";
                        while (qryRecibos.next()) {
                        /*Comprueba primero que todos los pagos de los recibos puedan ser eliminados*/
                                if (!formRecordremesasprov.iface.pub_excluirReciboRemesa(qryRecibos.value(0), idRemesa,true)){
                                        errorRecibos += util.sqlSelect("recibosprov","codigo","idrecibo='"+qryRecibos.value(0)+"'")+"\n";
                                }
                        }
                        if (errorRecibos!=""){
                                MessageBox.warning("La remesa no puede abrirse,\nlos siguientes recibos no pueden ser excluidos:\n"+errorRecibos,MessageBox.Ok, MessageBox.NoButton);
                                        util.destroyProgressDialog();
                                        return false;
                        }
                }
                cerrada = false;
                util.setProgress(4);
        }

        util.setProgress(5);
        curRemesa.setModeAccess(curRemesa.Edit);
        curRemesa.refreshBuffer();
        curRemesa.setValueBuffer("cerrada", cerrada);
        if (!curRemesa.commitBuffer()) {
                util.destroyProgressDialog();
                return false;
        }

        util.setProgress(6);
        if (tipoConta == "100"){
                if (ac == "cerrar"){
                        var pagoAuto = util.sqlSelect("factteso_general","pagoauto34","1=1");
                        if (pagoAuto){
                                if (!flfactteso.iface.pagoRemesaAutoProv(idRemesa, "Insertar")){
                                        util.destroyProgressDialog();
                                        return false;
                                }
                        }
                }else if (ac == "abrir"){
                        var idPagoRem = util.sqlSelect("pagosdevolremprov","idpagoremprov","idremesa='"+idRemesa+"'");
                        if (idPagoRem && idPagoRem!=""){
                                var continuar = MessageBox.information("La remesa esta pagada ¿Desea eliminar automáticamente el pago?", MessageBox.Ok, MessageBox.Cancel);
                                if (continuar != MessageBox.Ok){
                                        util.destroyProgressDialog();
                                        return false;
                                }

                                 if (!flfactteso.iface.pagoRemesaAutoProv(idRemesa, "Eliminar")){
                                        util.destroyProgressDialog();
                                        return false;
                                }
                        }
                }
        }
        util.destroyProgressDialog();
        return true;

}
//// GESTESORERIA ///////////////////////////////////////////////
////////////////////////////////////////////////////////////////

/** @class_definition tiposremprov */
/////////////////////////////////////////////////////////////////
//// TIPOSREMPROV //////////////////////////////////////////////

function tiposremprov_init()
{
    this.iface.__init();

    this.iface.tdbRecords = this.child("tableDBRecords");
    this.iface.pbnImprimirP = this.child("toolButtonPrintP");
    connect(this.iface.pbnImprimirP, "clicked()", this, "iface.imprimirP");
    connect(this.iface.tdbRecords, "currentChanged()", this, "iface.habilitarImprimirP");
}

function tiposremprov_abrirCerrarRemesa(curRemesa:FLSqlCursor, ac:String):Boolean
{

    if (!this.iface.__abrirCerrarRemesa(curRemesa, ac)){
        return false;
    }

    var util:FLUtil = new FLUtil();
    var tipoConta:String = curRemesa.valueBuffer("tipoconta");
    var tipoRem:String = curRemesa.valueBuffer("tiporem");

    if (tipoConta == "200") {
        return true;
    } else if (tipoConta == "100") {
        if (tipoRem != "01"){
            return true;
        }
    }


    var idRemesa:Number = curRemesa.valueBuffer("idremesa");
    var existe:Number = util.sqlSelect("pagaresemi","idpagare","idremesa = "+idRemesa);
    var curPagaresEmi: FLSqlCursor = new FLSqlCursor("pagaresemi");

    if (ac == "cerrar" && (tipoConta == "201" || tipoRem == "01")) {

        if (existe){
            MessageBox.warning("Ocurrió un error, ya existe un pagaré para esta remesa",MessageBox.Ok, MessageBox.NoButton);
            return false;
        }

        var hoy:Date = new Date();
        curPagaresEmi.setModeAccess(curPagaresEmi.Insert);
        curPagaresEmi.refreshBuffer();
        curPagaresEmi.setValueBuffer("idremesa",  idRemesa);
        curPagaresEmi.setValueBuffer("numero", "");
        curPagaresEmi.setValueBuffer("ci", "");
        curPagaresEmi.setValueBuffer("fecha", hoy);

        if (curPagaresEmi.commitBuffer()) {
            curPagaresEmi.select("idremesa = "+idRemesa);
            if (!curPagaresEmi.first()) {
                MessageBox.warning("Error en la lectura de los datos",MessageBox.Ok, MessageBox.NoButton);
                return false;
            }

            curPagaresEmi.setModeAccess(curPagaresEmi.Edit);
            curPagaresEmi.refreshBuffer();
            curPagaresEmi.editRecord();
            while (curPagaresEmi.modeAccess() == curPagaresEmi.Edit){
                sys.processEvents();
            }
        } else {
            MessageBox.warning("Error en almacenamiento de datos",MessageBox.Ok, MessageBox.NoButton);
            return false;
        }
    }

    if (ac == "abrir"){
        if (tipoConta == "201" || tipoRem == "01") {
            if (!existe) {
                MessageBox.warning("Ocurrió un error, no existe un pagaré para esta remesa",MessageBox.Ok, MessageBox.NoButton);
                return false;
            }

            curPagaresEmi.select("idremesa = " + idRemesa);
            curPagaresEmi.first();
            curPagaresEmi.setModeAccess(curPagaresEmi.Del);
            curPagaresEmi.refreshBuffer();
            if (!curPagaresEmi.commitBuffer()){
                return false;
            }
        }

        if (tipoConta == "202") {
            var idAnticipoRem:Number = util.sqlSelect("anticiposconf","count(idanticipoconf)","idremesa='"+idRemesa+"'");
            if (idAnticipoRem >= 1) {
                MessageBox.warning("La remesa no puede abrirse, por favor elimine los anticipos",MessageBox.Ok, MessageBox.NoButton);
                return false;
            }
        }
    }

    return true;

}

function tiposremprov_habilitarImprimirP()
{
    if (this.cursor().valueBuffer("tiporem") == "01") {
        this.iface.pbnImprimirP.enabled = true;
    } else {
        this.iface.pbnImprimirP.enabled = false;
    }
}

function tiposremprov_imprimirP()
{
    if (this.cursor().size() == 0){
        return;
    }

    if (sys.isLoadedModule("flfactinfo")) {
        var idRemesa:Number = this.cursor().valueBuffer("idremesa");
        var curImprimir:FLSqlCursor = new FLSqlCursor("i_remesasprov");
        curImprimir.setModeAccess(curImprimir.Insert);
        curImprimir.refreshBuffer();
        curImprimir.setValueBuffer("descripcion", "temp");
        curImprimir.setValueBuffer("i_remesasprov_idremesa", idRemesa);
        flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_remesasprov");
    } else{
            flfactppal.iface.pub_msgNoDisponible("Informes");
    }
}
//// TIPOSREMPROV //////////////////////////////////////////////
///////////////////////////////////////////////////////////////

