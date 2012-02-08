@@add-classes
  interna
  oficial
+ gtesoreria
  pagosMulti
  gastoDevol
  head
  ifaceCtx
..
@@added-class gtesoreria
  /** @class_declaration gtesoreria */
  /////////////////////////////////////////////////////////////////
  //// GTESORERIA ////////////////////////////////////////////////
  class gtesoreria extends PARENT_CLASS {
          function gtesoreria( context ) { PARENT_CLASS ( context ); }
          function init() {
                  return this.ctx.gtesoreria_init();
          }
          function validateForm() { return this.ctx.gtesoreria_validateForm(); }
  }
  //// GTESORERIA ////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  
  /** @class_definition gtesoreria */
  /////////////////////////////////////////////////////////////////
  //// GTESORERIA ////////////////////////////////////////////////
  
  // KLO. OJO: Rompe herencia
  function gtesoreria_init()
  {
          var cursor:FLSqlCursor = this.cursor();
  
          if (!this.iface.curRelacionado)
                  this.iface.curRelacionado = cursor.cursorRelation();
  
          var util:FLUtil = new FLUtil();
          this.iface.bngTasaCambio = this.child("bngTasaCambio");
          this.iface.divisaEmpresa = util.sqlSelect("empresa", "coddivisa", "1 = 1");
          this.iface.noGenAsiento = false;
  
          this.iface.contabActivada = sys.isLoadedModule("flcontppal") && util.sqlSelect("empresa", "contintegrada", "1 = 1");
  
          this.iface.ejercicioActual = flfactppal.iface.pub_ejercicioActual();
          if (this.iface.contabActivada) {
                  this.iface.longSubcuenta = util.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + this.iface.ejercicioActual + "'");
                  this.child("fdbIdSubcuenta").setFilter("codejercicio = '" + this.iface.ejercicioActual + "'");
                  this.iface.posActualPuntoSubcuenta = -1;
          } else {
                  this.child("tbwPagDevCli").setTabEnabled("contabilidad", false);
          }
  
          this.child("fdbTipo").setDisabled(true);
          this.child("fdbTasaConv").setDisabled(true);
          this.child("tdbPartidas").setReadOnly(true);
  
          connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
          connect(form, "closed()", this, "iface.desconexion");
          connect(this.iface.bngTasaCambio, "clicked(int)", this, "iface.bngTasaCambio_clicked()");
          connect(this.child("toolButtonInsertFC"), "clicked()", this, "iface.insertarFacturaDevolCli");
          connect(this.child("toolButtonInsertFP"), "clicked()", this, "iface.insertarFacturaDevolProv");
  
          var curPagosDevol:FLSqlCursor = new FLSqlCursor("pagosdevolcli");
          curPagosDevol.select("idrecibo = " + this.iface.curRelacionado.valueBuffer("idrecibo") + " ORDER BY fecha, idpagodevol");
          var last:Boolean = false;
          if (curPagosDevol.last()) {
                  last = true;
                  curPagosDevol.setModeAccess(curPagosDevol.Browse);
                  curPagosDevol.refreshBuffer();
              if(curPagosDevol.valueBuffer("nogenerarasiento") && curPagosDevol.valueBuffer("tipo") == "Pago"){
                          this.iface.noGenAsiento = true;
              var tipoContaRem= util.sqlSelect("remesas","tipoconta","idremesa='"+curPagosDevol.valueBuffer("idremesa")+"'");
              if (tipoContaRem=="110" || tipoContaRem=="100") this.iface.noGenAsiento = false;
                          this.child("fdbNoGenerarAsiento").setValue(this.iface.noGenAsiento);
                  }
          }
          switch (cursor.modeAccess()) {
          /** \C
          En modo inserción. Los pagos y devoluciones funcionan de forma alterna: un nuevo recibo generará un pago. El siguiente será una devolución, después un pago y así sucesivamente
          \end */
                  case cursor.Insert:
                          if (last) {
                                  if (curPagosDevol.valueBuffer("tipo") == "Pago") {
                                          /*No hace falta comprobar el pago de la remesa pues los pagos y devoluciones ya no dependen de ello
                                             if (!this.iface.comprobarRemesaPagada(curPagosDevol.valueBuffer("idremesa"))) {
                                                  this.close();
                                                  return;
                                          }*/
                                          this.child("fdbTipo").setValue("Devolución");
                                          var codCuenta:String = util.sqlSelect("pagosdevolcli", "codcuenta", "idrecibo = " + cursor.valueBuffer ("idrecibo") + " AND tipo = 'Pago' ORDER BY fecha DESC, idpagodevol DESC");
                                          this.child("fdbCodCuenta").setValue(codCuenta);
                                          if (this.iface.contabActivada) {
                                                  this.child("fdbCodSubcuenta").setValue(this.iface.calculateField("codsubcuenta"));
                                                  this.child("fdbIdSubcuenta").setValue(this.iface.calculateField("idsubcuentadefecto"));
                                                  this.child("fdbCodCuenta").setDisabled(true);
                                                  this.child("fdbIdSubcuenta").setDisabled(true);
                                                  this.child("fdbCodSubcuenta").setDisabled(true);
                                          }
                                          if (this.iface.curRelacionado.valueBuffer("coddivisa") != this.iface.divisaEmpresa) {
                                                  this.child("fdbTasaConv").setValue(curPagosDevol.valueBuffer("tasaconv"));
                                          }
                                  } else {
                                          this.child("fdbTipo").setValue("Pago");
                                          this.child("fdbCodCuenta").setValue(this.iface.calculateField("codcuenta"));
                                          if (this.iface.contabActivada) {
                                                  this.child("fdbIdSubcuenta").setValue(this.iface.calculateField("idsubcuentadefecto"));
                                          }
                                          if (this.iface.curRelacionado.valueBuffer("coddivisa") != this.iface.divisaEmpresa) {
                                                  this.child("fdbTasaConv").setDisabled(false);
                                                  this.child("rbnTasaActual").checked = true;
                                                  this.iface.bngTasaCambio_clicked(0);
                                          }
                                  }
                                  this.child("fdbFecha").setValue(util.addDays(curPagosDevol.valueBuffer("fecha"), 1));
                          } else {
                                  this.child("fdbTipo").setValue("Pago");
                                  this.child("fdbCodCuenta").setValue(this.iface.calculateField("codcuenta"));
                                  if (this.iface.contabActivada) {
                                          this.child("fdbIdSubcuenta").setValue(this.iface.calculateField("idsubcuentadefecto"));
                                  }
                                  if (this.iface.curRelacionado.valueBuffer("coddivisa") != this.iface.divisaEmpresa) {
                                          this.child("fdbTasaConv").setDisabled(false);
                                          this.child("rbnTasaActual").checked = true;
                                          this.iface.bngTasaCambio_clicked(0);
                                  }
                          }
                          break;
                  case cursor.Edit:
                          if (cursor.valueBuffer("idsubcuenta") == "0")
                                  cursor.setValueBuffer("idsubcuenta", "");
          }
          this.iface.bufferChanged("tipo");
  }
  
  function gtesoreria_validateForm():Boolean
  {
          var cursor:FLSqlCursor = this.cursor();
          var util:FLUtil = new FLUtil();
  
          /** \C
          Si es una devolución, está activada la contabilidad y su pago correspondiente no genera asiento no puede generar asiento
          \end */
          if (this.iface.contabActivada && this.iface.noGenAsiento && this.cursor().valueBuffer("tipo") == "Devolución" && !this.child("fdbNoGenerarAsiento").value()) {
                  MessageBox.warning(util.translate("scripts", "No se puede generar el asiento de una devolución cuyo pago no tiene asiento asociado"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
                  return false;
          }
  
          /** \C
          Si la contabilidad está integrada, se debe seleccionar una subcuenta válida a la que asignar el asiento de pago o devolución
          \end */
          if (this.iface.contabActivada && !this.child("fdbNoGenerarAsiento").value() && (this.child("fdbCodSubcuenta").value().isEmpty() || this.child("fdbIdSubcuenta").value() == 0)) {
                  MessageBox.warning(util.translate("scripts", "Debe seleccionar una subcuenta válida a la que asignar el asiento de pago o devolución"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
                  return false;
          }
  /*
          La fecha de un pago o devolución debe ser siempre igual o posterior\na la fecha de emisión del recibo
          \end
          if (util.daysTo(this.iface.curRelacionado.valueBuffer("fecha"), cursor.valueBuffer("fecha")) < 0) {
                  MessageBox.warning(util.translate("scripts", "La fecha de un pago o devolución debe ser siempre igual o posterior\na la fecha de emisión del recibo."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
                  return false;
          }
  */
  
          /** \C
          La fecha de un pago o devolución debe ser siempre posterior\na la fecha del pago o devolución anterior
          \end */
          var curPagosDevol:FLSqlCursor = new FLSqlCursor("pagosdevolcli");
          curPagosDevol.select("idrecibo = " + this.iface.curRelacionado.valueBuffer("idrecibo") + " AND idpagodevol <> " + cursor.valueBuffer("idpagodevol") + " ORDER BY  fecha, idpagodevol");
          if (curPagosDevol.last()) {
                  curPagosDevol.setModeAccess(curPagosDevol.Browse);
                  curPagosDevol.refreshBuffer();
                  if (util.daysTo(curPagosDevol.valueBuffer("fecha"), cursor.valueBuffer("fecha")) < 0) {
                          MessageBox.warning(util.translate("scripts", "La fecha de un pago o devolución debe ser siempre igual o posterior\na la fecha del pago o devolución anterior."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
                          return false;
                  }
          }
  
          /** \C Si el ejercicio de la factura que originó el recibo no coincide con el ejercicio actual, se solicita al usuario que confirme el pago
          \end */
          var ejercicioFactura = util.sqlSelect("reciboscli r INNER JOIN facturascli f ON r.idfactura = f.idfactura", "f.codejercicio", "r.idrecibo = " + cursor.valueBuffer("idrecibo"), "reciboscli,facturascli");
          if (ejercicioFactura){
              if (this.iface.ejercicioActual != ejercicioFactura) {
                      var respuesta:Number = MessageBox.warning(util.translate("scripts", "El ejercicio de la factura que originó este recibo es distinto del ejercicio actual ¿Desea continuar?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
                      if (respuesta != MessageBox.Yes)
                              return false;
              }
      }
  
          return true;
  }
  //// GTESORERIA ////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  
..

