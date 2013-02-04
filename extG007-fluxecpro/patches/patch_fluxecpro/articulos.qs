
/** @class_declaration fluxecPro */
/////////////////////////////////////////////////////////////////
//// FLUX EC PRO /////////////////////////////////////////////////
class fluxecPro extends traducciones /** %from: traducciones */ {
    function fluxecPro( context ) { traducciones ( context ); }
	function init() {
		this.ctx.fluxecPro_init();
	}
	function traducirDescripcionSEO() {
		return this.ctx.fluxecPro_traducirDescripcionSEO();
	}
}
//// FLUX EC PRO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition fluxecPro */
//////////////////////////////////////////////////////////////////
//// FLUX EC PRO //////////////////////////////////////////////////
function fluxecPro_init()
{
	this.iface.__init();
	connect(this.child("pbnTradDescripcionSEO"), "clicked()", this, "iface.traducirDescripcionSEO");
}

function fluxecPro_traducirDescripcionSEO()
{
	return flfactppal.iface.pub_traducir("articulos", "descripcionseo", this.cursor().valueBuffer("referencia"));
}
//// FLUX EC PRO //////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

