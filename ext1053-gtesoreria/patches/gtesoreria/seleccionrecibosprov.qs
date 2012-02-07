
/** @class_declaration gtesoreria */
/////////////////////////////////////////////////////////////////
//// GTESORERIA /////////////////////////////////////////////////
class gtesoreria extends oficial {
	function gtesoreria( context ) { oficial ( context ); }
	function init() { this.ctx.gtesoreria_init(); }
	function seleccionar() {
		return this.ctx.gtesoreria_seleccionar();
	}
	function quitar() {
		return this.ctx.gtesoreria_quitar();
	}
	function calcularTotal() {
		return this.ctx.gtesoreria_calcularTotal();
	}
}
//// GTESORERIA /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition gtesoreria */
/////////////////////////////////////////////////////////////////
//// GTESORERIA /////////////////////////////////////////////////
function gtesoreria_init()
{
	this.iface.__init();
	this.iface.calcularTotal();
}

function gtesoreria_seleccionar()
{
	this.iface.__seleccionar();
	this.iface.calcularTotal();
}
function gtesoreria_quitar()
{
	this.iface.__quitar();
	this.iface.calcularTotal();
}

function gtesoreria_calcularTotal()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var datos:String = cursor.valueBuffer("datos");
	var total:Number = 0;
	if (datos || datos != "") {
		total = parseFloat(util.sqlSelect("recibosprov", "SUM(importe)", "idrecibo IN (" + datos + ")"));
		if (!total || isNaN(total))
			total = 0;
	}
	this.child("lblImporte").text = util.translate("scripts", "Total seleccionado: %1").arg(util.roundFieldValue(total, "recibosprov", "importe"));
}
//// GTESORERIA /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

