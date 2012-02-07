
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
function gtesoreria_acceptedForm()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	if (cursor.valueBuffer("estado") == "Emitida"){
		var res:Number = MessageBox.information(util.translate("scripts", "La remesa no está cerrada. Esto puede provocar\n falta de verificación de datos antes de generar el fichero.\n ¿Desea continuar de todas formas?"),MessageBox.Yes, MessageBox.No);
		if (res != MessageBox.Yes)
			return false;
	}

	var file:Object = new File(this.child("leFichero").text);
	file.open(File.WriteOnly);

	file.write(this.iface.cabeceraPresentador() + "\r\n");
	file.write(this.iface.cabeceraOrdenante() + "\r\n");

	var qryRecibos:FLSqlQuery = new FLSqlQuery();
        var idRecibos:String = formRecordremesas.iface.idRecibosRemesa(cursor.valueBuffer("idremesa"));
	if (this.child("chkAgruparCliente").checked) {
		with (qryRecibos) {
			setTablesList("reciboscli");
			setSelect("SUM(importe), codcliente, nombrecliente, codcuenta, ctaentidad, ctaagencia, dc, cuenta");
			setFrom("reciboscli");
// 		setWhere("idremesa = " + cursor.valueBuffer("idremesa") + " GROUP BY codcliente, nombrecliente, codcuenta, ctaentidad, ctaagencia, dc, cuenta");
			setWhere("idrecibo IN ("+idRecibos+") GROUP BY codcliente, nombrecliente, codcuenta, ctaentidad, ctaagencia, dc, cuenta");
			setForwardOnly(true);
		}
	} else {
		with (qryRecibos) {
			setTablesList("reciboscli");
			setSelect("importe, codigo, codcliente, nombrecliente, codcuenta, ctaentidad, ctaagencia, dc, cuenta");
			setFrom("reciboscli");
// 			setWhere("idremesa = " + cursor.valueBuffer("idremesa"));
			setWhere("idrecibo IN ("+idRecibos+")");
			setForwardOnly(true);
		}
	}
	if (!qryRecibos.exec()) {
		return false;
	}

// 	var curRecibos:FLSqlCursor = new FLSqlCursor("reciboscli");
// 	curRecibos.select("idrecibo IN (SELECT idrecibo FROM pagosdevolcli WHERE idremesa = " + this.cursor().valueBuffer("idremesa") + ")");
// 	while (curRecibos.next())
// 			file.write(this.iface.individualObligatorio(curRecibos) + "\r\n");

	while (qryRecibos.next())
		file.write(this.iface.individualObligatorio(qryRecibos) + "\r\n");

// 	file.write(this.iface.totalOrdenante(curRecibos.size()) + "\r\n");
// 	file.write(this.iface.totalGeneral(curRecibos.size()) + "\r\n");

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
	MessageBox.information(util.translate("scripts", "Generado fichero de recibos en: \n\n%1\n\n").arg(this.child("leFichero").text),MessageBox.Ok, MessageBox.NoButton);
}
//// GTESORERIA /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

