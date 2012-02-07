
/** @class_declaration gtesoreria */
/////////////////////////////////////////////////////////////////
//// GTESORERIA /////////////////////////////////////////////////
class gtesoreria extends oficial {
	function gtesoreria( context ) { oficial ( context ); }
	function acceptedForm() { return this.ctx.gtesoreria_acceptedForm(); }
}
//// GTESORERIA /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition gtesoreria */
/////////////////////////////////////////////////////////////////
//// GTESORERIA /////////////////////////////////////////////////
/** \C Se genera el fichero de texto con los datos de la remesa en el fichero especificado
*/
function gtesoreria_acceptedForm()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	if (cursor.valueBuffer("estado") == "Emitida"){
		var res:Number = MessageBox.information(util.translate("scripts", "La remesa no está cerrada. Esto puede provocar\n falta de verificación de datos antes de generar el fichero.\n ¿Desea continuar de todas formas?"),MessageBox.Yes, MessageBox.No);
		if (res != MessageBox.Yes)
			return false;
	}

	var file = new File(this.child("leFichero").text);
	file.open(File.WriteOnly);

	file.write(this.iface.cabeceraPresentador() + "\r\n");
	file.write(this.iface.cabeceraOrdenante() + "\r\n");

	var qryRecibos:FLSqlQuery = new FLSqlQuery();
        var idRecibos:String = formRecordremesas.iface.idRecibosRemesa(cursor.valueBuffer("idremesa"));
	if (this.child("chkAgruparCliente").checked) {
		with (qryRecibos) {
			setTablesList("reciboscli");
			setSelect("SUM(importe), fechav, codcliente, cifnif, nombrecliente, codcuenta, ctaentidad, ctaagencia, dc, cuenta, fecha, direccion, ciudad, codpostal");
			setFrom("reciboscli");
// 			setWhere("idremesa = " + cursor.valueBuffer("idremesa") + " GROUP BY fechav, codcliente, cifnif, nombrecliente, codcuenta, ctaentidad, ctaagencia, dc, cuenta, fecha, direccion, ciudad, codpostal");
			setWhere("idrecibo IN ("+idRecibos+") GROUP BY fechav, codcliente, cifnif, nombrecliente, codcuenta, ctaentidad, ctaagencia, dc, cuenta, fecha, direccion, ciudad, codpostal");
			setForwardOnly(true);
		}
	} else {
		with (qryRecibos) {
			setTablesList("reciboscli");
			setSelect("importe, codigo, fechav, codcliente, cifnif, nombrecliente, codcuenta, ctaentidad, ctaagencia, dc, cuenta, fecha, direccion, ciudad, codpostal");
			setFrom("reciboscli");
// 			setWhere("idremesa = " + cursor.valueBuffer("idremesa"));
			setWhere("idrecibo IN ("+idRecibos+")");
			setForwardOnly(true);
		}
	}
	if (!qryRecibos.exec()) {
		return false;
	}

	var individualObligatorio:String = "";
	var registroDomicilio:String = "";

	while (qryRecibos.next()) {
		individualObligatorio = this.iface.individualObligatorio(qryRecibos);
		file.write(individualObligatorio + "\r\n");

		registroDomicilio = this.iface.registroDomicilio(qryRecibos);
		if (registroDomicilio != "") {
			file.write(registroDomicilio + "\r\n");
		}
	}

	file.write(this.iface.totalOrdenante(qryRecibos.size()) + "\r\n");
	file.write(this.iface.totalGeneral(qryRecibos.size()) + "\r\n");

	file.close();

	// Genera copia del fichero en codificacion ISO
	// ## Por hacer: Incluir mas codificaciones
	file.open( File.ReadOnly );
	var content = file.read();
	file.close();

	var fileIso = new File( this.child("leFichero").text + ".iso8859" );

	fileIso.open(File.WriteOnly);
	fileIso.write( sys.fromUnicode( content, "ISO-8859-15" ) );
	fileIso.close();

	var util:FLUtil = new FLUtil();
	MessageBox.information(util.translate("scripts", "Generado fichero de recibos en :\n\n" + this.child("leFichero").text + "\n\n"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}
//// GTESORERIA /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

