
/** @delete_class kits */

/** @class_declaration prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN /////////////////////////////////////////////////
class prod extends oficial {
    function prod( context ) { oficial ( context ); }
	function init() {
		this.ctx.prod_init();
	}
	function filtrarMovimientos() {
		this.ctx.prod_filtrarMovimientos();
	}
	function calcularCantidad() {
		this.ctx.prod_calcularCantidad();
	}
	function mostrarListadoMS() {
		return this.ctx.prod_mostrarListadoMS();
	}
}
//// PRODUCCIÓN /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN /////////////////////////////////////////////////
function prod_init()
{
	this.iface.__init();

	connect(this.child("chkDesdeUltReg"), "clicked()", this, "iface.filtrarMovimientos");
	connect(this.child("chkExcluirPtes"), "clicked()", this, "iface.filtrarMovimientos");
	connect (this.child("tnbMostrarListadoMS"), "clicked()", this, "iface.mostrarListadoMS");
	this.iface.filtrarMovimientos();
}

function prod_mostrarListadoMS()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var f:Object = new FLFormSearchDB("mostrarlistadoms");
	var curMostrar:FLSqlCursor = f.cursor();
	curMostrar.select("idusuario = '" + sys.nameUser() + "'");
	if (!curMostrar.first()) {
		curMostrar.setModeAccess(curMostrar.Insert);
		curMostrar.refreshBuffer();
		curMostrar.setValueBuffer("idusuario", sys.nameUser());
	} else {
		curMostrar.setModeAccess(curMostrar.Edit);
		curMostrar.refreshBuffer();
	}
	curMostrar.setValueBuffer("idstock", cursor.valueBuffer("idstock"));
	curMostrar.setValueBuffer("codalmacen", cursor.valueBuffer("codalmacen"));
	curMostrar.setValueBuffer("referencia", cursor.valueBuffer("referencia"));
	curMostrar.setValueBuffer("desdeultimareg",true);
	curMostrar.setValueBuffer("pendiente", true);
	curMostrar.setValueBuffer("reservado", true);
	curMostrar.setValueBuffer("hecho", true);
	if (!curMostrar.commitBuffer())
		return false;;

	curMostrar.select("idusuario = '" + sys.nameUser() + "' AND idstock = " + cursor.valueBuffer("idstock"));
	if (!curMostrar.first())
		return false;

	curMostrar.setModeAccess(curMostrar.Edit);
	curMostrar.refreshBuffer();

	f.setMainWidget();
	curMostrar.refreshBuffer();
	var acpt:String = f.exec("idusuario");
	if (!acpt)
		return false;
}

function prod_filtrarMovimientos()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var filtro:String = "1 = 1";
	if (this.child("chkDesdeUltReg").checked) {
		var ultFecha:String = util.sqlSelect("lineasregstocks", "fecha", "idstock = " + cursor.valueBuffer("idstock") + " ORDER BY fecha DESC, hora DESC");
		if (ultFecha && ultFecha != "") {
			var ultHora:String = util.sqlSelect("lineasregstocks", "hora", "idstock = " + cursor.valueBuffer("idstock") + " AND fecha = '" + ultFecha + "' ORDER BY hora DESC");
			if (ultHora && ultHora != "")
				filtro += " AND ((fechareal IS NULL OR fechareal > '" + ultFecha + "') OR (fechareal = '" + ultFecha + "' AND (horareal > '" + ultHora.toString().right(8) + "' 	OR horareal IS NULL)))";
		}
	}
	if (this.child("chkExcluirPtes").checked) {
		filtro += " AND fechareal IS NOT NULL";
	}
	this.child("tdbMoviStocks").cursor().setMainFilter(filtro);
	this.child("tdbMoviStocks").refresh();
}

function prod_calcularCantidad()
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil;

	var cantidad:Number = flfactalma.iface.pub_stockActual(cursor.valueBuffer("idstock"));
	this.child("fdbCantidad").setValue(cantidad)

	var cantPteServir:Number = parseFloat(flfactalma.iface.pub_stockPteServir(cursor.valueBuffer("idstock"))) * -1;
	this.child("fdbReservada").setValue(cantPteServir );
	var canDisponible:Number = formRecordregstocks.iface.pub_commonCalculateField("disponible", cursor);
	this.child("fdbDisponible").setValue(canDisponible);

	this.child("tdbMoviStocks").refresh();
}

//// PRODUCCIÓN /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

