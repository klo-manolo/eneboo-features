
/** @class_declaration eFactura */
/////////////////////////////////////////////////////////////////
//// EFACTURA ///////////////////////////////////////////////////
class eFactura extends oficial /** %from: oficial */ {
	var tbnEFactura:Object;
    function eFactura( context ) { oficial ( context ); }
	function init() {
		return this.ctx.eFactura_init();
	}
	function generarEFactura() {
		return this.ctx.eFactura_generarEFactura();
	}
	function nodoFacturae(nombreNodo:String, version:String):String {
		return this.ctx.eFactura_nodoFacturae(nombreNodo, version);
	}
	function nodoImporteTypeFacturae(nombreNodo:String, version:String, valor:String):String {
		return this.ctx.eFactura_nodoImporteTypeFacturae(nombreNodo, version, valor);
	}
	function nodoCurrencyCodeTypeFacturae(nombreNodo:String, version:String, valor:String):String {
		return this.ctx.eFactura_nodoCurrencyCodeTypeFacturae(nombreNodo, version, valor);
	}
	function nodoEmpresaTypeFacturae(nombreNodo:String, version:String, valor:String):String {
		return this.ctx.eFactura_nodoEmpresaTypeFacturae(nombreNodo, version, valor);
	}
	function nodoTaxIdentificationTypeFacturae(nombreNodo:String, version:String, datosEmpresa:Array):String {
		return this.ctx.eFactura_nodoTaxIdentificationTypeFacturae(nombreNodo, version, datosEmpresa);
	}
	function nodoPersonTypeCodeTypeFacturae(nombreNodo:String, version:String, datosEmpresa:Array):String {
		return this.ctx.eFactura_nodoPersonTypeCodeTypeFacturae(nombreNodo, version, datosEmpresa);
	}
	function nodoResidenceTypeCodeTypeFacturae(nombreNodo:String, version:String, datosEmpresa:Array):String {
		return this.ctx.eFactura_nodoResidenceTypeCodeTypeFacturae(nombreNodo, version, datosEmpresa);
	}
	function nodoPaisTypeFacturae(nombreNodo:String, version:String, valor:String):String {
		return this.ctx.eFactura_nodoPaisTypeFacturae(nombreNodo, version, valor);
	}
	function nodoTextMin3Max30TypeFacturae(nombreNodo:String, version:String, valor:String):String {
		return this.ctx.eFactura_nodoTextMin3Max30TypeFacturae(nombreNodo, version, valor);
	}
	function nodoTextMax2500TypeFacturae(nombreNodo:String, version:String, valor:String):String {
		return this.ctx.eFactura_nodoTextMax2500TypeFacturae(nombreNodo, version, valor);
	}
	function nodoTextMax80TypeFacturae(nombreNodo:String, version:String, valor:String):String {
		return this.ctx.eFactura_nodoTextMax80TypeFacturae(nombreNodo, version, valor);
	}
	function nodoTextMax50TypeFacturae(nombreNodo:String, version:String, valor:String):String {
		return this.ctx.eFactura_nodoTextMax50TypeFacturae(nombreNodo, version, valor);
	}
	function nodoTextMax40TypeFacturae(nombreNodo:String, version:String, valor:String):String {
		return this.ctx.eFactura_nodoTextMax40TypeFacturae(nombreNodo, version, valor);
	}
	function nodoTextMax20TypeFacturae(nombreNodo:String, version:String, valor:String):String {
		return this.ctx.eFactura_nodoTextMax20TypeFacturae(nombreNodo, version, valor);
	}
	function nodoPostCodeTypeFacturae(nombreNodo:String, version:String, valor:String):String {
		return this.ctx.eFactura_nodoPostCodeTypeFacturae(nombreNodo, version, valor);
	}
	function nodoLegalEntityTypeFacturae(nombreNodo:String, version:String, datosEmpresa:Array):String {
		return this.ctx.eFactura_nodoLegalEntityTypeFacturae(nombreNodo, version, datosEmpresa);
	}
	function nodoIndividualTypeFacturae(nombreNodo:String, version:String, datosEmpresa:Array):String {
		return this.ctx.eFactura_nodoIndividualTypeFacturae(nombreNodo, version, datosEmpresa);
	}
	function nodoAddressTypeFacturae(nombreNodo:String, version:String, datosEmpresa:Array):String {
		return this.ctx.eFactura_nodoAddressTypeFacturae(nombreNodo, version, datosEmpresa);
	}
	function nodoOverseasAddressTypeFacturae(nombreNodo:String, version:String, datosEmpresa:Array):String {
		return this.ctx.eFactura_nodoOverseasAddressTypeFacturae(nombreNodo, version, datosEmpresa);
	}
	function nodoXSDateFacturae(nombreNodo:String, fecha:String):String {
		return this.ctx.eFactura_nodoXSDateFacturae(nombreNodo, fecha);
	}
	function nodoXSDouble(nombreNodo:String, numero:Number):String {
		return this.ctx.eFactura_nodoXSDouble(nombreNodo, numero);
	}
	function nodoInvoiceSeriesTypeFacturae(nombreNodo:String, version:String, codFactura:String):String {
		return this.ctx.eFactura_nodoInvoiceSeriesTypeFacturae(nombreNodo, version, codFactura);
	}
	function nodoDoubleUpToEightDecimalTypeFacturae(nombreNodo:String, version:String, numero:Number):String {
		return this.ctx.eFactura_nodoDoubleUpToEightDecimalTypeFacturae(nombreNodo, version, numero);
	}
	function nodoDoubleSixDecimalTypeFacturae(nombreNodo:String, version:String, numero:Number):String {
		return this.ctx.eFactura_nodoDoubleSixDecimalTypeFacturae(nombreNodo, version, numero);
	}
	function nodoDoubleFourDecimalTypeFacturae(nombreNodo:String, version:String, numero:Number):String {
		return this.ctx.eFactura_nodoDoubleFourDecimalTypeFacturae(nombreNodo, version, numero);
	}
	function nodoDoubleTwoDecimalTypeFacturae(nombreNodo:String, version:String, numero:Number):String {
		return this.ctx.eFactura_nodoDoubleTwoDecimalTypeFacturae(nombreNodo, version, numero);
	}
	function nodoTaxesTypeFacturae(nombreNodo:String, version:String, cursor:FLSqlCursor):String {
		return this.ctx.eFactura_nodoTaxesTypeFacturae(nombreNodo, version, cursor);
	}
	function nodoTaxTypeCodeTypeFacturae(nombreNodo:String, version:String, idImpuesto:String):String {
		return this.ctx.eFactura_nodoTaxTypeCodeTypeFacturae(nombreNodo, version, idImpuesto);
	}
	function nodoTaxTypeFacturae(nombreNodo:String, version:String, impuesto:Array):String {
		return this.ctx.eFactura_nodoTaxTypeFacturae(nombreNodo, version, impuesto);
	}
	function nodoInvoiceLineTypeFacturae(nombreNodo:String, version:String, curLinea:FLSqlCursor):String {
		return this.ctx.eFactura_nodoInvoiceLineTypeFacturae(nombreNodo, version, curLinea);
	}
	function nodoDiscountsAndRebatesTypeFacturae(nombreNodo:String, version:String, cursor:FLSqlCursor):String {
		return this.ctx.eFactura_nodoDiscountsAndRebatesTypeFacturae(nombreNodo, version, cursor);
	}
	function nodoDiscountTypeFacturae(nombreNodo:String, version:String, descuento:Array):String {
		return this.ctx.eFactura_nodoDiscountTypeFacturae(nombreNodo, version, descuento);
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
	connect(this.iface.tbnEFactura, "clicked()", this, "iface.generarEFactura");
}

function eFactura_generarEFactura()
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil;
	var cadenaXML:String = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
	var versionFacturae:String = flfactppal.iface.pub_valorDefectoEmpresa("facturaever"); // Compatible multiempresa
	var cadenaFun:String = this.iface.nodoFacturae("Facturae", versionFacturae);
	var extFichero:String;

	if (cadenaFun.startsWith("ERROR")) {
		MessageBox.warning(util.translate("scripts", "Error al generar la factura:") + "\n" + cadenaFun, MessageBox.Ok, MessageBox.NoButton);
		return;
	}
	cadenaXML += cadenaFun;

	var nombreFichero:String = FileDialog.getSaveFileName();
	if (!nombreFichero)
		return;
	//////////////////////// EXTENSIÓN DEL FICHERO //////////////////////////////
	extFichero = util.sqlSelect("clientes","extfacturae","codcliente = '" + cursor.valueBuffer("codcliente") + "'");

	// Si se indica el ".xml", no volverlo a poner
	var arrayNombreFichero:Array = nombreFichero.split(".");
	if (arrayNombreFichero[arrayNombreFichero.length-1] != "xml")
		nombreFichero = nombreFichero + "." + extFichero;

	var xml:FLDomDocument = new FLDomDocument();
	if (!xml.setContent(cadenaXML)) {
		MessageBox.warning(util.translate("scripts", "Error en el formato XML"), MessageBox.Ok, MessageBox.NoButton);
		return;
	}
//	if (!this.iface.firmarFacturae(xml)) {
//		return false;
//	}




	var contenido:String = xml.toString(2);

	// File.write(nombreFichero, sys.fromUnicode( contenido, "UTF-8" )); // el sys.fromUnicode genera errores con tildes
	File.write(nombreFichero, contenido);
	//MessageBox.information(util.translate("scripts", "Documento creado en %1").arg(nombreFichero), MessageBox.Ok, MessageBox.NoButton);

	var idempresa = flfactppal.iface.pub_valorDefectoEmpresa("id");
	var certFile:String = util.readSettingEntry("scripts/flfacturac/rutacert"+idempresa);

	if (!certFile || certFile == ""){
		MessageBox.warning(util.translate("scripts", "No se ha podido firmar el fichero debido a que no se ha informado la ruta del certificado para ésta empresa.\
			\nPuede definirla en Facturación -> Principal -> Empresa -> Configuración Local"), MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	var rutaLib:String = util.readSettingEntry("scripts/flfacturac/rutalib");

	if (!rutaLib || rutaLib == ""){
		MessageBox.warning(util.translate("scripts", "No se ha podido firmar el fichero debido a que no se ha informado la ruta de la libreria.\
			\nPuede definirla en Facturación -> Principal -> Empresa -> Configuración Local"), MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	var password=""; //Si no lo pongo lo pregunta la librería.
	var comando = "java -jar " + rutaLib + " CREATE_SIGNATURE " + nombreFichero + " " + certFile + " " + password;

	var res:Array = flfactppal.iface.pub_ejecutarComandoAsincrono(comando);

	if (!res["ok"]){
		MessageBox.warning(util.translate("scripts", "Se ha producido un problema al firmar el fichero " + nombreFichero + "\n"+res["salida"]), MessageBox.Ok, MessageBox.NoButton);
		return;
	}
}

function eFactura_nodoFacturae(nombreNodo:String, version:String):String
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var cadenaXML:String = "";
	var cadenaFun:String;
	var sufijoError:String = "\n" + util.translate("scripts", "Nodo %1").arg(nombreNodo);

	switch (nombreNodo) {
		case "Facturae": {
			switch (version) {
				case "3.0": {
					cadenaXML += "<namespace:Facturae xmlns:namespace='http://www.facturae.es/Facturae/2007/v3.0/Facturae' xmlns:namespace2='http://uri.etsi.org/01903/v1.2.2#' xmlns:namespace3='http://www.w3.org/2000/09/xmldsig#'>";

					cadenaFun = this.iface.nodoFacturae("FileHeader", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("Parties", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("Invoices", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("Extensions", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("Signature", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaXML += "</namespace:Facturae>";
					break;
				}
				case "3.2":
				case "3.2.1": {
					cadenaXML += "<namespace:Facturae xmlns:namespace='http://www.facturae.es/Facturae/2009/v3.2/Facturae' xmlns:namespace2='http://uri.etsi.org/01903/v1.2.2#' xmlns:namespace3='http://www.w3.org/2000/09/xmldsig#'>";

					cadenaFun = this.iface.nodoFacturae("FileHeader", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("Parties", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("Invoices", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("Extensions", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("Signature", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaXML += "</namespace:Facturae>";
					break;
				}
			}
			break;
		}
		case "FileHeader": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "<FileHeader>";
					cadenaFun = this.iface.nodoFacturae("SchemaVersion", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun =  this.iface.nodoFacturae("Modality", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("InvoiceIssuerType", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("ThirdParty", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("Batch", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("FactoringAssignmentData", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaXML += "</FileHeader>";
					break;
				}
			}
			break;
		}
		case "SchemaVersion": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "<SchemaVersion>"
					cadenaXML += version
					cadenaXML += "</SchemaVersion>";
					break;
				}
			}
			break;
		}
		case "Modality": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					// 3.0 I = Individual, L = Batch (por lotes)
					cadenaXML += "<Modality>"
					cadenaXML += "I";
					cadenaXML += "</Modality>";
					break;
				}
			}
			break;
		}
		case "InvoiceIssuerType": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					// 3.0 EM = Proveedor (emisor), RE = Cliente (receptor), TE
					// = Tercero
					cadenaXML += "<InvoiceIssuerType>"
					cadenaXML += "EM";
					cadenaXML += "</InvoiceIssuerType>";
					break;
				}
			}
			break;
		}
		case "ThirdParty": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML = "";
					break;
				}
			}
			break;
		}
		case "Batch": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "<Batch>"

					cadenaFun = this.iface.nodoFacturae("BatchIdentifier", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("InvoicesCount", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoImporteTypeFacturae("TotalInvoicesAmount", version, cursor.valueBuffer("total"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoImporteTypeFacturae("TotalOutstandingAmount", version, cursor.valueBuffer("total"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoImporteTypeFacturae("TotalExecutableAmount", version, cursor.valueBuffer("total"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoCurrencyCodeTypeFacturae("InvoiceCurrencyCode", version, cursor.valueBuffer("coddivisa"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaXML += "</Batch>";
					break;
				}
			}
			break;
		}
		case "BatchIdentifier": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "<BatchIdentifier>"
					cadenaXML += cursor.valueBuffer("cifnif") + cursor.valueBuffer("codigo");
					cadenaXML += "</BatchIdentifier>";
				}
				break;
			}
			break;
		}
		case "InvoicesCount": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "<InvoicesCount>"
					cadenaXML += "1";
					cadenaXML += "</InvoicesCount>";
					break;
				}
			}
		}
		case "FactoringAssignmentData": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "";
					break;
				}
			}
			break;
		}
		case "Parties": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "<Parties>"

					cadenaFun = this.iface.nodoEmpresaTypeFacturae("SellerParty", version, "seller");
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoEmpresaTypeFacturae("BuyerParty", version, "buyer");
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaXML += "</Parties>";
					break;
				}
			}
			break;
		}
		case "PartyIdentification": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
                    // KLO.
                    var codCliente:String = flfactppal.iface.pub_cerosIzquierda(cursor.valueBuffer("codcliente"),10);
                    cadenaXML += "<PartyIdentification>"
                    cadenaXML += codCliente;
                    cadenaXML += "</PartyIdentification>";
					break;
				}
			}
			break;
		}
		case "AdministrativeCentres": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {

			var util:FLUtil = new FLUtil;
			var aDir:Array;
			var codISO:String;
			//Bucle recorriendo los centros administrativos ...
			var qryCentrosAdministrativos:FLSqlCursor = new FLSqlQuery;
			qryCentrosAdministrativos.setTablesList("centrosadmincli");
			qryCentrosAdministrativos.setSelect("rol,centro,descripcion,direccion,codpostal,ciudad,provincia,apartado,telefono1,fax");
			qryCentrosAdministrativos.setFrom("centrosadmincli");
			qryCentrosAdministrativos.setWhere("codcliente ='" + cursor.valueBuffer("codcliente") + "'");

			if (!qryCentrosAdministrativos.exec())
				break;

            if (qryCentrosAdministrativos.size() == 0)
                break;

			cadenaXML += "<AdministrativeCentres>";

			while (qryCentrosAdministrativos.next()) {
				aDir["direccion"] = qryCentrosAdministrativos.value("direccion");
				aDir["codpostal"] = qryCentrosAdministrativos.value("codpostal");
				aDir["ciudad"] = qryCentrosAdministrativos.value("ciudad");
				aDir["provincia"] = qryCentrosAdministrativos.value("provincia");
				codISO = util.sqlSelect("paises", "codisoalpha3", "codpais = '" + qryCentrosAdministrativos.value("codpais") + "'");
				if (!codISO)
					{
					codISO = "ESP"; //Forzamos a ESP si no hay definido un ISO3
					}
				aDir["codisoalpha3"] = codISO;

				cadenaXML += "<AdministrativeCentre>";
				cadenaXML += "<CentreCode>" + qryCentrosAdministrativos.value("centro") + "</CentreCode>";
				cadenaXML += "<RoleTypeCode>" + qryCentrosAdministrativos.value("rol").left(2) + "</RoleTypeCode>";
				cadenaXML += this.iface.nodoAddressTypeFacturae("AddressInSpain",version,aDir);
				//cadenaXML += this.iface.nodoFacturae("ContactDetails", version);
		if (qryCentrosAdministrativos.value("telefono1") != "" || qryCentrosAdministrativos.value("fax") != "")
				{
				cadenaXML += "<ContactDetails>";
				if (qryCentrosAdministrativos.value("telefono1") != "")
					{
					cadenaXML += "<Telephone>" + qryCentrosAdministrativos.value("telefono1") + "</Telephone>";
					}
				if (qryCentrosAdministrativos.value("fax") != "")
					{
					cadenaXML += "<TeleFax>" + qryCentrosAdministrativos.value("fax") + "</TeleFax>";
					}
				cadenaXML += "</ContactDetails>";
				}

		 cadenaXML += "<CentreDescription>" + qryCentrosAdministrativos.value("descripcion") +
"</CentreDescription></AdministrativeCentre>" ;
			}

                    cadenaXML += "</AdministrativeCentres>";
					break;
				}
			}
			break;
		}
		case "RegistrationData": {
			cadenaXML += "";
			break;
		}
		case "ContactDetails": {
			cadenaXML += "";
			break;
		}
		case "Invoices": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "<Invoices>"

					cadenaFun = this.iface.nodoFacturae("Invoice", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaXML += "</Invoices>";
					break;
				}
			}
			break;
		}
		case "Invoice": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "<Invoice>"

					cadenaFun = this.iface.nodoFacturae("InvoiceHeader", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("InvoiceIssueData", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoTaxesTypeFacturae("TaxesOutputs", version, cursor);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoTaxesTypeFacturae("TaxesWithheld", version, cursor);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("InvoiceTotals", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("Items", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("PaymentDetails", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("LegalLiterals", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("AdditionalData", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaXML += "</Invoice>";

					break;
				}
			}
			break;
		}
		case "InvoiceHeader": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "<InvoiceHeader>"

					cadenaFun = this.iface.nodoTextMax20TypeFacturae("InvoiceNumber", version, cursor.valueBuffer("codigo"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoTextMax20TypeFacturae("InvoiceSeriesCode", version, cursor.valueBuffer("codserie"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("InvoiceDocumentType", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("InvoiceClassType", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("Corrective", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaXML += "</InvoiceHeader>";
					break;
				}
			}
			break;
		}
		case "InvoiceIssueData": {
			switch (version) {
				case "3.0": {
					cadenaXML += "<InvoiceIssueData>"

					cadenaFun = this.iface.nodoXSDateFacturae("IssueDate", cursor.valueBuffer("fecha"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("PlaceOfIssue", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("InvoicingPeriod", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoCurrencyCodeTypeFacturae("InvoiceCurrencyCode", version, cursor.valueBuffer("coddivisa"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("ExchangeRateDetails", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoCurrencyCodeTypeFacturae("TaxCurrencyCode", version, flfactppal.iface.pub_valorDefectoEmpresa("coddivisa"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("LanguageName", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaXML += "</InvoiceIssueData>";
					break;
				}
				case "3.2":
				case "3.2.1": {
					cadenaXML += "<InvoiceIssueData>"

					cadenaFun = this.iface.nodoXSDateFacturae("IssueDate", cursor.valueBuffer("fecha"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoXSDateFacturae("OperationDate", cursor.valueBuffer("fecha"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("PlaceOfIssue", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("InvoicingPeriod", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoCurrencyCodeTypeFacturae("InvoiceCurrencyCode", version, cursor.valueBuffer("coddivisa"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("ExchangeRateDetails", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoCurrencyCodeTypeFacturae("TaxCurrencyCode", version, flfactppal.iface.pub_valorDefectoEmpresa("coddivisa"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("LanguageName", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaXML += "</InvoiceIssueData>";
					break;
				}
			}
			break;
		}
		case "ExchangeRateDetails": {
			if (cursor.valueBuffer("coddivisa") != flfactppal.iface.pub_valorDefectoEmpresa("coddivisa")) {
				cadenaXML += "<ExchangeRateDetails>"

				cadenaFun = this.iface.nodoDoubleTwoDecimalTypeFacturae("ExchangeRate", version, cursor.valueBuffer("tasaconv"));
				if (cadenaFun.startsWith("ERROR"))
					return cadenaFun + sufijoError;
				cadenaXML += cadenaFun;

				cadenaFun = this.iface.nodoXSDateFacturae("ExchangeRateDate", cursor.valueBuffer("fecha"));
				if (cadenaFun.startsWith("ERROR"))
					return cadenaFun + sufijoError;
				cadenaXML += cadenaFun;

				cadenaXML += "</ExchangeRateDetails>";
			} else {
				cadenaXML += "";
			}
			break;
		}
		case "InvoiceTotals": {
			switch (version) {
				case "3.0": {
					cadenaXML += "<InvoiceTotals>"

					cadenaFun = this.iface.nodoDoubleTwoDecimalTypeFacturae("TotalGrossAmount", version, cursor.valueBuffer("neto"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("GeneralDiscounts", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("GeneralSurcharges", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("TotalGeneralDiscounts", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("TotalGeneralSurcharges", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoDoubleTwoDecimalTypeFacturae("TotalGrossAmountBeforeTaxes", version, cursor.valueBuffer("neto"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoDoubleTwoDecimalTypeFacturae("TotalTaxOutputs", version, cursor.valueBuffer("totaliva") + cursor.valueBuffer("totalrecargo"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoDoubleTwoDecimalTypeFacturae("TotalTaxesWithheld", version, cursor.valueBuffer("totalirpf"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoDoubleTwoDecimalTypeFacturae("InvoiceTotal", version, cursor.valueBuffer("total"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("Subsidies", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("PaymentsOnAccount", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("TotalPaymentsOnAccount", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoDoubleTwoDecimalTypeFacturae("TotalOutstandingAmount", version, cursor.valueBuffer("total"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("AmountsWidthheld", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoDoubleTwoDecimalTypeFacturae("TotalExecutableAmount", version, cursor.valueBuffer("total"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaXML += "</InvoiceTotals>";

					break;
				}
				case "3.2": {
					cadenaXML += "<InvoiceTotals>"

					cadenaFun = this.iface.nodoDoubleTwoDecimalTypeFacturae("TotalGrossAmount", version, cursor.valueBuffer("neto"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("GeneralDiscounts", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("GeneralSurcharges", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("TotalGeneralDiscounts", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("TotalGeneralSurcharges", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoDoubleTwoDecimalTypeFacturae("TotalGrossAmountBeforeTaxes", version, cursor.valueBuffer("neto"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoDoubleTwoDecimalTypeFacturae("TotalTaxOutputs", version, cursor.valueBuffer("totaliva") + cursor.valueBuffer("totalrecargo"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoDoubleTwoDecimalTypeFacturae("TotalTaxesWithheld", version, cursor.valueBuffer("totalirpf"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoDoubleTwoDecimalTypeFacturae("InvoiceTotal", version, cursor.valueBuffer("total"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("Subsidies", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("PaymentsOnAccount", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

/*
 * cadenaFun = this.iface.nodoFacturae("ReimbursableExpenses", version); if
 * (cadenaFun.startsWith("ERROR")) return cadenaFun + sufijoError; cadenaXML +=
 * cadenaFun;
 */

// cadenaFun = this.iface.nodoFacturae("TotalFinancialExpenses", version);
// if (cadenaFun.startsWith("ERROR"))
// return cadenaFun + sufijoError;
// cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoDoubleTwoDecimalTypeFacturae("TotalOutstandingAmount", version, cursor.valueBuffer("total"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("TotalPaymentsOnAccount", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("AmountsWidthheld", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoDoubleTwoDecimalTypeFacturae("TotalExecutableAmount", version, cursor.valueBuffer("total"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

// cadenaFun = this.iface.nodoFacturae("TotalReimbursableExpenses", version);
// if (cadenaFun.startsWith("ERROR"))
// return cadenaFun + sufijoError;
// cadenaXML += cadenaFun;
					cadenaXML += "</InvoiceTotals>";

					break;
				}
				case "3.2.1": {
					cadenaXML += "<InvoiceTotals>"

					cadenaFun = this.iface.nodoDoubleUpToEightDecimalTypeFacturae("TotalGrossAmount", version, cursor.valueBuffer("neto"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("GeneralDiscounts", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("GeneralSurcharges", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("TotalGeneralDiscounts", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("TotalGeneralSurcharges", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoDoubleUpToEightDecimalTypeFacturae("TotalGrossAmountBeforeTaxes", version, cursor.valueBuffer("neto"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoDoubleUpToEightDecimalTypeFacturae("TotalTaxOutputs", version, cursor.valueBuffer("totaliva") + cursor.valueBuffer("totalrecargo"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoDoubleUpToEightDecimalTypeFacturae("TotalTaxesWithheld", version, cursor.valueBuffer("totalirpf"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoDoubleUpToEightDecimalTypeFacturae("InvoiceTotal", version, cursor.valueBuffer("total"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("Subsidies", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("PaymentsOnAccount", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

/*
 * cadenaFun = this.iface.nodoFacturae("ReimbursableExpenses", version); if
 * (cadenaFun.startsWith("ERROR")) return cadenaFun + sufijoError; cadenaXML +=
 * cadenaFun;
 */

// cadenaFun = this.iface.nodoFacturae("TotalFinancialExpenses", version);
// if (cadenaFun.startsWith("ERROR"))
// return cadenaFun + sufijoError;
// cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoDoubleUpToEightDecimalTypeFacturae("TotalOutstandingAmount", version, cursor.valueBuffer("total"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("TotalPaymentsOnAccount", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoFacturae("AmountsWidthheld", version);
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

					cadenaFun = this.iface.nodoDoubleUpToEightDecimalTypeFacturae("TotalExecutableAmount", version, cursor.valueBuffer("total"));
					if (cadenaFun.startsWith("ERROR"))
						return cadenaFun + sufijoError;
					cadenaXML += cadenaFun;

// cadenaFun = this.iface.nodoFacturae("TotalReimbursableExpenses", version);
// if (cadenaFun.startsWith("ERROR"))
// return cadenaFun + sufijoError;
// cadenaXML += cadenaFun;
					cadenaXML += "</InvoiceTotals>";

					break;
				}
			}
			break;
		}
		case "Items": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "<Items>"

					var curLineasFactura:FLSqlCursor = new FLSqlCursor("lineasfacturascli");
					curLineasFactura.select("idfactura = " + cursor.valueBuffer("idfactura"));
					while (curLineasFactura.next()) {
						curLineasFactura.setModeAccess(curLineasFactura.Browse);
						curLineasFactura.refreshBuffer();

						cadenaFun = this.iface.nodoInvoiceLineTypeFacturae("InvoiceLine", version, curLineasFactura);
						if (cadenaFun.startsWith("ERROR"))
							return cadenaFun + sufijoError;
						cadenaXML += cadenaFun;
					}

					cadenaXML += "</Items>";

					break;
				}
			}
			break;
		}
		case "GeneralDiscounts": {
			cadenaXML += "";
			break;
		}
		case "GeneralSurcharges": {
			cadenaXML += "";
			break;
		}
		case "TotalGeneralDiscounts": {
			cadenaXML += "";
			break;
		}
		case "TotalGeneralSurcharges": {
			cadenaXML += "";
			break;
		}
		case "Subsidies": {
			cadenaXML += "";
			break;
		}
		case "PaymentsOnAccount": {
			cadenaXML += "";
			break;
		}
		case "TotalPaymentsOnAccount": {
			cadenaXML += "";
			break;
		}
		case "AmountsWidthheld": {
			cadenaXML += "";
			break;
		}
		case "PlaceOfIssue": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "";
					break;
				}
			}
			break;
		}
		case "LanguageName": {
			switch (version) {
				case "3.0": {
					cadenaXML += "";
					break;
				}
				case "3.2":
				case "3.2.1": {
					var codIsoAlpha2:String = util.sqlSelect("paises", "codisoalpha2", "codpais = '" + cursor.valueBuffer("codpais") + "'");
					if (!codIsoAlpha2 || codIsoAlpha2 == "") {
						return util.translate("scripts", "ERROR: Nodo %1: El Cod.ISO.Alpha 2 del paí­s %2 está vací­o").arg(nombreNodo).arg(codpais);
					}

					cadenaXML += "<LanguageName>";
					cadenaXML += codIsoAlpha2.lower();
					cadenaXML += "</LanguageName>";
					break;
				}
			}
			break;
		}
		case "InvoicingPeriod": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "";
					break;
				}
			}
			break;
		}
		case "InvoiceDocumentType": {
			// V 3.0 FC: Factura completa, FA: Factura abreviada, AF:
			// Autofactura
			cadenaXML += "<InvoiceDocumentType>"
			cadenaXML += "FC";
			cadenaXML += "</InvoiceDocumentType>";
			break;
		}
		case "InvoiceClassType": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					// V 3.0 OO: Original, OR: Rectificativa, OC: Original
					// recapitulativa, CO: Copia de original, CR: Copia de
					// rectificativa, CC: Copia de recapitulativa,
					cadenaXML += "<InvoiceClass>"
					if (cursor.valueBuffer("deabono")) {
						cadenaXML += "OR";
					} else {
						cadenaXML += "OO";
					}
					cadenaXML += "</InvoiceClass>";
					break;
				}
			}
			break;
		}
		case "Corrective": {
			cadenaXML += "";
			break;
		}
		case "IssuerContractReference": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "";
					break;
				}
			}
			break;
		}
		case "IssuerTransactionReference": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "";
					break;
				}
			}
			break;
		}
		case "IssuerTransactionDate": {
			cadenaXML += "";
			break;
		}
		case "ReceiverContractReference": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "";
					break;
				}
			}
			break;
		}
		case "ReceiverContractDate": {
			cadenaXML += "";
			break;
		}
		case "ReceiverTransactionReference": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "";
					break;
				}
			}
			break;
		}
		case "ReceiverTransactionDate": {
			cadenaXML += "";
			break;
		}
		case "FileDate": {
			cadenaXML += "";
			break;
		}
		case "SequenceNumber": {
			cadenaXML += "";
			break;
		}
		case "PurchaseOrderReference": {
			cadenaXML += "";
			break;
		}
		case "FileReference": {
			cadenaXML += "";
			break;
		}
		case "DeliveryNotesReferences": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "";
					break;
				}
			}
			break;
		}
		case "UnitOfMeasure": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "";
					break;
				}
			}
			break;
		}
		case "Charges": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "";
					break;
				}
			}
			break;
		}
		case "LineItemPeriod": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "";
					break;
				}
			}
			break;
		}
		case "IssuerContractDate": {
			cadenaXML += "";
			break;
		}
		case "TransactionDate": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "";
					break;
				}
			}
			break;
		}
		case "AdditionalLineItemInformation": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "";
					break;
				}
			}
			break;
		}
		case "SpecialTaxableEvent": {
			cadenaXML += "";
			break;
		}
		case "Extensions": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "";
					break;
				}
			}
			break;
		}
		case "PaymentDetails": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "";
					break;
				}
			}
			break;
		}
		case "LegalLiterals": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "";
					break;
				}
			}
		}
		case "AdditionalData": {
			switch (version) {
				case "3.0":
				case "3.2":
				case "3.2.1": {
					cadenaXML += "";
					break;
				}
			}
			break;
		}
	}
	return cadenaXML;
}

function eFactura_nodoTaxesTypeFacturae(nombreNodo:String, version:String, cursor:FLSqlCursor):String
{
	var cadenaXML:String = "";
	switch (version) {
		case "3.0":
		case "3.2":
		case "3.2.1": {
			var util:FLUtil = new FLUtil;

			var cadenaFun:String;
			var sufijoError:String = util.translate("scripts", "Nodo %1").arg(nombreNodo);

			var datosImpuesto:Array = [];
			var tabla:String = cursor.table();
			switch (nombreNodo) {
				case "TaxesWithheld": {
					switch (tabla) {
						case "facturascli": {
							cadenaXML += "<TaxesWithheld>";

							datosImpuesto["baseimponible"] = cursor.valueBuffer("neto");
							datosImpuesto["porcentaje"] = cursor.valueBuffer("irpf");
							datosImpuesto["total"] = cursor.valueBuffer("totalirpf");
							datosImpuesto["tipoimpuesto"] = "04"; // IRPF
							datosImpuesto["recargo"] = "";
							cadenaFun = this.iface.nodoTaxTypeFacturae("Tax", version, datosImpuesto);
							if (cadenaFun.startsWith("ERROR"))
								return cadenaFun + sufijoError;
							cadenaXML += cadenaFun;

							cadenaXML += "</TaxesWithheld>";
							break;
						}
						case "lineasfacturascli": {
							cadenaXML += "<TaxesWithheld>"

							datosImpuesto["baseimponible"] = cursor.valueBuffer("pvptotal");
							datosImpuesto["porcentaje"] = cursor.valueBuffer("irpf");
							datosImpuesto["total"] = parseFloat(cursor.valueBuffer("pvptotal")) * cursor.valueBuffer("irpf") / 100;
							datosImpuesto["tipoimpuesto"] = "04"; // IRPF
							datosImpuesto["recargo"] = "";
							cadenaFun = this.iface.nodoTaxTypeFacturae("Tax", version, datosImpuesto);
							if (cadenaFun.startsWith("ERROR"))
								return cadenaFun + sufijoError;
							cadenaXML += cadenaFun;

							cadenaXML += "</TaxesWithheld>";
							break;
						}
		// case "lineasfacturascli": {
		// cadenaXML += "";
		// break;
		// }
						default: {
							return util.translate("scripts", "ERROR: Nodo %1: La tabla asociada al nodo (%2) es desconocida").arg(nombreNodo).arg(tabla);
						}
					}
					break;
				}
				case "TaxesOutputs": {
					switch (tabla) {
						case "facturascli": {
							cadenaXML += "<TaxesOutputs>"

							var qryIva:FLSqlQuery = new FLSqlQuery();
							qryIva.setTablesList("lineasivafactcli");
							qryIva.setSelect("neto, iva, totaliva, totalrecargo");
							qryIva.setFrom("lineasivafactcli");
							qryIva.setWhere("idfactura = " + cursor.valueBuffer("idfactura"));
							qryIva.setForwardOnly(true);
							if (!qryIva.exec()) {
								return util.translate("scripts", "ERROR: Nodo %1: Error en la consulta de IVA").arg(nombreNodo);
							}
							if (qryIva.size()){
								while (qryIva.next()) {
									datosImpuesto["baseimponible"] = qryIva.value("neto");
									datosImpuesto["porcentaje"] = qryIva.value("iva");
									datosImpuesto["total"] = qryIva.value("totaliva");

									if (qryIva.value("totalrecargo") != 0) {
										datosImpuesto["totalrecargo"] = qryIva.value("totalrecargo");
										datosImpuesto["recargo"] =  (datosImpuesto["totalrecargo"] * 100 )/ datosImpuesto["baseimponible"];
									}
									else {
										datosImpuesto["recargo"] = "";
									}
									datosImpuesto["tipoimpuesto"] = "01"; // IVA
									cadenaFun = this.iface.nodoTaxTypeFacturae("Tax", version, datosImpuesto);
									if (cadenaFun.startsWith("ERROR"))
										return cadenaFun + sufijoError;
									cadenaXML += cadenaFun;
								}
							} else {
								// No hay lineas de IVA, pero el NODO debe existir y contener algo
								datosImpuesto["baseimponible"] = cursor.valueBuffer("neto");
								datosImpuesto["porcentaje"] = 0; // no hay
								datosImpuesto["total"] = cursor.valueBuffer("totaliva"); // será 0
								datosImpuesto["tipoimpuesto"] = "01"; // IVA
								datosImpuesto["recargo"] = "";
								cadenaFun = this.iface.nodoTaxTypeFacturae("Tax", version, datosImpuesto);
								if (cadenaFun.startsWith("ERROR"))
									return cadenaFun + sufijoError;
								cadenaXML += cadenaFun;
							}

							cadenaXML += "</TaxesOutputs>";
							break;
						}
						case "lineasfacturascli": {
							cadenaXML += "<TaxesOutputs>"

							datosImpuesto["baseimponible"] = cursor.valueBuffer("pvptotal");
							datosImpuesto["porcentaje"] = cursor.valueBuffer("iva");
							datosImpuesto["total"] = parseFloat(cursor.valueBuffer("pvptotal")) * cursor.valueBuffer("iva") / 100;
							datosImpuesto["tipoimpuesto"] = "01"; // IVA

						if (cursor.valueBuffer("recargo")) {
//								debug("recargo lineas");
								datosImpuesto["recargo"] =  cursor.valueBuffer("recargo");
								datosImpuesto["totalrecargo"] = parseFloat((cursor.valueBuffer("recargo")) * parseFloat(cursor.valueBuffer("pvptotal")))/ 100;
								}
								else
								{
//								debug("NO recargo lineas");
								datosImpuesto["recargo"] = "";
								}



							cadenaFun = this.iface.nodoTaxTypeFacturae("Tax", version, datosImpuesto);
							if (cadenaFun.startsWith("ERROR"))
								return cadenaFun + sufijoError;
							cadenaXML += cadenaFun;

							cadenaXML += "</TaxesOutputs>";
							break;
						}
						default: {
							return util.translate("scripts", "ERROR: Nodo %1: La tabla asociada al nodo (%2) es desconocida").arg(nombreNodo).arg(tabla);
						}
					}
					break;
				}
				default: {
					return util.translate("scripts", "ERROR: Nodo %1: El nombre del nodo es desconocido para el tipo TaxesType").arg(nombreNodo);
					break;
				}
			}
			break;
		}
	}

	return cadenaXML;
}

function eFactura_nodoInvoiceLineTypeFacturae(nombreNodo:String, version:String, curLinea:FLSqlCursor):String
{
	var util:FLUtil = new FLUtil;

	var cadenaXML:String = "<" + nombreNodo + ">";
	var cadenaFun:String;
	var sufijoError:String = util.translate("scripts", "Nodo %1").arg(nombreNodo);

	switch (version) {
		case "3.0": {
			cadenaFun = this.iface.nodoFacturae("IssuerContractReference", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("IssuerTransactionReference", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("ReceiverContractReference", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("ReceiverTransactionReference", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("PurchaseOrderReference", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("DeliveryNotesReferences", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoTextMax2500TypeFacturae("ItemDescription", version, curLinea.valueBuffer("descripcion"));
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoXSDouble("Quantity", curLinea.valueBuffer("cantidad"));
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("UnitOfMeasure", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoDoubleSixDecimalTypeFacturae("UnitPriceWithoutTax", version, curLinea.valueBuffer("pvpunitario"));
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoDoubleTwoDecimalTypeFacturae("TotalCost", version, curLinea.valueBuffer("pvpsindto"));
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoDiscountsAndRebatesTypeFacturae("DiscountsAndRebates", version, curLinea);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("Charges", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoDoubleTwoDecimalTypeFacturae("GrossAmount", version, curLinea.valueBuffer("pvptotal"));
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoTaxesTypeFacturae("TaxesWithheld", version, curLinea);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoTaxesTypeFacturae("TaxesOutputs", version, curLinea);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("LineItemPeriod", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("TransactionDate", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("AdditionalLineItemInformation", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("Extensions", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;
			break;
		}
		case "3.2": {
			cadenaFun = this.iface.nodoFacturae("IssuerContractReference", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("IssuerContractDate", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("IssuerTransactionReference", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("IssuerTransactionDate", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("ReceiverContractReference", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("ReceiverContractDate", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("ReceiverTransactionReference", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("ReceiverTransactionDate", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("FileReference", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("FileDate", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("SequenceNumber", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("DeliveryNotesReferences", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoTextMax2500TypeFacturae("ItemDescription", version, curLinea.valueBuffer("descripcion"));
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoXSDouble("Quantity", curLinea.valueBuffer("cantidad"));
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("UnitOfMeasure", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoDoubleSixDecimalTypeFacturae("UnitPriceWithoutTax", version, curLinea.valueBuffer("pvpunitario"));
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoDoubleSixDecimalTypeFacturae("TotalCost", version, curLinea.valueBuffer("pvpsindto"));
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoDiscountsAndRebatesTypeFacturae("DiscountsAndRebates", version, curLinea);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("Charges", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoDoubleSixDecimalTypeFacturae("GrossAmount", version, curLinea.valueBuffer("pvptotal"));
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoTaxesTypeFacturae("TaxesWithheld", version, curLinea);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoTaxesTypeFacturae("TaxesOutputs", version, curLinea);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("LineItemPeriod", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("TransactionDate", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("AdditionalLineItemInformation", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("SpecialTaxableEvent", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoTextMax2500TypeFacturae("ArticleCode", version, curLinea.valueBuffer("referencia"));
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("Extensions", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;
			break;
		}
		case "3.2.1": {
			cadenaFun = this.iface.nodoFacturae("IssuerContractReference", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("IssuerContractDate", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("IssuerTransactionReference", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("IssuerTransactionDate", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("ReceiverContractReference", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("ReceiverContractDate", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("ReceiverTransactionReference", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("ReceiverTransactionDate", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("FileReference", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("FileDate", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("SequenceNumber", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("DeliveryNotesReferences", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoTextMax2500TypeFacturae("ItemDescription", version, curLinea.valueBuffer("descripcion"));
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoXSDouble("Quantity", curLinea.valueBuffer("cantidad"));
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("UnitOfMeasure", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoDoubleUpToEightDecimalTypeFacturae("UnitPriceWithoutTax", version, curLinea.valueBuffer("pvpunitario"));
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoDoubleUpToEightDecimalTypeFacturae("TotalCost", version, curLinea.valueBuffer("pvpsindto"));
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoDiscountsAndRebatesTypeFacturae("DiscountsAndRebates", version, curLinea);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("Charges", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoDoubleUpToEightDecimalTypeFacturae("GrossAmount", version, curLinea.valueBuffer("pvptotal"));
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoTaxesTypeFacturae("TaxesWithheld", version, curLinea);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoTaxesTypeFacturae("TaxesOutputs", version, curLinea);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("LineItemPeriod", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("TransactionDate", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("AdditionalLineItemInformation", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("SpecialTaxableEvent", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoTextMax2500TypeFacturae("ArticleCode", version, curLinea.valueBuffer("referencia"));
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoFacturae("Extensions", version);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;
			break;
		}
	}

	cadenaXML += "</" + nombreNodo + ">";
	return cadenaXML;
}

function eFactura_nodoDiscountsAndRebatesTypeFacturae(nombreNodo:String, version:String, cursor:FLSqlCursor):String
{
	var cadenaXML:String;
	switch (version) {
		case "3.0":
		case "3.2":
		case "3.2.1": {
			var util:FLUtil = new FLUtil;

			var cadenaFun:String;
			var sufijoError:String = util.translate("scripts", "Nodo %1").arg(nombreNodo);

			var datosDescuento:Array = [];
			if (cursor.table() == "lineasfacturascli") {
				cadenaXML = "<" + nombreNodo + ">";

				datosDescuento["razon"] = util.translate("scripts", "Descuento porcentual")
				datosDescuento["porcentaje"] = cursor.valueBuffer("dtopor");
				datosDescuento["total"] = formRecordlineaspedidoscli.iface.pub_commonCalculateField("lbldtopor", cursor);
				cadenaFun = this.iface.nodoDiscountTypeFacturae("Discount", version, datosDescuento);
				if (cadenaFun.startsWith("ERROR"))
					return cadenaFun + sufijoError;
				cadenaXML += cadenaFun;

				datosDescuento["razon"] = util.translate("scripts", "Descuento lineal")
				datosDescuento["porcentaje"] = ""
				datosDescuento["total"] = cursor.valueBuffer("dtolineal");
				cadenaFun = this.iface.nodoDiscountTypeFacturae("Discount", version, datosDescuento);
				if (cadenaFun.startsWith("ERROR"))
					return cadenaFun + sufijoError;
				cadenaXML += cadenaFun;
			}

			cadenaXML += "</" + nombreNodo + ">";
			break;
		}
	}
	return cadenaXML;
}

function eFactura_nodoDiscountTypeFacturae(nombreNodo:String, version:String, descuento:Array):String
{
	var util:FLUtil = new FLUtil;

	var cadenaXML:String = "<" + nombreNodo + ">";
	var cadenaFun:String;
	var sufijoError:String = util.translate("scripts", "Nodo %1").arg(nombreNodo);

	switch (version) {
		case "3.0": {
			cadenaFun = this.iface.nodoTextMax2500TypeFacturae("DiscountReason", version, descuento["razon"]);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoDoubleFourDecimalTypeFacturae("DiscountRate", version, descuento["porcentaje"]);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoDoubleTwoDecimalTypeFacturae("DiscountAmount", version, descuento["total"]);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;
			break;
		}
		case "3.2": {
			cadenaFun = this.iface.nodoTextMax2500TypeFacturae("DiscountReason", version, descuento["razon"]);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoDoubleFourDecimalTypeFacturae("DiscountRate", version, descuento["porcentaje"]);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoDoubleSixDecimalTypeFacturae("DiscountAmount", version, descuento["total"]);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;
			break;
		}
		case "3.2.1": {
			cadenaFun = this.iface.nodoTextMax2500TypeFacturae("DiscountReason", version, descuento["razon"]);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoDoubleUpToEightDecimalTypeFacturae("DiscountRate", version, descuento["porcentaje"]);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;

			cadenaFun = this.iface.nodoDoubleUpToEightDecimalTypeFacturae("DiscountAmount", version, descuento["total"]);
			if (cadenaFun.startsWith("ERROR"))
				return cadenaFun + sufijoError;
			cadenaXML += cadenaFun;
			break;
		}
	}

	cadenaXML += "</" + nombreNodo + ">";

	return cadenaXML;
}

function eFactura_nodoDoubleSixDecimalTypeFacturae(nombreNodo:String, version:String, numero:Number):String
{debug("precio unitario " + numero);
	var cadenaXML:String = "";
	switch (version) {
		case "3.0":
		case "3.2":
		case "3.2.1": {
			var util:FLUtil = new FLUtil;

			var numeroAux:Number = numero;
			//var numeroAux:Number = numero * 1000000;
//debug(numeroAux);
			//numeroAux = Math.round(numeroAux);  //Da problemas (numero * 1000000)
//debug(numeroAux);
			//numeroAux = numeroAux / 1000000;
//debug(numeroAux);

			var cadena:String = util.buildNumber(numeroAux, "f", 6);
debug(cadena);
			var iPunto:String = cadena.find(".");
debug(iPunto);
			if (iPunto == -1) {
				cadena += ".000000";
			} else {
				for (var i:Number = 0; i < (7 - (cadena.length - iPunto)); i++) {
					cadena += "0";
				}
			}
debug(cadena);
			cadenaXML = "<" + nombreNodo + ">";
			cadenaXML += cadena;
			cadenaXML += "</" + nombreNodo + ">";
			break;
		}
debug(cadenaXML);
	}
	return cadenaXML;
}

function eFactura_nodoDoubleUpToEightDecimalTypeFacturae(nombreNodo:String, version:String, numero:Number):String
{debug("precio unitario " + numero);
	var cadenaXML:String = "";
	switch (version) {
		case "3.0":
		case "3.2":
		case "3.2.1": {
			var util:FLUtil = new FLUtil;

			var numeroAux:Number = numero;
			//var numeroAux:Number = numero * 1000000;
//debug(numeroAux);
			//numeroAux = Math.round(numeroAux);  //Da problemas (numero * 1000000)
//debug(numeroAux);
			//numeroAux = numeroAux / 1000000;
//debug(numeroAux);

			var cadena:String = util.buildNumber(numeroAux, "f", 8);
debug(cadena);
			var iPunto:String = cadena.find(".");
debug(iPunto);
			if (iPunto == -1) {
				cadena += ".00000000";
			} else {
				for (var i:Number = 0; i < (9 - (cadena.length - iPunto)); i++) {
					cadena += "0";
				}
			}
debug(cadena);
			cadenaXML = "<" + nombreNodo + ">";
			cadenaXML += cadena;
			cadenaXML += "</" + nombreNodo + ">";
			break;
		}
debug(cadenaXML);
	}
	return cadenaXML;
}

function eFactura_nodoDoubleFourDecimalTypeFacturae(nombreNodo:String, version:String, numero:Number):String
{
	var util:FLUtil = new FLUtil;
	var numeroAux:Number = numero * 10000;
	numeroAux = Math.round(numeroAux);
	numeroAux = numeroAux / 10000;

	var cadena:String = util.buildNumber(numeroAux, "f", 4);
	var iPunto:String = cadena.find(".");
	if (iPunto == -1) {
		cadena += ".0000";
	} else {
		for (var i:Number = 0; i < (5 - (cadena.length - iPunto)); i++) {
			cadena += "0";
		}
	}

	var cadenaXML:String = "<" + nombreNodo + ">";
	cadenaXML += cadena;
	cadenaXML += "</" + nombreNodo + ">";

	return cadenaXML;
}

function eFactura_nodoDoubleTwoDecimalTypeFacturae(nombreNodo:String, version:String, numero:Number):String
{
	var cadenaXML:String = "<" + nombreNodo + ">";
	switch (version) {
		case "3.0":
		case "3.2":
		case "3.2.1": {
			var util:FLUtil = new FLUtil;
			var numeroAux:Number = numero * 100;
			numeroAux = Math.round(numeroAux);
			numeroAux = numeroAux / 100;

			var cadena:String = util.buildNumber(numeroAux, "f", 2);
			var iPunto:String = cadena.find(".");
			if (iPunto == -1) {
				cadena += ".000000";
			} else {
				for (var i:Number = 0; i < (3 - (cadena.length - iPunto)); i++) {
					cadena += "0";
				}
			}

			cadenaXML += cadena;
			cadenaXML += "</" + nombreNodo + ">";
			break;
		}
	}

	return cadenaXML;
}

function eFactura_nodoInvoiceSeriesTypeFacturae(nombreNodo:String, version:String, codFactura:String):String
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var cadenaXML = "";

	return cadenaXML;
}

function eFactura_nodoXSDateFacturae(nombreNodo:String, fecha:String):String
{
	var util:FLUtil = new FLUtil;

	var fechaString:String = fecha.toString().left(10);
	var d:Date = new Date(Date.parse(fechaString));
	if (!d) {
		return util.translate("scripts", "ERROR: Nodo %1: El valor de fecha %2 no cumple el estándar AAA-MM-DD").arg(nombreNodo).arg(fechaString);
	}
	var cadenaXML:String = "<" + nombreNodo + ">";
	cadenaXML += fechaString;
	cadenaXML += "</" + nombreNodo + ">";

	return cadenaXML;
}

function eFactura_nodoXSDouble(nombreNodo:String, numero:Number):String
{
	var util:FLUtil = new FLUtil;

	if (isNaN(numero)) {
		return util.translate("scripts", "ERROR: Nodo %1: El valor %2 no es un níºmero").arg(nombreNodo).arg(numero);
	}
	var cadenaXML:String = "<" + nombreNodo + ">";
	cadenaXML += numero;
	cadenaXML += "</" + nombreNodo + ">";

	return cadenaXML;
}

function eFactura_nodoImporteTypeFacturae(nombreNodo:String, version:String, valor:String):String
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var codDivisa:String = cursor.valueBuffer("coddivisa");

	var cadenaXML:String = "<" + nombreNodo + ">";
	switch (version) {
		case "3.0":
		case "3.2": {
			cadenaXML += "<TotalAmount>";
			cadenaXML += util.roundFieldValue(valor, "facturascli", "total");
			cadenaXML += "</TotalAmount>";
			if (codDivisa != "EUR") {
				var tasaConv:String = util.sqlSelect("divisas", "tasaconv", "coddivisa = '" + codDivisa + "'");
				var valorEuro:Number = parseFloat(valor) * parseFloat(tasaConv);
				cadenaXML += "<EquivalentInEuros>";
				cadenaXML += util.roundFieldValue(valorEuro, "facturascli", "total");
				cadenaXML += "</EquivalentInEuros>";
						}
			break;
			}
		case "3.2.1": {
			//cadenaXML += "<TotalAmount>";
			//cadenaXML += util.roundFieldValue(valor, "facturascli", "total");
			cadenaXML += this.iface.nodoDoubleUpToEightDecimalTypeFacturae("TotalAmount", version, valor);
			//cadenaXML += "</TotalAmount>";
			if (codDivisa != "EUR") {
				var tasaConv:String = util.sqlSelect("divisas", "tasaconv", "coddivisa = '" + codDivisa + "'");
				var valorEuro:Number = parseFloat(valor) * parseFloat(tasaConv);
				cadenaXML += "<EquivalentInEuros>";
				cadenaXML += util.roundFieldValue(valorEuro, "facturascli", "total");
				cadenaXML += "</EquivalentInEuros>";
			}
			break;
		}
	}

	cadenaXML += "</" + nombreNodo + ">";
	return cadenaXML;
}

function eFactura_nodoCurrencyCodeTypeFacturae(nombreNodo:String, version:String, valor:String):String
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var cadenaXML:String = "<" + nombreNodo + ">";
	switch (version) {
		case "3.0":
		case "3.2":
		case "3.2.1": {
			cadenaXML += valor;
			break;
		}
	}

	cadenaXML += "</" + nombreNodo + ">";
	return cadenaXML;
}

function eFactura_nodoEmpresaTypeFacturae(nombreNodo:String, version:String, valor:String):String
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var cadenaXML:String = "<" + nombreNodo + ">";
	var cadenaFun:String;
	var sufijoError:String = util.translate("scripts", "Nodo %1").arg(nombreNodo);

	var datosEmpresa:Array = [];
	switch (valor) {
		case "seller": {
			var codPais:String = flfactppal.iface.pub_valorDefectoEmpresa("codpais");

			if (codPais == cursor.valueBuffer("codpais"))
				datosEmpresa["mismopais"] = true;
			else
				datosEmpresa["mismopais"] = false;

			if (!codPais || codPais == "") {
				return util.translate("scripts", "ERROR: Nodo %1: Debe especificar el paí­s del vendedor en el formulario de empresa").arg(nombreNodo);
			}
			datosEmpresa["tipopersona"] = "J"; // XXX Nuevo campo Clientes
			datosEmpresa["codpais"] = codPais;
			datosEmpresa["codisoalpha3"] = util.sqlSelect("paises", "codisoalpha3", "codpais = '" + codPais + "'");
			if (!datosEmpresa["codisoalpha3"]) {
				return util.translate("scripts", "ERROR: Nodo %1: Debe especificar el código ISO ALPHA 3 correspondiente al paí­s %2 en la tabla de paí­ses").arg(nombreNodo).arg(codPais);
			}

			datosEmpresa["codisoalpha2"] = util.sqlSelect("paises", "codisoalpha2", "codpais = '" + codPais + "'");
			if (!datosEmpresa["codisoalpha2"]) {
				return util.translate("scripts", "ERROR: Nodo %1: Debe especificar el código ISO ALPHA 2 correspondiente al paí­s %2 en la tabla de paí­ses").arg(nombreNodo).arg(codPais);
			}

			datosEmpresa["direccion"] = flfactppal.iface.pub_valorDefectoEmpresa("direccion");
			datosEmpresa["codpostal"] = flfactppal.iface.pub_valorDefectoEmpresa("codpostal");
			datosEmpresa["provincia"] = flfactppal.iface.pub_valorDefectoEmpresa("provincia");
			datosEmpresa["ciudad"] = flfactppal.iface.pub_valorDefectoEmpresa("ciudad");
			datosEmpresa["cifnif"] = flfactppal.iface.pub_valorDefectoEmpresa("cifnif");

			if (datosEmpresa["tipopersona"] = "J") {
				datosEmpresa["nombre"] = flfactppal.iface.pub_valorDefectoEmpresa("nombre");
				datosEmpresa["nombrecomercial"] = ""; // XXX Nombre comercial
														// en empresa
			} else {
				datosEmpresa["nombrepf"] = ""; // XXX Nombre persona fí­sica en
												// empresa
				datosEmpresa["apellido1pf"] = ""; // XXX Apellido 1 persona
													// fí­sica en empresa
				datosEmpresa["apellido2pf"] = ""; // XXX Apellido 2 persona
													// fí­sica en empresa
			}
			break;
		}
		case "buyer": {
			var codCliente:String = cursor.valueBuffer("codcliente");
			var codPais:String = cursor.valueBuffer("codpais");
			if (!codPais || codPais == "") {
				return util.translate("scripts", "ERROR: Nodo %1: Debe especificar el paí­s de la factura").arg(nombreNodo);
			}

			if (codPais == flfactppal.iface.pub_valorDefectoEmpresa("codpais"))
				datosEmpresa["mismopais"] = true;
			else
				datosEmpresa["mismopais"] = false;


			datosEmpresa["tipopersona"] = "J"; // XXX Nuevo campo Clientes
			datosEmpresa["codpais"] = codPais;

			datosEmpresa["codisoalpha3"] = util.sqlSelect("paises", "codisoalpha3", "codpais = '" + codPais + "'");
			if (!datosEmpresa["codisoalpha3"]) {
				return util.translate("scripts", "ERROR: Nodo %1: Debe especificar el código ISO ALPHA 3 correspondiente al paí­s %2 en la tabla de paí­ses").arg(nombreNodo).arg(codPais);
			}
			datosEmpresa["codisoalpha2"] = util.sqlSelect("paises", "codisoalpha2", "codpais = '" + codPais + "'");
			if (!datosEmpresa["codisoalpha2"]) {
				return util.translate("scripts", "ERROR: Nodo %1: Debe especificar el código ISO ALPHA 2 correspondiente al paí­s %2 en la tabla de paí­ses").arg(nombreNodo).arg(codPais);
			}
			datosEmpresa["direccion"] = cursor.valueBuffer("direccion");
			datosEmpresa["codpostal"] = cursor.valueBuffer("codpostal");
			datosEmpresa["provincia"] = cursor.valueBuffer("provincia");
			datosEmpresa["ciudad"] = cursor.valueBuffer("ciudad");
			datosEmpresa["cifnif"] = cursor.valueBuffer("cifnif");

			if (datosEmpresa["tipopersona"] = "J") {
				datosEmpresa["nombre"] = cursor.valueBuffer("nombrecliente");
				datosEmpresa["nombrecomercial"] = util.sqlSelect("clientes", "nombrecomercial", "codcliente = '" + codCliente + "'");
				if (!datosEmpresa["nombrecomercial"])
					datosEmpresa["nombrecomercial"] = "";
			} else {
				datosEmpresa["nombrepf"] = ""; // XXX Nombre persona fí­sica en
												// clientes
				datosEmpresa["apellido1pf"] = ""; // XXX Apellido 1 persona
													// fí­sica en clientes
				datosEmpresa["apellido2pf"] = ""; // XXX Apellido 2 persona
													// fí­sica en clientes
			}
			break;
		}
	}

	cadenaFun = this.iface.nodoTaxIdentificationTypeFacturae("TaxIdentification", version, datosEmpresa);
	if (cadenaFun.startsWith("ERROR"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

    // KLO.
    if (valor == "buyer") {
    	debug("COMPRA COMPRA");
    	cadenaFun = this.iface.nodoFacturae("PartyIdentification", version);
        if (cadenaFun.startsWith("ERROR"))
            return cadenaFun + sufijoError;
        cadenaXML += cadenaFun;

        cadenaFun = this.iface.nodoFacturae("AdministrativeCentres", version, datosEmpresa);
        if (cadenaFun.startsWith("ERROR"))
            return cadenaFun + sufijoError;
        cadenaXML += cadenaFun;
    }

	if (datosEmpresa["tipopersona"] == "J") {
		cadenaFun = this.iface.nodoLegalEntityTypeFacturae("LegalEntity", version, datosEmpresa);
	} else {
		cadenaFun = this.iface.nodoIndividualTypeFacturae("Individual", version, datosEmpresa);
	}
	if (cadenaFun.startsWith("ERROR"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	cadenaXML += "</" + nombreNodo + ">";

	return cadenaXML;
}

function eFactura_nodoTaxIdentificationTypeFacturae(nombreNodo:String, version:String, datosEmpresa:Array):String
{
	var util:FLUtil = new FLUtil;
	var cadenaXML:String = "<" + nombreNodo + ">";
	var cadenaFun:String;
	var sufijoError:String = util.translate("scripts", "Nodo %1").arg(nombreNodo);

	cadenaFun = this.iface.nodoPersonTypeCodeTypeFacturae("PersonTypeCode", version, datosEmpresa);
	if (cadenaFun.startsWith("ERROR"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	cadenaFun = this.iface.nodoResidenceTypeCodeTypeFacturae("ResidenceTypeCode", version, datosEmpresa);
	if (cadenaFun.startsWith("ERROR"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	if (datosEmpresa["mismopais"])
	cadenaFun = this.iface.nodoTextMin3Max30TypeFacturae("TaxIdentificationNumber", version, datosEmpresa["cifnif"]);
	else
	cadenaFun = this.iface.nodoTextMin3Max30TypeFacturae("TaxIdentificationNumber", version, datosEmpresa["codisoalpha2"] + datosEmpresa["cifnif"]);

	if (cadenaFun.startsWith("ERROR"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	cadenaXML += "</" + nombreNodo + ">";

	return cadenaXML;
}

function eFactura_nodoTaxTypeFacturae(nombreNodo:String, version:String, impuesto:Array):String
{
	var util:FLUtil = new FLUtil;
	var cadenaXML:String = "<" + nombreNodo + ">";
	var cadenaFun:String;
	var sufijoError:String = util.translate("scripts", "Nodo %1").arg(nombreNodo);

	cadenaFun = this.iface.nodoTaxTypeCodeTypeFacturae("TaxTypeCode", version, impuesto["tipoimpuesto"]);
	if (cadenaFun.startsWith("ERROR"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	switch (version) {
		case "3.0":
		case "3.2": {
				cadenaFun = this.iface.nodoDoubleTwoDecimalTypeFacturae("TaxRate", version, impuesto["porcentaje"]);
				break;
			}
		case "3.2.1": {
				cadenaFun = this.iface.nodoDoubleUpToEightDecimalTypeFacturae("TaxRate", version, impuesto["porcentaje"]);
				break;
			}
		}

	if (cadenaFun.startsWith("ERROR"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	cadenaFun = this.iface.nodoImporteTypeFacturae("TaxableBase", version, impuesto["baseimponible"]);
	if (cadenaFun.startsWith("ERROR"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	cadenaFun = this.iface.nodoImporteTypeFacturae("TaxAmount", version, impuesto["total"]);
	if (cadenaFun.startsWith("ERROR"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

//	debug("paso " + nombreNodo);
	if (impuesto["recargo"] != "")
		{
		cadenaFun = this.iface.nodoDoubleTwoDecimalTypeFacturae("EquivalenceSurcharge", version, impuesto["recargo"]);
		if (cadenaFun.startsWith("ERROR"))
			return cadenaFun + sufijoError;
		cadenaXML += cadenaFun;

		cadenaFun = this.iface.nodoImporteTypeFacturae("EquivalenceSurchargeAmount", version, impuesto["totalrecargo"]);
		if (cadenaFun.startsWith("ERROR"))
			return cadenaFun + sufijoError;
		cadenaXML += cadenaFun;
		}
	cadenaXML += "</" + nombreNodo + ">";

	return cadenaXML;
}

function eFactura_nodoTaxTypeCodeTypeFacturae(nombreNodo:String, version:String, idImpuesto:String):String
{
	var util:FLUtil = new FLUtil;
	var cadenaXML:String = "<" + nombreNodo + ">";

	switch (idImpuesto) {
		case "01":
		case "02":
		case "03":
		case "04":
		case "05":
		case "06":
		case "07":
		case "08":
		case "09":
		case "10":
		case "11":
		case "12":
		case "13":
		case "14":
		case "15":
		case "16":
		case "17":
		case "18":
		case "19":
		case "20":
		case "21":
		case "22":
		case "23":
		case "24":
		case "25":
		case "26":
		case "27":
		case "28":
		case "29": {
			cadenaXML += idImpuesto;
			break;
		}
		default: {
			return util.translate("scripts", "ERROR: Nodo %1: Tipo de impuesto desconocido (%2)").arg(nombreNodo).arg(idImpuesto);
		}
	}

	cadenaXML += "</" + nombreNodo + ">";

	return cadenaXML;
}

function eFactura_nodoPersonTypeCodeTypeFacturae(nombreNodo:String, version:String, datosEmpresa:Array):String
{
	var util:FLUtil = new FLUtil;
	var cadenaXML:String = "<" + nombreNodo + ">";
	cadenaXML += datosEmpresa["tipopersona"];
	cadenaXML += "</" + nombreNodo + ">";

	return cadenaXML;
}

function eFactura_nodoResidenceTypeCodeTypeFacturae(nombreNodo:String, version:String, datosEmpresa:Array):String
{
	// V 3.0 E: Extranjero, R: Residente, U: Residente en la Unión Europea
	var util:FLUtil = new FLUtil;
	var valor:String;

	var codISO:String = datosEmpresa["codisoalpha3"];
	if (codISO && codISO.toUpperCase() == "ESP") {
		valor = "R";
	} else {
		// XXX Nuevo campo U.E. en paí­ses
		valor = "U";
		valor = "E";
	}

	var cadenaXML:String = "<" + nombreNodo + ">";
	cadenaXML += valor;
	cadenaXML += "</" + nombreNodo + ">";

	return cadenaXML;
}

function eFactura_nodoPaisTypeFacturae(nombreNodo:String, version:String, valor:String):String
{
	var util:FLUtil = new FLUtil;
	var cadenaXML:String = "<" + nombreNodo + ">";
	cadenaXML += valor;
	cadenaXML += "</" + nombreNodo + ">";

	return cadenaXML;
}

function eFactura_nodoTextMin3Max30TypeFacturae(nombreNodo:String, version:String, valor:String):String
{
	var util:FLUtil = new FLUtil;
	if (!valor)
		return util.translate("scripts", "ERROR: Nodo %1: La cadena no está definida\n").arg(nombreNodo);

	if (valor.length < 3 || valor.length > 30)
		return util.translate("scripts", "ERROR: Nodo %1: La longitud de la cadena no está entre los valores 3 - 30").arg(nombreNodo);

	var cadenaXML:String = "<" + nombreNodo + ">";
	cadenaXML += valor;
	cadenaXML += "</" + nombreNodo + ">";

	return cadenaXML;
}

function eFactura_nodoTextMax2500TypeFacturae(nombreNodo:String, version:String, valor:String):String
{
    // Si el código o descripción del artículo esta vacio se asegura de que el valor es vacio o con un valor - y no nulo para no dar error.
    // En el cado de la descripción la norma dice que ha de tener un valor, por lo que hemos puesto un -
    if (!valor) {
        switch (nombreNodo) {
            case "ArticleCode": {
                valor = " ";
                break;
            }
            case "ItemDescription": {
                valor = "-";
                break;
            }
        }
        //debug("KLO=======> nombreNodo: "+nombreNodo);
        //debug("KLO=====> valor referencia: "+valor);
    }

    var cadenaXML:String = "";
	switch (version) {
		case "3.0":
		case "3.2":
		case "3.2.1": {
			var util:FLUtil = new FLUtil;
			if (!valor)
				return util.translate("scripts", "ERROR: Nodo %1: La cadena no está definida").arg(nombreNodo);

			if (valor.length > 2500)
				valor = valor.left(2500);
				// return util.translate("scripts", "ERROR: Nodo %1: La longitud de la cadena es superior a 2500 caracteres").arg(nombreNodo);

			cadenaXML = "<" + nombreNodo + ">";
			cadenaXML += valor;
			cadenaXML += "</" + nombreNodo + ">";
			break;
		}
	}

	return cadenaXML;
}

function eFactura_nodoTextMax80TypeFacturae(nombreNodo:String, version:String, valor:String):String
{
	var util:FLUtil = new FLUtil;
	if (!valor)
		return util.translate("scripts", "ERROR: Nodo %1: La cadena no está definida").arg(nombreNodo);

	if (valor.length > 80)
		valor = valor.left(80);
		// return util.translate("scripts", "ERROR: Nodo %1: La longitud de la cadena es superior a 80 caracteres").arg(nombreNodo);

	var cadenaXML:String = "<" + nombreNodo + ">";
	cadenaXML += valor;
	cadenaXML += "</" + nombreNodo + ">";

	return cadenaXML;
}

function eFactura_nodoTextMax50TypeFacturae(nombreNodo:String, version:String, valor:String):String
{
	var util:FLUtil = new FLUtil;

	if (!valor)
		return util.translate("scripts", "ERROR: Nodo %1: La cadena no está definida").arg(nombreNodo);

	if (valor.length > 50)
		valor = valor.left(50);
		// return util.translate("scripts", "ERROR: Nodo %1: La longitud de la cadena es superior a 50 caracteres").arg(nombreNodo);

	var cadenaXML:String = "<" + nombreNodo + ">";
	cadenaXML += valor;
	cadenaXML += "</" + nombreNodo + ">";

	return cadenaXML;
}

function eFactura_nodoTextMax40TypeFacturae(nombreNodo:String, version:String, valor:String):String
{
	var util:FLUtil = new FLUtil;

	if (!valor)
		return util.translate("scripts", "ERROR: Nodo %1: La cadena no está definida").arg(nombreNodo);

	if (valor.length > 40)
		valor = valor.left(40);
		// return util.translate("scripts", "ERROR: Nodo %1: La longitud de la cadena es superior a 40 caracteres").arg(nombreNodo);

	var cadenaXML:String = "<" + nombreNodo + ">";
	cadenaXML += valor;
	cadenaXML += "</" + nombreNodo + ">";

	return cadenaXML;
}

function eFactura_nodoTextMax20TypeFacturae(nombreNodo:String, version:String, valor:String):String
{
	var util:FLUtil = new FLUtil;

	if (!valor)
		return util.translate("scripts", "ERROR: Nodo %1: La cadena no está definida").arg(nombreNodo);

	if (valor.length > 20)
		valor = valor.left(20);
		// return util.translate("scripts", "ERROR: Nodo %1: La longitud de la cadena es superior a 20 caracteres").arg(nombreNodo);

	var cadenaXML:String = "<" + nombreNodo + ">";
	cadenaXML += valor;
	cadenaXML += "</" + nombreNodo + ">";

	return cadenaXML;
}

function eFactura_nodoPostCodeTypeFacturae(nombreNodo:String, version:String, valor:String):String
{
	var util:FLUtil = new FLUtil;

	if (!valor)
		return util.translate("scripts", "ERROR: Nodo %1: La cadena de código postal no está definida").arg(nombreNodo);

	if (valor.length > 5)
		return util.translate("scripts", "ERROR: Nodo %1: La longitud de la cadena de código postal es superior a 5 caracteres").arg(nombreNodo);

	var numero:Number = parseInt(valor);
	if (isNaN(numero))
		return util.translate("scripts", "ERROR: Nodo %1: La la cadena de código postal no es numérica").arg(nombreNodo);

	var cadenaXML:String = "<" + nombreNodo + ">";
	cadenaXML += valor;
	cadenaXML += "</" + nombreNodo + ">";

	return cadenaXML;
}

function eFactura_nodoLegalEntityTypeFacturae(nombreNodo:String, version:String, datosEmpresa:Array):String
{
	var util:FLUtil = new FLUtil;

	var cadenaXML:String = "<" + nombreNodo + ">";
	var cadenaFun:String;
	var sufijoError:String = util.translate("scripts", "Nodo %1").arg(nombreNodo);

	cadenaFun = this.iface.nodoTextMax80TypeFacturae("CorporateName", version, datosEmpresa["nombre"]);
	if (cadenaFun.startsWith("ERROR:"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	if (datosEmpresa["nombrecomercial"] != "") {
		cadenaFun = this.iface.nodoTextMax40TypeFacturae("TradeName", version, datosEmpresa["nombrecomercial"]);
		if (cadenaFun.startsWith("ERROR:"))
			return cadenaFun + sufijoError;
		cadenaXML += cadenaFun;
	}

	cadenaFun = this.iface.nodoFacturae("RegistrationData", version);
	if (cadenaFun.startsWith("ERROR:"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	if (datosEmpresa["codisoalpha3"].toUpperCase() == "ESP") {
		cadenaFun = this.iface.nodoAddressTypeFacturae("AddressInSpain", version, datosEmpresa);
	} else {
		cadenaFun = this.iface.nodoOverseasAddressTypeFacturae("OverseasAddress", version, datosEmpresa);
	}
	if (cadenaFun.startsWith("ERROR:"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	cadenaFun = this.iface.nodoFacturae("ContactDetails", version);
	if (cadenaFun.startsWith("ERROR:"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	cadenaXML += "</" + nombreNodo + ">";

	return cadenaXML;
}

function eFactura_nodoIndividualTypeFacturae(nombreNodo:String, version:String, datosEmpresa:Array):String
{
	var util:FLUtil = new FLUtil;

	var cadenaXML:String = "<" + nombreNodo + ">";
	var cadenaFun:String;
	var sufijoError:String = util.translate("scripts", "Nodo %1").arg(nombreNodo);

	cadenaFun = this.iface.nodoTextMax40TypeFacturae("Name", version, datosEmpresa["nombrepf"]);
	if (cadenaFun.startsWith("ERROR:"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	cadenaFun = this.iface.nodoTextMax40TypeFacturae("FirstSurname", version, datosEmpresa["apellido1pf"]);
	if (cadenaFun.startsWith("ERROR:"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	cadenaFun = this.iface.nodoTextMax40TypeFacturae("SecondSurname", version, datosEmpresa["apellido1pf"]);
	if (cadenaFun.startsWith("ERROR:"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	if (datosEmpresa["codisoalpha3"].toUpperCase() == "ESP") {
		cadenaFun = this.iface.nodoAddressTypeFacturae("AddressInSpain", version, datosEmpresa);
	} else {
		cadenaFun = this.iface.nodoOverseasAddressTypeFacturae("OverseasAddress", version, datosEmpresa);
	}
	if (cadenaFun.startsWith("ERROR:"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	cadenaFun = this.iface.nodoFacturae("ContactDetails", version);
	if (cadenaFun.startsWith("ERROR:"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	cadenaXML += "</" + nombreNodo + ">";

	return cadenaXML;
}

function eFactura_nodoAddressTypeFacturae(nombreNodo:String, version:String, datosEmpresa:Array):String
{
	var util:FLUtil = new FLUtil;

	var cadenaXML:String = "<" + nombreNodo + ">";
	var cadenaFun:String;
	var sufijoError:String = util.translate("scripts", "Nodo %1").arg(nombreNodo);

	cadenaFun = this.iface.nodoTextMax80TypeFacturae("Address", version, datosEmpresa["direccion"]);
	if (cadenaFun.startsWith("ERROR:"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	cadenaFun = this.iface.nodoPostCodeTypeFacturae("PostCode", version, datosEmpresa["codpostal"]);
	if (cadenaFun.startsWith("ERROR:"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	cadenaFun = this.iface.nodoTextMax50TypeFacturae("Town", version, datosEmpresa["ciudad"]);
	if (cadenaFun.startsWith("ERROR:"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	cadenaFun = this.iface.nodoTextMax20TypeFacturae("Province", version, datosEmpresa["provincia"]);
	if (cadenaFun.startsWith("ERROR:"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	cadenaFun = this.iface.nodoPaisTypeFacturae("CountryCode", version, datosEmpresa["codisoalpha3"]);
	if (cadenaFun.startsWith("ERROR:"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	cadenaXML += "</" + nombreNodo + ">";

	return cadenaXML;
}

function eFactura_nodoOverseasAddressTypeFacturae(nombreNodo:String, version:String, datosEmpresa:Array):String
{
	var util:FLUtil = new FLUtil;

	var cadenaXML:String = "<" + nombreNodo + ">";
	var cadenaFun:String;
	var sufijoError:String = util.translate("scripts", "Nodo %1").arg(nombreNodo);

	cadenaFun = this.iface.nodoTextMax80TypeFacturae("Address", version, datosEmpresa["direccion"]);
	if (cadenaFun.startsWith("ERROR:"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	cadenaFun = this.iface.nodoTextMax50TypeFacturae("PostCodeAndTown", version, datosEmpresa["codpostal"] + " " + datosEmpresa["ciudad"]);
	if (cadenaFun.startsWith("ERROR:"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	cadenaFun = this.iface.nodoTextMax20TypeFacturae("Province", version, datosEmpresa["provincia"]);
	if (cadenaFun.startsWith("ERROR:"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	cadenaFun = this.iface.nodoPaisTypeFacturae("CountryCode", version, datosEmpresa["codisoalpha3"]);
	if (cadenaFun.startsWith("ERROR:"))
		return cadenaFun + sufijoError;
	cadenaXML += cadenaFun;

	cadenaXML += "</" + nombreNodo + ">";

	return cadenaXML;
}

//// EFACTURA ///////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

