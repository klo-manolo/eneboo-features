
/** @class_declaration cifconta */
//////////////////////////////////////////////////////////////////
//// SIAGAL CIFCONTA /////////////////////////////////////////////
class cifconta extends oficial {
    function cifconta( context ) { oficial( context ); }
	function init() { this.ctx.cifconta_init(); }
	function rellenarDatos() {
		this.ctx.cifconta_rellenarDatos();
	}

	function sustituirDatosClienteProveedor(codEjercicio:String) {
		this.ctx.cifconta_sustituirDatosClienteProveedor(codEjercicio);
	}
	function rellenarCuentasEsp() {
		this.ctx.cifconta_rellenarCuentasEsp();
	}

	function sustituirCuentasEsp(codEjercicio:String) {
		this.ctx.cifconta_sustituirCuentasEsp(codEjercicio);
	}


}
//// SIAGAL CIFCONTA /////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition cifconta */
//////////////////////////////////////////////////////////////////
//// SIAGAL CIFCONTA /////////////////////////////////////////////

function cifconta_init()
{


	this.iface.__init();

	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	connect(this.child("pbnRellenarDatos"), "clicked()", this, "iface.rellenarDatos");
	connect(this.child("pbnRellenarCuentasEsp"), "clicked()", this, "iface.rellenarCuentasEsp");


}



function cifconta_rellenarDatos()
{
	var util:FLUtil = new FLUtil();
	var ejercicioActual:String = this.iface.ejercicioActual;


	var res:Object = MessageBox.information(util.translate("scripts",  "¿Rellenar datos de cliente/proveedor? \n\nEsta operación sustituirá los datos actuales de cliente/proveedor\nde las subcuentas del ejercicio " + ejercicioActual + " por los encontrados en sus\nfichas de facturación."), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
	if (res == MessageBox.Yes) {
		this.iface.cifconta_sustituirDatosClienteProveedor(ejercicioActual);
	}



}


function cifconta_sustituirDatosClienteProveedor(codEjercicio:String)
{


	var util:FLUtil = new FLUtil();

	var curSubcuentas:FLSqlCursor = new FLSqlCursor("co_subcuentas");
	//curSubcuentas.setActivatedCommitActions(false);
	curSubcuentas.select("codejercicio = '" + codEjercicio + "' AND (idcuentaesp = 'CLIENT' OR idcuentaesp = 'PROVEE') order by idsubcuenta");
	//var cursorBloqueado:FLSqlCursor = new FLSqlCursor("co_asientos");

	var i:Number = 0;
	util.createProgressDialog(util.translate("scripts", "Rellenando datos de clientes en subcuentas..."), curSubcuentas.size());
	util.setProgress(0);

	var idSubcuenta:Number;
	var idCuentaEsp:String;
	var codSubcuenta:String;
	var cifNif:String;
	var codEjercicioSubcuenta:String;

	var resultado:String; //Para el debug

	curSubcuentas.transaction(false);

	while (curSubcuentas.next()) {

		cifNif = "";

		curSubcuentas.refreshBuffer();
		idSubcuenta = curSubcuentas.valueBuffer("idsubcuenta");
		idCuentaEsp = curSubcuentas.valueBuffer("idcuentaesp");
		codSubcuenta = curSubcuentas.valueBuffer("codsubcuenta");
		codEjercicioSubcuenta = curSubcuentas.valueBuffer("codejercicio");


		switch(idCuentaEsp) {

			case "CLIENT": {
				cifNif = util.sqlSelect("clientes", "cifnif", "codsubcuenta = '" + codSubcuenta + "'");

				resultado = resultado + idSubcuenta + " - " + idCuentaEsp  + " - " + codSubcuenta  + " - " + cifNif + " ||| ";
				break;
			}
			case "PROVEE": {
				cifNif = util.sqlSelect("proveedores", "cifnif", "codsubcuenta = '" + codSubcuenta + "'");

				resultado = resultado + idSubcuenta + " - " + idCuentaEsp  + " - " + codSubcuenta  + " - " + cifNif + " ||| ";
				break;
			}

		}

		curSubcuentas.setModeAccess(curSubcuentas.Edit);
		curSubcuentas.refreshBuffer();
		if (!cifNif) {
			util.setLabelText("Actualizando subcuenta " + codSubcuenta + " sin datos.");
			curSubcuentas.setValueBuffer("cifnif", "");
		} else {
			util.setLabelText("Actualizando subcuenta " + codSubcuenta + " con datos: " + cifNif + ".");
			curSubcuentas.setValueBuffer("cifnif", cifNif);

		}

		if (!curSubcuentas.commitBuffer())
			MessageBox.information(util.translate("scripts",  "Error actualizando en: " + codEjercicioSubcuenta + " - " + idSubcuenta + " - " + idCuentaEsp  + " - " + codSubcuenta  + " - " + cifNif ), MessageBox.NoButton);

		util.setProgress(i++)


	}


	curSubcuentas.commit();

	util.destroyProgressDialog();

	MessageBox.information(util.translate("scripts",  "Datos de cliente de las subcuentas del ejercicio " + codEjercicio + " actualizados correctamente."), MessageBox.NoButton);







}


function cifconta_rellenarCuentasEsp()
{
	var util:FLUtil = new FLUtil();
	var ejercicioActual:String = this.iface.ejercicioActual;


	var res:Object = MessageBox.information(util.translate("scripts",  "¿Rellenar las cuentas especiales de cliente/proveedor? \n\nEsta operación sustituirá las cuentas especiales actuales\nde cliente/proveedor de las subcuentas del ejercicio " + ejercicioActual + "\npor CLIENT para todas las 430 y PROVEE para todas\nlas 400 y 410."), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
	if (res == MessageBox.Yes) {
		this.iface.cifconta_sustituirCuentasEsp(ejercicioActual);
	}



}


function cifconta_sustituirCuentasEsp(codEjercicio:String)
{


	var util:FLUtil = new FLUtil();

	var curSubcuentas:FLSqlCursor = new FLSqlCursor("co_subcuentas");
	//curSubcuentas.setActivatedCommitActions(false);
	curSubcuentas.select("codejercicio = '" + codEjercicio + "' AND (SUBSTRING(codcuenta,1,3) = '430' OR SUBSTRING(codcuenta,1,3) = '400' OR SUBSTRING(codcuenta,1,3) = '410') order by idsubcuenta");
	//var cursorBloqueado:FLSqlCursor = new FLSqlCursor("co_asientos");

	var i:Number = 0;
	util.createProgressDialog(util.translate("scripts", "Rellenando cuentas especiales en subcuentas..."), curSubcuentas.size());
	util.setProgress(0);

	var idSubcuenta:Number;
	var idCuentaEsp:String;
	var codSubcuenta:String;
	var codCuenta:String;
	var cifNif:String;
	var codEjercicioSubcuenta:String;
	var raizCodCuenta:String;

	var resultado:String; // Para el debug

	curSubcuentas.transaction(false);

	while (curSubcuentas.next()) {

		idCuentaEsp = "";

		curSubcuentas.refreshBuffer();
		idSubcuenta = curSubcuentas.valueBuffer("idsubcuenta");
		codSubcuenta = curSubcuentas.valueBuffer("codsubcuenta");
		codCuenta = curSubcuentas.valueBuffer("codcuenta");
		codEjercicioSubcuenta = curSubcuentas.valueBuffer("codejercicio");
		raizCodCuenta = codCuenta.toString().left(3)

		switch(raizCodCuenta) {

			case "430": {
				idCuentaEsp = "CLIENT"
				resultado = resultado + idSubcuenta + " - " + codSubcuenta  + " - " + idCuentaEsp + " ||| ";
				break;
			}
			case "400": {
				idCuentaEsp = "PROVEE"
				resultado = resultado + idSubcuenta + " - " + codSubcuenta  + " - " + idCuentaEsp + " ||| ";
				break;
			}
			case "410": {
				idCuentaEsp = "PROVEE"
				resultado = resultado + idSubcuenta + " - " + codSubcuenta  + " - " + idCuentaEsp + " ||| ";
				break;
			}

		}


		curSubcuentas.setModeAccess(curSubcuentas.Edit);
		curSubcuentas.refreshBuffer();
		if (!idCuentaEsp) {
			util.setLabelText("Actualizando subcuenta " + codSubcuenta + " sin cuenta especial." );
			curSubcuentas.setValueBuffer("idcuentaesp", "");
		} else {
			util.setLabelText("Actualizando subcuenta " + codSubcuenta + " con cuenta especial " + idCuentaEsp + ".");
			curSubcuentas.setValueBuffer("idcuentaesp", idCuentaEsp);

		}

		if (!curSubcuentas.commitBuffer())
			MessageBox.information(util.translate("scripts",  "Error actualizando en: " + codEjercicioSubcuenta + " - " + idSubcuenta + " - " + idCuentaEsp  + " - " + codSubcuenta), MessageBox.NoButton);

		util.setProgress(i++)


	}

	curSubcuentas.commit();

	util.destroyProgressDialog();

	MessageBox.information(util.translate("scripts",  "Cuentas especiales de las subcuentas del ejercicio " + codEjercicio + " actualizadas correctamente."), MessageBox.NoButton);







}


//// SIAGAL CIFCONTA /////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

