
/** @class_declaration scab */
/////////////////////////////////////////////////////////////////
//// STOCKS CABECERA ////////////////////////////////////////////
class scab extends oficial {
    var tbnRevisarStock:Object;
    function scab( context ) { oficial ( context ); }
    function init() {
        return this.ctx.scab_init();
    }
    function tbnRevisarStock_clicked() {
        return this.ctx.scab_tbnRevisarStock_clicked();
    }
    function revisarStock(where:String):Boolean {
        return this.ctx.scab_revisarStock(where);
    }
}
//// STOCKS CABECERA ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition scab */
/////////////////////////////////////////////////////////////////
//// STOCKS CABECERA ////////////////////////////////////////////
function scab_init()
{
    this.iface.__init();
    this.iface.tbnRevisarStock = this.child("tbnRevisarStock");

    connect (this.iface.tbnRevisarStock, "clicked()", this, "iface.tbnRevisarStock_clicked");
}

function scab_tbnRevisarStock_clicked()
{
    var util:FLUtil = new FLUtil;
    var cursor:FLSqlCursor = this.cursor();

    var codAlmacen:String = cursor.valueBuffer("codalmacen");
    if (!codAlmacen || codAlmacen == "") {
        return false;
    }

    var arrayOps:Array = [];
    arrayOps[0] = util.translate("scripts", "Actualizar el stock seleccionado");
    arrayOps[1] = util.translate("scripts", "Actualizar los stocks de %1").arg(codAlmacen);
    arrayOps[2] = util.translate("scripts", "Actualizar todos los stocks");

    var dialogo = new Dialog;
    dialogo.okButtonText = util.translate("scripts", "Aceptar");
    dialogo.cancelButtonText = util.translate("scripts", "Cancelar");

    var gbxDialogo = new GroupBox;
    gbxDialogo.title = util.translate("scripts", "Seleccione opción");

    var rButton:Array = new Array(arrayOps.length);
    for (var i:Number = 0; i < rButton.length; i++) {
        rButton[i] = new RadioButton;
        rButton[i].text = arrayOps[i];
        rButton[i].checked = false;
        gbxDialogo.add(rButton[i]);
    }

    dialogo.add(gbxDialogo);
    if (!dialogo.exec()) {
        return false;
    }
    var seleccion:Number = -1;
    for (var i:Number = 0; i < rButton.length; i++) {
        if (rButton[i].checked) {
            seleccion = i;
            break;
        }
    }
    if (seleccion == -1) {
        return false;
    }
    var where:String;
    switch (seleccion) {
        case 0: {
            where = "idstock = " + cursor.valueBuffer("idstock");
            break;
        }
        case 1: {
            where = "codalmacen = '" + codAlmacen + "'";
            break;
        }
        case 2: {
            where = "1 = 1";
            break;
        }
    }
    var curTransaccion:FLSqlCursor = new FLSqlCursor("empresa");
    curTransaccion.transaction(false);
    try {
        if (this.iface.revisarStock(where)) {
            curTransaccion.commit();
        } else {
            curTransaccion.rollback();
            MessageBox.warning(util.translate("scripts", "Error al revisar el stock"), MessageBox.Ok, MessageBox.NoButton);
            return false;
        }
    } catch(e) {
        curTransaccion.rollback();
        MessageBox.warning(util.translate("scripts", "Error al revisar el stock:") + e, MessageBox.Ok, MessageBox.NoButton);
        return false;
    }
    this.child("tdbRegStocks").refresh();
}

function scab_revisarStock(where:String):Boolean
{
    var util:FLUtil = new FLUtil;

    var curStock:FLSqlCursor = new FLSqlCursor("stocks");
    curStock.select(where);
    util.createProgressDialog(util.translate("scripts", "Revisando stocks..."), curStock.size());
    var paso:Number = 0;
    var canUltReg:Number;
    while (curStock.next()) {
        util.setProgress(++paso);
        curStock.setModeAccess(curStock.Edit);
        curStock.refreshBuffer();
        curStock.setValueBuffer("fechaultreg", formRecordregstocks.iface.pub_commonCalculateField("fechaultreg", curStock));
        curStock.setValueBuffer("horaultreg", formRecordregstocks.iface.pub_commonCalculateField("horaultreg", curStock));
        canUltReg = formRecordregstocks.iface.pub_commonCalculateField("cantidadultreg", curStock);
        if (!canUltReg || isNaN(canUltReg)) {
            canUltReg = 0;
        }
        curStock.setValueBuffer("cantidadultreg", canUltReg);
        curStock.setValueBuffer("reservada", formRecordregstocks.iface.pub_commonCalculateField("reservada", curStock));
        curStock.setValueBuffer("pterecibir", formRecordregstocks.iface.pub_commonCalculateField("pterecibir", curStock));
        curStock.setValueBuffer("cantidadac", formRecordregstocks.iface.pub_commonCalculateField("cantidadac", curStock));
        curStock.setValueBuffer("cantidadap", formRecordregstocks.iface.pub_commonCalculateField("cantidadap", curStock));
        curStock.setValueBuffer("cantidadfc", formRecordregstocks.iface.pub_commonCalculateField("cantidadfc", curStock));
        curStock.setValueBuffer("cantidadfp", formRecordregstocks.iface.pub_commonCalculateField("cantidadfp", curStock));
        curStock.setValueBuffer("cantidadts", formRecordregstocks.iface.pub_commonCalculateField("cantidadts", curStock));
        if (sys.isLoadedModule("flfact_tpv")) {
            curStock.setValueBuffer("cantidadtpv", formRecordregstocks.iface.pub_commonCalculateField("cantidadtpv", curStock));
        }
        curStock.setValueBuffer("cantidad", formRecordregstocks.iface.pub_commonCalculateField("cantidad", curStock));
        curStock.setValueBuffer("disponible", formRecordregstocks.iface.pub_commonCalculateField("disponible", curStock));
        if (!curStock.commitBuffer()) {
            util.destroyProgressDialog();
            return false;
        }
    }
    util.destroyProgressDialog();
    return true;
}
//// STOCKS CABECERA ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

