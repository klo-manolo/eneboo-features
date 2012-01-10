
/** @class_declaration megarOil */
//////////////////////////////////////////////////////////////////
//// MEGAROIL ////////////////////////////////////////////////////////////////
class megarOil extends oficial {

	var toolButtonPreciosArt:Object;

	function megarOil( context ) { oficial( context ); }
	function init() { this.ctx.megarOil_init(); }
	function abrirListaPrecios():String {
		return this.ctx.megarOil_abrirListaPrecios();
	}
}
//// MEGAROIL ////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition megarOil */
/////////////////////////////////////////////////////////////////
//// MEGAROIL ////////////////////////////////////////////////////////////////
function megarOil_init()
{
	this.iface.__init();

	this.iface.toolButtonPreciosArt = this.child("toolButtonPreciosArt");
	connect(this.iface.toolButtonPreciosArt, "clicked()", this, "iface.abrirListaPrecios()");
}

function megarOil_abrirListaPrecios()
{
	var referencia:String = this.cursor().valueBuffer("referencia");
	var curArticuloLP = new FLSqlCursor("articulos");

	curArticuloLP.setAction("articuloslp");
	curArticuloLP.select("referencia = '" + referencia + "'");

	//MessageBox.information(curArticuloLP.valueBuffer("referencia"), MessageBox.Ok, MessageBox.NoButton);

	if (curArticuloLP.first())
		curArticuloLP.editRecord();
}
//// MEGAROIL ////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

