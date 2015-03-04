
/** @class_declaration eFactura */
/////////////////////////////////////////////////////////////////
//// EFACTURA ///////////////////////////////////////////////////
class eFactura extends oficial /** %from: oficial */ {
	var informeEFactura_:String;
	var curFacturae:FLSqlCursor;
	var curLineaFacturae:FLSqlCursor;

	var tbnEFactura:Object;
    function eFactura( context ) { oficial ( context ); }
	function init() {
		return this.ctx.eFactura_init();
	}
	function cargarEFactura_clicked() {
		return this.ctx.eFactura_cargarEFactura_clicked();
	}
	function cargarEFactura(xml:FLDomDocument):String {
		return this.ctx.eFactura_cargarEFactura(xml);
	}
// 	function valorNodoHijo(nombreNodo:String, nodoPadre:FLDomNode):String {
// 		return this.ctx.eFactura_valorNodoHijo(nombreNodo, nodoPadre);
// 	}
//
	function procesarFileHeaderType(nodoPadre:FLDomNode, nombreNodo:String, version:String):Array {
		return this.ctx.eFactura_procesarFileHeaderType(nodoPadre, nombreNodo, version);
	}
// 	function procesarPartiesType(nodoPadre:FLDomNode, nombreNodo:String, version:String):Array {
// 		return this.ctx.eFactura_procesarPartiesType(nodoPadre, nombreNodo, version);
// 	}
// 	function procesarEmpresaType(nodoPadre:FLDomNode, nombreNodo:String, version:String):Array {
// 		return this.ctx.eFactura_procesarEmpresaType(nodoPadre, nombreNodo, version);
// 	}
// 	function procesarTaxIdentificationType(nodoPadre:FLDomNode, nombreNodo:String, version:String):Array {
// 		return this.ctx.eFactura_procesarTaxIdentificationType(nodoPadre, nombreNodo, version);
// 	}
// 	function procesarNodoFacturae(nodoPadre:FLDomNode, nombreNodo:String, version:String):Array {
// 		return this.ctx.eFactura_procesarNodoFacturae(nodoPadre, nombreNodo, version);
// 	}
	function informeEFactura(texto:String):Boolean {
		return this.ctx.eFactura_informeEFactura(texto);
	}
	function valorNodo(nodoPadre:FLDomNode, ruta:String):String {
		return this.ctx.eFactura_valorNodo(nodoPadre, ruta);
	}
	function datosClienteFacturae(nodoFacturae:FLDomNode):Array {
		return this.ctx.eFactura_datosClienteFacturae(nodoFacturae);
	}
	function datosProveedorFacturae(nodoFacturae:FLDomNode):Array {
		return this.ctx.eFactura_datosProveedorFacturae(nodoFacturae);
	}
	function cargarCabeceraFacturae(nodoInvoice:FLDomNode):Array {
		return this.ctx.eFactura_cargarCabeceraFacturae(nodoInvoice);
	}
	function generarFacturae(nodoInvoice:FLDomNode, datosProveedor:Array, version:String):String {
		return this.ctx.eFactura_generarFacturae(nodoInvoice, datosProveedor, version);
	}
	function datosFacturae(cabecera:Array, proveedor:Array, version:String):String {
		return this.ctx.eFactura_datosFacturae(cabecera, proveedor, version);
	}
	function generarLineaFacturae(idFactura:String, nodoInvoiceLine:FLDomNode, version:String):Number {
		return this.ctx.eFactura_generarLineaFacturae(idFactura, nodoInvoiceLine, version);
	}
	function datosLineaFacturae(nodoInvoiceLine:FLDomNode, version:String):String {
		return this.ctx.eFactura_datosLineaFacturae(nodoInvoiceLine, version);
	}
	function totalesFacturae(cabecera:Array):String {
		return this.ctx.eFactura_totalesFacturae(cabecera);
	}
	function comprobarFirma(xml:FLDomDocument):Boolean {
		return this.ctx.eFactura_comprobarFirma(xml);
	}
}
//// EFACTURA ///////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition eFactura */
/////////////////////////////////////////////////////////////////
//// EFACTURA ///////////////////////////////////////////////////
function eFactura_init()
{
	this.iface.__init();

	this.iface.tbnEFactura = this.child("tbnEFactura");
	connect(this.iface.tbnEFactura, "clicked()", this, "iface.cargarEFactura_clicked");
}

function eFactura_cargarEFactura_clicked()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = new FLSqlCursor("facturasprov");

	var nombreFichero:String = FileDialog.getOpenFileName();
	if (!nombreFichero)
		return;

	var cadenaXML:String = File.read(nombreFichero);
	var xml:FLDomDocument = new FLDomDocument();
	if (!xml.setContent(cadenaXML)) {
		MessageBox.warning(util.translate("scripts", "Error en el formato XML"), MessageBox.Ok, MessageBox.NoButton);
		return;
	}

// 	if (!this.iface.comprobarFirma(xml))
 //		return false;

	var facturas:String;
	cursor.transaction(false);
	try {
		facturas = this.iface.cargarEFactura(xml);
		if (facturas.startsWith("ERROR")) {
			cursor.rollback();
			MessageBox.warning(facturas, MessageBox.Ok, MessageBox.NoButton);
		} else {
			if (this.iface.informeEFactura_ != "") {
				var res:Number = MessageBox.information(this.iface.informeEFactura_ + util.translate("scripts", "¿Desea continuar?"), MessageBox.Yes, MessageBox.No);
				if (res == MessageBox.Yes) {
					cursor.commit();
				} else {
					cursor.rollback();
				}
			} else {
				cursor.commit();
			}
		}
	} catch (e) {
		cursor.rollback();
		MessageBox.critical(util.translate("scripts", "Hubo un error al cargar la factura: ") + e, MessageBox.Ok, MessageBox.NoButton);
	}
	if (!facturas.startsWith("ERROR")) {
		MessageBox.information(util.translate("scripts", "Se han cargado las facturas %1").arg(facturas), MessageBox.Ok, MessageBox.NoButton);
		this.iface.tdbRecords.refresh();
	}
}

function eFactura_cargarEFactura(xml:FLDomDocument):String
{
	var util:FLUtil = new FLUtil;

	this.iface.informeEFactura_ = "";

	var nodoFacturae:FLDomNode = xml.namedItem("Facturae");
	if (!nodoFacturae) {
		nodoFacturae = xml.namedItem("namespace:Facturae");
		if (!nodoFacturae) {
			nodoFacturae = xml.namedItem("fe:Facturae");
			if (!nodoFacturae) {
				return util.translate("scripts", "ERROR: Error al procesar el fichero.\nNo existe un nodo raíz <Facturae>");
			}
		}
	}
	var datosCabecera:Array = this.iface.procesarFileHeaderType(nodoFacturae, "FileHeader");
	if (datosCabecera["error"] != "OK")
		return datosCabecera["error"];
	var datosCliente:Array = this.iface.datosClienteFacturae(nodoFacturae);
	if (datosCliente["error"] != "OK")
		return datosCliente["error"];

	var datosProveedor:Array = this.iface.datosProveedorFacturae(nodoFacturae);
	if (datosProveedor["error"] != "OK")
		return datosProveedor["error"];

	var nodoInvoices:FLDomNode = nodoFacturae.namedItem("Invoices");
	if (!nodoInvoices) {
		return util.translate("scripts", "ERROR: Error al procesar el fichero.\nNo existe un nodo <Invoices>");
	}

	var facturas:String = "";
	for (var nodoInvoice:FLDomNode = nodoInvoices.firstChild(); nodoInvoice; nodoInvoice = nodoInvoice.nextSibling()) {
		if (nodoInvoice.nodeName() != "Invoice") {
			continue;
		}
		var codFactura:String = this.iface.generarFacturae(nodoInvoice, datosProveedor, datosCabecera["version"]);
		if (codFactura.startsWith("ERROR"))
			return codFactura;

		facturas += "\n" + codFactura;
	}

	return facturas;
}

function eFactura_cargarCabeceraFacturae(nodoInvoice:FLDomNode):Array
{
	var util:FLUtil = new FLUtil;
	var datos:Array = [];
	datos["error"] = "OK";
	var sufijoError:String = util.translate("scripts", "ERROR: Error al procesar la cabecera de la factura");

	datos["numero"] = this.iface.valorNodo(nodoInvoice, "InvoiceHeader/InvoiceNumber");
	if (!datos["numero"]) {
		datos["error"] = sufijoError;
		return datos;
	}

	datos["fecha"] = this.iface.valorNodo(nodoInvoice, "InvoiceIssueData/IssueDate");
	if (!datos["fecha"]) {
		datos["error"] = sufijoError;
		return datos;
	}

	datos["coddivisa"] = this.iface.valorNodo(nodoInvoice, "InvoiceIssueData/InvoiceCurrencyCode");
	if (!datos["coddivisa"]) {
		datos["error"] = sufijoError;
		return datos;
	}
	if (!util.sqlSelect("divisas", "coddivisa", "coddivisa = '" + datos["coddivisa"] + "'")) {
		datos["error"] = util.translate("scripts", "ERROR: La divisa %1 no está incluida en la tabla de Divisas. Debe incluirla en el módulo principal de facturación.").arg(datos["coddivisa"]) + sufijoError;
		return datos;
	}

	var codDivisaEmpresa:String = flfactppal.iface.pub_valorDefectoEmpresa("coddivisa");
	if (codDivisaEmpresa == datos["coddivisa"]) {
		datos["tasaconv"] = 1;
	} else {
		datos["tasaconv"] = this.iface.valorNodo(nodoInvoice, "InvoiceIssueData/ExchangeRateDetails/ExchangeRate");
		if (!datos["tasaconv"]) {
			datos["error"] = util.translate("scripts", "ERROR: La moneda de la factura (%1) es distinta de la moneda de la empresa (%2).\nEs necesario un nodo ExchangeRate que especifique la tasa de cambio aplicada.").arg(datos["coddivisa"]).arg(codDivisaEmpresa) + sufijoError;
			return datos;
		}
	}

	datos["totaliva"] = 0;
	datos["totalrecargo"] = 0;
	var nodoTaxesOutputs:FLDomNode = nodoInvoice.namedItem("TaxesOutputs");
	if (nodoTaxesOutputs) {
		for (var nodoTax:FLDomNode = nodoTaxesOutputs.firstChild(); nodoTax; nodoTax = nodoTax.nextSibling()) {
			if (nodoTax.nodeName() != "Tax") {
				continue;
			}

			switch (this.iface.valorNodo(nodoTax, "TaxTypeCode")) {
				case "01": // IVA
				case "03": { // IGIC
					valor = this.iface.valorNodo(nodoTax, "TaxAmount");
					if (isNaN(valor))
						return util.translate("scripts", "No existe el nodo TaxAmount");
					datos["totaliva"] += parseFloat(valor);
					break;
				}
				default: {
					datos["error"] = util.translate("scripts", "ERROR: El código de impuesto repercutido no es 01 (IVA) ni 03 (IGIC)") + ufijoError;
					return datos;
				}
			}
		
		
			var ruta:String = "EquivalenceSurchargeAmount";
	var nombreNodo:Array = ruta.split("/");
	var nodoXML:FLDomNode = nodoTax;
	for (var i:Number = 0; i < nombreNodo.length; i++) {
		nodoXML = nodoXML.namedItem(nombreNodo[i]);
			if (!nodoXML) 
				datos["totalrecargo"] = 0;
			else
				datos["totalrecargo"] += this.iface.valorNodo(nodoTax, "EquivalenceSurchargeAmount");
			}
		}
	}









	datos["totalirpf"] = 0;
	datos["irpf"] = 0;
	var nodoTaxesWithheld:FLDomNode = nodoInvoice.namedItem("TaxesWithheld");
	if (nodoTaxesWithheld) {
		for (var nodoTax:FLDomNode = nodoTaxesWithheld.firstChild(); nodoTax; nodoTax = nodoTax.nextSibling()) {
			if (nodoTax.nodeName() != "Tax") {
				continue;
			}

			switch (this.iface.valorNodo(nodoTax, "TaxTypeCode")) {
				case "04": { // IRPF
					valor = this.iface.valorNodo(nodoTax, "TaxAmount");
					if (isNaN(valor))
						return util.translate("scripts", "No existe el nodo TaxAmount");
					datos["totalirpf"] += parseFloat(valor);

					valor = this.iface.valorNodo(nodoTax, "TaxRate");
					if (isNaN(valor))
						return util.translate("scripts", "No existe el nodo TaxRate");
					datos["irpf"] += parseFloat(valor);
					break;
				}
				default: {
					datos["error"] = util.translate("scripts", "ERROR: El código de impuesto retemodp no es 04 (IRPF)") + ufijoError;
					return datos;
				}
			}
		}
	}

	datos["neto"] = this.iface.valorNodo(nodoInvoice, "InvoiceTotals/TotalGrossAmountBeforeTaxes");
	if (!datos["neto"]) {
		datos["error"] = util.translate("scripts", "ERROR: El nodo <TotalGrossAmountBeforeTaxes> no existe.") + sufijoError;
		return datos;
	}

	datos["total"] = this.iface.valorNodo(nodoInvoice, "InvoiceTotals/TotalExecutableAmount");
	if (!datos["total"]) {
		datos["error"] = util.translate("scripts", "ERROR: El nodo <TotalExecutableAmount> no existe.") + sufijoError;
		return datos;
	}

	return datos;
}

function eFactura_datosProveedorFacturae(nodoFacturae:FLDomNode):Array
{
	var util:FLUtil = new FLUtil;
	var datos:Array = [];
	datos["error"] = "OK";
	var sufijoError:String = "\n" + util.translate("scripts", "Proceso de datos de proveedor");

	datos["idproveedor"] = this.iface.valorNodo(nodoFacturae, "Parties/SellerParty/TaxIdentification/TaxIdentificationNumber");
	if (!datos["idproveedor"]) {
		datos["error"] = util.translate("scripts", "ERROR: No existe el nodo <TaxIdentificationNumber>") + sufijoError;
		return datos;
	}
	datos["codpaisiso"] = "es";
	datos["cifnif"] = datos["idproveedor"];

	datos["tipopersona"] = this.iface.valorNodo(nodoFacturae, "Parties/SellerParty/TaxIdentification/PersonTypeCode");
	if (!datos["tipopersona"]) {
		datos["error"] = util.translate("scripts", "ERROR: No existe el nodo <PersonTypeCode>") + sufijoError;
		return datos;
	}

	var whereProveedor:String = "cifnif = '" + datos["cifnif"] + "'";
	if (datos["tipopersona"] == "J") {
		datos["nombre"] = this.iface.valorNodo(nodoFacturae, "Parties/SellerParty/LegalEntity/CorporateName");
		if (!datos["nombre"]) {
			datos["error"] = util.translate("scripts", "ERROR: No existe el nodo <CorporateName>") + sufijoError;
			return datos;
		}
		whereProveedor += " OR UPPER(nombre) = '" + datos["nombre"].toUpperCase() + "'";
	} else {
		datos["error"] = util.translate("scripts", "ERROR: La versión actual no soporta emisores de factura que son persona física") + sufijoError;
		return datos;
	}

	var qryProveedor:FLSqlQuery = new FLSqlQuery;
	with (qryProveedor) {
		setTablesList("proveedores");
		setSelect("codproveedor, nombre, cifnif");
		setFrom("proveedores");
		setWhere(whereProveedor);
		setForwardOnly(true);
	}
	if (!qryProveedor.exec()) {
		datos["error"] = util.translate("scripts", "ERROR: Error al buscar proveedores") + sufijoError;
		return datos;
	}

	if (qryProveedor.size() > 1) {
		var mensaje:String = util.translate("scripts", "ERROR: La búsqueda de proveedores con CIF/NIF %1 y nombre %2 ha devuelto más de un resultado:").arg(datos["cifnif"]).arg(datos["nombre"]);
		while (qryProveedor.next()) {
			mensaje += "\nCIF/NIF: " + qryProveedor.value("cifnif") + ": " + qryProveedor.value("nombre") + "(" + qryProveedor.value("codproveedor") + ")";
		}
		mensaje += "\n" + util.translate("scripts", "Debe corregir los datos de proveedores para resolver la ambigüedad");

		datos["error"] = mensaje + sufijoError;
		return datos;
	} else if (qryProveedor.size() == 1) {
		if (!qryProveedor.first()) {
			datos["error"] = util.translate("scripts", "ERROR: Error en la consulta de proveedores") + sufijoError;
			return datos;
		}
		datos["codproveedor"] = qryProveedor.value("codproveedor");
		datos["nombre"] = qryProveedor.value("nombre");
	} else {
		this.iface.informeEFactura(util.translate("scripts", "AVISO: " + "No se ha encontrado el proveedor con CIF/NIF %1 y nombre %2.\nLa factura no se asociará a ningún proveedor ya existente").arg(datos["cifnif"]).arg(datos["nombre"]))
		datos["codproveedor"] = false;
	}

	return datos;
}

function eFactura_datosClienteFacturae(nodoFacturae:FLDomNode):Array
{
	var util:FLUtil = new FLUtil;
	var datos:Array = [];
	datos["error"] = "OK";
	var sufijoError:String = "\n" + util.translate("scripts", "Procesar datos de cliente");

	datos["idcliente"] = this.iface.valorNodo(nodoFacturae, "Parties/BuyerParty/TaxIdentification/TaxIdentificationNumber");
	if (!datos["idcliente"]) {
		datos["error"] = util.translate("scripts", "ERROR: No existe el nodo <TaxIdentificationNumber>") + sufijoError;
		return datos;
	}

	datos["codpaisiso"] = "es";
	datos["cifnif"] = datos["idcliente"];

	datos["tipopersona"] = this.iface.valorNodo(nodoFacturae, "Parties/BuyerParty/TaxIdentification/PersonTypeCode");
	if (!datos["tipopersona"]) {
		datos["error"] = util.translate("sripts", "ERROR: No existe el nodo <PersonTypeCode>") + sufijoError;
		return datos;
	}

	if (datos["tipopersona"] == "J") {
		datos["nombre"] = this.iface.valorNodo(nodoFacturae, "Parties/SellerParty/LegalEntity/CorporateName");
		if (!datos["nombre"]) {
			datos["error"] = util.translate("scripts", "ERROR: No existe el nodo <CorporateName>") + sufijoError;
			return datos;
		}
	} else {
		datos["error"] = util.translate("scripts", "ERROR: La versión actual no soporta emisores de factura que son persona física") + sufijoError;
		return datos;
	}

	var nombreEmpresa:String = flfactppal.iface.pub_valorDefectoEmpresa("nombre");
	var cifNifEmpresa:String = flfactppal.iface.pub_valorDefectoEmpresa("cifnif");
	if (cifNifEmpresa != datos["cifnif"]) {
		datos["error"] = util.translate("scripts", "El NIF/CIF del comprador de la factura (%1) no coincide con el NIF/CIF de %2 (%3)").arg(datos["cifnif"]).arg(nombreEmpresa).arg(cifNifEmpresa) + sufijoError;
		return datos;
	}

	return datos;
}

function eFactura_valorNodo(nodoPadre:FLDomNode, ruta:String):String
{
	var util:FLUtil = new FLUtil;

	var valor:String;
	var nombreNodo:Array = ruta.split("/");
	var nodoXML:FLDomNode = nodoPadre;
	for (var i:Number = 0; i < nombreNodo.length; i++) {
		nodoXML = nodoXML.namedItem(nombreNodo[i]);
		if (!nodoXML) {
			MessageBox.warning(util.translate("scripts", "No se pudo leer el nodo de la ruta:\n%1.\nNo se encuentra el nodo <%2>").arg(ruta).arg(nombreNodo[i]), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
	}
	valor = nodoXML.toElement().text();
	return valor;
}

function eFactura_generarFacturae(nodoInvoice:FLDomNode, proveedor:Array, version:String):String
{
	var util:FLUtil = new FLUtil;
	var sufijoError:String;
	var ret:String;

	var cabecera:Array = this.iface.cargarCabeceraFacturae(nodoInvoice);
	if (cabecera["error"] != "OK") {
		return cabecera["error"];
	}
	sufijoError = "\n" + util.translate("scripts", "Factura %1").arg(cabecera["numero"]);

	if (proveedor["codproveedor"]) {
		var codRepetida:String = util.sqlSelect("facturasprov", "codigo", "codproveedor = '" + proveedor["codproveedor"] + "' AND numproveedor = '" + cabecera["numero"] + "'");
		if (codRepetida) {
			return util.translate("scripts", "ERROR: Ya existe una factura (%1) con número de proveedor %2 para el proveedor:\n%3 - %4").arg(codRepetida).arg(cabecera["numero"]).arg(proveedor["codproveedor"]).arg(proveedor["nombre"]) + sufijoError;
		}
	}

	if (!this.iface.curFacturae)
		this.iface.curFacturae = new FLSqlCursor("facturasprov");

	this.iface.curFacturae.setModeAccess(this.iface.curFacturae.Insert);
	this.iface.curFacturae.refreshBuffer();

	ret = this.iface.datosFacturae(cabecera, proveedor, version);
	if (ret.startsWith("ERROR"))
		return ret + sufijoError;

	if (!this.iface.curFacturae.commitBuffer()) {
		return util.translate("scripts", "ERROR: Error al guardar la factura") + sufijoError;
	}

	var idFactura:Number = this.iface.curFacturae.valueBuffer("idfactura");

	var nodoItems:FLDomNode = nodoInvoice.namedItem("Items");
	if (!nodoItems) {
		return util.translate("scripts", "Error al procesar el fichero.\nNo existe un nodo <Items>") + sufijoError;
	}

	var linea:Number = 0;
	for (var nodoInvoiceLine:FLDomNode = nodoItems.firstChild(); nodoInvoiceLine; nodoInvoiceLine= nodoInvoiceLine.nextSibling()) {
		if (nodoInvoiceLine.nodeName() != "InvoiceLine")
			continue;

		linea++;
		ret = this.iface.generarLineaFacturae(idFactura, nodoInvoiceLine, version);
		if (ret.toString().startsWith("ERROR"))
			return ret + sufijoError + "\n" + util.translate("scripts", "Línea %1").arg(linea);
	}

	this.iface.curFacturae.select("idfactura = " + idFactura);
	if (this.iface.curFacturae.first()) {
		this.iface.curFacturae.setModeAccess(this.iface.curFacturae.Edit);
		this.iface.curFacturae.refreshBuffer();

		ret = this.iface.totalesFacturae(cabecera)
		if (ret.startsWith("ERROR"))
			return ret + sufijoError;

		if (this.iface.curFacturae.commitBuffer() == false)
			return util.translate("scripts", "ERROR: error al guardar los totales") + sufijoError;
	}

	return this.iface.curFacturae.valueBuffer("codigo");
}

/** \D Informa los datos de una factura electrónica referentes a totales (I.V.A., neto, etc.)
@param	cabecera: Array con los valores de la cabecera de la factura
@return	True si el cálculo se realiza correctamente, false en caso contrario
\end */
function eFactura_totalesFacturae(cabecera:Array):String
{
	var util:FLUtil = new FLUtil;
	var sufijoError:String = "\n" + util.translate("scripts", "Cálculo de totales");

	var valor:Number;

	valor = formfacturasprov.iface.pub_commonCalculateField("neto", this.iface.curFacturae);
	if (valor != cabecera["neto"]) {
		return util.translate("scripts", "ERROR: El valor del neto (%1) no coincide con el cálculo de Abanq (%2)").arg(cabecera["neto"]).arg(valor) + sufijoError;
	}
	this.iface.curFacturae.setValueBuffer("neto", valor);

	valor = formfacturasprov.iface.pub_commonCalculateField("totaliva", this.iface.curFacturae);
	if (valor != cabecera["totaliva"]) {
		return util.translate("scripts", "ERROR: El valor del total de IVA (%1) no coincide con el cálculo de Abanq (%2)").arg(cabecera["totaliva"]).arg(valor) + sufijoError;
	}
	this.iface.curFacturae.setValueBuffer("totaliva", valor);

	valor = formfacturasprov.iface.pub_commonCalculateField("totalirpf", this.iface.curFacturae);
	if (valor != cabecera["totalirpf"]) {
		return util.translate("scripts", "ERROR: El valor del total de IRPF (%1) no coincide con el cálculo de Abanq (%2)").arg(cabecera["totalirpf"]).arg(valor) + sufijoError;
	}
	this.iface.curFacturae.setValueBuffer("totalirpf", valor);

	//valor = formfacturasprov.iface.pub_commonCalculateField("totalrecargo", this.iface.curFacturae);
	//if (valor != cabecera["totalrecargo"]) {
	//	return util.translate("scripts", "ERROR: El valor del total de recargo de equivalencia (%1) no coincide con el cálculo de Abanq (%2)").arg(cabecera["totalrecargo"]).arg(valor) + sufijoError;
	//}
	this.iface.curFacturae.setValueBuffer("totalrecargo", cabecera["totalrecargo"]);

	valor = formfacturasprov.iface.pub_commonCalculateField("total", this.iface.curFacturae);
	if (valor != cabecera["total"]) {
		return util.translate("scripts", "ERROR: El valor del total (%1) no coincide con el cálculo de Abanq (%2)").arg(cabecera["total"]).arg(valor) + sufijoError;
	}
	this.iface.curFacturae.setValueBuffer("total", valor);

	this.iface.curFacturae.setValueBuffer("totaleuros", formfacturasprov.iface.pub_commonCalculateField("totaleuros", this.iface.curFacturae));

	return "OK";
}

function eFactura_generarLineaFacturae(idFactura:String, nodoInvoiceLine:FLDomNode, version:String):Number
{
	var util:FLUtil = new FLUtil;
	var sufijoError:String;

	if (!this.iface.curLineaFacturae)
		this.iface.curLineaFacturae = new FLSqlCursor("lineasfacturasprov");

	with (this.iface.curLineaFacturae) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idfactura", idFactura);
	}

	var ret:String = this.iface.datosLineaFacturae(nodoInvoiceLine, version);
	if (ret.startsWith("ERROR"))
		return ret;

	if (!this.iface.curLineaFacturae.commitBuffer())
		return util.translate("scripts", "ERROR: Error al guardar la línea de factura");

	return this.iface.curLineaFacturae.valueBuffer("idlinea");
}

function eFactura_datosLineaFacturae(nodoInvoiceLine:FLDomNode, version:String):String
{
	var util:FLUtil = new FLUtil;
	var valor:String;
	var pvpTotal:Number;

	switch (version) {
		case "3.0": {
			this.iface.curLineaFacturae.setNull("referencia");
			break;
		}
		case "3.2": {
			valor = this.iface.valorNodo(nodoInvoiceLine, "ArticleCode");
			if (!valor)
				return util.translate("scripts", "No existe el nodo ArticleCode");
			this.iface.curLineaFacturae.setValueBuffer("referencia", valor);
			break;
		}
	}

	valor = this.iface.valorNodo(nodoInvoiceLine, "ItemDescription");
	if (!valor)
		return util.translate("scripts", "No existe el nodo ItemDescription");
	this.iface.curLineaFacturae.setValueBuffer("descripcion", valor);

	valor = this.iface.valorNodo(nodoInvoiceLine, "Quantity");
	if (isNaN(valor))
		return util.translate("scripts", "No existe el nodo Quantity");;
	this.iface.curLineaFacturae.setValueBuffer("cantidad", valor);

	valor = this.iface.valorNodo(nodoInvoiceLine, "UnitPriceWithoutTax");
	if (isNaN(valor))
		return util.translate("scripts", "No existe el nodo UnitPriceWithoutTax");
	this.iface.curLineaFacturae.setValueBuffer("pvpunitario", valor);

	valor = this.iface.valorNodo(nodoInvoiceLine, "TotalCost");
	if (isNaN(valor))
		return util.translate("scripts", "No existe el nodo TotalCost");
	this.iface.curLineaFacturae.setValueBuffer("pvpsindto", valor);

	var nodoDiscountsAndRebates:FLDomNode = nodoInvoiceLine.namedItem("DiscountsAndRebates");
	if (nodoDiscountsAndRebates) {
		var dtoLineal:Number = 0;
		for (var nodoDiscount:FLDomNode = nodoDiscountsAndRebates.firstChild(); nodoDiscount; nodoDiscount = nodoDiscount.nextSibling()) {
			if (nodoDiscount.nodeName() != "Discount")
				continue;

			valor = this.iface.valorNodo(nodoDiscount, "DiscountAmount");
			if (isNaN(valor))
				return util.translate("scripts", "No existe el nodo DiscountAmount");
			dtoLineal += parseFloat(valor);
		}
		this.iface.curLineaFacturae.setValueBuffer("dtolineal", dtoLineal);
	}

	valor = this.iface.valorNodo(nodoInvoiceLine, "GrossAmount");
	if (isNaN(valor))
		return util.translate("scripts", "No existe el nodo GrossAmount");
	this.iface.curLineaFacturae.setValueBuffer("pvptotal", valor);
	pvpTotal = valor;

	var nodoTaxesOutputs:FLDomNode = nodoInvoiceLine.namedItem("TaxesOutputs");
	if (nodoTaxesOutputs) {
		var porIva:Number = 0;
		for (var nodoTax:FLDomNode = nodoTaxesOutputs.firstChild(); nodoTax; nodoTax = nodoTax.nextSibling()) {
			if (nodoTax.nodeName() != "Tax")
				continue;

			if (this.iface.valorNodo(nodoTax, "TaxTypeCode") != "01") {
				return util.translate("scripts", "Error al procesar la línea de factura.\nEl código de impuesto no es 01 (IVA)");;
			}
			valor = this.iface.valorNodo(nodoTax, "TaxRate");
			if (isNaN(valor))
				return util.translate("scripts", "No existe el nodo TaxRate");
			porIva += parseFloat(valor);
		}
		this.iface.curLineaFacturae.setValueBuffer("iva", porIva);
	}

	this.iface.curLineaFacturae.setNull("codimpuesto");
	this.iface.curLineaFacturae.setNull("recargo");
	this.iface.curLineaFacturae.setNull("idalbaran");

	var pvpTotalCalculado:Number = formRecordlineaspedidosprov.iface.pub_commonCalculateField("pvptptal", this.iface.curLineaFacturae);
 	if (pvpTotal != pvpTotalCalculado) {
 		return util.translate("scripts", "Error: El total de la línea (%1) no coincide con el total calculado (%2)").arg(pvpTotal).arg(pvpTotalCalculado);
	}
	/** \C La subcuenta de compras asociada a cada línea será la establecida en la tabla de artículos
	\end
	if (sys.isLoadedModule("flcontppal") && referencia != "") {
		var codSubcuenta = util.sqlSelect("articulos", "codsubcuentacom", "referencia = '" + referencia + "'");
		if (codSubcuenta) {
			var ejercicioActual:String = flfactppal.iface.pub_ejercicioActual();
			var idSubcuenta:Number = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + codSubcuenta + "' AND codejercicio = '" + ejercicioActual + "'");
			if (!idSubcuenta) {
				MessageBox.warning(util.translate("scripts", "No existe la subcuenta de compras con código ") + codSubcuenta +  util.translate("scripts", " y ejercicio ") + ejercicioActual + ".\n" + util.translate("scripts", "Debe crear la subcuenta en el área Financiera."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				return false;
			}
			this.iface.curLineaFacturae.setValueBuffer("codsubcuenta", codSubcuenta);
			this.iface.curLineaFacturae.setValueBuffer("idsubcuenta", idSubcuenta);
		}
	}
	*/
	return "OK";
}



/** \D Informa los datos de una factura a partir un documento XML Facturae
@return	True si el cálculo se realiza correctamente, false en caso contrario
\end */
function eFactura_datosFacturae(cabecera:Array, proveedor:Array, version:String):String
{
	var util:FLUtil = new FLUtil;

	var fecha:String = cabecera["fecha"];
	var hora:String = fecha.right(8);

	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(fecha, codEjercicio, "facturasprov");
	if (!datosDoc.ok)
		return false;

	if (datosDoc.modificaciones == true) {
		if (fecha != datosDoc.fecha) {
			MessageBox.warning(util.translate("scripts", "No puede modificar la fecha de una factura electrónica"), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
		codEjercicio = datosDoc.codEjercicio;
		fecha = datosDoc.fecha;
	}

	var codSerie:String;
	if (proveedor["codproveedor"]) {
		codSerie = util.sqlSelect("proveedores", "codserie", "codproveedor = '" + proveedor["codproveedor"] + "'");
	} else {
		codSerie = flfactppal.iface.pub_valorDefectoEmpresa("codserie");
	}

	var codPago:String;
	if (proveedor["codproveedor"]) {
		codPago = util.sqlSelect("proveedores", "codpago", "codproveedor = '" + proveedor["codproveedor"] + "'");
	} else {
		codPago = flfactppal.iface.pub_valorDefectoEmpresa("codpago");
	}

	with (this.iface.curFacturae) {
		if (proveedor["codproveedor"])
			setValueBuffer("codproveedor", proveedor["codproveedor"]);
		setValueBuffer("nombre", proveedor["nombre"]);
		setValueBuffer("cifnif", proveedor["cifnif"]);
		setValueBuffer("coddivisa", cabecera["coddivisa"]);
		setValueBuffer("tasaconv", cabecera["tasaconv"]);
		setValueBuffer("recfinanciero", 0);
		setValueBuffer("codpago", codPago);
		setValueBuffer("codalmacen", flfactppal.iface.pub_valorDefectoEmpresa("codalmacen"));
		setValueBuffer("fecha", fecha);
		setValueBuffer("hora", hora);
		setValueBuffer("codejercicio", codEjercicio);
		setValueBuffer("codserie", codSerie);
		setValueBuffer("numproveedor", cabecera["numero"]);
		setValueBuffer("irpf", cabecera["irpf"]);
		setValueBuffer("docelectronico", true);
	}
	return "OK";
}

function eFactura_procesarFileHeaderType(nodoPadre:FLDomNode, nombreNodo:String):Array
{
	var util:FLUtil = new FLUtil;
	var datos:Array = [];
	datos["error"] = "OK";
	var sufijoError:String = "\n" + util.translate("scripts", "Proceso de cabecera de fichero");

	var nodoCabecera:FLDomNode = nodoPadre.namedItem(nombreNodo);
	if (!nodoCabecera) {
		datos["error"] = util.translate("scripts", "ERROR: No existe el nodo <%1>").arg(nombreNodo) + sufijoError;
		return datos;
	}
	datos["version"] = this.iface.valorNodo(nodoCabecera, "SchemaVersion");
	if (!datos["version"]) {
		datos["error"] = util.translate("scripts", "ERROR: No existe el nodo SchemaVersion") + sufijoError;
		return datos;
	}

	if (datos["version"] != "3.0" && datos["version"] != "3.2") {
		var res:Number = MessageBox.warning(util.translate("scripts", "La versión del fichero es distinta de 3.0. o 3.2 Puede que se produzcan errores en la carga.\n¿Desea continuar?"), MessageBox.No, MessageBox.Yes);
		if (res != MessageBox.Yes) {
			datos["error"] = util.translate("scripts", "ERROR: Versión del fichero no soportada") + sufijoError;
			return datos;
		}
		this.iface.informeEFactura(util.translate("scripts", "AVISO: Versión %1 del documento no soportada").arg(datos["version"]));
	}

	datos["modalidad"] = this.iface.valorNodo(nodoCabecera, "Modality");
	if (!datos["modalidad"])
		return false;

	switch (datos["modalidad"]) {
		case "I": {
			break;
		}
		case "L": {
			datos["error"] = util.translate("scripts", "ERROR: La versión actual no soporta la carga de facturas electrónicas por lotes") + sufijoError;
			return datos;
			break;
		}
		default: {
			datos["error"] = util.translate("scripts", "ERROR: Tipo de modalidad (%1) no soportado").arg(datos["modalidad"]) + sufijoError;
			return datos;
		}
	}

	datos["emisor"] = this.iface.valorNodo(nodoCabecera, "InvoiceIssuerType");
	if (!datos["emisor"]) {
		datos["error"] = util.translate("scripts", "ERROR: No se encuentra el nodo <InvoiceIssuerType>") + sufijoError;
		return datos;
	}

	switch (datos["emisor"]) {
		case "EM": {
			break;
		}
		case "RE": {
			datos["error"] = util.translate("scripts", "ERROR: La versión actual no soporta la carga de facturas electrónicas por generadas por el receptor") + sufijoError;
			return datos;
			break;
		}
		case "TE": {
			datos["error"] = util.translate("scripts", "ERROR: La versión actual no soporta la carga de facturas electrónicas por generadas por el terceros") + sufijoError;
			return datos;
			break;
		}
		default: {
			datos["error"] = util.translate("scripts", "ERROR: Tipo de emisor de facturas (%1) no soportado").arg(datos["emisor"]) + sufijoError;
			return datos;
		}
	}
	return datos;
}

function eFactura_procesarPartiesType(nodoPadre:FLDomNode, nombreNodo:String, version:String):Array
{
	var util:FLUtil = new FLUtil;
	var datos:Array = [];

	var nodoPartes:FLDomNode = nodoPadre.namedItem(nombreNodo);
	if (!nodoPartes) {
		MessageBox.warning(util.translate("scripts", "Error al procesar el fichero.\nNo existe el nodo <%1>").arg(nombreNodo), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	datos["vendedor"] = this.iface.procesarEmpresaType(nodoPartes, "SellerParty", version);
	if (!datos["vendedor"])
		return false;



// 	var nodoComprador:FLDomNode = nodoFacturae.namedItem("BuyerParty");
// 	if (!nodoComprador) {
// 		MessageBox.warning(util.translate("scripts", "Error al procesar el fichero.\nNo existe el nodo <BuyerParty>"), MessageBox.Ok, MessageBox.NoButton);
// 		return false;
// 	}

	return datos;
}

function eFactura_procesarEmpresaType(nodoPadre:FLDomNode, nombreNodo:String, version:String):Array
{
	var util:FLUtil = new FLUtil;
	var datos:Array = [];

	var nodoEmpresa:FLDomNode = nodoPadre.namedItem(nombreNodo);
	if (!nodoEmpresa) {
		MessageBox.warning(util.translate("scripts", "Error al procesar el fichero.\nNo existe el nodo <%1>").arg(nombreNodo), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	datos["identificacion"] = this.iface.procesarTaxIdentificationType(nodoEmpresa, "TaxIdentification", version);
	if (!datos["identificacion"])
		return false;

	return datos;
}

function eFactura_procesarTaxIdentificationType(nodoPadre:FLDomNode, nombreNodo:String, version:String):Array
{
	var util:FLUtil = new FLUtil;
	var datos:Array = [];

	var nodoEmpresa:FLDomNode = nodoPadre.namedItem(nombreNodo);
	if (!nodoEmpresa) {
		MessageBox.warning(util.translate("scripts", "Error al procesar el fichero.\nNo existe el nodo <%1>").arg(nombreNodo), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	datos["tipopersona"] = this.iface.procesarNodoFacturae(nodoEmpresa, "PersonTypeCode", version);
	if (!datos["tipopersona"])
		return false;

	datos["tiporesidencia"] = this.iface.procesarNodoFacturae(nodoEmpresa, "ResidenceTypeCode", version);
	if (!datos["tiporesidencia"])
		return false;

	datos["numero"] = this.iface.procesarNodoFacturae(nodoEmpresa, "TaxIdentificationNumber", version);
	if (!datos["numero"])
		return false;

	return datos;
}

function eFactura_procesarNodoFacturae(nodoPadre:FLDomNode, nombreNodo:String, version:String):Array
{
	var util:FLUtil = new FLUtil;
	var datos:Array = [];

	var nodoTipoPersona:FLDomNode = nodoPadre.namedItem(nombreNodo);
	if (!nodoTipoPersona) {
		MessageBox.warning(util.translate("scripts", "Error al procesar el fichero.\nNo existe el nodo <%1>").arg(nodoTipoPersona), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	datos["valor"] = nodoTipoPersona.toElement().text();
	if (!datos["valor"])
		return false;

	return datos;
}

function eFactura_valorNodoHijo(nombreNodo:String, nodoPadre:FLDomNode):String
{
	var util:FLUtil = new FLUtil;
	var nodoHijo:FLDomNode = nodoPadre.namedItem(nombreNodo);
	if (!nodoHijo) {
		MessageBox.warning(util.translate("scripts", "Error al procesar el fichero.\nNo existe el nodo <%1>").arg(nombreNodo), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	var valor:String = nodoHijo.toElement().text();
	return valor;
}

function eFactura_informeEFactura(texto:String):Boolean
{
	if (this.iface.informeEFactura_ != "")
		this.iface.informeEFactura_ += "\n";

	this.iface.informeEFactura_ += texto;
	return true;
}

function eFactura_comprobarFirma(xml:FLDomDocument):Boolean
{
	var util:FLUtil = new FLUtil;

	var xmlValorFirma:FLDomNode = xml.namedItem("Facturae").namedItem("ds:Signature").namedItem("ds:SignatureValue");
	var resumen:String = xmlValorFirma.toElement().text();
debug(resumen);
	xml.namedItem("Facturae").namedItem("ds:Signature").removeChild(xmlValorFirma);
	var cadenaXML:String = xml.toString();

	var resumen2:String = util.sha1(cadenaXML);
debug(resumen2);

	if (resumen != resumen2) {
		MessageBox.warning(util.translate("scripts", "Validación de firma incorrecta, el documento no se importará"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	return true;
}
//// EFACTURA ///////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

