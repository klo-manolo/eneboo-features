
/** @class_declaration prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCION /////////////////////////////////////////////////
class prod extends oficial {
	var curCostesTarea_:FLSqlCursor;
	function prod( context ) { oficial ( context ); }
	function copiarTiposTareaPro(idTipoProceso:String, nuevoTipoProceso:String):Boolean {
		return this.ctx.prod_copiarTiposTareaPro(idTipoProceso, nuevoTipoProceso);
	}
	function copiarCostesTarea(idTipoTarea:String,nuevoTipoTarea:String):Boolean {
		return this.ctx.prod_copiarCostesTarea(idTipoTarea,nuevoTipoTarea);
	}
	function copiarDatosCosteTarea(curCostesTarea:FLSqlCursor,campo:String):Boolean {
		return this.ctx.prod_copiarDatosCosteTarea(curCostesTarea,campo);
	}
}
//// PRODUCCION /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCION /////////////////////////////////////////////////
function prod_copiarTiposTareaPro(idTipoProceso:String, nuevoTipoProceso:String):Boolean
{
	var util:FLUtil;
	var curTiposTareaPro:FLSqlCursor = new FLSqlCursor("pr_tipostareapro");
	this.iface.curTipoTareaPro_ = new FLSqlCursor("pr_tipostareapro");

	curTiposTareaPro.select("idtipoproceso = '" + idTipoProceso + "'");
	var idTipoTareaOrigen:String;
	var idTipoTareaDestino:String;

	var campos:Array = util.nombreCampos("pr_tipostareapro");
	var totalCampos:Number = campos[0];

	while (curTiposTareaPro.next()) {
		idTipoTareaOrigen = curTiposTareaPro.valueBuffer("idtipotareapro");
		this.iface.curTipoTareaPro_.setModeAccess(this.iface.curTipoTareaPro_.Insert);
		this.iface.curTipoTareaPro_.refreshBuffer();
		this.iface.curTipoTareaPro_.setValueBuffer("idtipoproceso", nuevoTipoProceso);

		for (var i:Number = 1; i <= totalCampos; i++) {
			if (!this.iface.copiarDatosTipoTareaPro(curTiposTareaPro,campos[i]))
				return false;
		}

		if (!this.iface.curTipoTareaPro_.commitBuffer())
			return false;

		idTipoTareaDestino = this.iface.curTipoTareaPro_.valueBuffer("idtipotareapro");

		if(!this.iface.copiarCostesTarea(idTipoTareaOrigen,idTipoTareaDestino))
			return false;
	}
	return true;
}

function prod_copiarCostesTarea(idTipoTarea:String,nuevoTipoTarea:String):Boolean
{
	var util:FLUtil;
	var curCostesTarea:FLSqlCursor = new FLSqlCursor("pr_costestarea");
	this.iface.curCostesTarea_ = new FLSqlCursor("pr_costestarea");

	curCostesTarea.select("idtipotareapro = '" + idTipoTarea + "'");

	var campos:Array = util.nombreCampos("pr_costestarea");
	var totalCampos:Number = campos[0];

	while (curCostesTarea.next()) {
		this.iface.curCostesTarea_.setModeAccess(this.iface.curCostesTarea_.Insert);
		this.iface.curCostesTarea_.refreshBuffer();
		this.iface.curCostesTarea_.setValueBuffer("idtipotareapro", nuevoTipoTarea);

		for (var i:Number = 1; i <= totalCampos; i++) {
			if (!this.iface.copiarDatosCosteTarea(curCostesTarea,campos[i]))
				return false;
		}

		if (!this.iface.curCostesTarea_.commitBuffer())
			return false;
	}
	return true;
}

function prod_copiarDatosCosteTarea(curCostesTarea:FLSqlCursor,campo:String):Boolean
{
	if(!campo || campo == "")
		return false;

	switch (campo) {
		case "idcoste":
		case "idtipotareapro": {
			return true;
			break;
		}
		default: {
			if (curCostesTarea.isNull(campo)) {
				this.iface.curCostesTarea_.setNull(campo);
			} else {
				this.iface.curCostesTarea_.setValueBuffer(campo, curCostesTarea.valueBuffer(campo));
			}
		}
	}
	return true;
}
//// PRODUCCION /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

