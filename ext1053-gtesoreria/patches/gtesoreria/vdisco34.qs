@@add-classes
  interna
  oficial
+ gtesoreria
  head
  ifaceCtx
..
@@added-class gtesoreria
  /** @class_declaration gtesoreria */
  /////////////////////////////////////////////////////////////////
  //// GTESORERIA /////////////////////////////////////////////////
  class gtesoreria extends PARENT_CLASS {
          function gtesoreria( context ) { PARENT_CLASS ( context ); }
          function acceptedForm() { return this.ctx.gtesoreria_acceptedForm(); }
          function registroBeneficiario1(curRecibo:FLSqlCursor):String {
                  return this.ctx.gtesoreria_registroBeneficiario1(curRecibo);
          }
          function registroBeneficiario3(curRecibo:FLSqlCursor):String {
                  return this.ctx.gtesoreria_registroBeneficiario3(curRecibo);
          }
          function registroTotales():String {
                  return this.ctx.gtesoreria_registroTotales();
          }
  }
  //// GTESORERIA /////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  
  /** @class_definition gtesoreria */
  /////////////////////////////////////////////////////////////////
  //// GTESORERIA /////////////////////////////////////////////////
  
  // KLO. OJO: Rompe herencia
  /** \C Se genera el fichero de texto con los datos de la remesa en el fichero especificado
  \end */
  function gtesoreria_acceptedForm()
  {
          var util:FLUtil = new FLUtil();
          var cursor:FLSqlCursor = this.cursor();
          if (cursor.valueBuffer("estado") == "Emitida"){
                  var res:Number = MessageBox.information(util.translate("scripts", "La remesa no está cerrada. Esto puede provocar\n falta de verificación de datos antes de generar el fichero.\n ¿Desea continuar de todas formas?"),MessageBox.Yes, MessageBox.No);
                  if (res != MessageBox.Yes)
                          return false;
          }
  
          var file = new File(this.child("ledFichero").text);
          file.open(File.WriteOnly);
  
          this.iface.zonaACabecera = "03";
          this.iface.zonaBCabecera = "56";
          var cifnif:String = flfactppal.iface.pub_valorDefectoEmpresa("cifnif");
          this.iface.zonaCCabecera = flfactppal.iface.pub_espaciosDerecha(cifnif, 10);
          this.iface.zonaDCabecera = flfactppal.iface.pub_espaciosDerecha("", 12);
  
          this.iface.zonaABeneficiario = "06";
          this.iface.zonaCBeneficiario = this.iface.zonaCCabecera;
  
          this.iface.sumaImportes = 0;
          this.iface.sumaRegistros = 0;
          this.iface.sumaRegistros010 = 0;
  
          var datos:String = "";
  
          datos = this.iface.cabeceraOrdenante1();
          if(!datos || datos.length != this.iface.tamRegistro){
                  debug("Longitud: " + datos.length + " de " + this.iface.tamRegistro);
                  debug("Cadena ***" + datos + "***");
                  return;
          }
          file.write(datos + "\r\n");
  
          datos = this.iface.cabeceraOrdenante2();
          if(!datos || datos.length != this.iface.tamRegistro){
                  debug("Longitud: " + datos.length + " de " + this.iface.tamRegistro);
                  debug("Cadena ***" + datos + "***");
                  return;
          }
          file.write(datos + "\r\n");
  
          datos = this.iface.cabeceraOrdenante3();
          if(!datos || datos.length != this.iface.tamRegistro){
                  debug("Longitud: " + datos.length + " de " + this.iface.tamRegistro);
                  debug("Cadena ***" + datos + "***");
                  return;
          }
          file.write(datos + "\r\n");
  
          datos = this.iface.cabeceraOrdenante4();
          if(!datos || datos.length != this.iface.tamRegistro){
                  debug("Longitud: " + datos.length + " de " + this.iface.tamRegistro);
                  debug("Cadena ***" + datos + "***");
                  return;
          }
          file.write(datos + "\r\n");
  
          var curRecibos:FLSqlCursor = new FLSqlCursor("recibosprov");
          var idRecibos:String = formRecordremesasprov.iface.idRecibosRemesa(this.cursor().valueBuffer("idremesa"));
          curRecibos.select("idrecibo IN ("+idRecibos+")");
          while (curRecibos.next()) {
                  this.iface.restoDireccion = "";
                  var cifnifBen:String = curRecibos.valueBuffer("cifnif");
                  this.iface.zonaDBeneficiario = flfactppal.iface.pub_espaciosDerecha(cifnifBen, 12);
  
                  // ZonaB: 56-Transferencia
                  //                  57-Cheque bancario
                  //                  58-Pagaré
                  //                  59-Pago certificado
                  var tipoOperacion:String = curRecibos.valueBuffer("tipooperacion");
                  switch (tipoOperacion) {
                          case "NOMINAS Y TRANSFERENCIAS": {
                                  this.iface.zonaBBeneficiario = "56";
                                  break;
                          }
                          case "CHEQUES BANCARIOS": {
                                  this.iface.zonaBBeneficiario = "57";
                                  break;
                          }
                          case "PAGARES": {
                                  this.iface.zonaBBeneficiario = "58";
                                  break;
                          }
                          case "PAGOS CERTIFICADOS": {
                                  this.iface.zonaBBeneficiario = "59";
                                  break;
                          }
                          default: {
                                  MessageBox.warning(util.translate("scripts", "El recibo %1 no tiene establecido el siguiente dato: Tipo de operación.\nDebe editar y corregir el recibo antes de generar el fichero").arg(curRecibos.valueBuffer("codigo")), MessageBox.Ok, MessageBox.NoButton);
                                  return false;
                          }
                  }
                  datos = this.iface.registroBeneficiario1(curRecibos);
                  if(!datos || datos.length != this.iface.tamRegistro){
                          debug("Longitud: " + datos.length + " de " + this.iface.tamRegistro);
                          debug("Cadena ***" + datos + "***");
                          return;
                  }
                  file.write(datos + "\r\n");
  
                  datos = this.iface.registroBeneficiario2(curRecibos);
                  if(!datos || datos.length != this.iface.tamRegistro){
                          debug("Longitud: " + datos.length + " de " + this.iface.tamRegistro);
                          debug("Cadena ***" + datos + "***");
                          return;
                  }
                  file.write(datos + "\r\n");
  
                  datos = this.iface.registroBeneficiario3(curRecibos);
                  if(!datos || datos.length != this.iface.tamRegistro){
                          debug("Longitud: " + datos.length + " de " + this.iface.tamRegistro);
                          debug("Cadena ***" + datos + "***");
                          return;
                  }
                  file.write(datos + "\r\n");
  
                  if(this.iface.restoDireccion && this.iface.restoDireccion != "") {
                          datos = this.iface.registroBeneficiario4(curRecibos);
                          if(!datos || datos.length != this.iface.tamRegistro){
                                  debug("Longitud: " + datos.length + " de " + this.iface.tamRegistro);
                                  debug("Cadena ***" + datos + "***");
                                  return;
                          }
                          file.write(datos + "\r\n");
                  }
  
                  datos = this.iface.registroBeneficiario5(curRecibos);
                  if(!datos || datos.length != this.iface.tamRegistro){
                          debug("Longitud: " + datos.length + " de " + this.iface.tamRegistro);
                          debug("Cadena ***" + datos + "***");
                          return;
                  }
                  file.write(datos + "\r\n");
  
                  datos = this.iface.registroBeneficiario6(curRecibos);
                  if(!datos || datos.length != this.iface.tamRegistro){
                          debug("Longitud: " + datos.length + " de " + this.iface.tamRegistro);
                          debug("Cadena ***" + datos + "***");
                          return;
                  }
                  file.write(datos + "\r\n");
          }
  
          datos = this.iface.registroTotales();
          if(!datos || datos.length != this.iface.tamRegistro){
                  debug("Longitud: " + datos.length + " de " + this.iface.tamRegistro);
                  debug("Cadena ***" + datos + "***");
                  return;
          }
          file.write(datos + "\r\n");
  
          file.close();
  
          // Genera copia del fichero en codificacion ISO
          // ## Por hacer: Incluir mas codificaciones
          file.open( File.ReadOnly );
          var content = file.read();
          file.close();
  
          var fileIso = new File( this.child("ledFichero").text + ".iso8859" );
  
          fileIso.open(File.WriteOnly);
          fileIso.write( sys.fromUnicode( content, "ISO-8859-15" ) );
          fileIso.close();
  
          MessageBox.information(util.translate("scripts", "Generado fichero de Cuaderno 34 en :\n\n" + this.child("ledFichero").text + "\n\n"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
  }
  
  /** \D Crea el texto del primer registro de la cabecera del beneficiario
  @param curRecibo: Cursor del registro de un recibo
  @return Texto con los dato para ser volcados a fichero
  \end */
  function gtesoreria_registroBeneficiario1(curRecibo:FLSqlCursor):String
  {
          var util:FLUtil = new FLUtil();
  
          var importe:Number = parseFloat(curRecibo.valueBuffer("importe"));
          importe = parseInt(util.roundFieldValue(importe*100,"recibosprov","importe"));
          this.iface.sumaImportes = parseFloat((parseFloat(this.iface.sumaImportes) + importe));
  //         if(importe < 0)
  //                 importe = importe * -1;
  
          var gastos:String = curRecibo.valueBuffer("gastos");
          var opcionGastos:String;
          switch (gastos) {
                  case "Ordenante" : {
                          opcionGastos = "1";
                          break;
                  }
                  case "Beneficiario" : {
                          opcionGastos = "2";
                          break;
                  }
                  default: {
                          MessageBox.warning(util.translate("scripts", "El recibo %1 no tiene establecido el siguiente dato: Gastos.\nDebe editar y corregir el recibo antes de generar el fichero").arg(curRecibo.valueBuffer("codigo")), MessageBox.Ok, MessageBox.NoButton);
                          return false;
                          break;
                  }
          }
  
          var date:Date = curRecibo.valueBuffer("fecha");
          var fechaV = flfactppal.iface.pub_cerosIzquierda(date.getDate().toString(), 2) + flfactppal.iface.pub_cerosIzquierda(date.getMonth().toString(), 2) + date.getYear().toString().right(2);
  
          var reg:String = this.iface.zonaABeneficiario + this.iface.zonaBBeneficiario + this.iface.zonaCBeneficiario + this.iface.zonaDBeneficiario;
  
          // Zona E: Número de dato (3 dígitos) = 010
          reg += "010";
          // Zona F: Datos del abono.
          // Zona F1: (12 dígitos) Importe con dos posiciones decimales con céntimos a ceros (para pesetas) ajustados a la dcha. y relleno con ceros por la izda.
          reg += flfactppal.iface.pub_cerosIzquierda(importe, 12);
  
          if (this.iface.zonaBBeneficiario == "56") {
                  var entidad:String = curRecibo.valueBuffer("ctaentidad");
                  var oficina:String = curRecibo.valueBuffer("ctaagencia");
                  var cuenta:String = curRecibo.valueBuffer("cuenta");
                  // Zona F2: (4 dígitos) Código de Banco Beneficiario, Numérico y ajustado con ceros por la izda. (Obligatorio en Transferencias)
                  reg += flfactppal.iface.pub_cerosIzquierda(entidad, 4);
                  // Zona F3: (4 dígitos) Código de oficina, numérico con ceros por la Izda. (Obligatorio en Transferencias)
                  reg += flfactppal.iface.pub_cerosIzquierda(oficina, 4);
                  // Zona F4: (10 dígitos) Número de Cta.,Numérico con ceros por la Izda. (Obligatorio en Transferencias)
                  reg += flfactppal.iface.pub_cerosIzquierda(cuenta, 10);
          }
          else {
                  // Libre si no es Transferencia.
                  reg += flfactppal.iface.pub_espaciosDerecha("", 18);
          }
  
          // Zona F5: (1 dígito) Gastos 1/2 ....Ordenante/Beneficiario.
          reg += opcionGastos;
          // Zona F6: (1 dígito) Conceptos de la orden 1=Nomina, 8=Pensión, 9=Otros conceptos
          reg += "9";
          // Zona F7: (1 dígito) Signo del importe: (+ ó espacio)/(-) post/negat. (No es Std) (En CSB, libre, rellenos a blancos)
          reg += flfactppal.iface.pub_espaciosDerecha("", 2);
  
          if (this.iface.zonaBBeneficiario == "56") {
                  var dc:String = curRecibo.valueBuffer("dc");
                  // Zona F8: (2 dígitos) D.C. (Dígitos de Control de la Cuenta). (Obligatorio en Transferencias)
                  reg += flfactppal.iface.pub_cerosIzquierda(dc, 2);
          }
          else {
                  // Libre si no es Transferencia.
                  reg += flfactppal.iface.pub_espaciosDerecha("", 2);
          }
  
          // Zona G: (7 dígitos) Fecha de vencimiento (DDMMAA)
          reg += flfactppal.iface.pub_espaciosDerecha(fechaV, 7);
  
  
          this.iface.sumaRegistros010++;
          this.iface.sumaRegistros++;
          return reg;
  }
  
  /** \D Crea el texto del tercer registro de la cabecera del beneficiario
  @param curRecibo: Cursor del registro de un recibo
  @return Texto con los dato para ser volcados a fichero
  \end */
  function gtesoreria_registroBeneficiario3(curRecibo:FLSqlCursor):String
  {
          var util:FLUtil = new FLUtil();
  
          var direccion:String = curRecibo.valueBuffer("direccion");
          if (!direccion || direccion == "") {
                  MessageBox.warning(util.translate("scripts", "El recibo %1 no tiene establecido el siguiente dato: Dirección.\nDebe editar y corregir el recibo antes de generar el fichero").arg(curRecibo.valueBuffer("codigo")), MessageBox.Ok, MessageBox.NoButton);
                  return false;
          }
          direccion = direccion.toString().toUpperCase();
  
         if (direccion.length>36)
                  this.iface.restoDireccion = direccion.right(direccion.length - 36);
          else
                  this.iface.restoDireccion="";
  
          direccion = direccion.left(36);
  
          var date:Date = curRecibo.valueBuffer("fecha");
          var fecha = flfactppal.iface.pub_cerosIzquierda(date.getDate().toString(), 2) + flfactppal.iface.pub_cerosIzquierda(date.getMonth().toString(), 2) + date.getYear().toString().right(2);
  
          var reg:String = this.iface.zonaABeneficiario + this.iface.zonaBBeneficiario + this.iface.zonaCBeneficiario + this.iface.zonaDBeneficiario;
          // Zona E: Número de dato (3 dígitos) = 012
          reg += "012";
          // Zona F: Direccion del beneficiario. Ajustado a la izquierda, completado con blancos-
          reg += flfactppal.iface.pub_espaciosDerecha(direccion, 36)
          // Zona G: (7 dígitos) Libre.
          reg += flfactppal.iface.pub_espaciosDerecha("", 7);
  
          this.iface.sumaRegistros++;
          return reg;
  }
  
  /** \D Calcula el total del valor de recibos para el ordenante
  @return Texto con el total para ser volcado a disco
  \end */
  function gtesoreria_registroTotales():String
  {
          var util:FLUtil = new FLUtil();
          var cursor:FLSqlCursor = this.cursor();
  
          var reg:String = "";
  
          // Zona A: Código de registro (2 dígitos) 08
          reg += "08";
          // Zona B: Códgio de operación (2 dígitos) 56
          reg += "56";
          // Zona C: Código de ordenante como en la cabecera y los beneficiarios (10 dígitos);
          reg += this.iface.zonaCCabecera
          // Zona D: Libre. (12 dígitos)
          reg += flfactppal.iface.pub_espaciosDerecha("", 12);
          // Zona E: Libre. (3 dígitos)
          reg += flfactppal.iface.pub_espaciosDerecha("", 3);
          // Zona F: Datos totales:
          // F1: Suma de los importes del soporte (12 dígitos)
          reg += flfactppal.iface.pub_cerosIzquierda(this.iface.sumaImportes, 12);
          // F2: (8 dígitos) Número total de registros del beneficiario de tipo 010. (Número de órdenes)
          reg += flfactppal.iface.pub_cerosIzquierda(this.iface.sumaRegistros010, 8);
          // F3: (10 dígitos) Número total de registros del archivo
          reg += flfactppal.iface.pub_cerosIzquierda(this.iface.sumaRegistros+1, 10);
          // F4: Libre. (6 dígitos)
          reg += flfactppal.iface.pub_espaciosDerecha("", 6);
          // G: Libre. (7 dígitos)
          reg += flfactppal.iface.pub_espaciosDerecha("", 7);
  
          return reg;
  }
  //// GTESORERIA /////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  
..

