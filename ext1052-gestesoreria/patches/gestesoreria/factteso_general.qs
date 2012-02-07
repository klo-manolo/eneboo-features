
/** @class_declaration gestesoreria */
//////////////////////////////////////////////////////////////////
//// GESTESORERIA //////////////////////////////////////////////
class gestesoreria extends oficial {
        var cbx19:Object;
        var cbx58:Object;
        var cbx34:Object;
        var lblDes19:Object;
        var lblDes58:Object;
        var lblDes34:Object;
        var gbxCuentas19:Object;
        var gbxCuentas58:Object;
        var tipoConta19:String;
        var tipoConta58:String;
        var tipoConta34:String;
        var pagoAuto19:Object;
        var pagoAuto58:Object;
        var pagoAuto34:Object;
        var pbnAceptar:Object;
        var pbnCancelar:Object;

        function gestesoreria( context ) { oficial( context ); }

        function main() {
                this.ctx.gestesoreria_main();
        }

        function init() {
                this.ctx.gestesoreria_init();
        }

        function aceptarFormulario(){
            return this.ctx.gestesoreria_aceptarFormulario();
        }
        function cancelarFormulario(){
            return this.ctx.gestesoreria_cancelarFormulario();
        }

        function cambiarTipo19(){
                return this.ctx.gestesoreria_cambiarTipo19();
        }

        function cambiarTipo58(){
                return this.ctx.gestesoreria_cambiarTipo58();
        }

        function cambiarTipo34(){
                return this.ctx.gestesoreria_cambiarTipo34();
        }

        function validateForm() {
                return this.ctx.gestesoreria_validateForm();
        }

}
//// GESTESORERIA //////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration tiposremprov */
//////////////////////////////////////////////////////////////////
//// TIPOSREMPROV ////////////////////////////////////////////////
class tiposremprov extends gestesoreria {
    var gbxCuentas34:Object;
    function tiposremprov( context ) { gestesoreria ( context ); }
    function init() {
        this.ctx.tiposremprov_init();
    }
    function cambiarTipo34(){
        return this.ctx.tiposremprov_cambiarTipo34();
    }
    function validateForm() {
        return this.ctx.tiposremprov_validateForm();
    }
}
//// TIPOSREMPROV /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition gestesoreria */
/////////////////////////////////////////////////////////////////
//// GESTESORERIA //////////////////////////////////////////////

function gestesoreria_main()
{
        var commitOk:Boolean = false;
        var acpt:Boolean;

        while (!commitOk) {
                var f:Object = new FLFormSearchDB("factteso_general");
                var cursor:FLSqlCursor = f.cursor();
                cursor.select();
                if (!cursor.first())
                        cursor.setModeAccess(cursor.Insert);
                else
                        cursor.setModeAccess(cursor.Edit);

                f.setMainWidget();
                if (cursor.modeAccess() == cursor.Insert)
                        f.child("pushButtonCancel").setEnabled(true);
                cursor.refreshBuffer();
                cursor.transaction(false);
                acpt = false;
                f.exec("id");
                acpt = f.accepted();

                if (!acpt) {
                        if (cursor.rollback())
                                commitOk = true;
                } else {
                        if (cursor.commitBuffer()) {
                                cursor.commit();
                                commitOk = true;
                        }
                }
                f.close();
        }
}


function gestesoreria_init()
{
        var util:FLUtil = new FLUtil;

        this.iface.pbnAceptar = this.child("pbnAceptar");
        this.iface.pbnCancelar = this.child("pbnCancelar");
        this.child("pushButtonAccept").setHidden(true);
        this.child("pushButtonCancel").setHidden(true);
        connect(this.iface.pbnAceptar, "clicked()", this, "iface.aceptarFormulario");
        connect(this.iface.pbnCancelar, "clicked()", this, "iface.cancelarFormulario");


        var cursor:FLSqlCursor = this.cursor();
        this.iface.cbx19 = this.child("cbxN19");
        this.iface.cbx58 = this.child("cbxN58");
        this.iface.cbx34 = this.child("cbxN34");
        this.iface.lblDes19 = this.child("lblDesN19");
        this.iface.lblDes58 = this.child("lblDesN58");
        this.iface.lblDes34 = this.child("lblDesN34");
        this.iface.gbxCuentas19 = this.child("gbxCuentas19");
        this.iface.gbxCuentas58 = this.child("gbxCuentas58");
        this.iface.pagoAuto19 = this.child("gbxPagoAuto19");
        this.iface.pagoAuto58 = this.child("gbxPagoAuto58");
        this.iface.pagoAuto34 = this.child("gbxPagoAuto34");

        connect(this.iface.cbx19,"highlighted(int)",this,"iface.cambiarTipo19");
        connect(this.iface.cbx19,"activated(int)",this,"iface.cambiarTipo19");
        connect(this.iface.cbx58,"highlighted(int)",this,"iface.cambiarTipo58");
        connect(this.iface.cbx58,"activated(int)",this,"iface.cambiarTipo58");
        connect(this.iface.cbx34,"highlighted(int)",this,"iface.cambiarTipo34");
        connect(this.iface.cbx34,"activated(int)",this,"iface.cambiarTipo34");


        switch (cursor.modeAccess()){
                case cursor.Insert:
                        this.iface.cbx19.currentItem = 0;
                        this.iface.cbx58.currentItem = 0;
                        this.iface.cbx34.currentItem = 0;
                        this.iface.tipoConta19="100";
                        this.iface.tipoConta58="100";
                        this.iface.tipoConta34="100";
                        break;

                case cursor.Edit:
                        var tipo19 = cursor.valueBuffer("tipoconta19");
                        if (tipo19=="100") this.iface.cbx19.currentItem = 0;
                        if (tipo19=="200") this.iface.cbx19.currentItem = 1;
                        if (tipo19=="110") this.iface.cbx19.currentItem = 2;
                        this.iface.tipoConta19 = tipo19;

                        var tipo58 = cursor.valueBuffer("tipoconta58");
                        if (tipo58=="100") this.iface.cbx58.currentItem = 0;
                        if (tipo58=="200") this.iface.cbx58.currentItem = 1;
                        if (tipo58=="300") this.iface.cbx58.currentItem = 2;
                        this.iface.tipoConta58 = tipo58;

                        var tipo34 = cursor.valueBuffer("tipoconta34");
                        if (tipo34=="100") this.iface.cbx34.currentItem = 0;
                        if (tipo34=="200") this.iface.cbx34.currentItem = 1;
                        this.iface.tipoConta34 = tipo34;

                        break;
        }

        this.iface.cambiarTipo19();
        this.iface.cambiarTipo58();
        this.iface.cambiarTipo34();

}

function gestesoreria_aceptarFormulario(){

    if (!this.iface.validateForm()){
        return;
    }

    this.child("pushButtonAccept").animateClick();
}

function gestesoreria_cancelarFormulario(){

    this.child("pushButtonCancel").animateClick();
}

function gestesoreria_cambiarTipo19()
{
        var item:Number = this.iface.cbx19.currentItem;
        var destipo:String="";
        var ocultar:Boolean = true;
        var ocultarPago:Boolean = true;
        switch(item){
                /*Directa*/
                case 0 :
                        this.iface.tipoConta19 = "100";
                        destipo = " Al incluir un recibo de cliente en una remesa, el correspondiente asiento de pago se asigna directamente a la subcuenta de la cuenta bancaria indicada en la remesa."
                        ocultar = true;
                        ocultarPago = false;
                        break;

                /*Indirecta*/
                case 1 :
                        this.iface.tipoConta19 = "200";
                        destipo = "Al incluir un recibo de cliente en una remesa, el correspondiente asiento de pago se asigna a la subcuenta de Efectos comerciales de gestión de cobro (E.C.G.C.) asociada a la cuenta bancaria de la remesa. Cuando se recibe la confirmación del banco el usuario inserta un registro de pago para la remesa completa, que lleva las partidas de E.C.G.C. a la subcuenta de la cuenta bancaria.";
                        ocultar = true;
                        ocultarPago = true;
                        break;

                /*Indirecta con cuentas de riesgo*/
                case 2:
                        this.iface.tipoConta19 = "110";
                        destipo = "Al indicar las cuentas, el asiento de la remesa será el completo introducido en el PGC98";
                        ocultar = false;
                        ocultarPago = true;
                        break;

        }

        this.cursor().setValueBuffer("tipoconta19",this.iface.tipoConta19);
        this.iface.lblDes19.text = destipo;
        this.iface.gbxCuentas19.setHidden(ocultar);
        this.iface.pagoAuto19.setHidden(ocultarPago);

}

function gestesoreria_cambiarTipo58()
{
        var item:Number = this.iface.cbx58.currentItem;
        var destipo:String="";
        var ocultar:Boolean = false;
        var ocultarPago:Boolean = true;
        switch(item){
                /*Directa*/
                case 0 :
                        this.iface.tipoConta58 = "100";
                        destipo = " Al incluir un recibo de cliente en una remesa, el correspondiente asiento de pago se asigna directamente a la subcuenta de la cuenta bancaria indicada en la remesa."
                        ocultar = true;
                        ocultarPago = false;
                        break;

                /*Indirecta*/
                case 1 :
                        this.iface.tipoConta58 = "200";
                        destipo = "Al incluir un recibo de cliente en una remesa, el correspondiente asiento de pago se asigna a la subcuenta de Efectos comerciales de gestión de cobro (E.C.G.C.) asociada a la cuenta bancaria de la remesa. Cuando se recibe la confirmación del banco el usuario inserta un registro de pago para la remesa completa, que lleva las partidas de E.C.G.C. a la subcuenta de la cuenta bancaria.";
                        ocultar = true;
                        ocultarPago = true;
                        break;

                /*Indirecta con cuentas de riesgo*/
                case 2:
                        this.iface.tipoConta58 = "300";
                        destipo = "Al indicar las cuentas, el asiento de la remesa será el completo introducido en el PGC98";
                        ocultar = false;
                        ocultarPago = true;
                        break;

        }

        this.cursor().setValueBuffer("tipoconta58",this.iface.tipoConta58);
        this.iface.lblDes58.text = destipo;
        this.iface.gbxCuentas58.setHidden(ocultar);
        this.iface.pagoAuto58.setHidden(ocultarPago);

}

function gestesoreria_cambiarTipo34()
{
        var item:Number = this.iface.cbx34.currentItem;
        var destipo:String="";
        var ocultarPago:Boolean = true;

        switch(item){
                /*Directa*/
                case 0 :
                        this.iface.tipoConta34 = "100";
                        destipo = " Al incluir un recibo de proveedor en una remesa, el correspondiente asiento de pago se asigna directamente a la subcuenta de la cuenta bancaria indicada en la remesa."
                        ocultarPago = false;
                        break;

                /*Indirecta*/
                case 1 :
                        this.iface.tipoConta34 = "200";
                        destipo = "Al incluir un recibo de proveedor en una remesa, el correspondiente asiento de pago se asigna a la subcuenta de Efectos comerciales de gestión de pago (E.C.G.P.) asociada a la cuenta bancaria de la remesa. Cuando se recibe la confirmación del banco el usuario inserta un registro de pago para la remesa completa, que lleva las partidas de E.C.G.P. a la subcuenta de la cuenta bancaria.";
                        ocultarPago = true;
                        break;
        }

        this.cursor().setValueBuffer("tipoconta34",this.iface.tipoConta34);
        this.iface.lblDes34.text = destipo;
        this.iface.pagoAuto34.setHidden(ocultarPago);

}

function gestesoreria_validateForm()
{
        var cursor:FLSqlCursor = this.cursor();

        /**\ verificar que la longitud de las subcuentas para N19 sean de cuatro digitos*/
        var msglong19:Boolean = false;
        if (cursor.valueBuffer("tipoconta19") == "110"){
                var ges = cursor.valueBuffer("codctagescobro");
                var imp19 = cursor.valueBuffer("codctaimp19");
                if(imp19 == "430"){
                        if (ges.length!=4) {
                                msglong19 = true;
                        }
                }else{
                        if (ges.length!=4 || imp19.length!=4) {
                                msglong19 = true;
                        }
                }

                if (msglong19){
                        MessageBox.information("La longitud del código de cuenta ha de ser de 4 dígitos,\npor favor verifique los datos para la norma 19.", MessageBox.Ok, MessageBox.NoButton);
                        return false;
                }
        }

        /**\ verificar que la longitud de las subcuentas para N58 sean de cuatro digitos*/
        var msglong58:Boolean = false;
        if (cursor.valueBuffer("tipoconta58") == "300"){
                var car = cursor.valueBuffer("codctacartera");
                var des = cursor.valueBuffer("codctadescontados");
                var imp58 = cursor.valueBuffer("codctaimp58");
                if(imp58 == "430"){
                        if (car.length!=4 || des.length!=4) {
                                msglong58 = true;
                        }
                }else{
                        if (car.length!=4 || des.length!=4 || imp58.length!=4) {
                                msglong58 = true;
                        }
                }

                if (msglong58){
                        MessageBox.information("La longitud del código de cuenta ha de ser de 4 dígitos,\npor favor verifique los datos para la norma 58.", MessageBox.Ok, MessageBox.NoButton);
                        return false;
                }
        }

        return true;

}

//// GESTESORERIA //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition tiposremprov */
/////////////////////////////////////////////////////////////////
//// TIPOSREMPROV //////////////////////////////////////////////
function tiposremprov_init()
{
    this.iface.gbxCuentas34 = this.child("gbxCuentas34");
    this.iface.__init();
}

function tiposremprov_cambiarTipo34()
{
    this.iface.__cambiarTipo34();

    var item:Number = this.iface.cbx34.currentItem;
    var ocultar:Boolean = true;

    switch(item){
            /*Directa*/
            case 0 :
                ocultar = true;
                break;

            /*Indirecta*/
            case 1 :
                ocultar = false;
                break;
    }

    this.iface.gbxCuentas34.setHidden(ocultar);

}

function tiposremprov_validateForm()
{
    if (!this.iface.__validateForm()){
        return false;
    }

    var util:FLUtil = new FLUtil;
    var existeProv:String = util.sqlSelect("co_cuentasesp","idcuentaesp","idcuentaesp='ECPPRO'");
    var existeAcr:String = util.sqlSelect("co_cuentasesp","idcuentaesp","idcuentaesp='ECPACR'");
    if (!existeProv || !existeAcr) {
        MessageBox.warning("Están pendientes de crear cuentas especiales de tesorería.\nPor favor acceda al modulo principal del área de contabilidad\npara la creación automática de dichas cuentas,\ny vuelva a acceder a este formulario para terminar la configuración",MessageBox.Ok, MessageBox.NoButton);
        return false;
    }

    var cursor:FLSqlCursor = this.cursor();
    debug("idctaecpprov="+cursor.valueBuffer("idctaecpprov"));
    if (!cursor.valueBuffer("idctaecpprov") || cursor.isNull("idctaecpprov") || !cursor.valueBuffer("idctaecpacre") || cursor.isNull("idctaecpacre")){
        MessageBox.information("Pendiente configuración...\nPor favor verifique los datos para la norma 34.", MessageBox.Ok, MessageBox.NoButton);
        return false;
    }

    if (!util.sqlUpdate("co_cuentasesp","codcuenta",cursor.valueBuffer("codctaecpprov"),"idcuentaesp='ECPPRO'")){
        return false;
    }

    if (!util.sqlUpdate("co_cuentasesp","codcuenta",cursor.valueBuffer("codctaecpacre"),"idcuentaesp='ECPACR'")){
        return false;
    }

    return true;
}



//// TIPOSREMPROV //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

