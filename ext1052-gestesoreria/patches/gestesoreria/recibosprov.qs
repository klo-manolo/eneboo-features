
/** @class_declaration gestesoreria */
/////////////////////////////////////////////////////////////////
//// GESTESORERIA /////// ////////////////////////////////////
class gestesoreria extends remesas {
    function gestesoreria( context ) { remesas ( context ); }

    function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
            return this.ctx.gestesoreria_commonCalculateField(fN, cursor);
    }

    function cambiarEstado() {
        return this.ctx.gestesoreria_cambiarEstado();
    }

    function obtenerEstado(idRecibo:String):String {
        return this.ctx.gestesoreria_obtenerEstado(idRecibo)
    }
}
//// GESTESORERIA ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration recibosmultiprov */
//////////////////////////////////////////////////////////////////
//// RECIBOSMULTIPROV /////////////////////////////////////////////
class recibosmultiprov extends gestesoreria {
        function recibosmultiprov( context ) { gestesoreria( context ); }
        function acceptedForm() { return this.ctx.recibosmultiprov_acceptedForm(); }
}
//// RECIBOSMULTIPROV //////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration recibosmanuales */
//////////////////////////////////////////////////////////////////
//// RECIBOSMANUALES /////////////////////////////////////////////
class recibosmanuales extends recibosmultiprov {
    function recibosmanuales( context ) { recibosmultiprov( context ); }

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

    function acceptedForm() {
        return this.ctx.recibosmanuales_acceptedForm();
    }

}
//// RECIBOSMANUALES //////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration tiposremprov */
//////////////////////////////////////////////////////////////////
//// TIPOSREMPROV ////////////////////////////////////////////////
class tiposremprov extends recibosmanuales {
    var gbxAnt:Object;
    function tiposremprov( context ) { recibosmanuales ( context ); }
    function init() {
        this.ctx.tiposremprov_init();
    }
    function obtenerEstado(idRecibo:String):String {
        return this.ctx.tiposremprov_obtenerEstado(idRecibo);
    }
    function bufferChanged(fN:String) {
        return this.ctx.tiposremprov_bufferChanged(fN);
    }
    function cambiarEstado() {
        return this.ctx.tiposremprov_cambiarEstado();
    }
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration pubGesTesoreria */
/////////////////////////////////////////////////////////////////
//// PUB GESTESORERIA /////////////////////////////////////////////////
class pubGesTesoreria extends ifaceCtx {
	function pubGesTesoreria( context ) { ifaceCtx( context ); }
	function pub_obtenerEstado(idRecibo:String):String {
		return this.obtenerEstado(idRecibo);
	}
}
//// PUB GESTESORERIA /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition gestesoreria */
/////////////////////////////////////////////////////////////////
//// GESTESORERIA ////////////////////////////////////////////
function gestesoreria_commonCalculateField(fN:String, cursor:FLSqlCursor):String
{
        var util:FLUtil = new FLUtil();
        var valor:String;
        switch (fN) {
                case "estado":
                        valor = this.iface.obtenerEstado(cursor.valueBuffer("idrecibo"));
                        break;
        }

        return valor;
}

function gestesoreria_obtenerEstado(idRecibo:String):String
{
    var util:FLUtil = new FLUtil;
    var valor:String = "Emitido";

    var curPagosDevol:FLSqlCursor = new FLSqlCursor("pagosdevolprov");
    curPagosDevol.select("idrecibo = " + idRecibo + " ORDER BY fecha DESC, idpagodevol DESC");
    if (curPagosDevol.first()) {
            curPagosDevol.setModeAccess(curPagosDevol.Browse);
            curPagosDevol.refreshBuffer();
            if (curPagosDevol.valueBuffer("tipo") == "Pago"){
                    valor = "Pagado";
            }else{
                    valor = "Devuelto";
            }
    }

    var idremesa = util.sqlSelect("recibosprov","idremesa","idrecibo='"+idRecibo+"'");
    if (idremesa!=0 || idremesa!=""){
        var pagosdevol = util.sqlSelect("pagosdevolprov", "idpagodevol", "idrecibo = " + idRecibo + " AND idremesa ='"+idremesa+"'");
        if (!pagosdevol)
            valor = "Remesado";
    }

    var idAg = util.sqlSelect("recibosprov","idrecibomulti","idrecibo='"+idRecibo+"'");
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
        case "Emitido":
            this.child("fdbImporte").setDisabled(false);
            this.child("fdbFechav").setDisabled(false);
            this.child("fdbFecha").setDisabled(false);
            this.child("fdbFecha2").setDisabled(false);
            this.child("gbxCuenta").setDisabled(false);
            this.child("fdbCodDir").setDisabled(false);
            this.child("gbxCuentaPago").setDisabled(false);
            break;

        case "Devuelto":
            this.child("fdbImporte").setDisabled(true);
            this.child("fdbFechav").setDisabled(false);
            this.child("fdbFecha").setDisabled(true);
            this.child("fdbFecha2").setDisabled(true);
            this.child("gbxCuenta").setDisabled(false);
            this.child("fdbCodDir").setDisabled(true);
            this.child("gbxCuentaPago").setDisabled(false);
            break;

        case "Pagado":
            this.child("fdbImporte").setDisabled(true);
            this.child("fdbFechav").setDisabled(true);
            this.child("fdbFecha").setDisabled(true);
            this.child("fdbFecha2").setDisabled(true);
            this.child("fdbCodDir").setDisabled(true);
            this.child("gbxCuenta").setDisabled(true);
            var tipoconta = "";
            var idremesa = util.sqlSelect("pagosdevolprov","idremesa","idrecibo='"+cursor.valueBuffer("idrecibo")+"' ORDER BY idpagodevol DESC, fecha DESC");
            if (idremesa && idremesa!="") {
                    habBotones = false;
            }
            this.child("gbxCuentaPago").setDisabled(true);
            break;

        case "Remesado":
            this.child("lblRemesado").text = "Remesado en: "+cursor.valueBuffer("idremesa");
            this.child("tdbPagosDevolProv").setInsertOnly(true);
            this.child("toolButtomInsert").enabled = false;
            habBotones = false;
            this.child("fdbImporte").setDisabled(true);
            this.child("fdbFechav").setDisabled(true);
            this.child("fdbFecha").setDisabled(true);
            this.child("fdbFecha2").setDisabled(true);
            this.child("gbxCuenta").setDisabled(true);
            this.child("fdbCodDir").setDisabled(true);
            this.child("gbxCuentaPago").setDisabled(true);
            break;

        case "Agrupado":
            this.child("lblRemesado").text = "Agrupado en: " + util.sqlSelect("recibosmultiprov", "codigo", "idrecibomulti = " + cursor.valueBuffer("idrecibomulti"));
            this.child("tdbPagosDevolProv").setReadOnly(true);
            this.child("fdbImporte").setDisabled(true);
            this.child("fdbFechav").setDisabled(true);
            this.child("fdbFecha").setDisabled(true);
            this.child("fdbFecha2").setDisabled(true);
            this.child("gbxCuenta").setDisabled(true);
            this.child("fdbCodDir").setDisabled(true);
            this.child("toolButtomInsert").enabled = false;
            habBotones = false;
            this.child("toolButtonZoom").enabled = false;
            this.child("gbxCuentaPago").setDisabled(true);
            break;

        case "Compensado":
            this.child("lblRemesado").text = "Compensado con: " + util.sqlSelect("recibosprov", "codigo", "idrecibo = " + cursor.valueBuffer("idrecibocomp"));
            this.child("tdbPagosDevolProv").setReadOnly(true);
            this.child("fdbImporte").setDisabled(true);
            this.child("fdbFechav").setDisabled(true);
            this.child("fdbFecha").setDisabled(true);
            this.child("fdbFecha2").setDisabled(true);
            this.child("gbxCuenta").setDisabled(true);
            this.child("fdbCodDir").setDisabled(true);
            habBotones = false;
            this.child("toolButtonDelete").enabled = false;
            this.child("toolButtonZoom").enabled = false;
            this.child("gbxCuentaPago").setDisabled(true);
            break;
    }

    this.child("toolButtonDelete").enabled = habBotones;
    this.child("toolButtonEdit").enabled = habBotones;

}

//// GESTESORERIA ////////////////////////////////////////////
////////////////////////////////////////////////////////////////

/** @class_definition recibosmultiprov */
/////////////////////////////////////////////////////////////////
//// RECIBOSMULTIPROV ///////////////////////////////////////////
function recibosmultiprov_acceptedForm()
{
        var util:FLUtil = new FLUtil();

        /** \C
        Si el importe ha disminuido, genera un recibo complementario por la diferencia
        \end */
        var importeActual:Number = parseFloat(this.cursor().valueBuffer("importe"));
        if ((importeActual < this.iface.importeInicial && this.iface.importeInicial > 0) || (importeActual > this.iface.importeInicial && this.iface.importeInicial < 0)) {
                var cursor:FLSqlCursor = this.cursor();
                var numRecibo:Number;
                var codigo:String;
                var codFactura:String;
                var tasaConv:Number;
                var idFactura:String;

                idFactura = cursor.valueBuffer("idfactura");

                if (idFactura && idFactura != ""){
                    numRecibo = parseInt(util.sqlSelect("recibosprov", "numero", "idfactura = " + cursor.valueBuffer("idfactura") + " ORDER BY numero DESC")) + 1;
                    codFactura = util.sqlSelect("facturasprov", "codigo", "idfactura = " + cursor.valueBuffer("idfactura"));
                    tasaConv = parseFloat(util.sqlSelect("facturasprov", "tasaconv", "idfactura = " + cursor.valueBuffer("idfactura")));
                    codigo = codFactura + "-" + flfacturac.iface.pub_cerosIzquierda(numRecibo, 2);
                }

                if (!idFactura || idFactura==""){
                    numRecibo = parseInt(util.sqlSelect("recibosprov", "MAX(numero)+1","substring(codigo from 0 for 13) = (substring('"+cursor.valueBuffer("codigo")+"' from 0 for 13))"));
                    codigo = cursor.valueBuffer("codigo").substring(0, 12)+ "-" + flfacturac.iface.pub_cerosIzquierda(numRecibo, 2);
                    tasaConv = parseFloat(util.sqlSelect("recibosmultiprov", "tasaconv", "idrecibogen = " + cursor.valueBuffer("idrecibo")));
                    if (!tasaConv)
                        tasaConv = parseFloat(util.sqlSelect("recibosmultiprov", "tasaconv","codigo like (select substring(codigo from 0 for 13) from recibosprov where idrecibo='"+cursor.valueBuffer("idrecibo")+"')"));
                }

                var curRecibos:FLSqlCursor = new FLSqlCursor("recibosprov");
                var moneda:String = util.sqlSelect("divisas", "descripcion", "coddivisa = '" + cursor.valueBuffer("coddivisa") + "'");

                cursor.setValueBuffer("importeeuros", importeActual * tasaConv);

                curRecibos.setModeAccess(curRecibos.Insert);
                curRecibos.refreshBuffer();
                curRecibos.setValueBuffer("numero", numRecibo);
                if (idFactura && idFactura != "")
                    curRecibos.setValueBuffer("idfactura",idFactura);
                curRecibos.setValueBuffer("importe", this.iface.importeInicial - importeActual);
                curRecibos.setValueBuffer("importeeuros", (this.iface.importeInicial - importeActual) * tasaConv);
                curRecibos.setValueBuffer("coddivisa", cursor.valueBuffer("coddivisa"));
                curRecibos.setValueBuffer("codigo", codigo);
                curRecibos.setValueBuffer("codproveedor", cursor.valueBuffer("codproveedor"));
                curRecibos.setValueBuffer("nombreproveedor", cursor.valueBuffer("nombreproveedor"));
                curRecibos.setValueBuffer("cifnif", cursor.valueBuffer("cifnif"));
                curRecibos.setValueBuffer("fecha", cursor.valueBuffer("fecha"));
                curRecibos.setValueBuffer("fechav", cursor.valueBuffer("fechav"));
                curRecibos.setValueBuffer("codcuenta", cursor.valueBuffer("codcuenta"));
                curRecibos.setValueBuffer("descripcion", cursor.valueBuffer("descripcion"));
                curRecibos.setValueBuffer("ctaentidad", cursor.valueBuffer("ctaentidad"));
                curRecibos.setValueBuffer("ctaagencia", cursor.valueBuffer("ctaagencia"));
                curRecibos.setValueBuffer("dc", cursor.valueBuffer("dc"));
                curRecibos.setValueBuffer("cuenta", cursor.valueBuffer("cuenta"));
                curRecibos.setValueBuffer("estado", "Emitido");
                curRecibos.setValueBuffer("texto", util.enLetraMoneda(this.iface.importeInicial - importeActual, moneda));
                curRecibos.commitBuffer();
        }
}
//// RECIBOSMULTIPROV ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

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
            idfactura = formfacturasprov.iface.idFacturaProv;
    } else{
            idfactura = cursor.valueBuffer("idfactura")
    }

    if (!idfactura){
        this.child("tabWidget24").setTabEnabled("datosfactura", false);
    }else{
        this.child("tabWidget24").setTabEnabled("datosrecibo", false);
    }


    var deshab:Boolean;
    switch(cursor.modeAccess()){
            case cursor.Insert:
                    cursor.setValueBuffer("codejercicio",flfactppal.iface.pub_ejercicioActual());
                    cursor.setValueBuffer("fecha",hoy);
                    cursor.setValueBuffer("fechav",hoy);
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
                            var curFra:FLSqlCursor = new FLSqlCursor("facturasprov");
                            curFra.select("idfactura='"+idfactura+"'");
                            if (curFra.first())
                            var codProveedor:String = curFra.valueBuffer("codproveedor");

                            var tipopago = util.sqlSelect("formaspago","tipopago","codpago='"+curFra.valueBuffer("codpago")+"'");

                            cursor.setValueBuffer("codserie",curFra.valueBuffer("codserie"));
                            cursor.setValueBuffer("coddivisa",curFra.valueBuffer("coddivisa"));
                            cursor.setValueBuffer("tasaconv",curFra.valueBuffer("tasaconv"));
                            cursor.setValueBuffer("numero", util.sqlSelect("recibosprov","max(numero)+1","idfactura='"+idfactura+"'"));
                            cursor.setValueBuffer("codproveedor",curFra.valueBuffer("codproveedor"));
                            cursor.setValueBuffer("idfactura",curFra.valueBuffer("idfactura"));
                            if (tipopago) cursor.setValueBuffer("tipopago",tipopago);

                            if (codProveedor && codProveedor != "") {
                                    var qryDir:FLSqlQuery = new FLSqlQuery;
                                    with (qryDir) {
                                            setTablesList("dirproveedores");
                                            setSelect("id, direccion, ciudad, codpostal, provincia, codpais");
                                            setFrom("dirproveedores");
                                            setWhere("codproveedor = '" + codProveedor + "' AND direccionppal = true");
                                            setForwardOnly(true);
                                    }
                                    if (!qryDir.exec())
                                            return false;
                                    if (qryDir.first()) {
                                            cursor.setValueBuffer("coddir", qryDir.value("id"));
                                            cursor.setValueBuffer("direccion", qryDir.value("direccion"));
                                            cursor.setValueBuffer("ciudad", qryDir.value("ciudad"));
                                            cursor.setValueBuffer("codpostal", qryDir.value("codpostal"));
                                            cursor.setValueBuffer("provincia", qryDir.value("provincia"));
                                            cursor.setValueBuffer("codpais", qryDir.value("codpais"));
                                    }
                            }
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
    this.child("fdbCodProveedor").setDisabled(deshab);
    this.child("fdbCodDivisa").setDisabled(deshab);
    this.child("gbxCambio").setDisabled(deshab);
}

/** \C
Si el recibo es manual, genera el codigo del recibo
\end */
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
        var num=util.sqlSelect("recibosprov","MAX(cast(substring(codigo from 8 for 5) as integer))+1","codigo LIKE '"+inicio+"%'");
            if (!num) num=1;

        codigo=inicio+flfacturac.iface.pub_cerosIzquierda(num,5)+"-01";
    }else{
        var q:FLSqlQuery = new FLSqlQuery;
        q.setTablesList("facturasprov");
        q.setSelect("MAX(codigo), MAX(numero)");
        q.setFrom("recibosprov");
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
            case "tasaconv":
                var importe:Number = parseFloat(cursor.valueBuffer("importe"));
                var tasaConv:Number = parseFloat(cursor.valueBuffer("tasaconv"));
                res = importe * tasaConv;
                res = parseFloat(util.roundFieldValue(res, "recibosprov", "importeeuros"));
                this.child("fdbImporteEuros").setValue(res);
                this.child("fdbTexto").setValue(this.iface.calculateField("texto"));
                if (cursor.modeAccess()==cursor.Edit) this.child("gbxPagDev").setDisabled(true);
                break;

            default:
                this.iface.__bufferChanged(fN);
        }
}

function recibosmanuales_acceptedForm()
{
    var util:FLUtil = new FLUtil();

    /** \C
    Si el importe ha disminuido, genera un recibo complementario por la diferencia
    \end */
    var importeActual:Number = parseFloat(this.cursor().valueBuffer("importe"));
    if ((importeActual < this.iface.importeInicial && this.iface.importeInicial > 0) || (importeActual > this.iface.importeInicial && this.iface.importeInicial < 0)) {
        var cursor:FLSqlCursor = this.cursor();
        var numRecibo:Number;
        var codigo:String;
        var codFactura:String;
        var tasaConv:Number;
        var idFactura:String;
        var valorAuto:Boolean;

        idFactura = cursor.valueBuffer("idfactura");

        if (idFactura && idFactura != ""){
            numRecibo = parseInt(util.sqlSelect("recibosprov", "numero", "idfactura = " + cursor.valueBuffer("idfactura") + " ORDER BY numero DESC")) + 1;
            codFactura = util.sqlSelect("facturasprov", "codigo", "idfactura = " + cursor.valueBuffer("idfactura"));
            tasaConv = parseFloat(util.sqlSelect("facturasprov", "tasaconv", "idfactura = " + cursor.valueBuffer("idfactura")));
            codigo = codFactura + "-" + flfacturac.iface.pub_cerosIzquierda(numRecibo, 2);
            valorAuto=true;
        }

        if (!idFactura || idFactura==""){
            numRecibo = parseInt(util.sqlSelect("recibosprov", "MAX(numero)+1","substring(codigo from 0 for 13) = (substring('"+cursor.valueBuffer("codigo")+"' from 0 for 13))"));
            codigo = cursor.valueBuffer("codigo").substring(0, 12)+ "-" + flfacturac.iface.pub_cerosIzquierda(numRecibo, 2);
            var automatico = cursor.valueBuffer("automatico");

            /*Si no hay idfactura y es automatico el recibo es agrupado, si no es de generación manual*/
            if (automatico){
                valorAuto=true;
                tasaConv = parseFloat(util.sqlSelect("recibosmultiprov", "tasaconv", "idrecibogen = " + cursor.valueBuffer("idrecibo")));
                if (!tasaConv)
                    tasaConv = parseFloat(util.sqlSelect("recibosmultiprov", "tasaconv","codigo like (select substring(codigo from 0 for 13) from recibosprov where idrecibo='"+cursor.valueBuffer("idrecibo")+"')"));
            }else{
                tasaConv = cursor.valueBuffer("tasaconv");
                valorAuto = false;
            }

            if (!tasaConv){
                tasaConv = cursor.valueBuffer("tasaconv");
            }
        }

        var curRecibos:FLSqlCursor = new FLSqlCursor("recibosprov");
        var moneda:String = util.sqlSelect("divisas", "descripcion", "coddivisa = '" + cursor.valueBuffer("coddivisa") + "'");
        cursor.setValueBuffer("importeeuros", importeActual * tasaConv);
        curRecibos.setModeAccess(curRecibos.Insert);
        curRecibos.refreshBuffer();
        curRecibos.setValueBuffer("codigo", codigo);
        curRecibos.setValueBuffer("estado", "Emitido");
        curRecibos.setValueBuffer("importe", this.iface.importeInicial - importeActual);
        curRecibos.setValueBuffer("fecha", cursor.valueBuffer("fecha"));
        curRecibos.setValueBuffer("fechav", cursor.valueBuffer("fechav"));
        curRecibos.setValueBuffer("codproveedor", cursor.valueBuffer("codproveedor"));
        curRecibos.setValueBuffer("nombreproveedor", cursor.valueBuffer("nombreproveedor"));
        if (idFactura && idFactura != "")
            curRecibos.setValueBuffer("idfactura",idFactura);
        curRecibos.setValueBuffer("cifnif", cursor.valueBuffer("cifnif"));
        curRecibos.setValueBuffer("importeeuros", (this.iface.importeInicial - importeActual) * tasaConv);
        curRecibos.setValueBuffer("coddivisa", cursor.valueBuffer("coddivisa"));
        curRecibos.setValueBuffer("tasaconv", tasaConv);
        curRecibos.setValueBuffer("codcuenta", cursor.valueBuffer("codcuenta"));
        curRecibos.setValueBuffer("descripcion", cursor.valueBuffer("descripcion"));
        curRecibos.setValueBuffer("ctaentidad", cursor.valueBuffer("ctaentidad"));
        curRecibos.setValueBuffer("ctaagencia", cursor.valueBuffer("ctaagencia"));
        curRecibos.setValueBuffer("dc", cursor.valueBuffer("dc"));
        curRecibos.setValueBuffer("cuenta", cursor.valueBuffer("cuenta"));
        var codDir:String = cursor.valueBuffer("coddir");
        if (codDir && codDir != "")
            curRecibos.setValueBuffer("coddir", cursor.valueBuffer("coddir"));
        curRecibos.setValueBuffer("direccion", cursor.valueBuffer("direccion"));
        curRecibos.setValueBuffer("codpostal", cursor.valueBuffer("codpostal"));
        curRecibos.setValueBuffer("ciudad", cursor.valueBuffer("ciudad"));
        curRecibos.setValueBuffer("provincia", cursor.valueBuffer("provincia"));
        curRecibos.setValueBuffer("codpais", cursor.valueBuffer("codpais"));
        curRecibos.setValueBuffer("texto", util.enLetraMoneda(this.iface.importeInicial - importeActual, moneda));
        curRecibos.setValueBuffer("codejercicio", cursor.valueBuffer("codejercicio"));
        curRecibos.setValueBuffer("codserie", cursor.valueBuffer("codserie"));
        curRecibos.setValueBuffer("numero", numRecibo);
        curRecibos.setValueBuffer("automatico", valorAuto);
        curRecibos.setValueBuffer("tipopago",cursor.valueBuffer("tipopago"));
        curRecibos.commitBuffer();
    }
}
//// RECIBOSMANUALES ////////////////////////////////////////////
////////////////////////////////////////////////////////////////

/** @class_definition tiposremprov */
/////////////////////////////////////////////////////////////////
//// TIPOSREMPROV //////////////////////////////////////////////
function tiposremprov_init()
{
    var cursor:FLSqlCursor = this.cursor();
    var util:FLUtil = new FLUtil;

    this.iface.gbxAnt = this.child("gbxAnticiposConf");
    this.child("tdbAnticipo").setReadOnly(true);

    var hayAnticipo:Number = this.child("tdbAnticipo").cursor().size();
    if (hayAnticipo <=0) {
       this.iface.gbxAnt.close();
    } else {
        this.child("tdbAnticipo").setReadOnly(true);
    }

    this.iface.__init();

}

function tiposremprov_obtenerEstado(idRecibo:String):String
{
    var util:FLUtil = new FLUtil;
    var valor:String = "Emitido";

    var curPagosDevol:FLSqlCursor = new FLSqlCursor("pagosdevolprov");
    curPagosDevol.select("idrecibo = " + idRecibo + " ORDER BY fecha DESC, idpagodevol DESC");
    if (curPagosDevol.first()) {
        curPagosDevol.setModeAccess(curPagosDevol.Browse);
        curPagosDevol.refreshBuffer();
        if (curPagosDevol.valueBuffer("tipo") == "Pago"){
            valor = "Pagado";
        }else{
            valor = "Devuelto";
        }
    }

    var idremesa = util.sqlSelect("recibosprov","idremesa","idrecibo='"+idRecibo+"'");
    if (idremesa!=0 || idremesa!=""){
        var pagosdevol = util.sqlSelect("pagosdevolprov", "idpagodevol", "idrecibo = " + idRecibo + " AND idremesa ='"+idremesa+"'");
        var idAntConf = util.sqlSelect("anticiposconf","idanticipoconf","idrecibo="+idRecibo+" AND ptepago = true");
        if (!pagosdevol){
            if (idAntConf){
                valor = "Confirmado";
            } else {
                valor = "Remesado";
            }
        }
    }

    var idAg = util.sqlSelect("recibosprov","idrecibomulti","idrecibo='"+idRecibo+"'");
    if (idAg && idAg!=""){
        valor = "Agrupado";
    }

    return valor;
}

function tiposremprov_bufferChanged(fN:String)
{
        var util:FLUtil = new FLUtil();
        var cursor:FLSqlCursor = this.cursor();
        switch (fN) {
            case "tipopago":
                var tipoOp:String = util.sqlSelect("tipospago","tipooperacion","tipopago='"+cursor.valueBuffer("tipo")+"'");
                if (tipoOp && tipoOp!=""){
                    this.child("fdbTipoOperacion").setValue(tipoOp);
                }
                break;

            default:
                this.iface.__bufferChanged(fN);
        }
}

function tiposremprov_cambiarEstado() {

    this.iface.__cambiarEstado();

    var util:FLUtil = new FLUtil();
    var cursor:FLSqlCursor = this.cursor();
    if (cursor.valueBuffer("estado") == "Pagado") {
        var idremesa = util.sqlSelect("pagosdevolprov","idremesa","idrecibo='"+cursor.valueBuffer("idrecibo")+"' ORDER BY idpagodevol DESC, fecha DESC");
        if (idremesa && idremesa!="") {
            tipoconta = util.sqlSelect("remesasprov","tipoconta","idremesa='"+idremesa+"'");
            if (tipoconta=="202"){
                this.child("toolButtonDelete").enabled = true;
            }
        }
    }

    if (cursor.valueBuffer("estado") == "Confirmado") {
        this.child("toolButtomInsert").enabled = false;
        this.child("toolButtonDelete").enabled = false;
        this.child("toolButtonEdit").enabled = false;
        this.child("toolButtonZoom").enabled = false;
    }

}
//// TIPOSREMPROV //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

