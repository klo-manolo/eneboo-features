
/** @class_declaration prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCION /////////////////////////////////////////////////
class prod extends oficial {
    function prod( context ) { oficial ( context ); }
	function validateForm():Boolean {
		this.ctx.prod_validateForm();
	}
	function init() {
		this.ctx.prod_init();
	}
}
//// PRODUCCION /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition prod */
//////////////////////////////////////////////////////////////////
//// PRODUCCION //////////////////////////////////////////////////
function prod_validateForm():Boolean
{
	return true;
}

function prod_init()
{
	this.iface.__init();

	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	switch (cursor.modeAccess()) {
		case cursor.Insert: {
			if (util.sqlSelect("tiposopcioncomp","constante","idtipoopcion = " + this.cursor().valueBuffer("idtipoopcion")))
				cursor.setValueBuffer("constante", true);

			break;
		}
	}
}
//// PRODUCCION //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

