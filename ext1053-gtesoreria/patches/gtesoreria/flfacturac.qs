@@add-classes
  interna
  oficial
+ gtesoreria
  proveed
  pagosMultiProv
  remesasProv
  pagosMulti
  head
  ifaceCtx
..
@@added-class gtesoreria
  /** @class_declaration gtesoreria */
  /////////////////////////////////////////////////////////////////
  //// GTESORERIA ///////////////////////////////////////////////
  class gtesoreria extends PARENT_CLASS {
          function gtesoreria( context ) { PARENT_CLASS ( context ); }
          function datosConceptoAsiento(cur:FLSqlCursor):Array {
                  return this.ctx.gtesoreria_datosConceptoAsiento(cur);
          }
          function datosCtaEspecial(ctaEsp:String, codEjercicio:String):Array {
                  return this.ctx.gtesoreria_datosCtaEspecial(ctaEsp, codEjercicio);
          }
          function datosDocFacturacion(fecha:String, codEjercicio:String, tipoDoc:String):Array {
                  return this.ctx.gtesoreria_datosDocFacturacion(fecha, codEjercicio, tipoDoc);
          }
  }
  //// GTESORERIA ///////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  
  /** @class_definition gtesoreria */
  /////////////////////////////////////////////////////////////////
  //// GTESORERIA /////////////////////////////////////////////////
  function gtesoreria_datosConceptoAsiento(cur:FLSqlCursor):Array
  {
          var util:FLUtil = new FLUtil;
          var datosAsiento:Array = [];
  
          switch (cur.table()) {
                  case "remesas": {
                          datosAsiento.concepto = "Remesa "+cur.valueBuffer("idremesa");
                          datosAsiento.tipoDocumento = "";
                          datosAsiento.documento = "";
                          break;
                  }
                  default:
                          datosAsiento = this.iface.__datosConceptoAsiento(cur);
          }
          return datosAsiento;
  }
  
  // KLO. OJO: Rompe herencia
  /* \D Devuelve el código e id de la subcuenta especial correspondiente a un determinado ejercicio. Primero trata de obtener los datos a partir del campo cuenta de co_cuentasesp. Si este no existe o no produce resultados, busca los datos de la cuenta (co_cuentas) marcada con el tipo especial buscado.
  @param ctaEsp: Tipo de cuenta especial
  @codEjercicio: Código de ejercicio
  @return Los datos componen un vector de tres valores:
  error: 0.Sin error 1.Datos no encontrados 2.Error al ejecutar la query
  idsubcuenta: Identificador de la subcuenta
  codsubcuenta: Código de la subcuenta
  \end */
  function gtesoreria_datosCtaEspecial(ctaEsp:String, codEjercicio:String):Array
  {
          var datos:Array = [];
          var q:FLSqlQuery = new FLSqlQuery();
  
          with(q) {
                  setTablesList("co_subcuentas,co_cuentasesp");
                  setSelect("s.idsubcuenta,s.codsubcuenta");
                  setFrom("co_cuentasesp ce INNER JOIN co_subcuentas s ON ce.codsubcuenta = s.codsubcuenta");
                  setWhere("ce.idcuentaesp = '" + ctaEsp + "' AND s.codejercicio = '" + codEjercicio + "'  ORDER BY s.codsubcuenta");
          }
          try { q.setForwardOnly( true ); } catch (e) {}
          if (!q.exec()) {
                  datos["error"] = 2;
                  return datos;
          }
          if (q.next()) {
                  datos["error"] = 0;
                  datos["idsubcuenta"] = q.value(0);
                  datos["codsubcuenta"] = q.value(1);
                  return datos;
          }
  
          with(q) {
                  setTablesList("co_cuentas,co_subcuentas,co_cuentasesp");
                  setSelect("s.idsubcuenta,s.codsubcuenta");
                  setFrom("co_cuentasesp ce INNER JOIN co_cuentas c ON ce.codcuenta = c.codcuenta INNER JOIN co_subcuentas s ON c.idcuenta = s.idcuenta");
                  setWhere("ce.idcuentaesp = '" + ctaEsp + "' AND c.codejercicio = '" + codEjercicio + "' ORDER BY s.codsubcuenta");
          }
          try { q.setForwardOnly( true ); } catch (e) {}
          if (!q.exec()) {
                  datos["error"] = 2;
                  return datos;
          }
          if (q.next()) {
                  datos["error"] = 0;
                  datos["idsubcuenta"] = q.value(0);
                  datos["codsubcuenta"] = q.value(1);
                  return datos;
          }
  
          with(q) {
                  setTablesList("co_cuentas,co_subcuentas");
                  setSelect("s.idsubcuenta, s.codsubcuenta");
                  setFrom("co_cuentas c INNER JOIN co_subcuentas s ON c.idcuenta = s.idcuenta");
                  setWhere("c.idcuentaesp = '" + ctaEsp + "' AND c.codejercicio = '" + codEjercicio + "' ORDER BY s.codsubcuenta");
          }
          try { q.setForwardOnly( true ); } catch (e) {}
          if (!q.exec()) {
                  datos["error"] = 2;
                  return datos;
          }
  
          if (q.next()) {
                  datos["error"] = 0;
                  datos["idsubcuenta"] = q.value(0);
                  datos["codsubcuenta"] = q.value(1);
                  return datos;
          }
  
          if (ctaEsp == "IVASUE" || ctaEsp == "IVARUE" || ctaEsp == "IVAEUE"){
                  if (this.iface.consultarCtaEspecial(ctaEsp, codEjercicio)) {
                          return this.iface.datosCtaEspecial(ctaEsp, codEjercicio);
                  } else {
                          datos["error"] = 1;
                          return datos;
                  }
          }
  
          with(q) {
                  setTablesList("co_subcuentas,co_cuentasesp");
                  setSelect("s.idsubcuenta,s.codsubcuenta");
                  setFrom("co_cuentasesp ce INNER JOIN co_subcuentas s ON ce.idcuentaesp = s.idcuentaesp");
                  setWhere("ce.idcuentaesp = '" + ctaEsp + "' AND s.codejercicio = '" + codEjercicio + "' ORDER BY s.codsubcuenta");
          }
  
          try { q.setForwardOnly( true ); } catch (e) {}
  
          if (!q.exec()) {
                  datos["error"] = 2;
                  return datos;
          }
          if (q.next()) {
                  datos["error"] = 0;
                  datos["idsubcuenta"] = q.value(0);
                  datos["codsubcuenta"] = q.value(1);
                  return datos;
          }
          datos["error"] = 1;
          return datos;
  }
  
  function gtesoreria_datosDocFacturacion(fecha:String, codEjercicio:String, tipoDoc:String):Array
  {
          var res:Array = [];
          res["ok"] = true;
          res["modificaciones"] = false;
  
          var util:FLUtil = new FLUtil;
          if (util.sqlSelect("ejercicios", "codejercicio", "codejercicio = '" + codEjercicio + "' AND '" + fecha + "' BETWEEN fechainicio AND fechafin"))
                  return res;
  
          var f:Object = new FLFormSearchDB("fechaejercicio");
          var cursor:FLSqlCursor = f.cursor();
  
          cursor.select();
          if (!cursor.first())
                  cursor.setModeAccess(cursor.Insert);
          else
                  cursor.setModeAccess(cursor.Edit);
          cursor.refreshBuffer();
  
          cursor.refreshBuffer();
          cursor.setValueBuffer("fecha", fecha);
          cursor.setValueBuffer("codejercicio", codEjercicio);
          cursor.setValueBuffer("label", tipoDoc);
          cursor.commitBuffer();
          cursor.select();
  
          if (!cursor.first()) {
                  res["ok"] = false;
                  return res;
          }
  
          cursor.setModeAccess(cursor.Edit);
          cursor.refreshBuffer();
  
          f.setMainWidget();
  
          var acpt:String = f.exec("codejercicio");
          if (!acpt) {
                  res["ok"] = false;
                  return res;
          }
          res["modificaciones"] = true;
          res["fecha"] = cursor.valueBuffer("fecha");
          res["codEjercicio"] = cursor.valueBuffer("codejercicio");
  
          if (res.codEjercicio != flfactppal.iface.pub_ejercicioActual()) {
                  if (tipoDoc != "pagosdevolcli" && tipoDoc != "pagosdevolprov" && tipoDoc != "remesas" && tipoDoc != "remesasprov") {
                          MessageBox.information(util.translate("scripts", "Ha seleccionado un ejercicio distinto del actual.\nPara visualizar los documentos generados debe cambiar el ejercicio actual en la ventana\nde empresa y volver a abrir el formulario maestro correspondiente a los documentos generados"), MessageBox.Ok, MessageBox.NoButton);
                  }
          }
  
          return res;
  }
  //// GTESORERIA /////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////
  
..

