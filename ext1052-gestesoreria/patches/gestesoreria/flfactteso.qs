
/** @class_declaration infoVencimtos */
//////////////////////////////////////////////////////////////////
//// INFO VENCIMIENTOS////////////////////////////////////////////
class infoVencimtos extends pagosMultiProv {
    function infoVencimtos( context ) { pagosMultiProv( context ); }
        function datosReciboCli(curFactura:FLSqlCursor):Boolean {
                return this.ctx.infoVencimtos_datosReciboCli(curFactura);
        }
        function datosReciboPos(curFactura:FLSqlCursor):Boolean {
                return this.ctx.infoVencimtos_datosReciboPos(curFactura);
        }
        function datosReciboNeg2(curFactura:FLSqlCursor):Boolean {
                return this.ctx.infoVencimtos_datosReciboNeg2(curFactura);
        }
        function datosReciboAnticipo(curFactura:FLSqlCursor):Boolean {
                return this.ctx.infoVencimtos_datosReciboAnticipo(curFactura);
        }
        function datosReciboProv():Boolean {
                return this.ctx.infoVencimtos_datosReciboProv();
        }
}
//// INFO VENCIMIENTOS////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration gestesoreria */
/////////////////////////////////////////////////////////////////
//// GESTESORERIA ///////////////////////////////////////////////
class gestesoreria extends remesaProv {
    function gestesoreria( context ) { remesaProv ( context ); }

    function init() { this.ctx.gestesoreria_init(); }

    function beforeCommit_remesas(curRemesa:FLSqlCursor):Boolean {
        return this.ctx.gestesoreria_beforeCommit_remesas(curRemesa);
    }

    function afterCommit_remesas(curRemesa:FlSqlCursor):Boolean {
        return this.ctx.gestesoreria_afterCommit_remesas(curRemesa)
    }

    function calcularEstadoRemesa(curRemesa:FlSqlCursor):String{
        return this.ctx.gestesoreria_calcularEstadoRemesa(curRemesa);
    }

    function generarPartidasDebe(cur:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, partida:Array):Boolean {
        return this.ctx.gestesoreria_generarPartidasDebe(cur, valoresDefecto, datosAsiento, partida);
    }

    function generarPartidasHaber(cur:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, partida:Array):Boolean {
        return this.ctx.gestesoreria_generarPartidasHaber(cur, valoresDefecto, datosAsiento, partida);
    }

    function generarAsientoRemesa(curRemesa:FLSqlCursor):Boolean {
        return this.ctx.gestesoreria_generarAsientoRemesa(curRemesa);
    }

    function generarAsientoPagoRemesa(curPR:FLSqlCursor):Boolean {
        return this.ctx.gestesoreria_generarAsientoPagoRemesa(curPR);
    }

    function generarPagoRecibosCli(idRecibo:String, remesa:Array, fecha:Date, genAsiento:Boolean):Boolean {
        return this.ctx.gestesoreria_generarPagoRecibosCli(idRecibo, remesa, fecha, genAsiento);
    }

    function cuentaPagoRecibosCli(idRecibo:String, codEjercicio:String):Array {
        return this.ctx.gestesoreria_cuentaPagoRecibosCli(idRecibo, codEjercicio);
    }

    function otraSubcuentaCliente(raiz:String, codcliente:String, valoresDefecto:Array):Array {
        return this.ctx.gestesoreria_otraSubcuentaCliente(raiz, codcliente, valoresDefecto);
    }

    function calcularEstadoReciboCli(idRecibo:String):Boolean {
        return this.ctx.gestesoreria_calcularEstadoReciboCli(idRecibo);
    }

    function generarPartidasCli(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean {
        return this.ctx.gestesoreria_generarPartidasCli(curPD, valoresDefecto, datosAsiento, recibo);
    }

    function generarAsientoPagoDevolCli(curPD:FLSqlCursor) {
        return this.ctx.gestesoreria_generarAsientoPagoDevolCli(curPD);
    }

    function actualizarRiesgoCliente(codCliente:String):Boolean {
        return this.ctx.gestesoreria_actualizarRiesgoCliente(codCliente);
    }

    function fechaPagosDevolCli(idRemesa:String, fecha:Date):Boolean{
        return this.ctx.gestesoreria_fechaPagosDevolCli(idRemesa, fecha);
    }

    function generarPartidasProv(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean {
        return this.ctx.gestesoreria_generarPartidasProv(curPD, valoresDefecto, datosAsiento, recibo);
    }

    function actualizarEstadoRiesgo():Boolean{
        return this.ctx.gestesoreria_actualizarEstadoRiesgo();
    }

    function comprobarCuentasDom(idRemesa:String):Boolean {
            return this.ctx.gestesoreria_comprobarCuentasDom(idRemesa);
    }

    function comprobarDireccionesDom(idRemesa:String):Boolean {
            return this.ctx.gestesoreria_comprobarDireccionesDom(idRemesa);
    }

    function generarPartidasBanco(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean {
            return this.ctx.gestesoreria_generarPartidasBanco(curPD, valoresDefecto, datosAsiento, recibo);
    }

    function pagoRemesaAuto(idRemesa:String, modo:String):Boolean{
            return this.ctx.gestesoreria_pagoRemesaAuto(idRemesa, modo);
    }

    function gestionarPagosRecibosRemesa(curPR:FLSqlCursor, modo:String):Boolean{
            return this.ctx.gestesoreria_gestionarPagosRecibosRemesa(curPR, modo);
    }

    function beforeCommit_pagosdevolrem(curPR:FLSqlCursor):Boolean {
            return this.ctx.gestesoreria_beforeCommit_pagosdevolrem(curPR);
    }

    function afterCommit_pagosdevolrem(curPD:FLSqlCursor):Boolean {
            return this.ctx.gestesoreria_afterCommit_pagosdevolrem(curPD);
    }

    function generarPartidasCambio(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean {
           return this.ctx.gestesoreria_generarPartidasCambio(curPD, valoresDefecto, datosAsiento, recibo);
    }

    function calcularTasaConvCambio(recibo:Array, tipo:String):Number{
            return this.ctx.gestesoreria_calcularTasaConvCambio(recibo, tipo);
    }
    function afterCommit_pagosdevolcli(curPD:FLSqlCursor):Boolean {
            return this.ctx.gestesoreria_afterCommit_pagosdevolcli(curPD);
    }

    function cuentaPagoRecibosProv(idRecibo:String, codEjercicio:String):Array {
        return this.ctx.gestesoreria_cuentaPagoRecibosProv(idRecibo, codEjercicio);
    }

    function generarPartidasBancoProv(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean {
            return this.ctx.gestesoreria_generarPartidasBancoProv(curPD, valoresDefecto, datosAsiento, recibo);
    }

    function beforeCommit_remesasprov(curRemesa:FLSqlCursor):Boolean {
        return this.ctx.gestesoreria_beforeCommit_remesasprov(curRemesa);
    }

    function afterCommit_remesasprov(curRemesa:FlSqlCursor):Boolean {
        return this.ctx.gestesoreria_afterCommit_remesasprov(curRemesa)
    }

    function generarAsientoRemesaProv(curRemesa:FLSqlCursor):Boolean {
        return this.ctx.gestesoreria_generarAsientoRemesaProv(curRemesa);
    }

    function calcularEstadoRemesaProv(curRemesa:FlSqlCursor):String{
        return this.ctx.gestesoreria_calcularEstadoRemesaProv(curRemesa);
    }

    function pagoRemesaAutoProv(idRemesa:String, modo:String):Boolean{
            return this.ctx.gestesoreria_pagoRemesaAutoProv(idRemesa, modo);
    }

    function beforeCommit_pagosdevolremprov(curPR:FLSqlCursor):Boolean {
            return this.ctx.gestesoreria_beforeCommit_pagosdevolremprov(curPR);
    }

    function afterCommit_pagosdevolremprov(curPD:FLSqlCursor):Boolean {
                return this.ctx.gestesoreria_afterCommit_pagosdevolremprov(curPD);
    }

    function generarAsientoPagoRemesaProv(curPR:FLSqlCursor):Boolean {
            return this.ctx.gestesoreria_generarAsientoPagoRemesaProv(curPR);
    }

    function generarPagoRecibosProv(idRecibo:String, remesa:Array, fecha:Date, genAsiento:Boolean):Boolean {
        return this.ctx.gestesoreria_generarPagoRecibosProv(idRecibo, remesa, fecha, genAsiento);
    }

    function datosContaPagoDevolProv(remesa:Array, idRecibo:String):Array{
        return this.ctx.gestesoreria_datosContaPagoDevolProv(remesa, idRecibo);
    }

    function datosContaPagoDevolProv(remesa:Array, idRecibo:String):Array{
        return this.ctx.gestesoreria_datosContaPagoDevolProv(remesa, idRecibo);
    }

    function gestionarPagosRecibosRemesaProv(idRemesa:String, fecha:Date, modo:String):Boolean{
            return this.ctx.gestesoreria_gestionarPagosRecibosRemesaProv(idRemesa, fecha, modo);
    }

    function fechaPagosDevolProv(idRemesa:String, fecha:Date):Boolean{
        return this.ctx.gestesoreria_fechaPagosDevolProv(idRemesa, fecha);
    }

    function afterCommit_pagosdevolprov(curPD:FLSqlCursor):Boolean {
            return this.ctx.gestesoreria_afterCommit_pagosdevolprov(curPD);
    }

    function afterCommit_reciboscli(curR:FLSqlCursor):Boolean {
            return this.ctx.gestesoreria_afterCommit_reciboscli(curR);
    }

    function calcularEstadoFacturaCli(idRecibo:String, idFactura:String):Boolean {
            return this.ctx.gestesoreria_calcularEstadoFacturaCli(idRecibo, idFactura);
    }

    function afterCommit_recibosprov(curR:FLSqlCursor):Boolean {
            return this.ctx.gestesoreria_afterCommit_recibosprov(curR);
    }

    function calcularEstadoFacturaProv(idRecibo:String, idFactura:String):Boolean {
            return this.ctx.gestesoreria_calcularEstadoFacturaProv(idRecibo, idFactura);
    }

    function datosReciboCli(curFactura:FLSqlCursor):Boolean {
            return this.ctx.gestesoreria_datosReciboCli(curFactura);
    }

    function datosReciboPos(curFactura:FLSqlCursor):Boolean {
            return this.ctx.gestesoreria_datosReciboPos(curFactura);
    }

    function datosReciboNeg2(curFactura:FLSqlCursor):Boolean {
            return this.ctx.gestesoreria_datosReciboNeg2(curFactura);
    }
    function generarPartidasCambioProv(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean {
            return this.ctx.gestesoreria_generarPartidasCambioProv(curPD, valoresDefecto, datosAsiento, recibo);
    }

    function datosReciboAnticipo(curFactura:FLSqlCursor):Boolean {
            return this.ctx.gestesoreria_datosReciboAnticipo(curFactura);
    }
}
//// GESTESORERIA ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration recibosmulticli */
/////////////////////////////////////////////////////////////////
//// RECIBOSMULTICLI ////////////////////////////////////////////
class recibosmulticli extends gestesoreria {
    function recibosmulticli( context ) { gestesoreria ( context ); }

    function beforeCommit_recibosmulticli(curRecibosMultiCli:FLSqlCursor):Boolean {
        return this.ctx.recibosmulticli_beforeCommit_recibosmulticli(curRecibosMultiCli);
    }

    function actualizarRiesgoCliente(codCliente:String):Boolean {
        return this.ctx.recibosmulticli_actualizarRiesgoCliente(codCliente);
    }

    function afterCommit_reciboscli(curR:FLSqlCursor):Boolean {
        return this.ctx.recibosmulticli_afterCommit_reciboscli(curR);
    }

    function calcularEstadoFacturaCli(idRecibo:String, idFactura:String):Boolean {
        return this.ctx.recibosmulticli_calcularEstadoFacturaCli(idRecibo, idFactura);
    }

    function calcularTasaConvCambio(recibo:Array, tipo:String):Number{
            return this.ctx.recibosmulticli_calcularTasaConvCambio(recibo, tipo);
    }

}
//// RECIBOSMULTICLI ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration recibosmultiprov */
/////////////////////////////////////////////////////////////////
//// RECIBOSMULTIPROV ///////////////////////////////////////////
class recibosmultiprov extends recibosmulticli {
    function recibosmultiprov( context ) { recibosmulticli ( context ); }

    function beforeCommit_recibosmultiprov(curRecibosMultiProv:FLSqlCursor):Boolean {
        return this.ctx.recibosmultiprov_beforeCommit_recibosmultiprov(curRecibosMultiProv);
    }

    function afterCommit_recibosprov(curR:FLSqlCursor):Boolean {
        return this.ctx.recibosmultiprov_afterCommit_recibosprov(curR);
    }

    function calcularEstadoFacturaProv(idRecibo:String, idFactura:String):Boolean {
        return this.ctx.recibosmultiprov_calcularEstadoFacturaProv(idRecibo, idFactura);
    }

}
//// RECIBOSMULTIPROV ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration recibosmanuales */
//////////////////////////////////////////////////////////////////
//// RECIBOSMANUALES /////////////////////////////////////////////
class recibosmanuales extends recibosmultiprov {
    function recibosmanuales( context ) { recibosmultiprov( context ); }

    function beforeCommit_reciboscli(curR:FLSqlCursor):Boolean {
        return this.ctx.recibosmanuales_beforeCommit_reciboscli(curR);
    }
    function calcularEstadoFacturaCli(idRecibo:String, idFactura:String):Boolean {
        return this.ctx.recibosmanuales_calcularEstadoFacturaCli(idRecibo, idFactura);
    }
    function beforeCommit_recibosprov(curR:FLSqlCursor):Boolean {
        return this.ctx.recibosmanuales_beforeCommit_recibosprov(curR);
    }
    function calcularEstadoFacturaProv(idRecibo:String, idFactura:String):Boolean {
        return this.ctx.recibosmanuales_calcularEstadoFacturaProv(idRecibo, idFactura);
    }
    function calcularTasaConvCambio(recibo:Array, tipo:String):Number{
            return this.ctx.recibosmanuales_calcularTasaConvCambio(recibo, tipo);
    }
    function compensarReciboCli(idRecibo:String, curFactura:FLSqlCursor, sinCompensar:Number):Number {
            return this.ctx.recibosmanuales_compensarReciboCli(idRecibo, curFactura, sinCompensar);
    }
    function datosReciboCli(curFactura:FLSqlCursor):Boolean {
            return this.ctx.recibosmanuales_datosReciboCli(curFactura);
    }
    function datosReciboPos(curFactura:FLSqlCursor):Boolean {
            return this.ctx.recibosmanuales_datosReciboPos(curFactura);
    }
    function datosReciboNeg2(curFactura:FLSqlCursor):Boolean {
            return this.ctx.recibosmanuales_datosReciboNeg2(curFactura);
    }
    function datosReciboAnticipo(curFactura:FLSqlCursor):Boolean {
            return this.ctx.recibosmanuales_datosReciboAnticipo(curFactura);
    }
}
//// RECIBOSMANUALES //////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration gastosPagosDevol */
/////////////////////////////////////////////////////////////////
//// GASTOSPAGOSDEVOL ///////////////////////////////////////////
class gastosPagosDevol extends recibosmanuales {
    function gastosPagosDevol( context ) { recibosmanuales( context ); }

    function beforeCommit_gastospdcli(curG:FLSqlCursor):Boolean {
        return this.ctx.gastosPagosDevol_beforeCommit_gastospdcli(curG);
    }
    function afterCommit_gastospdcli(curG:FLSqlCursor):Boolean {
        return this.ctx.gastosPagosDevol_afterCommit_gastospdcli(curG);
    }
    function beforeCommit_gastospdprov(curG:FLSqlCursor):Boolean {
        return this.ctx.gastosPagosDevol_beforeCommit_gastospdprov(curG);
    }
    function afterCommit_gastospdprov(curG:FLSqlCursor):Boolean {
        return this.ctx.gastosPagosDevol_afterCommit_gastospdprov(curG);
    }
    function generarAsientoGastosPD(curG:FLSqlCursor) {
        return this.ctx.gastosPagosDevol_generarAsientoGastosPD(curG);
    }

}
//// GASTOSPAGOSDEVOL /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration gastosPagosMulti */
/////////////////////////////////////////////////////////////////
//// GASTOSPAGOSMULTI ///////////////////////////////////////////
class gastosPagosMulti extends gastosPagosDevol {
    function gastosPagosMulti( context ) { gastosPagosDevol( context ); }

    function beforeCommit_gastospmcli(curG:FLSqlCursor):Boolean {
        return this.ctx.gastosPagosMulti_beforeCommit_gastospmcli(curG);
    }
    function afterCommit_gastospmcli(curG:FLSqlCursor):Boolean {
        return this.ctx.gastosPagosMulti_afterCommit_gastospmcli(curG);
    }
    function beforeCommit_gastospmprov(curG:FLSqlCursor):Boolean {
        return this.ctx.gastosPagosMulti_beforeCommit_gastospmprov(curG);
    }
    function afterCommit_gastospmprov(curG:FLSqlCursor):Boolean {
        return this.ctx.gastosPagosMulti_afterCommit_gastospmprov(curG);
    }
    function generarAsientoGastosPM(curG:FLSqlCursor) {
        return this.ctx.gastosPagosMulti_generarAsientoGastosPM(curG);
    }

}
//// GASTOSPAGOSMULTI /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration gastosPagosRem */
/////////////////////////////////////////////////////////////////
//// GASTOSPAGOSREM ///////////////////////////////////////////
class gastosPagosRem extends gastosPagosMulti {
    function gastosPagosRem( context ) { gastosPagosMulti( context ); }

    function beforeCommit_gastospdrem(curG:FLSqlCursor):Boolean {
        return this.ctx.gastosPagosRem_beforeCommit_gastospdrem(curG);
    }
    function afterCommit_gastospdrem(curG:FLSqlCursor):Boolean {
        return this.ctx.gastosPagosRem_afterCommit_gastospdrem(curG);
    }
    function beforeCommit_gastospdremprov(curG:FLSqlCursor):Boolean {
        return this.ctx.gastosPagosRem_beforeCommit_gastospdremprov(curG);
    }
    function afterCommit_gastospdremprov(curG:FLSqlCursor):Boolean {
        return this.ctx.gastosPagosRem_afterCommit_gastospdremprov(curG);
    }
    function generarAsientoGastosPRem(curG:FLSqlCursor) {
        return this.ctx.gastosPagosRem_generarAsientoGastosPRem(curG);
    }

}
//// GASTOSPAGOSREM /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration tiposremprov */
//////////////////////////////////////////////////////////////////
//// TIPOSREMPROV ////////////////////////////////////////////////
class tiposremprov extends gastosPagosRem {
    function tiposremprov( context ) { gastosPagosRem ( context ); }
    function init() {
        this.ctx.tiposremprov_init();
    }
    function datosReciboProv():Boolean {
        return this.ctx.tiposremprov_datosReciboProv();
    }
    function beforeCommit_remesasprov(curRemesa:FLSqlCursor):Boolean {
        return this.ctx.tiposremprov_beforeCommit_remesasprov(curRemesa);
    }
    function generarAsientoRemesaProv(curRemesa:FLSqlCursor):Boolean {
        return this.ctx.tiposremprov_generarAsientoRemesaProv(curRemesa);
    }
    function generarAsientoPagoRemesaProv(curPR:FLSqlCursor):Boolean {
            return this.ctx.tiposremprov_generarAsientoPagoRemesaProv(curPR);
    }
    function beforeCommit_pagaresemi(curPE:FLSqlCursor):Boolean {
        return this.ctx.tiposremprov_beforeCommit_pagaresemi(curPE);
    }
    function afterCommit_pagaresemi(curPE:FLSqlCursor):Boolean {
        return this.ctx.tiposremprov_afterCommit_pagaresemi(curPE);
    }
    function actualizarDatosPagare(curPE:FLSqlCursor):Boolean {
        return this.ctx.tiposremprov_actualizarDatosPagare(curPE);
    }
    function beforeCommit_anticiposconf(curAC:FLSqlCursor):Boolean {
        return this.ctx.tiposremprov_beforeCommit_anticiposconf(curAC);
    }
    function afterCommit_anticiposconf(curAC:FLSqlCursor):Boolean {
        return this.ctx.tiposremprov_afterCommit_anticiposconf(curAC);
    }
    function generarAsientoAnticiposConf(curAC:FLSqlCursor) {
        return this.ctx.tiposremprov_generarAsientoAnticiposConf(curAC);
    }
    function afterCommit_pagosdevolprov(curPD:FLSqlCursor):Boolean {
        return this.ctx.tiposremprov_afterCommit_pagosdevolprov(curPD);
    }
    function cambiarPtePagoAnticipoConf(idAnticipoConf:Number, modoPD:Number):Boolean{
        return this.ctx.tiposremprov_cambiarPtePagoAnticipoConf(idAnticipoConf, modoPD);
    }
    function calcularEstadoReciboProv(idRecibo:Number):Boolean {
        return this.ctx.tiposremprov_calcularEstadoReciboProv(idRecibo);
    }
    function datosContaPagoDevolProv(remesa:Array, idRecibo:String):Array{
        return this.ctx.tiposremprov_datosContaPagoDevolProv(remesa, idRecibo);
    }
    function generarAsientoPagoDevolProv(curPD:FLSqlCursor):Boolean {
        return this.ctx.tiposremprov_generarAsientoPagoDevolProv(curPD);
    }
    function generarPartidasBancoProvECGP(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean {
        return this.ctx.tiposremprov_generarPartidasBancoProvECGP(curPD, valoresDefecto, datosAsiento, recibo);
    }
    function generarPartidasProv(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean {
        return this.ctx.tiposremprov_generarPartidasProv(curPD, valoresDefecto, datosAsiento, recibo);
    }
    function cambiarEstadoRemesaProv(idRemesa:Number):Boolean {
        return this.ctx.tiposremprov_cambiarEstadoRemesaProv(idRemesa);
    }
    function calcularEstadoRemesaProv(curRemesa:FLSqlCursor):String {
        return this.ctx.tiposremprov_calcularEstadoRemesaProv(curRemesa);
    }
}
//// TIPOSREMPROV /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition infoVencimtos */
/////////////////////////////////////////////////////////////////
//// INFO VENCIMIENTOS //////////////////////////////////////////
/** \D Informa la cuenta de pago como la cuenta de remesas del cliente
\end */
function infoVencimtos_datosReciboCli(curFactura):Boolean
{
        var util:FLUtil = new FLUtil;
        if (!this.iface.__datosReciboCli(curFactura))
                return false;
        var codCliente:String = this.iface.curReciboCli.valueBuffer("codcliente");
        if (!codCliente)
                return true;

        var codcuentapago = util.sqlSelect("clientes", "codcuentarem", "codcliente = '" + codCliente + "'");
        if (codcuentapago && codcuentapago!="")
                this.iface.curReciboCli.setValueBuffer("codcuentapago", codcuentapago);

        return true;
}

function infoVencimtos_datosReciboPos(curFactura):Boolean
{
        var util:FLUtil = new FLUtil;
        if (!this.iface.__datosReciboPos(curFactura))
                return false;

        var codCliente:String = this.iface.curReciboPos.valueBuffer("codcliente");
        if (!codCliente)
                return true;

        var codcuentapago = util.sqlSelect("clientes", "codcuentarem", "codcliente = '" + codCliente + "'");
        if (codcuentapago && codcuentapago!="")
                this.iface.curReciboPos.setValueBuffer("codcuentapago", codcuentapago);

        return true;
}

function infoVencimtos_datosReciboNeg2(curFactura):Boolean
{
        var util:FLUtil = new FLUtil;
        if (!this.iface.__datosReciboNeg2(curFactura))
                return false;
        var codCliente:String = this.iface.curReciboNeg2.valueBuffer("codcliente");
        if (!codCliente)
                return true;

        var codcuentapago = util.sqlSelect("clientes", "codcuentarem", "codcliente = '" + codCliente + "'");
        if (codcuentapago && codcuentapago!="")
                this.iface.curReciboNeg2.setValueBuffer("codcuentapago", codcuentapago);

        return true;
}
/** \D Informa la cuenta de pago como la cuenta de pago del proveedor
\end */
function infoVencimtos_datosReciboProv():Boolean
{
        var util:FLUtil = new FLUtil;
        if (!this.iface.__datosReciboProv())
                return false;
        var codProveedor:String = this.iface.curReciboProv.valueBuffer("codproveedor");
        if (!codProveedor)
                return true;

        var codcuentapago = util.sqlSelect("proveedores", "codcuentapago", "codproveedor = '" + codProveedor + "'");
        if (codcuentapago && codcuentapago!="")
            this.iface.curReciboProv.setValueBuffer("codcuentapago", codcuentapago);

        return true;
}

function infoVencimtos_datosReciboAnticipo(curFactura):Boolean
{
        var util:FLUtil = new FLUtil;
        if (!this.iface.__datosReciboAnticipo(curFactura))
                return false;

        var codCliente:String = this.iface.curReciboAnticipo.valueBuffer("codcliente");
        if (!codCliente)
                return true;

        var codcuentapago = util.sqlSelect("clientes", "codcuentarem", "codcliente = '" + codCliente + "'");
        if (codcuentapago && codcuentapago!="")
                this.iface.curReciboAnticipo.setValueBuffer("codcuentapago",codcuentapago);

        return true;
}

//// INFO VENCIMIENTOS //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition gestesoreria */
/////////////////////////////////////////////////////////////////
//// GESTESORERIA /////////////////////////////////////////////

function gestesoreria_init()
{
    this.iface.__init();
    var util:FLUtil;
    var hoy:Date = new Date();

     /*Asigna o  verifica el campo tipoconta de fllfacteso_general, valores iniciales para cuentas de riesgo cuando la contabilidad esta cargada e integrada*/
    var contActiva:Boolean = sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada");
    if (!contActiva)
            return;

    var tipoConta19 = util.sqlSelect("factteso_general","tipoconta19","1=1");
    var tipoConta58 = util.sqlSelect("factteso_general","tipoconta58","1=1");
    var tipoConta34 = util.sqlSelect("factteso_general","tipoconta34","1=1");

    var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();

    if (!tipoConta19 || tipoConta19=="" || !tipoConta58 || tipoConta58=="" || !tipoConta34 || tipoConta34==""){

            if (!util.sqlDelete("factteso_general","1=1")) return false;

            var idges = util.sqlSelect("co_cuentas","idcuenta","codcuenta='4312' AND codejercicio='"+codEjercicio+"'");
            var idcar = util.sqlSelect("co_cuentas","idcuenta","codcuenta='4310' AND codejercicio='"+codEjercicio+"'");
            var iddes = util.sqlSelect("co_cuentas","idcuenta","codcuenta='4311' AND codejercicio='"+codEjercicio+"'");
            var idimp = util.sqlSelect("co_cuentas","idcuenta","codcuenta='4315' AND codejercicio='"+codEjercicio+"'");

            var curFactteso:FLSqlCursor = new FLSqlCursor("factteso_general");
            curFactteso.setModeAccess(curFactteso.Insert);
            curFactteso.refreshBuffer();
            curFactteso.setValueBuffer("pagoindirecto", "true");
            curFactteso.setValueBuffer("tipoconta19", "110");
            curFactteso.setValueBuffer("tipoconta58", "300");
            curFactteso.setValueBuffer("tipoconta34", "100");
            if (idges && idcar && iddes && idimp) {
                    curFactteso.setValueBuffer("idctagescobro", idges);
                    curFactteso.setValueBuffer("codctagescobro", "4312");
                    curFactteso.setValueBuffer("idctaimp19", idimp);
                    curFactteso.setValueBuffer("codctaimp19", "4315");
                    curFactteso.setValueBuffer("idctacartera", idcar);
                    curFactteso.setValueBuffer("codctacartera", "4310");
                    curFactteso.setValueBuffer("idctadescontados", iddes);
                    curFactteso.setValueBuffer("codctadescontados", "4311");
                    curFactteso.setValueBuffer("idctaimp58", idimp);
                    curFactteso.setValueBuffer("codctaimp58", "4315");
                    curFactteso.setValueBuffer("actfechariesgo",hoy);
            }
            curFactteso.commitBuffer();
    }

    var sHoy = hoy.toString();
    var sFechaAct:String = "";

    var fechaAct = util.sqlSelect("factteso_general","actfechariesgo","1=1");
    if (fechaAct && fechaAct!="") sFechaAct = fechaAct.toString();

    /*Actualiza recibos en estado riesgo y el riesgo actual para todos los clientes, si la fecha de actualización es diferente a la de hoy, esto es para que no actualice los recibos cada vez que se entra al módulo de tesoreria*/
    if (sHoy.substring(0,10) != sFechaAct.substring(0,10)){
            var actualizado:Boolean = true;
            if (!this.iface.actualizarEstadoRiesgo()){
                    MessageBox.warning("Hubo un error en la actualización de estado\n Riesgo en los recibos de clientes",MessageBox.Ok, MessageBox.NoButton);
                    actualizado = false;
            }

            if (!flfactteso.iface.pub_actualizarRiesgoCliente()){
                    MessageBox.warning("Hubo un error en la actualización del riesgo\n para todos los clientes",MessageBox.Ok, MessageBox.NoButton);
                    actualizado = false;
            }

            if (actualizado){
                    util.sqlUpdate("factteso_general","actfechariesgo",hoy,"1=1");
            }
    }

    return true;
}
function gestesoreria_beforeCommit_remesas(curRemesa:FLSqlCursor):Boolean
{

        switch (curRemesa.modeAccess()) {
                /** \C La remesa puede borrarse si todos los recibos asociados pueden ser excluidos*/
                case curRemesa.Del:
                        var idRemesa:Number = curRemesa.valueBuffer("idremesa");
                        var qryRecibos:FLSqlQuery = new FLSqlQuery;
                        qryRecibos.setTablesList("reciboscliremesa");
                        qryRecibos.setSelect("idrecibo");
                        qryRecibos.setFrom("reciboscliremesa");
                        qryRecibos.setWhere("idremesa='"+idRemesa+"'");
                        if (!qryRecibos.exec())
                                return false;
                        while (qryRecibos.next()) {
                        /*Comprueba primero que todos los recibos puedan ser eliminados*/
                                if (!formRecordremesas.iface.pub_excluirReciboRemesa(qryRecibos.value("idrecibo"), idRemesa,true)){
                                        MessageBox.warning("La remesa no puede ser eliminada",MessageBox.Ok, MessageBox.NoButton);
                                        return false;
                                }
                        }

                        if (!qryRecibos.exec())
                                return false;

                        while (qryRecibos.next()) {
                        /*excluye los recibos*/
                                if (!formRecordremesas.iface.pub_excluirReciboRemesa(qryRecibos.value("idrecibo"), idRemesa,false)){
                                        return false;
                                }
                        }
                        break;


                case curRemesa.Insert:
                        curRemesa.setValueBuffer("estado","Emitida");
                        break;

                case curRemesa.Edit:
                        var estado = this.iface.calcularEstadoRemesa(curRemesa);
                        if (!estado || estado=="") return false;
                        else curRemesa.setValueBuffer("estado", estado);
                        break;
        }

        /** \ Si la contabilidad esta integrada, el tipoconta de la remesa es directa con riesgo (110 o 300) y el cerrada pasa a true: genera asiento de remesa*/
        if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada")) {
                if (curRemesa.valueBuffer("tipoconta")!="110" || curRemesa.valueBuffer("tipoconta")!="300") {
                        if (curRemesa.valueBuffer("cerrada") == true && curRemesa.valueBufferCopy("cerrada") == false){
                                if (this.iface.generarAsientoRemesa(curRemesa) == false)
                                    return false;
                        }

                        if (curRemesa.valueBuffer("cerrada") == false && curRemesa.valueBuffer("idasiento") && curRemesa.valueBuffer("idasiento")!=""){
                                curRemesa.setNull("idasiento");
                        }
                }
        }

        return true;
}
function gestesoreria_calcularEstadoRemesa(curRemesa:FlSqlCursor):String
{
        var idRemesa = curRemesa.valueBuffer("idremesa");
        if (!idRemesa || idRemesa==""){
                MessageBox.warning("Ha ocurrido un error.\nNo ha sido posible calcular el estado de la remesa",MessageBox.Ok, MessageBox.NoButton);
                return "";
        }

        var util:FLUtil = new FLUtil;

        var cerrada = curRemesa.valueBuffer("cerrada");
        var idPago = util.sqlSelect("pagosdevolrem","idpagorem","idremesa='"+idRemesa+"'");

        var estado:String="Emitida";
        if (cerrada == true) estado = "Cerrada";
        if (idPago && idPago!="") estado = "Pagada";

        return estado;
}
function gestesoreria_afterCommit_remesas(curRemesa:FlSqlCursor):Boolean
{

        if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada")) {
                switch (curRemesa.modeAccess()) {
                        case curRemesa.Del:
                                if (!flfacturac.iface.eliminarAsiento(curRemesa.valueBuffer("idasiento")))
                                        return false;
                                break;

                        case curRemesa.Edit:
                                if (curRemesa.valueBuffer("nogenerarasiento")) {
                                        var idAsientoAnterior:String = curRemesa.valueBufferCopy("idasiento");
                                        if (idAsientoAnterior && idAsientoAnterior != "") {
                                                if (!flfacturac.iface.eliminarAsiento(idAsientoAnterior))
                                                        return false;
                                        }
                                }
                                if (curRemesa.valueBuffer("tipoconta") == "110" || curRemesa.valueBuffer("tipoconta") == "300") {
                                        if (curRemesa.valueBuffer("cerrada") == false && curRemesa.valueBufferCopy("cerrada") == true){
                                                var idAsientoAnterior:String = curRemesa.valueBufferCopy("idasiento");
                                                if (!flfacturac.iface.eliminarAsiento(idAsientoAnterior)){
                                                        return false;
                                                }
                                        }
                                }
                                break;
                }
        }

        return true;

}
/**\Genera partida generica al debe
@param        cur: Cursor del registro que genera el asiento
@param        valoresDefecto: Array de valores por defecto (ejercicio, divisa, etc.)
@param        datosAsiento: Array con los datos del asiento
@param        partida: Array con los datos de la partida
@return        true si la generación es correcta, false en caso contrario*/

function gestesoreria_generarPartidasDebe(cur:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, partida:Array):Boolean
{
        var util:FLUtil = new FLUtil();

        partida.idsubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + partida.codsubcuenta + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
        if (!partida.idsubcuenta) {
                MessageBox.warning(util.translate("scripts", "No tiene definida la subcuenta %1 en el ejercicio %2.\nAntes de dar el pago debe crear la subcuenta o modificar el ejercicio").arg(partida.codsubcuenta).arg(valoresDefecto.codejercicio), MessageBox.Ok, MessageBox.NoButton);
                return false;
        }

        var debe:Number = 0;
        var debeME:Number = 0;
        var tasaconvDebe:Number = 1;

        if (partida["calcularCambio"] == true){
                if (valoresDefecto.coddivisa == partida.coddivisa) {
                        debe = parseFloat(partida.importe);
                        debeME = 0;
                } else {
                        tasaconvDebe = cur.valueBuffer("tasaconv");
                        debe = parseFloat(partida.importe) * parseFloat(tasaconvDebe);
                        debeME = parseFloat(partida.importe);
                }
        }else{
                tasaconvDebe = partida["tasaConv"];
                debe = parseFloat(partida["importe"]);
                debeME = parseFloat(partida["importeME"]);
        }

        debe = util.roundFieldValue(debe, "co_partidas", "debe");
        debeME = util.roundFieldValue(debeME, "co_partidas", "debeme");

        var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
        with(curPartida) {
                setModeAccess(curPartida.Insert);
                refreshBuffer();
                setValueBuffer("concepto", partida.concepto);
                setValueBuffer("idsubcuenta", partida.idsubcuenta);
                setValueBuffer("codsubcuenta", partida.codsubcuenta);
                setValueBuffer("idasiento", datosAsiento.idasiento);
                setValueBuffer("debe", debe);
                setValueBuffer("haber", 0);
                setValueBuffer("coddivisa", partida.coddivisa);
                setValueBuffer("tasaconv", tasaconvDebe);
                setValueBuffer("debeME", debeME);
                setValueBuffer("haberME", 0);
        }
        if (!curPartida.commitBuffer())
                return false;

        return true;
}
/**\Genera partida generica al haber
@param        cur: Cursor del registro que genera el asiento
@param        valoresDefecto: Array de valores por defecto (ejercicio, divisa, etc.)
@param        datosAsiento: Array con los datos del asiento
@param        partida: Array con los datos de la partida
@return        true si la generación es correcta, false en caso contrario*/

function gestesoreria_generarPartidasHaber(cur:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, partida:Array):Boolean
{
        var util:FLUtil = new FLUtil();
        partida.idsubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + partida.codsubcuenta + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
        if (!partida.idsubcuenta) {
                MessageBox.warning(util.translate("scripts", "No tiene definida la subcuenta %1 en el ejercicio %2.\nAntes de dar el pago debe crear la subcuenta o modificar el ejercicio").arg(partida.codsubcuenta).arg(valoresDefecto.codejercicio), MessageBox.Ok, MessageBox.NoButton);
                return false;
        }

        var haber:Number = 0;
        var haberME:Number = 0;
        var tasaconvHaber:Number = 1;
        if (partida["calcularCambio"] == true){
                if (valoresDefecto.coddivisa == partida.coddivisa) {
                        haber = parseFloat(partida.importe);
                        haberME = 0;
                } else {
                        tasaconvHaber = cur.valueBuffer("tasaconv");
                        haber = parseFloat(partida.importe) * parseFloat(tasaconvHaber);
                        haberME = parseFloat(partida.importe);
                }
        }else{
                tasaconvHaber = partida["tasaConv"];
                haber = parseFloat(partida["importe"]);
                haberME = parseFloat(partida["importeME"]);
        }

        haber = util.roundFieldValue(haber, "co_partidas", "debe");
        haberME = util.roundFieldValue(haberME, "co_partidas", "debeme");

        var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
        with (curPartida) {
                setModeAccess(curPartida.Insert);
                refreshBuffer();
                setValueBuffer("concepto", partida.concepto);
                setValueBuffer("idsubcuenta", partida.idsubcuenta);
                setValueBuffer("codsubcuenta", partida.codsubcuenta);
                setValueBuffer("idasiento", datosAsiento.idasiento);
                setValueBuffer("debe", 0);
                setValueBuffer("haber", haber);
                setValueBuffer("coddivisa", partida.coddivisa);
                setValueBuffer("tasaconv", tasaconvHaber);
                setValueBuffer("debeME", 0);
                setValueBuffer("haberME", haberME);
        }

        if (!curPartida.commitBuffer())
                return false;

        return true;
}
/**\Genera el asiento de la remesa dependiendo del tipo de configuración general en flfacteso_general */
function gestesoreria_generarAsientoRemesa(curRemesa:FLSqlCursor):Boolean
{
        var util:FLUtil = new FLUtil();
        if (curRemesa.modeAccess() != curRemesa.Insert && curRemesa.modeAccess() != curRemesa.Edit)
                return true;

        if (curRemesa.valueBuffer("nogenerarasiento")) {
                curRemesa.setNull("idasiento");
                return true;
        }

        var tipoconta:String=curRemesa.valueBuffer("tipoconta");

        /*Solo existen asientos asociados a la remesa en tipo de contabilidad indirecta con cuentas de riesgo*/
        if (tipoconta == "100" || tipoconta == "200"){
                curRemesa.setNull("idasiento");
                return true;
        }

        /*En tipo de contabilidad indirecta con cuentas de riesgo solo se hace el asiento cuando la remesa está cerrada*/
        if (curRemesa.valueBuffer("cerrada") == false){
                curRemesa.setNull("idasiento");
                return true;
        }

        var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
        var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(curRemesa.valueBuffer("fecha"), codEjercicio, "remesas");
        if (!datosDoc.ok) return false;

        if (datosDoc.modificaciones == true) {
                codEjercicio = datosDoc.codEjercicio;
                curRemesa.setValueBuffer("fecha", datosDoc.fecha);
        }

        var datosAsiento:Array = [];
        var valoresDefecto:Array;
        valoresDefecto["codejercicio"] = codEjercicio;
        valoresDefecto["coddivisa"] = util.sqlSelect("empresa", "coddivisa", "1 = 1");

        datosAsiento = flfacturac.iface.pub_regenerarAsiento(curRemesa, valoresDefecto);
        if (datosAsiento.error == true) return false;

        var remesa:Array = [];
        remesa["coddivisa"] = curRemesa.valueBuffer("coddivisa");
        remesa["total"] = curRemesa.valueBuffer("total");
        remesa["fecha"] = curRemesa.valueBuffer("fecha");
        remesa["idremesa"] = curRemesa.valueBuffer("idremesa");
        remesa["codcuenta"] = curRemesa.valueBuffer("codcuenta");
        remesa["codsubcuenta"] = curRemesa.valueBuffer("codsubcuenta");
        remesa["idsubcuenta"] = curRemesa.valueBuffer("idsubcuenta");
        remesa["codsubcuentaecgc"] = curRemesa.valueBuffer("codsubcuentaecgc");
        remesa["idsubcuentaecgc"] = curRemesa.valueBuffer("idsubcuentaecgc");
        remesa["tipoconta"] = tipoconta;

        var partidadebe:Array;
        var partidahaber:Array;

        var idRecibos:String = formRecordremesas.iface.pub_idRecibosRemesa(curRemesa.valueBuffer("idremesa"));
        var curRecibos:FLSqlCursor = new FLSqlCursor("reciboscli");
        curRecibos.select("idrecibo IN ("+idRecibos+")");
        if (curRecibos.size()<=0) return false;

        if (tipoconta == "110") {
                var sigue:Boolean=curRecibos.first()
                while (sigue){
                        var raiz = curRemesa.valueBuffer("codctagescobro");
                        if (!raiz)
                                return false;
                        partidadebe = this.iface.otraSubcuentaCliente(raiz,curRecibos.valueBuffer("codcliente"),valoresDefecto);
                        if (partidadebe.error!=0)
                                return false;
                        partidadebe["importe"] = curRecibos.valueBuffer("importe");
                        partidadebe["concepto"] = "Remesa "+curRemesa.valueBuffer("idremesa")+": Recibo "+curRecibos.valueBuffer("codigo")+" - "+curRecibos.valueBuffer("nombrecliente");
                        partidadebe["coddivisa"] = remesa.coddivisa;
                        partidadebe["calcularCambio"] = true;
                        if (!this.iface.generarPartidasDebe(curRemesa, valoresDefecto, datosAsiento, partidadebe))
                                return false;
                        sigue = curRecibos.next()
                }

        }

        if (tipoconta == "300") {
                var sigue:Boolean=curRecibos.first()
                while (sigue){
                        var raiz = curRemesa.valueBuffer("codctacartera");
                        if (!raiz)
                                return false;
                        partidadebe = this.iface.otraSubcuentaCliente(raiz,curRecibos.valueBuffer("codcliente"),valoresDefecto);
                        if (partidadebe.error!=0)
                                return false;
                        partidadebe["importe"] = curRecibos.valueBuffer("importe");
                        partidadebe["concepto"] = "Remesa "+curRemesa.valueBuffer("idremesa")+": Recibo "+curRecibos.valueBuffer("codigo")+" - "+curRecibos.valueBuffer("nombrecliente");
                        partidadebe["coddivisa"] = remesa.coddivisa;
                        partidadebe["calcularCambio"] = true;
                        if (!this.iface.generarPartidasDebe(curRemesa, valoresDefecto, datosAsiento, partidadebe))
                                return false;
                        sigue = curRecibos.next()
            }
        }

        /*La partida al haber es la misma en todos los casos de tipoconta de la remesa si el recibo no proviene de una devolución*/
        var sigue:Boolean=curRecibos.first()
        while (sigue){
                var devolucion:Boolean=false;
                var curPagosDevol:FLSqlCursor = new FLSqlCursor("pagosdevolcli");
                curPagosDevol.select("idrecibo = " + curRecibos.valueBuffer("idrecibo") + " ORDER BY fecha, idpagodevol");
                curPagosDevol.last()
                if (curPagosDevol.size()>0){
                        if (curPagosDevol.valueBuffer("tipo") != "Pago"){
                                devolucion = true;
                        }
                }

                partidahaber = this.iface.cuentaPagoRecibosCli(curRecibos.valueBuffer("idrecibo"),valoresDefecto.codejercicio);
                if (devolucion) {
                        var raiz2 = curRemesa.valueBuffer("codctaimpagados");
                        if (!raiz2) return false;
                        partidahaber = this.iface.otraSubcuentaCliente(raiz2,curRecibos.valueBuffer("codcliente"),valoresDefecto);
                        if (partidahaber.error!=0) return false;
                }

                partidahaber["importe"]=curRecibos.valueBuffer("importe");
                partidahaber["concepto"]="Remesa "+curRemesa.valueBuffer("idremesa")+": Recibo "+curRecibos.valueBuffer("codigo")+" - "+curRecibos.valueBuffer("nombrecliente");
                partidahaber["coddivisa"] = remesa["coddivisa"];
                partidahaber["calcularCambio"] = true;
                if (!this.iface.generarPartidasHaber(curRemesa, valoresDefecto, datosAsiento, partidahaber)) return false;

                sigue=curRecibos.next()
        }

        curRemesa.setValueBuffer("idasiento", datosAsiento["idasiento"]);
        if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento["idasiento"]))
                return false;

        return true;
}
/**\Genera el asiento de pago de la remesa dependiendo del tipo de configuración*/
function gestesoreria_generarAsientoPagoRemesa(curPR:FLSqlCursor):Boolean
{
        var util:FLUtil = new FLUtil();
        if (curPR.modeAccess() != curPR.Insert && curPR.modeAccess() != curPR.Edit)
                return true;

        if (curPR.valueBuffer("nogenerarasiento")) {
                curPR.setNull("idasiento");
                return true;
        }

        /*Solo se hace el asiento de pago cuando la remesa está cerrada*/
        var cerrada = util.sqlSelect("remesas","cerrada","idremesa='"+curPR.valueBuffer("idremesa")+"'");

        if (cerrada == false) {
                curPR.setNull("idasiento");
                return false;
        }

        if (curPR.valueBuffer("tipo") != "Pago")
                return false;

        var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
        var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(curPR.valueBuffer("fecha"), codEjercicio, "pagosdevolrem");
        if (!datosDoc.ok)
                return false;
        if (datosDoc.modificaciones == true) {
                codEjercicio = datosDoc.codEjercicio;
                curPR.setValueBuffer("fecha", datosDoc.fecha);
        }

        var datosAsiento:Array = [];
        var valoresDefecto:Array;
        valoresDefecto["codejercicio"] = codEjercicio;
        valoresDefecto["coddivisa"] = util.sqlSelect("empresa", "coddivisa", "1 = 1");

        var remesa:Array = flfactppal.iface.pub_ejecutarQry("remesas", "coddivisa,total,fecha,idremesa,codcuenta,codsubcuenta,idsubcuenta,codsubcuentaecgc,idsubcuentaecgc,tipoconta,codctagescobro,codctacartera,codctadescontados", "idremesa = " + curPR.valueBuffer("idremesa"));
        if (remesa.result != 1)
            return false;

        datosAsiento = flfacturac.iface.pub_regenerarAsiento(curPR, valoresDefecto);
        if (datosAsiento.error == true)
                return false;

        var partidadebe:Array;
        var partidahaber:Array;
        var tipoconta:String = remesa["tipoconta"];

        /*La partida al debe es la misma en todos los casos de tipoconta de la remesa*/
        partidadebe["codsubcuenta"] = remesa["codsubcuenta"];
        partidadebe["idsubcuenta"] = remesa["idsubcuenta"];
        partidadebe["importe"] = remesa["total"];
        partidadebe["concepto"]="Pago Remesa "+curPR.valueBuffer("idremesa");
        partidadebe["coddivisa"] = remesa["coddivisa"];
        partidadebe["calcularCambio"] = true;
        if (!this.iface.generarPartidasDebe(curPR, valoresDefecto, datosAsiento, partidadebe))
               return false;

        /*La partida al haber depende del tipoconta de la remesa*/
        if (tipoconta == "200" || tipoconta == "300") {
                partidahaber["codsubcuenta"] = remesa.codsubcuentaecgc;
                partidahaber["idsubcuenta"] = remesa.idsubcuentaecgc;
                partidahaber["importe"] = remesa.total
                partidahaber["concepto"] = "Pago Remesa "+curPR.valueBuffer("idremesa");
                partidahaber["coddivisa"] = remesa.coddivisa;
                partidahaber["calcularCambio"] = true;
                if (!this.iface.generarPartidasHaber(curPR, valoresDefecto, datosAsiento, partidahaber))
                            return false;
        }

        if (tipoconta == "100" || tipoconta == "110") {
                var idRecibos:String = formRecordremesas.iface.pub_idRecibosRemesa(remesa["idremesa"]);
                var curRecibos:FLSqlCursor = new FLSqlCursor("reciboscli");
                curRecibos.select("idrecibo IN ("+idRecibos+")");
                if (curRecibos.size()<=0)
                        return false;

                var sigue:Boolean=curRecibos.first()
                while (sigue){
                        if (tipoconta == "100"){
                                partidahaber = this.iface.cuentaPagoRecibosCli(curRecibos.valueBuffer("idrecibo"),valoresDefecto.codejercicio);
                        }else{
                                var raiz = remesa["codctagescobro"];
                                if (!raiz)
                                        return false;
                                partidahaber = this.iface.otraSubcuentaCliente(raiz,curRecibos.valueBuffer("codcliente"),valoresDefecto);
                        }

                        if (partidahaber.error!=0)
                                return false;

                        partidahaber["importe"]=curRecibos.valueBuffer("importe");
                        partidahaber["concepto"]="Pago Remesa "+curPR.valueBuffer("idremesa")+": Recibo "+curRecibos.valueBuffer("codigo")+" - "+curRecibos.valueBuffer("nombrecliente");
                        partidahaber["coddivisa"] = remesa["coddivisa"];
                        partidahaber["calcularCambio"] = true;

                        if (!this.iface.generarPartidasHaber(curPR, valoresDefecto, datosAsiento, partidahaber))
                                return false;

                        sigue=curRecibos.next()
                }
        }

        /*si tipoconta es 300 se generan dos partidas más (una por cada recibo) para el control de efectos descontados*/
        if (tipoconta=="300"){
                var idRecibos:String = formRecordremesas.iface.pub_idRecibosRemesa(remesa["idremesa"]);
                var curRecibos:FLSqlCursor = new FLSqlCursor("reciboscli");
                curRecibos.select("idrecibo IN ("+idRecibos+")");
                if (curRecibos.size()<=0)
                        return false;

                var sigue:Boolean = curRecibos.first()
                while (sigue){
                        var raiz1 = remesa["codctadescontados"];
                        if (!raiz1)
                                return false;
                        partidadebe=this.iface.otraSubcuentaCliente(raiz1,curRecibos.valueBuffer("codcliente"),valoresDefecto);
                        if (partidadebe.error!=0)
                                return false;
                        partidadebe["importe"]=curRecibos.valueBuffer("importe");
                        partidadebe["concepto"]="Pago Remesa "+curPR.valueBuffer("idremesa")+": Recibo "+curRecibos.valueBuffer("codigo")+" - "+curRecibos.valueBuffer("nombrecliente")
                        partidadebe["coddivisa"] = remesa.coddivisa;
                        partidadebe["calcularCambio"] = true;
                        if (!this.iface.generarPartidasDebe(curPR, valoresDefecto, datosAsiento, partidadebe))
                                return false;

                        var raiz2 = remesa["codctacartera"];
                        if (!raiz2)
                                return false;
                        partidahaber=this.iface.otraSubcuentaCliente(raiz2,curRecibos.valueBuffer("codcliente"),valoresDefecto);
                        if (partidahaber.error!=0)
                                return false;
                        partidahaber["importe"]=curRecibos.valueBuffer("importe");
                        partidahaber["concepto"]="Pago Remesa "+curPR.valueBuffer("idremesa")+": Recibo "+curRecibos.valueBuffer("codigo")+" - "+curRecibos.valueBuffer("nombrecliente")
                        partidahaber["coddivisa"]= remesa.coddivisa;
                        partidahaber["calcularCambio"] = true;
                        if (!this.iface.generarPartidasHaber(curPR, valoresDefecto, datosAsiento, partidahaber))
                                return false;
                        sigue=curRecibos.next()
                }
        }

        curPR.setValueBuffer("idasiento", datosAsiento.idasiento);
            if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento))
                    return false;

        return true;
}
/**\Genera un pago en la tabla pagosdevolcli cuando el recibo esta asociado a una Remesa*/
function gestesoreria_generarPagoRecibosCli(idRecibo:String,remesa:Array,fecha:Date,genAsiento:Boolean):Boolean
{
        var util:FLUtil = new FLUtil();

        /*comprueba que la fecha sea igual o superior a la fecha del ultimo pago o devolución*/
        var pdfecha = util.sqlSelect("pagosdevolcli","fecha","idrecibo="+idRecibo+" ORDER BY fecha DESC");
        if (pdfecha && pdfecha!=""){
            if (util.daysTo(pdfecha, fecha) < 0){
                return false;
            }
        }

        var codsubcuenta:String;
        var idsubcuenta:String;

        if(!remesa["idremesa"] || remesa["idremesa"]=="") return false;


        if (remesa.tipoconta=="200" || remesa.tipoconta=="300"){
                codsubcuenta= remesa["codsubcuentaecgc"];
                idsubcuenta= remesa["idsubcuentaecgc"];
        }else{
                codsubcuenta= remesa["codsubcuenta"];
                idsubcuenta= remesa["idsubcuenta"];
        }

        var datosCuentaEmp:Array = flfactppal.iface.pub_ejecutarQry("cuentasbanco","descripcion,ctaentidad,ctaagencia,cuenta","codcuenta='"+remesa["codcuenta"]+"'");
        var dc1:String = util.calcularDC(datosCuentaEmp["ctaentidad"]+datosCuentaEmp["ctaagencia"]);
        var dc2:String = util.calcularDC(datosCuentaEmp["cuenta"]);
        datosCuentaEmp["dc"] = dc1 + dc2;

        var tasaConv:Number = 1;
        var idFactura = util.sqlSelect("reciboscli","idfactura","idrecibo = '"+ idRecibo +"'");
        if (idFactura && idFactura!=""){
                tasaConv = util.sqlSelect("facturascli","tasaconv","idfactura='"+idFactura+"'");
        }

        curPagosDev = new FLSqlCursor("pagosdevolcli");
        curPagosDev.setModeAccess(curPagosDev.Insert);
        curPagosDev.refreshBuffer();
        curPagosDev.setValueBuffer("idrecibo", idRecibo);
        curPagosDev.setValueBuffer("fecha", fecha);
        curPagosDev.setValueBuffer("tipo", "Pago");
        curPagosDev.setValueBuffer("tasaconv", tasaConv);
        curPagosDev.setValueBuffer("codcuenta", remesa["codcuenta"]);
        curPagosDev.setValueBuffer("descripcion", datosCuentaEmp["descripcion"]);
        curPagosDev.setValueBuffer("ctaentidad", datosCuentaEmp["ctaentidad"]);
        curPagosDev.setValueBuffer("ctaagencia", datosCuentaEmp["ctaagencia"]);
        curPagosDev.setValueBuffer("dc", datosCuentaEmp["dc"]);
        curPagosDev.setValueBuffer("cuenta", datosCuentaEmp["cuenta"]);
        curPagosDev.setValueBuffer("idremesa",remesa["idremesa"]);
        curPagosDev.setValueBuffer("nogenerarasiento",genAsiento);
        curPagosDev.setValueBuffer("idsubcuenta",idsubcuenta);
        curPagosDev.setValueBuffer("codsubcuenta",codsubcuenta);
        curPagosDev.setValueBuffer("automatico",true);

        if (!curPagosDev.commitBuffer())
                return false;

        return true;
}
/**\Devuelve un array con el codcuenta y el id de cuenta para la partida de clientes*/
function gestesoreria_cuentaPagoRecibosCli(idRecibo:String,codEjercicio:String):Array
{
        var util:FLUtil = new FLUtil();
        var cta:Array = [];
        var ctaPorDefecto:Boolean=false;

        /** \C Si no es un recibo agrupado la cuenta del haber del asiento de pago será la misma cuenta de tipo CLIENT que se usó para realizar el asiento de la correspondiente factura*/
        var idAsientoFactura:Number = util.sqlSelect("reciboscli r INNER JOIN facturascli f ON r.idfactura = f.idfactura", "f.idasiento", "r.idrecibo = " + idRecibo, "facturascli,reciboscli");

        if (idAsientoFactura) {
                var codEjercicioFac:String = util.sqlSelect("co_asientos", "codejercicio", "idasiento = " + idAsientoFactura);
                if (codEjercicioFac == codEjercicio) {
                        cta.codsubcuenta = util.sqlSelect("co_partidas p" +
                        " INNER JOIN co_subcuentas s ON p.idsubcuenta = s.idsubcuenta" +
                        " INNER JOIN co_cuentas c ON c.idcuenta = s.idcuenta",
                        "s.codsubcuenta",
                        "p.idasiento = " + idAsientoFactura + " AND c.idcuentaesp = 'CLIENT'",
                        "co_partidas,co_subcuentas,co_cuentas");

                        if (!cta.codsubcuenta) {
                                MessageBox.warning(util.translate("scripts", "No se ha encontrado la subcuenta de cliente del asiento contable correspondiente a la factura a pagar"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
                                    cta["error"]=1;
                                return cta;
                            }
                }else {
                        ctaPorDefecto = true;
                }
        }else {
                ctaPorDefecto = true;
        }

        if (ctaPorDefecto) {
                var codCliente:String = util.sqlSelect("reciboscli", "codcliente", "idrecibo = " + idRecibo);
                if (codCliente && codCliente != "") {
                        cta.codsubcuenta = util.sqlSelect("co_subcuentascli", "codsubcuenta", "codcliente = '" + codCliente + "' AND codejercicio = '" + codEjercicio +"'");
                        if (!cta.codsubcuenta) {
                                MessageBox.warning(util.translate("scripts", "El cliente %1 no tiene definida ninguna subcuenta en el ejercicio %2.\nEspecifique la subcuenta en la pestaña de contabilidad del formulario de clientes").arg(codCliente).arg(codEjercicio), MessageBox.Ok, MessageBox.NoButton);
                                cta["error"]=2;
                                return cta;
                        }
                } else {
                        cta = flfacturac.iface.pub_datosCtaEspecial("CLIENT", codEjercicio);
                        if (!cta.codsubcuenta) {
                                MessageBox.warning(util.translate("scripts", "No tiene definida ninguna cuenta de tipo CLIENT.\nDebe crear este tipo especial y asociarlo a una cuenta\nen el módulo principal de contabilidad"), MessageBox.Ok, MessageBox.NoButton);
                                cta["error"]=3;
                                return cta;
                        }
                }
        }

        cta.idsubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + cta.codsubcuenta + "' AND codejercicio = '" +codEjercicio+ "'");
        if (!cta.idsubcuenta) {
                MessageBox.warning(util.translate("scripts", "No existe la subcuenta ")  + cta.codsubcuenta + util.translate("scripts", " correspondiente al ejercicio ") + codEjercicio + util.translate("scripts", ".\nPara poder realizar el pago o devolución debe crear antes esta subcuenta"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
                cta["error"]=4;
                return cta;
        }

        cta["error"]=0;
        return cta;
}
/**\ usando una raiz (cuenta) busca o crea los datos de subcuenta validos para el ejercicio: devuelve Array*/
function gestesoreria_otraSubcuentaCliente(raiz:String,codcliente:String,valoresDefecto:Array):Array
{
    var util:FLUtil = new FLUtil();
    var datosSubCuenta:Array=[];
    datosSubCuenta["error"] = 3;

    var longSubcuenta = util.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + valoresDefecto.codejercicio + "'");

    var ctaCliente:Array = flfactppal.iface.pub_datosCtaCliente( codcliente, valoresDefecto );
        if (ctaCliente.error != 0){
                MessageBox.warning("Error al leer los datos de subcuenta del cliente",MessageBox.Ok);
                datosSubCuenta["error"] = 3;
                return datosSubCuenta;
        }
        var codsubcuentaS:String=ctaCliente.codsubcuenta;

        if (codsubcuentaS.length == longSubcuenta){
                var finsubcta= codsubcuentaS.substring(raiz.length,longSubcuenta);
                var codsubcuenta:String=raiz+finsubcta;
                if (codsubcuenta.length != longSubcuenta){
                        MessageBox.warning("Error al crear datos de subcuenta del cliente",MessageBox.Ok);
                        datosSubCuenta["error"] = 3;
                        return datosSubCuenta;
                }

                datosSubCuenta["codsubcuenta"]=codsubcuenta;

                var idsubcuenta=util.sqlSelect("co_subcuentas","idsubcuenta","codsubcuenta='"+codsubcuenta+"' AND codejercicio='"+valoresDefecto.codejercicio+"'");
                if (!idsubcuenta){
                           var idcuenta = util.sqlSelect("co_cuentas","idcuenta","codcuenta='"+raiz+"' AND codejercicio='"+valoresDefecto.codejercicio+"'");
                        if (!idcuenta){
                                MessageBox.warning("No existe una cuenta "+raiz+" valida para el ejercicio actual, por favor genere la cuenta");
                                datosSubCuenta["error"]=1;
                                return datosSubCuenta;
                        }

                        var nombre= util.sqlSelect("clientes","nombre","codcliente='"+codcliente+"'");
                        var descripcion:String
                        if (raiz=="4380")
                                descripcion = "ANTICIPOS "+nombre;
                        else
                                descripcion=nombre;

                        var curSubcuenta:FLSqlCursor = new FLSqlCursor("co_subcuentas");
                        with (curSubcuenta) {
                                setModeAccess(curSubcuenta.Insert);
                                refreshBuffer();
                                setValueBuffer("codsubcuenta", codsubcuenta);
                                setValueBuffer("descripcion", descripcion);
                                setValueBuffer("idcuenta",idcuenta);
                                setValueBuffer("codcuenta", raiz);
                                setValueBuffer("coddivisa", valoresDefecto.coddivisa);
                                setValueBuffer("codejercicio", valoresDefecto.codejercicio);
                        }
                        if (!curSubcuenta.commitBuffer()){
                                datosSubCuenta["error"]=2;
                                return datosSubCuenta;
                        }

                        datosSubCuenta["idsubcuenta"]= curSubcuenta.valueBuffer("idsubcuenta");
                } else {
                        datosSubCuenta["idsubcuenta"]= idsubcuenta;
                }
    }
    datosSubCuenta["error"]=0;
    return datosSubCuenta;

}
function gestesoreria_calcularEstadoReciboCli(idRecibo){

    var curRecibo = new FLSqlCursor("reciboscli");
    curRecibo.select("idrecibo='"+idRecibo+"'");

    if (curRecibo.first()) {
                curRecibo.setModeAccess(curRecibo.Edit);
                curRecibo.refreshBuffer();
                curRecibo.setValueBuffer("estado",formRecordreciboscli.iface.pub_obtenerEstado(idRecibo));

        }
        if (!curRecibo.commitBuffer())
           return false;

    return true;
}
/** \D Genera la partida correspondiente al cliente del asiento de pago o devolucion
@param        curPD: Cursor del pago o devolución
@param        valoresDefecto: Array de valores por defecto (ejercicio, divisa, etc.)
@param        datosAsiento: Array con los datos del asiento
@param        recibo: Array con los datos del recibo asociado al pago
@return        true si la generación es correcta, false en caso contrario
\end */
function gestesoreria_generarPartidasCli(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean
{
        var util:FLUtil = new FLUtil();
        var datosPartida:Array;
        var destinoPartida:String = "";

        datosPartida["calcularCambio"] = false;
        datosPartida["importe"] = 0;
        datosPartida["importeME"] = 0;
        datosPartida["tasaConv"] = 1;

        if (valoresDefecto.coddivisa == recibo.coddivisa) {
                datosPartida["importe"] = recibo.importe;
                datosPartida["importeME"] = 0;
        } else {
                if (recibo["idfactura"] && recibo["idfactura"]!=""){
                        datosPartida["tasaConv"] = util.sqlSelect("reciboscli r INNER JOIN facturascli f ON r.idfactura = f.idfactura ", "f.tasaconv", "r.idrecibo = " + curPD.valueBuffer("idrecibo"), "reciboscli,facturascli");
                }else{
                        datosPartida["tasaConv"] = recibo.tasaconv;
                }
                datosPartida["importe"] = parseFloat(recibo.importeeuros);
                datosPartida["importeME"] = parseFloat(recibo.importe);
        }

        if (curPD.valueBuffer("tipo") == "Pago"){

                destinoPartida = "HABER";


                if (recibo["idfactura"] && recibo["idfactura"]!=""){
                        var esAbono:Boolean = util.sqlSelect("facturascli", "deabono", "idfactura ='" + recibo["idfactura"]+"'");
                        if (esAbono == true){
                                destinoPartida = "DEBE";
                                datosPartida["importe"] = datosPartida["importe"]*-1;
                                datosPartida["importeME"] = datosPartida["importeME"]*-1;
                        }
                }

                var ctaPartida:Array = [];
                ctaPartida = this.iface.cuentaPagoRecibosCli(curPD.valueBuffer("idrecibo"),valoresDefecto.codejercicio);

                var idRemesa = curPD.valueBuffer("idremesa");
                if (idRemesa && idRemesa != ""){
                        var tipoconta = util.sqlSelect("remesas","tipoconta","idremesa='"+idRemesa+"'");
                        if (tipoconta=="300"){
                                var raiz = util.sqlSelect("factteso_general","codctadescontados","1=1");
                                if (!raiz) return false;
                                var codcliente = util.sqlSelect("reciboscli","codcliente","idrecibo='"+curPD.valueBuffer("idrecibo")+"'");
                                ctaPartida = this.iface.otraSubcuentaCliente(raiz,codcliente,valoresDefecto);
                        }
                }

                if (ctaPartida["error"]!=0)
                        return false;

                datosPartida["codsubcuenta"] = ctaPartida["codsubcuenta"];
                datosPartida["idsubcuenta"] = ctaPartida["idsubcuenta"];
                datosPartida["concepto"] = curPD.valueBuffer("tipo") + " recibo " + recibo.codigo + " - " + recibo.nombrecliente;
                datosPartida["coddivisa"] = recibo["coddivisa"];

        }else {
                /*Solo entra a esta parte del código cuando es Devolución, y el pago proviene de una remesa*/
                destinoPartida = "DEBE";
                var where:String = "idrecibo = '"+ curPD.valueBuffer("idrecibo") +"'";
                if (curPD.modeAccess()==curPD.Edit) where+= " AND idpagodevol <> '"+curPD.valueBuffer("idpagodevol")+"'";
                var curPagosDevol:FLSqlCursor = new FLSqlCursor("pagosdevolcli");
                curPagosDevol.select(where + " ORDER BY fecha, idpagodevol");
                curPagosDevol.last();

                if (curPagosDevol.valueBuffer("tipo") != "Pago")
                        return false;

                var idRemesa = curPagosDevol.valueBuffer("idremesa")
                if (!idRemesa || idRemesa=="") return false;

                var tipoConta:String = util.sqlSelect("remesas","tipoconta","idremesa='"+idRemesa+"'");
                var ctaPartida:Array = [];
                ctaPartida = this.iface.cuentaPagoRecibosCli(curPD.valueBuffer("idrecibo"),valoresDefecto.codejercicio);

                if (tipoConta == "110" || tipoConta == "300"){
                        var raiz = util.sqlSelect("remesas","codctaimpagados","idremesa='"+idRemesa+"'");
                        if (!raiz) return false;

                        if (raiz != "430" && raiz != "4300"){
                                var codcliente = util.sqlSelect("reciboscli","codcliente","idrecibo='"+curPD.valueBuffer("idrecibo")+"'");
                                ctaPartida = this.iface.otraSubcuentaCliente(raiz,codcliente,valoresDefecto);
                        }
                }

                if (ctaPartida["error"] != 0)
                        return false;

                datosPartida["codsubcuenta"] = ctaPartida["codsubcuenta"];
                datosPartida["idsubcuenta"] = ctaPartida["idsubcuenta"];
                datosPartida["concepto"] = curPD.valueBuffer("tipo") + " recibo " + recibo.codigo + " - " + recibo.nombrecliente;
                datosPartida["coddivisa"] = recibo["coddivisa"];
        }

        if (destinoPartida == "HABER"){
                if (!this.iface.generarPartidasHaber(curPD, valoresDefecto, datosAsiento, datosPartida))
                        return false;
        } else if (destinoPartida == "DEBE"){
                if (!this.iface.generarPartidasDebe(curPD, valoresDefecto, datosAsiento, datosPartida))
                        return false;
        }

        return true;
}
/** \Genera o regenera el asiento contable asociado a un pago o devolución de recibo
@param        curPD: Cursor posicionado en el pago o devolución cuyo asiento se va a regenerar
@return        true si la regeneración se realiza correctamente, false en caso contrario
\end */
function gestesoreria_generarAsientoPagoDevolCli(curPD:FLSqlCursor):Boolean
{
        var util:FLUtil = new FLUtil();
        if (curPD.modeAccess() != curPD.Insert && curPD.modeAccess() != curPD.Edit)
                return true;

        if (curPD.valueBuffer("nogenerarasiento")) {
                curPD.setNull("idasiento");
                return true;
        }

        var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
        var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(curPD.valueBuffer("fecha"), codEjercicio, "pagosdevolcli");
        if (!datosDoc.ok)
                return false;
        if (datosDoc.modificaciones == true) {
                codEjercicio = datosDoc.codEjercicio;
                curPD.setValueBuffer("fecha", datosDoc.fecha);
        }

        var datosAsiento:Array = [];
        var valoresDefecto:Array;
        valoresDefecto["codejercicio"] = codEjercicio;
        valoresDefecto["coddivisa"] = util.sqlSelect("empresa", "coddivisa", "1 = 1");

        datosAsiento = flfacturac.iface.pub_regenerarAsiento(curPD, valoresDefecto);
        if (datosAsiento.error == true)
                return false;

        var recibo:Array = flfactppal.iface.pub_ejecutarQry("reciboscli", "coddivisa,importe,importeeuros,idfactura,codigo,codcliente,nombrecliente,tasaconv", "idrecibo = " + curPD.valueBuffer("idrecibo"));
        if (recibo.result != 1)
                return false;

        var asientoInverso:Boolean = false;
        var idAsientoDev:Number = 0;

        if (curPD.valueBuffer("tipo") != "Pago"){
                var where:String = "idrecibo = '"+ curPD.valueBuffer("idrecibo") +"'";
                if (curPD.modeAccess()==curPD.Edit) where+= " AND idpagodevol <> '"+curPD.valueBuffer("idpagodevol")+"'";
                var curPagosDevol:FLSqlCursor = new FLSqlCursor("pagosdevolcli");
                curPagosDevol.select(where + " ORDER BY fecha, idpagodevol");
                curPagosDevol.last();

                if (curPagosDevol.valueBuffer("tipo") != "Pago") return false;

                /*si la devolucion NO proviene de un pago de remesa, la devolución será el asientoinverso del pago*/
                if (!curPagosDevol.valueBuffer("idremesa") || curPagosDevol.valueBuffer("idremesa")==""){
                        asientoInverso = true;
                        idAsientoDev = curPagosDevol.valueBuffer("idasiento");
                }
        }

        if (asientoInverso == true){
                if (this.iface.generarAsientoInverso(datosAsiento.idasiento, idAsientoDev, curPD.valueBuffer("tipo") + " recibo " + recibo["codigo"], valoresDefecto.codejercicio) == false)
                        return false;
        } else {
                if (!this.iface.generarPartidasCli(curPD, valoresDefecto, datosAsiento, recibo))
                                return false;

                if (!this.iface.generarPartidasBanco(curPD, valoresDefecto, datosAsiento, recibo))
                        return false;

                if (!this.iface.generarPartidasCambio(curPD, valoresDefecto, datosAsiento, recibo))
                        return false;
        }

        curPD.setValueBuffer("idasiento", datosAsiento.idasiento);

        if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento))
                return false;

        return true;
}
/** \D Actualiza el valor del riesgo alcanzado para un cliente. El valor es la suma de importes de recibos en estado: emitido+devuelto+remesado+riesgo
    o lo que es lo mismo los recibos que no estan pagados, agrupados o compensados.
@param codCliente: Código del cliente
\end */
function gestesoreria_actualizarRiesgoCliente(codCliente:String):Boolean
{
        var util:FLUtil = new FLUtil();

        /*Si hay Codcliente, actualiza el riesgo solo para ese cliente*/
    if (codCliente){
        var riesgo:Number = parseFloat( util.sqlSelect( "reciboscli", "SUM(importe)", "estado NOT IN ('Pagado','Agrupado','Compensado') AND codcliente='" + codCliente + "'" ) );
        if (!riesgo || isNaN(riesgo))
                riesgo = 0;

        util.sqlUpdate( "clientes", "riesgoalcanzado", riesgo, "codcliente = '" + codCliente + "'" );

                if (!flfactteso.iface.pub_automataActivado()) {
                var riesgoMax:Number = parseFloat( util.sqlSelect( "clientes", "riesgomax", "codcliente = '" + codCliente + "'" ) );
                if ( riesgo >= riesgoMax && riesgoMax > 0 ) {
                                MessageBox.warning(util.translate("scripts", "El cliente ") + codCliente + util.translate("scripts", " ha superado el riesgo máximo"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
                        }
                }

        /*Si no hay codcliente, actualiza el riesgo para todos los clientes con recibos*/
    }else {
        var q:FLSqlQuery = new FLSqlQuery;
        q.setTablesList("reciboscli,clientes");
            q.setSelect("SUM(reciboscli.importe),clientes.codcliente")
            q.setFrom("reciboscli INNER JOIN clientes ON reciboscli.codcliente=clientes.codcliente")
            q.setWhere("estado NOT IN ('Pagado','Agrupado','Compensado') GROUP BY clientes.codcliente");

        if (!q.exec())
            return false;

        var n:Number =0;
        util.createProgressDialog("Actualizando riesgo para todos los clientes", q.size());
        while (q.next()){
            riesgo=q.value(0);
            CodCliente=q.value(1);
            if (!riesgo || isNaN(riesgo))
                riesgo = 0;
                util.sqlUpdate( "clientes", "riesgoalcanzado", riesgo, "codcliente = '" + codCliente + "'" );
            n++;
                    util.setProgress(n);
            }
            util.destroyProgressDialog();
    }

    return true;
}
 /*comprueba que la fecha de la remesa o el pago de remesa sea igual o superior a la fecha del ultimo pago o devolución de los recibos incluidos*/
function gestesoreria_fechaPagosDevolCli(idRemesa:String, fecha:Date):Boolean{

    var util:FLUtil = new FLUtil();
    var idRecibos:String = formRecordremesas.iface.pub_idRecibosRemesa(idRemesa);
    var curRecibos:FLSqlCursor = new FLSqlCursor("reciboscli");
    curRecibos.select("idrecibo IN ("+idRecibos+")");
    if (curRecibos.size()<=0)
        return false;

    var n:Number=0;
    var sigue:Boolean=curRecibos.first()
    while (sigue){
        var pdfecha = util.sqlSelect("pagosdevolcli","fecha","idrecibo="+curRecibos.valueBuffer("idrecibo")+" ORDER BY fecha DESC");
        if (pdfecha && pdfecha!=""){
            if (util.daysTo(pdfecha, fecha) < 0)
                n++;
        }
        sigue=curRecibos.next();
    }

    if (n>0) return false;
    if (n<=0) return true;
}
/** \D Genera la partida correspondiente al proveedor del asiento de pago
@param  curPD: Cursor del pago o devolución
@param  valoresDefecto: Array de valores por defecto (ejercicio, divisa, etc.)
@param  datosAsiento: Array con los datos del asiento
@param  recibo: Array con los datos del recibo asociado al pago
@return true si la generación es correcta, false en caso contrario
\end */
function gestesoreria_generarPartidasProv(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean
{

    /*Solo entra a esta función si es tipo Pago*/
    if (curPD.valueBuffer("tipo") != "Pago"){
            return false;
    }

    var util:FLUtil = new FLUtil();
    var datosPartida:Array;
    var destinoPartida:String = "";

    datosPartida["calcularCambio"] = false;
    datosPartida["importe"] = 0;
    datosPartida["importeME"] = 0;
    datosPartida["tasaConv"] = 1;

    if (valoresDefecto.coddivisa == recibo.coddivisa) {
        datosPartida["importe"] = recibo.importe;
        datosPartida["importeME"] = 0;
    } else {
         if (recibo["idfactura"] && recibo["idfactura"]!=""){
                        datosPartida["tasaConv"] = util.sqlSelect("recibosprov r INNER JOIN facturasprov f ON r.idfactura = f.idfactura ", "f.tasaconv", "r.idrecibo = " + curPD.valueBuffer("idrecibo"), "recibosprov,facturascli");
                }else{
                        datosPartida["tasaConv"] = recibo.tasaconv;
                }
                datosPartida["importe"] = parseFloat(recibo.importeeuros);
                datosPartida["importeME"] = parseFloat(recibo.importe);
    }

    destinoPartida = "DEBE";
    if (recibo["idfactura"] && recibo["idfactura"]!=""){
            var esAbono:Boolean = util.sqlSelect("facturasprov", "deabono", "idfactura ='" + recibo["idfactura"]+"'");
            if (esAbono == true){
                    destinoPartida = "HABER";
                    datosPartida["importe"] = datosPartida["importe"]*-1;
                    datosPartida["importeME"] = datosPartida["importeME"]*-1;
            }
    }

    var ctaPartida:Array = [];
    ctaPartida = this.iface.cuentaPagoRecibosProv(curPD.valueBuffer("idrecibo"),valoresDefecto.codejercicio);

    if (ctaPartida["error"]!=0)
            return false;

    datosPartida["codsubcuenta"] = ctaPartida["codsubcuenta"];
    datosPartida["idsubcuenta"] = ctaPartida["idsubcuenta"];
    datosPartida["concepto"] = curPD.valueBuffer("tipo") + " recibo prov " + recibo.codigo + " - " + recibo.nombreproveedor;
    datosPartida["coddivisa"] = recibo["coddivisa"];

    if (destinoPartida == "HABER"){
            if (!this.iface.generarPartidasHaber(curPD, valoresDefecto, datosAsiento, datosPartida))
                    return false;
    } else if (destinoPartida == "DEBE"){
            if (!this.iface.generarPartidasDebe(curPD, valoresDefecto, datosAsiento, datosPartida))
                    return false;
    }

    return true;
}
function gestesoreria_actualizarEstadoRiesgo():Boolean
{
    var util:FLUtil = new FLUtil();
    var hoy:Date = new Date();

    var curRecibos:FLSqlCursor = new FLSqlCursor("reciboscli");
    curRecibos.select("estado = 'Riesgo' AND fechamate<='"+hoy+"'");
    if (curRecibos.size()<=0)
        return true;

    var n:Number=0;
    util.createProgressDialog(util.translate("scripts", "Actualizando estado de recibos en Riesgo"), curRecibos.size());
    var sigue:Boolean=curRecibos.first();

    while (sigue){
        curRecibos.setModeAccess(curRecibos.Edit);
        curRecibos.refreshBuffer();
        curRecibos.setValueBuffer("estado","Pagado");
        if (!curRecibos.commitBuffer())
            return false;
        sigue=curRecibos.next();
        n++;
        util.setProgress(n);
    }
    util.destroyProgressDialog();
    return true;

}
function gestesoreria_comprobarCuentasDom(idRemesa:String):Boolean
{
        var util:FLUtil = new FLUtil();

        var qryRecibos:FLSqlQuery = new FLSqlQuery;
        qryRecibos.setTablesList("reciboscliremesa,reciboscli,cuentasbcocli");
        qryRecibos.setSelect("r.codigo, r.codcliente, r.nombrecliente");
        qryRecibos.setFrom("reciboscliremesa rm INNER JOIN reciboscli r ON rm.idrecibo = r.idrecibo LEFT OUTER JOIN cuentasbcocli cc ON (r.codcliente = cc.codcliente AND r.codcuenta = cc.codcuenta)");
        qryRecibos.setWhere("rm.idremesa = " + idRemesa + " AND cc.codcuenta IS NULL ORDER BY codcliente, codigo");
        qryRecibos.setForwardOnly( true );
        if (!qryRecibos.exec())
                return false;

        var msgError:String = "";
        var i:Number = 0;
        while (qryRecibos.next()) {
                msgError += "\n" + util.translate("scripts", "Cliente: %1 (%2), Recibo %3").arg(qryRecibos.value("r.nombrecliente")).arg(qryRecibos.value("r.codcliente")).arg(qryRecibos.value("r.codigo"));
        }
        if (msgError != "") {
                var res:Number = MessageBox.warning(util.translate("scripts", "Los siguientes recibos no tienen especificada una cuenta de domiciliación válida:") + msgError + "\n¿Desea continuar?" , MessageBox.Yes, MessageBox.No);
                if (res != MessageBox.Yes)
                        return false;
        }

        return true;
}
function gestesoreria_comprobarDireccionesDom(idRemesa:String):Boolean
{
        var util:FLUtil = new FLUtil();

        var qryRecibos:FLSqlQuery = new FLSqlQuery;
        qryRecibos.setTablesList("reciboscliremesa,reciboscli,dirclientes");
        qryRecibos.setSelect("r.codigo, r.codcliente, r.nombrecliente");
        qryRecibos.setFrom("reciboscliremesa rm INNER JOIN reciboscli r ON rm.idrecibo = r.idrecibo LEFT OUTER JOIN dirclientes dc ON (r.codcliente = dc.codcliente AND r.coddir = dc.id)");
        qryRecibos.setWhere("rm.idremesa = " + idRemesa + " AND dc.id IS NULL ORDER BY codcliente, codigo");
        qryRecibos.setForwardOnly( true );

        if (!qryRecibos.exec())
                return false;

        var msgError:String = "";
        var i:Number = 0;
        while (qryRecibos.next()) {
                msgError += "\n" + util.translate("scripts", "Cliente: %1 (%2), Recibo %3").arg(qryRecibos.value("r.nombrecliente")).arg(qryRecibos.value("r.codcliente")).arg(qryRecibos.value("r.codigo"));
        }
        if (msgError != "") {
                MessageBox.warning(util.translate("scripts", "Los siguientes recibos no tienen especificada una dirección de domiciliación válida:") + msgError , MessageBox.Yes, MessageBox.No);
                return false;
        }

        return true;
}
/** \D Genera la partida correspondiente al banco o a caja del asiento de pago
@param  curPD: Cursor del pago o devolución
@param  valoresDefecto: Array de valores por defecto (ejercicio, divisa, etc.)
@param  datosAsiento: Array con los datos del asiento
@param  recibo: Array con los datos del recibo asociado al pago
@return true si la generación es correcta, false en caso contrario
\end */
function gestesoreria_generarPartidasBanco(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean
{
        var util:FLUtil = new FLUtil();
        var destinoPartida:String = "";
        var ctaPartida:Array = [];
        var datosPartida:Array;

        ctaPartida.codsubcuenta = curPD.valueBuffer("codsubcuenta");
        ctaPartida.idsubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + ctaPartida.codsubcuenta + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
        if (!ctaPartida.idsubcuenta) {
                MessageBox.warning(util.translate("scripts", "No tiene definida la subcuenta %1 en el ejercicio %2.\nAntes de crear el pago ó devolución, debe crear la subcuenta o modificar el ejercicio").arg(ctaPartida.codsubcuenta).arg(valoresDefecto.codejercicio), MessageBox.Ok, MessageBox.NoButton);
                return false;
        }

        datosPartida["importe"] = recibo["importe"];
        datosPartida["calcularCambio"] = true;

        if (curPD.valueBuffer("tipo") == "Pago"){
                destinoPartida = "DEBE";
                if (recibo["idfactura"] && recibo["idfactura"]!=""){
                        var esAbono:Boolean = util.sqlSelect("facturascli", "deabono", "idfactura ='" + recibo["idfactura"]+"'");
                        if (esAbono == true){
                                destinoPartida = "HABER";
                                datosPartida["importe"] = recibo["importe"]*-1;
                        }
                }

        }else{
                destinoPartida = "HABER";
        }

        datosPartida["coddivisa"] = recibo["coddivisa"];
        datosPartida["codsubcuenta"] = ctaPartida["codsubcuenta"];
        datosPartida["idsubcuenta"] = ctaPartida["idsubcuenta"];
        datosPartida["concepto"] = curPD.valueBuffer("tipo") + " recibo " + recibo["codigo"];

        if (destinoPartida == "HABER"){
                if (!this.iface.generarPartidasHaber(curPD, valoresDefecto, datosAsiento, datosPartida))
                        return false;
        } else if (destinoPartida == "DEBE"){
                if (!this.iface.generarPartidasDebe(curPD, valoresDefecto, datosAsiento, datosPartida))
                        return false;
        }


        return true;
}
/*idRemesa: identificador de la remesa
insertar: Marca si el pago de remesa hay que insertarlo o eliminarlo
return: true si realiza el commit, false en caso de error.*/
function gestesoreria_pagoRemesaAuto(idRemesa:String, modo:String):Boolean
{

        if (!idRemesa || idRemesa=="") return false;
        var hoy:Date = new Date();

        var curPR:FLSqlCursor = new FLSqlCursor("pagosdevolrem");

        if (modo == "Insertar"){
                curPR.setModeAccess(curPR.Insert);
                curPR.refreshBuffer();
                curPR.setValueBuffer("idremesa", idRemesa);
                curPR.setValueBuffer("fecha", hoy);
                curPR.setValueBuffer("tipo", "Pago");
                curPR.setValueBuffer("nogenerarasiento", false);
        }

        if (modo == "Eliminar") {
                curPR.select("idremesa='"+idRemesa+"'");
                if (!curPR.first()) return false;
                curPR.setModeAccess(curPR.Del);
                curPR.refreshBuffer();
        }

        if (!curPR.commitBuffer()){
                return false;
        }

        return true;
}
/** \C Inserta o elimina los pagos de recibos asociados a una remesa con tipoconta 100 o 110*/
function gestesoreria_gestionarPagosRecibosRemesa(curPR:FLSqlCursor, modo:String):Boolean
{
        var util:FLUtil = new FLUtil();
        var idRemesa = curPR.valueBuffer("idremesa");
        var idRecibos:String = formRecordremesas.iface.pub_idRecibosRemesa(idRemesa);
        var curRecibos:FLSqlCursor = new FLSqlCursor("reciboscli");
        curRecibos.select("idrecibo IN ("+idRecibos+")");
        if (curRecibos.size()<=0)
                return false;

        /*Inserta los pagos y deja los recibos en estado Pagado*/
        if (modo == "Insertar"){
                var sigue:Boolean=curRecibos.first()
                while (sigue){
                        var pago:Boolean = false;
                        var curPagosDevol:FLSqlCursor = new FLSqlCursor("pagosdevolcli");
                        curPagosDevol.select("idrecibo = " + curRecibos.valueBuffer("idrecibo") + " ORDER BY fecha, idpagodevol");
                        curPagosDevol.last()
                        if (curPagosDevol.valueBuffer("tipo") == "Pago") pago=true;
                        if (pago) util.sqlDelete("pagosdevolcli","idpagodevol='"+curPagosDevol.valueBuffer("idpagodevol")+"'");

                        var noGenAsiento=true;
                        var remesa:Array= flfactppal.iface.pub_ejecutarQry("remesas", "tipoconta,codcuenta,codsubcuenta,idsubcuenta,codsubcuentaecgc,idsubcuentaecgc,idremesa", "idremesa='"+idRemesa+"'");

                        if (!this.iface.generarPagoRecibosCli(curRecibos.valueBuffer("idrecibo"),remesa,curPR.valueBuffer("fecha"),noGenAsiento))
                                return false;

                        var estado = "Pagado";
                        var hoy:Date = new Date();
                        var fechamate = util.sqlSelect("reciboscli","fechamate","idrecibo='"+curRecibos.valueBuffer("idrecibo")+"'");
                        if (fechamate>hoy){
                                estado = "Riesgo"
                        }

                        curRecibos.setActivatedCheckIntegrity(false);
                        curRecibos.setModeAccess(curRecibos.Edit);
                        curRecibos.refreshBuffer();
                        curRecibos.setValueBuffer("estado", estado);
                        curRecibos.commitBuffer();

                        sigue=curRecibos.next()
                }
        }

        /*Elimina los pagos y deja los recibos en estado Remesado*/
        if (modo == "Eliminar"){
                var qryRecibos1:FLSqlQuery = new FLSqlQuery;
                qryRecibos1.setTablesList("reciboscli");
                qryRecibos1.setSelect("idrecibo");
                qryRecibos1.setFrom("reciboscli");
                qryRecibos1.setWhere("idrecibo IN ("+idRecibos+") AND (estado<>'Pagado' AND estado<>'Riesgo')");
                if (!qryRecibos1.exec())
                    return false;

                if (qryRecibos1.size()>0){
                   MessageBox.warning("No se puede eliminar el pago de la remesa, uno o mas recibos vinculados tienen estado diferente de pagado",MessageBox.Ok, MessageBox.NoButton);
                            return false;
                }

                var qryRecibos2:FLSqlQuery = new FLSqlQuery;
                qryRecibos2.setTablesList("reciboscli");
                qryRecibos2.setSelect("idrecibo");
                qryRecibos2.setFrom("reciboscli");
                qryRecibos2.setWhere("idrecibo IN ("+idRecibos+") AND (estado='Pagado' OR estado='Riesgo')");
                if (!qryRecibos2.exec())
                    return false;

                while (qryRecibos2.next()){
                        var curPagoDevol:FLSqlCursor = new FLSqlCursor("pagosdevolcli");
                        curPagoDevol.select("idrecibo = '" + qryRecibos2.value("idrecibo") + "' ORDER BY fecha, idpagodevol");
                        if (!curPagoDevol.last()) return false;
                        if (curPagoDevol.valueBuffer("idremesa") != curPR.valueBuffer("idremesa")){
                                MessageBox.warning("No se puede eliminar el pago de la remesa, uno o mas recibos vinculados tienen pagos o devoluciones posteriores",MessageBox.Ok, MessageBox.NoButton);
                                return false;
                        }
                }

                if (!util.sqlDelete("pagosdevolcli","idremesa='"+curPR.valueBuffer("idremesa")+"'")) return false;

                var sigue:Boolean=curRecibos.first()
                while (sigue){
                        curRecibos.setModeAccess(curRecibos.Edit);
                        curRecibos.refreshBuffer();
                        curRecibos.setValueBuffer("estado","Remesado");
                        if (!curRecibos.commitBuffer())
                                return false;
                        sigue=curRecibos.next();
                }
        }

        return true;
}
/** \C Se regenera, si es posible, el asiento contable asociado al pago de una remesa

\end */
function gestesoreria_beforeCommit_pagosdevolrem(curPR:FLSqlCursor):Boolean
{
        var util:FLUtil = new FLUtil();

        /*Verifica que en tipo 100 y 110 el pago del recibo se pueda realizar, sino, no genera el asiento ni los pagos de los recibos*/
        var tipoConta = util.sqlSelect("remesas","tipoconta","idremesa='"+curPR.valueBuffer("idremesa")+"'");
        if (curPR.modeAccess() != curPR.Del && (tipoConta == "100" || tipoConta == "110")){
                var ok = this.iface.fechaPagosDevolCli(curPR.valueBuffer("idremesa"), curPR.valueBuffer("fecha"));
                if (!ok){
                        MessageBox.warning("Hubo un error al generar los pagos de los recibos, el asiento no se puede generar.\nVerifique que las fechas de pago y devolución de los recibos no sean posteriores\n a la fecha del pago de la remesa\n",MessageBox.Ok, MessageBox.NoButton);
                        return false;
                }

                if (!this.iface.gestionarPagosRecibosRemesa(curPR, "Insertar")){
                        return false;
                }
        }

        if (curPR.valueBuffer("nogenerarasiento")) {
                curPR.setNull("idasiento");
                return true;
        }

        if (!this.iface.__beforeCommit_pagosdevolrem(curPR)) return false;

        return true;
}

/** \C Se eliminan los recibos vinculados en tipo 100 y 110 y se actualiza el estado de la remesa
\end */
function gestesoreria_afterCommit_pagosdevolrem(curPD:FLSqlCursor):Boolean
{
        var util:FLUtil = new FLUtil();

        var tipoConta = util.sqlSelect("remesas","tipoconta","idremesa='"+curPD.valueBuffer("idremesa")+"'");
        if (curPD.modeAccess() == curPD.Del && (tipoConta == "100" || tipoConta == "110")){
                if (!this.iface.gestionarPagosRecibosRemesa(curPD, "Eliminar")){
                        return false;
                }
        }

        if (!this.iface.__afterCommit_pagosdevolrem(curPD)) return false;

        var curRem:FLSqlCursor = new FLSqlCursor("remesas");
        curRem.select("idremesa='"+curPD.valueBuffer("idremesa")+"'");
        if (!curRem.first()) return false;
        var estado = this.iface.calcularEstadoRemesa(curRem);

        curRem.setModeAccess(curRem.Edit);
        curRem.refreshBuffer();
        curRem.setValueBuffer("estado", estado);
        if (!curRem.commitBuffer()) return false;

        return true;
}
/** \D Genera, si es necesario, la partida de diferecias positivas o negativas de cambio
@param  curPD: Cursor del pago o devolución
@param  valoresDefecto: Array de valores por defecto (ejercicio, divisa, etc.)
@param  datosAsiento: Array con los datos del asiento
@param  recibo: Array con los datos del recibo asociado al pago
@return true si la generación es correcta, false en caso contrario
\end */
function gestesoreria_generarPartidasCambio(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean
{
        /** \C En el caso de que la divisa sea extranjera y la tasa de cambio haya variado desde el momento de la emisión del recibo respecto a su origen: factura, recibo manual ó recibo agrupado, la diferencia se imputará a la correspondiente cuenta de diferencias de cambio.

        La diferencia con la función de la clase oficial es básicamente que la tasaconv del haber es calculada en una función nueva que depende del origen del recibo: si hay o no factura, si proviene de un agrupado, etc.
        \end */

        if (valoresDefecto.coddivisa == recibo.coddivisa)
                return true;

        var util:FLUtil = new FLUtil();
        var debe:Number = 0;
        var haber:Number = 0;
        var tasaconvDebe:Number = 1;
        var tasaconvHaber:Number = 1;
        var diferenciaCambio:Number = 0;

        tasaconvDebe = curPD.valueBuffer("tasaconv");
        debe = parseFloat(recibo.importe) * parseFloat(tasaconvDebe);
        debe = util.roundFieldValue(debe, "co_partidas", "debe");

        recibo["idrecibo"] = curPD.valueBuffer("idrecibo");
        tasaconvHaber = this.iface.calcularTasaConvCambio(recibo, "reciboscli");
        haber = parseFloat(recibo.importeeuros);
        haber = util.roundFieldValue(haber, "co_partidas", "debe");

        diferenciaCambio = debe - haber;
        if (util.buildNumber(diferenciaCambio, "f", 2) == "0.00" || util.buildNumber(diferenciaCambio, "f", 2) == "-0.00") {
                diferenciaCambio = 0;
                return true;
        }

        diferenciaCambio = util.roundFieldValue(diferenciaCambio, "co_partidas", "debe");

        var ctaDifCambio:Array = [];
        var debeDifCambio:Number = 0;
        var haberDifCambio:Number = 0;
        if (diferenciaCambio > 0) {
                ctaDifCambio = flfacturac.iface.pub_datosCtaEspecial("CAMPOS", valoresDefecto.codejercicio);
                if (ctaDifCambio.error != 0){
                        MessageBox.information("No tiene configurada ninguna subcuenta como tipo especial CAMPOS.\nDebe asociarla en el módulo Principal del área Financiera",MessageBox.Ok,MessageBox.NoButton);
                        return false;}
                debeDifCambio = 0;
                haberDifCambio = diferenciaCambio;
        } else {
                ctaDifCambio = flfacturac.iface.pub_datosCtaEspecial("CAMNEG", valoresDefecto.codejercicio);
                if (ctaDifCambio.error != 0){
                        MessageBox.information("No tiene configurada ninguna subcuenta como tipo especial CAMNEG.\nDebe asociarla en el módulo Principal del área Financiera",MessageBox.Ok,MessageBox.NoButton);
                        return false;}
                diferenciaCambio = 0 - diferenciaCambio;
                debeDifCambio = diferenciaCambio;
                haberDifCambio = 0;
        }

        var esPago:Boolean = this.iface.esPagoEstePagoDevol(curPD);

        var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
        with(curPartida) {
                setModeAccess(curPartida.Insert);
                refreshBuffer();
                        try {
                        setValueBuffer("concepto", datosAsiento.concepto);
                } catch (e) {
                        setValueBuffer("concepto", curPD.valueBuffer("tipo") + " recibo " + recibo.codigo + " - " + recibo.nombrecliente);
                }
                setValueBuffer("idsubcuenta", ctaDifCambio.idsubcuenta);
                setValueBuffer("codsubcuenta", ctaDifCambio.codsubcuenta);
                setValueBuffer("idasiento", datosAsiento.idasiento);
                if (esPago) {
                        setValueBuffer("debe", debeDifCambio);
                        setValueBuffer("haber", haberDifCambio);
                } else {
                        setValueBuffer("debe", haberDifCambio);
                        setValueBuffer("haber", debeDifCambio);
                }
                setValueBuffer("coddivisa", valoresDefecto.coddivisa);
                setValueBuffer("tasaconv", 1);
                setValueBuffer("debeME", 0);
                setValueBuffer("haberME", 0);
        }
        if (!curPartida.commitBuffer())
                return false;

        return true;
}
/** \C Devuelve el valor de tasa de cambio (para generar las partidas de cambio) de un recibo
@param recibo: Array con valores del recibo
\end */
function gestesoreria_calcularTasaConvCambio(recibo:Array, tipo:String):Number
{
        var tasaConv:Number = 1;
        var tablaFact:String="";
        if (tipo == "reciboscli") tablaFact = "facturascli";
        else if (tipo == "recibosprov") tablaFact = "facturasprov";;
        var util:FLUtil = new FLUtil();

        var convFra = util.sqlSelect(tablaFact, "tasaconv", "idfactura = '"+recibo["idfactura"]+"'");
        if (convFra && convFra!=""){
                tasaConv = parseFloat(convFra);
        }

        return tasaConv;
}
function gestesoreria_afterCommit_pagosdevolcli(curPD:FLSqlCursor):Boolean
{
        var util:FLUtil = new FLUtil();
        if (!this.iface.__afterCommit_pagosdevolcli(curPD)){
                return false;
        }

        if (curPD.valueBuffer("tipo")=="Pago"){
                var idremesa = curPD.valueBuffer("idremesa") ;
                if (idremesa && idremesa!=""){
                        if (curPD.modeAccess() == curPD.Insert){
                                if (!util.sqlUpdate("reciboscli","idremesa","null","idrecibo='"+curPD.valueBuffer("idrecibo")+"'")){
                                        return false;
                                }
                        }else if (curPD.modeAccess() == curPD.Del){
                                if (!util.sqlUpdate("reciboscli","idremesa",idremesa,"idrecibo='"+curPD.valueBuffer("idrecibo")+"'")){
                                        return false;
                                }
                        }
                }
        }
        return true;
}
/**\Devuelve un array con el codcuenta y el id de cuenta para la partida de proveedor*/
function gestesoreria_cuentaPagoRecibosProv(idRecibo:String,codEjercicio:String):Array
{

        var util:FLUtil = new FLUtil();
        var cta:Array = [];
        var ctaPorDefecto:Boolean=false;

        /** \C Si no es un recibo agrupado la cuenta del haber del asiento de pago será la misma cuenta de tipo PROVEE que se usó para realizar el asiento de la correspondiente factura*/
        var idAsientoFactura:Number = util.sqlSelect("recibosprov r INNER JOIN facturasprov f" + " ON r.idfactura = f.idfactura", "f.idasiento", "r.idrecibo = " + idRecibo, "facturasprov,recibosprov");

        if (idAsientoFactura){
                var codEjercicioFac:String = util.sqlSelect("co_asientos", "codejercicio", "idasiento = " + idAsientoFactura);
                if (codEjercicioFac == codEjercicio) {
                        cta.codsubcuenta = util.sqlSelect("co_partidas p" + " INNER JOIN co_subcuentas s ON p.idsubcuenta = s.idsubcuenta" + " INNER JOIN co_cuentas c ON c.idcuenta = s.idcuenta", "s.codsubcuenta", "p.idasiento = " + idAsientoFactura + " AND c.idcuentaesp = 'PROVEE'", "co_partidas,co_subcuentas,co_cuentas");

                        if (!cta.codsubcuenta) {
                            MessageBox.warning(util.translate("scripts", "No se ha encontrado la subcuenta de proveedor del asiento contable correspondiente a la factura a pagar"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
                            cta["error"]=1;
                            return cta;
                        }
                }else{
                        ctaPorDefecto = true;
                }
        } else {
                ctaPorDefecto = true;
        }

        if (ctaPorDefecto){
                var codProveedor:String = util.sqlSelect("recibosprov", "codproveedor", "idrecibo = " + idRecibo);
                if (codProveedor && codProveedor != "") {
                        cta.codsubcuenta = util.sqlSelect("co_subcuentasprov", "codsubcuenta", "codproveedor = '" + codProveedor + "' AND codejercicio = '" + codEjercicio + "'");
                        if (!cta.codsubcuenta) {
                                MessageBox.warning(util.translate("scripts", "El proveedor %1 no tiene definida ninguna subcuenta en el ejercicio %2.\nEspecifique la subcuenta en la pestaña de contabilidad del formulario de proveedores").arg(codProveedor).arg(codEjercicio), MessageBox.Ok, MessageBox.NoButton);
                                cta["error"]=2;
                                return cta;
                        }
                } else {
                        cta = flfacturac.iface.pub_datosCtaEspecial("PROVEE", codEjercicio);
                        if (!cta.codsubcuenta) {
                                MessageBox.warning(util.translate("scripts", "No tiene definida ninguna cuenta de tipo PROVEE.\nDebe crear este tipo especial y asociarlo a una cuenta\nen el módulo principal de contabilidad"), MessageBox.Ok, MessageBox.NoButton);
                                cta["error"]=3;
                                return cta;
                        }
                }
        }

        cta.idsubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + cta.codsubcuenta +  "' AND codejercicio = '" + codEjercicio + "'");
        if (!cta.idsubcuenta) {
                MessageBox.warning(util.translate("scripts", "No existe la subcuenta ")  + cta.codsubcuenta + util.translate("scripts", " correspondiente al ejercicio ") + codEjercicio + util.translate("scripts", ".\nPara poder realizar el pago debe crear antes esta subcuenta"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
                cta["error"]=4;
        return cta;
        }

        cta["error"]=0;
        return cta;

}
/** \D Genera la partida correspondiente al banco o a caja del asiento de pago de recibosprov
@param  curPD: Cursor del pago o devolución
@param  valoresDefecto: Array de valores por defecto (ejercicio, divisa, etc.)
@param  datosAsiento: Array con los datos del asiento
@param  recibo: Array con los datos del recibo asociado al pago
@return true si la generación es correcta, false en caso contrario
\end */
function gestesoreria_generarPartidasBancoProv(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean
{
        var util:FLUtil = new FLUtil();
        var destinoPartida:String = "";
        var ctaPartida:Array = [];
        var datosPartida:Array;

        ctaPartida.codsubcuenta = curPD.valueBuffer("codsubcuenta");

        ctaPartida.idsubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + ctaPartida.codsubcuenta + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
        if (!ctaPartida.idsubcuenta) {
                MessageBox.warning(util.translate("scripts", "No tiene definida la subcuenta %1 en el ejercicio %2.\nAntes de crear el pago ó devolución, debe crear la subcuenta o modificar el ejercicio").arg(ctaPartida.codsubcuenta).arg(valoresDefecto.codejercicio), MessageBox.Ok, MessageBox.NoButton);
                return false;
        }

        datosPartida["importe"] = recibo["importe"];
        datosPartida["calcularCambio"] = true;

        if (curPD.valueBuffer("tipo") == "Pago"){
                destinoPartida = "HABER";
                if (recibo["idfactura"] && recibo["idfactura"]!=""){
                        var esAbono:Boolean = util.sqlSelect("facturasprov", "deabono", "idfactura ='" + recibo["idfactura"]+"'");
                        if (esAbono == true){
                                destinoPartida = "DEBE";
                                datosPartida["importe"] = recibo["importe"]*-1;
                        }
                }

        }else{
                destinoPartida = "DEBE";
        }
        datosPartida["coddivisa"] = recibo["coddivisa"];
        datosPartida["codsubcuenta"] = ctaPartida["codsubcuenta"];
        datosPartida["idsubcuenta"] = ctaPartida["idsubcuenta"];
        datosPartida["concepto"] = curPD.valueBuffer("tipo") + " recibo prov " + recibo["codigo"];

        if (destinoPartida == "HABER"){
                if (!this.iface.generarPartidasHaber(curPD, valoresDefecto, datosAsiento, datosPartida))
                        return false;
        } else if (destinoPartida == "DEBE"){
                if (!this.iface.generarPartidasDebe(curPD, valoresDefecto, datosAsiento, datosPartida))
                        return false;
        }


        return true;
}
function gestesoreria_beforeCommit_remesasprov(curRemesa:FLSqlCursor):Boolean
{

        switch (curRemesa.modeAccess()) {
                /** \C La remesa puede borrarse si todos los recibos asociados pueden ser excluidos*/
                case curRemesa.Del:
                        var util:FLUtil = new FLUtil();
                        var idRemesa:Number = curRemesa.valueBuffer("idremesa");
                        var idPagoRem = util.sqlSelect("pagosdevolremprov","idpagoremprov","idremesa='"+idRemesa+"'");
                        if (idPagoRem && idPagoRem!=""){
                                MessageBox.warning("La remesa no puede borrarse, por favor elimine el pago",MessageBox.Ok, MessageBox.NoButton);
                                return false;
                        }

                        var qryRecibos:FLSqlQuery = new FLSqlQuery;
                        qryRecibos.setTablesList("recibosprovremesa");
                        qryRecibos.setSelect("idrecibo");
                        qryRecibos.setFrom("recibosprovremesa");
                        qryRecibos.setWhere("idremesa='"+idRemesa+"'");
                        if (!qryRecibos.exec())
                                return false;
                        while (qryRecibos.next()) {
                        /*Comprueba primero que todos los recibos puedan ser eliminados*/
                                if (!formRecordremesasprov.iface.excluirReciboRemesa(qryRecibos.value("idrecibo"), idRemesa,true)){
                                        MessageBox.warning("La remesa no puede ser eliminada",MessageBox.Ok, MessageBox.NoButton);
                                        return false;
                                }
                        }

                        if (!qryRecibos.exec())
                                return false;

                        while (qryRecibos.next()) {
                        /*excluye los recibos*/
                                if (!formRecordremesasprov.iface.excluirReciboRemesa(qryRecibos.value("idrecibo"), idRemesa,false)){
                                        return false;
                                }
                        }
                        break;


                case curRemesa.Insert:
                        curRemesa.setValueBuffer("estado","Emitida");
                        break;

                case curRemesa.Edit:
                        var estado = this.iface.calcularEstadoRemesaProv(curRemesa);
                        if (!estado || estado=="") return false;
                        else curRemesa.setValueBuffer("estado", estado);
                        break;
        }

        /** \ Si la contabilidad esta integrada, el tipoconta de la remesa es indirecta (200) y el cerrada pasa a true: genera asiento de remesa*/
        if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada")) {
                if (curRemesa.valueBuffer("tipoconta")=="200") {
                        if (curRemesa.valueBuffer("cerrada") == true && curRemesa.valueBufferCopy("cerrada") == false){
                                if (this.iface.generarAsientoRemesaProv(curRemesa) == false)
                                        return false;
                        }

                        if (curRemesa.valueBuffer("cerrada") == false && curRemesa.valueBuffer("idasiento") &&  curRemesa.valueBuffer("idasiento")!=""){
                                curRemesa.setNull("idasiento");
                        }
                }
        }

        return true;
}
function gestesoreria_afterCommit_remesasprov(curRemesa:FlSqlCursor):Boolean
{
        if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada")) {
                switch (curRemesa.modeAccess()) {
                        case curRemesa.Del:
                                if (curRemesa.valueBuffer("tipoconta")=="200"){
                                        if (!flfacturac.iface.eliminarAsiento(curRemesa.valueBuffer("idasiento")))
                                                return false;
                                }
                                break;

                        case curRemesa.Edit:
                                if (curRemesa.valueBuffer("nogenerarasiento")) {
                                        var idAsientoAnterior:String = curRemesa.valueBufferCopy("idasiento");
                                        if (idAsientoAnterior && idAsientoAnterior != "") {
                                                if (!flfacturac.iface.eliminarAsiento(idAsientoAnterior))
                                                        return false;
                                        }
                                }
                                if (curRemesa.valueBuffer("tipoconta") == "200") {
                                        if (curRemesa.valueBuffer("cerrada") == false && curRemesa.valueBufferCopy("cerrada") == true){
                                                var idAsientoAnterior:String = curRemesa.valueBufferCopy("idasiento");
                                                if (!flfacturac.iface.eliminarAsiento(idAsientoAnterior)){
                                                        return false;
                                                }

                                        }
                                }
                                break;
                }
        }

        return true;

}

/**\Genera el asiento de la remesa dependiendo del tipo de configuración general en flfacteso_general */
function gestesoreria_generarAsientoRemesaProv(curRemesa:FLSqlCursor):Boolean
{
        var util:FLUtil = new FLUtil();
        if (curRemesa.modeAccess() != curRemesa.Insert && curRemesa.modeAccess() != curRemesa.Edit)
                return true;

        if (curRemesa.valueBuffer("nogenerarasiento")) {
                curRemesa.setNull("idasiento");
                return true;
        }

        var tipoconta:String=curRemesa.valueBuffer("tipoconta");

        /*Solo existen asientos asociados a la remesa en tipo de contabilidad indirecta*/
        if (tipoconta == "100"){
                curRemesa.setNull("idasiento");
                return true;
        }

        /*En tipo de contabilidad indirecta solo se hace el asiento cuando la remesa está cerrada*/
        if (curRemesa.valueBuffer("cerrada") == false){
                curRemesa.setNull("idasiento");
                return true;
        }

        var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
        var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(curRemesa.valueBuffer("fecha"), codEjercicio, "remesasprov");
        if (!datosDoc.ok) return false;

        if (datosDoc.modificaciones == true) {
                codEjercicio = datosDoc.codEjercicio;
                curRemesa.setValueBuffer("fecha", datosDoc.fecha);
        }

        var datosAsiento:Array = [];
        var valoresDefecto:Array;
        valoresDefecto["codejercicio"] = codEjercicio;
        valoresDefecto["coddivisa"] = util.sqlSelect("empresa", "coddivisa", "1 = 1");

        datosAsiento = flfacturac.iface.pub_regenerarAsiento(curRemesa, valoresDefecto);
        if (datosAsiento.error == true) return false;

        var remesa:Array = [];
        remesa["coddivisa"] = curRemesa.valueBuffer("coddivisa");
        remesa["total"] = curRemesa.valueBuffer("total");
        remesa["fecha"] = curRemesa.valueBuffer("fecha");
        remesa["idremesa"] = curRemesa.valueBuffer("idremesa");
        remesa["codcuenta"] = curRemesa.valueBuffer("codcuenta");
        remesa["codsubcuenta"] = curRemesa.valueBuffer("codsubcuenta");
        remesa["idsubcuenta"] = curRemesa.valueBuffer("idsubcuenta");
        remesa["codsubcuentaecgp"] = curRemesa.valueBuffer("codsubcuentaecgp");
        remesa["idsubcuentaecgp"] = curRemesa.valueBuffer("idsubcuentaecgp");
        remesa["tipoconta"] = tipoconta;

        var partidadebe:Array;
        var partidahaber:Array;

        var idRecibos:String = formRecordremesasprov.iface.pub_idRecibosRemesa(curRemesa.valueBuffer("idremesa"));
        var curRecibos:FLSqlCursor = new FLSqlCursor("recibosprov");
        curRecibos.select("idrecibo IN ("+idRecibos+")");
        if (curRecibos.size()<=0) return false;

        var sigue:Boolean = curRecibos.first()
        while (sigue){
                partidadebe = this.iface.cuentaPagoRecibosProv(curRecibos.valueBuffer("idrecibo"),valoresDefecto.codejercicio);

                if (partidadebe["error"]!=0)
                        return false;

                partidadebe["importe"] = curRecibos.valueBuffer("importe");
                partidadebe["concepto"] = "Remesa prov "+curRemesa.valueBuffer("idremesa")+": Recibo "+curRecibos.valueBuffer("codigo")+" - "+curRecibos.valueBuffer("nombreproveedor");
                partidadebe["coddivisa"] = remesa.coddivisa;
                partidadebe["calcularCambio"] = true;
                if (!this.iface.generarPartidasDebe(curRemesa, valoresDefecto, datosAsiento, partidadebe))
                        return false;
                sigue = curRecibos.next()
        }

        partidahaber["codsubcuenta"] = remesa.codsubcuentaecgp;
        partidahaber["idsubcuenta"] = remesa.idsubcuentaecgp;
        partidahaber["importe"] = remesa.total
        partidahaber["concepto"] = "Remesa prov "+curRemesa.valueBuffer("idremesa");
        partidahaber["coddivisa"] = remesa.coddivisa;
        partidahaber["calcularCambio"] = true;
        if (!this.iface.generarPartidasHaber(curRemesa, valoresDefecto, datosAsiento, partidahaber))
                    return false;


        curRemesa.setValueBuffer("idasiento", datosAsiento["idasiento"]);
        if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento["idasiento"]))
                return false;

        return true;
}
function gestesoreria_calcularEstadoRemesaProv(curRemesa:FlSqlCursor):String
{
        var idRemesa = curRemesa.valueBuffer("idremesa");
        if (!idRemesa || idRemesa==""){
                MessageBox.warning("Ha ocurrido un error.\nNo ha sido posible calcular el estado de la remesa",MessageBox.Ok, MessageBox.NoButton);
                return "";
        }

        var util:FLUtil = new FLUtil;

        var cerrada = curRemesa.valueBuffer("cerrada");
        var idPago = util.sqlSelect("pagosdevolremprov","idpagoremprov","idremesa='"+idRemesa+"'");

        var estado:String="Emitida";
        if (cerrada == true) estado = "Cerrada";
        if (idPago && idPago!="") estado = "Pagada";

        return estado;
}
/*idRemesa: identificador de la remesa de proveedor
insertar: Marca si el pago de remesa hay que insertarlo o eliminarlo
return: true si realiza el commit, false en caso de error.*/
function gestesoreria_pagoRemesaAutoProv(idRemesa:String, modo:String):Boolean
{

        if (!idRemesa || idRemesa=="") return false;
        var hoy:Date = new Date();

        var curPR:FLSqlCursor = new FLSqlCursor("pagosdevolremprov");

        if (modo == "Insertar"){
                curPR.setModeAccess(curPR.Insert);
                curPR.refreshBuffer();
                curPR.setValueBuffer("idremesa", idRemesa);
                curPR.setValueBuffer("fecha", hoy);
                curPR.setValueBuffer("tipo", "Pago");
                curPR.setValueBuffer("nogenerarasiento", false);
        }

        if (modo == "Eliminar") {
                curPR.select("idremesa='"+idRemesa+"'");
                if (!curPR.first()) return false;
                curPR.setModeAccess(curPR.Del);
                curPR.refreshBuffer();
        }

        if (!curPR.commitBuffer()){
                return false;
        }

        return true;
}
/** \C Se regenera, si es posible, el asiento contable asociado al pago de una remesa de proveedor
\end */
function gestesoreria_beforeCommit_pagosdevolremprov(curPR:FLSqlCursor):Boolean
{
        var util:FLUtil = new FLUtil();

        /*Verifica que el pago del recibo se pueda realizar, sino, no genera el asiento ni los pagos de los recibos*/
        if (curPR.modeAccess() != curPR.Del){
                var ok = this.iface.fechaPagosDevolProv(curPR.valueBuffer("idremesa"), curPR.valueBuffer("fecha"));
                if (!ok){
                        MessageBox.warning("Hubo un error al generar los pagos de los recibos, el asiento no se puede generar.\nVerifique que las fechas de pago y devolución de los recibos no sean posteriores\n a la fecha del pago de la remesa\n",MessageBox.Ok, MessageBox.NoButton);
                        return false;
                }

                if (!this.iface.gestionarPagosRecibosRemesaProv(curPR.valueBuffer("idremesa"), curPR.valueBuffer("fecha"), "Insertar")){
                        return false;
                }
        }

        if (curPR.valueBuffer("nogenerarasiento")) {
                curPR.setNull("idasiento");
                return true;
        }

        if (!this.iface.__beforeCommit_pagosdevolremprov(curPR)) return false;

        return true;
}
/** \C Se eliminan los recibos vinculados en tipo 100 y se actualiza el estado de la remesa
\end */
function gestesoreria_afterCommit_pagosdevolremprov(curPD:FLSqlCursor):Boolean
{
        var util:FLUtil = new FLUtil();

        if (curPD.modeAccess() == curPD.Del){
                if (!this.iface.gestionarPagosRecibosRemesaProv(curPD.valueBuffer("idremesa"), curPD.valueBuffer("fecha"), "Eliminar")){
                        return false;
                }
        }

        if (!this.iface.__afterCommit_pagosdevolremprov(curPD)) return false;

        var curRem:FLSqlCursor = new FLSqlCursor("remesasprov");
        curRem.select("idremesa='"+curPD.valueBuffer("idremesa")+"'");
        if (!curRem.first()) return false;
        var estado = this.iface.calcularEstadoRemesaProv(curRem);

        curRem.setModeAccess(curRem.Edit);
        curRem.refreshBuffer();
        curRem.setValueBuffer("estado", estado);
        if (!curRem.commitBuffer()) return false;

        return true;
}
/** \Genera o regenera el asiento contable asociado a un pago de una remesa de proveedor
@param  curPR: Cursor posicionado en el pago cuyo asiento se va a regenerar
@return true si la regeneración se realiza correctamente, false en caso contrario
\end */
function gestesoreria_generarAsientoPagoRemesaProv(curPR:FLSqlCursor):Boolean
{
        var util:FLUtil = new FLUtil();
        if (curPR.modeAccess() != curPR.Insert && curPR.modeAccess() != curPR.Edit)
                return true;

        if (curPR.valueBuffer("nogenerarasiento")) {
                curPR.setNull("idasiento");
                return true;
        }

        /*Solo se hace el asiento de pago cuando la remesa está cerrada*/
        var cerrada = util.sqlSelect("remesasprov","cerrada","idremesa='"+curPR.valueBuffer("idremesa")+"'");

        if (cerrada == false) {
                curPR.setNull("idasiento");
                return false;
        }

        if (curPR.valueBuffer("tipo") != "Pago")
                return false;

        var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
        var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(curPR.valueBuffer("fecha"), codEjercicio, "pagosdevolremprov");
        if (!datosDoc.ok)
                return false;
        if (datosDoc.modificaciones == true) {
                codEjercicio = datosDoc.codEjercicio;
                curPR.setValueBuffer("fecha", datosDoc.fecha);
        }

        var datosAsiento:Array = [];
        var valoresDefecto:Array;
        valoresDefecto["codejercicio"] = codEjercicio;
        valoresDefecto["coddivisa"] = util.sqlSelect("empresa", "coddivisa", "1 = 1");

        var remesa:Array = flfactppal.iface.pub_ejecutarQry("remesasprov", "coddivisa,total,fecha,idremesa,codcuenta,codsubcuenta,idsubcuenta,codsubcuentaecgp,idsubcuentaecgp,tipoconta", "idremesa = " + curPR.valueBuffer("idremesa"));
        if (remesa.result != 1)
            return false;

        datosAsiento = flfacturac.iface.pub_regenerarAsiento(curPR, valoresDefecto);
        if (datosAsiento.error == true)
                return false;

        var partidadebe:Array;
        var partidahaber:Array;
        var tipoconta:String = remesa["tipoconta"];

        /*La partida al haber es la misma en todos los casos de tipoconta de la remesa*/
        partidahaber["codsubcuenta"] = remesa["codsubcuenta"];
        partidahaber["idsubcuenta"] = remesa["idsubcuenta"];
        partidahaber["importe"] = remesa["total"];
        partidahaber["concepto"]="Pago Remesa prov "+curPR.valueBuffer("idremesa");
        partidahaber["coddivisa"] = remesa["coddivisa"];
        partidahaber["calcularCambio"] = true;
        if (!this.iface.generarPartidasHaber(curPR, valoresDefecto, datosAsiento, partidahaber))
               return false;

        /*La partida al debe depende del tipoconta de la remesa*/
        if (tipoconta == "200") {
                partidadebe["codsubcuenta"] = remesa.codsubcuentaecgp;
                partidadebe["idsubcuenta"] = remesa.idsubcuentaecgp;
                partidadebe["importe"] = remesa.total
                partidadebe["concepto"] = "Pago Remesa prov "+curPR.valueBuffer("idremesa");
                partidadebe["coddivisa"] = remesa.coddivisa;
                partidadebe["calcularCambio"] = true;
                if (!this.iface.generarPartidasDebe(curPR, valoresDefecto, datosAsiento, partidadebe))
                            return false;

        }else if (tipoconta == "100") {
                var idRecibos:String = formRecordremesasprov.iface.pub_idRecibosRemesa(remesa["idremesa"]);
                var curRecibos:FLSqlCursor = new FLSqlCursor("recibosprov");
                curRecibos.select("idrecibo IN ("+idRecibos+")");
                if (curRecibos.size()<=0)
                        return false;

                var sigue:Boolean=curRecibos.first()
                while (sigue){
                        partidadebe = this.iface.cuentaPagoRecibosProv(curRecibos.valueBuffer("idrecibo"),valoresDefecto.codejercicio);

                        if (partidadebe.error!=0)
                                return false;

                        partidadebe["importe"]=curRecibos.valueBuffer("importe");
                        partidadebe["concepto"]="Pago Remesa prov "+curPR.valueBuffer("idremesa")+": Recibo "+curRecibos.valueBuffer("codigo")+" - "+curRecibos.valueBuffer("nombreproveedor");
                        partidadebe["coddivisa"] = remesa["coddivisa"];
                        partidadebe["calcularCambio"] = true;

                        if (!this.iface.generarPartidasDebe(curPR, valoresDefecto, datosAsiento, partidadebe))
                                return false;

                        sigue=curRecibos.next()
                }
        }

        curPR.setValueBuffer("idasiento", datosAsiento.idasiento);
        if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento))
                return false;

        return true;
}
/** \C Inserta o elimina los pagos de recibos asociados a una remesa con tipoconta 100*/
function gestesoreria_gestionarPagosRecibosRemesaProv(idRemesa:String, fecha:Date, modo:String):Boolean
{
        var util:FLUtil = new FLUtil();
        var idRecibos:String = formRecordremesasprov.iface.pub_idRecibosRemesa(idRemesa);
        var curRecibos:FLSqlCursor = new FLSqlCursor("recibosprov");
        curRecibos.select("idrecibo IN ("+idRecibos+")");
        if (curRecibos.size()<=0)
                return false;


        /*Inserta los pagos y deja los recibos en estado Pagado*/
        if (modo == "Insertar"){
                var sigue:Boolean=curRecibos.first()
                while (sigue){
                        var pago:Boolean = false;
                        var curPagosDevol:FLSqlCursor = new FLSqlCursor("pagosdevolprov");                        curPagosDevol.select("idrecibo = " + curRecibos.valueBuffer("idrecibo") + " ORDER BY fecha, idpagodevol");
                        curPagosDevol.last()
                        if (curPagosDevol.valueBuffer("tipo") == "Pago") pago=true;
                        if (pago) util.sqlDelete("pagosdevolprov","idpagodevol='"+curPagosDevol.valueBuffer("idpagodevol")+"'");

                        var noGenAsiento=true;

                        var remesa:Array= flfactppal.iface.pub_ejecutarQry("remesasprov", "tipoconta,codcuenta,codsubcuenta,idsubcuenta,codsubcuentaecgp,idsubcuentaecgp,idremesa", "idremesa='"+idRemesa+"'");

                        if (!this.iface.generarPagoRecibosProv(curRecibos.valueBuffer("idrecibo"),remesa,fecha,noGenAsiento))
                                return false;

                        var estado = "Pagado";

                        curRecibos.setActivatedCheckIntegrity(false);
                        curRecibos.setModeAccess(curRecibos.Edit);
                        curRecibos.refreshBuffer();
                        curRecibos.setValueBuffer("estado", estado);
                        curRecibos.commitBuffer();

                        sigue=curRecibos.next()
                }
        }

        /*Elimina los pagos y deja los recibos en estado Remesado*/
        if (modo == "Eliminar"){
                var qryRecibos1:FLSqlQuery = new FLSqlQuery;
                qryRecibos1.setTablesList("recibosprov");
                qryRecibos1.setSelect("idrecibo");
                qryRecibos1.setFrom("recibosprov");
                qryRecibos1.setWhere("idrecibo IN ("+idRecibos+") AND estado<>'Pagado'");
                if (!qryRecibos1.exec())
                    return false;

                if (qryRecibos1.size()>0){
                   MessageBox.warning("No se puede eliminar el pago de la remesa, uno o mas recibos vinculados tienen estado diferente de pagado",MessageBox.Ok, MessageBox.NoButton);
                            return false;
                }

                var qryRecibos2:FLSqlQuery = new FLSqlQuery;
                qryRecibos2.setTablesList("recibosprov");
                qryRecibos2.setSelect("idrecibo");
                qryRecibos2.setFrom("recibosprov");
                qryRecibos2.setWhere("idrecibo IN ("+idRecibos+") AND estado='Pagado'");
                if (!qryRecibos2.exec())
                    return false;

                while (qryRecibos2.next()){
                        var curPagoDevol:FLSqlCursor = new FLSqlCursor("pagosdevolprov");
                        curPagoDevol.select("idrecibo = '" + qryRecibos2.value("idrecibo") + "' ORDER BY fecha, idpagodevol");
                        if (!curPagoDevol.last()) return false;
                        if (curPagoDevol.valueBuffer("idremesa") != idRemesa){
                                MessageBox.warning("No se puede eliminar el pago de la remesa, uno o mas recibos vinculados tienen pagos o devoluciones posteriores",MessageBox.Ok, MessageBox.NoButton);
                                return false;
                        }
                }

                if (!util.sqlDelete("pagosdevolprov","idremesa='"+idRemesa+"'")) return false;

                var sigue:Boolean=curRecibos.first()
                while (sigue){
                        curRecibos.setModeAccess(curRecibos.Edit);
                        curRecibos.refreshBuffer();
                        curRecibos.setValueBuffer("estado","Remesado");
                        if (!curRecibos.commitBuffer())
                                return false;
                        sigue=curRecibos.next();
                }
        }

        return true;
}
/**\Genera un pago en la tabla pagosdevolprov cuando el recibo esta asociado a una Remesa*/
function gestesoreria_generarPagoRecibosProv(idRecibo:String,remesa:Array,fecha:Date,genAsiento:Boolean):Boolean
{
        var util:FLUtil = new FLUtil();

        /*comprueba que la fecha sea igual o superior a la fecha del ultimo pago o devolución*/
        var pdfecha = util.sqlSelect("pagosdevolprov","fecha","idrecibo="+idRecibo+" ORDER BY fecha DESC");
        if (pdfecha && pdfecha!=""){
            if (util.daysTo(pdfecha, fecha) < 0){
                return false;
            }
        }

        if(!remesa["idremesa"] || remesa["idremesa"]=="") return false;

        var datosConta:Array = this.iface.datosContaPagoDevolProv(remesa, idRecibo);
        if (datosConta["error"] != 0){
            return false;
        }

        var datosCuentaEmp:Array = flfactppal.iface.pub_ejecutarQry("cuentasbanco","descripcion,ctaentidad,ctaagencia,cuenta","codcuenta='"+remesa["codcuenta"]+"'");
        var dc1:String = util.calcularDC(datosCuentaEmp["ctaentidad"]+datosCuentaEmp["ctaagencia"]);
        var dc2:String = util.calcularDC(datosCuentaEmp["cuenta"]);
        datosCuentaEmp["dc"] = dc1 + dc2;

        var tasaConv:Number = 1;
        var idFactura = util.sqlSelect("recibosprov","idfactura","idrecibo = '"+ idRecibo +"'");
        if (idFactura && idFactura!=""){
                tasaConv = util.sqlSelect("facturasprov","tasaconv","idfactura='"+idFactura+"'");
        }

        curPagosDev = new FLSqlCursor("pagosdevolprov");
        curPagosDev.setModeAccess(curPagosDev.Insert);
        curPagosDev.refreshBuffer();
        curPagosDev.setValueBuffer("idrecibo", idRecibo);
        curPagosDev.setValueBuffer("fecha", fecha);
        curPagosDev.setValueBuffer("tipo", "Pago");
        curPagosDev.setValueBuffer("tasaconv", tasaConv);
        curPagosDev.setValueBuffer("codcuenta", remesa["codcuenta"]);
        curPagosDev.setValueBuffer("descripcion", datosCuentaEmp["descripcion"]);
        curPagosDev.setValueBuffer("ctaentidad", datosCuentaEmp["ctaentidad"]);
        curPagosDev.setValueBuffer("ctaagencia", datosCuentaEmp["ctaagencia"]);
        curPagosDev.setValueBuffer("dc", datosCuentaEmp["dc"]);
        curPagosDev.setValueBuffer("cuenta", datosCuentaEmp["cuenta"]);
        curPagosDev.setValueBuffer("idremesa",remesa["idremesa"]);
        curPagosDev.setValueBuffer("nogenerarasiento",genAsiento);
        curPagosDev.setValueBuffer("idsubcuenta",datosConta["idsubcuenta"]);
        curPagosDev.setValueBuffer("codsubcuenta",datosConta["codsubcuenta"]);
        curPagosDev.setValueBuffer("automatico",true);

        if (!curPagosDev.commitBuffer())
                return false;

        return true;
}

function gestesoreria_datosContaPagoDevolProv(remesa:Array, idRecibo:String):Array
{
    var datos:Array = new Array();
    datos["error"] = 1;

    if (remesa.tipoconta=="200") {
        datos["codsubcuenta"] = remesa["codsubcuentaecgp"];
        datos["idsubcuenta"] = remesa["idsubcuentaecgp"];
        datos["error"] = 0;
    }else if (remesa.tipoconta == "100") {
        datos["codsubcuenta"] = remesa["codsubcuenta"];
        datos["idsubcuenta"] = remesa["idsubcuenta"];
        datos["error"] = 0;
    }

    return datos;
}


function gestesoreria_datosContaPagoDevolProv(remesa:Array, idRecibo:String):Array
{
    var datos:Array = new Array();
    datos["error"] = 1;

    if (remesa.tipoconta=="200") {
        datos["codsubcuenta"] = remesa["codsubcuentaecgp"];
        datos["idsubcuenta"] = remesa["idsubcuentaecgp"];
        datos["error"] = 0;
    }else if (remesa.tipoconta == "100") {
        datos["codsubcuenta"] = remesa["codsubcuenta"];
        datos["idsubcuenta"] = remesa["idsubcuenta"];
        datos["error"] = 0;
    }

    return datos;
}
 /*comprueba que la fecha de la remesa o el pago de remesa sea igual o superior a la fecha del ultimo pago o devolución de los recibos incluidos*/
function gestesoreria_fechaPagosDevolProv(idRemesa:String, fecha:Date):Boolean{

    var util:FLUtil = new FLUtil();
    var idRecibos:String = formRecordremesasprov.iface.pub_idRecibosRemesa(idRemesa);
    var curRecibos:FLSqlCursor = new FLSqlCursor("recibosprov");
    curRecibos.select("idrecibo IN ("+idRecibos+")");
    if (curRecibos.size()<=0)
        return false;

    var n:Number=0;
    var sigue:Boolean=curRecibos.first()
    while (sigue){
        var pdfecha = util.sqlSelect("pagosdevolprov","fecha","idrecibo="+curRecibos.valueBuffer("idrecibo")+" ORDER BY fecha DESC");
        if (pdfecha && pdfecha!=""){
            if (util.daysTo(pdfecha, fecha) < 0)
                n++;
        }
        sigue=curRecibos.next();
    }

    if (n>0) return false;
    if (n<=0) return true;
}
function gestesoreria_afterCommit_pagosdevolprov(curPD:FLSqlCursor):Boolean
{
        var util:FLUtil = new FLUtil();
        if (!this.iface.__afterCommit_pagosdevolprov(curPD)){
                return false;
        }

        if (curPD.valueBuffer("tipo")=="Pago"){
                var idremesa = curPD.valueBuffer("idremesa") ;
                if (idremesa && idremesa!=""){
                        if (curPD.modeAccess() == curPD.Insert){
                                if (!util.sqlUpdate("recibosprov","idremesa","null","idrecibo='"+curPD.valueBuffer("idrecibo")+"'")){
                                        return false;
                                }
                        }else if (curPD.modeAccess() == curPD.Del){
                                if (!util.sqlUpdate("recibosprov","idremesa",idremesa,"idrecibo='"+curPD.valueBuffer("idrecibo")+"'")){
                                        return false;
                                }
                        }
                }
        }
        return true;
}
/** \C Calcular estado para facturas cuando el recibo es o era remesado (antes no se incluia porque hacía referencia a un pago de recibo)
\end */
function gestesoreria_afterCommit_reciboscli(curRecibo:FLSqlCursor):Boolean
{

  var util:FLUtil = new FLUtil;

        if (!this.iface.__afterCommit_reciboscli(curRecibo)) {
                return false;
        }

        switch(curRecibo.modeAccess()) {
                case curRecibo.Edit: {
                        if (curRecibo.valueBuffer("estado") == "Remesado" || curRecibo.valueBufferCopy("estado") == "Remesado") {
                                if (!this.iface.calcularEstadoFacturaCli(curRecibo.valueBuffer("idrecibo")))
                                        return false;
                        }
                break;
                }
        }
        return true;
}
/** \C Si la factura tiene asociado algún recibo Remesado, no será editable
@param  idRecibo: Identificador de uno de los recibos asociados a la factura
@param  idFactura: Identificador de la factura
\end */
function gestesoreria_calcularEstadoFacturaCli(idRecibo:String, idFactura:String):Boolean
{
        var util:FLUtil = new FLUtil();
        if (!idFactura)
                idFactura = util.sqlSelect("reciboscli", "idfactura", "idrecibo = " + idRecibo);

        if (idFactura){
                if (util.sqlSelect("reciboscli", "idrecibo", "idfactura = " + idFactura + " AND estado = 'Remesado'")) {
                        var curFactura:FLSqlCursor = new FLSqlCursor("facturascli");
                        curFactura.select("idfactura = " + idFactura);
                        curFactura.first();
                        curFactura.setUnLock("editable", false);
                } else
                        return this.iface.__calcularEstadoFacturaCli(idRecibo, idFactura);
        }
        return true;
}
/** \C Calcular estado para facturas cuando el recibo es o era remesado (antes no se incluia porque hacía referencia a un pago de recibo)
\end */
function gestesoreria_afterCommit_recibosprov(curRecibo:FLSqlCursor):Boolean
{

  var util:FLUtil = new FLUtil;

        switch(curRecibo.modeAccess()) {
                case curRecibo.Edit: {
                        if (curRecibo.valueBuffer("estado") == "Remesado" || curRecibo.valueBufferCopy("estado") == "Remesado") {
                                if (!this.iface.calcularEstadoFacturaProv(curRecibo.valueBuffer("idrecibo")))
                                        return false;
                        }
                break;
                }
        }
        return true;
}
/** \C Si la factura tiene asociado algún recibo Remesado, no será editable
@param  idRecibo: Identificador de uno de los recibos asociados a la factura
@param  idFactura: Identificador de la factura
\end */
function gestesoreria_calcularEstadoFacturaProv(idRecibo:String, idFactura:String):Boolean
{
        var util:FLUtil = new FLUtil();
        if (!idFactura)
                idFactura = util.sqlSelect("recibosprov", "idfactura", "idrecibo = " + idRecibo);

        if (idFactura){
                if (util.sqlSelect("recibosprov", "idrecibo", "idfactura = " + idFactura + " AND estado = 'Remesado'")) {
                        var curFactura:FLSqlCursor = new FLSqlCursor("facturasprov");
                        curFactura.select("idfactura = " + idFactura);
                        curFactura.first();
                        curFactura.setUnLock("editable", false);
                } else
                        return this.iface.__calcularEstadoFacturaProv(idRecibo, idFactura);
        }
        return true;
}
function gestesoreria_datosReciboCli(curFactura:FLSqlCursor):Boolean
{
        var util:FLUtil = new FLUtil();

        if (!this.iface.__datosReciboCli(curFactura))
                return false;

        var tipopago:String = util.sqlSelect("formaspago","tipopago","codpago='"+curFactura.valueBuffer("codpago")+"'");
        if (tipopago)
                this.iface.curReciboCli.setValueBuffer("tipopago",tipopago);

        this.iface.curReciboCli.setValueBuffer("fechamate", this.iface.curReciboCli.valueBuffer("fechav"));

        return true;
}
function gestesoreria_datosReciboPos(curFactura:FLSqlCursor):Boolean
{
        var util:FLUtil = new FLUtil();

        if (!this.iface.__datosReciboPos(curFactura))
                return false;

        var tipopago:String = util.sqlSelect("formaspago","tipopago","codpago='"+curFactura.valueBuffer("codpago")+"'");
        if (tipopago)
                this.iface.curReciboPos.setValueBuffer("tipopago",tipopago);

        this.iface.curReciboPos.setValueBuffer("fechamate", this.iface.curReciboPos.valueBuffer("fechav"));

        return true;
}

function gestesoreria_datosReciboNeg2(curFactura:FLSqlCursor):Boolean
{
        var util:FLUtil = new FLUtil();

        if (!this.iface.__datosReciboNeg2(curFactura))
                return false;

        var tipopago:String="";
        if (this.iface.curReciboNeg2.valueBuffer("idfactura") && this.iface.curReciboNeg2.valueBuffer("idfactura")!= 0){
            tipopago = util.sqlSelect("formaspago inner join facturascli on formaspago.codpago = facturascli.codpago","tipopago","facturascli.idfactura='"+this.iface.curReciboNeg2.valueBuffer("idfactura")+"'","formaspago,facturascli");
        } else {
            tipopago = this.iface.curReciboNeg.valueBuffer("tipopago");
        }

        if (tipopago)
                this.iface.curReciboNeg2.setValueBuffer("tipopago",tipopago);

        this.iface.curReciboNeg2.setValueBuffer("fechamate", this.iface.curReciboNeg2.valueBuffer("fechav"));
        return true;

}

/** \D Genera, si es necesario, la partida de diferecias positivas o negativas de cambio
@param        curPD: Cursor del pago o devolución
@param        valoresDefecto: Array de valores por defecto (ejercicio, divisa, etc.)
@param        datosAsiento: Array con los datos del asiento
@param        recibo: Array con los datos del recibo asociado al pago
@return        true si la generación es correcta, false en caso contrario
\end */
function gestesoreria_generarPartidasCambioProv(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean
{
        /** \C En el caso de que la divisa sea extranjera y la tasa de cambio haya variado desde el momento de la emisión de la factura, la diferencia se imputará a la correspondiente cuenta de diferencias de cambio.
        \end */

        /*La diferencia con la función de la clase oficial es básicamente que la tasaconv del haber es calculada en una función nueva que depende del origen del recibo: si hay o no factura, si proviene de un agrupado, etc.
        \end */
        if (valoresDefecto.coddivisa == recibo.coddivisa)
                return true;

        var util:FLUtil = new FLUtil();
        var debe:Number = 0;
        var haber:Number = 0;
        var tasaconvDebe:Number = 1;
        var tasaconvHaber:Number = 1;
        var diferenciaCambio:Number = 0;


        tasaconvHaber = curPD.valueBuffer("tasaconv");
        haber = parseFloat(recibo.importe) * parseFloat(tasaconvHaber);
        haber = util.roundFieldValue(haber, "co_partidas", "haber");

        recibo["idrecibo"] = curPD.valueBuffer("idrecibo");
        tasaconvDebe = this.iface.calcularTasaConvCambio(recibo, "recibosprov");
        debe = parseFloat(recibo.importeeuros);
        debe = util.roundFieldValue(debe, "co_partidas", "debe");

        diferenciaCambio = debe - haber;
        if (util.buildNumber(diferenciaCambio, "f", 2) == "0.00" || util.buildNumber(diferenciaCambio, "f", 2) == "-0.00") {
                diferenciaCambio = 0;
                return true;
        }

        diferenciaCambio = util.roundFieldValue(diferenciaCambio, "co_partidas", "haber");

        var ctaDifCambio:Array = [];
        var debeDifCambio:Number = 0;
        var haberDifCambio:Number = 0;
        if (diferenciaCambio > 0) {
                ctaDifCambio = flfacturac.iface.pub_datosCtaEspecial("CAMPOS", valoresDefecto.codejercicio);
                if (ctaDifCambio.error != 0){
                        MessageBox.information("No tiene configurada ninguna subcuenta como tipo especial CAMPOS.\nDebe asociarla en el módulo Principal del área Financiera",MessageBox.Ok,MessageBox.NoButton);
                        return false;
                }
                debeDifCambio = 0;
                haberDifCambio = diferenciaCambio;
        } else {
                ctaDifCambio = flfacturac.iface.pub_datosCtaEspecial("CAMNEG", valoresDefecto.codejercicio);
                if (ctaDifCambio.error != 0){
                        MessageBox.information("No tiene configurada ninguna subcuenta como tipo especial CAMNEG.\nDebe asociarla en el módulo Principal del área Financiera",MessageBox.Ok,MessageBox.NoButton);
                        return false;
                }
                diferenciaCambio = 0 - diferenciaCambio;
                debeDifCambio = diferenciaCambio;
                haberDifCambio = 0;
        }

        /// Esto lo usan algunas extensiones
        if (curPD.valueBuffer("tipo") == "Devolución") {
                var aux:Number = debeDifCambio;
                debeDifCambio = haberDifCambio;
                haberDifCambio = aux;
        }

        var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
        with(curPartida) {
                setModeAccess(curPartida.Insert);
                refreshBuffer();
                try {
                        setValueBuffer("concepto", datosAsiento.concepto);
                } catch (e) {
                        setValueBuffer("concepto", curPD.valueBuffer("tipo") + " recibo prov. " + recibo.codigo + " - " + recibo.nombreproveedor);
                }
                setValueBuffer("idsubcuenta", ctaDifCambio.idsubcuenta);
                setValueBuffer("codsubcuenta", ctaDifCambio.codsubcuenta);
                setValueBuffer("idasiento", datosAsiento.idasiento);
                setValueBuffer("debe", debeDifCambio);
                setValueBuffer("haber", haberDifCambio);
                setValueBuffer("coddivisa", valoresDefecto.coddivisa);
                setValueBuffer("tasaconv", 1);
                setValueBuffer("debeME", 0);
                setValueBuffer("haberME", 0);
        }
        if (!curPartida.commitBuffer())
                return false;

        return true;
}

function gestesoreria_datosReciboAnticipo(curFactura:FLSqlCursor):Boolean
{
        var util:FLUtil = new FLUtil();

        if (!this.iface.__datosReciboAnticipo(curFactura))
                return false;

        var tipopago:String = util.sqlSelect("formaspago","tipopago","codpago='"+curFactura.valueBuffer("codpago")+"'");
        if (tipopago)
                this.iface.curReciboAnticipo.setValueBuffer("tipopago",tipopago);

        this.iface.curReciboAnticipo.setValueBuffer("fechamate", this.iface.curReciboAnticipo.valueBuffer("fechav"));
        return true;

}
//// GESTESORERIA /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition recibosmulticli */
/////////////////////////////////////////////////////////////////
//// RECIBOSMULTICLI ////////////////////////////////////////////

function recibosmulticli_beforeCommit_recibosmulticli(curReciboMultiCli:FLSqlCursor):Boolean
{
    var util:FLUtil = new FLUtil();
        switch (curReciboMultiCli.modeAccess()) {
        case curReciboMultiCli.Del: {

            /**\ Verifica que todos los recibos generados a partir del agrupado esten en estado emitido*/
            var qryRecibos:FLSqlQuery = new FLSqlQuery;
            qryRecibos.setTablesList("reciboscli");
            qryRecibos.setSelect("estado");
            qryRecibos.setFrom("reciboscli");
            qryRecibos.setWhere("codigo LIKE '"+curReciboMultiCli.valueBuffer("codigo")+"%' AND estado!='Emitido'");
            if (!qryRecibos.exec())
                return false;

            if (qryRecibos.size()>0){
                MessageBox.information("No se puede eliminar la agrupación, uno o varios de los recibos generados no tienen el estado emitido",MessageBox.Ok);
                return false;
            }

            /**\ Eliminar recibos generados a partir del recibo agrupado*/
            var qryRecibosGen:FLSqlQuery = new FLSqlQuery;
            qryRecibosGen.setTablesList("reciboscli");
            qryRecibosGen.setSelect("idrecibo,codigo");
            qryRecibosGen.setFrom("reciboscli");
            qryRecibosGen.setWhere("codigo LIKE '"+curReciboMultiCli.valueBuffer("codigo")+"%'");
            if (!qryRecibosGen.exec())
                return false;

            while (qryRecibosGen.next()){
                    if (!util.sqlDelete("reciboscli","idrecibo='"+qryRecibosGen.value("idrecibo")+"'"))
                        return false;
            }

            /**\ Eliminar estado agrupado de recibos asociados*/
            var qryRecibosAgrup:FLSqlQuery = new FLSqlQuery;
            qryRecibosAgrup.setTablesList("reciboscli");
            qryRecibosAgrup.setSelect("idrecibo");
            qryRecibosAgrup.setFrom("reciboscli");
            qryRecibosAgrup.setWhere("idrecibomulti='"+curReciboMultiCli.valueBuffer("idrecibomulti")+"'");
            if (!qryRecibosAgrup.exec())
               return false;

            while (qryRecibosAgrup.next()){
                if (!formRecordrecibosmulticli.iface.excluirDeReciboMulti(qryRecibosAgrup.value("idrecibo")))
                    return false;
            }
        }
    }
        return true;
}
/** \D Actualiza el valor del riesgo alcanzado para un cliente. El valor es la suma de importes de recibos en estado: emitido+devuelto+remesado
    o lo que es lo mismo los recibos que no estan pagados, agrupados o compensados.
@param codCliente: Código del cliente
\end */
function recibosmulticli_actualizarRiesgoCliente(codCliente:String):Boolean
{
        var util:FLUtil = new FLUtil();

        /*Si hay Codcliente, actualiza el riesgo solo para ese cliente*/
    if (codCliente){
        var riesgo:Number = parseFloat( util.sqlSelect( "reciboscli", "SUM(importe)", "estado NOT IN ('Pagado','Agrupado','Compensado') AND codcliente='" + codCliente + "'" ) );
        if (!riesgo || isNaN(riesgo))
                riesgo = 0;

        util.sqlUpdate( "clientes", "riesgoalcanzado", riesgo, "codcliente = '" + codCliente + "'" );

                if (!flfactteso.iface.pub_automataActivado()) {
                var riesgoMax:Number = parseFloat( util.sqlSelect( "clientes", "riesgomax", "codcliente = '" + codCliente + "'" ) );
                if ( riesgo >= riesgoMax && riesgoMax > 0 ) {
                                MessageBox.warning(util.translate("scripts", "El cliente ") + codCliente + util.translate("scripts", " ha superado el riesgo máximo"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
                        }
                }

        /*Si no hay codcliente, actualiza el riesgo para todos los clientes con recibos*/
    }else {
        var q:FLSqlQuery = new FLSqlQuery;
        q.setTablesList("reciboscli,clientes");
            q.setSelect("SUM(reciboscli.importe),clientes.codcliente")
            q.setFrom("reciboscli INNER JOIN clientes ON reciboscli.codcliente=clientes.codcliente")
            q.setWhere("estado NOT IN ('Pagado','Agrupado','Compensado') GROUP BY clientes.codcliente");

        if (!q.exec())
            return false;

        var n:Number =0;
        util.createProgressDialog("Actualizando riesgo para todos los clientes", q.size());
        while (q.next()){
            riesgo=q.value(0);
            CodCliente=q.value(1);
            if (!riesgo || isNaN(riesgo))
                riesgo = 0;
                util.sqlUpdate( "clientes", "riesgoalcanzado", riesgo, "codcliente = '" + codCliente + "'" );
            n++;
                    util.setProgress(n);
            }
            util.destroyProgressDialog();
    }

    return true;
}
/** \C Calcular estado para facturas cuando el recibo es o era agrupado
\end */
function recibosmulticli_afterCommit_reciboscli(curRecibo:FLSqlCursor):Boolean
{

  var util:FLUtil = new FLUtil;

        if (!this.iface.__afterCommit_reciboscli(curRecibo)) {
                return false;
        }

        switch(curRecibo.modeAccess()) {
                case curRecibo.Edit: {
                        if (curRecibo.valueBuffer("estado") == "Agrupado" || curRecibo.valueBufferCopy("estado") == "Agrupado") {
                                if (!this.iface.calcularEstadoFacturaCli(curRecibo.valueBuffer("idrecibo")))
                                        return false;
                        }
                break;
                }
        }
        return true;
}
/** \C Si la factura tiene asociado algún recibo Agrupado, no será editable
@param  idRecibo: Identificador de uno de los recibos asociados a la factura
@param  idFactura: Identificador de la factura
\end */
function recibosmulticli_calcularEstadoFacturaCli(idRecibo:String, idFactura:String):Boolean
{
        var util:FLUtil = new FLUtil();
        if (!idFactura)
                idFactura = util.sqlSelect("reciboscli", "idfactura", "idrecibo = " + idRecibo);

        if (idFactura){
                if (util.sqlSelect("reciboscli", "idrecibo", "idfactura = " + idFactura + " AND estado = 'Agrupado'")) {
                        var curFactura:FLSqlCursor = new FLSqlCursor("facturascli");
                        curFactura.select("idfactura = " + idFactura);
                        curFactura.first();
                        curFactura.setUnLock("editable", false);
                } else
                        return this.iface.__calcularEstadoFacturaCli(idRecibo, idFactura);
        }
        return true;
}
/** \C Devuelve el valor de tasa de cambio (para generar las partidas de cambio) de un recibo procedente de un agrupado
@param recibo: Array con valores del recibo
\end */
function recibosmulticli_calcularTasaConvCambio(recibo:Array, tipo:String):Number
{
        if (recibo["idfactura"] && recibo["idfactura"]!=""){
                return this.iface.__calcularTasaConvCambio(recibo, tipo);
        }

        var tablaMulti:String;
        if (tipo == "reciboscli") tablaMulti = "recibosmulticli";
        else if (tipo == "recibosprov") tablaMulti = "recibosmultiprov";

        var util:FLUtil = new FLUtil();
        var tasaConv:Number = 1;
        var convMulti = util.sqlSelect(tablaMulti,"tasaconv","codigo='"+recibo["codigo"].left(12)+"'");
        if (convMulti && convMulti!=""){
                tasaConv = parseFloat(convMulti);
        }

        return tasaConv;
}
//// RECIBOSMULTICLI ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition recibosmultiprov */
/////////////////////////////////////////////////////////////////
//// RECIBOSMULTIPROV////////////////////////////////////////////

function recibosmultiprov_beforeCommit_recibosmultiprov(curReciboMultiProv:FLSqlCursor):Boolean
{
    var util:FLUtil = new FLUtil();
        switch (curReciboMultiProv.modeAccess()) {
        case curReciboMultiProv.Del: {

            /**\ Verifica que todos los recibos generados a partir del agrupado esten en estado emitido*/
            var qryRecibos:FLSqlQuery = new FLSqlQuery;
            qryRecibos.setTablesList("recibosprov");
            qryRecibos.setSelect("estado");
            qryRecibos.setFrom("recibosprov");
            qryRecibos.setWhere("codigo LIKE '"+curReciboMultiProv.valueBuffer("codigo")+"%' AND estado!='Emitido'");
            if (!qryRecibos.exec())
                return false;

            if (qryRecibos.size()>0){
                MessageBox.information("No se puede eliminar la agrupación, uno o varios de los recibos generados no tienen el estado emitido",MessageBox.Ok);
                return false;
            }

            /**\ Eliminar recibos generados a partir del recibo agrupado*/
            var qryRecibosGen:FLSqlQuery = new FLSqlQuery;
            qryRecibosGen.setTablesList("recibosprov");
            qryRecibosGen.setSelect("idrecibo,codigo");
            qryRecibosGen.setFrom("recibosprov");
            qryRecibosGen.setWhere("codigo LIKE '"+curReciboMultiProv.valueBuffer("codigo")+"%'");
            if (!qryRecibosGen.exec())
                return false;

            while (qryRecibosGen.next()){
                    if (!util.sqlDelete("recibosprov","idrecibo='"+qryRecibosGen.value("idrecibo")+"'"))
                        return false;
            }

            /**\ Eliminar estado agrupado de recibos asociados*/
            var qryRecibosAgrup:FLSqlQuery = new FLSqlQuery;
            qryRecibosAgrup.setTablesList("recibosprov");
            qryRecibosAgrup.setSelect("idrecibo");
            qryRecibosAgrup.setFrom("recibosprov");
            qryRecibosAgrup.setWhere("idrecibomulti='"+curReciboMultiProv.valueBuffer("idrecibomulti")+"'");
            if (!qryRecibosAgrup.exec())
               return false;

            while (qryRecibosAgrup.next()){
                if (!formRecordrecibosmultiprov.iface.excluirDeReciboMulti(qryRecibosAgrup.value("idrecibo")))
                    return false;
            }
        }
    }
        return true;
}
/** \C Calcular estado para facturas cuando el recibo es o era agrupado
\end */
function recibosmultiprov_afterCommit_recibosprov(curRecibo:FLSqlCursor):Boolean
{
        if (!this.iface.__afterCommit_recibosprov(curRecibo)) {
                return false;
        }

        var util:FLUtil = new FLUtil;

        switch(curRecibo.modeAccess()) {
                case curRecibo.Edit: {
                        if (curRecibo.valueBuffer("estado") == "Agrupado" || curRecibo.valueBufferCopy("estado") == "Agrupado") {
                                if (!this.iface.calcularEstadoFacturaProv(curRecibo.valueBuffer("idrecibo")))
                                        return false;
                        }
                break;
                }
        }
        return true;
}
/** \C Si la factura tiene asociado algún recibo Agrupado, no será editable
@param  idRecibo: Identificador de uno de los recibos asociados a la factura
@param  idFactura: Identificador de la factura
\end */
function recibosmultiprov_calcularEstadoFacturaProv(idRecibo:String, idFactura:String):Boolean
{
        var util:FLUtil = new FLUtil();
        if (!idFactura)
                idFactura = util.sqlSelect("recibosprov", "idfactura", "idrecibo = " + idRecibo);

        if (idFactura){
                if (util.sqlSelect("recibosprov", "idrecibo", "idfactura = " + idFactura + " AND estado = 'Agrupado'")) {
                        var curFactura:FLSqlCursor = new FLSqlCursor("facturasprov");
                        curFactura.select("idfactura = " + idFactura);
                        curFactura.first();
                        curFactura.setUnLock("editable", false);
                } else
                        return this.iface.__calcularEstadoFacturaProv(idRecibo, idFactura);
        }

        return true;
}
//// RECIBOSMULTIPROV ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////
//// RECIBOSMANUALES ////////////////////////////////////////////

function recibosmanuales_beforeCommit_reciboscli(curR:FLSqlCursor):Boolean
{
    if(!this.iface.__beforeCommit_reciboscli(curR))
        return false;

    var util:FLUtil = new FLUtil();
    if (curR.modeAccess()==curR.Insert){
        var codserie = curR.valueBuffer("codserie");
        if (!codserie){
            MessageBox.warning(util.translate("scripts", "Para generar el código del recibo actual es necesario seleccionar la serie"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
            return false;
        }
        if (!curR.valueBuffer("codigo") ||curR.valueBuffer("codigo")==0){
            curR.setValueBuffer("codigo",formRecordreciboscli.iface.generarCodigo(curR.valueBuffer("codejercicio"),curR.valueBuffer("codserie"),curR.valueBuffer("idFactura")));
        }
    }

    return true;
}
/*Solo calcula el estado de la factura si existe un idfactura (en recibos manuales efectivamente no existe idfactura)*/
function recibosmanuales_calcularEstadoFacturaCli(idRecibo:String, idFactura:String):Boolean
{
    var util:FLUtil = new FLUtil();
    if (!idFactura)
        idFactura = util.sqlSelect("reciboscli", "idfactura", "idrecibo = " + idRecibo);

    if(idFactura){
        return this.iface.__calcularEstadoFacturaCli(idRecibo, idFactura);
    }
    return true;

}
function recibosmanuales_beforeCommit_recibosprov(curR:FLSqlCursor):Boolean
{
    var util:FLUtil = new FLUtil();
    if (curR.modeAccess()==curR.Insert){
        var codserie = curR.valueBuffer("codserie");
        if (!codserie){
            MessageBox.warning(util.translate("scripts", "Para generar el código del recibo actual es necesario seleccionar la serie"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
            return false;
        }
        if (!curR.valueBuffer("codigo") ||curR.valueBuffer("codigo")==0){
            curR.setValueBuffer("codigo",formRecordrecibosprov.iface.generarCodigo(curR.valueBuffer("codejercicio"),curR.valueBuffer("codserie"),curR.valueBuffer("idFactura")));
        }
    }
    return true;
}
/*Solo calcula el estado de la factura si existe un idfactura (en recibos manuales efectivamente no existe idfactura)*/
function recibosmanuales_calcularEstadoFacturaProv(idRecibo:String, idFactura:String):Boolean
{
    var util:FLUtil = new FLUtil();
    if (!idFactura)
        idFactura = util.sqlSelect("recibosprov", "idfactura", "idrecibo = " + idRecibo);

    if(idFactura){
        return this.iface.__calcularEstadoFacturaProv(idRecibo, idFactura);
    }
    return true;

}
/** \C Devuelve el valor de tasa de cambio (para generar las partidas de cambio) de un recibo procedente de un recibo manual
@param recibo: Array con valores del recibo
\end */
function recibosmanuales_calcularTasaConvCambio(recibo:Array, tipo:String):Number
{
        var util:FLUtil = new FLUtil();
        var automatico = util.sqlSelect(tipo,"automatico","idrecibo='"+recibo["idrecibo"]+"'");

        if(automatico==true){
                return this.iface.__calcularTasaConvCambio(recibo, tipo);
        }

        var tasaConv:Number = 1;
        var convRecibo = util.sqlSelect(tipo,"tasaconv","idrecibo='"+recibo["idrecibo"]+"'");
        if (convRecibo && convRecibo!=""){
                tasaConv = parseFloat(convRecibo);
        }

        return tasaConv;

}

function recibosmanuales_datosReciboCli(curFactura:FLSqlCursor):Boolean
{
        if (!this.iface.__datosReciboCli(curFactura))
                return false;

        this.iface.curReciboCli.setValueBuffer("codserie", curFactura.valueBuffer("codserie"));
        this.iface.curReciboCli.setValueBuffer("codejercicio", curFactura.valueBuffer("codejercicio"));
        this.iface.curReciboCli.setValueBuffer("tasaconv",curFactura.valueBuffer("tasaconv") );
        this.iface.curReciboCli.setValueBuffer("automatico", true);

        return true;
}

/*La diferencia con la función original es que al crear el reciboNeg2 puede haber o no factura y de ello dependen datos como la tasaconv y el numrecibo*/
function recibosmanuales_compensarReciboCli(idRecibo:String, curFactura:FLSqlCursor, sinCompensar:Number):Number
{
    var util:FLUtil = new FLUtil();

    var compPositivo:Boolean = (sinCompensar >= 0);

    if (!this.iface.curReciboNeg) {
        this.iface.curReciboNeg = new FLSqlCursor("reciboscli");
    }
    this.iface.curReciboNeg.select("idrecibo = " + idRecibo);
    if (!this.iface.curReciboNeg.first()) {
        return false;
    }
    this.iface.curReciboNeg.setModeAccess(this.iface.curReciboNeg.Edit);
    if (!this.iface.curReciboNeg.refreshBuffer()) {
        return false;
    }
    var importeNeg:Number = parseFloat(this.iface.curReciboNeg.valueBuffer("importe"));
    var importeComp:Number;
    if (compPositivo) {
        if ((sinCompensar + importeNeg) >= 0) {
            importeComp = importeNeg * -1;
        } else {
            importeComp = sinCompensar;
        }
    } else {
        if ((sinCompensar + importeNeg) <= 0) {
            importeComp = importeNeg * -1;
        } else {
            importeComp = sinCompensar;
        }
    }

    var importeRecibo:Number;
    var importeReciboEuros:Number;

    var numReciboPos:Number = parseFloat(util.sqlSelect("reciboscli", "numero", "idfactura = " + curFactura.valueBuffer("idfactura") + " ORDER BY numero DESC"));
    if (!numReciboPos) numReciboPos = 0;
    numReciboPos++;

    var tasaConvPos:Number = parseFloat(curFactura.valueBuffer("tasaconv"));
    var moneda:String = util.sqlSelect("divisas", "descripcion", "coddivisa = '" + curFactura.valueBuffer("coddivisa") + "'");
    var diasAplazado:Number = util.sqlSelect("plazos", "dias", "codpago = '" + curFactura.valueBuffer("codpago") + "' ORDER BY dias");
    if (isNaN(diasAplazado)) {
        diasAplazado = 0;
    }

    var fechaVencimiento = this.iface.calcFechaVencimientoCli(curFactura, 1, diasAplazado);
    if (!fechaVencimiento) {
        fechaVencimiento = curFactura.valueBuffer("fecha");
    }

    if (!this.iface.curReciboPos) {
        this.iface.curReciboPos = new FLSqlCursor("reciboscli");
    }

    this.iface.curReciboPos.setModeAccess(this.iface.curReciboPos.Insert);
    this.iface.curReciboPos.refreshBuffer()
    this.iface.curReciboPos.setValueBuffer("numero", numReciboPos);
    this.iface.curReciboPos.setValueBuffer("idfactura", curFactura.valueBuffer("idFactura"));
    this.iface.curReciboPos.setValueBuffer("codserie", curFactura.valueBuffer("codserie"));
    this.iface.curReciboPos.setValueBuffer("importe", importeComp);
    this.iface.curReciboPos.setValueBuffer("importeeuros", importeComp * tasaConvPos);
    this.iface.curReciboPos.setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
    this.iface.curReciboPos.setValueBuffer("codigo", curFactura.valueBuffer("codigo") + "-" + flfacturac.iface.pub_cerosIzquierda(numReciboPos, 2));
    this.iface.curReciboPos.setValueBuffer("codcliente", curFactura.valueBuffer("codcliente"));
    this.iface.curReciboPos.setValueBuffer("nombrecliente", curFactura.valueBuffer("nombrecliente"));
    this.iface.curReciboPos.setValueBuffer("cifnif", curFactura.valueBuffer("cifnif"));
    this.iface.curReciboPos.setValueBuffer("coddir", curFactura.valueBuffer("coddir"));
    this.iface.curReciboPos.setValueBuffer("direccion", curFactura.valueBuffer("direccion"));
    this.iface.curReciboPos.setValueBuffer("codpostal", curFactura.valueBuffer("codpostal"));
    this.iface.curReciboPos.setValueBuffer("ciudad", curFactura.valueBuffer("ciudad"));
    this.iface.curReciboPos.setValueBuffer("provincia", curFactura.valueBuffer("provincia"));
    this.iface.curReciboPos.setValueBuffer("codpais", curFactura.valueBuffer("codpais"));
    this.iface.curReciboPos.setValueBuffer("fecha", curFactura.valueBuffer("fecha"));
    this.iface.curReciboPos.setValueBuffer("fechav", curFactura.valueBuffer("fecha"));
    this.iface.curReciboPos.setValueBuffer("estado", "Compensado");
    this.iface.curReciboPos.setValueBuffer("texto", util.enLetraMoneda(importeComp, moneda));
    this.iface.curReciboPos.setValueBuffer("idrecibocomp", this.iface.curReciboNeg.valueBuffer("idrecibo"));

    if (!this.iface.datosReciboPos(curFactura)) {
        return -1;
    }
    if (!this.iface.curReciboPos.commitBuffer()) {
        return -1;
    }
    var idReciboPos:String = this.iface.curReciboPos.valueBuffer("idrecibo");

    if ((compPositivo && (sinCompensar + importeNeg) >= 0) || (!compPositivo && (sinCompensar + importeNeg) <= 0)) {
        this.iface.curReciboNeg.setValueBuffer("estado", "Compensado");
        this.iface.curReciboNeg.setValueBuffer("idrecibocomp", idReciboPos);
        if (!this.iface.curReciboNeg.commitBuffer()) {
                return -1;
        }
        sinCompensar += importeNeg;

    } else {
        var tasaConvNeg:Number = parseFloat(this.iface.curReciboNeg.valueBuffer("tasaconv"));
        this.iface.curReciboNeg.setValueBuffer("estado", "Compensado");
        this.iface.curReciboNeg.setValueBuffer("idrecibocomp", idReciboPos);
        this.iface.curReciboNeg.setValueBuffer("importe", (importeComp * -1));
        this.iface.curReciboNeg.setValueBuffer("importeeuros", (importeComp * tasaConvNeg * -1));
        this.iface.curReciboNeg.setValueBuffer("texto", util.enLetraMoneda((importeComp * -1), moneda));

        if (!this.iface.curReciboNeg.commitBuffer()) {
            return -1;
        }

        var numReciboNeg2:Number;
        var idFacturaNeg2 = this.iface.curReciboNeg.valueBuffer("idfactura");
        if (idFacturaNeg2 && idFacturaNeg2!= 0){
            numReciboNeg2 = parseInt(util.sqlSelect("reciboscli", "numero", "idfactura = " + this.iface.curReciboNeg.valueBuffer("idfactura") + " ORDER BY numero DESC"));
        }else{
            numReciboNeg2 = parseInt(util.sqlSelect("reciboscli", "MAX(numero)","substring(codigo from 0 for 13) = (substring('"+this.iface.curReciboNeg.valueBuffer("codigo")+"' from 0 for 13))"));
        }

        if (!numReciboNeg2) {
            numReciboNeg2 = 0;
        }
        numReciboNeg2++;

        if (!this.iface.curReciboNeg2) {
                this.iface.curReciboNeg2 = new FLSqlCursor("reciboscli");
        }

        this.iface.curReciboNeg2.setModeAccess(this.iface.curReciboNeg2.Insert);
        this.iface.curReciboNeg2.refreshBuffer();
        this.iface.curReciboNeg2.setValueBuffer("numero", numReciboNeg2);
        if (idFacturaNeg2 && idFacturaNeg2!= 0){
              this.iface.curReciboNeg2.setValueBuffer("idfactura", idFacturaNeg2);
        }
        this.iface.curReciboNeg2.setValueBuffer("importe", (sinCompensar + importeNeg));
        this.iface.curReciboNeg2.setValueBuffer("importeeuros", (sinCompensar + importeNeg) * tasaConvNeg);
        this.iface.curReciboNeg2.setValueBuffer("coddivisa", this.iface.curReciboNeg.valueBuffer("coddivisa"));
        this.iface.curReciboNeg2.setValueBuffer("codigo", (this.iface.curReciboNeg.valueBuffer("codigo")).left(12) + "-" + flfacturac.iface.pub_cerosIzquierda(numReciboNeg2, 2));
        this.iface.curReciboNeg2.setValueBuffer("codcliente", this.iface.curReciboNeg.valueBuffer("codcliente"));
        this.iface.curReciboNeg2.setValueBuffer("nombrecliente", this.iface.curReciboNeg.valueBuffer("nombrecliente"));
        this.iface.curReciboNeg2.setValueBuffer("cifnif", this.iface.curReciboNeg.valueBuffer("cifnif"));
        if (this.iface.curReciboNeg.valueBuffer("coddir")){
            this.iface.curReciboNeg2.setValueBuffer("coddir", this.iface.curReciboNeg.valueBuffer("coddir"));
        }
        this.iface.curReciboNeg2.setValueBuffer("direccion", this.iface.curReciboNeg.valueBuffer("direccion"));
        this.iface.curReciboNeg2.setValueBuffer("codpostal", this.iface.curReciboNeg.valueBuffer("codpostal"));
        this.iface.curReciboNeg2.setValueBuffer("ciudad", this.iface.curReciboNeg.valueBuffer("ciudad"));
        this.iface.curReciboNeg2.setValueBuffer("provincia", this.iface.curReciboNeg.valueBuffer("provincia"));
        this.iface.curReciboNeg2.setValueBuffer("codpais", this.iface.curReciboNeg.valueBuffer("codpais"));
        this.iface.curReciboNeg2.setValueBuffer("fecha", this.iface.curReciboNeg.valueBuffer("fecha"));
        this.iface.curReciboNeg2.setValueBuffer("fechav", this.iface.curReciboNeg.valueBuffer("fechav"));
        this.iface.curReciboNeg2.setValueBuffer("estado", "Emitido");
        this.iface.curReciboNeg2.setValueBuffer("texto", util.enLetraMoneda((sinCompensar + importeNeg), moneda));

        if (!this.iface.datosReciboNeg2(curFactura)) {
            return -1;
        }
        if (!this.iface.curReciboNeg2.commitBuffer()) {
            return -1;
        }
        sinCompensar = 0;
    }
    return sinCompensar;
}

function recibosmanuales_datosReciboPos(curFactura:FLSqlCursor):Boolean
{
        if (!this.iface.__datosReciboPos(curFactura))
                return false;

        this.iface.curReciboPos.setValueBuffer("codserie", curFactura.valueBuffer("codserie"));
        this.iface.curReciboPos.setValueBuffer("codejercicio", curFactura.valueBuffer("codejercicio"));
        this.iface.curReciboPos.setValueBuffer("tasaconv",curFactura.valueBuffer("tasaconv") );
        this.iface.curReciboPos.setValueBuffer("automatico", true);

        return true;
}

function recibosmanuales_datosReciboNeg2(curFactura:FLSqlCursor):Boolean
{
        if (!this.iface.__datosReciboNeg2(curFactura))
                return false;

        this.iface.curReciboNeg2.setValueBuffer("codserie", this.iface.curReciboNeg.valueBuffer("codserie"));
        this.iface.curReciboNeg2.setValueBuffer("codejercicio", this.iface.curReciboNeg.valueBuffer("codejercicio"));
        this.iface.curReciboNeg2.setValueBuffer("tasaconv", this.iface.curReciboNeg.valueBuffer("tasaconv"));
        this.iface.curReciboNeg2.setValueBuffer("automatico", this.iface.curReciboNeg.valueBuffer("automatico"));

        return true;

}

function recibosmanuales_datosReciboAnticipo(curFactura:FLSqlCursor):Boolean
{
        if (!this.iface.__datosReciboAnticipo(curFactura))
                return false;

        this.iface.curReciboAnticipo.setValueBuffer("codserie", curFactura.valueBuffer("codserie"));
        this.iface.curReciboAnticipo.setValueBuffer("codejercicio", curFactura.valueBuffer("codejercicio"));
        this.iface.curReciboAnticipo.setValueBuffer("tasaconv",curFactura.valueBuffer("tasaconv") );
        this.iface.curReciboAnticipo.setValueBuffer("automatico", true);

        return true;
}
//// RECIBOSMANUALES ////////////////////////////////////////////
////////////////////////////////////////////////////////////////

/** @class_definition gastosPagosDevol */
/////////////////////////////////////////////////////////////////
//// GASTOSPAGOSDEVOL ///////////////////////////////////////////

/** \C Se regenera, si es posible, el asiento contable asociado al gasto de pago o devolución
\end */
function gastosPagosDevol_beforeCommit_gastospdcli(curG:FLSqlCursor):Boolean
{
    var util:FLUtil = new FLUtil();
    if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada")) {
        if (!this.iface.generarAsientoGastosPD(curG)) {
            return false;
        }
    }

    return true;
}

/** \C Se elimina, si es posible, el asiento contable asociado al gasto de pago o devolución
\end */
function gastosPagosDevol_afterCommit_gastospdcli(curG:FLSqlCursor):Boolean
{

    var util:FLUtil = new FLUtil();
    if (sys.isLoadedModule("flcontppal") == false || util.sqlSelect("empresa", "contintegrada", "1 = 1") == false)
        return true;

    switch (curG.modeAccess()) {
        case curG.Del:
            if (curG.isNull("idasiento")){
                return true;
            }

            var idAsiento:Number = curG.valueBuffer("idasiento");
            if (!flfacturac.iface.pub_eliminarAsiento(idAsiento)){
                return false;
            }
            break;

        case curG.Edit:
            if (curG.valueBuffer("nogenerarasiento")) {
                var idAsientoAnterior:String = curG.valueBufferCopy("idasiento");
                if (idAsientoAnterior && idAsientoAnterior != "") {
                    if (!flfacturac.iface.pub_eliminarAsiento(idAsientoAnterior))
                        return false;
                    }
            }
            break;
    }

    return true;
}

/** \C Se regenera, si es posible, el asiento contable asociado al gasto de pago o devolución
\end */
function gastosPagosDevol_beforeCommit_gastospdprov(curG:FLSqlCursor):Boolean
{
    var util:FLUtil = new FLUtil();
    if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada")) {
        if (!this.iface.generarAsientoGastosPD(curG)) {
            return false;
        }
    }

    return true;
}

/** \C Se elimina, si es posible, el asiento contable asociado al gasto de pago o devolución
\end */
function gastosPagosDevol_afterCommit_gastospdprov(curG:FLSqlCursor):Boolean
{

    var util:FLUtil = new FLUtil();
    if (sys.isLoadedModule("flcontppal") == false || util.sqlSelect("empresa", "contintegrada", "1 = 1") == false)
        return true;

    switch (curG.modeAccess()) {
        case curG.Del:
            if (curG.isNull("idasiento")){
                return true;
            }

            var idAsiento:Number = curG.valueBuffer("idasiento");
            if (!flfacturac.iface.pub_eliminarAsiento(idAsiento)){
                return false;
            }
            break;

        case curG.Edit:
            if (curG.valueBuffer("nogenerarasiento")) {
                var idAsientoAnterior:String = curG.valueBufferCopy("idasiento");
                if (idAsientoAnterior && idAsientoAnterior != "") {
                    if (!flfacturac.iface.pub_eliminarAsiento(idAsientoAnterior))
                        return false;
                    }
            }
            break;
    }

    return true;
}

/**\Genera el asiento de gastos asociado a un pago o devolución de recibos */
function gastosPagosDevol_generarAsientoGastosPD(curG:FLSqlCursor):Boolean {

    var util:FLUtil = new FLUtil();
    if (curG.modeAccess() != curG.Insert && curG.modeAccess() != curG.Edit){
        return true;
    }

    if (curG.valueBuffer("nogenerarasiento")) {
        curG.setNull("idasiento");
        return true;
    }

    var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
    var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(curG.valueBuffer("fecha"), codEjercicio, curG.table());
    if (!datosDoc.ok)
        return false;
    if (datosDoc.modificaciones == true) {
        codEjercicio = datosDoc.codEjercicio;
        curG.setValueBuffer("fecha", datosDoc.fecha);
    }

    var datosAsiento:Array = [];
    var valoresDefecto:Array;
    valoresDefecto["codejercicio"] = codEjercicio;
    valoresDefecto["coddivisa"] = util.sqlSelect("empresa", "coddivisa", "1 = 1");

    datosAsiento = flfacturac.iface.pub_regenerarAsiento(curG, valoresDefecto);
    if (datosAsiento.error == true)
        return false;

    var partidadebe:Array;
    var partidahaber:Array;
    var codSBanco:String;

    switch(curG.table()){
        case "gastospdcli":
            codSBanco = util.sqlSelect("cuentasbanco b INNER JOIN pagosdevolcli p ON b.codcuenta = p.codcuenta","b.codsubcuenta","p.idpagodevol="+curG.valueBuffer("idpagodevol"),"cuentasbanco,pagosdevolcli");
            break;
        case "gastospdprov":
            codSBanco = util.sqlSelect("cuentasbanco b INNER JOIN pagosdevolprov p ON b.codcuenta = p.codcuenta","b.codsubcuenta","p.idpagodevol="+curG.valueBuffer("idpagodevol"),"cuentasbanco,pagosdevolprov");
            break;
    }

    if (!codSBanco){
        return false;
    }

    partidadebe["concepto"]= datosAsiento.concepto;
    partidadebe["coddivisa"] = curG.valueBuffer("coddivisa");
    partidadebe["calcularCambio"] = true;
    partidadebe["codsubcuenta"] = curG.valueBuffer("codsubcuenta");
    partidadebe["idsubcuenta"] = curG.valueBuffer("idsubcuenta");
    partidadebe["importe"] = curG.valueBuffer("importe");

    partidahaber["concepto"]= datosAsiento.concepto;
    partidahaber["coddivisa"] = curG.valueBuffer("coddivisa");
    partidahaber["calcularCambio"] = true;
    partidahaber["codsubcuenta"] = codSBanco;
    partidahaber["idsubcuenta"] = "";
    partidahaber["importe"] = curG.valueBuffer("importe");


    if (!this.iface.generarPartidasDebe(curG, valoresDefecto, datosAsiento, partidadebe))
        return false;

    if (!this.iface.generarPartidasHaber(curG, valoresDefecto, datosAsiento, partidahaber))
        return false;

    curG.setValueBuffer("idasiento", datosAsiento.idasiento);
    if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento)){
        return false;
    }

    return true;
}
//// GASTOSPAGOSDEVOL ///////////////////////////////////////////
////////////////////////////////////////////////////////////////

/** @class_definition gastosPagosMulti */
/////////////////////////////////////////////////////////////////
//// GASTOSPAGOSMULTI ///////////////////////////////////////////

/** \C Se regenera, si es posible, el asiento contable asociado al gasto de pago o devolución
\end */
function gastosPagosMulti_beforeCommit_gastospmcli(curG:FLSqlCursor):Boolean
{
    var util:FLUtil = new FLUtil();
    if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada")) {
        if (!this.iface.generarAsientoGastosPM(curG)) {
            return false;
        }
    }

    return true;
}

/** \C Se elimina, si es posible, el asiento contable asociado al gasto de pago o devolución
\end */
function gastosPagosMulti_afterCommit_gastospmcli(curG:FLSqlCursor):Boolean
{

    var util:FLUtil = new FLUtil();
    if (sys.isLoadedModule("flcontppal") == false || util.sqlSelect("empresa", "contintegrada", "1 = 1") == false)
        return true;

    switch (curG.modeAccess()) {
        case curG.Del:
            if (curG.isNull("idasiento")){
                return true;
            }

            var idAsiento:Number = curG.valueBuffer("idasiento");
            if (!flfacturac.iface.pub_eliminarAsiento(idAsiento)){
                return false;
            }
            break;

        case curG.Edit:
            if (curG.valueBuffer("nogenerarasiento")) {
                var idAsientoAnterior:String = curG.valueBufferCopy("idasiento");
                if (idAsientoAnterior && idAsientoAnterior != "") {
                    if (!flfacturac.iface.pub_eliminarAsiento(idAsientoAnterior))
                        return false;
                    }
            }
            break;
    }

    return true;
}

/** \C Se regenera, si es posible, el asiento contable asociado al gasto de pago o devolución
\end */
function gastosPagosMulti_beforeCommit_gastospmprov(curG:FLSqlCursor):Boolean
{
    var util:FLUtil = new FLUtil();
    if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada")) {
        if (!this.iface.generarAsientoGastosPM(curG)) {
            return false;
        }
    }

    return true;
}

/** \C Se elimina, si es posible, el asiento contable asociado al gasto de pago o devolución
\end */
function gastosPagosMulti_afterCommit_gastospmprov(curG:FLSqlCursor):Boolean
{

    var util:FLUtil = new FLUtil();
    if (sys.isLoadedModule("flcontppal") == false || util.sqlSelect("empresa", "contintegrada", "1 = 1") == false)
        return true;

    switch (curG.modeAccess()) {
        case curG.Del:
            if (curG.isNull("idasiento")){
                return true;
            }

            var idAsiento:Number = curG.valueBuffer("idasiento");
            if (!flfacturac.iface.pub_eliminarAsiento(idAsiento)){
                return false;
            }
            break;

        case curG.Edit:
            if (curG.valueBuffer("nogenerarasiento")) {
                var idAsientoAnterior:String = curG.valueBufferCopy("idasiento");
                if (idAsientoAnterior && idAsientoAnterior != "") {
                    if (!flfacturac.iface.pub_eliminarAsiento(idAsientoAnterior))
                        return false;
                    }
            }
            break;
    }

    return true;
}

/**\Genera el asiento de gastos asociado a un pago múltiple de recibos */
function gastosPagosMulti_generarAsientoGastosPM(curG:FLSqlCursor):Boolean {

    var util:FLUtil = new FLUtil();
    if (curG.modeAccess() != curG.Insert && curG.modeAccess() != curG.Edit){
        return true;
    }

    if (curG.valueBuffer("nogenerarasiento")) {
        curG.setNull("idasiento");
        return true;
    }

    var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
    var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(curG.valueBuffer("fecha"), codEjercicio, curG.table());
    if (!datosDoc.ok)
        return false;
    if (datosDoc.modificaciones == true) {
        codEjercicio = datosDoc.codEjercicio;
        curG.setValueBuffer("fecha", datosDoc.fecha);
    }

    var datosAsiento:Array = [];
    var valoresDefecto:Array;
    valoresDefecto["codejercicio"] = codEjercicio;
    valoresDefecto["coddivisa"] = util.sqlSelect("empresa", "coddivisa", "1 = 1");

    datosAsiento = flfacturac.iface.pub_regenerarAsiento(curG, valoresDefecto);
    if (datosAsiento.error == true)
        return false;

    var partidadebe:Array;
    var partidahaber:Array;
    var codSBanco:String

    switch(curG.table()){
        case "gastospmcli":
            codSBanco = util.sqlSelect("cuentasbanco c INNER JOIN pagosmulticli p ON c.codcuenta=p.codcuenta","c.codsubcuenta","p.idpagomulti = "+curG.valueBuffer("idpagomulti"),"cuentasbanco,pagosmulticli");
            break;
        case "gastospmprov":
            codSBanco = util.sqlSelect("cuentasbanco c INNER JOIN pagosmultiprov p ON c.codcuenta=p.codcuenta","c.codsubcuenta","p.idpagomulti = "+curG.valueBuffer("idpagomulti"),"cuentasbanco,pagosmultiprov");
            break;
    }

    if (!codSBanco) {
        return false;
    }

    partidadebe["concepto"] = datosAsiento.concepto;
    partidadebe["coddivisa"] = curG.valueBuffer("coddivisa");
    partidadebe["calcularCambio"] = true;
    partidadebe["codsubcuenta"] = curG.valueBuffer("codsubcuenta");
    partidadebe["idsubcuenta"] = curG.valueBuffer("idsubcuenta");
    partidadebe["importe"] = curG.valueBuffer("importe");

    partidahaber["concepto"] = datosAsiento.concepto;
    partidahaber["coddivisa"] = curG.valueBuffer("coddivisa");
    partidahaber["calcularCambio"] = true;
    partidahaber["codsubcuenta"] = codSBanco;
    partidahaber["idsubcuenta"] = "";
    partidahaber["importe"] = curG.valueBuffer("importe");


    if (!this.iface.generarPartidasDebe(curG, valoresDefecto, datosAsiento, partidadebe))
        return false;

    if (!this.iface.generarPartidasHaber(curG, valoresDefecto, datosAsiento, partidahaber))
        return false;

    curG.setValueBuffer("idasiento", datosAsiento.idasiento);
    if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento)){
        return false;
    }

    return true;
}
//// GASTOSPAGOSMULTI ///////////////////////////////////////////
////////////////////////////////////////////////////////////////

/** @class_definition gastosPagosRem */
/////////////////////////////////////////////////////////////////
//// GASTOSPAGOSREM ///////////////////////////////////////////

/** \C Se regenera, si es posible, el asiento contable asociado al gasto de pago de remesa
\end */
function gastosPagosRem_beforeCommit_gastospdrem(curG:FLSqlCursor):Boolean
{
    var util:FLUtil = new FLUtil();
    if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada")) {
        if (!this.iface.generarAsientoGastosPRem(curG)) {
            return false;
        }
    }

    return true;
}

/** \C Se elimina, si es posible, el asiento contable asociado al gasto de pago de remesa
\end */
function gastosPagosRem_afterCommit_gastospdrem(curG:FLSqlCursor):Boolean
{

    var util:FLUtil = new FLUtil();
    if (sys.isLoadedModule("flcontppal") == false || util.sqlSelect("empresa", "contintegrada", "1 = 1") == false)
        return true;

    switch (curG.modeAccess()) {
        case curG.Del:
            if (curG.isNull("idasiento")){
                return true;
            }

            var idAsiento:Number = curG.valueBuffer("idasiento");
            if (!flfacturac.iface.pub_eliminarAsiento(idAsiento)){
                return false;
            }
            break;

        case curG.Edit:
            if (curG.valueBuffer("nogenerarasiento")) {
                var idAsientoAnterior:String = curG.valueBufferCopy("idasiento");
                if (idAsientoAnterior && idAsientoAnterior != "") {
                    if (!flfacturac.iface.pub_eliminarAsiento(idAsientoAnterior))
                        return false;
                    }
            }
            break;
    }

    return true;
}

/** \C Se regenera, si es posible, el asiento contable asociado al gasto de pago de remesa de proveedor
\end */
function gastosPagosRem_beforeCommit_gastospdremprov(curG:FLSqlCursor):Boolean
{
    var util:FLUtil = new FLUtil();
    if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada")) {
        if (!this.iface.generarAsientoGastosPRem(curG)) {
            return false;
        }
    }

    return true;
}

/** \C Se elimina, si es posible, el asiento contable asociado al gasto de pago de remesa de proveedor
\end */
function gastosPagosRem_afterCommit_gastospdremprov(curG:FLSqlCursor):Boolean
{

    var util:FLUtil = new FLUtil();
    if (sys.isLoadedModule("flcontppal") == false || util.sqlSelect("empresa", "contintegrada", "1 = 1") == false)
        return true;

    switch (curG.modeAccess()) {
        case curG.Del:
            if (curG.isNull("idasiento")){
                return true;
            }

            var idAsiento:Number = curG.valueBuffer("idasiento");
            if (!flfacturac.iface.pub_eliminarAsiento(idAsiento)){
                return false;
            }
            break;

        case curG.Edit:
            if (curG.valueBuffer("nogenerarasiento")) {
                var idAsientoAnterior:String = curG.valueBufferCopy("idasiento");
                if (idAsientoAnterior && idAsientoAnterior != "") {
                    if (!flfacturac.iface.pub_eliminarAsiento(idAsientoAnterior))
                        return false;
                    }
            }
            break;
    }

    return true;
}

/**\Genera el asiento de gastos asociado a un pago de remesa o de remesa de proveedor */
function gastosPagosRem_generarAsientoGastosPRem(curG:FLSqlCursor):Boolean {

    var util:FLUtil = new FLUtil();
    if (curG.modeAccess() != curG.Insert && curG.modeAccess() != curG.Edit){
        return true;
    }

    if (curG.valueBuffer("nogenerarasiento")) {
        curG.setNull("idasiento");
        return true;
    }

    var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
    var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(curG.valueBuffer("fecha"), codEjercicio, curG.table());
    if (!datosDoc.ok)
        return false;
    if (datosDoc.modificaciones == true) {
        codEjercicio = datosDoc.codEjercicio;
        curG.setValueBuffer("fecha", datosDoc.fecha);
    }

    var datosAsiento:Array = [];
    var valoresDefecto:Array;
    valoresDefecto["codejercicio"] = codEjercicio;
    valoresDefecto["coddivisa"] = util.sqlSelect("empresa", "coddivisa", "1 = 1");

    datosAsiento = flfacturac.iface.pub_regenerarAsiento(curG, valoresDefecto);
    if (datosAsiento.error == true)
        return false;

    var partidadebe:Array;
    var partidahaber:Array;

    var codSRem:String;
    if (curG.table() == "gastospdrem") {
        codSRem = util.sqlSelect("remesas r INNER JOIN pagosdevolrem p ON r.idremesa = p.idremesa","r.codsubcuenta","p.idpagorem="+curG.valueBuffer("idpagorem"),"remesas,pagosdevolrem");
    } else if (curG.table() == "gastospdremprov") {
        codSRem = util.sqlSelect("remesasprov r INNER JOIN pagosdevolremprov p ON r.idremesa = p.idremesa","r.codsubcuenta","p.idpagoremprov="+curG.valueBuffer("idpagoremprov"),"remesas,pagosdevolrem");
    }

    if (!codSRem) {
        return false;
    }

    partidadebe["concepto"]= datosAsiento.concepto;
    partidadebe["coddivisa"] = curG.valueBuffer("coddivisa");
    partidadebe["calcularCambio"] = true;
    partidadebe["codsubcuenta"] = curG.valueBuffer("codsubcuenta");
    partidadebe["idsubcuenta"] = curG.valueBuffer("idsubcuenta");
    partidadebe["importe"] = curG.valueBuffer("importe");

    partidahaber["concepto"]= datosAsiento.concepto;
    partidahaber["coddivisa"] = curG.valueBuffer("coddivisa");
    partidahaber["calcularCambio"] = true;
    partidahaber["codsubcuenta"] = codSRem;
    partidahaber["idsubcuenta"] = "";
    partidahaber["importe"] = curG.valueBuffer("importe");


    if (!this.iface.generarPartidasDebe(curG, valoresDefecto, datosAsiento, partidadebe))
        return false;

    if (!this.iface.generarPartidasHaber(curG, valoresDefecto, datosAsiento, partidahaber))
        return false;

    curG.setValueBuffer("idasiento", datosAsiento.idasiento);
    if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento)){
        return false;
    }

    return true;
}
//// GASTOSPAGOSREM /////////////////////////////////////////////
////////////////////////////////////////////////////////////////

/** @class_definition tiposremprov */
/////////////////////////////////////////////////////////////////
//// TIPOSREMPROV //////////////////////////////////////////////
function tiposremprov_init()
{
    this.iface.__init();
    var util:FLUtil;

     /*Asigna o  verifica el campo tipoconta de fllfacteso_general, valores iniciales para cuentas de riesgo cuando la contabilidad esta cargada e integrada*/
    var contActiva:Boolean = sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada");
    if (!contActiva)
            return;

    var tipoConta34 = util.sqlSelect("factteso_general","tipoconta34","1=1");
    var idECPProv = util.sqlSelect("factteso_general","idctaecpprov","1=1");
    var idECPAcre = util.sqlSelect("factteso_general","idctaecpacre","1=1");

    if (tipoConta34 && tipoConta34!="" && !idECPProv && !idECPAcre){
        var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
        var idECPProv = util.sqlSelect("co_cuentas","idcuenta","codcuenta LIKE '410%' AND codejercicio='"+codEjercicio+"'");
        var idECPAcre = util.sqlSelect("co_cuentas","idcuenta","codcuenta LIKE '411%' AND codejercicio='"+codEjercicio+"'");

        var msnError:String = "Ocurrió un error al inicializar los datos generales de tesorería\n, pueden faltar algunos datos de configuración.\nPor favor acceda manualmente al formulario y configurelos manualmente.";

        if (!idECPProv || !idECPProv) {
            MessageBox.warning(msnError, MessageBox.Ok, MessageBox.NoButton);
            return
        }

        var curFactteso:FLSqlCursor = new FLSqlCursor("factteso_general");
        curFactteso.select();
        if (!curFactteso.first()){
            MessageBox.warning(msnError, MessageBox.Ok, MessageBox.NoButton);
            return;
        }

        curFactteso.setModeAccess(curFactteso.Edit);
        curFactteso.refreshBuffer();
        curFactteso.setValueBuffer("idctaecpprov", idECPProv);
        curFactteso.setValueBuffer("codctaecpprov", util.sqlSelect("co_cuentas","codcuenta","idcuenta="+idECPProv));
        curFactteso.setValueBuffer("idctaecpacre", idECPAcre);
        curFactteso.setValueBuffer("codctaecpacre", util.sqlSelect("co_cuentas","codcuenta","idcuenta="+idECPAcre));

        if (!curFactteso.commitBuffer()){
            MessageBox.warning(msnError, MessageBox.Ok, MessageBox.NoButton);
            return;
        }
    }

    return true;
}

/** \D Informa el tipooperacion segun el tipo de pago
\end */
function tiposremprov_datosReciboProv():Boolean
{
    var util:FLUtil = new FLUtil;
    if (!this.iface.__datosReciboProv()){
        return false;
    }

    if (this.iface.curReciboProv.valueBuffer("tipopago") &&  this.iface.curReciboProv.valueBuffer("tipopago")!="") {
        var tipoOp:String = util.sqlSelect("tipospago","tipooperacion","tipopago='"+this.iface.curReciboProv.valueBuffer("tipopago")+"'");
        if (tipoOp && tipoOp!=""){
            this.iface.curReciboProv.setValueBuffer("tipooperacion", tipoOp);
        }
    }

    return true;
}

function tiposremprov_beforeCommit_remesasprov(curRemesa:FLSqlCursor):Boolean
{

    if (!this.iface.__beforeCommit_remesasprov(curRemesa)){
        return false;
    }

    /** \ Si la contabilidad esta integrada, el tipoconta es de pagare (201) y el cerrada pasa a true: genera asiento de remesa*/
    if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada") && (curRemesa.valueBuffer("tipoconta")=="201") || curRemesa.valueBuffer("tipoconta")=="202") {

        if (curRemesa.valueBuffer("cerrada") == true && curRemesa.valueBufferCopy("cerrada") == false){
                if (this.iface.generarAsientoRemesaProv(curRemesa) == false)
                        return false;
        }

        if (curRemesa.valueBuffer("cerrada") == false && curRemesa.valueBuffer("idasiento") &&  curRemesa.valueBuffer("idasiento")!=""){
                curRemesa.setNull("idasiento");
        }
    }

    return true;
}

/**\Genera el asiento de la remesa dependiendo del tipoConta (configuración general en flfacteso_general y el tipo de remesa) */
function tiposremprov_generarAsientoRemesaProv(curRemesa:FLSqlCursor):Boolean
{
    var tipoConta:String = curRemesa.valueBuffer("tipoconta");
    if (!tipoConta || tipoConta == ""){
        return false;
    }

    if (tipoConta == "100" || tipoConta == "200"){
        return this.iface.__generarAsientoRemesaProv(curRemesa);
    }

    /*Genera el siguiente tipo de asiento para cuando la remesa es de tipo 201 y 202*/
    if (curRemesa.valueBuffer("cerrada") == false){
        curRemesa.setNull("idasiento");
        return true;
    }

    var util:FLUtil = new FLUtil();
    var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
    var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(curRemesa.valueBuffer("fecha"), codEjercicio, "remesasprov");
    if (!datosDoc.ok) return false;

    if (datosDoc.modificaciones == true) {
        codEjercicio = datosDoc.codEjercicio;
        curRemesa.setValueBuffer("fecha", datosDoc.fecha);
    }

    var datosAsiento:Array = [];
    var valoresDefecto:Array;
    valoresDefecto["codejercicio"] = codEjercicio;
    valoresDefecto["coddivisa"] = util.sqlSelect("empresa", "coddivisa", "1 = 1");

    datosAsiento = flfacturac.iface.pub_regenerarAsiento(curRemesa, valoresDefecto);
    if (datosAsiento.error == true) return false;

    var partidadebe:Array;
    var partidahaber:Array;

    var idRecibos:String = formRecordremesasprov.iface.pub_idRecibosRemesa(curRemesa.valueBuffer("idremesa"));
    var curRecibos:FLSqlCursor = new FLSqlCursor("recibosprov");
    curRecibos.select("idrecibo IN ("+idRecibos+")");
    if (curRecibos.size()<=0) {
        return false;
    }

    var sigue:Boolean = curRecibos.first()
    while (sigue){
        partidadebe = this.iface.cuentaPagoRecibosProv(curRecibos.valueBuffer("idrecibo"),valoresDefecto.codejercicio);
        if (partidadebe["error"]!=0){
            return false;
        }

        partidadebe["concepto"] = "Remesa prov "+curRemesa.valueBuffer("idremesa")+": Recibo "+curRecibos.valueBuffer("codigo")+" - "+curRecibos.valueBuffer("nombreproveedor");
        partidadebe["importe"] = curRecibos.valueBuffer("importe");
        partidadebe["importeME"] = curRecibos.valueBuffer("importeeuros");
        partidadebe["coddivisa"] = curRemesa.valueBuffer("coddivisa");
        partidadebe["calcularCambio"] = false;
        partidadebe["tasaConv"] = 1;
        if (!this.iface.generarPartidasDebe(curRemesa, valoresDefecto, datosAsiento, partidadebe)){
            return false;
        }

        var codCuenta:String = "";
        var ctaEsp:String = "";
        if (util.sqlSelect("proveedores","acreedor","codproveedor = '"+curRecibos.valueBuffer("codproveedor")+"'")){
            codCuenta = util.sqlSelect("factteso_general","codctaecpacre","1=1");
            ctaEsp = "ECPACR";
        } else {
            codCuenta = util.sqlSelect("factteso_general","codctaecpprov","1=1");
            ctaEsp = "ECPPRO";
        }
        if (!codCuenta || codCuenta=="") {
            MessageBox.warning("Error, no se encuentran datos de configuración general de tesorería",MessageBox.Ok, MessageBox.NoButton);
            return false;
        }

        partidahaber = flfactppal.iface.pub_datosOtraSubcuentaProveedor(ctaEsp,curRecibos.valueBuffer("codproveedor"),valoresDefecto);
        if (partidahaber["error"]!=0){
            return false;
        }

        partidahaber["concepto"] = "Remesa prov "+curRemesa.valueBuffer("idremesa")+": Recibo "+curRecibos.valueBuffer("codigo")+" - "+curRecibos.valueBuffer("nombreproveedor");
        partidahaber["importe"] = curRecibos.valueBuffer("importe");
        partidahaber["importeME"] = curRecibos.valueBuffer("importeeuros");
        partidahaber["coddivisa"] = curRemesa.valueBuffer("coddivisa");
        partidahaber["calcularCambio"] = false;
        partidahaber["tasaConv"] = 1;
        if (!this.iface.generarPartidasHaber(curRemesa, valoresDefecto, datosAsiento, partidahaber))
                    return false;

        sigue = curRecibos.next();
    }

    curRemesa.setValueBuffer("idasiento", datosAsiento["idasiento"]);
    if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento["idasiento"]))
            return false;

    return true;
}

/** \Genera o regenera el asiento contable asociado a un pago de una remesa de proveedor que depende del tiporem
@param  curPR: Cursor posicionado en el pago cuyo asiento se va a regenerar
@return true si la regeneración se realiza correctamente, false en caso contrario
\end */
function tiposremprov_generarAsientoPagoRemesaProv(curPR:FLSqlCursor):Boolean
{
    var util:FLUtil = new FLUtil();
    var remesa:Array = flfactppal.iface.pub_ejecutarQry("remesasprov", "idremesa,coddivisa,total,codsubcuenta,idsubcuenta,tipoconta,codproveedor,codcuenta", "idremesa = " + curPR.valueBuffer("idremesa"));
    if (remesa.result != 1){
        return false;
    }

    var tipoConta:String = remesa["tipoconta"];

    if (!tipoConta || tipoConta == ""){
        return false;
    }

    if (tipoConta != "201"){
        return this.iface.__generarAsientoPagoRemesaProv(curPR);
    }

    if (curPR.modeAccess() != curPR.Insert && curPR.modeAccess() != curPR.Edit){
        return true;
    }

    if (curPR.valueBuffer("nogenerarasiento")) {
        curPR.setNull("idasiento");
        return true;
    }

    /*Solo se hace el asiento de pago cuando la remesa está cerrada*/
    var cerrada = util.sqlSelect("remesasprov","cerrada","idremesa='"+curPR.valueBuffer("idremesa")+"'");

    if (cerrada == false) {
        curPR.setNull("idasiento");
        return false;
    }

    if (curPR.valueBuffer("tipo") != "Pago") {
        return false;
    }

    var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
    var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(curPR.valueBuffer("fecha"), codEjercicio, "pagosdevolremprov");
    if (!datosDoc.ok)
            return false;
    if (datosDoc.modificaciones == true) {
            codEjercicio = datosDoc.codEjercicio;
            curPR.setValueBuffer("fecha", datosDoc.fecha);
    }

    var datosAsiento:Array = [];
    var valoresDefecto:Array;
    valoresDefecto["codejercicio"] = codEjercicio;
    valoresDefecto["coddivisa"] = util.sqlSelect("empresa", "coddivisa", "1 = 1");

    datosAsiento = flfacturac.iface.pub_regenerarAsiento(curPR, valoresDefecto);
    if (datosAsiento.error == true)
         return false;

    var partidadebe:Array;
    var partidahaber:Array;

    partidahaber["codsubcuenta"] = remesa["codsubcuenta"];
    partidahaber["idsubcuenta"] = remesa["idsubcuenta"];
    partidahaber["importe"] = remesa["total"];
    partidahaber["importeME"] = 0;
    partidahaber["concepto"]="Pago Remesa prov "+curPR.valueBuffer("idremesa");
    partidahaber["coddivisa"] = remesa["coddivisa"];
    partidahaber["calcularCambio"] = false;
    partidahaber["tasaConv"] = 1;
    if (!this.iface.generarPartidasHaber(curPR, valoresDefecto, datosAsiento, partidahaber))
            return false;


    var codCuenta:String = "";
    var ctaEsp:String = "";
    if (util.sqlSelect("proveedores","acreedor","codproveedor = '"+remesa["codproveedor"]+"'")){
        codCuenta = util.sqlSelect("factteso_general","codctaecpacre","1=1");
        ctaEsp = "ECPACR";
    } else {
        codCuenta = util.sqlSelect("factteso_general","codctaecpprov","1=1");
        ctaEsp = "ECPPRO";
    }
    if (!codCuenta || codCuenta=="") {
        MessageBox.warning("Error, no se encuentran datos de configuración general de tesorería",MessageBox.Ok, MessageBox.NoButton);
        return false;
    }

    partidadebe = flfactppal.iface.pub_datosOtraSubcuentaProveedor(ctaEsp,remesa["codproveedor"],valoresDefecto);
    if (partidadebe["error"]!=0){
        return false;
    }

    partidadebe["coddivisa"] = remesa["coddivisa"];
    partidadebe["calcularCambio"] = false;
    partidadebe["tasaConv"] = 1;

    var idRecibos:String = formRecordremesasprov.iface.pub_idRecibosRemesa(curPR.valueBuffer("idremesa"));
    var curRecibos:FLSqlCursor = new FLSqlCursor("recibosprov");
    curRecibos.select("idrecibo IN ("+idRecibos+")");
    if (curRecibos.size()<=0){
        return false;
    }

    var sigue:Boolean = curRecibos.first()
    while (sigue){
        partidadebe["importe"]=curRecibos.valueBuffer("importe");
        partidadebe["importeME"]=0;
        partidadebe["concepto"]="Pago Remesa prov "+curPR.valueBuffer("idremesa")+": Recibo "+curRecibos.valueBuffer("codigo")+" - "+curRecibos.valueBuffer("nombreproveedor");

        if (!this.iface.generarPartidasDebe(curPR, valoresDefecto, datosAsiento, partidadebe)){
            return false;
        }

        var noGenAsiento:Boolean = true;
        sigue=curRecibos.next()
    }


    curPR.setValueBuffer("idasiento", datosAsiento.idasiento);
    if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento))
            return false;

    return true;
}

function tiposremprov_beforeCommit_pagaresemi(curPE:FLSqlCursor):Boolean {

    if (curPE.modeAccess() == curPE.Edit && (curPE.valueBuffer("numero") == "" || curPE.valueBuffer("ci") == "")){
        MessageBox.warning("El número de pagaré es un campo obligatorio",MessageBox.Ok, MessageBox.NoButton);
        return false;
    }

    return true;

}

function tiposremprov_afterCommit_pagaresemi(curPE:FLSqlCursor):Boolean {

    if (curPE.modeAccess() == curPE.Edit && curPE.valueBuffer("numero") != "" && curPE.valueBuffer("ci") != ""){
        if (!this.iface.actualizarDatosPagare(curPE)){
            return false;
        }
    }

    return true;

}

function tiposremprov_actualizarDatosPagare(curPE:FLSqlCursor):Boolean
{

    var datosCuentaEmp:Array = flfactppal.iface.pub_ejecutarQry("cuentasbanco INNER JOIN remesasprov ON cuentasbanco.codcuenta=remesasprov.codcuenta", "cuentasbanco.codcuenta,cuentasbanco.ctaentidad,cuentasbanco.ctaagencia,cuentasbanco.cuenta", "remesasprov.idremesa = " + curPE.valueBuffer("idremesa"),"cuentasbanco,remesasprov");
    if (datosCuentaEmp["result"] != 1) {
        return false;
    }

    var idRecibos:String = formRecordremesasprov.iface.pub_idRecibosRemesa(curPE.valueBuffer("idremesa"));
    var curRecibos:FLSqlCursor = new FLSqlCursor("recibosprov");
    curRecibos.setActivatedCommitActions(false);
    curRecibos.select("idrecibo IN ("+idRecibos+")");
    if (curRecibos.size()<=0){
        return false;
    }

    while (curRecibos.next()){
        curRecibos.setModeAccess(curRecibos.Edit);
        curRecibos.refreshBuffer();
        curRecibos.setValueBuffer("fechav", curPE.valueBuffer("fecha"));
        curRecibos.setValueBuffer("codcuentapago", datosCuentaEmp["cuentasbanco.codcuenta"]);
        curRecibos.setValueBuffer("ctaentidadpago", datosCuentaEmp["cuentasbanco.ctaentidad"]);
        curRecibos.setValueBuffer("ctaagenciapago", datosCuentaEmp["cuentasbanco.ctaagencia"]);
        curRecibos.setValueBuffer("cuentapago", datosCuentaEmp["cuentasbanco.cuenta"]);
        if (!curRecibos.commitBuffer()){
            return false;
        }
    }

    curRecibos.setActivatedCommitActions(true);
    return true;
}


/** \C Se regenera, si es posible, el asiento contable asociado al anticipo de confirming
\end */
function tiposremprov_beforeCommit_anticiposconf(curAC:FLSqlCursor):Boolean
{
    var util:FLUtil = new FLUtil();
    if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada")) {
        if (!this.iface.generarAsientoAnticiposConf(curAC)) {
            return false;
        }
    }

    return true;
}

/** \C Se elimina, si es posible, el asiento contable asociado al anticipo de confirming
\end */
function tiposremprov_afterCommit_anticiposconf(curAC:FLSqlCursor):Boolean
{

    var util:FLUtil = new FLUtil();
    if (sys.isLoadedModule("flcontppal") == false || util.sqlSelect("empresa", "contintegrada", "1 = 1") == false)
        return true;

    switch (curAC.modeAccess()) {
        case curAC.Del:
            if (curAC.isNull("idasiento")){
                return true;
            }

            var idAsiento:Number = curAC.valueBuffer("idasiento");
            if (!flfacturac.iface.pub_eliminarAsiento(idAsiento)){
                return false;
            }
            break;

        case curAC.Edit:
            if (curAC.valueBuffer("nogenerarasiento")) {
                var idAsientoAnterior:String = curAC.valueBufferCopy("idasiento");
                if (idAsientoAnterior && idAsientoAnterior != "") {
                    if (!flfacturac.iface.pub_eliminarAsiento(idAsientoAnterior))
                        return false;
                    }
            }
            break;
    }

    if (!this.iface.calcularEstadoReciboProv(curAC.valueBuffer("idrecibo"))){
        return false;
    }

    return true;
}

/**\Genera el asiento de anticipo de confirming para una remesa de tipo 02 */
function tiposremprov_generarAsientoAnticiposConf(curAC:FLSqlCursor):Boolean {

    var util:FLUtil = new FLUtil();
    if (curAC.modeAccess() != curAC.Insert && curAC.modeAccess() != curAC.Edit){
        return true;
    }

    if (curAC.valueBuffer("nogenerarasiento")) {
        curAC.setNull("idasiento");
        return true;
    }

    var tipoConta = util.sqlSelect("remesasprov","tipoconta","idremesa = "+curAC.valueBuffer("idremesa"));
    if (!tipoConta || tipoConta != "202"){
        return false;
    }

    var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
    var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(curAC.valueBuffer("fecha"), codEjercicio, curAC.table());
    if (!datosDoc.ok)
        return false;
    if (datosDoc.modificaciones == true) {
        codEjercicio = datosDoc.codEjercicio;
        curAC.setValueBuffer("fecha", datosDoc.fecha);
    }

    var datosAsiento:Array = [];
    var valoresDefecto:Array;
    valoresDefecto["codejercicio"] = codEjercicio;
    valoresDefecto["coddivisa"] = util.sqlSelect("empresa", "coddivisa", "1 = 1");

    datosAsiento = flfacturac.iface.pub_regenerarAsiento(curAC, valoresDefecto);
    if (datosAsiento.error == true)
        return false;

    var partidadebe:Array;
    var partidahaber:Array;

    var qryDatos:FLSqlQuery = new FLSqlQuery();
    qryDatos.setTablesList("recibosprov,proveedores");
    qryDatos.setSelect("r.importe,p.codproveedor,p.acreedor");
    qryDatos.setFrom("recibosprov r INNER JOIN proveedores p ON p.codproveedor = r.codproveedor");
    qryDatos.setWhere("r.idrecibo = "+curAC.valueBuffer("idrecibo"));

    if (!qryDatos.exec()){
        debug("error en consulta de datos para asiento de anticipos confirming");
        return false;
    }

    if (!qryDatos.first()){
        debug("error en consulta de datos para asiento de anticipos confirming");
        return false;
    }

    var codCuentaAnt:String;
    var ctaEsp:String = "";
    var acreedor:Boolean = qryDatos.value("p.acreedor");
    if (!acreedor) {
        codCuentaAnt = util.sqlSelect("factteso_general","codctaecpprov","1=1");
        ctaEsp = "ECPPRO";
    } else {
        codCuentaAnt = util.sqlSelect("factteso_general","codctaecpacre","1=1");
        ctaEsp = "ECPACR";
    }

    if (!codCuentaAnt || codCuentaAnt =="") {
        MessageBox.warning("Ocurrio un error al generar el asiento de anticipo de confirming.\n Por favor revise la configuración general de tesorería",MessageBox.Ok, MessageBox.NoButton);
        return false;
    }

    partidadebe = flfactppal.iface.pub_datosOtraSubcuentaProveedor(ctaEsp,qryDatos.value("p.codproveedor"),valoresDefecto);
    if (partidadebe["error"]!=0){
        return false;
    }

    partidadebe["concepto"]= datosAsiento.concepto;
    partidadebe["coddivisa"] =  valoresDefecto["coddivisa"];
    partidadebe["calcularCambio"] = false;
    partidadebe["tasaConv"] = 1;
    partidadebe["importe"] = qryDatos.value("r.importe");
    partidadebe["importeME"] = 0;

    if (!this.iface.generarPartidasDebe(curAC, valoresDefecto, datosAsiento, partidadebe)){
        return false;
    }

    partidahaber["codsubcuenta"] = util.sqlSelect("remesasprov","codsubcuentaecgp","idremesa="+curAC.valueBuffer("idremesa"));
    partidahaber["idsubcuenta"] = util.sqlSelect("remesasprov","idsubcuentaecgp","idremesa="+curAC.valueBuffer("idremesa"));
    partidahaber["concepto"]= datosAsiento.concepto;
    partidahaber["coddivisa"] =  valoresDefecto["coddivisa"];
    partidahaber["calcularCambio"] = false;
    partidahaber["tasaConv"] = 1;
    partidahaber["importe"] = qryDatos.value("r.importe");
    partidahaber["importeME"] = 0;

    if (!this.iface.generarPartidasHaber(curAC, valoresDefecto, datosAsiento, partidahaber))
        return false;

    curAC.setValueBuffer("idasiento", datosAsiento.idasiento);
    if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento)){
        return false;
    }

    return true;
}


function tiposremprov_afterCommit_pagosdevolprov(curPD:FLSqlCursor):Boolean
{
    var util:FLUtil = new FLUtil();
    if (!this.iface.__afterCommit_pagosdevolprov(curPD)){
        return false;
    }

    var idAnticipoConf = util.sqlSelect("anticiposconf","idanticipoconf","idrecibo="+curPD.valueBuffer("idrecibo")+" AND idremesa="+curPD.valueBuffer("idremesa"));

    if (curPD.valueBuffer("tipo") == "Pago" && idAnticipoConf) {
        if (!this.iface.cambiarPtePagoAnticipoConf(idAnticipoConf, curPD.modeAccess())){
            return false;
        }
    }

    if (!this.iface.calcularEstadoReciboProv(curPD.valueBuffer("idrecibo"))){
        return false;
    }

    if (curPD.valueBuffer("tipo") == "Pago" && curPD.valueBuffer("idremesa")) {
        var tipoConta:String = util.sqlSelect("remesasprov","tipoconta","idremesa="+curPD.valueBuffer("idremesa"));
        if (tipoConta == "202") {
            if (!this.iface.cambiarEstadoRemesaProv(curPD.valueBuffer("idremesa"))){
                return false;
            }
        }
    }

    return true;
}

function tiposremprov_cambiarPtePagoAnticipoConf(idAnticipoConf:Number, modoPD:Number):Boolean
{
    var curAnticipoConf:FLSqlCursor = new FLSqlCursor("anticiposconf");
    curAnticipoConf.setActivatedCommitActions(false);
    curAnticipoConf.select("idanticipoconf="+idAnticipoConf);
    if (!curAnticipoConf.first()){
        return false;
    }

    if ((modoPD == 0 || modoPD == 1) && curAnticipoConf.valueBuffer("ptepago") == true) {
        curAnticipoConf.setModeAccess(curAnticipoConf.Edit);
        curAnticipoConf.refreshBuffer();
        curAnticipoConf.setUnLock("ptepago", false);
        if (!curAnticipoConf.commitBuffer()){
            return false;
        }
    }

    if (modoPD == 2 && curAnticipoConf.valueBuffer("ptepago") == false){
        curAnticipoConf.setModeAccess(curPedido.Edit);
        curAnticipoConf.refreshBuffer();
        curAnticipoConf.setUnLock("ptepago", true);
        if (!curAnticipoConf.commitBuffer()){
            return false;
        }
    }

    curAnticipoConf.setActivatedCommitActions(true);
    return true;
}

function tiposremprov_calcularEstadoReciboProv(idRecibo:Number):Boolean{

    var curRecibo = new FLSqlCursor("recibosprov");
    curRecibo.select("idrecibo='"+idRecibo+"'");

    if (curRecibo.first()) {
        curRecibo.setModeAccess(curRecibo.Edit);
        curRecibo.refreshBuffer();
        curRecibo.setValueBuffer("estado",formRecordrecibosprov.iface.pub_obtenerEstado(idRecibo));
    }

    if (!curRecibo.commitBuffer()){
        return false;
    }

    return true;
}

function tiposremprov_datosContaPagoDevolProv(remesa:Array, idrecibo:Number):Array
{
    var util:FLUtil = new FLUtil();
    var datos:Array = new Array();
    datos["error"] = 1;

    if (remesa.tipoconta == "100" || remesa.tipoconta == "201" || remesa.tipoconta=="202") {
        datos["codsubcuenta"] = remesa["codsubcuenta"];
        datos["idsubcuenta"] = remesa["idsubcuenta"];
        datos["error"] = 0;
    } else if (remesa.tipoconta=="200") {
        datos["codsubcuenta"] = remesa["codsubcuentaecgp"];
        datos["idsubcuenta"] = remesa["idsubcuentaecgp"];
        datos["error"] = 0;
    }

    return datos;
}

function tiposremprov_generarAsientoPagoDevolProv(curPD:FLSqlCursor):Boolean
{
    var util:FLUtil = new FLUtil();

    if (curPD.modeAccess() != curPD.Insert && curPD.modeAccess() != curPD.Edit)
        return true;

    var idRemesa:Number;
    var tipoConta:String;
    var idAnticipoConf:Number
    var tipo:String = curPD.valueBuffer("tipo");
    if (tipo == "Pago") {
        idRemesa = curPD.valueBuffer("idremesa");

        if (!idRemesa) {
            return this.iface.__generarAsientoPagoDevolProv(curPD);
        }

        var tipoConta = util.sqlSelect("remesasprov","tipoconta","idremesa="+idRemesa);
        if (!tipoConta) {
            return false;
        }

        if (tipoConta != "202") {
            return this.iface.__generarAsientoPagoDevolProv(curPD);
        }

        idAnticipoConf = util.sqlSelect("anticiposconf","idanticipoconf","idrecibo="+curPD.valueBuffer("idrecibo")+" AND idremesa="+idRemesa);
        if (!idAnticipoConf) {
            return this.iface.__generarAsientoPagoDevolProv(curPD);
        }

    } else {
        idRemesa = util.sqlSelect("pagosdevolprov","idremesa","idrecibo = "+curPD.valueBuffer("idrecibo")+" AND idpagodevol <> "+curPD.valueBuffer("idpagodevol")+" ORDER BY fecha, idpagodevol");
        if (!idRemesa) {
            return this.iface.__generarAsientoPagoDevolProv(curPD);
        }

        tipoConta = util.sqlSelect("remesasprov","tipoconta","idremesa="+idRemesa);
        if (!tipoConta) {
            return false;
        }

        idAnticipoConf = util.sqlSelect("anticiposconf","idanticipoconf","idrecibo="+curPD.valueBuffer("idrecibo")+" AND idremesa="+idRemesa);
    }

    var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
    var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(curPD.valueBuffer("fecha"), codEjercicio, "pagosdevolprov");
    if (!datosDoc.ok)
        return false;
    if (datosDoc.modificaciones == true) {
        codEjercicio = datosDoc.codEjercicio;
        curPD.setValueBuffer("fecha", datosDoc.fecha);
    }

    var datosAsiento:Array = [];
    var valoresDefecto:Array;
    valoresDefecto["codejercicio"] = codEjercicio;
    valoresDefecto["coddivisa"] = util.sqlSelect("empresa", "coddivisa", "1 = 1");

    datosAsiento = flfacturac.iface.pub_regenerarAsiento(curPD, valoresDefecto);
    if (datosAsiento.error == true)
        return false;

    var curTransaccion:FLSqlCursor = new FLSqlCursor("empresa");
    curTransaccion.transaction(false);

    try {
        /*Hasta aqui solo deberían llegar los pagos de 202 con anticipo*/
        if (tipo == "Pago") {
            var recibo:Array = flfactppal.iface.pub_ejecutarQry("recibosprov", "coddivisa,importe,importeeuros,idfactura,codigo,nombreproveedor,tasaconv", "idrecibo = " + curPD.valueBuffer("idrecibo"));
            if (recibo.result != 1) {
                throw util.translate("scripts", "Error al obtener los datos del recibo");
            }
            if (!this.iface.generarPartidasBancoProv(curPD, valoresDefecto, datosAsiento, recibo)) {
                throw util.translate("scripts", "Error al obtener la partida de banco");
            }
            if (!this.iface.generarPartidasBancoProvECGP(curPD, valoresDefecto, datosAsiento, recibo)) {
                throw util.translate("scripts", "Error al obtener la partida de banco");
            }

        } else {
        /*El asiento de devolución es para todos los casos de pago de recibo con idremesa*/
            if (tipoConta == "202" && idAnticipoConf){
                /** \D las subcuentas del asiento contable serán las inversas al asiento contable correspondiente al último pago**/
                var idAsientoPago:Number = util.sqlSelect("pagosdevolprov", "idasiento", "idrecibo = " + curPD.valueBuffer("idrecibo") + " AND  tipo = 'Pago' ORDER BY fecha DESC");
                if (this.iface.generarAsientoInverso(datosAsiento.idasiento, idAsientoPago, datosAsiento.concepto, valoresDefecto.codejercicio) == false) {
                    throw util.translate("scripts", "Error al generar el asiento inverso al pago");
                }
            }

            if (tipoConta == "100" || tipoConta == "200" || tipoConta == "201" || (tipoConta == "202" && !idAnticipoConf)){
                var recibo:Array = flfactppal.iface.pub_ejecutarQry("recibosprov", "coddivisa,importe,importeeuros,idfactura,codigo,nombreproveedor,tasaconv", "idrecibo = " + curPD.valueBuffer("idrecibo"));
                var partidadebe:Array;
                var partidahaber:Array;

                partidahaber = this.iface.cuentaPagoRecibosProv(curPD.valueBuffer("idrecibo"),valoresDefecto.codejercicio);
                if (partidahaber["error"]!=0){
                    return false;
                }
                partidahaber["concepto"] = curPD.valueBuffer("tipo") + " recibo " + recibo.codigo + " - " + recibo.nombreproveedor;
                partidahaber["coddivisa"] = recibo["coddivisa"];
                partidahaber["calcularCambio"] = false;
                partidahaber["importeME"] = 0;
                partidahaber["tasaConv"] = 1;
                if (valoresDefecto.coddivisa == recibo.coddivisa) {
                    partidahaber["importe"] = recibo.importe;
                    partidahaber["importeME"] = 0;
                } else {
                    if (recibo["idfactura"] && recibo["idfactura"]!=""){
                        partidahaber["tasaConv"] = util.sqlSelect("recibosprov r INNER JOIN facturasprov f ON r.idfactura = f.idfactura ", "f.tasaconv", "r.idrecibo = " + curPD.valueBuffer("idrecibo"), "recibosprov,facturascli");
                    }else{
                        partidahaber["tasaConv"] = recibo.tasaconv;
                    }
                    partidahaber["importe"] = parseFloat(recibo.importeeuros);
                    partidahaber["importeME"] = parseFloat(recibo.importe);
                }

                if (!this.iface.generarPartidasHaber(curPD, valoresDefecto, datosAsiento, partidahaber)){
                    return false;
                }

                var remesa:Array = flfactppal.iface.pub_ejecutarQry("remesasprov", "codsubcuenta,idsubcuenta", "idremesa = " + idRemesa);
                partidadebe["codsubcuenta"] = remesa["codsubcuenta"];
                partidadebe["idsubcuenta"] = remesa["idsubcuenta"];
                partidadebe["importe"] = partidahaber["importe"];
                partidadebe["importeME"] = partidahaber["importeME"];
                partidadebe["tasaConv"] = partidahaber["tasaConv"];
                partidadebe["calcularCambio"] = false;
                partidadebe["coddivisa"] = recibo["coddivisa"];
                partidadebe["concepto"] = curPD.valueBuffer("tipo") + " recibo " + recibo.codigo + " - " + recibo.nombreproveedor;

                if (!this.iface.generarPartidasDebe(curPD, valoresDefecto, datosAsiento, partidadebe)){
                    return false;
                }
            }
        }

        curPD.setValueBuffer("idasiento", datosAsiento.idasiento);

        if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento)) {
            throw util.translate("scripts", "Error al comprobar el asiento");
        }

    } catch (e) {
        curTransaccion.rollback();
        var codRecibo:String = util.sqlSelect("reciboscli", "codigo", "idrecibo = " + curPD.valueBuffer("idrecibo"));
        MessageBox.warning(util.translate("scripts", "Error al generar el asiento correspondiente a %1 del recibo %2:").arg(curPD.valueBuffer("tipo")).arg(codRecibo) + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
        return false;
    }

    curTransaccion.commit();
    return true;
}

/** \D Genera la partida correspondiente al banco de ECGP para pagos de recibos de proveedor con remesa en tipo 202
@param  curPD: Cursor del pago o devolución
@param  valoresDefecto: Array de valores por defecto (ejercicio, divisa, etc.)
@param  datosAsiento: Array con los datos del asiento
@param  recibo: Array con los datos del recibo asociado al pago
@return true si la generación es correcta, false en caso contrario
\end */
function tiposremprov_generarPartidasBancoProvECGP(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean
{
    var util:FLUtil = new FLUtil();
    var ctaPartida:Array = [];
    var datosPartida:Array;

    var remesa:Array = flfactppal.iface.pub_ejecutarQry("remesasprov", "codsubcuentaecgp,idsubcuentaecgp", "idremesa = " + curPD.valueBuffer("idremesa"));
    if (remesa.result != 1) {
        return false;
    }

    datosPartida["codsubcuenta"] = remesa["codsubcuentaecgp"];
    datosPartida["idsubcuenta"] = remesa["idsubcuentaecgp"];
    datosPartida["importe"] = recibo["importe"];
    datosPartida["importeME"] = 0;
    datosPartida["tasaConv"] = 1;
    datosPartida["calcularCambio"] = false;
    datosPartida["coddivisa"] = recibo["coddivisa"];
    datosPartida["concepto"] = curPD.valueBuffer("tipo") + " recibo prov " + recibo["codigo"];

    if (!this.iface.generarPartidasDebe(curPD, valoresDefecto, datosAsiento, datosPartida)){
        return false;
    }

    return true;
}

/** \D Genera la partida correspondiente al proveedor del asiento de pago
@param  curPD: Cursor del pago o devolución
@param  valoresDefecto: Array de valores por defecto (ejercicio, divisa, etc.)
@param  datosAsiento: Array con los datos del asiento
@param  recibo: Array con los datos del recibo asociado al pago
@return true si la generación es correcta, false en caso contrario
la diferencia con la clase anterior de gestesoreria, es que depende del tipo de remesa, la cuenta de pago es del proveedor o de efectos comerciales a pagar
\end */
function tiposremprov_generarPartidasProv(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean
{

    /*Solo entra a esta función si es tipo Pago*/
    if (curPD.valueBuffer("tipo") != "Pago"){
            return false;
    }

    var util:FLUtil = new FLUtil();
    var datosPartida:Array;
    var destinoPartida:String = "";

    datosPartida["calcularCambio"] = false;
    datosPartida["importe"] = 0;
    datosPartida["importeME"] = 0;
    datosPartida["tasaConv"] = 1;

    if (valoresDefecto.coddivisa == recibo.coddivisa) {
        datosPartida["importe"] = recibo.importe;
        datosPartida["importeME"] = 0;
    } else {
         if (recibo["idfactura"] && recibo["idfactura"]!=""){
                        datosPartida["tasaConv"] = util.sqlSelect("recibosprov r INNER JOIN facturasprov f ON r.idfactura = f.idfactura ", "f.tasaconv", "r.idrecibo = " + curPD.valueBuffer("idrecibo"), "recibosprov,facturascli");
                }else{
                        datosPartida["tasaConv"] = recibo.tasaconv;
                }
                datosPartida["importe"] = parseFloat(recibo.importeeuros);
                datosPartida["importeME"] = parseFloat(recibo.importe);
    }

    destinoPartida = "DEBE";
    if (recibo["idfactura"] && recibo["idfactura"]!=""){
            var esAbono:Boolean = util.sqlSelect("facturasprov", "deabono", "idfactura ='" + recibo["idfactura"]+"'");
            if (esAbono == true){
                    destinoPartida = "HABER";
                    datosPartida["importe"] = datosPartida["importe"]*-1;
                    datosPartida["importeME"] = datosPartida["importeME"]*-1;
            }
    }

    var ctaPartida:Array = [];
    ctaPartida = this.iface.cuentaPagoRecibosProv(curPD.valueBuffer("idrecibo"),valoresDefecto.codejercicio);
    var idRemesa:Number = curPD.valueBuffer("idremesa");
    if (idRemesa) {
        var tipoConta:String = util.sqlSelect("remesasprov","tipoconta","idremesa="+idRemesa);
        if (!tipoConta) {
            return false;
        }
        if (tipoConta == "202"){
            var qryDatos:FLSqlQuery = new FLSqlQuery();
            qryDatos.setTablesList("recibosprov,proveedores");
            qryDatos.setSelect("r.codigo,r.importe,p.codproveedor,p.nombre,p.acreedor");
            qryDatos.setFrom("recibosprov r INNER JOIN proveedores p ON p.codproveedor = r.codproveedor");
            qryDatos.setWhere("r.idrecibo = "+curPD.valueBuffer("idrecibo"));

            if (!qryDatos.exec()){
                debug("error en consulta de datos para asiento de anticipos confirming");
                return false;
            }

            if (!qryDatos.first()){
                debug("error en consulta de datos para asiento de anticipos confirming");
                return false;
            }

            var codCuentaAnt:String;
            var ctaEsp:String = "";
            var acreedor:Boolean = qryDatos.value("p.acreedor");
            if (!acreedor) {
                codCuentaAnt = util.sqlSelect("factteso_general","codctaecpprov","1=1");
                ctaEsp = "ECPPRO";
            } else {
                codCuentaAnt = util.sqlSelect("factteso_general","codctaecpacre","1=1");
                ctaEsp = "ECPACR";
            }

            if (!codCuentaAnt || codCuentaAnt =="") {
                MessageBox.warning("Ocurrio un error al generar el asiento.\n Por favor revise la configuración general de tesorería",MessageBox.Ok, MessageBox.NoButton);
                return false;
            }

            ctaPartida = flfactppal.iface.pub_datosOtraSubcuentaProveedor(ctaEsp,qryDatos.value("p.codproveedor"),valoresDefecto);
        }
    }

    if (ctaPartida["error"]!=0){
        return false;
    }

    datosPartida["codsubcuenta"] = ctaPartida["codsubcuenta"];
    datosPartida["idsubcuenta"] = ctaPartida["idsubcuenta"];
    datosPartida["concepto"] = curPD.valueBuffer("tipo") + " recibo " + recibo.codigo + " - " + recibo.nombreproveedor;
    datosPartida["coddivisa"] = recibo["coddivisa"];

    if (destinoPartida == "HABER"){
            if (!this.iface.generarPartidasHaber(curPD, valoresDefecto, datosAsiento, datosPartida))
                    return false;
    } else if (destinoPartida == "DEBE"){
            if (!this.iface.generarPartidasDebe(curPD, valoresDefecto, datosAsiento, datosPartida))
                    return false;
    }

    return true;
}

/*Cambia el estado de una remesa de proveedor*/
function tiposremprov_cambiarEstadoRemesaProv(idRemesa:Number):Boolean{

    var curRemesa = new FLSqlCursor("remesasprov");
    curRemesa.select("idremesa='"+idRemesa+"'");

    if (curRemesa.first()) {
        curRemesa.setModeAccess(curRemesa.Edit);
        curRemesa.refreshBuffer();
        curRemesa.setValueBuffer("estado",this.iface.calcularEstadoRemesaProv(curRemesa));
    }

    if (!curRemesa.commitBuffer()){
        return false;
    }

    return true;
}

/*Pone a estado pagada una remesa de proveedor si todos sus recibos tienen un pagodevolprov para esa idremesa*/
function tiposremprov_calcularEstadoRemesaProv(curRemesa:FlSqlCursor):String
{
    var idRemesa = curRemesa.valueBuffer("idremesa");
    if (!idRemesa || idRemesa==""){
        MessageBox.warning("Ha ocurrido un error.\nNo ha sido posible calcular el estado de la remesa",MessageBox.Ok, MessageBox.NoButton);
        return "";
    }

    var util:FLUtil = new FLUtil;

    var cerrada = curRemesa.valueBuffer("cerrada");
    var idPago = util.sqlSelect("pagosdevolremprov","idpagoremprov","idremesa='"+idRemesa+"'");

    var estado:String="Emitida";
    if (cerrada == true) estado = "Cerrada";

    var tipoConta = curRemesa.valueBuffer("tipoconta");
    if (tipoConta != "202" && idPago && idPago!="") {
        estado = "Pagada";
    }

    if (tipoConta == "202") {
        var countRecibos:Number = util.sqlSelect("recibosprovremesa","count(idreciborem)","idremesa="+idRemesa);
        var countPagos:Number = util.sqlSelect("pagosdevolprov INNER JOIN remesasprov ON pagosdevolprov.idremesa = remesasprov.idremesa","count(idpagodevol)","remesasprov.idremesa ="+idRemesa+" AND pagosdevolprov.tipo = 'Pago'","pagosdevolprov,remesasprov");
        if (countRecibos == countPagos){
            estado = "Pagada";
        }
    }

    return estado;
}

//// TIPOSREMPROV //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

