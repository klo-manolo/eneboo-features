/***************************************************************************
                 flmasterterminal.qs  -  description
                             -------------------
    begin                : lun abr 26 2007
    copyright            : (C) 2007 by InfoSiAL S.L.
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
/** \C
El formulario muestra la lista de las tareas existentes. 
El funcionamiento a través del lector de código de barras es el siguiente:

El trabajador lee su código personal: La ventana mostrará la lista de tareas pendientes

El trabajador lee el código de la tarea a realizar: La ventana mostrará la tarea correspondiente, realizando las acciones correspondientes a según el tipo y estado de la tarea (p.e. si la tarea es de corte y está en estado PTE, mostrará el formulario de tarea de corte para que el usuario valide los datos del corte y la tarea pueda pasar a EN CURSO)
\end */
/** @class_declaration interna */
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna {
	var ctx:Object;
	function interna( context ) { this.ctx = context; }
	function init() { this.ctx.interna_init(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var tdbTareas:FLTableDB;
	var ledTrabajador:Object;
	var ledTarea:Object;
	var lblTrabajador:Object;
	var lblEstado:Object;
	var lblEstadoTarea:Object;
	var tbnPendientes:Object;
	var tbnEnCurso:Object;
	var tbnTerminadas:Object;
	var tbnFiltroUsuario:Object;
	var tbnInicio:Object;
	var tbnDeshacer:Object;
	var ultimaTarea:String;
	var filtroOperario:String;

	var posActualPuntoTrabajador:Number;
	var posActualPuntoTarea:Number;

    function oficial( context ) { interna( context ); }
	function avanzarTarea()	{
		return this.ctx.oficial_avanzarTarea();
	}
	function lanzarTarea() {
		return this.ctx.oficial_lanzarTarea();
	}
	function filtrarPendientes() {
		return this.ctx.oficial_filtrarPendientes();
	}
	function trabajadorSet() {
		return this.ctx.oficial_trabajadorSet();
	}
	function textChangedTrabajador( text:String ) {
		return this.ctx.oficial_textChangedTrabajador( text );
	}
	function textChangedTarea( text:String )	{
		return this.ctx.oficial_textChangedTarea( text );
	}
	function mostrarDatosTarea() {
		return this.ctx.oficial_mostrarDatosTarea();
	}
	function filtroBase():String {
		return this.ctx.oficial_filtroBase();
	}
	function mostrarPendientes() {
		return this.ctx.oficial_mostrarPendientes();
	}
	function mostrarEnCurso() {
		return this.ctx.oficial_mostrarEnCurso();
	}
	function mostrarTerminadas() {
		return this.ctx.oficial_mostrarTerminadas();
	}
	function mostrarMias() {
		return this.ctx.oficial_mostrarMias();
	}
	function volverInicio() {
		return this.ctx.oficial_volverInicio();
	}
	function deshacerTarea() {
		return this.ctx.oficial_deshacerTarea();
	}
	function actualizarEtiquetas(okInicioFin:Boolean) {
		return this.ctx.oficial_actualizarEtiquetas(okInicioFin);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCION /////////////////////////////////////////////////
class prod extends oficial {
	var tbnPausarTareaS:Object;
	function prod( context ) { oficial ( context ); }
	function init() {
		return this.ctx.prod_init();
	}
	function avanzarTarea() {
		return this.ctx.prod_avanzarTarea();
	}
	function pausarTareas_clicked() {
		this.ctx.prod_pausarTareas_clicked();
	}
	function pausarTareas():Boolean {
		return this.ctx.prod_pausarTareas();
	}
}
//// PRODUCCION /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends prod {
	function head( context ) { prod ( context ); }
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

	this.child("pushButtonCancel").close();

	this.iface.tdbTareas = this.child("tdbTareasS");
	this.iface.ledTrabajador = this.child("ledTrabajador");
	this.iface.ledTarea = this.child("ledTarea");
	this.iface.lblTrabajador = this.child("lblTrabajador");
	this.iface.lblEstado = this.child("lblEstado");
	this.iface.lblEstadoTarea = this.child("lblEstadoTarea");
	this.iface.tbnPendientes = this.child("tbnPendientes");
	this.iface.tbnEnCurso = this.child("tbnEnCurso");
	this.iface.tbnTerminadas = this.child("tbnTerminadas");
	this.iface.tbnFiltroUsuario = this.child("tbnFiltroUsuario");
	this.iface.tbnInicio = this.child("tbnInicio");
	this.iface.tbnDeshacer = this.child("tbnDeshacer");

	this.iface.posActualPuntoTrabajador = -1;
	this.iface.posActualPuntoTarea = -1;
	this.iface.filtroOperario = "";

	var campos:Array = ["idtarea", "estado", "realizadapor", "descripcion"];
	this.iface.tdbTareas.setOrderCols(campos);
	//this.iface.tdbTareas.setReadOnly(true);

	connect(this.iface.ledTrabajador, "returnPressed()", this, "iface.trabajadorSet");
	connect(this.iface.ledTarea, "returnPressed()", this, "iface.lanzarTarea");
	connect(this.iface.ledTrabajador, "textChanged(QString)", this, "iface.textChangedTrabajador");
	connect(this.iface.ledTarea, "textChanged(QString)", this, "iface.textChangedTarea");

	connect(this.iface.tbnPendientes, "clicked()", this, "iface.mostrarPendientes()");
	connect(this.iface.tbnEnCurso, "clicked()", this, "iface.mostrarEnCurso()");
	connect(this.iface.tbnTerminadas, "clicked()", this, "iface.mostrarTerminadas()");
	connect(this.iface.tbnFiltroUsuario, "clicked()", this, "iface.mostrarMias()");
	connect(this.iface.tbnInicio, "clicked()", this, "iface.volverInicio()");
	connect(this.iface.tbnDeshacer, "clicked()", this, "iface.deshacerTarea()");

	this.iface.ledTrabajador.text = "";
	this.iface.ledTarea.text = "";
	this.iface.lblTrabajador.text = "";
	this.iface.lblEstado.text = "";
	this.iface.lblEstadoTarea.text = "";
	this.iface.ultimaTarea = "";
	this.iface.tbnDeshacer.setDisabled(true);
	this.iface.ledTrabajador.setFocus();

	var datosS:Array;
	datosS["tipoObjeto"] = "todos";
	datosS["idObjeto"] = "0";
	flcolaproc.iface.pub_seguimientoOn(this, datosS);

	var filtro:String = this.iface.filtroBase();
	var codCCoste:String = util.readSettingEntry("scripts/flprodppal/codCentroCoste");
	if (codCCoste && codCCoste != "") {
		var desCentro:String = util.sqlSelect("pr_centroscoste", "descripcion", "codcentro = '" + codCCoste + "'");
		this.child("gbxTarea").title = util.translate("scripts", "Tareas del centro de coste %1 - %2").arg(codCCoste).arg(desCentro);
		filtro += " AND codcentro = '" + codCCoste + "'";
	}
	flcolaproc.iface.pub_filtroFormularioS(filtro);

	this.child("tbnLanzarTareaS").close();
	this.child("tbnDeleteTareaS").close();
	this.child("tdbTareasS").setEditOnly(true);

	if(this.child("chkPteS").checked)
		this.iface.tbnPendientes.setOn(true);
	else
		this.iface.tbnPendientes.setOn(false);
	
	if(this.child("chkEnCursoS").checked)
		this.iface.tbnEnCurso.setOn(true);
	else
		this.iface.tbnEnCurso.setOn(false);
	
	if(this.child("chkTerminadaS").checked)
		this.iface.tbnTerminadas.setOn(true);
	else
		this.iface.tbnTerminadas.setOn(false);

	if(this.child("chkMiasS").checked)
		this.iface.tbnFiltroUsuario.setOn(true);
	else
		this.iface.tbnFiltroUsuario.setOn(false);
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D
Si la tarea está en estado PTE, llama a iniciarTarea. Si está en estado EN CURSO, llama a terminarTarea
\end */
function oficial_avanzarTarea()
{
	var util:FLUtil = new FLUtil;
	var okInicioFin:Boolean = true;
	var cursor:FLSqlCursor = this.cursor();
	cursor.refreshBuffer();

	var idTarea:String = cursor.valueBuffer("idtarea");
	var idUsuario:String = util.sqlSelect("pr_trabajadores", "idtrabajador", "idtrabajador = '" + this.iface.ledTrabajador.text + "'");
	if (!idUsuario || idUsuario == "") {
		MessageBox.warning(util.translate("scripts", "El trabajador %1 no existe en la tabla de trabajadores (módulo principal de producción)").arg(this.iface.ledTrabajador.text), MessageBox.Ok);
		return;
	}
	
	var datosTarea:String = cursor.valueBuffer("idtarea") + " - " + cursor.valueBuffer("descripcion");
	if (cursor.valueBuffer("estado") == "EN CURSO") {
		this.iface.lblEstadoTarea.text = util.translate("scripts", "Terminando tarea %1...").arg(datosTarea);
	} else {
		this.iface.lblEstadoTarea.text = util.translate("scripts", "Iniciando tarea %1...").arg(datosTarea);
	}
	

	okInicioFin = flcolaproc.iface.tbnIniciarTareaSClicked(idUsuario);
	if (okInicioFin) {
		if (util.sqlSelect("pr_tareas", "estado", "idtarea = '" + idTarea + "'") == "TERMINADA")
			this.iface.lblEstadoTarea.text = util.translate("scripts", "Tarea %1: TERMINADA").arg(datosTarea);
		else
			this.iface.lblEstadoTarea.text = util.translate("scripts", "Tarea %1: INICIADA").arg(datosTarea);
	} else {
		this.iface.lblEstadoTarea.text = util.translate("scripts", "Error al procesar la tarea %1").arg(datosTarea);
	}
/*
		cursor.transaction(false);
		try {
			if (flcolaproc.iface.pub_terminarTarea(cursor)) {
				cursor.commit();
				okInicioFin = true;
				this.iface.lblEstadoTarea.text = util.translate("scripts", "Tarea %1: TERMINADA").arg(datosTarea);
			} else {
				cursor.rollback();
				okInicioFin = false;
				this.iface.lblEstadoTarea.text = util.translate("scripts", "Error al terminar la tarea %1").arg(datosTarea);
			}
		}
		catch(e) {
			cursor.rollback();
			this.iface.lblEstadoTarea.text = util.translate("scripts", "Error al terminar la tarea %1").arg(datosTarea);
			MessageBox.warning(util.translate("scripts", "Error al terminar la tarea:") + e, MessageBox.Ok, MessageBox.NoButton);
		}
	}
	if (cursor.valueBuffer("estado") == "PTE") {
		this.iface.lblEstadoTarea.text = util.translate("scripts", "Iniciando tarea %1...").arg(datosTarea);
		cursor.transaction(false);
		try {
			if (flcolaproc.iface.pub_iniciarTarea(cursor, idUsuario)) {
				cursor.commit();
				okInicioFin = true;
				this.iface.lblEstadoTarea.text = util.translate("scripts", "Tarea %1: INICIADA").arg(datosTarea);
			} else {
				cursor.rollback();
				okInicioFin = false;
				this.iface.lblEstadoTarea.text = util.translate("scripts", "Error al iniciar la tarea %1").arg(datosTarea);
			}
		}
		catch(e) {
			cursor.rollback();
			this.iface.lblEstadoTarea.text = util.translate("scripts", "Error al iniciar la tarea %1").arg(datosTarea);
			MessageBox.warning(util.translate("scripts", "Error al terminar la tarea:") + e, MessageBox.Ok, MessageBox.NoButton);
		}
	}
	*/

	this.iface.actualizarEtiquetas(okInicioFin);

	this.iface.ultimaTarea = idTarea;
	this.iface.tbnDeshacer.setDisabled(false);
}

function oficial_actualizarEtiquetas(okInicioFin:Boolean)
{
	if ( okInicioFin ) {
		this.iface.ledTrabajador.text = "";
		this.iface.ledTarea.text = "";
		this.iface.filtrarPendientes();
		this.iface.ledTarea.setFocus();
	}
	
}

/** \D
Filtra la tabla de tareas por la tarea especificada, pasando el foco al campo Trabajador
\end */
function oficial_lanzarTarea()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var idTarea:String = (this.iface.ledTarea.text).toString().toUpperCase();
	cursor.setMainFilter("UPPER(idtarea) = '" + idTarea + "'");
	this.iface.tdbTareas.refresh();
	if (cursor.valueBuffer("idtarea") != idTarea) {
		MessageBox.warning(util.translate("scripts", "No hay ninguna tarea con código ") + idTarea, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		this.iface.ledTarea.text = "";
		this.iface.ledTarea.setFocus();
		this.iface.filtrarPendientes();
		return;
	}
	if (cursor.valueBuffer("estado") == "OFF") {
		MessageBox.warning(util.translate("scripts", "La tarea indicada (%1) no está activa.\nEsto es debido a que alguna de sus tareas precedentes todavía no ha terminado").arg(idTarea), MessageBox.Ok, MessageBox.NoButton);
		return;
	}
	this.iface.mostrarDatosTarea();
	this.iface.avanzarTarea()
}

/** \D
Filtra la tabla de tareas por tareas en estado PTE o EN CURSO
\end */
function oficial_filtrarPendientes()
{
/*
	var cursor:FLSqlCursor = this.cursor();
	var nomTrabajador:String = this.iface.lblTrabajador.text

	if (nomTrabajador.isEmpty()) {
		cursor.setMainFilter("estado IN ('PTE', 'EN CURSO')");
		this.iface.lblEstado.text = "TODAS LAS TAREAS PTES. O EN CURSO";
	} else {
		cursor.setMainFilter("estado IN ('PTE', 'EN CURSO') AND idtrabajador='" + this.iface.ledTrabajador.text + "'");
		this.iface.lblEstado.text = "TAREAS EN CURSO DE " + this.iface.lblTrabajador.text;
	}
*/
	//this.iface.tdbTareas.refresh();
	flcolaproc.iface.regenerarFiltroS();
}

/** \D
Busca el trabajador en la tabla de trabajadores
\end */
function oficial_trabajadorSet()
{
	var util:FLUtil = new FLUtil;
	var nomTrabajador:String = util.sqlSelect( "pr_trabajadores", "nombre", "idtrabajador = '" + this.iface.ledTrabajador.text + "'");
	if (nomTrabajador)  {
		this.iface.lblTrabajador.text = nomTrabajador;
		this.iface.ledTarea.text = "";
		this.iface.ledTarea.setFocus();
	} else {
		this.iface.lblTrabajador.text = "";
		this.iface.ledTarea.text = "";
		this.iface.ledTrabajador.text = "";
		this.iface.ledTrabajador.setFocus();
	}
	//this.iface.filtrarPendientes();
}

/** \D
Filtrado del texto de la linea de edición de trabajador para trabajar de forma rápida utilizando solamente el teclado númerico.
\end */
function oficial_textChangedTrabajador( text:String ) {

}

/** \D
Filtrado del texto de la linea de edición de tareas para trabajar de forma rápida utilizando solamente el teclado númerico.
\end */
function oficial_textChangedTarea( text:String ) {
	var txt:String = text;

/** \C Al introducir el carácter '/' al final del texto del campo de tarea, se borra el campo de tarea y el del trabajador, situando el foco en este último.
\end */
	if ( txt.endsWith( "/" ) ) {
		this.iface.lblTrabajador.text = "";
		this.iface.ledTarea.text = "";
		this.iface.ledTrabajador.text = "";
		this.iface.ledTrabajador.setFocus();
		this.iface.filtrarPendientes();
	}
/** \C Al introducir el carácter '*' al final del texto del campo de tarea se cambia el contenido actual de este
campo por la cadena 'TA'. La cadena 'TA' corresponde al prefijo utilizado en los códigos de tareas.
\end */
	if ( txt.endsWith( "*" ) ) {
		this.iface.ledTarea.text = "TA";
		this.iface.ledTarea.setFocus();
	}
/** \C Al introducir el carácter '.' se reformatea el valor del código de la tareas reemplazando dicho el carácter "."
por los ceros "0" necesarios hasta completar el número de dígitos total, a su vez elimina los caracteres sobrantes cuando se supere el límite de dígitos.
\end */
	this.iface.posActualPuntoTarea = flcolaproc.iface.pub_formatearCodigo( this.iface.ledTarea, 8, this.iface.posActualPuntoTarea );
}

function oficial_mostrarDatosTarea()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var codLote:String = cursor.valueBuffer("idobjeto");

	var qryDatos:FLSqlQuery = new FLSqlQuery;
	with (qryDatos) {
		setTablesList("lotesstock,articulos");
		setSelect("a.referencia, a.descripcion, ls.canlote");
		setFrom("lotesstock ls INNER JOIN articulos a ON ls.referencia = a.referencia");
		setWhere("ls.codlote = '" + codLote + "'");
		setForwardOnly(true);
	}
	if (!qryDatos.exec())
		return;

	if (!qryDatos.first())
		return;

	this.iface.lblEstado.text = util.translate("scripts", "Lote %1. Artículo %2 - %3. Total %4").arg(codLote).arg(qryDatos.value("a.referencia")).arg(qryDatos.value("a.descripcion")).arg(qryDatos.value("ls.canlote"));
}

function oficial_filtroBase()
{
	return "tipoobjeto = 'lotesstock'";
}

function oficial_mostrarPendientes()
{
	if(this.iface.tbnPendientes.on)
		this.child("chkPteS").checked = true;
	else
		this.child("chkPteS").checked = false;

	flcolaproc.iface.regenerarFiltroS();

	if(this.iface.filtroOperario && this.iface.filtroOperario != "") {
		var filtro:String = this.child("tdbTareasS").cursor().mainFilter();
		if (filtro != "")
			filtro += " AND ";
		filtro += this.iface.filtroOperario;
		this.child("tdbTareasS").cursor().setMainFilter(filtro);
		this.child("tdbTareasS").refresh();
	}
}

function oficial_mostrarEnCurso()
{
	if(this.iface.tbnEnCurso.on)
		this.child("chkEnCursoS").checked = true;
	else
		this.child("chkEnCursoS").checked = false;

	flcolaproc.iface.regenerarFiltroS();

	if(this.iface.filtroOperario && this.iface.filtroOperario != "") {
		var filtro:String = this.child("tdbTareasS").cursor().mainFilter();
		if (filtro != "")
			filtro += " AND ";
		filtro += this.iface.filtroOperario;
		this.child("tdbTareasS").cursor().setMainFilter(filtro);
		this.child("tdbTareasS").refresh();
	}
}

function oficial_mostrarTerminadas()
{
	if(this.iface.tbnTerminadas.on)
		this.child("chkTerminadaS").checked = true;
	else
		this.child("chkTerminadaS").checked = false;

	flcolaproc.iface.regenerarFiltroS();

	if(this.iface.filtroOperario && this.iface.filtroOperario != "") {
		var filtro:String = this.child("tdbTareasS").cursor().mainFilter();
		if (filtro != "")
			filtro += " AND ";
		filtro += this.iface.filtroOperario;
		this.child("tdbTareasS").cursor().setMainFilter(filtro);
		this.child("tdbTareasS").refresh();
	}
}

function oficial_mostrarMias()
{
	var util:FLUtil;
	if(this.iface.tbnFiltroUsuario.on) {
		if(this.iface.ledTrabajador.text == "" || !this.iface.ledTrabajador.text) {
			MessageBox.information(util.translate("scripts", "Debe especificar un operario."), MessageBox.Ok);
			this.iface.tbnFiltroUsuario.setOn(false);
			return;
		}
		var filtro:String = this.child("tdbTareasS").cursor().mainFilter();
		if (filtro != "")
			filtro += " AND ";
		this.iface.filtroOperario = "realizadapor = '" + this.iface.ledTrabajador.text + "'";
		filtro += this.iface.filtroOperario;
		this.child("tdbTareasS").cursor().setMainFilter(filtro);
		this.child("tdbTareasS").refresh();
	}
	else {
		this.iface.filtroOperario = "";
		flcolaproc.iface.regenerarFiltroS();
	}
}

function oficial_volverInicio()
{
	this.iface.ledTrabajador.text = "";
	this.iface.ledTarea.text = "";
	this.iface.lblTrabajador.text = "";
	this.iface.lblEstado.text = "";
	this.iface.lblEstadoTarea.text = "";
	
	this.iface.ledTrabajador.setFocus();

	flcolaproc.iface.regenerarFiltroS();
}

function oficial_deshacerTarea()
{
	var util:FLUtil;
	
	this.iface.tdbTareas.cursor().setMainFilter("idtarea = '" + this.iface.ultimaTarea + "'");
	var estado:String = this.iface.tdbTareas.cursor().valueBuffer("estado");
	var unPaso:Boolean = util.sqlSelect("pr_tipostareapro", "terminaenunpaso", "idtipotareapro = " + this.iface.tdbTareas.cursor().valueBuffer("idtipotareapro"));
	var estadoAnterior:String = "PTE";
	if(estado != "TERMINADA" && estado != "EN CURSO") {
		MessageBox.warning(util.translate("scripts", "La tarea debe estar en estado TERMINADA o EN CURSO."), MessageBox.Ok);
		flcolaproc.iface.regenerarFiltroS();
		return
	}
	if(estado == "TERMINADA" && !unPaso)
		estadoAnterior = "EN CURSO";
	
	var res = MessageBox.information(util.translate("scripts", "La tarea %1 pasará de estado %1 a %3.\n¿Desea continuar?").arg(this.iface.ultimaTarea).arg(estado).arg(estadoAnterior), MessageBox.Yes,MessageBox.No);
	
	if(res == MessageBox.Yes) {
		flcolaproc.iface.pub_tbnDeshacerTareaSClicked();
		this.iface.ultimaTarea = "";
		this.iface.tbnDeshacer.setDisabled(true);
	}

	flcolaproc.iface.regenerarFiltroS();
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCION /////////////////////////////////////////////////
function prod_init()
{
	this.iface.__init();

	this.iface.tbnPausarTareaS = this.child("tbnPausarTareaS");

	connect(this.iface.tbnPausarTareaS, "clicked()", this, "iface.pausarTareas_clicked()");
	var orden:Array = ["idtarea", "idtipotarea", "estado", "descripcion", "subestado"];
	this.iface.tdbTareas.setOrderCols(orden);
	this.iface.tdbTareas.refresh();
}

function prod_pausarTareas_clicked()
{	
	var util:FLUtil;

	if(!util.sqlSelect("pr_tareastrabajador","id","activa")) {
		MessageBox.information(util.translate("scripts", "No hay ninguna tarea activa"), MessageBox.Yes, MessageBox.No);
		return;
	}
	
	var res:Number = MessageBox.information(util.translate("scripts", "Se van a pausar todas las tareas activas.\n¿Desea continuar?"), MessageBox.Yes, MessageBox.No);
	if(res != MessageBox.Yes)
		return;

	var cursor:FLSqlCursor = this.cursor();
	cursor.transaction(false);
	try {
		if (this.iface.pausarTareas()) {
			cursor.commit();
		} else {
			cursor.rollback();
			return;
		}
	}
	catch(e) {
		cursor.rollback();
		MessageBox.warning(util.translate("scripts", "Error al terminar la tarea:") + e, MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	this.child("tdbTareasS").refresh();
	MessageBox.information(util.translate("scripts", "Las tareas activas se pausaron correctamente."), MessageBox.Ok, MessageBox.NoButton);
}

function prod_pausarTareas():Boolean
{
	var util:FLUtil;
	var curTareasTrab:FLSqlCursor = new FLSqlCursor("pr_tareastrabajador");
	var curTareas:FLSqlCursor = new FLSqlCursor("pr_tareas");
	curTareasTrab.select("activa");

	var estado:String;
	var idTarea:String;
	var idProceso:Number;
	var ahora:Date = new Date();
	while (curTareasTrab.next()) {
		curTareasTrab.setModeAccess(curTareasTrab.Edit);
		curTareasTrab.refreshBuffer();
		estado = curTareasTrab.valueBuffer("estado");
		if(!estado || estado == "")
			return false;
		idTarea = curTareasTrab.valueBuffer("idtarea");
		if(!idTarea || idTarea == "")
			return false;
		curTareas.select("idtarea = '" + idTarea + "'");
		curTareas.first();
		curTareas.setModeAccess(curTareas.Edit);
		curTareas.refreshBuffer();
		idProceso = curTareas.valueBuffer("idproceso");
		if(!idProceso)
			return false;

		curTareasTrab.setValueBuffer("estado","EN PAUSA");
		curTareasTrab.setValueBuffer("activa",false);
		curTareasTrab.setValueBuffer("fincuentaf",ahora.toString());
		curTareasTrab.setValueBuffer("fincuentat",ahora.toString().right(8));
		switch(estado) {
			case util.translate("scripts", "PREPARACIÓN EN CURSO"): {
				var tiempo:Number = formRecordpr_tareas.iface.pub_calcularTiempo(curTareasTrab);
				var acumuladoTrab:Number = parseInt(curTareasTrab.valueBuffer("acumuladotrab"))
				var acumuladoPrep:Number = parseInt(curTareasTrab.valueBuffer("acumuladoprep")) + tiempo;
				curTareasTrab.setValueBuffer("acumuladoprep", acumuladoPrep);
				var totalAcumulado = parseInt(curTareasTrab.valueBuffer("totalacumulado")) + acumuladoTrab + acumuladoPrep;
				totalAcumulado = flcolaproc.iface.pub_convertirTiempoProceso(totalAcumulado, idProceso);
				curTareasTrab.setValueBuffer("totalacumulado", totalAcumulado);
				if(!curTareasTrab.commitBuffer())
					return false;

				curTareas.setValueBuffer("subestado",util.translate("scripts", "EN PAUSA"));
				var tiempo:Number = formRecordpr_tareas.iface.pub_calcularTiempo(curTareas);
				var acumuladoPrep:Number = parseInt(curTareas.valueBuffer("intervaloprep")) + tiempo;
				curTareas.setValueBuffer("intervaloprep", acumuladoPrep);
				if(!curTareas.commitBuffer())
					return false;
				break;
			}
			case util.translate("scripts", "TRABAJO EN CURSO"): {
				var tiempo:Number = formRecordpr_tareas.iface.pub_calcularTiempo(curTareasTrab);
				var acumuladoPrep:Number = parseInt(curTareasTrab.valueBuffer("acumuladoprep"))
				var acumuladoTrab:Number = parseInt(curTareasTrab.valueBuffer("acumuladotrab")) + tiempo;
				curTareasTrab.setValueBuffer("acumuladotrab", acumuladoTrab);
				var totalAcumulado = parseInt(curTareasTrab.valueBuffer("totalacumulado")) + acumuladoTrab + acumuladoPrep;
				totalAcumulado = flcolaproc.iface.pub_convertirTiempoProceso(totalAcumulado, idProceso);
				curTareasTrab.setValueBuffer("totalacumulado", totalAcumulado);
				if(!curTareasTrab.commitBuffer())
					return false;

				curTareas.setValueBuffer("subestado",util.translate("scripts", "EN PAUSA"));
				var tiempo:Number = formRecordpr_tareas.iface.pub_calcularTiempo(curTareas);
				var acumuladoTrab:Number = parseInt(curTareas.valueBuffer("intervalotrab")) + tiempo;
				curTareas.setValueBuffer("intervalotrab", acumuladoTrab);
				if(!curTareas.commitBuffer())
					return false;
				break;
			}
		}
	}
	return true;
}

/** \D
Si la tarea está en estado PTE, llama a iniciarTarea. Si está en estado EN CURSO, llama a terminarTarea
\end */
function prod_avanzarTarea()
{
	var util:FLUtil = new FLUtil;
	var okInicioFin:Boolean = true;
	var cursor:FLSqlCursor = this.cursor();
	cursor.refreshBuffer();

	var idTarea:String = cursor.valueBuffer("idtarea");

	this.iface.__avanzarTarea();

	if(util.sqlSelect("pr_config","controltiempo","1=1") && util.sqlSelect("pr_config","mostrarformulario","1=1")) {
		if (idTarea == this.iface.ultimaTarea) {
			if (util.sqlSelect("pr_tareas", "estado", "idtarea = '" + idTarea + "'") == "EN CURSO") {
				var curTarea:FLSqlCursor = new FLSqlCursor("pr_tareas");
				curTarea.select("idtarea = '" + idTarea + "'");
				if (!curTarea.first()) {
					MessageBox.warning(util.translate("scripts", "Error al abrir el formulario de la tarea %1").arg(idTarea), MessageBox.Ok, MessageBox.NoButton);
					return;
				}
				curTarea.editRecord();
			}
		}
	}
}
//// PRODUCCION /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
