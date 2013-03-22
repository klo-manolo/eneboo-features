
/** @class_declaration scab */
/////////////////////////////////////////////////////////////////
//// CONTROL STOCK CABECERA /////////////////////////////////////
class scab extends oficial {
    function scab( context ) { oficial ( context ); }
    function controlStockPedidosCli(curLP:FLSqlCursor):Boolean {
        return this.ctx.scab_controlStockPedidosCli(curLP);
    }
    function controlStockProv(curLP:FLSqlCursor):Boolean {
        return this.ctx.scab_controlStockPedidosProv(curLP);
    }
    function controlStockAlbaranesCli(curLA:FLSqlCursor):Boolean {
        return this.ctx.scab_controlStockAlbaranesCli(curLA);
    }
    function controlStockAlbaranesProv(curLA:FLSqlCursor):Boolean {
        return this.ctx.scab_controlStockAlbaranesProv(curLA);
    }
    function controlStockFacturasCli(curLF:FLSqlCursor):Boolean {
        return this.ctx.scab_controlStockFacturasCli(curLF);
    }
    function controlStockComandasCli(curLV:FLSqlCursor):Boolean {
        return this.ctx.scab_controlStockComandasCli(curLV);
    }
    function controlStockFacturasProv(curLF:FLSqlCursor):Boolean {
        return this.ctx.scab_controlStockFacturasProv(curLF);
    }
    function controlStockLineasTrans(curLTS:FLSqlCursor):Boolean {
        return this.ctx.scab_controlStockLineasTrans(curLTS);
    }
    function arraySocksAfectados(arrayInicial:Array, arrayFinal:Array):Array {
        return this.ctx.scab_arraySocksAfectados(arrayInicial, arrayFinal);
    }
    function compararArrayStock(a:Array, b:Array):Number {
        return this.ctx.scab_compararArrayStock(a, b);
    }
    function actualizarStockFisico(referencia:String, codAlmacen:String, campo:String):Boolean {
        return this.ctx.scab_actualizarStockFisico(referencia, codAlmacen, campo);
    }
    function actualizarStockReservado(referencia:String, codAlmacen:String, idPedido:String):Boolean {
        return this.ctx.scab_actualizarStockReservado(referencia, codAlmacen, idPedido);
    }
    function actualizarStockPteRecibir(referencia:String, codAlmacen:String, idPedido:String):Boolean {
        return this.ctx.scab_actualizarStockPteRecibir(referencia, codAlmacen, idPedido);
    }
    function controlStockFisico(curLinea:FLSqlCursor, codAlmacen:String, campo):Boolean {
        return this.ctx.scab_controlStockFisico(curLinea, codAlmacen, campo);
    }
}
//// CONTROL STOCK CABECERA /////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubScab */
/////////////////////////////////////////////////////////////////
//// PUB SCAB ///////////////////////////////////////////////////
class pubScab extends ifaceCtx {
    function pubScab ( context ) { ifaceCtx( context ); }
    function pub_arraySocksAfectados(arrayInicial:Array, arrayFinal:Array):Array {
        return this.arraySocksAfectados(arrayInicial, arrayFinal);
    }
    function pub_actualizarStockReservado(referencia:String, codAlmacen:String, idPedido:String):Boolean {
        return this.actualizarStockReservado(referencia, codAlmacen, idPedido);
    }
    function pub_actualizarStockPteRecibir(referencia:String, codAlmacen:String, idPedido:String):Boolean {
        return this.actualizarStockPteRecibir(referencia, codAlmacen, idPedido);
    }
    function pub_actualizarStockFisico(referencia:String, codAlmacen:String, campo:String):Boolean {
        return this.actualizarStockFisico(referencia, codAlmacen, campo);
    }
}
//// PUB SCAB ///////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition scab */
/////////////////////////////////////////////////////////////////
//// CONTROL STOCKS CABECERA ////////////////////////////////////
/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function scab_controlStockPedidosCli(curLP:FLSqlCursor):Boolean
{
    var util:FLUtil = new FLUtil;
    var curRel:FLSqlCursor = curLP.cursorRelation();
    if (curRel && curRel.action() == "pedidoscli") {
        return true;
    }

    if (!this.iface.__controlStockPedidosCli(curLP)) {
        return false;
    }

    return true;
}

function scab_controlStockPedidosProv(curLP:FLSqlCursor):Boolean
{
    var util:FLUtil = new FLUtil;
    var curRel:FLSqlCursor = curLP.cursorRelation();
    if (curRel && curRel.action() == "pedidosprov") {
        return true;
    }

    if (!this.iface.__controlStockPedidosProv(curLP)) {
        return false;
    }

    return true;
}

function scab_controlStockAlbaranesCli(curLA:FLSqlCursor):Boolean
{
    var util:FLUtil = new FLUtil;
    var curRel:FLSqlCursor = curLA.cursorRelation();
    if (curRel && curRel.action() == "albaranescli") {
        return true;
    }

    var codAlmacen:String = util.sqlSelect("albaranescli", "codalmacen", "idalbaran = " + curLA.valueBuffer("idalbaran"));
    if (!codAlmacen || codAlmacen == "") {
        return true;
    }

    if (!this.iface.controlStockFisico(curLA, codAlmacen, "cantidadac")) {
        return false;
    }

    return true;
}

function scab_controlStockAlbaranesProv(curLA:FLSqlCursor):Boolean
{
    var util:FLUtil = new FLUtil;
    var curRel:FLSqlCursor = curLA.cursorRelation();
    if (curRel && curRel.action() == "albaranesprov") {
        return true;
    }

    var codAlmacen:String = util.sqlSelect("albaranesprov", "codalmacen", "idalbaran = " + curLA.valueBuffer("idalbaran"));
    if (!codAlmacen || codAlmacen == "") {
        return true;
    }

    if (!this.iface.controlStockFisico(curLA, codAlmacen, "cantidadap")) {
        return false;
    }

    return true;
}

function scab_controlStockFacturasCli(curLF:FLSqlCursor):Boolean
{
    var util:FLUtil = new FLUtil;
    var curRel:FLSqlCursor = curLF.cursorRelation();
    if (curRel && curRel.action() == "facturascli") {
        return true;
    }

    if (util.sqlSelect("facturascli", "automatica", "idfactura = " + curLF.valueBuffer("idfactura"))) {
        return true;
    }

    var codAlmacen:String = util.sqlSelect("facturascli", "codalmacen", "idfactura = " + curLF.valueBuffer("idfactura"));
    if (!codAlmacen || codAlmacen == "") {
        return true;
    }

    if (!this.iface.controlStockFisico(curLF, codAlmacen, "cantidadfc")) {
        return false;
    }

    return true;
}

function scab_controlStockFacturasProv(curLF:FLSqlCursor):Boolean
{
    var util:FLUtil = new FLUtil;
    var curRel:FLSqlCursor = curLF.cursorRelation();
    if (curRel && curRel.action() == "facturasprov") {
        return true;
    }

    if (util.sqlSelect("facturasprov", "automatica", "idfactura = " + curLF.valueBuffer("idfactura"))) {
        return true;
    }

    var codAlmacen:String = util.sqlSelect("facturasprov", "codalmacen", "idfactura = " + curLF.valueBuffer("idfactura"));
    if (!codAlmacen || codAlmacen == "") {
        return true;
    }

    if (!this.iface.controlStockFisico(curLF, codAlmacen, "cantidadfp")) {
        return false;
    }

    return true;
}

function scab_controlStockComandasCli(curLV:FLSqlCursor):Boolean
{
debug("scab_controlStockComandasCli");
    var util:FLUtil = new FLUtil();

    var curRel:FLSqlCursor = curLV.cursorRelation();
    if (curRel && curRel.action() == "tpv_comandas") {
        return true;
    }
debug("scab_controlStockComandasCli pasa");
    var codAlmacen = util.sqlSelect("tpv_comandas c INNER JOIN tpv_puntosventa pv ON c.codtpv_puntoventa = pv.codtpv_puntoventa", "pv.codalmacen", "idtpv_comanda = " + curLV.valueBuffer("idtpv_comanda"), "tpv_comandas,tpv_puntosventa");
    if (!codAlmacen || codAlmacen == "") {
        return true;
    }

    if (!this.iface.controlStockFisico(curLV, codAlmacen, "cantidadtpv")) {
        return false;
    }

    return true;
}

function scab_controlStockLineasTrans(curLTS:FLSqlCursor):Boolean
{
debug("scab_controlStockLineasTrans");
    var util:FLUtil = new FLUtil();

    var curRel:FLSqlCursor = curLTS.cursorRelation();
    if (curRel && curRel.action() == "transstock") {
        return true;
    }
debug("scab_controlStockLineasTrans pasa");
    var codAlmacenOrigen:String = util.sqlSelect("transstock", "codalmaorigen", "idtrans = " + curLTS.valueBuffer("idtrans"));
    if (!codAlmacenOrigen || codAlmacenOrigen == "") {
        return true;
    }

    var codAlmacenDestino:String = util.sqlSelect("transstock", "codalmadestino", "idtrans = " + curLTS.valueBuffer("idtrans"));
    if (!codAlmacenDestino || codAlmacenDestino == "") {
        return true;
    }

    if (!this.iface.controlStockFisico(curLTS, codAlmacenOrigen, "cantidadts")) {
        return false;
    }

    if (!this.iface.controlStockFisico(curLTS, codAlmacenDestino, "cantidadts")) {
        return false;
    }

    return true;
}


function scab_arraySocksAfectados(arrayInicial:Array, arrayFinal:Array):Array
{
    var arrayAfectados:Array = [];
    var iAA:Number = 0;
    var iAI:Number = 0;
    var iAF:Number = 0;
    var longAI:Number = arrayInicial.length;
    var longAF:Number = arrayFinal.length;

/*debug("ARRAY INICIAL");
for (var i:Number = 0; i < arrayInicial.length; i++) {
    debug(" " + arrayInicial[i]["idarticulo"] + "-" + arrayInicial[i]["codalmacen"]);
}
debug("ARRAY FINAL");
for (var i:Number = 0; i < arrayFinal.length; i++) {
    debug(" " + arrayFinal[i]["idarticulo"] + "-" + arrayFinal[i]["codalmacen"]);
}
*/
    arrayInicial.sort(this.iface.compararArrayStock);
    arrayFinal.sort(this.iface.compararArrayStock);

/*debug("ARRAY INICIAL ORDENADO");
for (var i:Number = 0; i < arrayInicial.length; i++) {
    debug(" " + arrayInicial[i]["idarticulo"] + "-" + arrayInicial[i]["codalmacen"]);
}
debug("ARRAY FINAL ORDENADO");
for (var i:Number = 0; i < arrayFinal.length; i++) {
    debug(" " + arrayFinal[i]["idarticulo"] + "-" + arrayFinal[i]["codalmacen"]);
}*/
    var comparacion:Number;
    while (iAI < longAI || iAF < longAF) {
        if (iAI < longAI && iAF < longAF) {
            comparacion = this.iface.compararArrayStock(arrayInicial[iAI], arrayFinal[iAF]);
        } else if (iAF < longAF) {
            comparacion = 1;
        } else if (iAI < longAI) {
            comparacion = -1;
        }
        switch (comparacion) {
            case 1: {
                arrayAfectados[iAA] = [];
                arrayAfectados[iAA]["idarticulo"] = arrayFinal[iAF]["idarticulo"];
                arrayAfectados[iAA]["codalmacen"] = arrayFinal[iAF]["codalmacen"];
                iAF++;
                iAA++;
                break;
            }
            case -1: {
                arrayAfectados[iAA] = [];
                arrayAfectados[iAA]["idarticulo"] = arrayInicial[iAI]["idarticulo"];
                arrayAfectados[iAA]["codalmacen"] = arrayInicial[iAI]["codalmacen"];
                iAI++;
                iAA++;
                break;
            }
            case 0: {
                if (arrayInicial[iAI]["cantidad"] != arrayFinal[iAF]["cantidad"]) {
                    arrayAfectados[iAA] = [];
                    arrayAfectados[iAA]["idarticulo"] = arrayFinal[iAI]["idarticulo"];
                    arrayAfectados[iAA]["codalmacen"] = arrayFinal[iAI]["codalmacen"];
                    iAA++;
                }
                iAI++;
                iAF++;
                break;
            }
        }
    }
    return arrayAfectados;
}

function scab_compararArrayStock(a:Array, b:Array):Number
{
    var resultado:Number = 0;
    if (a["codalmacen"] > b["codalmacen"]) {
        resultado = 1;
    } else if (a["codalmacen"] < b["codalmacen"]) {
        resultado = -1;
    } else if (a["codalmacen"] == b["codalmacen"]) {
        if (a["idarticulo"] > b["idarticulo"])  {
            resultado = 1;
        } else if (a["idarticulo"] < b["idarticulo"])  {
            resultado = -1;
        }
    }
    return resultado;
}

function scab_controlStockFisico(curLinea:FLSqlCursor, codAlmacen:String, campo:String):Boolean
{
    var util:FLUtil = new FLUtil;

    var referencia:String = curLinea.valueBuffer("referencia");
    if (util.sqlSelect("articulos", "nostock", "referencia = '" + referencia  + "'")) {
        return true;
    }
debug("Referencia = " + referencia);
    if (referencia && referencia != "") {
debug("Llamando");
        if (!this.iface.actualizarStockFisico(referencia, codAlmacen, campo)) {
            return false;
        }
    }

    var referenciaPrevia:String = curLinea.valueBufferCopy("referencia");
    if (referenciaPrevia && referenciaPrevia != "" && referenciaPrevia != referencia) {
        if (!this.iface.actualizarStockFisico(referenciaPrevia, codAlmacen, campo)) {
            return false;
        }
    }

    return true;
}

function scab_actualizarStockFisico(referencia:String, codAlmacen:String, campo:String):Boolean
{
debug("scab_actualizarStockFisico para " + campo);
    var util:FLUtil = new FLUtil;

    if (util.sqlSelect("articulos", "nostock", "referencia = '" + referencia  + "'")) {
        return true;
    }

    var idStock:String = util.sqlSelect("stocks", "idstock", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "'");
    if ( !idStock ) {
        idStock = this.iface.crearStock( codAlmacen, referencia );
        if ( !idStock ) {
            return false;
        }
    }

    var curStock:FLSqlCursor = new FLSqlCursor("stocks");
    curStock.select("idstock = " + idStock);
    if (!curStock.first()) {
        return false;
    }
    var stockFisico:Number;
    curStock.setModeAccess(curStock.Edit);
    curStock.refreshBuffer();
    curStock.setValueBuffer(campo, formRecordregstocks.iface.pub_commonCalculateField(campo, curStock));

    stockFisico = formRecordregstocks.iface.pub_commonCalculateField("cantidad", curStock);
    if (stockFisico < 0) {
        if (!util.sqlSelect("articulos", "controlstock", "referencia = '" + referencia + "'")) {
            MessageBox.warning( util.translate("scripts", "El artículo %1 no permite ventas sin stock. Este movimiento dejaría el stock de %2 con un valor de %3.\n").arg(referencia).arg(codAlmacen).arg(stockFisico), MessageBox.Ok, MessageBox.NoButton);
            return false;
        }
    }
    curStock.setValueBuffer("cantidad", stockFisico);
    curStock.setValueBuffer("disponible", formRecordregstocks.iface.pub_commonCalculateField("disponible", curStock));
    if (!curStock.commitBuffer()) {
        return false;
    }
    return true;
}

function scab_actualizarStockReservado(referencia:String, codAlmacen:String, idPedido:String):Boolean
{
    var util:FLUtil = new FLUtil;

    if (util.sqlSelect("articulos", "nostock", "referencia = '" + referencia  + "'")) {
        return true;
    }

    var idStock:String = util.sqlSelect("stocks", "idstock", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "'");
    if ( !idStock ) {
        idStock = this.iface.crearStock( codAlmacen, referencia );
        if ( !idStock ) {
            return false;
        }
    }

    var curStock:FLSqlCursor = new FLSqlCursor("stocks");
    curStock.select("idstock = " + idStock);
    if (!curStock.first()) {
        return false;
    }
    var stockFisico:Number;
    curStock.setModeAccess(curStock.Edit);
    curStock.refreshBuffer();
    curStock.setValueBuffer("reservada", formRecordregstocks.iface.pub_commonCalculateField("reservada", curStock, idPedido));
    curStock.setValueBuffer("disponible", formRecordregstocks.iface.pub_commonCalculateField("disponible", curStock));
    if (!curStock.commitBuffer()) {
        return false;
    }

    return true;
}

function scab_actualizarStockPteRecibir(referencia:String, codAlmacen:String, idPedido:String):Boolean
{
    var util:FLUtil = new FLUtil;

    if (util.sqlSelect("articulos", "nostock", "referencia = '" + referencia  + "'")) {
        return true;
    }

    var idStock:String = util.sqlSelect("stocks", "idstock", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "'");
    if ( !idStock ) {
        idStock = this.iface.crearStock( codAlmacen, referencia );
        if ( !idStock ) {
            return false;
        }
    }
    var curStock:FLSqlCursor = new FLSqlCursor("stocks");
    curStock.select("idstock = " + idStock);
    if (!curStock.first()) {
        return false;
    }
    var stockFisico:Number;
    curStock.setModeAccess(curStock.Edit);
    curStock.refreshBuffer();
    curStock.setValueBuffer("pterecibir", formRecordregstocks.iface.pub_commonCalculateField("pterecibir", curStock, idPedido));
    if (!curStock.commitBuffer()) {
        return false;
    }
    return true;
}

//// CONTROL STOCKS CABECERA ////////////////////////////////////
/////////////////////////////////////////////////////////////////

