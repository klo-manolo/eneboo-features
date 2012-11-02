/***************************************************************************
                 movistock.qs  -  description
                             -------------------
    begin                : jue jun 14 2006
    copyright            : (C) 2006 by InfoSiAL S.L.
    email                : mail@infosial.com
 ***************************************************************************/
/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

/** @file */

/** @class_declaration interna */
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna {
    var ctx:Object;
    function interna( context ) { this.ctx = context; }
	function init() {
		this.ctx.interna_init();
	}
	function validateForm():String {
		return this.ctx.interna_validateForm();
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var tbnVerPresupuestoCli:Object;
	var tbnVerPedidoCli:Object;
	var tbnVerAlbaranCli:Object;
	var tbnVerPedidoProv:Object;
	var tbnVerAlbaranProv:Object;
	var tbnVerProceso:Object;
	var tbnVerTransStock:Object;
    function oficial( context ) { interna( context ); }
	function mostrarDatosDoc() {
		return this.ctx.oficial_mostrarDatosDoc();
	}
	function mostrarPresupuestoCli() {
		return this.ctx.oficial_mostrarPresupuestoCli();
	}
	function mostrarPedidoCli() {
		return this.ctx.oficial_mostrarPedidoCli();
	}
	function mostrarAlbaranCli() {
		return this.ctx.oficial_mostrarAlbaranCli();
	}
	function mostrarPedidoProv() {
		return this.ctx.oficial_mostrarPedidoProv();
	}
	function mostrarAlbaranProv() {
		return this.ctx.oficial_mostrarAlbaranProv();
	}
	function mostrarProceso() {
		return this.ctx.oficial_mostrarProceso();
	}
	function mostrarTransStock() {
		return this.ctx.oficial_mostrarTransStock();
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial {
    function head( context ) { oficial ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
}

const iface = new ifaceCtx( this );
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
function interna_init()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var referencia:String = cursor.valueBuffer("referencia");

	this.iface.tbnVerPresupuestoCli = this.child("tbnVerPresupuestoCli"); 
	this.iface.tbnVerPedidoCli = this.child("tbnVerPedidoCli");
	this.iface.tbnVerAlbaranCli = this.child("tbnVerAlbaranCli");
	this.iface.tbnVerPedidoProv = this.child("tbnVerPedidoProv");
	this.iface.tbnVerAlbaranProv = this.child("tbnVerAlbaranProv");
	this.iface.tbnVerProceso = this.child("tbnVerProceso");
	this.iface.tbnVerTransStock = this.child("tbnVerTransStock");

	connect(this.iface.tbnVerPresupuestoCli, "clicked()", this, "iface.mostrarPresupuestoCli()");
	connect(this.iface.tbnVerPedidoCli, "clicked()", this, "iface.mostrarPedidoCli()");
	connect(this.iface.tbnVerAlbaranCli, "clicked()", this, "iface.mostrarAlbaranCli()");
	connect(this.iface.tbnVerPedidoProv, "clicked()", this, "iface.mostrarPedidoProv()");
	connect(this.iface.tbnVerAlbaranProv, "clicked()", this, "iface.mostrarAlbaranProv()");
	connect(this.iface.tbnVerProceso, "clicked()", this, "iface.mostrarProceso()");
	connect(this.iface.tbnVerTransStock, "clicked()", this, "iface.mostrarTransStock()");

// 	if (cursor.valueBuffer("estado") != "PTE") {
// 		this.child("fdbCodLote").setDisabled(false);
// 	} else {
// 		if (util.sqlSelect("articulos", "tipostock", "referencia = '" + referencia + "'") != "Lotes")
// 			this.child("fdbCodLote").setDisabled(false);
// 	}

	if (util.sqlSelect("articulos", "tipostock", "referencia = '" + referencia + "'") != "Lotes")
		this.child("fdbCodLote").setDisabled(true);
	else {
		if (cursor.valueBuffer("estado") == "PTE") 
			this.child("fdbCodLote").setDisabled(false);
		else
			this.child("fdbCodLote").setDisabled(true);
	}
debug("consumo");
	var curRelation:FLSqlCursor = cursor.cursorRelation();
	switch (cursor.modeAccess()) {
		case cursor.Insert: {
			if (curRelation && curRelation.table() == "pr_tareas") {
				this.child("fdbIdProceso").setValue(curRelation.valueBuffer("idproceso"));
				this.child("fdbCodLoteProd").setValue(curRelation.valueBuffer("idobjeto"));
			}
			break;
		}
		case cursor.Edit: {
			break;
		}
	}
	if (curRelation && curRelation.table() == "pr_tareas") {
debug("consumo CR");
		this.child("fdbIdProceso").setDisabled(true);
		this.child("fdbCodLoteProd").setDisabled(true);
	}

	this.child("fdbCodLote").setFilter("referencia = '" + cursor.valueBuffer("referencia") + "'");
	this.child("fdbIdProceso").setFilter("idobjeto = '" + cursor.valueBuffer("codloteprod") + "'");

	this.iface.mostrarDatosDoc();
}

function interna_validateForm():Boolean
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	/** \C No pueden insertarse manualmente consumos de artículos por lotes (temporal)
	\end */
	var referencia:String = cursor.valueBuffer("referencia");
	
	var tipoSock:String = util.sqlSelect("articulos", "tipostock", "referencia = '" + referencia + "'");
	if (tipoSock == "Lotes") {
		MessageBox.warning(util.translate("scripts", "No pueden insertarse manualmente consumos de artículos por lotes (temporal)"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	if (cursor.isNull("idproceso")) {
		MessageBox.warning(util.translate("scripts", "Debe establecer el proceso asociado al movimiento"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	if (cursor.isNull("idtarea")) {
		MessageBox.warning(util.translate("scripts", "Debe establecer la tarea asociada al movimiento"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	return true;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_mostrarDatosDoc()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	this.child("gbxPresupuestoCli").close();
	this.child("gbxPedidoCli").close();
	this.child("gbxAlbaranCli").close();
	this.child("gbxPedidoProv").close();
	this.child("gbxAlbaranProv").close();
	this.child("gbxProceso").close();
	this.child("gbxTransStock").close();

	var idLineaPR:Number = parseFloat(cursor.valueBuffer("idlineapr"));
	var idLineaPC:Number = parseFloat(cursor.valueBuffer("idlineapc"));
	var idLineaAC:Number = parseFloat(cursor.valueBuffer("idlineaac"));
	var idLineaPP:Number = parseFloat(cursor.valueBuffer("idlineapp"));
	var idLineaAP:Number = parseFloat(cursor.valueBuffer("idlineaap"));
	var idProceso:Number = parseFloat(cursor.valueBuffer("idproceso"));
	var idLineaTS:Number = parseFloat(cursor.valueBuffer("idlineats"));

debug("PRESUPUESTO CLIENTE " + idLineaPR);
debug("PEDIDO CLIENTE " + idLineaPC);
debug("ALBARAN CLIENTE " + idLineaAC);
debug("PEDIDO PROVEEDOR " + idLineaPP);
debug("ALBARAN PROVEEDOR " + idLineaAP);
debug("PROCESO " + idProceso);
debug("TRANSFERENCIA DE STOCK " + idLineaTS);
	
// PRESUPUESTO DE CLIENTE
	if (idLineaPR && idLineaPR != 0) {
		var codPresupuesto:String = util.sqlSelect("lineaspresupuestoscli lp INNER JOIN presupuestoscli p ON lp.idpresupuesto = p.idpresupuesto", "p.codigo", "lp.idlinea = " + idLineaPR, "presupuestoscli,lineaspresupuestoscli");
		if (codPresupuesto && codPresupuesto != "") {
			this.child("gbxPresupuestoCli").show();
			this.child("lblPresupuestoCli").text = codAlbaran;
		}
	}

// PEDIDO DE CLIENTE
	if (idLineaPC && idLineaPC != 0) {debug("ENTRA PC " + idLineaPC);
		var codPedido:String = util.sqlSelect("lineaspedidoscli lp INNER JOIN pedidoscli p ON lp.idpedido = p.idpedido", "p.codigo", "lp.idlinea = " + idLineaPC, "pedidoscli,lineaspedidoscli");
	debug("CODIGO " + codPedido);
		if (codPedido && codPedido != "") {
			this.child("gbxPedidoCli").show();
			this.child("lblPedidoCli").text = codPedido;
		}
	}

// ALBARAN DE CLIENTE
	if (idLineaAC && idLineaAC != 0) {
		var codAlbaran:String = util.sqlSelect("lineasalbaranescli la INNER JOIN albaranescli a ON la.idalbaran = a.idalbaran", "a.codigo", "la.idlinea = " + idLineaAC, "albaranescli,lineasalbaranescli");
		if (codAlbaran && codAlbaran != "") {
			this.child("gbxAlbaranCli").show();
			this.child("lblAlbaranCli").text = codAlbaran;
		}
	}

// PEDIDO DE PROVEEDOR
	if (idLineaPP && idLineaPP != 0) {
		var codPedido:String = util.sqlSelect("lineaspedidosprov lp INNER JOIN pedidosprov p ON lp.idpedido = p.idpedido", "p.codigo", "lp.idlinea = " + idLineaPP, "pedidosprov,lineaspedidosprov");
		if (codPedido && codPedido != "") {
			this.child("gbxPedidoProv").show();
			this.child("lblPedidoProv").text = codPedido;
		}
	}

// ALBARAN DE PROVEEDOR
	if (idLineaAP && idLineaAP != 0) {
		var codAlbaran:String = util.sqlSelect("lineasalbaranesprov la INNER JOIN albaranesprov a ON la.idalbaran = a.idalbaran", "a.codigo", "la.idlinea = " + idLineaAP, "albaranesprov,lineasalbaranesprov");
		if (codAlbaran && codAlbaran != "") {
			this.child("gbxAlbaranProv").show();
			this.child("lblAlbaranProv").text = codAlbaran;
		}
	}

// PROCESO
	if (idProceso && idProceso != 0) {
		this.child("gbxProceso").show();
		this.child("lblProceso").text = idProceso;
	}

// TRANSFERENCIA DE STOCK
	if (idLineaTS && idLineaTS != 0) {
		this.child("gbxTransStock").show();
		this.child("lblTransStock").text = idLineaTS;
	}
}

function oficial_mostrarPresupuestoCli()
{
	var util:FLUtil;
	var idPresupuesto:Number = parseFloat(util.sqlSelect("lineaspresupuestoscli","idpresupuesto","idlinea = " + parseFloat(this.cursor().valueBuffer("idlineapr"))));
	if (!idPresupuesto || idPresupuesto == 0)
		return false;

	var curPresupuestoCli:FLSqlCursor = new FLSqlCursor("presupuestoscli");
	curPresupuestoCli.select("idpresupuesto = " + idPresupuesto);
	if (!curPresupuestoCli.first())
		return;

	curPresupuestoCli.browseRecord();
}

function oficial_mostrarPedidoCli()
{
	var util:FLUtil;
	var idPedido:Number = parseFloat(util.sqlSelect("lineaspedidoscli","idpedido","idlinea = " + parseFloat(this.cursor().valueBuffer("idlineapc"))));
	if (!idPedido || idPedido == 0)
		return false;

	var curPedidoCli:FLSqlCursor = new FLSqlCursor("pedidoscli");
	curPedidoCli.select("idpedido = " + idPedido);
	if (!curPedidoCli.first())
		return;

	curPedidoCli.browseRecord();
}

function oficial_mostrarAlbaranCli()
{
	var util:FLUtil;
	var idAlbaran:Number = parseFloat(util.sqlSelect("lineasalbaranescli","idalbaran","idlinea = " + parseFloat(this.cursor().valueBuffer("idlineaac"))));
	if (!idAlbaran || idAlbaran == 0)
		return false;

	var curAlbaranCli:FLSqlCursor = new FLSqlCursor("albaranescli");
	curAlbaranCli.select("idalbaran = " + idAlbaran);
	if (!curAlbaranCli.first())
		return;

	curAlbaranCli.browseRecord();
}

function oficial_mostrarPedidoProv()
{
	var util:FLUtil;
	var idPedido:Number = parseFloat(util.sqlSelect("lineaspedidosprov","idpedido","idlinea = " + parseFloat(this.cursor().valueBuffer("idlineapp"))));
	if (!idPedido || idPedido == 0)
		return false;

	var curPedidoProv:FLSqlCursor = new FLSqlCursor("pedidosprov");
	curPedidoProv.select("idpedido = " + idPedido);
	if (!curPedidoProv.first())
		return;

	curPedidoProv.browseRecord();
}

function oficial_mostrarAlbaranProv()
{
	var util:FLUtil;
	var idAlbaran:Number = parseFloat(util.sqlSelect("lineasalbaranesprov","idalbaran","idlinea = " + parseFloat(this.cursor().valueBuffer("idlineaap"))));
	if (!idAlbaran || idAlbaran == 0)
		return false;

	var curAlbaranProv:FLSqlCursor = new FLSqlCursor("albaranesprov");
	curAlbaranProv.select("idalbaran = " + idAlbaran);
	if (!curAlbaranProv.first())
		return;

	curAlbaranProv.browseRecord();
}

function oficial_mostrarProceso()
{
	var idProceso:Number = parseFloat(this.cursor().valueBuffer("idproceso"));
	if (!idProceso || idProceso == 0)
		return false;

	var curProceso:FLSqlCursor = new FLSqlCursor("pr_procesos");
	curProceso.select("idproceso = " + idProceso);
	if (!curProceso.first())
		return;

	curProceso.browseRecord();
}

function oficial_mostrarTransStock()
{
	var idTransStock:Number = parseFloat(this.cursor().valueBuffer("idlineats"));
	if (!idTransStock || idTransStock == 0)
		return false;

	var curTransStock:FLSqlCursor = new FLSqlCursor("transstock");
	curTransStock.select("idtrans = " + idTransStock);
	if (!curTransStock.first())
		return;

	curTransStock.browseRecord();
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
