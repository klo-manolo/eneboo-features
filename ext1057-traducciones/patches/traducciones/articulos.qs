
/** @class_declaration traducciones */
/////////////////////////////////////////////////////////////////
//// TRADUCCIONES ///////////////////////////////////////////////
class traducciones extends oficial {
    function traducciones( context ) { oficial ( context ); }
    function init() { 
		return this.ctx.traducciones_init(); 
	}
	function traducirDescripcion() {
		return this.ctx.traducciones_traducirDescripcion();
	}
}
//// TRADUCCIONES ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition traducciones */
/////////////////////////////////////////////////////////////////
//// TRADUCCIONES //////////////////////////////////////////////
function traducciones_init()
{
	this.iface.__init();
	connect(this.child("pbnTradDescripcion"), "clicked()", this, "iface.traducirDescripcion");
}

function traducciones_traducirDescripcion()
{
	return flfactppal.iface.pub_traducir("articulos", "descripcion", this.cursor().valueBuffer("referencia"));
}

//// TRADUCCIONES //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
