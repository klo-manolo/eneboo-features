
/** @class_declaration preciEspeCli */
//////////////////////////////////////////////////////////////////
//// PRECIESPECLI ////////////////////////////////////////////////
class preciEspeCli extends oficial {
    function preciEspeCli( context ) { oficial ( context ); }
        function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
                return this.ctx.preciEspeCli_commonCalculateField(fN, cursor);
        }
}

//// PRECIESPECLI ////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition preciEspeCli */
//////////////////////////////////////////////////////////////////
//// PRECIESPECLI ////////////////////////////////////////////////
function preciEspeCli_commonCalculateField(fN, cursor)
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
			var codCliente:String = datosTP["codcliente"];
			var referencia:String = cursor.valueBuffer("referencia");
			var pvp:Number = cursor.valueBuffer("pvp");
			var codTarifa:String = this.iface.obtenerTarifa(codCliente, cursor);
			if (codTarifa) {
				valor = util.sqlSelect("articulostarifas", "pvp", "referencia = '" + referencia + "' AND codtarifa = '" + codTarifa + "'");
			}
			if (!valor) {
				valor = util.sqlSelect("articulosclientes", "pvp", "referencia = '" + referencia + "' AND codcliente = '" + codCliente + "'");
				debug("Precio especial nivel Articulo("+ referencia +") - Cliente (" + codCliente + ") = ("+pvp+")");
			}
			if (!valor) {
				valor = util.sqlSelect("articulos", "pvp", "referencia = '" + referencia + "'");
                debug("No hay precio especial ("+ referencia +") - Cliente (" + codCliente + ") = ("+pvp+")");
			}
			var tasaConv:Number = datosTP["tasaconv"];
			valor = parseFloat(valor) / tasaConv;
			debug("El valor final es ("+ valor +") ");
			break;
		}
		case "pvpsindto":{
			valor = parseFloat(cursor.valueBuffer("pvpunitario")) * parseFloat(cursor.valueBuffer("cantidad"));
			valor = util.roundFieldValue(valor, "lineaspedidoscli", "pvpsindto");
			break;
		}
		case "iva": {
			valor = flfacturac.iface.pub_campoImpuesto("iva", cursor.valueBuffer("codimpuesto"), datosTP["fecha"]);
			if (isNaN(valor)) {
				valor = "";
			}
			break;
		}
		case "lbldtopor":{
			valor = (cursor.valueBuffer("pvpsindto") * cursor.valueBuffer("dtopor")) / 100;
			valor = util.roundFieldValue(valor, "lineaspedidoscli", "pvpsindto");
			break;
		}
		case "pvptotal":{
			var dtoPor:Number = (cursor.valueBuffer("pvpsindto") * cursor.valueBuffer("dtopor")) / 100;
			dtoPor = util.roundFieldValue(dtoPor, "lineaspedidoscli", "pvpsindto");
			valor = cursor.valueBuffer("pvpsindto") - parseFloat(dtoPor) - cursor.valueBuffer("dtolineal");
			valor = util.roundFieldValue(valor, cursor.table(), "pvptotal");
			break;
		}
		case "dtopor":{
			var codCliente:String = datosTP["codcliente"];
			valor = flfactppal.iface.pub_valorQuery("descuentosclientes,descuentos", "SUM(d.dto)", "descuentosclientes dc INNER JOIN descuentos d ON dc.coddescuento = d.coddescuento", "dc.codcliente = '" + codCliente + "';");
			break;
		}
		case "recargo":{
			var codCliente:String = datosTP["codcliente"];;
			var aplicarRecEq:Boolean = util.sqlSelect("clientes", "recargo", "codcliente = '" + codCliente + "'");
			if (aplicarRecEq == true) {
				valor = flfacturac.iface.pub_campoImpuesto("recargo", cursor.valueBuffer("codimpuesto"), datosTP["fecha"]);
			} else {
				valor = "";
			}
			if (isNaN(valor)) {
				valor = "";
			}
			break;
		}
		case "codimpuesto": {
			var codCliente:String = datosTP["codcliente"];;
			var codSerie:String = datosTP["codserie"];;
			if (flfacturac.iface.pub_tieneIvaDocCliente(codSerie, codCliente)) {
				valor = util.sqlSelect("articulos", "codimpuesto", "referencia = '" + cursor.valueBuffer("referencia") + "'");
			} else {
				valor = "";
			}
			break;
		}
		case "porcomision": {
			var porComisionPadre:String = datosTP["porcomision"];
			if (porComisionPadre) {
				valor = "";
				break;
			}
			var codAgente:String = datosTP["codagente"];
			if (!codAgente || codAgente == "") {
				valor = "";
				break;
			}
			var comisionAgente:Number = flfacturac.iface.pub_calcularComisionLinea(codAgente,cursor.valueBuffer("referencia"));
			comisionAgente = util.roundFieldValue(comisionAgente, cursor.table(), "porcomision");
			valor = comisionAgente.toString();
			break;
		}
		case "lblComision": {
			var porComision:Number = parseFloat(cursor.valueBuffer("porcomision"));
			if (!porComision) {
				break;
			}
			var pvpTotal:Number = parseFloat(cursor.valueBuffer("pvptotal"));
			var comision:Number = (porComision * pvpTotal) / 100;
			comision = util.roundFieldValue(comision, cursor.table(), "pvptotal");
			valor = comision.toString();
			break;
		}
	}
	return valor;
}


//// PRECIESPECLI ////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

