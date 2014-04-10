
/** @class_declaration cifconta */
//////////////////////////////////////////////////////////////////
//// SIAGAL CIFCONTA /////////////////////////////////////////////
class cifconta extends oficial {
    function cifconta( context ) { oficial( context ); }
	function init() { this.ctx.cifconta_init(); }
	function bufferChanged(fN) {
		return this.ctx.cifconta_bufferChanged(fN);
	}
	function habilitarClienteProveedor(curSubcuenta:FLSqlCursor, objeto:Object) {
		this.ctx.cifconta_habilitarClienteProveedor(curSubcuenta, objeto);
	}
	function rellenarDatos() {
		this.ctx.cifconta_rellenarDatos();
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

	this.iface.cifconta_habilitarClienteProveedor(cursor, this.child("gbClienteProveedor"));


}


function cifconta_bufferChanged(fN)
{

	this.iface.__bufferChanged()

	var cursor:FLSqlCursor = this.cursor();
	switch(fN) {
		/*U Al cambiar --idcuentaesp--, si la cuenta es de cliente, proveedor o acreedor habilitamos o desabilitamos el groupbox de sus campos
		\end */
		case "idcuentaesp":
			this.iface.cifconta_habilitarClienteProveedor(cursor,this.child("gbClienteProveedor"));
			break;
		case "codsubcuenta":
			this.child("fdbCifNif").setValue("");
			break;

	}
}

function cifconta_habilitarClienteProveedor(curSubcuenta:FLSqlCursor, objeto:Object)
{


	var idCuentaEsp = curSubcuenta.valueBuffer("idcuentaesp");

	if (idCuentaEsp == "CLIENT" || idCuentaEsp == "PROVEE") {
		objeto.setDisabled(false);
	}
	else {
		objeto.setDisabled(true);
	}

}

function cifconta_rellenarDatos()
{


	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	var idCuentaEsp = cursor.valueBuffer("idcuentaesp");
	var codSubcuenta = cursor.valueBuffer("codsubcuenta");
	var cifNif:String;


	switch(idCuentaEsp) {

		case "CLIENT": {
			//this.child("fdbCodSubcuenta").setValue(this.iface.calculateField("codsubcuenta"));
			//var idCuenta:Number = this.iface.calculateField("idcuenta");
			//if (idCuenta) this.child("fdbIdCuenta").setValue(idCuenta);
			//this.iface.habilitarIVA();
			cifNif = util.sqlSelect("clientes", "cifnif", "codsubcuenta = '" + codSubcuenta + "'");

			debug("Rellenar Datos Cliente");
			break;
		}
		case "PROVEE": {
			cifNif = util.sqlSelect("proveedores", "cifnif", "codsubcuenta = '" + codSubcuenta + "'");

			debug("Rellenar Datos Proveedor");
			break;
		}

	}

	debug("cifnif:" + cifNif);
	if (!cifNif) {
		debug("No existe");
		this.child("fdbCifNif").setValue("");
	} else {
		this.child("fdbCifNif").setValue(cifNif);
	}

}

//// SIAGAL CIFCONTA /////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

