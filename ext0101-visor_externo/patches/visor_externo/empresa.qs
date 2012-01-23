
/** @class_declaration visorexterno */
/////////////////////////////////////////////////////////////////
//// VISOREXTERNO /////////////////////////////////////////////////
class visorexterno extends oficial {
	function visorexterno( context ) { oficial ( context ); }
	function init() { 
		return this.ctx.visorexterno_init(); 
	}
	function cambiarVisor() { 
		return this.ctx.visorexterno_cambiarVisor();
	}
	function cambiarUsoVisor() { 
		return this.ctx.visorexterno_cambiarUsoVisor();
	}
	function cambiarDirTmpVisor() { 
		return this.ctx.visorexterno_cambiarDirTmpVisor();
	}
}
//// VISOREXTERNO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition visorexterno */
/////////////////////////////////////////////////////////////////
//// VISOREXTERNO /////////////////////////////////////////////////
function visorexterno_init()
{
	this.iface.__init();

	var util:FLUtil = new FLUtil();
	this.child("lblNombreVisor").text = util.readSettingEntry("scripts/flfactinfo/visorexterno");
	this.child("lblUsoVisor").text = util.readSettingEntry("scripts/flfactinfo/usovisor");
	this.child("lblDirTmpVisor").text = util.readSettingEntry("scripts/flfactinfo/dirtmpvisor");
	connect(this.child("pbnCambiarVisor"), "clicked()", this, "iface.cambiarVisor");
	connect(this.child("pbnCambiarUsoVisor"), "clicked()", this, "iface.cambiarUsoVisor");
	connect(this.child("pbnCambiarDirTmpVisor"), "clicked()", this, "iface.cambiarDirTmpVisor");
}

function visorexterno_cambiarVisor()
{
	var util:FLUtil = new FLUtil();
	//var nombreVisor:String = Input.getText( util.translate( "scripts", "Ejecutable para visualizar informes:" ) );

	var nombreVisor:String = FileDialog.getOpenFileName("*");
	
	if ( !File.isFile( nombreVisor ) ) {
		MessageBox.information(util.translate( "scripts", "Ruta errónea" ), MessageBox.Ok, MessageBox.NoButton);
		this.child("lblNombreVisor").text = "";
		util.writeSettingEntry("scripts/flfactinfo/visorexterno", "");
		return;
	}

	if (!nombreVisor) {
		return;
	}
	
	this.child("lblNombreVisor").text = nombreVisor;
	util.writeSettingEntry("scripts/flfactinfo/visorexterno", nombreVisor);
}

function visorexterno_cambiarUsoVisor()
{
	var util:FLUtil = new FLUtil();
	var opciones:Array = ["Siempre", "Nunca"];
	var usoVisor:String = Input.getItem( util.translate( "scripts", "Preguntar por el uso del visor externo:"), opciones, "Siempre", false);
		
	if (!usoVisor) {
		return;
	}

	var etiquetaUsoVisor = "";
	switch (usoVisor) {
		case "Siempre": { etiquetaUsoVisor = "siempre"; break; }
		case "Nunca": { etiquetaUsoVisor = "nunca"; break; }
	}
	if (etiquetaUsoVisor != "") {
		this.child("lblUsoVisor").text = usoVisor;
		util.writeSettingEntry("scripts/flfactinfo/usovisor", etiquetaUsoVisor);
	}
}

function visorexterno_cambiarDirTmpVisor()
{
	var util:FLUtil = new FLUtil();
	var ruta:String = FileDialog.getExistingDirectory(util.translate("scripts", ""), util.translate("scripts", "RUTA TEMPORALES DEL VISOR"));
	
	if (!File.isDir(ruta)) {
		MessageBox.information(util.translate("scripts", "Ruta errónea"),MessageBox.Ok, MessageBox.NoButton);
		return;
	}
	this.child("lblDirTmpVisor").text = ruta;
	util.writeSettingEntry("scripts/flfactinfo/dirtmpvisor", ruta);
}
//// VISOREXTERNO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
