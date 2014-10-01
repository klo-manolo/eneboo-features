
/** @class_declaration navegador */
/////////////////////////////////////////////////////////////////
//// CONF NAVEGADOR /////////////////////////////////////////////
class navegador extends oficial /** %from: oficial */ {
	function navegador( context ) { oficial ( context ); }
	function init() {
		return this.ctx.navegador_init();
	}
	function cambiarNavegador() {
		return this.ctx.navegador_cambiarNavegador();
	}
}
//// CONF NAVEGADOR /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration envioMail */
/////////////////////////////////////////////////////////////////
//// ENVIO MAIL /////////////////////////////////////////////////
class envioMail extends navegador /** %from: navegador */ {
	function envioMail( context ) { navegador ( context ); }
	function init() {
		return this.ctx.envioMail_init();
	}
	function cambiarClienteCorreo() {
		return this.ctx.envioMail_cambiarClienteCorreo();
	}
	function cambiarNombreCorreo() {
		return this.ctx.envioMail_cambiarNombreCorreo();
	}
	function cambiarDirIntermedia() {
		return this.ctx.envioMail_cambiarDirIntermedia();
	}
}
//// ENVIO MAIL /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition navegador */
/////////////////////////////////////////////////////////////////
//// CONF NAVEGADOR /////////////////////////////////////////////
function navegador_init()
{
	this.iface.__init();

	var util:FLUtil = new FLUtil();
	this.child("lblNombreNavegador").text = util.readSettingEntry("scripts/flfactinfo/nombrenavegador");
	connect(this.child("pbnCambiarNavegador"), "clicked()", this, "iface.cambiarNavegador");
}

function navegador_cambiarNavegador()
{
	var util:FLUtil = new FLUtil();
	var nombreNavegador:String = Input.getText( util.translate( "scripts", "Nombre del navegador o ruta de acceso:" ) );
	if (!nombreNavegador) {
		return;
	}

	this.child("lblNombreNavegador").text = nombreNavegador;
	util.writeSettingEntry("scripts/flfactinfo/nombrenavegador", nombreNavegador);
}

//// CONF NAVEGADOR /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition envioMail */
/////////////////////////////////////////////////////////////////
//// ENVIO MAIL /////////////////////////////////////////////////
function envioMail_init()
{
	this.iface.__init();

	var util:FLUtil = new FLUtil();
	this.child("lblClienteCorreo").text = util.readSettingEntry("scripts/flfactinfo/clientecorreo");
	this.child("lblNombreCorreo").text = util.readSettingEntry("scripts/flfactinfo/nombrecorreo");
	this.child("lblDirIntermedia").text = util.readSettingEntry("scripts/flfactinfo/dirCorreo");
	connect(this.child("pbnCambiarClienteCorreo"), "clicked()", this, "iface.cambiarClienteCorreo");
	connect(this.child("pbnCambiarNombreCorreo"), "clicked()", this, "iface.cambiarNombreCorreo");
	connect(this.child("pbnCambiarDirIntermedia"), "clicked()", this, "iface.cambiarDirIntermedia");
}

function envioMail_cambiarClienteCorreo()
{
	var util:FLUtil = new FLUtil();
	var opciones:Array = ["KMail", "Thunderbird", "Outlook"];
	var codClienteCorreo:String = Input.getItem( util.translate( "scripts", "Cliente de correo:"), opciones, "KMail", false);

	if (!codClienteCorreo) {
		return;
	}

	this.child("lblClienteCorreo").text = codClienteCorreo;
	util.writeSettingEntry("scripts/flfactinfo/clientecorreo", codClienteCorreo);

	var nombreCorreo = "";
	switch (codClienteCorreo) {
		case "KMail": { nombreCorreo = "kmail"; break; }
		case "Thunderbird": { nombreCorreo = "thunderbird"; break; }
		case "Outlook": { nombreCorreo = "outlook.exe"; break; }
	}
	if (nombreCorreo != "") {
		this.child("lblNombreCorreo").text = nombreCorreo;
		util.writeSettingEntry("scripts/flfactinfo/nombrecorreo", nombreCorreo);
	}
}

function envioMail_cambiarNombreCorreo()
{
	var util:FLUtil = new FLUtil();
	var texto:String = "Debe escribir la ruta al programa de correo. A continuación se detallan algunos ejemplos: \n\n - MAC:  /Applications/Thunderbird.app/Contents/MacOS/Thunedrbird.app/Contents/MacOS/thunderbird \n\n - WINDOWS:  C:'\\Program Files (x86)\\Mozilla Thunderbird\\thunderbird.exe \n\n - LINUX:  thunderbird \n\n\n Escriba su ruta para el programa de correo:";
	var nombreCorreo:String = Input.getText( util.translate( "scripts", texto ) );

	if (!nombreCorreo) {
		return;
	}

	this.child("lblNombreCorreo").text = nombreCorreo;
	util.writeSettingEntry("scripts/flfactinfo/nombrecorreo", nombreCorreo);
}

function envioMail_cambiarDirIntermedia()
{
	var util:FLUtil = new FLUtil();
	var ruta:String = FileDialog.getExistingDirectory(util.translate("scripts", ""), util.translate("scripts", "RUTA INTERMEDIA"));

	if (!File.isDir(ruta)) {
		MessageBox.information(util.translate("scripts", "Ruta errónea"),MessageBox.Ok, MessageBox.NoButton);
		return;
	}
	this.child("lblDirIntermedia").text = ruta;
	util.writeSettingEntry("scripts/flfactinfo/dirCorreo", ruta);
}
//// ENVIO MAIL /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

