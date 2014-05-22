
/** @class_declaration siagal */
/////////////////////////////////////////////////////////////////
//// SIAGAL /////////////////////////////////////////////////////

class siagal extends oficial {
		function siagal( context ) { oficial ( context ); }
		function controlCosteMedio(idFactura:String):Boolean {
		return this.ctx.siagal_controlCosteMedio(idFactura);
		}
		function generarFactura(where:String, curAlbaran:FLSqlCursor, datosAgrupacion):Number {
		return this.ctx.siagal_generarFactura(where, curAlbaran, datosAgrupacion);
		}
		function cargarArrayCosteMedio(idFactura:String):Array {
		return this.ctx.siagal_cargarArrayCosteMedio(idFactura);
		}
}

//// SIAGAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition siagal */
/////////////////////////////////////////////////////////////
//// SIAGAL /////////////////////////////////////////////////

/** \D Compara los datos de cálculo de coste medio inicial y final, para llamar a la función de recálculo en los casos en los que estos han cambiado
@param cursor: Cursor de la tabla que contiene los valores de los criterios de búsqueda
\end */
function siagal_controlCosteMedio(idFactura:String):Boolean
{
	if (!sys.isLoadedModule("flfactalma")) {
		return true;
	}
//debug (">>> SIAGAL_controlCosteMedio ahí le andamos idFactura" + idFactura);
	var util:FLUtil = new FLUtil;
	//var cursor:FLSqlCursor = this.cursor();

	var arrayActual:Array = this.iface.cargarArrayCosteMedio(idFactura);
	if (!arrayActual) {
		MessageBox.warning(util.translate("scripts", "Error al cargar los datos de coste medio"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	//var arrayAfectados:Array = flfacturac.iface.pub_arrayCostesAfectados(this.iface.arrayCosteM_, arrayActual);
	//if (!arrayAfectados) {
	//	return false;
	//}
	for (var i:Number = 0; i < arrayActual.length; i++) {
//debug (">>> SIAGAL_controlCosteMedio Array[" + i + "] = " + arrayActual[i]["idarticulo"]);
		if (!flfactalma.iface.pub_cambiarCosteMedio(arrayActual[i]["idarticulo"])) {
			return false;
		}
	}
//debug (">>> SIAGAL_controlCosteMedio ahí SALIMOS ");
	return true;
}

/** \D
Genera la factura asociada a uno o más albaranes
@param where: Sentencia where para la consulta de búsqueda de los albaranes a agrupar
@param curAlbaran: Cursor con los datos principales que se copiarán del albarán a la factura
@param datosAgrupacion: Array con los datos indicados en el formulario de agrupación de albaranes
@return True: Copia realizada con éxito, False: Error
\end */
function siagal_generarFactura(where:String, curAlbaran:FLSqlCursor, datosAgrupacion:Array):Number
{
//debug(">> SIAGAL generarFactura");
	if (!this.iface.curFactura)
		this.iface.curFactura = new FLSqlCursor("facturasprov");

	this.iface.curFactura.setModeAccess(this.iface.curFactura.Insert);
	this.iface.curFactura.refreshBuffer();
//debug(">> SIAGAL generarFactura 2");
	if (!this.iface.datosFactura(curAlbaran, where, datosAgrupacion)) {
		return false;
	}

	if (!this.iface.curFactura.commitBuffer()) {
		return false;
	}
	var idFactura:Number = this.iface.curFactura.valueBuffer("idfactura");

	var curAlbaranes:FLSqlCursor = new FLSqlCursor("albaranesprov");
	curAlbaranes.select(where);
	var idAlbaran:Number;
	while (curAlbaranes.next()) {
		curAlbaranes.setModeAccess(curAlbaranes.Edit);
		curAlbaranes.refreshBuffer();
		idAlbaran = curAlbaranes.valueBuffer("idalbaran");
		if (!this.iface.copiaLineasAlbaran(idAlbaran, idFactura))
			return false;

		curAlbaranes.setValueBuffer("idfactura", idFactura);
		curAlbaranes.setValueBuffer("ptefactura", false);
		if (!curAlbaranes.commitBuffer())
			return false;
	}

	this.iface.curFactura.select("idfactura = " + idFactura);
	if (this.iface.curFactura.first()) {
/*
		if (!formRecordfacturasprov.iface.pub_actualizarLineasIva(idFactura))
			return false;
*/

		this.iface.curFactura.setModeAccess(this.iface.curFactura.Edit);
		this.iface.curFactura.refreshBuffer();

		if (!this.iface.totalesFactura())
			return false;

		if (this.iface.curFactura.commitBuffer() == false)
			return false;
	}

	if (idFactura) {
		if (!this.iface.controlCosteMedio(idFactura)) {
			MessageBox.warning(util.translate("scripts", "Error al calcular los precios de coste medio."), MessageBox.Ok, MessageBox.NoButton);
		}
	}

//debug(">>>SIAGAL antes de retornar idFactura=" + idFactura);

	return idFactura;

}


/** \D Carga una array con los datos que afectan al cálculo del coste medio de todas las líneas de la factura
\end */
function siagal_cargarArrayCosteMedio(idFactura:String):Array
{
	if (!sys.isLoadedModule("flfactalma")) {
		return true;
	}
//debug(">>> SIAGAL cargarArrayCosteMedio")
	var util:FLUtil = new FLUtil;
	var arrayCoste:Array = [];

	var qryCoste:FLSqlQuery = new FLSqlQuery;
	qryCoste.setTablesList("facturasprov,lineasfacturasprov");
	qryCoste.setSelect("lf.referencia, lf.pvptotal, lf.cantidad");
	qryCoste.setFrom("facturasprov f INNER JOIN lineasfacturasprov lf ON f.idfactura = lf.idfactura");
	qryCoste.setWhere("f.idfactura = " + idFactura + " AND lf.referencia IS NOT NULL");
	qryCoste.setForwardOnly(true);
	if (!qryCoste.exec()) {
//debug(">>> SIAGAL No hay QUERY")
		return false;
	}
	var i:Number = 0;
	while (qryCoste.next()) {
		arrayCoste[i] = [];
		arrayCoste[i]["idarticulo"] = qryCoste.value("lf.referencia");
		arrayCoste[i]["pvptotal"] = qryCoste.value("lf.pvptotal");
		arrayCoste[i]["cantidad"] = qryCoste.value("lf.cantidad");
//debug(">>> SIAGAL cargarArrayCosteMedio arrayCoste  Índice Referencia Pvptotal Cantidad")
//debug(">>> SIAGAL cargarArrayCosteMedio arrayCoste    " + i + "        " + qryCoste.value("lf.referencia") + "        " + qryCoste.value("lf.pvptotal") + "        " + qryCoste.value("lf.cantidad"))

		i++;
	}
	return arrayCoste;
}

//// SIAGAL /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////

