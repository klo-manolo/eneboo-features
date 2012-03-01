
/** @class_declaration usupedcli */
//////////////////////////////////////////////////////////////////
//// USUPEDCLI /////////////////////////////////////////////////////
class usupedcli extends oficial {
	function usupedcli( context ) { oficial ( context ); }
	function init() {
		return this.ctx.usupedcli_init();
	}
	function validateForm():Boolean { return this.ctx.usupedcli_validateForm(); }
}
//// USUPEDCLI /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition usupedcli */
//// USUPEDCLI /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
function usupedcli_init()
{
	this.iface.__init();

	var util:FLUtil = new FLUtil();
	var idUsuario:String = sys.nameUser();
	var cursor:FLSqlCursor = this.cursor();

	if (cursor.modeAccess() == cursor.Insert) {
		cursor.setValueBuffer("idusucrea", idUsuario);
	}
}

function usupedcli_validateForm()
{
	if(!this.iface.__validateForm())
		return false;

	var cursor:FLSqlCursor = this.cursor();
	if (cursor.valueBuffer("idusucrea") == "" || cursor.isNull("idusucrea")) {
		var idUsuario:String = sys.nameUser();
		cursor.setValueBuffer("idusucrea", idUsuario);
	}

	return true;
}
//// USUPEDCLI /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

