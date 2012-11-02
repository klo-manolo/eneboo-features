var form = Application.formRecordpr_inbox;
/***************************************************************************
                 pr_masterterminaltrabajador.qs  -  description
                             -------------------
    begin                : vie oct 10 2008
    copyright            : (C) 20010 by InfoSiAL S.L.
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
El formulario muestra los datos de la tarea en curso según el trabajador
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
	var ledTrabajador:Object;
	var lblTrabajador:Object;
	var tbnBorrarUsuario:Object;
	var ledTarea:Object;
	var lblTareaSeleccionada:Object;
	var lblTareaActiva:Object;
	var tbnPlayPrep:Object;
	var tbnPausePrep:Object;
	var tbnStopPrep:Object;
	var tbnPlayTrab:Object;
	var tbnPauseTrab:Object;
	var tbnStopTrab:Object;
	var lblTiempoPreparacion:Object;
	var lblTiempoTrabajo:Object;
	var lblAcumuladoPrep:Object;
	var lblAcumuladoTrab:Object;
	var lblDatosLoteSeleccionado:Object;
	var lblDatosLoteActivo:Object;
	var lblSubestado:Object;
	var posActualPuntoTrabajador:Number;
	var posActualPuntoTarea:Number;
	var idTareaActiva:String;
	var curTareaActiva_:FLSqlCursor;
    function oficial( context ) { interna( context ); }
	function textChangedTrabajador( text:String ) {
		return this.ctx.oficial_textChangedTrabajador( text );
	}
	function textChangedTarea( text:String )	{
		return this.ctx.oficial_textChangedTarea( text );
	}
	function mostrarTrabajador()	{
		return this.ctx.oficial_mostrarTrabajador();
	}
	function mostrarTareaSeleccionada()	{
		return this.ctx.oficial_mostrarTareaSeleccionada();
	}
	function mostrarTareaActiva(idTarea:String,subestado:String) {
		return this.ctx.oficial_mostrarTareaActiva(idTarea,subestado);
	}
	function buscarTareaActiva() {
		return this.ctx.oficial_buscarTareaActiva();
	}
	function activarTarea(tiempo:String):Boolean {
		return this.ctx.oficial_activarTarea(tiempo);
	}
	function establecerTareaActiva():Boolean {
		return this.ctx.oficial_establecerTareaActiva();
	}
	function borrarUsuario() {
		return this.ctx.oficial_borrarUsuario();
	}
	function hayUnaTareaActiva():Number {
		return this.ctx.oficial_hayUnaTareaActiva();
	}
	function mostrarTiempo() {
		return this.ctx.oficial_mostrarTiempo();
	}
	function tbnPlayPrep_clicked() {
		return this.ctx.oficial_tbnPlayPrep_clicked();
	}
	function tbnPausePrep_clicked() {
		return this.ctx.oficial_tbnPausePrep_clicked();
	}
	function tbnPlayTrab_clicked() {
		return this.ctx.oficial_tbnPlayTrab_clicked();
	}
	function tbnPauseTrab_clicked() {
		return this.ctx.oficial_tbnPauseTrab_clicked();
	}
	function tbnStop_clicked() {
		return this.ctx.oficial_tbnStop_clicked();
	}
	function playPrep():Boolean {
		return this.ctx.oficial_playPrep();
	}
	function pausePrep():Boolean {
		return this.ctx.oficial_pausePrep();
	}
	function playTrab():Boolean {
		return this.ctx.oficial_playTrab();
	}
	function pauseTrab():Boolean {
		return this.ctx.oficial_pauseTrab();
	}
	function stop():Boolean {
		return this.ctx.oficial_stop();
	}
	function borrarTemporizadores() {
		return this.ctx.oficial_borrarTemporizadores();
	}
	function controlTiempoTarea(curTareaTrab:FLSqlCursor):Boolean {
		return this.ctx.oficial_controlTiempoTarea(curTareaTrab);
	}
	function comprobarTareaTrabajador() {
		return this.ctx.oficial_comprobarTareaTrabajador();
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
	this.child("pushButtonCancel").close();

	this.iface.ledTrabajador = this.child("ledTrabajador");
	this.iface.lblTrabajador = this.child("lblTrabajador");
	this.iface.tbnBorrarUsuario = this.child("tbnBorrarUsuario");
	this.iface.ledTarea = this.child("ledTarea");
	this.iface.lblTareaSeleccionada = this.child("lblDatosTareaSeleccionada");
	this.iface.lblTareaActiva = this.child("lblDatosTareaActiva");
	this.iface.tbnPlayPrep = this.child("tbnPlayPrep");
	this.iface.tbnPausePrep = this.child("tbnPausePrep");
	this.iface.tbnStopPrep = this.child("tbnStopPrep");
	this.iface.tbnPlayTrab = this.child("tbnPlayTrab");
	this.iface.tbnPauseTrab = this.child("tbnPauseTrab");
	this.iface.tbnStopTrab = this.child("tbnStopTrab");
	this.iface.lblTiempoPreparacion = this.child("lblTiempoPreparacion");
	this.iface.lblTiempoTrabajo = this.child("lblTiempoTrabajo");
	this.iface.lblAcumuladoPrep = this.child("lblAcumuladoPrep");
	this.iface.lblAcumuladoTrab = this.child("lblAcumuladoTrab");
	this.iface.lblDatosLoteSeleccionado = this.child("lblDatosLoteSeleccionado");
	this.iface.lblDatosLoteActivo = this.child("lblDatosLoteActivo");
	this.iface.lblSubestado = this.child("lblSubestado");
	this.iface.idTareaActiva = "";

	this.iface.borrarUsuario();
	
	if(!util.sqlSelect("pr_config","controltiempo","1 = 1")) {
		this.setDisabled(true);
	}

	connect(this.iface.ledTrabajador, "returnPressed()", this, "iface.mostrarTrabajador");
	connect(this.iface.ledTarea, "returnPressed()", this, "iface.mostrarTareaSeleccionada");
	connect(this.iface.ledTrabajador, "textChanged(QString)", this, "iface.textChangedTrabajador");
	connect(this.iface.ledTarea, "textChanged(QString)", this, "iface.textChangedTarea");
	connect(this.iface.tbnBorrarUsuario, "clicked()", this, "iface.borrarUsuario()");
	connect(this.iface.tbnPlayPrep, "clicked()", this, "iface.tbnPlayPrep_clicked()");
	connect(this.iface.tbnPausePrep, "clicked()", this, "iface.tbnPausePrep_clicked()");
	connect(this.iface.tbnStopPrep, "clicked()", this, "iface.tbnStop_clicked()");
	connect(this.iface.tbnPlayTrab, "clicked()", this, "iface.tbnPlayTrab_clicked()");
	connect(this.iface.tbnPauseTrab, "clicked()", this, "iface.tbnPauseTrab_clicked()");
	connect(this.iface.tbnStopTrab, "clicked()", this, "iface.tbnStop_clicked()");
	connect (this, "closed()", this, "iface.borrarTemporizadores");
	this.iface.tbnStopPrep.close();
	this.child("lblE").close();
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D
Busca el trabajador en la tabla de trabajadores
\end */
function oficial_mostrarTrabajador()
{
	var util:FLUtil = new FLUtil;
	var nomTrabajador:String = util.sqlSelect( "pr_trabajadores", "nombre", "idtrabajador = '" + this.iface.ledTrabajador.text + "'");
	if (nomTrabajador)  {
		this.iface.lblTrabajador.text = nomTrabajador;
		this.iface.ledTarea.text = "";
		this.iface.ledTarea.setFocus();
		var tareaActiva:Number = this.iface.hayUnaTareaActiva();
		if(tareaActiva) {
			idTarea = util.sqlSelect("pr_tareastrabajador","idtarea","id = " + tareaActiva);
			estado = util.sqlSelect("pr_tareastrabajador","estado","id = " + tareaActiva);
			this.iface.mostrarTareaActiva(idTarea,estado);
		}
		else
			this.iface.lblSubestado.text = "No tiene tarea activa";
	} else {
		this.iface.lblTrabajador.text = "";
		this.iface.ledTarea.text = "";
		this.iface.ledTrabajador.text = "";
		this.iface.ledTrabajador.setFocus();
		delete this.iface.curTareaActiva_;
	}
}

/** \D
Busca la tarea en la tabla de tareas
\end */
function oficial_mostrarTareaSeleccionada()
{
	var util:FLUtil = new FLUtil;
	
	var idTarea:String = this.iface.ledTarea.text;
	
	if(!idTarea || idTarea == "")
		return;

	var qryDatos:FLSqlQuery = new FLSqlQuery;
	with (qryDatos) {
		setTablesList("pr_tareas,lotesstock,articulos");
		setSelect("a.referencia, a.descripcion, ls.canlote,ls.codlote,t.idtarea,t.descripcion,t.estado");
		setFrom("pr_tareas T INNER JOIN lotesstock ls ON t.idobjeto = ls.codlote INNER JOIN articulos a ON ls.referencia = a.referencia");
		setWhere("t.idtarea = '" + idTarea + "'");
		setForwardOnly(true);
	}
	if (!qryDatos.exec())
		return;

	if (!qryDatos.first())
		return;

	this.iface.lblDatosLoteSeleccionado.text = util.translate("scripts", "Lote %1. Artículo %2 - %3. Total %4").arg(qryDatos.value("ls.codlote")).arg(qryDatos.value("a.referencia")).arg(qryDatos.value("a.descripcion")).arg(qryDatos.value("ls.canlote"));
	this.iface.lblTareaSeleccionada.text = util.translate("scripts", "Tarea %1 %2 - %2").arg(qryDatos.value("t.idtarea")).arg(qryDatos.value("t.estado")).arg(qryDatos.value("t.descripcion"));

	if(this.iface.idTareaActiva) {
		var subestado = this.iface.lblSubestado.text;
		if(subestado != "EN PAUSA" && subestado != "")
			return;
	}

	if(qryDatos.value("t.estado") == "TERMINADA" || qryDatos.value("t.estado") == "OFF"){
		this.iface.lblTareaActiva.text = "";
		delete this.iface.curTareaActiva_;
		this.iface.idTareaActiva = "";
		this.iface.lblDatosLoteActivo.text = "";
		this.iface.lblTiempoPreparacion.text = "";
		this.iface.lblTiempoTrabajo.text = "";
		this.iface.lblAcumuladoPrep.text = "";
		this.iface.lblAcumuladoTrab.text = "";
		this.iface.lblSubestado.text = "";
		this.iface.borrarTemporizadores();
		this.child("gbxTareaActiva").setDisabled(true);
	}
	else {
		this.child("gbxTareaActiva").setDisabled(false);
		this.iface.comprobarTareaTrabajador();
	}
}

function oficial_comprobarTareaTrabajador()
{
	var util:FLUtil;

	var idTarea:String = this.iface.ledTarea.text;
	if(!idTarea || idTarea == "")
		return;
	
	var idTrabajador:String = this.iface.ledTrabajador.text;
	if(!idTrabajador || idTrabajador == "")
		return;

	var estado:String = util.sqlSelect("pr_tareastrabajador","estado","idtarea = '" + idTarea + "' AND idtrabajador = '" + idTrabajador + "' AND activa");

	if(estado && estado != "")
		this.iface.mostrarTareaActiva(idTarea,estado);
	else
		this.iface.lblSubestado.text = ""
	
}

function oficial_establecerTareaActiva():Boolean
{
	if(this.iface.curTareaActiva_)
		delete this.iface.curTareaActiva_;

	var idTrabajador = this.iface.ledTrabajador.text;

	if(!this.iface.idTareaActiva || this.iface.idTareaActiva == "" || !idTrabajador || idTrabajador == "")
		return false;
	
	this.iface.curTareaActiva_ = new FLSqlCursor("pr_tareastrabajador");
			
	this.iface.curTareaActiva_.select("idtarea = '" + this.iface.idTareaActiva + "' AND idtrabajador = '" + idTrabajador + "' AND activa");
	this.iface.curTareaActiva_.first();
	this.iface.curTareaActiva_.setModeAccess(this.iface.curTareaActiva_.Edit);
	this.iface.curTareaActiva_.refreshBuffer();

	return true;
}

function oficial_mostrarTareaActiva(idTarea:String,subestado:String)
{
	var util:FLUtil = new FLUtil;
	
	var qryDatos:FLSqlQuery = new FLSqlQuery;
	with (qryDatos) {
		setTablesList("pr_tareas,lotesstock,articulos");
		setSelect("a.referencia, a.descripcion, ls.canlote,ls.codlote,t.idtarea,t.descripcion,t.estado");
		setFrom("pr_tareas T INNER JOIN lotesstock ls ON t.idobjeto = ls.codlote INNER JOIN articulos a ON ls.referencia = a.referencia");
		setWhere("t.idtarea = '" + idTarea + "'");
		setForwardOnly(true);
	}
	if (!qryDatos.exec())
		return;

	if (!qryDatos.first())
		return;

	this.iface.lblDatosLoteActivo.text = util.translate("scripts", "Lote %1. Artículo %2 - %3. Total %4").arg(qryDatos.value("ls.codlote")).arg(qryDatos.value("a.referencia")).arg(qryDatos.value("a.descripcion")).arg(qryDatos.value("ls.canlote"));
	this.iface.lblTareaActiva.text = util.translate("scripts", "Tarea %1 %2 - %2").arg(qryDatos.value("t.idtarea")).arg(qryDatos.value("t.estado")).arg(qryDatos.value("t.descripcion"));
	this.iface.idTareaActiva = idTarea;
	
	if(!this.iface.establecerTareaActiva())
		return false;
	
	this.iface.lblSubestado.text = subestado;
	this.iface.lblTiempoPreparacion.text = formRecordpr_tareas.iface.pub_formatearTiempo(0);
	this.iface.lblAcumuladoPrep.text = formRecordpr_tareas.iface.pub_formatearTiempo(parseInt(this.iface.curTareaActiva_.valueBuffer("acumuladoprep")));
	this.iface.lblTiempoTrabajo.text = formRecordpr_tareas.iface.pub_formatearTiempo(0);
	this.iface.lblAcumuladoTrab.text = formRecordpr_tareas.iface.pub_formatearTiempo(parseInt(this.iface.curTareaActiva_.valueBuffer("acumuladotrab")));


	if(subestado == "EN PAUSA")
		this.iface.mostrarTiempo();
	else	
		startTimer(1000, this.iface.mostrarTiempo);
}

/** \D
Filtrado del texto de la linea de edición de trabajador para trabajar de forma rápida utilizando solamente el teclado númerico.
\end */
function oficial_textChangedTrabajador( text:String )
{
	this.iface.ledTarea.text = "";
	this.iface.lblTareaSeleccionada.text = "";
	this.iface.lblTareaActiva.text = "";
	delete this.iface.curTareaActiva_;
	this.iface.idTareaActiva = "";
	this.iface.lblDatosLoteSeleccionado.text = "";
	this.iface.lblDatosLoteActivo.text = "";
	this.iface.lblTiempoPreparacion.text = "";
	this.iface.lblTiempoTrabajo.text = "";
	this.iface.lblAcumuladoPrep.text = "";
	this.iface.lblAcumuladoTrab.text = "";
	this.iface.lblSubestado.text = "";
	this.iface.posActualPuntoTrabajador = -1;
	this.iface.posActualPuntoTarea = -1;
	this.child("gbxTareaActiva").setDisabled(false);
	this.iface.borrarTemporizadores();
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

function oficial_borrarUsuario()
{
	this.iface.ledTrabajador.text = "";
	this.iface.ledTarea.text = "";
	this.iface.lblTrabajador.text = "";
	this.iface.lblTareaSeleccionada.text = "";
	this.iface.lblTareaActiva.text = "";
	delete this.iface.curTareaActiva_;
	this.iface.idTareaActiva = "";
	this.iface.lblDatosLoteSeleccionado.text = "";
	this.iface.lblDatosLoteActivo.text = "";
	this.iface.ledTrabajador.setFocus();
	this.iface.lblTiempoPreparacion.text = "";
	this.iface.lblTiempoTrabajo.text = "";
	this.iface.lblAcumuladoPrep.text = "";
	this.iface.lblAcumuladoTrab.text = "";
	this.iface.lblSubestado.text = "";
	this.iface.posActualPuntoTrabajador = -1;
	this.iface.posActualPuntoTarea = -1;

	this.iface.borrarTemporizadores();
}

function oficial_activarTarea(tiempo:String):Boolean
{
	var util:FLUtil;

	var ahora:Date = new Date();
	var tareaActiva:Number = this.iface.hayUnaTareaActiva();
	if(tareaActiva) {
		if(this.iface.curTareaActiva_)
			delete this.iface.curTareaActiva_;

		this.iface.curTareaActiva_ = new FLSqlCursor("pr_tareastrabajador");	
		this.iface.curTareaActiva_.select("id = " + tareaActiva);
		if(!this.iface.curTareaActiva_.first())
			return false;
		switch(this.iface.curTareaActiva_.valueBuffer("estado")) {
			case util.translate("scripts", "PREPARACIÓN EN CURSO"): {
				this.iface.curTareaActiva_.setValueBuffer("fincuentaf",ahora.toString());
				this.iface.curTareaActiva_.setValueBuffer("fincuentat",ahora.toString().right(8));
				if(!this.iface.pausePrep())
					return false;
				break;
			}
			case estadoActivo = util.translate("scripts", "TRABAJO EN CURSO"): {
				this.iface.curTareaActiva_.setValueBuffer("fincuentaf",ahora.toString());
				this.iface.curTareaActiva_.setValueBuffer("fincuentat",ahora.toString().right(8));
				if(!this.iface.pauseTrab())
					return false;
				break;
			}
			default: {
				return false;
			}
		}
	}

	var idTarea:String = this.iface.ledTarea.text;
	if(!idTarea || idTarea == "")
		return;

	var trabajador:String = this.iface.ledTrabajador.text;
	if(!trabajador || trabajador == "")
		return;

	if(this.iface.curTareaActiva_)
		delete this.iface.curTareaActiva_;

	this.iface.curTareaActiva_ = new FLSqlCursor("pr_tareastrabajador");	
	this.iface.curTareaActiva_.setModeAccess(this.iface.curTareaActiva_.Insert);
	this.iface.curTareaActiva_.refreshBuffer();
	this.iface.curTareaActiva_.setValueBuffer("idtarea", idTarea);
	this.iface.curTareaActiva_.setValueBuffer("idtrabajador", trabajador);

	this.iface.idTareaActiva = idTarea;
	var estadoActivo:String;

	if(tiempo && tiempo != "") {
		if(tiempo == "preparacion")
			estadoActivo = util.translate("scripts", "PREPARACIÓN EN CURSO");
		else
			estadoActivo = util.translate("scripts", "TRABAJO EN CURSO");
	}

	if(!estadoActivo || estadoActivo == "") {
		if(util.sqlSelect("pr_tareastrabajador","SUM(acumuladotrab)","idtarea = '" + idTarea + "' AND idtrabajador = '" + trabajador + "'") == 0)
			estadoActivo = util.translate("scripts", "PREPARACIÓN EN CURSO");
		else
			estadoActivo = util.translate("scripts", "TRABAJO EN CURSO");
	}
	
	this.iface.curTareaActiva_.setValueBuffer("estado",estadoActivo);
	if(!this.iface.controlTiempoTarea())
		return false;

	this.iface.curTareaActiva_.setValueBuffer("acumuladoprep",0);
	this.iface.curTareaActiva_.setValueBuffer("acumuladotrab",0);
	this.iface.curTareaActiva_.setValueBuffer("activa",true);
	this.iface.curTareaActiva_.setValueBuffer("iniciocuentaf",ahora.toString());
	this.iface.curTareaActiva_.setValueBuffer("iniciocuentat",ahora.toString().right(8));
	if(!this.iface.curTareaActiva_.commitBuffer())
		return false;

	this.iface.mostrarTareaActiva(idTarea,estadoActivo);
	startTimer(1000, this.iface.mostrarTiempo);

	return true;
}

function oficial_mostrarTiempo()
{
	var util:FLUtil = new FLUtil;
	
	if(!this.iface.curTareaActiva_)
		if(!this.iface.establecerTareaActiva())
			return false;

	var estado:String = this.iface.curTareaActiva_.valueBuffer("estado");
	var tiempo:Number = formRecordpr_tareas.iface.pub_calcularTiempo(this.iface.curTareaActiva_);
	switch (estado) {
		case util.translate("scripts", "PREPARACIÓN EN CURSO"): {
			this.iface.lblTiempoPreparacion.text = formRecordpr_tareas.iface.pub_formatearTiempo(tiempo);
			var acumuladoPrep:Number = parseInt(util.sqlSelect("pr_tareastrabajador","SUM(acumuladoprep)","idtarea = '" + this.iface.curTareaActiva_.valueBuffer("idtarea") + "' AND idtrabajador = '" +  this.iface.curTareaActiva_.valueBuffer("idtrabajador") + "'")) + tiempo;
			this.iface.lblAcumuladoPrep.text = formRecordpr_tareas.iface.pub_formatearTiempo(acumuladoPrep);
			break;
		}
		case util.translate("scripts", "TRABAJO EN CURSO"): {
			this.iface.lblTiempoTrabajo.text = formRecordpr_tareas.iface.pub_formatearTiempo(tiempo);
			var acumuladoTrab:Number = parseInt(util.sqlSelect("pr_tareastrabajador","SUM(acumuladotrab)","idtarea = '" + this.iface.curTareaActiva_.valueBuffer("idtarea") + "' AND idtrabajador = '" +  this.iface.curTareaActiva_.valueBuffer("idtrabajador") + "'")) + tiempo;
			this.iface.lblAcumuladoTrab.text = formRecordpr_tareas.iface.pub_formatearTiempo(acumuladoTrab);
			break;
		}
	}
}

function oficial_hayUnaTareaActiva():Number
{
	var util:FLUtil;
	var trabajador:String = this.iface.ledTrabajador.text;

	var tarea:Number = util.sqlSelect("pr_tareastrabajador","id","idtrabajador = '" + trabajador + "' AND activa");
	if(!tarea)
		return false;

	return tarea;
}

function oficial_controlTiempoTarea():Boolean
{
	var util:FLUtil;

	if(!this.iface.idTareaActiva || this.iface.idTareaActiva == "") {
		if(!this.iface.establecerTareaActiva())
			return false;
	}

	var idTarea:String = this.iface.idTareaActiva;
	var curTarea:FLSqlCursor = new FLSqlCursor("pr_tareas");
	curTarea.select("idtarea = '" + idTarea + "'");
	if(!curTarea.first())
		return false;

	curTarea.setModeAccess(curTarea.Edit);
	curTarea.refreshBuffer();

	var estadoTT:String = this.iface.curTareaActiva_.valueBuffer("estado");
	var estadoT:String = curTarea.valueBuffer("estado");
	switch(estadoTT) {
		case util.translate("scripts", "PREPARACIÓN EN CURSO"):
		case util.translate("scripts", "TRABAJO EN CURSO"): {
			switch(estadoT) {
				case "PTE": {
					var idTrabajador:String = this.iface.curTareaActiva_.valueBuffer("idtrabajador");
					if(!idTrabajador)
						return false;
					
					if(!flcolaproc.iface.pub_iniciarTarea(curTarea,idTrabajador))
						return false;

					curTarea.setValueBuffer("subestado",estadoTT);
					break;
				}
				case "EN CURSO": {
					var subestado:String = curTarea.valueBuffer("subestado");
					if(subestado == util.translate("scripts", "EN PAUSA")) {
						curTarea.setValueBuffer("subestado",estadoTT);
						var ahora:Date = new Date;
						curTarea.setValueBuffer("iniciocuentaf", ahora.toString());
						curTarea.setValueBuffer("iniciocuentat", ahora.toString().right(8));
					}
					break;
				}
			}
			break;
		}
		case util.translate("scripts", "EN PAUSA"): {
			switch(estadoT) {
				case "EN CURSO": {
					if(!util.sqlSelect("pr_tareastrabajador","id","idtarea = '" + idTarea + "' AND activa = true AND id <> " + this.iface.curTareaActiva_.valueBuffer("id"))) {
						var intervalo:Number;
						var subestado:String = curTarea.valueBuffer("subestado");
						if(subestado && subestado != util.translate("scripts", "EN PAUSA")) {
							var ahora:Date = new Date;
							var tiempoAhora:Number = ahora.getTime();
							var inicio:String = curTarea.valueBuffer("iniciocuentaf").toString().left(11) + curTarea.valueBuffer("iniciocuentat").toString().right(8);
							var tiempoInicio:Number = Date.parse(inicio);
							intervalo = tiempoAhora - tiempoInicio;
							intervalo = Math.round(intervalo / 1000);
							switch (subestado) {
								case util.translate("scripts", "PREPARACIÓN EN CURSO"): {
									intervalo = parseFloat(curTarea.valueBuffer("intervaloprep")) + intervalo;
									curTarea.setValueBuffer("intervaloprep",intervalo.toString());
									break;
								}
								case util.translate("scripts", "TRABAJO EN CURSO"): {
									intervalo = parseFloat(curTarea.valueBuffer("intervalotrab")) + intervalo;
									curTarea.setValueBuffer("intervalotrab",intervalo.toString());
									break;
								}
							}
							curTarea.setValueBuffer("subestado",util.translate("scripts", "EN PAUSA"));
							curTarea.setNull("iniciocuentaf");
							curTarea.setNull("iniciocuentat");
						}
					}
				}
			}
		}
	}

	if(!curTarea.commitBuffer())
		return false;

	return true;
}

function oficial_tbnPlayPrep_clicked()
{
	var cursor:FLSqlCursor = new FLSqlCursor("empresa");
	cursor.select("1=1");
	cursor.first();
	cursor.setModeAccess(cursor.Edit);
	cursor.refreshBuffer();
	cursor.transaction(false);
	try {
		if (this.iface.playPrep()){
			cursor.commit();
		}
		else{
			cursor.rollback();
		}
	} catch(e) {
		cursor.rollback();
	}
	
}

function oficial_tbnPlayTrab_clicked()
{
	var cursor:FLSqlCursor = new FLSqlCursor("empresa");
	cursor.select("1=1");
	cursor.first();
	cursor.setModeAccess(cursor.Edit);
	cursor.refreshBuffer();
	cursor.transaction(false);
	try {
		if (this.iface.playTrab())
			cursor.commit();
		else
			cursor.rollback();
	} catch(e) {
		cursor.rollback();
	}
}

function oficial_tbnPausePrep_clicked()
{
	var cursor:FLSqlCursor = new FLSqlCursor("empresa");
	cursor.select("1=1");
	cursor.first();
	cursor.setModeAccess(cursor.Edit);
	cursor.refreshBuffer();
	cursor.transaction(false);
	try {
		if (this.iface.pausePrep())
			cursor.commit();
		else
			cursor.rollback();
	} catch(e) {
		cursor.rollback();
	}
}

function oficial_tbnPauseTrab_clicked()
{
	var cursor:FLSqlCursor = new FLSqlCursor("empresa");
	cursor.select("1=1");
	cursor.first();
	cursor.setModeAccess(cursor.Edit);
	cursor.refreshBuffer();
	cursor.transaction(false);
	try {
		if (this.iface.pauseTrab())
			cursor.commit();
		else
			cursor.rollback();
	} catch(e) {
		cursor.rollback();
	}
}

function oficial_tbnStop_clicked()
{
	var cursor:FLSqlCursor = new FLSqlCursor("empresa");
	cursor.select("1=1");
	cursor.first();
	cursor.setModeAccess(cursor.Edit);
	cursor.refreshBuffer();
	cursor.transaction(false);
	try {
		if (this.iface.stop())
			cursor.commit();
		else
			cursor.rollback();
	} catch(e) {
		cursor.rollback();
	}
}

function oficial_playPrep():Boolean
{
	var util:FLUtil = new FLUtil;

	var idTarea:String = this.iface.ledTarea.text;
	if(!idTarea || idTarea == "") {
		idTarea = this.iface.idTareaActiva;
		if(!idTarea || idTarea == "")
			return false;
	}

	var trabajador:String = this.iface.ledTrabajador.text;
	if(!trabajador || trabajador == "")
		return false;

	if(util.sqlSelect("pr_tareas","subestado","idtarea = '" + idTarea + "'") == util.translate("scripts", "TRABAJO EN CURSO")) {
		MessageBox.warning(util.translate("scripts", "No se puede comenzar el tiempo de preparación ya que la tarea %1 se encuentra en tiempo de trabajo.").arg(idTarea), MessageBox.Ok,MessageBox.NoButton);
		return false;
	}

	var ahora:Date = new Date();
	var tareaActiva:Number = this.iface.hayUnaTareaActiva();
	var estado:String;

	if(tareaActiva) {
		this.iface.idTareaActiva =  util.sqlSelect("pr_tareastrabajador","idtarea","id = " + tareaActiva);
		delete this.iface.curTareaActiva_;
		if(!this.iface.establecerTareaActiva())
			return false;
		if(idTarea == this.iface.curTareaActiva_.valueBuffer("idtarea")) {
			return false;
		}

		switch(this.iface.curTareaActiva_.valueBuffer("estado")) {
			case util.translate("scripts", "PREPARACIÓN EN CURSO"): {
				if(!this.iface.pausePrep())
					return false;
				break;
			}
			case estadoActivo = util.translate("scripts", "TRABAJO EN CURSO"): {
				if(!this.iface.pauseTrab())
					return false;
				break;
			}
			default: {
				return false;
			}
		}
	}

	if(this.iface.curTareaActiva_)
		delete this.iface.curTareaActiva_;

	this.iface.curTareaActiva_ = new FLSqlCursor("pr_tareastrabajador");	
	this.iface.curTareaActiva_.setModeAccess(this.iface.curTareaActiva_.Insert);
	this.iface.curTareaActiva_.refreshBuffer();
	this.iface.curTareaActiva_.setValueBuffer("idtarea", idTarea);
	this.iface.curTareaActiva_.setValueBuffer("idtrabajador", trabajador);
	this.iface.idTareaActiva = idTarea;
	this.iface.curTareaActiva_.setValueBuffer("estado",util.translate("scripts", "PREPARACIÓN EN CURSO"));
	this.iface.lblSubestado.text = util.translate("scripts", "PREPARACIÓN EN CURSO");
	if(!this.iface.controlTiempoTarea())
		return false;

	this.iface.curTareaActiva_.setValueBuffer("acumuladoprep",0);
	this.iface.curTareaActiva_.setValueBuffer("acumuladotrab",0);
	this.iface.curTareaActiva_.setValueBuffer("activa",true);
	this.iface.curTareaActiva_.setValueBuffer("iniciocuentaf",ahora.toString());
	this.iface.curTareaActiva_.setValueBuffer("iniciocuentat",ahora.toString().right(8));
	if(!this.iface.curTareaActiva_.commitBuffer())
		return false;

	this.iface.mostrarTareaActiva(idTarea,util.translate("scripts", "PREPARACIÓN EN CURSO"));
	startTimer(1000, this.iface.mostrarTiempo);
	return true;
}

function oficial_playTrab():Boolean
{
	var util:FLUtil = new FLUtil;

	var idTarea:String = this.iface.ledTarea.text;
	if(!idTarea || idTarea == "") {
		idTarea = this.iface.idTareaActiva;
		if(!idTarea || idTarea == "")
			return false;
	}

	var trabajador:String = this.iface.ledTrabajador.text;
	if(!trabajador || trabajador == "")
		return;

	if(util.sqlSelect("pr_tareas","subestado","idtarea = '" + idTarea + "'") == util.translate("scripts", "PREPARACIÓN EN CURSO")) {
		MessageBox.warning(util.translate("scripts", "No se puede comenzar el tiempo de trabajo ya que la tarea %1 se encuentra en tiempo de preparación.").arg(idTarea), MessageBox.Ok,MessageBox.NoButton);
		return false;
	}

	var ahora:Date = new Date();
	var tareaActiva:Number = this.iface.hayUnaTareaActiva();
	var estado:String;
	if(tareaActiva) {
		this.iface.idTareaActiva =  util.sqlSelect("pr_tareastrabajador","idtarea","id = " + tareaActiva);

		delete this.iface.curTareaActiva_;
		if(!this.iface.establecerTareaActiva())
			return false;
		if(idTarea == this.iface.curTareaActiva_.valueBuffer("idtarea")) {
			return false;
		}

		switch(this.iface.curTareaActiva_.valueBuffer("estado")) {
			case util.translate("scripts", "PREPARACIÓN EN CURSO"): {
				if(!this.iface.pausePrep())
					return false;
				break;
			}
			case estadoActivo = util.translate("scripts", "TRABAJO EN CURSO"): {
				if(!this.iface.pauseTrab())
					return false;
				break;
			}
			default: {
				return false;
			}
		}
	}

	if(this.iface.curTareaActiva_)
		delete this.iface.curTareaActiva_;

	this.iface.idTareaActiva = idTarea;
	this.iface.curTareaActiva_ = new FLSqlCursor("pr_tareastrabajador");	
	this.iface.curTareaActiva_.setModeAccess(this.iface.curTareaActiva_.Insert);
	this.iface.curTareaActiva_.refreshBuffer();
	this.iface.curTareaActiva_.setValueBuffer("idtarea", idTarea);
	this.iface.curTareaActiva_.setValueBuffer("idtrabajador", trabajador);
	this.iface.curTareaActiva_.setValueBuffer("estado",util.translate("scripts", "TRABAJO EN CURSO"));
	this.iface.lblSubestado.text = util.translate("scripts", "TRABAJO EN CURSO");
	if(!this.iface.controlTiempoTarea())
		return false;

	this.iface.curTareaActiva_.setValueBuffer("acumuladoprep",0);
	this.iface.curTareaActiva_.setValueBuffer("acumuladotrab",0);
	this.iface.curTareaActiva_.setValueBuffer("activa",true);
	this.iface.curTareaActiva_.setValueBuffer("iniciocuentaf",ahora.toString());
	this.iface.curTareaActiva_.setValueBuffer("iniciocuentat",ahora.toString().right(8));
	if(!this.iface.curTareaActiva_.commitBuffer())
		return false;

	this.iface.mostrarTareaActiva(idTarea,util.translate("scripts", "TRABAJO EN CURSO"));
	startTimer(1000, this.iface.mostrarTiempo);
	return true;
}

function oficial_pausePrep():Boolean
{
	var util:FLUtil = new FLUtil;

	if(!this.iface.curTareaActiva_)
		if(!this.iface.establecerTareaActiva())
			return false;

	var estado:String = this.iface.curTareaActiva_.valueBuffer("estado");
	var idProceso:Number = util.sqlSelect("pr_tareas","idproceso","idtarea = '" + this.iface.idTareaActiva + "'");
	var ahora:Date = new Date();
	switch (estado) {
		case util.translate("scripts", "PREPARACIÓN EN CURSO"): {
			killTimers();
			this.iface.curTareaActiva_.setValueBuffer("estado",util.translate("scripts", "EN PAUSA"));
			this.iface.lblSubestado.text = util.translate("scripts", "EN PAUSA");
			if(!this.iface.controlTiempoTarea())
				return false;
			this.iface.curTareaActiva_.setValueBuffer("activa",false);
			this.iface.curTareaActiva_.setValueBuffer("fincuentaf",ahora.toString());
			this.iface.curTareaActiva_.setValueBuffer("fincuentat",ahora.toString().right(8));
			
			var tiempo:Number = formRecordpr_tareas.iface.pub_calcularTiempo(this.iface.curTareaActiva_);
			this.iface.lblTiempoPreparacion.text = formRecordpr_tareas.iface.pub_formatearTiempo(tiempo);
			var acumuladoTrab:Number = parseInt(this.iface.curTareaActiva_.valueBuffer("acumuladotrab"));
			var acumuladoPrep:Number = parseInt(this.iface.curTareaActiva_.valueBuffer("acumuladoprep")) + tiempo;
			this.iface.curTareaActiva_.setValueBuffer("acumuladoprep", acumuladoPrep);
			var totalAcumulado = parseInt(this.iface.curTareaActiva_.valueBuffer("totalacumulado")) + acumuladoTrab + acumuladoPrep;
			totalAcumulado = flcolaproc.iface.pub_convertirTiempoProceso(totalAcumulado, idProceso);
			this.iface.lblAcumuladoPrep.text =  formRecordpr_tareas.iface.pub_formatearTiempo(parseInt(util.sqlSelect("pr_tareastrabajador","SUM(acumuladoprep)","idtarea = '" + this.iface.curTareaActiva_.valueBuffer("idtarea") + "' AND idtrabajador = '" + this.iface.curTareaActiva_.valueBuffer("idtrabajador") + "'"))+acumuladoPrep);
			this.iface.curTareaActiva_.setValueBuffer("totalacumulado", totalAcumulado);
			
			var id:Number = this.iface.curTareaActiva_.valueBuffer("id");
			if(!this.iface.curTareaActiva_.commitBuffer())
				return false;
			this.iface.curTareaActiva_.select("id = " + id);
			this.iface.curTareaActiva_.first();
			this.iface.curTareaActiva_.setModeAccess(this.iface.curTareaActiva_.Edit);
			this.iface.curTareaActiva_.refreshBuffer();

			break;
		}
		default: {
			break;
		}
	}

	return true;
}

function oficial_pauseTrab():Boolean
{
	var util:FLUtil = new FLUtil;

	if(!this.iface.curTareaActiva_)
		if(!this.iface.establecerTareaActiva())
			return false;

	var estado:String = this.iface.curTareaActiva_.valueBuffer("estado");
	var idProceso:Number = util.sqlSelect("pr_tareas","idproceso","idtarea = '" + this.iface.idTareaActiva + "'");
	var ahora:Date = new Date();
	switch (estado) {
		case util.translate("scripts", "TRABAJO EN CURSO"): {
			killTimers();
			this.iface.curTareaActiva_.setValueBuffer("estado",util.translate("scripts", "EN PAUSA"));
			this.iface.lblSubestado.text = util.translate("scripts", "EN PAUSA");
			if(!this.iface.controlTiempoTarea())
				return false;

			this.iface.curTareaActiva_.setValueBuffer("activa",false);	
			this.iface.curTareaActiva_.setValueBuffer("fincuentaf",ahora.toString());
			this.iface.curTareaActiva_.setValueBuffer("fincuentat",ahora.toString().right(8));

			var tiempo:Number = formRecordpr_tareas.iface.pub_calcularTiempo(this.iface.curTareaActiva_);
			this.iface.lblTiempoTrabajo.text = formRecordpr_tareas.iface.pub_formatearTiempo(tiempo);
			var acumuladoPrep:Number = parseInt(this.iface.curTareaActiva_.valueBuffer("acumuladoprep"));
			var acumuladoTrab:Number = parseInt(this.iface.curTareaActiva_.valueBuffer("acumuladotrab")) + tiempo;
			this.iface.curTareaActiva_.setValueBuffer("acumuladotrab", acumuladoTrab);
			this.iface.lblAcumuladoTrab.text =  formRecordpr_tareas.iface.pub_formatearTiempo(parseInt(util.sqlSelect("pr_tareastrabajador","SUM(acumuladotrab)","idtarea = '" + this.iface.curTareaActiva_.valueBuffer("idtarea") + "' AND idtrabajador = '" + this.iface.curTareaActiva_.valueBuffer("idtrabajador") + "'"))+acumuladoTrab);
			var totalAcumulado = parseInt(this.iface.curTareaActiva_.valueBuffer("totalacumulado")) + acumuladoTrab + acumuladoPrep;
			totalAcumulado = flcolaproc.iface.pub_convertirTiempoProceso(totalAcumulado, idProceso);
			this.iface.curTareaActiva_.setValueBuffer("totalacumulado", totalAcumulado);
			
			var id:Number = this.iface.curTareaActiva_.valueBuffer("id");
			if(!this.iface.curTareaActiva_.commitBuffer())
				return false;

			this.iface.curTareaActiva_.select("id = " + id);
			this.iface.curTareaActiva_.first();
			this.iface.curTareaActiva_.setModeAccess(this.iface.curTareaActiva_.Edit);
			this.iface.curTareaActiva_.refreshBuffer();
			break;
		}
		default: {
			break;
		}
	}

	return true;
}

function oficial_stop():Boolean
{
	if(!this.iface.idTareaActiva || this.iface.idTareaActiva == "")
		return false;

	var curTarea:FLSqlCursor = new FLSqlCursor("pr_tareas");
	curTarea.select("idtarea = '" + this.iface.idTareaActiva + "'");
	curTarea.first();
	curTarea.setModeAccess(curTarea.Edit);
	curTarea.refreshBuffer();

	if(!flcolaproc.iface.pub_terminarTarea(curTarea))
		return false;
	
	delete this.iface.curTareaActiva_;
	this.iface.idTareaActiva == "";

	this.iface.ledTarea.setFocus();
	this.iface.lblTareaActiva.text = "";
	delete this.iface.curTareaActiva_;
	this.iface.idTareaActiva = "";
	this.iface.lblDatosLoteActivo.text = "";
	this.iface.lblTiempoPreparacion.text = "";
	this.iface.lblTiempoTrabajo.text = "";
	this.iface.lblAcumuladoPrep.text = "";
	this.iface.lblAcumuladoTrab.text = "";
	this.iface.lblSubestado.text = "";
	
	this.iface.mostrarTareaSeleccionada();
	
	this.iface.borrarTemporizadores();

	return true;
}

function oficial_borrarTemporizadores()
{
	killTimers();
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
