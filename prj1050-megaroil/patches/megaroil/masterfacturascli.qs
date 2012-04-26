
/** @class_declaration modelo303 */
/////////////////////////////////////////////////////////////////
//// MODELO 303 /////////////////////////////////////////////////
class modelo303 extends modelos {
    function modelo303( context ) { modelos ( context ); }
        function completarOpcionesModelos(arrayOps:Array):Boolean {
                return this.ctx.modelo303_completarOpcionesModelos(arrayOps);
        }
        function ejecutarOpcionModelo(opcion:String):Boolean {
                return this.ctx.modelo303_ejecutarOpcionModelo(opcion);
        }
        function configurarBotonModelos() {
                return this.ctx.modelo303_configurarBotonModelos();
        }
}
//// MODELO 303 /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition modelo303 */
/////////////////////////////////////////////////////////////////
//// MODELO 303 /////////////////////////////////////////////////
function modelo303_configurarBotonModelos()
{
        return true;
}

function modelo303_completarOpcionesModelos(arrayOps:Array):Boolean
{
        var util:FLUtil = new FLUtil;
        var cursor:FLSqlCursor = this.cursor();

        var i:Number = arrayOps.length;
        arrayOps[i] = [];
        if (cursor.valueBuffer("excluir303")) {
                arrayOps[i]["texto"] = util.translate("scripts", "Incluir en modelo 303");
                arrayOps[i]["opcion"] = "303IN";
        } else {
                arrayOps[i]["texto"] = util.translate("scripts", "Excluir de modelo 303");
                arrayOps[i]["opcion"] = "303EX";
        }
        return true;
}

function modelo303_ejecutarOpcionModelo(opcion:String):Boolean
{

        var util:FLUtil = new FLUtil;
        var cursor:FLSqlCursor = this.cursor();

        if (opcion != "303IN" && opcion != "303EX") {
                return this.iface.__ejecutarOpcionModelo(opcion);
        }

        var curFactura:FLSqlCursor = new FLSqlCursor("facturascli");
        curFactura.setActivatedCheckIntegrity(false);
        curFactura.setActivatedCommitActions(false);
        var idFactura:String = cursor.valueBuffer("idfactura");
        curFactura.select("idfactura = " + idFactura);
        if (!curFactura.first()) {
                return false;
        }

        var editable:Boolean = curFactura.valueBuffer("editable");
        if (!editable) {
                curFactura.setUnLock("editable", true);
                curFactura.select("idfactura = " + idFactura);
                if (!curFactura.first()) {
                        return false;
                }
        }

        curFactura.setModeAccess(curFactura.Edit);
        curFactura.refreshBuffer();
        if (opcion == "303EX") {
                curFactura.setValueBuffer("excluir303", true);
        } else {
                curFactura.setValueBuffer("excluir303", false);
        }
        if (!curFactura.commitBuffer()) {
                return false;
        }

        if (!editable) {
                curFactura.select("idfactura = " + idFactura);
                if (!curFactura.first()) {
                        return false;
                }
                curFactura.setUnLock("editable", false);
        }

        if (opcion == "303EX") {
                MessageBox.information(util.translate("scripts", "La factura %1 será excluida del modelo 303").arg(cursor.valueBuffer("codigo")), MessageBox.Ok, MessageBox.NoButton);
        } else {
                MessageBox.information(util.translate("scripts", "La factura %1 será incluida en el modelo 303").arg(cursor.valueBuffer("codigo")), MessageBox.Ok, MessageBox.NoButton);
        }
        this.iface.tdbRecords.refresh();
        return true;
}

//// MODELO 303 /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

