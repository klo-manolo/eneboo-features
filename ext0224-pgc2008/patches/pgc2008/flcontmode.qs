/** @class_declaration boe2011 */
/////////////////////////////////////////////////////////////////
//// BOE2011 ////////////////////////////////////////////////////
class boe2011 extends modelo340 {
    var error:String;
    var xGesteso:Boolean;
    var xC0:Boolean;
    var xMulti:Boolean;
    
    function boe2011( context ) { modelo340 ( context ); }
    function init() {
        this.ctx.boe2011_init();
    }
    function rellenarTablaMod340ClaveOp() {
        return this.ctx.boe2011_rellenarTablaMod340ClaveOp();
    }
    function aplicarFormato(formatoCampo:String,valorCampo:String,nombreCampo:String,longitudCampo:Number):String{
        return this.ctx.boe2011_aplicarFormato(formatoCampo,valorCampo,nombreCampo,longitudCampo);
    }
    function validarFormato(formatoCampo:String,valorCampo:String,nombreCampo:String,longitudCampo:Number):Boolean{
        return this.ctx.boe2011_validarFormato(formatoCampo,valorCampo,nombreCampo,longitudCampo);
    }
    function desRegistro347(codReg:String):Array {
        return this.ctx.boe2011_desRegistro347(codReg);
    }
    function desRegistro340(codReg:String):Array {
        return this.ctx.boe2011_desRegistro340(codReg);
    }
    function desRegistro349(codReg:String):Array {
        return this.ctx.boe2011_desRegistro349(codReg);
    }
    function generarRegistro(desReg:Array,registro:Object):String {
        return this.ctx.boe2011_generarRegistro(desReg,registro);
    }
    function generarCSV(desReg:Array,registro:Object):String {
        return this.ctx.boe2011_generarCSV(desReg,registro);
    }
    function establecerFechasPeriodo(codEjercicio:String, tipo:String, valor:String):Array{
        return this.ctx.boe2011_establecerFechasPeriodo(codEjercicio, tipo, valor);
    }
    function validarExtension(extension:String):Boolean {
        return this.ctx.boe2011_validarExtension(extension);
    }
    function consultaDeclarados347(p:Array):FLSqlQuery{
        return this.ctx.boe2011_consultaDeclarados347(p);
    }
    function establecerFromMetalico(p:Array):Array {
        return this.ctx.boe2011_establecerFromMetalico(p); 
    }
    function consultaDeclaradosMetalico(p:Array):FLSqlQuery{
        return this.ctx.boe2011_consultaDeclaradosMetalico(p);
    }
    function datosDeclarados(p:Array,qryDeclarados:FLSqlQuery):Array {
        return this.ctx.boe2011_datosDeclarados(p,qryDeclarados);
    }
    function importeTrimestre(p:Array,codEjercicio:String,cifnif:String,trimestre:String):Number{
        return this.ctx.boe2011_importeTrimestre(p,codEjercicio,cifnif,trimestre);
    }
    function identFraDeclaradosMetalico(p:Array, cifnif:String):String{
        return this.ctx.boe2011_identFraDeclaradosMetalico(p, cifnif);
    }
}

//// BOE2011 ////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubBoe2011 */
/////////////////////////////////////////////////////////////////
//// PUBBOE2011 /////////////////////////////////////////////////
class pubBoe2011 extends pubModelo347 {
    function pubBoe2011( context ) { pubModelo347 ( context ); }
    function pub_aplicarFormato(formatoCampo:String,valorCampo:String,nombreCampo:String,longitudCampo:Number):String{
        return this.aplicarFormato(formatoCampo,valorCampo,nombreCampo,longitudCampo);
    }
    function pub_validarFormato(formatoCampo:String,valorCampo:String,nombreCampo:String,longitudCampo:Number):Boolean{
        return this.validarFormato(formatoCampo,valorCampo,nombreCampo,longitudCampo);
    }
    function pub_desRegistro347(codReg:String):Array {
        return this.desRegistro347(codReg);
    }
    function pub_desRegistro340(codReg:String):Array {
        return this.desRegistro340(codReg);
    }
    function pub_desRegistro349(codReg:String):Array {
        return this.desRegistro349(codReg);
    }
    function pub_generarRegistro(desReg:Array,registro:Object):String {
        return this.generarRegistro(desReg,registro);
    }
    function pub_generarCSV(desReg:Array,registro:Object):String {
        return this.generarCSV(desReg,registro);
    }
    function pub_establecerFechasPeriodo(codEjercicio:String, tipo:String, valor:String):Array{
        return this.establecerFechasPeriodo(codEjercicio, tipo, valor);
    }
    function pub_consultaDeclarados347(p:Array):FLSqlQuery{
        return this.consultaDeclarados347(p);
    }
    function pub_establecerFromMetalico(p:Array):Array {
        return this.establecerFromMetalico(p); 
    }
    function pub_consultaDeclaradosMetalico(p:Array):FLSqlQuery{
        return this.consultaDeclaradosMetalico(p);
    }
    function pub_datosDeclarados(p:Array,qryDeclarados:FLSqlQuery):Array {
        return this.datosDeclarados(p,qryDeclarados);
    }
    function pub_importeTrimestre(p:Array,codEjercicio:String,cifnif:String,trimestre:String):Number{
        return this.importeTrimestre(p,codEjercicio,cifnif,trimestre);
    }
    function pub_identFraDeclaradosMetalico(p:Array, cifnif):String{
        return this.identFraDeclaradosMetalico(p, cifnif);
    }
}

//// PUB_BOE2011 /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition boe2011 */
/////////////////////////////////////////////////////////////////
//// BOE2011 ///////////////////////////////////////////////////

function boe2011_init()
{
    this.iface.__init();

    var util:FLUtil = new FLUtil();
    var totalClaves = util.sqlSelect("co_claveoperacion","count(codigo)","1=1");
    if (totalClaves != 24) {
        this.iface.rellenarTablaMod340ClaveOp();
    }
    
    this.iface.xGesteso = this.iface.validarExtension("gestesoreria");
    this.iface.xC0 = this.iface.validarExtension("column0");
    this.iface.xMulti = this.iface.validarExtension("multiempresa");

}

function boe2011_rellenarTablaMod340ClaveOp()
{
    var util:FLUtil = new FLUtil();
    
    var cursor:FLSqlCursor = new FLSqlCursor("co_claveoperacion");
    var claveOperacion:Array =
        [
        ["A", "Asiento resumen de facturas"],["B", "Asiento resumen de tique"],["C", "Factura con varios asientos (varios tipos impositivos)"],["D", "Factura rectificativa"],["F", "Adquisiciones realizadas por las agencias de viajes directamente en interés del viajero (Régimen especial de agencias de viajes)"],["G", "Régimen especial de grupo de entidades en IVA o IGIC (Incorpora la contraprestación real a coste)"],["H", "Régimen especial de oro de inversión"],["I", "Inversión del sujeto pasivo (ISP)"],["J", "Tiques"],["K", "Rectificación de errores registrales"],["L", "Adquisiciones a comerciantes minoristas del IGIC"],[" ","Ninguna de las anteriores"],["E","IVA/IGIC devengado pendiente de emitir factura"],["M","IVA/IGIC facturado pendiente de devengar (emitida factura)"],["N","Facturación de las prestaciones de servicios de agencias de viaje que actuan como mediadoras en nombre y por cuenta ajena (disposición adicional 4a RD 1496/2003)"],["O", "Factura emitida en sustición de tiques facturados y declarados"
],["P", "Adquisiciones intracomunitarias de bienes"],["Q", "Operaciones en las que se aplique el régimen especial de bienes usados,objetos de arte,antigüedades y objetos de colección según los artículos del 135 al 139 de la Ley 37/1992 de 28 de diciembre del Impuesto sobre el Valor Añadido"],["R", "Operación de arrendamiento de local de negocio"],["S", "Subvenciones, auxilios o ayudas satisfechas o recibidas, tanto por parte de administraciones públicas como de entidades privadas"],["T", "Cobros por cuenta de terceros de honorarios profesionales o de derechos derivados de la propiedad intelectual, industrial, de autor u otros por cuenta de sus socios, asociados o colegiados efectuados por sociedades, asociaciones, colegios profesionales u otras entidades que, entre sus funciones, realicen las de cobro"],["U", "Operación de seguros"],["V", "compras de agengias de viajes: operaciones de prestación de servicios de mediación en nombre y por cuenta ajena relativos a los servicios de transporte de viajeros y de "
+"sus equipajes que las agencias de viajes presten al destinatario de dichos servicios de transporte, de acuerdo con lo dispuesto en el apartado 3 de la disposición adicional cuarta del reglamento por el que se regulan las obligaciones de facturación"],["W", "Oparaciones sujetas al Impuesto sobre la Producción, los Servicios y la Importación en las Ciudades de Ceuta y Melilla"],["X", "Operaciones por las que los empresarios o profesionales que satisfagan compensaciones agrícolas, ganaderas y/o pesqueras hayan expedido el recibo correspondiente"]
        ];

    for (var i:Number = 0; i < claveOperacion.length; i++) {
        var existe = util.sqlSelect("co_claveoperacion","codigo","codigo='"+claveOperacion[i][0]+"'");
        if (!existe) {
            cursor.setModeAccess(cursor.Insert);
            cursor.refreshBuffer();
            cursor.setValueBuffer("codigo", claveOperacion[i][0]);
            cursor.setValueBuffer("descripcion", claveOperacion[i][1]);
            cursor.commitBuffer();
        }
    }
    
}

function boe2011_aplicarFormato(formatoCampo:String,valorCampo:String,nombreCampo:String,longitudCampo:Number):String 
{
    switch(formatoCampo){
        case "N":
        //Tipo = Numerico.
            valorCampo = parseFloat(valorCampo);
            valorCampo = flfactppal.iface.pub_cerosIzquierda(valorCampo, longitudCampo); 
            break;
        
        case "A":
        //Tipo = Alfanumerico.
        case "T":
        //Tipo = Texto
            var regExp1:RegExp = new RegExp( "^ +" );
            regExp1.global = true;
            valorCampo = valorCampo.replace(regExp1,"");
            valorCampo = valorCampo.toUpperCase();
            var regExp2:RegExp = new RegExp( " +$" );
            regExp2.global = true;
            var regExp2:RegExp = new RegExp("  ");
            regExp2.global = true;
            valorCampo = valorCampo.replace(regExp2,"");
            valorCampo = flfactppal.iface.pub_espaciosDerecha(valorCampo, longitudCampo);
            break;

        case "C":
        //Tipo = Alfanumérico relleno a ceros en cambio de espacios en blanco, utilizado para cifnif y cifnif replegal
            var regExp1:RegExp = new RegExp( "^ +" );
            regExp1.global = true;
            valorCampo = valorCampo.replace(regExp1,"");
            valorCampo = valorCampo.toUpperCase();
            var regExp2:RegExp = new RegExp( " +$" );
            regExp2.global = true;
            valorCampo = valorCampo.replace(regExp2,"");
            if (valorCampo !="") {
                valorCampo = flfactppal.iface.pub_cerosIzquierda(valorCampo, longitudCampo);
            } else {
                valorCampo = flfactppal.iface.pub_espaciosDerecha(valorCampo, longitudCampo);
            }
            break;
            
        case "B":
        //Tipo = Blancos
            valorCampo = flfactppal.iface.pub_espaciosDerecha(valorCampo, longitudCampo);
            break;
        
        default:
        //Cualquier otro tipo.
            break;
    }
        
    return valorCampo;
}

function boe2011_validarFormato(formatoCampo:String,valorCampo:String,nombreCampo:String,longitudCampo:Number):Boolean 
{
    var regExp1:RegExp;
    var valido:Number;
    switch(formatoCampo){
        case "N": regExp1 = new RegExp( "^[0-9]+$" );  break;
        case "A": regExp1 = new RegExp( "^[0-9A-ZÑÇ ,\\.:;-&]+$" ); break;
        case "T": regExp1 = new RegExp( "^[A-ZÑÇ ,\\.:;-&]+$" ); break;
        case "B": regExp1 = new RegExp( "^[ ]+$" ); break;
    }
    
    valido = valorCampo.find(regExp1);
    
    if(valido<0) {
        debug("valorCampo = ["+valorCampo+"] + valido = ["+valido+"]");
        debug("Campo "+nombreCampo+" , formato {"+formatoCampo+"} no cumple RegExp {"+regExp1+"}");
        return false;
    }
            
    if (valorCampo.length != longitudCampo) {
         debug("nombreCampo = ["+nombreCampo+"] + valorCampo = ["+valorCampo+"]");
         debug("Error de longitud = Campo: ["+valorCampo.length+"] / formato = ["+longitudCampo+"]");
        return false;
    }
    
    return true;
}

function boe2011_desRegistro347(codReg:String):Array
{
    var ret = [];
    //  [REGISTRO  POSICION  LONGITUD   TIPO]
    /*  TIPO:   N : NUMERICO
     *          A : ALFANUMERICO
     *          T : ALFABETICO (TEXTO)
     *          B : ESPACIOS EN BLANCO
     *          C : ALFANUMERICO RELLENO DE CEROS HASTA LONGITUD
    */
    
    switch (codReg) {
      
    /** \D Registro de declarante \end */
    case "1":
        ret =   [
                ["tiporeg",             1,      1,      "N" ],
                ["modelo",              2,      3,      "N" ],
                ["ejercicio",           5,      4,      "N" ],
                ["cifnif",              9,      9,      "C" ],
                ["apellidosnombrers",   18,     40,     "A" ],
                ["tiposoporte",         58,     1,      "T" ],
                ["telefono",            59,     9,      "N" ],
                ["contacto",            68,     40,     "A" ],
                ["justificante",        108,    13,     "N" ],
                ["complementaria",      121,    1,      "T" ],
                ["sustitutiva",         122,    1,      "T" ],
                ["jusanterior",         123,    13,     "N" ],
                ["totalentidades",      136,    9,      "N" ],
                ["signo",               145,    1,      "T" ],
                ["importetotal",        146,    15,     "N" ],
                ["totalinmuebles",      161,    9,      "N" ],
                ["totalarrendamiento",  170,    15,     "N" ],
                ["blancos",             185,    206,    "B" ],
                ["nifreplegal",         391,    9,      "C" ],
                ["blancos2",            400,    88,     "B" ],
                ["sello",               488,    13,     "B" ]
                ];
      break;
    
    case "2d":
      /** \D Registro de declarados \end */
        ret =   [
                ["tiporeg",             1,      1,      "N" ],
                ["modelo",              2,      3,      "N" ],
                ["ejercicio",           5,      4,      "N" ],
                ["cifnif",              9,      9,      "C" ],
                ["nifdeclarado",        18,     9,      "C" ],
                ["nifreplegal",         27,     9,      "C" ],
                ["apellidosnombrers",   36,     40,     "A" ],
                ["tipohoja",            76,     1,      "T" ],
                ["codprovincia",        77,     2,      "N" ],
                ["codpais",             79,     2,      "T" ],
                ["blancos",             81,     1,      "B" ],
                ["clavecodigo",         82,     1,      "T" ],
                ["signo",               83,     1,      "T" ],
                ["importe",             84,     15,     "N" ],
                ["seguro",              99,     1,      "T" ],
                ["arrendlocal",         100,    1,      "T" ],
                ["importemetalico",     101,    15,     "N" ],
                ["signoinmuebles",      116,    1,      "T" ],
                ["importeinmuebles",    117,    15,     "N" ],
                ["ejerciciometalico",   132,    4,      "N" ],
                ["signo1t",             136,    1,      "T" ],
                ["importe1t",           137,    15,     "N" ],
                ["signoinmuebles1t",    152,    1,      "T" ],
                ["importeinmuebles1t",  153,    15,     "N" ],
                ["signo2t",             168,    1,      "T" ],
                ["importe2t",           169,    15,     "N" ],
                ["signoinmuebles2t",    184,    1,      "T" ],
                ["importeinmuebles2t",  185,    15,     "N" ],
                ["signo3t",             200,    1,      "T" ],
                ["importe3t",           201,    15,     "N" ],
                ["signoinmuebles3t",    216,    1,      "T" ],
                ["importeinmuebles3t",  217,    15,     "N" ],
                ["signo4t",             232,    1,      "T" ],
                ["importe4t",           233,    15,     "N" ],
                ["signoinmuebles4t",    248,    1,      "T" ],
                ["importeinmuebles4t",  249,    15,     "N" ],
                ["blancos2",            264,    237,    "B" ]
                ];
        break;

      /** \D Registro de inmuebles \end */
    case "2i":
        ret =   [
                ["tiporeg",             1,      1,      "N" ],
                ["modelo",              2,      3,      "N" ],
                ["ejercicio",           5,      4,      "N" ],
                ["cifnif",              9,      9,      "C" ],
                ["nifarrendatario",     18,     9,      "C" ],
                ["nifreplegal",         27,     9,      "C" ],
                ["apellidosnombrers",   36,     40,     "A" ],
                ["tipohoja",            76,     1,      "T" ],
                ["blancos",             77,     23,     "B" ],
                ["importe",             100,    15,     "N" ],
                ["situacion",           115,    1,      "T" ],
                ["refcatastral",        116,    25,     "A" ],
                ["codtipovia",          141,    5,      "T" ],
                ["nombrevia",           146,    50,     "A" ],
                ["tiponumeracion",      196,    3,      "A" ],
                ["numero",              199,    5,      "N" ],
                ["califnumero",         204,    3,      "A" ],
                ["bloque",              207,    3,      "A" ],
                ["portal",              210,    3,      "A" ],
                ["escalera",            213,    3,      "A" ],
                ["piso",                216,    3,      "A" ],
                ["puerta",              219,    3,      "A" ],
                ["complemento",         222,    40,     "A" ],
                ["localidad",           262,    30,     "A" ],
                ["municipio",           292,    30,     "A" ],
                ["codmunicipio",        322,    5,      "A" ],
                ["codprovincia",        327,    2,      "N" ],
                ["codpostal",           329,    5,      "N" ],
                ["blancos2",            334,    167,    "B" ]
                ];
      break;
    }

  return ret;
}

function boe2011_desRegistro340(codReg:String):Array
{
    var ret = [];
    //  [REGISTRO  POSICION  LONGITUD   TIPO]
    /*  TIPO:   N : NUMERICO
     *          A : ALFANUMERICO
     *          T : ALFABETICO (TEXTO)
     *          B : ESPACIOS EN BLANCO
    */
    
    switch (codReg) {
      
    /** \D Registro de declarante \end */
    case "1":
        ret =   [
                ["tiporeg",             1,      1,      "N",    "F" ],
                ["modelo",              2,      3,      "N",    "F" ],
                ["ejercicio",           5,      4,      "N",    "F" ],
                ["cifnif",              9,      9,      "C",    "F" ],
                ["apellidosnombrers",   18,     40,     "A",    "F" ],
                ["tiposoporte",         58,     1,      "T",    "F" ],
                ["telefono",            59,     9,      "N",    "F" ],
                ["contacto",            68,     40,     "A",    "F" ],
                ["numidentificativo",   108,    13,     "N",    "F" ],
                ["complementaria",      121,    1,      "T",    "F" ],
                ["sustitutiva",         122,    1,      "T",    "F" ],
                ["jusanterior",         123,    13,     "N",    "F" ],
                ["periodo",             136,    2,      "N",    "F" ],
                ["registros",           138,    9,      "N",    "F" ],
                ["sbaseimponible",      147,    1,      "T",    "F" ],
                ["baseimponible",       148,    17,     "N",    "T" ],
                ["scuotaimpuesto",      165,    1,      "T",    "F" ],
                ["cuotaimpuesto",       166,    17,     "N",    "T" ],
                ["stotalfacturas",      183,    1,      "T",    "F" ],
                ["totalfacturas",       184,    17,     "N",    "T" ],
                ["blancos",             201,    190,    "B",    "F" ],
                ["cifnifrepres",        391,    9,      "C",    "F" ],
                ["codigoelectronico",   400,    16,     "B",    "F" ],
                ["blancos",             416,    85,     "B",    "F" ]
                ];
      break;
    
    case "2e":
      /** \D Registro de declarado facturas emitidas \end */
        ret =   [
                ["tiporeg",             1,      1,      "N",    "F" ],
                ["modelo",              2,      3,      "N",    "F" ],
                ["ejercicio",           5,      4,      "N",    "F" ],
                ["cifnif",              9,      9,      "C",    "F" ],
                ["nifdeclarado",        18,     9,      "C",    "F" ],
                ["cifnifrp",            27,     9,      "C",    "F" ],
                ["apellidosnomrs",      36,     40,     "A",    "F" ],
                ["codpais",             76,     2,      "T",    "F" ],
                ["claveidentificacion", 78,     1,      "N",    "F" ],
                ["numidentificacion",   79,     20,     "A",    "F" ],
                ["tipolibro",           99,     1,      "T",    "F" ],
                ["operacion",           100,    1,      "T",    "F" ],
                ["fechaexpedicion",     101,    8,      "N",    "F" ],
                ["fechaoperacion",      109,    8,      "N",    "F" ],
                ["tipoimpositivo",      117,    5,      "N",    "T" ],
                ["sbaseimponible",      122,    1,      "T",    "F" ],
                ["baseimponible",       123,    13,     "N",    "T" ],
                ["scuotaimpuesto",      136,    1,      "T",    "F" ],
                ["cuotaimpuesto",       137,    13,     "N",    "T" ],
                ["simportetotal",       150,    1,      "T",    "F" ],
                ["importetotal",        151,    13,     "N",    "T" ],
                ["sbaseimponiblecoste", 164,    1,      "T",    "F" ],
                ["baseimponiblecoste",  165,    13,     "N",    "T" ],
                ["idenfactura",         178,    40,     "A",    "F" ],
                ["numregistro",         218,    18,     "A",    "F" ],
                ["numfacturas",         236,    8,      "N",    "F" ],
                ["desgloseregistro",    244,    2,      "N",    "F" ],
                ["intervidentif",       246,    40,     "A",    "F" ],
                ["intervidentif2",      286,    40,     "A",    "F" ],
                ["identfacturarect",    326,    40,     "A",    "F" ],
                ["tiporecequi",         366,    5,      "N",    "T" ],
                ["scuotarecequi",       371,    1,      "T",    "F" ],
                ["cuotarecequi",        372,    13,     "N",    "T" ],
                ["situacioninmueble",   385,    1,      "N",    "F" ],
                ["refcatastral",        386,    25,     "A",    "F" ],
                ["importemetalico",     411,    15,     "N",    "T" ],
                ["ejerciciometalico",   426,    4,      "N",    "F" ],
                ["importeinmuebles",    430,    15,     "N",    "T" ],
                ["blancos",             445,    56,      "B",     "F" ]
                ];
        break;

    case "2r":
      /** \D Registro de declarado facturas recibidas \end */
        ret =   [
                ["tiporeg",             1,      1,      "N",    "F" ],
                ["modelo",              2,      3,      "N",    "F" ],
                ["ejercicio",           5,      4,      "N",    "F" ],
                ["cifnif",              9,      9,      "C",    "F" ],
                ["nifdeclarado",        18,     9,      "C",    "F" ],
                ["cifnifrp",            27,     9,      "C",    "F" ],
                ["apellidosnomrs",      36,     40,     "A",    "F" ],
                ["codpais",             76,     2,      "T",    "F" ],
                ["claveidentificacion", 78,     1,      "N",    "F" ],
                ["numidentificacion",   79,     20,     "A",    "F" ],
                ["tipolibro",           99,     1,      "T",    "F" ],
                ["operacion",           100,    1,      "T",    "F" ],
                ["fechaexpedicion",     101,    8,      "N",    "F" ],
                ["fechaoperacion",      109,    8,      "N",    "F" ],
                ["tipoimpositivo",      117,    5,      "N",    "T" ],
                ["sbaseimponible",      122,    1,      "T",    "F" ],
                ["baseimponible",       123,    13,     "N",    "T" ],
                ["scuotaimpuesto",      136,    1,      "T",    "F" ],
                ["cuotaimpuesto",       137,    13,     "N",    "T" ],
                ["simportetotal",       150,    1,      "T",    "F" ],
                ["importetotal",        151,    13,     "N",    "T" ],
                ["sbaseimponiblecoste", 164,    1,      "T",    "F" ],
                ["baseimponiblecoste",  165,    13,     "N",    "T" ],
                ["idenfactura",         178,    40,     "A",    "F" ],
                ["numregistro",         218,    18,     "A",    "F" ],
                ["numfacturas",         236,    18,     "N",    "F" ],
                ["desgloseregistro",    254,    2,      "N",    "F" ],
                ["intervidentif",       256,    40,     "A",    "F" ],
                ["intervidentif2",      296,    40,     "A",    "F" ],
                ["scuotadeducible",     336,    1,      "T",    "F" ],
                ["cuotadeducible",      337,    13,     "N",    "T" ],
                ["blancos",             350,    151,    "B",    "F" ]
                ];
        break;
        
    case "2b":
      /** \D Registro de declarado bienes de inversion \end */
        ret =   [
                ["tiporeg",             1,      1,      "N",    "F" ],
                ["modelo",              2,      3,      "N",    "F" ],
                ["ejercicio",           5,      4,      "N",    "F" ],
                ["cifnif",              9,      9,      "C",    "F" ],
                ["nifdeclarado",        18,     9,      "C",    "F" ],
                ["cifnifrp",            27,     9,      "C",    "F" ],
                ["apellidosnomrs",      36,     40,     "A",    "F" ],
                ["codpais",             76,     2,      "T",    "F" ],
                ["claveidentificacion", 78,     1,      "N",    "F" ],
                ["numidentificacion",   79,     20,     "A",    "F" ],
                ["tipolibro",           99,     1,      "T",    "F" ],
                ["operacion",           100,    1,      "T",    "F" ],
                ["fechaexpedicion",     101,    8,      "N",    "F" ],
                ["fechaoperacion",      109,    8,      "N",    "F" ],
                ["tipoimpositivo",      117,    5,      "N",    "T" ],
                ["sbaseimponible",      122,    1,      "T",    "F" ],
                ["baseimponible",       123,    13,     "N",    "T" ],
                ["scuotaimpuesto",      136,    1,      "T",    "F" ],
                ["cuotaimpuesto",       137,    13,     "N",    "T" ],
                ["simportetotal",       150,    1,      "T",    "F" ],
                ["importetotal",        151,    13,     "N",    "T" ],
                ["sbaseimponiblecoste", 164,    1,      "T",    "F" ],
                ["baseimponiblecoste",  165,    13,     "N",    "T" ],
                ["idenfactura",         178,    40,     "A",    "F" ],
                ["numregistro",         218,    18,     "A",    "F" ],
                ["prorrata",            236,    3,      "N",    "F" ],
                ["sreganual",           239,    1,      "T",    "F" ],
                ["reganual",            240,    13,     "N",    "T" ],
                ["idententrega",        253,    40,     "A",    "F" ],
                ["sreganualefect",      293,    1,      "T",    "F" ],
                ["reganualefect",       294,    13,     "N",    "T" ],
                ["fechautilizacion",    307,    8,      "N",    "F" ],
                ["identbien",           315,    17,     "A",    "F" ],
                ["blancos",             332,    169,    "B",    "F" ]
                ];
        break;
        
    case "2i":
      /** \D Registro de declarado de determinadas operaciones intracomunitarias \end */
        ret =   [
                ["tiporeg",             1,      1,      "N",    "F" ],
                ["modelo",              2,      3,      "N",    "F" ],
                ["ejercicio",           5,      4,      "N",    "F" ],
                ["cifnif",              9,      9,      "C",    "F" ],
                ["nifdeclarado",        18,     9,      "C",    "F" ],
                ["cifnifrp",            27,     9,      "C",    "F" ],
                ["apellidosnomrs",      36,     40,     "A",    "F" ],
                ["codpais",             76,     2,      "T",    "F" ],
                ["claveidentificacion", 78,     1,      "N",    "F" ],
                ["numidentificacion",   79,     20,     "A",    "F" ],
                ["tipolibro",           99,     1,      "T",    "F" ],
                ["operacion",           100,    1,      "T",    "F" ],
                ["fechaexpedicion",     101,    8,      "N",    "F" ],
                ["fechaoperacion",      109,    8,      "N",    "F" ],
                ["tipoimpositivo",      117,    5,      "N",    "T" ],
                ["sbaseimponible",      122,    1,      "T",    "F" ],
                ["baseimponible",       123,    13,     "N",    "T" ],
                ["scuotaimpuesto",      136,    1,      "T",    "F" ],
                ["cuotaimpuesto",       137,    13,     "N",    "T" ],
                ["simportetotal",       150,    1,      "T",    "F" ],
                ["importetotal",        151,    13,     "N",    "T" ],
                ["sbaseimponiblecoste", 164,    1,      "T",    "F" ],
                ["baseimponiblecoste",  165,    13,     "N",    "T" ],
                ["idenfactura",         178,    40,     "A",    "F" ],
                ["numregistro",         218,    18,     "A",    "F" ],
                ["tipoopintra",         236,    1,      "T",    "F" ],
                ["clavedeclarado",      237,    1,      "T",    "F" ],
                ["codestadomiembro",    238,    2,      "A",    "F" ],
                ["plazooperacion",      240,    3,      "N",    "F" ],
                ["descripcion",         243,    35,     "A",    "F" ],
                ["domicilio",           278,    40,     "A",    "F" ],
                ["poblacion",           318,    22,     "A",    "F" ],
                ["codpostal",           340,    10,     "A",    "F" ],
                ["otrasfact",           350,    135,    "A",    "F" ],
                ["blancos",             485,    16,     "B",    "F" ]
                ];
        break;
    }

  return ret;
}

/** El modelo 349 no se modifica en el boletin oficial del 2011, pero se agregan cambios en esta clase como mejora para la generación del registro a presentar */
function boe2011_desRegistro349(codReg:String):Array
{
    var ret = [];
    //  [REGISTRO  POSICION  LONGITUD   TIPO]
    /*  TIPO:   N : NUMERICO
     *          A : ALFANUMERICO
     *          T : ALFABETICO (TEXTO)
     *          B : ESPACIOS EN BLANCO
     *          C : ALFANUMERICO RELLENO DE CEROS HASTA LONGITUD
    */

    switch (codReg) {

    /** \D Registro de declarante \end */
    case "1":
        ret =   [
                ["tiporeg",             1,      1,      "N" ],
                ["modelo",              2,      3,      "N" ],
                ["ejercicio",           5,      4,      "N" ],
                ["cifnifpres",          9,      9,      "C" ],
                ["nombrepres",          18,     40,     "A" ],
                ["tiposoporte",         58,     1,      "T" ],
                ["telefonorel",         59,     9,      "N" ],
                ["personarel",          68,     40,     "A" ],
                ["numjustificante",     108,    13,     "N" ],
                ["complementaria",      121,    1,      "T" ],
                ["sustitutiva",         122,    1,      "T" ],
                ["jusanterior",         123,    13,     "N" ],
                ["periodo",             136,    2,      "A" ],
                ["numtotaloi",          138,    9,      "N" ],
                ["importetotaloi",      147,    15,     "N" ],
                ["numtotaloirec",       162,    9,      "N" ],
                ["importetotaloirec",   171,    15,     "N" ],
                ["cambioperiodicidad",  186,    1,      "T" ],
                ["blancos",             187,    204,    "B" ],
                ["cifnifreplegal",      391,    9,      "C" ],
                ["blancos2",            400,    88,     "B" ],
                ["sello",               488,    13,     "B" ]
                ];
      break;

    case "2":
      /** \D Registro de declarados \end */
        ret =   [
                ["tiporeg",             1,      1,      "N" ],
                ["modelo",              2,      3,      "N" ],
                ["ejercicio",           5,      4,      "N" ],
                ["cifnifpres",          9,      9,      "C" ],
                ["blancos",             18,     58,     "B" ],
                ["codue",               76,     2,      "T" ],
                ["cifnif",              78,     15,     "A" ],
                ["nombre",              93,     40,     "A" ],
                ["clave",               133,    1,      "T" ],
                ["baseimponible",       134,    13,     "N" ],
                ["blancos2",            147,    354,    "B" ]
                ];
        break;

    case "2r":
      /** \D Registro de rectificaciones \end */
        ret =   [
                ["tiporeg",             1,      1,      "N" ],
                ["modelo",              2,      3,      "N" ],
                ["ejercicio",           5,      4,      "N" ],
                ["cifnifpres",          9,      9,      "C" ],
                ["blancos",             18,     58,     "B" ],
                ["codue",               76,     2,      "T" ],
                ["cifnif",              78,     15,     "A" ],
                ["nombre",              93,     40,     "A" ],
                ["clave",               133,    1,      "T" ],
                ["blancos2",            134,    13,     "B" ],
                ["codejercicio",        147,    4,      "N" ],
                ["periodo",             151,    2,      "A" ],
                ["bianterior",          153,    13,     "N" ],
                ["bianterior",          166,    13,     "N" ],
                ["blancos3",            179,    322,    "B" ]
                ];
        break;
    }

  return ret;
}

function boe2011_generarRegistro(desReg:Array,registro:Object):String {
    
    var contenidoReg:String="";
    var longReg:Number = 0;
    var tipoReg:Number = registro["tiporeg"];
    
    var nombreCampo:String = "";
    var posIni:Number = 0;
    var longitudCampo:Number = 0;
    var formatoCampo:String="";
    var valorCampo;
    
    for (var i = 0; i < desReg.length; i++) {
        nombreCampo = desReg[i][0];
        posIni = desReg[i][1];
        longitudCampo = desReg[i][2];
        formatoCampo = desReg[i][3];
        valorCampo = registro[nombreCampo].toString();
        
        if ((contenidoReg.length + 1) != posIni) {
            this.iface.error += "Registro tipo "+tipoReg+" - Campo:"+nombreCampo+" - Valor :"+valorCampo+" - Error de longitud, No empieza en posición "+posIni+"\n";
        }
        
        debug("1 Tiporeg["+tipoReg+"] - "+nombreCampo+"["+valorCampo+"] - PosIni["+(contenidoReg.length + 1)+"] - Longitud["+valorCampo.length+"]");
        
        valorCampo = this.iface.aplicarFormato(formatoCampo,valorCampo,nombreCampo,longitudCampo);

        if(!this.iface.validarFormato(formatoCampo,valorCampo,nombreCampo,longitudCampo)) {
            this.iface.error += "Registro tipo "+tipoReg+" - Campo:"+nombreCampo+" - Valor :"+valorCampo+" - Error de formato\n";
        }
        
        debug("2 Tiporeg["+tipoReg+"] - "+nombreCampo+"["+valorCampo+"] - PosIni["+(contenidoReg.length + 1)+"] - Longitud["+valorCampo.length+"]");
        
        contenidoReg += valorCampo;
        longReg = (posIni+longitudCampo)-1;
    }
    
    if (contenidoReg.length != longReg) {
        this.iface.error += "Registro tipo "+tipoReg+" - Error de longitud de registro";
    }
    
    return contenidoReg;
}

function boe2011_generarCSV(desReg:Array,registro:Object):String {
    
    var contenidoReg:String;
    var longReg:Number = 0;
    var tipoReg:Number = registro["tiporeg"];
    
    var nombreCampo:String = "";
    var posIni:Number = 0;
    var longitudCampo:Number = 0;
    var formatoCampo:String="";
    var compuesto:String ="";
    var valorCampo;
    
    for (var i = 0; i < desReg.length; i++) {
        nombreCampo = desReg[i][0];
        posIni = desReg[i][1];
        longitudCampo = desReg[i][2];
        formatoCampo = desReg[i][3];
        compuesto = desReg[i][4];
        valorCampo = registro[nombreCampo];
        
        valorCampo = this.iface.aplicarFormato(formatoCampo,valorCampo,nombreCampo,longitudCampo);

        if(!this.iface.validarFormato(formatoCampo,valorCampo,nombreCampo,longitudCampo)) {
            this.iface.error += "Registro tipo "+tipoReg+" - Campo:"+nombreCampo+" - Valor :"+valorCampo+" - Error de formato\n";
        }
        
        debug("Tiporeg["+tipoReg+"] - "+nombreCampo+"["+valorCampo+"] - PosIni["+(contenidoReg.length + 1)+"] - Longitud["+valorCampo.length+"]");
        
        if (compuesto == "T") {
            /*Campo de numero compuesto por enteros y decimales*/
            var sValorCampo:String = valorCampo.toString();
            var lEnteros:Number = parseFloat(longitudCampo - 2);
            var lDecimales:Number = 2;
            var sDecimales:String = sValorCampo.right(2);
            var nEnteros:Number = parseFloat(sValorCampo.left(lEnteros));
            var sEnteros:String = nEnteros.toString();
            valorCampo = sEnteros+","+sDecimales;
        }
        
        if (i == 0) {
            contenidoReg += valorCampo;
        } else {
            contenidoReg += "|"+valorCampo;
        }
    }
    
    return contenidoReg;
}

    
function boe2011_establecerFechasPeriodo(codEjercicio:String, tipo:String, valor:String):Array
{
    var util:FLUtil = new FLUtil();

    var fechaInicio:Date = new Date(Date.parse( "2001-01-01T00:00:00" ));
    var fechaFin:Date = new Date(Date.parse( "2001-01-01T00:00:00" ));
    var fechasP:Array = [];
    fechasP["inicio"] = "0000-00-00";
    fechasP["fin"] = "0000-00-00";

    var inicioEjercicio = util.sqlSelect("ejercicios", "fechainicio", "codejercicio = '" + codEjercicio + "'");
    if (!inicioEjercicio) {
        MessageBox.warning(util.translate("scripts","No se ha encontrado la fecha inicio del ejercicio  %1.No es posible continuar").arg(codEjercicio),MessageBox.Ok,MessageBox.NoButton);
        return fechasP;
    }
        
    fechaInicio.setYear(inicioEjercicio.getYear());
    fechaFin.setYear(inicioEjercicio.getYear());
    fechaInicio.setDate(1);


    switch (tipo) {
        case "Trimestre": 
            switch (valor){ 
                case "1T": 
                    fechaInicio.setMonth(1);
                    fechaFin.setMonth(3);
                    fechaFin.setDate(31);
                    break;
                           
                case "2T":
                    fechaInicio.setMonth(4);
                    fechaFin.setMonth(6);
                    fechaFin.setDate(30);
                    break;
                    
                case "3T":
                    fechaInicio.setMonth(7);
                    fechaFin.setMonth(9);
                    fechaFin.setDate(30);
                    break;
                case "4T": 
                    fechaInicio.setMonth(10);
                    fechaFin.setMonth(12);
                    fechaFin.setDate(31);
                    break;
            }
            break;
            
        case "Mes": 
                var numMes:Number = parseInt(valor);
                fechaInicio.setDate(1);
                fechaInicio.setMonth(numMes);
                fechaFin = util.addMonths(fechaInicio, 1);
                fechaFin = util.addDays(fechaFin, -1);
                break;
        
    }
    
    if (fechaInicio && fechaFin) {
        fechasP["inicio"] = fechaInicio.toString().left(10);
        fechasP["fin"] = fechaFin.toString().left(10);
    } 
   

    return fechasP;
}

/*Valida extensiones en la base de datos*/
function boe2011_validarExtension(extension:String):Boolean
{
    var util = new FLUtil();
    
    var tabla:String;
    var campo:String;
    
    switch(extension) {
        case "gestesoreria":
            tabla = "reciboscli";
            campo = "codejercicio";
            break;
            
        case "multiempresa":
            tabla = "ejercicios";
            campo = "idempresa";
            break;
            
        case "column0":
            tabla = "empresa";
            campo = "column0";
            break;
    }
    
    
    var fieldList:String = util.nombreCampos(tabla);
    var ret:Boolean = false;

    for (var i:Number = 0; i<fieldList.length; i++) {
        var nombreCampo:String = fieldList[i];
        if (nombreCampo == campo) {
            ret = true;
            break;
        }
    }
    return ret;
}

function boe2011_consultaDeclarados347(p:Array):FLSqlQuery {
    
    var qryDeclarados= new FLSqlQuery;
    var where:String = p.where;
    if (p.origen == "Contabilidad"){
        /*Contabilidad"*/
        if (p.clave == "B"){
            qryDeclarados.setTablesList("clientes,co_asientos,co_partidas,co_subcuentascli");
            qryDeclarados.setSelect("cp.cifnif, SUM(p.debe - p.haber)");
            qryDeclarados.setFrom("co_partidas p INNER JOIN co_subcuentascli scp ON p.idsubcuenta = scp.idsubcuenta INNER JOIN clientes cp ON scp.codcliente = cp.codcliente INNER JOIN co_asientos a ON p.idasiento = a.idasiento");
            p["groupby"] = "cp.cifnif";
            p["having"]  = "ABS(SUM(p.debe - p.haber)) > "+p.importemin;
        
        }else if (p.clave == "A"){
            qryDeclarados.setTablesList("proveedores,co_asientos,co_partidas,co_subcuentasprov");
            qryDeclarados.setSelect("cp.cifnif, SUM(p.haber - p.debe)");
            qryDeclarados.setFrom("co_partidas p INNER JOIN co_subcuentasprov scp ON p.idsubcuenta = scp.idsubcuenta INNER JOIN proveedores cp ON scp.codproveedor = cp.codproveedor INNER JOIN co_asientos a ON a.idasiento = p.idasiento");
            p["groupby"] = "cp.cifnif";
            p["having"]  = "ABS(SUM(p.haber - p.debe)) > "+p.importemin;
        }
    } else {
        /*Facturación"*/
        var tablaOrig:String;
        if (p.clave == "B") tablaOrig = "facturascli";
        if (p.clave == "A") tablaOrig = "facturasprov";
        qryDeclarados.setTablesList(tablaOrig+",co_asientos");
        qryDeclarados.setSelect("f.cifnif,SUM(f.total)");
        qryDeclarados.setFrom(tablaOrig+" f INNER JOIN co_asientos a on f.idasiento = a.idasiento");
        p["groupby"] = "f.cifnif";
        p["having"]  = "ABS(SUM(f.total)) > "+p.importemin;
    }
    
    if (p["groupby"]) {
        where += " GROUP BY "+p["groupby"];
    }
    
    if (p["having"]) {
        where += " HAVING "+p["having"];
    }
    
    qryDeclarados.setWhere(where);
    debug("Consulta Declarados 347 / Clave:"+p.clave+" Tipo:"+p.tipoimp+" >>> "+qryDeclarados.sql());
    return qryDeclarados;

}

function boe2011_establecerFromMetalico(p:Array):Array
{
    var util= new FLUtil();

    p["tablas"] = [];
    
    if (p.clave == "A") {
        p["tablas"]["recibos"] = "recibosprov";
        p["tablas"]["pagosdevol"] = "pagosdevolprov";
        p["tablas"]["facturas"] = "facturasprov";
    } else if (p.clave == "B") {
        p["tablas"]["recibos"] = "reciboscli";
        p["tablas"]["pagosdevol"] = "pagosdevolcli";
        p["tablas"]["facturas"] = "facturascli";
    }
    
    p["from"] = p["tablas"]["recibos"]+" r INNER JOIN (SELECT r1.idrecibo,max(p1.idpagodevol) AS idpagodevol FROM "+p["tablas"]["recibos"]+" r1 INNER JOIN "+p["tablas"]["pagosdevol"]+" p1 ON r1.idrecibo = p1.idrecibo GROUP BY r1.idrecibo) x ON r.idrecibo = x.idrecibo INNER JOIN "+p["tablas"]["pagosdevol"]+" p on x.idrecibo = p.idrecibo AND x.idpagodevol = p.idpagodevol";
    
    if (flcontmode.iface.xGesteso) {
        p["from"] += " LEFT JOIN "+  p["tablas"]["facturas"] +" f on f.idfactura = r.idfactura ";
    } else {
        p["from"] += " INNER JOIN "+  p["tablas"]["facturas"] +" f on f.idfactura = r.idfactura ";
    }
    
    return p;
}

function boe2011_consultaDeclaradosMetalico(p:Array):FLSqlQuery {
    
    var where:String = p.where;
    
    var qryFiltro = new FLSqlQuery;
    var filtroCifNif:String = "'-1'";
    qryFiltro.setTablesList(p["tablas"]["recibos"]+","+p["tablas"]["pagosdevol"]+","+p["tablas"]["facturas"]);
    qryFiltro.setSelect(p["campos"]["cifnif"]+","+p["campos"]["valor"]);
    qryFiltro.setFrom(p["from"]);
    p["groupby"] = p["campos"]["cifnif"];
    p["having"]  = p["campos"]["valor"]+" > "+p.importemin;
    
    if (p["groupby"]) {
        where += " GROUP BY "+p["groupby"];
    }
    
    if (p["having"]) {
        where += " HAVING "+p["having"];
    }
    
    qryFiltro.setWhere(where);
    debug("ImporteEfectivo filtro>> "+qryFiltro.sql());
    qryFiltro.setForwardOnly(true);
    qryFiltro.exec();
    while (qryFiltro.next()){
        if (filtroCifNif) filtroCifNif+= ",";
        filtroCifNif += "'"+qryFiltro.value(0)+"'";
    }
    
    var qryDeclarados= new FLSqlQuery;
    qryDeclarados.setTablesList(p["tablas"]["recibos"]+","+p["tablas"]["pagosdevol"]+","+p["tablas"]["facturas"]);
    qryDeclarados.setSelect(p["campos"]["cifnif"]+","+p["campos"]["valor"]+","+p["campos"]["codejercicio"]);
    qryDeclarados.setFrom(p["from"]);
    where =  p.where;
    where += " AND "+p["campos"]["cifnif"]+" IN("+filtroCifNif+")";
    p["groupby"] = p["campos"]["cifnif"]+","+p["campos"]["codejercicio"];
    
    if (p["groupby"]) {
        where += " GROUP BY "+p["groupby"];
    }
    
    qryDeclarados.setWhere(where);
    debug("Consulta Declarados Metalico/ Clave:"+p.clave+" Tipo:"+p.tipoimp+" >>> "+qryDeclarados.sql());
    return qryDeclarados;

}

function boe2011_datosDeclarados(p:Array,qryDeclarados:FLSqlQuery):Array {
        
    var datos:Array;
    var util= new FLUtil();
    datos["importe"] = parseFloat(qryDeclarados.value(1));

    if (p.clave == "B"){
        datos["codCP"] = util.sqlSelect("clientes", "codcliente", "cifnif = '" + qryDeclarados.value(0) + "' ORDER BY codcliente");
        datos["codPais"] = util.sqlSelect("dirclientes dc INNER JOIN paises p ON dc.codpais = p.codpais", "p.codiso", "dc.codcliente = '" + datos["codCP"] + "' AND dc.domfacturacion = true", "dirclientes,paises");
        datos["nombreCP"] = util.sqlSelect("clientes", "nombre", "cifnif = '" + qryDeclarados.value(0) + "' ORDER BY codcliente");
        datos["codProvincia"] = util.sqlSelect("dirclientes dc INNER JOIN provincias p ON dc.idprovincia = p.idprovincia", "p.codigo", "dc.codcliente = '" + datos["codCP"] + "' AND dc.domfacturacion = true", "dirclientes,provincias");
        datos["tipoId"] = util.sqlSelect("clientes", "tipoidfiscal", "codcliente = '" + datos["codCP"] + "' ORDER BY codcliente");
    }else if (p.clave == "A"){
        datos["codCP"] = util.sqlSelect("proveedores", "codproveedor", "cifnif = '" + qryDeclarados.value(0) + "' ORDER BY codproveedor");
        datos["codPais"] = util.sqlSelect("dirproveedores dp INNER JOIN paises p ON dp.codpais = p.codpais", "p.codiso", "dp.codproveedor = '" + datos["codCP"] + "' AND dp.direccionppal = true", "dirproveedores,paises");
        datos["nombreCP"] = util.sqlSelect("proveedores", "nombre", "cifnif = '" + qryDeclarados.value(0) + "' ORDER BY codproveedor");
        datos["codProvincia"] = util.sqlSelect("dirproveedores dp INNER JOIN provincias p ON dp.idprovincia = p.idprovincia", "p.codigo", "dp.codproveedor = '" + datos["codCP"] + "' AND dp.direccionppal = true", "dirproveedores,provincias");
        datos["tipoId"] = util.sqlSelect("proveedores", "tipoidfiscal", "codproveedor = '" + datos["codCP"] + "' ORDER BY codproveedor");
    
    }

    datos["nombreCP"] = flcontmode.iface.pub_formatearTexto(datos["nombreCP"]);
    datos["cifCP"] = flcontmode.iface.pub_limpiarCifNif(qryDeclarados.value(0));
    
    if (p.tipoimp == "Importe") {
        datos["importe"] = qryDeclarados.value(1);
        datos["importe1t"] = this.iface.importeTrimestre(p,qryDeclarados.value(0),"1T");
        datos["importe2t"] = this.iface.importeTrimestre(p,qryDeclarados.value(0),"2T");
        datos["importe3t"] = this.iface.importeTrimestre(p,qryDeclarados.value(0),"3T");
        datos["importe4t"] = this.iface.importeTrimestre(p,qryDeclarados.value(0),"4T");
    } else if (p.tipoimp == "ImporteEfectivo") {
        datos["importeMetalico"] = qryDeclarados.value(1);
        datos["ejercicioMetalico"] = util.sqlSelect("ejercicios","date_part('year',fechainicio)","codejercicio='"+qryDeclarados.value(2)+"'");
    }
                
    return datos;
}

function boe2011_importeTrimestre(p:Array,cifnif:String,trimestre:String):Number{
    
    var fechaT:Array = flcontmode.iface.pub_establecerFechasPeriodo(p.codejercicio,"Trimestre",trimestre);
    var util= new FLUtil();
    var tablas:String;
    var tablasF:String;
    var valor:String;
    var condicion:String = p.where;
    
    if (p.origen == "Contabilidad") {
        condicion += " AND cp.cifnif = '"+cifnif+"' AND a.fecha between '"+fechaT.inicio+"' AND '"+fechaT.fin+"'";
        if (p.clave == "B") {
            valor = "SUM(p.debe - p.haber)";
            tablas = "clientes,co_asientos,co_partidas,co_subcuentascli";
            tablasF = "co_partidas p INNER JOIN co_subcuentascli scp ON p.idsubcuenta = scp.idsubcuenta INNER JOIN clientes cp ON scp.codcliente = cp.codcliente INNER JOIN co_asientos a ON p.idasiento = a.idasiento";
        }else if (p.clave == "A"){
            valor = "SUM(p.haber - p.debe)";
            tablas = "proveedores,co_asientos,co_partidas,co_subcuentasprov";
            tablasF = "co_partidas p INNER JOIN co_subcuentasprov scp ON p.idsubcuenta = scp.idsubcuenta INNER JOIN proveedores cp ON scp.codproveedor = cp.codproveedor INNER JOIN co_asientos a ON p.idasiento = a.idasiento";
        }
    } else {
        valor = "SUM(f.total)";
        condicion += " AND f.cifnif = '"+cifnif+"' AND a.fecha between '"+fechaT.inicio+"' AND '"+fechaT.fin+"'";
        if (p.clave == "B") {
            tablas = "facturascli,co_asientos";
            tablasF = "facturascli f inner join co_asientos a on f.idasiento = a.idasiento";
        } else if (p.clave == "A") {
            tablas = "facturasprov,co_asientos";
            tablasF = "facturasprov f inner join co_asientos a on f.idasiento = a.idasiento";
        }
    }

    var importe:Number = util.sqlSelect(tablasF,valor,condicion,tablas);
    if (!importe || isNaN(importe)){
        importe = 0;
    }
    
    return importe;
                
}

function boe2011_identFraDeclaradosMetalico(p:Array, cifnif:String):String {

    var util= new FLUtil();
    var codFactura:String = "";
    var where:String = p.where;

    var qryDeclarados= new FLSqlQuery;
    qryDeclarados.setTablesList(p["tablas"]["recibos"]+","+p["tablas"]["pagosdevol"]+","+p["tablas"]["facturas"]);
    qryDeclarados.setSelect("r.idfactura");
    qryDeclarados.setFrom(p["from"]);
    where =  p.where;
    where += " AND "+p["campos"]["cifnif"]+" = '"+cifnif+"'";
    where += " AND r.idfactura is not null";
    qryDeclarados.setWhere(where);
    
    //debug("Consulta identFra Metalico/ cifnif:"+cifnif+" >>> "+qryDeclarados.sql());
    if (!qryDeclarados.exec()) {
        MessageBox.critical(util.translate("scripts", "Falló la consulta de declarantes para importes en metálico / identificador de factura /"), MessageBox.Ok, MessageBox.NoButton);
        return codFactura;
    }
    
    if (qryDeclarados.first()) {
        codFactura = util.sqlSelect(p["tablas"]["facturas"],"codigo","idfactura="+qryDeclarados.value("r.idfactura"));
    }
    
    return codFactura;

}
//// BOE2011 ///////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
