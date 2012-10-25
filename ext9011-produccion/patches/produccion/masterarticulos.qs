
/** @class_declaration prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN /////////////////////////////////////////////////
class prod extends pesosMedidas {
	var tbnFiltroFamilia:Object;
	var lblFiltroActual:Object;
    function prod( context ) { pesosMedidas ( context ); }
	function init() {
		this.ctx.prod_init();
	}
	function tbnFiltroFamilia_clicked() {
		return this.ctx.prod_tbnFiltroFamilia_clicked();
	}
// 	function datosArticulo(cursor:FLSqlCursor,referencia:String):Boolean {
// 		return this.ctx.prod_datosArticulo(cursor,referencia);
// 	}
// 	function datosArticuloProv(cursor:FLSqlCursor, cursorNuevo:FLSqlCursor, referencia:String):Boolean {
// 		return this.ctx.prod_datosArticuloProv(cursor, cursorNuevo, referencia);
// 	}
// 	function datosArticuloComp(cursor:FLSqlCursor,cursorNuevo:FLSqlCursor,referencia:String):Boolean {
// 		return this.ctx.prod_datosArticuloComp(cursor,cursorNuevo,referencia);
// 	}
}
//// PRODUCCIÓN /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN /////////////////////////////////////////////////
function prod_init()
{
	this.iface.__init();

	this.iface.tbnFiltroFamilia = this.child("tbnFiltroFamilia");
	this.iface.lblFiltroActual = this.child("lblFiltroActual");

	connect(this.iface.tbnFiltroFamilia, "clicked()", this, "iface.tbnFiltroFamilia_clicked");
}

function prod_tbnFiltroFamilia_clicked()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	if (this.iface.tbnFiltroFamilia.on) {
		var f:Object = new FLFormSearchDB("familias");
		f.setMainWidget();
		var codFamilia:String = f.exec("codfamilia");
		var desFamilia:String = util.sqlSelect("familias", "descripcion", "codfamilia = '" + codFamilia + "'");

		if (codFamilia){
			cursor.setMainFilter("codfamilia = '" + codFamilia + "'");
			this.iface.lblFiltroActual.text = desFamilia;
		} else {
			cursor.setMainFilter("");
			this.iface.lblFiltroActual.text = "";
		}
	} else {
		cursor.setMainFilter("");
		this.iface.lblFiltroActual.text = "";
	}
	this.iface.tdbRecords.refresh();
}

// function prod_datosArticulo(cursor:FLSqlCursor,referencia:String):Boolean
// {
// 	if (!this.iface.__datosArticulo(cursor,referencia))
// 		return false;
//
// 	cursor.setValueBuffer("loteunico",this.iface.curArticulo.valueBuffer("loteunico"));
// 	cursor.setValueBuffer("fabricado",this.iface.curArticulo.valueBuffer("fabricado"));
// 	cursor.setValueBuffer("tipostock",this.iface.curArticulo.valueBuffer("tipostock"));
// 	cursor.setValueBuffer("idtipoproceso",this.iface.curArticulo.valueBuffer("idtipoproceso"));
//
// 	var diasprodenvio:Number = this.iface.curArticulo.valueBuffer("diasprodenvio");
// 	if (diasprodenvio)
// 		cursor.setValueBuffer("diasprodenvio",diasprodenvio);
//
// 	return true;
// }

// function prod_datosArticuloProv(cursor:FLSqlCursor,cursorNuevo:FLSqlCursor,referencia:String):Boolean
// {
// 	if (!this.iface.__datosArticuloProv(cursor, cursorNuevo, referencia))
// 		return false;
//
// 	cursorNuevo.setValueBuffer("plazo",cursor.valueBuffer("plazo"));
//
// 	return true;
// }

// function prod_datosArticuloComp(cursor:FLSqlCursor, cursorNuevo:FLSqlCursor, referencia:String):Boolean
// {
// 	if (!this.iface.__datosArticuloComp(cursor, cursorNuevo, referencia))
// 		return false;
//
// 	cursorNuevo.setValueBuffer("idtipotareapro", cursor.valueBuffer("idtipotareapro"));
// 	cursorNuevo.setValueBuffer("diasantelacion", cursor.valueBuffer("diasantelacion"));
// 	cursorNuevo.setValueBuffer("codfamiliacomponente", cursor.valueBuffer("codfamiliacomponente"));
//
// 	return true;
// }
//// PRODUCCIÓN /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

