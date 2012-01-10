
/** @class_declaration megarOil */
//////////////////////////////////////////////////////////////////
//// MEGAROIL ////////////////////////////////////////////////////////////////
class megarOil extends oficial {
	function megarOil( context ) { oficial( context ); }
	function init() { this.ctx.megarOil_init(); }
	function commonBufferChanged(fN:String, miForm:Object) {
		return this.ctx.megarOil_commonBufferChanged(fN, miForm);
	}
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.megarOil_commonCalculateField(fN, cursor);
	}
}
//// MEGAROIL ////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition megarOil */
/////////////////////////////////////////////////////////////////
//// MEGAROIL ////////////////////////////////////////////////////////////////

function megarOil_init()
{
	this.iface.__init();

	var cursor:FLSqlCursor = this.cursor();

	if (cursor.modeAccess() == cursor.Insert) {
		// KLO. Añadido para dto lineal.
		this.child("fdbDtoLineal").setValue(this.iface.calculateField("dtolineal"));
		// KLO. Para el nº de líneas.
		var util:FLUtil = new FLUtil();
		var sigNum:Number = util.sqlSelect("lineaspedidoscli", "max(numlinea)", "idpedido = "  + cursor.valueBuffer("idpedido"));
		if (!sigNum) sigNum = 0;
		sigNum = parseInt(sigNum);
		sigNum += 1;
		cursor.setValueBuffer("numlinea", sigNum);
	}

	if (cursor.modeAccess() == cursor.Edit) {
		var label:String = this.child("lblPvpConIva");
		label.setText(this.iface.commonCalculateField("pvpconiva",cursor));
	}
}

function megarOil_commonBufferChanged(fN:String, miForm:Object)
{
	var label:String = miForm.child("lblPvpConIva");

	// KLO. Este procedimiento se ajusta para que el descuento lineal se aplique por cantidad del artículo y no a la línea en general.
	switch (fN) {
		case "referencia":{
			miForm.child("fdbPvpUnitario").setValue(this.iface.commonCalculateField("pvpunitario", miForm.cursor()));
			miForm.child("fdbCodImpuesto").setValue(this.iface.commonCalculateField("codimpuesto", miForm.cursor()));
			miForm.child("lblDtoPor").setText(this.iface.commonCalculateField("lbldtopor", miForm.cursor()));
			miForm.child("fdbDtoLineal").setValue(this.iface.commonCalculateField("dtolineal", miForm.cursor()));
			miForm.child("fdbPvpTotal").setValue(this.iface.commonCalculateField("pvptotal", miForm.cursor()));
			label.setText(this.iface.commonCalculateField("pvpconiva", miForm.cursor()));
			break;
		}
		case "cantidad":
			case "pvpunitario":{
				miForm.child("fdbPvpSinDto").setValue(this.iface.commonCalculateField("pvpsindto", miForm.cursor()));
				miForm.child("fdbDtoLineal").setValue(this.iface.commonCalculateField("dtolineal", miForm.cursor()));
				miForm.child("fdbPvpTotal").setValue(this.iface.commonCalculateField("pvptotal", miForm.cursor()));
				break;
			}
		case "pvpsindto":
			case "dtopor":{
				miForm.child("lblDtoPor").setText(this.iface.commonCalculateField("lbldtopor", miForm.cursor()));
				miForm.child("fdbPvpTotal").setValue(this.iface.commonCalculateField("pvptotal", miForm.cursor()));
				break;
			}
			default:{
				valor = this.iface.__commonBufferChanged(fN, miForm);
				break;
			}
	}
}

function megarOil_commonCalculateField(fN:String, cursor:FLSqlCursor):String
{
	var util:FLUtil = new FLUtil();
	var datosTP:Array = this.iface.datosTablaPadre(cursor);
	if (!datosTP)
		return false;
	var wherePadre:String = datosTP.where;
	var tablaPadre:String = datosTP.tabla;

	var valor:String;

	switch (fN) {
		case "pvpunitario":{
			var codCliente:String = util.sqlSelect(tablaPadre, "codcliente", wherePadre);
			var referencia:String = cursor.valueBuffer("referencia");
			var fecha:String = util.sqlSelect(tablaPadre, "fecha", wherePadre);

			// Mira el precio para la fecha del documento.
			valor = util.sqlSelect("lineasarticuloslp", "pvp", "referencia = '" + referencia + "' AND fecha = '" + fecha + "'");

			// Si no hay precio creado en la fecha del documento, lo crea con el precio de la fecha anterior más próxima o el normal.
			if (!valor || valor == 0) {
				var curLineasArticulosLP = new FLSqlCursor("lineasarticuloslp");
				curLineasArticulosLP.select("referencia = '" + referencia + "' AND fecha <= '" + fecha + "' ORDER BY fecha DESC");
				if (curLineasArticulosLP.first())
					valor = curLineasArticulosLP.valueBuffer("pvp");
				// Si no tiene precio adjudicado, lo mira normalmente.
				if (!valor)
				{
					var codTarifa:String = this.iface.obtenerTarifa(codCliente);
					if (codTarifa)
						valor = util.sqlSelect("articulostarifas", "pvp", "referencia = '" + referencia + "' AND codtarifa = '" + codTarifa + "'");
					if (!valor)
						valor = util.sqlSelect("articulos", "pvp", "referencia = '" + referencia + "'");
				}
				var tasaConv:Number = util.sqlSelect(tablaPadre, "tasaconv", wherePadre);
				valor = parseFloat(valor) / tasaConv;
				// Crea el registro y le asigna los valores.
				var curLineasALP = new FLSqlCursor("lineasarticuloslp");
				curLineasALP.setModeAccess(curLineasALP.Insert);
				curLineasALP.refreshBuffer();
				curLineasALP.setValueBuffer("referencia", referencia);
				curLineasALP.setValueBuffer("fecha", fecha);
				curLineasALP.setValueBuffer("pvp", valor);
				curLineasALP.commitBuffer();
				//---
			}
			break;
		}
		case "pvpsindto":{
			valor = parseFloat(cursor.valueBuffer("pvpunitario")) * parseFloat(cursor.valueBuffer("cantidad"));
			valor = util.roundFieldValue(valor, "lineaspedidoscli", "pvpsindto");
			break;
		}
		case "dtolineal":{
			var codCliente:String = util.sqlSelect(tablaPadre, "codcliente", wherePadre);
			var referencia:String = cursor.valueBuffer("referencia");
			var codFamilia:String = util.sqlSelect("articulos", "codfamilia", "referencia = '"+referencia+"'");
			valor = flfactppal.iface.pub_valorQuery("descuentosclientes,descuentos", "SUM(d.dtolineal)", "descuentosclientes dc INNER JOIN descuentos d ON dc.coddescuento = d.coddescuento", "dc.codcliente = '" + codCliente + "';");
			debug("Dto lineal normal: "+valor);
			// Ademas del descuento que tenga puesto, calcula y añade el acumulado.
			valor = parseFloat(valor) + formRecordclientes.iface.pub_calculaDtoLinealAgrupado(codCliente, codFamilia);
			debug("Dto lineal acumulado + normal: "+valor);
			valor = parseFloat(valor)*parseFloat(cursor.valueBuffer("cantidad"));
			break;
		}
		case "pvpconiva":{
			var iva:Number = parseFloat(cursor.valueBuffer("iva"));
			valor = ((iva/100)*cursor.valueBuffer("pvpunitario"))+parseFloat(cursor.valueBuffer("pvpunitario"));
			debug("VALOR: "+valor);
			valor = util.roundFieldValue(valor, "articulos", "pvp");
			break;
		}
		case "recargo":{
			var codCliente:String = util.sqlSelect(tablaPadre, "codcliente", wherePadre);
			var aplicarRecEq:Boolean = util.sqlSelect("clientes", "recargo", "codcliente = '" + codCliente + "'");
			if (aplicarRecEq == true) {
				valor = parseFloat(util.sqlSelect("impuestos", "recargo", "codimpuesto = '" + cursor.valueBuffer("codimpuesto") + "'"));
			} else {
				valor = 0;
			}
			if (isNaN(valor)) {
				valor = 0;
			}
			break;
		}
		default:{
			valor = this.iface.__commonCalculateField(fN, cursor);
			break;
		}
	}
	return valor;
}

//// MEGAROIL ////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

