
/** @class_declaration prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN /////////////////////////////////////////////////
class prod extends oficial {
	function prod( context ) { oficial ( context ); }
	function init() {
		this.ctx.prod_init();
	}
	function bufferChanged(fN:String) {
		return this.ctx.prod_bufferChanged(fN);
	}
}
//// PRODUCCIÓN /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN /////////////////////////////////////////////////
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
//// PRODUCCIÓN /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

