
/** @class_declaration megarOil */
//////////////////////////////////////////////////////////////////
//// MEGAR-OIL /////////////////////////////////////////////////////
class megarOil extends oficial {

	function megarOil( context ) { oficial( context ); }

	function datosLineaPedido(curLineaPresupuesto:FLSqlCursor):Boolean {
		return this.ctx.megarOil_datosLineaPedido(curLineaPresupuesto);
	}
}
//// MEGAR-OIL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition megarOil */
/////////////////////////////////////////////////////////////////
//// MEGAR-OIL //////////////////////////////////////////////
/** \D Copia los datos de una linea de Presupuesto en una linea de Pedido
@param	curLineaPresupuesto: Cursor que contiene los datos a incluir en la linea de Pedido
@return	True si la copia se realiza correctamente, false en caso contrario
\end */
function megarOil_datosLineaPedido(curLineaPresupuesto:FLSqlCursor):Boolean
{
	this.iface.__datosLineaPedido(curLineaPresupuesto);
	with (this.iface.curLineaPedido) {
		setValueBuffer("numlinea", curLineaPresupuesto.valueBuffer("numlinea"));
	}
	return true;
}
//// MEGAR-OIL //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

