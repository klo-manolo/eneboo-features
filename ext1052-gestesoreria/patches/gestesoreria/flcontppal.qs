
/** @class_declaration tiposremprov */
/////////////////////////////////////////////////////////////////
//// TIPOSREMPROV //////////////////////////////////////////////
class tiposremprov extends pgc2008 {
    function tiposremprov( context ) { pgc2008 ( context ); }
    function init() {
        return this.ctx.tiposremprov_init();
    }

}
//// TIPOSREMPROV ///////////////////////////////////////////////
////////////////////////////////////////////////////////////////

/** @class_definition tiposremprov */
/////////////////////////////////////////////////////////////////
//// TIPOSREMPROV //////////////////////////////////////////////
/*Crear cuentas especiales para efectos comerciales a pagar en proveedores y acreedores si no existen*/
function tiposremprov_init()
{
    this.iface.__init();

    var util:FLUtil = new FLUtil();
    var curCtasEsp:FLSqlCursor = new FLSqlCursor("co_cuentasesp");
    var existeProv:String = util.sqlSelect("co_cuentasesp","idcuentaesp","idcuentaesp='ECPPRO'");
    if (!existeProv) {
        curCtasEsp.setModeAccess(curCtasEsp.Insert);
        curCtasEsp.refreshBuffer();
        curCtasEsp.setValueBuffer("idcuentaesp", "ECPPRO");
        curCtasEsp.setValueBuffer("descripcion", "PROVEEDORES, EFECTOS COMERCIALES A PAGAR");
        if (!curCtasEsp.commitBuffer()){
            MessageBox.information("Ocurrio un error en la creación de la cuenta especial:\n ECPPRO - Proveedores, efectos comerciales a Pagar\nPor favor acceda a la tabla de cuentas especiales y cree dicha cuenta manualmente.",MessageBox.Ok, MessageBox.NoButton);
        }
    }

    var existeAcr:String = util.sqlSelect("co_cuentasesp","idcuentaesp","idcuentaesp='ECPACR'");
    if (!existeAcr) {
        curCtasEsp.setModeAccess(curCtasEsp.Insert);
        curCtasEsp.refreshBuffer();
        curCtasEsp.setValueBuffer("idcuentaesp", "ECPACR");
        curCtasEsp.setValueBuffer("descripcion", "ACREEDORES, EFECTOS COMERCIALES A PAGAR");
        if (!curCtasEsp.commitBuffer()){
            MessageBox.information("Ocurrio un error en la creación de la cuenta especial:\n ECPACR - Acreedores, efectos comerciales a Pagar\nPor favor acceda a la tabla de cuentas especiales y cree dicha cuenta manualmente.",MessageBox.Ok, MessageBox.NoButton);
        }
    }

}

//// TIPOSREMPROV ///////////////////////////////////////////////
////////////////////////////////////////////////////////////////

