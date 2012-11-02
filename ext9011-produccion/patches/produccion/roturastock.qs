/***************************************************************************
                 roturastock.qs  -  description
                             -------------------
    begin                : lun jun 18 2007
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
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var INCLUIR:Number = 0;
	var NUMPEDIDO:Number = 1;
	var CODPROVEEDOR:Number = 2;
	var NOMPROVEEDOR:Number = 3;
	var REFERENCIA:Number = 4;
	var DESARTICULO:Number = 5;
	var FECHAPEDIDO:Number = 6;
	var PLAZO:Number = 7;
	var FECHAROTURA:Number = 8;
	var STOCKACTUAL:Number = 9;
	var STOCKMIN:Number = 10;
	var STOCKMAX:Number = 11;
	var PEDIR:Number = 12;
	var IDSTOCK:Number = 13;

	var estado:String;
	var currentRow_:Number;
	var totalDatosES:Array;
    function oficial( context ) { interna( context ); } 
	function tblArticulos_currentChanged(row:Number, col:Number) {
		return this.ctx.oficial_tblArticulos_currentChanged(row, col);
	}
	function pbnAddDel_clicked() {
		return this.ctx.oficial_pbnAddDel_clicked();
	}
	function incluirFila(fila:Number, col:Number) {
		return this.ctx.oficial_incluirFila(fila, col);
	}
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function gestionEstado() {
		return this.ctx.oficial_gestionEstado();
	}
	function actualizar() {
		return this.ctx.oficial_actualizar();
	}
	function generarListaArticulos():Boolean {
		return this.ctx.oficial_generarListaArticulos();
	}
	function construirWhere():String {
		return this.ctx.oficial_construirWhere();
	}
	function construirWherePedidoCli():String {
		return this.ctx.oficial_construirWherePedidoCli();
	}
	function listaRefPedido(qryMov:FLSqlQuery):String {
		return this.ctx.oficial_listaRefPedido(qryMov);
	}
	function tbnEvolStock_clicked() {
		return this.ctx.oficial_tbnEvolStock_clicked();
	}
	function initDatosLinea():Array {
		return this.ctx.oficial_initDatosLinea();
	}
	function calculoNecesidades() {
		return this.ctx.oficial_calculoNecesidades();
	}
	function hayRoturaStock(datosLinea:Array):Array {
		return this.ctx.oficial_hayRoturaStock(datosLinea);
	}
	function agruparPedidos():Boolean {
		return this.ctx.oficial_agruparPedidos();
	}
	function cambiarFechas(fechaPedido:String, fechaRotura:String, filaDesde:Number, filaHasta:Number, numPedido:Number):Boolean {
		return this.ctx.oficial_cambiarFechas(fechaPedido, fechaRotura, filaDesde, filaHasta, numPedido);
	}
	function datosEvolStockActual():Array {
		return this.ctx.oficial_datosEvolStockActual();
	}
	function numerarPedidosFecha():Boolean {
		return this.ctx.oficial_numerarPedidosFecha();
	}
	function numerarPedidosArticulo():Boolean {
		return this.ctx.oficial_numerarPedidosArticulo();
	}
	function consultaBusqueda():FLSqlQuery {
		return this.ctx.oficial_consultaBusqueda();
	}
	function iniciarTabla() {
		return this.ctx.oficial_iniciarTabla();
	}
	function incluirDatosExtraFila(fila:Number, qryDatos:FLSqlQuery) {
		return this.ctx.oficial_incluirDatosExtraFila(fila, qryDatos);
	}
	function tbnStock_clicked() {
		return this.ctx.oficial_tbnStock_clicked();
	}
	function mensajeTiempoSuficiente() {
		return this.ctx.oficial_mensajeTiempoSuficiente();
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
	function pub_datosEvolStockActual():Array {
		return this.datosEvolStockActual();
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
Este formulario agrupa distintos pedidos del mismo proveedor un único albarán. Es posible especificar los criterios que deben cumplir los pedidos a incluir. De la lista de pedidos que cumplen los criterios de búsqueda se generará un albarán por proveedor (ej. si los pedidos corresponden a dos proveedores se generarán dos albaranes).
\end */
function interna_init()
{
	this.iface.estado = "Buscando";
	this.iface.gestionEstado();
	var tblArticulos:QTable = this.child("tblArticulos");
	var cursor:FLSqlCursor = this.cursor();

	connect(this.child("pbnRefresh"), "clicked()", this, "iface.actualizar");
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(tblArticulos, "doubleClicked(int, int)", this, "iface.incluirFila");
	connect(tblArticulos, "currentChanged(int, int)", this, "iface.tblArticulos_currentChanged");
	connect(this.child("pushButtonAccept"), "clicked()", this, "iface.generarListaArticulos");
	connect(this.child("tbnEvolStock"), "clicked()", this, "iface.tbnEvolStock_clicked");
	connect(this.child("tbnStock"), "clicked()", this, "iface.tbnStock_clicked");
	connect(this.child("tbnCalcuNece"), "clicked()", this, "iface.calculoNecesidades");
	connect(this.child("pbnAddDel"), "clicked()", this, "iface.pbnAddDel_clicked");

	this.child("fdbCodAlmacen").setValue(flfactppal.iface.pub_valorDefectoEmpresa("codalmacen"));
	this.child("fdbCodEjercicio").setValue(flfactppal.iface.pub_ejercicioActual());
	this.child("fdbCodSerie").setValue(flfactppal.iface.pub_valorDefectoEmpresa("codserie"));
	this.child("fdbCodDivisa").setValue(flfactppal.iface.pub_valorDefectoEmpresa("coddivisa"));
	this.child("fdbCodEjercicio").setDisabled(true);

	var util:FLUtil = new FLUtil();
	var hoy:Date = new Date();
	this.child("fdbFecha").setValue(hoy);
	
	this.iface.iniciarTabla()
	cursor.setValueBuffer("lista", "");

	if (!cursor.isNull("idpedidocli")) {
		this.child("lblPedidoCli").text = util.translate("scripts", "Pedido %1").arg(util.sqlSelect("pedidoscli", "codigo", "idpedido = " + cursor.valueBuffer("idpedidocli")));
		this.child("fdbCodProveedor").setValue("");
		this.child("fdbReferencia").setValue("");
		this.child("fdbCodProveedor").setDisabled(true);
		this.child("fdbReferencia").setDisabled(true);
		this.iface.actualizar();
	}

	if (cursor.isNull("codpago") || cursor.valueBuffer("codpago") == "") {
		this.child("fdbCodPago").setValue(flfactppal.iface.pub_valorDefectoEmpresa("codpago"));
	}
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_iniciarTabla()
{
	var tblArticulos:QTable = this.child("tblArticulos");

	tblArticulos.setNumCols(14);
	tblArticulos.setColumnWidth(this.iface.INCLUIR, 50);
	tblArticulos.setColumnWidth(this.iface.NUMPEDIDO, 40);
	tblArticulos.setColumnWidth(this.iface.CODPROVEEDOR, 60);
	tblArticulos.setColumnWidth(this.iface.NOMPROVEEDOR, 120);
	tblArticulos.setColumnWidth(this.iface.REFERENCIA, 80);
	tblArticulos.setColumnWidth(this.iface.DESARTICULO, 100);
	tblArticulos.setColumnWidth(this.iface.FECHAROTURA, 80);
	tblArticulos.setColumnWidth(this.iface.PLAZO, 50);
	tblArticulos.setColumnWidth(this.iface.FECHAPEDIDO, 80);
	tblArticulos.setColumnWidth(this.iface.STOCKACTUAL, 50);
	tblArticulos.setColumnWidth(this.iface.STOCKMIN, 50);
	tblArticulos.setColumnWidth(this.iface.STOCKMAX, 50);
	tblArticulos.setColumnWidth(this.iface.PEDIR, 50);
	tblArticulos.hideColumn(this.iface.IDSTOCK);
	tblArticulos.hideColumn(this.iface.CODPROVEEDOR);

	tblArticulos.setColumnLabels("/", "Incluir/Nº/C.P./Proveedor/Ref./Artículo/F.Pedido/Plazo/F.Rotura/Actual/Mínimo/Máximo/Pedir/idStock");
}

function oficial_tblArticulos_currentChanged(row:Number, col:Number)
{
	this.iface.currentRow_ = row;
}

function oficial_pbnAddDel_clicked()
{
	this.iface.incluirFila(this.iface.currentRow_, this.iface.INCLUIR);
}

function oficial_incluirFila(fila:Number, col:Number)
{
	if (col != this.iface.INCLUIR)
		return;

	var tblArticulos:QTable = this.child("tblArticulos");
	if (tblArticulos.numRows() == 0)
		return;
	if (tblArticulos.text(fila, this.iface.INCLUIR) == "Sí") {
		tblArticulos.setText(fila, this.iface.INCLUIR, "No");
	} else {
		tblArticulos.setText(fila, this.iface.INCLUIR, "Sí");
	}
}

function oficial_bufferChanged(fN:String)
{
	switch (fN) {
	/** \C
	La modificación de alguno de los criterios de búsqueda habilita el botón 'Actualizar', de forma que puede realizarse una búsqueda de acuerdo a los nuevos criterios utilizados.
	\end */
	case "codproveedor":
	case "referencia":
	case "codalmacen":
	case "agrupar": {
			if (this.iface.estado == "Seleccionando") {
				this.iface.estado = "Buscando";
				this.iface.gestionEstado();
			}
			break;
		}
	}
}

/** \D
El estado 'Buscando' define la situación en la que el usuario está especificando los criterios de búsqueda.
El estado 'Seleccionando' define la situación en la que el usuario ya ha buscado y puede generar la factura o facturas
\end */
function oficial_gestionEstado()
{
	switch (this.iface.estado) {
	case "Buscando":{
		this.child("pbnRefresh").enabled = true;
		this.child("pushButtonAccept").enabled = false;
		break;
	}
	case "Seleccionando":{
			this.child("pbnRefresh").enabled = false;
			this.child("pushButtonAccept").enabled = true;
			break;
		}
	}
}

/** \D
Actualiza la lista de pedidos en función de los criterios de búsqueda especificados
\end */
function oficial_actualizar()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	
	if (this.iface.totalDatosES)
		delete this.iface.totalDatosES;
	this.iface.totalDatosES = [];

	var tblArticulos:QTable = this.child("tblArticulos");
	var fila:Number;
	var hoy:Date = new Date;
	var numFilas:Number = tblArticulos.numRows();

	for (fila = numFilas - 1; fila >= 0; fila--)
		tblArticulos.removeRow(fila);

	var referencia:String;
	var incluir:String;
	var datosRotura:Array;
	var fechaPedido:String;
	var fechaRotura:String;
	var codAlmacen:String = cursor.valueBuffer("codalmacen");
	var nomProveedor:String;
	var plazo:Number;
	var stockMinimo:Number;
	var cantidad:Number;
	var idStock:String;

	var qryArticulos:FLSqlQuery = this.iface.consultaBusqueda()
	if (!qryArticulos)
		return false;

	util.createProgressDialog( util.translate( "scripts", "Buscando artículos..." ), qryArticulos.size());
	util.setProgress(0);
	var i:Number = 1;
	fila = 0;
	var avisar:Boolean = true;
	while (qryArticulos.next()) {
		util.setProgress(i);
		i++;
		referencia = qryArticulos.value("a.referencia");
		nomProveedor = qryArticulos.value("p.nombre");

		plazo = qryArticulos.value("ap.plazo");
		if (!plazo || isNaN(plazo))
			plazo = 0;
		
		stockMinimo = qryArticulos.value("a.stockmin");
		if (!stockMinimo || isNaN(stockMinimo))
			stockMinimo = 0;

		stockMaximo = qryArticulos.value("a.stockmax");
		if (!stockMaximo || isNaN(stockMaximo))
			stockMaximo = 0;

		idStock = qryArticulos.value("s.idstock");
		this.iface.totalDatosES[fila] = flfactalma.iface.pub_datosEvolStock(idStock, hoy.toString(), avisar);

	
		if (!this.iface.totalDatosES[fila]) {
			util.destroyProgressDialog();
			return false;
		}

		if(!this.iface.totalDatosES[fila]["avisar"])
			avisar = false;

		this.iface.totalDatosES[fila] = flfactalma.iface.pub_planificarPedStock(this.iface.totalDatosES[fila], plazo)
		if (!this.iface.totalDatosES[fila]) {
			util.destroyProgressDialog();
			return false;
		}

		var idRotura:Number = -1;
		var idPedido:Number = -1;
		for (var i:Number = 0; i < this.iface.totalDatosES[fila].length; i++) {
			if (this.iface.totalDatosES[fila][i]["RPP"] > 0)
				idRotura = i;
			if (this.iface.totalDatosES[fila][i]["LPP"] > 0)
				idPedido = i;
		}
		if (idRotura == -1 && cursor.isNull("idpedidocli"))
			continue;

		if (idRotura > -1) {
			incluir = util.translate("scripts", "Sí");
			cantidad = this.iface.totalDatosES[fila][idRotura]["RPP"];
			fechaRotura = this.iface.totalDatosES[fila][idRotura]["fecha"];
			fechaPedido = this.iface.totalDatosES[fila][idPedido]["fecha"];
		} else {
			incluir = util.translate("scripts", "No");
			cantidad = 0;
			fechaRotura = "";
			fechaPedido = "";
		}

		cantidad = util.roundFieldValue(cantidad,"lineaspedidosprov","cantidad");
		var valorCero:Number = 0;
		valorCero = util.roundFieldValue(valorCero,"lineaspedidosprov","cantidad");
		if(cantidad <= valorCero)
			incluir = util.translate("scripts", "No");

		if (cursor.valueBuffer("agrupar") != "Proveedor (Usar fecha mínima)") {
			var datosArticulo:Array = flfactalma.iface.pub_datosArticuloStock(idStock);
			if (fechaRotura && fechaPedido && util.daysTo(fechaPedido, fechaRotura) < plazo) {
				if(nomProveedor)
					this.iface.mensajeTiempoSuficiente(datosArticulo["nombre"],nomProveedor,util.dateAMDtoDMA(fechaRotura));
			}
		}
		
		tblArticulos.insertRows(fila);
		tblArticulos.setText(fila, this.iface.INCLUIR, incluir);
		tblArticulos.setText(fila, this.iface.CODPROVEEDOR, qryArticulos.value("ap.codproveedor"));
		tblArticulos.setText(fila, this.iface.NOMPROVEEDOR, nomProveedor);
		tblArticulos.setText(fila, this.iface.REFERENCIA, referencia);
		tblArticulos.setText(fila, this.iface.DESARTICULO, qryArticulos.value("a.descripcion"));
		tblArticulos.setText(fila, this.iface.FECHAROTURA, util.dateAMDtoDMA(fechaRotura));
		tblArticulos.setText(fila, this.iface.PLAZO, plazo);
		tblArticulos.setText(fila, this.iface.FECHAPEDIDO, util.dateAMDtoDMA(fechaPedido));
		tblArticulos.setText(fila, this.iface.STOCKACTUAL, qryArticulos.value("s.cantidad"));
		tblArticulos.setText(fila, this.iface.STOCKMIN, stockMinimo);
		tblArticulos.setText(fila, this.iface.STOCKMAX, stockMaximo);
		tblArticulos.setText(fila, this.iface.PEDIR, cantidad);
		tblArticulos.setText(fila, this.iface.IDSTOCK, idStock);
		this.iface.incluirDatosExtraFila(fila, qryArticulos);
		fila++;
	}

	util.setProgress(qryArticulos.size());
	util.destroyProgressDialog();

	if (cursor.valueBuffer("agrupar") == "Proveedor (Usar fecha mínima)") {
		if (!this.iface.agruparPedidos()) {
			MessageBox.warning(util.translate("scripts", "Hubo un error al agrupar los pedidos por las fechas mínimas de pedido y rotura"), MessageBox.Ok, MessageBox.NoButton);
		}
	} else if (cursor.valueBuffer("agrupar") == "Proveedor y F.Pedido/F.Rotura") {
		if (!this.iface.numerarPedidosFecha()) {
			MessageBox.warning(util.translate("scripts", "Hubo un error al asignar número a los pedidos"), MessageBox.Ok, MessageBox.NoButton);
		}
	} else {
		if (!this.iface.numerarPedidosArticulo()) {
			MessageBox.warning(util.translate("scripts", "Hubo un error al asignar número a los pedidos"), MessageBox.Ok, MessageBox.NoButton);
		}
	}

	this.iface.estado = "Seleccionando";
	this.iface.gestionEstado();

	if (tblArticulos.numRows() == 0)
		this.child("pushButtonAccept").enabled = false;
}

function oficial_incluirDatosExtraFila(fila:Numberm, qryArticulos:FLSqlQuery)
{
	return true;
}

function oficial_consultaBusqueda():FLSqlQuery
{
	var cursor:FLSqlCursor = this.cursor();
	var miWhere:String;

	if (cursor.isNull("idpedidocli"))
		miWhere = this.iface.construirWhere();
	else
		miWhere = this.iface.construirWherePedidoCli();

	if (!miWhere)
		return false;

	var qryArticulos = new FLSqlQuery;
	with (qryArticulos) {
		setTablesList("articulos,articulosprov,stocks,proveedores");
		setSelect("ap.codproveedor, p.nombre, a.referencia, a.descripcion, a.stockmin, a.stockmax, ap.plazo, s.cantidad, s.idstock");
		setFrom("articulos a LEFT OUTER JOIN articulosprov ap ON a.referencia = ap.referencia INNER JOIN proveedores p ON ap.codproveedor = p.codproveedor LEFT OUTER JOIN stocks s ON a.referencia = s.referencia");
		setWhere(miWhere);
		setForwardOnly(true);
	}
debug(qryArticulos.sql());
	if (!qryArticulos.exec())
		return false;

	return qryArticulos;
}

function oficial_numerarPedidosFecha():Boolean
{
	var tblArticulos:QTable = this.child("tblArticulos");
	var totalFilas:Number = tblArticulos.numRows();
	var numPedido:Number = 1;
	for (var fila:Number = 0; fila < totalFilas; fila++) {
		if (tblArticulos.text(fila, this.iface.NUMPEDIDO) != "")
			continue;
		tblArticulos.setText(fila, this.iface.NUMPEDIDO, numPedido);
		for (var f2:Number = fila + 1; f2 < totalFilas; f2++) {
			if (tblArticulos.text(fila, this.iface.CODPROVEEDOR) == tblArticulos.text(f2, this.iface.CODPROVEEDOR) && tblArticulos.text(fila, this.iface.FECHAPEDIDO) == tblArticulos.text(f2, this.iface.FECHAPEDIDO) && tblArticulos.text(fila, this.iface.FECHAROTURA) == tblArticulos.text(f2, this.iface.FECHAROTURA)) {
				tblArticulos.setText(f2, this.iface.NUMPEDIDO, numPedido);
			}
		}
		numPedido++;
	}
	return true;
}

function oficial_numerarPedidosArticulo():Boolean
{
	var tblArticulos:QTable = this.child("tblArticulos");
	var totalFilas:Number = tblArticulos.numRows();
	var numPedido:Number = 1;
	for (var fila:Number = 0; fila < totalFilas; fila++) {
		tblArticulos.setText(fila, this.iface.NUMPEDIDO, numPedido);
		numPedido++;
	}
	return true;
}

function oficial_agruparPedidos():Boolean
{
	var util:FLUtil = new FLUtil;
	var codProveedor:String;
	var codProveedorPrevio:String;
	var filaInicioP:Number;
	var fechaPedidoMin:String;
	var fechaRoturaMin:String;
	var fechaPedido:String;
	var fechaRotura:String;
	var numPedido:Number = 0;

	var tblArticulos:QTable = this.child("tblArticulos");
	var totalFilas:Number = tblArticulos.numRows();
	
	for (var fila:Number = 0; fila < totalFilas; fila++) {
		codProveedor = tblArticulos.text(fila, this.iface.CODPROVEEDOR);
		if (codProveedor != codProveedorPrevio) {
			if (codProveedorPrevio) {
				if (!this.iface.cambiarFechas(fechaPedidoMin, fechaRoturaMin, filaInicioP, fila - 1, numPedido))
					return false;
			}
			filaInicioP = fila;
			codProveedorPrevio = codProveedor;
			fechaPedidoMin = false;
			fechaRoturaMin = false;
			numPedido++;
		}
		fechaPedido = util.dateDMAtoAMD(tblArticulos.text(fila, this.iface.FECHAPEDIDO));
		fechaRotura = util.dateDMAtoAMD(tblArticulos.text(fila, this.iface.FECHAROTURA));
		if (!fechaPedidoMin || util.daysTo(fechaPedido, fechaPedidoMin) > 0)
			fechaPedidoMin = fechaPedido;
		if (!fechaRoturaMin || util.daysTo(fechaRotura, fechaRoturaMin) > 0)
			fechaRoturaMin = fechaRotura;
	}
	if (!this.iface.cambiarFechas(fechaPedidoMin, fechaRoturaMin, filaInicioP, totalFilas - 1, numPedido))
		return false;

	return true;
}

/** \D Cambia las fechas de pedido y rotura desde una fila hasta otra
@param	fechaPedido: Nueva fecha de pedido
@param	fechaRotura: Nueva fecha de rotura
@param	filaDesde: Fila de inicio en la tabla
@param	filaHasta: Fila de fin en la tabla
\end */
function oficial_cambiarFechas(fechaPedido:String, fechaRotura:String, filaDesde:Number, filaHasta:Number,  numPedido:Number):Boolean
{
	var util:FLUtil = new FLUtil;
	var tblArticulos:QTable = this.child("tblArticulos");
	
	var fechaPedPrevia:String;
	var fechaRotPrevia:String;
	var indice:Number;
	var cantidad:Number;

	for (var filaPP:Number = filaDesde; filaPP <= filaHasta; filaPP++) {
		if (tblArticulos.text(filaPP, this.iface.INCLUIR) == "No")
			continue;
		fechaPedPrevia = util.dateDMAtoAMD(tblArticulos.text(filaPP, this.iface.FECHAPEDIDO));
		indice = flfactalma.iface.pub_buscarIndiceAES(fechaPedPrevia, this.iface.totalDatosES[filaPP]);
		if (indice < 0)
			return false;
		cantidad = this.iface.totalDatosES[filaPP][indice]["LPP"];
		this.iface.totalDatosES[filaPP][indice]["LPP"] = 0;

		indice = flfactalma.iface.pub_buscarIndiceAES(fechaPedido, this.iface.totalDatosES[filaPP]);
		if (indice < 0)
			return false;
		this.iface.totalDatosES[filaPP][indice]["LPP"] = cantidad;
		tblArticulos.setText(filaPP, this.iface.FECHAPEDIDO, util.dateAMDtoDMA(fechaPedido));
		
		fechaRotPrevia = util.dateDMAtoAMD(tblArticulos.text(filaPP, this.iface.FECHAROTURA));
		indice = flfactalma.iface.pub_buscarIndiceAES(fechaRotPrevia, this.iface.totalDatosES[filaPP]);
		if (indice < 0)
			return false;
		cantidad = this.iface.totalDatosES[filaPP][indice]["RPP"];
		this.iface.totalDatosES[filaPP][indice]["RPP"] = 0;

		indice = flfactalma.iface.pub_buscarIndiceAES(fechaRotura, this.iface.totalDatosES[filaPP]);
		if (indice < 0)
			return false;
		this.iface.totalDatosES[filaPP][indice]["RPP"] = cantidad;
		tblArticulos.setText(filaPP, this.iface.FECHAROTURA, util.dateAMDtoDMA(fechaRotura));

		plazo = tblArticulos.text(filaPP, this.iface.PLAZO)
		if (util.daysTo(fechaPedido, fechaRotura) < plazo) {
			this.iface.mensajeTiempoSuficiente("Referencia " + tblArticulos.text(filaPP, this.iface.REFERENCIA),tblArticulos.text(filaPP, this.iface.NOMPROVEEDOR),util.dateAMDtoDMA(fechaRotura));
		}

		tblArticulos.setText(filaPP, this.iface.NUMPEDIDO, numPedido);
	}
	return true;
}

function oficial_construirWhere():String
{
	var util:FLUtil;

	var cursor:FLSqlCursor = this.cursor();

	var where:String = "ap.pordefecto = true AND a.tipostock <> 'Sin stock'";
	var codProveedor:String = cursor.valueBuffer("codproveedor");
	if (codProveedor && codProveedor != "") {
		where += " AND ap.codproveedor = '" + codProveedor + "'";
	}

	var referencia:String = cursor.valueBuffer("referencia");
	if (referencia && referencia != "") {
		where += " AND a.referencia = '" + referencia + "'";
	}
	
	var codAlmacen:String = cursor.valueBuffer("codalmacen");
	if (!codAlmacen || codAlmacen == "") {
		MessageBox.warning(util.translate("scripts", "Debe especificar un almacén"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	where += " AND s.codalmacen = '" + codAlmacen + "'";

	var codFamilia:String = cursor.valueBuffer("codfamilia");
	if (codFamilia && codFamilia != "") {
		where += " AND a.codfamilia = '" + codFamilia + "'";
	}

	where += " ORDER BY ap.codproveedor, a.referencia";

	return where;
}

function oficial_construirWherePedidoCli():String
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var listaRef:String = "(";
	var subLista:String;
	
	var qryLineas:FLSqlQuery = new FLSqlQuery;
	with (qryLineas) {
		setTablesList("lineaspedidoscli,movistock,articulos");
		setSelect("ms.idmovimiento, ms.referencia, ms.codlote, a.fabricado");
		setFrom("lineaspedidoscli lp INNER JOIN movistock ms ON lp.idlinea = ms.idlineapc INNER JOIN articulos a ON ms.referencia = a.referencia");
		setWhere("idpedido = " + cursor.valueBuffer("idpedidocli"));
		setForwardOnly(true);
	}
	if (!qryLineas.exec())
		return false;

	while (qryLineas.next()) {
		subLista = this.iface.listaRefPedido(qryLineas);
		if (subLista && subLista != "") {
			if (listaRef != "(")
				listaRef += ", ";
			listaRef += subLista;
		}
	}
	listaRef += ")";
	
	if (listaRef == "()") {
		MessageBox.warning(util.translate("scripts", "El pedido seleccionado no tiene artículos asociados.\nAsegúrese de que los artículos tienen un proveedor por defecto asociado."), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	var where:String = "ap.pordefecto = true AND a.referencia IN " + listaRef;
	
	var codAlmacen:String = cursor.valueBuffer("codalmacen");
	if (!codAlmacen || codAlmacen == "") {
		MessageBox.warning(util.translate("scripts", "Debe especificar un almacén"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	where += " AND s.codalmacen = '" + codAlmacen + "'";

	where += " ORDER BY ap.codproveedor, a.referencia";

	return where;
}

function oficial_listaRefPedido(qryMov:FLSqlQuery):String
{
	var util:FLUtil = new FLUtil;
	var lista:String = "";
	var subLista:String;
	
	var codLote:String = qryMov.value("ms.codlote");
	if (!codLote || codLote == "" || !qryMov.value("a.fabricado")) {
		if (lista != "")
			lista += ", ";
		lista += "'" + qryMov.value("ms.referencia") + "'";
	} else {
		var qryConsumos:FLSqlQuery = new FLSqlQuery;
		with (qryConsumos) {
			setTablesList("movistock,articulos");
			setSelect("ms.idmovimiento, ms.referencia, ms.codlote, a.fabricado");
			setFrom("movistock ms INNER JOIN articulos a ON ms.referencia = a.referencia");
			setWhere("ms.codloteprod = '" + codLote + "'");
			setForwardOnly(true);
		}
		if (!qryConsumos.exec())
			return false;
	
		while (qryConsumos.next()) {
			subLista = this.iface.listaRefPedido(qryConsumos);
			if (subLista && subLista != "") {
				if (lista != "")
					lista += ", ";
				lista += subLista;
			}
		}
	}
	return lista;
}

/** \D
Elabora un string en el que figuran, los artículos incluidos en la lista. Este string se usará para generar las líneas de pedidos de proveedor.
\end */
function oficial_generarListaArticulos():Boolean
{
	var util:FLUtil = new FLUtil;
	var valor:Boolean = true;
	var cursor:FLSqlCursor = this.cursor();
	var tblArticulos:QTable = this.child("tblArticulos");

	var xmlDoc:FLDomDocument = new FLDomDocument;
	xmlDoc.setContent("<RoturaStock/>");
	var eLinea:FLDomElement;

	var fila:Number;
	var maxNumPedido:Number = 0;
	var numPedidoActual;	
	for (fila = 0; fila < tblArticulos.numRows(); fila++) {
		numPedidoActual = parseFloat(tblArticulos.text(fila, this.iface.NUMPEDIDO));
		if (!isNaN(numPedidoActual) && numPedidoActual > maxNumPedido)
			maxNumPedido = tblArticulos.text(fila, this.iface.NUMPEDIDO);
	}
	for (var numPedido:Number = 1; numPedido <= maxNumPedido; numPedido++) {
		for (fila = 0; fila < tblArticulos.numRows(); fila++) {
			if (tblArticulos.text(fila, this.iface.INCLUIR) == util.translate("scripts", "Sí") && parseFloat(tblArticulos.text(fila, this.iface.PEDIR)) > 0 && tblArticulos.text(fila, this.iface.NUMPEDIDO) == numPedido) {
//				if (lista != "")
// 					lista += ","; 
				eLinea = xmlDoc.createElement("Linea");
				eLinea.setAttribute("NumPedido", tblArticulos.text(fila, this.iface.NUMPEDIDO));
				eLinea.setAttribute("CodProveedor", tblArticulos.text(fila, this.iface.CODPROVEEDOR));
				eLinea.setAttribute("Referencia", tblArticulos.text(fila, this.iface.REFERENCIA));
				eLinea.setAttribute("FechaPedido", util.dateDMAtoAMD(tblArticulos.text(fila, this.iface.FECHAPEDIDO)));
				eLinea.setAttribute("FechaEntrada", util.dateDMAtoAMD(tblArticulos.text(fila, this.iface.FECHAROTURA)));
				eLinea.setAttribute("Cantidad", tblArticulos.text(fila, this.iface.PEDIR));
				xmlDoc.firstChild().appendChild(eLinea);
			}
		}
	}
	var lista:String = xmlDoc.toString(4);
debug(lista);
	
	cursor.setValueBuffer("lista", lista);
	return valor;
}

function oficial_tbnEvolStock_clicked()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var tblArticulos:QTable = this.child("tblArticulos");
	var filaActual:Number = tblArticulos.currentRow();
	if (filaActual < 0)
		return;

	var idStock:String = tblArticulos.text(filaActual , this.iface.IDSTOCK);
	flfactalma.iface.pub_graficoStock(idStock, false);
}

function oficial_calculoNecesidades()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var tblArticulos:QTable = this.child("tblArticulos");
	var filaActual:Number = tblArticulos.currentRow();
	if (filaActual < 0)
		return;

	var referencia:String = tblArticulos.text(filaActual , this.iface.REFERENCIA);
	var codAlmacen:String = cursor.valueBuffer("codalmacen");
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

function oficial_datosEvolStockActual():Array
{
	if (!this.iface.totalDatosES)
		return false;
		
	return this.iface.totalDatosES[this.iface.currentRow_];
}

/** \D Calcula las necesidades de stock y devuelve los datos de los pedidos a realizar
@param datosLinea: Datos de una línea de la tabla
@return	Array con los datos del pedido a generar 
\end */
function oficial_hayRoturaStock(qryRS:FLSqlQuery):Array
{
	var util:FLUtil = new FLUtil;

	var datosRotura:Array = [];
	var hoy:Date = new Date;
	datosRotura["rotura"] = false;

	var arrayEvolStock:Array = flfactalma.iface.pub_datosEvolStock(false, qryRS.value("referencia"), datosLinea["codalmacen"], hoy.toString(), true);
	if (!arrayEvolStock)
		return false;

	arrayEvolStock = flfactalma.iface.pub_planificarPedStock(arrayEvolStock, datosLinea["plazo"])
	if (!arrayEvolStock)
		return false;

	var idRotura:Number = -1;
	var idPedido:Number = -1;
	for (var i:Number = 0; i < arrayEvolStock.length; i++) {
		if (arrayEvolStock[i]["RPP"] > 0)
			idRotura = i;
		if (arrayEvolStock[i]["LPP"] > 0)
			idPedido = i;
	}
	if (idRotura == -1)
		return datosRotura;

	datosRotura["rotura"] = true;
	datosRotura["cantidad"] = arrayEvolStock[idRotura]["RPP"];
	datosRotura["fecharotura"] = arrayEvolStock[idRotura]["fecha"];
	datosRotura["fechapedido"] = arrayEvolStock[idPedido]["fecha"];

	if (util.daysTo(datosRotura["fechapedido"], datosRotura["fecharotura"]) < datosLinea["plazo"]) {
		this.iface.mensajeTiempoSuficiente("Referencia " + datosLinea["referencia"],datosLinea["nombreproveedor"],util.dateAMDtoDMA(datosRotura["fecharotura"]));
	}
	return datosRotura;
}

function oficial_tbnStock_clicked()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var tblArticulos:QTable = this.child("tblArticulos");
	var filaActual:Number = tblArticulos.currentRow();
	if (filaActual < 0)
		return;

	var referencia:String = tblArticulos.text(filaActual , this.iface.REFERENCIA);
	var codAlmacen:String = cursor.valueBuffer("codalmacen");
	if (!codAlmacen || codAlmacen == "")
		return;
	
	var curStock:FLSqlCursor = new FLSqlCursor("stocks");
	curStock.select("referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "'");
	if (!curStock.first())
		return;

	curStock.browseRecord();
}

function oficial_mensajeTiempoSuficiente(articulo:String,proveedor:string,fecha:Date)
{
	var util:FLUtil;
	MessageBox.warning(util.translate("scripts", "%1:\nNo hay tiempo suficiente para recibir el material del proveedor %2 antes de la fecha de rotura (%3)").arg(articulo).arg(proveedor).arg(fecha), MessageBox.Ok, MessageBox.NoButton);
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
