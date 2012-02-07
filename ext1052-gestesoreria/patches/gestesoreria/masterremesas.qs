
/** @class_declaration gestesoreria */
/////////////////////////////////////////////////////////////////
//// GESTESORERIA ////////////////////////////////////////////////
class gestesoreria extends norma58 {
    var tdbRemesas:Object;
    var tipoRemesa:String;
    function gestesoreria( context ) { norma58 ( context ); }

    function init() { this.ctx.gestesoreria_init(); }

    function abrirCerrarRemesaClicked(){
            return this.ctx.gestesoreria_abrirCerrarRemesaClicked();
    }

    function abrirCerrarRemesa(idRemesa:String, ac:String):Boolean{
            return this.ctx.gestesoreria_abrirCerrarRemesa(idRemesa, ac);
    }

    function insertar19(){
            return this.ctx.gestesoreria_insertar19();
    }

    function insertar58(){
            return this.ctx.gestesoreria_insertar58();
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

/** @class_definition gestesoreria */
//////////////////////////////////////////////////////////////////
//// GESTESORERIA ///////////////////////////////////////////////
function gestesoreria_init()
{
        this.iface.__init();

        connect(this.child("toolButtonInsert19"), "clicked()", this, "iface.insertar19");
        connect(this.child("toolButtonInsert58"), "clicked()", this, "iface.insertar58");
        connect(this.child("toolButtonDelete"), "clicked()", this, "iface.borrarRegistro");
        connect(this.child("tbnAbrirCerrar"), "clicked()", this, "iface.abrirCerrarRemesaClicked");
        connect(formRecordremesas, "closed()", this, "iface.registroCerrado");

        this.iface.tipoRemesa = "";
        this.iface.tdbRemesas = this.child("tableDBRecords");
        this.iface.tdbRemesas.setEditOnly(true);
}

function gestesoreria_insertar19()
{
        this.iface.tipoRemesa = "19";

        var curRemesa:FLSqlCursor = new FLSqlCursor("remesas");
        curRemesa.insertRecord();
}

function gestesoreria_insertar58()
{
        this.iface.tipoRemesa = "58";

        var curRemesa:FLSqlCursor = new FLSqlCursor("remesas");
        curRemesa.insertRecord();
}

function gestesoreria_borrarRegistro()
{
        var ok = MessageBox.information("El registro activo será borrado. ¿Esta seguro?", MessageBox.Ok, MessageBox.Cancel);
        if (ok!=MessageBox.Ok) return;

        var cursor:FLSqlCursor = this.cursor();

        var idRemesa = cursor.valueBuffer("idremesa");
        if (!idRemesa){
                MessageBox.information("No hay ningun registro seleccionado",MessageBox.Ok, MessageBox.NoButton);
                return;
        }

        var curRemesa:FLSqlCursor = new FLSqlCursor("remesas");
        curRemesa.select("idremesa='"+idRemesa+"'");
        curRemesa.first();

        var util:FLUtil = new FLUtil();
        var idPagoRem = util.sqlSelect("pagosdevolrem","idpagorem","idremesa='"+idRemesa+"'");
        if (idPagoRem && idPagoRem!=""){
                MessageBox.warning("La remesa no puede borrarse, por favor elimine el pago",MessageBox.Ok, MessageBox.NoButton);
                return false;
        }

        curRemesa.setModeAccess(curRemesa.Del);
        curRemesa.refreshBuffer();
        if (!curRemesa.commitBuffer()){
                MessageBox.information("No ha sido posible eliminar el registro seleccionado",MessageBox.Ok, MessageBox.NoButton);
                return;
        }

        this.iface.tdbRemesas.refresh();
}

function gestesoreria_registroCerrado(){

        this.iface.tipoRemesa="";
        this.iface.tdbRemesas.refresh();
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

        var tipoRem = curRemesa.valueBuffer("tiporem");
                if (!tipoRem || tipoRem ==""){
                        util.destroyProgressDialog();
                        return false;
        }

        util.setProgress(2);
        if (ac == "cerrar"){

                if (tipoRem == "19"){
                        if (!flfactteso.iface.pub_comprobarCuentasDom(idRemesa)){
                                util.destroyProgressDialog();
                                return false;
                        }
                }

                util.setProgress(3);

                if (tipoRem == "58"){
                        if (!flfactteso.iface.pub_comprobarDireccionesDom(idRemesa)){
                                var continuar = MessageBox.information("¿Desea continuar?",MessageBox.Ok, MessageBox.Cancel);
                                if (continuar != MessageBox.Ok){
                                        util.destroyProgressDialog();
                                        return false;
                                }
                        }
                }
                cerrada = true;
                util.setProgress(4);
        }

        if (ac == "abrir"){
                util.setProgress(3);
                var idPagoRem = util.sqlSelect("pagosdevolrem","idpagorem","idremesa='"+idRemesa+"'");
                if (idPagoRem && idPagoRem!=""){
                        if (tipoConta!="100"){
                                MessageBox.warning("La remesa no puede abrirse, por favor elimine el pago",MessageBox.Ok, MessageBox.NoButton);
                                util.destroyProgressDialog();
                                return false;
                        }
                }

                if (tipoConta == "100" || tipoConta == "110"){
                        var qryRecibos:FLSqlQuery = new FLSqlQuery;
                        qryRecibos.setTablesList("pagosdevolcli");
                        qryRecibos.setSelect("DISTINCT(idrecibo)");
                        qryRecibos.setFrom("pagosdevolcli");
                        qryRecibos.setWhere("idremesa = " + idRemesa);
                        if (!qryRecibos.exec()){
                                util.destroyProgressDialog();
                                return false;
                        }
                        var errorRecibos:String="";
                        while (qryRecibos.next()) {
                        /*Comprueba primero que todos los pagos de los recibos puedan ser eliminados*/
                                if (!formRecordremesas.iface.pub_excluirReciboRemesa(qryRecibos.value(0), idRemesa,true)){
                                        errorRecibos += util.sqlSelect("reciboscli","codigo","idrecibo='"+qryRecibos.value(0)+"'")+"\n";
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
                        var pagoAuto = util.sqlSelect("factteso_general","pagoauto"+tipoRem,"1=1");
                        if (pagoAuto){
                                if (!flfactteso.iface.pagoRemesaAuto(idRemesa, "Insertar")){
                                        util.destroyProgressDialog();
                                        return false;
                                }
                        }
                }else if (ac == "abrir"){
                        var idPagoRem = util.sqlSelect("pagosdevolrem","idpagorem","idremesa='"+idRemesa+"'");
                        if (idPagoRem && idPagoRem!=""){
                                var continuar = MessageBox.information("La remesa esta pagada ¿Desea eliminar automáticamente el pago?", MessageBox.Ok, MessageBox.Cancel);
                                if (continuar != MessageBox.Ok){
                                        util.destroyProgressDialog();
                                        return false;
                                }

                                 if (!flfactteso.iface.pagoRemesaAuto(idRemesa, "Eliminar")){
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

