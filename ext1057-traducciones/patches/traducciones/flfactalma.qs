
/** @class_declaration traducciones */
/////////////////////////////////////////////////////////////////
//// TRADUCCIONES ///////////////////////////////////////////////
class traducciones extends oficial {
	var valoresTradActual:Array;
	function traducciones( context ) { oficial ( context ); }
	function traducir(tabla:String, campo:String, idCampo:String) {
		return this.ctx.traducciones_traducir(tabla, campo, idCampo);
	}
	function valoresTrad(tabla:String, campo:String, idCampo:String) {
		return this.ctx.traducciones_valoresTrad(tabla, campo, idCampo);
	}
	function afterCommit_articulos(curArticulo:FLSqlCursor):Boolean {
		return this.ctx.traducciones_afterCommit_articulos(curArticulo);
	}
}
//// TRADUCCIONES ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubTraducciones */
/////////////////////////////////////////////////////////////////
//// PUB_TRADUCCIONES //////////////////////////////////////////
class pubTraducciones extends head {
	function pubTraducciones( context ) { head( context ); }
	function pub_traducir(tabla:String, campo:String, idCampo:String) {
		return this.traducir(tabla, campo, idCampo);
	}
	function pub_valoresTrad(tabla:String, campo:String, idCampo:String) {
		return this.valoresTrad(tabla, campo, idCampo);
	}
}

//// PUB_TRADUCCIONES //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition traducciones */
/////////////////////////////////////////////////////////////////
//// TRADUCCIONES ///////////////////////////////////////////////
function traducciones_traducir(tabla:String, campo:String, idCampo:String)
{
	return flfactppal.iface.pub_traducir(tabla, campo, idCampo);
}

function traducciones_valoresTrad(tabla:String, campo:String, idCampo:String)
{
	return flfactppal.iface.valoresTrad(tabla, campo, idCampo);
}

function traducciones_afterCommit_articulos(curArticulo:FlSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	if (curArticulo.modeAccess() == curArticulo.Del) {
		if (!util.sqlDelete("traducciones", "idcampo = '" + curArticulo.valueBuffer("referencia") + "'")) {
			return false;
		}
	}
	return true;
}

//// TRADUCCIONES ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
