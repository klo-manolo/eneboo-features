
/** @class_declaration gtesoreria */
/////////////////////////////////////////////////////////////////
//// GTESORERIA ////////////////////////////////////////////////
class gtesoreria extends oficial {
	function gtesoreria( context ) { oficial ( context ); }
	function validateForm() { return this.ctx.gtesoreria_validateForm(); }
}
//// GTESORERIA ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition gtesoreria */
/////////////////////////////////////////////////////////////////
//// GTESORERIA /////////////////////////////////////////////////

// KLO. OJO: Rompe herencia
function gtesoreria_validateForm():Boolean
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();

	/** \C
	Si es una devolución, está activada la contabilidad y su pago correspondiente no genera asiento no puede generar asiento
	\end */
	if (this.iface.contabActivada && this.iface.noGenAsiento && this.cursor().valueBuffer("tipo") == "Devolución" && !this.child("fdbNoGenerarAsiento").value()) {
		MessageBox.warning(util.translate("scripts", "No se puede generar el asiento de una devolución cuyo pago no tiene asiento asociado"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}

	/** \C
	Si la contabilidad está integrada, se debe seleccionar una subcuenta válida a la que asignar el asiento de pago o devolucián
	\end */
	if (this.iface.contabActivada && !this.child("fdbNoGenerarAsiento").value() && (this.child("fdbCodSubcuenta").value().isEmpty() || this.child("fdbIdSubcuenta").value() == 0)) {
		MessageBox.warning(util.translate("scripts", "Debe seleccionar una subcuenta válida a la que asignar el asiento de pago o devolución"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}

/*
	La fecha de un pago o devolución debe ser siempre igual o posterior\na la fecha de emisión del recibo
	\end
	if (util.daysTo(cursor.cursorRelation().valueBuffer("fecha"), cursor.valueBuffer("fecha")) < 0) {
		MessageBox.warning(util.translate("scripts", "La fecha de un pago o devolución debe ser siempre igual o posterior\na la fecha de emisión del recibo."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
*/
	/** \C
	La fecha de un pago o devolución debe ser siempre posterior\na la fecha del pago o devolución anterior
	\end */
	var curPagosDevol:FLSqlCursor = new FLSqlCursor("pagosdevolprov");
	curPagosDevol.select("idrecibo = " + cursor.cursorRelation().valueBuffer("idrecibo") + " AND idpagodevol <> " + cursor.valueBuffer("idpagodevol") + " ORDER BY  fecha, idpagodevol");
	if (curPagosDevol.last()) {
		curPagosDevol.setModeAccess(curPagosDevol.Browse);
		curPagosDevol.refreshBuffer();
		if (util.daysTo(curPagosDevol.valueBuffer("fecha"), cursor.valueBuffer("fecha")) <= 0) {
			MessageBox.warning(util.translate("scripts", "La fecha de un pago o devolución debe ser siempre posterior\na la fecha del pago o devolución anterior."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
	}

	/** \C Si el ejercicio de la factura que originó el recibo no coincide con el ejercicio actual, se solicita al usuario que confirme el pago
	\end */
	var ejercicioFactura = util.sqlSelect("recibosprov r INNER JOIN facturasprov f ON r.idfactura = f.idfactura", "f.codejercicio", "r.idrecibo = " + cursor.valueBuffer("idrecibo"), "recibosprov,facturasprov");
    if (ejercicioFactura){
        if (this.iface.ejercicioActual != ejercicioFactura) {
            var respuesta:Number = MessageBox.warning(util.translate("scripts", "El ejercicio de la factura que originó este recibo es distinto del ejercicio actual ¿Desea continuar?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
            if (respuesta != MessageBox.Yes)
                return false;
        }
    }

	return true;
}
//// GTESORERIA /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

