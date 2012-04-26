
/** @class_declaration boe2011 */
//////////////////////////////////////////////////////////////////
//// BOE2011 /////////////////////////////////////////////////////
class boe2011 extends oficial {
    function boe2011( context ) { oficial( context ); }
    function buscarCampo() {
        return this.ctx.boe2011_buscarCampo();
    }
    function valoresDefecto() {
        return this.ctx.boe2011_valoresDefecto();
    }
}
//// BOE2011 /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition boe2011 */
/////////////////////////////////////////////////////////////////
//// BOE2011 ////////////////////////////////////////////////////
function boe2011_buscarCampo()
{
    var util:FLUtil = new FLUtil;
    var cursor:FLSqlCursor = this.cursor();

    var dialog = new Dialog(util.translate ( "scripts", "Carta 347" ), 0);
    dialog.caption = "Seleccione un campo";
    dialog.OKButtonText = util.translate ( "scripts", "Aceptar" );
    dialog.cancelButtonText = util.translate ( "scripts", "Cancelar" );

    var grupo1:GroupBox = new GroupBox;
    dialog.add( grupo1 );
    grupo1.title = util.translate ( "scripts", "Seleccione un campo" );

    var combo1 = new ComboBox;
    grupo1.add( combo1 );
    combo1.label = util.translate ( "scripts", "Campo" );
    combo1.itemList = new Array("IMPORTEMINIMO","EJERCICIO","IMPORTE","IMPORTE1T","IMPORTE2T","IMPORTE3T","IMPORTE4T");

    var grupo2:GroupBox = new GroupBox;
    dialog.add( grupo2 );
    grupo2.title = util.translate ( "scripts", "Seleccione el parrafo" );

    var combo2 = new ComboBox;
    grupo2.add( combo2 );
    combo2.label = util.translate ( "scripts", "Parrafo" );
    combo2.itemList = new Array("1","2","3");

    var campoS:String;
    var parrafoS:String;
    if( dialog.exec() ) {
        campoS = combo1.currentItem;
        parrafoS = combo2.currentItem;
    }

    switch(parrafoS) {
        case "1": this.child("fdbParrafo1").editor().insert("#" + campoS + "#");break;
        case "2": this.child("fdbParrafo2").editor().insert("#" + campoS + "#");break;
        case "3": this.child("fdbParrafo3").editor().insert("#" + campoS + "#");break;
    }

}

function boe2011_valoresDefecto()
{
    var saludo:String = "Muy Sres. Nuestros:";
    this.child("fdbSaludo").setValue(saludo);

    var parrafo1:String = "      En cumplimiento del Real Decreto 2027/95 sobre ingresos y pagos a terceros cuyo importe supere los #IMPORTEMINIMO# ¤, les comunicamos que el volumen total de operaciones con ustedes correspondientes al ejercicio #EJERCICIO#, asciende a: #IMPORTE# ¤\n";
    this.child("fdbParrafo1").setValue(parrafo1);

    var parrafo2:String = "      Con relación a las modificaciones en la orden EHA/3378/2011, los importes trimestrales se verán detallados a continuación:\n\n                       Primer trimestre:  #IMPORTE1T# ¤\n                       Segundo trimestre: #IMPORTE2T# ¤\n                       Tercer trimestre:  #IMPORTE3T# ¤\n                       Cuarto trimestre:  #IMPORTE4T# ¤\n";
    this.child("fdbParrafo2").setValue(parrafo2);

    var parrafo3:String = "      Rogamos que de no estar conforme con las cantidades, nos lo comunique a la mayor brevedad, entendiendo, de no recibir observaciones por su parte, que la cantidad indicada es correcta.";
    this.child("fdbParrafo3").setValue(parrafo3);

    var despedida:String = "Sin otro particular, le saluda atentamente.";
    this.child("fdbDespedida").setValue(despedida);
}
//// BOE2011 ////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

