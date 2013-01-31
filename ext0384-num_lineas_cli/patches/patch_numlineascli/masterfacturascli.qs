
/** @class_declaration numLinea */
/////////////////////////////////////////////////////////////////
//// NUMEROS LINEA /////////////////////////////////////////////
class numLinea extends oficial {
    function numLinea( context ) { oficial ( context ); }
	function copiadatosLineaFactura(curLineaFactura:FLSqlCursor):Boolean {
		return this.ctx.numLinea_copiadatosLineaFactura(curLineaFactura);
	}
}
//// NUMEROS LINEA /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition numLinea */
/////////////////////////////////////////////////////////////////
//// NUMEROS LINEA /////////////////////////////////////////////
function numLinea_copiadatosLineaFactura(curLineaFactura:FLSqlCursor):Boolean
{
	if (!this.iface.__copiadatosLineaFactura(curLineaFactura)) {
		return false;
	}
	
	with (this.iface.curLineaFactura) {
		setValueBuffer("numlinea", curLineaFactura.valueBuffer("numlinea"));
	}
	return true;
}
//// NUMEROS LINEA /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
