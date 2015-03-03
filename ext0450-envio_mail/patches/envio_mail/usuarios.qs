
/** @class_declaration envioMail */
/////////////////////////////////////////////////////////////////
//// ENVIO MAIL /////////////////////////////////////////////////
class envioMail extends oficial {
    function envioMail( context ) { oficial ( context ); }
    function init() { 
		return this.ctx.envioMail_init(); 
	}
	function validateForm() {
		return this.ctx.envioMail_validateForm();
	}
	function iniciaClave() {
		return this.ctx.envioMail_iniciaClave();
	}
	function validarClave() {
		return this.ctx.envioMail_validarClave();
	}
	function tbnEnviarMailPrueba_clicked(){
		return this.ctx.envioMail_tbnEnviarMailPrueba_clicked();
	}
}
/** @class_definition envioMail */
/////////////////////////////////////////////////////////////////
//// ENVIO MAIL /////////////////////////////////////////////////
function envioMail_init()
{
	var _i = this.iface;
	_i.__init();
	_i.iniciaClave();
	
	connect(this.child("tbnEnviarMailPrueba"),"clicked()",this,"envioMail_tbnEnviarMailPrueba_clicked()");
}
function envioMail_validateForm()
{
	var _i = this.iface;
	
	if (!_i.validarClave()) {
		return false;
	}
	return true;
}
function envioMail_iniciaClave()
{
	var _i = this.iface;
	var cursor = this.cursor();
	this.child("ledClaveAcceso").text = cursor.valueBuffer("passwordsmtp");
	
}
function envioMail_validarClave()
{
	var _i = this.iface;
	var cursor = this.cursor();
	cursor.setValueBuffer("passwordsmtp", this.child("ledClaveAcceso").text);
	
	return true;
}

function envioMail_tbnEnviarMailPrueba_clicked()
{
	var destino = Input.getText(sys.translate("Indique el correo destino"));
	if (!destino) {
		return;
	}
	var asunto = sys.translate("Correo de prueba");
	var cuerpo = sys.translate("Cuerpo del correo de prueba");
	var arrayDest = [destino];
	var arrayAttach = [];
	
	var oDM = {};
	var curUsuario = this.cursor();
	var datos = ["hostcorreosaliente", "puertosmtp", "tipocxsmtp", "tipoautsmtp", "usuariosmtp"];
	for (i = 0; i < datos.length; i++) {
		oDM[datos[i]] = curUsuario.valueBuffer(datos[i]);
		debug("DAtos-------------------------" + curUsuario.valueBuffer(datos[i]));
	}
	oDM.passwordsmtp = this.child("ledClaveAcceso").text;
	
	flfactppal.iface.pub_enviaCorreoSMTP(cuerpo, asunto, arrayDest, arrayAttach, oDM);
}
//// ENVIO MAIL /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
