
/** @class_declaration prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN /////////////////////////////////////////////////
class prod extends oficial {
    function prod( context ) { oficial ( context ); }
	function validateForm():Boolean {
		return this.ctx.prod_validateForm();
	}
	function init() {
		return this.ctx.prod_init();
	}
	function calcularTotales() {
		return this.ctx.prod_calcularTotales();
	}
	function refrescarLotes() {
		return this.ctx.prod_refrescarLotes();
	}
}
//// DESARROLLO /////////////////////////////////////////////////
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
//// PRODUCCIÓN /////////////////////////////////////////////////
function prod_validateForm():Boolean
{
	if (!this.iface.__validateForm())
		return false;

	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	if (cursor.valueBuffer("fechasalida") != cursor.valueBufferCopy("fechasalida")) {
		if (!flfactalma.iface.pub_modificarFechaPedidoCli(cursor))
			return false;
	}
// 	var qryStocks:FLSqlQuery = new FLSqlQuery()
// 	with (qryStocks) {
// 		setTablesList("movistock,lineaspedidosprov");
// 		setSelect("ms.idstock");
// 		setFrom("lineaspedidoscli lp INNER JOIN movistock ms ON lp.idlinea = ms.idlineapc");
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

function prod_init()
{
	this.iface.__init();
	this.iface.refrescarLotes();
}

function prod_calcularTotales()
{
	this.iface.__calcularTotales();
	this.iface.refrescarLotes();
}

function prod_refrescarLotes()
{
	var cursor:FLSqlCursor = this.cursor();

	var qryLotes:FLSqlQuery = new FLSqlQuery();
	qryLotes.setTablesList("movistock,lineaspedidoscli");
	qryLotes.setSelect("ms.codlote");
	qryLotes.setFrom("lineaspedidoscli lp INNER JOIN movistock ms ON lp.idlinea = ms.idlineapc");
	qryLotes.setWhere("idpedido = " + cursor.valueBuffer("idpedido"));
	qryLotes.setForwardOnly(true);
	if (!qryLotes.exec())
		return;

	var listaLotes:String = "";
	while (qryLotes.next()) {
		if (listaLotes != "")
			listaLotes += ", "
		listaLotes += "'" + qryLotes.value("ms.codlote") + "'";
	}
	if (listaLotes && listaLotes != "")
		this.child("tdbLotesStock").cursor().setMainFilter("codlote IN (" + listaLotes + ")");
	else
		this.child("tdbLotesStock").cursor().setMainFilter("1 = 2");

	this.child("tdbLotesStock").refresh();
}

//// PRODUCCIÓN /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition visual */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN VISUAL //////////////////////////////////////////
function visual_init()
{
debug("init");
	this.iface.__init();
	connect(this, "formReady()", this, "iface.accionesAutomaticas");
}

function visual_accionesAutomaticas()
{
debug("acciones auto");
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

	while (i < acciones.length && acciones[i]["contexto"] == "pedidoscli") {
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
debug("visual_realizarAccionAutomatica")
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	switch (accion["accion"]) {
		case "editar_linea": {
debug("editar linea " + accion["idlinea"]);
			accion["usada"] = true;
			var curLineas:FLSqlCursor = this.child("tdbLineasPedidosCli").cursor();
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

