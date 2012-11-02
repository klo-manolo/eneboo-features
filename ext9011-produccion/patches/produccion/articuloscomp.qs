
/** @class_declaration prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN /////////////////////////////////////////////////
class prod extends oficial {
	var bloqueo:Boolean;
	var desdeTareas:Boolean;
    function prod( context ) { oficial ( context ); }
	function init() {
		return this.ctx.prod_init();
	}
	function validateForm():Boolean {
		return this.ctx.prod_validateForm();
	}
	function bufferChanged(fN:String) {
		return this.ctx.prod_bufferChanged(fN);
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

	connect(this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged");

	var util:FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var referencia:String = this.child("fdbRefCompuesto").value();

	var curRel:FLSqlCursor = cursor.cursorRelation();
	this.iface.desdeTareas = (curRel && curRel.table() == "pr_tipostareapro");
	if (sys.isLoadedModule("flcolaproc")) {
		if (this.iface.desdeTareas) {
			this.child("fdbRefCompuesto").setFilter("idtipoproceso = '" + curRel.valueBuffer("idtipoproceso") + "'");
		} else {
			if (referencia && referencia != "") {
				var idTipoProceso:String;
				if (referencia == formRecordarticulos.cursor().valueBuffer("referencia")) {
					idTipoProceso = formRecordarticulos.cursor().valueBuffer("idtipoproceso");
				} else {
					if (formRecordarticuloscomponente.cursor() && referencia == formRecordarticuloscomponente.cursor().valueBuffer("referencia")) {
						idTipoProceso = formRecordarticuloscomponente.cursor().valueBuffer("idtipoproceso");
					} else {
						idTipoProceso = util.sqlSelect("articulos", "idtipoproceso", "referencia = '" + referencia + "'");
					}
				}
 				this.child("fdbIdTipoTareaPro").setFilter("idtipoproceso = '" + idTipoProceso + "'");
			}
		}
	} else {
		this.child("gbxProduccion").close();
	}

	switch (cursor.modeAccess()) {
		case cursor.Insert: {
			if (this.iface.desdeTareas) {
				if (parseInt(util.sqlSelect("articulos", "count(referencia)", "idtipoproceso = '" + curRel.valueBuffer("idtipoproceso") + "'")) == 1) {
					this.child("fdbRefCompuesto").setValue(util.sqlSelect("articulos", "referencia", "idtipoproceso = '" + curRel.valueBuffer("idtipoproceso") + "'"));
				}
			}
			break;
		}
		case cursor.Edit : {
			this.child("fdbCodFamiliaComponente").setDisabled(true);
			break;
		}
	}
	this.iface.bufferChanged("codfamiliacomponente");
	this.iface.bloqueo = false;
}

function prod_validateForm():Boolean
{
	if (!this.iface.__validateForm())
		return false;

	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var codFamilia:String = cursor.valueBuffer("codfamiliacomponente");
	var refComponente:String = cursor.valueBuffer("refcomponente");

	if ((!codFamilia || codFamilia == "") && (!refComponente || refComponente == "")) {
		MessageBox.warning(util.translate("scripts", "Debe establecer una familia o un componente"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	if (util.sqlSelect("articulos", "tipostock", "referencia = '" + refComponente + "'") == "Grupo base") {
		var procesoComponente:String = util.sqlSelect("articulos", "idtipoproceso", "referencia = '" + refComponente + "'");
		if (procesoComponente && procesoComponente != "") {
			var procesoCompuesto:String = util.sqlSelect("articulos", "idtipoproceso", "referencia = '" + cursor.valueBuffer("refcompuesto") + "'");
			if (procesoCompuesto && procesoCompuesto != "" && procesoCompuesto != procesoComponente) {
				MessageBox.warning(util.translate("scripts", "El componente es un grupo base.\nEl componente tiene un proceso de fabricación asociado (%1) que no coincide con el proceso del artículo compuesto (%2).").arg(procesoComponente).arg(procesoCompuesto ), MessageBox.Ok, MessageBoxNoButton);
				return false;
			}
		}
	}

	return true;
}

function prod_bufferChanged(fN:String)
{
	var util:FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var codFamilia:String = cursor.valueBuffer("codfamiliacomponente");
	var refComponente:String = cursor.valueBuffer("refcomponente");

	switch (fN) {
		case "codfamiliacomponente": {
			if (!this.iface.bloqueo){
				this.iface.bloqueo = true;
				if (codFamilia && codFamilia != "") {
					this.child("lblFamilia").text = util.translate("scripts", "Se escogerá cualquier componente de la familia indicada");
					this.child("lblComponente").text = util.translate("scripts", "Valor por defecto");
/*
					this.child("fdbRefComponente").setValue("");
					this.child("fdbDescComponente").setValue("");
					this.child("fdbRefComponente").setDisabled(true);
					this.child("fdbDescComponente").setDisabled(true);
*/
				} else {
					this.child("lblFamilia").text = "";
					this.child("lblComponente").text = util.translate("scripts", "Valor fijo del componente");;
/*
					this.child("fdbRefComponente").setDisabled(false);
					this.child("fdbDescComponente").setDisabled(false);
*/
				}
				this.iface.bloqueo = false;
			}
			break;
		}

		case "refcomponente": {
			if (util.sqlSelect("articulos", "tipostock", "referencia = '" + cursor.valueBuffer("refcomponente") + "'") == "Grupo base") {
				if (this.iface.desdeTareas) {
					MessageBox.warning(util.translate("scripts", "No puede asociar el consumo de un grupo base a una tarea"), MessageBox.Ok, MessageBox.NoButton);
				} else {
					this.child("fdbIdTipoTareaPro").setValue("");
					this.child("fdbIdTipoTareaPro").setDisabled(true);
					this.child("fdbDiasAntelacion").setValue(0);
					this.child("fdbDiasAntelacion").setDisabled(true);
				}
			} else {
				if (!this.iface.desdeTareas) {
					this.child("fdbIdTipoTareaPro").setDisabled(false);
					this.child("fdbDiasAntelacion").setDisabled(false);
				}
			}
/*
			if (!this.iface.bloqueo){
				this.iface.bloqueo = true;
				if (refComponente && refComponente != "") {
					this.child("fdbCodfamilia").setValue("");
					this.child("fdbDescFamilia").setValue("");
					this.child("fdbCodfamilia").setDisabled(true);
				}
				if (!refComponente || refComponente == "")
					this.child("fdbCodfamilia").setDisabled(false);
				this.iface.bloqueo = false;
			}
*/
			break;
		}
		case "refcompuesto": {
			this.child("fdbIdTipoOpcionArt").setValue("");
			this.child("fdbIdOpcionArticulo").setValue("");
			this.child("fdbIdTipoOpcionArt").setFilter("referencia = '" + cursor.valueBuffer("refcompuesto") + "'");
			break;
		}
		default : {
		}
	}

	return true;
}

//// PRODUCCIÓN /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

