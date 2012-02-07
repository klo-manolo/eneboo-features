
/** @class_declaration gestesoreria */
/////////////////////////////////////////////////////////////////
//// GESTESORERIA //////////////////////////////////////////////
class gestesoreria extends pagosMultiProv {
        function gestesoreria( context ) { pagosMultiProv ( context ); }

        function datosConceptoAsiento(cur:FLSqlCursor):Array {
                return this.ctx.gestesoreria_datosConceptoAsiento(cur);
        }
}
//// GESTESORERIA //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration gastosPagosDevol */
/////////////////////////////////////////////////////////////////
//// GASTOSPAGOSDEVOL ///////////////////////////////////////////
class gastosPagosDevol extends gestesoreria {
    function gastosPagosDevol( context ) { gestesoreria( context ); }
    function datosConceptoAsiento(cur:FLSqlCursor):Array {
        return this.ctx.gastosPagosDevol_datosConceptoAsiento(cur);
    }
}
//// GASTOSPAGOSDEVOL /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration gastosPagosMulti */
/////////////////////////////////////////////////////////////////
//// GASTOSPAGOSMULTI ///////////////////////////////////////////
class gastosPagosMulti extends gastosPagosDevol {
    function gastosPagosMulti( context ) { gastosPagosDevol( context ); }
        function datosConceptoAsiento(cur:FLSqlCursor):Array {
        return this.ctx.gastosPagosMulti_datosConceptoAsiento(cur);
    }
}
//// GASTOSPAGOSMULTI /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration gastosPagosRem */
/////////////////////////////////////////////////////////////////
//// GASTOSPAGOSREM ///////////////////////////////////////////
class gastosPagosRem extends gastosPagosMulti {
    function gastosPagosRem( context ) { gastosPagosMulti( context ); }
    function datosConceptoAsiento(cur:FLSqlCursor):Array {
        return this.ctx.gastosPagosRem_datosConceptoAsiento(cur);
    }
}
//// GASTOSPAGOSREM //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration tiposremprov */
//////////////////////////////////////////////////////////////////
//// TIPOSREMPROV ////////////////////////////////////////////////
class tiposremprov extends gastosPagosRem {
    function tiposremprov( context ) { gastosPagosRem ( context ); }
    function datosConceptoAsiento(cur:FLSqlCursor):Array {
        return this.ctx.tiposremprov_datosConceptoAsiento(cur);
    }
}
//// TIPOSREMPROV /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition gestesoreria */
/////////////////////////////////////////////////////////////////
//// GESTESORERIA ///////////////////////////////////////////////
function gestesoreria_datosConceptoAsiento(cur:FLSqlCursor):Array
{
        var util:FLUtil = new FLUtil;
        var datosAsiento:Array = [];

        switch (cur.table()) {
                case "remesasprov": {
                        datosAsiento.concepto = "Remesa prov "+cur.valueBuffer("idremesa");
                        datosAsiento.tipoDocumento = "";
                        datosAsiento.documento = "";
                        break;
                }
                default: {
                        datosAsiento = this.iface.__datosConceptoAsiento(cur);
                }
        }
        return datosAsiento;
}
//// GESTESORERIA ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition gastosPagosDevol */
/////////////////////////////////////////////////////////////////
//// GASTOSPAGOSDEVOL ///////////////////////////////////////////
function gastosPagosDevol_datosConceptoAsiento(cur:FLSqlCursor):Array
{
    var util:FLUtil = new FLUtil;
    var datosAsiento:Array = [];

    switch (cur.table()) {
        case "gastospdcli":
            var qryR:FLSqlQuery = new FLSqlQuery;
            qryR.setTablesList("reciboscli,pagosdevolcli");
            qryR.setSelect("r.codigo,r.nombrecliente,p.tipo");
            qryR.setFrom("reciboscli r inner join pagosdevolcli p on r.idrecibo = p.idrecibo");
            qryR.setWhere("p.idpagodevol="+cur.valueBuffer("idpagodevol"));
            if (!qryR.exec()){
               return false;
            }
            if (!qryR.first()){
                return false;
            }
            var concepto:String = "Gastos "+qryR.value(2)+" Recibo "+qryR.value(0) + " - "+qryR.value(1);
            datosAsiento.concepto = concepto.left(255);
            datosAsiento.tipoDocumento = "";
            datosAsiento.documento = "";
            break;

        case "gastospdprov":
            var qryR:FLSqlQuery = new FLSqlQuery;
            qryR.setTablesList("recibosprov,pagosdevolprov");
            qryR.setSelect("r.codigo,r.nombreproveedor,p.tipo");
            qryR.setFrom("recibosprov r inner join pagosdevolprov p on r.idrecibo = p.idrecibo");
            qryR.setWhere("p.idpagodevol="+cur.valueBuffer("idpagodevol"));
            if (!qryR.exec()){
               return false;
            }
            if (!qryR.first()){
                return false;
            }
            var concepto:String = "Gastos "+qryR.value(2)+" Recibo prov "+qryR.value(0) + " - "+qryR.value(1);
            datosAsiento.concepto = concepto.left(255);
            datosAsiento.tipoDocumento = "";
            datosAsiento.documento = "";
            break;

        default:
            datosAsiento = this.iface.__datosConceptoAsiento(cur);

    }

    return datosAsiento;
}
//// GASTOSPAGOSDEVOL ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition gastosPagosMulti */
/////////////////////////////////////////////////////////////////
//// GASTOSPAGOSMULTI ///////////////////////////////////////////
function gastosPagosMulti_datosConceptoAsiento(cur:FLSqlCursor):Array
{
    var util:FLUtil = new FLUtil;
    var datosAsiento:Array = [];

    switch (cur.table()) {
        case "gastospmcli":
            var qryR:FLSqlQuery = new FLSqlQuery;
            qryR.setTablesList("reciboscli,pagosdevolcli,pagosmulticli,clientes");
            qryR.setSelect("c.nombre,r.codigo");
            qryR.setFrom("pagosdevolcli p INNER JOIN reciboscli r ON r.idrecibo = p.idrecibo INNER JOIN pagosmulticli m ON p.idpagomulti = m.idpagomulti INNER JOIN clientes c ON c.codcliente = m.codcliente");
            qryR.setWhere("m.idpagomulti="+cur.valueBuffer("idpagomulti"));
            if (!qryR.exec()){
               return false;
            }

            var listaRecibos:String = "";
            var nombre:String;
            while (qryR.next()) {
                if (listaRecibos != ""){
                    listaRecibos += ", ";
                }
                listaRecibos += qryR.value("r.codigo");
                nombre = qryR.value("c.nombre");
            }

            var concepto:String = "Gastos Pago Múltiple Nº"+cur.valueBuffer("idpagomulti")+" - "+nombre+" - Recibos:"+listaRecibos;
            datosAsiento.concepto = concepto.left(255);
            datosAsiento.tipoDocumento = "";
            datosAsiento.documento = "";
            break;

        case "gastospmprov":
            var qryR:FLSqlQuery = new FLSqlQuery;
            qryR.setTablesList("recibosprov,pagosdevolprov,pagosmultiprov,proveedores");
            qryR.setSelect("c.nombre,r.codigo");
            qryR.setFrom("pagosdevolprov p INNER JOIN recibosprov r ON r.idrecibo = p.idrecibo INNER JOIN pagosmultiprov m ON p.idpagomulti = m.idpagomulti INNER JOIN proveedores c ON c.codproveedor = m.codproveedor");
            qryR.setWhere("m.idpagomulti="+cur.valueBuffer("idpagomulti"));
            if (!qryR.exec()){
               return false;
            }

            var listaRecibos:String = "";
            var nombre:String;
            while (qryR.next()) {
                if (listaRecibos != ""){
                    listaRecibos += ", ";
                }
                listaRecibos += qryR.value("r.codigo");
                nombre = qryR.value("c.nombre");
            }

            var concepto:String = "Gastos Pago Múltiple Prov Nº"+cur.valueBuffer("idpagomulti")+" - "+nombre+" - Recibos:"+listaRecibos;
            datosAsiento.concepto = concepto.left(255);
            datosAsiento.tipoDocumento = "";
            datosAsiento.documento = "";
            break;

        default:
            datosAsiento = this.iface.__datosConceptoAsiento(cur);

    }
    return datosAsiento;
}
//// GASTOSPAGOSMULTI ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition gastosPagosRem */
/////////////////////////////////////////////////////////////////
//// GASTOSPAGOSREM /////////////////////////////////////////////
function gastosPagosRem_datosConceptoAsiento(cur:FLSqlCursor):Array
{
    var util:FLUtil = new FLUtil;
    var datosAsiento:Array = [];

    switch (cur.table()) {
        case "gastospdrem":
            var idRemesa = util.sqlSelect("pagosdevolrem","idremesa","idpagorem="+cur.valueBuffer("idpagorem"));
            var concepto:String = "Gastos pago remesa "+idRemesa;
            datosAsiento.concepto = concepto.left(255);
            datosAsiento.tipoDocumento = "";
            datosAsiento.documento = "";
            break;

        case "gastospdremprov":
            var idRemesa = util.sqlSelect("pagosdevolremprov","idremesa","idpagoremprov="+cur.valueBuffer("idpagoremprov"));
            var concepto:String = "Gastos pago remesa prov "+idRemesa;
            datosAsiento.concepto = concepto.left(255);
            datosAsiento.tipoDocumento = "";
            datosAsiento.documento = "";
            break;

        default:
            datosAsiento = this.iface.__datosConceptoAsiento(cur);

    }
    return datosAsiento;
}
//// GASTOSPAGOSREM /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition tiposremprov */
/////////////////////////////////////////////////////////////////
//// TIPOSREMPROV ///////////////////////////////////////////////
function tiposremprov_datosConceptoAsiento(cur:FLSqlCursor):Array
{
    var util:FLUtil = new FLUtil;
    var datosAsiento:Array = [];

    switch (cur.table()) {
        case "anticiposconf":
            var qryDatos:FLSqlQuery = new FLSqlQuery();
            qryDatos.setTablesList("recibosprov,proveedores");
            qryDatos.setSelect("r.codigo,p.nombre");
            qryDatos.setFrom("recibosprov r INNER JOIN proveedores p ON p.codproveedor = r.codproveedor");
            qryDatos.setWhere("r.idrecibo = "+cur.valueBuffer("idrecibo"));

            if (!qryDatos.exec()){
                return false;
            }

            if (!qryDatos.first()){
                return false;
            }

             var concepto:String = "Anticipo Confirming: Remesa prov "+cur.valueBuffer("idremesa")+" - Recibo: "+qryDatos.value("r.codigo")+" - "+qryDatos.value("p.nombre");
            datosAsiento.concepto = concepto.left(255);
            datosAsiento.tipoDocumento = "";
            datosAsiento.documento = "";
            break;

        default:
            datosAsiento = this.iface.__datosConceptoAsiento(cur);

    }
    return datosAsiento;
}
//// TIPOSREMPROV ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

