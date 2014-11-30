
/** @class_declaration preciEspeCli */
//////////////////////////////////////////////////////////////////
//// PRECIESPECLI ////////////////////////////////////////////////
class preciEspeCli extends serviciosCli {
    function preciEspeCli( context ) { serviciosCli ( context ); }
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
		default:{
			valor = this.iface.__commonCalculateField(fN, cursor);
			}
		}
	
	return valor;
}


//// PRECIESPECLI ////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

