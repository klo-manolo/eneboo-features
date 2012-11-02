
/** @class_declaration prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCI�N /////////////////////////////////////////////////
class prod extends articuloscomp {
    function prod( context ) { articuloscomp ( context ); }
	function dameDatosAgrupacionPedidos(curAgruparPedidos:FLSqlCursor):Array {
		return this.ctx.prod_dameDatosAgrupacionPedidos(curAgruparPedidos);
	}
}
//// PRODUCCI�N /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCI�N /////////////////////////////////////////////////
/** \D
Construye un array con los datos del albar�n a generar especificados en el formulario de agrupaci�n de pedidos
@param curAgruparPedidos: Cursor de la tabla agruparpedidoscli que contiene los valores
@return Array
\end */
function prod_dameDatosAgrupacionPedidos(curAgruparPedidos:FLSqlCursor):Array
{
	var res:Array = this.iface.__dameDatosAgrupacionPedidos(curAgruparPedidos);
	if (!res) {
		return false;
	}
	res["hora"] = curAgruparPedidos.valueBuffer("hora");
	return res;
}

//// PRODUCCI�N /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////

