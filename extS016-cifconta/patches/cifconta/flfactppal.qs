
/** @class_declaration cifconta */
//////////////////////////////////////////////////////////////////
//// SIAGAL CIFCONTA /////////////////////////////////////////////
class cifconta extends pubEnvioMail {
    	function cifconta( context ) { pubEnvioMail( context ); }
	function crearSubcuenta(codSubcuenta:String, descripcion:String, idCuentaEsp:String, codEjercicio:String):Number {
		return this.ctx.cifconta_crearSubcuenta(codSubcuenta, descripcion, idCuentaEsp, codEjercicio);
	}
}
//// SIAGAL CIFCONTA /////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration pubCifconta */
//////////////////////////////////////////////////////////////////
//// SIAGAL PUB CIFCONTA /////////////////////////////////////////
class pubCifconta extends cifconta {
    	function pubCifconta( context ) { cifconta( context ); }
	function pub_crearSubcuenta(codSubcuenta:String, descripcion:String, idCuentaEsp:String, codEjercicio:String):Number {
		return this.crearSubcuenta(codSubcuenta, descripcion, idCuentaEsp, codEjercicio);
	}
}
//// SIAGAL PUB CIFCONTA /////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition cifconta */
//////////////////////////////////////////////////////////////////
//// SIAGAL CIFCONTA /////////////////////////////////////////////


// Sustituimos la oficial por esta, que es una copia de la oficial pero modificada
function cifconta_crearSubcuenta(codSubcuenta:String, descripcion:String, idCuentaEsp:String, codEjercicio:String):Number
{



	var util:FLUtil = new FLUtil();

	var datosEmpresa:Array;
	if (!codEjercicio) {
		datosEmpresa["codejercicio"] = this.iface.ejercicioActual();
	} else {
		datosEmpresa["codejercicio"] = codEjercicio;
	}
	datosEmpresa["coddivisa"] = this.iface.valorDefectoEmpresa("coddivisa");

	var idSubcuenta:String = util.sqlSelect("co_subcuentas", "idsubcuenta","codsubcuenta = '" + codSubcuenta + "' AND codejercicio = '" + datosEmpresa.codejercicio + "'");
	if (idSubcuenta) {
		return idSubcuenta;
	}
	var codCuenta3:String = codSubcuenta.left(3);
	var codCuenta4:String = codSubcuenta.left(4);
	var datosCuenta:Array = this.iface.ejecutarQry("co_cuentas", "codcuenta,idcuenta",
		"idcuentaesp = '" + idCuentaEsp + "'" +
		" AND codcuenta = '" + codCuenta4 + "'" +
		" AND codejercicio = '" + datosEmpresa.codejercicio + "' ORDER BY codcuenta");

	//SIAGAL para buscar el cifNIF
	var cifNif:String;

	switch(idCuentaEsp) {

			case "CLIENT": {
				//this.child("fdbCodSubcuenta").setValue(this.iface.calculateField("codsubcuenta"));
				//var idCuenta:Number = this.iface.calculateField("idcuenta");
				//if (idCuenta) this.child("fdbIdCuenta").setValue(idCuenta);
				//this.iface.habilitarIVA();
				cifNif = util.sqlSelect("clientes", "cifnif", "codsubcuenta = '" + codSubcuenta + "'");

				//debug("Rellenar Datos Cliente");
				break;
			}
			case "PROVEE": {
				cifNif = util.sqlSelect("proveedores", "cifnif", "codsubcuenta = '" + codSubcuenta + "'");

				//debug("Rellenar Datos Proveedor");
				break;
			}

	}

	//debug("cifnif:" + cifNif);
	if (!cifNif) {
		//debug("No existe");
		cifNif = "";
	}

	if (datosCuenta.result == -1) {
		datosCuenta = this.iface.ejecutarQry("co_cuentas", "codcuenta,idcuenta", "idcuentaesp = '" + idCuentaEsp + "'" + " AND codcuenta = '" + codCuenta3 + "'" + " AND codejercicio = '" + datosEmpresa.codejercicio + "' ORDER BY codcuenta");
		if (datosCuenta.result == -1)  {
			return true;
		}
	}
	var curSubcuenta:FLSqlCursor = new FLSqlCursor("co_subcuentas");
	with (curSubcuenta) {
		setModeAccess(curSubcuenta.Insert);
		refreshBuffer();
		setValueBuffer("codsubcuenta", codSubcuenta);
		setValueBuffer("descripcion", descripcion);
		setValueBuffer("idcuenta", datosCuenta.idcuenta);
		setValueBuffer("codcuenta", datosCuenta.codcuenta);
		setValueBuffer("coddivisa", datosEmpresa.coddivisa);
		setValueBuffer("codejercicio", datosEmpresa.codejercicio);

		// SIAGAL Modificaciones
		setValueBuffer("idcuentaesp", idCuentaEsp);
		setValueBuffer("cifnif", cifNif);
	}
	if (!curSubcuenta.commitBuffer()) {
		return false;
	}

	return curSubcuenta.valueBuffer("idsubcuenta");

}

//// SIAGAL CIFCONTA /////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

