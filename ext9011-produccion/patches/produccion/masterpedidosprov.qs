
/** @class_declaration prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN /////////////////////////////////////////////////
class prod extends articuloscomp {
	var tbnRoturaStock:Object;
	var curPedidoRS:FLSqlCursor;
	var curLineaRS:FLSqlCursor;
    function prod( context ) { articuloscomp ( context ); }
	function init() {
		return this.ctx.prod_init();
	}
	function tbnRoturaStock_clicked() {
		return this.ctx.prod_tbnRoturaStock_clicked();
	}
	function generarRoturaStock(lista:String, curRS:FLSqlCursor):Boolean {
		return this.ctx.prod_generarRoturaStock(lista, curRS);
	}
	function guardarCabeceraRS(idPedido:String):Boolean {
		return this.ctx.prod_guardarCabeceraRS(idPedido);
	}
	function datosPedidoRS(eLinea:FLDomElement, curRS:FLSqlCursor):Boolean {
		return this.ctx.prod_datosPedidoRS(eLinea, curRS);
	}
	function generarLineaRS(eLinea:FLDomElement, idPedido:String):String {
		return this.ctx.prod_generarLineaRS(eLinea, idPedido);
	}
	function datosLineaRS(eLinea:FLDomElement):Boolean {
		return this.ctx.prod_datosLineaRS(eLinea);
	}
	function totalesPedidoRS():Boolean {
		return this.ctx.prod_totalesPedidoRS();
	}
	function datosAlbaran(curPedido:FLSqlCursor, where:String, datosAgrupacion:Array):Boolean {
		return this.ctx.prod_datosAlbaran(curPedido, where, datosAgrupacion);
	}
}
//// PRODUCCIÓN /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubProd */
/////////////////////////////////////////////////////////////////
//// PUB PRODUCCIÓN /////////////////////////////////////////////
class pubProd extends ifaceCtx {
    function pubProd( context ) { ifaceCtx( context ); }
	function pub_generarRoturaStock(lista:String, curRS:FLSqlCursor):Boolean {
		return this.generarRoturaStock(lista, curRS);
	}
}
//// PUB PRODUCCIÓN /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN /////////////////////////////////////////////////
function prod_init()
{
	this.iface.__init();
	this.iface.tbnRoturaStock = this.child("tbnRoturaStock");

	connect(this.child("tbnRoturaStock"), "clicked()", this, "iface.tbnRoturaStock_clicked()");
}

function prod_tbnRoturaStock_clicked()
{
	var util:FLUtil = new FLUtil;
	var f:Object = new FLFormSearchDB("roturastock");
	var cursor:FLSqlCursor = f.cursor();

	cursor.select("idusuario = '" + sys.nameUser() + "'");
	if (!cursor.first())
		cursor.setModeAccess(cursor.Insert);
	else
		cursor.setModeAccess(cursor.Edit);

	f.setMainWidget();
	cursor.refreshBuffer();
	cursor.setValueBuffer("idusuario", sys.nameUser());
	cursor.setNull("idpedidocli");
	var acpt:String = f.exec("codejercicio");
	var lista:String;
	if (acpt) {
		if (!cursor.commitBuffer())
			return false;
		var curRoturaStock:FLSqlCursor = new FLSqlCursor("roturastock");
		curRoturaStock.select("idusuario = '" + sys.nameUser() + "'");
		if (curRoturaStock.first()) {
			lista = curRoturaStock.valueBuffer("lista");
			if (!lista || lista == "")
				return;

			var curPedido:FLSqlCursor = new FLSqlCursor("pedidosprov");
			curPedido.transaction(false);
			try {
				if (!this.iface.generarRoturaStock(lista, curRoturaStock)) {
					curPedido.rollback();
					util.destroyProgressDialog();
				} else {
					curPedido.commit();
					util.destroyProgressDialog();
				}
			} catch (e) {
				curPedido.rollback();
				util.destroyProgressDialog();
				MessageBox.critical(util.translate("scripts", "Hubo un error al generar los pedidos de artículos con rotura de stock: ") + e, MessageBox.Ok, MessageBox.NoButton);
			}
		}
	}
	f.close();
	this.iface.tdbRecords.refresh();
}

function prod_generarRoturaStock(lista:String, curRS:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	var xmlDoc:FLDomDocument = new FLDomDocument;
	if (!xmlDoc.setContent(lista)) {
		MessageBox.warning(util.translate("scripts", "Error al cargar los datos XML de los pedidos a generar"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	var xmlListaLineas:FLDomNodeList = xmlDoc.elementsByTagName("Linea");
	if (!xmlListaLineas || xmlListaLineas.length() == 0) {
		return false;
	}
	var eLinea:FLDomElement;
	var arrayLista:Array = lista.split(",");
	var arrayAux:Array;
	var arrayLinea:Array;

	var totalLineas:Number = xmlListaLineas.length();
	var idPedido:String;
	var codProveedor:String;
	var numPedido:Number;
	var numPedidoPrevio:Number;
	var listaPedidos:String = util.translate("scripts", "Pedidos generados:\n");
	var idPedidos:String = "";
	var datosProveedor:String;

	util.createProgressDialog(util.translate("scripts", "Generando pedidos..."), totalLineas);
	for (var i:Number = 0; i < totalLineas; i++) {
		util.setProgress(i + 1);
		eLinea = xmlListaLineas.item(i).toElement();
		numPedido = eLinea.attribute("NumPedido");

		if (numPedido != numPedidoPrevio) {
			numPedidoPrevio = numPedido;
			if (idPedido) {
				if (!this.iface.guardarCabeceraRS(idPedido)) {
					util.destroyProgressDialog();
					return false;
				}
				listaPedidos += util.translate("scripts", "Ped. %1 a Proveedor %2-%3").arg(util.sqlSelect("pedidosprov", "codigo", "idpedido = " + idPedido)).arg(util.sqlSelect("pedidosprov", "codproveedor", "idpedido = " + idPedido)).arg(util.sqlSelect("pedidosprov", "nombre", "idpedido = " + idPedido)) + "\n";
				if (idPedidos != "") {
					idPedidos += ",";
				}
				idPedidos += idPedido;
			}
			if (!this.iface.curPedidoRS) {
				this.iface.curPedidoRS = new FLSqlCursor("pedidosprov");
			}

			this.iface.curPedidoRS.setModeAccess(this.iface.curPedidoRS.Insert);
			this.iface.curPedidoRS.refreshBuffer();

			if (!this.iface.datosPedidoRS(eLinea, curRS)) {
				util.destroyProgressDialog();
				return false;
			}
			if (!this.iface.curPedidoRS.commitBuffer()) {
				util.destroyProgressDialog();
				return false;
			}
			idPedido = this.iface.curPedidoRS.valueBuffer("idpedido");
			if (!idPedido) {
				util.destroyProgressDialog();
				return false;
			}
		}
		if (!this.iface.generarLineaRS(eLinea, idPedido)) {
			util.destroyProgressDialog();
			return false;
		}
	}

	if (idPedido) {
		if (!this.iface.guardarCabeceraRS(idPedido)) {
			util.destroyProgressDialog();
			return false;
		}
		listaPedidos += util.translate("scripts", "Ped. %1 a Proveedor %2-%3").arg(util.sqlSelect("pedidosprov", "codigo", "idpedido = " + idPedido)).arg(util.sqlSelect("pedidosprov", "codproveedor", "idpedido = " + idPedido)).arg(util.sqlSelect("pedidosprov", "nombre", "idpedido = " + idPedido));
		if(idPedidos != "")
			idPedidos += ",";
		idPedidos += idPedido;
	}
	util.destroyProgressDialog();
	var res:Number = MessageBox.information(listaPedidos + "\n\n¿Desea imprimirlos?", MessageBox.Yes, MessageBox.No);
	if (res == MessageBox.Yes) {
		if (sys.isLoadedModule("flfactinfo")) {
			var curImprimir:FLSqlCursor = new FLSqlCursor("i_pedidosprov");
			curImprimir.setModeAccess(curImprimir.Insert);
			curImprimir.refreshBuffer();
			curImprimir.setValueBuffer("descripcion", "temp");
			curImprimir.setValueBuffer("d_pedidosprov_codigo", util.sqlSelect("pedidosprov","MIN(codigo)","idpedido IN(" + idPedidos + ")"));
			curImprimir.setValueBuffer("h_pedidosprov_codigo", util.sqlSelect("pedidosprov","MAX(codigo)","idpedido IN(" + idPedidos + ")"));
			flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_pedidosprov", "codigo");
		} else
			flfactppal.iface.pub_msgNoDisponible("Informes");
	}

	return true;
}

function prod_guardarCabeceraRS(idPedido:String):Boolean
{
	this.iface.curPedidoRS.select("idpedido = " + idPedido);
	if (this.iface.curPedidoRS.first()) {
		this.iface.curPedidoRS.setModeAccess(this.iface.curPedidoRS.Edit);
		this.iface.curPedidoRS.refreshBuffer();

		if (!this.iface.totalesPedidoRS())
			return false;

		if (this.iface.curPedidoRS.commitBuffer() == false)
			return false;
	}
	return true;
}

function prod_datosPedidoRS(eLinea:FLDomElement, curRS:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	var fecha:String = eLinea.attribute("FechaPedido");

	var codEjercicio:String = curRS.valueBuffer("codejercicio");
	var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(fecha, codEjercicio, "pedidosprov");
	if (!datosDoc.ok)
		return false;
	if (datosDoc.modificaciones == true) {
		codEjercicio = datosDoc.codEjercicio;
		fecha = datosDoc.fecha;
	}

	var codProveedor:String = eLinea.attribute("CodProveedor");
	with (this.iface.curPedidoRS) {
		setValueBuffer("codproveedor", codProveedor);
		setValueBuffer("nombre", util.sqlSelect("proveedores", "nombre", "codproveedor = '" + codProveedor + "'"));
		setValueBuffer("cifnif", util.sqlSelect("proveedores", "cifnif", "codproveedor = '" + codProveedor + "'"));
		setValueBuffer("coddivisa", curRS.valueBuffer("coddivisa"));
		setValueBuffer("tasaconv", curRS.valueBuffer("tasaconv"));
		setValueBuffer("recfinanciero", 0);
		setValueBuffer("codpago", curRS.valueBuffer("codpago"));
		setValueBuffer("codalmacen", curRS.valueBuffer("codalmacen"));
		setValueBuffer("fecha", fecha);
		setValueBuffer("fechaentrada", eLinea.attribute("FechaEntrada"));
		setValueBuffer("codserie", curRS.valueBuffer("codserie"));
		setValueBuffer("codejercicio", codEjercicio);
		setValueBuffer("tasaconv", curRS.valueBuffer("tasaconv"));
	}

	return true;
}

function prod_generarLineaRS(eLinea:FLDomElement, idPedido:String):String
{
	if (!this.iface.curLineaRS)
		this.iface.curLineaRS = new FLSqlCursor("lineaspedidosprov");

	with (this.iface.curLineaRS) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idpedido", idPedido);
	}

	if (!this.iface.datosLineaRS(eLinea))
		return false;

	if (!this.iface.curLineaRS.commitBuffer())
		return false;

	return this.iface.curLineaRS.valueBuffer("idlinea");
}

function prod_datosLineaRS(eLinea:FLDomElement):Boolean
{
	var util:FLUtil = new FLUtil;
	var cantidad:Number = parseFloat(eLinea.attribute("Cantidad"));
	cantidad = util.roundFieldValue(cantidad, "lineaspedidosprov", "cantidad");
	var iva:Number;
	var recargo:Number;
	with (this.iface.curLineaRS) {
		setValueBuffer("referencia", eLinea.attribute("Referencia"));
		setValueBuffer("descripcion", util.sqlSelect("articulos", "descripcion", "referencia = '" + eLinea.attribute("Referencia") + "'"));
		setValueBuffer("pvpunitario", formRecordlineaspedidosprov.iface.pub_commonCalculateField("pvpunitario", this));
		setValueBuffer("cantidad", cantidad);
		setValueBuffer("codimpuesto", formRecordlineaspedidosprov.iface.pub_commonCalculateField("codimpuesto", this));
		iva = formRecordlineaspedidosprov.iface.pub_commonCalculateField("iva", this);
			if (!iva || isNaN(iva))
			iva = 0;
		setValueBuffer("iva", iva);
		recargo = formRecordlineaspedidosprov.iface.pub_commonCalculateField("recargo", this);
		if (!recargo || isNaN(recargo))
			recargo = 0;
		setValueBuffer("recargo", recargo);
		setValueBuffer("dtolineal", 0);
		setValueBuffer("dtopor", formRecordlineaspedidosprov.iface.pub_commonCalculateField("pvpunitario", this));
		setValueBuffer("pvpsindto", formRecordlineaspedidosprov.iface.pub_commonCalculateField("pvpsindto", this));
		setValueBuffer("pvptotal", formRecordlineaspedidosprov.iface.pub_commonCalculateField("pvptotal", this));
	}
	return true;
}

function prod_totalesPedidoRS():Boolean
{
	with (this.iface.curPedidoRS) {
		setValueBuffer("neto", formpedidosprov.iface.pub_commonCalculateField("neto", this));
		setValueBuffer("totaliva", formpedidosprov.iface.pub_commonCalculateField("totaliva", this));
		setValueBuffer("totalirpf", formpedidosprov.iface.pub_commonCalculateField("totalirpf", this));
		setValueBuffer("totalrecargo", formpedidosprov.iface.pub_commonCalculateField("totalrecargo", this));
		setValueBuffer("total", formpedidosprov.iface.pub_commonCalculateField("total", this));
		setValueBuffer("totaleuros", formpedidosprov.iface.pub_commonCalculateField("totaleuros", this));
	}
	return true;
}

function prod_datosAlbaran(curPedido:FLSqlCursor, where:String, datosAgrupacion:Array):Boolean
{
	if (!this.iface.__datosAlbaran(curPedido, where, datosAgrupacion)) {
		return false;
	}

	var hora:String;
	if (datosAgrupacion) {
		hora = datosAgrupacion["hora"];
	} else {
		var hoy:Date = new Date();
		hora = hoy.toString().right(8);
	}

	this.iface.curAlbaran.setValueBuffer("hora", hora);

	return true;
}

//// PRODUCCIÓN /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////

