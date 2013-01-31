
/** @class_declaration numLinea */
/////////////////////////////////////////////////////////////////
//// NUMEROS DE LÍNEA ///////////////////////////////////////////
class numLinea extends oficial {
	var numLinea_:Number;
    function numLinea( context ) { oficial ( context ); }
	function generarPedido(curPresupuesto:FLSqlCursor):Number {
		return this.ctx.numLinea_generarPedido(curPresupuesto);
	}
	function copiaLineas(idPresupuesto:Number, idPedido:Number):Boolean {
		return this.ctx.numLinea_copiaLineas(idPresupuesto, idPedido);
	}
	function datosLineaPedido(curLineaPresupuesto:FLSqlCursor):Boolean {
		return this.ctx.numLinea_datosLineaPedido(curLineaPresupuesto);
	}
}
//// NUMEROS DE LÍNEA ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition numLinea */
/////////////////////////////////////////////////////////////////
//// NÚMEROS DE LÍNEA ///////////////////////////////////////////
function numLinea_generarPedido(curPresupuesto:FLSqlCursor):Number
{
	this.iface.numLinea_ = 0;

	var idPedido:String = this.iface.__generarPedido(curPresupuesto);
	if (!idPedido) {
		return false;
	}
	
	return idPedido;
}

function numLinea_datosLineaPedido(curLineaPresupuesto:FLSqlCursor):Boolean
{
	if (!this.iface.__datosLineaPedido(curLineaPresupuesto)) {
		return false;
	}

	this.iface.numLinea_++;
	this.iface.curLineaPedido.setValueBuffer("numlinea", this.iface.numLinea_);

	return true;
}

function numLinea_copiaLineas(idPresupuesto:Number, idPedido:Number):Boolean
{
	var curLineaPresupuesto:FLSqlCursor = new FLSqlCursor("lineaspresupuestoscli");
	curLineaPresupuesto.select("idpresupuesto = " + idPresupuesto + " ORDER BY numlinea");
	while (curLineaPresupuesto.next()) {
		curLineaPresupuesto.setModeAccess(curLineaPresupuesto.Browse);
		curLineaPresupuesto.refreshBuffer();
		if (!this.iface.copiaLineaPresupuesto(curLineaPresupuesto, idPedido)) {
			return false;
		}
	}
	return true;
}


//// NÚMEROS DE LÍNEA ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////
