
/** @class_declaration scab */
/////////////////////////////////////////////////////////////////
//// CONTROL STOCK CABECERA /////////////////////////////////////
class scab extends oficial {
    var arrayStocks_:Array;
    function scab( context ) { oficial ( context ); }
    function init() {
        return this.ctx.scab_init();
    }
    function validateForm():Boolean {
        return this.ctx.scab_validateForm();
    }
    function cargarArrayStocks():Boolean {
        return this.ctx.scab_cargarArrayStocks();
    }
    function controlStockCabecera():Boolean {
        return this.ctx.scab_controlStockCabecera();
    }
}
//// CONTROL STOCK CABECERA /////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition scab */
/////////////////////////////////////////////////////////////////
//// CONTROL STOCK CABECERA /////////////////////////////////////
function scab_init()
{
    this.iface.__init();

    var util:FLUtil = new FLUtil;

    this.iface.arrayStocks_ = this.iface.cargarArrayStocks();
    if (!this.iface.arrayStocks_) {
        MessageBox.warning(util.translate("scripts", "Error al cargar los datos de stock"), MessageBox.Ok, MessageBox.NoButton);
        return false;
    }
}

function scab_cargarArrayStocks():Array
{
    var util:FLUtil = new FLUtil;
    var cursor:FLSqlCursor = this.cursor();
    var arrayStocks:Array = [];

    var qryStocks:FLSqlQuery = new FLSqlQuery;
    qryStocks.setTablesList("transstock,lineastransstock");
    qryStocks.setSelect("t.codalmaorigen, lt.referencia, SUM(lt.cantidad)");
    qryStocks.setFrom("transstock t INNER JOIN lineastransstock lt ON t.idtrans = lt.idtrans");
    qryStocks.setWhere("t.idtrans = " + cursor.valueBuffer("idtrans") + " GROUP BY t.codalmaorigen, lt.referencia");
    qryStocks.setForwardOnly(true);
    if (!qryStocks.exec()) {
        return false;
    }
    var i:Number = 0;
    while (qryStocks.next()) {
        arrayStocks[i] = [];
        arrayStocks[i]["idarticulo"] = qryStocks.value("lt.referencia");
        arrayStocks[i]["codalmacen"] = qryStocks.value("t.codalmaorigen");
        arrayStocks[i]["cantidad"] = qryStocks.value("SUM(lt.cantidad)");
        i++;
    }

    qryStocks.setSelect("t.codalmadestino, lt.referencia, SUM(lt.cantidad)");
    qryStocks.setWhere("t.idtrans = " + cursor.valueBuffer("idtrans") + " GROUP BY t.codalmadestino, lt.referencia");
    if (!qryStocks.exec()) {
        return false;
    }
    while (qryStocks.next()) {
        arrayStocks[i] = [];
        arrayStocks[i]["idarticulo"] = qryStocks.value("lt.referencia");
        arrayStocks[i]["codalmacen"] = qryStocks.value("t.codalmadestino");
        arrayStocks[i]["cantidad"] = qryStocks.value("SUM(lt.cantidad)");
        i++;
    }
    return arrayStocks;
}

function scab_validateForm():Boolean
{
    if (!this.iface.__validateForm()) {
        return false;
    }

    if (!this.iface.controlStockCabecera()) {
        return false;
    }

    return true;
}

function scab_controlStockCabecera():Boolean
{
    var util:FLUtil = new FLUtil;
    var cursor:FLSqlCursor = this.cursor();

    var arrayActual:Array = this.iface.cargarArrayStocks();
    if (!arrayActual) {
        MessageBox.warning(util.translate("scripts", "Error al cargar los datos de stock"), MessageBox.Ok, MessageBox.NoButton);
        return false;
    }

    var arrayAfectados:Array = flfactalma.iface.pub_arraySocksAfectados(this.iface.arrayStocks_, arrayActual);
    if (!arrayAfectados) {
        return false;
    }
    for (var i:Number = 0; i < arrayAfectados.length; i++) {
        if (!flfactalma.iface.pub_actualizarStockFisico(arrayAfectados[i]["idarticulo"], arrayAfectados[i]["codalmacen"], "cantidadts")) {
            return false;
        }
    }

    return true;
}

//// CONTROL STOCK CABECERA /////////////////////////////////////
/////////////////////////////////////////////////////////////////

