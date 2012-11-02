
/** @class_declaration prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN /////////////////////////////////////////////////
class prod extends articuloscomp {
    function prod( context ) { articuloscomp ( context ); }
	function dameDatosAgrupacionPedidos(curAgruparPedidos:FLSqlCursor):Array {
		return this.ctx.prod_dameDatosAgrupacionPedidos(curAgruparPedidos);
	}
}
//// PRODUCCIÓN /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN /////////////////////////////////////////////////
/** \D
Construye un array con los datos del albarán a generar especificados en el formulario de agrupación de pedidos
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

//// PRODUCCIÓN /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////

