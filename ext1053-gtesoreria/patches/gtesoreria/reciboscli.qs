
/** @class_declaration gtesoreria */
/////////////////////////////////////////////////////////////////
//// GTESORERIA ////////////////////////////////////
class gtesoreria extends oficial {
	var gbxPagDev:Object;
	function gtesoreria( context ) { oficial ( context ); }
	function init() { this.ctx.gtesoreria_init(); }
	function bufferChanged(fN:String) {
		return this.ctx.gtesoreria_bufferChanged(fN);
	}
	function copiarCampoReciboDiv(nombreCampo:String, cursor:FLSqlCursor, campoInformado:Array):Boolean {
		return this.ctx.gtesoreria_copiarCampoReciboDiv(nombreCampo, cursor, campoInformado);
	}
}
//// GTESORERIA ////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition gtesoreria */
/////////////////////////////////////////////////////////////////
//// GTESORERIA /////////////////////////////////////////////////
function gtesoreria_init()
{
	var cursor:FLSqlCursor = this.cursor();
	this.iface.gbxPagDev = this.child("groupBoxPD");

	if (cursor.modeAccess() == cursor.Edit)
		this.iface.importeInicial = parseFloat(cursor.valueBuffer("importe"));
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.child("tdbPagosDevolCli").cursor(), "cursorUpdated()", this, "iface.cambiarEstado");
	connect(this.child("tdbPagosDevolCli").cursor(), "bufferCommited()", this, "iface.cambiarEstado");
	if (cursor.modeAccess() == cursor.Edit)
		this.child("pushButtonAcceptContinue").close();
	this.child("fdbTexto").setValue(this.iface.calculateField("texto"));

	this.iface.bufferChanged("codcuenta");
	this.iface.cambiarEstado();
	return true;
}

function gtesoreria_bufferChanged(fN:String)
{
	if (fN == "importe") {
		this.iface.gbxPagDev.setDisabled(true);
	}

	this.iface.__bufferChanged(fN);
}

function gtesoreria_copiarCampoReciboDiv(nombreCampo:String, cursor:FLSqlCursor, campoInformado:Array):Boolean
{
	if (!cursor) {
		cursor = this.cursor();
	}
	this.iface.__copiarCampoReciboDiv(nombreCampo, cursor, campoInformado);
}
//// GTESORERIA /////////////////////////////////////////////////
////////////////////////////////////////////////////////////

