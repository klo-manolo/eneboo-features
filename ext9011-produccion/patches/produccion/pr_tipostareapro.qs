
/** @class_declaration prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCION /////////////////////////////////////////////////
class prod extends oficial {
	function prod( context ) { oficial ( context ); }
	function init() {
		this.ctx.prod_init();
	}
	function bufferChanged(fN:String) {
		return this.ctx.prod_bufferChanged(fN);
	}
	function validateForm():Boolean {
		return this.ctx.prod_validateForm();
	}
}
//// PRODUCCION /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCION /////////////////////////////////////////////////
function prod_init()
{
	this.iface.__init();

	var cursor:FLSqlCursor = this.cursor();

	this.iface.bufferChanged("opcional");
	switch(cursor.modeAccess()) {
		case cursor.Edit: {
			var valores:String = cursor.valueBuffer("valoresopcion");
			if(valores && valores != "") {
				var array:Array = valores.split("|");
				for(var i=0;i<array.length;i++)
					this.child("tdbOpciones").setPrimaryKeyChecked(array[i],true);
			}
			break;
		}
	}
}

function prod_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();
	switch (fN) {
		case "opcional": {
			if(cursor.valueBuffer("opcional")) {
				this.child("tbwProduccion").setTabEnabled("TabPageOpciones", true);
			}
			else {
				cursor.setNull("idtipoopcion");
				cursor.setNull("valoresopcion");
				this.child("tbwProduccion").setTabEnabled("TabPageOpciones", false);
			}
			break;
		}
		case "idtipoopcion": {
debug("entra");
			var keys:Array = this.child("tdbOpciones").primarysKeysChecked();
			for(var i=0;i<keys.length;i++) {
			debug("keys " + keys[i]);
				this.child("tdbOpciones").setPrimaryKeyChecked(keys[i],false);
			}
			cursor.setNull("valoresopcion");
			this.child("tdbOpciones").refresh();
			break;
		}
		default: {
			this.iface.__bufferChanged(fN);
			break;
		}
	}
}

function prod_validateForm():Boolean
{
	var util:FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	if(cursor.valueBuffer("idtipoopcion")) {
		var valores:String = "|" + this.child("tdbOpciones").primarysKeysChecked().join("|") + "|";
		if(!valores)
			cursor.setNull("valoresopcion");
		else
			cursor.setValueBuffer("valoresopcion",valores);
	}
}
//// PRODUCCION /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

