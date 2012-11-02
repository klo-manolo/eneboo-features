var form = Application.formRecordpr_inbox;
/***************************************************************************
                 pr_terminaltrabajador.qs  -  description
                             -------------------
    begin                : jue oct 16 2008
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
	var lblTiempoPreparacion:Object;
	var lblTiempoTrabajo:Object;
    function oficial( context ) { interna( context ); }
	function mostrarTiempo() {
		return this.ctx.oficial_mostrarTiempo();
	}
	function borrarTemporizadores() {
		return this.ctx.oficial_borrarTemporizadores();
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
	
	this.iface.lblTiempoPreparacion = this.child("lblTiempoPreparacion");
	this.iface.lblTiempoTrabajo = this.child("lblTiempoTrabajo");

	connect (this, "closed()", this, "iface.borrarTemporizadores");

	this.child("fdbidTarea").setDisabled(true);
	this.child("fdbidTrabajador").setDisabled(true);
	this.child("fdbEstado").setDisabled(true);

	this.iface.lblTiempoPreparacion.text = formRecordpr_tareas.iface.pub_formatearTiempo(parseInt(this.cursor().valueBuffer("acumuladoprep")));
	this.iface.lblTiempoTrabajo.text = formRecordpr_tareas.iface.pub_formatearTiempo(parseInt(this.cursor().valueBuffer("acumuladotrab")));

	if(this.cursor().valueBuffer("activa"))
		startTimer(1000, this.iface.mostrarTiempo);
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_mostrarTiempo()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var estado:String = cursor.valueBuffer("estado");
	var tiempo:Number = formRecordpr_tareas.iface.pub_calcularTiempo(cursor);
	switch (estado) {
		case util.translate("scripts", "PREPARACIÓN EN CURSO"): {
			var acumuladoPrep:Number = parseInt(util.sqlSelect("pr_tareastrabajador","SUM(acumuladoprep)","idtarea = '" + cursor.valueBuffer("idtarea") + "' AND idtrabajador = '" +  cursor.valueBuffer("idtrabajador") + "'")) + tiempo;
			this.iface.lblTiempoPreparacion.text = formRecordpr_tareas.iface.pub_formatearTiempo(acumuladoPrep);
			break;
		}
		case util.translate("scripts", "TRABAJO EN CURSO"): {
			var acumuladoTrab:Number = parseInt(util.sqlSelect("pr_tareastrabajador","SUM(acumuladotrab)","idtarea = '" + cursor.valueBuffer("idtarea") + "' AND idtrabajador = '" +  cursor.valueBuffer("idtrabajador") + "'")) + tiempo;
			this.iface.lblTiempoTrabajo.text = formRecordpr_tareas.iface.pub_formatearTiempo(acumuladoTrab);
			break;
		}
	}
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
