
/** @class_declaration eFactura */
/////////////////////////////////////////////////////////////////
//// E-FACTURA //////////////////////////////////////////////////
class eFactura extends oficial /** %from: oficial */ {
	function eFactura( context ) { oficial ( context ); }
	function init() {
		return this.ctx.eFactura_init();
	}
	function pbnCambiarRutaLib_clicked() {
		return this.ctx.eFactura_pbnCambiarRutaLib_clicked();
	}
	function pbnCambiarRutaCert_clicked() {
		return this.ctx.eFactura_pbnCambiarRutaCert_clicked();
	}
}
//// E-FACTURA //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition eFactura */
/////////////////////////////////////////////////////////////////
//// E-FACTURA //////////////////////////////////////////////////
function eFactura_init()
{
	this.iface.__init();

	var util:FLUtil = new FLUtil();

	this.child("lblRutaLib").text = util.readSettingEntry("scripts/flfacturac/rutalib");
	this.child("lblRutaCertificado").text = util.readSettingEntry("scripts/flfacturac/rutacert");

	connect( this.child( "pbnCambiarRutaLib" ), "clicked()", this, "iface.pbnCambiarRutaLib_clicked" );
	connect( this.child( "pbnCambiarRutaCert" ), "clicked()", this, "iface.pbnCambiarRutaCert_clicked" );
}

function eFactura_pbnCambiarRutaLib_clicked()
{
	var util:FLUtil = new FLUtil();
	var ruta:String = FileDialog.getOpenFileName("", util.translate( "scripts", "Ruta a Eneboo Signature"));

	if ( !File.isFile( ruta ) ) {
		MessageBox.information(util.translate( "scripts", "Ruta errónea" ), MessageBox.Ok, MessageBox.NoButton);
		return;
	}
	this.child("lblRutaLib").text = ruta;
	util.writeSettingEntry("scripts/flfacturac/rutalib", ruta);
}

function eFactura_pbnCambiarRutaCert_clicked()
{
	var util:FLUtil = new FLUtil();
	var ruta:String = FileDialog.getOpenFileName("", util.translate( "scripts", "Ruta al fichero de certificado"));

	if ( !File.isFile( ruta ) ) {
		MessageBox.information(util.translate( "scripts", "Ruta errónea" ), MessageBox.Ok, MessageBox.NoButton);
		return;
	}
	this.child("lblRutaCertificado").text = ruta;
	util.writeSettingEntry("scripts/flfacturac/rutacert", ruta);
}
//// E-FACTURA //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

