
/** @class_declaration jasperPlugin */
//////////////////////////////////////////////////////////////////
//// JASPER_PLUGIN ///////////////////////////////////////////////
class jasperPlugin extends oficial /** %from: oficial */ {
    function jasperPlugin( context ) { oficial( context ); }
    function init() {
        return this.ctx.jasperPlugin_init();
    }
    function seteaPath() {
            return this.ctx.jasperPlugin_seteaPath();
     }
    function seteaPlugin() {
            return this.ctx.jasperPlugin_seteaPlugin();
     }
    function testJava() {
            return this.ctx.jasperPlugin_testJava();
     }
    function testPlugin() {
            return this.ctx.jasperPlugin_testPlugin();
     }
     function checkRT() {
            return this.ctx.jasperPlugin_checkRT();
     }
     function checkCompilar() {
            return this.ctx.jasperPlugin_checkCompilar();
     }
     function checkGuardaTemporal() {
            return this.ctx.jasperPlugin_checkGuardaTemporal();
     }
     function fixPath(ruta:String):String {
            return this.ctx.jasperPlugin_fixPath(ruta);
    }
    function guardaCodificacion() {
            return this.ctx.jasperPlugin_guardaCodificacion();
     }
    }

//// JASPER_PLUGIN ///////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition jasperPlugin */
//////////////////////////////////////////////////////////////////
//// JASPER_PLUGIN ///////////////////////////////////////////////
function jasperPlugin_init()
{
    var util:FLUtil = new FLUtil;
    connect(this.child("pbPath"), "clicked()", this, "iface.seteaPath");
    connect(this.child("pbJPlugin"), "clicked()", this, "iface.seteaPlugin");
    connect(this.child("pbJava"), "clicked()", this, "iface.testJava");
    connect(this.child("pbPlugin"), "clicked()", this, "iface.testPlugin");
    connect(this.child("chbRT"), "clicked()", this, "iface.checkRT");
    connect(this.child("chbCompilar"), "clicked()", this, "iface.checkCompilar");
    connect(this.child("chbGuardaTemporal"), "clicked()", this, "iface.checkGuardaTemporal");
    connect(this.child("cBCodificacion"), "activated(int)", this, "iface.guardaCodificacion");
    this.child("lnJPlugin").text = util.readSettingEntry("jasperplugin/pluginpath");
    this.child("lnPath").text = util.readSettingEntry("jasperplugin/reportspath");
    this.child("chbRT").checked = util.readSettingEntry("jasperplugin/detecRT");
    this.child("chbGuardaTemporal").checked = util.readSettingEntry("jasperplugin/guardatemporal");
    this.child("chbCompilar").checked = util.readSettingEntry("jasperplugin/compilarSiempre");
    this.child("cBCodificacion").currentItem = util.readSettingEntry("jasperplugin/codificacion");
    this.iface.__init();
}
function jasperPlugin_seteaPath()
{
    var util:FLUtil = new FLUtil;
    var dirBasePath = this.iface.fixPath(FileDialog.getExistingDirectory(Dir.home));

    if (!dirBasePath)
    return;
    this.child("lnPath").text = dirBasePath;
    util.writeSettingEntry("jasperplugin/reportspath",dirBasePath);
}
function jasperPlugin_seteaPlugin()
{
    var util:FLUtil = new FLUtil;
    var dirBasePath = this.iface.fixPath(FileDialog.getExistingDirectory(Dir.home));

    if (!dirBasePath)
    return;
    this.child("lnJPlugin").text = dirBasePath;
    util.writeSettingEntry("jasperplugin/pluginpath",dirBasePath);
}
function jasperPlugin_testJava()
{
    var util:FLUtil = new FLUtil;
    var resultado:Array = flfactppal.iface.pub_ejecutarComandoAsincrono("java -version");
        MessageBox.information(util.translate("scripts", resultado["salida"]), MessageBox.Ok);
}
function jasperPlugin_testPlugin()
{
    var util:FLUtil = new FLUtil;
    var ruta:String = this.child("lnJPlugin").text + "enebooreports.jar";
    if (File.exists(ruta))
    flfactinfo.iface.pub_lanzarInforme(this.cursor(), "version","", "", false, false,"","","","",false);
     else MessageBox.information(util.translate("scripts", "¡¡ Ruta incorrecta !! \n " + ruta), MessageBox.Ok);
}
function jasperPlugin_checkRT()
{
   var util:FLUtil = new FLUtil;
   var pulsado:Boolean = false;
   if (this.child("chbRT").checked) pulsado = true;
  //debug ("JASPER_PLUGIN :: Guardando checkRT = " + pulsado);
   util.writeSettingEntry("jasperplugin/detecRT",pulsado);
}
function jasperPlugin_checkCompilar()
{
   var util:FLUtil = new FLUtil;
   var pulsado:Boolean = false;
   if (this.child("chbCompilar").checked) pulsado = true;
  //debug ("JASPER_PLUGIN :: Guardando checkCompilar = " + pulsado);
   util.writeSettingEntry("jasperplugin/compilarSiempre",pulsado);
}
function jasperPlugin_checkGuardaTemporal()
{
   var util:FLUtil = new FLUtil;
   var pulsado:Boolean = false;
   if (this.child("chbGuardaTemporal").checked) pulsado = true;
   util.writeSettingEntry("jasperplugin/guardatemporal",pulsado);
}
function jasperPlugin_fixPath(ruta:String):String
{
var rutaFixed:String;
    if (sys.osName() == "WIN32")
            {
           var barra = "\\";
        while (ruta != rutaFixed)
                    {
                    rutaFixed = ruta;
                    ruta = ruta.replace("/",barra);
                    }
        if (!rutaFixed.endsWith(barra)) rutaFixed +="\\";
            } else
                rutaFixed= ruta;
return rutaFixed;
}
function jasperPlugin_guardaCodificacion()
{
   var util:FLUtil = new FLUtil;
   util.writeSettingEntry("jasperplugin/codificacion",this.child("cBCodificacion").currentItem);
}
//// JASPER_PLUGIN ///////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

