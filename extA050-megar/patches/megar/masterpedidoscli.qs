
/** @class_declaration megarOil */
//////////////////////////////////////////////////////////////////
//// MEGAR-OIL /////////////////////////////////////////////////////
class megarOil extends oficial {

	function megarOil( context ) { oficial( context ); }

	function datosLineaAlbaran(curLineaPedido:FLSqlCursor):Boolean {
		return this.ctx.megarOil_datosLineaAlbaran(curLineaPedido);
	}
}
//// MEGAR-OIL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition megarOil */
/////////////////////////////////////////////////////////////////
//// MEGAR-OIL //////////////////////////////////////////////
/** \D Copia los datos de una linea de Pedido en una linea de Albaran
@param	curLineaPedido: Cursor que contiene los datos a incluir en la linea de Albaran
@return	True si la copia se realiza correctamente, false en caso contrario
\end */
function megarOil_datosLineaAlbaran(curLineaPedido:FLSqlCursor):Boolean
{
	this.iface.__datosLineaAlbaran(curLineaPedido);
	with (this.iface.curLineaAlbaran) {
		setValueBuffer("numlinea", curLineaPedido.valueBuffer("numlinea"));
	}
	return true;
}
//// MEGAR-OIL //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

