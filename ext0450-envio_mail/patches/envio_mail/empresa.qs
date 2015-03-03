
/** @class_declaration envioMail */
/////////////////////////////////////////////////////////////////
//// ENVIO MAIL /////////////////////////////////////////////////
class envioMail extends navegador {
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
	var opciones:Array = ["Eneboo", "KMail", "Thunderbird", "Outlook"];
	var codClienteCorreo:String = Input.getItem( util.translate( "scripts", "Cliente de correo:"), opciones, "Eneboo", false);
		
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
	var nombreCorreo:String = Input.getText( util.translate( "scripts", "Ejecutable para correo (no necesario para cliente Eneboo):" ) );
		
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
