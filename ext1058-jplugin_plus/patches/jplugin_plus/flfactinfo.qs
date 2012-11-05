
/** @class_declaration jPluginPlus */
/////////////////////////////////////////////////////////////////
//// JPLUGIN_PLUS //////////////////////////////////////////////
class jPluginPlus extends jasperPlugin {
    function jPluginPlus( context ) { jasperPlugin ( context ); }
	function lanzarInforme(cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String, etiquetas:Boolean, impDirecta:Boolean, whereFijo:String, nombreReport:String, numCopias:Number, impresora:String, pdf:Boolean) {
		return this.ctx.jPluginPlus_lanzarInforme(cursor, nombreInforme, orderBy, groupBy, etiquetas, impDirecta, whereFijo, nombreReport, numCopias, impresora, pdf);
	}
	function cargaDescripcionJasper(fichero:String):String {
		return this.ctx.jPluginPlus_cargaDescripcionJasper(fichero);
	}
}

//// JPLUGIN_PLUS ////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_definition jPluginPlus */
//////////////////////////////////////////////////////////////////
//// JPLUGIN_PLUS ///////////////////////////////////////////////
function jPluginPlus_lanzarInforme(cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String, etiquetas:Boolean, impDirecta:Boolean, whereFijo:String, nombreReport:String, numCopias:Number, impresora:String, pdf:Boolean)
{
	debug("KLO--> jPluginPlus_lanzarInforme()");
	debug("nombreInforme " + nombreInforme);
	switch(nombreInforme) {
		case "i_presupuestoscli":
		case "i_pedidoscli":
		case "i_albaranescli":
		case "i_facturascli":
		case "i_reciboscli":
		case "i_pedidosprov":
		case "i_albaranesprov":
		case "i_facturasprov":
		case "i_recibosprov": {
			break;
		}
		default: {
			return this.iface.__lanzarInforme(cursor, nombreInforme, orderBy, groupBy, etiquetas, impDirecta, whereFijo, nombreReport, numCopias, impresora, pdf);
		}
	}

	var util:FLUtil = new FLUtil();
	var report:String = "";
	var consulta:String = "";
	var ordenacion:String = "";
	var arrayModelos:Array = [];

	var nomTabla:String = cursor.table();
	if (nomTabla.startsWith("i_"))
		nomTabla = nomTabla.right(nomTabla.length - 2);

	//================================================================================================
	// KLO. Aqui es donde tengo que capturar los informes de topo jxml que haya en el directorio dado.
	// KLO this.iface.rutaReports + this.iface.dbName + this.iface.barra + "reports" + this.iface.barra + nombreInforme + this.iface.barra + nombreReport + ".jrxml"
	this.iface.rutaReports =  util.readSettingEntry("jasperplugin/reportspath");
	this.iface.dbName = util.readSettingEntry("DBA/lastDB");
	this.iface.barra = this.iface.seteaBarra(); //Barra de separacion.

	var rutaInforme:String = this.iface.rutaReports + this.iface.dbName + this.iface.barra + "reports" + this.iface.barra + nombreInforme + this.iface.barra;
	debug("KLO rutaInforme: "+rutaInforme);
	var dir:Dir = new Dir(rutaInforme);
	var listaF:Array = [];
	listaF = dir.entryList("*.jrxml");


	for (var i = 0; i < listaF.length; i++)
		debug("KLO--> Lista de ficheros jasper: "+listaF[i]);

	// KLO C�digo original.
	var dialog = new Dialog(util.translate ( "scripts", "Modelos de impresion" ), 0);
	dialog.caption = "Seleccionar un modelo de impresion";
	dialog.OKButtonText = util.translate ( "scripts", "Aceptar" );
	dialog.cancelButtonText = util.translate ( "scripts", "Cancelar" );

	var bgroup:GroupBox = new GroupBox;
	dialog.add( bgroup );
	var rB:Array = [];
	var nModelos:Number = 0;
	var hayDefecto:Boolean = false;
	var hayOficial:Boolean = false;
	var posOficial:Number;
	var iniReport:String;
	var cont:Number = 0;
	var textModelo:String;
	
	
	for (nModelos = 0; nModelos < listaF.length; nModelos++) {
		textModelo = listaF[nModelos];
		var nombreReport:String = this.iface.cargaDescripcionJasper(rutaInforme + textModelo);
		if ( !nombreReport ) nombreReport =  textModelo.left(textModelo.find(".jrxml",0));
		debug("Nombre del informe: "+textModelo.left(textModelo.find(".jrxml",0)));
		rB[nModelos] = new RadioButton;
		rB[nModelos].text = nombreReport;
		arrayModelos[nModelos] = [];

		if (listaF[nModelos] != nombreInforme+".jrxml") {
			arrayModelos[nModelos]["report"] = listaF[nModelos];
			arrayModelos[nModelos]["consulta"] = "";
			arrayModelos[nModelos]["ordenacion"] = "";
			rB[nModelos].checked = false;
			bgroup.add( rB[nModelos] );
			cont ++;
		} else {
			hayOficial = true;
			posOficial = nModelos;
		}
	}

	if (hayOficial) {
		debug("KLO--> Hay oficial: "+nombreInforme);
		rB[posOficial] = new RadioButton;
		rB[posOficial].text = util.translate ( "scripts", "Modelo oficial" );
		arrayModelos[posOficial]["report"] = nombreInforme;
		arrayModelos[posOficial]["consulta"] = nombreInforme;
		arrayModelos[posOficial]["ordenacion"] = "";
		rB[posOficial].checked = true; //!hayDefecto;
		bgroup.add( rB[posOficial] );
	}

	// No hay modelos adicionales
	if (cont == 0) {
		this.iface.__lanzarInforme(cursor, nombreInforme, orderBy, groupBy, etiquetas, impDirecta, whereFijo, nombreReport, numCopias, impresora, pdf);
		return;
	}

	var lista:String = "";
	if (!dialog.exec()) {
		return;
	}
	for (var i:Number = 0; i < nModelos; i++) {
		debug("KLO--> arrayModelos en formulario: "+arrayModelos[i]["report"]);
		if (rB[i].checked == true) {
			report = arrayModelos[i]["report"];
			debug("KLO--> report devuelto: "+report);
			consulta = arrayModelos[i]["consulta"];
			if (!consulta || consulta == "") {
				consulta = nombreInforme;
			}
			ordenacion = arrayModelos[i]["ordenacion"];
			if (!ordenacion || ordenacion == "") {
				ordenacion = orderBy;
			}
			break;
		}
	}
 
	//if (!report) {
	//	report = nombreReport;
	//}

	this.iface.__lanzarInforme(cursor, consulta, ordenacion, groupBy, etiquetas, impDirecta, whereFijo, report, numCopias, impresora, pdf);
}

function jPluginPlus_cargaDescripcionJasper(fichero:String):String
{
   var xmlFinal:String;
    var ficheroO = new File(fichero);
        ficheroO.open(File.ReadOnly);
    var f = ficheroO.read();
    	ficheroO.close();
    var xmlReport = new FLDomDocument();
if (sys.osName() == "WIN32")
  f = sys.toUnicode(f, "latin1");
    if (xmlReport.setContent(f)) {
	        		if (xmlReport.namedItem("jasperReport"))
	                    		{
	                     		xmlFinal = xmlReport.toString(2);
					xmlFinal = xmlFinal.left(xmlFinal.find("\" >",0));
					xmlFinal = xmlFinal.mid(xmlFinal.find("name=\"",0));
					xmlFinal = xmlFinal.left(xmlFinal.find("\" ",0));
					xmlFinal = xmlFinal.right(xmlFinal.length - 6);
					if (sys.osName() != "WIN32") //Convertimos el fichero a UTF8 si no es win32
     	                     			xmlFinal = sys.toUnicode(xmlFinal, "utf8");
			    		}
				}
return xmlFinal;
}
//// JPLUGIN_PLUS ////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

