
/** @class_declaration eFactura */
/////////////////////////////////////////////////////////////////
//// EFACTURA ///////////////////////////////////////////////////
class eFactura extends oficial /** %from: oficial */ {
    function eFactura( context ) { oficial ( context ); }
	function validateForm():Boolean {
		return this.ctx.eFactura_validateForm();
	}
}
//// EFACTURA ///////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition eFactura */
/////////////////////////////////////////////////////////////////
//// EFACTURA ///////////////////////////////////////////////////
function eFactura_validateForm():Boolean
{
	if (!this.iface.__validateForm())
		return false;

	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var codPago:String = cursor.valueBuffer("codpago");
	if (!codPago || codPago == "") {
		if (!cursor.valueBuffer("docelectronico")) {
			MessageBox.warning(util.translate("scripts", "Debe establecer la forma de pago"), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
	}
	return true;
}
//// EFACTURA ///////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

