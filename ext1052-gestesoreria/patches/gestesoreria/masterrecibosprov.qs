
/** @class_declaration recibosmanuales */
//////////////////////////////////////////////////////////////////
//// RECIBOSMANUALES /////////////////////////////////////////////
class recibosmanuales extends proveed {
    var tdbRecords:Object;
    function recibosmanuales( context ) { proveed( context ); }

    function init() {
        return this.ctx.recibosmanuales_init();
    }

    function insertarRecibosManuales(){
        return this.ctx.recibosmanuales_insertarRecibosManuales();
    }

    function refrescarTabla(){
        return this.ctx.recibosmanuales_refrescarTabla();
    }

    function borrarRecibosManualesClicked(){
        return this.ctx.recibosmanuales_borrarRecibosManualesClicked();
    }

    function borrarRecibosManuales(idRecibo:String):Boolean{
        return this.ctx.recibosmanuales_borrarRecibosManuales(idRecibo);
    }

}
//// RECIBOSMANUALES //////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration tiposremprov */
/////////////////////////////////////////////////////////////////
//// TIPOSREMPROV //////////////////////////////////////////////
class tiposremprov extends recibosmanuales {
    var pbnGestionRR:Object;
    function tiposremprov( context ) { recibosmanuales ( context ); }
    function init() {
            this.ctx.tiposremprov_init();
    }
    function gestionRecibosRemesados() {
            return this.ctx.tiposremprov_gestionRecibosRemesados()
    }
    function crearPagoRecibo(idRecibo:String, fechaPago:Date):Boolean {
            return this.ctx.tiposremprov_crearPagoRecibo(idRecibo, fechaPago);
    }
    function crearAnticipoRecibo(idRecibo:String, fecha:Date, documento:String):Boolean {
            return this.ctx.tiposremprov_crearAnticipoRecibo(idRecibo, fecha, documento);
    }
    function generarRegistros(curPA:FLSqlCursor):Boolean {
            return this.ctx.tiposremprov_generarRegistros(curPA);
    }
}
//// TIPOSREMPROV ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition recibosmanuales */
////////////////////////////////////////////////////////////////
//// RECIBOSMANUALES ////////////////////////////////////////////
function recibosmanuales_init()
{
        this.iface.__init();
        this.iface.tdbRecords = this.child("tableDBRecords");
        connect(this.child("toolButtomInsert"), "clicked()", this, "iface.insertarRecibosManuales");
        connect(this.child("toolButtonDelete"), "clicked()", this, "iface.borrarRecibosManualesClicked");
        connect(formRecordrecibosprov, "closed()", this, "iface.refrescarTabla");
}

function recibosmanuales_insertarRecibosManuales()
{

        var curR:FLSqlCursor = new FLSqlCursor("recibosprov");
        curR.insertRecord();

}

function recibosmanuales_refrescarTabla()
{
        if (!this.child("tableDBRecords")) return false;
        this.iface.tdbRecords.refresh();
}

function recibosmanuales_borrarRecibosManualesClicked()
{

        var idRecibo = this.cursor().valueBuffer("idrecibo");

        if (!this.iface.borrarRecibosManuales(idRecibo)){
                return false;
        }
        this.iface.tdbRecords.refresh();
}

function recibosmanuales_borrarRecibosManuales(idRecibo:String):Boolean
{

        var curR:FLSqlCursor =  new FLSqlCursor("recibosprov");
        curR.select("idrecibo='"+idRecibo+"'");
        if (!curR.first()){
                return false;
        }

        var noDel:Boolean = false;

        if (curR.valueBuffer("automatico")==true){
                noDel=true;
        }

        if (curR.valueBuffer("automatico")==false && curR.valueBuffer("estado")!="Emitido"){
                noDel = true;
        }

        if (noDel){
            MessageBox.warning("Solo es posible eliminar recibos creados manualmente y en estado Emitido",MessageBox.Ok, MessageBox.NoButton);
            return false;
        } else {
                curR.setModeAccess(curR.Del);
                curR.refreshBuffer();
                curR.commitBuffer();
                return true;
        }

}

//// RECIBOSMANUALES ////////////////////////////////////////////
////////////////////////////////////////////////////////////////

/** @class_definition tiposremprov */
/////////////////////////////////////////////////////////////////
//// TIPOSREMPROV ///////////////////////////////////////////////
function tiposremprov_init()
{
    this.iface.__init();

    var util:FLUtil = new FLUtil();

    this.iface.pbnGestionRR = this.child("pbnGestionRR");
    connect(this.iface.pbnGestionRR, "clicked()",this, "iface.gestionRecibosRemesados()");

}

function tiposremprov_gestionRecibosRemesados()
{

    var util:FLUtil = new FLUtil();
    util.sqlDelete("pagorecibosremprov","usuario = '" + sys.nameUser() + "'");

    var curPA:FLSqlCursor = new FLSqlCursor("pagorecibosremprov");
    var hoy:Date = new Date();
    curPA.setModeAccess(curPA.Insert);
    curPA.refreshBuffer();
    curPA.setValueBuffer("usuario",  sys.nameUser());
    curPA.setValueBuffer("fechafiltro", hoy);
    curPA.setValueBuffer("fecha", hoy);

    if (!curPA.commitBuffer()) {
        return;
    }

    curPA.select("usuario = '" + sys.nameUser() + "'");
    if (!curPA.first()) {
        return;
    }

    curPA.setModeAccess(curPA.Edit);
    curPA.refreshBuffer();
    curPA.editRecord();

    while (curPA.modeAccess() == curPA.Edit){
        sys.processEvents();
    }

    curPA.select("usuario = '" + sys.nameUser() + "'");
    if (!curPA.first()) {
        return;
    }
    curPA.setModeAccess(curPA.Browse);
    curPA.refreshBuffer();
    curPA.transaction(false);

     try {
        if (!this.iface.generarRegistros(curPA)){
            curPA.rollback();
        } else {
            curPA.commit();
        }
    } catch (e) {
        MessageBox.warning(util.translate("scripts", "Error al generar los Pagos/Anticipos para recibos:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
        curPA.rollback();
    }

    this.iface.tdbRecords.refresh();
}

function tiposremprov_generarRegistros(curPA:FLSqlCursor):Boolean
{
    var util:FLUtil = new FLUtil();
    var recibos:String = curPA.valueBuffer("recibos");
    if(!recibos || recibos == ""){
        return false;
    }

    var arrayRecibos:Array = recibos.split(",");
    var codRecibos:String="";
    var codigo:String="";
    util.createProgressDialog(util.translate("scripts", "Generando Registros..."), arrayRecibos.length);
    util.setProgress(0);
    var n:Number=0;

    for (var i=0; i<arrayRecibos.length; i++) {
        util.setProgress(i)

        if (curPA.valueBuffer("tipo") == "Anticipo") {
            if(!this.iface.crearAnticipoRecibo(arrayRecibos[i], curPA.valueBuffer("fecha"), curPA.valueBuffer("documento"))) {
                n++;
                codigo = util.sqlSelect("recibosprov","codigo","idrecibo="+arrayRecibos[i]);
                codRecibos+= codigo+"\n";
            }
        } else if (curPA.valueBuffer("tipo") == "Pago") {
            if(!this.iface.crearPagoRecibo(arrayRecibos[i], curPA.valueBuffer("fecha"))) {
                n++;
                codigo = util.sqlSelect("recibosprov","codigo","idrecibo="+arrayRecibos[i]);
                codRecibos+= codigo+"\n";
            }
        }

        util.setProgress(arrayRecibos.length);
        util.destroyProgressDialog();
        if (n==1) {
            MessageBox.warning("Se encontró un recibo que no se pudo pagar/anticipar:\n"+codRecibos+"Compruebe las fechas de los ultimos pagos o devoluciones",MessageBox.Ok, MessageBox.NoButton);
        }
        if (n>1) {
            MessageBox.warning("Se encontraron "+n+" recibos que no se pudieron pagar/anticipar:\n"+codRecibos+"Compruebe las fechas de los últimos pagos o devoluciones",MessageBox.Ok, MessageBox.NoButton);
        }
    }

    return true;
}

function tiposremprov_crearAnticipoRecibo(idRecibo:String, fecha:Date, documento:String):Boolean
{
    var util:FLUtil = new FLUtil();

    var hoy:Date = new Date();
    if (fecha && fecha!=""){
        hoy = fecha;
    }

    var idRemesa = util.sqlSelect("recibosprov","idremesa","idrecibo="+idRecibo);
    if (!idRemesa || idRemesa==""){
        return false;
    }

    var cerrada = util.sqlSelect("remesasprov","cerrada","idremesa='"+idRemesa+"'");
    if (cerrada == false){
        return false;
    }

    var curAC:FLSqlCursor = new FLSqlCursor("anticiposconf");
    curAC.setModeAccess(curAC.Insert);
    curAC.refreshBuffer();
    curAC.setValueBuffer("idremesa", idRemesa);
    curAC.setValueBuffer("idrecibo", idRecibo);
    curAC.setValueBuffer("fecha", hoy);
    curAC.setValueBuffer("documento", documento);

    if (!curAC.commitBuffer()){
        return false;
    }

    return true;
}

function tiposremprov_crearPagoRecibo(idRecibo:String, fechaPago:Date):Boolean
{
    var util:FLUtil = new FLUtil();

    var hoy:Date = new Date();
    if (fechaPago && fechaPago!=""){
        hoy = fechaPago;
    }

    var idRemesa = util.sqlSelect("recibosprov","idremesa","idrecibo="+idRecibo);
    if (!idRemesa || idRemesa==""){
        return false;
    }

    var nogenAsiento=false;

    var remesa:Array= flfactppal.iface.pub_ejecutarQry("remesasprov", "tipoconta,codcuenta,codsubcuenta,idsubcuenta,codsubcuentaecgp,idsubcuentaecgp,idremesa", "idremesa='"+idRemesa+"'");

    if (!flfactteso.iface.generarPagoRecibosProv(idRecibo,remesa,hoy,nogenAsiento)){
        return false;
    }

    return true;
}
//// TIPOSREMPROV ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

