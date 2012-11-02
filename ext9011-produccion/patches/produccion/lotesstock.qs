/***************************************************************************
                 lotesstock.qs  -  description
                             -------------------
    begin                : jue abr 26 2007
    copyright            : (C) 2007 by InfoSiAL S.L.
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
    function init() { this.ctx.interna_init(); }
	function calculateCounter(curLS:FLSqlCursor):String {
		return this.ctx.interna_calculateCounter(curLS);
	}
	function validateForm():Boolean {
		return this.ctx.interna_validateForm();
	}
	function calculateField(fN:String):String {
		return this.ctx.interna_calculateField(fN);
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	function oficial( context ) { interna( context ); } 
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration prod */
//////////////////////////////////////////////////////////////////
//// PRODUCCION //////////////////////////////////////////////////
class prod extends oficial {
	var lvwDescomposicion:Object;
	var nodoSeleccionado:Object;
	var tbnCalcuNece:Object;
	var tbnEvolStock:Object;
	var tbnStock:Object;
	var toolButtonDeleteMS:Object;
	var tbnRegularizar:Object;
	var tbnFabricacionManual:Object;
	var toolButtonMostrarProceso:Object;
	var tbnLanzarProceso:Object;
	var curProceso:FLSqlCursor;
	var tbnCambiarLote:Object;
	function prod( context ) { oficial( context ); }
	function init() {
		return this.ctx.prod_init();
	}
	function cambiarLote_clicked() {
		return this.ctx.prod_cambiarLote_clicked();
	}
	function cambiarLote():Boolean {
		return this.ctx.prod_cambiarLote();
	}
	function refrescarArbol() {
		return this.ctx.prod_refrescarArbol();
	}
	function establecerDatosNodo(nodo:FLListViewItem,datos:Array) {
		return this.ctx.prod_establecerDatosNodo(nodo,datos);
	}
	function calcularDatosNodo(codLote:String):Array {
		return this.ctx.prod_calcularDatosNodo(codLote);
	}
	function calcularDatosNodoRaiz():Array {
		return this.ctx.prod_calcularDatosNodoRaiz();
	}
	function pintarNodo(nodo:FLListViewItem) {
		return this.ctx.prod_pintarNodo(nodo);
	}
	function cambiarSeleccionNodo(nodo:FLListViewItem) {
		return this.ctx.prod_cambiarSeleccionNodo(nodo);
	}
	function mostrarGrafica() {
		return this.ctx.prod_mostrarGrafica();
	}
	function mostrarTabla() {
		return this.ctx.prod_mostrarTabla();
	}
	function mostrarProceso() {
		return this.ctx.prod_mostrarProceso();
	}
	function mostrarStock() {
		return this.ctx.prod_mostrarStock();
	}
	function calcularIdProceso(codLote:String,referencia:String):Number {
		return this.ctx.prod_calcularIdProceso(codLote,referencia);
	}
	function bufferChanged(fN:String) {
		return this.ctx.prod_bufferChanged(fN);
	}
	function borrarRegularizacion() {
		return this.ctx.prod_borrarRegularizacion();
	}
	function regularizar() {
		return this.ctx.prod_regularizar();
	}
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.prod_commonCalculateField(fN, cursor);
	}
	function refrescarTotales() {
		return this.ctx.prod_refrescarTotales();
	}
	function fabricacionManual() {
		return this.ctx.prod_fabricacionManual();
	}
	function marcarFabricado(codLote:String):Boolean {
		return this.ctx.prod_marcarFabricado(codLote);
	}
	function desmarcarFabricado(codLote:String):Boolean {
		return this.ctx.prod_desmarcarFabricado(codLote);
	}
	function calculateCounter(curLS:FLSqlCursor):String {
		return this.ctx.prod_calculateCounter(curLS);
	}
	function tbnLanzarProceso_clicked() {
		return this.ctx.prod_tbnLanzarProceso_clicked();
	}
}
//// PRODUCCION //////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends prod {
    function head( context ) { prod ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
	function pub_calculateCounter(curLS:FLSqlCursor):String {
		return this.calculateCounter(curLS);
	}
	function pub_commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.commonCalculateField(fN, cursor);
	}
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
/** \C 
\end */
function interna_init()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
}

/** \D El parámetro cursor se usa en las funcionalidades que sobrecargan producción
\end */
function interna_calculateCounter(curLS:FLSqlCursor):String
{
	var util:FLUtil = new FLUtil();
	var id:String = "LS00000001";
	var idUltima:String = util.sqlSelect("lotesstock", "codlote", "codlote LIKE 'LS%' ORDER BY codlote DESC");
	if (idUltima) {
		var numUltima:Number = parseFloat(idUltima.right(8));
		id = "LS" + flfacturac.iface.pub_cerosIzquierda((++numUltima).toString(), 8);
	}
		
	return id;
}

function interna_validateForm():Boolean
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	
	if (parseFloat(cursor.valueBuffer("canlote")) < parseFloat(cursor.valueBuffer("canreservada"))) {
		MessageBox.warning(util.translate("scripts", "La capacidad del lote debe ser igual o superior a la cantidad reservada"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	return true;
}

function interna_calculateField(fN:String):String
{
	var cursor:FLSqlCursor = this.cursor();
	res = this.iface.commonCalculateField(fN, cursor);
	return res;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCION /////////////////////////////////////////////////
function prod_init()
{
	this.iface.__init()

	var util:FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	this.iface.tbnCambiarLote = this.child("tbnCambiarLote");
	this.iface.lvwDescomposicion = this.child("lvwDescomposicion");
	this.iface.tbnCalcuNece = this.child("tbnCalcuNece");
	this.iface.tbnEvolStock = this.child("tbnEvolStock");
	this.iface.tbnStock = this.child("tbnStock");
	this.iface.toolButtonMostrarProceso = this.child("toolButtonMostrarProceso");
	this.iface.toolButtonDeleteMS = this.child("toolButtonDeleteMS");
	this.iface.tbnRegularizar = this.child("tbnRegularizar");
	this.iface.tbnFabricacionManual = this.child("tbnFabricacionManual");
	this.iface.tbnLanzarProceso= this.child("tbnLanzarProceso");
	
	if (this.iface.curProceso)
		delete this.iface.curProceso;
	this.iface.curProceso = new FLSqlCursor("pr_procesos");
	this.iface.curProceso.setAction("pr_procesos");
	
	connect(this.iface.tbnCambiarLote, "clicked()", this, "iface.cambiarLote_clicked()");
	connect (this.iface.lvwDescomposicion, "selectionChanged(FLListViewItemInterface)", this, "iface.cambiarSeleccionNodo()");
	connect (this.iface.tbnCalcuNece, "clicked()", this, "iface.mostrarGrafica()");
	connect (this.iface.tbnEvolStock, "clicked()", this, "iface.mostrarTabla()");
	connect (this.iface.toolButtonDeleteMS, "clicked()", this, "iface.borrarRegularizacion()");
	connect (this.iface.tbnRegularizar, "clicked()", this, "iface.regularizar()");
	connect (this.iface.tbnFabricacionManual, "clicked()", this, "iface.fabricacionManual()");
	connect (this.iface.toolButtonMostrarProceso, "clicked()", this, "iface.mostrarProceso()");
	connect (this.iface.tbnLanzarProceso, "clicked()", this, "iface.tbnLanzarProceso_clicked()");
	connect (this.child("tdbProcesos").cursor(), "bufferCommited()", this, "iface.refrescarArbol");
	connect(this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged(campo)");

	switch (cursor.modeAccess()) {
		case cursor.Insert: {
			this.child("fdbEstado").setValue("PTE");
			break;
		}
		case cursor.Edit: {
			this.child("fdbReferencia").setDisabled(true);
			break;
		}
	}
	
	if(cursor.modeAccess() != cursor.Insert)
		this.child("fdbCrearTerminado").setDisabled(true);

	this.iface.lvwDescomposicion.setColumnText(0, util.translate("scripts", "Referencia"));
	this.iface.lvwDescomposicion.addColumn(util.translate("scripts", "Descripción"));
	this.iface.lvwDescomposicion.addColumn(util.translate("scripts", "Lote"));
	this.iface.lvwDescomposicion.addColumn(util.translate("scripts", "Cantidad"));
	this.iface.lvwDescomposicion.addColumn(util.translate("scripts", "Estado"));
	this.iface.lvwDescomposicion.addColumn(util.translate("scripts", "Proceso"));
	this.iface.lvwDescomposicion.addColumn(util.translate("scripts", "En Stock"));
	this.iface.refrescarArbol();

	if (sys.isLoadedModule("flprodppal")) {
		this.iface.tbnFabricacionManual.close();
	}
}

function prod_cambiarLote_clicked()
{
	var util:FLUtil;
	var curTrans:FLSqlCursor = this.cursor();
	curTrans.transaction(false);
		try {
			if (this.iface.cambiarLote()) {
				curTrans.commit();
			} else {
				curTrans.rollback();
			}
		} catch (e) {
			curTrans.rollback();
			MessageBox.critical(util.translate("scripts", "Error al marcar el lote actual como fabricado:") + e, MessageBox.Ok, MessageBox.NoButton);
			return;
		}
}

function prod_cambiarLote():Boolean
{
	var util:FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var esteLote:String = cursor.valueBuffer("codlote")
	if(!esteLote || esteLote == "")
		return false;

	var referencia:String = this.iface.nodoSeleccionado.text(0);
	var tipoStock:String = util.sqlSelect("articulos","tipostock","referencia = '" + referencia + "'");
	if(tipoStock != "Lotes") {
		MessageBox.warning(util.translate("scripts", "El artículo no es por lotes"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	var codLote = this.iface.nodoSeleccionado.text(2);
	if(codLote == esteLote)
		return false;
	
	var cantidad:Number = parseFloat(this.iface.nodoSeleccionado.text(3));
	var idMov:Number = this.iface.nodoSeleccionado.key();
	if(!idMov)
		return false;

	var estadoMov:String = util.sqlSelect("movistock","estado","idmovimiento = " + idMov);
	if(estadoMov == "HECHO") {
		MessageBox.warning(util.translate("scripts", "No se puede cambiar el lote porque el movimiento ya está HECHO"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	var f:Object = new FLFormSearchDB("lotesstock");
	var curLotes:FLSqlCursor = f.cursor();

	if(codLote && codLote != "")
		curLotes.select("codlote <> '" + codLote + "' AND referencia = '" + referencia + "' AND estado = 'TERMINADO' AND candisponible >= " + cantidad);
	else
		curLotes.select("referencia = '" + referencia + "' AND estado = 'TERMINADO' AND candisponible >= " + cantidad);

	curLotes.setModeAccess(curLotes.Edit);
	f.setMainWidget();
	curLotes.refreshBuffer();	
	var loteNuevo:String = f.exec("codlote");
	if (loteNuevo && loteNuevo != "") {
		if(!util.sqlUpdate("movistock","codlote",loteNuevo,"idmovimiento = " + idMov)) {
			MessageBox.warning(util.translate("scripts", "Hubo un error al cambiar el lote."), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
	}	

	this.iface.refrescarArbol();

	return true;
}

function prod_refrescarArbol()
{
	var util:FLUtil;
	var cursor:FLSqlCursor = this.cursor();	

	this.iface.lvwDescomposicion.clear();

	var raiz = new FLListViewItem(this.iface.lvwDescomposicion);
	this.iface.nodoSeleccionado = raiz;
	
	var datosNodo:Array = new Array();
	
	datosNodo = this.iface.calcularDatosNodoRaiz();
	if (!datosNodo)
		return false;

	this.iface.establecerDatosNodo(raiz,datosNodo[0]);

	raiz.setExpandable(false);
	this.iface.pintarNodo(raiz, 1);
	raiz.setOpen(true);
	this.iface.nodoSeleccionado = raiz;

}

function prod_establecerDatosNodo(nodo:FLListViewItem,datos:Array)
{
	var util:FLUtil;
	if (datos["referencia"] && datos["referencia"] != "")
		nodo.setText(0, datos["referencia"]);
		
	if (datos["descripcion"] && datos["descripcion"] != "")
		nodo.setText(1, datos["descripcion"]);
	
	if (datos["lote"] && datos["lote"] != "")
		nodo.setText(2, datos["lote"]);
	
	if (datos["cantidad"] && datos["cantidad"] != "")
		nodo.setText(3, datos["cantidad"]);
	
	if (datos["estado"] && datos["estado"] != "")
		nodo.setText(4, datos["estado"]);
	
	if (datos["proceso"] && datos["proceso"] != "")
		nodo.setText(5, datos["proceso"]);

	if (datos["enstock"] && datos["enstock"] != "")
		nodo.setText(6, datos["enstock"]);
	
	if (datos["imagen"] && datos["imagen"] != "")
		nodo.setPixmap(0, datos["imagen"]);

	if (datos["key"] && datos["key"] != "")
		nodo.setKey(datos["key"]);
}

function prod_pintarNodo(nodo:FLListViewItem)
{
	var util:FLUtil;
	var codLote:String = "";
	var datosNodo:Array = new Array();
	
	if (!nodo)
		return;

	codLote = nodo.text(2);
	var referencia:String = nodo.text(0);
	if (!codLote || codLote == "")
		return;

	if (!referencia || referencia == "")
		return;

	datosNodo = this.iface.calcularDatosNodo(codLote);
	
	if (!datosNodo)
		return false;
	
	nodo.setExpandable(false);

	var primerHijo:Boolean = false;
	for (var i = 0; i < datosNodo.length; i++) {
		if(!primerHijo){
			nodo.setExpandable(true);
			nodo.setOpen(true);
			primerHijo = true;
		}
		var nodoHijo = new FLListViewItem(nodo);
		this.iface.establecerDatosNodo(nodoHijo,datosNodo[i]);
		nodoHijo.setExpandable(false);
		this.iface.nodoSeleccionado = nodoHijo;
		this.iface.pintarNodo(nodoHijo);
	}
	return true;
}

function prod_calcularDatosNodo(codLote:String):Array
{
	var util:FLUtil;
	var datosNodo:Array = new Array;
	var cursor:FLSqlCursor = this.cursor();

	var codFamilia:String;
	var imagen:String = "";
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("movistock");
	q.setSelect("idmovimiento,cantidad,estado,referencia,codlote,idstock,fechaprev,idlineaap,idarticulocomp");
	q.setFrom("movistock");
	
	if (this.iface.nodoSeleccionado.text(2) != codLote)
		q.setWhere("estado <> 'CANCEL' AND codlote = '" + codLote + "'"/* AND (cantidad < 0 OR idlineapp <> 0 OR idlineaap <> 0 OR idlineapp IS NOT NULL OR idlineaap IS NOT NULL)*/);
	else
		q.setWhere("estado <> 'CANCEL' AND codloteprod = '" + codLote + "'"/* AND cantidad < 0"*/);
	
	if (!q.exec())
		return false;

	imagen = "";
	var i:Number = 0;
	var codLote:String;
	var estado:String;
	var idArticuloComp:String;
	while (q.next()) {
		codFamilia = util.sqlSelect("articulos","codfamilia","referencia = '" + q.value("referencia") + "'");
		if (codFamilia && codFamilia != "")
			imagen = util.sqlSelect("familias","imagen","codfamilia = '" + codFamilia + "'");

		datosNodo[i] = new Array;
		datosNodo[i]["key"] = q.value("idmovimiento");
		datosNodo[i]["referencia"] = q.value("referencia");
		datosNodo[i]["descripcion"] = "";
		idArticuloComp = q.value("idarticulocomp");
		if (idArticuloComp && idArticuloComp != "0") {
			var desComponente:String = util.sqlSelect("articuloscomp", "desccomponente", "id = " + idArticuloComp);
			if (desComponente)
				datosNodo[i]["descripcion"] = desComponente;
		}
		datosNodo[i]["lote"] = q.value("codlote");
// 		if (q.value("codlote") == this.cursor().valueBuffer("codlote") && q.value("codlote") && q.value("codlote") != "")
// 			cantidad = parseFloat(this.child("fdbCanLote").value());
// 		else 
// 			cantidad = parseFloat(util.sqlSelect("lotesstock","canlote","codlote = '" + q.value("codlote") + "'"));
		
		//if (!cantidad || cantidad == 0)
			cantidad = parseFloat(q.value("cantidad"));

		if (cantidad < 0)
			cantidad = cantidad * -1;
		datosNodo[i]["cantidad"] = cantidad;
		datosNodo[i]["estado"] = q.value("estado");
		datosNodo[i]["proceso"] = "";
		datosNodo[i]["imagen"] = imagen;
		datosNodo[i]["enstock"] = "";

		codLote = q.value("codlote");
		if (codLote && codLote != "") {
			estado = util.sqlSelect("lotesstock", "estado", "codlote = '" + codLote + "'");

			if (estado && estado != "")
				datosNodo[i]["estado"] = estado;
		}

		var idProceso:Number = this.iface.calcularIdProceso(q.value("codlote"),q.value("referencia"));
		if (idProceso > 0)
			datosNodo[i]["proceso"] = idProceso;

		if (datosNodo[i]["estado"] == "PTE") {
			var hoy:Date = new Date();
			var arrayEvolStock:Array = flfactalma.iface.pub_datosEvolStock(q.value("idstock"),hoy.toString());
			var fechaPrev = q.value("fechaprev");
			if(!fechaPrev || fechaPrev == "")
				fechaPrev = new Date();
			var indice:Number = flfactalma.iface.pub_buscarIndiceAES(fechaPrev, arrayEvolStock);
			if (indice >= 0) {
				if (arrayEvolStock[indice]["NN"] > 0)
					datosNodo[i]["enstock"] = util.translate("scripts", "No");
				else
					datosNodo[i]["enstock"] = util.translate("scripts", "Sí");
			} else {
					datosNodo[i]["enstock"] = util.translate("scripts", "No");
			}
		}
		if (q.value("idlineaap") != 0 && q.value("idlineaap"))
			datosNodo[i]["enstock"] = util.translate("scripts", "Sí");
		i += 1;
	}
	if (i == 0)
		return false;

	return datosNodo;
}

function prod_calcularDatosNodoRaiz()
{
	var util:FLUtil;
	var datosNodo:Array = new Array;
	var cursor:FLSqlCursor = this.cursor();

	var referencia:String = cursor.valueBuffer("referencia");
	var codLote:String = cursor.valueBuffer("codlote");
	var codFamilia:String;
	var imagen:String = "";

	datosNodo[0] = new Array;
	datosNodo[0]["key"] = 0;
	datosNodo[0]["referencia"] = referencia;
	datosNodo[0]["descripcion"] = util.sqlSelect("articulos", "descripcion", "referencia = '" + referencia + "'");
	datosNodo[0]["lote"] = codLote;
	datosNodo[0]["cantidad"] = cursor.valueBuffer("canlote");
	datosNodo[0]["estado"] = cursor.valueBuffer("estado");;
	
	datosNodo[0]["proceso"] = "";
	var idProceso:Number = this.iface.calcularIdProceso(codLote, referencia);
	if (idProceso > 0)
		datosNodo[0]["proceso"] = idProceso;
	
	datosNodo[0]["enstock"] = "";
	
	codFamilia = util.sqlSelect("articulos", "codfamilia", "referencia = '" + referencia + "'");
		if (codFamilia && codFamilia != "")
			imagen = util.sqlSelect("familias","imagen","codfamilia = '" + codFamilia + "'");
	datosNodo[0]["imagen"] = imagen;

	return datosNodo
}

function prod_calcularIdProceso(codLote:String,referencia:String):Number
{
	var util:FLUtil;
	var idTipoProceso:String = util.sqlSelect("articulos","idtipoproceso","referencia = '" + referencia + "'");
	if (!idTipoProceso || idTipoProceso == "")
		return -1;
	var idProceso:Number = util.sqlSelect("pr_procesos","idproceso","idtipoproceso = '" + idTipoProceso + "' AND idobjeto = '" + codLote + "'");
	if(!idProceso)
		return -1;

	return idProceso;
}

function prod_cambiarSeleccionNodo(item:FLListViewItem)
{
	this.iface.nodoSeleccionado = item;
}

function prod_mostrarGrafica()
{
	var util:FLUtil;

	if(!this.iface.nodoSeleccionado) {
		MessageBox.warning(util.translate("scripts", "No hay ningún registro seleccionado"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	
	var idMovimiento:Number = parseFloat(this.iface.nodoSeleccionado.key());
	
	if(!idMovimiento)
		return false;

	var idStock:Number = parseFloat(util.sqlSelect("movistock","idstock","idmovimiento = " + idMovimiento));
	
	if(!idStock)
		return false;

	flfactalma.iface.pub_graficoStock(idStock, false);
}

function prod_mostrarTabla()
{
	var util:FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	if(!this.iface.nodoSeleccionado) {
		MessageBox.warning(util.translate("scripts", "No hay ningún registro seleccionado"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	var referencia:Number = this.iface.nodoSeleccionado.text(0);
	if (!referencia || referencia == "")
		return false;

	var idMovimiento:Number = parseFloat(this.iface.nodoSeleccionado.key());
	if(!idMovimiento)
		return false;

	var idStock:Number = parseFloat(util.sqlSelect("movistock","idstock","idmovimiento = " + idMovimiento));
	
	if(!idStock)
		return false;

	var codAlmacen:String = util.sqlSelect("stocks","codalmacen","idstock = " + idStock);
	if (!codAlmacen || codAlmacen == "")
		return;
	
	var f:Object = new FLFormSearchDB("calcunecesidades");
	var curCN:FLSqlCursor = f.cursor();

	curCN.select("idusuario = '" + sys.nameUser() + "'");
	if (!curCN.first())
		curCN.setModeAccess(curCN.Insert);
	else
		curCN.setModeAccess(curCN.Edit);

	f.setMainWidget();
	curCN.refreshBuffer();
	curCN.setValueBuffer("referencia", referencia);
	curCN.setValueBuffer("codalmacen", codAlmacen);

	var acpt:String = f.exec("id");
	if (acpt) {
		curCN.commitBuffer();
	}
	f.close();
}

function prod_mostrarProceso()
{
	var util:FLUtil;

	if(!this.iface.nodoSeleccionado) {
		MessageBox.information(util.translate("scripts", "No hay ningún registro seleccionado"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	
	var idProceso:Number = parseFloat(this.iface.nodoSeleccionado.text(5));

	if (!idProceso || idProceso == 0) {
		MessageBox.information(util.translate("scripts", "El lote seleccionado no está asociado a ningún proceso de producción"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	this.iface.curProceso.select("idproceso = " + idProceso);
	if (!this.iface.curProceso.first())
		return;

	this.iface.curProceso.browseRecord();
}

function prod_mostrarStock()
{
	var util:FLUtil;

	if (!this.iface.nodoSeleccionado) {
		MessageBox.information(util.translate("scripts", "No hay ningún registro seleccionado"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	
	var referencia:String = this.iface.nodoSeleccionado.text(0);
	var codAlmacen:String = flfactalma.iface.pub_almacenFabricacion();

	var curStock:FLSqlCursor = new FLSqlCursor("stocks");
	curStock.select("referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "'");
	if (!curStock.first())
		return;

	curStock.browseRecord();
}

function prod_bufferChanged(campo:String)
{
	switch (campo) {
		case "canlote":{
			this.iface.refrescarArbol();
		}
		break;
		default:
	}
}

function prod_borrarRegularizacion()
{
	var util:FLUtil = new FLUtil;
	
	var curMS:FLSqlCursor = this.child("tdbMoviStock").cursor();
	if (!curMS.valueBuffer("regularizacion")) {
		MessageBox.warning(util.translate("scripts", "Sólo puede borrar movimientos de regularización"), MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	var res:Number = MessageBox.warning(util.translate("scripts", "Va a borrar el movimiento de regularización seleccionado. ¿Está seguro?"), MessageBox.Yes, MessageBox.No);
	if (res != MessageBox.Yes)
		return;

	if (!util.sqlDelete("movistock", "idmovimiento = " + curMS.valueBuffer("idmovimiento")))
		return false;

	this.child("tdbMoviStock").refresh();
	this.iface.refrescarTotales();
}

function prod_regularizar()
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();
	var hoy:Date = new Date();

	var f:Object = new FLFormSearchDB("reglotestock");
	var curRegLS:FLSqlCursor = f.cursor();

	var actual:Number = parseFloat(cursor.valueBuffer("cantotal")) - parseFloat(cursor.valueBuffer("canusada"));
	var codAlmacen:String = flfactalma.iface.pub_almacenFabricacion();
	var idStock:String = util.sqlSelect("stocks", "idstock", "referencia = '" + cursor.valueBuffer("referencia") + "' AND codalmacen = '" + codAlmacen + "'");

	curRegLS.select("idusuario = '" + sys.nameUser() + "'");
	if (curRegLS.first()) {
		curRegLS.setModeAccess(curRegLS.Edit);
		curRegLS.refreshBuffer();
	} else {
		curRegLS.setModeAccess(curRegLS.Insert);
		curRegLS.refreshBuffer();
		curRegLS.setValueBuffer("idusuario", sys.nameUser());
	}
	curRegLS.setValueBuffer("actual", actual);
	curRegLS.setValueBuffer("movimiento", 0);
	curRegLS.setValueBuffer("nueva", actual);
	curRegLS.setValueBuffer("fecha", hoy);

	f.setMainWidget();
	var id:String = f.exec("id");

	if (id) {
		var curMS:FLSqlCursor = new FLSqlCursor("movistock");
		curMS.setModeAccess(curMS.Insert);
		curMS.refreshBuffer();
		curMS.setValueBuffer("referencia", cursor.valueBuffer("referencia"));
		curMS.setValueBuffer("estado", "HECHO");
		curMS.setValueBuffer("cantidad", curRegLS.valueBuffer("movimiento"));
		curMS.setValueBuffer("fechareal", curRegLS.valueBuffer("fecha"));
		curMS.setValueBuffer("horareal", curRegLS.valueBuffer("fecha"));
		curMS.setValueBuffer("idstock", idStock);
		curMS.setValueBuffer("codlote", cursor.valueBuffer("codlote"));
		curMS.setValueBuffer("regularizacion", true);
		if (!curMS.commitBuffer())
			return false;

		this.child("tdbMoviStock").refresh();
		this.iface.refrescarTotales();
	}
}

function prod_commonCalculateField(fN:String, cursor:FLSqlCursor):String
{
	var util:FLUtil = new FLUtil();
	var res:String;
	var codLote:String = cursor.valueBuffer("codlote");

	switch (fN) {
		case "cantotal": {
			res = parseFloat(util.sqlSelect("movistock", "SUM(cantidad)", "codlote = '" + codLote + "' AND cantidad > 0 AND estado = 'HECHO'"));
			if (!res || isNaN(res))
				res = 0;
				break;
			break;
		}
		case "canusada": {
			res = parseFloat(util.sqlSelect("movistock", "SUM(cantidad)", "codlote = '" + codLote + "' AND estado = 'HECHO' AND cantidad < 0"));
			if (!res || isNaN(res))
				res = 0;
			res = res * -1;
			break;
		}
		case "canreservada": {
			res = parseFloat(util.sqlSelect("movistock", "SUM(cantidad)", "codlote = '" + codLote + "' AND estado = 'PTE' AND cantidad < 0"));
			if (!res || isNaN(res))
				res = 0;
			res = res * -1;
			break;
		}
		case "candisponible": {
			res = parseFloat(cursor.valueBuffer("cantotal")) - parseFloat(cursor.valueBuffer("canusada")) - parseFloat(cursor.valueBuffer("canreservada"));
			if (!res || isNaN(res))
				res = 0;
			break;
		}
		case "estado": {
			if (parseFloat(cursor.valueBuffer("cantotal")) >= parseFloat(cursor.valueBuffer("canlote")))
				res = "TERMINADO";
			else
				res = "PTE";
			break;
		}
	}
	return res;
}

function prod_refrescarTotales()
{
	this.child("fdbCanTotal").setValue(this.iface.calculateField("cantotal"));
	this.child("fdbCanUsada").setValue(this.iface.calculateField("canusada"));
	this.child("fdbCanReservada").setValue(this.iface.calculateField("canreservada"));
	this.child("fdbCanDisponible").setValue(this.iface.calculateField("candisponible"));
	this.child("fdbEstado").setValue(this.iface.calculateField("estado"));
}

function prod_fabricacionManual()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var estado:String = cursor.valueBuffer("estado");
	var codLote:String = cursor.valueBuffer("codlote");
	var curTrans:FLSqlCursor = new FLSqlCursor("empresa");
	
	if (estado == "PTE") {
		var codLoteComponente:String = util.sqlSelect("movistock", "codlote", "codloteprod = '" + codLote + "' AND (codlote <> '' OR codlote IS NOT NULL)");
		if (codLoteComponente && codLoteComponente != "") {
			MessageBox.warning(util.translate("scripts", "No puede marcar el lote actual como fabricado.\nEl lote %1, del cual depende, no está fabricado").arg(codLoteComponente), MessageBox.Ok, MessageBox.NoButton);
			return;
		}
		var res:Number = MessageBox.information(util.translate("scripts", "Va a marcar el lote actual como fabricado. ¿Está seguro?"), MessageBox.Yes, MessageBox.No);
		if (res != MessageBox.Yes)
			return;
		curTrans.transaction(false);
		try {
			if (this.iface.marcarFabricado(codLote)) {
				curTrans.commit();
				this.child("fdbEstado").setValue("TERMINADO");
				this.iface.refrescarArbol();
			} else {
				curTrans.rollback();
			}
		} catch (e) {
			curTrans.rollback();
			MessageBox.critical(util.translate("scripts", "Error al marcar el lote actual como fabricado:") + e, MessageBox.Ok, MessageBox.NoButton);
			return;
		}
	} else if (estado == "TERMINADO"){
		var res:Number = MessageBox.information(util.translate("scripts", "Va a desmarcar el lote fabricado actual para ponerlo PTE. ¿Está seguro?"), MessageBox.Yes, MessageBox.No);
		if (res != MessageBox.Yes)
			return;
		curTrans.transaction(false);
		try {
			if (this.iface.desmarcarFabricado(codLote)) {
				curTrans.commit();
				this.child("fdbEstado").setValue("PTE");
				this.iface.refrescarArbol();
			} else {
				curTrans.rollback();
			}
		} catch (e) {
			curTrans.rollback();
			MessageBox.critical(util.translate("scripts", "Error al marcar el lote actual como fabricado:") + e, MessageBox.Ok, MessageBox.NoButton);
			return;
		}
	}
}

function prod_marcarFabricado(codLote:String):Boolean
{
	var util:FLUtil = new FLUtil;
	var hoy:Date = new Date;
	var ahora:String = hoy.toString().right(8);
	if (!util.sqlUpdate("movistock", "estado,fechareal,horareal", "HECHO," + hoy.toString() + "," + ahora, "codloteprod = '" + codLote + "'"))
		return false;

	return true;
}

function prod_desmarcarFabricado(codLote:String):Boolean
{
	var util:FLUtil = new FLUtil;
	var hoy:Date = new Date;
	var ahora:String = hoy.toString().right(8);
	if (!util.sqlUpdate("movistock", "estado,fechareal,horareal", "PTE,NULL,NULL", "codloteprod = '" + codLote + "'"))
		return false;

	return true;
}

/** \D El parámetro cursor se usa en las funcionalidades que sobrecargan producción
\end */
function prod_calculateCounter(curLS:FLSqlCursor):String
{
	var util:FLUtil = new FLUtil();
	var prefijo = "LS";
	var ultimoLote:Number = util.sqlSelect("secuenciaslotes","valor","prefijo = '" + prefijo + "'");

	if(!ultimoLote) {
		var idUltimo:String = util.sqlSelect("lotesstock", "codlote", "codlote LIKE '" + prefijo + "%' ORDER BY codlote DESC");

		if (idUltimo)
			ultimoLote = parseFloat(idUltimo.right(8));
		else
			ultimoLote = 0;

		ultimoLote += 1;
		util.sqlInsert("secuenciaslotes","prefijo,valor",prefijo + "," + ultimoLote)
	}
	else {
		ultimoLote += 1;
		util.sqlUpdate("secuenciaslotes","valor",ultimoLote,"prefijo = '" + prefijo + "'");
	}

	var id:String = prefijo + flfacturac.iface.pub_cerosIzquierda((ultimoLote).toString(), 8);

	return id;
}

function prod_tbnLanzarProceso_clicked()
{
	/// XXXXXXXXXXXXXXXXXXXXXXXXXXxx
/** Buscar los procesos de modificación, 
Crear el proceso en estado OFF
Modificar búsqueda en orden de producción
*/
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();
	
	var f:Object = new FLFormSearchDB("articulos");
	var curArticulos:FLSqlCursor = f.cursor();
	
	var codLote:String = cursor.valueBuffer("codlote");
	var referencia:String = cursor.valueBuffer("referencia");
	curArticulos.setMainFilter("referencia IN (SELECT refproceso FROM articulosaplicables WHERE refaplicable = '" + referencia + "')");

	f.setMainWidget();
	var refProceso:String = f.exec("referencia");
	if (!refProceso) {
		return false;
	}
	if (!flcolaproc.iface.pub_crearProcesoProd(refProceso, codLote)) {
		MessageBox.warning(util.translate("scripts", "Error al crear el proceso asociado a %1 para el lote %2").arg(refProceso).arg(codLote));
		return false;
	}
	this.child("tdbProcesos").refresh();
}
//// PRODUCCION /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
