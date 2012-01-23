
/** @class_declaration megarOil */
//////////////////////////////////////////////////////////////////
//// MEGAROIL ////////////////////////////////////////////////////////////////
class megarOil extends oficial {
	function megarOil( context ) { oficial( context ); }
	function init() { this.ctx.megarOil_init(); }
}
//// MEGAROIL ////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition megarOil */
/////////////////////////////////////////////////////////////////
//// MEGAROIL ////////////////////////////////////////////////////////////////

function megarOil_init()
{
	this.iface.__init();

	var cursor:FLSqlCursor = this.cursor();

	if (cursor.modeAccess() == cursor.Insert) {
		// KLO. Añadido para dto lineal.
		this.child("fdbDtoLineal").setValue(this.iface.calculateField("dtolineal"));
		// KLO. Para el nº de líneas.
		var util:FLUtil = new FLUtil();
		var sigNum:Number = util.sqlSelect("lineasalbaranescli", "max(numlinea)", "idalbaran = "  + cursor.valueBuffer("idalbaran"));
		if (!sigNum) sigNum = 0;
		sigNum = parseInt(sigNum);
		sigNum += 1;
		cursor.setValueBuffer("numlinea", sigNum);
	}

	if (cursor.modeAccess() == cursor.Edit) {
		var label:String = this.child("lblPvpConIva");
		label.setText(formRecordlineaspedidoscli.iface.pub_commonCalculateField("pvpconiva", cursor));
	}
}
//// MEGAROIL ////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

