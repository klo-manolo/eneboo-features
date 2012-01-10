
/** @class_declaration jasper */
/////////////////////////////////////////////////////////////////
/////// JASPER /////////////////////////////////////////////////
class jasper extends oficial {
	function jasper( context ) { oficial( context ); }

	function lanzarJRXML(informe:String,modelo:String,argumentos:String) {
		return this.ctx.jasper_lanzarJRXML(informe,modelo,argumentos);
	}
	function lanzarInforme(cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String, etiquetas:Boolean, impDirecta:Boolean, whereFijo:String, nombreReport:String, numCopias:Number, impresora:String, pdf:Boolean) {
		return this.ctx.jasper_lanzarInforme(cursor, nombreInforme, orderBy, groupBy, etiquetas, impDirecta, whereFijo, nombreReport, numCopias, impresora, pdf);
	}
	function sysexec(comando:String):Array {
		return this.ctx.jasper_sysexec(comando);
	}
}
//// JASPER /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition jasper */
//////////////////////////////////////////////////////////////////
//// JASPER /////////////////////////////////////////////////////
function jasper_sysexec(comando:String):Array
{
	var res:Array = [];
	Process.execute(comando);
	if (Process.stderr != "") {
		res["ok"] = false;
		res["salida"] = "!" + Process.stderr + "(" + Process.stdout + ")";
	} else {
		res["ok"] = true;
		res["salida"] = Process.stdout;
	}
	return res["salida"];
}

function jasper_lanzarJRXML(informe:String,modelo:String,argumentos:String)
{
	var util:FLUtil = new FLUtil();    
	debug("Lanzamos el informe '" + informe + "' modelo '" + modelo + "'");
	debug("argumentos:" + argumentos);     
	util.createProgressDialog ("Imprimiendo informe '" + informe + "' modelo '" + modelo + "'", 100)
	util.setProgress(1);
	var curColaImpresion:FLSqlCursor = new FLSqlCursor("jrpt_colaimpresion");    
	curColaImpresion.setModeAccess(curColaImpresion.Insert);
	curColaImpresion.refresh();
	curColaImpresion.setValueBuffer("codinforme",informe);
	curColaImpresion.setValueBuffer("modelo",modelo);
	curColaImpresion.setValueBuffer("argumentos",argumentos);
	curColaImpresion.setValueBuffer("estado","Pendiente");
	curColaImpresion.setValueBuffer("peticion","imprimir");
	curColaImpresion.commitBuffer();
	var id = curColaImpresion.valueBuffer("id");
	util.setProgress(2);
	var estado = "Pendiente";
	var n = 0;
	var n1 = 0;
	var mInicio:Date = new Date();
	var mFin:Date = new Date();
	while(estado == "Pendiente") {
		if (n1!=n) {
			estado = util.sqlSelect("jrpt_colaimpresion","estado","id = '" + id + "'");
			n1=n;
		}
		mFin = new Date();
		n = (mFin.getTime() - mInicio.getTime()) / 200;
		util.setProgress(3+n%10);
		
	}
	
	mInicio = new Date();
	while(estado == "Procesando") {
		if (n1!=n) {
			estado = util.sqlSelect("jrpt_colaimpresion","estado","id = '" + id + "'");
			n1=n;
		}
		mFin = new Date();
		n = (mFin.getTime() - mInicio.getTime()) / 200;
		util.setProgress(13+n%80);
	}
	util.setProgress(95);
	if (estado != "Finalizado")
	{ 
		txt_msg = util.sqlSelect("jrpt_colaimpresion","mensaje","id = '" + id + "'");
		MessageBox.information("Ocurrió un error inesperado al imprimir (estado="+estado+")"+"\n\n"+txt_msg , MessageBox.Ok, MessageBox.NoButton);
		
		util.destroyProgressDialog();
		return;
	}
	var urlpdf = util.sqlSelect("jrpt_colaimpresion","urlpdf","id = '" + id + "'"); 
	var rutaImpresion:String;
	rutaImpresion = util.readSettingEntry("scripts/flfactinfo/RutaServer", "");
	var rutaVisor:String;
	rutaVisor = util.readSettingEntry("scripts/flfactinfo/RutaVisor", "");
	var rutaArchivo:String=rutaImpresion.toString()+urlpdf.toString();
	rutaArchivo.toString();
	var rutaArchivo2:String=rutaArchivo;
	
	if (util.readSettingEntry("scripts/flfactinfo/CambiarBarras",  0)==1)
	{
		var i:Number=0;
		for (i=0;i<32;i++) {
			rutaArchivo2=rutaArchivo2.replace(new RegExp("/"),"\\");
		}
	}
	else
	{
		rutaArchivo2=rutaArchivo;
	}
	debug(rutaVisor);
	debug(rutaArchivo);
	debug(rutaArchivo2);
	debug(this.iface.sysexec([rutaVisor,rutaArchivo2]));
	util.destroyProgressDialog();
	
	
	MessageBox.information("Impresión terminada.", MessageBox.Ok, MessageBox.NoButton);
	return;
	
}

/** \D
Lanza un informe
@param	cursor: Cursor con los criterios de búsqueda para la consulta base del informe
@param	nombreinforme: Nombre del informe
@param	orderBy: Cláusula ORDER BY de la consulta base
@param	groupBy: Cláusula GROUP BY de la consulta base
@param	etiquetas: Indicador de si se trata de un informe de etiquetas
@param	impDirecta: Indicador para imprimir directaemnte el informe, sin previsualización
@param	whereFijo: Sentencia where que debe preceder a la sentencia where calculada por la función
\end */
function jasper_lanzarInforme(cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String, etiquetas:Boolean, impDirecta:Boolean, whereFijo:String, nombreReport:String, numCopias:Number, impresora:String, pdf:Boolean)
{
	debug("KLO--> lanzarInforme 1");
	
	var util:FLUtil = new FLUtil();    
	existeJrxml = util.sqlSelect("flfiles","nombre","nombre = '" + nombreInforme + ".jrxml'");
	existeKut = util.sqlSelect("flfiles","nombre","nombre = '" + nombreInforme + ".kut'");
	solicitaJrxml = util.sqlSelect("jrpt_declararinforme","solicitajrxml","codinforme = '" + nombreInforme + "'");
	solicitaKut = util.sqlSelect("jrpt_declararinforme","solicitakut","codinforme = '" + nombreInforme + "'");   
	debug(nombreInforme);
	
	var dialog:Dialog = new Dialog;
	dialog.okButtonText = util.translate("scripts","Aceptar");
	dialog.cancelButtonText = util.translate("scripts","Cancelar");
	var bgroup:GroupBox = new GroupBox;
	dialog.add(bgroup);
	
	var cursorModelos:FLSqlCursor = new FLSqlCursor("jrpt_modeloinforme");
	cursorModelos.select("codinforme = '"+nombreInforme+"'");
	var i:Number = 0;
	var lstRB:Array=[];
	var lstRBcod:Array=[];
	
	while (cursorModelos.next()) {
		var rB:Object;
		rB = new RadioButton;
		bgroup.add(rB);
		rB.text = cursorModelos.valueBuffer("descripcion");
		if( i == 0)
			rB.checked = true;
		else
			rB.checked = false;
		lstRB[i]=rB;
		lstRBcod[i]=cursorModelos.valueBuffer("nombre");
		i++;
		
		
	}
	if (existeJrxml)
	{
		if (i==0 || solicitaJrxml)
		{
			rB = new RadioButton;
			bgroup.add(rB);
			rB.text = "Informe JasperReports";
			lstRB[i]=rB;
			lstRBcod[i]=nombreInforme;
			i++;
		}
	}
	
	if (existeKut)
	{
		if (i==0 || solicitaKut)
		{
			rB = new RadioButton;
			bgroup.add(rB);
			rB.text = "Informe AbanQ";
			lstRB[i]=rB;
			lstRBcod[i]="KUT";
			i++;
		}
	}
	
	var numOpciones = i;
	var opcionElegida = -1;
	if (numOpciones==0)
	{
		MessageBox.information("No hay ningún modelo asociado a este informe. No se puede imprimir", MessageBox.Ok, MessageBox.NoButton);
		return;
	} 
	else if (numOpciones==1)
	{
		opcionElegida = 0;
	}
	else
	{
		if(!dialog.exec()) return;                                                                                  
		for (i=0;i<numOpciones;i++)
		{
			rB =  lstRB[i];
			if (rB.checked)
			{
				opcionElegida = i;
				break;
			}
		}
	}            
	var q:FLSqlQuery = this.iface.establecerConsulta(cursor, nombreInforme, orderBy, groupBy, whereFijo);
	
	var modelo = lstRBcod[opcionElegida];
	if (modelo != "KUT") {
		var argumentos = "";
		if(q.where())
		{
			argumentos += "WHERE=" +q.where()+"\n";
		}
		else
		{
			argumentos += "WHERE=" + "1 = 1";
		}
		if(q.orderBy())
		{ 
			argumentos += "ORDERBY=" +q.orderBy()+"\n";
		}
		else
		{
			argumentos += "ORDERBY=" + "1";
		}
		this.iface.lanzarJRXML(nombreInforme,modelo,argumentos);
		return;
	}
	
	/////////////////////////////////////////////////
	////////////////////////////////////////////////
	//KLO. A PARTIR DE AQUI ES LO OFICIAL 
	return this.iface.__lanzarInforme(cursor, nombreInforme, orderBy, groupBy, etiquetas, impDirecta, whereFijo, nombreReport, numCopias, impresora, pdf);
}
//// JASPER /////////////////////////////////////////////////
//////////////////////////////////////////////
