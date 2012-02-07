
/** @class_declaration gestesoreria */
/////////////////////////////////////////////////////////////////
//// GESTESORERIA ///////////////////////////////////////////////
class gestesoreria extends oficial {

        var tipoConta:String;
        function gestesoreria( context ) { oficial ( context ); }

        function init() {
                this.ctx.gestesoreria_init();
        }
        function calculateField(fN:String):String {
                return this.ctx.gestesoreria_calculateField(fN);
        }
        function actualizarTotal() {
               return this.ctx.gestesoreria_actualizarTotal();
        }
        function agregarRecibo():Boolean {
                return this.ctx.gestesoreria_agregarRecibo();
        }
        function eliminarRecibo() {
                return this.ctx.gestesoreria_eliminarRecibo();
        }
        function bufferChanged(fN:String) {
                return this.ctx.gestesoreria_bufferChanged(fN);
        }
        function asociarReciboRemesa(idRecibo:String, curRemesa:FLSqlCursor):Boolean {
                return this.ctx.gestesoreria_asociarReciboRemesa(idRecibo, curRemesa);
        }
        function auxExcluirReciboRemesa(idRecibo:String, idRemesa:String):Boolean {
                return this.ctx.gestesoreria_auxExcluirReciboRemesa(idRecibo, idRemesa);
        }
        function excluirReciboRemesa(idRecibo:String, idRemesa:String,dryRun:Boolean):Boolean {
                return this.ctx.gestesoreria_excluirReciboRemesa(idRecibo, idRemesa, dryRun);
        }
        function validateForm():Boolean {
               return this.ctx.gestesoreria_validateForm();
        }
        function verificarHabilitaciones(){
                return this.ctx.gestesoreria_verificarHabilitaciones();
        }
        function refrescarRecibosProv(){
                return this.ctx.gestesoreria_refrescarRecibosProv();
        }
        function idRecibosRemesa(idRemesa:String):String{
                return this.ctx.gestesoreria_idRecibosRemesa(idRemesa)
        }
        function directaEditable(idRemesa:String){
                return this.ctx.gestesoreria_directaEditable(idRemesa)
        }
        function filtroRecibosProv():String {
                return this.ctx.gestesoreria_filtroRecibosProv();
        }
}
//// GESTESORERIA/////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration tiposremprov */
//////////////////////////////////////////////////////////////////
//// TIPOSREMPROV ////////////////////////////////////////////////
class tiposremprov extends gestesoreria {
    var tipoRem:String;
    var tipoConta:String;
    var cbxTipoRem:Object;
    var gbxProv:Object;
    function tiposremprov( context ) { gestesoreria ( context ); }
    function init() {
        this.ctx.tiposremprov_init();
    }
    function cambiarTipoRem(){
        return this.ctx.tiposremprov_cambiarTipoRem();
    }
    function agregarRecibo():Boolean {
        return this.ctx.gestesoreria_agregarRecibo();
    }
    function filtroRecibosProv():String {
        return this.ctx.tiposremprov_filtroRecibosProv();
    }
    function validateForm():Boolean {
        return this.ctx.tiposremprov_validateForm();
    }
}
//// TIPOSREMPROV /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration pubGesTesoreria */
/////////////////////////////////////////////////////////////////
//// PUB GESTESORERIA /////////////////////////////////////////////////
class pubGesTesoreria extends ifaceCtx {
	function pubGesTesoreria( context ) { ifaceCtx( context ); }
	function pub_excluirReciboRemesa(idRecibo:String, idRemesa:String, dryRun:Boolean):Boolean {
		return this.excluirReciboRemesa(idRecibo, idRemesa, dryRun);
	}
	function pub_idRecibosRemesa(idRemesa:String):String{
		return this.idRecibosRemesa(idRemesa)
	}
	function pub_idRecibosRemesa(idRemesa:String):String{
		return this.idRecibosRemesa(idRemesa)
	}
}
//// PUB GESTESORERIA /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition gestesoreria */
/////////////////////////////////////////////////////////////////
//// GESTESORERIA ///////////////////////////////////////////////

function gestesoreria_init()
{
        var cursor:FLSqlCursor = this.cursor();
        var util:FLUtil = new FLUtil;

        this.iface.ejercicioActual = flfactppal.iface.pub_ejercicioActual();
        this.iface.longSubcuenta = util.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + this.iface.ejercicioActual + "'");

        var tipoContaG:String = util.sqlSelect("factteso_general", "tipoconta34", "1=1");
        if (!tipoContaG || tipoContaG==""){
                Messagebox.warning("No se ha encontrado la configuración por defecto",MessageBox.Ok,MessageBox.NoButton);
                return false;
        }

        connect(this.child("tbInsert"), "clicked()", this, "iface.agregarRecibo");
        connect(this.child("tbDelete"), "clicked()", this, "iface.eliminarRecibo");
        connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
        connect(this.child("tdbPagosDevolRemProv").cursor(), "bufferCommited()", this, "iface.cambiarEstado");

        this.iface.bufferChanged("estado");

        var tabPagos:Boolean = true;
        switch(cursor.modeAccess()){
                case cursor.Insert:
                        tabPagos = false;
                        this.iface.tipoConta = tipoContaG;
                        cursor.setValueBuffer("coddivisa", flfactppal.iface.pub_valorDefectoEmpresa("coddivisa"));
                        cursor.setValueBuffer("tipoconta", this.iface.tipoConta);
                        cursor.setValueBuffer("nogenerarasiento",this.iface.calculateField("nogenerarasiento"));
                        break;

                case cursor.Edit:
                        this.iface.tipoConta = cursor.valueBuffer("tipoconta");
                        this.iface.verificarHabilitaciones();
                        if (cursor.valueBuffer("cerrada")==true){
                                this.child("tbInsert").enabled = false;
                                this.child("tbDelete").enabled = false;
                                this.child("fdbNoGenerarAsiento").setDisabled(true);
                        }else{
                                var editable= this.iface.directaEditable(cursor.valueBuffer("idremesa"));
                                if (cursor.valueBuffer("tipoconta")=="100" && !editable){
                                        cursor.setModeAccess(cursor.Browse)
                                        this.child("tbInsert").enabled = false;
                                        this.child("tbDelete").enabled = false;
                                }

                                if (cursor.valueBuffer("cerrada") == false){
                                        tabPagos = false;
                                }
                        }
                        break;
        }

        var tabConta:Boolean = true;
        this.iface.contabActivada = sys.isLoadedModule("flcontppal") && util.sqlSelect("empresa", "contintegrada", "1 = 1");
        if (!this.iface.contabActivada || this.iface.tipoConta =="100") {
                tabConta = false;
        }

        this.child("tbwRemesa").setTabEnabled("contabilidad", tabConta);
        this.child("tbwRecibos").setTabEnabled("pagos", tabPagos);

        this.iface.refrescarRecibosProv();

}

function gestesoreria_validateForm():Boolean
{
        var util:FLUtil = new FLUtil;
        var cursor:FLSqlCursor = this.cursor();

        /** \C La remesa debe tener al menos un recibo */
        if (this.child("tdbRecibos").cursor().size() < 1) {
                MessageBox.warning(util.translate("scripts", "La remesa debe tener al menos un recibo."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
                return false;
        }

        if (!cursor.valueBuffer("tipoconta") || cursor.valueBuffer("tipoconta")==""){
                MessageBox.warning(util.translate("scripts", "Ocurrio un error en la configuracion de contabilidad en la remesa."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
                return false;
        }

        if (!cursor.valueBuffer("codsubcuenta") || cursor.valueBuffer("codsubcuenta")=="" || !cursor.valueBuffer("idsubcuenta") || cursor.valueBuffer("idsubcuenta") == ""){
                MessageBox.warning("La cuenta bancaria seleccionada no tiene asociada una subcuenta de contabilidad o no existe la subcuenta para este ejercicio.\nDebe asignar esta subcuenta, o crearla para el ejercicio actual", MessageBox.Ok, MessageBox.NoButton);
                return false;
        }

        if (this.iface.tipoConta == "200"){
                if (!cursor.valueBuffer("codsubcuentaecgp") || cursor.valueBuffer("codsubcuentaecgp")=="" || !cursor.valueBuffer("idsubcuentaecgp") || cursor.valueBuffer("idsubcuentaecgp") == ""){
                        MessageBox.warning("La cuenta bancaria seleccionada no tiene asociada una subcuenta de Efectos comerciales de gestión de pago o no existe la subcuenta para este ejercicio.\nDebe asignar esta subcuenta, o crearla para el ejercicio actual", MessageBox.Ok, MessageBox.NoButton);
                        return false;
                }
        }

    return true;
}

function gestesoreria_calculateField(fN:String):String
{
        var util:FLUtil = new FLUtil();
        var cursor = this.cursor();

        var res:String;
        switch (fN) {
                case "codsubcuenta":
                        res = util.sqlSelect("cuentasbanco", "codsubcuenta", "codcuenta ='" +cursor.valueBuffer("codcuenta")+"'");
                        if (!res) res="";
                        break;

                case "codsubcuentaecgp":{
                        res = util.sqlSelect("cuentasbanco", "codsubcuentaecgp", "codcuenta ='"+cursor.valueBuffer("codcuenta")+"'");
                        if (!res) res="";
                        break;
                }
                case "idsubcuenta":
                                var codSubcuenta:String = cursor.valueBuffer("codsubcuenta").toString();
                                if (codSubcuenta.length == this.iface.longSubcuenta){
                                res = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta ='" + codSubcuenta + "' AND codejercicio ='" + this.iface.ejercicioActual + "'");
                                if (!res) res="";
                                }
                                break;

                case "idsubcuentaecgp":
                                var codSubcuentaecgp:String = cursor.valueBuffer("codsubcuentaecgp").toString();
                                if (codSubcuentaecgp.length == this.iface.longSubcuenta){
                                res = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta ='" + codSubcuentaecgp + "' AND codejercicio ='" + this.iface.ejercicioActual + "'");
                                if (!res) res="";
                                }
                                break;

                case "total":
                        var idRecibos = this.iface.idRecibosRemesa(cursor.valueBuffer("idremesa"));
                        res = util.sqlSelect("recibosprov", "SUM(importe)", "idrecibo IN ("+idRecibos+")");
                        res = parseFloat(util.roundFieldValue(res,"remesasprov","total"));
                        break;

                case "nogenerarasiento":
                    res = false;
                    if (cursor.valueBuffer("tipoconta")=="100") res = true;
                    break;

        }
        return res;
}

function gestesoreria_actualizarTotal()
{

        this.child("total").setValue(this.iface.calculateField("total"));
        this.iface.verificarHabilitaciones();

}

/** \D Se agrega un recibo a la remesa. Si la contabilidad está integrada se comprueba que se ha seleccionado una subcuenta */
function gestesoreria_agregarRecibo():Boolean
{
        var util:FLUtil = new FLUtil();
        var cursor:FLSqlCursor = this.cursor();

        if (!cursor.valueBuffer("codcuenta")) {
                MessageBox.warning(util.translate("scripts", "Debe indicar una cuenta bancaria"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
                return;
        }

        if (!cursor.valueBuffer("codsubcuenta") || cursor.valueBuffer("codsubcuenta")==""){
                MessageBox.warning("La cuenta bancaria seleccionada no tiene asociada una subcuenta de contabilidad o no existe la subcuenta para este ejercicio.\nDebe asignar esta subcuenta, o crearla para el ejercicio actual", MessageBox.Ok, MessageBox.NoButton);
                return false;
        }

        if (this.iface.tipoConta!="100"){
            if (!cursor.valueBuffer("codsubcuentaecgp") || cursor.valueBuffer("codsubcuentaecgp")==""){
                MessageBox.warning("La cuenta bancaria seleccionada no tiene asociada una subcuenta de Efectos comerciales de gestión de pago o no existe la subcuenta para este ejercicio.\nDebe asignar esta subcuenta, o crearla para el ejercicio actual", MessageBox.Ok, MessageBox.NoButton);
                return false;
            }
        }

        var f:Object = new FLFormSearchDB("seleccionrecibosprov");
        var curRecibos:FLSqlCursor = f.cursor();
        var fecha:String = cursor.valueBuffer("fecha");

        if (cursor.modeAccess() != cursor.Browse){
                if (!cursor.checkIntegrity())
                        return;
        }

        curRecibos.select();
        if (!curRecibos.first())
                curRecibos.setModeAccess(curRecibos.Insert);
        else
                curRecibos.setModeAccess(curRecibos.Edit);

        f.setMainWidget();
        curRecibos.refreshBuffer();
        curRecibos.setValueBuffer("datos", "");
        curRecibos.setValueBuffer("filtro", this.iface.filtroRecibosProv());

        var ret = f.exec( "datos" );

        if ( !f.accepted() )
                return false;

        var datos:String = new String( ret );

        if ( datos.isEmpty() )
                return false;

        var recibos:Array = datos.split(",");

        for (var i:Number = 0; i < recibos.length; i++) {
                if (!this.iface.asociarReciboRemesa(recibos[i], cursor))
                        return false;
        }

        this.iface.refrescarRecibosProv();
        this.iface.actualizarTotal();
}

/** \D Se elimina el recibo activo de la remesa. El pago asociado a la remesa debe ser el último asignado al recibo
\end */
function gestesoreria_eliminarRecibo()
{
        if (!this.child("tdbRecibos").cursor().isValid())
                return;

        var recibo:String = this.child("tdbRecibos").cursor().valueBuffer("idrecibo");
        if (!this.iface.excluirReciboRemesa(recibo, this.cursor().valueBuffer("idremesa")))
                return

        this.iface.refrescarRecibosProv();
        this.iface.actualizarTotal();
}

function gestesoreria_excluirReciboRemesa(idRecibo:String, idRemesa:String, dryRun:Boolean):Boolean
{
        var util:FLUtil = new FLUtil;

        var curPagosDev:FLSqlCursor = new FLSqlCursor("pagosdevolprov");
        curPagosDev.select("idrecibo = " + idRecibo + " AND idremesa ="+idRemesa +" ORDER BY idpagodevol");
        if (curPagosDev.first()){
                var idpagodevol = curPagosDev.valueBuffer("idpagodevol");
                curPagosDev.select("idrecibo = " + idRecibo + " AND idpagodevol>"+idpagodevol);
                if (curPagosDev.first()){
                        var codigo = util.sqlSelect("recibosprov","codigo","idrecibo='"+idRecibo+"'");
                        MessageBox.warning(util.translate("scripts", "Para excluir el recibo %1 de la remesa debe eliminar antes los pagos o devoluciones").arg(codigo), MessageBox.Ok, MessageBox.NoButton);
                        return false;
                }else{
                        if (dryRun) return true;
                        if(!util.sqlDelete("pagosdevolprov","idpagodevol="+idpagodevol)){
                                return false;
                        }
                        if (!this.iface.auxExcluirReciboRemesa(idRecibo,idRemesa)){
                                return false;
                        }
                }
        }else{
                if (dryRun) return true;
                if (!this.iface.auxExcluirReciboRemesa(idRecibo,idRemesa)){
                        return false;
                }
        }

        return true;
}

function gestesoreria_auxExcluirReciboRemesa(idRecibo:String, idRemesa:String):Boolean
{
        var estado:String;
        var curPagosDev:FLSqlCursor = new FLSqlCursor("pagosdevolprov");
        curPagosDev.select("idrecibo = " + idRecibo + " ORDER BY fecha,idpagodevol");
        if (curPagosDev.last()) {
                curPagosDev.setUnLock("editable", true);
        }

        if (curPagosDev.size() == 0){
                estado="Emitido";
        }else{
                estado="Devuelto";
        }

        if(!curPagosDev.commitBuffer)
                return false;

        var curRecibos:FLSqlCursor = new FLSqlCursor("recibosprov");
        curRecibos.select("idrecibo = " + idRecibo);

        if (!curRecibos.first())
                return false;

        curRecibos.setModeAccess(curRecibos.Edit);
        curRecibos.refreshBuffer();
        curRecibos.setValueBuffer("estado",estado);
        curRecibos.setNull("idremesa");

        if (!curRecibos.commitBuffer())
                return false;

        var curRM:FLSqlCursor = new FLSqlCursor("recibosprovremesa");
        curRM.select("idrecibo = '"+idRecibo+"' AND idremesa='"+idRemesa+"'");
        if (!curRM.first())
                return false;

        curRM.setModeAccess(curRM.Del);
        curRM.refreshBuffer();
        if (!curRM.commitBuffer())
                return false;


        return true;

}

/** \D Asocia un recibo a una remesa
@param  idRecibo: Identificador del recibo
@param  curRemesa: Cursor posicionado en la remesa
@return true si la asociación se realiza de forma correcta, false en caso contrario
\end */
function gestesoreria_asociarReciboRemesa(idRecibo:String, curRemesa:FLSqlCursor):Boolean
{
        var util:FLUtil = new FLUtil;
        var idRemesa:String = curRemesa.valueBuffer("idremesa");

        if (util.sqlSelect("recibosprov", "coddivisa", "idrecibo = " + idRecibo) != curRemesa.valueBuffer("coddivisa")) {
                MessageBox.warning(util.translate("scripts", "No es posible incluir el recibo.\nLa divisa del recibo y de la remesa deben ser la misma."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
                return;
        }

        var curRecibos:FLSqlCursor = new FLSqlCursor("recibosprov");
        curRecibos.select("idrecibo = " + idRecibo);
        if (!curRecibos.first()) return false;

        if (!curRecibos.valueBuffer("codcuenta") || curRecibos.valueBuffer("codcuenta") ==""){
                var continuar = MessageBox.warning("Precaución: El recibo "+curRecibos.valueBuffer("codigo")+" no tiene asignada\nuna cuenta válida.\n¿Desea continuar de todas formas?",MessageBox.Ok, MessageBox.Cancel);
                if (continuar != MessageBox.Ok){
                        return true;
                }
        }

       var datosCuenta:Array = flfactppal.iface.pub_ejecutarQry("cuentasbanco", "ctaentidad,ctaagencia,cuenta", "codcuenta = '" + curRemesa.valueBuffer("codcuenta") + "'");
        if (datosCuenta.result != 1)
                return false;

        var curRecibosRem:FLSqlCursor = new FLSqlCursor("recibosprovremesa");
        curRecibosRem.setModeAccess(curRecibosRem.Insert);
        curRecibosRem.refreshBuffer();
        curRecibosRem.setValueBuffer("idremesa", idRemesa);
        curRecibosRem.setValueBuffer("idrecibo", idRecibo);
        if (!curRecibosRem.commitBuffer()){
                return false;
        }

        curRecibos.setActivatedCheckIntegrity(false);
        curRecibos.setModeAccess(curRecibos.Edit);
        curRecibos.refreshBuffer();
        curRecibos.setValueBuffer("idremesa", idRemesa);
        curRecibos.setValueBuffer("estado","Remesado");
        if (!curRecibos.commitBuffer()){
                return false;
        }

        curRecibos.setActivatedCheckIntegrity(true);

        return true;
}

function gestesoreria_bufferChanged(fN:String)
{
        var cursor:FLSqlCursor = this.cursor();
        var util:FLUtil = new FLUtil();
        switch (fN) {
                case "codcuenta":
                        var codsubcuenta=this.iface.calculateField("codsubcuenta");
                        var codsubcuentaecgp=this.iface.calculateField("codsubcuentaecgp");
                        if (codsubcuenta && codsubcuenta !="") {
                            cursor.setValueBuffer("codsubcuenta",codsubcuenta);
                        }
                        if (codsubcuentaecgp && codsubcuentaecgp !="") {
                            cursor.setValueBuffer("codsubcuentaecgp",codsubcuentaecgp);
                        }

                        var idsubcuenta=this.iface.calculateField("idsubcuenta");
                        var idsubcuentaecgp=this.iface.calculateField("idsubcuentaecgp");
                        if (idsubcuenta) {
                            cursor.setValueBuffer("idsubcuenta",idsubcuenta);
                        }
                        if (idsubcuentaecgp) {
                            cursor.setValueBuffer("idsubcuentaecgp",idsubcuentaecgp);
                        }

                        break;
        }

}

function gestesoreria_verificarHabilitaciones(){

        if (this.child("tdbRecibos").cursor().size() > 0) {
                this.child("fdbCodCuenta").setDisabled(true);
                this.child("fdbCodDivisa").setDisabled(true);
                this.child("fdbFecha").setDisabled(true);
        } else {
                this.child("fdbCodCuenta").setDisabled(false);
                this.child("fdbCodDivisa").setDisabled(false);
                this.child("fdbFecha").setDisabled(false);
        }

}

function gestesoreria_refrescarRecibosProv(){

        var util:FLUtil = new FLUtil;
        var cursor:FLSqlCursor = this.cursor();
        var tdbRecibos:FLTableDB = this.child("tdbRecibos");

        var idRecibos=this.iface.idRecibosRemesa(cursor.valueBuffer("idremesa"));

        tdbRecibos.setReadOnly(true);
        tdbRecibos.cursor().setMainFilter("idrecibo IN ("+idRecibos+")");
        tdbRecibos.refresh();

}

/*con la idRemesa, devuelve los recibos que pertenecen a la remesa correspondiente según el idRemesa en reciboscli o en pagos y devoluciones*/
function gestesoreria_idRecibosRemesa(idRemesa:String):String{

        var curRM:FLSqlCursor = new FLSqlCursor("recibosprovremesa");
        curRM.select("idremesa = '"+idRemesa+"'");

        var idrecibos:String="-1";
        while (curRM.next()) {
            if (idrecibos) idrecibos+=",";
            idrecibos+= curRM.valueBuffer("idrecibo");
        }

        return idrecibos;
}

/*para remesas tipo 100 comprueba si hay devoluciones posteriores en pagosdevolcli de los recibos que pertenecen a la remesa para hacer no editable la remesa*/
function gestesoreria_directaEditable(idRemesa:String):Boolean
{
        var util:FLUtil = new FLUtil();
        var idRecibos:String = this.iface.idRecibosRemesa(idRemesa);
        var curRecibos:FLSqlCursor = new FLSqlCursor("recibosprov");
        curRecibos.select("idrecibo IN ("+idRecibos+")");
        if (curRecibos.size()<=0)
            return false;

        var n:Number=0;
        var sigue:Boolean=curRecibos.first()
        while (sigue){
            var tipo = util.sqlSelect("pagosdevolprov","tipo","idrecibo="+curRecibos.valueBuffer("idrecibo")+" ORDER BY idpagodevol DESC");
            if (tipo && tipo!="Pago"){
                var pago = util.sqlSelect("pagosdevolprov","idpagodevol","idremesa='"+idRemesa+"'");
                if (pago) n++;
            }
            sigue=curRecibos.next();
        }

        if (n>0) return false;
        if (n<=0) return true;
}

function gestesoreria_filtroRecibosProv():String
{
    var filtro:String = "estado IN ('Emitido', 'Devuelto') AND fecha <= '" + this.cursor().valueBuffer("fecha") + "'";
    return  filtro;

}

//// GESTESORERIA ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition tiposremprov */
/////////////////////////////////////////////////////////////////
//// TIPOSREMPROV //////////////////////////////////////////////
function tiposremprov_init()
{
    var cursor:FLSqlCursor = this.cursor();
    var util:FLUtil = new FLUtil;

    this.iface.cbxTipoRem = this.child("cbxTipoRem");
    this.iface.gbxProv = this.child("gbxProv");

    connect(this.iface.cbxTipoRem,"highlighted(int)",this,"iface.cambiarTipoRem");
    connect(this.iface.cbxTipoRem,"activated(int)",this,"iface.cambiarTipoRem");

    this.iface.__init();

    var tConfig:String = util.sqlSelect("factteso_general", "tipoconta34", "1=1");
    if (cursor.modeAccess() == cursor.Insert) {
        this.iface.tipoRem = "00";
        this.iface.cbxTipoRem.currentItem = 0;
        this.iface.tipoConta = tConfig;
    } else {
        var tipo = cursor.valueBuffer("tiporem");
        if (tipo == "00") {
            this.iface.cbxTipoRem.currentItem = 0;
        }
        if (tipo == "01") {
            this.iface.cbxTipoRem.currentItem = 1;
            this.iface.gbxProv.setDisabled(true);
        }
        if (tipo =="02") {
            this.iface.cbxTipoRem.currentItem = 2;
            if (this.iface.tipoConta == "202") {
                this.child("tbwRecibos").setTabEnabled("pagos", false);
            }
        }
        this.iface.tipoRem = tipo;
        this.iface.cbxTipoRem.setDisabled(true);
        this.iface.tipoConta = cursor.valueBuffer("tipoconta");
    }

    if (!this.iface.tipoRem || !this.iface.tipoConta){
        MessageBox.warning("Ha ocurrido un error de configuración\nSe cerrará el formulario",MessageBox.Ok,MessageBox.NoButton);
        this.close();
    }

    this.child("tdbPagares").setReadOnly(true);
    this.child("tdbAnticiposConf").setReadOnly(true);

    var tabPag:Boolean = false;
    var tabAnt:Boolean = false;

    if (cursor.modeAccess() == cursor.Edit && cursor.valueBuffer("cerrada") == true){
        if (this.iface.tipoRem == "01") {
            tabPag = true;
            this.child("tdbPagares").setEditOnly(true);
        }
        if (this.iface.tipoConta == "202") {
            tabAnt = true;
            this.child("tdbAnticiposConf").setReadOnly(false);
        }
    }

    if (cursor.valueBuffer("cerrada") == true) {
        this.child("fdbIdSubcuenta").setDisabled(true);
        this.child("fdbCodSubcuenta").setDisabled(true);
    }

    if(cursor.valueBuffer("tipoconta") == "202" && cursor.valueBuffer("estado") == "Pagada"){
        this.child("tdbAnticiposConf").setReadOnly(true);
    }

    this.child("tbwRecibos").setTabEnabled("pagares", tabPag);
    this.child("tbwRecibos").setTabEnabled("anticiposconf", tabAnt);
    this.iface.cambiarTipoRem();

    this.child("tdbPartidas").setReadOnly(true);

}

function tiposremprov_cambiarTipoRem()
{
    var item:Number = this.iface.cbxTipoRem.currentItem;
    var ocultar:Boolean = true;
    var util:FLUtil = new FLUtil;
    var tConfig:String = util.sqlSelect("factteso_general", "tipoconta34", "1=1");
    this.iface.tipoConta = tConfig;

    switch(item){
        /*Cheques nóminas y transferencias*/
        case 0:
            this.iface.tipoRem = "00";
            ocultar = true;
            if (tConfig == "200") {
                this.iface.tipoConta = "200";
            }
            break;

        /*Pagares*/
        case 1:
            this.iface.tipoRem = "01";
            ocultar = false;
            if (tConfig == "200") {
                this.iface.tipoConta = "201";
            }
            break;

        /*Confirming - Pago certificado*/
        case 2:
            this.iface.tipoRem = "02";
            ocultar = true;
            if (tConfig == "200") {
                this.iface.tipoConta = "202";
            }
            break;
    }

    this.cursor().setValueBuffer("tiporem",this.iface.tipoRem);
    this.cursor().setValueBuffer("tipoconta",this.iface.tipoConta);
    this.iface.gbxProv.setHidden(ocultar);

}

function tiposremprov_agregarRecibo():Boolean
{
    var cursor:FLSqlCursor = this.cursor();
    if (cursor.valueBuffer("tiporem") == "01" && (cursor.isNull("codproveedor") || cursor.valueBuffer("codproveedor") == "")) {
        MessageBox.warning(util.translate("scripts", "Debe indicar un proveedor para el tipo de remesa seleccionada"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
        return;
    }

    return this.iface.__agregarRecibo();
}

function tiposremprov_filtroRecibosProv():String
{
    var cursor:FLSqlCursor = this.cursor();
    var filtro:String = "estado IN ('Emitido', 'Devuelto') AND fecha <= '" + cursor.valueBuffer("fecha") + "' AND coddivisa='"+cursor.valueBuffer("coddivisa")+"'";

    var tipoRem = cursor.valueBuffer("tiporem");
    var whereTP:String;
    switch (tipoRem){
        case "00":
            whereTP = " IN('NOMINAS Y TRANSFERENCIAS','CHEQUES BANCARIOS')";
            break;

        case "01":
            whereTP = " = 'PAGARES'";
            filtro += " AND codproveedor ='"+cursor.valueBuffer("codproveedor")+"'";
            break;

         case "02":
            whereTP = " = 'PAGOS CERTIFICADOS'";
            break;
    }

    var qryTipos:FLSqlQuery = new FLSqlQuery()
    qryTipos.setTablesList("tipospago");
    qryTipos.setSelect("tipopago");
    qryTipos.setFrom("tipospago");
    qryTipos.setWhere("tipooperacion "+whereTP);
    if (!qryTipos.exec()){
        return "";
    }

    if (qryTipos.size()<=0){
        return filtro;
    }

    var inTipos:String="";
    while (qryTipos.next()){
        if(inTipos != "") inTipos += ",";
        inTipos += "'"+qryTipos.value("tipopago")+"'";
    }

    if (inTipos!=""){
        filtro += " AND tipopago IN("+inTipos+")";
    }

    return  filtro;

}

function tiposremprov_validateForm():Boolean
{

    if (!this.iface.__validateForm()){
        return false;
    }

    var util:FLUtil = new FLUtil;
    var cursor:FLSqlCursor = this.cursor();

    /** \C Si la remesa es de tipo "02" la divisa obligatoriamente ha de ser la de por defecto de la empresa: El confirming es solo para proveedores y acreedores nacionales
    \end */
    var codDivisa:String = flfactppal.iface.pub_valorDefectoEmpresa("coddivisa");
    if ((cursor.valueBuffer("tiporem")=="01" || cursor.valueBuffer("tiporem")=="02") && cursor.valueBuffer("coddivisa") != codDivisa) {
        MessageBox.warning(util.translate("scripts", "El tipo de remesa elegida solo está habilitada para proveedores y acreedores nacionales.\nEl código de la divisa debe ser el mismo que el de la empresa por defecto"), MessageBox.Ok, MessageBox.NoButton);
        return false;
    }

     if (this.iface.tipoConta == "202" && (!cursor.valueBuffer("codsubcuentaecgp") || cursor.valueBuffer("codsubcuentaecgp")=="" || !cursor.valueBuffer("idsubcuentaecgp") || cursor.valueBuffer("idsubcuentaecgp") =="")){
        MessageBox.warning("La cuenta bancaria seleccionada no tiene asociada una subcuenta de Efectos comerciales de gestión de pago o no existe la subcuenta para este ejercicio.\nDebe asignar esta subcuenta, o crearla para el ejercicio actual", MessageBox.Ok, MessageBox.NoButton);
        return false;
    }

    return true;
}

//// TIPOSREMPROV //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

