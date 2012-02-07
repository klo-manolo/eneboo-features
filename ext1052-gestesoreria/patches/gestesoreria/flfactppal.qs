
/** @class_declaration tiposremprov */
//////////////////////////////////////////////////////////////////
//// TIPOSREMPROV ////////////////////////////////////////////////
class tiposremprov extends oficial {
    function tiposremprov( context ) { oficial ( context ); }
    function datosOtraSubcuentaProveedor(ctaEsp:String, codproveedor:String, valoresDefecto:Array):Array {
        return this.ctx.tiposremprov_datosOtraSubcuentaProveedor(ctaEsp, codproveedor, valoresDefecto);
    }
    function datosCuentaEspecial(ctaEsp:String, codEjercicio:String):Array {
        return this.ctx.tiposremprov_datosCuentaEspecial(ctaEsp, codEjercicio);
    }
    function crearSubcuenta(codSubcuenta:String, descripcion:String, idCuentaEsp:String, codEjercicio:String):Number {
        return this.ctx.tiposremprov_crearSubcuenta(codSubcuenta, descripcion, idCuentaEsp, codEjercicio);
    }
}
//// TIPOSREMPROV ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubTiposremprov */
////////////////////////////////////////////////////////////////
//// PUB_TIPOSREMPROV //////////////////////////////////////////
class pubTiposremprov extends ifaceCtx {
function pubTiposremprov( context ) { ifaceCtx( context ); }
    function pub_datosOtraSubcuentaProveedor(ctaEsp:String, codproveedor:String, valoresDefecto:Array):Array {
        return this.datosOtraSubcuentaProveedor(ctaEsp, codproveedor, valoresDefecto);
    }
    function pub_datosCuentaEspecial(ctaEsp:String, codEjercicio:String):Array {
        return this.datosCuentaEspecial(ctaEsp, codEjercicio);
    }
    function pub_crearSubcuenta(codSubcuenta:String, descripcion:String, idCuentaEsp:String, codEjercicio:String):Number {
        return this.crearSubcuenta(codSubcuenta, descripcion, idCuentaEsp, codEjercicio);
    }
}

//// PUB_TIPOSREMPROV //////////////////////////////////////////
//////////////////////////////////////////////////////////////

/** @class_definition tiposremprov */
/////////////////////////////////////////////////////////////////
//// TIPOSREMPROV //////////////////////////////////////////////
/**\ usando una cuenta especial, busca o crea los datos de subcuenta de proveedor validos para el ejercicio: devuelve Array*/
function tiposremprov_datosOtraSubcuentaProveedor(ctaEsp:String, codproveedor:String, valoresDefecto:Array):Array
{
    var util:FLUtil = new FLUtil();
    var datosSubCuenta:Array=[];
    datosSubCuenta["error"] = 0;

    var longSubcuenta = util.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + valoresDefecto.codejercicio + "'");
    if (!longSubcuenta){
        MessageBox.warning(util.translate("scripts","Error al leer los datos por defecto para el ejercicio %1").arg(valoresDefecto.codejercicio),MessageBox.Ok,MessageBox.NoButton);
        datosSubCuenta["error"] = 3;
        return datosSubCuenta;
    }

    var datosCtaEsp = this.iface.datosCuentaEspecial(ctaEsp, valoresDefecto.codejercicio);
    if (datosCtaEsp["error"] != 0){
        MessageBox.warning(util.translate("scripts", "No existe ninguna cuenta contable marcada como tipo especial %1 para el ejercicio\nDebe asociar una cuenta contable a dicho tipo especial en el módulo Principal del área Financiera").arg(ctaEsp).arg(valoresDefecto.codejercicio), MessageBox.Ok, MessageBox.NoButton);
        datosSubCuenta["error"] = 3;
        return datosSubCuenta;
    }

    var subctaProveedor:Array = this.iface.datosCtaProveedor(codproveedor, valoresDefecto );
    if (subctaProveedor["error"] != 0){
        MessageBox.warning(util.translate("scripts","Error al leer los datos de subcuenta del proveedor para el ejercicio %1").arg(valoresDefecto.codejercicio),MessageBox.Ok, MessageBox.NoButton);
        datosSubCuenta["error"] = 3;
        return datosSubCuenta;
    }

    if (subctaProveedor["codsubcuenta"].length != longSubcuenta){
        MessageBox.warning(util.translate("scripts","Error al leer los datos de subcuenta del proveedor para el ejercicio %1").arg(valoresDefecto.codejercicio),MessageBox.Ok, MessageBox.NoButton);
        datosSubCuenta["error"] = 3;
        return datosSubCuenta;
    }

    var codCuentaOrig:String = util.sqlSelect("co_subcuentas","codcuenta","codsubcuenta='"+subctaProveedor["codsubcuenta"]+"' AND codejercicio='"+valoresDefecto.codejercicio+"'");
    if (!codCuentaOrig){
        MessageBox.warning(util.translate("scripts","Error al leer los datos de subcuenta del proveedor para el ejercicio %1").arg(valoresDefecto.codejercicio),MessageBox.Ok, MessageBox.NoButton);
        datosSubCuenta["error"] = 3;
        return datosSubCuenta;
    }

    var codSubcuenta:String = datosCtaEsp["codcuenta"];
    var finSubcuenta:String = subctaProveedor["codsubcuenta"].substring(codCuentaOrig.length,longSubcuenta);

    var numCeros:Number = longSubcuenta - codSubcuenta.length - finSubcuenta.length;
    for (var i:Number = 0; i < numCeros; i++){
        codSubcuenta += "0";
    }

    if (codSubcuenta.length + finSubcuenta.length > longSubcuenta){
        finSubcuenta = finSubcuenta.right(longSubcuenta - codSubcuenta.length);
    }

    codSubcuenta += finSubcuenta;

    if (codSubcuenta.length != longSubcuenta){
        MessageBox.warning(util.translate("scripts","Error al crear los datos de subcuenta del proveedor\nde tipo especial %1 para el ejercicio %2").arg(ctaEsp).arg(valoresDefecto.codejercicio),MessageBox.Ok, MessageBox.NoButton);
        datosSubCuenta["error"] = 3;
        return datosSubCuenta;
    }

    var idSubcuenta = util.sqlSelect("co_subcuentas","idsubcuenta","codsubcuenta='"+codSubcuenta+"' AND codejercicio='"+valoresDefecto.codejercicio+"'");
    debug("idSubcuenta="+idSubcuenta);
    if (idSubcuenta) {
        datosSubCuenta["error"] = 0;
        datosSubCuenta["codsubcuenta"] = codSubcuenta;
        datosSubCuenta["idsubcuenta"] = idSubcuenta;
        return datosSubCuenta;
    }

    var descripcion:String  = util.sqlSelect("proveedores","nombre","codproveedor='"+codproveedor+"'");
    var idSubcuenta = this.iface.crearSubcuenta(codSubcuenta, descripcion, ctaEsp, valoresDefecto.codejercicio);

    if (!idSubcuenta) {
        datosSubCuenta["error"] = 0;
        return datosSubCuenta;
    }

    datosSubCuenta["error"] = 0;
    datosSubCuenta["codsubcuenta"] = codSubcuenta;
    datosSubCuenta["idsubcuenta"] = idSubcuenta;
    return datosSubCuenta;

}

/*Para no dar cabida a errores:
 * En el modulo de facturacion, en el script flfacturac.qs hacen una llamada a la función datosCtaEspecial, pero ésta devuelve idsubcuenta y codsubcuenta para un tipo de cuenta especial en un ejercicio(desde la tabla co_subcuentas de 8 ó 10 dígitos: debería, por lógica, originalmente haberse llamado datosSbctaEspecial pero NO!)
 * La función siguiente, devuelve el idcuenta y el codcuenta para un tipo de cuenta especial en un ejercicio (desde la tabla co_cuentas de 3 o 4 dígitos)
*/

function tiposremprov_datosCuentaEspecial(ctaEsp:String, codEjercicio:String):Array
{
    var util:FLUtil = new FLUtil();
    var datosCta:Array = [];
    datosCta["error"] = 0;
    var q:FLSqlQuery = new FLSqlQuery();

    q.setTablesList("co_cuentas");
    q.setSelect("idcuenta,codcuenta");
    q.setFrom("co_cuentas");
    q.setWhere("idcuentaesp = '" + ctaEsp + "' AND codejercicio = '" + codEjercicio + "'");

    try { q.setForwardOnly( true ); } catch (e) {}
    if (!q.exec()) {
            datosCta["error"] = 2;
            return datosCta;
    }

    if (q.first()) {
        datosCta["error"] = 0;
        datosCta["idcuenta"] = q.value(0);
        datosCta["codcuenta"] = q.value(1);
        return datosCta;
    }

    q.setTablesList("co_cuentas,co_cuentasesp");
    q.setSelect("c.idcuenta,c.codcuenta");
    q.setFrom("co_cuentas c INNER JOIN co_cuentasesp ce ON c.codcuenta = ce.codcuenta ");
    q.setWhere("ce.idcuentaesp = '" + ctaEsp + "' AND c.codejercicio = '" + codEjercicio + "'");

    try { q.setForwardOnly( true ); } catch (e) {}

    if (!q.exec()) {
        datosCta["error"] = 2;
        return datosCta;
    }

    if (q.first()) {
        datosCta["error"] = 0;
        datosCta["idcuenta"] = q.value(0);
        datosCta["codcuenta"] = q.value(1);
        return datosCta;
    } else {
        datosCta["error"] = 2;
        return datosCta;
    }

}

/** \D
Crea una subcuenta contable, si no existe ya la combinación Código de subcuenta - Ejercicio actual
La diferencia con la función de oficial es que agrega una descripcion en determinados casos de ctaesp y pone idcuentaesp en co_subcuentas
@param  codSubcuenta: Código de la subcuenta a crear
@param  descripcion: Descripción de la subcuenta a crear
@param  idCuentaEsp: Indicador del tipo de cuenta especial (
@param  codEjercicio: Código del ejercicio en el que se va a crear la subcuenta
@return id de la subcuenta creada o ya existente.
\end */
function tiposremprov_crearSubcuenta(codSubcuenta:String, descripcion:String, idCuentaEsp:String, codEjercicio:String):Number
{
    var util:FLUtil = new FLUtil();

    var datosEmpresa:Array;
    if (!codEjercicio) {
        datosEmpresa["codejercicio"] = this.iface.ejercicioActual();
    } else {
        datosEmpresa["codejercicio"] = codEjercicio;
    }
    datosEmpresa["coddivisa"] = this.iface.valorDefectoEmpresa("coddivisa");

    var idSubcuenta:String = util.sqlSelect("co_subcuentas", "idsubcuenta","codsubcuenta = '" + codSubcuenta + "' AND codejercicio = '" + datosEmpresa.codejercicio + "'");
    if (idSubcuenta) {
        return idSubcuenta;
    }

    var codCuenta3:String = codSubcuenta.left(3);
    var codCuenta4:String = codSubcuenta.left(4);

    var datosCuenta:Array = this.iface.ejecutarQry("co_cuentas", "codcuenta,idcuenta","idcuentaesp = '" + idCuentaEsp + "' AND codcuenta = '" + codCuenta4 + "' AND codejercicio = '" + datosEmpresa.codejercicio + "' ORDER BY codcuenta");

    if (datosCuenta.result == -1) {
        datosCuenta = this.iface.ejecutarQry("co_cuentas", "codcuenta,idcuenta", "idcuentaesp = '" + idCuentaEsp + "'" + " AND codcuenta = '" + codCuenta3 + "'" + " AND codejercicio = '" + datosEmpresa.codejercicio + "' ORDER BY codcuenta");

        if (datosCuenta.result == -1)  {
              datosCuenta = this.iface.ejecutarQry("co_cuentas", "codcuenta,idcuenta","codcuenta = '" + codCuenta4 + "' AND codejercicio = '" + datosEmpresa.codejercicio + "' ORDER BY codcuenta");

              if (datosCuenta.result == -1) {
                   datosCuenta = this.iface.ejecutarQry("co_cuentas", "codcuenta,idcuenta","codcuenta = '" + codCuenta3 + "' AND codejercicio = '" + datosEmpresa.codejercicio + "' ORDER BY codcuenta");
                     if (datosCuenta.result == -1) {
                        return false;
                }
            }
        }
    }

    var curSubcuenta:FLSqlCursor = new FLSqlCursor("co_subcuentas");
    curSubcuenta.setModeAccess(curSubcuenta.Insert);
    curSubcuenta.refreshBuffer();
    curSubcuenta.setValueBuffer("codsubcuenta", codSubcuenta);
    curSubcuenta.setValueBuffer("descripcion", descripcion);
    curSubcuenta.setValueBuffer("idcuenta", datosCuenta.idcuenta);
    curSubcuenta.setValueBuffer("codcuenta", datosCuenta.codcuenta);
    curSubcuenta.setValueBuffer("coddivisa", datosEmpresa.coddivisa);
    curSubcuenta.setValueBuffer("codejercicio", datosEmpresa.codejercicio);
    curSubcuenta.setValueBuffer("idcuentaesp", idCuentaEsp);

    if (!curSubcuenta.commitBuffer()) {
        return false;
    }

    return curSubcuenta.valueBuffer("idsubcuenta");
}
//// TIPOSREMPROV //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

