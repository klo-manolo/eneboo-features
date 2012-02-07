
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
        function refrescarRecibosCli(){
                return this.ctx.gestesoreria_refrescarRecibosCli();
        }
        function idRecibosRemesa(idRemesa:String):String{
                return this.ctx.gestesoreria_idRecibosRemesa(idRemesa)
        }
        function directaEditable(idRemesa:String){
                return this.ctx.gestesoreria_directaEditable(idRemesa)
        }
}
//// GESTESORERIA/////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubGesTesoreria */
/////////////////////////////////////////////////////////////////
//// PUB GESTESORERIA /////////////////////////////////////////////////
class pubGesTesoreria extends ifaceCtx {
	function pubGesTesoreria( context ) { ifaceCtx( context ); }
	function pub_excluirReciboRemesa(idRecibo:String, idRemesa:String, dryRun:Boolean):Boolean {
		return this.excluirReciboRemesa(idRecibo, idRemesa, dryRun);
	}
	function pub_idRecibosRemesa(idRemesa:String):String {
		return this.idRecibosRemesa(idRemesa);
	}
	function pub_directaEditable(idRemesa:String){
		return this.directaEditable(idRemesa)
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

        var tConfig:Array = flfactppal.iface.pub_ejecutarQry("factteso_general", "tipoconta19,codctagescobro,codctaimp19,tipoconta58,codctacartera,codctadescontados,codctaimp58", "1=1");
        if (tConfig.result != 1){
                Messagebox.warning("No se ha encontrado la configuración por defecto",MessageBox.Ok,MessageBox.NoButton);
                return false;
        }

        var mA = cursor.modeAccess();
        var tipoRemesa:String="";

        if (mA == cursor.Insert) {
                tipoRemesa = formremesas.iface.tipoRemesa;
        } else {
                tipoRemesa = cursor.valueBuffer("tiporem");
                this.iface.tipoConta = cursor.valueBuffer("tipoconta");
        }

        if (!tipoRemesa || tipoRemesa==""){
                MessageBox.warning("Ha ocurrido un error de configuración\nSe cerrará el formulario",MessageBox.Ok,MessageBox.NoButton);
                this.close();
        }

        connect(this.child("tbInsert"), "clicked()", this, "iface.agregarRecibo");
	connect(this.child("tbDelete"), "clicked()", this, "iface.eliminarRecibo");
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.child("tdbPagosDevolRem").cursor(), "bufferCommited()", this, "iface.cambiarEstado");
	this.child("tdbPartidas").setReadOnly(true);

        this.iface.bufferChanged("estado");

        var tabPagos:Boolean = true;
        switch(mA){
                case cursor.Insert:
                        tabPagos = false;
                        var ctaImpagados:String="";
                        if (tipoRemesa=="19") {
                                this.iface.tipoConta = tConfig["tipoconta19"];
                                ctaImpagados = tConfig["codctaimp19"];
                        }else if (tipoRemesa=="58") {
                                this.iface.tipoConta = tConfig["tipoconta58"];
                                ctaImpagados = tConfig["codctaimp58"];
                        }
                        cursor.setValueBuffer("coddivisa", flfactppal.iface.pub_valorDefectoEmpresa("coddivisa"));
                        cursor.setValueBuffer("nogenerarasiento",this.iface.calculateField("nogenerarasiento"));
                        cursor.setValueBuffer("tipoconta", this.iface.tipoConta);
                        cursor.setValueBuffer("tiporem", tipoRemesa);
                        cursor.setValueBuffer("codctagescobro", tConfig["codctagescobro"]);
                        cursor.setValueBuffer("codctacartera", tConfig["codctacartera"]);
                        cursor.setValueBuffer("codctadescontados", tConfig["codctadescontados"]);
                        cursor.setValueBuffer("codctaimpagados", ctaImpagados);
                        break;

                case cursor.Edit:
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

        if (this.iface.tipoConta == "100" || this.iface.tipoConta == "200"){
                tabConta = false;
        }

        if (this.iface.tipoConta == "110" || this.iface.tipoConta == "300"){
                tabConta = true;
        }

        this.child("tbwRemesa").setTabEnabled("contabilidad", tabConta);
        this.child("tbwRecibos").setTabEnabled("pagos", tabPagos);

        this.iface.refrescarRecibosCli();
        this.child("tdbPartidas").refresh();
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

        if (!cursor.valueBuffer("codsubcuenta") || cursor.valueBuffer("codsubcuenta")==""){
                MessageBox.warning("La cuenta bancaria seleccionada no tiene asociada una subcuenta de contabilidad o no existe la subcuenta para este ejercicio.\nDebe asignar esta subcuenta, o crearla para el ejercicio actual", MessageBox.Ok, MessageBox.NoButton);
                return false;
        }

        if (cursor.valueBuffer("tipoconta") == "200" || cursor.valueBuffer("tipoconta") =="300"){
                if (!cursor.valueBuffer("codsubcuentaecgc") || cursor.valueBuffer("codsubcuentaecgc")==""){
                        MessageBox.warning("La cuenta bancaria seleccionada no tiene asociada una subcuenta de Efectos comerciales de gestión de cobro o no existe la subcuenta para este ejercicio.\nDebe asignar esta subcuenta, o crearla para el ejercicio actual", MessageBox.Ok, MessageBox.NoButton);
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

		case "codsubcuentaecgc":{
			res = util.sqlSelect("cuentasbanco", "codsubcuentaecgc", "codcuenta ='"+cursor.valueBuffer("codcuenta")+"'");
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

                case "idsubcuentaecgc":
                                var codSubcuentaecgc:String = cursor.valueBuffer("codsubcuentaecgc").toString();
                                if (codSubcuentaecgc.length == this.iface.longSubcuenta){
                                res = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta ='" + codSubcuentaecgc + "' AND codejercicio ='" + this.iface.ejercicioActual + "'");
                                if (!res) res="";
                                }
                                break;

                case "total":
                        var idRecibos = this.iface.idRecibosRemesa(cursor.valueBuffer("idremesa"));
                        res = util.sqlSelect("reciboscli", "SUM(importe)", "idrecibo IN ("+idRecibos+")");
                        break;

		case "estado":
                        //Normalmente se calcula en el beforecommit de la remesa//
                        //res = this.iface.calcularEstadoRemesa(cursor.valueBuffer("idremesa"));
			break;

                case "nogenerarasiento":
                    var tipo = cursor.valueBuffer("tipoconta");
                    if (tipo == "100" || tipo == "200"){
                            res=true;
                    }else{
                            res=false;
                    }
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

        if (!cursor.valueBuffer("codsubcuenta") || cursor.valueBuffer("codsubcuenta")=="" || !cursor.valueBuffer("idsubcuenta") || cursor.valueBuffer("idsubcuenta") == ""){
                MessageBox.warning("La cuenta bancaria seleccionada no tiene asociada una subcuenta de contabilidad o no existe la subcuenta para este ejercicio.\nDebe asignar esta subcuenta, o crearla para el ejercicio actual", MessageBox.Ok, MessageBox.NoButton);
                return false;
        }

        if (cursor.valueBuffer("tiporem")=="58"){
            if (!cursor.valueBuffer("codsubcuentaecgc") || cursor.valueBuffer("codsubcuentaecgc")==""){
                MessageBox.warning("La cuenta bancaria seleccionada no tiene asociada una subcuenta de Efectos comerciales de gestión de cobro o no existe la subcuenta para este ejercicio.\nDebe asignar esta subcuenta, o crearla para el ejercicio actual", MessageBox.Ok, MessageBox.NoButton);
                return false;
            }
        }

	var f:Object = new FLFormSearchDB("seleccionreciboscli");
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
	curRecibos.setValueBuffer("filtro", "estado IN ('Emitido', 'Devuelto') AND fecha <= '" + fecha + "'");

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

        this.iface.refrescarRecibosCli();
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

	this.iface.refrescarRecibosCli();
	this.iface.actualizarTotal();
}

function gestesoreria_excluirReciboRemesa(idRecibo:String, idRemesa:String, dryRun:Boolean):Boolean
{
        var util:FLUtil = new FLUtil;

	var curPagosDev:FLSqlCursor = new FLSqlCursor("pagosdevolcli");
	curPagosDev.select("idrecibo = " + idRecibo + " AND idremesa ="+idRemesa +" ORDER BY idpagodevol");
        if (curPagosDev.first()){
                var idpagodevol = curPagosDev.valueBuffer("idpagodevol");
	 	curPagosDev.select("idrecibo = " + idRecibo + " AND idpagodevol>"+idpagodevol);
	        if (curPagosDev.first()){
                        var codigo = util.sqlSelect("reciboscli","codigo","idrecibo='"+idRecibo+"'");
                        MessageBox.warning(util.translate("scripts", "Para excluir el recibo %1 de la remesa debe eliminar antes los pagos o devoluciones").arg(codigo), MessageBox.Ok, MessageBox.NoButton);
                        return false;
		}else{
                        if (dryRun) return true;
                        if(!util.sqlDelete("pagosdevolcli","idpagodevol="+idpagodevol)){
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
        var curPagosDev:FLSqlCursor = new FLSqlCursor("pagosdevolcli");
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

        var curRecibos:FLSqlCursor = new FLSqlCursor("reciboscli");
        curRecibos.select("idrecibo = " + idRecibo);

        if (!curRecibos.first())
                return false;

        curRecibos.setModeAccess(curRecibos.Edit);
        curRecibos.refreshBuffer();
        curRecibos.setValueBuffer("estado",estado);
        curRecibos.setNull("idremesa");
        curRecibos.setValueBuffer("fechamate",curRecibos.valueBuffer("fechav"));

        if (!curRecibos.commitBuffer())
                return false;

        var curRM:FLSqlCursor = new FLSqlCursor("reciboscliremesa");
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
@param	idRecibo: Identificador del recibo
@param	curRemesa: Cursor posicionado en la remesa
@return	true si la asociación se realiza de forma correcta, false en caso contrario
\end */
function gestesoreria_asociarReciboRemesa(idRecibo:String, curRemesa:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	var idRemesa:String = curRemesa.valueBuffer("idremesa");

	if (util.sqlSelect("reciboscli", "coddivisa", "idrecibo = " + idRecibo) != curRemesa.valueBuffer("coddivisa")) {
		MessageBox.warning(util.translate("scripts", "No es posible incluir el recibo.\nLa divisa del recibo y de la remesa deben ser la misma."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return;
	}

        var curRecibos:FLSqlCursor = new FLSqlCursor("reciboscli");
        curRecibos.select("idrecibo = " + idRecibo);
        if (!curRecibos.first()) return false;

        if (!curRecibos.valueBuffer("codcuenta") || curRecibos.valueBuffer("codcuenta") ==""){
                var continuar = MessageBox.warning("Precaución: El recibo "+curRecibos.valueBuffer("codigo")+" no tiene asignada\nuna cuenta de domiciliación válida.\n¿Desea continuar de todas formas?",MessageBox.Ok, MessageBox.Cancel);
                if (continuar != MessageBox.Ok){
                        return true;
                }
        }

        var curRecibosRem:FLSqlCursor = new FLSqlCursor("reciboscliremesa");
        curRecibosRem.setModeAccess(curRecibosRem.Insert);
        curRecibosRem.refreshBuffer();
        curRecibosRem.setValueBuffer("idremesa", idRemesa);
        curRecibosRem.setValueBuffer("idrecibo", idRecibo);
        if (!curRecibosRem.commitBuffer()){
                return false;
        }

         var dias:Number;
         if (curRemesa.valueBuffer("tiporem")=="19")
                dias= util.sqlSelect("cuentasbanco","matecobro","codcuenta='"+curRemesa.valueBuffer("codcuenta")+"'");
        if (curRemesa.valueBuffer("tiporem")=="58")
                dias= util.sqlSelect("cuentasbanco","matedescuento","codcuenta='"+curRemesa.valueBuffer("codcuenta")+"'");


        var fechamate = util.addDays(curRecibos.valueBuffer("fechav"),dias);
        curRecibos.setActivatedCheckIntegrity(false);
        curRecibos.setModeAccess(curRecibos.Edit);
        curRecibos.refreshBuffer();
        curRecibos.setValueBuffer("idremesa", idRemesa);
        curRecibos.setValueBuffer("estado","Remesado");
        curRecibos.setValueBuffer("fechamate",fechamate);
        if (!curRecibos.commitBuffer()){
                return false;
        }

	return true;
}

function gestesoreria_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();
	switch (fN) {
		case "estado":
			/*if (cursor.valueBuffer("estado") == "Pagada") {
				this.child("tbInsert").setDisabled(true);
				this.child("tbDelete").setDisabled(true);
			} else {
				this.child("tbInsert").setDisabled(false);
				this.child("tbDelete").setDisabled(false);
			}*/
			break;

		case "codcuenta":
			var codsubcuenta=this.iface.calculateField("codsubcuenta");
                        var codsubcuentaecgc=this.iface.calculateField("codsubcuentaecgc");
                        if (codsubcuenta && codsubcuenta !="") {
                            cursor.setValueBuffer("codsubcuenta",codsubcuenta);
                        }
                        if (codsubcuentaecgc && codsubcuentaecgc !="") {
                            cursor.setValueBuffer("codsubcuentaecgc",codsubcuentaecgc);
                        }

                        var idsubcuenta=this.iface.calculateField("idsubcuenta");
                        var idsubcuentaecgc=this.iface.calculateField("idsubcuentaecgc");
                        if (idsubcuenta) {
                            cursor.setValueBuffer("idsubcuenta",idsubcuenta);
                        }
                        if (idsubcuentaecgc) {
                            cursor.setValueBuffer("idsubcuentaecgc",idsubcuentaecgc);
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

function gestesoreria_refrescarRecibosCli(){

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

        var curRM:FLSqlCursor = new FLSqlCursor("reciboscliremesa");
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
        var curRecibos:FLSqlCursor = new FLSqlCursor("reciboscli");
        curRecibos.select("idrecibo IN ("+idRecibos+")");
        if (curRecibos.size()<=0)
            return false;

        var n:Number=0;
        var sigue:Boolean=curRecibos.first()
        while (sigue){
            var tipo = util.sqlSelect("pagosdevolcli","tipo","idrecibo="+curRecibos.valueBuffer("idrecibo")+" ORDER BY idpagodevol DESC");
            if (tipo && tipo!="Pago"){
                var pago = util.sqlSelect("pagosdevolcli","idpagodevol","idremesa='"+idRemesa+"'");
                if (pago) n++;
            }
            sigue=curRecibos.next();
        }

        if (n>0) return false;
        if (n<=0) return true;
}

//// GESTESORERIA ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

