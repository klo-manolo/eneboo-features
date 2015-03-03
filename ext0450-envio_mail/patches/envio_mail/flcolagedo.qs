
/** @class_declaration envioMail */
/////////////////////////////////////////////////////////////////
//// ENVIO MAIL ///////////////////////////////////////////////
class envioMail extends oficial {
	function envioMail( context ) { oficial ( context ); }
	function enviarDocEmail() {
		return this.ctx.envioMail_enviarDocEmail();
	}
	function obtenerDestinatarios() {
		return this.ctx.envioMail_obtenerDestinatarios();
	}
}
//// ENVIO MAIL ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition envioMail */
/////////////////////////////////////////////////////////////////
//// ENVIO MAIL ///////////////////////////////////////////////
function envioMail_obtenerDestinatarios()
{
	return "";
}

function envioMail_enviarDocEmail()
{
	var _i = this.iface;
	var item = _i.itemActual_;
	if (!item) {
		sys.warnMsgBox(sys.translate("No ha seleccionado ningún elemento"));
		return false;
	}
	
	if (this.iface.tipoActual_ != "gd_documentos") {
		return false;
	}

	var pathFichero = AQUtil.readSettingEntry("scripts/flfactinfo/dirCorreo");
	if (!File.isDir(pathFichero)) {
		pathFichero = FileDialog.getExistingDirectory(Dir.home, util.translate("scripts", "Seleccione directorio"));
		if (!pathFichero)
			return false;
	}
	
	if (!pathFichero.endsWith("/")) {
		pathFichero += "/";
	}

	var codDocumento:String = AQUtil.sqlSelect("gd_documentos", "codigo", "iddocumento = " + _i.itemActual_.key());
	if (!codDocumento)
		return false;
	
	var cursor = new FLSqlCursor("gd_documentos");
	cursor.select("iddocumento = " + _i.itemActual_.key());
	if(!cursor.first())
		return false;

	cursor.setModeAccess(cursor.Browse);
	cursor.refreshBuffer();
	
	if (!_i.pub_obtenerDocumento(codDocumento, pathFichero + cursor.valueBuffer("fichero"), false, false, cursor.valueBuffer("rutarepositorio"))) {
		return false;
	}
	
	var destinatarios = _i.obtenerDestinatarios();
	if (!destinatarios) {
		destinatarios = "";
	}

	var cuerpo:String = "";
	var asunto:String = sys.translate("scripts", "Envío de documento %1").arg(cursor.valueBuffer("fichero"));
	var rutaDocumento = pathFichero + cursor.valueBuffer("fichero");

	var arrayDest:Array = [];
	arrayDest[0] = [];
	arrayDest[0]["tipo"] = "to";
	arrayDest[0]["direccion"] = destinatarios;

	var arrayAttach:Array = [];
	arrayAttach[0] = rutaDocumento;

	flfactppal.iface.pub_enviarCorreo(cuerpo, asunto, arrayDest, arrayAttach);
	
	return true;
}
//// ENVIO MAIL ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
