
/** @class_declaration boe2011 */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class boe2011 extends oficial {
    function boe2011( context ) { oficial( context ); }
    function presTelematica() {
        return this.ctx.boe2011_presTelematica();
    }
    function presTelematica2011() {
        return this.ctx.boe2011_presTelematica2011();
    }
    function nombreFichero():String {
        return this.ctx.boe2011_nombreFichero();
    }
    function formatoFichero():String{
        return this.ctx.boe2011_formatoFichero();
    }
    function tiporeg1(curMod:FLSlqCursor):String {
        return this.ctx.boe2011_tiporeg1(curMod);
    }
    function tiporeg2e(curMod:FLSlqCursor,curMod2e:FlsqlCursor,formato:String):String {
        return this.ctx.boe2011_tiporeg2e(curMod,curMod2e,formato);
    }
    function tiporeg2r(curMod:FLSlqCursor,curMod2r:FlsqlCursor,formato:String):String {
        return this.ctx.boe2011_tiporeg2r(curMod,curMod2r,formato);
    }
    function tiporeg2b(curMod:FLSlqCursor,curMod2b:FlsqlCursor,formato:String):String {
        return this.ctx.boe2011_tiporeg2b(curMod,curMod2b,formato);
    }
    function tiporeg2i(curMod:FLSlqCursor,curMod2i:FlsqlCursor,formato:String):String {
        return this.ctx.boe2011_tiporeg2i(curMod,curMod2i,formato);
    }
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends boe2011 {
	function head( context ) { boe2011 ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
	function ifaceCtx( context ) { head( context ); }
}


//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
function interna_init()
{
	this.child("toolButtonPrint").close();
	connect (this.child("toolButtonAeat"), "clicked()", this, "iface.presTelematica()");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Genera un fichero para realizar la presentación telemática del modelo
\end */
function oficial_presTelematica()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	if (!cursor.isValid()) {
		return;
	}

/*	var ejercicio:Number = parseFloat(cursor.valueBuffer("fechainicio"));
	var temp:Number = ejercicio.toString().left(4);
*/
	var nombreFichero:String = FileDialog.getSaveFileName("*.*");
	if (!nombreFichero) {
		return;
	}

	var formatos:Array = [util.translate("scripts", "Fichero TXT formato B.O.E."), util.translate("scripts", "Ficheros CSV con separador \"|\"")];

	var formato:String;
	var nombreFicheroRec:String;
	var seleccion:String = Input.getItem(util.translate("scripts", "Seleccione formato"), formatos);
	if (seleccion == util.translate("scripts", "Fichero TXT formato B.O.E.")) {
		formato = "BOE";
	} else {
		formato = "CSV";
		var iPunto:Number = nombreFichero.find(".");
		if (iPunto >= 0) {
			nombreFicheroRec = nombreFichero.left(iPunto) + "_r" + nombreFichero.right(nombreFichero.length - iPunto);
		} else {
			nombreFicheroRec = nombreFichero + "_r";
		}
	}

	var temp:Number;
	var ejercicio:Number;
	var acumuladoControl:Number = 1;
	var nombreDato:String;
	var contenido:String = "";
	var file:Object;
	file = new File(nombreFichero);
	file.open(File.WriteOnly);

	var ejercicio:String;
	var nifDeclarante:String;

//CABECERA
	nombreDato = util.translate("scripts", "Tipo de registro");
	if ((contenido.length + 1) !=  1) {
		return this.iface.errorAcumuladoControl(1, nombreDato);
	}
	contenido += "1";

	nombreDato = util.translate("scripts", "Modelo");
	if ((contenido.length + 1) !=  2) {
		return this.iface.errorAcumuladoControl(3, nombreDato);
	}
	contenido += "340";

	nombreDato = util.translate("scripts", "Ejercicio");
	if ((contenido.length + 1) !=  5) {
		return this.iface.errorAcumuladoControl(5, nombreDato);
	}
	var fecha:Date = cursor.valueBuffer("fechainicio");
	ejercicio = fecha.getYear();
	contenido += ejercicio;

	nombreDato = util.translate("scripts", "NIF entidad declarante");
	if ((contenido.length + 1) !=  9) {
		return this.iface.errorAcumuladoControl(9, nombreDato);
	}
	nifDeclarante = cursor.valueBuffer("cifnif");
	contenido += flfactppal.iface.pub_espaciosDerecha(nifDeclarante, 9);

	nombreDato = util.translate("scripts", "Apellidos y nombre ó razón social del declarante");
	if ((contenido.length + 1) !=  18) {
		return this.iface.errorAcumuladoControl(18, nombreDato);
	}
	contenido += flfactppal.iface.pub_espaciosDerecha(cursor.valueBuffer("apellidosnombrers"),40);

	nombreDato = util.translate("scripts", "Tipo de soporte");
	if ((contenido.length + 1) !=  58) {
		return this.iface.errorAcumuladoControl(58, nombreDato);
	}
	contenido += cursor.valueBuffer("tiposoporte");

	nombreDato = util.translate("scripts", "Teléfono contacto");
	if ((contenido.length + 1) !=  59) {
		return this.iface.errorAcumuladoControl(59, nombreDato);
	}
	temp = cursor.valueBuffer("telefono");
	contenido += flfactppal.iface.pub_espaciosDerecha(temp, 9);

	nombreDato = util.translate("scripts", "Apellidos y nombre del contacto");
	if ((contenido.length + 1) !=  68) {
		return this.iface.errorAcumuladoControl(68, nombreDato);
	}
	contenido += flfactppal.iface.pub_espaciosDerecha(cursor.valueBuffer("contacto"),40);

	nombreDato = util.translate("scripts", "Número identificativo de la declaración");
	if ((contenido.length + 1) !=  108) {
		return this.iface.errorAcumuladoControl(108, nombreDato);
	}
	contenido += cursor.valueBuffer("numidentificativo");

	nombreDato = util.translate("scripts", "Declaración complementaria");
	if ((contenido.length + 1) !=  121) {
		return this.iface.errorAcumuladoControl(121, nombreDato);
	}
	if (cursor.valueBuffer("complementaria")) {
		contenido += "C";
	} else {
		contenido += " ";
	}

	nombreDato = util.translate("scripts", "Declaración sustitutiva");
	if ((contenido.length + 1) !=  122) {
		return this.iface.errorAcumuladoControl(122, nombreDato);
	}
	if (cursor.valueBuffer("sustitutiva")) {
		contenido += "S";
	} else {
		contenido += " ";
	}
debug(contenido);
	nombreDato = util.translate("scripts", "Número identificativo de la declaración anterior");
	if ((contenido.length + 1) !=  123) {
		return this.iface.errorAcumuladoControl(123, nombreDato);
	}
	if (cursor.valueBuffer("complementaria") || cursor.valueBuffer("sustitutiva")) {
		temp = parseFloat(cursor.valueBuffer("numanterior"));
	} else {
		temp = "";
	}
debug("numero de la declaración anterior " + temp);
	contenido += flcontmode.iface.pub_formatoNumero(temp, 13, 0);
debug(contenido);
	nombreDato = util.translate("scripts", "Período");
	if ((contenido.length + 1) !=  136) {
		return this.iface.errorAcumuladoControl(136, nombreDato);
	}
	if (cursor.valueBuffer("tipoperiodo") == "Trimestre") {
		temp = cursor.valueBuffer("trimestre");
	} else {
		temp = cursor.valueBuffer("mes");
	}
	if (!flcontmode.iface.pub_verificarDato(temp, true, nombreDato, 2)) {
		return false;
	}
	contenido += temp;

	nombreDato = util.translate("scripts", "Número total de registros");
	if ((contenido.length + 1) !=  138) {
		return this.iface.errorAcumuladoControl(138, nombreDato);
	}
	temp = parseFloat(cursor.valueBuffer("registros"));
	contenido += flcontmode.iface.pub_formatoNumero(temp, 9, 0);

	nombreDato = util.translate("scripts", "Importe total de la base imponible");
	if ((contenido.length + 1) !=  147) {
		return this.iface.errorAcumuladoControl(147, nombreDato);
	}
	temp = parseFloat(cursor.valueBuffer("baseimponible"));
	contenido += this.iface.formatoNumero340(temp, 15, 2);

	nombreDato = util.translate("scripts", "Importe total de la cuota del impuesto");
	if ((contenido.length + 1) !=  165) {
		return this.iface.errorAcumuladoControl(165, nombreDato);
	}
	temp = cursor.valueBuffer("cuotaimpuesto");
	contenido += this.iface.formatoNumero340(temp, 15, 2);

	nombreDato = util.translate("scripts", "Importe total de las facturas");
	if ((contenido.length + 1) !=  183) {
		return this.iface.errorAcumuladoControl(183, nombreDato);
	}
	temp = cursor.valueBuffer("totalfacturas");
	contenido += this.iface.formatoNumero340(temp, 15, 2);

	nombreDato = util.translate("scripts", "Blancos");
	if ((contenido.length + 1) !=  201) {
		return this.iface.errorAcumuladoControl(201, nombreDato);
	}
	contenido += flfactppal.iface.pub_espaciosDerecha("", 190);

	nombreDato = util.translate("scripts", "NIF del representante legal del declarante");
	if ((contenido.length + 1) !=  391) {
		return this.iface.errorAcumuladoControl(391, nombreDato);
	}
	temp = cursor.valueBuffer("cifnifrepres");
	contenido += flfactppal.iface.pub_espaciosDerecha(temp, 9);

	nombreDato = util.translate("scripts", "Código electrónico. Autoliquidación IVA");
	if ((contenido.length + 1) !=  400) {
		return this.iface.errorAcumuladoControl(400, nombreDato);
	}
	contenido += flfactppal.iface.pub_espaciosDerecha(cursor.valueBuffer("codelectronico"), 16);

	nombreDato = util.translate("scripts", "Blancos");
	if ((contenido.length + 1) !=  416) {
		return this.iface.errorAcumuladoControl(416, nombreDato);
	}
	contenido += flfactppal.iface.pub_espaciosDerecha("", 85);

	file.writeLine(contenido);

	contenido += "\n";


//FACTURAS EMITIDAS

	var qryFacturasEmitidas:FLSqlQuery = new FLSqlQuery();
	qryFacturasEmitidas.setTablesList("co_facturasemi340");
	qryFacturasEmitidas.setSelect("cifnif, cifnifrp, apellidosnomrs, codpais, claveidentificacion, numidentificacion, tipolibro, operacion, fechaexpedicion, fechaoperacion, tipoimpositivo, baseimponible, cuotaimpuesto, importetotal, baseimponiblecoste, idenfactura, numregistro, numfacturas, desgloseregistro, intervidentif, intervidentif2, identfacturarect, tiporecequi, cuotarecequi");
	qryFacturasEmitidas.setFrom("co_facturasemi340");
	qryFacturasEmitidas.setWhere("idmodelo = " + cursor.valueBuffer("idmodelo"));
		if (!qryFacturasEmitidas.exec()) {
		return false;
	}
	var contenidoEmitidas:String;
	var contenidoCSV:String = "";
	util.createProgressDialog(util.translate("scripts", "Guardando facturas emitidas..."), qryFacturasEmitidas.size());
	var progreso:Number = 0;
	while (qryFacturasEmitidas.next()) {
		util.setProgress(++progreso);
		contenidoEmitidas = "";
		contenidoCSV = "";

		nombreDato = util.translate("scripts", "Tipo de registro");
		if ((contenidoEmitidas.length + 1) !=  1) {
			return this.iface.errorAcumuladoControl(1, nombreDato);
		}
		temp = "2";
		contenidoEmitidas += temp;
		contenidoCSV += temp;

		nombreDato = util.translate("scripts", "Modelo");
		if ((contenidoEmitidas.length + 1) !=  2) {
			return this.iface.errorAcumuladoControl(2, nombreDato);
		}
		temp = "340";
		contenidoEmitidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Ejercicio");
		if ((contenidoEmitidas.length + 1) !=  5) {
			return this.iface.errorAcumuladoControl(5, nombreDato);
		}
		temp = ejercicio;
		contenidoEmitidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "NIF entidad declarante");
		if ((contenidoEmitidas.length + 1) !=  9) {
			return this.iface.errorAcumuladoControl(9, nombreDato);
		}
		temp = flfactppal.iface.pub_espaciosDerecha(nifDeclarante, 9);
		contenidoEmitidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "NIF declarado");
		if ((contenidoEmitidas.length + 1) !=  18) {
			return this.iface.errorAcumuladoControl(18, nombreDato);
		}
		temp = qryFacturasEmitidas.value("cifnif");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 9);
		contenidoEmitidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "NIF del representante legal");
		if ((contenidoEmitidas.length + 1) !=  27) {
			return this.iface.errorAcumuladoControl(27, nombreDato);
		}
		temp = qryFacturasEmitidas.value("cifnifrp");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 9);
		contenidoEmitidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Apellidos y nombre, razón social o denominación");
		if ((contenidoEmitidas.length + 1) !=  36) {
			return this.iface.errorAcumuladoControl(36, nombreDato);
		}
		temp = qryFacturasEmitidas.value("apellidosnomrs");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 40);
		contenidoEmitidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Código país");
		if ((contenidoEmitidas.length + 1) !=  76) {
			return this.iface.errorAcumuladoControl(76, nombreDato);
		}
		temp = qryFacturasEmitidas.value("codpais");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 2);
		contenidoEmitidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Clave número de identificación en el país de residencia");
		if ((contenidoEmitidas.length + 1) !=  78) {
			return this.iface.errorAcumuladoControl(78, nombreDato);
		}
		temp = qryFacturasEmitidas.value("claveidentificacion");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 1);
		contenidoEmitidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Número de identificación fiscal en el país de residencia");
		if ((contenidoEmitidas.length + 1) !=  79) {
			return this.iface.errorAcumuladoControl(79, nombreDato);
		}
		temp = qryFacturasEmitidas.value("numidentificacion");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 20);
		contenidoEmitidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Clave tipo libro");
		if ((contenidoEmitidas.length + 1) !=  99) {
			return this.iface.errorAcumuladoControl(99, nombreDato);
		}
		temp = qryFacturasEmitidas.value("tipolibro");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 1);
		contenidoEmitidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Clave de operación");
		if ((contenidoEmitidas.length + 1) !=  100) {
			return this.iface.errorAcumuladoControl(100, nombreDato);
		}
		temp = qryFacturasEmitidas.value("operacion");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 1);
		contenidoEmitidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Fecha de expedición");
		if ((contenidoEmitidas.length + 1) !=  101) {
			return this.iface.errorAcumuladoControl(101, nombreDato);
		}
		temp = qryFacturasEmitidas.value("fechaexpedicion");
		temp = this.iface.formatoFecha(temp.toString());
		contenidoEmitidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Fecha de operación");
		if ((contenidoEmitidas.length + 1) !=  109) {
			return this.iface.errorAcumuladoControl(109, nombreDato);
		}
		temp = qryFacturasEmitidas.value("fechaoperacion");
		temp = this.iface.formatoFecha(temp.toString());
		contenidoEmitidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Tipo impositivo");
		if ((contenidoEmitidas.length + 1) !=  117) {
			return this.iface.errorAcumuladoControl(117, nombreDato);
		}
		temp = qryFacturasEmitidas.value("tipoimpositivo");
		contenidoEmitidas += flcontmode.iface.pub_formatoNumero(temp, 3, 2);
		contenidoCSV += "|" + this.iface.formatoNumeroCSV(temp, "co_facturasemi340", "tipoimpositivo");

		nombreDato = util.translate("scripts", "Base imponible");
		if ((contenidoEmitidas.length + 1) !=  122) {
			return this.iface.errorAcumuladoControl(122, nombreDato);
		}
		temp = qryFacturasEmitidas.value("baseimponible");
		contenidoEmitidas += this.iface.formatoNumero340(temp, 11, 2);
		contenidoCSV += "|" + this.iface.formatoNumeroCSV(temp, "co_facturasemi340", "baseimponible");

		nombreDato = util.translate("scripts", "Cuota del impuesto");
		if ((contenidoEmitidas.length + 1) !=  136) {
			return this.iface.errorAcumuladoControl(136, nombreDato);
		}
		temp = qryFacturasEmitidas.value("cuotaimpuesto");
		contenidoEmitidas += this.iface.formatoNumero340(temp, 11, 2);
		contenidoCSV += "|" + this.iface.formatoNumeroCSV(temp, "co_facturasemi340", "cuotaimpuesto");

		nombreDato = util.translate("scripts", "Importe total de la factura");
		if ((contenidoEmitidas.length + 1) !=  150) {
			return this.iface.errorAcumuladoControl(150, nombreDato);
		}
		temp = qryFacturasEmitidas.value("importetotal");
		contenidoEmitidas += this.iface.formatoNumero340(temp, 11, 2);
		contenidoCSV += "|" + this.iface.formatoNumeroCSV(temp, "co_facturasemi340", "importetotal");

		nombreDato = util.translate("scripts", "Base imponible a coste");
		if ((contenidoEmitidas.length + 1) !=  164) {
			return this.iface.errorAcumuladoControl(164, nombreDato);
		}
		temp = qryFacturasEmitidas.value("baseimponiblecoste");
		contenidoEmitidas += this.iface.formatoNumero340(temp, 11, 2);
		contenidoCSV += "|" + this.iface.formatoNumeroCSV(temp, "co_facturasemi340", "baseimponiblecoste");

		nombreDato = util.translate("scripts", "Identificación de la factura");
		if ((contenidoEmitidas.length + 1) !=  178) {
			return this.iface.errorAcumuladoControl(178, nombreDato);
		}
		temp = qryFacturasEmitidas.value("idenfactura");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 40);
		contenidoEmitidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Número de registro");
		if ((contenidoEmitidas.length + 1) !=  218) {
			return this.iface.errorAcumuladoControl(218, nombreDato);
		}
		temp = qryFacturasEmitidas.value("numregistro");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 18);
		contenidoEmitidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Número de facturas");
		if ((contenidoEmitidas.length + 1) !=  236) {
			return this.iface.errorAcumuladoControl(236, nombreDato);
		}
		temp = qryFacturasEmitidas.value("numfacturas");
		contenidoEmitidas += flcontmode.iface.pub_formatoNumero(temp, 8, 0);
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Nº registro (desglose)");
		if ((contenidoEmitidas.length + 1) !=  244) {
			return this.iface.errorAcumuladoControl(244, nombreDato);
		}
		temp = qryFacturasEmitidas.value("desgloseregistro");
		contenidoEmitidas += flcontmode.iface.pub_formatoNumero(temp, 2, 0);
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Intervalo de identificación de la acumulación (primer número)");
		if ((contenidoEmitidas.length + 1) !=  246) {
			return this.iface.errorAcumuladoControl(246, nombreDato);
		}
		temp = qryFacturasEmitidas.value("intervidentif");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 40);
		contenidoEmitidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Intervalo de identificación de la acumulación (último número)");
		if ((contenidoEmitidas.length + 1) !=  286) {
			return this.iface.errorAcumuladoControl(286, nombreDato);
		}
		temp = qryFacturasEmitidas.value("intervidentif2");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 40);
		contenidoEmitidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Identificación de la factura rectificada");
		if ((contenidoEmitidas.length + 1) !=  326) {
			return this.iface.errorAcumuladoControl(326, nombreDato);
		}
		temp = qryFacturasEmitidas.value("identfacturarect");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 40);
		contenidoEmitidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Tipo de recargo de equivalencia");
		if ((contenidoEmitidas.length + 1) !=  366) {
			return this.iface.errorAcumuladoControl(366, nombreDato);
		}
		temp = qryFacturasEmitidas.value("tiporecequi");
		contenidoEmitidas += flcontmode.iface.pub_formatoNumero(temp, 3, 2);
		contenidoCSV += "|" + this.iface.formatoNumeroCSV(temp, "co_facturasemi340", "tiporecequi");

		nombreDato = util.translate("scripts", "Cuota del recargo de equivalencia");
		if ((contenidoEmitidas.length + 1) !=  371) {
			return this.iface.errorAcumuladoControl(371, nombreDato);
		}
		temp = qryFacturasEmitidas.value("cuotarecequi");
		contenidoEmitidas += this.iface.formatoNumero340(temp, 11, 2);
		contenidoCSV += "|" + this.iface.formatoNumeroCSV(temp, "co_facturasemi340", "cuotarecequi");

		//Blancos del 385 al 500
		nombreDato = util.translate("scripts", "Espacios fin de registro emitidas");
		if ((contenidoEmitidas.length + 1) !=  385) {
			return this.iface.errorAcumuladoControl(385, nombreDato);
		}
		contenidoEmitidas = flfactppal.iface.espaciosDerecha(contenidoEmitidas, 500);

		nombreDato = util.translate("scripts", "Fin de registro emitidas");
		if ((contenidoEmitidas.length + 1) !=  501) {
			return this.iface.errorAcumuladoControl(501, nombreDato);
		}

		if (formato == "CSV") {
			contenidoCSV = sys.fromUnicode( contenidoCSV, "ISO-8859-1");
			file.writeLine(contenidoCSV);
		} else {
			contenidoEmitidas = sys.fromUnicode( contenidoEmitidas, "ISO-8859-1");
			file.writeLine(contenidoEmitidas);
		}

// 		contenidoEmitidas += "\n";
// 		contenido += contenidoEmitidas;
// 		contenidoCSV += "\n";

	}
	util.destroyProgressDialog();

	if (formato == "CSV") {
// 		contenidoCSV = sys.fromUnicode( contenidoCSV, "ISO-8859-1");
// 		file.write(contenidoCSV);
		file.close();
		file = new File(nombreFicheroRec);
		file.open(File.WriteOnly);
	}
//FACTURAS RECIBIDAS

	var qryFacturasRecibidas:FLSqlQuery = new FLSqlQuery();
	qryFacturasRecibidas.setTablesList("co_facturasrec340");
	qryFacturasRecibidas.setSelect("cifnif, cifnifrp, apellidosnomrs, codpais, claveidentificacion, numidentificacion, tipolibro, operacion, fechaexpedicion, fechaoperacion, tipoimpositivo, baseimponible, cuotaimpuesto, importetotal, baseimponiblecoste, idenfactura, numregistro, numfacturas, desgloseregistro, intervidentif, intervidentif2, cuotadeducible");
	qryFacturasRecibidas.setFrom("co_facturasrec340");
	qryFacturasRecibidas.setWhere("idmodelo = " + cursor.valueBuffer("idmodelo"));
		if (!qryFacturasRecibidas.exec()) {
		return false;
	}
	var contenidoRecibidas:String;
	contenidoCSV = "";
	util.createProgressDialog(util.translate("scripts", "Guardando facturas recibidas..."), qryFacturasRecibidas.size());
	progreso = 0;
	while (qryFacturasRecibidas.next()) {
		util.setProgress(++progreso);
		contenidoRecibidas = "";
		contenidoCSV = "";

		nombreDato = util.translate("scripts", "Tipo de registro");
		if ((contenidoRecibidas.length + 1) !=  1) {
			return this.iface.errorAcumuladoControl(1, nombreDato);
		}
		temp = "2";
		contenidoRecibidas += temp;
		contenidoCSV += temp;

		nombreDato = util.translate("scripts", "Modelo");
		if ((contenidoRecibidas.length + 1) !=  2) {
			return this.iface.errorAcumuladoControl(2, nombreDato);
		}
		temp = "340";
		contenidoRecibidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Ejercicio");
		if ((contenidoRecibidas.length + 1) !=  5) {
			return this.iface.errorAcumuladoControl(5, nombreDato);
		}
		temp = ejercicio;
		contenidoRecibidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "NIF entidad declarante");
		if ((contenidoRecibidas.length + 1) !=  9) {
			return this.iface.errorAcumuladoControl(9, nombreDato);
		}
		temp = flfactppal.iface.pub_espaciosDerecha(nifDeclarante, 9);
		contenidoRecibidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "NIF declarado");
		if ((contenidoRecibidas.length + 1) !=  18) {
			return this.iface.errorAcumuladoControl(18, nombreDato);
		}
		temp = qryFacturasRecibidas.value("cifnif");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 9);
		contenidoRecibidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "NIF del representante legal");
		if ((contenidoRecibidas.length + 1) !=  27) {
			return this.iface.errorAcumuladoControl(27, nombreDato);
		}
		temp = qryFacturasRecibidas.value("cifnifrp");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 9);
		contenidoRecibidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Apellidos y nombre, razón social o denominación");
		if ((contenidoRecibidas.length + 1) !=  36) {
			return this.iface.errorAcumuladoControl(36, nombreDato);
		}
		temp = qryFacturasRecibidas.value("apellidosnomrs");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 40);
		contenidoRecibidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Código país");
		if ((contenidoRecibidas.length + 1) !=  76) {
			return this.iface.errorAcumuladoControl(76, nombreDato);
		}
		temp = qryFacturasRecibidas.value("codpais");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 2);
		contenidoRecibidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Clave número de identificación en el país de residencia");
		if ((contenidoRecibidas.length + 1) !=  78) {
			return this.iface.errorAcumuladoControl(78, nombreDato);
		}
		temp = qryFacturasRecibidas.value("claveidentificacion");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 1);
		contenidoRecibidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Número de identificación fiscal en el país de residencia");
		if ((contenidoRecibidas.length + 1) !=  79) {
			return this.iface.errorAcumuladoControl(79, nombreDato);
		}
		temp = qryFacturasRecibidas.value("numidentificacion");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 20);
		contenidoRecibidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Clave tipo libro");
		if ((contenidoRecibidas.length + 1) !=  99) {
			return this.iface.errorAcumuladoControl(99, nombreDato);
		}
		temp = qryFacturasRecibidas.value("tipolibro");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 1);
		contenidoRecibidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Clave de operación");
		if ((contenidoRecibidas.length + 1) !=  100) {
			return this.iface.errorAcumuladoControl(100, nombreDato);
		}
		temp = qryFacturasRecibidas.value("operacion");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 1);
		contenidoRecibidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Fecha de expedición");
		if ((contenidoRecibidas.length + 1) !=  101) {
			return this.iface.errorAcumuladoControl(101, nombreDato);
		}
		temp = qryFacturasRecibidas.value("fechaexpedicion");
		temp = this.iface.formatoFecha(temp.toString());
		contenidoRecibidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Fecha de operación");
		if ((contenidoRecibidas.length + 1) !=  109) {
			return this.iface.errorAcumuladoControl(109, nombreDato);
		}
		temp = qryFacturasRecibidas.value("fechaoperacion");
		temp = this.iface.formatoFecha(temp.toString());
		contenidoRecibidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Tipo impositivo");
		if ((contenidoRecibidas.length + 1) !=  117) {
			return this.iface.errorAcumuladoControl(117, nombreDato);
		}
		temp = qryFacturasRecibidas.value("tipoimpositivo");
		contenidoRecibidas += flcontmode.iface.pub_formatoNumero(temp, 3, 2);
		contenidoCSV += "|" + this.iface.formatoNumeroCSV(temp, "co_facturasrec340", "tipoimpositivo");

		nombreDato = util.translate("scripts", "Base imponible");
		if ((contenidoRecibidas.length + 1) !=  122) {
			return this.iface.errorAcumuladoControl(122, nombreDato);
		}
		temp = qryFacturasRecibidas.value("baseimponible");
		contenidoRecibidas += this.iface.formatoNumero340(temp, 11, 2);
		contenidoCSV += "|" + this.iface.formatoNumeroCSV(temp, "co_facturasrec340", "baseimponible");

		nombreDato = util.translate("scripts", "Cuota del impuesto");
		if ((contenidoRecibidas.length + 1) !=  136) {
			return this.iface.errorAcumuladoControl(136, nombreDato);
		}
		temp = qryFacturasRecibidas.value("cuotaimpuesto");
		contenidoRecibidas += this.iface.formatoNumero340(temp, 11, 2);
		contenidoCSV += "|" + this.iface.formatoNumeroCSV(temp, "co_facturasrec340", "cuotaimpuesto");

		nombreDato = util.translate("scripts", "Importe total de la factura");
		if ((contenidoRecibidas.length + 1) !=  150) {
			return this.iface.errorAcumuladoControl(150, nombreDato);
		}
		temp = qryFacturasRecibidas.value("importetotal");
		contenidoRecibidas += this.iface.formatoNumero340(temp, 11, 2);
		contenidoCSV += "|" + this.iface.formatoNumeroCSV(temp, "co_facturasrec340", "importetotal");

		nombreDato = util.translate("scripts", "Base imponible a coste");
		if ((contenidoRecibidas.length + 1) !=  164) {
			return this.iface.errorAcumuladoControl(164, nombreDato);
		}
		temp = qryFacturasRecibidas.value("baseimponiblecoste");
		contenidoRecibidas += this.iface.formatoNumero340(temp, 11, 2);
		contenidoCSV += "|" + this.iface.formatoNumeroCSV(temp, "co_facturasrec340", "baseimponiblecoste");

		nombreDato = util.translate("scripts", "Identificación de la factura");
		if ((contenidoRecibidas.length + 1) !=  178) {
			return this.iface.errorAcumuladoControl(178, nombreDato);
		}
		temp = qryFacturasRecibidas.value("idenfactura");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 40);
		contenidoRecibidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Número de registro");
		if ((contenidoRecibidas.length + 1) !=  218) {
			return this.iface.errorAcumuladoControl(218, nombreDato);
		}
		temp = qryFacturasRecibidas.value("numregistro");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 18);
		contenidoRecibidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Número de facturas");
		if ((contenidoRecibidas.length + 1) !=  236) {
			return this.iface.errorAcumuladoControl(236, nombreDato);
		}
		temp = qryFacturasRecibidas.value("numfacturas");
		contenidoRecibidas += flcontmode.iface.pub_formatoNumero(temp, 18, 0);
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Nº registro (desglose)");
		if ((contenidoRecibidas.length + 1) !=  254) {
			return this.iface.errorAcumuladoControl(254, nombreDato);
		}
		temp = qryFacturasRecibidas.value("desgloseregistro");
		contenidoRecibidas += flcontmode.iface.pub_formatoNumero(temp, 2, 0);
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Intervalo de identificación de la acumulación (primer número)");
		if ((contenidoRecibidas.length + 1) !=  256) {
			return this.iface.errorAcumuladoControl(256, nombreDato);
		}
		temp = qryFacturasRecibidas.value("intervidentif");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 40);
		contenidoRecibidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Intervalo de identificación de la acumulación (último número)");
		if ((contenidoRecibidas.length + 1) !=  296) {
			return this.iface.errorAcumuladoControl(296, nombreDato);
		}
		temp = qryFacturasRecibidas.value("intervidentif2");
		temp = flfactppal.iface.pub_espaciosDerecha(temp, 40);
		contenidoRecibidas += temp;
		contenidoCSV += "|" + temp;

		nombreDato = util.translate("scripts", "Cuota deducible");
		if ((contenidoRecibidas.length + 1) !=  336) {
			return this.iface.errorAcumuladoControl(336, nombreDato);
		}
		temp = qryFacturasRecibidas.value("cuotadeducible");
		contenidoRecibidas += this.iface.formatoNumero340(temp, 11, 2);
		contenidoCSV += "|" + this.iface.formatoNumeroCSV(temp, "co_facturasrec340", "cuotadeducible");

		//Blancos del 350 al 500
		nombreDato = util.translate("scripts", "Espacios fin de registro recibidas");
		if ((contenidoRecibidas.length + 1) !=  350) {
			return this.iface.errorAcumuladoControl(350, nombreDato);
		}
		contenidoRecibidas = flfactppal.iface.espaciosDerecha(contenidoRecibidas, 500);

		nombreDato = util.translate("scripts", "Fin de registro emitidas");
		if ((contenidoRecibidas.length + 1) !=  501) {
			return this.iface.errorAcumuladoControl(501, nombreDato);
		}

		if (formato == "CSV") {
			contenidoCSV = sys.fromUnicode( contenidoCSV, "ISO-8859-1");
			file.writeLine(contenidoCSV);
		} else {
			contenidoRecibidas = sys.fromUnicode( contenidoRecibidas, "ISO-8859-1");
			file.writeLine(contenidoRecibidas);
		}
// 		contenidoRecibidas += "\n";
// 		contenido += contenidoRecibidas;
// 		contenidoCSV += "\n";
	}
	util.destroyProgressDialog();

	temp = String.fromCharCode(13, 10);
	contenido += temp;

// 	if (formato == "BOE") {
// 		contenido = sys.fromUnicode(contenido, "ISO-8859-1");
// 		file.write(contenido);
// 	} else {
// 		contenidoCSV = sys.fromUnicode(contenidoCSV, "ISO-8859-1");
// 		file.write(contenidoCSV);
// 	}
	file.close();

	if (formato == "BOE") {
		MessageBox.information(util.translate("scripts", "El fichero se ha generado en :\n\n" + nombreFichero + "\n\n"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
	} else {
		MessageBox.information(util.translate("scripts", "Los ficheros generados son:\n\n %1\n%2\n\n").arg(nombreFichero).arg(nombreFicheroRec), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
	}
}

function oficial_errorAcumuladoControl(acumuladoControl:Number, nombreDato:String):Boolean
{
	var util:FLUtil = new FLUtil;
	util.destroyProgressDialog();
	MessageBox.warning(util.translate("scripts", "Error al crear el fichero: El dato %1 no comienza en la posición %2").arg(nombreDato).arg(acumuladoControl), MessageBox.Ok, MessageBox.NoButton);
	return false;
}

function oficial_formatoNumero340(numero:Number, enteros:Number, decimales:Number):String
{
	var resultado:String = "";
	if (numero >= 0) {
		resultado = " ";
	} else {
		numero = numero * -1;
		resultado = "N";
	}
	resultado += flcontmode.iface.pub_formatoNumero(numero, enteros, decimales);
	return resultado;
}

function oficial_formatoFecha(fecha:String):String
{
	var res:String = fecha.substring(0, 4) + fecha.substring(5, 7) + fecha.substring(8, 10);
	return res;
}

function oficial_formatoNumeroCSV(numero:Number, tabla:String, campo:String):String
{
	var util:FLUtil = new FLUtil;
	var numeroCSV:String = util.roundFieldValue(numero, tabla, campo);
	numeroCSV = numeroCSV.replace(".", ",");
	return numeroCSV;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition boe2011 */
//////////////////////////////////////////////////////////////////
//// BOE2011 /////////////////////////////////////////////////////
/** \D Genera un fichero para realizar la presentación telemática del modelo
\end */

function boe2011_presTelematica()
{
    this.iface.presTelematica2011();
}

function boe2011_presTelematica2011() {

    var curMod:FLSqlCursor = this.cursor();
    if (!curMod.isValid()){
        return;
    }

    var nombreFichero = this.iface.nombreFichero();
    if (!nombreFichero){
        return;
    }

    var formatoFichero = this.iface.formatoFichero();
    if (!formatoFichero) {
        return;
    }

     var util:FLUtil = new FLUtil();
    util.createProgressDialog(util.translate("scripts", "Generando registro de tipo 1"), 10);
    util.setProgress(2);

    flcontmode.iface.error = "";

    var file:Object = new File(nombreFichero);
    file.open(File.WriteOnly);

    file.write(this.iface.tiporeg1(curMod) + "\r\n");

    util.setProgress(10);
    util.destroyProgressDialog();

    var curMod2e:FLSqlCursor = new FLSqlCursor("co_facturasemi340");
    curMod2e.select("idmodelo = " + curMod.valueBuffer("idmodelo") + " AND (omitir = false OR omitir is null) ");
    util.createProgressDialog(util.translate("scripts", "Generando registro de tipo 2 facturas expedidas"), curMod2e.size());
    var progreso:Number = 0;
    while (curMod2e.next()){
        util.setProgress(progreso++);
        file.write(this.iface.tiporeg2e(curMod,curMod2e,formatoFichero) + "\r\n");
    }
    util.destroyProgressDialog();

    var curMod2r:FLSqlCursor = new FLSqlCursor("co_facturasrec340");
    curMod2r.select("idmodelo = " + curMod.valueBuffer("idmodelo"));
    util.createProgressDialog(util.translate("scripts", "Generando registro de tipo 2 facturas recibidas"), curMod2r.size());
    var progreso:Number = 0;
    while (curMod2r.next()){
        util.setProgress(progreso++);
        file.write(this.iface.tiporeg2r(curMod,curMod2r,formatoFichero) + "\r\n");
    }
    util.destroyProgressDialog();

    var curMod2b:FLSqlCursor = new FLSqlCursor("co_bienesinv340");
    curMod2b.select("idmodelo = " + curMod.valueBuffer("idmodelo"));
    util.createProgressDialog(util.translate("scripts", "Generando registro de tipo 2 bienes inmuebles"), curMod2b.size());
    var progreso:Number = 0;
    while (curMod2b.next()){
        util.setProgress(progreso++);
        file.write(this.iface.tiporeg2b(curMod,curMod2b,formatoFichero) + "\r\n");
    }
    util.destroyProgressDialog();


    var curMod2i:FLSqlCursor = new FLSqlCursor("co_opintracomunitarias340");
    curMod2i.select("idmodelo = " + curMod.valueBuffer("idmodelo"));
    util.createProgressDialog(util.translate("scripts", "Generando registro de tipo 2 bienes inmuebles"), curMod2i.size());
    var progreso:Number = 0;
    while (curMod2i.next()){
        util.setProgress(progreso++);
        file.write(this.iface.tiporeg2i(curMod,curMod2i,formatoFichero) + "\r\n");
    }

    file.close();

    // Genera copia del fichero en codificacion ISO
    file.open(File.ReadOnly);
    var content = file.read();
    file.close();

    var fileIso = new File(nombreFichero + ".iso8859" );
    fileIso.open(File.WriteOnly);
    fileIso.write( sys.fromUnicode( content, "ISO-8859-1" ) );
    fileIso.close();

    util.destroyProgressDialog();

    var util:FLUtil = new FLUtil();
    if (flcontmode.iface.error == "") {
        MessageBox.information(util.translate("scripts", "Generado fichero en:\n\n" + nombreFichero+".iso8859" + "\n\n"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    } else {
        MessageBox.information(util.translate("scripts", "Se han detectado los siguientes errores :\n\n" +flcontmode.iface.error+ "\n\n"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    }
}

function boe2011_nombreFichero():String
{
    var nombreFichero:String = FileDialog.getSaveFileName("*.*");
    if (!nombreFichero) {
        MessageBox.warning("No ha indicado el nombre del fichero",MessageBox.Ok, MessageBox.NoButton);
        return "";
    } else {
        return nombreFichero;
    }

}

function boe2011_formatoFichero():String{

    var util:FLUtil = new FLUtil();
    var formatos:Array = [util.translate("scripts", "Fichero TXT formato B.O.E."), util.translate("scripts", "Ficheros CSV con separador \"|\"")];

    var formato:String;
    var seleccion:String = Input.getItem(util.translate("scripts", "Seleccione formato"), formatos);
    if (seleccion == util.translate("scripts", "Fichero TXT formato B.O.E.")) {
        formato = "BOE";
    } else {
        formato = "CSV";
    }

    return formato;
}

function boe2011_tiporeg1(curMod:FLSlqCursor):String {

    //Registro de tipo 1 declarante
    var codReg = "1";
    var desReg:Array = flcontmode.iface.pub_desRegistro340(codReg);

    var util:FLUtil = new FLUtil();
    var valorCampo;
    var nombreCampo = "";
    var formatoCampo = "";
    var registro:Object = {};

    for (var i = 0; i < desReg.length; i++) {
        nombreCampo = desReg[i][0];
        longitudCampo = desReg[i][2];
        formatoCampo = desReg[i][3];
        if (formatoCampo == "B") {
            valorCampo = " ";
        } else {
            switch(nombreCampo) {
                case "tiporeg":
                    valorCampo = "1";
                    break;

                case "modelo":
                    valorCampo = "340";
                    break;

                case "ejercicio":
                    var fecha:Date = curMod.valueBuffer("fechainicio");
                    valorCampo = fecha.getYear();
                    break;

                case "complementaria":
                    if (curMod.valueBuffer("complementaria")) {
                        valorCampo = "C";
                    } else {
                        valorCampo = " ";
                    }
                    break;
                case "sustitutiva":
                    if (curMod.valueBuffer("sustitutiva")) {
                        valorCampo = "S";
                    } else{
                        valorCampo = " ";
                    }
                    break;

                case "jusanterior":
                    if (curMod.valueBuffer("complementaria") || curMod.valueBuffer("sustitutiva")) {
                        valorCampo = curMod.valueBuffer("numanterior");
                    } else {
                        valorCampo = "0";
                    }
                    break;

                case "periodo":
                    if (curMod.valueBuffer("tipoperiodo") == "Trimestre") {
                        valorCampo = curMod.valueBuffer("trimestre");
                    } else {
                        valorCampo = curMod.valueBuffer("mes");
                    }
                    break;

                case "sbaseimponible":
                    if (curMod.valueBuffer("baseimponible") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "stotalfacturas":
                    if (curMod.valueBuffer("totalfacturas") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "scuotaimpuesto":
                    if (curMod.valueBuffer("cuotaimpuesto") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "baseimponible":
                case "cuotaimpuesto":
                case "totalfacturas":
                    valorCampo = flcontmode.iface.pub_formatoNumero(Math.abs(parseFloat(curMod.valueBuffer(nombreCampo))), (parseFloat(longitudCampo)-2), 2);
                    break;

                default :
                    valorCampo = curMod.valueBuffer(nombreCampo);
                    break;
            }
        }

        registro[nombreCampo] = valorCampo;
    }

    return flcontmode.iface.pub_generarRegistro(desReg,registro);

}

/*Registro de declarados facturas emitidas*/
function boe2011_tiporeg2e(curMod:FLSlqCursor,curMod2e:FlsqlCursor,formato:String):String {

    var codReg = "2e";
    var desReg:Array = flcontmode.iface.pub_desRegistro340(codReg);

    var util:FLUtil = new FLUtil();
    var valorCampo;
    var nombreCampo = "";
    var formatoCampo = "";
    var registro:Object = {};

    for (var i = 0; i < desReg.length; i++) {
        nombreCampo = desReg[i][0];
        longitudCampo = desReg[i][2];
        formatoCampo = desReg[i][3];
        if (formatoCampo == "B") {
            valorCampo = " ";
        } else {
            switch(nombreCampo) {
                case "tiporeg":
                    valorCampo = "2";
                    break;

                case "modelo":
                    valorCampo = "340";
                    break;

                case "ejercicio":
                    var fecha:Date = curMod.valueBuffer("fechainicio");
                    valorCampo = fecha.getYear();
                    break;

                case "cifnif":
                    valorCampo = curMod.valueBuffer("cifnif");
                    break;

                case "nifdeclarado":
                    valorCampo = curMod2e.valueBuffer("cifnif");
                    break;

                case "fechaexpedicion":
                    var temp = curMod2e.valueBuffer("fechaexpedicion");
                    if (!temp && curMod2e.valueBuffer("importemetalico") != 0) {
                        valorCampo = "0";
                    } else {
                        valorCampo = this.iface.formatoFecha(temp.toString());
                    }
                    break;

                case "fechaoperacion":
                    var temp = curMod2e.valueBuffer("fechaoperacion");
                    if (!temp && curMod2e.valueBuffer("importemetalico") != 0) {
                        valorCampo = "0";
                    } else {
                        valorCampo = this.iface.formatoFecha(temp.toString());
                    }
                    break;

                case "sbaseimponible":
                    if (curMod2e.valueBuffer("baseimponible") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "scuotaimpuesto":
                    if (curMod2e.valueBuffer("cuotaimpuesto") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "simportetotal":
                    if (curMod2e.valueBuffer("importetotal") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "sbaseimponiblecoste":
                    if (curMod2e.valueBuffer("baseimponiblecoste") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "scuotarecequi":
                    if (curMod2e.valueBuffer("cuotarecequi") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "tipoimpositivo":
                case "tiporecequi":
                    valorCampo = flcontmode.iface.pub_formatoNumero(parseFloat(curMod2e.valueBuffer(nombreCampo)), (parseFloat(longitudCampo)-2), 2);
                    break;

                case "baseimponible":
                case "cuotaimpuesto":
                case "importetotal":
                case "baseimponiblecoste":
                case "cuotarecequi":
                case "importemetalico":
                case "importeinmuebles":
                    valorCampo = flcontmode.iface.pub_formatoNumero(Math.abs(parseFloat(curMod2e.valueBuffer(nombreCampo))), (parseFloat(longitudCampo)-2), 2);
                    break;

                case "idenfactura":
                case "numregistro":
                    var temp = curMod2e.valueBuffer(nombreCampo);
                    if (!temp && curMod2e.valueBuffer("importemetalico") != 0) {
                        valorCampo = "";
                    } else {
                        valorCampo = temp;
                    }
                    break;

                case "numfacturas":
                case "desgloseregistro":
                    var temp = curMod2e.valueBuffer(nombreCampo);
                    if (!temp && curMod2e.valueBuffer("importemetalico") != 0) {
                        valorCampo = "0";
                    } else {
                        valorCampo = temp;
                    }
                    break;

                case "ejerciciometalico":
                    if (!curMod2e.valueBuffer("importemetalico"))
                        valorCampo = "0";
                    else
                        valorCampo = curMod2e.valueBuffer("ejerciciometalico");
                    break;

                default :
                    valorCampo = curMod2e.valueBuffer(nombreCampo);
                    break;
            }
        }

        registro[nombreCampo] = valorCampo;
    }

    if (formato == "BOE") {
        return flcontmode.iface.pub_generarRegistro(desReg,registro);
    } else {
        /*PARA VALIDAR REGISTRO*/
        var tempValidar = flcontmode.iface.pub_generarRegistro(desReg,registro);
        return flcontmode.iface.pub_generarCSV(desReg,registro);
    }

}

/*Registro de declarados facturas recibidas*/
function boe2011_tiporeg2r(curMod:FLSlqCursor,curMod2r:FlsqlCursor,formato:String):String {

    var codReg = "2r";
    var desReg:Array = flcontmode.iface.pub_desRegistro340(codReg);

    var util:FLUtil = new FLUtil();
    var valorCampo;
    var nombreCampo = "";
    var formatoCampo = "";
    var registro:Object = {};

    for (var i = 0; i < desReg.length; i++) {
        nombreCampo = desReg[i][0];
        longitudCampo = desReg[i][2];
        formatoCampo = desReg[i][3];
        if (formatoCampo == "B") {
            valorCampo = " ";
        } else {
            switch(nombreCampo) {
                case "tiporeg":
                    valorCampo = "2";
                    break;

                case "modelo":
                    valorCampo = "340";
                    break;

                case "ejercicio":
                    var fecha:Date = curMod.valueBuffer("fechainicio");
                    valorCampo = fecha.getYear();
                    break;

                case "cifnif":
                    valorCampo = curMod.valueBuffer("cifnif");
                    break;

                case "nifdeclarado":
                    valorCampo = curMod2r.valueBuffer("cifnif");
                    break;

                case "fechaexpedicion":
                    var temp = curMod2r.valueBuffer("fechaexpedicion");
                    valorCampo = this.iface.formatoFecha(temp.toString());
                    break;

                case "fechaoperacion":
                    var temp = curMod2r.valueBuffer("fechaoperacion");
                    valorCampo = this.iface.formatoFecha(temp.toString());
                    break;

                case "sbaseimponible":
                    if (curMod2r.valueBuffer("baseimponible") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "scuotaimpuesto":
                    if (curMod2r.valueBuffer("cuotaimpuesto") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "simportetotal":
                    if (curMod2r.valueBuffer("importetotal") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "sbaseimponiblecoste":
                    if (curMod2r.valueBuffer("baseimponiblecoste") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "scuotadeducible":
                    if (curMod2r.valueBuffer("cuotadeducible") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "tipoimpositivo":
                    valorCampo = flcontmode.iface.pub_formatoNumero(parseFloat(curMod2r.valueBuffer(nombreCampo)), (parseFloat(longitudCampo)-2), 2);
                    break;

                case "baseimponible":
                case "cuotaimpuesto":
                case "importetotal":
                case "baseimponiblecoste":
                case "cuotadeducible":
                    valorCampo = flcontmode.iface.pub_formatoNumero(Math.abs(parseFloat(curMod2r.valueBuffer(nombreCampo))), (parseFloat(longitudCampo)-2), 2);
                    break;

                default :
                    valorCampo = curMod2r.valueBuffer(nombreCampo);
                    break;
            }
        }

        registro[nombreCampo] = valorCampo;
    }

    if (formato == "BOE") {
        return flcontmode.iface.pub_generarRegistro(desReg,registro);
    } else {
        /*PARA VALIDAR REGISTRO*/
        var tempValidar = flcontmode.iface.pub_generarRegistro(desReg,registro);
        return flcontmode.iface.pub_generarCSV(desReg,registro);
    }

}

/*Registro de declarados de bienes de inversión*/
function boe2011_tiporeg2b(curMod:FLSlqCursor,curMod2b:FlsqlCursor,formato:String):String {

    var codReg = "2b";
    var desReg:Array = flcontmode.iface.pub_desRegistro340(codReg);

    var util:FLUtil = new FLUtil();
    var valorCampo;
    var nombreCampo = "";
    var formatoCampo = "";
    var registro:Object = {};

    for (var i = 0; i < desReg.length; i++) {
        nombreCampo = desReg[i][0];
        longitudCampo = desReg[i][2];
        formatoCampo = desReg[i][3];
        if (formatoCampo == "B") {
            valorCampo = " ";
        } else {
            switch(nombreCampo) {
                case "tiporeg":
                    valorCampo = "2";
                    break;

                case "modelo":
                    valorCampo = "340";
                    break;

                case "ejercicio":
                    var fecha:Date = curMod.valueBuffer("fechainicio");
                    valorCampo = fecha.getYear();
                    break;

                case "cifnif":
                    valorCampo = curMod.valueBuffer("cifnif");
                    break;

                case "nifdeclarado":
                    valorCampo = curMod2b.valueBuffer("cifnif");
                    break;

                case "fechaexpedicion":
                    var temp = curMod2b.valueBuffer("fechaexpedicion");
                    valorCampo = this.iface.formatoFecha(temp.toString());
                    break;

                case "fechaoperacion":
                    var temp = curMod2b.valueBuffer("fechaoperacion");
                    valorCampo = this.iface.formatoFecha(temp.toString());
                    break;

                case "sbaseimponible":
                    if (curMod2b.valueBuffer("baseimponible") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "scuotaimpuesto":
                    if (curMod2b.valueBuffer("cuotaimpuesto") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "simportetotal":
                    if (curMod2b.valueBuffer("importetotal") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "sbaseimponiblecoste":
                    if (curMod2b.valueBuffer("baseimponiblecoste") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "sreganual":
                    if (curMod2b.valueBuffer("reganual") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "sreganualefect":
                    if (curMod2b.valueBuffer("reganualefect") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "tipoimpositivo":
                    valorCampo = flcontmode.iface.pub_formatoNumero(parseFloat(curMod2b.valueBuffer(nombreCampo)), (parseFloat(longitudCampo)-2), 2);
                    break;

                case "baseimponible":
                case "cuotaimpuesto":
                case "importetotal":
                case "baseimponiblecoste":
                case "reganual":
                case "reganualefect":
                    valorCampo = flcontmode.iface.pub_formatoNumero(Math.abs(parseFloat(curMod2b.valueBuffer(nombreCampo))), (parseFloat(longitudCampo)-2), 2);
                    break;

            case "fechautilizacion":
                    var temp = curMod2b.valueBuffer("fechautilizacion");
                    valorCampo = this.iface.formatoFecha(temp.toString());
                    break;

                default :
                    valorCampo = curMod2b.valueBuffer(nombreCampo);
                    break;
            }
        }

        registro[nombreCampo] = valorCampo;
    }

    if (formato == "BOE") {
        return flcontmode.iface.pub_generarRegistro(desReg,registro);
    } else {
        /*PARA VALIDAR REGISTRO*/
        var tempValidar = flcontmode.iface.pub_generarRegistro(desReg,registro);
        return flcontmode.iface.pub_generarCSV(desReg,registro);
    }

}

/*Registro de declarados de determinadas operaciones intracomunitarias*/
function boe2011_tiporeg2i(curMod:FLSlqCursor,curMod2i:FlsqlCursor,formato:String):String {

    var codReg = "2i";
    var desReg:Array = flcontmode.iface.pub_desRegistro340(codReg);

    var util:FLUtil = new FLUtil();
    var valorCampo;
    var nombreCampo = "";
    var formatoCampo = "";
    var registro:Object = {};

    for (var i = 0; i < desReg.length; i++) {
        nombreCampo = desReg[i][0];
        longitudCampo = desReg[i][2];
        formatoCampo = desReg[i][3];
        if (formatoCampo == "B") {
            valorCampo = " ";
        } else {
            switch(nombreCampo) {
                case "tiporeg":
                    valorCampo = "2";
                    break;

                case "modelo":
                    valorCampo = "340";
                    break;

                case "ejercicio":
                    var fecha:Date = curMod.valueBuffer("fechainicio");
                    valorCampo = fecha.getYear();
                    break;

                case "cifnif":
                    valorCampo = curMod.valueBuffer("cifnif");
                    break;

                case "nifdeclarado":
                    valorCampo = curMod2i.valueBuffer("cifnif");
                    break;

                case "fechaexpedicion":
                    var temp = curMod2i.valueBuffer("fechaexpedicion");
                    valorCampo = this.iface.formatoFecha(temp.toString());
                    break;

                case "fechaoperacion":
                    var temp = curMod2i.valueBuffer("fechaoperacion");
                    valorCampo = this.iface.formatoFecha(temp.toString());
                    break;

                case "sbaseimponible":
                    if (curMod2i.valueBuffer("baseimponible") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "scuotaimpuesto":
                    if (curMod2i.valueBuffer("cuotaimpuesto") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "simportetotal":
                    if (curMod2i.valueBuffer("importetotal") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "sbaseimponiblecoste":
                    if (curMod2i.valueBuffer("baseimponiblecoste") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "tipoimpositivo":
                    valorCampo = flcontmode.iface.pub_formatoNumero(parseFloat(curMod2i.valueBuffer(nombreCampo)), (parseFloat(longitudCampo)-2), 2);
                    break;

                case "baseimponible":
                case "cuotaimpuesto":
                case "importetotal":
                case "baseimponiblecoste":
                    valorCampo = flcontmode.iface.pub_formatoNumero(Math.abs(parseFloat(curMod2i.valueBuffer(nombreCampo))), (parseFloat(longitudCampo)-2), 2);
                    break;

                default :
                    valorCampo = curMod2i.valueBuffer(nombreCampo);
                    break;
            }
        }

        registro[nombreCampo] = valorCampo;
    }

    if (formato == "BOE") {
        return flcontmode.iface.pub_generarRegistro(desReg,registro);
    } else {
        /*PARA VALIDAR REGISTRO*/
        var tempValidar = flcontmode.iface.pub_generarRegistro(desReg,registro);
        return flcontmode.iface.pub_generarCSV(desReg,registro);
    }

}

//// BOE2011 /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

