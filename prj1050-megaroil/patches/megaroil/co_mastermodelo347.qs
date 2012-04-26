
/** @class_declaration boe2011 */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class boe2011 extends oficial {
    function boe2011( context ) { oficial( context ); }
    function presTelematica() {
        return this.ctx.boe2011_presTelematica();
    }
    function presTelematica2011() {
        return this.ctx.boe2011_presTelematica2011();
    }
    function nombreFichero():String {
        return this.ctx.boe2011_nombreFichero();
    }

    function soporteModelo():String{
        return this.ctx.boe2011_soporteModelo();
    }
    function tiporeg1(curMod:FLSlqCursor):String {
        return this.ctx.boe2011_tiporeg1(curMod);
    }
    function tiporeg2d(curMod:FLSlqCursor,curMod2d:FlsqlCursor):String {
        return this.ctx.boe2011_tiporeg2d(curMod,curMod2d);
    }
    function tiporeg2i(curMod:FLSlqCursor,curMod2i:FlsqlCursor):String {
        return this.ctx.boe2011_tiporeg2i(curMod,curMod2i);
    }
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition boe2011 */
//////////////////////////////////////////////////////////////////
//// BOE2011 /////////////////////////////////////////////////////
/** \D Genera un fichero para realizar la presentación telemática del modelo
\end */

function boe2011_presTelematica()
{
    this.iface.presTelematica2011();
}

function boe2011_presTelematica2011() {

    var curMod:FLSqlCursor = this.cursor();
    if (!curMod.isValid()){
        return;
    }

    var nombreFichero = this.iface.nombreFichero();
    if (!nombreFichero){
        return;
    }

    var util:FLUtil = new FLUtil();
    flcontmode.iface.error = "";

    util.createProgressDialog(util.translate("scripts", "Generando registro de tipo 1"), 10);
    util.setProgress(2);

    var file:Object = new File(nombreFichero);
    file.open(File.WriteOnly);

    file.write(this.iface.tiporeg1(curMod) + "\r\n");
    util.setProgress(10);
    util.destroyProgressDialog();


    var curMod2d:FLSqlCursor = new FLSqlCursor("co_modelo347_tipo2d");
    curMod2d.select("idmodelo = " + curMod.valueBuffer("idmodelo"));
    util.createProgressDialog(util.translate("scripts", "Generando registro de tipo 2 declarados operaciones"), curMod2d.size());
    var progreso:Number = 0;
    while (curMod2d.next()){
        util.setProgress(progreso++);
        file.write(this.iface.tiporeg2d(curMod,curMod2d) + "\r\n");
    }
    util.destroyProgressDialog();

    var curMod2i:FLSqlCursor = new FLSqlCursor("co_modelo347_tipo2i");
    curMod2i.select("idmodelo = " + curMod.valueBuffer("idmodelo"));
    util.createProgressDialog(util.translate("scripts", "Generando registro de tipo 2 bienes inmuebles"), curMod2d.size());
    var progreso:Number = 0;
    while (curMod2i.next()){
        util.setProgress(progreso++);
        file.write(this.iface.tiporeg2i(curMod,curMod2i) + "\r\n");
    }

    file.close();

    // Genera copia del fichero en codificacion ISO
    file.open(File.ReadOnly);
    var content = file.read();
    file.close();

    var fileIso = new File(nombreFichero + ".iso8859" );
    fileIso.open(File.WriteOnly);
    fileIso.write( sys.fromUnicode( content, "ISO-8859-1" ) );
    fileIso.close();

    util.destroyProgressDialog();

    var util:FLUtil = new FLUtil();
    if (flcontmode.iface.error == "") {
        MessageBox.information(util.translate("scripts", "Generado fichero en :\n\n" + nombreFichero+".iso8859" + "\n\n"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    } else {
        MessageBox.information(util.translate("scripts", "Se han detectado los siguientes errores :\n\n" +flcontmode.iface.error+ "\n\n"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    }
}

function boe2011_nombreFichero():String
{

    var nombreFichero:String = FileDialog.getSaveFileName("*.*");
    if (!nombreFichero) {
        MessageBox.warning("No ha indicado el nombre del fichero",MessageBox.Ok, MessageBox.NoButton);
        return "";
    } else {
        return nombreFichero;
    }
}

function boe2011_soporteModelo():String{

    var util:FLUtil = new FLUtil();

    // Tipo de soporte
    var tipoSoporte:String;
    var presTelematica:String = util.translate("scripts", "Transmisión telemática");
    var soporteMagnetico:String = util.translate("scripts", "Soporte Magnético");
    var soportes:Array = [presTelematica, soporteMagnetico];
    var opcion:String = Input.getItem(util.translate("scripts", "Indique el tipo de soporte"), soportes, presTelematica, false);
    if (!opcion){
        MessageBox.warning("No ha indicado el tipo de soporte.\nSe asignara presentación telemática como valor por defecto",MessageBox.Ok,MessageBox.NoButton);
        return "T";
    }

    switch (opcion) {
        case presTelematica:
            tipoSoporte = "T";
            break;

    case soporteMagnetico:
            tipoSoporte = "C";
            break;
    }

    return tipoSoporte;
}

function boe2011_tiporeg1(curMod:FLSlqCursor):String {

    //Registro de tipo 1 declarante
    var codReg = "1";
    var desReg:Array = flcontmode.iface.pub_desRegistro347(codReg);

    var util:FLUtil = new FLUtil();
    var valorCampo;
    var nombreCampo = "";
    var formatoCampo = "";
    var registro:Object = {};

    for (var i = 0; i < desReg.length; i++) {
        nombreCampo = desReg[i][0];
        longitudCampo = desReg[i][2];
        formatoCampo = desReg[i][3];
        if (formatoCampo == "B") {
            valorCampo = " ";
        } else {
            switch(nombreCampo) {
                case "tiporeg":
                    valorCampo = "1";
                    break;

                case "modelo":
                    valorCampo = "347";
                    break;

                case "ejercicio":
                    valorCampo = util.sqlSelect("ejercicios","date_part('year',fechainicio)","codejercicio='"+curMod.valueBuffer("codejercicio")+"'");
                    break;

                case "tiposoporte":
                    valorCampo = this.iface.soporteModelo();
                    break;

                case "complementaria":
                    if (curMod.valueBuffer("complementaria")) {
                        valorCampo = "C";
                    } else {
                        valorCampo = " ";
                    }
                    break;
                case "sustitutiva":
                    if (curMod.valueBuffer("sustitutiva")) {
                        valorCampo = "S";
                    } else{
                        valorCampo = " ";
                    }
                    break;

                case "jusanterior":
                    if (curMod.valueBuffer("complementaria") || curMod.valueBuffer("sustitutiva")) {
                        valorCampo = curMod.valueBuffer("jusanterior");
                    } else {
                        valorCampo = "0";
                    }
                    break;

                case "signo":
                    if (curMod.valueBuffer("importetotal") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "importetotal":
                    valorCampo = flcontmode.iface.pub_formatoNumero(Math.abs(parseFloat(curMod.valueBuffer("importetotal"))), 13, 2);
                    break;

                case "totalarrendamiento":
                    valorCampo = flcontmode.iface.pub_formatoNumero(parseFloat(curMod.valueBuffer("totalarrendamiento")), 13, 2);
                    break;

                default :
                    valorCampo = curMod.valueBuffer(nombreCampo);
                    break;
            }
        }

        registro[nombreCampo] = valorCampo;
    }

    return flcontmode.iface.pub_generarRegistro(desReg,registro);

}


function boe2011_tiporeg2d(curMod:FLSlqCursor,curMod2d:FlsqlCursor):String {

    //Registro de tipo 2 declarados
    var codReg = "2d";
    var desReg:Array = flcontmode.iface.pub_desRegistro347(codReg);

    var util:FLUtil = new FLUtil();
    var valorCampo;
    var nombreCampo = "";
    var formatoCampo = "";
    var registro:Object = {};

    for (var i = 0; i < desReg.length; i++) {
        nombreCampo = desReg[i][0];
        longitudCampo = desReg[i][2];
        formatoCampo = desReg[i][3];
        if (formatoCampo == "B") {
            valorCampo = " ";
        } else {
            switch(nombreCampo) {
                case "tiporeg":
                    valorCampo = "2";
                    break;

                case "modelo":
                    valorCampo = "347";
                    break;

                case "ejercicio":
                    valorCampo = util.sqlSelect("ejercicios","date_part('year',fechainicio)","codejercicio='"+curMod.valueBuffer("codejercicio")+"'");
                    break;

                case "cifnif":
                    valorCampo = curMod.valueBuffer(nombreCampo);
                    break;

                case "tipohoja":
                    valorCampo = "D";
                    break;

                case "signo":
                    if (curMod2d.valueBuffer("importe") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "importe":
                    valorCampo = flcontmode.iface.pub_formatoNumero(Math.abs(parseFloat(curMod2d.valueBuffer("importe"))), 13, 2);
                    break;

                case "seguro":
                    if (curMod2d.valueBuffer("seguro"))
                        valorCampo = "X";
                    else
                        valorCampo = " ";
                    break;

                case "arrendlocal":
                    if (curMod2d.valueBuffer("arrendlocal"))
                        valorCampo = "X";
                    else
                        valorCampo = " ";
                    break;

                case "importemetalico":
                    valorCampo = flcontmode.iface.pub_formatoNumero(parseFloat(curMod2d.valueBuffer("importemetalico")), 13, 2);
                    break;

                case "signoinmuebles":
                    if (curMod2d.valueBuffer("importeinmuebles") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "importeinmuebles":
                    valorCampo = flcontmode.iface.pub_formatoNumero(Math.abs(parseFloat(curMod2d.valueBuffer("importeinmuebles"))), 13, 2);
                    break;

                case "ejerciciometalico":
                    if (!curMod2d.valueBuffer("importemetalico"))
                        valorCampo = "0";
                    else
                        valorCampo = curMod2d.valueBuffer("ejerciciometalico");
                    break;

                case "signo1t":
                    if (curMod2d.valueBuffer("importe1t") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "importe1t":
                    valorCampo = flcontmode.iface.pub_formatoNumero(Math.abs(parseFloat(curMod2d.valueBuffer("importe1t"))), 13, 2);
                    break;

                case "signoinmuebles1t":
                    if (curMod2d.valueBuffer("importeinmuebles1t") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "importeinmuebles1t":
                    valorCampo = flcontmode.iface.pub_formatoNumero(Math.abs(parseFloat(curMod2d.valueBuffer("importeinmuebles1t"))), 13, 2);
                    break;

                case "signo2t":
                    if (curMod2d.valueBuffer("importe2t") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "importe2t":
                    valorCampo = flcontmode.iface.pub_formatoNumero(Math.abs(parseFloat(curMod2d.valueBuffer("importe2t"))), 13, 2);
                    break;

                case "signoinmuebles2t":
                    if (curMod2d.valueBuffer("importeinmuebles2t") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "importeinmuebles2t":
                    valorCampo = flcontmode.iface.pub_formatoNumero(Math.abs(parseFloat(curMod2d.valueBuffer("importeinmuebles2t"))), 13, 2);
                    break;

                case "signo3t":
                    if (curMod2d.valueBuffer("importe3t") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "importe3t":
                    valorCampo = flcontmode.iface.pub_formatoNumero(Math.abs(parseFloat(curMod2d.valueBuffer("importe3t"))), 13, 2);
                    break;

                case "signoinmuebles3t":
                    if (curMod2d.valueBuffer("importeinmuebles3t") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "importeinmuebles3t":
                    valorCampo = flcontmode.iface.pub_formatoNumero(Math.abs(parseFloat(curMod2d.valueBuffer("importeinmuebles3t"))), 13, 2);
                    break;

                case "signo4t":
                    if (curMod2d.valueBuffer("importe4t") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "importe4t":
                    valorCampo = flcontmode.iface.pub_formatoNumero(Math.abs(parseFloat(curMod2d.valueBuffer("importe4t"))), 13, 2);
                    break;

                case "signoinmuebles4t":
                    if (curMod2d.valueBuffer("importeinmuebles4t") < 0) {
                        valorCampo = "N";
                    }else {
                        valorCampo = " ";
                    }
                    break;

                case "importeinmuebles4t":
                    valorCampo = flcontmode.iface.pub_formatoNumero(Math.abs(parseFloat(curMod2d.valueBuffer("importeinmuebles4t"))), 13, 2);
                    break;

                default :
                    valorCampo = curMod2d.valueBuffer(nombreCampo);
                    break;
            }
        }

        registro[nombreCampo] = valorCampo;
    }

    return flcontmode.iface.pub_generarRegistro(desReg,registro);

}

function boe2011_tiporeg2i(curMod:FLSlqCursor,curMod2i:FlsqlCursor):String {

    //Registro de tipo 2 inmuebles
    var codReg = "2i";
    var desReg:Array = flcontmode.iface.pub_desRegistro347(codReg);

    var util:FLUtil = new FLUtil();
    var valorCampo;
    var nombreCampo = "";
    var formatoCampo = "";
    var registro:Object = {};

    for (var i = 0; i < desReg.length; i++) {
        nombreCampo = desReg[i][0];
        longitudCampo = desReg[i][2];
        formatoCampo = desReg[i][3];
        if (formatoCampo == "B") {
            valorCampo = " ";
        } else {
            switch(nombreCampo) {
                case "tiporeg":
                    valorCampo = "2";
                    break;

                case "modelo":
                    valorCampo = "347";
                    break;

                case "ejercicio":
                   valorCampo = util.sqlSelect("ejercicios","date_part('year',fechainicio)","codejercicio='"+curMod.valueBuffer("codejercicio")+"'");
                    break;

                case "cifnif":
                    valorCampo = curMod.valueBuffer(nombreCampo);
                    break;

                case "tipohoja":
                    valorCampo = "I";
                    break;

                case "importe":
                    valorCampo = flcontmode.iface.pub_formatoNumero(parseFloat(curMod2i.valueBuffer("importe")), 13, 2);
                    break;

                default :
                    valorCampo = curMod2i.valueBuffer(nombreCampo);
                    break;
            }
        }

        registro[nombreCampo] = valorCampo;
    }

    return flcontmode.iface.pub_generarRegistro(desReg,registro);

}

//// BOE2011 /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

