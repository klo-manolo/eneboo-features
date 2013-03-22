
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
    qryStocks.setTablesList("albaranescli,lineasalbaranescli");
    qryStocks.setSelect("la.referencia, SUM(la.cantidad)");
    qryStocks.setFrom("albaranescli a INNER JOIN lineasalbaranescli la ON a.idalbaran = la.idalbaran");
    qryStocks.setWhere("a.idalbaran = " + cursor.valueBuffer("idalbaran") + " AND la.referencia IS NOT NULL GROUP BY a.codalmacen, la.referencia");
    qryStocks.setForwardOnly(true);
    if (!qryStocks.exec()) {
        return false;
    }
    var i:Number = 0;
    while (qryStocks.next()) {
        arrayStocks[i] = [];
        arrayStocks[i]["idarticulo"] = qryStocks.value("la.referencia");
        arrayStocks[i]["codalmacen"] = cursor.valueBuffer("codalmacen");
        arrayStocks[i]["cantidad"] = qryStocks.value("SUM(la.cantidad)");
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
        if (!flfactalma.iface.pub_actualizarStockFisico(arrayAfectados[i]["idarticulo"], arrayAfectados[i]["codalmacen"], "cantidadac")) {
            return false;
        }
    }

    return true;
}

//// CONTROL STOCK CABECERA /////////////////////////////////////
/////////////////////////////////////////////////////////////////

