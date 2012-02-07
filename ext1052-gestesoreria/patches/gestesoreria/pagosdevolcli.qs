
/** @class_declaration gestesoreria */
//////////////////////////////////////////////////////////////////
//// GESTESORERIA ///////////////////////////////////////////////
class gestesoreria extends pagosMulti {
    function gestesoreria( context ) { pagosMulti( context ); }

    function init() { this.ctx.gestesoreria_init(); }

    function calculateFieldOrig(fN:String):String {
	   return this.ctx.interna_calculateField(fN);
    }

    function calculateField(fN:String):String {
            return this.ctx.gestesoreria_calculateField(fN);
    }

    function bngTasaCambio_clicked(opcion:Number) {
            return this.ctx.gestesoreria_bngTasaCambio_clicked(opcion);
    }

}
//// GESTESORERIA ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration recibosmulticli */
/////////////////////////////////////////////////////////////////
//// RECIBOSMULTICLI ////////////////////////////////////////////
class recibosmulticli extends gestesoreria {
    function recibosmulticli( context ) { gestesoreria ( context ); }
    function validateForm() { return this.ctx.recibosmulticli_validateForm(); }
}
//// RECIBOSMULTICLI /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration recibosmanuales */
/////////////////////////////////////////////////////////////////
//// RECIBOSMANUALES ////////////////////////////////////////////
class recibosmanuales extends recibosmulticli {
    function recibosmanuales( context ) { recibosmulticli ( context ); }
    function validateForm() { return this.ctx.recibosmanuales_validateForm(); }
}
//// RECIBOSMANUALES /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition gestesoreria */
/////////////////////////////////////////////////////////////////
//// GESTESORERIA /////////////////////////////////////////////////

/** \C En el caso de que el registro sea tipo Pago y éste halla sido insertado de manera automática, se cambia el modo a browse
\end */
function gestesoreria_init()
{
        this.iface.__init();

        var cursor:FLSqlCursor = this.cursor();
        if (cursor.modeAccess() == cursor.Edit){
                if (cursor.valueBuffer("automatico") == true){
                       cursor.setModeAccess(cursor.Browse);
                       cursor.refreshBuffer();
                }
        }

        this.child("gbxGastoDevol").setHidden(true);
}

function gestesoreria_calculateField(fN:String):String {
    var cursor:FLSqlCursor = this.cursor();
    var res:String;
    var util:FLUtil = new FLUtil;
    	switch (fN) {
		case "codsubcuenta": {
                res = util.sqlSelect("cuentasbanco", "codsubcuenta", "codcuenta ='" + cursor.valueBuffer ("codcuenta")+"'");
			break;
		}
		default: {
			res = this.iface.calculateFieldOrig(fN);
			break;
		}
	}
	return res;
}

/** \D
Establece el valor de --tasaconv-- obteniéndolo de la factura original si la hubiese o del cambio actual de la divisa del recibo
@param  opcion: Origen de la tasa: tasa actual o tasa de la factura original
\end */
function gestesoreria_bngTasaCambio_clicked(opcion:Number)
{
        var util:FLUtil = new FLUtil();
        var cursor:FLSqlCursor = this.cursor();
        var tasaCalc = util.sqlSelect("divisas", "tasaconv", "coddivisa = '" + this.iface.curRelacionado.valueBuffer("coddivisa") + "'");
        switch (opcion) {
        case 0: // Tasa actual
                this.child("fdbTasaConv").setValue(tasaCalc);
                break;
        case 1: // Tasa de la factura si la hay
                if (this.iface.curRelacionado.valueBuffer("idfactura") && this.iface.curRelacionado.valueBuffer("idfactura")!=""){
                        this.child("fdbTasaConv").setValue(util.sqlSelect("facturascli", "tasaconv", "idfactura = " + this.iface.curRelacionado.valueBuffer("idfactura")));
                }else{
                        this.child("fdbTasaConv").setValue(tasaCalc);
                }
                break;
        }
}
//// GESTESORERIA /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////

/** @class_definition recibosmulticli */
/////////////////////////////////////////////////////////////////
//// RECIBOSMULTICLI ////////////////////////////////////////////
function recibosmulticli_validateForm():Boolean
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
        Si la contabilidad está integrada, se debe seleccionar una subcuenta válida a la que asignar el asiento de pago o devolución
        \end */
        if (this.iface.contabActivada && !this.child("fdbNoGenerarAsiento").value() && (this.child("fdbCodSubcuenta").value().isEmpty() || this.child("fdbIdSubcuenta").value() == 0)) {
                MessageBox.warning(util.translate("scripts", "Debe seleccionar una subcuenta válida a la que asignar el asiento de pago o devolución"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
                return false;
        }

        /** \C
        La fecha de un pago o devolución debe ser siempre posterior\na la fecha del pago o devolución anterior
        \end */
        var curPagosDevol:FLSqlCursor = new FLSqlCursor("pagosdevolcli");
        curPagosDevol.select("idrecibo = " + this.iface.curRelacionado.valueBuffer("idrecibo") + " AND idpagodevol <> " + cursor.valueBuffer("idpagodevol") + " ORDER BY  fecha, idpagodevol");
        if (curPagosDevol.last()) {
                curPagosDevol.setModeAccess(curPagosDevol.Browse);
                curPagosDevol.refreshBuffer();
                if (util.daysTo(curPagosDevol.valueBuffer("fecha"), cursor.valueBuffer("fecha")) < 0) {
                        MessageBox.warning(util.translate("scripts", "La fecha de un pago o devolución debe ser siempre igual o posterior\na la fecha del pago o devolución anterior."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
                        return false;
                }
        }

        /** \C Si el recibo no es agrupado comprueba que el ejercicio de la factura que originó el recibo no coincide con el ejercicio actual, se solicita al usuario que confirme el pago
        \end */
        var idrecibo = this.iface.curRelacionado.valueBuffer("idrecibo");
        var agrupado = util.sqlSelect("recibosmulticli","idrecibomulti","codigo like (select substring(codigo from 0 for 13) from reciboscli where idrecibo='"+idrecibo+"')");
        if (!agrupado){
            var ejercicioFactura = util.sqlSelect("reciboscli r INNER JOIN facturascli f ON r.idfactura = f.idfactura", "f.codejercicio", "r.idrecibo = " + cursor.valueBuffer("idrecibo"), "reciboscli,facturascli");
            if (this.iface.ejercicioActual != ejercicioFactura) {
                    var respuesta:Number = MessageBox.warning(util.translate("scripts", "El ejercicio de la factura que originó este recibo es distinto del ejercicio actual ¿Desea continuar?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
                    if (respuesta != MessageBox.Yes)
                            return false;
            }
        }
        return true;
}

//// RECIBOSMULTICLI ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition recibosmanuales */
/////////////////////////////////////////////////////////////////
//// RECIBOSMANUALES    ////////////////////////////////////////
function recibosmanuales_validateForm():Boolean
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
        Si la contabilidad está integrada, se debe seleccionar una subcuenta válida a la que asignar el asiento de pago o devolución
        \end */
        if (this.iface.contabActivada && !this.child("fdbNoGenerarAsiento").value() && (this.child("fdbCodSubcuenta").value().isEmpty() || this.child("fdbIdSubcuenta").value() == 0)) {
                MessageBox.warning(util.translate("scripts", "Debe seleccionar una subcuenta válida a la que asignar el asiento de pago o devolución"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
                return false;
        }

        /** \C
        La fecha de un pago o devolución debe ser siempre posterior\na la fecha del pago o devolución anterior
        \end */
        var curPagosDevol:FLSqlCursor = new FLSqlCursor("pagosdevolcli");
        curPagosDevol.select("idrecibo = " + this.iface.curRelacionado.valueBuffer("idrecibo") + " AND idpagodevol <> " + cursor.valueBuffer("idpagodevol") + " ORDER BY  fecha, idpagodevol");
        if (curPagosDevol.last()) {
                curPagosDevol.setModeAccess(curPagosDevol.Browse);
                curPagosDevol.refreshBuffer();
                if (util.daysTo(curPagosDevol.valueBuffer("fecha"), cursor.valueBuffer("fecha")) < 0) {
                        MessageBox.warning(util.translate("scripts", "La fecha de un pago o devolución debe ser siempre igual o posterior\na la fecha del pago o devolución anterior."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
                        return false;
                }
        }

        /** \C Si el recibo no es manual o agrupado comprueba que el ejercicio de la factura que originó el recibo no coincide con el ejercicio actual, se solicita al usuario que confirme el pago
        \end */
        var automatico = this.iface.curRelacionado.valueBuffer("automatico");
        if (!automatico)
            return true;

        var idrecibo = this.iface.curRelacionado.valueBuffer("idrecibo");
        var agrupado = util.sqlSelect("recibosmulticli","idrecibomulti","codigo like (select substring(codigo from 0 for 13) from reciboscli where idrecibo='"+idrecibo+"')");
        if (!agrupado){
            var ejercicioFactura = util.sqlSelect("reciboscli r INNER JOIN facturascli f ON r.idfactura = f.idfactura", "f.codejercicio", "r.idrecibo = " + cursor.valueBuffer("idrecibo"), "reciboscli,facturascli");
            if (this.iface.ejercicioActual != ejercicioFactura) {
                    var respuesta:Number = MessageBox.warning(util.translate("scripts", "El ejercicio de la factura que originó este recibo es distinto del ejercicio actual ¿Desea continuar?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
                    if (respuesta != MessageBox.Yes)
                            return false;
            }
        }
        return true;
}

//// RECIBOSMANUALES ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

