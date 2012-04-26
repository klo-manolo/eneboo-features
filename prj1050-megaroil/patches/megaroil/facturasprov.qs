
/** @class_declaration modelo115 */
/////////////////////////////////////////////////////////////////
//// MODELO 115 /////////////////////////////////////////////////
class modelo115 extends modelo347 {
    function modelo115( context ) { modelo347 ( context ); }
        function calcularTotales() {
                return this.ctx.modelo115_calcularTotales();
        }
        function incluir115():Boolean {
                return this.ctx.modelo115_incluir115();
        }
}

//// MODELO 115 /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition modelo115 */
/////////////////////////////////////////////////////////////////
//// MODELO 115 /////////////////////////////////////////////////
function modelo115_calcularTotales()
{
        this.iface.__calcularTotales();
        this.iface.incluir115();
}

function modelo115_incluir115():Boolean
{
        var cursor:FLSqlCursor = this.cursor();
        var util:FLUtil = new FLUtil();
        var qry:FLSqlQuery = new FLSqlQuery;
        qry.setTablesList("lineasfacturasprov,articulos");
        qry.setSelect("a.arrendamiento,lf.referencia");
        qry.setFrom("lineasfacturasprov lf INNER JOIN articulos a ON lf.referencia = a.referencia");
        qry.setWhere("lf.idfactura = " + cursor.valueBuffer("idfactura"));
        qry.setForwardOnly(true);

        if (!qry.exec()) {
                return false;
        }
        this.child("fdbIncluir115").setValue(false);
        while (qry.next()) {
                if (qry.value("a.arrendamiento") == true) {
                        this.child("fdbIncluir115").setValue(true);
                        return true;
                }
        }
        return true;
}

//// MODELO 115 /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

