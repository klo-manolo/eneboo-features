
/** @class_declaration recibosmanuales */
//////////////////////////////////////////////////////////////////
//// RECIBOSMANUALES /////////////////////////////////////////////
class recibosmanuales extends oficial {
    var idFacturaProv:String;
    function recibosmanuales( context ) { oficial( context ); }

    function init() { return this.ctx.recibosmanuales_init(); }

    function gestorRecibos(){
            return this.ctx.recibosmanuales_gestorRecibos();
    }
}
//// RECIBOSMANUALES //////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition recibosmanuales */
/////////////////////////////////////////////////////////////////
//// RECIBOSMANUALES ///////////////////////////////////////////
function recibosmanuales_init(){

    this.iface.__init();

    var cursor:FLSqlCursor = this.cursor();

    connect(this.child("pbnRecibos"), "clicked()", this, "iface.gestorRecibos");

}

function recibosmanuales_gestorRecibos()
{
    var cursor:FLSqlCursor = this.cursor();
    this.iface.idFacturaProv = cursor.valueBuffer("idfactura");

    var f:Object = new FLFormSearchDB("recibosfactprov");
    var cursor:FLSqlCursor = f.cursor();

    cursor.setActivatedCheckIntegrity(false);
    cursor.select();
    if (cursor.first()){
            cursor.setModeAccess(cursor.Edit);
    }

    f.setMainWidget();
    cursor.refreshBuffer();
    var acpt:String = f.exec("id");
    if (acpt) {
            f.close();
    }

    this.iface.tdbRecords.refresh();

}

//// RECIBOSMANUALES /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

