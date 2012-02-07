
/** @class_declaration gestesoreria */
/////////////////////////////////////////////////////////////////
//// GESTESORERIA //////////////////////////////////////////////
class gestesoreria extends compRecibos {
    var pbnGestionRR:Object;
    function gestesoreria( context ) { compRecibos ( context ); }
    function init() {
            this.ctx.gestesoreria_init();
    }
    function pagoRecibosRemesados() {
            return this.ctx.gestesoreria_pagoRecibosRemesados()
    }
    function crearPagoRecibo(idRecibo:String, fechaPago:Date):Boolean {
            return this.ctx.gestesoreria_crearPagoRecibo(idRecibo, fechaPago);
    }
    function generarRecibos(recibos:String, fechaPago:Date):Boolean {
            return this.ctx.gestesoreria_generarRecibos(recibos, fechaPago);
    }
}
//// GESTESORERIA ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration recibosmanuales */
//////////////////////////////////////////////////////////////////
//// RECIBOSMANUALES /////////////////////////////////////////////
class recibosmanuales extends gestesoreria {
    var tdbRecords:Object;
    function recibosmanuales( context ) { gestesoreria( context ); }

    function init() {
        return this.ctx.recibosmanuales_init();
    }

    function insertarRecibosManuales(){
        return this.ctx.recibosmanuales_insertarRecibosManuales();
    }

    function borrarRecibosManualesClicked(){
        return this.ctx.recibosmanuales_borrarRecibosManualesClicked();
    }

    function borrarRecibosManuales(idRecibo:String):Boolean{
        return this.ctx.recibosmanuales_borrarRecibosManuales(idRecibo);
    }
    function refrescarTabla(){
        return this.ctx.recibosmanuales_refrescarTabla();
    }
}
//// RECIBOSMANUALES //////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition gestesoreria */
/////////////////////////////////////////////////////////////////
//// GESTESORERIA ///////////////////////////////////////////////
function gestesoreria_init()
{
	this.iface.__init();

	var util:FLUtil = new FLUtil();

	this.iface.pbnGestionRR = this.child("pbnGestionRR");
	connect(this.iface.pbnGestionRR, "clicked()",this, "iface.pagoRecibosRemesados()");

}

function gestesoreria_pagoRecibosRemesados()
{

    var util:FLUtil = new FLUtil();
    util.sqlDelete("pagorecibosrem","usuario = '" + sys.nameUser() + "'");

    var curPA:FLSqlCursor = new FLSqlCursor("pagorecibosrem");
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
        if (!this.iface.generarRecibos(curPA.valueBuffer("recibos"),curPA.valueBuffer("fecha"))){
            curPA.rollback();
        } else {
            curPA.commit();
        }
    } catch (e) {
        MessageBox.warning(util.translate("scripts", "Error al generar los Pagos para recibos:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
        curPA.rollback();
    }

    this.iface.tdbRecords.refresh();
}


function gestesoreria_generarRecibos(recibos:String, fechaPago:Date):Boolean
{
    var util:FLUtil = new FLUtil();
    if(recibos && recibos != "") {
            var arrayRecibos:Array = recibos.split(",");
            var codRecibos:String="";
            util.createProgressDialog(util.translate("scripts", "Generando pagos..."), arrayRecibos.length);
            util.setProgress(0);
            var n:Number=0;
            for (var i=0;i<arrayRecibos.length;i++) {
                    util.setProgress(i)
                    if(!this.iface.crearPagoRecibo(arrayRecibos[i], fechaPago)) {
                        n++; // Devuelve false, no se completa el recibo
                        var codigo = util.sqlSelect("reciboscli","codigo","idrecibo='"+arrayRecibos[i]+"'");
                        codRecibos+= codigo+"\n";
                    }
            }
            util.setProgress(arrayRecibos.length);
            util.destroyProgressDialog();
            if (n==1) {
                    MessageBox.warning("Se encontró un recibo que no se pudo pagar:\n"+codRecibos+"Compruebe las fechas de los ultimos pagos o devoluciones",MessageBox.Ok, MessageBox.NoButton);
            }
            if (n>1) {
                    MessageBox.warning("Se encontraron "+n+" recibos que no se pudieron pagar:\n"+codRecibos+"Compruebe las fechas de los últimos pagos o devoluciones",MessageBox.Ok, MessageBox.NoButton);
            }
    }

    return true;
}

function gestesoreria_crearPagoRecibo(idRecibo:String, fechaPago:Date):Boolean
{
	var util:FLUtil = new FLUtil();

	var hoy:Date = new Date();
        if (fechaPago && fechaPago!="")
                hoy = fechaPago;

	var idRemesa = util.sqlSelect("reciboscli","idremesa","idrecibo='"+idRecibo+"'");
        if (!idRemesa || idRemesa=="") return false;

        var nogenAsiento=false;

	var remesa:Array= flfactppal.iface.pub_ejecutarQry("remesas", "tipoconta,codcuenta,codsubcuenta,idsubcuenta,codsubcuentaecgc,idsubcuentaecgc,idremesa", "idremesa='"+idRemesa+"'");

	if (!flfactteso.iface.generarPagoRecibosCli(idRecibo,remesa,hoy,nogenAsiento))
        return false;

    return true;
}
//// GESTESORERIA ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//// RECIBOSMULTICLI ////////////////////////////////////////////
////////////////////////////////////////////////////////////////

/** @class_definition recibosmanuales */
////////////////////////////////////////////////////////////////
//// RECIBOSMANUALES ////////////////////////////////////////////
function recibosmanuales_init(){

        this.iface.__init();
        this.iface.tdbRecords = this.child("tableDBRecords");
        connect(this.child("toolButtomInsert"), "clicked()", this, "iface.insertarRecibosManuales");
        connect(this.child("toolButtonDelete"), "clicked()", this, "iface.borrarRecibosManualesClicked");
        connect(formRecordrecibosprov, "closed()", this, "iface.refrescarTabla");
}

function recibosmanuales_insertarRecibosManuales(){

        var curR:FLSqlCursor = new FLSqlCursor("reciboscli");
        curR.insertRecord();
        this.iface.tdbRecords.refresh();
}

function recibosmanuales_borrarRecibosManualesClicked(){

        var ok = MessageBox.information("El registro activo será borrado. ¿Esta seguro?", MessageBox.Ok, MessageBox.Cancel);
        if (ok!=MessageBox.Ok) return;

        var idRecibo = this.cursor().valueBuffer("idrecibo");

        if (!this.iface.borrarRecibosManuales(idRecibo)){
                return false;
        }
        this.iface.tdbRecords.refresh();
}

function recibosmanuales_borrarRecibosManuales(idRecibo:String):Boolean{

        var curR:FLSqlCursor =  new FLSqlCursor("reciboscli");
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
                if (!curR.commitBuffer()) return false;
                return true;
        }

}

function recibosmanuales_refrescarTabla()
{
        if (!this.child("tableDBRecords")) return false;
        this.iface.tdbRecords.refresh();
}

//// RECIBOSMANUALES ////////////////////////////////////////////
////////////////////////////////////////////////////////////////

