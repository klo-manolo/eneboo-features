
/** @class_declaration prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCION /////////////////////////////////////////////////
class prod extends oficial {
    function prod( context ) { oficial ( context ); }
	function validateForm():Boolean {
		return this.ctx.prod_validateForm();
	}
}
//// PRODUCCION /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration visual */
/////////////////////////////////////////////////////////////////
//// PRODUCCION VISUAL //////////////////////////////////////////
class visual extends prod {
    function visual( context ) { prod ( context ); }
	function init() {
		return this.ctx.visual_init();
	}
	function accionesAutomaticas() {
		return this.ctx.visual_accionesAutomaticas();
	}
	function realizarAccionAutomatica(accion:Array):Boolean {
		return this.ctx.visual_realizarAccionAutomatica(accion);
	}
}
//// PRODUCCION VISUAL //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCION /////////////////////////////////////////////////
function prod_validateForm():Boolean
{
	if (!this.iface.__validateForm())
		return false;

	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	if (cursor.valueBuffer("fechaentrada") != cursor.valueBufferCopy("fechaentrada")) {
		if (!flfactalma.iface.pub_modificarFechaPedidoProv(cursor))
			return false;
	}
// 	var qryStocks:FLSqlQuery = new FLSqlQuery()
// 	with (qryStocks) {
// 		setTablesList("movistock,lineaspedidosprov");
// 		setSelect("ms.idstock");
// 		setFrom("lineaspedidosprov lp INNER JOIN movistock ms ON lp.idlinea = ms.idlineapp");
// 		setWhere("lp.idpedido = " + cursor.valueBuffer("idpedido") + " AND ms.estado = 'PTE' GROUP BY idstock");
// 		setForwardOnly(true);
// 	}
// 	if (!qryStocks.exec())
// 		return false;
// 	while (qryStocks.next()) {
// 		if (!flfactalma.iface.pub_comprobarEvolStock(qryStocks.value("ms.idstock")))
// 			return false;
// 	}
	return true;
}

//// PRODUCCION /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition visual */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN VISUAL //////////////////////////////////////////
function visual_init()
{
	this.iface.__init();
	connect(this, "formReady()", this, "iface.accionesAutomaticas");
}

function visual_accionesAutomaticas()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var acciones:Array = flcolaproc.iface.pub_accionesAuto();
	if (!acciones) {
		return;
	}
	var i:Number = 0;
	while (i < acciones.length && acciones[i]["usada"]) { i++; }
	if (i == acciones.length) {
		return;
	}

	while (i < acciones.length && acciones[i]["contexto"] == "pedidosprov") {
		if (!this.iface.realizarAccionAutomatica(acciones[i])) {
			break;
		}
		i++;
	}
}

/** \D Realizar una determinada acción.
@return: Se devuelve false si algo falla o si la acción implica que no debe realizarse ninguna acción subsiguiente en el contexto actual.
\end */
function visual_realizarAccionAutomatica(accion:Array):Boolean
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	switch (accion["accion"]) {
		case "editar_linea": {
			accion["usada"] = true;
			var curLineas:FLSqlCursor = this.child("tdbArticulosPedProv").cursor();
			curLineas.select("idlinea = " + accion["idlinea"]);
			curLineas.first();
			curLineas.editRecord();
			break;
		}
		default: {
			return false;
		}
	}
	return true;
}
//// PRODUCCIÓN VISUAL //////////////////////////////////////////
////////////////////////////////////////////////////////////////

