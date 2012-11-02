
/** @class_declaration prod */
//////////////////////////////////////////////////////////////////
//// PRODUCCION //////////////////////////////////////////////////
class prod extends oficial {
	var tbnParametros:Object;
	var tbnInsert:Object;
	var tbnDelete:Object;
	var xmlProceso:FLDomDocument;
	function prod( context ) { oficial( context ); }
	function init() {
		return this.ctx.prod_init();
	}
	function tbnParametros_clicked() {
		return this.ctx.prod_tbnParametros_clicked();
	}
	function mostrarParametros() {
		return this.ctx.prod_mostrarParametros();
	}
	function datosProcesoFabricacion(xmlParametros:FLDomNode):String {
		return this.ctx.prod_datosProcesoFabricacion(xmlParametros);
	}
	function anadirTarea_clicked() {
		this.ctx.prod_anadirTarea_clicked();
	}
	function quitarTarea_clicked() {
		this.ctx.prod_quitarTarea_clicked();
	}
	function anadirTarea():Boolean {
		return this.ctx.prod_anadirTarea();
	}
	function datosTarea(curTarea:FLSqlCursor, idProceso:Number, estadoTarea:String, idTipoTareaPro:Number):Boolean {
		return this.ctx.prod_datosTarea(curTarea, idProceso, estadoTarea, idTipoTareaPro);
	}
	function quitarTarea():Boolean {
		return this.ctx.prod_quitarTarea();
	}
}
//// PRODUCCION //////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition prod */
//////////////////////////////////////////////////////////////////
//// PRODUCCION //////////////////////////////////////////////////
function prod_init()
{
	this.iface.__init()

	var util:FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	this.iface.tbnParametros = this.child("tbnParametros");
	this.iface.tbnInsert = this.child("tbnInsert");
	this.iface.tbnDelete = this.child("tbnDelete");

	connect(this.iface.tbnInsert, "clicked()", this, "iface.anadirTarea_clicked()");
	connect(this.iface.tbnDelete, "clicked()", this, "iface.quitarTarea_clicked()");
	connect (this.iface.tbnParametros, "clicked()", this, "iface.tbnParametros_clicked()");

	this.child("tdbTareas").setEditOnly(true);

	var nodoProceso:FLDomNode = flcolaproc.iface.pub_dameXMLProceso(this.cursor().valueBuffer("idproceso"));
	if (!nodoProceso) {
		MessageBox.warning(util.translate("scripts", "Error al obtener los datos del proceso.\nPuede que los botones de añadir y quitar tareas no funcionen correctamente."), MessageBox.Ok, MessageBox.NoButton);
	}

	this.iface.xmlProceso = new FLDomDocument;
	this.iface.xmlProceso.appendChild(nodoProceso.cloneNode());
// 	if(!this.iface.xmlProceso)
// 		return false;

	switch (cursor.modeAccess()) {
		case cursor.Insert: {
			break;
		}
		case cursor.Edit: {
			this.iface.mostrarParametros();
			break;
		}
		case cursor.Browse: {
			this.iface.mostrarParametros();
			this.iface.tbnParametros.enabled = false;
			break;
		}
	}
}

function prod_tbnParametros_clicked()
{
	var util:FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var contenido:String = cursor.valueBuffer("xmlparametros");
	if (!contenido || contenido == "") {
		this.child("lblParametros").text = util.translate("scripts", "No hay parámetros");
		return;
	}
	var docParametros:FLDomDocument = new FLDomDocument();
	if (!docParametros.setContent(contenido)) {
		MessageBox.warning(util.translate("scripts", "Error al cargar el documento XML de parámetros del lote"), MessageBox.Ok, MessageBox.NoButton);
		return;
	}
	var xmlProceso:FLDomNode = docParametros.firstChild();
	if (flcolaproc.iface.crearXMLTareasOpcionales(cursor, xmlProceso)) {
		cursor.setValueBuffer("xmlparametros", docParametros.toString(4));
		this.iface.mostrarParametros();
	}
}

function prod_mostrarParametros()
{
	var util:FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var textoParam:String = "";

	var idLineaPedidoCli:String = cursor.valueBuffer("idlineapedidocli");
	var codPedido:String = util.sqlSelect("lineaspedidoscli lp INNER JOIN pedidoscli p ON lp.idpedido = p.idpedido", "p.codigo", "lp.idlinea = " + idLineaPedidoCli, "lineaspedidoscli,pedidoscli");
	textoParam += util.translate("scripts", "Pedido de cliente %1").arg(codPedido);
	textoParam += "\n";

	var contenido:String = cursor.valueBuffer("xmlparametros");
	if (!contenido || contenido == "") {
		textoParam += util.translate("scripts", "No hay parámetros");
		this.child("lblParametros").text = textoParam;
		return;
	}
	var docParametros:FLDomDocument = new FLDomDocument();
	if (!docParametros.setContent(contenido)) {
		MessageBox.warning(util.translate("scripts", "Error al cargar el documento XML de parámetros del proceso"), MessageBox.Ok, MessageBox.NoButton);
		return;
	}
	var xmlProceso:FLDomNode = docParametros.firstChild();
	var datosProcesoFab:String = this.iface.datosProcesoFabricacion(xmlProceso);

	if (datosProcesoFab && datosProcesoFab != "") {
		textoParam += datosProcesoFab;
	}
	this.child("lblParametros").text = textoParam;
}

function prod_datosProcesoFabricacion(xmlProceso:FLDomNode):String
{
	var util:FLUtil;
	var contenido:String = "";
	var eProceso:FLDomElement = xmlProceso.toElement();

	contenido += util.translate("scripts", "Proceso de producción: %1\n").arg(eProceso.attribute("IdTipoProceso"));
	var xmlTareas:FLDomNodeList = eProceso.elementsByTagName("Tarea");
	if (!xmlTareas) {
		return false;
	}
	var eTarea:FLDomElement;
	for (var i:Number = 0; i < xmlTareas.length(); i++) {
		eTarea = xmlTareas.item(i).toElement();
		if (eTarea.attribute("Estado") == "Saltada") {
			contenido += util.translate("scripts", "\tTarea saltada: %1\n").arg(eTarea.attribute("Descripcion"));
		}
	}
	return contenido;
}

function prod_anadirTarea_clicked()
{
	var util:FLUtil;
	var cursor:FLSqlCursor = new FLSqlCursor("empresa");
	cursor.transaction(false);

	try {
		if (this.iface.anadirTarea()) {
			cursor.commit();
		}
		else {
			cursor.rollback();
			return;
		}
	} catch(e) {
		cursor.rollback();
		MessageBox.critical(util.translate("scripts", "Hubo un error al intentar añadir la tarea:\n") + e, MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	this.child("tdbTareas").refresh();
}

function prod_quitarTarea_clicked()
{
	var util:FLUtil;
	var cursor:FLSqlCursor = new FLSqlCursor("empresa");
	cursor.transaction(false);

	try {
		if (this.iface.quitarTarea()) {
			cursor.commit();
		}
		else {
			cursor.rollback();
			return;
		}
	} catch(e) {
		cursor.rollback();
		MessageBox.critical(util.translate("scripts", "Hubo un error al intentar quitar la tarea:\n") + e, MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	this.child("tdbTareas").refresh();
}

function prod_anadirTarea():Boolean
{
	var util:FLUtil;

	var idProceso:Number = this.cursor().valueBuffer("idproceso");
	var idTipoProceso:Number = this.cursor().valueBuffer("idtipoproceso");
	f = new FLFormSearchDB("pr_tipostareapro");
	curTiposTareaPro = f.cursor();
	if (!util.sqlSelect("pr_tipostareapro","idtipotareapro","tareainicial AND tareafinal AND idtipotareapro NOT IN (select tareainicio FROM pr_secuencias) AND idtipotareapro NOT IN (SELECT tareafin FROM pr_secuencias) AND idtipotareapro NOT IN (SELECT idtipotareapro from pr_tareas WHERE idproceso = " + idProceso + ") AND idtipoproceso = '" + idTipoProceso + "'")) {
		MessageBox.warning(util.translate("scripts", "No hay ninguna tarea para este tipo de proceso que sea tarea inicial y final que no pertenezca a ninguna secuencia y que no esté asociada ya al proceso."), MessageBox.Ok, MessageBox.NoButton);
		return true;
	}

// 	curTiposTareaPro.setModeAccess(curTiposTareaPro.Edit);
// 	curTiposTareaPro.refreshBuffer();

	f.setMainWidget();
	f.cursor().setMainFilter("tareainicial AND tareafinal AND idtipotareapro NOT IN (select tareainicio FROM pr_secuencias) AND idtipotareapro NOT IN (SELECT tareafin FROM pr_secuencias) AND idtipotareapro NOT IN (SELECT idtipotareapro from pr_tareas WHERE idproceso = " + idProceso + ") AND idtipoproceso = '" + idTipoProceso + "'");

	var idTipoTareaPro:Number = f.exec("idtipotareapro");
	if (idTipoTareaPro) {
		var estadoTarea:String = "PTE";
		if(this.cursor().valueBuffer("estado") == "OFF")
			estadoTarea = "OFF";

		if(!this.iface.xmlProceso)
			return false;
		var xmlTarea:FLDomNode = flprodppal.iface.pub_dameNodoXML(this.iface.xmlProceso.firstChild(), "Tareas/Tarea[@IdTipoTareaPro=" + idTipoTareaPro + "]");
		if(!xmlTarea) {
			var xmlDocAux:FLDomDocument = new FLDomDocument;
			var xmlTareas:FLDomNode = flprodppal.iface.pub_dameNodoXML(this.iface.xmlProceso.firstChild(), "Tareas");
			var eTarea:FLDomElement = xmlDocAux.createElement("Tarea");
			eTarea.setAttribute("IdTipoTareaPro", idTipoTareaPro);
			eTarea.setAttribute("Descripcion", util.sqlSelect("pr_tipostareapro","descripcion","idtipotareapro = " + idTipoTareaPro));
			eTarea.setAttribute("Estado", "");
			xmlTareas.appendChild(eTarea.cloneNode());
		}
		else {
			var eTarea:FLDomElement = xmlTarea.toElement();
			eTarea.setAttribute("Estado", "");
		}

// 		var xmlDoc:FLDomDocument = new FLDomDocument;
// 		xmlDoc.appendChild(this.iface.xmlProceso);
// 		this.cursor().setValueBuffer("xmlparametros",xmlDoc.toString(4));
		this.cursor().setValueBuffer("xmlparametros", this.iface.xmlProceso.toString(4));

		var curTarea:FLSqlCursor = new FLSqlCursor("pr_tareas");
		curTarea.setModeAccess(curTarea.Insert);
		curTarea.refreshBuffer();

		if(!this.iface.datosTarea(curTarea, idProceso, estadoTarea, idTipoTareaPro))
			return false;

		if (!curTarea.commitBuffer())
			return false;

		var codLote:String = this.cursor().valueBuffer("idobjeto");
		var curLoteStock:FLSqlCursor = new FLSqlCursor("lotesstock");
		curLoteStock.select("codlote = '" + codLote + "'");
		if(!curLoteStock.first())
			return false;

		curLoteStock.setModeAccess(curLoteStock.Edit);
		curLoteStock.refreshBuffer();

		var refLote:String = curLoteStock.valueBuffer("referencia");
		var curComponentes:FLSqlQuery = new FLSqlCursor("articuloscomp");
		curComponentes.select("refcompuesto = '" + refLote + "'" + " AND idtipotareapro = " + idTipoTareaPro);

		var datosRev:Array = [];
		var nuevaCantidad:Number = 0;
		var cantidad:Number = parseFloat(curLoteStock.valueBuffer("canlote"));
		if(!cantidad)
			cantidad = 1

		while (curComponentes.next()) {
			curComponentes.setModeAccess(curComponentes.Edit);
			curComponentes.refreshBuffer();
			datosRev = flfactalma.iface.pub_revisarComponente(curComponentes);
			if (!datosRev)
				return false;

			if (parseFloat(datosRev["cantidad"]) == 0)
				continue;

			curComponentes.setValueBuffer("refcomponente",datosRev["referencia"]);
			nuevaCantidad = cantidad * parseFloat(datosRev["cantidad"]);
			tipoStock = util.sqlSelect("articulos", "tipostock", "referencia = '" + curComponentes.valueBuffer("refcomponente") + "'");

			switch (tipoStock) {
				case "Lotes": {
					if (!flfactalma.iface.pub_generarLoteStock(curLoteStock, nuevaCantidad, curComponentes, idProceso))
						return false;
					break;
				}
				case "Grupo base": {
					if (!flfactalma.iface.pub_crearComposicion(curLoteStock, curComponentes, refLote, idProceso))
						return false;
					break;
				}
				default: {
					if (util.sqlSelect("articuloscomp","refcompuesto","refcompuesto = '" + datosRev["referencia"] + "'")) {
						if (!flfactalma.iface.pub_crearComposicion(curLoteStock, curComponentes, refLote, idProceso))
							return false;
					} else {
						if (!flfactalma.iface.pub_generarMoviStock(curLoteStock, false, nuevaCantidad, curComponentes, idProceso))
							return false;
					}
					break;
				}
			}
		}
	}
	f.close();
	return true;
}

function prod_datosTarea(curTarea:FLSqlCursor, idProceso:Number, estadoTarea:String, idTipoTareaPro:Number):Boolean
{
	var util:FLUtil;
	var codLote:String = this.cursor().valueBuffer("idobjeto");
	var hoy:Date = new Date();

	curTarea.setValueBuffer("idtarea", flcolaproc.iface.pub_calcularIdTarea());
	curTarea.setValueBuffer("idproceso", idProceso);
	curTarea.setValueBuffer("estado", estadoTarea);
	curTarea.setValueBuffer("idtipotarea", util.sqlSelect("pr_tipostareapro","idtipotarea","idtipotareapro = '" + idTipoTareaPro + "'"));
	curTarea.setValueBuffer("idtipotareapro", idTipoTareaPro);
	curTarea.setValueBuffer("tipoobjeto", "lotesstock");
	curTarea.setValueBuffer("idobjeto", codLote);
	curTarea.setValueBuffer("descripcion", flcolaproc.iface.pub_descripcionTarea(curTarea));
	curTarea.setValueBuffer("numciclo", 1);
	curTarea.setValueBuffer("fechainicioprev", hoy);
	if(estadoTarea == "PTE")
		curTarea.setValueBuffer("anexo", true);

	return true;
}

function prod_quitarTarea():Boolean
{
	var util:FLUtil;

	var idTarea:String = this.child("tdbTareas").cursor().valueBuffer("idtarea");
	if(!idTarea || idTarea == "") {
		MessageBox.warning(util.translate("scripts", "No hay ningún registro seleccionado"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	var res:Number = MessageBox.information(util.translate("scripts", "¿Seguro que desea eliminar la tarea %1?").arg(idTarea), MessageBox.Yes, MessageBox.No);
	if(res != MessageBox.Yes)
		return true;

	var estado:String = this.child("tdbTareas").cursor().valueBuffer("estado");
	if(estado != "OFF" && estado != "PTE") {
		MessageBox.warning(util.translate("scripts", "La tarea debe estar en estado OFF o PTE"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	var idTipoTareaPro:String = this.child("tdbTareas").cursor().valueBuffer("idtipotareapro");
	if(!idTipoTareaPro)
		return false;

	var esInicial:Boolean = util.sqlSelect("pr_tipostareapro","tareainicial","idtipotareapro = " + idTipoTareaPro);
	var esFinal:Boolean = util.sqlSelect("pr_tipostareapro","tareafinal","idtipotareapro = " + idTipoTareaPro);
	var secuencia:Boolean = util.sqlSelect("pr_secuencias","idsecuencia","tareainicio = " + idTipoTareaPro + " OR tareafin = " + idTipoTareaPro);

	if(!esInicial || !esFinal || secuencia) {
		MessageBox.warning(util.translate("scripts", "La tarea debe ser inicial y final y no pertenecer a ninguna secuencia."), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	if(!this.iface.xmlProceso)
		return false;
	var xmlTarea:FLDomNode = flprodppal.iface.pub_dameNodoXML(this.iface.xmlProceso.firstChild(), "Tareas/Tarea[@IdTipoTareaPro=" + idTipoTareaPro + "]");
	if(!xmlTarea)
		return false;

	var eTarea:FLDomElement = xmlTarea.toElement();
	eTarea.setAttribute("Estado", "Saltada");

// 	var xmlDoc:FLDomDocument = new FLDomDocument;
// 	xmlDoc.appendChild(this.iface.xmlProceso);
//
// 	this.cursor().setValueBuffer("xmlparametros",xmlDoc.toString(4));
	this.cursor().setValueBuffer("xmlparametros", this.iface.xmlProceso.toString(4));

	if(!util.sqlDelete("pr_tareas","idtarea = '" + idTarea + "'"))
		return false;

	if(!util.sqlSelect("pr_tareas","idtarea","idproceso = " + this.cursor().valueBuffer("idproceso") + " AND estado <> 'TERMINADA'")) {
		var hoy:Date = new Date();
		this.cursor().setValueBuffer("diafin",hoy);
		this.cursor().setValueBuffer("estado","TERMINADO");
	}

	return true;
}
//// PRODUCCION //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

