
/** @class_declaration jasperPlugin */
//////////////////////////////////////////////////////////////////
//// JASPER_PLUGIN ///////////////////////////////////////////////
class jasperPlugin extends oficial /** %from: oficial */ {
    var rutaReports:String;
    var dbName:String;
    var reportsFolder:String;
    var barra:String;
    var procesoJP:Process;
    var procesoInicializado:Boolean = false;
    var procesoVisible:Boolean = false;
    var rutaTrabajoVieja:String;
    var detectarRutaTrabajo:Boolean;
    var guardaTemporal:Boolean;
    var whereCursor:String;
    var whereFijoExt:String;
    var reportAnterior;
    function jasperPlugin( context ) { oficial( context ); }
function lanzarInforme(cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String, etiquetas:Boolean, impDirecta:Boolean, whereFijo:String, nombreReport:String, numCopias:Number, impresora:String, pdf:Boolean) {
        return this.ctx.jasperPlugin_lanzarInforme(cursor, nombreInforme, orderBy, groupBy, etiquetas, impDirecta, whereFijo, nombreReport, numCopias, impresora, pdf);
    }
function comprobarJasperFisico( reportName:String ):Boolean {
            return this.ctx.jasperPlugin_comprobarJasperFisico(reportName);
    }
function seteaBarra():String {
        return this.ctx.jasperPlugin_seteaBarra();
    }
    function tratarReport(nombreFichero:String, consultaOriginalSQL:String ):String {
        return this.ctx.jasperPlugin_tratarReport(nombreFichero, consultaOriginalSQL);
    }
    function generarComando( rutaJP:String ):Boolean {
       return this.ctx.jasperPlugin_generarComando(rutaJP );
    }
   function datosProcesoRecibidos() {
       return this.ctx.jasperPlugin_datosProcesoRecibidos();
    }
    function establecerConsulta(cursor:FLSqlCursor, nombreConsulta:String, orderBy:String, groupBy:String, whereFijo:String):FLSqlQuery {
                return this.ctx.jasperPlugin_establecerConsulta(cursor, nombreConsulta, orderBy, groupBy, whereFijo);
        }
   function whereFijoExtendido(nombreInforme:String):String {
       return this.ctx.jasperPlugin_whereFijoExtendido(nombreInforme);
    }
}
//// JASPER_PLUGIN ///////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition jasperPlugin */
//////////////////////////////////////////////////////////////////
//// JASPER_PLUGIN ///////////////////////////////////////////////

function jasperPlugin_lanzarInforme(cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String, etiquetas:Boolean, impDirecta:Boolean, whereFijo:String, nombreReport:String, numCopias:Number, impresora:String, pdf:Boolean)
    {
            var util:FLUtil = new FLUtil();
            var etiquetaInicial:Array = [];

  	    //Comprobamos si whereFijo contiene parametrosJasper.
          	  //Contamos \n

                             	var cadena1:String = "";
                             	var cadena2:String;

                                // Agregamos los parametros extras al whereFijo
                                this.iface.whereFijoExt = "";
                                this.iface.whereFijoExtendido(nombreInforme);
                                whereFijo = whereFijo + this.iface.whereFijoExt;

                             	if (!whereFijo || whereFijo == "")
                             	{
                             	cadena2 = "";
                             	debug("JASPER_PLUGIN :: WhereFijo está vacío");
                             	}
                             	else cadena2 = whereFijo;

                             	var cantidadParametrosJasper:Number = -1;
                             	var parametrosJasper:String = ""; // Aquí guardamos la lista de parametros a pasar a la librería.
                             	do
                             	  {
                             	  cadena1 = cadena2;
                             	  cantidadParametrosJasper++;
                             	  cadena2 = cadena2.replace("\n","");
                             	  } while (cadena1 != cadena2);
                             	 if (cantidadParametrosJasper > 0)
                             	 			{
                             	 			debug("JASPER_PLUGIN :: Se han encontrado varios saltos de linea (PARAMETROS) en whereFijo");
		            				parametrosJasper = whereFijo;
		            				//Se procede a sacar whereFijo si existe
		            				if ( whereFijo.lastIndexOf("WHEREFIJO\n") == -1)
		            					{
		            					debug("JASPER_PLUGIN :: Entre los PARAMETROS no se encuentra WHEREFIFO");
		            					whereFijo = ""; //ponemos whereFijo vacio
		            					}
		            					else
		            						{
		            						whereFijo = whereFijo.right(whereFijo.length - (whereFijo.lastIndexOf("WHEREFIJO") + 10));
		            						whereFijo = whereFijo.mid(0,whereFijo.indexOf("\n"));
		            						if (whereFijo != "")
		            						debug("JASPER_PLUGIN :: WHEREFIJO = " + whereFijo);
		            						else
		            						debug("JASPER_PLUGIN :: WHEREFIJO existe, pero está vacío");
		            						}
		            				} else debug("JASPER_PLUGIN :: whereFijo NO contiene saltos de linea(PARAMETROS)");






            if (etiquetas == true) {
                    etiquetaInicial = this.iface.seleccionEtiquetaInicial();
            } else {
                    etiquetaInicial["fila"] = 0;
                    etiquetaInicial["col"] = 0;
            }

            this.iface.ultIdDocPagina = "";
            var q:FLSqlQuery;
            if(nombreInforme != "version")
                    {

            q = this.iface.establecerConsulta(cursor, nombreInforme, orderBy, groupBy, whereFijo);
    //debug("------ CONSULTA -------" + q.sql());
    	  if (util.sqlSelect("flfiles", "nombre", "nombre = '" + nombreInforme + ".qry'"))
    	  	{
                 if (q.exec() == false) {
                    MessageBox.critical(util.translate("scripts", "Falló la consulta"), MessageBox.Ok, MessageBox.NoButton);
                    return;
                 } else {
                         if (q.first() == false) {
                         MessageBox.warning(util.translate("scripts", "No hay registros que cumplan los criterios de búsqueda establecidos"), MessageBox.Ok, MessageBox.NoButton);
                         return;
                    				}
            		}
               }
                 }
            var tipoReport:String = "";
            if (!nombreReport || nombreReport == "") {
                    nombreReport = nombreInforme;
            } else {
                    var extension:String;
                    var iPunto:Number = nombreReport.findRev(".");
                    if (iPunto > -1) {
                            extension = nombreReport.right(nombreReport.length - (iPunto + 1));
                            nombreReport = nombreReport.left(iPunto);
                            if (extension.toLowerCase() == "jxml") {
                                    tipoReport = "JasperQueryData";
                            } else if (extension.toLowerCase() == "jdxml") {
                                    tipoReport = "JasperXmlData";
                            }
                    }
                    //debug("extension = '" + extension + "'");
                    debug("JASPER_PLUGIN :: nombreReport = '" + nombreReport + "'");
                    debug("JASPER_PLUGIN :: nombreInforme = '" + nombreInforme + "'");
                    //debug("tipoReport = '" + tipoReport + "'");
            }


            switch (tipoReport) {
                    case "JasperQueryData": {
                            var jpViewer = new FLJasperViewer;
                            jpViewer.setReportData(q);
                            jpViewer.setReportTemplate(nombreReport);
                            jpViewer.exec();
                            break;
                    }
                    case "JasperXmlData": {
                      var xmlData = sys.toXmlReportData(q);
                      var regExp = new RegExp(" \\|\\| ' ' \\|\\| ");

                      regExp.global = true;
                      xmlData.setContent(xmlData.toString(0).replace(regExp,"_"));

          var jpViewer = new FLJasperViewer;
          jpViewer.setReportData(xmlData);
          jpViewer.setReportTemplate(nombreReport);
          jpViewer.exec();
                            break;
                    }
                    default: {

                    	//Cargamos configuración plugin
                        this.iface.rutaReports =  util.readSettingEntry("jasperplugin/reportspath");
                        this.iface.guardaTemporal = util.readSettingEntry("jasperplugin/guardatemporal");
                        this.iface.dbName = sys.nameBD();
                        this.iface.detectarRutaTrabajo = util.readSettingEntry("jasperplugin/detecRT");
                        this.iface.barra = this.iface.seteaBarra(); //Barra de separacion.
                        //Generamos ruta a directorio de reports
                        var fullPath:String  = this.iface.rutaReports + this.iface.dbName + this.iface.barra + "reports" + this.iface.barra + nombreInforme + this.iface.barra;
                        var fullPathReport:String = fullPath + nombreReport + ".jrxml";
                        //Si existe un report en ruta " path / dbName / reports / nombre_informe / nombre_report.jrxml " o pregunto por versión
                        if (this.iface.comprobarJasperFisico(fullPathReport) || nombreInforme == "version")
                                     {
                                  debug ("JASPER_PLUGIN :: Report encontrado");
                                  debug ("JASPER_PLUGIN :: Procesando plantilla " + fullPathReport);




                        	 if (cantidadParametrosJasper % 2 == 0)
	                             	 		cantidadParametrosJasper = cantidadParametrosJasper / 2 ; //Sacamos parejas en limpio
 								 else
                             						{
                             						debug ("JASPER_PLUGIN :: ERROR :: PARAMETRO - VALOR impares. Se pasan solo los Automáticos");
                             						cantidadParametrosJasper = 0;
                             						parametrosJasper="";
                             						}
				//comprobamos orderBy y groupBy !undefined
				if (!orderBy) orderBy="";
				if (!groupBy) groupBy="";

                               	//Ahora añadimos parametros especiales a parametrosJasper (where,orderby,groupby) y añadimos 6 saltos de linea a cantidadParametrosJasper


                               	if ( parametrosJasper.lastIndexOf("WHERE\n") == -1)
                               					{
                               					parametrosJasper = "WHERE\n" + this.iface.whereCursor+"\n" + parametrosJasper;
                               					cantidadParametrosJasper++;
                               					} else debug("JASPER_PLUGIN :: PELIGRO :: El parámetro WHERE no es el automático");
                             	if ( parametrosJasper.lastIndexOf("ORDERBY\n") == -1)
                             					{
                             					parametrosJasper = "ORDERBY\n" + orderBy+"\n" + parametrosJasper;
                             					cantidadParametrosJasper++;
                             					} else debug("JASPER_PLUGIN :: PELIGRO :: El parámetro ORDERBY no es el automático");
                            	if ( parametrosJasper.lastIndexOf("GROUPBY\n") == -1)
                            					{
                            					parametrosJasper = "GROUPBY\n" + groupBy+"\n" + parametrosJasper;
                            					cantidadParametrosJasper++;
                            					} else debug("JASPER_PLUGIN :: PELIGRO :: El parámetro GROUPBY no es el automático");

                            	if (etiquetas == true) //Si son etiquetas.
                            		{
                            	if ( parametrosJasper.lastIndexOf("ETIQUETAFILA\n") == -1)
                            					{
                            					parametrosJasper = "ETIQUETAFILA\n" + etiquetaInicial["fila"] +"\n" + parametrosJasper;
                            					cantidadParametrosJasper++;
                            					} else debug("JASPER_PLUGIN :: PELIGRO :: El parámetro ETIQUETAFILA no es el automático");
                            	if ( parametrosJasper.lastIndexOf("ETIQUETACOLUMNA\n") == -1)
                            					{
                            					parametrosJasper = "ETIQUETACOLUMNA\n" + etiquetaInicial["col"] +"\n" + parametrosJasper;
                            					cantidadParametrosJasper++;
                            					} else debug("JASPER_PLUGIN :: PELIGRO :: El parámetro ETIQUETACOLUMNA no es el automático");
                            		}


                                var stdin:String; //Cadena que se envia a la librería
                                var ficheroTemporal;

                        if (this.iface.procesoInicializado)
                             if (!this.iface.procesoJP.running)
                          		this.iface.reportAnterior ="";


                          if(nombreInforme == "version")
                          {
                          ficheroTemporal = "version";
                          this.iface.reportAnterior ="";
                          }
                          			    else ficheroTemporal = this.iface.tratarReport(nombreInforme, nombreReport);
				    if (!ficheroTemporal)
							{
							debug("JASPER_PLUGIN :: ERROR :: El report " + nombreReport + " no es una plantilla válida.");
							this.iface.reportAnterior="";
							return;
							}
                                    debug("JASPER_PLUGIN :: Usando fichero temporal " + ficheroTemporal);
                                    stdin = ficheroTemporal + "\n";
                                    stdin += this.iface.guardaTemporal + "\n"; //Valor guardaTemporal para borrar o no temporales


                                    if (pdf) stdin += "true\n";
                                    	else
                                 	     stdin += "false\n";


                             	    if (numCopias) stdin += numCopias + "\n";
                                 	 else
                                 	     stdin += "1\n";


                             	    if (impresora) stdin += impresora+"\n";
                                 	else
                                	      stdin += "false\n";


                                    if (impDirecta) stdin += "true\n";
                                    	else
                                 	     stdin += "false\n";


                                    stdin+= cantidadParametrosJasper + "\n";
                                    stdin += parametrosJasper;






                             //Seteamos directorio del report a usar.
                             var rutaTrabajo:String;
                             if (nombreReport =="version") rutaTrabajo = this.iface.rutaReports //Si marco el reporte "version" seteo el path principal de reports, pues reporte version no existe.
                             		else rutaTrabajo = this.iface.rutaReports + this.iface.dbName + this.iface.barra + "reports" + this.iface.barra + nombreInforme+ this.iface.barra;

                             debug("JASPER_PLUGIN :: Ruta de trabajo con fichero temporal = " + rutaTrabajo);
                             debug ("JASPER_PLUGIN :: GuardaTemporal " + this.iface.guardaTemporal);

                             //Si la libreria no se ha ejecutado antes

                             if (!this.iface.procesoInicializado)
                                        {
                                      debug("JASPER_PLUGIN :: Inicializando la librería ");
                                         var rutaPlugin= util.readSettingEntry("jasperplugin/pluginpath");
                                         if (rutaPlugin == "")
                                                                 {
                                                                  MessageBox.critical("JASPER_PLUGIN ERROR \n No se ha especificado el path de JasperPlugin", MessageBox.Ok);
                                                                  break;
                                                                 }
                                       this.iface.generarComando(rutaPlugin);
                                       debug("JASPER_PLUGIN :: Ruta de trabajo actual ("+rutaTrabajo+")");
                                       this.iface.rutaTrabajoVieja = rutaTrabajo;
                                       this.iface.procesoInicializado = true;


                                           }
                             //Miramos si el cambio de directorio está activo
                            var detectRT = this.iface.detectarRutaTrabajo;
                            if (detectRT == "true")
                                                {
                                                debug("JASPER_PLUGIN :: Detectar RT activado");
                                                if (rutaTrabajo != this.iface.rutaTrabajoVieja)
                                                                            {
                                                                            this.iface.procesoJP.kill(); //Si cambiamos de carpeta de trabajo , paramos el proceso.
                                                                           debug ("JASPER_PLUGIN :: ( KILL/START ) CAMBIO DE RUTA. La ruta no era la misma");
                                                                           this.iface.rutaTrabajoVieja = rutaTrabajo;
                                                                           this.iface.procesoJP.workingDirectory = rutaTrabajo;
                                                                           debug ("JASPER_PLUGIN :: Ruta cambiada.");
                                                                            this.iface.procesoJP.start();
                                                                            }
                                               }

                                         if (!this.iface.procesoJP.running)
                                                                     {
                                                                    debug ("JASPER_PLUGIN :: START");
                                                                    this.iface.procesoJP.workingDirectory = rutaTrabajo;
                                                                     this.iface.procesoJP.start();

                                                                     }

                                        this.iface.procesoJP.writeToStdin(stdin);
                                      	debug("JASPER_PLUGIN :: Enviando por stdin : \n\n" + stdin);






                                     }
                              else
                                {
                            var rptViewer:FLReportViewer = new FLReportViewer();
                            rptViewer.setReportTemplate(nombreReport);
                            rptViewer.setReportData(q);
                            rptViewer.renderReport(etiquetaInicial.fila, etiquetaInicial.col);
                            if (numCopias)
                                    rptViewer.setNumCopies(numCopias);
                            if (impresora) {
                                    try {
                                            rptViewer.setPrinterName(impresora);
                                    }
                                    catch (e) {}
                            }
                            if (impDirecta) {
                                    rptViewer.printReport();
                            } else if (pdf) {
                                    //Si pdf es true, en el parámetro impresora está la ruta completa del fichero pdf
                                    rptViewer.printReportToPDF(impresora);
                            } else {
                                    this.iface.mostrarInformeVisor(rptViewer);
                            }
                      }
                    }
            }
    }

/** Agrega parametros directamente al whereFijo
\end */
function jasperPlugin_whereFijoExtendido(nombreInforme:String)
{
    // debug("jasperPlugin_whereFijoExtendido -> " + this.iface.whereFijoExt);
    return;
}

/** Comprueba si existe un jrxml en la carpeta compartida
@return true = Existe , false = No existe
\end */
function jasperPlugin_comprobarJasperFisico(reportName:String):Boolean
  {
    debug ("JASPER_PLUGIN :: buscando " + reportName);
    if (File.exists(reportName)) return true;
     else
     return false;

   }


/** Especifica que barras usa el S.O. al poner una ruta
@return / , linux, mac y  \\ windows
\end */
function jasperPlugin_seteaBarra():String
 {
    var retorno:String;
    var util:FLUtil = new FLUtil;
    var plataforma = util.getOS();
    if (plataforma == "WIN32")
        retorno = "\\";
    else
        retorno = "/";
    return retorno;

}

/** Genera ficheroTemporal en carpeta Temp.
@return Nombre del fichero temporal
\end */
function jasperPlugin_tratarReport(nombreInforme:String, nombreReport:String):String
{
    var date = new Date();
    var xmlFinal:String;
    var util:FLUtil = new FLUtil;
    var compilarSiempre:Boolean = false;
    compilarSiempre = util.readSettingEntry("jasperplugin/compilarSiempre");

    //Aqui introducimos el where y las rutas de los objetos..
    var rutaFicheroOriginal = this.iface.rutaReports + this.iface.dbName + this.iface.barra + "reports" + this.iface.barra + nombreInforme + this.iface.barra + nombreReport + ".jrxml"

    if (compilarSiempre == "false")
    	{
    	if (this.iface.reportAnterior == rutaFicheroOriginal)
    		{
    		debug("JASPER_PLUGIN :: Este report no será compilado");
    		return "Repetir";
    		}
    		else
    		{
    		debug("JASPER_PLUGIN :: Este report será compilado");
    		this.iface.reportAnterior = rutaFicheroOriginal;
    		}
    	} else debug("JASPER_PLUGIN :: COMPILAR SIEMPRE :: Activado");

    var ficheroO = new File(rutaFicheroOriginal);
        ficheroO.open(File.ReadOnly);
    var f = ficheroO.read();
    ficheroO.close();

    var consultaSQL:String;
    var nodeJasperReports;
    var xmlReport = new FLDomDocument();
if (sys.osName() == "WIN32")
  f = sys.toUnicode(f, "latin1");
    if (xmlReport.setContent(f)) {
	        if (xmlReport.namedItem("jasperReport"))
	                    {
	                     xmlFinal = xmlReport.toString(2);
			     //Tratamos codificación
				var codificacion = util.readSettingEntry("jasperplugin/codificacion");
				if (!codificacion) codificacion = 0;
				if ( codificacion == 1 ) xmlFinal = xmlFinal.replace("ISO-8859-1","UTF-8");
				if ( codificacion == 2 ) xmlFinal = xmlFinal.replace("UTF-8","ISO-8859-1");
	                     //xmlFinal =  xmlFinal.replace("groovy","java");
                             if (sys.osName() != "WIN32") //Convertimos el fichero a UTF8 si no es win32
     	                     xmlFinal = sys.toUnicode(xmlFinal, "utf8");
     	                     //Creamos el nombre del fichero...
                             var directorio = this.iface.rutaReports + this.iface.dbName + this.iface.barra + "temp_files" ;	
			     var ficheroTemporal = directorio + this.iface.barra + nombreReport + date.getYear().toString() + "_"
                       + date.getMonth().toString() + "_" + date.getDay().toString() + "_" + date.getHours().toString() + "_" + date.getMinutes().toString() + date.getSeconds().toString()+ date.getMilliseconds().toString() + ".jrxml";
                       
                       
                       //Comprobamos si temp_files existe
			     var dir = new Dir();
			     if (!dir.fileExists(directorio)) 
				dir.mkdir(directorio);	
				
			
                        //guardamos el fichero
                        try {
                            var ficheroD = new File(ficheroTemporal);
                            ficheroD.open(File.WriteOnly);
                            ficheroD.write(xmlFinal);
                            ficheroD.close();
                        } catch (e) {
                          AQUtil.destroyProgressDialog();
                          debug(e);
                          MessageBox.critical("" + e, MessageBox.Ok);
                          return;
                                    }
                 return ficheroTemporal;
                }   else  debug("JASPER_PLUGIN :: ERROR :: No se encuentra la etiqueta jasperReport");
        } else debug("JASPER_PLUGIN :: ERROR :: No se puede leer el contenido de la plantilla " + rutaFicheroOriginal);
}


function jasperPlugin_generarComando(rutaJP:String):Boolean
{
     var util:FLUtil = new FLUtil();
    var comando:String;
    var db_ = aqApp.db();

    var driver = db_.driverName();
    var driverJava:String;
    var jdbc:String;
    if (driver.startsWith("FLQPSQL"))
    {
    driverJava = "org.postgresql.Driver";
    jdbc = "jdbc:postgresql://" + db_.host() + ":" + db_.port() + "/" + db_.database();

    }else
    {
        driverJava = "com.mysql.jdbc.Driver";
        jdbc = "jdbc:mysql://"+ db_.host() + ":" + db_.port() + "/" + db_.database();
    }
    rutaJP = rutaJP + "enebooreports.jar";

    var maxJVM:String = util.readSettingEntry("jasperplugin/MaxJVM");
    if (maxJVM != "")
    		{
    		maxJVM = "-Xmx" + maxJVM + "m";
    		this.iface.procesoJP = new Process("java",maxJVM,"-jar",rutaJP,driverJava,jdbc,db_.user(),db_.password()) ;//Aqui ponemos java -jar la ruta al plugin , con los datos de la conexion
    		}
    		else this.iface.procesoJP = new Process("java","-jar",rutaJP,driverJava,jdbc,db_.user(),db_.password()) ;

    return true;
}


function jasperPlugin_establecerConsulta(cursor:FLSqlCursor, nombreConsulta:String, orderBy:String, groupBy:String, whereFijo:String):FLSqlQuery
{
        var util:FLUtil = new FLUtil();
        var q:FLSqlQuery = new FLSqlQuery(nombreConsulta);
        var fieldList:String = util.nombreCampos(cursor.table());
        var cuenta:Number = parseFloat(fieldList[0]);

        var signo:String;
        var fN:String;
        var valor:String;
        var primerCriterio:Boolean = false;
        var where:String = "";
        var criterio:String;
        for (var i:Number = 1; i <= cuenta; i++) {
                if (cursor.isNull(fieldList[i])) {
                        continue;
                }
                signo = this.iface.obtenerSigno(fieldList[i]);
                if (signo != "") {
                        fN = this.iface.fieldName(fieldList[i]);
                        valor = cursor.valueBuffer(fieldList[i]);
                        criterio = this.iface.aplicarCriterio(cursor.table(), fN, valor, signo);
                        if (criterio && criterio != "") {
                                if (primerCriterio == true) {
                                        where += " AND ";
                                }
                                where += criterio;
                                primerCriterio = true;
                        }
                }
        }

        if (whereFijo && whereFijo != "") {
                if (where == "")
                        where = whereFijo;
                else
                        where = whereFijo + " AND (" + where + ")";
        }

        this.iface.whereCursor = where; //Recogemos el where limpio (wherefijo + where de cursor);

        var ampliarWhere:String = this.iface.ampliarWhere(nombreConsulta);
        if (ampliarWhere)
                if (where)
                        where += " AND " + ampliarWhere;
                else
                        where += ampliarWhere;

        if (groupBy && groupBy != "") {
                if (where == "")
                        where = "1 = 1";
                where += " GROUP BY " + groupBy;
        }
        //Si no existe el .qry no continua procesandose la consulta
	if (!util.sqlSelect("flfiles", "nombre", "nombre = '" + nombreConsulta + ".qry'"))
		return q;

        q.setWhere(where);

        if (orderBy)
                q.setOrderBy(orderBy);

        return q;
}
//// JASPER_PLUGIN ///////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

