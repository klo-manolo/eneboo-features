
/** @class_declaration prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCION /////////////////////////////////////////////
class prod extends oficial {
	function prod( context ) { oficial ( context ); }
	function init() {
		return this.ctx.prod_init();
	}
	function tbnPlayPrep_clicked() {
		return this.ctx.prod_tbnPlayPrep_clicked();
	}
	function tbnStopPrep_clicked() {
		return this.ctx.prod_tbnStopPrep_clicked();
	}
	function tbnPlayTrab_clicked() {
		return this.ctx.prod_tbnPlayTrab_clicked();
	}
	function tbnStopTrab_clicked() {
		return this.ctx.prod_tbnStopTrab_clicked();
	}
	function calcularTiempo(cursor:FLSqlCursor):Number {
		return this.ctx.prod_calcularTiempo(cursor);
	}
	function mostrarTiempo() {
		return this.ctx.prod_mostrarTiempo();
	}
	function borrarTemporizadores() {
		return this.ctx.prod_borrarTemporizadores();
	}
	function formatearTiempo(s:Number):String {
		return this.ctx.prod_formatearTiempo(s);
	}
}
//// PRODUCCION /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubProd */
/////////////////////////////////////////////////////////////////
//// PUB_PRODUCCION  ////////////////////////////////////////////
class pubProd extends ifaceCtx {
	function pubProd( context ) { ifaceCtx( context ); }
	function pub_calcularTiempo(cursor:FLSqlCursor):Number {
		return this.calcularTiempo(cursor);
	}
	function pub_formatearTiempo(s:Number):String {
		return this.formatearTiempo(s);
	}
}
//// PUB_PRODUCCION  ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCION /////////////////////////////////////////////////
function prod_init()
{
	this.iface.__init();

	var util:FLUtil = new FLUtil;

	if(!util.sqlSelect("pr_config","controltiempo","1 = 1")) {
		this.child("tbwTarea").setTabEnabled("controldetiempo", false);
	}

	var cursor:FLSqlCursor = this.cursor();
	var estado:String = cursor.valueBuffer("estado");
	if (estado == "EN CURSO") {
		var subestado:String = cursor.valueBuffer("subestado");
		if (!subestado || subestado == "") {
			subestado = util.translate("scripts", "EN PAUSA");
			this.child("fdbSubestado").setValue(subestado);
		}
		connect (this, "closed()", this, "iface.borrarTemporizadores");
		connect (this.child("tbnPlayPrep"), "clicked()", this, "iface.tbnPlayPrep_clicked()");
		connect (this.child("tbnStopPrep"), "clicked()", this, "iface.tbnStopPrep_clicked()");
		connect (this.child("tbnPlayTrab"), "clicked()", this, "iface.tbnPlayTrab_clicked()");
		connect (this.child("tbnStopTrab"), "clicked()", this, "iface.tbnStopTrab_clicked()");

		switch (subestado) {
			case util.translate("scripts", "PREPARACIÓN EN CURSO"): {
				this.child("lblAcumuladoTrab").text = this.iface.formatearTiempo(cursor.valueBuffer("intervalotrab"));
				this.child("lblTiempoTrabajo").text = this.iface.formatearTiempo(0);

				startTimer(1000, this.iface.mostrarTiempo);
				break;
			}
			case util.translate("scripts", "TRABAJO EN CURSO"): {
				this.child("lblAcumuladoPrep").text = this.iface.formatearTiempo(cursor.valueBuffer("intervaloprep"));
				this.child("lblTiempoPreparacion").text = this.iface.formatearTiempo(0);

				startTimer(1000, this.iface.mostrarTiempo);
				break;
			}
			case util.translate("scripts", "EN PAUSA"): {
				this.child("lblAcumuladoPrep").text = this.iface.formatearTiempo(cursor.valueBuffer("intervaloprep"));
				this.child("lblTiempoPreparacion").text = this.iface.formatearTiempo(0);

				this.child("lblAcumuladoTrab").text = this.iface.formatearTiempo(cursor.valueBuffer("intervalotrab"));
				this.child("lblTiempoTrabajo").text = this.iface.formatearTiempo(0);
				break;
			}
		}
	}
}

function prod_tbnPlayPrep_clicked()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var subestado:String = cursor.valueBuffer("subestado");
	switch (subestado) {
		case util.translate("scripts", "EN PAUSA"): {
			this.child("fdbSubestado").setValue(util.translate("scripts", "PREPARACIÓN EN CURSO"));
			var ahora:Date = new Date;
			cursor.setValueBuffer("iniciocuentaf", ahora.toString());
			cursor.setValueBuffer("iniciocuentat", ahora.toString().right(8));
			startTimer(1000, this.iface.mostrarTiempo);
			break;
		}
		default: {
			break;
		}
	}
}

function prod_tbnPlayTrab_clicked()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var subestado:String = cursor.valueBuffer("subestado");
	switch (subestado) {
		case util.translate("scripts", "EN PAUSA"): {
			this.child("fdbSubestado").setValue(util.translate("scripts", "TRABAJO EN CURSO"));
			var ahora:Date = new Date;
			cursor.setValueBuffer("iniciocuentaf", ahora.toString());
			cursor.setValueBuffer("iniciocuentat", ahora.toString().right(8));
			startTimer(1000, this.iface.mostrarTiempo);
			break;
		}
		default: {
			break;
		}
	}
}

function prod_tbnStopPrep_clicked()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var subestado:String = cursor.valueBuffer("subestado");
	switch (subestado) {
		case util.translate("scripts", "PREPARACIÓN EN CURSO"): {
			if(!flcolaproc.iface.pub_terminarTareasActivas(cursor.valueBuffer("idtarea"),subestado))
				return false;
			this.child("tdbTrabajadores").refresh();
			killTimers();
			this.child("fdbSubestado").setValue(util.translate("scripts", "EN PAUSA"));
			var tiempo:Number = this.iface.calcularTiempo(cursor);
			this.child("lblTiempoPreparacion").text = this.iface.formatearTiempo(tiempo);
			var acumuladoPrep:Number = parseInt(cursor.valueBuffer("intervaloprep")) + tiempo;
			cursor.setValueBuffer("intervaloprep", acumuladoPrep);
			this.child("lblAcumuladoPrep").text = this.iface.formatearTiempo(acumuladoPrep);
			break;
		}
		default: {
			break;
		}
	}
}

function prod_tbnStopTrab_clicked()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var subestado:String = cursor.valueBuffer("subestado");
	switch (subestado) {
		case util.translate("scripts", "TRABAJO EN CURSO"): {
			if(!flcolaproc.iface.pub_terminarTareasActivas(cursor.valueBuffer("idtarea"),subestado))
				return false;

			this.child("tdbTrabajadores").refresh();
			killTimers();
			this.child("fdbSubestado").setValue(util.translate("scripts", "EN PAUSA"));
			var tiempo:Number = this.iface.calcularTiempo(cursor);
			this.child("lblTiempoTrabajo").text = this.iface.formatearTiempo(tiempo);
			var acumuladoTrab:Number = parseInt(cursor.valueBuffer("intervalotrab")) + tiempo;
			cursor.setValueBuffer("intervalotrab", acumuladoTrab);
			this.child("lblAcumuladoTrab").text = this.iface.formatearTiempo(acumuladoTrab);
			break;
		}
		default: {
			break;
		}
	}
}

function prod_calcularTiempo(cursor:FLSqlCursor):Number
{
	var util:FLUtil = new FLUtil;
// 	var cursor:FLSqlCursor = this.cursor();

	var ahora:Date = new Date;
	var tiempoAhora:Number = ahora.getTime();
	var inicio:String = cursor.valueBuffer("iniciocuentaf").toString().left(11) + cursor.valueBuffer("iniciocuentat").toString().right(8);
	var tiempoInicio:Number = Date.parse(inicio);
	var intervalo:Number = tiempoAhora - tiempoInicio;
	intervalo = Math.round(intervalo / 1000);

	return intervalo;
}

function prod_mostrarTiempo()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var subestado:String = cursor.valueBuffer("subestado");
	var tiempo:Number = this.iface.calcularTiempo(cursor);
	switch (subestado) {
		case util.translate("scripts", "PREPARACIÓN EN CURSO"): {
			this.child("lblTiempoPreparacion").text = this.iface.formatearTiempo(tiempo);
			var acumuladoPrep:Number = parseInt(cursor.valueBuffer("intervaloprep")) + tiempo;
			this.child("lblAcumuladoPrep").text = this.iface.formatearTiempo(acumuladoPrep);
			break;
		}
		case util.translate("scripts", "TRABAJO EN CURSO"): {
			this.child("lblTiempoTrabajo").text = this.iface.formatearTiempo(tiempo);
			var acumuladoTrab:Number = parseInt(cursor.valueBuffer("intervalotrab")) + tiempo;
			this.child("lblAcumuladoTrab").text = this.iface.formatearTiempo(acumuladoTrab);
			break;
		}
	}
}

function prod_borrarTemporizadores()
{
	killTimers();
}

function prod_formatearTiempo(s:Number):String
{
	var remHoras:Number = s % 3600;
	var h:Number = Math.floor(s / 3600);
	s -= h * 3600;
	var m:Number = Math.floor(s / 60);
	s -= m * 60;
	var tiempo:String = flfacturac.iface.pub_cerosIzquierda(h, 3) + ":" + flfacturac.iface.pub_cerosIzquierda(m, 2) + ":" + flfacturac.iface.pub_cerosIzquierda(s, 2);
	return tiempo;
}
//// PRODUCCION /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

