
/** @class_declaration modelos */
/////////////////////////////////////////////////////////////////
//// BASE MODELOS ///////////////////////////////////////////////
class modelos extends oficial {
	var tbnModelos:Object;
	function modelos( context ) { oficial ( context ); }
	function init() {
		return this.ctx.modelos_init();
	}
	function tbnModelos_clicked() {
		return this.ctx.modelos_tbnModelos_clicked();
	}
	function completarOpcionesModelos(arrayOps:Array):Boolean {
		return this.ctx.modelos_completarOpcionesModelos(arrayOps);
	}
	function ejecutarOpcionModelo(opcion:String):Boolean {
		return this.ctx.modelos_ejecutarOpcionModelo(opcion);
	}
	function obtenerOpcionModelo(arrayOps:Array):String {
		return this.ctx.modelos_obtenerOpcionModelo(arrayOps);
	}
	function configurarBotonModelos() {
		return this.ctx.modelos_configurarBotonModelos();
	}
}
//// BASE MODELOS ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition modelos */
/////////////////////////////////////////////////////////////////
//// BASE MODELOS ///////////////////////////////////////////////
function modelos_init()
{
	this.iface.__init();

	this.iface.tbnModelos = this.child("tbnModelos");
	connect (this.iface.tbnModelos, "clicked()", this, "iface.tbnModelos_clicked");
	this.iface.configurarBotonModelos();
}

function modelos_tbnModelos_clicked()
{
	var arrayOpciones:Array = [];
	if (!this.iface.completarOpcionesModelos(arrayOpciones)) {
		return false;
	}
	var opcion:String = this.iface.obtenerOpcionModelo(arrayOpciones);
	if (!opcion) {
		return false;
	}
	if (!this.iface.ejecutarOpcionModelo(opcion)) {
		return false;
	}
}

function modelos_completarOpcionesModelos(arrayOps:Array):Boolean
{
// 	var i:Number = arrayOps.length;
// 	arrayOps[i] = [];
// 	arrayOps[i]["texto"] = "prueba";
// 	arrayOps[i]["opcion"] = "PB";
	return true;
}

function modelos_ejecutarOpcionModelo(opcion:String):Boolean
{
// 	debug("Opción = " + opcion);
	return true;
}

function modelos_obtenerOpcionModelo(arrayOps:Array):String
{
	var util:FLUtil = new FLUtil;
	var dialogo = new Dialog;
	dialogo.okButtonText = util.translate("scripts", "Aceptar");
	dialogo.cancelButtonText = util.translate("scripts", "Cancelar");
	
	var gbxDialogo = new GroupBox;
	gbxDialogo.title = util.translate("scripts", "Seleccione opción");
	
	var rButton:Array = new Array(arrayOps.length);
	for (var i:Number = 0; i < rButton.length; i++) {
		rButton[i] = new RadioButton;
		rButton[i].text = arrayOps[i]["texto"];
		rButton[i].checked = false;
		gbxDialogo.add(rButton[i]);
	}
	
	dialogo.add(gbxDialogo);
	if (!dialogo.exec()) {
		return false;
	}
	for (var i:Number = 0; i < rButton.length; i++) {
		if (rButton[i].checked) {
			return arrayOps[i]["opcion"];
		}
	}
	return false;
}

function modelos_configurarBotonModelos()
{
	this.child("tbnModelos").close();
}

//// BASE MODELOS ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
