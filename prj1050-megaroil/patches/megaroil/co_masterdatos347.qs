
/** @class_declaration boe2011 */
//////////////////////////////////////////////////////////////////
//// BOE2011 /////////////////////////////////////////////////////
class boe2011 extends oficial {
    function boe2011( context ) { oficial( context ); }
    function lanzar() {
        return this.ctx.boe2011_lanzar();
    }
    function listadeclarados347(cursor:FLSqlCursor){
        return this.ctx.boe2011_listadeclarados347(cursor);
    }
    function listado347(cursor:FLSqlCursor){
        return this.ctx.boe2011_listado347(cursor);
    }
    function guardarDatosListado(cursor:FLSqlCursor, p:Array, qryDeclarados:FLSqlQuery):Boolean {
        return this.ctx.boe2011_guardarDatosListado(cursor, p, qryDeclarados);
    }
    function calcularDireccion(clave:String, codCP:String):String {
        return this.ctx.boe2011_calcularDireccion(clave, codCP);
    }
    function calcularParrafo(cursor:FLSqlCursor,parrafo:String,datosDec:Array):String {
        return this.ctx.boe2011_calcularParrafo(cursor,parrafo,datosDec);
    }
    function formatearImporte(valor:Number, enteros:Number, decimales:Number):String {
        return this.ctx.boe2011_formatearImporte(valor, enteros, decimales);
    }
}
//// BOE2011 /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition boe2011 */
/////////////////////////////////////////////////////////////////
//// BOE2011 ///////////////////////////////////////////////////
function boe2011_lanzar()
{
    this.iface.total_ = 0;
    var util:FLUtil = new FLUtil;
    var cursor:FLSqlCursor = this.cursor();
    var seleccion:String = cursor.valueBuffer("id");
    if (!seleccion)
        return;

    this.iface.listadeclarados347(cursor);

    this.iface.listado347(cursor);

}

function boe2011_listadeclarados347(cursor):Boolean{

    var util:FLUtil = new FLUtil;

    var p:Array;
    p["tipoimp"] = "Importe";
    p = formRecordco_modelo347.iface.establecerParametrosConsulta(cursor,p);

    var qryDeclarados= new FLSqlQuery;
    qryDeclarados = flcontmode.iface.pub_consultaDeclarados347(p);
    qryDeclarados.setForwardOnly(true);
    if (!qryDeclarados.exec()) {
        MessageBox.critical(util.translate("scripts", "Falló la consulta"), MessageBox.Ok, MessageBox.NoButton);
        return;
    }

    if (!this.iface.guardarDatosListado(cursor, p, qryDeclarados)) {
        MessageBox.critical(util.translate("scripts", "Falló el almacenamiento de datos para el listado"), MessageBox.Ok, MessageBox.NoButton);
        return false;
    }

    return true;
}



function boe2011_listado347(cursor:FLSqlCursor){

    var curInforme:FLSqlCursor = new FLSqlCursor("i_co_datos347_list");
    curInforme.setModeAccess(curInforme.Insert);
    curInforme.refreshBuffer();
    curInforme.setValueBuffer("i_co__datos347__list_id",cursor.valueBuffer("id"));

    var orderBy:String;
    if (cursor.valueBuffer("orden") == "NIF") {
        orderBy = " ORDER BY nifdeclarado";
    } else {
        orderBy = " ORDER BY apellidosnombrers";
    }

    var nombreInforme:String;
    if (cursor.valueBuffer("listado")) {
        nombreInforme = "co_datos347_list";
    } else {
        nombreInforme = "co_datos347_carta";
    }

    flcontmode.iface.pub_lanzar(curInforme, "co_datos347_list", orderBy, nombreInforme);


}

function boe2011_guardarDatosListado(cursor:FLSqlCursor, p:Array, qryDeclarados:FLSqlQuery):Boolean {

    var util:FLUtil = new FLUtil;
    if (!util.sqlDelete("co_datos347_list","id="+cursor.valueBuffer("id"))){
        return false;
    }

    var curDatos:FLSqlCursor = new FLSqlCursor("co_datos347_list");
    util.createProgressDialog(util.translate("scripts", "Guardando datos ..."), qryDeclarados.size());
    var progreso:Number = 0;
    while (qryDeclarados.next()) {
        if (progreso%100==0) util.setProgress(progreso);
        progreso++;
        var datosDec:Array = flcontmode.iface.pub_datosDeclarados(p,qryDeclarados);
        if ((datosDec.codPais && datosDec.codPais.toUpperCase() != "ES") || datosDec.codPais == "") {
            continue;
        }

        datosDec.codPais = "  ";

        if (datosDec.cifCP.length > 9) {
            var res= MessageBox.warning(util.translate("scripts", "El CIF ó NIF %1 (%2) correspondiente a %3 tiene más de nueve dígitos, por lo que no debería entrar en el listado de la declaración.\nPulse Ignorar para incluirlo en el listado de todas maneras,\no Cancelar para continuar con el siguiente registro").arg(datosDec.cifCP).arg(qryDeclarados.value("cifnif")).arg(datosDec.nombreCP), MessageBox.Ignore, MessageBox.Cancel);
            if (res != MessageBox.Ignore) {
                continue;
            }
        }

        var direccion:String = this.iface.calcularDireccion(p.clave,datosDec.codCP);
        var parrafo1:String = this.iface.calcularParrafo(cursor,"parrafo1",datosDec);
        var parrafo2:String = this.iface.calcularParrafo(cursor,"parrafo2",datosDec);
        var parrafo3:String = this.iface.calcularParrafo(cursor,"parrafo3",datosDec);

        curDatos.setModeAccess(curDatos.Insert);
        curDatos.refreshBuffer();
        curDatos.setValueBuffer("id", cursor.valueBuffer("id"));
        curDatos.setValueBuffer("clavecodigo", p.clave);
        curDatos.setValueBuffer("nifdeclarado", datosDec.cifCP);
        curDatos.setValueBuffer("apellidosnombrers", datosDec.nombreCP);
        curDatos.setValueBuffer("direccion", direccion);
        curDatos.setValueBuffer("importe", datosDec.importe);
        curDatos.setValueBuffer("importe1t", datosDec.importe1t);
        curDatos.setValueBuffer("importe2t", datosDec.importe2t);
        curDatos.setValueBuffer("importe3t", datosDec.importe3t);
        curDatos.setValueBuffer("importe4t", datosDec.importe4t);
        curDatos.setValueBuffer("parrafo1", parrafo1);
        curDatos.setValueBuffer("parrafo2", parrafo2);
        curDatos.setValueBuffer("parrafo3", parrafo3);

        if (!curDatos.commitBuffer()){
            debug("error guardando datos en listado de 347");
            util.destroyProgressDialog();
            return false;
        }
    }
    util.destroyProgressDialog();
    return true;
}

function boe2011_calcularDireccion(clave:String, codCP:String){

    var qryCP:FLSqlQuery = new FLSqlQuery;
    if (clave == "B") {
        qryCP.setTablesList("clientes,dirclientes");
        qryCP.setSelect("d.direccion, d.codpostal, d.ciudad, d.provincia");
        qryCP.setFrom("clientes cp INNER JOIN dirclientes d ON cp.codcliente = d.codcliente");
        qryCP.setWhere("cp.codcliente = '" + codCP + "' AND d.domfacturacion = true");
    } else {
        qryCP.setTablesList("proveedores,dirproveedores");
        qryCP.setSelect("d.direccion, d.codpostal, d.ciudad, d.provincia");
        qryCP.setFrom("proveedores cp INNER JOIN dirproveedores d ON cp.codproveedor = d.codproveedor");
        qryCP.setWhere("cp.codproveedor = '" + codCP + "' AND d.direccionppal = true");
    }
    qryCP.exec();
    var direccion:String = "";
    if (qryCP.first()) {
        direccion += qryCP.value("d.direccion")+"\n";
        direccion += qryCP.value("d.codpostal")+" - "+qryCP.value("d.ciudad")+"\n";
        direccion += qryCP.value("d.provincia");
    }

    return direccion;
}

function boe2011_calcularParrafo(cursor:FLSqlCursor,parrafo:String,datosDec:Array):String
{
    var cursor:FLSqlCursor = this.cursor();
    var valor:String = cursor.valueBuffer(parrafo);
    var importe:String;

    var regExp1:RegExp = new RegExp("#IMPORTEMINIMO#");
    regExp1.global = true;
    valor = valor.replace( regExp1, cursor.valueBuffer("cantidad") );

    var regExp2:RegExp = new RegExp("#EJERCICIO#");
    regExp2.global = true;
    valor = valor.replace( regExp2, cursor.valueBuffer("codejercicio") );

    var regExp3:RegExp = new RegExp("#IMPORTE#");
    regExp3.global = true;
    importe = this.iface.formatearImporte(datosDec.importe, 13, 2);
    valor = valor.replace( regExp3,  importe);

    var regExp4:RegExp = new RegExp("#IMPORTE1T#");
    regExp4.global = true;
    importe = this.iface.formatearImporte(datosDec.importe1t, 13, 2);
    valor = valor.replace( regExp4, importe );

    var regExp5:RegExp = new RegExp("#IMPORTE2T#");
    regExp5.global = true;
    importe = this.iface.formatearImporte(datosDec.importe2t, 13, 2);
    valor = valor.replace( regExp5, importe );

    var regExp6:RegExp = new RegExp("#IMPORTE3T#");
    regExp6.global = true;
    importe = this.iface.formatearImporte(datosDec.importe3t, 13, 2);
    valor = valor.replace( regExp6, importe );

    var regExp7:RegExp = new RegExp("#IMPORTE4T#");
    regExp7.global = true;
    importe = this.iface.formatearImporte(datosDec.importe4t, 13, 2);
    valor = valor.replace( regExp7, importe );

    return valor;
}

function boe2011_formatearImporte(valor:Number, enteros:Number, decimales:Number):String
{

    var util:FLUtil = new FLUtil;
    var importe:String = util.roundFieldValue(valor,"co_modelo347","importetotal");
    importe = util.formatoMiles(importe);

    return importe;

}
//// BOE2011 ///////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

