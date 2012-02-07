
/** @class_declaration gestesoreria */
/////////////////////////////////////////////////////////////////
//// GESTESORERIA /////// ////////////////////////////////////
class gestesoreria extends compRecibos {
    function gestesoreria( context ) { compRecibos ( context ); }

    function cambiarEstado() {
        return this.ctx.gestesoreria_cambiarEstado();
    }

    function obtenerEstado(idRecibo:String):String {
        return this.ctx.gestesoreria_obtenerEstado(idRecibo)
    }
}
//// GESTESORERIA ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration recibosmulticli */
//////////////////////////////////////////////////////////////////
//// RECIBOSMULTICLI /////////////////////////////////////////////
class recibosmulticli extends gestesoreria {
    function recibosmulticli( context ) { gestesoreria( context ); }
    function copiarCampoReciboDiv(nombreCampo:String, cursor:FLSqlCursor, campoInformado:Array):Boolean {
            return this.ctx.recibosmulticli_copiarCampoReciboDiv(nombreCampo, cursor, campoInformado);
    }
}
//// RECIBOSMULTICLI //////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration recibosmanuales */
//////////////////////////////////////////////////////////////////
//// RECIBOSMANUALES /////////////////////////////////////////////
class recibosmanuales extends recibosmulticli {
    function recibosmanuales( context ) { recibosmulticli( context ); }

    function init() {
        return this.ctx.recibosmanuales_init();
    }

    function generarCodigo(codEjercicio:String, codSerie:String, idFactura:String):String {
        return this.ctx.recibosmanuales_generarCodigo(codEjercicio, codSerie, idFactura);
    }

    function bufferChanged(fN:String) {
        return this.ctx.recibosmanuales_bufferChanged(fN);
    }

    function validateForm():Boolean {
        return this.ctx.recibosmanuales_validateForm();
    }

    function copiarCampoReciboDiv(nombreCampo:String, cursor:FLSqlCursor, campoInformado:Array):Boolean {
            return this.ctx.recibosmanuales_copiarCampoReciboDiv(nombreCampo, cursor, campoInformado);
    }

    function divisionRecibo() {
            return this.ctx.recibosmanuales_divisionRecibo();
    }

    function calculateField(fN:String):String {
        return this.ctx.recibosmanuales_calculateField(fN);
    }
}
//// RECIBOSMANUALES //////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition gestesoreria */
/////////////////////////////////////////////////////////////////
//// GESTESORERIA //////////////////////////////////////////////
function gestesoreria_obtenerEstado(idRecibo:String):String
{
        var util:FLUtil = new FLUtil;
        var valor:String = "Emitido";

        var curPagosDevol:FLSqlCursor = new FLSqlCursor("pagosdevolcli");
        curPagosDevol.select("idrecibo = " + idRecibo + " ORDER BY fecha DESC, idpagodevol DESC");
        if (curPagosDevol.first()) {
                curPagosDevol.setModeAccess(curPagosDevol.Browse);
                curPagosDevol.refreshBuffer();
                if (curPagosDevol.valueBuffer("tipo") == "Pago"){
                        valor = "Pagado";
                        if (curPagosDevol.valueBuffer("idremesa") && curPagosDevol.valueBuffer("idremesa")!=""){
                                var hoy:Date = new Date();
                                var fechamate = util.sqlSelect("reciboscli","fechamate","idrecibo='"+idRecibo+"'");
                                if (fechamate>hoy){
                                        valor = "Riesgo"
                                }
                        }
                }else{
                        valor = "Devuelto";
                }
        }

        var idremesa = util.sqlSelect("reciboscli","idremesa","idrecibo='"+idRecibo+"'");
        if (idremesa!=0 || idremesa!=""){
                var pagosdevol = util.sqlSelect("pagosdevolcli", "idpagodevol", "idrecibo = " + idRecibo + " AND idremesa ='"+idremesa+"'");
                if (!pagosdevol)
                        valor = "Remesado";
        }

        var idComp = util.sqlSelect("reciboscli","idrecibocomp","idrecibo='"+idRecibo+"'");
        if (idComp && idComp!=""){
                        valor = "Compensado";
        }

        var idAg = util.sqlSelect("reciboscli","idrecibomulti","idrecibo='"+idRecibo+"'");
        if (idAg && idAg!=""){
                        valor = "Agrupado";
        }

        return valor;
}
function gestesoreria_cambiarEstado()
{
        var util:FLUtil = new FLUtil;
        var cursor:FLSqlCursor = this.cursor();

        if (cursor.valueBuffer("estado") != "Compensado" && cursor.valueBuffer("estado") != "Agrupado"){
                this.child("fdbEstado").setValue(this.iface.calculateField("estado"));
        }

        if (cursor.modeAccess()!=cursor.Edit){
                return;
        }

        var habBotones:Boolean = true;

        switch (cursor.valueBuffer("estado")){
            case "Emitido":{
                this.child("fdbImporte").setDisabled(false);
                this.child("fdbFechav").setDisabled(false);
                this.child("gbxCuenta").setDisabled(false);
                this.child("coddir").setDisabled(false);
                if (cursor.valueBuffer("idfactura")){
                    this.child("fdbFecha").setDisabled(true);
                }else{
                        this.child("fdbFecha").setDisabled(false);
                }
                break;
            }
            case "Devuelto": {
                this.child("fdbImporte").setDisabled(true);
                this.child("fdbFechav").setDisabled(false);
                this.child("fdbFecha").setDisabled(true);
                this.child("fdbFecha2").setDisabled(true);
                this.child("gbxCuenta").setDisabled(false);
                this.child("coddir").setDisabled(true);
                break;
            }

            case "Riesgo":
            case "Pagado":{
                this.child("fdbImporte").setDisabled(true);
                this.child("fdbFechav").setDisabled(true);
                this.child("fdbFecha").setDisabled(true);
                this.child("fdbFecha2").setDisabled(true);
                this.child("coddir").setDisabled(true);
                this.child("gbxCuenta").setDisabled(true);
                var tipoconta = "";
                var idremesa = util.sqlSelect("pagosdevolcli","idremesa","idrecibo='"+cursor.valueBuffer("idrecibo")+"' ORDER BY idpagodevol DESC, fecha DESC");
                if (idremesa && idremesa!="") tipoconta = util.sqlSelect("remesas","tipoconta","idremesa='"+idremesa+"'");
                if (tipoconta=="100" || tipoconta =="110"){
                        habBotones = false;
                }
                    break;
            }
            case "Remesado":{
                this.child("lblRemesado").text = "Remesado en: "+cursor.valueBuffer("idremesa");
                this.child("tdbPagosDevolCli").setInsertOnly(true);
                this.child("toolButtomInsert").enabled = false;
                habBotones = false;
                this.child("fdbImporte").setDisabled(true);
                this.child("fdbFechav").setDisabled(true);
                this.child("fdbFecha").setDisabled(true);
                this.child("fdbFecha2").setDisabled(true);
                this.child("gbxCuenta").setDisabled(true);
                this.child("coddir").setDisabled(true);
                    break;
                }

            case "Agrupado":{
                this.child("lblRemesado").text = "Agrupado en: " + util.sqlSelect("recibosmulticli", "codigo", "idrecibomulti = " + cursor.valueBuffer("idrecibomulti"));
                this.child("tdbPagosDevolCli").setReadOnly(true);
                this.child("fdbImporte").setDisabled(true);
                this.child("fdbFecha").setDisabled(true);
                this.child("fdbFecha2").setDisabled(true);
                this.child("fdbFechav").setDisabled(true);
                this.child("gbxCuenta").setDisabled(true);
                this.child("coddir").setDisabled(true);
                this.child("toolButtomInsert").enabled = false;
                habBotones = false;
                this.child("toolButtonZoom").enabled = false;
                break;
            }

            case "Compensado":{
                this.child("lblRemesado").text = "Compensado con: " + util.sqlSelect("reciboscli", "codigo", "idrecibo = " + cursor.valueBuffer("idrecibocomp"));
                this.child("tdbPagosDevolCli").setReadOnly(true);
                this.child("fdbImporte").setDisabled(true);
                this.child("fdbFechav").setDisabled(true);
                this.child("fdbFecha").setDisabled(true);
                this.child("fdbFecha2").setDisabled(true);
                this.child("gbxCuenta").setDisabled(true);
                this.child("coddir").setDisabled(true);
                this.child("toolButtomInsert").enabled = false;
                habBotones = false;
                this.child("toolButtonZoom").enabled = false;
                break;
            }
        }

        this.child("toolButtonDelete").enabled = habBotones;
        this.child("toolButtonEdit").enabled = habBotones;

        if (!this.iface.bloqueoInit_) {
                this.child("fdbGastoDevol").setValue(this.iface.calculateField("gastodevol"));
                this.child("fdbImporte").setValue(this.iface.calculateField("importe"));
        }

}
//// GESTESORERIA ////////////////////////////////////////////
////////////////////////////////////////////////////////////////

/** @class_definition recibosmulticli */
///////////////////////////=//////////////////////////////////////
//// RECIBOSMULTICLI ////////////////////////////////////////////
function recibosmulticli_copiarCampoReciboDiv(nombreCampo:String, cursor:FLSqlCursor, campoInformado:Array):Boolean
{
    var util:FLUtil = new FLUtil;

    if (campoInformado[nombreCampo]) {
        return true;
    }
    var nulo:Boolean =false;

    if (!cursor){
        cursor = this.cursor();
    }

    switch (nombreCampo) {
        case "numero":
            if (!campoInformado["idfactura"]) {
                if (!this.iface.copiarCampoReciboDiv("idfactura", cursor, campoInformado)) {
                    return false;
                }
            }
            var idFactura = campoInformado["idfactura"];
            if (idFactura && idFactura!=0){
                valor =  parseInt(util.sqlSelect("reciboscli", "numero", "idfactura = " + idFactura + " ORDER BY numero DESC")) + 1;
            } else {
                valor = parseInt(util.sqlSelect("reciboscli", "MAX(numero)+1","substring(codigo from 0 for 13) = (substring('"+cursor.valueBuffer("codigo")+"' from 0 for 13))"));
            }
            break;

        case "codigo":
            if (!campoInformado["numero"]) {
                if (!this.iface.copiarCampoReciboDiv("numero", cursor, campoInformado)) {
                    return false;
                }
            }
            valor = cursor.valueBuffer("codigo").left(12) + "-" + flfacturac.iface.pub_cerosIzquierda(cursor.valueBuffer("numero"), 2);
            break;

        case "tasaconv":
            if (!campoInformado["idfactura"]) {
                if (!this.iface.copiarCampoReciboDiv("idfactura", cursor, campoInformado)) {
                    return false;
                }
            }
            var idFactura = campoInformado["idfactura"];
            if (idFactura && idFactura!=0){
                valor = parseFloat(util.sqlSelect("facturascli", "tasaconv", "idfactura = " + cursor.valueBuffer("idfactura")));
            } else {
                valor = parseFloat(util.sqlSelect("recibosmulticli", "tasaconv", "idrecibogen = " + cursor.valueBuffer("idrecibo")));
                if (!valor){
                    valor = parseFloat(util.sqlSelect("recibosmulticli", "tasaconv","codigo like (select substring(codigo from 0 for 13) from reciboscli where idrecibo='"+cursor.valueBuffer("idrecibo")+"')"));
                }
            }
            break;

            default:
                if (!this.iface.__copiarCampoReciboDiv(nombreCampo, cursor, campoInformado)) {
                    return false;
                }
                return true;

        }

        if (nulo) {
                this.iface.curReciboDiv.setNull(nombreCampo);
        } else {
                this.iface.curReciboDiv.setValueBuffer(nombreCampo, valor);
        }
        campoInformado[nombreCampo] = true;

        return true;
}
//// RECIBOSMULTICLI ////////////////////////////////////////////
////////////////////////////////////////////////////////////////

/** @class_definition recibosmanuales */
////////////////////////////////////////////////////////////////
//// RECIBOSMANUALES ////////////////////////////////////////////
function recibosmanuales_init(){

    this.iface.__init();

    var util:FLUtil = new FLUtil();
    var hoy:Date = new Date();
    var cursor:FLSqlCursor = this.cursor();

    var idfactura:String;
    if (cursor.modeAccess()==cursor.Insert){
            idfactura = formfacturascli.iface.idFacturaCli;
    } else{
            idfactura = cursor.valueBuffer("idfactura")
    }

    if (!idfactura){
        this.child("tabWidget24").setTabEnabled("datosfactura", false);
    }else{
        this.child("tabWidget24").setTabEnabled("datosrecibo", false);
    }

    var deshab:Boolean;
    switch (cursor.modeAccess()){
            case cursor.Insert:
                    cursor.setValueBuffer("codejercicio",flfactppal.iface.pub_ejercicioActual());
                    cursor.setValueBuffer("fecha",hoy);
                    cursor.setValueBuffer("fechav",hoy);
                    cursor.setValueBuffer("fechamate",hoy);
                    cursor.setValueBuffer("automatico",false);

                    if (!idfactura){
                            /*Creación de recibos completamente manuales*/
                            deshab=false;
                            cursor.setValueBuffer("codserie",flfactppal.iface.pub_valorDefectoEmpresa("codserie"));
                            cursor.setValueBuffer("coddivisa",flfactppal.iface.pub_valorDefectoEmpresa("coddivisa"));
                            cursor.setValueBuffer("numero",1);
                    } else {
                            /*Creación de recibos manuales desde facturas, se relaciona con el id y el codigo de factura*/
                            deshab=true;
                            var curFra:FLSqlCursor = new FLSqlCursor("facturascli");
                            curFra.select("idfactura='"+idfactura+"'");
                            curFra.first();
                            var tipopago = util.sqlSelect("formaspago","tipopago","codpago='"+curFra.valueBuffer("codpago")+"'");

                            cursor.setValueBuffer("codserie",curFra.valueBuffer("codserie"));
                            cursor.setValueBuffer("coddivisa",curFra.valueBuffer("coddivisa"));
                            cursor.setValueBuffer("tasaconv",curFra.valueBuffer("tasaconv"));
                            cursor.setValueBuffer("numero", util.sqlSelect("reciboscli","max(numero)+1","idfactura='"+idfactura+"'"));
                            cursor.setValueBuffer("codcliente",curFra.valueBuffer("codcliente"));
                            cursor.setValueBuffer("coddir",curFra.valueBuffer("coddir"));
                            cursor.setValueBuffer("idfactura",curFra.valueBuffer("idfactura"));
                            if (tipopago) cursor.setValueBuffer("tipopago",tipopago);
                    }
                    break;


            case cursor.Edit:
                    var automatico = cursor.valueBuffer("automatico");
                    var estado = cursor.valueBuffer("estado");
                    if (automatico && estado=="Emitido")
                        deshab=false;
                    else
                        deshab=true;
                    break;

            case cursor.Browse:
                    deshab=true;
                    break;
    }

    this.child("fdbCodCliente").setDisabled(deshab);
    this.child("fdbCodDivisa").setDisabled(deshab);
    this.child("gbxCambio").setDisabled(deshab);

}
function recibosmanuales_validateForm():Boolean{

    var util:FLUtil = new FLUtil();
    var cursor:FLSqlCursor = this.cursor();

    if (cursor.modeAccess()==cursor.Edit){
        var importeActual:Number = parseFloat(cursor.valueBuffer("importe"));
        if (cursor.valueBuffer("automatico")){
                if ((this.iface.importeInicial >= 0 && this.iface.importeInicial < importeActual) || (this.iface.importeInicial < 0 && this.iface.importeInicial > importeActual)) {
                        MessageBox.warning(util.translate("scripts", "El importe del recibo debe ser menor o igual del que tenía anteriormente.\nSi es menor el recibo se fraccionará."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
                        this.child("fdbImporte").setFocus();
                        return false;
                }
        }
    }

    if (cursor.modeAccess()==cursor.Insert){
        var serie=this.cursor().valueBuffer("codserie");
        if (!serie || serie==""){
                MessageBox.information("Por favor seleccione la serie del recibo",MessageBox.Ok);
                return false;
            }
    }

    if (util.daysTo(cursor.valueBuffer("fecha"), cursor.valueBuffer("fechav")) < 0) {
            MessageBox.warning(util.translate("scripts", "La fecha de vencimiento debe ser siempre igual o posterior\na la fecha de emisión del recibo."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
            return false;
    }

    return true;

}
/** \D Genera el codigo para el nuevo recibo
@param  codEejercicio: Ejercicio Actual
@param  codSerie:Serie de facturación el la cual generar el recibo
@param idFactura: si existe genera el codigo a partir de la factura, si no, genera un codigo nuevo tipo "M"
\end */
function recibosmanuales_generarCodigo(codEjercicio:String, codSerie:String, idFactura:String):String
{
    var util:FLUtil = new FLUtil;
    var codigo:String;
    if (!idFactura){
        var inicio:String=flfacturac.iface.pub_cerosIzquierda(codEjercicio,4)+flfacturac.iface.pub_cerosIzquierda(codSerie,2)+"M";
        var num=util.sqlSelect("reciboscli","MAX(cast(substring(codigo from 8 for 5) as integer))+1","codigo LIKE '"+inicio+"%'");
            if (!num) num=1;

        codigo=inicio+flfacturac.iface.pub_cerosIzquierda(num,5)+"-01";
    }else{
        var q:FLSqlQuery = new FLSqlQuery;
        q.setTablesList("reciboscli");
        q.setSelect("MAX(codigo), MAX(numero)");
        q.setFrom("reciboscli");
        q.setWhere("idfactura='"+idFactura+"'");
        q.exec();
        if (q.first()){
            var codfra:String= q.value(0).toString();
            var numero =flfacturac.iface.pub_cerosIzquierda(parseFloat(q.value(1))+1,2);
            codigo = codfra.substring(0,12)+"-"+numero;
        }
    }
    return codigo;
}
function recibosmanuales_bufferChanged(fN:String)
{
        var util:FLUtil = new FLUtil();
        var cursor:FLSqlCursor = this.cursor();
        switch (fN) {
            case "importe":
                if (!cursor.valueBuffer("automatico") && !cursor.valueBuffer("idfactura")){
                    if (!this.iface.bloqueoImporte_) {
                        this.iface.bloqueoImporte_ = true;
                        cursor.setValueBuffer("importesingd", this.iface.calculateField("importesingd"));
                        cursor.setValueBuffer("gastodevol",this.iface.calculateField("gastodevol"));
                        this.iface.bloqueoImporte_ = false;
                    }
                }
                this.iface.__bufferChanged(fN);
            case "tasaconv":
                var importe:Number = parseFloat(cursor.valueBuffer("importe"));
                var tasaConv:Number = parseFloat(cursor.valueBuffer("tasaconv"));
                res = importe * tasaConv;
                res = parseFloat(util.roundFieldValue(res, "reciboscli", "importeeuros"));
                this.child("fdbImporteEuros").setValue(res);
                this.child("fdbTexto").setValue(this.iface.calculateField("texto"));
                if (cursor.modeAccess()==cursor.Edit) this.iface.gbxPagDev.setDisabled(true);
                break;

            case "fechav":
                this.child("fdbFechaMate").setValue(cursor.valueBuffer("fechav"));
                break;

            default:
                this.iface.__bufferChanged(fN);
        }
}
function recibosmanuales_divisionRecibo()
{
    var util:FLUtil = new FLUtil();
    var cursor:FLSqlCursor = this.cursor();

    /** \C
    Si el importe ha disminuido y el recibo no es automático, genera un recibo complementario por la diferencia siempre que el recibo no este en modo insert o que el recibo no sea manual. Se hace la llamada a la función porque la tasaconv ha de leerse desde el mismo recibo y el importe del recibo no depende de si existe la clase de gastos y devoluciones.
    \end */
    if (cursor.modeAccess() == cursor.Insert || cursor.valueBuffer("automatico") == false){
            return true;
    }

    var importeActual = parseFloat(form.cursor().valueBuffer("importe"));
    if (importeActual != this.iface.importeInicial) {
        var cursor = form.cursor();
        var tasaConv = cursor.valueBuffer("tasaconv")

        cursor.setValueBuffer("importeeuros", importeActual * tasaConv);

        if (!this.iface.curReciboDiv) {
                this.iface.curReciboDiv = new FLSqlCursor("reciboscli");
        }
        this.iface.curReciboDiv.setModeAccess(this.iface.curReciboDiv.Insert);
        this.iface.curReciboDiv.refreshBuffer();

        var camposRecibo:Array = util.nombreCampos("reciboscli");
        var totalCampos:Number = camposRecibo[0];

        var campoInformado:Array = [];
        for (var i:Number = 1; i <= totalCampos; i++) {
                campoInformado[camposRecibo[i]] = false;
        }
        for (var i:Number = 1; i <= totalCampos; i++) {
                if (!this.iface.copiarCampoReciboDiv(camposRecibo[i], cursor, campoInformado)) {
                        return false;
                }
        }
        this.iface.curReciboDiv.commitBuffer();
    }

    return true;
}

function recibosmanuales_copiarCampoReciboDiv(nombreCampo:String, cursor:FLSqlCursor, campoInformado:Array):Boolean
{
    var util:FLUtil = new FLUtil;

    if (campoInformado[nombreCampo]) {
            return true;
    }

    if (!cursor){
        cursor = this.cursor();
    }

    var nulo:Boolean = false;

    var tasaConv:Number = 1;
    switch (nombreCampo) {
        case "codigo":
            if (!campoInformado["numero"]) {
                    if (!this.iface.copiarCampoReciboDiv("numero", cursor, campoInformado)) {
                            return false;
                    }
            }
            valor = cursor.valueBuffer("codigo").left(12) + "-" + flfacturac.iface.pub_cerosIzquierda(this.iface.curReciboDiv.valueBuffer("numero"), 2);
            break;

        case "importe":
            valor = this.iface.importeInicial - parseFloat(cursor.valueBuffer("importe"));
            break;

        case "importeeuros":
            if (!campoInformado["importe"]) {
                    if (!this.iface.copiarCampoReciboDiv("importe", cursor, campoInformado)) {
                            return false;
                    }
            }
            if (!campoInformado["tasaconv"]) {
                    if (!this.iface.copiarCampoReciboDiv("tasaconv", cursor, campoInformado)) {
                            return false;
                    }
            }
            valor = this.iface.curReciboDiv.valueBuffer("importe") * this.iface.curReciboDiv.valueBuffer("tasaconv");
            break;

        case "tasaconv":
            valor = cursor.valueBuffer("tasaconv");
            break;

        case "numero":
            valor =  parseInt(util.sqlSelect("reciboscli", "MAX(numero)+1","substring(codigo from 0 for 13) = (substring('"+cursor.valueBuffer("codigo")+"' from 0 for 13))"));
            break;

        case "importesingd":
            if (!campoInformado["importe"]) {
                    if (!this.iface.copiarCampoReciboDiv("importe", cursor, campoInformado)) {
                            return false;
                    }
            }
            valor = this.iface.curReciboDiv.valueBuffer("importe");
            break;

        case "automatico" :
            if (!campoInformado["idfactura"]) {
                if (!this.iface.copiarCampoReciboDiv("idfactura", cursor, campoInformado)) {
                    return false;
                }
            }
            idFactura = this.iface.curReciboDiv.valueBuffer("idfactura");
            if (idFactura && idFactura != ""){
                    valor = true;
            } else {
                /*Si no hay idfactura y es automatico el recibo es agrupado, si no es de generación manual*/
                var automatico = cursor.valueBuffer("automatico");
                if (automatico){
                    valor = true;
                }else{
                    valor = false;
                }
            }
            break;

        default: {
                if (!this.iface.__copiarCampoReciboDiv(nombreCampo, cursor, campoInformado)) {
                        return false;
                }
                return true;
        }

    }

    if (nulo) {
            this.iface.curReciboDiv.setNull(nombreCampo);
    } else {
            this.iface.curReciboDiv.setValueBuffer(nombreCampo, valor);
    }
    campoInformado[nombreCampo] = true;

    return true;
}

function recibosmanuales_calculateField(fN:String):String
{
        var util:FLUtil = new FLUtil();
        var cursor:FLSqlCursor = this.cursor();
        var valor:String;
        switch (fN) {
        /*Si existen las extensiones de pagodevolcli y el recibo es manual, hay que asignar los valores de gastodevol e importesingd*/
                case "importesingd":
                    if (!cursor.valueBuffer("automatico") && !cursor.valueBuffer("idfactura")){debug("importesingd manual");
                        valor = cursor.valueBuffer("importe");
                    } else {debug("importesingd __");
                        valor = this.iface.__calculateField(fN);
                    }
                    break;

                case "gastodevol":
                    if (!cursor.valueBuffer("automatico") && !cursor.valueBuffer("idfactura")){debug("gastidevik manual");
                        valor = 0;
                    } else {debug("gastodevol __");
                        valor = this.iface.__calculateField(fN);
                    }
                    break;

                default: {
                        valor = this.iface.__calculateField(fN);
                }
        }
        return valor;
}
//// RECIBOSMANUALES ////////////////////////////////////////////
////////////////////////////////////////////////////////////////

