
/** @class_declaration gtesoreria */
//////////////////////////////////////////////////////////////////
//// GTESORERIA /////////////////////////////////////////////////////
class gtesoreria extends oficial {
	function gtesoreria( context ) { oficial( context ); }
	function init() { this.ctx.gtesoreria_init(); }
	function validateForm() { return this.ctx.gtesoreria_validateForm(); }
}
//// GTESORERIA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition gtesoreria */
/////////////////////////////////////////////////////////////////
//// GTESORERIA /////////////////////////////////////////////////

// KLO. OJO: Rompe herencia
function gtesoreria_init()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	this.iface.noGenAsiento = false;

	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");

	this.iface.contabActivada = sys.isLoadedModule("flcontppal") && util.sqlSelect("empresa", "contintegrada", "1 = 1");
	this.iface.ejercicioActual = flfactppal.iface.pub_ejercicioActual();
	if (!this.iface.contabActivada) {
		this.child("tbwPagDevProv").setTabEnabled("contabilidad", false);
		this.child("tdbPartidas").setReadOnly(true);
	}

	this.child("fdbTipo").setDisabled(true);
	this.child("fdbTipo").setValue("Pago");

	if (cursor.modeAccess()==cursor.Edit){
		debug("cursor en edit");
		var editable= formRecordremesas.iface.pub_directaEditable(cursor.valueBuffer("idremesa"));
		debug("editable="+editable);
		var tipoconta = util.sqlSelect("remesas","tipoconta","idremesa="+cursor.valueBuffer("idremesa"));
		if (tipoconta=="110" && !editable){
			cursor.setModeAccess(cursor.Browse);
		}
	}
}

function gtesoreria_validateForm():Boolean
{
        var cursor:FLSqlCursor = this.cursor();
        var util:FLUtil = new FLUtil();

        var fechaRem = cursor.cursorRelation().valueBuffer("fecha");
        var fechaPago = cursor.valueBuffer("fecha");

        if (util.daysTo(fechaRem, fechaPago) < 0){
                MessageBox.warning("No puede validarse el regristro: la fecha de pago de la remesa\n debe ser igual o posterior a la fecha de creación de la remesa.",MessageBox.Ok, MessageBox.NoButton);
                return false;
        }

        return true;
}
//// GTESORERIA /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

