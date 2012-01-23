
/** @class_declaration megarOil */
//KLO///////////////////////////////////////////////////////////////
//// MEGAROIL /////////////////////////////////////////////////
class megarOil extends oficial {
	function megarOil( context ) { oficial ( context ); }

	function init() { this.ctx.megarOil_init(); }
	function bufferChanged(fN:String) { return this.ctx.megarOil_bufferChanged(fN); }
	function calculateField(fN:String):String { return this.ctx.megarOil_calculateField(fN); }
}
//// MEGAR /////////////////////////////////////////////////
//KLO///////////////////////////////////////////////////////////////

/** @class_declaration traducciones */
/////////////////////////////////////////////////////////////////
//// TRADUCCIONES ///////////////////////////////////////////////
class traducciones extends ivaIncluido {
    function traducciones( context ) { ivaIncluido ( context ); }
    function init() {
		return this.ctx.traducciones_init();
	}
	function traducirDescripcion() {
		return this.ctx.traducciones_traducirDescripcion();
	}
}
//// TRADUCCIONES ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition megarOil */
//KLO///////////////////////////////////////////////////////////////
//// MEGAROIL /////////////////////////////////////////////////
function megarOil_init()
{
	this.iface.__init();

	this.iface.calculateField("pvpconiva");
}

function megarOil_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();

	switch (fN) {
		case "pvp": {
			this.iface.calculateField("pvpconiva");
			break;
		}
		default: {
			this.iface.__bufferChanged(fN);
			break;
		}
	}
}

function megarOil_calculateField(nombreCampo:String):String
{
	this.iface.__calculateField(nombreCampo);

	var hoy:Date = new Date();
	if (nombreCampo == "pvpconiva") {
		var cursor:FLSqlCursor = this.cursor();
		var util:FLUtil = new FLUtil();
		var label:String = this.child("lblPvpConIva");
		//var iva:Number = flfacturac.iface.pub_campoImpuesto("iva", cursor.valueBuffer("codimpuesto"), util.dateAMDtoDMA(hoy));
		var iva:Number = parseFloat(util.sqlSelect("impuestos", "iva", "codimpuesto = '" + cursor.valueBuffer("codimpuesto") + "'"));
		var pvpConIva:Number = ((iva/100)*cursor.valueBuffer("pvp"))+parseFloat(cursor.valueBuffer("pvp"));
		pvpConIva = util.roundFieldValue(pvpConIva, "articulos", "pvp");
		label.setText(pvpConIva);
	}
}
//// MEGAROIL /////////////////////////////////////////////////
//KLO///////////////////////////////////////////////////////////////

/** @class_definition traducciones */
/////////////////////////////////////////////////////////////////
//// TRADUCCIONES //////////////////////////////////////////////
function traducciones_init()
{
	this.iface.__init();
	connect(this.child("pbnTradDescripcion"), "clicked()", this, "iface.traducirDescripcion");
}

function traducciones_traducirDescripcion()
{
	return flfactppal.iface.pub_traducir("articulos", "descripcion", this.cursor().valueBuffer("referencia"));
}

//// TRADUCCIONES //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

