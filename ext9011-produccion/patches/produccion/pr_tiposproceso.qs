
/** @class_declaration prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCI�N /////////////////////////////////////////////////
class prod extends oficial {
	function prod( context ) { oficial ( context ); }
	function init() {
		this.ctx.prod_init();
	}
	function bufferChanged(fN:String) {
		return this.ctx.prod_bufferChanged(fN);
	}
}
//// PRODUCCI�N /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCI�N /////////////////////////////////////////////////
function prod_init()
{
	this.iface.__init();

// 	this.iface.bufferChanged("fabricacion");
	if(this.cursor().valueBuffer("fabricacion")) {
		this.child("fdbTipoObjeto").setDisabled(true);
		this.child("fdbTipoProduccion").setDisabled(false);
	} else {
		this.child("fdbTipoObjeto").setDisabled(false);
		this.child("fdbTipoProduccion").setDisabled(true);
	}
}

function prod_bufferChanged(fN:String)
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	switch (fN) {
		case "fabricacion": {
			if (cursor.valueBuffer("fabricacion")) {
				this.child("fdbTipoObjeto").setValue("lotesstock");
				this.child("fdbTipoObjeto").setDisabled(true);
				this.child("fdbTipoProduccion").setDisabled(false);
			} else {
				this.child("fdbTipoObjeto").setValue("");
				this.child("fdbTipoObjeto").setDisabled(false);
				this.child("fdbTipoProduccion").setDisabled(true);
			}
		}
	}
}
//// PRODUCCI�N /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

