
/** @class_declaration boe2011 */
//////////////////////////////////////////////////////////////////
//// BOE2011 ////////////////////////////////////////////////////
class boe2011 extends oficial {
    function boe2011( context ) { oficial( context ); }
    function init() {
        this.ctx.boe2011_init();
    }
    function cargarFacturasEmitidas():Boolean {
        return this.ctx.boe2011_cargarFacturasEmitidas();
    }
    function establecerParametrosConsulta(cursor:FLSqlCursor,p:Array):Array {
        return this.ctx.boe2011_establecerParametrosConsulta(cursor,p)
    }
    function dameWhereEmi():String {
        return this.ctx.boe2011_dameWhereEmi();
    }
    function dameWhereRec():String {
        return this.ctx.boe2011_dameWhereRec();
    }
    function dameWhereRecibos(cursor:FLSqlCursor, cifnif:String):String {
        return this.ctx.boe2011_dameWhereRecibos(cursor, cifnif);
    }
    function registrosImporteMetalico():Boolean{
        return this.ctx.boe2011_registrosImporteMetalico();
    }
    function bufferChanged(fN) {
        return this.ctx.boe2011_bufferChanged(fN);
    }
    function habilitarBusquedaAnteriores(){
        this.ctx.boe2011_habilitarBusquedaAnteriores();
    }
    function buscarModelo() {
        this.ctx.boe2011_buscarModelo();
    }
    function calcularTotales() {
        return this.ctx.boe2011_calcularTotales();
    }
    function calculateField( fN:String ):String {
        return this.ctx.boe2011_calculateField( fN );
    }
}
//// BOE2011 ////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition boe2011 */
/////////////////////////////////////////////////////////////////
//// BOE2011 ////////////////////////////////////////////////////
function boe2011_init()
{
    this.iface.__init();

    if (this.cursor().modeAccess() == this.cursor().Insert) {
        this.child("fdbRepLegal").setValue(flcontmode.iface.pub_valorDefectoDatosFiscales("nifreplegal"));
    }

    connect(this.child("tbnBuscarModelo"), "clicked()", this, "iface.buscarModelo()");
    this.iface.habilitarBusquedaAnteriores();

    /*No se porque Infosial deshabilita estas pestañas, las habilito para que en el caso de que el usuario quiera generar este tipo de registros,pueda generarse el fichero del 340 completo y correctamente*/
    this.child("tbwModelo340").setTabEnabled("bienesinversion", true);
    this.child("tbwModelo340").setTabEnabled("operacionesintracomunitarias", true);

}

function boe2011_cargarFacturasEmitidas()
{
    var util= new FLUtil();
    var cursor:FLSqlCursor = this.cursor();
    var idModeloAnt = cursor.valueBuffer("idmodeloant");

    var error:Boolean = false;
    if (cursor.valueBuffer("tipoperiodo") == "Trimestre" && cursor.valueBuffer("trimestre") != "1T" && (cursor.isNull("idmodeloant") || !cursor.valueBuffer("idmodeloant"))) {
        error = true;
    }

    if (cursor.valueBuffer("tipoperiodo") == "Mes" && cursor.valueBuffer("mes") != "01" && (cursor.isNull("idmodeloant") || !cursor.valueBuffer("idmodeloant"))) {
        error = true;
    }

    if (error) {
         var res = MessageBox.warning(util.translate("scripts", "Para el control de registros de importes en Metálico\nes necesario estipular el identificador de la presentación anterior\nPulse Cancelar si desea indicarla\nPulse Aceptar si desea continuar y marcar manualmente la omisión de registros repetidos"), MessageBox.Ok, MessageBox.Cancel);
        if (res != MessageBox.Ok) {
            return;
        }
    }

    if (!this.iface.__cargarFacturasEmitidas()){
        return false;
    }

    if (!this.iface.registrosImporteMetalico()) {
        return false;
    } else {
        MessageBox.information(util.translate("scripts", "Los datos relativos a registro de importes recibos en metálico,\nhan sido cargados correctamente"), MessageBox.Ok, MessageBox.NoButton);
    }

    this.child("tdbFacturasEmitidas").refresh();

    this.iface.calcularTotales();

    return true;

}

/*Establecer criterios unificados para consulta de importe percibido en metalico usando consulta de 347*/
function boe2011_establecerParametrosConsulta(cursor:FLSqlCursor,p:Array):Array {

    p["codejercicio"] = cursor.valueBuffer("codejercicio");
    p["tipoimp"] = "ImporteEfectivo";
    p["importemin"] = cursor.valueBuffer("importeminimoefectivo");
    p["clave"] = "B";
    p["where"] = this.iface.dameWhereRecibos(cursor);

    p["campos"] = {};
    p["campos"]["cifnif"] = "r.cifnif";
    p["campos"]["valor"] = "SUM(r.importeeuros)";

    if (flcontmode.iface.xGesteso) {
        p["campos"]["codejercicio"] = "r.codejercicio";
    } else {
        p["campos"]["codejercicio"] = "f.codejercicio";
    }

    p = flcontmode.iface.pub_establecerFromMetalico(p);

    return p;
}

function boe2011_dameWhereEmi():String
{
    where = this.iface.__dameWhereEmi();

    if (flcontmode.iface.xC0) {
        where += " AND co_asientos.column0 = '1'";
    }

    return where;
}

function boe2011_dameWhereRec():String
{
    where = this.iface.__dameWhereRec();

    if (flcontmode.iface.xC0) {
        where += " AND co_asientos.column0 = '1'";
    }

    return where;
}

function boe2011_dameWhereRecibos(cursor:FLSqlCursor,cifnif:String):String
{
    var util= new FLUtil();
    if (!cursor.isValid()) {
        cursor = this.cursor();
    }

    /*Todos los recibos pagados en efectivo con ejercicio origen 2012 en adelante*/
    var where:String = "p.tipo='Pago' AND p.fecha BETWEEN (select fechainicio from ejercicios where codejercicio='"+cursor.valueBuffer("codejercicio")+"') AND (select fechafin from ejercicios where codejercicio='"+cursor.valueBuffer("codejercicio")+"') AND r.fecha > '2011-12-31' AND (p.codcuenta = '" + flcontmode.iface.pub_valorDefectoDatosFiscales("codcuentaefectivo") + "' OR p.codcuenta IS NULL)  AND r.estado = 'Pagado'";

    if (flcontmode.iface.xGesteso) {
        where += " AND (r.nomodelo347 = false or r.nomodelo347 IS NULL)";
    } else {
        where += " AND (f.nomodelo347 = false or f.nomodelo347 IS NULL)";
    }

    if (flcontmode.iface.xC0) {
        if (flcontmode.iface.xGesteso) {
            where += " AND r.column0 = '1'";
        } else {
            where += " AND f.column0 = '1'";
        }
    }

    if (flcontmode.iface.xMulti) {
        if (flcontmode.iface.xGesteso) {
            where += " AND r.codejercicio IN (SELECT a.codejercicio FROM ejercicios a INNER JOIN ejercicios b ON a.idempresa = b.idempresa WHERE b.codejercicio = '"+cursor.valueBuffer("codejercicio")+"')";
        } else {
            where += " AND f.codejercicio IN (SELECT a.codejercicio FROM ejercicios a INNER JOIN ejercicios b ON a.idempresa = b.idempresa WHERE b.codejercicio = '"+cursor.valueBuffer("codejercicio")+"')";
        }
    }


    if (cifnif) {
        if (flcontmode.iface.xGesteso) {
            where += " AND r.cifnif = '"+cifnif+"'";
        } else {
            where += " AND f.cifnif = '"+cifnif+"'";
        }
    }

    return where;
}


function boe2011_registrosImporteMetalico():Boolean{

    var util:FLUtil = new FLUtil;
    var cursor:FLSqlCursor = this.cursor();
    var curEmitidas:FLSqlCursor = this.child("tdbFacturasEmitidas").cursor();
    var cifNif:String;
    var codPais:String;
    var numIdent:String;
    var tipoIdFiscal:String;
    var codCliente:String;
    var tipoIdFiscal:String;

    var idModelo:String = cursor.valueBuffer("idmodelo");
    var codEjercicio:String = cursor.valueBuffer("codejercicio");

    var p:Array = [];
    p = this.iface.establecerParametrosConsulta(cursor, p);

    var qryDeclarados= new FLSqlQuery;
    qryDeclarados = flcontmode.iface.pub_consultaDeclaradosMetalico(p);
    qryDeclarados.setForwardOnly(true);
    if (!qryDeclarados.exec()) {
        MessageBox.critical(util.translate("scripts", "Falló la consulta de declarantes para importes en metálico"), MessageBox.Ok, MessageBox.NoButton);
        return;
    }

    while (qryDeclarados.next()) {
        tipoIdFiscal = 1;
        var datosDec:Array = flcontmode.iface.pub_datosDeclarados(p,qryDeclarados);
        if ((datosDec.codPais && datosDec.codPais.toUpperCase() != "ES") || datosDec.codPais == "") {
            datosDec.codPais = "ES";
        }
        codCliente = datosDec.codCP;
        cifNif = qryDeclarados.value(0);
        if (datosDec.tipoId) {
            tipoIdFiscal = datosDec.tipoId;
        }

        codPais = datosDec.codPais;
        if (!codPais || codPais == "") {
            codPais = "ES";
        }

        var errorIdent:Boolean = false;
        if (codPais == "ES") {
            if (datosDec.cifCP.length > 9) {
                var res= MessageBox.warning(util.translate("scripts", "El CIF ó NIF %1 (%2) correspondiente a %3 tiene más de nueve dígitos\nPulse Ignorar para continuar con el siguiente registro o Cancelar para cancelar la carga de datos").arg(datosDec.cifCP).arg(qryDeclarados.value("cifnif")).arg(datosDec.nombreCP), MessageBox.Ignore, MessageBox.Cancel);
                if (res == MessageBox.Ignore) {
                    continue;
                } else {
                    return false;
                }
            }
            numIdent = " ";
            if (!datosDec.cifCP || datosDec.cifCP == "") {
                errorIdent = true;
            }
        } else {
            if (!cifNif.startsWith(codPais)) {
                numIdent = codPais + cifNif;
            }
            datosDec.cifCP = "";
            if (!numIdent || numIdent == "") {

            }
            errorIdent = true;
        }

        if (errorIdent) {
            var res:Number = MessageBox.warning(util.translate("scripts", "El cliente %1 (%2) no tiene Identificador Fiscal asociado.\nPulse Ignorar para continuar con el siguiente registro o Cancelar para cancelar la carga de datos").arg(cifNif).arg(datosDec.nombreCP), MessageBox.Ignore, MessageBox.Cancel);
            if (res == MessageBox.Ignore) {
                continue;
            } else {
                return false;
            }
        }

        if (tipoIdFiscal != "1") {
            tipoIdFiscal = this.iface.obtenerTipoIdFiscal(tipoIdFiscal);
            if ((tipoIdFiscal != "1" && codPais == "ES") || (tipoIdFiscal == "1" && codPais != "ES")) {
                var res:Number = MessageBox.warning(util.translate("scripts", "Los datos de Tipo de Identificación Fiscal y país del cliente no son coherentes para:\n%1\: %2").arg(qryDeclarados.value(0)).arg(datosDec.cifCP), MessageBox.Ignore, MessageBox.Cancel);
                if (res == MessageBox.Ignore) {
                    continue;
                } else {
                    util.destroyProgressDialog();
                    return false;
                }
            }
        }

        var omitir:Boolean = false;
        if (cursor.valueBuffer("idmodeloant")) {
            /*Comprueba que para el declarado actual no se halla presentado el mismo registro de importe metalico en una declaracion anterior*/
            var idReg = util.sqlSelect("co_facturasemi340","id","idmodelo = "+cursor.valueBuffer("idmodeloant")+" AND cifnif='"+datosDec.cifCP+"' AND codpais='"+datosDec.codPais+"' AND claveidentificacion = '"+tipoIdFiscal+"' AND numidentificacion='"+numIdent+"' AND ejerciciometalico = '"+datosDec.ejercicioMetalico+"' AND importemetalico = "+datosDec.importeMetalico);
            if (idReg) omitir = true;
        }

        curEmitidas.setModeAccess(curEmitidas.Insert);
        curEmitidas.refreshBuffer();
        curEmitidas.setValueBuffer("idmodelo", idModelo);
        curEmitidas.setValueBuffer("cifnif", datosDec.cifCP);
        curEmitidas.setValueBuffer("cifnifrp", " ");
        if (datosDec.nombreCP && datosDec.nombreCP != "") {
            curEmitidas.setValueBuffer("apellidosnomrs", datosDec.nombreCP.left(40));
        }
        curEmitidas.setValueBuffer("codpais", datosDec.codPais);
        curEmitidas.setValueBuffer("claveidentificacion", tipoIdFiscal);
        curEmitidas.setValueBuffer("numidentificacion", numIdent);
        curEmitidas.setValueBuffer("importemetalico", datosDec.importeMetalico);
        curEmitidas.setValueBuffer("ejerciciometalico", datosDec.ejercicioMetalico);
        curEmitidas.setValueBuffer("omitir", omitir);

        if (!curEmitidas.commitBuffer()) {
            MessageBox.critical(util.translate("scripts", "Falló la inserción de registro de declarado para ") + datosDec.nombreCP, MessageBox.Ok, MessageBox.NoButton);
                    return;
        }

    }

    return true;
}

function boe2011_bufferChanged(fN)
{
    this.iface.__bufferChanged(fN);

    switch ( fN ) {
        case "fechainicio":
            this.iface.habilitarBusquedaAnteriores();
            break;
    }
}

function boe2011_habilitarBusquedaAnteriores()
{
    var cursor:FLSqlCursor = this.cursor();
    var desHab:Boolean = false;
    var util:FLUtil = new FLUtil();

    var count:Number = util.sqlSelect("co_modelo340","count(idmodelo)","fechafin<'"+cursor.valueBuffer("fechainicio")+"'");
    if (!count || isNaN(count)) count = 0;
    if (count < 1) {
        desHab = true;
    } else {
        if (cursor.valueBuffer("tipoperiodo") == "Trimestre" && cursor.valueBuffer("trimestre") == "1T") {
            desHab = true;
        }

        if (cursor.valueBuffer("tipoperiodo") == "Mes" && cursor.valueBuffer("mes") == "01") {
            desHab = true;
        }
    }

    this.child("idModeloAnt").setDisabled(desHab);
    this.child("tbnBuscarModelo").setDisabled(desHab);

}


/* \D Muestra el formulario de busqueda de modelos anteriores para comparativa de importes en metálico
\end */
function boe2011_buscarModelo()
{
    var ruta:Object = new FLFormSearchDB("busmod340");
    var curAnterior:FLSqlCursor = ruta.cursor();
    var cursor:FLSqlCursor = this.cursor();
    var util:FLUtil = new FLUtil();

    var fechaIni:String = cursor.valueBuffer("fechainicio");


    curAnterior.setMainFilter("fechafin < '"+fechaIni+"'");

    ruta.setMainWidget();
    var idModelo:String = ruta.exec("idmodelo");

    if (!idModelo) {
        return;
    }

   this.child("idModeloAnt").setValue(idModelo);
}

function boe2011_calcularTotales()
{
    this.iface.__calcularTotales();

    this.child("fdbNumRegistros").setValue(this.iface.calculateField("numregistros"));


}

function boe2011_calculateField(fN:String):String {

    var valor:String;
    switch(fN){
        case "numregistros":
            var util:FLUtil = new FLUtil();
            var idModelo = this.cursor().valueBuffer("idmodelo");
            var emi = util.sqlSelect("co_facturasemi340", "COUNT(id)", "idmodelo = " + idModelo +" AND (omitir= false OR omitir is NULL)");
            var rec = util.sqlSelect("co_facturasrec340", "COUNT(id)", "idmodelo = " + idModelo);
            var bin = util.sqlSelect("co_bienesinv340", "COUNT(id)", "idmodelo = " + idModelo);
            var opi = util.sqlSelect("co_opintracomunitarias340", "COUNT(id)", "idmodelo = " + idModelo);
            valor = parseFloat(emi)+parseFloat(rec)+parseFloat(bin)+parseFloat(opi);
            break;

        default:
            valor = this.iface.__calculateField(fN);
    }

    return valor;

}
//// BOE2011 ////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

