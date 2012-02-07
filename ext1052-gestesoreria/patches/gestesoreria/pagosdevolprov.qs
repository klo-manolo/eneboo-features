
/** @class_declaration recibosmultiprov */
/////////////////////////////////////////////////////////////////
//// RECIBOSMULTIPROV ///////////////////////////////////////////
class recibosmultiprov extends pagosMultiProv {
    function recibosmultiprov( context ) { pagosMultiProv ( context ); }
    function validateForm():Boolean {
                return this.ctx.recibosmultiprov_validateForm();
    }
}
//// RECIBOSMULTIPROV ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration gestesoreria */
//////////////////////////////////////////////////////////////////
//// GESTESORERIA ///////////////////////////////////////////////
class gestesoreria extends recibosmultiprov {
    function gestesoreria( context ) { recibosmultiprov( context ); }

    function init() { this.ctx.gestesoreria_init(); }

}
//// GESTESORERIA ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration recibosmanuales */
/////////////////////////////////////////////////////////////////
//// RECIBOSMANUALES ////////////////////////////////////////////
class recibosmanuales extends gestesoreria {
    function recibosmanuales( context ) { gestesoreria ( context ); }
    function validateForm() { return this.ctx.recibosmanuales_validateForm(); }
}
//// RECIBOSMANUALES /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration tiposremprov */
//////////////////////////////////////////////////////////////////
//// TIPOSREMPROV ////////////////////////////////////////////////
class tiposremprov extends recibosmanuales {
    function tiposremprov( context ) { recibosmanuales( context ); }
    function validateForm() {
        return this.ctx.tiposremprov_validateForm();
    }

}
//// TIPOSREMPROV ////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition recibosmultiprov */
/////////////////////////////////////////////////////////////////
//// RECIBOSMULTIPROV////////////////////////////////////////////
function recibosmultiprov_validateForm():Boolean
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

        /** \C Si no es un recibo agrupado, comprueba que el ejercicio de la factura que originó el recibo no coincide con el ejercicio actual, se solicita al usuario que confirme el pago
        \end */
        var idrecibo = cursor.cursorRelation().valueBuffer("idrecibo")
        var agrupado = util.sqlSelect("recibosmultiprov","idrecibomulti","codigo like (select substring(codigo from 0 for 13) from recibosprov where idrecibo='"+idrecibo+"')");
        if (!agrupado){
            var ejercicioFactura = util.sqlSelect("recibosprov r INNER JOIN facturasprov f ON r.idfactura = f.idfactura", "f.codejercicio", "r.idrecibo = " + cursor.valueBuffer("idrecibo"), "recibosprov,facturasprov");

            if (this.iface.ejercicioActual != ejercicioFactura) {
                var respuesta:Number = MessageBox.warning(util.translate("scripts", "El ejercicio de la factura que originó este recibo es distinto del ejercicio actual ¿Desea continuar?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
                if (respuesta != MessageBox.Yes)
                    return false;
            }
        }

        return true;
}

//// RECIBOSMULTIPROV////////////////////////////////////////////
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
}

//// GESTESORERIA /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////

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
       /*if (this.iface.contabActivada && this.iface.noGenAsiento && this.cursor().valueBuffer("tipo") == "Devolución" && !this.child("fdbNoGenerarAsiento").value()) {
                MessageBox.warning(util.translate("scripts", "No se puede generar el asiento de una devolución cuyo pago no tiene asiento asociado"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
                return false;
        }*/

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
        var curPagosDevol:FLSqlCursor = new FLSqlCursor("pagosdevolprov");
        curPagosDevol.select("idrecibo = " + cursor.cursorRelation().valueBuffer("idrecibo") + " AND idpagodevol <> " + cursor.valueBuffer("idpagodevol") + " ORDER BY  fecha, idpagodevol");
        if (curPagosDevol.last()) {
                curPagosDevol.setModeAccess(curPagosDevol.Browse);
                curPagosDevol.refreshBuffer();
                if (util.daysTo(curPagosDevol.valueBuffer("fecha"), cursor.valueBuffer("fecha")) < 0) {
                        MessageBox.warning(util.translate("scripts", "La fecha de un pago o devolución debe ser siempre posterior\na la fecha del pago o devolución anterior."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
                        return false;
                }
        }

        /** \C Si el recibo no es manual o agrupado comprueba que el ejercicio de la factura que originó el recibo no coincide con el ejercicio actual, se solicita al usuario que confirme el pago
        \end */
        var automatico =cursor.cursorRelation().valueBuffer("automatico");
        if (!automatico)
            return true;

        var idrecibo = cursor.cursorRelation().valueBuffer("idrecibo");
        var agrupado = util.sqlSelect("recibosmultiprov","idrecibomulti","codigo like (select substring(codigo from 0 for 13) from recibosprov where idrecibo='"+idrecibo+"')");
        if (!agrupado){
            var ejercicioFactura = util.sqlSelect("recibosprov r INNER JOIN facturasprov f ON r.idfactura = f.idfactura", "f.codejercicio", "r.idrecibo = " + cursor.valueBuffer("idrecibo"), "recibosprov,facturasprov");

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

/** @class_definition tiposremprov */
/////////////////////////////////////////////////////////////////
//// TIPOSREMPROV //////////////////////////////////////////////
function tiposremprov_validateForm():Boolean
{
    if (!this.iface.__validateForm()){
        return false;
    }

    var cursor:FLSqlCursor = this.cursor();
    var util:FLUtil = new FLUtil();

    /** \C
    Si es una devolución, está activada la contabilidad y su pago correspondiente no genera asiento no puede generar asiento
    siempre y cuando, el asiento no provenga de una remesa*/
    var idRemesa:Number;
    var automatico:Boolean;
    var curPagosDevol:FLSqlCursor = new FLSqlCursor("pagosdevolprov");
    curPagosDevol.select("idrecibo = " + cursor.valueBuffer("idrecibo") + " ORDER BY fecha, idpagodevol");
    if (curPagosDevol.last()) {
        curPagosDevol.setModeAccess(curPagosDevol.Browse);
        curPagosDevol.refreshBuffer();
        idRemesa = curPagosDevol.valueBuffer("idremesa");
        automatico = curPagosDevol.valueBuffer("automatico");
    }

    if (this.iface.contabActivada && this.iface.noGenAsiento && this.cursor().valueBuffer("tipo") == "Devolución" && !this.child("fdbNoGenerarAsiento").value() && !idRemesa && !automatico) {
            MessageBox.warning(util.translate("scripts", "No se puede generar el asiento de una devolución cuyo pago no tiene asiento asociado"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
            return false;
    }

    return true;
}
//// TIPOSREMPROV //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

