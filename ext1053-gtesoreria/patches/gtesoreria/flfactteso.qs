
/** @class_declaration gtesoreria */
//////////////////////////////////////////////////////////////////
//// GTESORERIA /////////////////////////////////////////////////////
class gtesoreria extends oficial {
	var idFactura:String;
	function gtesoreria( context ) { oficial( context ); }
	function beforeCommit_reciboscli(curR:FLSqlCursor):Boolean {
		return this.ctx.gtesoreria_beforeCommit_reciboscli(curR);
	}
    function afterCommit_pagosdevolcli(curPD:FLSqlCursor):Boolean {
		return this.ctx.gtesoreria_afterCommit_pagosdevolcli(curPD);
	}
}
//// GTESORERIA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration pubGTesoreria */
/////////////////////////////////////////////////////////////////
//// PUB GTESORERIA ////////////////////////////////////////////
class pubGTesoreria extends ifaceCtx {
	function pubGTesoreria( context ) { ifaceCtx( context ); }
	function pub_comprobarDireccionesDom(idRemesa:String):Boolean {
		return this.comprobarDireccionesDom(idRemesa);
	}
}
//// PUB GTESORERIA ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition gtesoreria */
/////////////////////////////////////////////////////////////////
//// GTESORERIA /////////////////////////////////////////////////

//KLO. OJO. Rompemos la herencia
function gtesoreria_afterCommit_pagosdevolcli(curPD:FLSqlCursor):Boolean
{
        var idRecibo:String = curPD.valueBuffer("idrecibo");
        /** \C Se cambia el pago anterior al actual para que sólo el último sea editable
        \end */
        switch (curPD.modeAccess()) {
                case curPD.Insert:
                case curPD.Edit: {
                        if (!this.iface.cambiaUltimoPagoCli(idRecibo, curPD.valueBuffer("idpagodevol"), false))
                                return false;
                        break;
                }
                case curPD.Del: {
                        if (!this.iface.cambiaUltimoPagoCli(idRecibo, curPD.valueBuffer("idpagodevol"), true))
                                return false;
                        break;
                }
        }

        if (!this.iface.calcularEstadoFacturaCli(idRecibo))
                return false;

        // KLO. Agregado a oficial
		  if (!this.iface.calcularEstadoReciboCli(idRecibo))
            return false;
		  // KLO. Fin agregado a oficial

        var util:FLUtil = new FLUtil();
        if (sys.isLoadedModule("flcontppal") == false || util.sqlSelect("empresa", "contintegrada", "1 = 1") == false)
                return true;

        switch (curPD.modeAccess()) {
                case curPD.Del: {
                        if (curPD.isNull("idasiento"))
                                return true;

                        var idAsiento:Number = curPD.valueBuffer("idasiento");
                        if (flfacturac.iface.pub_asientoBorrable(idAsiento) == false)
                                return false;

                        var curAsiento:FLSqlCursor = new FLSqlCursor("co_asientos");
                        curAsiento.select("idasiento = " + idAsiento);
                        if (curAsiento.first()) {
                                curAsiento.setUnLock("editable", true);
                                curAsiento.setModeAccess(curAsiento.Del);
                                curAsiento.refreshBuffer();
                                if (!curAsiento.commitBuffer())
                                        return false;
                        }
                        break;
                }
                case curPD.Edit: {
                        if (curPD.valueBuffer("nogenerarasiento")) {
                                var idAsientoAnterior:String = curPD.valueBufferCopy("idasiento");
                                if (idAsientoAnterior && idAsientoAnterior != "") {
                                        if (!flfacturac.iface.pub_eliminarAsiento(idAsientoAnterior))
                                                return false;
                                }
                        }
                        break;
                }
        }

        return true;
}

function gtesoreria_beforeCommit_reciboscli(curR:FLSqlCursor):Boolean
{
	if (curR.valueBuffer("idfactura"))
		this.iface.idFactura=curR.valueBuffer("idfactura");

	return true;
}
//// GTESORERIA /////////////////////////////////////////////////
////////////////////////////////////////////////////

