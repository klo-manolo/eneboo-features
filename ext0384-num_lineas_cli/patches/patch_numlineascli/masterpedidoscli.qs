
/** @class_declaration numLinea */
/////////////////////////////////////////////////////////////////
//// NUMEROS DE LÍNEA ///////////////////////////////////////////
class numLinea extends oficial {
	var numLinea_:Number;
    function numLinea( context ) { oficial ( context ); }
	function generarAlbaran(where:String, cursor:FLSqlCursor, datosAgrupacion:Array):Number {
		return this.ctx.numLinea_generarAlbaran(where, cursor, datosAgrupacion);
	}
	function copiaLineas(idPedido:Number, idAlbaran:Number):Boolean {
		return this.ctx.numLinea_copiaLineas(idPedido, idAlbaran);
	}
	function datosLineaAlbaran(curLineaPedido:FLSqlCursor):Boolean {
		return this.ctx.numLinea_datosLineaAlbaran(curLineaPedido);
	}
}
//// NUMEROS DE LÍNEA ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition numLinea */
/////////////////////////////////////////////////////////////////
//// NÚMEROS DE LÍNEA ///////////////////////////////////////////
function numLinea_generarAlbaran(where:String, cursor:FLSqlCursor, datosAgrupacion:Array):Number
{
	this.iface.numLinea_ = 0;

	var idAlbaran:String = this.iface.__generarAlbaran(where, cursor, datosAgrupacion);
	if (!idAlbaran) {
		return false;
	}

	return idAlbaran;
}

function numLinea_copiaLineas(idPedido:Number, idAlbaran:Number):Boolean
{
	var util:FLUtil = new FLUtil;
	var cantidad:Number;
	var totalEnAlbaran:Number;
	var curLineaPedido:FLSqlCursor = new FLSqlCursor("lineaspedidoscli");
	curLineaPedido.select("idpedido = " + idPedido + " AND (cerrada = false or cerrada IS NULL) ORDER BY numlinea");
	while (curLineaPedido.next()) {
		curLineaPedido.setModeAccess(curLineaPedido.Browse);
		curLineaPedido.refreshBuffer();
		cantidad = parseFloat(curLineaPedido.valueBuffer("cantidad"));
		totalEnAlbaran = parseFloat(curLineaPedido.valueBuffer("totalenalbaran"));
		if (cantidad > totalEnAlbaran) {
			if (!this.iface.copiaLineaPedido(curLineaPedido, idAlbaran)) {
				return false;
			}
		}
	}
	return true;
}

/** \D Copia los datos de una línea de pedido en una línea de albarán
@param	curLineaPedido: Cursor que contiene los datos a incluir en la línea de albarán
@return	True si la copia se realiza correctamente, false en caso contrario
\end */
function numLinea_datosLineaAlbaran(curLineaPedido:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	if (!this.iface.__datosLineaAlbaran(curLineaPedido)) {
		return false;
	}

	this.iface.numLinea_++;
	this.iface.curLineaAlbaran.setValueBuffer("numlinea", this.iface.numLinea_);

	return true;
}
//// NÚMEROS DE LÍNEA ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////
