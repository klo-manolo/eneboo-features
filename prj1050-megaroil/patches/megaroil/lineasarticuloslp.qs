
/** @class_declaration megar */
//////////////////////////////////////////////////////////////////
//// MEGAR /////////////////////////////////////////////////////
class megar extends oficial {
	function megar( context ) { oficial( context ); }
	function init() { this.ctx.megar_init(); }
	function bufferChanged(fN:String) { return this.ctx.megar_bufferChanged(fN); }
	function calculateField(fN:String):String { return this.ctx.megar_calculateField(fN); }
}
//// MEGAR /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition megar */
//////////////////////////////////////////////////////////////////
//// MEGAR ///////////////////////////////////////////////////
function megar_init()
{
	this.iface.__init();
	this.iface.calculateField("diferenciaud");
}

function megar_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();

	switch (fN) {
		case "totaludvendidas": {
			this.iface.calculateField("diferenciaud");
			break;
		}
		default:{
			this.iface.__bufferChanged(fN);
		}
	}
}

function megar_calculateField(fN:String):String
{
	var hoy:Date = new Date();
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();

	switch (fN) {
		case "diferenciaud": {
			var labelDif:String = this.child("lblDiferenciaUd");
			var diferenciaUd:Number = parseFloat(cursor.valueBuffer("totaludvendidas"))-parseFloat(cursor.valueBuffer("totalunidades"));
			diferenciaUd = util.roundFieldValue(diferenciaUd, "lineasarticuloslp", "totaludvendidas");
			labelDif.setText(diferenciaUd);
			break;
		}
		default: {
			this.iface.__calculateField(fN);
		}
	}
}
//// MEGAR /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

