
/** @class_declaration prevPagos */
//////////////////////////////////////////////////////////////////
//// PREVISIÓN PAGOS /////////////////////////////////////////////
class prevPagos extends proveed
{
  function prevPagos(context)
  {
    proveed(context);
  }

  function cargaEvolCuenta(codCuentaBancaria, fechaD, fechaH)
  {
    return this.ctx.prevPagos_cargaEvolCuenta(codCuentaBancaria, fechaD, fechaH);
  }
  function cargaEvolPagosPeriodicos(codCuentaBancaria, fechaD, fechaH)
  {
    return this.ctx.prevPagos_cargaEvolPagosPeriodicos(codCuentaBancaria, fechaD, fechaH);
  }
  function cargaEvolPagosPuntuales(codCuentaBancaria, fechaD, fechaH)
  {
    return this.ctx.prevPagos_cargaEvolPagosPuntuales(codCuentaBancaria, fechaD, fechaH);
  }
  function dameSelect(tabla, codCuentaBancaria, fechaD, fechaH)
  {
    return this.ctx.prevPagos_dameSelect(tabla, codCuentaBancaria, fechaD, fechaH);
  }
  function dameFrom(tabla, codCuentaBancaria, fechaD, fechaH)
  {
    return this.ctx.prevPagos_dameFrom(tabla, codCuentaBancaria, fechaD, fechaH);
  }
  function dameWhere(tabla, codCuentaBancaria, fechaD, fechaH)
  {
    return this.ctx.prevPagos_dameWhere(tabla, codCuentaBancaria, fechaD, fechaH);
  }
  function cargaEvolCobrosPeriodicos(codCuentaBancaria, fechaD, fechaH)
  {
    return this.ctx.prevPagos_cargaEvolCobrosPeriodicos(codCuentaBancaria, fechaD, fechaH);
  }
  function cargaEvolCobrosPuntuales(codCuentaBancaria, fechaD, fechaH)
  {
    return this.ctx.prevPagos_cargaEvolCobrosPuntuales(codCuentaBancaria, fechaD, fechaH);
  }
}
//// PREVISIÓN PAGOS /////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_definition prevPagos */
/////////////////////////////////////////////////////////////////
//// PREVISIÓN PAGOS ////////////////////////////////////////////

function prevPagos_cargaEvolCuenta(codCuentaBancaria, fechaD, fechaH)
{
  var _i = this.iface;
  var cursor = this.cursor();

  if (!_i.cargaEvolPagosPuntuales(codCuentaBancaria, fechaD, fechaH)) {
    return false;
  }
  if (!_i.cargaEvolPagosPeriodicos(codCuentaBancaria, fechaD, fechaH)) {
    return false;
  }
  if (!_i.cargaEvolCobrosPuntuales(codCuentaBancaria, fechaD, fechaH)) {
    return false;
  }
  if (!_i.cargaEvolCobrosPeriodicos(codCuentaBancaria, fechaD, fechaH)) {
    return false;
  }
  if (!_i.__cargaEvolCuenta(codCuentaBancaria, fechaD, fechaH)) {
    return false;
  }
  return true;
}

function prevPagos_cargaEvolPagosPuntuales(codCuentaBancaria, fechaD, fechaH)
{
  var _i = this.iface;
  var cursor = this.cursor();

  var select = _i.dameSelect("pagospuntuales", codCuentaBancaria, fechaD, fechaH);
  var from = _i.dameFrom("pagospuntuales", codCuentaBancaria, fechaD, fechaH);
  var where = _i.dameWhere("pagospuntuales", codCuentaBancaria, fechaD, fechaH);

  var q = new FLSqlQuery;
  q.setSelect(select);
  q.setFrom(from);
  q.setWhere(where);

  q.setForwardOnly(true);
  if (!q.exec()) {
    return;
  }

  var p = 0;

  flfactppal.iface.pub_creaDialogoProgreso(sys.translate("Buscando Pagos Puntuales..."), q.size());

  var i = _i.aDatos_.length;

  while (q.next()) {
    AQUtil.setProgress(p++);
    _i.aDatos_[i] = _i.dameObjetoRecibo();
    _i.aDatos_[i]["tabla"] = "pagospuntuales";
    _i.aDatos_[i]["clave"] = q.value("id");
    _i.aDatos_[i]["fecha"] = q.value("fechav");
    _i.aDatos_[i]["concepto"] = "Pago Puntual: " + q.value("descripcion").left(15) + " al proveedor " + q.value("codproveedor");
    _i.aDatos_[i]["importe"] = q.value("importe");
    _i.aDatos_[i]["esIngreso"] = false;
    i++;
  }
  sys.AQTimer.singleShot(0, AQUtil.destroyProgressDialog);
  return true;

}

function prevPagos_cargaEvolPagosPeriodicos(codCuentaBancaria, fechaD, fechaH)
{
  var _i = this.iface;
  var cursor = this.cursor();

  var select = _i.dameSelect("pagosperiodicos", codCuentaBancaria, fechaD, fechaH);
  var from = _i.dameFrom("pagosperiodicos", codCuentaBancaria, fechaD, fechaH);
  var where = _i.dameWhere("pagosperiodicos", codCuentaBancaria, fechaD, fechaH);

  var q = new FLSqlQuery;
  q.setSelect(select);
  q.setFrom(from);
  q.setWhere(where);

  q.setForwardOnly(true);
  if (!q.exec()) {
    return;
  }

  var p = 0;

  flfactppal.iface.pub_creaDialogoProgreso(sys.translate("Buscando Pagos Periódicos..."), q.size());

  var i = _i.aDatos_.length;
  var fechaHasta, fechaAux, meses;

  while (q.next()) {
    AQUtil.setProgress(p++);
    if (!q.value("fechahasta") || q.value("fechahasta") == "" || q.value("fechahasta") > fechaH) {
      fechaHasta = fechaH;
    } else {
      fechaHasta = q.value("fechahasta");
    }
    fechaAux = q.value("fechadesde");
    /**if(parseFloat(fechaAux.getDate()) < parseFloat(q.value("diapago"))){
      fechaAux = AQUtil.addMonths(fechaAux, 1);
    }*/
    fechaAux.setDate(q.value("diapago"));
    switch (q.value("periodicidad")) {
      case "Mensual": {
        meses = 1;
        break;
      }
      case "Bimensual": {
        meses = 2;
        break;
      }
      case "Trimestral": {
        meses = 3;
        break;
      }
      case "Cuatrimestral": {
        meses = 4;
        break;
      }
      case "Semestral": {
        meses = 6;
        break;
      }
      case "Anual": {
        meses = 12;
        break;
      }
      case "Bienal": {
        meses = 24;
        break;
      }
    }
    while (fechaAux < fechaD) {
      fechaAux = AQUtil.addMonths(fechaAux, meses);
    }

    while (fechaAux <= fechaHasta) {
      _i.aDatos_[i] = _i.dameObjetoRecibo();
      _i.aDatos_[i]["tabla"] = "pagosperiodicos";
      _i.aDatos_[i]["clave"] = q.value("id");
      _i.aDatos_[i]["fecha"] = fechaAux;
      _i.aDatos_[i]["concepto"] = "Pago Periódico: " + q.value("descripcion").left(25);
      _i.aDatos_[i]["importe"] = q.value("importe");
      _i.aDatos_[i]["esIngreso"] = false;
      fechaAux = AQUtil.addMonths(fechaAux, meses);
      i++;
    }
  }
  sys.AQTimer.singleShot(0, AQUtil.destroyProgressDialog);
  return true;
}

function prevPagos_dameSelect(tabla, codCuentaBancaria, fechaD, fechaH)
{
  var _i = this.iface;
  var cursor = this.cursor();

  var select = "";

  switch (tabla) {
    case "cobrosperiodicos": {
      select = "id,fechadesde,fechahasta,importe,diacobro,periodicidad,codcliente,descripcion";
      break;
    }
    case "cobrospuntuales": {
      select = "id,importe,fechav,codcliente,descripcion";
      break;
    }
    case "pagosperiodicos": {
      select = "id,fechadesde,fechahasta,importe,diapago,periodicidad,codproveedor,descripcion";
      break;
    }
    case "pagospuntuales": {
      select = "id,importe,fechav,codproveedor,descripcion";
      break;
    }
    default: {
      select = _i.__dameSelect(tabla, codCuentaBancaria, fechaD, fechaH);
    }
  }
  return select;
}

function prevPagos_dameFrom(tabla, codCuentaBancaria, fechaD, fechaH)
{
  var _i = this.iface;
  var cursor = this.cursor();

  var from = "";

  switch (tabla) {
    case "cobrospuntuales":
    case "cobrosperiodicos":
    case "pagospuntuales":
    case "pagosperiodicos": {
      from = tabla;
      break;
    }
    default: {
      from = _i.__dameFrom(tabla, codCuentaBancaria, fechaD, fechaH);
    }
  }
  return from;
}

function prevPagos_dameWhere(tabla, codCuentaBancaria, fechaD, fechaH)
{
  var _i = this.iface;
  var cursor = this.cursor();

  var where = "";

  switch (tabla) {
    case "cobrosperiodicos": {
      where = "fechadesde <= '" + fechaH + "' AND (fechahasta >= '" + fechaH + "' OR fechahasta IS NULL) AND codcuenta = '" + codCuentaBancaria + "'";
      break;
    }
    case "cobrospuntuales": {
      where = "fechav BETWEEN '" + fechaD + "' AND '" + fechaH + "' AND codcuenta = '" + codCuentaBancaria + "'";
      break;
    }
    case "pagosperiodicos": {
      where = "fechadesde <= '" + fechaH + "' AND (fechahasta >= '" + fechaH + "' OR fechahasta IS NULL) AND codcuenta = '" + codCuentaBancaria + "'";
      break;
    }
    case "pagospuntuales": {
      where = "fechav BETWEEN '" + fechaD + "' AND '" + fechaH + "' AND codcuenta = '" + codCuentaBancaria + "'";
      break;
    }
    default: {
      where = _i.__dameWhere(tabla, codCuentaBancaria, fechaD, fechaH);
    }
  }
  return where;
}


function prevPagos_cargaEvolCobrosPuntuales(codCuentaBancaria, fechaD, fechaH)
{
  var _i = this.iface;
  var cursor = this.cursor();

  var select = _i.dameSelect("cobrospuntuales", codCuentaBancaria, fechaD, fechaH);
  var from = _i.dameFrom("cobrospuntuales", codCuentaBancaria, fechaD, fechaH);
  var where = _i.dameWhere("cobrospuntuales", codCuentaBancaria, fechaD, fechaH);

  var q = new FLSqlQuery;
  q.setSelect(select);
  q.setFrom(from);
  q.setWhere(where);

  q.setForwardOnly(true);
  if (!q.exec()) {
    return;
  }

  var p = 0;

  flfactppal.iface.pub_creaDialogoProgreso(sys.translate("Buscando Cobros Puntuales..."), q.size());

  var i = _i.aDatos_.length;

  while (q.next()) {
    AQUtil.setProgress(p++);
    _i.aDatos_[i] = _i.dameObjetoRecibo();
    _i.aDatos_[i]["tabla"] = "cobrospuntuales";
    _i.aDatos_[i]["clave"] = q.value("id");
    _i.aDatos_[i]["fecha"] = q.value("fechav");
    _i.aDatos_[i]["concepto"] = "Cobro Puntual: " + q.value("descripcion").left(15) + " al cliente " + q.value("codcliente");
    _i.aDatos_[i]["importe"] = q.value("importe");
    _i.aDatos_[i]["esIngreso"] = true;
    i++;
  }
  sys.AQTimer.singleShot(0, AQUtil.destroyProgressDialog);
  return true;

}

function prevPagos_cargaEvolCobrosPeriodicos(codCuentaBancaria, fechaD, fechaH)
{
  var _i = this.iface;
  var cursor = this.cursor();

  var select = _i.dameSelect("cobrosperiodicos", codCuentaBancaria, fechaD, fechaH);
  var from = _i.dameFrom("cobrosperiodicos", codCuentaBancaria, fechaD, fechaH);
  var where = _i.dameWhere("cobrosperiodicos", codCuentaBancaria, fechaD, fechaH);

  var q = new FLSqlQuery;
  q.setSelect(select);
  q.setFrom(from);
  q.setWhere(where);

  q.setForwardOnly(true);
  if (!q.exec()) {
    return;
  }

  var p = 0;

  flfactppal.iface.pub_creaDialogoProgreso(sys.translate("Buscando Cobros Periódicos..."), q.size());

  var i = _i.aDatos_.length;
  var fechaHasta, fechaAux, meses;

  while (q.next()) {
    AQUtil.setProgress(p++);
    if (!q.value("fechahasta") || q.value("fechahasta") == "" || q.value("fechahasta") > fechaH) {
      fechaHasta = fechaH;
    } else {
      fechaHasta = q.value("fechahasta");
    }
    fechaAux = q.value("fechadesde");
    /**if(parseFloat(fechaAux.getDate()) < parseFloat(q.value("diacobro"))){
      fechaAux = AQUtil.addMonths(fechaAux, 1);
    }*/
    fechaAux.setDate(q.value("diacobro"));
    switch (q.value("periodicidad")) {
      case "Mensual": {
        meses = 1;
        break;
      }
      case "Bimensual": {
        meses = 2;
        break;
      }
      case "Trimestral": {
        meses = 3;
        break;
      }
      case "Cuatrimestral": {
        meses = 4;
        break;
      }
      case "Semestral": {
        meses = 6;
        break;
      }
      case "Anual": {
        meses = 12;
        break;
      }
      case "Bienal": {
        meses = 24;
        break;
      }
    }
    while (fechaAux < fechaD) {
      fechaAux = AQUtil.addMonths(fechaAux, meses);
    }

    while (fechaAux <= fechaHasta) {
      _i.aDatos_[i] = _i.dameObjetoRecibo();
      _i.aDatos_[i]["tabla"] = "cobrosperiodicos";
      _i.aDatos_[i]["clave"] = q.value("id");
      _i.aDatos_[i]["fecha"] = fechaAux;
      _i.aDatos_[i]["concepto"] = "Cobro Periódico: " + q.value("descripcion").left(25);
      _i.aDatos_[i]["importe"] = q.value("importe");
      _i.aDatos_[i]["esIngreso"] = true;
      fechaAux = AQUtil.addMonths(fechaAux, meses);
      i++;
    }
  }
  sys.AQTimer.singleShot(0, AQUtil.destroyProgressDialog);
  return true;
}
//// PREVISIÓN PAGOS ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

