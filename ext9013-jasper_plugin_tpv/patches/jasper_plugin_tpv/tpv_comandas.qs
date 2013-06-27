
/** @class_declaration jasperPluginTpv */
/////////////////////////////////////////////////////////////////
//// JASPERPLUGIN_TPV ///////////////////////////////////////////

class jasperPluginTpv extends oficial /** %from: oficial */ {
    function jasperPluginTpv( context ) { oficial ( context ); }
    	function init() {
		return this.ctx.jasperPluginTpv_init();
	}
        function imprimirQuickClicked(){
		return this.ctx.jasperPluginTpv_imprimirQuickClicked();
	}
}

//// JASPERPLUGIN_TPV ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition jasperPluginTpv */
/////////////////////////////////////////////////////////////////
//// JASPERPLUGIN_TPV ///////////////////////////////////////////
function jasperPluginTpv_init()
{

	this.iface.__init();
	this.child("pushButtonCancel").show();
}

/** \D
Imprime el tique de la comanda. Antes guarda los datos actuales para poder obtenerlos correctamente en el informe
*/
function jasperPluginTpv_imprimirQuickClicked()
{
	var cursor:FLSqlCursor = this.cursor();

	this.iface.datosVisorImprimir();

	if (!this.iface.validateForm())
		return false;
	this.iface.acceptedForm();
	if (!cursor.commitBuffer())
		return false;
	if(!cursor.commit()) //Obliga a guardarse el buffer en la BD
		return false;
		else
		this.child("pushButtonCancel").hide(); //Esconde botón cancelar , al hacer commit, no es posible cancelar cambios!!
	cursor.setModeAccess(cursor.Edit);
	cursor.refreshBuffer();
	var util:FLUtil = new FLUtil();
	var pv:String = util.readSettingEntry( "scripts/fltpv_ppal/codTerminal" );

	if ( !pv )
			pv = util.sqlSelect( "tpv_puntosventa", "codtpv_puntoventa", "1=1") ;

	var impresora:String = util.sqlSelect( "tpv_puntosventa", "impresora","codtpv_puntoventa = '" + pv + "'") ;

	if (!formtpv_comandas.iface.pub_imprimirQuick(this.cursor().valueBuffer("codigo"), impresora))
		return false;
}

//// JASPERPLUGIN_TPV ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

