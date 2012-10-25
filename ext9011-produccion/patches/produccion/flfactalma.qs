
/** @class_declaration prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN /////////////////////////////////////////////////
class prod extends articuloscomp {
	var tipoOpcionActual_:String;
	var idComponenteActual_:String;
	var curMoviStock:FLSqlCursor;
	var xmlNodoBuffer_:FLDomNode;
	function prod( context ) { articuloscomp ( context ); }
	function datosArticulo(cursor:FLSqlCursor, codLote:String):Array {
		return this.ctx.prod_datosArticulo(cursor, codLote);
	}
	function controlStockPresupuestosCli(curLP:FLSqlCursor):Boolean {
		return this.ctx.prod_controlStockPresupuestosCli(curLP);
	}
	function controlStockPedidosCli(curLP:FLSqlCursor):Boolean {
		return this.ctx.prod_controlStockPedidosCli(curLP);
	}
	function controlStockComandasCli(curLV:FLSqlCursor):Boolean {
		return this.ctx.prod_controlStockComandasCli(curLV);
	}
	function controlStockPedidosProv(curLP:FLSqlCursor):Boolean {
		return this.ctx.prod_controlStockPedidosProv(curLP);
	}
	function controlStockValesTPV(curLinea:FLSqlCursor):Boolean {
		return this.ctx.prod_controlStockValesTPV(curLinea);
	}
	function controlStockAlbaranesCli(curLA:FLSqlCursor):Boolean {
		return this.ctx.prod_controlStockAlbaranesCli(curLA);
	}
	function controlStockAlbaranesProv(curLA:FLSqlCursor):Boolean {
		return this.ctx.prod_controlStockAlbaranesProv(curLA);
	}
	function controlStockFacturasCli(curLF:FLSqlCursor):Boolean {
		return this.ctx.prod_controlStockFacturasCli(curLF);
	}
	function controlStockFacturasProv(curLF:FLSqlCursor):Boolean {
		return this.ctx.prod_controlStockFacturasProv(curLF);
	}
	function generarEstructura(curLP:FLSqlCursor):Boolean {
		return this.ctx.prod_generarEstructura(curLP);
	}
	function borrarEstructura(curLP:FLSqlCursor):Boolean {
		return this.ctx.prod_borrarEstructura(curLP);
	}
	function generarMoviStock(curLinea:FLSqlCursor, codLote:String, cantidad:Number, curArticuloComp:FLSqlCursor, idProceso:String):Boolean {
		return this.ctx.prod_generarMoviStock(curLinea, codLote, cantidad, curArticuloComp, idProceso);
	}
	function datosArticuloMS(datosArt:Array):Boolean {
		return this.ctx.prod_datosArticuloMS(datosArt);
	}
	function borrarMoviStock(curLinea:FLSqlCursor):Boolean {
		return this.ctx.prod_borrarMoviStock(curLinea);
	}
	function beforeCommit_movistock(curMS:FLSqlCursor):Boolean {
		return this.ctx.prod_beforeCommit_movistock(curMS);
	}
	function consistenciaLinea(curLinea:FLSqlCursor):Boolean {
		return this.ctx.prod_consistenciaLinea(curLinea);
	}
	function afterCommit_movistock(curMS:FLSqlCursor):Boolean {
		return this.ctx.prod_afterCommit_movistock(curMS);
	}
	function afterCommit_lotesstock(curLS:FLSqlCursor):Boolean {
		return this.ctx.prod_afterCommit_lotesstock(curLS);
	}
	function generarLoteStock(curLinea:FLSqlCursor, cantidad:Number, curArticuloComp:FLSqlCursor, idProceso:String):Boolean {
		return this.ctx.prod_generarLoteStock(curLinea, cantidad, curArticuloComp, idProceso);
	}
	function crearLote(datosArt:Array, cantidad:Number, idLinea:Number):String {
		return this.ctx.prod_crearLote(datosArt, cantidad, idLinea);
	}
	function almacenFabricacion(curLinea:FLSqlCursor,curArticuloComp:FLSqlCursor):String {
		return this.ctx.prod_almacenFabricacion(curLinea,curArticuloComp);
	}
	function buscarLoteDisponible(curLinea:FLSqlCursor, cantidad:Number, curArticuloComp:FLSqlCursor, idProceso:String):Boolean {
		return this.ctx.prod_buscarLoteDisponible(curLinea, cantidad, curArticuloComp, idProceso);
	}
	function crearComposicion(curLoteStock:FLSqlCursor, curComponente:FLSqlCursor, refProceso:String, idProceso:String,primeraLlamada:Boolean):Boolean {
		return this.ctx.prod_crearComposicion(curLoteStock, curComponente, refProceso, idProceso,primeraLlamada);
	}
	function borrarComposicion(curLoteStock:FLSqlCursor, idProceso:FLSqlCursor):Boolean {
		return this.ctx.prod_borrarComposicion(curLoteStock, idProceso);
	}
	function modificarFechaPedidoCli(curPedido:FLSqlCursor):Boolean {
		return this.ctx.prod_modificarFechaPedidoCli(curPedido);
	}
	function modificarFechaAlbaranCli(curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.prod_modificarFechaAlbaranCli(curAlbaran);
	}
	function modificarFechaPedidoProv(curPedido:FLSqlCursor):Boolean {
		return this.ctx.prod_modificarFechaPedidoProv(curPedido);
	}
	function modificarFechaAlbaranProv(curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.prod_modificarFechaAlbaranProv(curAlbaran);
	}
	function restarDiasLaborables(fechaInicial:String, dias:Number):String {
		return this.ctx.prod_restarDiasLaborables(fechaInicial, dias);
	}
	function sumarDiasLaborables(fechaInicial:String, dias:Number):String {
		return this.ctx.prod_sumarDiasLaborables(fechaInicial, dias);
	}
	function comprobarFechaFabricacionLote(curMS:FLSqlCursor):Boolean {
		return this.ctx.prod_comprobarFechaFabricacionLote(curMS);
	}
	function pedirLineaPresCli(idLineaPresupuesto:String, curLP:FLSqlCursor):Boolean {
		return this.ctx.prod_pedirLineaPresCli(idLineaPresupuesto, curLP);
	}
	function albaranarLineaPedCli(idLineaPedido:String, curLA:FLSqlCursor):Boolean {
		return this.ctx.prod_albaranarLineaPedCli(idLineaPedido, curLA);
	}
	function albaranarLineaPedProv(idLineaPedido:String, curLA:FLSqlCursor):Boolean {
		return this.ctx.prod_albaranarLineaPedProv(idLineaPedido, curLA);
	}
	function desalbaranarLineaPedCli(idLineaPedido:String, idLineaAlbaran:String):Boolean {
		return this.ctx.prod_desalbaranarLineaPedCli(idLineaPedido, idLineaAlbaran);
	}
	function desalbaranarLineaPedProv(idLineaPedido:String, idLineaAlbaran:String):Boolean {
		return this.ctx.prod_desalbaranarLineaPedProv(idLineaPedido, idLineaAlbaran);
	}
	function albaranarParcialLPC(idLineaPedido:String, curLA:FLSqlCursor):Boolean {
		return this.ctx.prod_albaranarParcialLPC(idLineaPedido, curLA);
	}
	function albaranarParcialLPP(idLineaPedido:String, curLA:FLSqlCursor):Boolean {
		return this.ctx.prod_albaranarParcialLPP(idLineaPedido, curLA);
	}
	function copiaDatosMoviStock(curMSOrigen:FLSqlCursor):Boolean {
		return this.ctx.prod_copiaDatosMoviStock(curMSOrigen);
	}
	function unificarMovPtePC(idLineaPedido:String):Boolean {
		return this.ctx.prod_unificarMovPtePC(idLineaPedido);
	}
	function unificarMovPtePP(idLineaPedido:String):Boolean {
		return this.ctx.prod_unificarMovPtePP(idLineaPedido);
	}
	function comprobarEvolStock(idStock:String):Boolean {
		return this.ctx.prod_comprobarEvolStock(idStock);
	}
	function graficoStock(idStock:String, avisar:Boolean):Boolean {
		return this.ctx.prod_graficoStock(idStock, avisar);
	}
	function stockActual(idStock:String):Number {
		return this.ctx.prod_stockActual(idStock);
	}
	function stockPteRecibir(idStock:String):Number {
		return this.ctx.prod_stockPteRecibir(idStock);
	}
	function stockPteServir(idStock:String):Number {
		return this.ctx.prod_stockPteServir(idStock);
	}
	function actualizarStock(idStock:Number):Boolean {
		return this.ctx.prod_actualizarStock(idStock);
	}
	function datosEvolStock(idStock:String, fechaDesde:String, avisar:Boolean):Array {
		return this.ctx.prod_datosEvolStock(idStock, fechaDesde, avisar);
	}
	function initPeriodoStock():Array {
		return this.ctx.prod_initPeriodoStock();
	}
	function planificarPedStock(arrayEvolStock:Array, plazoPedido:Number):Array {
		return this.ctx.prod_planificarPedStock(arrayEvolStock, plazoPedido);
	}
	function buscarIndiceAES(fecha:String, arrayEvolStock:Array):Number {
		return this.ctx.prod_buscarIndiceAES(fecha, arrayEvolStock);
	}
	function crearStock(codAlmacen:String, datosArt:Array):Number {
		return this.ctx.prod_crearStock(codAlmacen, datosArt);
	}
	function datosArticuloStock(idStock:String):Array {
		return this.ctx.prod_datosArticuloStock(idStock);
	}
	function revisarComponente(cursor:FLSqlCursor,idLinea:Number,codLote:String):Array {
		return this.ctx.prod_revisarComponente(cursor,idLinea,codLote);
	}
	function beforeCommit_lotesstock(curLote:FLSqlCursor):Boolean {
		return this.ctx.prod_beforeCommit_lotesstock(curLote);
	}
	function beforeCambioEstadoLote(curLote:FLSqlCursor):Boolean {
		return this.ctx.prod_beforeCambioEstadoLote(curLote);
	}
	function afterCambioEstadoLote(curLote:FLSqlCursor):Boolean {
		return this.ctx.prod_afterCambioEstadoLote(curLote);
	}
	function revisarEstadoLote(codLote:String):Boolean {
		return this.ctx.prod_revisarEstadoLote(codLote);
	}
	function asignarMoviStockSinLote(codLote:String):Boolean {
		return this.ctx.prod_asignarMoviStockSinLote(codLote);
	}
	function actualizarFechaComponentesLote(curLote:FLSqlCursor):Boolean {
		return this.ctx.prod_actualizarFechaComponentesLote(curLote);
	}
	function establecerOpcionesLote(codLote:Strins,idProceso:Number,idTipoOpcion:Number):Number {
		return this.ctx.prod_establecerOpcionesLote(codLote,idProceso,idTipoOpcion);
	}
	function obtenerOpcionLote(qryOpciones:FLSqlQuery,codLote:String):Number {
		return this.ctx.prod_obtenerOpcionLote(qryOpciones,codLote);
	}
	function establecerCantidad(curLinea:FLSqlCursor):Number {
		return this.ctx.prod_establecerCantidad(curLinea);
	}
	function sacarDeOrdenProd(codLote:String):Boolean {
		return this.ctx.prod_sacarDeOrdenProd(codLote);
	}
	function borrarLote(codLote:String, idMov:Number):Boolean {
		return this.ctx.prod_borrarLote(codLote, idMov);
	}
	function tareasOpcionales(idTipoProceso:String):String {
		return this.ctx.prod_tareasOpcionales(idTipoProceso);
	}
	function datosProcesoArticulo(referencia:String):Array {
		return this.ctx.prod_datosProcesoArticulo(referencia);
	}
	function buscarOpcionLote(idTipoOpcion:Number,codLote:String,idProceso:Number):Number {
		return this.ctx.prod_buscarOpcionLote(idTipoOpcion,codLote,idProceso);
	}
	function controlStockLineasTrans(curLTS:FLSqlCursor):Boolean {
		return this.ctx.prod_controlStockLineasTrans(curLTS);
	}
	function comprobarStockOrigen(datosArt:Array,codAlmacen:String,cantidad:Number):String {
		return this.ctx.prod_comprobarStockOrigen(datosArt,codAlmacen,cantidad);
	}
	function mostrarEmpresa():String {
		return this.ctx.prod_mostrarEmpresa();
	}
	function actualizarStockPteRecibir(idStock:Number):Boolean {
		return this.ctx.prod_actualizarStockPteRecibir(idStock);
	}
	function actualizarStockPteServir(idStock:Number):Boolean {
		return this.ctx.prod_actualizarStockPteServir(idStock);
	}
	function preguntarSiFabricado(referencia:String):Boolean {
		return this.ctx.prod_preguntarSiFabricado(referencia);
	 }
	function preguntarSiCrearLote(codLote:String):String {
		return this.ctx.prod_preguntarSiCrearLote(codLote);
	}
	function articuloVariable(referencia:String):Boolean {
		return this.ctx.prod_articuloVariable(referencia);
	}
	function buscarLote(localizador:String,cantidad:Number):String {
		return this.ctx.prod_buscarLote(localizador,cantidad);
	}
	function crearMovRegularizacionLote(codLote:String,cantidad:Number):Boolean {
		return this.ctx.prod_crearMovRegularizacionLote(codLote,cantidad);
	}
	function comprobarProcesosLoteABorrar(curLote:FLSqlCursor):Boolean {
		return this.ctx.prod_comprobarProcesosLoteABorrar(curLote);
	}
}
//// PRODUCCIÓN /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubProd */
/////////////////////////////////////////////////////////////////
//// PUB_PRODUCCION /////////////////////////////////////////////
class pubProd extends pubArticulosComp {
	//var xmlParametrosLote_:FLDomNode;
	function pubProd( context ) { pubArticulosComp( context ); }
	function pub_controlStockPedidosProv(curLP:FLSqlCursor):Boolean {
		return this.controlStockPedidosProv(curLP);
	}
	function pub_controlStockPresupuestosCli(curLP:FLSqlCursor):Boolean {
		return this.controlStockPresupuestosCli(curLP);
	}
	function pub_modificarFechaPedidoCli(curPedido:FLSqlCursor):Boolean {
		return this.modificarFechaPedidoCli(curPedido);
	}
	function pub_modificarFechaAlbaranCli(curAlbaran:FLSqlCursor):Boolean {
		return this.modificarFechaAlbaranCli(curAlbaran);
	}
	function pub_comprobarEvolStock(idStock:String):Boolean {
		return this.comprobarEvolStock(idStock);
	}
	function pub_modificarFechaPedidoProv(curPedido:FLSqlCursor):Boolean {
		return this.modificarFechaPedidoProv(curPedido);
	}
	function pub_modificarFechaAlbaranProv(curAlbaran:FLSqlCursor):Boolean {
		return this.modificarFechaAlbaranProv(curAlbaran);
	}
	function pub_graficoStock(idStock:String, avisar:Boolean):Boolean {
		return this.graficoStock(idStock, avisar);
	}
	function pub_stockActual(idStock:String):Number {
		return this.stockActual(idStock);
	}
	function pub_stockPteServir(idStock:String):Number {
		return this.stockPteServir(idStock);
	}
	function pub_datosEvolStock(idStock:String, fechaDesde:String, avisar:Boolean):Array {
		return this.datosEvolStock(idStock, fechaDesde, avisar);
	}
	function pub_planificarPedStock(arrayEvolStock:Array, plazoPedido:Number):Array {
		return this.planificarPedStock(arrayEvolStock, plazoPedido);
	}
	function pub_buscarIndiceAES(fecha:String, arrayEvolStock:Array):Number {
		return this.buscarIndiceAES(fecha, arrayEvolStock);
	}
	function pub_datosArticuloStock(idStock:String):Array {
		return this.datosArticuloStock(idStock);
	}
	function pub_generarMoviStock(curLinea:FLSqlCursor, codLote:String, cantidad:Number, curArticuloComp:FLSqlCursor,idProceso:String):Boolean {
		return this.generarMoviStock(curLinea, codLote, cantidad, curArticuloComp,idProceso);
	}
	function pub_almacenFabricacion(curLinea:FLSqlCursor,curArticuloComp:FLSqlCursor):String {
		return this.almacenFabricacion(curLinea,curArticuloComp);
	}
	function pub_datosProcesoArticulo(referencia:String):Array {
		return this.datosProcesoArticulo(referencia);
	}
	function pub_crearComposicion(curLoteStock:FLSqlCursor, curComponente:FLSqlCursor, refProceso:String, idProceso:String,primeraLlamada:Boolean):Boolean {
		return this.crearComposicion(curLoteStock, curComponente, refProceso, idProceso,primeraLlamada);
	}
	function pub_borrarComposicion(curLoteStock:FLSqlCursor, idProceso:FLSqlCursor):Boolean {
		return this.borrarComposicion(curLoteStock, idProceso);
	}
	function pub_mostrarEmpresa():String {
		return this.mostrarEmpresa();
	}
	function pub_actualizarStock(idStock:Number):Boolean {
		return this.actualizarStock(idStock);
	}
	function pub_revisarComponente(cursor:FLSqlCursor,idLinea:Number,codLote:String):Array {
		return this.revisarComponente(cursor,idLinea,codLote);
	}
	function pub_generarLoteStock(curLinea:FLSqlCursor, cantidad:Number, curArticuloComp:FLSqlCursor, idProceso:String):Boolean {
		return this.generarLoteStock(curLinea, cantidad, curArticuloComp, idProceso);
	}
}
//// PUB_PRODUCCION /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN /////////////////////////////////////////////////
function prod_controlStockPresupuestosCli(curLP:FLSqlCursor):Boolean
{
	switch (curLP.modeAccess()) {
		case curLP.Insert: {
			if (!this.iface.generarEstructura(curLP))
				return false;
			break;
		}
		case curLP.Edit: {
			var cantidad:String = curLP.valueBuffer("cantidad");
			var cantidadAnterior:String = curLP.valueBufferCopy("cantidad");
			var referencia:String = curLP.valueBuffer("referencia");
			var referenciaAnterior:String = curLP.valueBufferCopy("referencia");
			if (cantidad != cantidadAnterior || referencia != referenciaAnterior) {
				if (!this.iface.borrarEstructura(curLP))
					return false;
				if (!this.iface.generarEstructura(curLP))
					return false;
			}
			break;
		}
		case curLP.Del: {
			if (!this.iface.borrarEstructura(curLP))
				return false;
			break;
		}
	}
	return true;
}

function prod_controlStockPedidosCli(curLP:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLP.valueBuffer("referencia") + "'"))
		return true;

	switch (curLP.modeAccess()) {
		case curLP.Insert: {
			var idLineaPresupuesto:String = curLP.valueBuffer("idlineapresupuesto");
			var idLineaPedido:String = curLP.valueBuffer("idlinea");

			if (idLineaPresupuesto && idLineaPresupuesto != "" && idLineaPresupuesto != 0) {
				if (util.sqlSelect("movistock", "idmovimiento", "idlineapr = " + idLineaPresupuesto)) {
					if (!this.iface.pedirLineaPresCli(idLineaPresupuesto, curLP))
						return false;
				} else {
					if (!this.iface.generarEstructura(curLP))
						return false;
				}
			} else {
				if (!this.iface.generarEstructura(curLP))
					return false;
			}
			break;
		}
		case curLP.Edit: {
			var cantidad:String = curLP.valueBuffer("cantidad");
			var cantidadAnterior:String = curLP.valueBufferCopy("cantidad");
			var referencia:String = curLP.valueBuffer("referencia");
			var referenciaAnterior:String = curLP.valueBufferCopy("referencia");
			var cerrada:Boolean = curLP.valueBuffer("cerrada");
			var cerradaAnterior:Boolean = curLP.valueBufferCopy("cerrada");
			if (cantidad != cantidadAnterior || referencia != referenciaAnterior || cerrada != cerradaAnterior) {
				if (!this.iface.borrarEstructura(curLP))
					return false;
				if (!this.iface.generarEstructura(curLP))
					return false;
			}
			break;
		}
		case curLP.Del: {
			if (!this.iface.borrarEstructura(curLP))
				return false;
			break;
		}
	}

	return true;
}

function prod_controlStockComandasCli(curLC:FLSqlCursor):Boolean
{
	switch (curLC.modeAccess()) {
		case curLC.Insert: {
			if (!this.iface.generarEstructura(curLC))
				return false;
			break;
		}
		case curLC.Edit: {
			var cantidad:String = curLC.valueBuffer("cantidad");
			var cantidadAnterior:String = curLC.valueBufferCopy("cantidad");
			var referencia:String = curLC.valueBuffer("referencia");
			var referenciaAnterior:String = curLC.valueBufferCopy("referencia");
			if (cantidad != cantidadAnterior || referencia != referenciaAnterior) {
				if (!this.iface.borrarEstructura(curLC))
					return false;
				if (!this.iface.generarEstructura(curLC))
					return false;
			}
			break;
		}
		case curLC.Del: {
			if (!this.iface.borrarEstructura(curLC))
				return false;
			break;
		}
	}
	return true;
}

function prod_controlStockValesTPV(curLV:FLSqlCursor):Boolean
{
	switch (curLV.modeAccess()) {
		case curLV.Insert: {
			if (!this.iface.generarEstructura(curLV))
				return false;
			break;
		}
		case curLV.Edit: {
			var cantidad:String = curLV.valueBuffer("cantidad");
			var cantidadAnterior:String = curLV.valueBufferCopy("cantidad");
			var referencia:String = curLV.valueBuffer("referencia");
			var referenciaAnterior:String = curLV.valueBufferCopy("referencia");
			if (cantidad != cantidadAnterior || referencia != referenciaAnterior) {
				if (!this.iface.borrarEstructura(curLV))
					return false;
				if (!this.iface.generarEstructura(curLV))
					return false;
			}
			break;
		}
		case curLV.Del: {
			if (!this.iface.borrarEstructura(curLV))
				return false;
			break;
		}
	}
	return true;
}

function prod_controlStockPedidosProv(curLP:FLSqlCursor):Boolean
{
	switch (curLP.modeAccess()) {
		case curLP.Insert: {
			if (!this.iface.generarEstructura(curLP))
				return false;
			break;
		}
		case curLP.Edit: {
			var cantidad:String = curLP.valueBuffer("cantidad");
			var cantidadAnterior:String = curLP.valueBufferCopy("cantidad");
			var referencia:String = curLP.valueBuffer("referencia");
			var referenciaAnterior:String = curLP.valueBufferCopy("referencia");
			var cerrada:Boolean = curLP.valueBuffer("cerrada");
			var cerradaAnterior:Boolean = curLP.valueBufferCopy("cerrada");
			if (cantidad != cantidadAnterior || referencia != referenciaAnterior || cerrada != cerradaAnterior) {
				if (!this.iface.borrarEstructura(curLP))
					return false;
				if (!this.iface.generarEstructura(curLP))
					return false;
			}
			break;
		}
		case curLP.Del: {
			if (!this.iface.borrarEstructura(curLP))
				return false;
			break;
		}
	}
	return true;
}

function prod_controlStockAlbaranesCli(curLA:FLSqlCursor):Boolean
{
	var idLineaPedido:String = curLA.valueBuffer("idlineapedido");
	var idLineaAlbaran:String = curLA.valueBuffer("idlinea");

	if (idLineaPedido && idLineaPedido != "" && idLineaPedido != 0) {
		switch (curLA.modeAccess()) {
			case curLA.Insert: {
				if (!this.iface.albaranarLineaPedCli(idLineaPedido, curLA))
					return false;
				break;
			}
			case curLA.Edit: {
				var cantidad:Number = parseFloat(curLA.valueBuffer("cantidad"));
				var cantidadPrevia:Number = parseFloat(curLA.valueBufferCopy("cantidad"));
				if (cantidad == cantidadPrevia)
					break;
				if (!this.iface.desalbaranarLineaPedCli(idLineaPedido, idLineaAlbaran))
					return false;
				if (!this.iface.albaranarParcialLPC(idLineaPedido, curLA))
					return false;
				break;
			}
			case curLA.Del: {
				if (!this.iface.desalbaranarLineaPedCli(idLineaPedido, idLineaAlbaran))
					return false;
				break;
			}
		}
	} else {
		switch (curLA.modeAccess()) {
			case curLA.Insert: {
				if (!this.iface.generarEstructura(curLA))
					return false;
				break;
			}
			case curLA.Edit: {
				var cantidad:String = curLA.valueBuffer("cantidad");
				var cantidadAnterior:String = curLA.valueBufferCopy("cantidad");
				var referencia:String = curLA.valueBuffer("referencia");
				var referenciaAnterior:String = curLA.valueBufferCopy("referencia");
				if (cantidad != cantidadAnterior || referencia != referenciaAnterior) {
					if (!this.iface.borrarEstructura(curLA))
						return false;
					if (!this.iface.generarEstructura(curLA))
						return false;
				}
				break;
			}
			case curLA.Del: {
				if (!this.iface.borrarEstructura(curLA))
					return false;
				break;
			}
		}
	}
	return true;
}

function prod_controlStockAlbaranesProv(curLA:FLSqlCursor):Boolean
{
	var idLineaPedido:String = curLA.valueBuffer("idlineapedido");
	var idLineaAlbaran:String = curLA.valueBuffer("idlinea");

	if (idLineaPedido && idLineaPedido != "" && idLineaPedido != 0) {
		switch (curLA.modeAccess()) {
			case curLA.Insert: {
				if (!this.iface.albaranarLineaPedProv(idLineaPedido, curLA))
					return false;
				break;
			}
			case curLA.Edit: {
				var cantidad:Number = parseFloat(curLA.valueBuffer("cantidad"));
				var cantidadPrevia:Number = parseFloat(curLA.valueBufferCopy("cantidad"));
				if (cantidad == cantidadPrevia)
					break;
				if (!this.iface.desalbaranarLineaPedProv(idLineaPedido, idLineaAlbaran))
					return false;
				if (!this.iface.albaranarParcialLPP(idLineaPedido, curLA))
					return false;
				break;
			}
			case curLA.Del: {
				if (!this.iface.desalbaranarLineaPedProv(idLineaPedido, idLineaAlbaran))
					return false;
				break;
			}
		}
	} else {
		switch (curLA.modeAccess()) {
			case curLA.Insert: {
				if (!this.iface.generarEstructura(curLA))
					return false;
				break;
			}
			case curLA.Edit: {
				var cantidad:String = curLA.valueBuffer("cantidad");
				var cantidadAnterior:String = curLA.valueBufferCopy("cantidad");
				var referencia:String = curLA.valueBuffer("referencia");
				var referenciaAnterior:String = curLA.valueBufferCopy("referencia");
				if (cantidad != cantidadAnterior || referencia != referenciaAnterior) {
					if (!this.iface.borrarEstructura(curLA))
						return false;
					if (!this.iface.generarEstructura(curLA))
						return false;
				}
				break;
			}
			case curLA.Del: {
				if (!this.iface.borrarEstructura(curLA))
					return false;
				break;
			}
		}
	}
	return true;
}

function prod_controlStockFacturasCli(curLF:FLSqlCursor)
{
	return true;
}

function prod_controlStockFacturasProv(curLF:FLSqlCursor)
{
	return true;
}

/** \C Asocia los movimientos asociados a una línea de presupuesto a la línea de pedido
@param	idLineaPresupuesto: Identificador de la línea de presupuesto
@param	curLP: Cursor posicionado en la línea de pedido
\end */
function prod_pedirLineaPresCli(idLineaPresupuesto:String, curLP:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	var idLineaPedido:String = curLP.valueBuffer("idlinea");

	var curMoviStock:FLSqlCursor = new FLSqlCursor("movistock");
	curMoviStock.select("idlineapr = " + idLineaPresupuesto + " AND estado = 'PTE'");
	while (curMoviStock.next()) {
		curMoviStock.setModeAccess(curMoviStock.Edit);
		curMoviStock.refreshBuffer();
		curMoviStock.setValueBuffer("idlineapc", idLineaPedido);
		if (!curMoviStock.commitBuffer())
			return false;
	}
	return true;
}


/** \C Marca como HECHO los movimientos asociados a un línea de pedido, y los asocia a la línea de albarán
@param	idLineaPedido: Identificador de la línea de pedido
@param	curLA: Cursor posicionado en la línea de albarán
\end */
function prod_albaranarLineaPedCli(idLineaPedido:String, curLA:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	var idLineaAlbaran:String = curLA.valueBuffer("idlinea");
	var fechaAlbaran:String;
	var horaAlbaran:String;
	var curAlbaran:FLSqlCursor = curLA.cursorRelation();
	if (curAlbaran) {
		fechaAlbaran = curAlbaran.valueBuffer("fecha");
		horaAlbaran = curAlbaran.valueBuffer("hora");
	}
	else {
		fechaAlbaran = util.sqlSelect("albaranescli", "fecha", "idalbaran = " + curLA.valueBuffer("idalbaran"));
		horaAlbaran = util.sqlSelect("albaranescli", "hora", "idalbaran = " + curLA.valueBuffer("idalbaran"));
	}

	if (!fechaAlbaran)
		return false;


	horaAlbaran = horaAlbaran.toString();
	var hora:String = horaAlbaran.right(8);

	var curMoviStock:FLSqlCursor = new FLSqlCursor("movistock");
	curMoviStock.select("idlineapc = " + idLineaPedido + " AND estado = 'PTE'");
	while (curMoviStock.next()) {
		curMoviStock.setModeAccess(curMoviStock.Edit);
		curMoviStock.refreshBuffer();
		curMoviStock.setValueBuffer("estado", "HECHO");
		curMoviStock.setValueBuffer("fechareal", fechaAlbaran);
		curMoviStock.setValueBuffer("horareal", hora);
		curMoviStock.setValueBuffer("idlineaac", idLineaAlbaran);
		if (!curMoviStock.commitBuffer())
			return false;
	}
	return true;
}

/** \C Marca como HECHO los movimientos asociados a un línea de pedido, y los asocia a la línea de albarán
@param	idLineaPedido: Identificador de la línea de pedido
@param	curLA: Cursor posicionado en la línea de albarán
\end */
function prod_albaranarLineaPedProv(idLineaPedido:String, curLA:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	var idLineaAlbaran:String = curLA.valueBuffer("idlinea");
	var fechaAlbaran:String;
	var horaAlbaran:String;
	var curAlbaran:FLSqlCursor = curLA.cursorRelation();
	if (curAlbaran) {
		fechaAlbaran = curAlbaran.valueBuffer("fecha");
		horaAlbaran = curAlbaran.valueBuffer("hora");
	}
	else {
		fechaAlbaran = util.sqlSelect("albaranesprov", "fecha", "idalbaran = " + curLA.valueBuffer("idalbaran"));
		if (!fechaAlbaran)
			return false;

		horaAlbaran = util.sqlSelect("albaranesprov", "hora", "idalbaran = " + curLA.valueBuffer("idalbaran"));
	}


	horaAlbaran = horaAlbaran.toString();

	var hora:String = horaAlbaran.right(8);

	var curMoviStock:FLSqlCursor = new FLSqlCursor("movistock");
	curMoviStock.select("idlineapp = " + idLineaPedido + " AND estado = 'PTE'");
	while (curMoviStock.next()) {
		curMoviStock.setModeAccess(curMoviStock.Edit);
		curMoviStock.refreshBuffer();
		curMoviStock.setValueBuffer("estado", "HECHO");
		curMoviStock.setValueBuffer("fechareal", fechaAlbaran);
		curMoviStock.setValueBuffer("horareal", hora);
		curMoviStock.setValueBuffer("idlineaap", idLineaAlbaran);
		if (!curMoviStock.commitBuffer())
			return false;
	}
	return true;
}

/** \C Marca como PTE los movimientos asociados a un línea de albaran, y los desasocia de la línea. Si hay otros movimientos en estado PTE asociados a la línea de pedido, los unifica
@param	idLineaPedido: Identificador de la línea de pedido
@param	idLineaAlbaran: Identificador de la línea de albarán
\end */
function prod_desalbaranarLineaPedCli(idLineaPedido:String, idLineaAlbaran:String):Boolean
{
	var util:FLUtil = new FLUtil;

	var curMoviStock:FLSqlCursor = new FLSqlCursor("movistock");
	curMoviStock.select("idlineaac = " + idLineaAlbaran);
	var idMovimientoPte:String;
	while (curMoviStock.next()) {
		curMoviStock.setModeAccess(curMoviStock.Edit);
		curMoviStock.refreshBuffer();
		curMoviStock.setValueBuffer("estado", "PTE");
		curMoviStock.setNull("fechareal");
		curMoviStock.setNull("horareal");
		curMoviStock.setNull("idlineaac");
		if (!curMoviStock.commitBuffer())
			return false;
	}
	if (!this.iface.unificarMovPtePC(idLineaPedido))
		return false;

	return true;
}

/** \C Marca como PTE los movimientos asociados a un línea de albaran, y los desasocia de la línea. Si hay otros movimientos en estado PTE asociados a la línea de pedido, los unifica
@param	idLineaPedido: Identificador de la línea de pedido
@param	idLineaAlbaran: Identificador de la línea de albarán
\end */
function prod_desalbaranarLineaPedProv(idLineaPedido:String, idLineaAlbaran:String):Boolean
{
	var util:FLUtil = new FLUtil;

	var curMoviStock:FLSqlCursor = new FLSqlCursor("movistock");
	curMoviStock.select("idlineaap = " + idLineaAlbaran);
	var idMovimientoPte:String;
	while (curMoviStock.next()) {
		curMoviStock.setModeAccess(curMoviStock.Edit);
		curMoviStock.refreshBuffer();
		curMoviStock.setValueBuffer("estado", "PTE");
		curMoviStock.setNull("fechareal");
		curMoviStock.setNull("horareal");
		curMoviStock.setNull("idlineaap");
		if (!curMoviStock.commitBuffer())
			return false;
	}
	if (!this.iface.unificarMovPtePP(idLineaPedido))
		return false;

	return true;
}

/** \C Unifica en un único movimiento todos los movimientos pendientes asociados a la misma línea de pedido y lote (para cada referencia -esto se usa cuando el artículo es compuesto-)
@param	idLineaPedido: Identificador de la línea de pedido
\end */
function prod_unificarMovPtePC(idLineaPedido:String):Boolean
{
	var util:FLUtil = new FLUtil;
	var qryReferencia:FLSqlQuery = new FLSqlQuery;
	with (qryReferencia) {
		setTablesList("movistock");
		setSelect("idstock, codlote, SUM(cantidad)");
		setFrom("movistock");
		setWhere("idlineapc = " + idLineaPedido + " AND estado = 'PTE' GROUP BY idstock, codlote");
		setForwardOnly(true);
	}
	if (!qryReferencia.exec())
		return false;

	var cantidadPte:Number;
	var idMovimiento:String;
	while (qryReferencia.next()) {
		cantidadPte = parseFloat(qryReferencia.value("SUM(cantidad)"));
		if (!cantidadPte || isNaN(cantidadPte))
			return true;
		idMovimiento = util.sqlSelect("movistock", "idmovimiento", "idlineapc = " + idLineaPedido + " AND estado = 'PTE' AND idstock = " + qryReferencia.value("idstock") + " AND codlote = '" + qryReferencia.value("codlote") + "'");
		if (!idMovimiento)
			return true;

		if (!util.sqlDelete("movistock", "idlineapc = " + idLineaPedido + " AND estado = 'PTE' AND idmovimiento <> " + idMovimiento + " AND idstock = " + qryReferencia.value("idstock") + " AND codlote = '" + qryReferencia.value("codlote") + "'"))
			return false;
		if (!util.sqlUpdate("movistock", "cantidad", cantidadPte, "idmovimiento = " + idMovimiento))
			return false;
	}
	return true;
}

/** \C Unifica en un único movimiento todos los movimientos pendientes asociados a una línea de pedido (para cada referencia -esto se usa cuando el artículo es compuesto-)
@param	idLineaPedido: Identificador de la línea de pedido
\end */
function prod_unificarMovPtePP(idLineaPedido:String):Boolean
{
	var util:FLUtil = new FLUtil;
	var qryReferencia:FLSqlQuery = new FLSqlQuery;
	with (qryReferencia) {
		setTablesList("movistock");
		setSelect("idstock, SUM(cantidad)");
		setFrom("movistock");
		setWhere("idlineapp = " + idLineaPedido + " AND estado = 'PTE' GROUP BY idstock");
		setForwardOnly(true);
	}
	if (!qryReferencia.exec())
		return false;

	var cantidadPte:Number;
	var idMovimiento:String;
	while (qryReferencia.next()) {
		cantidadPte = parseFloat(qryReferencia.value("SUM(cantidad)"));
		if (!cantidadPte || isNaN(cantidadPte))
			return true;
		idMovimiento = util.sqlSelect("movistock", "idmovimiento", "idlineapp = " + idLineaPedido + " AND estado = 'PTE' AND idstock = " + qryReferencia.value("idstock"));
		if (!idMovimiento)
			return true;

		if (!util.sqlDelete("movistock", "idlineapp = " + idLineaPedido + " AND estado = 'PTE' AND idmovimiento <> " + idMovimiento + " AND idstock = " + qryReferencia.value("idstock")))
			return false;
		if (!util.sqlUpdate("movistock", "cantidad", cantidadPte, "idmovimiento = " + idMovimiento))
			return false;
	}
	return true;
}

/** \C Divide los movimientos pendientes de una línea de pedido y asocia la parte correspondiente a una línea de albarán
@param	idLineaPedido: Identificador de la línea de pedido
@param	curLA: Cursor posicionado en la línea de albarán
\end */
function prod_albaranarParcialLPC(idLineaPedido:String, curLA:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	if (!this.iface.curMoviStock)
		this.iface.curMoviStock = new FLSqlCursor("movistock");

	var cantidadPedido:Number = parseFloat(util.sqlSelect("lineaspedidoscli", "cantidad", "idlinea = "  + idLineaPedido));

	var fechaAlbaran:String;
	var horaAlbaran:String;
	var curAlbaran:FLSqlCursor = curLA.cursorRelation();
	if (curAlbaran) {
		fechaAlbaran = curAlbaran.valueBuffer("fecha");
		horaAlbaran = curAlbaran.valueBuffer("hora");
	}
	else {
		fechaAlbaran = util.sqlSelect("albaranescli", "fecha", "idalbaran = " + curLA.valueBuffer("idalbaran"));
		horaAlbaran = util.sqlSelect("albaranescli", "hora", "idalbaran = " + curLA.valueBuffer("idalbaran"));
	}

	if (!fechaAlbaran)
		return false;

	var hora:String = fechaAlbaran.toString().left(11) + horaAlbaran.toString().right(8);

	var curMSOrigen:FLSqlCursor = new FLSqlCursor("movistock");
	curMSOrigen.select("idlineapc = " + idLineaPedido + " AND estado = 'PTE'");
	var cantidadPte:Number;
	var cantidadAlb:Number;
	var factor:Number;
	var cantidadMovi:Number;
	while (curMSOrigen.next()) {
		curMSOrigen.setModeAccess(curMSOrigen.Edit);
		curMSOrigen.refreshBuffer();

		cantidadMovi = parseFloat(util.sqlSelect("movistock", "SUM(cantidad)", "idlineapc = "  + 	idLineaPedido + " AND idstock = " + curMSOrigen.valueBuffer("idstock")));
		factor = cantidadMovi / cantidadPedido;

		cantidadPte = curMSOrigen.valueBuffer("cantidad");
		cantidadAlb = curLA.valueBuffer("cantidad") * factor;
		cantidadPte -= cantidadAlb;
		if (cantidadPte > 0) {
			MessageBox.warning(util.translate("scripts", "No puede establecer una cantidad albaranada superior a la cantidad de la línea de pedido asociada.\nSi realmente va a servir más cantidad que la pedida indíquelo en una nueva línea de albarán"), MessageBox.Ok,  MessageBox.NoButton);
			return false;
		}
		cantidadPte = util.roundFieldValue(cantidadPte, "movistock", "cantidad");
		cantidadAlb = util.roundFieldValue(cantidadAlb, "movistock", "cantidad");

		if (cantidadAlb == 0)
			return false;

		this.iface.curMoviStock.setModeAccess(this.iface.curMoviStock.Insert);
		this.iface.curMoviStock.refreshBuffer();
		if (!this.iface.copiaDatosMoviStock(curMSOrigen))
			return false;

		this.iface.curMoviStock.setValueBuffer("cantidad", cantidadAlb);
		this.iface.curMoviStock.setValueBuffer("fechareal", fechaAlbaran);
		this.iface.curMoviStock.setValueBuffer("horareal", hora);
		this.iface.curMoviStock.setValueBuffer("idlineaac", curLA.valueBuffer("idlinea"));
		this.iface.curMoviStock.setValueBuffer("idlineapc", curMSOrigen.valueBuffer("idlineapc"));

		if (cantidadPte == 0) {
			curMSOrigen.setModeAccess(curMSOrigen.Del);
			curMSOrigen.refreshBuffer();
		} else {
			curMSOrigen.setValueBuffer("cantidad", cantidadPte);
		}

		if (!curMSOrigen.commitBuffer())
			return false;

		if (!this.iface.curMoviStock.commitBuffer())
			return false;
	}
	return true;
}

function prod_copiaDatosMoviStock(curMSOrigen:FLSqlCursor):Boolean
{
	with (this.iface.curMoviStock) {
		setValueBuffer("referencia", curMSOrigen.valueBuffer("referencia"));
		setValueBuffer("estado", "HECHO");
		setValueBuffer("fechaprev", curMSOrigen.valueBuffer("fechaprev"));
		setValueBuffer("idstock", curMSOrigen.valueBuffer("idstock"));
		setValueBuffer("codlote", curMSOrigen.valueBuffer("codlote"));
		setValueBuffer("codloteprod", curMSOrigen.valueBuffer("codloteprod"));
	}
	if (curMSOrigen.isNull("idarticulocomp")) {
		this.iface.curMoviStock.setNull("idarticulocomp");
	} else {
		this.iface.curMoviStock.setValueBuffer("idarticulocomp", curMSOrigen.valueBuffer("idarticulocomp"));
	}
	if (curMSOrigen.isNull("idtipotareapro")) {
		this.iface.curMoviStock.setNull("idtipotareapro");
	} else {
		this.iface.curMoviStock.setValueBuffer("idtipotareapro", curMSOrigen.valueBuffer("idtipotareapro"));
	}

	return true;
}


/** \C Divide los movimientos pendientes de una línea de pedido y asocia la parte correspondiente a una línea de albarán
@param	idLineaPedido: Identificador de la línea de pedido
@param	curLA: Cursor posicionado en la línea de albarán
\end */
function prod_albaranarParcialLPP(idLineaPedido:String, curLA:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	if (!this.iface.curMoviStock)
		this.iface.curMoviStock = new FLSqlCursor("movistock");

	var cantidadPedido:Number = parseFloat(util.sqlSelect("lineaspedidosprov", "cantidad", "idlinea = "  + idLineaPedido));

	var fechaAlbaran:String;
	var horaAlbaran:String;
	var curAlbaran:FLSqlCursor = curLA.cursorRelation();
	if (curAlbaran) {
		fechaAlbaran = curAlbaran.valueBuffer("fecha");
		horaAlbaran = curAlbaran.valueBuffer("hora");
	}
	else {
		fechaAlbaran = util.sqlSelect("albaranesprov", "fecha", "idalbaran = " + curLA.valueBuffer("idalbaran"));
		horaAlbaran = util.sqlSelect("albaranesprov", "hora", "idalbaran = " + curLA.valueBuffer("idalbaran"));
	}

	if (!fechaAlbaran)
		return false;

	horaAlbaran = horaAlbaran.toString();

	var hora:String = horaAlbaran.right(8);

	var curMSOrigen:FLSqlCursor = new FLSqlCursor("movistock");
	curMSOrigen.select("idlineapp = " + idLineaPedido + " AND estado = 'PTE'");
	var cantidadPte:Number;
	var cantidadAlb:Number;
	var factor:Number;
	var cantidadMovi:Number;
	while (curMSOrigen.next()) {
		curMSOrigen.setModeAccess(curMSOrigen.Edit);
		curMSOrigen.refreshBuffer();

		cantidadMovi = parseFloat(util.sqlSelect("movistock", "SUM(cantidad)", "idlineapp = "  + 	idLineaPedido + " AND idstock = " + curMSOrigen.valueBuffer("idstock")));
		factor = cantidadMovi / cantidadPedido;

		cantidadPte = curMSOrigen.valueBuffer("cantidad");
		cantidadAlb = curLA.valueBuffer("cantidad") * factor;
		cantidadPte -= cantidadAlb;
		if (cantidadPte < 0) {
			MessageBox.warning(util.translate("scripts", "No puede establecer una cantidad albaranada superior a la cantidad de la línea de pedido asociada.\nSi realmente va a servir más cantidad que la pedida indíquelo en una nueva línea de albarán"), MessageBox.Ok,  MessageBox.NoButton);
			return false;
		}
		cantidadPte = util.roundFieldValue(cantidadPte, "movistock", "cantidad");
		cantidadAlb = util.roundFieldValue(cantidadAlb, "movistock", "cantidad");

		if (cantidadAlb == 0)
			return false;

		this.iface.curMoviStock.setModeAccess(this.iface.curMoviStock.Insert);
		this.iface.curMoviStock.refreshBuffer();

		if (!this.iface.copiaDatosMoviStock(curMSOrigen))
			return false;

		this.iface.curMoviStock.setValueBuffer("cantidad", cantidadAlb);
		this.iface.curMoviStock.setValueBuffer("fechareal", fechaAlbaran);
		this.iface.curMoviStock.setValueBuffer("horareal", hora);
		this.iface.curMoviStock.setValueBuffer("idlineaap", curLA.valueBuffer("idlinea"));
		this.iface.curMoviStock.setValueBuffer("idlineapp", curMSOrigen.valueBuffer("idlineapp"));

		if (cantidadPte == 0) {
			curMSOrigen.setModeAccess(curMSOrigen.Del);
			curMSOrigen.refreshBuffer();
		} else {
			curMSOrigen.setValueBuffer("cantidad", cantidadPte);
		}

		if (!curMSOrigen.commitBuffer())
			return false;

		if (!this.iface.curMoviStock.commitBuffer())
			return false;
	}
	return true;
}

/** \D Genera la estructura de lotes de stock y salidas programadas asociada a los artículos pedidos
\end */
function prod_generarEstructura(curLinea:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	var referencia:String = curLinea.valueBuffer("referencia");
	if (!referencia || referencia == "")
		return true;

	var tipoStock:String = util.sqlSelect("articulos", "tipostock", "referencia = '" + referencia + "'");
	switch (tipoStock) {
		case "Granel": {
			if (!this.iface.generarMoviStock(curLinea, false))
				return false;
			break;
		}
		case "Lotes": {
			if (!this.iface.generarLoteStock(curLinea))
				return false;
			break;
		}
		case "Sin stock": {
			return true;
			break;
		}
		default: {
			MessageBox.warning(util.translate("scripts", "Error: Intenta generar una entrada / salida para un artículo de tipo Grupo base.\nLos artículos de este tipo deben formar parte de artículos a granel o por lotes,\nque son los artículos sujetos a entrada / salida."), MessageBox.Ok, MessageBox.NoButton);
			return false;
/*
			if (!this.iface.generarMoviStock(curLinea, false))
				return false;
*/
			break;
		}
	}
	return true;
}

/** \D Asocia un lote de stock (creándolo o buscando uno ya existente) a una línea de facturación o a un lote de stock
@param	curLinea: Línea de facturación o lote de stock al que asociar el nuevo lote
@param	cantidad: Cantidad del lote a crear
@param	curArticuloComp: Cursor de composición para la creación de lotes que forman parte de un artículo
@param	idProceso: Proceso al cual asociar el movimiento de stock que se creará asociado al nuevo lote
\end */
function prod_generarLoteStock(curLinea:FLSqlCursor, cantidad:Number, curArticuloComp:FLSqlCursor, idProceso:String):Boolean
{
	var util:FLUtil = new FLUtil;
	var codLote:String;
	var referencia:String
	switch (curLinea.table()) {
		case "lineaspresupuestoscli": {
			//Para lineas de presupuesto en principio no debe generarse la estructura.
			break;
		}
		case "lotesstock":
		case "lineaspedidoscli":
		case "tpv_lineascomanda":
		case "lineasalbaranescli": {
			if (!this.iface.buscarLoteDisponible(curLinea, cantidad, curArticuloComp, idProceso)) {
				return false;
			}
			break;
		}
		case "lineaspedidosprov":
		case "tpv_lineasvale": /// Por hacer: En el caso de vales buscar el mismo lote que el de la línea de comanda devuelta
		case "lineasalbaranesprov": {
			var datosArt:Array = this.iface.datosArticulo(curLinea);
			var codLote:String = this.iface.crearLote(datosArt, curLinea.valueBuffer("cantidad"));
			if (!codLote) {
				return false;
			}

			if (!this.iface.generarMoviStock(curLinea, codLote, false, false, idProceso)) {
				return false;
			}
		}
	}

	if (!this.iface.consistenciaLinea(curLinea))
		return false;

	return true;
}

function prod_asignarMoviStockSinLote(codLote:String):Boolean
{
	var util:FLUtil;
	var referencia:String = util.sqlSelect("lotesstock","referencia","codlote = '" + codLote + "'");
	if (!referencia || referencia == "")
		return false;

	var cantDisponible:Number = parseFloat(util.sqlSelect("lotesstock","candisponible","codlote = '" + codLote + "'"));

	var curMS:FLSqlCursor = new FLSqlCursor("movistock");
	curMS.select("referencia = '" + referencia + "' AND (codlote IS NULL OR codlote = '') AND cantidad < " + cantDisponible + " ORDER BY fechaprev");
	if (!curMS.first())
		return true;

	var res:Number = MessageBox.information(util.translate("scripts", "Hay movimientos para el artículo %1 sin lote asociado . ¿Desea asociar el nuevo lote a estos movimientos?").arg(referencia), MessageBox.Yes, MessageBox.No);
	if (res != MessageBox.Yes)
		return true;

	var canMS:Number;
	do {
		curMS.setModeAccess(curMS.Edit);
		curMS.refreshBuffer();
		canMS = parseFloat(curMS.valueBuffer("cantidad"));
		if (canMS > cantDisponible)
			continue;
		curMS.setValueBuffer("codlote", codLote);
		if (!curMS.commitBuffer())
			return false;

		cantDisponible -= canMS;
	} while (curMS.next());

	return true;
}

/** \D Busca lotes disponibles de artículos no fabricados para asignarles movimientos de salida
@param	curLinea: Cursor del objeto que origina la salida (albarán o pedido de cliente o lote de stock en los casos de fabricación)
@param	cantidad: Cantidad a reservar
@param	curArticuloComp: Cursor del componente cuyo lote se busca, para los casos de fabricación
@param	idProceso: Proceso al que asociar el movimiento de stock a crear
@return	True si la función termina correctamente, false en caso contrario
\end */
function prod_buscarLoteDisponible(curLinea:FLSqlCursor, cantidad:Number, curArticuloComp:FLSqlCursor, idProceso:String):Boolean
{
	var util:FLUtil = new FLUtil;
	var codLote:String = false;
	var referencia:String
	var datosArt:Array;
	var idLinea:Number = false;

	if (curLinea.table() == "lotesstock") {
		datosArt = this.iface.datosArticulo(curArticuloComp);
		if (!cantidad)
			cantidad = curLinea.valueBuffer("candisponible");
		idLinea = curLinea.valueBuffer("idlineapc");
	} else {
		datosArt = this.iface.datosArticulo(curLinea);
		if (!cantidad)
			cantidad = curLinea.valueBuffer("cantidad");
		if(curLinea.table() == "lineaspedidoscli")
			idLinea = curLinea.valueBuffer("idlinea");
	}

	var datosProceso:Array = this.iface.datosProcesoArticulo(datosArt["referencia"]);
	if (!datosProceso) {
		return false;
	}
	var fabricado:Boolean = (datosProceso["produccion"] && datosProceso["tipoproduccion"] == "F");

// 	var fabricado:String = util.sqlSelect("articulos a INNER JOIN pr_tiposproceso tp ON a.idtipoproceso = tp.idtipoproceso", "tp.tipoproduccion", "a.referencia = '" + datosArt["referencia"] + "' AND a.fabricado");

	var comprado:Boolean = util.sqlSelect("articulos", "secompra", "referencia = '" + datosArt["referencia"] + "'");

	var variable:Boolean = util.sqlSelect("articulos","variable","referencia = '" + datosArt["referencia"] + "'");

	if(fabricado && comprado && !variable) {
		if(!this.iface.preguntarSiFabricado(datosArt["referencia"]))
			fabricado = false;
	}

	var hayDisponible:Boolean = false;

	if (fabricado && curLinea.table() == "lineaspresupuestoscli") {
		// Por hacer
		MessageBox.warning(util.translate("scripts", "No pueden presupuestarse artículos de fabricación"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	var loteUnico:Boolean = util.sqlSelect("articulos", "loteunico", "referencia = '" + datosArt["referencia"] + "'");


	if (loteUnico) {
		if(!variable) {
			codLote = this.iface.buscarLote(datosArt["localizador"],cantidad);
			if(fabricado && codLote && codLote != "")
				codLote = this.iface.preguntarSiCrearLote(codLote);
		}
		if (!codLote) {
			if (fabricado) {
				codLote = this.iface.crearLote(datosArt, cantidad, idLinea);
				if (!codLote)
					return false;
			}
		}
		if (!this.iface.generarMoviStock(curLinea, codLote, cantidad, curArticuloComp, idProceso))
			return false;
	} else {
		var completado:Boolean = false;
		var cantidadRestante:Number = parseFloat(cantidad);
		var disponible:Number;
		var preguntado:Boolean = false;
		while (!completado) {
			if(!variable) {
				codLote = this.iface.buscarLote(datosArt["localizador"],cantidadRestante);
				if(fabricado && !preguntado && codLote && codLote != "")  {
					codLote = this.iface.preguntarSiCrearLote(codLote);
					preguntado == true;
				}
			}
			if (codLote) {
				if (!this.iface.generarMoviStock(curLinea, codLote, cantidad, curArticuloComp, idProceso))
					return false;
				completado = true;
			} else {
				if(!variable) {
					codLote = this.iface.buscarLote(datosArt["localizador"],0);
					if(fabricado && !preguntado && codLote && codLote != "")  {
						codLote = this.iface.preguntarSiCrearLote(codLote);
						preguntado == true;
					}
				}
				if (codLote) {
					disponible = parseFloat(util.sqlSelect("lotesstock", "candisponible", "codlote = '" + codLote + "'"));
					if (!disponible || isNaN(disponible))
						disponible = 0;
					if (disponible > cantidadRestante)
						disponible = cantidadRestante;
					if (!this.iface.generarMoviStock(curLinea, codLote, disponible, curArticuloComp, idProceso))
						return false;
					cantidadRestante = cantidadRestante - disponible;
					hayDisponible = true;
					if (cantidadRestante == 0)
						completado = true;
				} else {
					if (fabricado) {
						codLote = this.iface.crearLote(datosArt, cantidadRestante, idLinea);
						if (!codLote)
							return false;
					} /*else {
						if (util.sqlSelect("articuloscomp", "id", "refcompuesto = '" + datosArt["referencia"] + "'")) {
							codLote = this.iface.crearLote(datosArt, cantidadRestante, idLinea);
							if (!codLote)
								return false;
						} else {
							MessageBox.warning(util.translate("scripts", "No hay suficiente cantidad disponible del artículo %1 en lotes de stock").arg(datosArt["referencia"]), MessageBox.Ok, MessageBox.NoButton);
						}
					}*/
					if (!this.iface.generarMoviStock(curLinea, codLote, cantidadRestante, curArticuloComp, idProceso))
						return false;
					completado = true;
				}
			}
		}
	}
	if (fabricado && hayDisponible) {
		MessageBox.information(util.translate("scripts", "Una parte o la totalidad de la línea ha sido asignada a lotes ya disponibles"), MessageBox.Ok, MessageBox.NoButton);
	}
	return true;
}

function prod_buscarLote(localizador:String,cantidad:Number):String
{
	var util:FLUtil;

	var codLote:String = util.sqlSelect("lotesstock", "codlote", localizador + " AND candisponible >= " + cantidad + " AND candisponible <> 0 ORDER BY candisponible");
	if(!codLote || codLote == "")
		return false;

	return codLote;
}

function prod_articuloVariable(referencia:String):Boolean
{
	var util:FLUtil;

	if(!util.sqlSelect("articuloscomp","id","refcompuesto = '" + referencia + "'"))
		return false;

	if(util.sqlSelect("articuloscomp","id","refcompuesto = '" + referencia + "' AND codfamiliacomponente IS NOT NULL AND codfamiliacomponente <> ''"))
		return true;

	if(util.sqlSelect("articuloscomp","id","refcompuesto = '" + referencia + "' AND idopcionarticulo IS NOT NULL AND idopcionarticulo <> 0"))
		return true;

	return false;
}

function prod_preguntarSiFabricado(referencia:String):Boolean
{
	var util:FLUtil;
	var res:Number = MessageBox.warning(util.translate("scripts", "El artículo %1 está definido como artículo de fabricación y de compra.\n¿Desea fabricarlo? (Si elige sí se creará el lote de fabricación correspondiente).").arg(referencia), MessageBox.Yes, MessageBox.No);
	if(res != MessageBox.Yes)
		return false;

	return true;
}

function prod_preguntarSiCrearLote(codLote:String):String
{
	var util:FLUtil;

	var referencia:String = util.sqlSelect("lotesstock","referencia","codlote = '" + codLote + "'");
	var res:Number = MessageBox.warning(util.translate("scripts", "Se ha encontrado el lote %1 disponible con cantidad suficiente del artículo %2. ¿Desea utilizalo?").arg(codLote).arg(referencia), MessageBox.Yes, MessageBox.No);
	if(res != MessageBox.Yes)
		return false;

	return codLote;
}
/** \D Función a sobrecargar por extensiones como la de barcodes
@param	cursor: Cursor que contiene los datos que identifican el artículo
@param	codLote: Código del lote del artículo
@return	array con datos identificativos del artículo
\end */
function prod_datosArticulo(cursor:FLSqlCursor, codLote:String):Array
{
	var util:FLUtil = new FLUtil;
	var res:Array = [];
	var referencia:String = "";

	switch (cursor.table()) {
		case "articuloscomp": {
			referencia = cursor.valueBuffer("refcomponente")
			break;
		}
		case "pr_procesos": {
			referencia = util.sqlSelect("lotesstock", "referencia", "codlote = '" + cursor.valueBuffer("idobjeto") + "'");
			if (!referencia || referencia == "")
				return false;
			break;
		}
		default: {
			referencia = cursor.valueBuffer("referencia")
			break;
		}
	}
	res["localizador"] = "referencia = '" + referencia + "'";
	res["referencia"] = referencia;


	return res;
}

/** \C En el caso de que el componente sea una familia, mostrará la lista de artículos de dicha familia para que el usuario seleccione el artículo deseado
@param	cursor: Cursor del componente
@return array con los siguientes valores:
* Cantidad: Cantidad del componente
* Referencia: Referencia del componente seleccionado
\end */
function prod_revisarComponente(cursor:FLSqlCursor,idLinea:Number,codLote:String):Array
{
	var util:FLUtil;
	var res:Array = new Array();

	res["cantidad"] = cursor.valueBuffer("cantidad");
	res["referencia"] = cursor.valueBuffer("refcomponente");
	if (res["referencia"] && res["referencia"] != "")
		return res;

	var codFamilia:String = cursor.valueBuffer("codfamiliacomponente");

	if (!codFamilia || codFamilia == "")
		return false;

	this.iface.idComponenteActual_ = cursor.valueBuffer("id");

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

	var eLote:FLDomElement = xmlLote.toElement();
	var componentes:FLDomElement = eLote.namedItem("Componentes").toElement();
	var componente:FLDomElement;
	var whereOpciones:String = "";
	for (var nodoComp:FLDomNode = componentes.firstChild(); nodoComp; nodoComp = nodoComp.nextSibling()) {
		componente = nodoComp.toElement();
		if(this.iface.idComponenteActual_ == componente.attribute("IdArticuloComp")) {
			res["referencia"] = componente.attribute("Referencia");
			break;
		}
	}

	if (res["referencia"] && res["referencia"] != "")
		return res;

	var f:Object = new FLFormSearchDB("buscarcomponente");
	var curArticulos:FLSqlCursor = f.cursor();
	var lista:String = this.iface.calcularFiltroReferencia(cursor.valueBuffer("refcompuesto"));
	if (!lista || lista == "")
		curArticulos.setMainFilter("codfamilia = '" + codFamilia + "'");
	else
		curArticulos.setMainFilter("codfamilia = '" + codFamilia + "' AND referencia NOT IN (" + lista + ")");

	f.setMainWidget();

	res["referencia"] = f.exec("referencia");

	if (!res["referencia"])
		return false;

	var eComponente:FLDomElement = xmlDocLote.createElement("Componente");
	xmlLote.namedItem("Componentes").appendChild(eComponente);
	eComponente.setAttribute("IdArticuloComp",this.iface.idComponenteActual_);
	eComponente.setAttribute("Referencia",res["referencia"]);

	if(!util.sqlUpdate("lotesstock","xmlparametros",xmlDocLote.toString(4),"codlote = '" + codLote + "'"))
		return false;

	return res;
}

function prod_crearLote(datosArt:Array, cantidad:Number, idLinea:Number):String
{
	var curLoteStock:FLSqlCursor = new FLSqlCursor("lotesstock");
	curLoteStock.setModeAccess(curLoteStock.Insert);
	curLoteStock.refreshBuffer();
	curLoteStock.setValueBuffer("referencia", datosArt["referencia"]);
	var codLote:String = formRecordlotesstock.iface.pub_calculateCounter(curLoteStock);
	curLoteStock.setValueBuffer("codlote", codLote);
	curLoteStock.setValueBuffer("estado", "PTE");
	curLoteStock.setValueBuffer("canlote", cantidad);
	curLoteStock.setValueBuffer("cantotal", 0);
	curLoteStock.setValueBuffer("canusada", 0);
	curLoteStock.setValueBuffer("candisponible", 0);
	if(idLinea && idLinea != 0)
		curLoteStock.setValueBuffer("idlineapc", idLinea);

// 	if (sys.isLoadedModule("flprodppal")) {
// 		var parametros:String = this.iface.parametrosLote(curLoteStock);
// 		if (!parametros) {
// 			return false;
// 		}
// 		if (parametros != "") {
// 			curLoteStock.setValueBuffer("xmlparametros", parametros);
// 		}
// 	}

	if (!curLoteStock.commitBuffer())
		return false;

	return codLote;
}


/** \D Borra la estructura de lotes de stock y salidas programadas asociada a los artículos pedidos
\end */
function prod_borrarEstructura(curLinea:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	var referencia:String = curLinea.valueBuffer("referencia");
	if (!referencia || referencia == "")
		return true;

	if (!this.iface.borrarMoviStock(curLinea))
		return false;

	return true;
}

/** \D Genera un movimiento de stock asociado a una línea de facturación y opcionalmente a un lote de producción
@param	curLinea: Línea de facturación, Lote de stock o Proceso de producción
@param	codLote: Lote de producción al que asociar el movimiento (opcional)
@param	cantidad: Cantidad del movimiento, cuando es distinta de la de la curLinea o no está contenido en este cursor (opcional).
@param	idProceso: Proceso al que se asociará el movimiento de stock
\end */
function prod_generarMoviStock(curLinea:FLSqlCursor, codLote:String, cantidad:Number, curArticuloComp:FLSqlCursor, idProceso:String):Boolean
{
	var util:FLUtil = new FLUtil;

	var idLinea:String;
	var idPadre:String;
	var fechaPrev:String;
	var fechaReal:String;
	var horaReal:String;
	var codAlmacen:String;
	var codAlmacenOrigen:String;
	var codAlmacenDestino:String;
	var referencia:String;
	var datosArt:Array;

	var tabla:String = curLinea.table();

	switch (tabla) {
		case "lineaspedidoscli": {
			if(curLinea.valueBuffer("cerrada"))
				return true;
		}
		case "lineaspresupuestoscli":
		case "lineasalbaranescli":
		case "pr_procesos":
		case "tpv_lineascomanda":
		case "tpv_lineasvale":
		case "lotesstock":
		case "lineastransstock": {
			if (curArticuloComp) {
				datosArt = this.iface.datosArticulo(curArticuloComp);
			} else {
				datosArt = this.iface.datosArticulo(curLinea, codLote);
			}
			if (datosArt["referencia"] == "")
				return true;

			if (!cantidad || isNaN(cantidad))
				cantidad = this.iface.establecerCantidad(curLinea);
			if(!cantidad)
				return true;

			if(!idProceso)
				idProceso = curLinea.valueBuffer("idproceso");

			var idTipoProceso:String = "";
			var whereTipoProceso:String = "";
			if(idProceso)
				idTipoProceso = util.sqlSelect("pr_procesos","idtipoproceso","idproceso = " + idProceso);
			if(idTipoProceso && idTipoProceso != "")
				whereTipoProceso = " AND ac.idtipotareapro IN (SELECT idtipotareapro FROM pr_tipostareapro WHERE idtipoproceso = '" + idTipoProceso + "')";

			/** Para artículos compuestos que no son fabricados, se crean tantos movimientos de stock como componentes haya */
			if (util.sqlSelect("articulos a INNER JOIN articuloscomp ac ON a.referencia = ac.refcompuesto", "a.referencia", "a.referencia = '" + referencia + "' AND (a.fabricado = false OR a.fabricado IS NULL)" + whereTipoProceso, "articulos,articuloscomp")) {
				var nuevaCantidad:Number;
				var curAC:FLSqlCursor = new FLSqlCursor("articuloscomp");
				curAC.select("refcompuesto = '" + datosArt["referencia"] + "'");
				while (curAC.next()) {
					curAC.setModeAccess(curAC.Browse);
					curAC.refreshBuffer();
					nuevaCantidad = cantidad * curAC.valueBuffer("cantidad");
					if (!this.iface.generarMoviStock(curLinea, codLote, nuevaCantidad, curAC))
						return false;
				}
				return true;
			}

			idLinea = curLinea.valueBuffer("idlinea");
			switch (tabla) {
				case "lineaspresupuestoscli": {
					idPadre = curLinea.valueBuffer("idpresupuesto");
					fechaPrev = util.sqlSelect("presupuestoscli", "fechasalida", "idpresupuesto = " + idPadre);
					codAlmacen = util.sqlSelect("presupuestoscli", "codalmacen", "idpresupuesto = " + idPadre);
					break;
				}
				case "lineaspedidoscli": {
					idPadre = curLinea.valueBuffer("idpedido");
					fechaPrev = util.sqlSelect("pedidoscli", "fechasalida", "idpedido = " + idPadre);
					codAlmacen = util.sqlSelect("pedidoscli", "codalmacen", "idpedido = " + idPadre);
					break;
				}
				case "tpv_lineascomanda": {
					idLinea = curLinea.valueBuffer("idtpv_linea");
					idPadre = curLinea.valueBuffer("idtpv_comanda");
					fechaReal = util.sqlSelect("tpv_comandas", "fecha", "idtpv_comanda = " + idPadre);
					codAlmacen = util.sqlSelect("tpv_comandas c INNER JOIN tpv_puntosventa pv ON c.codtpv_puntoventa = pv.codtpv_puntoventa", "pv.codalmacen", "idtpv_comanda = " + idPadre, "tpv_comandas,tpv_puntosventa");
					break;
				}
				case "tpv_lineasvale": {
					idPadre = curLinea.valueBuffer("refvale");
					fechaReal = util.sqlSelect("tpv_vales", "fechaemision", "referencia = '" + idPadre + "'");
					codAlmacen = curLinea.valueBuffer("codalmacen");
					break;
				}
				case "lineasalbaranescli": {
					idPadre = curLinea.valueBuffer("idalbaran");
					fechaReal = util.sqlSelect("albaranescli", "fecha", "idalbaran = " + idPadre);
					var hora:String = util.sqlSelect("albaranescli", "hora", "idalbaran = " + idPadre);

					hora = hora.toString();
					horaReal = hora.right(8);
					codAlmacen = util.sqlSelect("albaranescli", "codalmacen", "idalbaran = " + idPadre);
					break;
				}
				case "lineastransstock": {
					idPadre = curLinea.valueBuffer("idtrans");
					fechaPrev = util.sqlSelect("transstock", "fecha", "idtrans = " + idPadre);
					horaReal = util.sqlSelect("transstock", "hora", "idtrans = " + idPadre);
					codAlmacenOrigen = util.sqlSelect("transstock", "codalmaorigen", "idtrans = " + idPadre);
					codAlmacenDestino = util.sqlSelect("transstock", "codalmadestino", "idtrans = " + idPadre);
					break;
				}
				case "lotesstock": {
					fechaPrev = curLinea.valueBuffer("fechafabricacion");
					// Por ahora no se usa el campo fechafabricacion (fechaPrev se calcula a partir de la fecha de entrega del pedido, más adelante.
					if (!fechaPrev || fechaPrev == "") {
						var hoy:Date = new Date;
						fechaPrev = hoy.toString();
					}
					var diasAntelacion:Number = parseFloat(curArticuloComp.valueBuffer("diasantelacion"));
					if (diasAntelacion && !isNaN(diasAntelacion)) {
						diasAntelacion = diasAntelacion * -1;
						fechaPrev = util.addDays(fechaPrev, diasAntelacion);
					}
					codAlmacen = this.iface.almacenFabricacion(curLinea,curArticuloComp);
					break;
				}
				case "pr_procesos": {
					fechaPrev = util.sqlSelect("pr_tareas", "MAX(fechafinprev)", "idproceso = " + curLinea.valueBuffer("idproceso"));
					if (!fechaPrev || fechaPrev == "") {

						return false;
					}
					codAlmacen = this.iface.almacenFabricacion(curLinea);
					break;
				}
			}
			break;
		}
		case "lineaspedidosprov": {
			if(curLinea.valueBuffer("cerrada"))
				return true;
			datosArt = this.iface.datosArticulo(curLinea);
			if (datosArt["referencia"] == "")
				return true;

			if (!cantidad || isNaN(cantidad)) {
				cantidad = this.iface.establecerCantidad(curLinea);
			}
			if(!cantidad)
				return true;
			idLinea = curLinea.valueBuffer("idlinea");
			idPadre = curLinea.valueBuffer("idpedido");
			fechaPrev = util.sqlSelect("pedidosprov", "fechaentrada", "idpedido = " + idPadre);
			codAlmacen = util.sqlSelect("pedidosprov", "codalmacen", "idpedido = " + idPadre);
			break;
		}
		case "lineasalbaranesprov": {
			datosArt = this.iface.datosArticulo(curLinea);
			if (datosArt["referencia"] == "")
				return true;
			if (!cantidad || isNaN(cantidad)) {
				cantidad = this.iface.establecerCantidad(curLinea);
			}
			if(!cantidad)
				return true;
			idLinea = curLinea.valueBuffer("idlinea");
			idPadre = curLinea.valueBuffer("idalbaran");
			fechaReal = util.sqlSelect("albaranesprov", "fecha", "idalbaran = " + idPadre);
			var hora:String = util.sqlSelect("albaranesprov", "hora", "idalbaran = " + idPadre);

			hora = hora.toString();
			horaReal = hora.right(8);
			codAlmacen = util.sqlSelect("albaranesprov", "codalmacen", "idalbaran = " + idPadre);
			break;
		}
	}

	var idStock:String = false;
	var idStockDestino:String = false;

	if (tabla == "lineastransstock") {
		if (!codAlmacenOrigen || codAlmacenOrigen == "" || !codAlmacenDestino || codAlmacenDestino == "") {
			MessageBox.critical(util.translate("scripts", "Error: Intenta generar un movimiento de stock sin especificar el almacén asociado"), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}

		idStock = this.iface.comprobarStockOrigen(datosArt,codAlmacenOrigen,cantidad);
		if(!idStock)
			return false;
		idStockDestino = util.sqlSelect("stocks", "idstock", datosArt["localizador"] + " AND codalmacen = '" + codAlmacenDestino + "'");
		if (!idStockDestino || idStockDestino == "")
			idStockDestino = this.iface.crearStock(codAlmacenDestino, datosArt);
		if (!idStockDestino || idStockDestino == "") {
			MessageBox.critical(util.translate("scripts", "Error: No pudo crearse el stock para el artículo %1 y el almacén %2").arg(datosArt["referencia"]).arg(codAlmacenDestino), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
	} else {
		if (!codAlmacen || codAlmacen == "") {
			MessageBox.critical(util.translate("scripts", "Error: Intenta generar un movimiento de stock sin especificar el almacén asociado"), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
		idStock = util.sqlSelect("stocks", "idstock", datosArt["localizador"] + " AND codalmacen = '" + codAlmacen + "'");
		if (!idStock || idStock == "")
			idStock = this.iface.crearStock(codAlmacen, datosArt);
		if (!idStock || idStock == "") {
			MessageBox.critical(util.translate("scripts", "Error: No pudo crearse el stock para el artículo %1 y el almacén %2").arg(datosArt["referencia"]).arg(codAlmacen), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
	}

	if (!this.iface.curMoviStock) {
		this.iface.curMoviStock = new FLSqlCursor("movistock");
	}

	switch (tabla) {
		case "lineaspresupuestoscli": {
			cantidad = parseFloat(cantidad) * -1;
			this.iface.curMoviStock.setModeAccess(this.iface.curMoviStock.Insert);
			this.iface.curMoviStock.refreshBuffer();
			this.iface.curMoviStock.setValueBuffer("idlineapr", idLinea);
			//this.iface.curMoviStock.setValueBuffer("referencia", datosArt["referencia"]);
			this.iface.curMoviStock.setValueBuffer("estado", "PTE");
			this.iface.curMoviStock.setValueBuffer("fechaprev", fechaPrev);
			this.iface.curMoviStock.setValueBuffer("cantidad", cantidad);
			break;
		}
		case "lineaspedidoscli": {
			cantidad = parseFloat(cantidad) * -1;
			this.iface.curMoviStock.setModeAccess(this.iface.curMoviStock.Insert);
			this.iface.curMoviStock.refreshBuffer();
			this.iface.curMoviStock.setValueBuffer("idlineapc", idLinea);
			//this.iface.curMoviStock.setValueBuffer("referencia", datosArt["referencia"]);
			this.iface.curMoviStock.setValueBuffer("estado", "PTE");
			this.iface.curMoviStock.setValueBuffer("fechaprev", fechaPrev);
			this.iface.curMoviStock.setValueBuffer("cantidad", cantidad);
			break;
		}
		case "lineaspedidosprov": {
			cantidad = parseFloat(cantidad);
			this.iface.curMoviStock.setModeAccess(this.iface.curMoviStock.Insert);
			this.iface.curMoviStock.refreshBuffer();
			this.iface.curMoviStock.setValueBuffer("idlineapp", idLinea);
			//this.iface.curMoviStock.setValueBuffer("referencia", datosArt["referencia"]);
			this.iface.curMoviStock.setValueBuffer("estado", "PTE");
			this.iface.curMoviStock.setValueBuffer("fechaprev", fechaPrev);
			this.iface.curMoviStock.setValueBuffer("cantidad", cantidad);
			break;
		}
		case "tpv_lineascomanda": {
			cantidad = parseFloat(cantidad) * -1;
			this.iface.curMoviStock.setModeAccess(this.iface.curMoviStock.Insert);
			this.iface.curMoviStock.refreshBuffer();
			this.iface.curMoviStock.setValueBuffer("cantidad", cantidad);
			this.iface.curMoviStock.setValueBuffer("idlineaco", idLinea);
			this.iface.curMoviStock.setValueBuffer("estado", "HECHO");
			this.iface.curMoviStock.setValueBuffer("fechareal", fechaReal);
			this.iface.curMoviStock.setValueBuffer("horareal", horaReal);
			break;
		}
		case "lineasalbaranescli": {
			cantidad = parseFloat(cantidad) * -1;
			var idLineaPedido:String = curLinea.valueBuffer("idlineapedido");
			if (idLineaPedido && idLineaPedido != "" && idLineaPedido != 0) {
				this.iface.curMoviStock.select("idlineapc = " + idLineaPedido + " AND estado = 'PTE' AND fechareal IS NULL");
				if (!curMoviStock.first()) {
					MessageBox.critical(util.translate("scripts", "No se encuentra un movimiento pendiente que albaranar"), MessageBox.Ok, MessageBox.NoButton);
					return false;
				}
				this.iface.curMoviStock.setModeAccess(this.iface.curMoviStock.Edit);
				this.iface.curMoviStock.refreshBuffer();
				this.iface.curMoviStock.setValueBuffer("idlineapc", idLineaPedido);
				if (cantidad != parseFloat(this.iface.curMoviStock.valueBuffer("cantidad"))) {
					MessageBox.critical(util.translate("scripts", "Error de consistencia en línea de pedido %1.\nEl total albaranado no coincide con la cantidad del movimiento de stock pendiente").arg(idLineaPedido), MessageBox.Ok, MessageBox.NoButton);
					return false;
				}
			} else {
				this.iface.curMoviStock.setModeAccess(this.iface.curMoviStock.Insert);
				this.iface.curMoviStock.refreshBuffer();
				this.iface.curMoviStock.setValueBuffer("cantidad", cantidad);
			}
			//this.iface.curMoviStock.setValueBuffer("referencia", datosArt["referencia"]);
			this.iface.curMoviStock.setValueBuffer("idlineaac", idLinea);
			this.iface.curMoviStock.setValueBuffer("estado", "HECHO");
			this.iface.curMoviStock.setValueBuffer("fechareal", fechaReal);
			this.iface.curMoviStock.setValueBuffer("horareal", horaReal);
			break;
		}
		case "tpv_lineasvale": {
			cantidad = parseFloat(cantidad);
			this.iface.curMoviStock.setModeAccess(this.iface.curMoviStock.Insert);
			this.iface.curMoviStock.refreshBuffer();
			this.iface.curMoviStock.setValueBuffer("cantidad", cantidad);
			this.iface.curMoviStock.setValueBuffer("idlineava", idLinea);
			this.iface.curMoviStock.setValueBuffer("estado", "HECHO");
			this.iface.curMoviStock.setValueBuffer("fechareal", fechaReal);
			this.iface.curMoviStock.setValueBuffer("horareal", horaReal);
			break;
		}
		case "lineasalbaranesprov": {
			cantidad = parseFloat(cantidad);
			var idLineaPedido:String = curLinea.valueBuffer("idlineapedido");
			if (idLineaPedido && idLineaPedido != "" && idLineaPedido != 0) {
				this.iface.curMoviStock.select("idlineapp = " + idLineaPedido + " AND estado = 'PTE' AND fechareal IS NULL");
				if (!this.iface.curMoviStock.first()) {
					MessageBox.critical(util.translate("scripts", "No se encuentra un movimiento pendiente que albaranar"), MessageBox.Ok, MessageBox.NoButton);
					return false;
				}
				this.iface.curMoviStock.setModeAccess(this.iface.curMoviStock.Edit);
				this.iface.curMoviStock.refreshBuffer();
				this.iface.curMoviStock.setValueBuffer("idlineapp", idLineaPedido);
				if (cantidad != parseFloat(this.iface.curMoviStock.valueBuffer("cantidad"))) {
					MessageBox.critical(util.translate("scripts", "Error de consistencia en línea de pedido %1.\nEl total albaranado no coincide con la cantidad del movimiento de stock pendiente").arg(idLineaPedido), MessageBox.Ok, MessageBox.NoButton);
					return false;
				}
			} else {
				this.iface.curMoviStock.setModeAccess(this.iface.curMoviStock.Insert);
				this.iface.curMoviStock.refreshBuffer();
				this.iface.curMoviStock.setValueBuffer("cantidad", cantidad);
			}
			this.iface.curMoviStock.setValueBuffer("idlineaap", idLinea);
			//this.iface.curMoviStock.setValueBuffer("referencia", datosArt["referencia"]);
			this.iface.curMoviStock.setValueBuffer("estado", "HECHO");
			this.iface.curMoviStock.setValueBuffer("fechareal", fechaReal);
			this.iface.curMoviStock.setValueBuffer("horareal", horaReal);
			break;
		}
		case "lotesstock": {
			cantidad = parseFloat(cantidad) * -1;
			this.iface.curMoviStock.setModeAccess(this.iface.curMoviStock.Insert);
			this.iface.curMoviStock.refreshBuffer();
			this.iface.curMoviStock.setValueBuffer("codloteprod", curLinea.valueBuffer("codlote"));
			this.iface.curMoviStock.setValueBuffer("estado", "PTE");
			//this.iface.curMoviStock.setValueBuffer("referencia", datosArt["referencia"]);
			this.iface.curMoviStock.setValueBuffer("fechaprev", fechaPrev);
			this.iface.curMoviStock.setValueBuffer("cantidad", cantidad);
			this.iface.curMoviStock.setValueBuffer("idarticulocomp", curArticuloComp.valueBuffer("id"));
			var idTipoTareaPro:String = curArticuloComp.valueBuffer("idtipotareapro");
			this.iface.curMoviStock.setValueBuffer("idtipotareapro", idTipoTareaPro);
			if (idProceso) {
				this.iface.curMoviStock.setValueBuffer("idproceso", idProceso);
				var idTarea:String = util.sqlSelect("pr_tareas", "idtarea", "idproceso = " + idProceso + " AND idtipotareapro = " + idTipoTareaPro);
				if (!idTarea) {
					MessageBox.warning(util.translate("scripts", "Error al crear el movimiento de stock:\nNo se ha encontrado una tarea para el proceso %1 y el tipo %2\nal crear el movimiento de stock para el artículo %3").arg(idProceso).arg(idTipoTareaPro).arg(curArticuloComp.valueBuffer("refcomponente")), MessageBox.Ok, MessageBox.NoButton);
					return false;
				}
				this.iface.curMoviStock.setValueBuffer("idtarea", idTarea);
			}
			break;
		}
		case "pr_procesos": {
			this.iface.curMoviStock.setModeAccess(this.iface.curMoviStock.Insert);
			this.iface.curMoviStock.refreshBuffer();
			this.iface.curMoviStock.setValueBuffer("estado", "PTE");
			this.iface.curMoviStock.setValueBuffer("fechaprev", fechaPrev);
			this.iface.curMoviStock.setValueBuffer("cantidad", cantidad);
			this.iface.curMoviStock.setValueBuffer("idproceso", curLinea.valueBuffer("idproceso"));
			break;
		}
		case "lineastransstock": {
			cantidad = parseFloat(cantidad);
			this.iface.curMoviStock.setModeAccess(this.iface.curMoviStock.Insert);
			this.iface.curMoviStock.refreshBuffer();
			this.iface.curMoviStock.setValueBuffer("idlineats", idLinea);
			//this.iface.curMoviStock.setValueBuffer("referencia", datosArt["referencia"]);
			this.iface.curMoviStock.setValueBuffer("estado", "HECHO");
			this.iface.curMoviStock.setValueBuffer("fechareal", fechaPrev);
			this.iface.curMoviStock.setValueBuffer("horareal", horaReal);
			this.iface.curMoviStock.setValueBuffer("fechaprev", fechaPrev);
			this.iface.curMoviStock.setValueBuffer("cantidad", (cantidad*-1));
			if (idStock)
				this.iface.curMoviStock.setValueBuffer("idstock", idStock);

			if (!this.iface.datosArticuloMS(datosArt))
				return false;

			if (!this.iface.curMoviStock.commitBuffer()) {
				MessageBox.critical(util.translate("scripts", "Error: No pudo crearse el movimiento de stock para el artículo %1 y el almacén %2").arg(datosArt["referencia"]).arg(codAlmacenOrigen), MessageBox.Ok, MessageBox.NoButton);
				return false;
			}

			this.iface.curMoviStock.setModeAccess(this.iface.curMoviStock.Insert);
			this.iface.curMoviStock.refreshBuffer();
			this.iface.curMoviStock.setValueBuffer("idlineats", idLinea);
			//this.iface.curMoviStock.setValueBuffer("referencia", datosArt["referencia"]);
			this.iface.curMoviStock.setValueBuffer("estado", "HECHO");
			this.iface.curMoviStock.setValueBuffer("fechareal", fechaPrev);
			this.iface.curMoviStock.setValueBuffer("horareal", horaReal);
			this.iface.curMoviStock.setValueBuffer("fechaprev", fechaPrev);
			this.iface.curMoviStock.setValueBuffer("cantidad", cantidad);
			if (idStock)
				this.iface.curMoviStock.setValueBuffer("idstock", idStockDestino);

			if (!this.iface.datosArticuloMS(datosArt))
				return false;

			if (!this.iface.curMoviStock.commitBuffer()) {
				MessageBox.critical(util.translate("scripts", "Error: No pudo crearse el movimiento de stock para el artículo %1 y el almacén %2").arg(datosArt["referencia"]).arg(codAlmacenDestino), MessageBox.Ok, MessageBox.NoButton);
				return false;
			}
			break;
		}
	}

	var modoAcceso:Number = this.iface.curMoviStock.modeAccess();
	if(tabla != "lineastransstock") {
		if (!this.iface.datosArticuloMS(datosArt))
			return false;

		if (modoAcceso == this.iface.curMoviStock.Insert) {
			if (idStock) {
				this.iface.curMoviStock.setValueBuffer("idstock", idStock);
			} else {
				//curMoviStock.setNull("idstock");
			}
			if (codLote) {
				this.iface.curMoviStock.setValueBuffer("codlote", codLote);
			} else {
				this.iface.curMoviStock.setNull("codlote");
			}
		}
		if (!this.iface.curMoviStock.commitBuffer()) {
			MessageBox.critical(util.translate("scripts", "Error: No pudo crearse el movimiento de stock para el artículo %1 y el almacén %2").arg(datosArt["referencia"]).arg(codAlmacen), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
	}

	switch (tabla) {
		case "lineaspresupuestoscli":
		case "lineaspedidoscli":
		case "lineaspedidosprov":
		case "lotesstock": {
			if (modoAcceso == this.iface.curMoviStock.Insert) {
				if (codLote && fechaPrev && fechaPrev != "") {
					if (!this.iface.comprobarFechaFabricacionLote(this.iface.curMoviStock))
						return false;
				}
			}
		}
		break;
	}
	return true;
}

function prod_comprobarStockOrigen(datosArt:Array,codAlmacen:String,cantidad:Number):String
{
	var util:FLUtil;
	var idStock:String = util.sqlSelect("stocks", "idstock", datosArt["localizador"] + " AND codalmacen = '" + codAlmacen + "'");
		if (!idStock || idStock == "")
			idStock = this.iface.crearStock(codAlmacen, datosArt);
		if (!idStock || idStock == "") {
			MessageBox.critical(util.translate("scripts", "Error: No pudo crearse el stock para el artículo %1 y el almacén %2").arg(datosArt["referencia"]).arg(codAlmacen), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
	return idStock;
}

function prod_establecerCantidad(curLinea:FLSqlCursor):Number
{
	var cantidad:Number;
	if (curLinea.table() == "lotesstock")
		cantidad = curLinea.valueBuffer("canreservada");
	else {
		if(curLinea.table() == "lineaspedidoscli" || curLinea.table() == "lineaspedidosprov") {
			if(curLinea.valueBuffer("cantidad") > curLinea.valueBuffer("totalenalbaran") && curLinea.valueBuffer("totalenalbaran") != 0) {
				cantidad = parseFloat(curLinea.valueBuffer("cantidad")) - parseFloat(curLinea.valueBuffer("totalenalbaran"));
			}
			else
				cantidad = curLinea.valueBuffer("cantidad");
		}
		else
			cantidad = curLinea.valueBuffer("cantidad");
	}

	return cantidad;
}

function prod_datosArticuloMS(datosArt:Array):Boolean
{
	this.iface.curMoviStock.setValueBuffer("referencia", datosArt["referencia"]);
	return true;
}

/** \D Función a sobrecargar. Devuelve el almacén donde se creará el lote
@param	curLote: Cursor posicionado en el lote a fabricar
@return	código del almacén.
\end */
function prod_almacenFabricacion(curLinea:FLSqlCursor,curArticuloComp:FLSqlCursor):String
{
	return flfactppal.iface.pub_valorDefectoEmpresa("codalmacen");
}

/** \D Borra los movimientos de stock asociados a una línea de pedido
@param	idLinea: Identificador de la línea de pedido
@return	true si los movimientos se borrar correctamente, false en caso contrario
\end */
function prod_borrarMoviStock(curLinea:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	var tabla:String = curLinea.table();
	var idLinea:String;

	switch (tabla) {
		case "lineaspresupuestoscli": {
			idLinea = curLinea.valueBuffer("idlinea");
			if (!util.sqlDelete("movistock", "idlineapr = " + idLinea))
				return false;
			break;
		}
		case "lineaspedidoscli": {
			idLinea = curLinea.valueBuffer("idlinea");
			if (!util.sqlDelete("movistock", "idlineapc = " + idLinea + " AND (idlineaac IS NULL OR idlineaac = 0)"))
				return false;
			break;
		}
		case "lineaspedidosprov": {
			idLinea = curLinea.valueBuffer("idlinea");
			if (!util.sqlDelete("movistock", "idlineapp = " + idLinea + " AND (idlineaap IS NULL OR idlineaap = 0)"))
				return false;
			break;
		}
		case "lineastransstock": {
			idLinea = curLinea.valueBuffer("idlinea");
			if (!util.sqlDelete("movistock", "idlineats = " + idLinea))
				return false;
			break;
		}
		case "tpv_lineascomanda": {
			idLinea = curLinea.valueBuffer("idtpv_linea");
			if (!util.sqlDelete("movistock", "idlineaco = " + idLinea))
				return false;
			break;
		}
		case "tpv_lineasvale": {
			idLinea = curLinea.valueBuffer("idlinea");
			if (!util.sqlDelete("movistock", "idlineava = " + idLinea))
				return false;
			break;
		}
		case "lineasalbaranescli": {
			idLinea = curLinea.valueBuffer("idlinea");
			var idLineaPedido:Number = parseFloat(curLinea.valueBuffer("idlineapedido"));

			if (!idLineaPedido || isNaN(idLineaPedido)) {
				if (!util.sqlDelete("movistock", "idlineaac = " + idLinea))
					return false;
			} else {
				if (!util.sqlUpdate("movistock", "idlineaac, fechareal, horareal, estado", "NULL,NULL,NULL,PTE", "idlineaac = " + idLinea))
					return false;
			}
			break;
		}
		case "lineasalbaranesprov": {
			idLinea = curLinea.valueBuffer("idlinea");
			var idLineaPedido:Number = parseFloat(curLinea.valueBuffer("idlineapedido"));
			if (!idLineaPedido || isNaN(idLineaPedido)) {
				if (!util.sqlDelete("movistock", "idlineaap = " + idLinea))
					return false;
			} else {
				if (!util.sqlUpdate("movistock", "idlineaap, fechareal, horareal, estado", "NULL,NULL,NULL,PTE", "idlineaap = " + idLinea))
					return false;
			}
			break;
		}
	}

	return true;
}

function prod_beforeCommit_movistock(curMS:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	var codLote:String = curMS.valueBuffer("codlote");

	switch (curMS.modeAccess()) {
		case curMS.Del: {

			/** \D Si el movimiento viene de un documento de proveedor y tiene lote asociado, se podrá borrar sólo si el lote no tiene ningún otro movimiento asociado
			\end */
			if (codLote && codLote != "") {
				if (!curMS.isNull("idlineapp") || !curMS.isNull("idlineaap")) {
					if (util.sqlSelect("movistock", "idmovimiento", "codlote = '" + codLote + "' AND idmovimiento <> " + curMS.valueBuffer("idmovimiento"))) {
						MessageBox.warning(util.translate("scripts", "El lote %1 asociado a la línea a borrar tiene asociados otros movimientos de stock.\nDebe reasignar el lote de estos movimientos antes de borrar la línea").arg(codLote), MessageBox.Ok, MessageBox.NoButton);
						return false;
					}
				}
			}
			break;
		}
		case curMS.Edit: {
			break;
		}
		case curMS.Insert: {
			var idTarea:String = curMS.valueBuffer("idtarea");
			if(idTarea && idTarea != "" && !curMS.valueBuffer("idtipotareapro"))
				curMS.setValueBuffer("idtipotareapro",util.sqlSelect("pr_tareas","idtipotareapro","idtarea = '" + idTarea + "'"));
			break;
		}
	}
	return true;
}

/** \D Comprueba el stock que existirá para el momento en el que está previsto un determinado movimiento
@param idStock: Identificador de stock
\end */
function prod_comprobarEvolStock(idStock:String):Boolean
{
	var util:FLUtil = new FLUtil;

	var datosArtStock:Array = this.iface.datosArticuloStock(idStock);

	var qryArticulo:FLSqlQuery = new FLSqlQuery();
	with (qryArticulo) {
		setTablesList("articulos");
		setSelect("tipostock,controlstock,stockmin");
		setFrom("articulos");
		setWhere("referencia = '" + datosArtStock["referencia"] + "'");
		setForwardOnly(true);
	}
	if (!qryArticulo.exec())
		return false;

	if (!qryArticulo.first())
		return false;

	if (qryArticulo.value("tipostock") == "Sin stock")
		return true;

	var stockMinimo:Number = parseFloat(qryArticulo.value("stockmin"));
	if (!stockMinimo || isNaN(stockMinimo))
		stockMinimo = 0;

	var controlStock:Boolean = qryArticulo.value("controlstock");

	var stockActual:Number = parseFloat(util.sqlSelect("stocks", "cantidad", "idstock = " + idStock));
	if (!stockActual || isNaN(stockActual))
		stockActual = 0;

	var hoy:Date = new Date;
	var stockPteAnterior:Number = parseFloat(util.sqlSelect("movistock", "SUM(cantidad)", "idstock = " + idStock + " AND estado = 'PTE' AND (fechaprev IS NULL OR fechaprev < '" + hoy.toString() + "')"));
	if (!stockPteAnterior || isNaN(stockPteAnterior))
		stockPteAnterior = 0;

	stockActual += stockPteAnterior;

	var qryMoviStock:FLSqlQuery = new FLSqlQuery();
	with (qryMoviStock) {
		setTablesList("movistock");
		setSelect("movistock.cantidad, movistock.fechaprev");
		setFrom("movistock");
		setWhere("idstock = " + idStock + " AND fechaprev >= '" + hoy.toString() + "' ORDER BY fechaprev")
		setForwardOnly(true);
	}
	if (!qryMoviStock.exec())
		return false;

	var stockPrevisto:Number = stockActual;
	var avisado:Boolean = false;
	while (qryMoviStock.next()) {
		stockPrevisto += parseFloat(qryMoviStock.value("movistock.cantidad"));
		if (!avisado && stockPrevisto < stockMinimo && controlStock) {
			var res:Number = MessageBox.warning(util.translate("scripts", "Se ha detectado al menos una rotura del stock mínimo (%1) para el artículo %2 el día %3.\n¿Desea continuar?").arg(stockMinimo).arg(datosArtStock["nombre"]).arg(util.dateAMDtoDMA(qryMoviStock.value("movistock.fechaprev"))), MessageBox.Yes, MessageBox.No);
			if (res != MessageBox.Yes)
				return false;
			avisado = true;
		}
	}
	this.iface.graficoStock(idStock);
	return true;
}

function prod_datosArticuloStock(idStock:String):Array
{
	var util:FLUtil = new FLUtil;
	var res:Array = [];
	res["referencia"] = util.sqlSelect("stocks", "referencia", "idstock = " + idStock);
	res["descripcion"] = util.sqlSelect("articulos", "descripcion", "referencia = '" + res["referencia"] + "'");
	res["nombre"] = util.translate("scripts", "Artículo: %1 - %2").arg(res["referencia"]).arg(res["descripcion"]);
	return res;
}

function prod_graficoStock(idStock:String, avisar:Boolean):Boolean
{
	var util:FLUtil = new FLUtil;
	var datosArtStock:Array = this.iface.datosArticuloStock(idStock);

	var hoy:Date = new Date;
	var arrayEvolStock:Array = this.iface.datosEvolStock(idStock, hoy.toString(), avisar);

	var fechaMinima:String = arrayEvolStock[0]["fecha"].toString().left(10);
	var fechaMaxima:String = arrayEvolStock[arrayEvolStock.length - 1]["fecha"].toString().left(10);
	fechaMinima = util.dateAMDtoDMA(fechaMinima);
	fechaMaxima = util.dateAMDtoDMA(fechaMaxima);

	var stdin:String, datos:String;

	datos = fechaMinima + " " + fechaMaxima + "\r\n";

	var tempX:String, tempY:String;
	for (var i:Number = 0; i < arrayEvolStock.length; i++) {
		tempX = util.dateAMDtoDMA( arrayEvolStock[i]["fecha"]);
		tempY = arrayEvolStock[i]["stock"]

		datos += tempX + " " + tempY + "\r\n";
	}

	stdin =  "set title \"" + util.translate("scripts", "Evolución prevista de stock para %1").arg(datosArtStock["nombre"]) + "\"";
	stdin += "\r\nset xdata time";
	stdin += "\r\nset timefmt \"\%d-\%m-\%Y\"";
	stdin += "\r\nset xrange [\"" + fechaMinima + "\" : \"" + fechaMaxima + "\"]";
	stdin += "\r\nset format x \"\%d-\%m\"";

	stdin += "\r\nset xlabel \"" + util.translate("scripts", "Fecha") + "\"";
	stdin += "\r\nset ylabel \"" + util.translate("scripts", "Stock") + "\"";
	stdin += "\r\nset grid";
	//stdin += "\r\nplot '-' using 1:2 t '' with line smoot bezier, '-' using 1:2 t '' with impulses\r\n";
	stdin += "\r\nplot '-' using 1:2 t '' with boxes\r\n";
	//stdin += "\r\nplot '-' using 1:2 t '' with l\r\n";
	//stdin += "\r\nplot '-' using 1:2 t '' with impulses\r\n";
	stdin += datos;
	stdin += "\r\ne\r\n"
	//stdin += datos;
	var os:String = util.getOS();
	switch (os) {
		case "WIN32": {
			File.write("datosgnuplot.txt", stdin);
			Process.execute( ["wgnuplot",  "-persist", "datosgnuplot.txt"]);
			break;
		}
		default : {
			Process.execute( ["gnuplot","-persist"], stdin);
		}
	}
}


/** \D Esta función rellena las filas de Recepción de pedidos planificados y de Lanzamiento de pedidos planificados. El algoritmo que usa es proponer un pedido por la totalidad de las necesidades netas para que se reciba en la fecha en la que se ha detectado la primera necesidad
@param	arrayEvolStock: Array con los datos de evolución de stock
@param	plazoPedido: Plazo de demora desde el lanzamiento hasta la recepción del pedido (días)
@return Array con los datos de evolución de stock más las dos filas de pedidos planificados
\end */
function prod_planificarPedStock(arrayEvolStock:Array, plazoPedido:Number):Array
{
	var util:FLUtil = new FLUtil;

	var totalNN:Number = 0;
	var iFechaMin:Number = -1;
	for (var i:Number; i < arrayEvolStock.length; i++) {
		if (arrayEvolStock[i]["NN"] > 0) {
			totalNN += arrayEvolStock[i]["NN"];
			if (iFechaMin < 0)
				iFechaMin = i;
		}
	}
	if (iFechaMin < 0)
		return arrayEvolStock;

	var fechaEntrada:String  = arrayEvolStock[iFechaMin]["fecha"];
	var fechaPedido:String = util.addDays(fechaEntrada, (-1 * plazoPedido));
	if (util.daysTo(fechaPedido, arrayEvolStock[0]["fecha"]) > 0)
		fechaPedido = arrayEvolStock[0]["fecha"];

	var iLPP:Number = this.iface.buscarIndiceAES(fechaPedido, arrayEvolStock);
	if (iLPP < 0)
		iLPP = 0;

	arrayEvolStock[iFechaMin]["RPP"] = totalNN;
	arrayEvolStock[iLPP]["LPP"] = totalNN;

	return arrayEvolStock;
}

function prod_buscarIndiceAES(fecha:String, arrayEvolStock:Array):Number
{
	var util:FLUtil = new FLUtil;
	if(!fecha || fecha.toString().length == 0)
		return -1;

	if (fecha.toString().length == 10) {
		fecha += "T00:00:00";
	}
	var hoy:Date = new Date;
	var objetoFecha:Date;

	if (util.daysTo(fecha, hoy.toString) > 0) {
		objetoFecha = hoy;
	} else {
		objetoFecha = new Date(Date.parse(fecha.toString()));
	}
	objetoFecha.setHours(0);
	objetoFecha.setMinutes(0);
	objetoFecha.setSeconds(0);

	for (var i:Number; i < arrayEvolStock.length; i++) {
		if (arrayEvolStock[i]["fecha"].toString() == objetoFecha.toString())
			return i;
	}
	return -1;
}

function prod_initPeriodoStock():Array
{
	var datos:Array = [];

	datos["fecha"] = false;
	datos["stock"] = 0;
	datos["NB"] = 0;
	datos["D"] = 0;
	datos["RP"] = 0;
	datos["SS"] = 0;
	datos["NN"] = 0;
	datos["RPP"] = 0;
	datos["LPP"] = 0;

	return datos;
}

/** \D Genera un array con los datos de fecha y stock previsto para un stock determinado. El stock puede referenciarse por el identificador de stock o por la combinación referencia - almacén
@param	idStock: Identificador del stock
@param	fechaDesde: Fecha de inicio de los cálculos
@param	avisar: Indica si hay que mostrar mensajes de aviso al usuario
\end */
function prod_datosEvolStock(idStock:String, fechaDesde:String, avisar:Boolean):Array
{
	var util:FLUtil = new FLUtil;
	var arrayEvolStock:Array = [];

	arrayEvolStock["avisar"] = avisar;

	if (!idStock) {
		arrayEvolStock[0] = this.iface.initPeriodoStock();
		arrayEvolStock[0]["fecha"] = fechaDesde.toString().left(10) + "T00:00:00";
		return arrayEvolStock;
	}
	var datosArtStock:Array = this.iface.datosArticuloStock(idStock);
	var stockSS:Number = parseFloat(util.sqlSelect("articulos", "stockmin", "referencia = '" + datosArtStock["referencia"] + "'"));
	if (!stockSS || isNaN(stockSS))
		stockSS = 0;

	var hoy:Date = new Date;
	var pteAnterior:Number = 0;

	if (util.sqlSelect("movistock", "idmovimiento", "idstock = " + idStock + " AND estado = 'PTE' AND (fechaprev < '" + fechaDesde + "' OR fechaprev IS NULL)")) {
		if (avisar) {
			var res:Number = MessageBox.warning(util.translate("scripts", "%1:\nExisten movimientos de stock en estado PTE que tienen una fecha nula o anterior a la actual.\nLos datos de evolución de stock pueden no ser correctos por esta causa.\n¿Desea continuar? (Pulse ignorar para no volver a mostrar este mensaje)").arg(datosArtStock["nombre"]), MessageBox.Yes, MessageBox.No,MessageBox.Ignore);
			if (res == MessageBox.No)
				return false;

			if (res == MessageBox.Ignore)
				arrayEvolStock["avisar"] = false;

			if (res == MessageBox.Yes)
				arrayEvolStock["avisar"] = true;
		}
		else
			arrayEvolStock["avisar"] = false;

		pteAnterior = parseFloat(util.sqlSelect("movistock", "SUM(cantidad)", "idstock = " + idStock + " AND estado = 'PTE' AND (fechaprev < '" + fechaDesde + "' OR fechaprev IS NULL)"));
		if (isNaN(pteAnterior)) {
			pteAnterior = 0;
		}
		pteAnterior = pteAnterior * -1;
	}

	var fechaAnterior:String = fechaDesde.toString().left(10) + "T00:00:00";
	var fecha:String;
	var cantidad:Number;
	var canAbsoluta:Number;
	var stock:Number = util.sqlSelect("stocks", "cantidad", "idstock = " + idStock);
	if (!stock || isNaN(stock))
		stock = 0;
	var moviDesde:Number = parseFloat(util.sqlSelect("movistock", "SUM(cantidad)", "fechaprev >= '" + hoy.toString() + "' AND fechaprev < '" + fechaDesde + "'"));
	if (!moviDesde || isNaN(moviDesde))
		moviDesde = 0;
	stock += moviDesde;

	var qryMoviStock:FLSqlQuery = new FLSqlQuery();
	with (qryMoviStock) {
		setTablesList("movistock");
		setSelect("SUM(cantidad), SUM(ABS(cantidad)), fechaprev");
		setFrom("movistock");
		setWhere("idstock = " + idStock + " AND fechaprev >= '" + fechaDesde + "' AND estado = 'PTE' GROUP BY fechaprev ORDER BY fechaprev")
		setForwardOnly(true);
	}
	if (!qryMoviStock.exec())
		return false;

	var indice:Number = 0;
	if (qryMoviStock.size() > 0) {
		while (qryMoviStock.next()) {
			fecha = qryMoviStock.value("fechaprev");
			for (var f:String  = fechaAnterior; util.daysTo(f, fecha) > 0; f = util.addDays(f, 1)) {
				arrayEvolStock[indice] = this.iface.initPeriodoStock();
				arrayEvolStock[indice]["fecha"] = f;
				arrayEvolStock[indice]["stock"] = stock;
				if (indice == 0) {
					arrayEvolStock[indice]["D"] = stock;
					arrayEvolStock[indice]["NB"] = pteAnterior;
				} else {
					arrayEvolStock[indice]["D"] = arrayEvolStock[indice - 1]["D"] + arrayEvolStock[indice - 1]["RP"] - arrayEvolStock[indice - 1]["NB"];
				}
				arrayEvolStock[indice]["SS"] = stockSS;

				indice++;
			}
			canAbsoluta = qryMoviStock.value("SUM(ABS(cantidad))");
			cantidad = qryMoviStock.value("SUM(cantidad)");
			arrayEvolStock[indice] = this.iface.initPeriodoStock();
			arrayEvolStock[indice]["fecha"] = fecha;
			arrayEvolStock[indice]["NB"] = -1 * ((cantidad - canAbsoluta) / 2);
			arrayEvolStock[indice]["RP"] = canAbsoluta - arrayEvolStock[indice]["NB"];
			if (indice == 0) {
				arrayEvolStock[indice]["D"] = stock;
			} else {
				arrayEvolStock[indice]["D"] = arrayEvolStock[indice - 1]["D"] + arrayEvolStock[indice - 1]["RP"] - arrayEvolStock[indice - 1]["NB"];
			}
			stock += cantidad;
			arrayEvolStock[indice]["stock"] = stock;
			arrayEvolStock[indice]["SS"] = stockSS;
			arrayEvolStock[indice]["NN"] = arrayEvolStock[indice]["NB"] - arrayEvolStock[indice]["D"] + arrayEvolStock[indice]["SS"] - arrayEvolStock[indice]["RP"];
			if (arrayEvolStock[indice]["NN"] < 0)
				arrayEvolStock[indice]["NN"] = 0;

			indice++;
			fechaAnterior = util.addDays(fecha, 1);
		}
	} else {
		arrayEvolStock[0] = this.iface.initPeriodoStock();
		arrayEvolStock[0]["fecha"] = fechaDesde.toString().left(10) + "T00:00:00";
		arrayEvolStock[0]["stock"] = stock;
		arrayEvolStock[0]["D"] = stock;
		arrayEvolStock[0]["NB"] = pteAnterior;
		arrayEvolStock[0]["SS"] = stockSS;
		arrayEvolStock[0]["NN"] = arrayEvolStock[0]["NB"] - arrayEvolStock[0]["D"] + arrayEvolStock[0]["SS"] - arrayEvolStock[0]["RP"];
		if (arrayEvolStock[0]["NN"] < 0)
			arrayEvolStock[0]["NN"] = 0;
	}

	return arrayEvolStock;
}

/** \D Comprueba si hay que actualizar, y actualiza en caso necesario, la fecha de fabricación del lote en función de la fecha de salida asociada al mismo más reciente
@param curMS: Cursor posicionado en un movimiento de salida que ha cambiado de fecha
\end */
function prod_comprobarFechaFabricacionLote(curMS:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	var diasAntelacion:Number = 0;

	if (!util.sqlSelect("articulos", "fabricado", "referencia = '" + curMS.valueBuffer("referencia") + "'"))
		return true;

	var diasProdEnvio:Number = parseFloat(util.sqlSelect("articulos", "diasprodenvio", "referencia = '" + curMS.valueBuffer("referencia") + "'"));

	if (!diasProdEnvio || diasProdEnvio == "")
		diasProdEnvio = 0;
	diasAntelacion += diasProdEnvio;

	var codLote:String = curMS.valueBuffer("codlote");
	var fechaSalidaLote:String = util.sqlSelect("movistock", "fechaprev", "codlote = '" + codLote + "' AND cantidad < 0 ORDER BY fechaprev");

	if (fechaSalidaLote && fechaSalidaLote != "") {
		var fechaNuevaProdLote:String = util.addDays(fechaSalidaLote, (diasProdEnvio * -1));
		var fechaPreviaProdLote:String = util.sqlSelect("lotesstock", "fechafabricacion", "codlote = '" + codLote + "'");
		if (fechaNuevaProdLote != fechaPreviaProdLote) {
			if (!util.sqlUpdate("lotesstock", "fechafabricacion", fechaNuevaProdLote, "codlote = '" + codLote + "'"))
				return false;
		}
	}
	return true;
}

/** \D Actualiza la fecha prevista de consumo de los componentes de un lote
@param curLote: Cursor posicionado en el lote
\end */
function prod_actualizarFechaComponentesLote(curLote:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	var diasIniTareaFinPro:Number;
	var fechaConsumo:String;
	var hoy:Date = new Date;
	var codLote:String = curLote.valueBuffer("codlote");
	var curMSLote:FLSqlCursor = new FLSqlCursor("movistock");
	curMSLote.select("codloteprod = '" + codLote + "'");
	while (curMSLote.next()) {
		curMSLote.setModeAccess(curMSLote.Edit);
		curMSLote.refreshBuffer();
		diasIniTareaFinPro = parseFloat(util.sqlSelect("articuloscomp ac INNER JOIN pr_tipostareapro tt ON ac.idtipotareapro = tt.idtipotareapro", "tt.diasinitareafinpro", "ac.id = " + curMSLote.valueBuffer("idarticulocomp"), "articuloscomp,pr_tipostareapro"));
		if (!diasIniTareaFinPro || isNaN(diasIniTareaFinPro))
			diasIniTareaFinPro = 0;

		fechaConsumo = this.iface.restarDiasLaborables(curLote.valueBuffer("fechafabricacion"), diasIniTareaFinPro);
		if (util.daysTo(hoy, fechaConsumo) < 0)
			fechaConsumo = hoy;

		curMSLote.setValueBuffer("fechaprev", fechaConsumo);
		if (!curMSLote.commitBuffer())
			return false;
	}
	return true;
}

/** \D Modificar teniendo en cuenta la tabla de festivos
\end */
function prod_restarDiasLaborables(fechaInicial:String, dias:Number):String
{
	var util:FLUtil = new FLUtil;
	return util.addDays(fechaInicial, (-1 * dias));
}

/** \D Modificar teniendo en cuenta la tabla de festivos
\end */
function prod_sumarDiasLaborables(fechaInicial:String, dias:Number):String
{
	var util:FLUtil = new FLUtil;
	return util.addDays(fechaInicial, dias);
}

/** \D Actualiza los totales del lote
\end */
function prod_afterCommit_movistock(curMS:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	var codLote:String = curMS.valueBuffer("codlote");
	var idStock:String = curMS.valueBuffer("idstock");

	switch (curMS.modeAccess()) {
		case curMS.Edit: {
			var codLotePrevio:String = curMS.valueBufferCopy("codlote");
			if (codLotePrevio && codLotePrevio != "" && codLotePrevio != codLote) {
				if (!this.iface.revisarEstadoLote(codLotePrevio))
					return false;
			}
			/** \C Si cambia la fecha prevista y se trata de un artículo fabricado, se actualizan las fechas de consumo de los componentes
			\end */
			if (curMS.valueBuffer("fechaprev") != curMS.valueBufferCopy("fechaprev")) {
				if (codLote && codLote != "") {
					if (!this.iface.comprobarFechaFabricacionLote(curMS))
						return false;
				}
			}
			break;
		}
	}

	if (codLote && codLote != "") {
		if (!this.iface.revisarEstadoLote(codLote))
			return false;
	}

	var tipoStock:String = util.sqlSelect("articulos", "tipostock", "referencia = '" + curMS.valueBuffer("referencia") + "'");

	if (tipoStock != "Sin stock") {
		switch (curMS.modeAccess()) {
			case curMS.Insert: {
				if(curMS.valueBuffer("estado") == "PTE") {
					if (curMS.valueBuffer("cantidad") > 0) {
						if(!this.iface.actualizarStockPteRecibir(idStock))
							return false;
					}
					if (curMS.valueBuffer("cantidad") < 0) {
						if(!this.iface.actualizarStockPteServir(idStock))
							return false;
					}
					break;
				}
			}
			case curMS.Edit:
			case curMS.Del: {
				if (!this.iface.actualizarStock(idStock))
					return false;
				break;
			}
		}
	}

	switch (curMS.modeAccess()) {
		case curMS.Del: {
			/** \C Si se deja un lote sin movimientos asociados, el lote es borrado
			\end */
			var codLote:String = curMS.valueBuffer("codlote");
			var idProceso:Number = curMS.valueBuffer("idproceso");
			if (idProceso == 0 || curMS.isNull("idproceso")) {
				var idMov:Number = curMS.valueBuffer("idmovimiento");

				if(codLote && codLote != "") {
					if(!this.iface.borrarLote(codLote,idMov))
						return false;
				}
			}
			break;
		}
	}
	return true;
}

function prod_borrarLote(codLote:String, idMov:Number):Boolean
{
	var util:FLUtil;

	if (!util.sqlSelect("movistock", "idmovimiento", "codlote = '" + codLote + "' AND idmovimiento <> " + idMov + " AND (idproceso = 0 OR idproceso IS NULL)")) {

		if(!this.iface.sacarDeOrdenProd(codLote))
			return false;

		var res:Number = MessageBox.information(util.translate("scritps", "El lote %1 se ha quedado sin movimientos asociados.\n¿Desea eliminarlo?").arg(codLote), MessageBox.Yes, MessageBox.No);
		if(res == MessageBox.Yes){
			if (!util.sqlDelete("lotesstock", "codlote = '" + codLote + "'"))
				return false;
		}
	}

	return true;
}

function prod_sacarDeOrdenProd(codLote:String):Boolean
{
	var util:FLUtil;

	var qryProcesos:FLSqlQuery = new FLSqlQuery();
	with (qryProcesos) {
		setTablesList("movistock,pr_procesos");
		setSelect("ms.idproceso, p.codordenproduccion");
		setFrom("movistock ms INNER JOIN pr_procesos p ON ms.idproceso = p.idproceso");
		setWhere("codlote = '" + codLote + "'");
		setForwardOnly(true);
	}
	if (!qryProcesos.exec()) {
		return false;
	}

	while (qryProcesos.next()) {
		var res:Number = MessageBox.information(util.translate("scripts", "El lote %1 está en la orden de producción %2.\n¿Desea sacarlo de la orden?").arg(codLote).arg(qryProcesos.value("p.codordenproduccion")), MessageBox.Yes, MessageBox.No);
		if (res != MessageBox.Yes)
			return false;

		if (!formpr_ordenesproduccion.iface.pub_sacarProceso(qryProcesos.value("ms.idproceso")))
			return false;
	}

	return true;
}

function prod_revisarEstadoLote(codLote:String):Boolean
{
	var util:FLUtil;
	if (codLote && codLote != "") {

		if (formRecordlotesstock.child("fdbCodLote") && formRecordlotesstock.child("codLote") == codLote)
				return true;

		// El formulario de lotes está cerrado o está abierto el formulario de otro lote, se modifica el cursor
		var curLote:FLSqlCursor = new FLSqlCursor("lotesstock");
		curLote.select("codlote = '" + codLote + "'");
		if (!curLote.first())
			return false;

		curLote.setModeAccess(curLote.Edit);
		curLote.refreshBuffer();
		curLote.setValueBuffer("cantotal", formRecordlotesstock.iface.pub_commonCalculateField("cantotal", curLote));
		curLote.setValueBuffer("canusada", formRecordlotesstock.iface.pub_commonCalculateField("canusada", curLote));
		curLote.setValueBuffer("canreservada", formRecordlotesstock.iface.pub_commonCalculateField("canreservada", curLote));
		curLote.setValueBuffer("candisponible", formRecordlotesstock.iface.pub_commonCalculateField("candisponible", curLote));
		var referencia:String = util.sqlSelect("lotesstock","referencia","codlote = '" + codLote + "'");
		var fabricado:Boolean = util.sqlSelect("articulos","fabricado","referencia = '" + referencia + "'");
		if(!fabricado)
			curLote.setValueBuffer("estado", formRecordlotesstock.iface.pub_commonCalculateField("estado", curLote));

		if (!curLote.commitBuffer())
			return false;

	}
	return true;
}


function prod_actualizarStockPteRecibir(idStock:Number):Boolean
{
	var util:FLUtil = new FLUtil;

	var pteRecibir:Number = parseFloat(this.iface.stockPteRecibir(idStock));
	if (isNaN(pteRecibir))
		return false;

	var curStocks:FLSqlCursor = new FLSqlCursor("stocks");
	curStocks.select("idstock = " + idStock);
	if (!curStocks.first())
		return false;
	curStocks.setModeAccess(curStocks.Edit);
	curStocks.refreshBuffer();
	curStocks.setValueBuffer("pterecibir", pteRecibir);
	if (!curStocks.commitBuffer())
		return false;

	return true;
}

function prod_actualizarStockPteServir(idStock:Number):Boolean
{
	var util:FLUtil = new FLUtil;

	var pteServir:Number = parseFloat(this.iface.stockPteServir(idStock));
	if (isNaN(pteServir))
		return false;

	pteServir = pteServir * -1;

	var curStocks:FLSqlCursor = new FLSqlCursor("stocks");
	curStocks.select("idstock = " + idStock);
	if (!curStocks.first())
		return false;
	curStocks.setModeAccess(curStocks.Edit);
	curStocks.refreshBuffer();
	curStocks.setValueBuffer("reservada", pteServir);
	var disponible:Number = parseFloat(formRecordregstocks.iface.pub_commonCalculateField("disponible", curStocks));
	disponible = util.roundFieldValue(disponible, "stocks", "disponible");
	curStocks.setValueBuffer("disponible", disponible);
	if (!curStocks.commitBuffer())
		return false;

	return true;
}

function prod_actualizarStock(idStock:Number):Boolean
{
	var util:FLUtil = new FLUtil;
	var cantidadStock:Number = parseFloat(this.iface.stockActual(idStock));
	if (isNaN(cantidadStock))
		return false;

	var pteRecibir:Number = parseFloat(this.iface.stockPteRecibir(idStock));
	if (isNaN(pteRecibir))
		return false;

	var pteServir:Number = parseFloat(this.iface.stockPteServir(idStock));
	if (isNaN(pteServir))
		return false;

 	pteServir = pteServir * -1;

	var curStocks:FLSqlCursor = new FLSqlCursor("stocks");
	curStocks.select("idstock = " + idStock);
	if (!curStocks.first())
		return false;
	curStocks.setModeAccess(curStocks.Edit);
	curStocks.refreshBuffer();
	curStocks.setValueBuffer("cantidad", cantidadStock);
	curStocks.setValueBuffer("pterecibir", pteRecibir);
	curStocks.setValueBuffer("reservada", pteServir);
	var disponible:Number = parseFloat(formRecordregstocks.iface.pub_commonCalculateField("disponible", curStocks));
	disponible = util.roundFieldValue(disponible, "stocks", "disponible");
	curStocks.setValueBuffer("disponible", disponible);
	if (!curStocks.commitBuffer())
		return false;

	return true;
}

/** \D Calcula la cantidad de stock pendiente de recibir (movimientos PTE con cantidad > 0)
@param	idStock: Identificador del stock
@return	valor del stock actual
\end */
function prod_stockPteRecibir(idStock:String):Number
{
	var util:FLUtil = new FLUtil;

	var pteRecibir:Number = parseFloat(util.sqlSelect("movistock", "SUM(cantidad)", "idstock = " + idStock + " AND estado = 'PTE' AND cantidad > 0"));
	if (!pteRecibir || isNaN(pteRecibir))
		pteRecibir = 0;

	pteRecibir = util.roundFieldValue(pteRecibir, "stocks", "pterecibir");
	return pteRecibir;
}

/** \D Calcula la cantidad de stock pendiente de servir (movimientos PTE con cantidad < 0)
@param	idStock: Identificador del stock
@return	valor del stock actual
\end */
function prod_stockPteServir(idStock:String):Number
{
	var util:FLUtil = new FLUtil;

	var pteServir:Number = parseFloat(util.sqlSelect("movistock", "SUM(cantidad)", "idstock = " + idStock + " AND estado = 'PTE' AND cantidad < 0"));
	if (!pteServir || isNaN(pteServir))
		pteServir = 0;

	return pteServir;
}


/** \D Calcula la cantidad actual del stock como suma de los movimientos en estado HECHO asociados a dicho stock
@param	idStock: Identificador del stock
@return	valor del stock actual
\end */
function prod_stockActual(idStock:String):Number
{
	var util:FLUtil = new FLUtil;
	var qryUltimaReg:FLSqlQuery = new FLSqlQuery();
	with (qryUltimaReg) {
		setTablesList("lineasregstocks");
		setSelect("fecha, hora, cantidadfin");
		setFrom("lineasregstocks");
		setWhere("idstock = " + idStock + " ORDER BY fecha DESC, hora DESC");
		setForwardOnly(true);
	}
	if (!qryUltimaReg.exec())
		return false;

	var whereStock:String = "idstock = " + idStock + " AND estado = 'HECHO'";
	var cantidadUltReg:Number = 0;
	if (qryUltimaReg.first()) {
		whereStock += " AND ((fechareal > '" + qryUltimaReg.value("fecha") + "') OR (fechareal = '" + qryUltimaReg.value("fecha") + "' AND horareal > '" + qryUltimaReg.value("hora").toString().right(8) + "'))";
		cantidadUltReg = parseFloat(qryUltimaReg.value("cantidadfin"));
	}

	var stock:Number = parseFloat(util.sqlSelect("movistock", "SUM(cantidad)", whereStock));
	if (!stock || isNaN(stock))
		stock = 0;

	stock += parseFloat(cantidadUltReg);
	stock = util.roundFieldValue(stock, "stocks", "cantidad");

	return stock;
}

/** \D Comprueba la consistencia de una línea de de facturación en relación con los movimientos de stock asociados
@param	curLinea: Cursor posicionado en la línea a analizar
@return	True si la línea es consistente, false si no lo es o si hay un error
\end */
function prod_consistenciaLinea(curLinea:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	var ok:Boolean = true;
	var mensaje:String = "";

	switch (curLinea.table()) {
		case "lineaspedidoscli": {
			if (util.sqlSelect("articulos a INNER JOIN articuloscomp ac ON a.referencia = ac.refcompuesto", "a.referencia", "a.referencia = '" + curLinea.valueBuffer("referencia") + "' AND (a.fabricado = false OR a.fabricado IS NULL)", "articulos,articuloscomp")) {
/// Por hacer: Comprobar consistencia de artículos compuestos no fabricados
				return true;
			}
			var totalCan:Number = parseFloat(util.sqlSelect("movistock", "SUM(cantidad)", "idlineapc = " + curLinea.valueBuffer("idlinea")));
			if (!totalCan || isNaN(totalCan))
				totalCan = 0;
			totalCan = totalCan * -1;
			if (totalCan != parseFloat(curLinea.valueBuffer("cantidad"))) {
				mensaje = util.translate("scritps", "Error de consistencia en la línea de pedido");
				ok = false;
				break;
			}
			break;
		}
		case "lineaspedidosprov": {
			var totalCan:Number = parseFloat(util.sqlSelect("movistock", "SUM(cantidad)", "idlineapp = " + curLinea.valueBuffer("idlinea")));
			if (!totalCan || isNaN(totalCan))
				totalCan = 0;
			if (totalCan != parseFloat(curLinea.valueBuffer("cantidad"))) {
				mensaje = util.translate("scritps", "Error de consistencia en la línea de pedido");
				ok = false;
				break;
			}
			break;
		}
		case "lineasalbaranescli": {
			var totalCan:Number = parseFloat(util.sqlSelect("movistock", "SUM(cantidad)", "idlineaac = " + curLinea.valueBuffer("idlinea")));
			if (!totalCan || isNaN(totalCan))
				totalCan = 0;
			totalCan = totalCan * -1;
			if (totalCan != parseFloat(curLinea.valueBuffer("cantidad"))) {
				mensaje = util.translate("scritps", "Error de consistencia en la línea de albarán");
				ok = false;
				break;
			}
			break;
		}
		case "lineasalbaranesprov": {
			var totalCan:Number = parseFloat(util.sqlSelect("movistock", "SUM(cantidad)", "idlineaap = " + curLinea.valueBuffer("idlinea")));
			if (!totalCan || isNaN(totalCan))
				totalCan = 0;
			if (totalCan != parseFloat(curLinea.valueBuffer("cantidad"))) {
				mensaje = util.translate("scritps", "Error de consistencia en la línea de albarán");
				ok = false;
				break;
			}
			break;
		}
	}
	if (!ok) {
		MessageBox.warning(mensaje, MessageBox.Ok, MessageBox.NoButton);
	}

	return true;
}

/** \C Consulta al usuario las opciones que desea para el lote que se va a crear
@param curLS: Lote de stock
\end */
function prod_establecerOpcionesLote(codLote:String,idProceso:Number,idTipoOpcion:Number):Number
{
	var util:FLUtil = new FLUtil;
	var qryOpciones:FLSqlQuery = new FLSqlQuery();
	with (qryOpciones) {
		setTablesList("tiposopcioncomp");
		setSelect("idtipoopcion, tipo, constante");
		setFrom("tiposopcioncomp");
		setWhere("idtipoopcion = " + idTipoOpcion);
		setForwardOnly(true);
	}
	if (!qryOpciones.exec())
		return false;

	var curOpcionesLote:FLSqlCursor = new FLSqlCursor("opcioneslote");
	var idOpcion:Number;

	if (qryOpciones.first()) {
		idOpcion = this.iface.obtenerOpcionLote(qryOpciones,codLote);
		if (!idOpcion)
			return false;

		curOpcionesLote.setModeAccess(curOpcionesLote.Insert);
		curOpcionesLote.refreshBuffer();
		curOpcionesLote.setValueBuffer("codlote", codLote);
		curOpcionesLote.setValueBuffer("idtipoopcion", idTipoOpcion);
		curOpcionesLote.setValueBuffer("idopcion", idOpcion);
		if(!qryOpciones.value("constante") && idProceso)
			curOpcionesLote.setValueBuffer("idproceso", idProceso);
		else
			curOpcionesLote.setNull("idproceso");

		if (!curOpcionesLote.commitBuffer())
			return false;
	}
	return idOpcion;
}

function prod_obtenerOpcionLote(qryOpciones:FLSqlQuery,codLote:String):Number
{
	this.iface.tipoOpcionActual_ = qryOpciones.value("tipo");
	var f:Object = new FLFormSearchDB("opcionescomp");
	var curOpciones:FLSqlCursor = f.cursor();
	curOpciones.setMainFilter("idtipoopcion = " + qryOpciones.value("idtipoopcion"));
	f.setMainWidget();

	var idOpcion:String;
	idOpcion = f.exec("idopcion");
	if (!idOpcion)
		return false;

	return idOpcion;
}

function prod_crearMovRegularizacionLote(codLote:String,cantidad:Number):Boolean
{
	var util:FLUtil;

	var referencia:String = util.sqlSelect("lotesstock","referencia","codlote = '" + codLote + "'");
	var hoy:Date = new Date();
	var idStock:Number;

	var qryStocks:FLSqlQuery = new FLSqlQuery();
	qryStocks.setTablesList("stocks");
	qryStocks.setSelect("codalmacen,idstock");
	qryStocks.setFrom("stocks");
	qryStocks.setWhere("referencia = '" + referencia + "'");
	qryStocks.setForwardOnly(true);

	if (!qryStocks.exec())
		return false;

	if(qryStocks.size() == 1) {
		if(!qryStocks.first())
			return false;

		idStock = qryStocks.value("idstock");
	} else {
		var listaAlmacenes:String = "";
		if(qryStocks.size() > 1) {
			var f:Object = new FLFormSearchDB("stocks");
			var curStocks:FLSqlCursor = f.cursor();
			curStocks.setMainFilter("referencia = '" + referencia + "'");
			f.setMainWidget();
			idStock = f.exec("idstock");
		}

		if(qryStocks.size() == 0) {
			var f:Object = new FLFormSearchDB("almacenes");
			f.setMainWidget();
			var codAlmacen:String = f.exec("codalmacen");
			if(!codAlmacen)
				return false;
			var datosArt:Array = [];
			datosArt["referencia"] = referencia
			idStock = this.iface.crearStock(codAlmacen, datosArt);
		}
	}

	if(!idStock)
		return false;

	var curMS:FLSqlCursor = new FLSqlCursor("movistock");
	curMS.setModeAccess(curMS.Insert);
	curMS.refreshBuffer();
	curMS.setValueBuffer("codlote",codLote);
	curMS.setValueBuffer("referencia",referencia);
	curMS.setValueBuffer("idstock",idStock);
	curMS.setValueBuffer("cantidad",cantidad);
	curMS.setValueBuffer("estado","HECHO");
	curMS.setValueBuffer("fechaprev",hoy);
	curMS.setValueBuffer("fechareal",hoy);
	curMS.setValueBuffer("horareal",hoy);
	if(!curMS.commitBuffer())
		return false;

	return true;
}

function prod_afterCommit_lotesstock(curLS:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	var idProceso:Number;

	switch (curLS.modeAccess()) {
		case curLS.Insert: {
			if(curLS.valueBuffer("crearterminado")) {
				if(!this.iface.crearMovRegularizacionLote(curLS.valueBuffer("codlote"),curLS.valueBuffer("canlote")))
					return false;
				var codLote:String = curLS.valueBuffer("codlote");
				if(!util.sqlUpdate("lotesstock","estado","TERMINADO","codlote = '" + codLote + "'"))
					return false;
				if(!util.sqlUpdate("lotesstock","candisponible",curLS.valueBuffer("canlote"),"codlote = '" + codLote + "'"))
					return false;
				if(!util.sqlUpdate("lotesstock","cantotal",curLS.valueBuffer("canlote"),"codlote = '" + codLote + "'"))
					return false;

				return true;
			}

// 			AHORA SE HACE EN LA FUNCIÓN CREAR COMPOSICIÓN
// 			if (!this.iface.establecerOpcionesLote(curLS))
// 				return false;
			var datosProceso_:Array = [];
			datosProceso_ = flfactalma.iface.pub_datosProcesoArticulo(curLS.valueBuffer("referencia"));
			if (datosProceso_) {
				if (datosProceso_["produccion"] && datosProceso_["tipoproduccion"] == "F") {
					idProceso = flcolaproc.iface.pub_crearProcesoProd(curLS.valueBuffer("referencia"), curLS.valueBuffer("codlote"), curLS.valueBuffer("idlineapc"));
					if (!idProceso) {
						MessageBox.warning(util.translate("scripts", "Error al crear el proceso %1 para el lote %2").arg(this.iface.datosProceso_["idtipoproceso"]).arg(curLS.valueBuffer("codlote")), MessageBox.Ok, MessageBox.NoButton);
						return false;
					}
				}
			}

			if (!this.iface.crearComposicion(curLS,false,false,idProceso,true))
				return false;
			if (!this.iface.afterCambioEstadoLote(curLS))
				return false;
			break;
		}
		case curLS.Edit: {

			if (curLS.valueBuffer("canlote") != curLS.valueBufferCopy("canlote")) {
				if (!this.iface.borrarComposicion(curLS))
					return false;

				var referencia:String = curLS.valueBuffer("referencia");
				if(!referencia || referencia == "")
					return false;
				var idTipoProceso = util.sqlSelect("articulos","idtipoproceso","referencia = '" + referencia + "'");
				var idProceso:Number = 0;
				if(idTipoProceso) {
					idProceso = util.sqlSelect("pr_procesos","idproceso","idobjeto = '" + curLS.valueBuffer("codlote") + "' AND idtipoproceso = '" + idTipoProceso + "'");
				}
				if(idProceso) {
					if (!this.iface.crearComposicion(curLS,false,false,idProceso,true))
						return false;
				}
				else {
					if (!this.iface.crearComposicion(curLS,false,false,false,true))
						return false;
				}
			}
			if (curLS.valueBuffer("estado") != curLS.valueBufferCopy("estado")) {
				if (!this.iface.afterCambioEstadoLote(curLS))
					return false;
			}
			if (curLS.valueBuffer("fechafabricacion") != curLS.valueBufferCopy("fechafabricacion")) {
				if (!this.iface.actualizarFechaComponentesLote(curLS))
					return false;
			}
			break;
		}
		case curLS.Del: {
			if (!this.iface.borrarComposicion(curLS))
				return false;
			break;
		}
	}
	return true;
}

/** \D Función recursiva que crea los lotes y movimientos asociados a la composición de un producto.
@param	curLoteStock: Cursor con el lote cuya composición hay que crear (primera llamada)
@param	curComponente: Cursor con el componente cuya composición de hay que crear (resto de llamadas)
@param	refProceso: Artículo que contiene los componentes que el proceso consume
@param	idProceso: Proceso al que asociar los movimientos de consumo
\end */
function prod_crearComposicion(curLoteStock:FLSqlCursor, curComponente:FLSqlCursor, refProceso:String, idProceso:String,primeraLlamada:Boolean):Boolean
{
	var util:FLUtil = new FLUtil;
	var referencia:String;
	var codLote:String;
	var cantidad:Number;

	if (curComponente) {
		referencia = curComponente.valueBuffer("refcomponente");
		cantidad = curComponente.valueBuffer("cantidad");
	} else {
		if (refProceso) {
			referencia = refProceso;
		} else {
			referencia = curLoteStock.valueBuffer("referencia");
		}
		codLote = curLoteStock.valueBuffer("codlote");
		cantidad = curLoteStock.valueBuffer("canlote");
	}

// 	if (!util.sqlSelect("articulos", "fabricado", "referencia = '" + referencia + "'"))
// 		return true;

	if (!cantidad || isNaN(cantidad) || cantidad == 0) {
		MessageBox.warning(util.translate("scritps", "Error: Intenta crear una composición con cantidad 0"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	var tipoStock:String;
	var nuevaCantidad:Number;
	var datosRev:Array;
	var idTipoOpcionArt:String;
	var idTipoOpcion:String;
	var idTipoOpcionArt:String;
	var idTipoOpcion:String;
	var idTipoProceso:String = "";

	if(idProceso)
		idTipoProceso = util.sqlSelect("pr_procesos","idtipoproceso","idproceso = " + idProceso);

	var curComponentes:FLSqlCursor = new FLSqlCursor("articuloscomp");

	if(idTipoProceso && idTipoProceso != "")
		curComponentes.select("refcompuesto = '" + referencia + "' AND idtipotareapro IN (SELECT idtipotareapro FROM pr_tipostareapro WHERE idtipoproceso = '" + idTipoProceso + "')");
	else
		curComponentes.select("refcompuesto = '" + referencia + "'");

	var numComponentes:Number = 0;
	if(primeraLlamada) {
		numComponentes = util.sqlSelect("articuloscomp","count(id)","refcompuesto = '" + referencia + "'");
		util.createProgressDialog( util.translate( "scripts", "Creando composición para el artículo %1..." ).arg(referencia), numComponentes);
	}

	var xmlTareas:FLDomNodeList;
	var eTarea:FLDomElement;
	var idTipoTareaProXML:String;
	var idTipoTareaPro:String;
	if(idProceso) {
		var xmlDocParametros:FLDomDocument = new FLDomDocument;
		if (!xmlDocParametros.setContent(util.sqlSelect("pr_procesos","xmlparametros","idproceso = " + idProceso)))
			return false;
		var xmlProceso:FLDomNode = xmlDocParametros.firstChild();
		xmlTareas = xmlProceso.toElement().elementsByTagName("Tarea");
	}

	var saltar:Boolean = false;
	var progreso:Number = 0;
	while (curComponentes.next()) {
		if(primeraLlamada)
			util.setProgress(progreso++);
		idTipoTareaPro = curComponentes.valueBuffer("idtipotareapro");
		saltar = false;

		if (idProceso && xmlTareas) {
			var i:Number = 0
			while (i < xmlTareas.length() && !saltar) {
				eTarea = xmlTareas.item(i).toElement();
				idTipoTareaProXML = eTarea.attribute("IdTipoTareaPro");
				if(idTipoTareaProXML != idTipoTareaPro){
					i ++;
					continue;
				}
				if (eTarea.attribute("Estado") == "Saltada")
					saltar = true;
				i++;
			}
		}
		if(saltar)
			continue;

		idTipoOpcionArt = curComponentes.valueBuffer("idtipoopcionart");
		idTipoOpcion = util.sqlSelect("tiposopcionartcomp","idtipoopcion","idtipoopcionart = " + idTipoOpcionArt);

		if (idTipoOpcion && idTipoOpcion != 0) {
			idValorOpcionArt = curComponentes.valueBuffer("idopcionarticulo");
			idValorOpcion = util.sqlSelect("opcionesarticulocomp","idopcion","idopcionarticulo = " + idValorOpcionArt);

			var valorOpcionNueva:Number = this.iface.buscarOpcionLote(idTipoOpcion,codLote,idProceso);
			if(!valorOpcionNueva) {
				if(primeraLlamada)
					util.destroyProgressDialog();
				return false;
			}

			if(valorOpcionNueva != idValorOpcion) {
				continue;
			}
		}
		curComponentes.setModeAccess(curComponentes.Edit);
		curComponentes.refreshBuffer();

		var idLinea:Number
		if(idProceso)
			idLinea = util.sqlSelect("pr_procesos","idlineapedidocli","idproceso = " + idProceso);

		datosRev = this.iface.revisarComponente(curComponentes,idLinea,codLote);
		if (!datosRev) {
			if(primeraLlamada)
				util.destroyProgressDialog();
			return false;
		}

		if (parseFloat(datosRev["cantidad"]) == 0)
			continue;

		curComponentes.setValueBuffer("refcomponente",datosRev["referencia"]);
		nuevaCantidad = cantidad * parseFloat(datosRev["cantidad"]);
		tipoStock = util.sqlSelect("articulos", "tipostock", "referencia = '" + curComponentes.valueBuffer("refcomponente") + "'");
		switch (tipoStock) {
			case "Lotes": {
				if (!this.iface.generarLoteStock(curLoteStock, nuevaCantidad, curComponentes, idProceso)) {
					if(primeraLlamada)
						util.destroyProgressDialog();
					return false;
				}
				break;
			}
			case "Grupo base": {
				if (!this.iface.crearComposicion(curLoteStock, curComponentes, refProceso, idProceso)) {
					if(primeraLlamada)
						util.destroyProgressDialog();
					return false;
				}
				break;
			}
			default: {
				if (util.sqlSelect("articuloscomp","refcompuesto","refcompuesto = '" + datosRev["referencia"] + "'")) {
					if (!this.iface.crearComposicion(curLoteStock, curComponentes, refProceso, idProceso)) {
						if(primeraLlamada)
							util.destroyProgressDialog();
						return false;
					}
				} else {
					if (!this.iface.generarMoviStock(curLoteStock, false, nuevaCantidad, curComponentes, idProceso)) {
						if(primeraLlamada)
							util.destroyProgressDialog();
						return false;
					}
				}
				break;
			}
		}
	}

	if(primeraLlamada)
		util.destroyProgressDialog();

	return true;
}

function prod_buscarOpcionLote(idTipoOpcion:Number,codLote:String,idProceso:Number):Number
{
	var util:FLUtil;

	var valorOpcion:Number = 0;

	var parametrosXML:String = util.sqlSelect("lotesstock", "xmlparametros", "codlote = '" + codLote + "'");
	var xmlDocLote:FLDomDocument = new FLDomDocument;
	var xmlLote:FLDomNode;
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
			if(idTipoOpcion == opcion.attribute("IdTipoOpcion")) {
				valorOpcion = opcion.attribute("IdValorOpcion");
				break;
			}
		}
	}

	if(!valorOpcion)
		valorOpcion = util.sqlSelect("opcioneslote", "idopcion", "codlote = '" + codLote + "' AND idtipoopcion = " + idTipoOpcion + " AND (idproceso IS NULL OR idproceso = 0 OR idproceso = " + idProceso + ")");

	if(!valorOpcion)
		valorOpcion = this.iface.establecerOpcionesLote(codLote,idProceso,idTipoOpcion);

	if(!valorOpcion)
		return false;

	return valorOpcion;
}

/** \D Elimina los movimientos de stock asociados a un lote para un determinado proceso de producción
@param	curLoteStock: Cursor con el lote cuya composición hay que borrar
@param	idProceso: Proceso de producción respecto al cual hay que borrar la composición (opcional)
\end */
function prod_borrarComposicion(curLoteStock:FLSqlCursor, idProceso:String):Boolean
{
	var util:FLUtil = new FLUtil;

	var referencia:String;
	referencia = curLoteStock.valueBuffer("referencia");

	if (!util.sqlSelect("articulos", "fabricado", "referencia = '" + referencia + "'"))
		return true;

	var codLote:String = curLoteStock.valueBuffer("codlote");

	var where:String = "codloteprod = '" + codLote + "'";
	if (idProceso && idProceso != "") {
		where += " AND idproceso = " + idProceso;
	}

	if (util.sqlSelect("movistock", "idmovimiento", where + " AND estado <> 'PTE'")) {
		MessageBox.warning(util.translate("scritps", "Error: Intenta borrar un movimiento de consumo en estado distinto de PTE"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	if (!util.sqlDelete("movistock", where))
		return false;

	return true;
}

function prod_modificarFechaPedidoCli(curPedido:FLSqlCursor):Boolean
{
	var qryLineas:FLSqlQuery = new FLSqlQuery;
	with (qryLineas) {
		setTablesList("lineaspedidoscli");
		setSelect("idlinea");
		setFrom("lineaspedidoscli");
		setWhere("idpedido = " + curPedido.valueBuffer("idpedido"));
		setForwardOnly(true);
	}
	if (!qryLineas.exec())
		return false;

	var curMoviStock:FLSqlCursor = new FLSqlCursor("movistock");
	while (qryLineas.next()) {
		curMoviStock.select("idlineapc = " + qryLineas.value("idlinea"));
		while (curMoviStock.next()) {
			curMoviStock.setModeAccess(curMoviStock.Edit);
			curMoviStock.refreshBuffer();
			curMoviStock.setValueBuffer("fechaprev", curPedido.valueBuffer("fechasalida"));
			if (!curMoviStock.commitBuffer())
				return false;
		}
	}
	return true;
}

function prod_modificarFechaAlbaranCli(curAlbaran:FLSqlCursor):Boolean
{
	var qryLineas:FLSqlQuery = new FLSqlQuery;
	with (qryLineas) {
		setTablesList("lineasalbaranescli");
		setSelect("idlinea");
		setFrom("lineasalbaranescli");
		setWhere("idalbaran = " + curAlbaran.valueBuffer("idalbaran"));
		setForwardOnly(true);
	}
	if (!qryLineas.exec()) {
		return false;
	}
	var curMoviStock:FLSqlCursor = new FLSqlCursor("movistock");
	while (qryLineas.next()) {
		curMoviStock.select("idlineaac = " + qryLineas.value("idlinea"));
		while (curMoviStock.next()) {
			curMoviStock.setModeAccess(curMoviStock.Edit);
			curMoviStock.refreshBuffer();
			curMoviStock.setValueBuffer("fechareal", curAlbaran.valueBuffer("fecha"));
			curMoviStock.setValueBuffer("horareal", curAlbaran.valueBuffer("hora"));
			if (!curMoviStock.commitBuffer()) {
				return false;
			}
		}
	}
	return true;
}

function prod_modificarFechaPedidoProv(curPedido:FLSqlCursor):Boolean
{
	var qryLineas:FLSqlQuery = new FLSqlQuery;
	with (qryLineas) {
		setTablesList("lineaspedidosprov");
		setSelect("idlinea");
		setFrom("lineaspedidosprov");
		setWhere("idpedido = " + curPedido.valueBuffer("idpedido"));
		setForwardOnly(true);
	}
	if (!qryLineas.exec())
		return false;

	var curMoviStock:FLSqlCursor = new FLSqlCursor("movistock");
	while (qryLineas.next()) {
		curMoviStock.select("idlineapp = " + qryLineas.value("idlinea"));
		while (curMoviStock.next()) {
			curMoviStock.setModeAccess(curMoviStock.Edit);
			curMoviStock.refreshBuffer();
			curMoviStock.setValueBuffer("fechaprev", curPedido.valueBuffer("fechaentrada"));
			if (!curMoviStock.commitBuffer())
				return false;
		}
	}
	return true;
}

function prod_modificarFechaAlbaranProv(curAlbaran:FLSqlCursor):Boolean
{
	var qryLineas:FLSqlQuery = new FLSqlQuery;
	with (qryLineas) {
		setTablesList("lineasalbaranesprov");
		setSelect("idlinea");
		setFrom("lineasalbaranesprov");
		setWhere("idalbaran = " + curAlbaran.valueBuffer("idalbaran"));
		setForwardOnly(true);
	}
	if (!qryLineas.exec()) {
		return false;
	}
	var curMoviStock:FLSqlCursor = new FLSqlCursor("movistock");
	while (qryLineas.next()) {
		curMoviStock.select("idlineaap = " + qryLineas.value("idlinea"));
		while (curMoviStock.next()) {
			curMoviStock.setModeAccess(curMoviStock.Edit);
			curMoviStock.refreshBuffer();
			curMoviStock.setValueBuffer("fechareal", curAlbaran.valueBuffer("fecha"));
			curMoviStock.setValueBuffer("horareal", curAlbaran.valueBuffer("hora"));
			if (!curMoviStock.commitBuffer()) {
				return false;
			}
		}
	}
	return true;
}


/** \D Crea un registro de stock para el almacén y artículo especificados
@param	codAlmacen: Almacén
@param	datosArt: Array con los datos del artículo
@return	identificador del stock o false si hay error
\end */
function prod_crearStock(codAlmacen:String, datosArt:Array):Number
{
	var util:FLUtil = new FLUtil;
	var curStock:FLSqlCursor = new FLSqlCursor("stocks");
	with(curStock) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("codalmacen", codAlmacen);
		setValueBuffer("referencia", datosArt["referencia"]);
		setValueBuffer("nombre", util.sqlSelect("almacenes", "nombre", "codalmacen = '" + codAlmacen + "'"));
		setValueBuffer("cantidad", 0);
		if (!commitBuffer())
			return false;
	}
	return curStock.valueBuffer("idstock");
}

function prod_beforeCommit_lotesstock(curLote:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	switch (curLote.modeAccess()) {
		case curLote.Edit: {
			if (curLote.valueBuffer("estado") != curLote.valueBufferCopy("estado"))
				if (!this.iface.beforeCambioEstadoLote(curLote))
					return false;
			break;
		}
		case curLote.Del: {
			if (!this.iface.comprobarProcesosLoteABorrar(curLote)) {
				return false;
			}
			break;
		}
	}

	return true;
}

/** Comprueba, antes de borrar un lote, que éste no tenga procesos asociados en estado OFF, y borra los procesos asociados en estado OFF que pueda haber
@param curLote: Cursor del lote a borrar
\end */
function prod_comprobarProcesosLoteABorrar(curLote:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	if (util.sqlSelect("pr_procesos","idproceso","idobjeto = '" + curLote.valueBuffer("codlote") + "' AND estado <> 'OFF'")) {
		MessageBox.warning(util.translate("scripts", "No puede borrar el lote %1 porque tiene procesos de producción asociados.").arg(curLote.valueBuffer("codlote")), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	var curProcesos:FLSqlCursor = new FLSqlCursor("pr_procesos");
	curProcesos.select("idobjeto = '" + curLote.valueBuffer("codlote") + "' AND estado = 'OFF'");
	while (curProcesos.next()) {
		curProcesos.setModeAccess(curProcesos.Del);
		curProcesos.refreshBuffer();
		if (!curProcesos.commitBuffer()) {
			return false;
		}
	}
	return true;
}

function prod_beforeCambioEstadoLote(curLote:FLSqlCursor):Boolean
{
	return true;
}

function prod_afterCambioEstadoLote(curLote:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	var idOrden:String = curLote.valueBuffer("codordenproduccion");

	switch (curLote.valueBuffer("estado")) {
// 		case "PTE": {
// 			switch (curLote.valueBufferCopy("estado")) {
// 				case "EN CURSO":{
// 					if (!util.sqlSelect("lotesstock","codlote","estado <> 'PTE' AND codordenproduccion = '" + idOrden + "'")){
// 						if (!util.sqlUpdate("pr_ordenesproduccion", "estado", "PTE", "codorden = '" + idOrden + "'"))
// 							return false;
// 					}
// 				}
// 				break;
// 			}
// 		}
// 		break;
		case "EN CURSO": {
			switch (curLote.valueBufferCopy("estado")) {
				case "TERMINADO": {
					var codLote:String = curLote.valueBuffer("codlote");
					if (util.sqlSelect("movistock", "idmovimiento", "codlote = '" + codLote + "' AND estado = 'HECHO' AND cantidad < 0")) {
						MessageBox.warning(util.translate("scripts", "No puede deshacerse el lote %1. El lote ya ha sido usado.\n(Tiene asociados movimientos de consumo en estado HECHO).").arg(codLote), MessageBox.Ok, MessageBox.NoButton);
						return false;
					}
// 					if (!util.sqlUpdate("pr_ordenesproduccion", "estado", "EN CURSO", "codorden = '" + idOrden + "'"))
// 						return false;
				}
				break;
// 				case "PTE":{
// 					if (!util.sqlUpdate("pr_ordenesproduccion", "estado", "EN CURSO", "codorden = '" + idOrden + "'"))
// 						return false;
// 				}
// 				break;
			}
		}
		break;
		case "TERMINADO": {
			var codLote:String = curLote.valueBuffer("codlote");
			if (!this.iface.asignarMoviStockSinLote(codLote))
				return false;
			break;
		}
// 			switch (curLote.valueBufferCopy("estado")) {
// 				default: {
// 					if (!util.sqlSelect("lotesstock","codlote","estado <> 'TERMINADO' AND codordenproduccion = '" + idOrden + "'")){
// 						if (!util.sqlUpdate("pr_ordenesproduccion", "estado", "TERMINADO", "codorden = '" + idOrden + "'"))
// 							return false;
// 					}
// 				}
// 				break;
// 			}
// 		}
// 		break;
	}

	return true;
}

function prod_modificarEstadoOrden(codOrden:String):Boolean
{
	var util:FLUtil = new FLUtil;

	var estadoPrevio:String = util.sqlSelect("pr_ordenesproduccion", "estado", "codorden = '" + codOrden + "'");
	var estadoActual:String;
	if (util.sqlSelect("lotesstock ls INNER JOIN pr_procesos p ON ls.codlote = p.idobjeto INNER JOIN pr_tiposproceso ON p.idtipoproceso = tp.idtipoproceso ", "l.codlote", "tp.fabricacion = true AND l.codordenproduccion = '" + codOrden + "' AND p.estado = 'PTE'")) {
		estadoActual = "PTE";
	} else if (util.sqlSelect("lotesstock ls INNER JOIN pr_procesos p ON ls.codlote = p.idobjeto INNER JOIN pr_tiposproceso ON p.idtipoproceso = tp.idtipoproceso ", "l.codlote", "tp.fabricacion = true AND l.codordenproduccion = '" + codOrden + "' AND p.estado = 'EN CURSO'")) {
		estadoActual = "EN CURSO";
	} else {
		estadoActual = "TERMINADA";
	}
	if (estadoActual != estadoPrevio) {
		if (!util.sqlUpdate("pr_ordenesproduccion", "estado", estadoActual, "codorden = '" + codOrden + "'"))
			return false;
	}
	return true;
}

/** \D Indica si un artículo está asociado a un proceso de producción de tipo Modificación
@param	referencia: Referencia del artículo
@return True si está asociado, false en caso contrario
\end */
function prod_datosProcesoArticulo(referencia:String):Array
{
	var util:FLUtil = new FLUtil;
	var datos:Array = [];

	if (!sys.isLoadedModule("flcolaproc")) {
		datos["produccion"] = false;
		return datos;
	}
	var qryProceso:FLSqlQuery = new FLSqlQuery();
	with (qryProceso) {
		setTablesList("articulos,pr_tiposproceso");
		setSelect("a.fabricado, tp.tipoproduccion, tp.idtipoproceso");
		setFrom("articulos a INNER JOIN pr_tiposproceso tp ON a.idtipoproceso = tp.idtipoproceso");
		setWhere("a.referencia = '" + referencia + "'");
	}
	if (!qryProceso.exec()) {
		return false;
	}
	datos["produccion"] = false;
	if (!qryProceso.first()) {
		return datos;
	}
	datos["produccion"] = qryProceso.value("a.fabricado");
	datos["idtipoproceso"] = qryProceso.value("tp.idtipoproceso");
	datos["tipoproduccion"] = qryProceso.value("tp.tipoproduccion").left(1);
	if (!datos["tipoproduccion"]) {
		MessageBox.warning(util.translate("scripts", "Error al consultar el tipo de proceso de producción asociado al artículo o servicio %1").arg(referencia), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	return datos;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function prod_controlStockLineasTrans(curLTS:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	var codAlmacenOrigen:String = util.sqlSelect("transstock", "codalmaorigen", "idtrans = " + curLTS.valueBuffer("idtrans"));
	if (!codAlmacenOrigen || codAlmacenOrigen == "")
		return true;

	var codAlmacenDestino:String = util.sqlSelect("transstock", "codalmadestino", "idtrans = " + curLTS.valueBuffer("idtrans"));
	if (!codAlmacenDestino || codAlmacenDestino == "")
		return true;

	switch(curLTS.modeAccess()) {
		case curLTS.Insert: {
			if(!this.iface.generarMoviStock(curLTS))
				return false;
			break;
		}
		case curLTS.Edit: {
			if(!this.iface.borrarMoviStock(curLTS))
				return false;
			if(!this.iface.generarMoviStock(curLTS))
				return false;
			break;
		}
		case curLTS.Del: {
			if(!this.iface.borrarMoviStock(curLTS))
				return false;
			break;
		}
	}

// 	if (!this.iface.controlStock(curLTS, "cantidad", -1, codAlmacenOrigen))
// 			return false;
//
// 	if (!this.iface.controlStock(curLTS, "cantidad", -1, codAlmacenDestino))
// 			return false;

	return true;
}

function prod_mostrarEmpresa():String
{
	var empresa:String;
	empresa = flfactppal.iface.pub_valorDefectoEmpresa("nombre");
	if (!empresa) {
		empresa = "";
	}
	return empresa;
}

//// PRODUCCIÓN /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////

