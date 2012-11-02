
/** @class_declaration prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN /////////////////////////////////////////////////
class prod extends oficial {
	var xmlNodoBuffer_:FLDomNode;
	var curProceso_:FLSqlCursor;
	var curTareas_:FLSqlCursor;
	var tareaAutomatica:Boolean;
	var tareasOpcionales_:String;
    function prod( context ) { oficial ( context ); }
	function asignarTareas(idProceso:String, idTipoProceso:String):Boolean {
		return this.ctx.prod_asignarTareas(idProceso, idTipoProceso);
	}
	function iniciarTareaEsp(curTareas:FLSqlCursor):Boolean {
		return this.ctx.prod_iniciarTareaEsp(curTareas);
	}
	function subestadoInicialTiemposReales():String {
		return this.ctx.prod_subestadoInicialTiemposReales();
	}
	function deshacerTareaEnCursoEsp(curTareas:FLSqlCursor):Boolean {
		return this.ctx.prod_deshacerTareaEnCursoEsp(curTareas);
	}
	function esTareaProduccion(curTarea:FLSqlCursor):Boolean {
		return this.ctx.prod_esTareaProduccion(curTarea);
	}
	function valoresDefectoFiltroS() {
		return this.ctx.prod_valoresDefectoFiltroS();
	}
	function terminarProcesoEsp(curProceso:FLSqlCursor):Boolean {
		return this.ctx.prod_terminarProcesoEsp(curProceso);
	}
// 	function crearProceso(tipoProceso:String, tipoObjeto:String, idObjeto:String):Number {
// 		return this.ctx.prod_crearProceso(tipoProceso, tipoObjeto, idObjeto);
// 	}
	function loteCreado(curProceso:FLSqlCursor):Boolean {
		return this.ctx.prod_loteCreado(curProceso);
	}
	function deshacerProcesoTerminadoEsp(idProceso:String):Boolean {
		return this.ctx.prod_deshacerProcesoTerminadoEsp(idProceso);
	}
	function formatearCodigo( lineEdit:Object, longCodigo:Number, posPuntoActual:Number ):Number {
		return this.ctx.prod_formatearCodigo( lineEdit, longCodigo, posPuntoActual);
	}
	function comprobarStockConsumo(curMoviStock:FLSqlCursor):Boolean {
		return this.ctx.prod_comprobarStockConsumo(curMoviStock);
	}
	function terminarTareaEsp(curTareas:FLSqlCursor):Boolean {
		return this.ctx.prod_terminarTareaEsp(curTareas);
	}
	function afterCommit_pr_procesos(curProceso:FLSqlCursor):Boolean {
		return this.ctx.prod_afterCommit_pr_procesos(curProceso);
	}
	function tareasNoSaltadas(idTareasIniciales:Array, idTipoTareaPro:String, tipoProceso:String, idProceso:String, xmlProceso:FLDomNode):Boolean {
		return this.ctx.prod_tareasNoSaltadas(idTareasIniciales, idTipoTareaPro, tipoProceso, idProceso, xmlProceso);
	}
	function activarSiguientesTareas(curTareas:FLSqlCursor):Boolean {
		return this.ctx.prod_activarSiguientesTareas(curTareas);
	}
// 	function dameXMLProceso(idProceso:String):FLDomNode {
// 		return this.ctx.prod_dameXMLProceso(idProceso);
// 	}
	function desactivarSiguientesTareas(curTareas:FLSqlCursor):Boolean {
		return this.ctx.prod_desactivarSiguientesTareas(curTareas);
	}
	function activarProcesoProd(idProceso:String,mostrarProgreso:Boolean):Boolean {
		return this.ctx.prod_activarProcesoProd(idProceso,mostrarProgreso);
	}
	function esProcesoFabricacion(idTipoProceso:String):Boolean {
		return this.ctx.prod_esProcesoFabricacion(idTipoProceso);
	}
	function cambiarEstadoObjeto(idProceso:Number, estadoObjeto:String):Boolean {
		return this.ctx.prod_cambiarEstadoObjeto(idProceso, estadoObjeto);
	}
	function beforeCommit_pr_procesos(curProceso:FLSqlCursor):Boolean {
		return this.ctx.prod_beforeCommit_pr_procesos(curProceso);
	}
	function crearProcesoProd(referencia:String, codLote:String, idLineaPedidoCli:String):Number {
		return this.ctx.prod_crearProcesoProd(referencia, codLote, idLineaPedidoCli);
	}
	function crearXMLTareasOpcionales(curLote:FLSqlCursor, xmlParametros:FLDomNode):Boolean {
		return this.ctx.prod_crearXMLTareasOpcionales(curLote, xmlParametros);
	}
	function crearXMLProcesoProd(curProceso:FLSqlCursor):FLDomDocument {
		return this.ctx.prod_crearXMLProcesoProd(curProceso);
	}
	function crearXMLParametrosProceso(curLote:FLSqlCursor, xmlParametros:FLDomNode):Boolean {
		return this.ctx.prod_crearXMLParametrosProceso(curLote, xmlParametros);
	}
	function crearXMLTipoProceso(idTipoProceso:String,refArticulo:String,restricciones:Array):Boolean {
		return this.ctx.prod_crearXMLTipoProceso(idTipoProceso,refArticulo,restricciones);
	}
	function selectTareasOpcionales(idTipoProceso:String,whereTareas:String):Boolean {
		return this.ctx.prod_selectTareasOpcionales(idTipoProceso,whereTareas);
	}
	function parametrosProceso(curProceso:FLSqlCursor):String {
		return this.ctx.prod_parametrosProceso(curProceso);
	}
	function pasarOFFProcesoProd(idProceso:String):Boolean {
		return this.ctx.prod_pasarOFFProcesoProd(idProceso);
	}
	function crearTareasOFF(curProceso:FLSqlCursor):Boolean {
		return this.ctx.prod_crearTareasOFF(curProceso);
	}
	function datosTareaOFF(curTipoTareaPro:FLSqlCursor, xmlTarea:FLDomNode):Boolean {
		return this.ctx.prod_datosTareaOFF(curTipoTareaPro, xmlTarea);
	}
	function pasarOFFTareaProd() {
		return this.ctx.prod_pasarOFFTareaProd();
	}
	function borrarProcesoProd(idProceso:Number,codLote:String):Boolean {
		return this.ctx.prod_borrarProcesoProd(idProceso,codLote);
	}
	function datosProcesoOFF(referencia:String, codLote:String, idLineaPedidoCli:String):Boolean {
		return this.ctx.prod_datosProcesoOFF(referencia, codLote, idLineaPedidoCli);
	}
	function iniciarTarea(curTareas:FLSqlCursor, idUser:String, ignorarEstadistica:Boolean) {
		return this.ctx.prod_iniciarTarea(curTareas, idUser, ignorarEstadistica);
	}
	function deshacerTareaEnCurso(curTareas:FLSqlCursor):Boolean {
		return this.ctx.prod_deshacerTareaEnCurso(curTareas);
	}
	function calcularTiempoInvertido(curTareas:FLSqlCursor):Number {
		return this.ctx.prod_calcularTiempoInvertido(curTareas);
	}
	function calcularTiempoTrabajadores(curTareas:FLSqlCursor):Number {
		return this.ctx.prod_calcularTiempoTrabajadores(curTareas);
	}
	function deshacerTareaTerminada(curTareas:FLSqlCursor):Boolean {
		return this.ctx.prod_deshacerTareaTerminada(curTareas);
	}
	function terminarTareasActivas(idTarea:String,estado:String):Boolean {
		return this.ctx.prod_terminarTareasActivas(idTarea,estado);
	}
	function setTareaAutomatica(automatica:Boolean) {
		return this.ctx.prod_setTareaAutomatica(automatica);
	}
	function esTareaAutomatica():Boolean {
		return this.ctx.prod_esTareaAutomatica();
	}
	function seguimientoOn(container:Object, datosS:Array):Boolean {
		return this.ctx.prod_seguimientoOn(container, datosS);
	}
	function calcularTiemposFinalizacionTarea(curTareas:FLSqlCursor,fechaFin:Date):Boolean {
		return this.ctx.prod_calcularTiemposFinalizacionTarea(curTareas,fechaFin);
	}
	function crearXMLTareasTipoProceso(idTipoProceso:String,whereTareas:String):String {
		return this.ctx.prod_crearXMLTareasTipoProceso(idTipoProceso,whereTareas);
	}
	function crearXMLComponentesTipoProceso(idTipoProceso:String,refArticulo:String,whereTareas:String,whereComponentes:String):String {
		return this.ctx.prod_crearXMLComponentesTipoProceso(idTipoProceso,refArticulo,whereTareas,whereComponentes);
	}
	function comprobarXmlOpciones(codLote:String):Boolean {
		return this.ctx.prod_comprobarXmlOpciones(codLote);
	}
	function obtenerOpcionLote(codLote:String, idTipoOpcion:String):String {
		return this.ctx.prod_obtenerOpcionLote(codLote, idTipoOpcion);
	}
// 	function iniciarTareaEsp(curTareas:FLSqlCursor):Boolean {
// 		return this.ctx.prod_iniciarTareaEsp(curTareas);
// 	}
}
//// PRODUCCIÓN /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubProd */
/////////////////////////////////////////////////////////////////
//// PUB_PRODUCCION /////////////////////////////////////////////
class pubProd extends ifaceCtx {
	function pubProd( context ) { ifaceCtx( context ); }
	function pub_formatearCodigo( lineEdit:Object, longCodigo:Number, posPuntoActual:Number ):Number {
		return this.formatearCodigo( lineEdit, longCodigo, posPuntoActual);
	}
	function pub_tbnDeshacerTareaSClicked():Boolean {
		return this.tbnDeshacerTareaSClicked();
	}
	function pub_activarProcesoProd(idProceso:String,mostrarProgreso:Boolean):Boolean {
		return this.activarProcesoProd(idProceso,mostrarProgreso);
	}
	function pub_esProcesoFabricacion(idTipoProceso:String):Boolean {
		return this.esProcesoFabricacion(idTipoProceso);
	}
	function pub_crearProcesoProd(idTipoProceso:String, codLote:String, idLineaPedidoCli:String):Number {
		return this.crearProcesoProd(idTipoProceso, codLote, idLineaPedidoCli);
	}
	function pub_pasarOFFProcesoProd(idProceso:String):Boolean {
		return this.pasarOFFProcesoProd(idProceso);
	}
	function pub_borrarProcesoProd(idProceso:Number,codLote:String):Boolean {
		return this.borrarProcesoProd(idProceso,codLote);
	}
	function pub_terminarTareasActivas(idTarea:String,estado:String):Boolean {
		return this.terminarTareasActivas(idTarea,estado);
	}
	function pub_setTareaAutomatica(automatica:Boolean) {
		return this.setTareaAutomatica(automatica);
	}
	function pub_esTareaAutomatica():Boolean {
		return this.esTareaAutomatica();
	}
	function pub_calcularIdTarea():String {
		return this.calcularIdTarea();
	}
	function pub_descripcionTarea(curTarea:FLSqlCursor):String {
		return this.descripcionTarea(curTarea);
	}
	function pub_dameXMLProceso(idProceso:String):FLDomNode {
		return this.dameXMLProceso(idProceso);
	}
	function pub_crearXMLTipoProceso(idTipoProceso:String,refArticulo:String,restricciones:Array):Boolean {
		return this.crearXMLTipoProceso(idTipoProceso,refArticulo,restricciones);
	}
}
//// PUB_PRODUCCION /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN /////////////////////////////////////////////////
/** \D Para los procesos de fabricación (los asignados a un artículo), la asignación de tareas no se realiza o se realiza automáticamente
@param	idProceso: Identificador del proceso
@param	idTipoProceso: Identificador del tipo de proceso
@return	true si no hay error, false en caso contrario
\end */
function prod_asignarTareas(idProceso:String, idTipoProceso:String):Boolean
{
	var util:FLUtil = new FLUtil;
	if (!util.sqlSelect("articulos", "referencia", "idtipoproceso = '" + idTipoProceso + "'"))
		return this.iface.__asignarTareas(idProceso, idTipoProceso);

	return true;
}

/** \D Al iniciarse una tarea de producción se restarán del stock los artículos consumidos en la misma
\end */
function prod_iniciarTareaEsp(curTareas:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	if (!this.iface.esTareaProduccion(curTareas)) {
		return this.iface.__iniciarTareaEsp(curTareas);
	}

	var codLote:String = util.sqlSelect("pr_procesos", "idobjeto", "idproceso = " + curTareas.valueBuffer("idproceso"));
	if (!codLote) {
		MessageBox.warning(util.translate("scripts", "Error al obtener el código de lote correspondiente a la tarea %1").arg(curTareas.valueBuffer("idtarea")), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	var hoy:Date = new Date();
	var curMoviStock:FLSqlCursor = new FLSqlCursor("movistock");
	curMoviStock.select("codloteprod = '" + codLote + "' AND idtipotareapro = " + curTareas.valueBuffer("idtipotareapro"));
	while (curMoviStock.next()) {
		curMoviStock.setModeAccess(curMoviStock.Edit);
		curMoviStock.refreshBuffer();

		if (!this.iface.comprobarStockConsumo(curMoviStock))
			return false;

		curMoviStock.setValueBuffer("estado", "HECHO");
		curMoviStock.setValueBuffer("fechareal", hoy.toString());
		curMoviStock.setValueBuffer("horareal", hoy.toString().right(8));
		curMoviStock.setValueBuffer("idtarea", curTareas.valueBuffer("idtarea"));
		if (!curMoviStock.commitBuffer())
			return false;
	}
	return true;
}

/** \C Al iniciarse una tarea se restan del stock los artículos consumidos en la misma. Antes de hacer esto se verifica si hay stock suficiente y se avisa al usuario en caso de que no lo haya
@param curMoviStock: Cursor posicionado en el movimiento que va a pasar de PTE a HECHO
\end */
function prod_comprobarStockConsumo(curMoviStock:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	var referencia:String = curMoviStock.valueBuffer("referencia");
	var codLote:String = curMoviStock.valueBuffer("codlote");
	if (codLote && codLote != "") {
		var estadoLoteConsumo:String = util.sqlSelect("lotesstock", "estado", "codlote = '" + codLote + "'");
		if (estadoLoteConsumo != "TERMINADO") {
			MessageBox.warning(util.translate("scripts", "No puede completarse el consumo del componente %1.\nEl lote asociado al consumo (%2) debe estar en estado TERMINADO.").arg(referencia).arg(codLote), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
	} else {
		var controlStock:Boolean = util.sqlSelect("articulos", "controlstock", "referencia = '" + referencia + "'");
		if (controlStock)
			return true;

		var tipoStock:Boolean = util.sqlSelect("articulos", "tipostock", "referencia = '" + referencia + "'");
		if (tipoStock == "Sin stock")
			return true;

		var cantidadEnStock:Number = parseFloat(util.sqlSelect("stocks", "cantidad", "idstock = " + curMoviStock.valueBuffer("idstock")));
		if (!cantidadEnStock || isNaN(cantidadEnStock))
			cantidadEnStock = 0;

		var nuevaCantidad = cantidadEnStock + parseFloat(curMoviStock.valueBuffer("cantidad"));
		if (nuevaCantidad < 0) {
			var codAlmacen:String = util.sqlSelect("stocks", "codalmacen", "idstock = " + curMoviStock.valueBuffer("idstock"));
			var res:Number = MessageBox.warning(util.translate("scripts", "El consumo del componente %1 va a provocar un stock negativo (%2) en el almacén %3.\n¿Desea continuar?").arg(referencia).arg(nuevaCantidad).arg(codAlmacen), MessageBox.No, MessageBox.Yes);
			if (res != MessageBox.Yes)
				return false;
		}
	}

	return true;
}

/** \D Al deshacerse una tarea de producción (paso a PTE) se sumarán del stock los artículos consumidos en la misma
\end */
function prod_deshacerTareaEnCursoEsp(curTareas:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	if (!this.iface.esTareaProduccion(curTareas)) {
		return this.iface.__deshacerTareaEnCursoEsp(curTareas);
	}

	var codLote:String = util.sqlSelect("pr_procesos", "idobjeto", "idproceso = " + curTareas.valueBuffer("idproceso"));
	if (!codLote) {
		MessageBox.warning(util.translate("scripts", "Error al obtener el código de lote correspondiente a la tarea %1").arg(curTareas.valueBuffer("idtarea")), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	var hoy:Date = new Date();
	var curMoviStock:FLSqlCursor = new FLSqlCursor("movistock");
	curMoviStock.select("codloteprod = '" + codLote + "' AND idtipotareapro = " + curTareas.valueBuffer("idtipotareapro"));
	while (curMoviStock.next()) {
		curMoviStock.setModeAccess(curMoviStock.Edit);
		curMoviStock.refreshBuffer();
		curMoviStock.setValueBuffer("estado", "PTE");
		curMoviStock.setNull("idtarea");
		curMoviStock.setNull("fechareal");
		curMoviStock.setNull("horareal");
		if (!curMoviStock.commitBuffer())
			return false;
	}
	return true;
}

function prod_esTareaProduccion(curTarea:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	if (curTarea.valueBuffer("tipoobjeto") == "lotesstock")
		return true;

	return false;
}

function prod_valoresDefectoFiltroS()
{
	if (!this.iface.container_)
		return this.iface.__valoresDefectoFiltroS();

	if (!this.iface.container_.cursor())
		return this.iface.__valoresDefectoFiltroS();

	var accionContenedor:String = this.iface.container_.cursor().action();
	switch (accionContenedor) {
		case "pr_terminal": {
			if (this.iface.chkTodasS)
				this.iface.chkTodasS.checked = true;
			if (this.iface.chkPteS)
				this.iface.chkPteS.checked = true;
			if (this.iface.chkEnCursoS)
				this.iface.chkEnCursoS.checked = true;
			break;
		}
		default: {
			this.iface.__valoresDefectoFiltroS();
		}
	}
}

/** \D Pone el lote como HECHO y genera el movimiento de stock positivo asociado
\end */
function prod_terminarProcesoEsp(curProceso:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	var idTipoProceso:String = curProceso.valueBuffer("idtipoproceso");
	var tipoObjeto:String = util.sqlSelect("pr_tiposproceso", "tipoobjeto", "idtipoproceso = '" + idTipoProceso + "'");

	switch (tipoObjeto) {
		case "lotesstock": {
			if (!this.iface.__terminarProcesoEsp(curProceso)) {
				return false;
			}

			if (this.iface.esProcesoFabricacion(idTipoProceso)) {
				if (!this.iface.loteCreado(curProceso)) {
					return false;
				}
			}
			break;
		}
		default: {
			if (!this.iface.__terminarProcesoEsp(curProceso)) {
				return false;
			}
			break;
		}
	}
	return true;
}

function prod_loteCreado(curProceso:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	var idProceso:String = curProceso.valueBuffer("idproceso");
	var fecha:Date = new Date;

	var curMoviStock:FLSqlCursor = new FLSqlCursor("movistock");
	curMoviStock.select("idproceso = " + idProceso + " AND estado = 'PTE'");
	while (curMoviStock.next()) {
		curMoviStock.setModeAccess(curMoviStock.Edit);
		curMoviStock.refreshBuffer();
		curMoviStock.setValueBuffer("estado", "HECHO");
		curMoviStock.setValueBuffer("fechareal", fecha);
		curMoviStock.setValueBuffer("horareal", fecha.toString().right(8));
		if (!curMoviStock.commitBuffer()) {
			return false;
		}
	}
	/// Todos los lotes producidos deben estar TERMINADOs para que puedan usarse como material base de otros procesos de producción
	if (!this.iface.cambiarEstadoObjeto(curProceso.valueBuffer("idproceso"), "TERMINADO")) {
		return false;
	}

	return true;
}

function prod_tareasNoSaltadas(idTareasIniciales:Array, idTipoTareaPro:String, tipoProceso:String, idProceso:String, xmlProceso:FLDomNode):Boolean
{
	var util:FLUtil = new FLUtil();

	var xmlTarea:FLDomNode = false;
// debug(idTipoTareaPro);
	if (xmlProceso) {
// debug("hay proceso");
// var d:FLDomDocument = new FLDomDocument;
// d.appendChild(xmlProceso.cloneNode());
// debug(d.toString(4));
		xmlTarea = flprodppal.iface.pub_dameNodoXML(xmlProceso, "Tareas/Tarea[@IdTipoTareaPro=" + idTipoTareaPro + "]");
	}
	var saltada:Boolean = false;
	if (xmlTarea) {
		if (xmlTarea.toElement().attribute("Estado") == "Saltada") {
			saltada = true;
		}
	} else {
		return true;
	}

	if (!saltada) {
// 		idTareasIniciales[idTareasIniciales.length] = util.sqlSelect("pr_tareas", "idtarea", "idproceso = '" + idProceso + "' AND idtipotareapro = " + idTipoTareaPro);
		idTareasIniciales[idTareasIniciales.length] = idTipoTareaPro;
		return true;
	} else {
		var qrySiguientes:FLSqlQuery = new FLSqlQuery;
		with (qrySiguientes) {
			setTablesList("pr_secuencias");
			setSelect("tareafin");
			setFrom("pr_secuencias");
			setWhere("idtipoproceso = '" + tipoProceso + "' AND tareainicio = " + idTipoTareaPro);
			setForwardOnly(true);
		}
		if (!qrySiguientes.exec()) {
			return false;
		}

		while (qrySiguientes.next()) {
			if (!this.iface.tareasNoSaltadas(idTareasIniciales, qrySiguientes.value("tareafin"), tipoProceso, idProceso, xmlProceso)) {
				return false;
			}
		}
	}
	return true;
}


function prod_deshacerProcesoTerminadoEsp(idProceso:String):Boolean
{
	var util:FLUtil = new FLUtil;

	if (!this.iface.__deshacerProcesoTerminadoEsp(idProceso))
		return false;

	if (util.sqlSelect("pr_procesos p INNER JOIN pr_tiposproceso tp ON p.idtipoproceso = tp.idtipoproceso", "tp.fabricacion", "idproceso = " + idProceso, "pr_procesos,pr_tiposproceso")) {
		if (!util.sqlUpdate("movistock", "estado,fechareal,horareal", "PTE,NULL,NULL", "idproceso = " + idProceso)) {
			return false;
		}
	}

	return true;
}

/** \D
Reformatea el valor de un código reemplazando el carácter ".", si es que existe, por los ceros "0" necesarios
hasta completar el número de dígitos total, a su vez elimina los caracteres sobrantes cuando se supere el límite de dígitos.

@param lineEdit: Objeto linea de edición en el que se muestra el código formateado
@param longCodigo: Longitud máxima del código
@param posPuntoActual: Posición del punto en el valor actual del código

@return Nueva posición del punto en el valor actual del código
\end */
function prod_formatearCodigo( lineEdit:Object, longCodigo:Number, posPuntoActual:Number ):Number
{debug("prod_formatearCodigo " + lineEdit + " - " + longCodigo + " + " + posPuntoActual);
	var cambiado:Boolean = false;
	var valCodigo:String = lineEdit.text;
	var lenValCodigo:Number = valCodigo.length;
	var nuevoPunto:Number = valCodigo.find( "." );

	if ( nuevoPunto < 0 && lenValCodigo > longCodigo ) {
		// En caso de superar el nº de dígitos, se eliminarán los ceros insertados por el "."
		if ( posPuntoActual >= 0 ) {
			if ( valCodigo.mid( posPuntoActual, 1 ) == "0" )
				// Sólo en caso de que sigan existiendo "0" insertados
				valCodigo = valCodigo.left( posPuntoActual ) + valCodigo.right( longCodigo - posPuntoActual);
		}
		if ( valCodigo.length > longCodigo ) {
			// Pero si ya se eliminaron los "0" insertados, se elimina el último dígito tecleado.
			valCodigo = valCodigo.left( longCodigo );
		}
		cambiado = true;
	}
	if ( nuevoPunto > -1 && posPuntoActual > -1 ) {
		// El punto pulsado por segunda vez debe sustituir al anterior
		posPuntoActual = -1;
	}

	if (posPuntoActual == -1)
		posPuntoActual = nuevoPunto;
	if (nuevoPunto > -1) {
		var numCeros = longCodigo - ( valCodigo.length - 1 );
		var strCeros = "";
		for ( var i = 0; i < numCeros; i++ )
			strCeros += "0";
		valCodigo = valCodigo.replace( ".", strCeros );
		cambiado = true;
	}
	if (cambiado) {
		lineEdit.text = valCodigo ;
	}
	return posPuntoActual;
}

function prod_terminarTareaEsp(curTareas:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	var idTarea:String = curTareas.valueBuffer("idtarea");
	if (!idTarea) {
		return false;
	}

	if (!this.iface.terminarTareasActivas(idTarea)) {
		return false;
	}

	if (util.sqlSelect("pr_tipostareapro", "verificarconsumos", "idtipotareapro = " + curTareas.valueBuffer("idtipotareapro"))) {
// 		if(util.sqlSelect("movistock","idmovimiento","idtarea = '" + idTarea + "'")) {
			var f:Object = new FLFormSearchDB("pr_verificarconsumos");
			var curVC:FLSqlCursor = f.cursor();

			curVC.select("idtarea = '" + idTarea + "'");
			if (!curVC.first()) {
				return false;
			}

			f.setMainWidget();
			f.exec("idtarea");
			var ok:Boolean = f.accepted();
			if (!ok) {
				return false;
			}
// 		}
	}
	return true;
}

function prod_terminarTareasActivas(idTarea:String,estado:String):Boolean
{
	var util:FLUtil;
	var curTareasTrab:FLSqlCursor = new FLSqlCursor("pr_tareastrabajador");
	curTareasTrab.select("idtarea = '" + idTarea + "' AND activa");
	var idProceso:Number = util.sqlSelect("pr_tareas","idproceso","idtarea = '" + idTarea + "'");
	if (!idProceso) {
		return false;
	}

	var ahora:Date = new Date();
	while (curTareasTrab.next()) {
		curTareasTrab.setModeAccess(curTareasTrab.Edit);
		curTareasTrab.refreshBuffer();
		if(!estado || estado == "")
			estado = curTareasTrab.valueBuffer("estado");
		switch(estado) {
			case util.translate("scripts", "PREPARACIÓN EN CURSO"): {
				curTareasTrab.setValueBuffer("estado","EN PAUSA");
				curTareasTrab.setValueBuffer("activa",false);
				curTareasTrab.setValueBuffer("fincuentaf",ahora.toString());
				curTareasTrab.setValueBuffer("fincuentat",ahora.toString().right(8));
				var tiempo:Number = formRecordpr_tareas.iface.pub_calcularTiempo(curTareasTrab);
				var acumuladoTrab:Number = parseInt(curTareasTrab.valueBuffer("acumuladotrab"))
				var acumuladoPrep:Number = parseInt(curTareasTrab.valueBuffer("acumuladoprep")) + tiempo;
				curTareasTrab.setValueBuffer("acumuladoprep", acumuladoPrep);
				var totalAcumulado = parseInt(curTareasTrab.valueBuffer("totalacumulado")) + acumuladoTrab + acumuladoPrep;
				totalAcumulado = this.iface.convertirTiempoProceso(totalAcumulado, idProceso);
				curTareasTrab.setValueBuffer("totalacumulado", totalAcumulado);
				if (!curTareasTrab.commitBuffer()) {
					return false;
				}
				break;
			}
			case util.translate("scripts", "TRABAJO EN CURSO"): {
				curTareasTrab.setValueBuffer("estado","EN PAUSA");
				curTareasTrab.setValueBuffer("activa",false);
				curTareasTrab.setValueBuffer("fincuentaf",ahora.toString());
				curTareasTrab.setValueBuffer("fincuentat",ahora.toString().right(8));
				var tiempo:Number = formRecordpr_tareas.iface.pub_calcularTiempo(curTareasTrab);
				var acumuladoPrep:Number = parseInt(curTareasTrab.valueBuffer("acumuladoprep"))
				var acumuladoTrab:Number = parseInt(curTareasTrab.valueBuffer("acumuladotrab")) + tiempo;
				curTareasTrab.setValueBuffer("acumuladotrab", acumuladoPrep);
				var totalAcumulado = parseInt(curTareasTrab.valueBuffer("totalacumulado")) + acumuladoTrab + acumuladoPrep;
				totalAcumulado = this.iface.convertirTiempoProceso(totalAcumulado, idProceso);
				curTareasTrab.setValueBuffer("totalacumulado", totalAcumulado);
				if(!curTareasTrab.commitBuffer())
					return false;
				break;
			}
		}
	}
	return true;
}

/** \C Si el proceso cambia de estado se revisa el estado de la correspondiente orden de producción
\end */
function prod_afterCommit_pr_procesos(curProceso:FLSqlCursor):Boolean
{
// 	if (!this.iface.__afterCommit_pr_procesos(curProceso))
// 		return false;

	var util:FLUtil = new FLUtil;

	switch (curProceso.modeAccess()) {
		case curProceso.Edit: {
			if (curProceso.valueBuffer("estado") != curProceso.valueBufferCopy("estado")) {
				var codOrdenProduccion:String = curProceso.valueBuffer("codordenproduccion");
				if (codOrdenProduccion && codOrdenProduccion != "") {
					if (!flprodppal.iface.pub_modificarEstadoOrden(codOrdenProduccion)) {
						return false;
					}
				}
			}
		}
	}
	return true;
}

/** \C Si el proceso se borra se borra la composición asociada para su lote
\end */
function prod_beforeCommit_pr_procesos(curProceso:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	if (!util.sqlSelect("pr_tiposproceso", "fabricacion", "idtipoproceso = '" + curProceso.valueBuffer("idtipoproceso") + "'")) {
		return true;
	}

	switch (curProceso.modeAccess()) {
		case curProceso.Del: {
			if (curProceso.valueBuffer("estado") != "OFF") {
				MessageBox.warning(util.translate("scripts", "Error al borrar el proceso de producción %1: El proceso no está en estado OFF").arg(curProceso.valueBuffer("idproceso")), MessageBox.Ok, MessageBox.NoButton);
				return false;
			}
		}
	}
	return true;
}


/** \D Activa las tareas siguientes a una determinada tarea, según las secuencias en las que dicha tarea es la tarea inicial
\param	curTareas: Cursor con las tarea inicial
\end */
function prod_activarSiguientesTareas(curTareas:FLSqlCursor):Boolean
{
// debug("prod_activarSiguientesTareas");
	var tipoObjeto:String = curTareas.valueBuffer("tipoobjeto");
	if (tipoObjeto != "lotesstock") {
		return this.iface.__activarSiguientesTareas(curTareas);
	}

	var util:FLUtil = new FLUtil;
	var idTipoTareaPro:String = curTareas.valueBuffer("idtipotareapro");
	var idProceso:String = curTareas.valueBuffer("idproceso");
	var tipoProceso:String = util.sqlSelect("pr_procesos", "idtipoproceso", "idproceso = " + idProceso);
	var idObjeto:String = curTareas.valueBuffer("idobjeto");

	var xmlProceso:FLDomNode = this.iface.dameXMLProceso(idProceso);
/*if (xmlProceso) {
debug("prod_activarSiguientesTareas SI");
} else {
debug("prod_activarSiguientesTareas NO");
}*/
	var qrySiguienteTarea:FLSqlQuery = new FLSqlQuery();
	with (qrySiguienteTarea) {
		setTablesList("pr_tipostareapro,pr_secuencias");
		setSelect("s.tareafin");
		setFrom("pr_tipostareapro tt INNER JOIN pr_secuencias s ON tt.idtipotareapro = s.tareainicio");
		setWhere("tt.idtipotareapro = " + idTipoTareaPro);
	}
	if (!qrySiguienteTarea.exec()) {
		return false;
	}

	var siguienteTarea:String;
	var idTareasiniciales:Array;
	while (qrySiguienteTarea.next()) {
		siguienteTarea = qrySiguienteTarea.value("s.tareafin");

		idTareasIniciales = [];
		if (!this.iface.tareasNoSaltadas(idTareasIniciales, siguienteTarea, tipoProceso, idProceso, xmlProceso)) {
			return false;
		}
		for (var i:Number = 0; i < idTareasIniciales.length; i++) {
			if (!this.iface.activarTarea(curTareas, idTareasIniciales[i])) {
				return false;
			}
		}
	}

	if (!util.sqlSelect("pr_tareas", "idtarea", "idproceso = " + idProceso + " AND estado <> 'TERMINADA'")) {
		if (!this.iface.terminarProceso(idProceso)) {
			return false;
		}
	}

	return true;
}

function prod_desactivarSiguientesTareas(curTareas:FLSqlCursor):Boolean
{
	var tipoObjeto:String = curTareas.valueBuffer("tipoobjeto");
	if (tipoObjeto != "lotesstock") {
		return this.iface.__desactivarSiguientesTareas(curTareas);
	}

	var util:FLUtil = new FLUtil();
	var idTipoTareaPro:String = curTareas.valueBuffer("idtipotareapro");
	var idProceso:String = curTareas.valueBuffer("idproceso");
	var tipoProceso:String = util.sqlSelect("pr_procesos", "idtipoproceso", "idproceso = " + idProceso);
	var idObjeto:String = curTareas.valueBuffer("idobjeto");
	var numCiclo:String = curTareas.valueBuffer("numciclo");

	var xmlProceso:FLDomNode = this.iface.dameXMLProceso(idProceso);

	var qrySiguienteTarea:FLSqlQuery = new FLSqlQuery();
	with (qrySiguienteTarea) {
		setTablesList("pr_tipostareapro,pr_secuencias");
		setSelect("s.tareafin");
		setFrom("pr_tipostareapro tt INNER JOIN pr_secuencias s ON tt.idtipotareapro = s.tareainicio");
		setWhere("tt.idtipotareapro = " + idTipoTareaPro);
	}
	if (!qrySiguienteTarea.exec()) {
		return false;
	}

	if (qrySiguienteTarea.size() == 0) {
		if (!this.iface.deshacerProcesoTerminado(idProceso)) {
			return false;
		}
	}
	var idTareaSiguiente:String = "";
	var idTareasiniciales:Array;

	while (qrySiguienteTarea.next()) {
		idTareaSiguiente = qrySiguienteTarea.value("s.tareafin");
		idTareasIniciales = [];
		if (!this.iface.tareasNoSaltadas(idTareasIniciales, idTareaSiguiente, tipoProceso, idProceso, xmlProceso)) {
			return false;
		}
		for (var i:Number = 0; i < idTareasIniciales.length; i++) {
			if (util.sqlSelect("pr_tareas", "estado", "idtipotareapro = " + idTareasIniciales[i] + " AND numciclo = " + numCiclo + " AND idproceso = " + idProceso) != "PTE") {
				MessageBox.warning(util.translate("scripts", "La tarea a deshacer debe tener todas sus tareas subsiguientes en estado OFF o PTE"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				return false;
			}
			if (!util.sqlUpdate("pr_tareas", "estado", "OFF", "idtipotareapro = " + idTareasIniciales[i] + " AND numciclo = " + numCiclo + " AND idproceso = " + idProceso)) {
				return false;
			}
		}
	}

	return true;
}

/** \D Activa (pone en estado PTE) un proceso de producción
@param	idProceso: Identificador del proceso
\end */
function prod_activarProcesoProd(idProceso:String,mostrarProgreso:Boolean):Boolean
{
	var util:FLUtil = new FLUtil;

	var curProceso:FLSqlCursor = new FLSqlCursor("pr_procesos");
	curProceso.select("idproceso = " + idProceso);
	if (!curProceso.first()) {
		MessageBox.warning(util.translate("scripts", "Error al activar el proceso %1: El proceso no existe").arg(idProceso), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	if (curProceso.valueBuffer("estado") != "OFF") {
		MessageBox.warning(util.translate("scripts", "Error al activar el proceso %1: El proceso no está en estado OFF").arg(idProceso), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	var idTipoProceso:String = curProceso.valueBuffer("idtipoproceso");
	var codLote:String = curProceso.valueBuffer("idobjeto");
	with (curProceso) {
		setModeAccess(curProceso.Edit);
		refreshBuffer();
		setValueBuffer("estado", "PTE");
	}
	if (!curProceso.commitBuffer()) {
		return false;
	}

	var xmlProceso:FLDomNode = this.iface.dameXMLProceso(idProceso);

// 	var qryTiposTarea:FLSqlQuery = new FLSqlQuery();
// 	with (qryTiposTarea) {
// 		setTablesList("pr_tipostareapro");
// 		setSelect("idtipotarea, idtipotareapro");
// 		setFrom("pr_tipostareapro");
// 		setWhere("idtipoproceso = '" + idTipoProceso + "' ORDER BY ordenlista");
// 	}
// 	if (!qryTiposTarea.exec())
// 		return false;

// 	var curTarea:FLSqlCursor = new FLSqlCursor("pr_tareas");
// 	var xmlTarea:FLDomNode;
// 	var idTipoTareaPro:String;
// 	while (qryTiposTarea.next()) {
// 		idTipoTareaPro = qryTiposTarea.value("idtipotareapro");
// debug("creando tarea " + idTipoTareaPro);
// 		if (xmlProceso) {
// debug("hay proceso");
// 			xmlTarea = flprodppal.iface.pub_dameNodoXML(xmlProceso, "Tareas/Tarea[@IdTipoTareaPro=" + idTipoTareaPro + "]");
// 			if (xmlTarea && xmlTarea.toElement().attribute("Estado") == "Saltada") {
// debug("hay tarea, saltando");
// 				continue;
// 			}
// 		}
// 		curTarea.setModeAccess(curTarea.Insert);
// 		curTarea.refreshBuffer();
// 		curTarea.setValueBuffer("idtarea", this.iface.calcularIdTarea());
// 		curTarea.setValueBuffer("idproceso", idProceso);
// 		curTarea.setValueBuffer("estado", "OFF");
// 		curTarea.setValueBuffer("idtipotarea", qryTiposTarea.value("idtipotarea"));
// 		curTarea.setValueBuffer("idtipotareapro", idTipoTareaPro);
// 		curTarea.setValueBuffer("tipoobjeto", "lotesstock");
// 		curTarea.setValueBuffer("idobjeto", codLote);
// 		curTarea.setValueBuffer("descripcion", this.iface.descripcionTarea(curTarea));
//
// 		if (!curTarea.commitBuffer())
// 			return false;
// 	}

	var qryTareasIniciales:FLSqlQuery = new FLSqlQuery;
	with (qryTareasIniciales) {
		setTablesList("pr_tipostareapro");
		setSelect("idtipotareapro");
		setFrom("pr_tipostareapro");
		setWhere("idtipoproceso = '" + idTipoProceso + "'" + " AND tareainicial = true");
	}
	if (!qryTareasIniciales.exec()) {
		return false;
	}

	if(mostrarProgreso)
		util.createProgressDialog(util.translate("scripts", "Activando tareas ..."), qryTareasIniciales.size());
	var progress:Number = 0;

	var idTareasIniciales:Array;
	var idTipoTareaPro:String;
	while (qryTareasIniciales.next()) {
		if(mostrarProgreso)
			util.setProgress(progress++);
		idTareasIniciales = [];
		idTipoTareaPro = qryTareasIniciales.value("idtipotareapro");
		if (!this.iface.tareasNoSaltadas(idTareasIniciales, idTipoTareaPro, idTipoProceso, idProceso, xmlProceso)) {
			if(mostrarProgreso)
				util.destroyProgressDialog();
			return false;
		}
		for (var i:Number = 0; i < idTareasIniciales.length; i++) {
// 			if (!this.iface.activarTarea(idTareasIniciales[i]))
			if (!this.iface.activarTarea(curProceso, idTareasIniciales[i])) {
				if(mostrarProgreso)
					util.destroyProgressDialog();
				return false;
			}
		}
	}

	var util:FLUtil = new FLUtil;
	switch (tipoObjeto) {
		default: {
			break;
		}
	}

	if(mostrarProgreso)
		util.destroyProgressDialog();

	return idProceso;
}

function prod_esProcesoFabricacion(idTipoProceso:String):Boolean
{
	var util:FLUtil = new FLUtil;
	var tipoProduccion:String = util.sqlSelect("pr_tiposproceso", "tipoproduccion", "idtipoproceso = '" + idTipoProceso + "'");

	return (tipoProduccion == "Fabricación");
}

/** \D Cambia el estado del objeto asociado a un proceso
@param	idPoceso: Identificador del proceso
@param	estadoObjeto: Estado del objeto
@return True si el cambio se realiza correctamente, False en otro caso
\end */
function prod_cambiarEstadoObjeto(idProceso:Number, estadoObjeto:String):Boolean
{
debug("prod_cambiarEstadoObjeto");
	var util:FLUtil = new FLUtil;

	var qryProceso:FLSqlQuery = new FLSqlQuery();
	with (qryProceso) {
		setTablesList("pr_procesos,pr_tiposproceso");
		setSelect("p.idobjeto, tp.tipoobjeto, tp.fabricacion, tp.idtipoproceso");
		setFrom("pr_procesos p INNER JOIN pr_tiposproceso tp ON p.idtipoproceso = tp.idtipoproceso");
		setWhere("idproceso = '" + idProceso + "'");
	}
	if (!qryProceso.exec()) {
		return false;
	}
	if (!qryProceso.first()) {
		return false;
	}

	/// Si el proceso es de producción pero no de fabricación el estado del objeto (lote) no se modifica nunca.
	if (qryProceso.value("tp.fabricacion") && !this.iface.esProcesoFabricacion(qryProceso.value("tp.idtipoproceso"))) {
		return true;
	}

	return this.iface.__cambiarEstadoObjeto(idProceso, estadoObjeto);
}

/** \D Si el tipo de proceso asociado al artículo tiene al menos una tarea opcional, se construye un documento XML que indica las tareas a saltar
\end */
function prod_parametrosProceso(curProceso:FLSqlCursor):String
{
	var util:FLUtil = new FLUtil;
	if (this.iface.xmlDocParametros_) {
		delete this.iface.xmlDocParametros_;
	}
	this.iface.xmlDocParametros_ = this.iface.crearXMLProcesoProd(curProceso);
	if (!this.iface.xmlDocParametros_) {
		return false;
	}

	var xmlProceso:FLDomNode = this.iface.xmlDocParametros_.firstChild();
	if (!this.iface.crearXMLParametrosProceso(curProceso, xmlProceso)) {
		MessageBox.warning(util.translate("scripts", "Error al crear los parámetros asociados al proceso %1").arg(curProceso.valueBuffer("idproceso")), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	return this.iface.xmlDocParametros_.toString(4);
}

/** \D Genera un xml con los datos de tareas a realizar (tareas fijas y tareas opcionales seleccionadas) y las opciones de composición elegidas.
@param	idTipoProceso: Identificador del tipo de proceso
@param	refArticulo: Referencia del artículo.
@param	restricciones: Array con ciertos valores restrictivos a la hora de buscar tareas y componentes del tipo de proceso:
	- sinComponentes: Si este valor es true no se incluirán las opciones de los componentes del proceso.
	- sinTareas: Si este valor es true no se incluirán las tareas finas y opcionales seleccionadas.
	- whereComponentes: Where que se sumará a la consulta con ciertos filtros que se etablecerán a la hora de buscar componentes.
	- whereTareas: Where que se sumará a la consulta con ciertos filtros que se etablecerán a la hora de buscar tareas opcionales.
@return True si se a generado correctamente, False en otro caso
\end */
function prod_crearXMLTipoProceso(idTipoProceso:String,refArticulo:String,restricciones:Array):Boolean
{
	var util:FLUtil = new FLUtil;
	if(!idTipoProceso || idTipoProceso == "" || !refArticulo || refArticulo == "")
		return false;

	var contenido:String = "<Proceso IdTipoProceso='" + idTipoProceso + "' Referencia = '" + refArticulo + "'>";
	contenido += "\n";
	var aux:String;


	var sinTareas:Boolean = false;
	var sinComponentes:Boolean = false;
	var whereComponentes:String = "";
	var whereTareas:String = "";
	if(restricciones) {
		sinTareas = restricciones["sinTareas"];
		sinComponentes = restricciones["sinComponentes"];
		whereComponentes = restricciones["whereComponentes"];
		whereTareas = restricciones["whereTareas"];
	}

	if(!sinTareas) {
		aux = this.iface.crearXMLTareasTipoProceso(idTipoProceso,whereTareas);
		if(aux == false)
			return false;
		contenido += aux;
	}

	if(!sinComponentes) {
		aux = this.iface.crearXMLComponentesTipoProceso(idTipoProceso,refArticulo,whereTareas,whereComponentes);
		if(aux == false)
			return false;
		contenido += aux;
	}

	contenido += "</Proceso>";

	if (this.iface.xmlDocParametros_)
		delete this.iface.xmlDocParametros_;
	this.iface.xmlDocParametros_ = new FLDomDocument;
	if (!this.iface.xmlDocParametros_.setContent(contenido)) {
		MessageBox.warning(util.translate("scripts", "Error al cargar los parámetros XML correspondientes al tipo de proceso %1").arg(idTipoProceso), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	return true;
}

function prod_crearXMLTareasTipoProceso(idTipoProceso:String,whereTareas:String):String
{
	var util:FLUtil;
	var contenido:String = "";
	contenido += "<Tareas>";
	contenido += "\n";

	if(!this.iface.selectTareasOpcionales(idTipoProceso, whereTareas))
		return false;

	if(!whereTareas)
		whereTareas = "";

	if(whereTareas != "")
		whereTareas += " AND ";

	if(this.iface.tareasOpcionales_ && this.iface.tareasOpcionales_ != "")
		whereTareas += "(pr_tipostareapro.opcional = false OR pr_tipostareapro.idtipotareapro IN (" + this.iface.tareasOpcionales_ + "))";
	else
		whereTareas += "pr_tipostareapro.opcional = false";


	var qryTareas:FLSqlQuery = new FLSqlQuery;
	qryTareas.setTablesList("pr_tipostareapro");
	qryTareas.setSelect("idtipotareapro, codtipotareapro, descripcion");
	qryTareas.setFrom("pr_tipostareapro");
	qryTareas.setWhere("idtipoproceso = '" + idTipoProceso + "' AND " + whereTareas);
	qryTareas.setForwardOnly(true);
	if (!qryTareas.exec())
		return false;

	while (qryTareas.next())
		contenido += "<Tarea IdTipoTareaPro='" + qryTareas.value("idtipotareapro") + "' CodTipoTareaPro='" + qryTareas.value("codtipotareapro") + "' Descripcion='" + qryTareas.value("descripcion") + "'/>\n";
	contenido += "</Tareas>";
	contenido += "\n";

	return contenido;
}

function prod_crearXMLComponentesTipoProceso(idTipoProceso:String,refArticulo:String,whereTareas:String,whereComponentes:String):String
{
	var util:FLUtil;

	var contenido:String = "";

	if(!whereTareas)
		whereTareas = "";

	if(whereTareas != "")
		whereTareas += " AND ";

	if(this.iface.tareasOpcionales_ && this.iface.tareasOpcionales_ != "")
		whereTareas += "(pr_tipostareapro.opcional = false OR pr_tipostareapro.idtipotareapro IN (" + this.iface.tareasOpcionales_ + "))";
	else
		whereTareas += "pr_tipostareapro.opcional = false";

	if(!whereComponentes)
		whereComponentes = "";

	if(whereComponentes != "")
		whereComponentes = " AND " + whereComponentes;

	contenido += "<Opciones>";
	contenido += "\n";
	var qryArt:FLSqlQuery = new FLSqlQuery;
	qryArt.setTablesList("articuloscomp");
	qryArt.setSelect("id,idtipoopcionart,idopcionarticulo,codfamiliacomponente,idtipotareapro");
	qryArt.setFrom("articuloscomp");
	qryArt.setWhere("refcompuesto = '" + refArticulo + "' AND idtipotareapro IN (Select idtipotareapro from pr_tipostareapro where idtipoproceso = '" + idTipoProceso + "' AND " + whereTareas + ")" + whereComponentes);
	qryArt.setForwardOnly(true);
	if (!qryArt.exec())
		return false;

	var idArtComp:Number;
	var codFamilia:String;
	var referencia:String;
	var familias:String = "<Familias>\n";
	var idTipoOpcionArt:Number = -1;
	var idTipoOpcion:Number;
	var idValorOpcion:Number;
	var opcionesConstantes:Array = new Array();
	var saltarOpc:Boolean = false;
	var tipoTarea:Number;
	while (qryArt.next()) {
		codFamilia = qryArt.value("codfamiliacomponente");
		idArtComp = qryArt.value("id");
		tipoTarea = qryArt.value("idtipotareapro");
		if(idTipoOpcionArt == -1 || idTipoOpcionArt != qryArt.value("idtipoopcionart")) {
			idTipoOpcionArt = qryArt.value("idtipoopcionart");

			if(idTipoOpcionArt) {
				idTipoOpcion = util.sqlSelect("tiposopcionartcomp","idtipoopcion","idtipoopcionart = " + idTipoOpcionArt);

				if (idTipoOpcion && idTipoOpcion != 0) {
					saltarOpc = false;

					if(util.sqlSelect("tiposopcionartcomp","constante","idtipoopcionart = " + idTipoOpcionArt)) {
						var i:Number = 0;
						while (!saltarOpc && i<opcionesConstantes.length) {
							if(opcionesConstantes[i] == idTipoOpcion)
								saltarOpc = true;
							i++;
						}
						if(i == opcionesConstantes.length)
							opcionesConstantes[i] = idTipoOpcion;
					}

					if(!saltarOpc) {
						var f:Object = new FLFormSearchDB("opcionescomp");
						var curOpciones:FLSqlCursor = f.cursor();
						curOpciones.setMainFilter("idtipoopcion = " + idTipoOpcion);
						f.setMainWidget();
						idValorOpcion = f.exec("idopcion");
						if(!idValorOpcion)
							return false;

						var idValorOpcionArt:Number = util.sqlSelect("opcionesarticulocomp","idopcionarticulo","idtipoopcionart = " + idTipoOpcionArt + " AND idopcion = " + idValorOpcion);
						if(!idValorOpcionArt)
							return false;

						contenido += "<Opcion IdTipoOpcion = '" + idTipoOpcionArt + "' IdValorOpcion = '" + idValorOpcionArt + "'/>\n";

						if(idValorOpcionArt != qryArt.value("idopcionarticulo"))
							continue;
					}
				}
			}
		}
		if(codFamilia && codFamilia != "") {
			var f:Object = new FLFormSearchDB("buscarcomponente");
			var curArticulos:FLSqlCursor = f.cursor();
			var lista:String = flfactalma.iface.calcularFiltroReferencia(refArticulo);
			if (!lista || lista == "")
				curArticulos.setMainFilter("codfamilia = '" + codFamilia + "'");
			else
				curArticulos.setMainFilter("codfamilia = '" + codFamilia + "' AND referencia NOT IN (" + lista + ")");

			f.setMainWidget();
			if(tipoTarea)
				f.child("lblMensaje").text = "Seleccione el componente correspondiente a la tarea " + util.sqlSelect("pr_tipostareapro","descripcion","idtipotareapro = " + tipoTarea);
			referencia = f.exec("referencia");
			if (!referencia)
				return false;

			familias += "<Familia Id = '" + idArtComp + "' Referencia = '" + referencia + "'/>\n";
		}
	}

	familias += "</Familias>\n";
	contenido += "</Opciones>";
	contenido += "\n";
	contenido += familias;

	return contenido;
}

function prod_selectTareasOpcionales(idTipoProceso:String,whereTareas:String):Boolean
{
	var util:FLUtil;

	this.iface.tareasOpcionales_ = "";

	if(!whereTareas)
		whereTareas = "";

	if(whereTareas != "")
		whereTareas = " AND " + whereTareas;

	var f:Object = new FLFormSearchDB("pr_selecttipostareapro");
	var curT:FLSqlCursor = f.cursor();
	curT.select("idtipoproceso = '" + idTipoProceso + "' AND opcional = true" + whereTareas);
	if(!curT.first())
		return true;

	f.setMainWidget();
	f.child("lblTitulo").text = "Seleccione las tareas opcionales a incluir para el tipo de proceso " + idTipoProceso + " - " + util.sqlSelect("pr_tiposproceso","descripcion","idtipoproceso = '" + idTipoProceso + "'") + ".";
	f.child("tableDBRecords").cursor().setMainFilter("idtipoproceso = '" + idTipoProceso + "' AND opcional = true" + whereTareas);
	if(!f.exec("idtipotarea"))
		return false;

	return true;
}

function prod_crearXMLProcesoProd(curProceso:FLSqlCursor):FLDomDocument
{
	var util:FLUtil = new FLUtil;

	var idTipoProceso:String = curProceso.valueBuffer("idtipoproceso");
	var idProceso:String = curProceso.valueBuffer("idproceso");
	var objeto:String = curProceso.valueBuffer("idobjeto");
	var contenido:String = "<Proceso IdProceso='" + idProceso + "' IdTipoProceso='" + idTipoProceso + "' IdObjeto = '" + objeto + "'>";
	contenido += "\n";
	contenido += "<Tareas>";
	contenido += "\n";
	var qryTareas:FLSqlQuery = new FLSqlQuery;
	with (qryTareas) {
		setTablesList("pr_tipostareapro");
		setSelect("idtipotareapro, codtipotareapro, descripcion");
		setFrom("pr_tipostareapro");
		setWhere("idtipoproceso = '" + idTipoProceso + "'");
		setForwardOnly(true);
	}
	if (!qryTareas.exec()) {
		return false;
	}
	while (qryTareas.next()) {
		contenido += "<Tarea IdTipoTareaPro='" + qryTareas.value("idtipotareapro") + "' CodTipoTareaPro='" + qryTareas.value("codtipotareapro") + "' Descripcion='" + qryTareas.value("descripcion") + "'/>";
		contenido += "\n";
	}
	contenido += "</Tareas>";
	contenido += "\n";
	contenido += "</Proceso>";

	var xmlDocProceso:FLDomDocument = new FLDomDocument;
	if (!xmlDocProceso.setContent(contenido))
		return false;

	return xmlDocProceso;
}

function prod_crearXMLParametrosProceso(curLote:FLSqlCursor, xmlProceso:FLDomNode):Boolean
{
	var util:FLUtil = new FLUtil;
	if (!this.iface.crearXMLTareasOpcionales(curLote, xmlProceso)) {
		return false;
	}
	return true;
}

function prod_crearXMLTareasOpcionales(curLote:FLSqlCursor, xmlProceso:FLDomNode):Boolean
{
	var util:FLUtil = new FLUtil;

	var idTipoProceso:String = xmlProceso.toElement().attribute("IdTipoProceso");
	if (!util.sqlSelect("pr_tipostareapro", "idtipotareapro", "idtipoproceso = '" + idTipoProceso + "' AND opcional = true")) {
		return true;
	}

	this.iface.xmlNodoBuffer_ = xmlProceso;
	if (!this.iface.xmlNodoBuffer_) {
		return false;
	}

	var fTTP:Object = new FLFormSearchDB("pr_smtipostareapro");
	var curTiposTareaPro:FLSqlCursor = fTTP.cursor();

	fTTP.setMainWidget();
	var idTipoTarea:String = fTTP.exec("idtipotarea");
debug("idTipoTarea = " + idTipoTarea);
if (!this.iface.xmlNodoBuffer_)
	debug("No hay NBuffer");
else {
var d:FLDomDocument = new FLDomDocument;
d.appendChild(this.iface.xmlNodoBuffer_.cloneNode())
debug(d.toString());
}
	if (!idTipoTarea) {
		return false;
	}

	return true;
}

/** \D Crea un proceso de producción.
@param referencia: Referencia del producto o servicio asociado al proceso de producción
@param codLote: Lote asociado al proceso
@param idLineaPedidoCli: Línea de pedido de cliente asociada al proceso (opcional)
\end */
function prod_crearProcesoProd(referencia:String, codLote:String, idLineaPedidoCli:String):Number
{
	var util:FLUtil = new FLUtil;

	var curLote:FLSqlCursor = new FLSqlCursor("lotesstock");
	curLote.select("codlote = '" + codLote + "'");
	if (!curLote.first()) {
		MessageBox.warning(util.translate("scripts", "Error al crear el proceso de producción %1: El lote %2 no existe").arg(idTipoProceso).arg(codLote), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	this.iface.comprobarXmlOpciones(codLote)
	var idTipoProceso:String = util.sqlSelect("articulos", "idtipoproceso", "referencia = '" + referencia + "'");

	if (!this.iface.curProceso_) {
		this.iface.curProceso_ = new FLSqlCursor("pr_procesos");
	}

	this.iface.curProceso_.setModeAccess(this.iface.curProceso_.Insert);
	this.iface.curProceso_.refreshBuffer();
	this.iface.curProceso_.setValueBuffer("idtipoproceso", idTipoProceso);
	this.iface.curProceso_.setValueBuffer("estado", "OFF");
	this.iface.curProceso_.setValueBuffer("idobjeto", codLote);
	this.iface.curProceso_.setValueBuffer("tipoobjeto", "lotesstock");
	if (!this.iface.datosProcesoOFF(referencia, codLote, idLineaPedidoCli)) {
		return false;
	}

	var parametros:String = this.iface.parametrosProceso(this.iface.curProceso_);
	if (!parametros) {
		MessageBox.warning(util.translate("scripts", "Error al obtener los parámetros del proceso de producción"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	if (parametros != "")
		this.iface.curProceso_.setValueBuffer("xmlparametros", parametros);

	if (!this.iface.curProceso_.commitBuffer())
		return false;

	var idProceso:String = this.iface.curProceso_.valueBuffer("idproceso");
	if (!idProceso)
		return false;

	if (!this.iface.crearTareasOFF(this.iface.curProceso_))
		return false;

	var datosProceso_:Array = [];
	datosProceso_ = flfactalma.iface.pub_datosProcesoArticulo(referencia);
	if (datosProceso_) {
debug("entra " + datosProceso_["tipoproduccion"]);
		if (datosProceso_["tipoproduccion"] == "M") {
debug("llega");
			if (!flfactalma.iface.pub_crearComposicion(curLote, false, referencia, idProceso))
				return false;
		}
	}

	return idProceso;
}

function prod_comprobarXmlOpciones(codLote:String):Boolean
{
	var util:FLUtil;

	if(!codLote || codLote == "")
		return false;

	var parametrosXML:String = util.sqlSelect("lotesstock", "xmlparametros", "codlote = '" + codLote + "'");

	if(!parametrosXML || parametrosXML == "") {
		parametrosXML = "<Lote CodLote='" + codLote + "'>";
		parametrosXML +="<Opciones></Opciones>";
		parametrosXML +="<Componentes></Componentes>";
		parametrosXML += "</Lote>";
	}

	var xmlDocLote:FLDomDocument = new FLDomDocument;
	var xmlLote:FLDomNode;
	if (parametrosXML && parametrosXML != "") {
		if (!xmlDocLote.setContent(parametrosXML)) {
			MessageBox.warning(util.translate("scripts", "Error al cargar los parámetros XML correspondientes al lote %1").arg(codLote), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
		xmlLote = xmlDocLote.firstChild();
	}
debug("xml " + xmlDocLote.toString(4));

	var eLote:FLDomElement = xmlLote.toElement();
	var opciones:FLDomElement = eLote.namedItem("Opciones").toElement();
	var opcion:FLDomElement;
	var whereOpciones:String = "";
	for (var nodoOpcion:FLDomNode = opciones.firstChild(); nodoOpcion; nodoOpcion = nodoOpcion.nextSibling()) {
		opcion = nodoOpcion.toElement();
		if(whereOpciones != "")
			whereOpciones += ",";
		whereOpciones += opcion.attribute("IdTipoOpcion");
	}

	if(whereOpciones != "")
		whereOpciones = " AND idtipoopcion NOT IN (" + whereOpciones + ")";
debug("whereOpciones " + whereOpciones);
	var artLote:String = util.sqlSelect("lotesstock","referencia","codlote = '" + codLote + "'");
debug("artLote " + artLote);
	if(!artLote || artLote == "")
		return false;

	var qryOpciones:FLSqlQuery = new FLSqlQuery();
	with (qryOpciones) {
		setTablesList("tiposopcionartcomp");
		setSelect("idtipoopcion");
		setFrom("tiposopcionartcomp");
		setWhere("referencia = '" + artLote + "'" + whereOpciones);
	}
	if (!qryOpciones.exec())
		return false;


	var idTipoOpcion:Number;
	var idValorOpcion:Number;
	var eOpcion:FLDomElement;
	while (qryOpciones.next()) {
		idTipoOpcion = qryOpciones.value("idtipoopcion");
		idValorOpcion = this.iface.obtenerOpcionLote(codLote, idTipoOpcion);
		if (!idValorOpcion) {
			return false;
		}
		eOpcion = xmlDocLote.createElement("Opcion");
		xmlLote.namedItem("Opciones").appendChild(eOpcion);
		eOpcion.setAttribute("IdTipoOpcion",idTipoOpcion);
		eOpcion.setAttribute("IdValorOpcion",idValorOpcion);
	}
debug("xmlFinal " + xmlDocLote.toString(4));
	if(!util.sqlUpdate("lotesstock","xmlparametros",xmlDocLote.toString(4),"codlote = '" + codLote + "'"))
		return false;

	return true;
}

function prod_obtenerOpcionLote(codLote:String, idTipoOpcion:String)
{
	var idValorOpcion:String
	var f:Object = new FLFormSearchDB("opcionescomp");
	var curOpciones:FLSqlCursor = f.cursor();
	curOpciones.setMainFilter("idtipoopcion = " + idTipoOpcion);
	f.setMainWidget();
	idValorOpcion = f.exec("idopcion");
	if (!idValorOpcion) {
		return false;
	}
	return idValorOpcion;
}

function prod_datosProcesoOFF(referencia:String, codLote:String, idLineaPedidoCli:String):Boolean
{
	var util:FLUtil = new FLUtil;
	if (idLineaPedidoCli) {
		this.iface.curProceso_.setValueBuffer("idlineapedidocli", idLineaPedidoCli);
		this.iface.curProceso_.setValueBuffer("descripcion", util.sqlSelect("lineaspedidoscli","descripcion","idlinea = " + idLineaPedidoCli));
	}
	return true;
}


/** \C Crea las tareas de un proceso en estado OFF
@param	curProceso: Cursor del proceso
\end */
function prod_crearTareasOFF(curProceso:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	var idProceso:String = curProceso.valueBuffer("idproceso");

	if (this.iface.xmlDocParametros_) {
		delete this.iface.xmlDocParametros_;
	}
	this.iface.xmlDocParametros_ = new FLDomDocument;
	if (!this.iface.xmlDocParametros_.setContent(curProceso.valueBuffer("xmlparametros"))) {
		return false;
	}
	var xmlProceso:FLDomNode = this.iface.xmlDocParametros_.firstChild();

	if (this.iface.curTareas_) {
		delete this.iface.curTareas_;
	}
	this.iface.curTareas_ = new FLSqlCursor("pr_tareas");
	var curTipoTareaPro:FLSqlCursor = new FLSqlCursor("pr_tipostareapro");
	var xmlTareas:FLDomNodeList = xmlProceso.toElement().elementsByTagName("Tarea");

	var eTarea:FLDomElement;
	var idTipoTareaPro:String;
	var codTipoTareaPro:String;
	if (xmlTareas) {
		util.createProgressDialog( util.translate( "scripts", "Creando tareas de producción para el proceso %1..." ).arg(idProceso), xmlTareas.length());
		for (var i:Number = 0; i < xmlTareas.length(); i++) {
			util.setProgress(i);
			eTarea = xmlTareas.item(i).toElement();
			idTipoTareaPro = eTarea.attribute("IdTipoTareaPro");
			codTipoTareaPro = eTarea.attribute("CodTipoTareaPro");

			if (eTarea.attribute("Estado") != "Saltada") {
				curTipoTareaPro.select("idtipotareapro = " + idTipoTareaPro);
				if (!curTipoTareaPro.first()) {
					util.destroyProgressDialog();
					MessageBox.warning(util.translate("scripts", "Error al buscar la tarea con idtipotareapro %1").arg(idTipoTareaPro), MessageBox.Ok, MessageBox.NoButton);
					return false;
				}
				this.iface.curTareas_.setModeAccess(this.iface.curTareas_.Insert);
				this.iface.curTareas_.refreshBuffer();
				this.iface.curTareas_.setValueBuffer("idproceso", idProceso);
				this.iface.curTareas_.setValueBuffer("idtarea", this.iface.calcularIdTarea());
				this.iface.curTareas_.setValueBuffer("idtipotareapro", idTipoTareaPro);
				this.iface.curTareas_.setValueBuffer("codtipotareapro", codTipoTareaPro);
				this.iface.curTareas_.setValueBuffer("estado", "OFF");
				this.iface.curTareas_.setValueBuffer("tipoobjeto", "lotesstock");
				this.iface.curTareas_.setValueBuffer("idobjeto", curProceso.valueBuffer("idobjeto"));
				this.iface.curTareas_.setValueBuffer("idtipotarea", curTipoTareaPro.valueBuffer("idtipotarea"));
				this.iface.curTareas_.setValueBuffer("numciclo", 1);
				if (!this.iface.datosTareaOFF(curTipoTareaPro, xmlTareas.item(i))) {
					util.destroyProgressDialog();
					return false;
				}
				if (!this.iface.curTareas_.commitBuffer()) {
					util.destroyProgressDialog();
					MessageBox.warning(util.translate("scripts", "Error al crear la tarea tipo %1 para el proceso %2").arg(idTipoTareaPro).arg(idProceso), MessageBox.Ok, MessageBox.NoButton);
					return false;
				}
			}
		}
		util.destroyProgressDialog();
	}
	return true;
}

function prod_datosTareaOFF(curTipoTareaPro:FLSqlCursor, xmlTarea:FLDomNode):Boolean
{
	with (this.iface.curTareas_) {
		setValueBuffer("descripcion", curTipoTareaPro.valueBuffer("descripcion"));
	}
	return true;
}

/** \C
Pasa un proceso a estado OFF, borrando sus tareas y sacándolo de la orden de producción
El proceso debe estar en estado PTE y todas sus tareas en estado OFF o PTE
@param idProceso: Identificador del proceso a borrar
@return True si el proceso se borró correctamente, false en caso contrario
\end */
function prod_pasarOFFProcesoProd(idProceso:String):Boolean
{
	var util:FLUtil = new FLUtil();

	var noPendiente:Boolean = util.sqlSelect("pr_procesos", "estado", "idproceso = " + idProceso + " AND estado NOT IN ('PTE', 'OFF')");
	if (noPendiente) {
		MessageBox.warning(util.translate("scripts", "Anular proceso: El proceso debe estar en estado OFF o PTE"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	var hayTareasIniciadas:Number = util.sqlSelect("pr_tareas", "idtarea", "idproceso = " + idProceso + " AND estado NOT IN ('PTE', 'OFF')");
	if (hayTareasIniciadas) {
		MessageBox.warning(util.translate("scripts", "Anular proceso: Todas las tareas del proceso deben estar en estado OFF o PTE"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}


	if (this.iface.curTareas_) {
		delete this.iface.curTareas_;
	}

	this.iface.curTareas_ = new FLSqlCursor("pr_tareas");
	this.iface.curTareas_.select("idproceso = " + idProceso);

	while (this.iface.curTareas_.next()) {
		this.iface.curTareas_.setModeAccess(this.iface.curTareas_.Edit);
		this.iface.curTareas_.refreshBuffer();
		if (!this.iface.pasarOFFTareaProd()) {
			return false;
		}
		if (!this.iface.curTareas_.commitBuffer()) {
			MessageBox.warning(util.translate("scripts", "Borrar tareas: Hubo un error al borrar la tarea %1 asociada al proceso %2").arg(this.iface.curTareas_.valueBuffer("idtarea")).arg(idProceso), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
	}

	var curProcesos:FLSqlCursor = new FLSqlCursor("pr_procesos");
	curProcesos.select("idproceso = " + idProceso);
	if (!curProcesos.first()) {
		return false;
	}
	curProcesos.setModeAccess(curProcesos.Edit);
	curProcesos.refreshBuffer();
	curProcesos.setValueBuffer("estado", "OFF");
	curProcesos.setNull("codordenproduccion");
	if (!curProcesos.commitBuffer()) {
		MessageBox.warning(util.translate("scripts", "Anular proceso: Hubo un error al pasar el proceso %1 a estado OFF").arg(idProceso), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	return true;
}

function prod_pasarOFFTareaProd()
{
	this.iface.curTareas_.setValueBuffer("estado", "OFF");
	this.iface.curTareas_.setNull("fechainicioprev");
	this.iface.curTareas_.setNull("horainicioprev");
	this.iface.curTareas_.setNull("fechafinprev");
	this.iface.curTareas_.setNull("horafinprev");
	this.iface.curTareas_.setNull("horafinprev");
	this.iface.curTareas_.setNull("codcentro");
	return true;
}

function prod_borrarProcesoProd(idProceso:Number,codLote:String):Boolean
{
	var util:FLUtil;

	if (!idProceso) {
		MessageBox.information(util.translate("scripts", "No hay ningún proceso seleccionado"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	if (!codLote || codLote == "") {
		return false;
	}

	var curLote:FLSqlCursor = new FLSqlCursor("lotesstock");
	curLote.select("codlote = '" + codLote + "'");
	if (!curLote.first()) {
		return false;
	}
	curLote.refreshBuffer();

	var cursor:FLSqlCursor = new FLSqlCursor("pr_procesos");
	cursor.select("idproceso = " + idProceso);
	cursor.transaction(false);
	try {
		if(this.iface.borrarProceso(idProceso)) {
			if(flfactalma.iface.pub_borrarComposicion(curLote, idProceso)) {
				cursor.commit();
			} else {
				cursor.rollback();
				return false;
			}
		} else {
			cursor.rollback();
			return false;
		}
	} catch (e) {
		cursor.rollback();
		MessageBox.critical(util.translate("scripts", "Hubo un error al borrar el proceso %1:\n").arg(idProceso) + e, MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	return true;
}

function prod_subestadoInicialTiemposReales():String
{
	var util:FLUtil;

	return util.translate("scripts", "PREPARACIÓN EN CURSO");
}

/** \C
Cambia el estado de la tarea de PTE a EN CURSO, llamando -si existe- a la acción asociada a la tarea
@param curTareas: Cursor posicionado sobre la tarea a iniciar
@param idUser: Identificador del usuario que inicia la tarea
@return VERDADERO si la tarea ha sido iniciada. FALSO en otro caso
\end */
function prod_iniciarTarea(curTareas:FLSqlCursor, idUser:String, ignorarEstadistica:Boolean)
{
	var util:FLUtil = new FLUtil();
	var idTipoTarea:String = curTareas.valueBuffer("idtipotarea");
	var idTipoTareaPro:String = curTareas.valueBuffer("idtipotareapro");
	var idTarea:String = curTareas.valueBuffer("idtarea");
	var idProceso:String = curTareas.valueBuffer("idproceso");
	var estado:String = curTareas.valueBuffer("estado");

	var fechaInicio:Date = new Date();
	var horaInicio:String = fechaInicio.toString().substring(11, 19);
	var ahora:Date = new Date();
	var subEstado:String = this.iface.subestadoInicialTiemposReales();
	with(curTareas) {
		setModeAccess(curTareas.Edit);
		refreshBuffer();
		setValueBuffer("estado", "EN CURSO");
		setValueBuffer("tiempoinicio", horaInicio);
		setValueBuffer("diainicio", fechaInicio);
		setValueBuffer("realizadapor", idUser);
		setValueBuffer("iniciocuentaf", ahora.toString());
		setValueBuffer("iniciocuentat", ahora.toString().right(8));
		setValueBuffer("subestado", subEstado);
		if (ignorarEstadistica) {
			setValueBuffer("ignorarestadistica", true);
		}
	}
	if (!curTareas.commitBuffer()) {
		return false;
	}

	curTareas.select("idtarea = '" + idTarea + "'");
	curTareas.first();
	curTareas.setModeAccess(curTareas.Edit);
	curTareas.refreshBuffer();

/** \C Si la tarea es una tarea inicial, se inicia el proceso asociado, y se marca el objeto relacionado para indicar que está incluido en un proceso ya iniciado
\end */
	if (this.iface.esTareaInicial(idTipoTareaPro)) {
		if (!this.iface.iniciarProceso(idProceso)) {
			return false;
		}

		var estadoObjeto:String = this.iface.estadoObjetoInicial(idProceso);
		if (!this.iface.cambiarEstadoObjeto(idProceso, estadoObjeto)) {
			return false;
		}
	}
	if (!this.iface.iniciarTareaEsp(curTareas)) {
		return false;
	}

	return true;
}

/** \C
Cambia el estado de la tarea de EN CURSO a PTE, deshaciendo también -si existe- a la acción asociada a la tarea
@param curTareas: Cursor posicionado sobre la tarea a iniciar
@return VERDADERO si la tarea ha sido deshecha. FALSO en otro caso
\end */
function prod_deshacerTareaEnCurso(curTareas:FLSqlCursor):Boolean
{
	if (!this.iface.__deshacerTareaEnCurso(curTareas)) {
		return false;
	}
	var util:FLUtil = new FLUtil();
	var idTarea:String = curTareas.valueBuffer("idtarea");

	with(curTareas) {
		setModeAccess(curTareas.Edit);
		refreshBuffer();
		setNull("tiempoinvertido");
		setNull("iniciocuentaf");
		setNull("iniciocuentat");
		setNull("intervaloprep");
		setNull("intervalotrab");
		setNull("subestado");
	}
	if (!curTareas.commitBuffer()) {
		return false;
	}

	curTareas.select("idtarea = '" + idTarea + "'");
	curTareas.first();
	curTareas.setModeAccess(curTareas.Edit);
	curTareas.refreshBuffer();

	return true;
}

function prod_calcularTiempoInvertido(curTareas:FLSqlCursor):Number
{
	var util:FLUtil;
	var tiempo:Number = 0;
	if(util.sqlSelect("pr_config","controltiempo","1=1")) {
		var intervalo:Number;
		var subestado:String = curTareas.valueBuffer("subestado");

		if(subestado && subestado != util.translate("scripts", "EN PAUSA")) {
			var ahora:Date = new Date;
			var tiempoAhora:Number = ahora.getTime();
			var inicio:String = curTareas.valueBuffer("iniciocuentaf").toString().left(11) + curTareas.valueBuffer("iniciocuentat").toString().right(8);
			var tiempoInicio:Number = Date.parse(inicio);
			intervalo = tiempoAhora - tiempoInicio;
			intervalo = Math.round(intervalo / 1000);
			switch (subestado) {
				case util.translate("scripts", "PREPARACIÓN EN CURSO"): {
					intervalo = parseFloat(curTareas.valueBuffer("intervaloprep")) + intervalo;
					curTareas.setValueBuffer("intervaloprep",intervalo.toString());
					break;
				}
				case util.translate("scripts", "TRABAJO EN CURSO"): {
					intervalo = parseFloat(curTareas.valueBuffer("intervalotrab")) + intervalo;
					curTareas.setValueBuffer("intervalotrab",intervalo.toString());
					break;
				}
			}
		}
debug("sigue");
		var tiempoAcumulado:Number = parseFloat(curTareas.valueBuffer("intervaloprep")) + parseFloat(curTareas.valueBuffer("intervalotrab"));
		tiempo = this.iface.convertirTiempoProceso(tiempoAcumulado, curTareas.valueBuffer("idproceso"));
	} else {
		tiempo = this.iface.__calcularTiempoInvertido(curTareas);
	}

	curTareas.setNull("subestado");
	curTareas.setNull("iniciocuentaf");
	curTareas.setNull("iniciocuentat");

	return tiempo;
}

function prod_calcularTiempoTrabajadores(curTareas:FLSqlCursor):Number
{
	var util:FLUtil;
	var tiempo:Number = parseFloat(util.sqlSelect("pr_tareastrabajador","SUM(totalacumulado)","idtarea = '" + curTareas.valueBuffer("idtarea") + "'"));
	return tiempo;
}

function prod_deshacerTareaTerminada(curTareas:FLSqlCursor):Boolean
{debug("prod_deshacerTareaTerminada " + curTareas.valueBuffer("idtarea"));
	var util:FLUtil;

	if (!this.iface.__deshacerTareaTerminada(curTareas)) {
		return false;
	}

	if (!util.sqlUpdate("pr_tareas","subestado",util.translate("scripts", "EN PAUSA"),"idtarea = '" + curTareas.valueBuffer("idtarea") + "'")) {
		return false;
	}

	return true;
}


function prod_seguimientoOn(container:Object, datosS:Array):Boolean
{
	if (!this.iface.__seguimientoOn(container, datosS)) {
		return false;
	}

	this.iface.setTareaAutomatica(false);

	return true;
}

function prod_setTareaAutomatica(automatica:Boolean)
{
	this.iface.tareaAutomatica = automatica;
}

function prod_calcularTiemposFinalizacionTarea(curTareas:FLSqlCursor,fechaFin:Date):Boolean
{
	if(!this.iface.__calcularTiemposFinalizacionTarea(curTareas,fechaFin))
		return false;

	curTareas.setValueBuffer("tiempotrabajadores", this.iface.calcularTiempoTrabajadores(curTareas));

	return true;
}

function prod_esTareaAutomatica():Boolean
{
	return this.iface.tareaAutomatica;
}
/*
function prod_iniciarTareaEsp(curTareas:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	if (!this.iface.__esTareaProduccion(curTareas) || !flcolaproc.iface.pub_esTareaAutomatica()) {
		return this.iface.iniciarTareaEsp(curTareas);
	}

	return prod_iniciarTareaEsp(curTareas);
}*/
//// PRODUCCIÓN /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

