
/** @class_declaration modImpresion */
/////////////////////////////////////////////////////////////////
//// MOD_IMPRESION //////////////////////////////////////////////
class modImpresion extends oficial {
    function modImpresion( context ) { oficial ( context ); }
	function lanzarInforme(cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String, etiquetas:Boolean, impDirecta:Boolean, whereFijo:String, nombreReport:String, numCopias:Number, impresora:String, pdf:Boolean) {
		return this.ctx.modImpresion_lanzarInforme(cursor, nombreInforme, orderBy, groupBy, etiquetas, impDirecta, whereFijo, nombreReport, numCopias, impresora, pdf);
	}
}
//// MOD_IMPRESION ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition modImpresion */
//////////////////////////////////////////////////////////////////
//// MOD_IMPRESION ///////////////////////////////////////////////
function modImpresion_lanzarInforme(cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String, etiquetas:Boolean, impDirecta:Boolean, whereFijo:String, nombreReport:String, numCopias:Number, impresora:String, pdf:Boolean)
{
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
// Control de resumenes
// 		case "i_resalbaranescli":
// 		case "i_resfacturascli":
// 		case "i_respedidoscli":
// 		case "i_respresupuestoscli":
// 		case "i_resalbaranesprov":
// 		case "i_resfacturasprov":
// 		case "i_respedidosprov":
// 		case "i_resreciboscli":
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
		
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("modelosimpresion");
	q.setFrom("modelosimpresion");
	q.setSelect("descripcion, report, consulta, modelodefecto, ordenacion");
 	q.setWhere("tipointerno = '" + nomTabla + "' ORDER BY descripcion");
	if (!q.exec()) {
		return false;
	}
	
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
	
	while (q.next())  {
		rB[nModelos] = new RadioButton;
		rB[nModelos].text = q.value("descripcion");
		arrayModelos[nModelos] = [];
// debug("Report " + q.value("report") + " Consulta " + q.value("consulta"));
		arrayModelos[nModelos]["report"] = q.value("report");
		arrayModelos[nModelos]["consulta"] = q.value("consulta");
		arrayModelos[nModelos]["ordenacion"] = q.value("ordenacion");
		if (q.value("modelodefecto")) {
			hayDefecto = true;
			rB[nModelos].checked = true;
		} else {
			rB[nModelos].checked = false;
		}
		if (arrayModelos[nModelos]["report"] == nombreReport && arrayModelos[nModelos]["consulta"] == nombreReport && arrayModelos[nModelos]["ordenacion"] == "") {
			hayOficial = true;
		}
		bgroup.add( rB[nModelos] );
		nModelos ++;
	}
	
	if (!hayOficial) {
		rB[nModelos] = new RadioButton;
		rB[nModelos].text = util.translate ( "scripts", "Modelo oficial" );
		arrayModelos[nModelos] = [];
		arrayModelos[nModelos]["report"] = nombreReport;
		arrayModelos[nModelos]["consulta"] = nombreReport;
		arrayModelos[nModelos]["ordenacion"] = "";
		rB[nModelos].checked = !hayDefecto;
		bgroup.add( rB[nModelos] );
	}

	// No hay modelos adicionales	
	if (nModelos == 0) {
		this.iface.__lanzarInforme(cursor, nombreInforme, orderBy, groupBy, etiquetas, impDirecta, whereFijo, nombreReport, numCopias, impresora, pdf);
		return;
	}
	
	var lista:String = "";
	if (!dialog.exec()) {
		return;
	}
	for (var i:Number = 0; i <= nModelos; i++) {
		if (rB[i].checked == true) {
			report = arrayModelos[i]["report"];
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
	
	if (!report) {
		report = nombreReport;
	}
// debug("Report final " + report + " Consulta " + consulta);
	this.iface.__lanzarInforme(cursor, consulta, ordenacion, groupBy, etiquetas, impDirecta, whereFijo, report, numCopias, impresora, pdf);
}
//// MOD_IMPRESION ////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
