
/** @delete_class kits */

/** @class_declaration prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN /////////////////////////////////////////////////
class prod extends oficial {
	var tbnEvolStock:Object;
	var tbnRegularizarStock0:Object;
    function prod( context ) { oficial ( context ); }
	function init() {
		return this.ctx.prod_init();
	}
	function infoEvolStock() {
		return this.ctx.prod_infoEvolStock();
	}
	function regularizarStock0_clicked() {
		return this.ctx.prod_regularizarStock0_clicked();
	}
	function regularizarStock0(where:String):Boolean {
		return this.ctx.prod_regularizarStock0(where);
	}
}
//// PRODUCCIÓN /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCION /////////////////////////////////////////////////
function prod_init()
{
	this.iface.__init();

	this.iface.tbnEvolStock = this.child("tbnEvolStock");
	this.iface.tbnRegularizarStock0 = this.child("tbnRegularizarStock0");
	connect (this.iface.tbnEvolStock, "clicked()", this, "iface.infoEvolStock");
	connect (this.iface.tbnRegularizarStock0, "clicked()", this, "iface.regularizarStock0_clicked");
	this.iface.tbnRegularizarStock0.close();
}

function prod_infoEvolStock()
{
	var cursor:FLSqlCursor = this.cursor();
	var idStock:String = cursor.valueBuffer("idstock");
	if (!idStock)
		return;

	flfactalma.iface.pub_graficoStock(idStock);
}

function prod_regularizarStock0_clicked()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var codAlmacen:String = cursor.valueBuffer("codalmacen");
	if (!codAlmacen || codAlmacen == "") {
		return false;
	}

	var res:Number = MessageBox.warning(util.translate("scripts", "Esta acción no puede deshacerse de forma automática.\n¿Está seguro de querer continuar?"), MessageBox.No, MessageBox.Yes);
	if (res != MessageBox.Yes) {
		return false;
	}

	var arrayOps:Array = [];
	arrayOps[0] = util.translate("scripts", "Regularizar a 0 el stock seleccionado");
	arrayOps[1] = util.translate("scripts", "Regularizar a 0 los stocks de %1").arg(codAlmacen);
	arrayOps[2] = util.translate("scripts", "Regularizar a 0 todos los stocks");

	var dialogo = new Dialog;
	dialogo.okButtonText = util.translate("scripts", "Aceptar");
	dialogo.cancelButtonText = util.translate("scripts", "Cancelar");

	var gbxDialogo = new GroupBox;
	gbxDialogo.title = util.translate("scripts", "Seleccione opción");

	var rButton:Array = new Array(arrayOps.length);
	for (var i:Number = 0; i < rButton.length; i++) {
		rButton[i] = new RadioButton;
		rButton[i].text = arrayOps[i];
		rButton[i].checked = false;
		gbxDialogo.add(rButton[i]);
	}

	dialogo.add(gbxDialogo);
	if (!dialogo.exec()) {
		return false;
	}
	var seleccion:Number = -1;
	for (var i:Number = 0; i < rButton.length; i++) {
		if (rButton[i].checked) {
			seleccion = i;
			break;
		}
	}
	if (seleccion == -1) {
		return false;
	}
	var where:String;
	switch (seleccion) {
		case 0: {
			where = "idstock = " + cursor.valueBuffer("idstock");
			break;
		}
		case 1: {
			where = "codalmacen = '" + codAlmacen + "'";
			break;
		}
		case 2: {
			where = "1 = 1";
			break;
		}
	}
	var curTransaccion:FLSqlCursor = new FLSqlCursor("empresa");
	curTransaccion.transaction(false);
	try {
		if (this.iface.regularizarStock0(where)) {
			curTransaccion.commit();
		} else {
			curTransaccion.rollback();
			MessageBox.warning(util.translate("scripts", "Error al regularizar a 0 el stock"), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
	} catch(e) {
		curTransaccion.rollback();
		MessageBox.warning(util.translate("scripts", "Error al regularizar a 0 el stock:") + e, MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	this.child("tdbRegStocks").refresh();
}

/** \D Crea un registro de reguarización de stock para todos los stock que cumplan la condición del parámetro where
@param	where: Cláusula where para buscar stocks
\end */
function prod_regularizarStock0(where:String):Boolean
{
	var util:FLUtil = new FLUtil;

	var curLineasRegStock:FLSqlCursor = new FLSqlCursor("lineasregstocks");
	var curStock:FLSqlCursor = new FLSqlCursor("stocks");
	curStock.select(where);
	util.createProgressDialog(util.translate("scripts", "Revisando stocks..."), curStock.size());
	var paso:Number = 0;
	var canUltReg:Number, idStock:String;
	var fecha:Date = new Date;

	while (curStock.next()) {
		util.setProgress(++paso);

		idStock = curStock.valueBuffer("idstock");
		curLineasRegStock.setModeAccess(curLineasRegStock.Insert);
		curLineasRegStock.refreshBuffer();
		curLineasRegStock.setValueBuffer("idstock", idStock);
		curLineasRegStock.setValueBuffer("fecha", fecha.toString());
		curLineasRegStock.setValueBuffer("hora", fecha.toString().right(8));
		curLineasRegStock.setValueBuffer("cantidadini", curStock.valueBuffer("cantidad"));
		curLineasRegStock.setValueBuffer("cantidadfin", 0);
		if (!curLineasRegStock.commitBuffer()) {
			return false;
		}

		curStock.setModeAccess(curStock.Edit);
		curStock.refreshBuffer();
		curStock.setValueBuffer("cantidad", flfactalma.iface.pub_stockActual(idStock));
		curStock.setValueBuffer("disponible", formRecordregstocks.iface.pub_commonCalculateField("disponible", curStock));
		if (!curStock.commitBuffer()) {
			util.destroyProgressDialog();
			return false;
		}
	}
	util.destroyProgressDialog();
	return true;
}

//// PRODUCCION /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

