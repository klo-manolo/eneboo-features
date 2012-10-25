
/** @class_declaration prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN /////////////////////////////////////////////////
class prod extends articuloscomp {
	var tbnAsociarAplicable:Object;

    function prod( context ) { articuloscomp ( context ); }
	function init() {
		return this.ctx.prod_init();
	}
	function tbnAsociarAplicable_clicked() {
		return this.ctx.prod_tbnAsociarAplicable_clicked();
	}
	function comprobarTabStock() {
		return this.ctx.prod_comprobarTabStock();
	}
	function validateForm():Boolean {
		return this.ctx.prod_validateForm();
	}
	function bufferChanged(fN:String) {
		return this.ctx.prod_bufferChanged(fN);
	}
	function calcularDatosNodoCompuesto(referencia:String):Array {
		return this.ctx.prod_calcularDatosNodoCompuesto(referencia);
	}
	function insertArticuloComp() {
		return this.ctx.prod_insertArticuloComp();
	}
	function calcularPvp() {
		return this.ctx.prod_calcularPvp();
	}
	function editArticulo() {
		return this.ctx.prod_editArticulo();
	}
	function browseArticulo() {
		return this.ctx.prod_browseArticulo();
	}
	function deleteArticulo() {
		return this.ctx.prod_deleteArticulo();
	}
	function refrescarNodos() {
		return this.ctx.prod_refrescarNodos();
	}
	function imagenComponente(idComp:String, referencia:String):String {
		return this.ctx.prod_imagenComponente(idComp, referencia);
	}
	function codigoComponente(idComp:String, referencia:String):String {
		return this.ctx.prod_codigoComponente(idComp, referencia);
	}
	function borrarDatosStock(referencia:String):Boolean {
		return this.ctx.prod_borrarDatosStock(referencia);
	}
	function mostrarListadoMS() {
		return this.ctx.prod_mostrarListadoMS();
	}
	function esVariable(referencia:String):Boolean {
		return this.ctx.prod_esVariable(referencia);
	}
}
//// PRODUCCIÓN /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN /////////////////////////////////////////////////
function prod_init()
{
	this.iface.__init();
	var cursor:FLSqlCursor = this.cursor();

	this.iface.tbnProvDefecto = this.child("tbnProvDefecto");
	this.iface.tbnAsociarAplicable = this.child("tbnAsociarAplicable");

	connect (this.iface.tbnProvDefecto, "clicked()", this, "iface.marcarProvDefecto");
	connect (this.iface.tbnAsociarAplicable, "clicked()", this, "iface.tbnAsociarAplicable_clicked");
	connect (this.child("tnbMostrarListadoMS"), "clicked()", this, "iface.mostrarListadoMS");

	if (sys.isLoadedModule("flcolaproc")) {
		if (cursor.valueBuffer("fabricado")) {
			this.child("fdbDiasProdEnvio").setDisabled(false);
			this.child("fdbIdTipoProceso").setDisabled(false);
		}
	} else {
		this.child("gbxProduccion").close();
	}
}

function prod_tbnAsociarAplicable_clicked()
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();

	var f:Object = new FLFormSearchDB("articulos");
	var curArticulosFabricados:FLSqlCursor = f.cursor();

	//curArticulosFabricados.setMainFilter("fabricado = true AND idtipoproceso IN (SELECT idtipoproceso FROM pr_tiposproceso WHERE fabricacion = true AND tipoproduccion = 'Fabricación')");
	curArticulosFabricados.setMainFilter("tipostock = 'Lotes'");

	f.setMainWidget();
	var refAplicable:String = f.exec("referencia");

	if (refAplicable) {
		var curAplicable:FLSqlCursor = new FLSqlCursor("articulosaplicables");
		curAplicable.setModeAccess(curAplicable.Insert);
		curAplicable.refreshBuffer();
		curAplicable.setValueBuffer("refproceso", cursor.valueBuffer("referencia"));
		curAplicable.setValueBuffer("refaplicable", refAplicable);
		if (!curAplicable.commitBuffer())
			return false;

		this.child("tdbArticulosAplicables").refresh();
	}
}

function prod_comprobarTabStock()
{
	return;
}

function prod_validateForm():Boolean
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	if (cursor.valueBuffer("fabricado")) {
		var idTipoProceso:String = cursor.valueBuffer("idtipoproceso");
		if (!idTipoProceso || idTipoProceso == "") {
			MessageBox.warning(util.translate("scripts", "Si el artículo es fabricado, debe indicar cuál es su proceso de fabricación"), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}

		if (!util.sqlSelect("pr_tiposproceso", "fabricacion", "idtipoproceso = '" + idTipoProceso + "'")) {
			MessageBox.warning(util.translate("scripts", "El tipo de proceso %1 no está marcado como Proceso de fabricación.\nModifique este tipo de proceso o elija uno distinto que sí esté marcado.").arg(idTipoProceso), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}

		var tipoProduccion:String = util.sqlSelect("pr_tiposproceso", "tipoproduccion", "idtipoproceso = '" + idTipoProceso + "'");
		switch (tipoProduccion) {
			case "Fabricación": {
				if (cursor.valueBuffer("tipostock") != "Lotes") {
					MessageBox.warning(util.translate("scripts", "El proceso asociado al artículo es de fabricación. El tipo de stock debe ser Lotes"), MessageBox.Ok, MessageBox.NoButton);
					return false;
				}
				if(util.sqlSelect("articulosaplicables","id","refproceso = '" + cursor.valueBuffer("referencia") + "'")) {
					MessageBox.warning(util.translate("scripts", "El proceso asociado al artículo es de fabricación. No debe tener artículos aplicables"), MessageBox.Ok, MessageBox.NoButton);
					return false;
				}
				break;
			}
			case "Modificación": {
				if (!cursor.valueBuffer("nostock")) {
					MessageBox.warning(util.translate("scripts", "El proceso asociado al artículo es de modificación. El artículo debe marcarse como \"Sin stock\""), MessageBox.Ok, MessageBox.NoButton);
					return false;
				}
				break;
			}
		}

		var idComponenteSinTarea:String = util.sqlSelect("articuloscomp ac LEFT OUTER JOIN articulos a ON ac.refcomponente = a.referencia", "ac.id", "ac.refcompuesto = '" + cursor.valueBuffer("referencia") + "' AND (ac.idtipotareapro = 0 OR ac.idtipotareapro IS NULL) AND (a.tipostock <> 'Grupo base' OR a.referencia IS NULL)", "articuloscomp,articulos");
		if (idComponenteSinTarea && idComponenteSinTarea != "") {
			var desComponente:String = util.sqlSelect("articuloscomp", "desccomponente", "id = " + idComponenteSinTarea);
			MessageBox.warning(util.translate("scripts", "El componente %1 no tiene tarea de consumo asignada").arg(desComponente), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
		var refComponenteTareaMala:String = util.sqlSelect("articuloscomp ac INNER JOIN pr_tipostareapro tt ON ac.idtipotareapro = tt.idtipotareapro", "ac.refcomponente", "ac.refcompuesto = '" + cursor.valueBuffer("referencia") + "' AND tt.idtipoproceso <> '" + idTipoProceso + "'", "articuloscomp,pr_tipostareapro");
		if (refComponenteTareaMala && refComponenteTareaMala != "") {
			MessageBox.warning(util.translate("scripts", "El componente %1 está asignado a una tarea que no pertenece al proceso %1.").arg(refComponenteTareaMala).arg(idTipoProceso), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
	}
	return true;
}

function prod_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();

	switch (fN) {
		case "fabricado": {
			if (cursor.valueBuffer("fabricado")) {
				cursor.setValueBuffer("tipostock", "Lotes");
				this.child("fdbDiasProdEnvio").setDisabled(false);
				this.child("fdbIdTipoProceso").setDisabled(false);
			} else {
				this.child("fdbDiasProdEnvio").setValue(0);
				this.child("fdbIdTipoProceso").setValue("");
				this.child("fdbDiasProdEnvio").setDisabled(true);
				this.child("fdbIdTipoProceso").setDisabled(true);
			}
			break;
		}
		case "tipostock": {
			if(cursor.valueBuffer("tipostock") != "Lotes") {
				cursor.setValueBuffer("loteunico",false);
				this.child("fdbLoteUnico").setDisabled(true);
			}
			else {
				this.child("fdbLoteUnico").setDisabled(false);
			}
			break;
		}
		default: {
			return this.iface.__bufferChanged(fN);
		}
	}
}

function prod_calcularDatosNodoCompuesto(referencia:String):Array
{
return this.iface.__calcularDatosNodoCompuesto(referencia);

	var util:FLUtil;
	datosNodo = new Array;

	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("articuloscomp,articulos");
	q.setSelect("articuloscomp.id,articuloscomp.refcompuesto,articuloscomp.codfamiliacomponente,articulos.descripcion,articuloscomp.cantidad,articuloscomp.codunidad");
	q.setFrom("articuloscomp INNER JOIN articulos ON articuloscomp.refcompuesto = articulos.referencia");
	q.setWhere("articuloscomp.refcomponente = '" + referencia + "'");

	if(!q.exec())
	return false;

	var i:Number = 0;
	while (q.next()) {
		var codigo:String = q.value("articuloscomp.refcompuesto");
		var imagen:String = "";
		var descripcion:String = q.value("articulos.descripcion");
		if (!codigo || codigo == "") {
			codigo = q.value("articuloscomp.codfamiliacomponente");
			imagen = util.sqlSelect("familias","imagen","codfamilia = '" + codigo + "'");
			descripcion = util.sqlSelect("familias","descripcion","codfamilia = '" + codigo + "'");
		}
		else {
			imagen = util.sqlSelect("articulos INNER JOIN familias ON articulos.codfamilia = familias.codfamilia","familias.imagen","articulos.referencia = '" + codigo + "'","articulos,familias");
			}
		datosNodo[i] = new Array;
		datosNodo[i]["id"] = q.value("articuloscomp.id");
		datosNodo[i]["codigo"] = codigo;
		datosNodo[i]["descripcion"] = descripcion;
		datosNodo[i]["cantidad"] = q.value("articuloscomp.cantidad");
		datosNodo[i]["unidad"] = q.value("articuloscomp.codunidad");
		datosNodo[i]["imagen"] = imagen;
		i += 1;
	}

	return datosNodo;
}

function prod_insertArticuloComp()
{
	var util:FLUtil;

	if (!this.iface.componenteSeleccionado)
		return;

	var cursor:FLSqlCursor = this.cursor();
	var clave:String = this.iface.componenteSeleccionado.key();

	if (cursor.modeAccess() == cursor.Edit) {
		var nodo;
		if (clave.startsWith("TO_")) {
			nodo = this.iface.componenteSeleccionado.parent();
		} else {
			nodo = this.iface.componenteSeleccionado;
		}


		if (!util.sqlSelect("articulos", "referencia", "referencia = '" + nodo.text(0) + "'")) {
			MessageBox.information(util.translate("scripts", "No se puede asociar un artículo a una familia"), MessageBox.Ok, MessageBox.NoButton);
			return;
		}
	}

	this.iface.__insertArticuloComp();
}

function prod_calcularPvp()
{
	var util:FLUtil;

	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("articuloscomp,familias");
	q.setSelect("articuloscomp.codfamiliacomponente");
	q.setFrom("articuloscomp INNER JOIN familias ON articuloscomp.codfamiliacomponente = familias.codfamilia");
	q.setWhere("articuloscomp.refcompuesto = '" + this.cursor().valueBuffer("referencia") + "'");

	if(!q.exec())
	return false;

	if (q.first()) {
		MessageBox.information(util.translate("scripts", "No se puede calcular el pvp ya que uno de los componentes es una familia"), MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	this.iface.__calcularPvp();
}

function prod_editArticulo()
{
	var util:FLUtil;
	var codigo:String = this.iface.componenteSeleccionado.text(0);
	if (util.sqlSelect("familias","codfamilia","codfamilia = '" + codigo + "'")) {
		MessageBox.information(util.translate("scripts", "No se puede editar el componente seleccionado porque es una familia"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	return this.iface.__editArticulo();
}

function prod_browseArticulo()
{
	var util:FLUtil;
	var codigo:String = this.iface.componenteSeleccionado.text(0);
	if (util.sqlSelect("familias","codfamilia","codfamilia = '" + codigo + "'")) {
		MessageBox.information(util.translate("scripts", "No se puede mostrar el componente seleccionado porque es una familia"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	return this.iface.__browseArticulo();
}

function prod_deleteArticulo()
{
	var util:FLUtil;
	var codigo:String = this.iface.componenteSeleccionado.text(0);
	if (util.sqlSelect("familias","codfamilia","codfamilia = '" + codigo + "'")) {
		MessageBox.information(util.translate("scripts", "No se puede eliminar el componente seleccionado porque es una familia"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	return this.iface.__deleteArticulo();
}

function prod_refrescarNodos()
{
return this.iface.__refrescarNodos();

	var util:FLUtil = new FLUtil;

	if (this.iface.referenciaComp_) {
		/// Alta de nuevo nodo
		if (this.iface.referenciaComp_ != this.iface.raizComponente.text(0)) {
			this.iface.buscarNodos(this.iface.referenciaComp_,this.iface.raizComponente,"");
		}
		else {
			this.iface.indice = 0;
			this.iface.arrayNodos[this.iface.indice] = this.iface.raizComponente;
			this.iface.indice += 1;
		}

		var datosNodo:Array = new Array;

		datosNodo["cantidad"] = parseFloat(this.iface.curArticulosComp_.valueBuffer("cantidad"));
		datosNodo["unidad"] = this.iface.curArticulosComp_.valueBuffer("codunidad");
		datosNodo["id"] = this.iface.curArticulosComp_.valueBuffer("id");

		/// Comprobar si el componente es familia o artículo
		var codigo:String = this.iface.curArticulosComp_.valueBuffer("refcomponente");
		var descripcion:String = this.iface.curArticulosComp_.valueBuffer("desccomponente");
		var imagen:String = "";

		if (!codigo || codigo == "") {
			codigo = this.iface.curArticulosComp_.valueBuffer("codfamiliacomponente")
			descripcion = util.sqlSelect("familias","descripcion","codfamilia = '" + codigo + "'");
			imagen = util.sqlSelect("familias","imagen","codfamilia = '" + codigo + "'");
		}
		else {
			var codFamilia:String = util.sqlSelect("articulos","codfamilia","referencia = '" + codigo + "'");

			if (codFamilia && codFamilia != "")
				imagen = util.sqlSelect("familias","imagen","codfamilia = '" + codFamilia + "'");
		}

		datosNodo["descripcion"] = descripcion;
		datosNodo["codigo"] = codigo;
		datosNodo["imagen"] = imagen;

		for (var i = 0; i < this.iface.indice; i++) {
			var nodoHijo = new FLListViewItem(this.iface.arrayNodos[i]);
			this.iface.establecerDatosNodo(nodoHijo,datosNodo);
			nodoHijo.setExpandable(false);
			this.iface.pintarNodo(nodoHijo,"componente");
		}

	} else {
		/// Modificación de nodo existente
		this.iface.__refrescarNodos();
	}
}

function prod_imagenComponente(idComp:String, referencia:String):String
{
	var util:FLUtil;
	if (referencia && referencia != "")
		return this.iface.__imagenComponente(idComp, referencia);

	var imagen:String = util.sqlSelect("articuloscomp INNER JOIN familias ON articuloscomp.codfamiliacomponente = familias.codfamilia", "familias.imagen", "articuloscomp.id = " + idComp, "articuloscomp,familias");
	return imagen;
}

function prod_codigoComponente(idComp:String, referencia:String):String
{
	var util:FLUtil;
	if (referencia && referencia != "")
		return this.iface.__codigoComponente(idComp, referencia);

	var codigo:String = util.sqlSelect("articuloscomp", "codfamiliacomponente", "id = " + idComp);
	return codigo;
}

function prod_borrarDatosStock(referencia:String):Boolean
{
	var util:FLUtil = new FLUtil;
	if (!util.sqlDelete("movistock", "referencia = '" + referencia + "'")) {
		return false;
	}
	if (!this.iface.__borrarDatosStock(referencia)) {
		return false;
	}

	return true;
}

function prod_mostrarListadoMS()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
// 	var hoy:Date = new Date();
// 	var fechaDesde:Date = new Date();
// 	fechaDesde = fechaDesde.setDate(1);
// 	fechaDesde = fechaDesde.setMonth(1);

	var f:Object = new FLFormSearchDB("mostrarlistadoms");
	var curMostrar:FLSqlCursor = f.cursor();
	curMostrar.select("idusuario = '" + sys.nameUser() + "'");
	if (!curMostrar.first()) {
		curMostrar.setModeAccess(curMostrar.Insert);
		curMostrar.refreshBuffer();
		curMostrar.setValueBuffer("idusuario", sys.nameUser());
	} else {
		curMostrar.setModeAccess(curMostrar.Edit);
		curMostrar.refreshBuffer();
	}
	curMostrar.setValueBuffer("idstock", this.child("tdbStocks").cursor().valueBuffer("idstock"));
	curMostrar.setValueBuffer("codalmacen", this.child("tdbStocks").cursor().valueBuffer("codalmacen"));
	curMostrar.setValueBuffer("referencia", cursor.valueBuffer("referencia"));
	curMostrar.setValueBuffer("desdeultimareg",true);
// 	curMostrar.setValueBuffer("fechadesde", fechaDesde);
// 	curMostrar.setValueBuffer("horadesde", "00:00");
// 	curMostrar.setValueBuffer("fechahasta", hoy);
// 	curMostrar.setValueBuffer("horahasta", hoy);
	curMostrar.setValueBuffer("pendiente", true);
	curMostrar.setValueBuffer("reservado", true);
	curMostrar.setValueBuffer("hecho", true);
	if (!curMostrar.commitBuffer())
		return false;

	curMostrar.select("idusuario = '" + sys.nameUser() + "' AND idstock = " + this.child("tdbStocks").cursor().valueBuffer("idstock"));
	if (!curMostrar.first())
		return false;

	curMostrar.setModeAccess(curMostrar.Edit);
	curMostrar.refreshBuffer();

	f.setMainWidget();
	curMostrar.refreshBuffer();
	var acpt:String = f.exec("idusuario");
	if (!acpt)
		return false;
}

function prod_esVariable(referencia:String):Boolean
{
	var util:FLUtil;
	if(!referencia || referencia == "")
		return false;

	if(this.iface.__esVariable(referencia))
		return true;

	if(util.sqlSelect("articuloscomp","codfamiliacomponente","refcompuesto = '" + referencia + "' AND codfamiliacomponente IS NOT NULL AND codfamiliacomponente <> ''"))
		return true;

	return false;
}
//// PRODUCCIÓN /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////

