/***************************************************************************
                 pr_mastersmtipostareapro.qs  -  description
                             -------------------
    begin                : jue may 29 2008
    copyright            : (C) 2008 by InfoSiAL S.L.
    email                : mail@infosial.com
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

/** @file */

/** @class_declaration interna */
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna {
    var ctx:Object;
    function interna( context ) { this.ctx = context; }
	function init() {
		return this.ctx.interna_init();
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var xmlNodoBuffer_:FLDomNode;
	var tdbRecords:FLTableDB;
	var pbnOk:Object;
	var tbnTiempos:Object;
	var tbnOpcionales:Object;
	var whereOpcionesTareas:String;
    function oficial( context ) { interna( context ); } 
	function pbnOk_clicked() {
		return this.ctx.oficial_pbnOk_clicked();
	}
	function tbnTiempos_clicked() {
		return this.ctx.oficial_tbnTiempos_clicked();
	}
	function tbnOpcionales_clicked() {
		return this.ctx.oficial_tbnOpcionales_clicked();
	}
	function obtenerTiempoTarea(eTarea:FLDomElement):Number {
		return this.ctx.oficial_obtenerTiempoTarea(eTarea);
	}
	function activarConsumosTarea(idTipoTareaPro:String, idProceso:String, activar:Boolean) {
		return this.ctx.oficial_activarConsumosTarea(idTipoTareaPro, idProceso, activar);
	}
	function guardarTareasOpcionales() {
		return this.ctx.oficial_guardarTareasOpcionales();
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial {
    function head( context ) { oficial ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
}

const iface = new ifaceCtx( this );
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
function interna_init()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	this.iface.tdbRecords = this.child("tableDBRecords");
	this.iface.pbnOk = this.child("pbnOk");
	this.iface.tbnTiempos = this.child("tbnTiempos");
	this.iface.tbnOpcionales = this.child("tbnOpcionales");
	this.iface.whereOpcionesTareas = "";
	this.iface.tbnTiempos.close();
	this.iface.tbnOpcionales.close();
	this.iface.xmlNodoBuffer_ = flcolaproc.iface.xmlNodoBuffer_;
	if (this.iface.xmlNodoBuffer_) {
		var eNodo:FLDomElement = this.iface.xmlNodoBuffer_.toElement();
		var idTipoProceso:String = eNodo.attribute("IdTipoProceso");
		switch (this.iface.xmlNodoBuffer_.nodeName()) {
			case "Proceso": {
				this.child("lblTitulo").text = util.translate("scripts", "Seleccione tareas opcionales a incluir");

				var codLote:String = eNodo.attribute("IdObjeto");
				var whereOpciones:String = "";
				var xmlLote:FLDomNode;
				var xmlDocLote:FLDomDocument = new FLDomDocument;
				if(codLote) {
					var parametrosXML:String = util.sqlSelect("lotesstock", "xmlparametros", "codlote = '" + codLote + "'");
					if (parametrosXML && parametrosXML != "") {
						if (!xmlDocLote.setContent(parametrosXML)) {
							MessageBox.warning(util.translate("scripts", "Error al cargar los parámetros XML correspondientes al lote %1").arg(codLote), MessageBox.Ok, MessageBox.NoButton);
							return false;
						}
						xmlLote = xmlDocLote.firstChild();
						var eLote:FLDomElement = xmlLote.toElement();
						var opciones:FLDomElement = eLote.namedItem("Opciones").toElement();
						var opcion:FLDomElement;
						
						for (var nodoOpcion:FLDomNode = opciones.firstChild(); nodoOpcion; nodoOpcion = nodoOpcion.nextSibling()) {
							opcion = nodoOpcion.toElement();
							if(whereOpciones != "")
								whereOpciones += ",";
							whereOpciones += opcion.attribute("IdTipoOpcion");
							if(this.iface.whereOpcionesTareas != "")
								this.iface.whereOpcionesTareas += " OR ";
							this.iface.whereOpcionesTareas += "(idtipoopcion = '" + opcion.attribute("IdTipoOpcion") + "' AND valoresopcion  like '%|" + opcion.attribute("IdValorOpcion") + "|%')";
						}
					
						if(whereOpciones != "")
							whereOpciones = " AND (idtipoopcion IS NULL OR idtipoopcion NOT IN (" + whereOpciones + "))";
					}
				}

				cursor.setMainFilter("idtipoproceso = '" + idTipoProceso + "' AND opcional = true" + whereOpciones);
				this.iface.tdbRecords.refresh();
				var xmlTareas:FLDomNodeList = this.iface.xmlNodoBuffer_.toElement().elementsByTagName("Tarea");
				var eTarea:FLDomElement;
				if (!xmlTareas) {
					return;
				}
// 				this.iface.tdbRecords.setCheckColumnEnabled(true);
				var idTipoTareaPro:String;
				for (var i:Number = 0; i < xmlTareas.length(); i++) {
					eTarea = xmlTareas.item(i).toElement();
					if (eTarea.attribute("Saltada") != "true") {
					idTipoTareaPro = eTarea.attribute("IdTipoTareaPro");
						//this.iface.tdbRecords.setPrimaryKeyChecked(idTipoTareaPro, false);
					} else {
						//this.iface.tdbRecords.setPrimaryKeyChecked(idTipoTareaPro, true);
					}
				}
				break;
			}
			default: {
				this.child("lblTitulo").text = util.translate("scripts", "Error. No se ha establecido la acción a realizar.");
				cursor.setMainFilter("1 = 2");
				return;
			}
		}
		this.iface.tdbRecords.refresh();
	}
	this.iface.tdbRecords.setCheckColumnEnabled(true);
	connect (this.iface.pbnOk, "clicked()", this, "iface.pbnOk_clicked");
	connect (this.iface.tbnTiempos, "clicked()", this, "iface.tbnTiempos_clicked");
	connect (this.iface.tbnOpcionales, "clicked()", this, "iface.tbnOpcionales_clicked");

	this.child("pushButtonAccept").setEnabled(false);

	//this.iface.tbnOpcionales_clicked();
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_pbnOk_clicked()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	if (!this.iface.guardarTareasOpcionales()) {
		MessageBox.warning(util.translate("scripts", "Ha habido un error al guardar las tareas opcionales"), MessageBox.Ok, MessageBox.NoButton);
		this.child("pushButtonCancel").animateClick();
	}

	cursor.setMainFilter("1 = 1");
	this.iface.tdbRecords.refresh();
				
var d:FLDomDocument = new FLDomDocument;
d.appendChild(this.iface.xmlNodoBuffer_.cloneNode());
	this.child("pushButtonAccept").setEnabled(true);
	this.child("pushButtonAccept").animateClick();
}

function oficial_tbnTiempos_clicked()
{
	var cursor:FLSqlCursor = this.cursor();
	var idTipoTareaPro:String = cursor.valueBuffer("idtipotareapro");
	if (!idTipoTareaPro) {
		return false;
	}
	var xmlTarea:FLDomNode = flprodppal.iface.pub_dameNodoXML(this.iface.xmlNodoBuffer_, "Tareas/Tarea[@IdTipoTareaPro=" + idTipoTareaPro + "]");
	if (!xmlTarea) {
		MessageBox.warning(util.translate("scripts", "Error al obtener la tarea tipo %1 del nodo XML").arg(idTipoTareaPro), MessageBox.Ok, MessageBox.NoButton);
		return;
	}
	var eTarea:FLDomElement = xmlTarea.toElement();
	var tiempo:Number = this.iface.obtenerTiempoTarea(eTarea);
	if (tiempo == -2) {
		return;
	}
	var costeTiempo:String;
	if (tiempo == -1) {
		costeTiempo = "";
	} else {
		costeTiempo = tiempo;
	}
	eTarea.setAttribute("CosteTiempo", costeTiempo);
}

/** \D Obtiene del usuario un timpo fijo para la tarea indicada
@param eTarea: Elemento XML de la tarea
@return	Tiempo en las unidades del sistema de producción. Otros valores:
* -1: No establecer un tienpo fijo
* -2: Error
\end */
function oficial_obtenerTiempoTarea(eTarea:FLDomElement):Number
{
	var util:FLUtil = new FLUtil;
	var dialog = new Dialog;
	dialog.caption = util.translate("scripts", "Tiempo para %1").arg(util.sqlSelect("pr_tipostareapro", "descripcion", "idtipotareapro = " + eTarea.attribute("idTipoTareaPro")));
	dialog.okButtonText = util.translate("scripts", "Aceptar");
	dialog.cancelButtonText = util.translate("scripts", "Cancelar");

	var tiempo = new NumberEdit;
	tiempo.label = util.translate("scripts", "Tiempo: ");
	tiempo.decimals = 2;
	tiempo.minimum = 0;
	tiempo.value = eTarea.attribute("CosteTiempo")
	dialog.add( tiempo );
	
	var fijarTiempo = new CheckBox;
	fijarTiempo.checked = true;
	fijarTiempo.text = util.translate("scripts", "Fijar tiempo");
	dialog.add( fijarTiempo );

	if( !dialog.exec() ) {
		return -2;
	}

	if (!fijarTiempo.checked) {
		return -1;
	}

	return tiempo.value;
}

function oficial_tbnOpcionales_clicked()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var eNodo:FLDomElement = this.iface.xmlNodoBuffer_.toElement();
	var idTipoProceso:String = eNodo.attribute("IdTipoProceso");
	var idProceso:String = eNodo.attribute("IdProceso");
		
	if (this.iface.tbnOpcionales.on) {
		cursor.setMainFilter("idtipoproceso = '" + idTipoProceso + "' AND opcional = true");
		var xmlTareas:FLDomNodeList = this.iface.xmlNodoBuffer_.toElement().elementsByTagName("Tarea");
		var eTarea:FLDomElement;
		if (!xmlTareas) {
			return;
		}
		this.iface.tdbRecords.setCheckColumnEnabled(true);
		this.iface.tdbRecords.refresh();
		this.child("lblTitulo").text = util.translate("scripts", "Seleccione tareas opcionales a incluir");
		var idTipoTareaPro:String;
		for (var i:Number = 0; i < xmlTareas.length(); i++) {
			eTarea = xmlTareas.item(i).toElement();
			if (eTarea.attribute("Saltada") != "true") {
			idTipoTareaPro = eTarea.attribute("IdTipoTareaPro");
				//this.iface.tdbRecords.setPrimaryKeyChecked(idTipoTareaPro, false);
			} else {
				//this.iface.tdbRecords.setPrimaryKeyChecked(idTipoTareaPro, true);
			}
		}
	} else {
		if (!this.iface.guardarTareasOpcionales()) {
			this.child("pushButtonCancel").animateClick();
		}
		this.iface.tdbRecords.setCheckColumnEnabled(false);
		cursor.setMainFilter("idtipoproceso = '" + idTipoProceso + "'");
		this.iface.tdbRecords.refresh();
	}
}

function oficial_guardarTareasOpcionales()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var eNodo:FLDomElement = this.iface.xmlNodoBuffer_.toElement();
	var idTipoProceso:String = eNodo.attribute("IdTipoProceso");
	var idProceso:String = eNodo.attribute("IdProceso");
	
	var arrayTareas:Array = this.iface.tdbRecords.primarysKeysChecked();
	if (arrayTareas) {
		var xmlTareas:FLDomNodeList = this.iface.xmlNodoBuffer_.toElement().elementsByTagName("Tarea");
		var eTarea:FLDomElement;
		var k:Number;
		if (xmlTareas) {
			for (var i:Number = 0; i < xmlTareas.length(); i++) {
				eTarea = xmlTareas.item(i).toElement();
				idTipoTareaPro = eTarea.attribute("IdTipoTareaPro");

				if (!util.sqlSelect("pr_tipostareapro", "opcional", "idtipotareapro = " + idTipoTareaPro))
					continue;
				
				if(this.iface.whereOpcionesTareas != "") {
					if (util.sqlSelect("pr_tipostareapro", "idtipotareapro", "idtipotareapro = " + idTipoTareaPro + " AND opcional = true AND (" + this.iface.whereOpcionesTareas + ")"))
						continue;
				}
				
				
				for (k = 0; k < arrayTareas.length; k++) {
					if (arrayTareas[k] == idTipoTareaPro) {
						break;
					}
				}
				if (k == arrayTareas.length) {
					eTarea.setAttribute("Estado", "Saltada");
					if (!this.iface.activarConsumosTarea(idTipoTareaPro, idProceso, false)) {
						this.child("pushButtonCancel").animateClick();
					}
				} else {
					eTarea.setAttribute("Estado", "");
					if (!this.iface.activarConsumosTarea(idTipoTareaPro, idProceso, true)) {
						this.child("bushButtonCancel").animateClick();
					}
				}
			}
		}
	}
	return true;
}
/** \D Marca como PTE o CANCEL los movimientos de stock asociados a una tarea opcional que se activa o desactiva
@param	idTipoTareaPro: Tipo de tarea por tipo de proceso
@param	idProceso: Proceso
@param	activar: Indica si se activan o se desactivan los movimientos
\end */
function oficial_activarConsumosTarea(idTipoTareaPro:String, idProceso:String, activar:Boolean)
{
	var util:FLUtil = new FLUtil;
	if (activar) {
		if (!util.sqlUpdate("movistock", "estado", "PTE", "idproceso = " + idProceso + " AND idtipotareapro = " + idTipoTareaPro + " AND estado = 'CANCEL'")) {
			MessageBox.warning(util.translate("scripts", "Error al activar los consumos asociados a la tarea:\n%1").arg(util.sqlSelect("pr_tipostareapro", "descripcion", "idtipotareapro = " + idTipoTareaPro)), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
	} else {
		if (!util.sqlUpdate("movistock", "estado", "CANCEL", "idproceso = " + idProceso + " AND idtipotareapro = " + idTipoTareaPro + " AND estado = 'PTE'")) {
			MessageBox.warning(util.translate("scripts", "Error al desactivar los consumos asociados a la tarea:\n%1").arg(util.sqlSelect("pr_tipostareapro", "descripcion", "idtipotareapro = " + idTipoTareaPro)), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
	}
	return true;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
