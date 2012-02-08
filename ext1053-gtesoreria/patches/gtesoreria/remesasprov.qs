@@add-classes
  interna
  oficial
+ gtesoreria
  head
  ifaceCtx
..
@@patch-class interna
== 122 lines ==
  function interna_calculateField(fN:String):String
  {
          var util:FLUtil = new FLUtil();
          var cursor = this.cursor();
  
          var res:String;
          switch (fN) {
                  /** \D La subcuenta contable por defecto será la asociada a la cuenta bancaria. Si ésta está vacía, será la subcuenta correspondienta a Caja
                                  \end */
                  case "idsubcuentadefecto": {
                          if (this.iface.contabActivada) {
                                  var codSubcuenta:String;
                                  if (this.iface.pagoIndirecto_) {
-                                         codSubcuenta = util.sqlSelect("cuentasbanco", "codsubcuentaecgp", "codcuenta = '" + cursor. valueBuffer("codcuenta") + "'");
?                                                                                                       ^
+                                         codSubcuenta = util.sqlSelect("cuentasbanco", "codsubcuentaecgP", "codcuenta = '" + cursor. valueBuffer("codcuenta") + "'");
?                                                                                                       ^
                                  } else {
                                          codSubcuenta = util.sqlSelect("cuentasbanco", "codsubcuenta", "codcuenta = '" + cursor. valueBuffer("codcuenta") + "'");
                                  }
                                  if (codSubcuenta != false) {
                                          res = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + codSubcuenta + "' AND codejercicio = '" + this.iface.ejercicioActual + "'");
                                  } else  {
                                          res = "";
                                  }
                          }
                          break;
                  }
                  case "idsubcuenta": {
                          var codSubcuenta:String = cursor.valueBuffer("codsubcuenta").toString();
                          if (codSubcuenta.length == this.iface.longSubcuenta)
                                  res = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + codSubcuenta + "' AND codejercicio = '" + this.iface.ejercicioActual + "'");
                          break;
                  }
                  case "codsubcuenta": {
                          res = "";
                          if (cursor.valueBuffer("idsubcuenta"))
                                          res = util.sqlSelect("co_subcuentas", "codsubcuenta", "idsubcuenta = '" + cursor.valueBuffer("idsubcuenta") + "' AND codejercicio = '" + this.iface.ejercicioActual + "'");
                          break;
                  }
                  case "total": {
                          res = util.sqlSelect("recibosprov", "SUM(importe)", "idrecibo IN (SELECT idrecibo FROM pagosdevolprov WHERE idremesa = " + cursor.valueBuffer("idremesa") + ")");
                          break;
                  }
                  case "estado": {
                          if (this.iface.pagoIndirecto_) {
                                  var tipo:String = util.sqlSelect("pagosdevolremprov", "tipo", "idremesa = " + cursor.valueBuffer("idremesa"));
                                  if (!tipo || tipo == "")
                                          res = "Emitida";
                                  else
                                          res = "Pagada";
                          } else {
                                  res = "Emitida";
                          }
                          break;
                  }
          }
          return res;
  }
  
  /** \D Calcula un nuevo código de remesa
  \end */
..
@@added-class gtesoreria
  /** @class_declaration gtesoreria */
  /////////////////////////////////////////////////////////////////
  //// GTESORERIA /////////////////////////////////////////////////
  class gtesoreria extends PARENT_CLASS {
          function gtesoreria( context ) { PARENT_CLASS ( context ); }
          function agregarRecibo():Boolean {
                  return this.ctx.gtesoreria_agregarRecibo();
          }
          function eliminarRecibo() {
                  return this.ctx.gtesoreria_eliminarRecibo();
          }
  }
  //// GTESORERIA /////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  
  /** @class_definition gtesoreria */
  /////////////////////////////////////////////////////////////////
  //// GTESORERIA /////////////////////////////////////////////////
  
  // KLO. OJO: Rompe herencia
  function gtesoreria_agregarRecibo():Boolean
  {
          var util:FLUtil = new FLUtil();
  
          if (!this.cursor().valueBuffer("codcuenta")) {
                  MessageBox.warning(util.translate("scripts", "Debe indicar una cuenta bancaria"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
                  return;
          }
  
          if (sys.isLoadedModule("flcontppal") && util.sqlSelect("empresa", "contintegrada", "1 = 1") && !this.cursor().valueBuffer("nogenerarasiento") && !this.cursor().valueBuffer("codsubcuenta")) {
                  MessageBox.warning(util.translate("scripts", "Debe indicar una subcuenta contable"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
                  return;
          }
  
          var cursor:FLSqlCursor = this.cursor();
          var f:Object = new FLFormSearchDB("seleccionrecibosprov");
          var curRecibos:FLSqlCursor = f.cursor();
          var fecha:String = cursor.valueBuffer("fecha");
  
          var noGenerarAsiento:Boolean = cursor.valueBuffer("nogenerarasiento");
  
          if (cursor.modeAccess() != cursor.Browse)
                  if (!cursor.checkIntegrity())
                          return;
  
          if (this.iface.contabActivada && this.child("fdbCodSubcuenta").value().isEmpty()) {
                  if (cursor.valueBuffer("nogenerarasiento") == false) {
                          MessageBox.warning(util.translate("scripts", "Debe seleccionar una subcuenta a la que asignar el asiento de pago o devolución"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
                          return false;
                  }
          }
  
          curRecibos.select();
          if (!curRecibos.first())
                  curRecibos.setModeAccess(curRecibos.Insert);
          else
                  curRecibos.setModeAccess(curRecibos.Edit);
  
          f.setMainWidget();
          curRecibos.refreshBuffer();
          curRecibos.setValueBuffer("datos", "");
          curRecibos.setValueBuffer("filtro", "estado IN ('Emitido', 'Devuelto') AND fecha <= '" + fecha + "'");
          var datos:String = f.exec("datos");
          if (!datos || datos == "")
                  return false;
          var recibos:Array = datos.toString().split(",");
          var cur:FLSqlCursor = new FLSqlCursor("empresa");
          for (var i:Number = 0; i < recibos.length; i++) {
                  cur.transaction(false);
                  try {
                          if (this.iface.asociarReciboRemesa(recibos[i], cursor)) {
                                  cur.commit();
                          } else {
                                  cur.rollback();
                                  var codRecibo:String = util.sqlSelect("recibosprov", "codigo", "idrecibo = " + recibos[i]);
                                  MessageBox.warning(util.translate("scripts", "Hubo un error en la asociación del recibo %1 a la remesa").arg(codRecibo), MessageBox.Ok, MessageBox.NoButton);
                          }
                  } catch (e) {
                          cur.rollback();
                          MessageBox.critical(util.translate("scripts", "Hubo un error en la asociación del recibo a la remesa:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
                  }
          }
          this.child("tdbRecibos").refresh();
          this.iface.actualizarTotal();
  }
  
  /** \D Se elimina el recibo activo de la remesa. El pago asociado a la remesa debe ser el último asignado al recibo
  \end */
  // KLO. OJO: Rompe herencia
  function gtesoreria_eliminarRecibo()
  {
          var util:FLUtil = new FLUtil;
          if (!this.child("tdbRecibos").cursor().isValid()) {
                  return;
          }
  
          var recibo:String = this.child("tdbRecibos").cursor().valueBuffer("idrecibo");
          var cur:FLSqlCursor = new FLSqlCursor("empresa");
          cur.transaction(false);
          try {
                  if (this.iface.excluirReciboRemesa(recibo, this.cursor().valueBuffer("idremesa"))) {
                          cur.commit();
                  }
                  else {
                          cur.rollback();
                          var codRecibo:String = util.sqlSelect("recibosprov", "codigo", "idrecibo = " + recibo);
                          MessageBox.warning(util.translate("scripts", "Hubo un error en la exclusión del recibo %1").arg(codRecibo), MessageBox.Ok, MessageBox.NoButton);
                  }
          }
          catch (e) {
                  cur.rollback();
                  MessageBox.critical(util.translate("scripts", "Hubo un error en la exlusión del recibo:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
          }
  
          this.child("tdbRecibos").refresh();
          this.iface.actualizarTotal();
  }
  //// GTESORERIA /////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  
..

