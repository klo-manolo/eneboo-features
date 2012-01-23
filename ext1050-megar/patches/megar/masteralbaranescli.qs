
/** @class_declaration megarOil */
//////////////////////////////////////////////////////////////////
//// MEGAR-OIL /////////////////////////////////////////////////////
class megarOil extends oficial {

	function megarOil( context ) { oficial( context ); }

	function datosLineaFactura(curLineaAlbaran:FLSqlCursor):Boolean {
		return this.ctx.megarOil_datosLineaFactura(curLineaAlbaran);
	}
}
//// MEGAR-OIL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration modelo347 */
/////////////////////////////////////////////////////////////////
//// MODELO347 //////////////////////////////////////////////////
class modelo347 extends fluxEcommerce {
    function modelo347( context ) { fluxEcommerce ( context ); }
    function totalesFactura():Boolean {
		return this.ctx.modelo347_totalesFactura();
	}
}
//// MODELO347 //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition megarOil */
/////////////////////////////////////////////////////////////////
//// MEGAR-OIL //////////////////////////////////////////////
/** \D Copia los datos de una linea de albaran en una linea de factura
@param	curLineaAlbaran: Cursor que contiene los datos a incluir en la linea de factura
@return	True si la copia se realiza correctamente, false en caso contrario
\end */
function megarOil_datosLineaFactura(curLineaAlbaran:FLSqlCursor):Boolean
{
	this.iface.__datosLineaFactura(curLineaAlbaran);
	with (this.iface.curLineaFactura) {
		setValueBuffer("numlinea", curLineaAlbaran.valueBuffer("numlinea"));
	}
	return true;
}
//// MEGAR-OIL //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition modelo347 */
/////////////////////////////////////////////////////////////////
//// MODELO 347 /////////////////////////////////////////////////
function modelo347_totalesFactura():Boolean
{
	if (!this.iface.__totalesFactura()) {
		return false;
	}
	with (this.iface.curFactura) {
		setValueBuffer("nomodelo347", formfacturascli.iface.pub_commonCalculateField("nomodelo347", this));
	}
	return true;
}
//// MODELO 347 /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

