
/** @class_declaration prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN /////////////////////////////////////////////////
class prod extends articuloscomp {
	var tbnRoturaStock:Object;
    function prod( context ) { articuloscomp ( context ); }
	function init() {
		return this.ctx.prod_init();
	}
	function tbnRoturaStock_clicked() {
		return this.ctx.prod_tbnRoturaStock_clicked();
	}
	function datosAlbaran(curPedido:FLSqlCursor, where:String, datosAgrupacion:Array):Boolean {
		return this.ctx.prod_datosAlbaran(curPedido, where, datosAgrupacion);
	}
	function abrirCerrarPedido() {
		return this.ctx.prod_abrirCerrarPedido();
	}
}
//// PRODUCCIÓN /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN ////////////////////////////////////////////////
function prod_init()
{
	this.iface.__init();
	this.iface.tbnRoturaStock = this.child("tbnRoturaStock");

	connect(this.iface.tbnRoturaStock, "clicked()", this, "iface.tbnRoturaStock_clicked");
}

function prod_tbnRoturaStock_clicked()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	if (!cursor.isValid())
		return false;

	var f:Object = new FLFormSearchDB("roturastock");
	var curRS:FLSqlCursor = f.cursor();

	curRS.select("idusuario = '" + sys.nameUser() + "'");
	if (!curRS.first())
		curRS.setModeAccess(curRS.Insert);
	else
		curRS.setModeAccess(curRS.Edit);

	f.setMainWidget();
	curRS.refreshBuffer();
	curRS.setValueBuffer("idusuario", sys.nameUser());
	curRS.setValueBuffer("idpedidocli", cursor.valueBuffer("idpedido"));
	var acpt:String = f.exec("codejercicio");
	var lista:String;
	if (acpt) {
		if (!curRS.commitBuffer())
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
				if (!formpedidosprov.iface.pub_generarRoturaStock(lista, curRoturaStock)) {
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

function prod_abrirCerrarPedido()
{
	var util:FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var idPedido:Number = cursor.valueBuffer("idpedido");
	if(!idPedido) {
		MessageBox.warning(util.translate("scripts", "No hay ningún registro seleccionado"), MessageBox.Ok, MessageBox.NoButton);
	}

	var cerrar:Boolean = true;
	var res:Number;
	if(util.sqlSelect("lineaspedidoscli LEFT OUTER JOIN articulos on lineaspedidoscli.referencia = articulos.referencia","cerrada","idpedido = " + idPedido + " AND articulos.fabricado = false AND cerrada","lineaspedidoscli,articulos")) {
		cerrar = false;
		res = MessageBox.information(util.translate("scripts", "El pedido seleccionado tiene líneas cerradas.\n¿Seguro que desa abrirlas?"), MessageBox.Yes, MessageBox.No);
	}
	else {
		if(!cursor.valueBuffer("editable")) {
			MessageBox.warning(util.translate("scripts", "El pedido ya ha sido servido completamente."), MessageBox.Ok, MessageBox.NoButton);
			return;
		}

		if(util.sqlSelect("lineaspedidoscli LEFT OUTER JOIN articulos on lineaspedidoscli.referencia = articulos.referencia","idlinea","idpedido = " + idPedido + " AND articulos.fabricado AND (cerrada = false OR cerrada IS NULL)","lineaspedidoscli,articulos")) {
			res = MessageBox.warning(util.translate("scripts", "El pedido contiene líneas de artículos de fabricación que no se cerrarán.\n¿Desea continuar de todas formas?"), MessageBox.Yes, MessageBox.No);
		}
		else {
			res = MessageBox.warning(util.translate("scripts", "Se va a cerrar el pedido y no podrá terminar de servirse.\n¿Desea continuar?"), MessageBox.Yes, MessageBox.No);
		}
	}
	if(res != MessageBox.Yes)
		return;

	if(!util.sqlUpdate("lineaspedidoscli","cerrada",cerrar,"idpedido = " + idPedido + " AND referencia NOT IN (select referencia from articulos where fabricado)"))
		return;

	if (!flfacturac.iface.pub_actualizarEstadoPedidoCli(idPedido))
		return;

	this.iface.tdbRecords.refresh();
}
//// PRODUCCIÓN ////////////////////////////////////////////////
////////////////////////////////////////////////////////////////

