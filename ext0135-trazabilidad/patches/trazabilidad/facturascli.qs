
/** @class_declaration traza */
/////////////////////////////////////////////////////////////////
//// TRAZABILIDAD ///////////////////////////////////////////////
class traza extends oficial
{
  var curMoviLoteRec_: FLSqlCursor;
  function traza(context)
  {
    oficial(context);
  }
  function copiarDatosLineaRec(idLinea, idLineaOriginal, factor)
  {
    return this.ctx.traza_copiarDatosLineaRec(idLinea, idLineaOriginal, factor);
  }
  function copiarMoviLoteLineaRec(idLinea, idLineaOriginal, factor)
  {
    return this.ctx.traza_copiarMoviLoteLineaRec(idLinea, idLineaOriginal, factor);
  }
  function copiarCampoMoviRec(nombreCampo, curMoviOriginal, campoInformado)
  {
    return this.ctx.traza_copiarCampoMoviRec(nombreCampo, curMoviOriginal, campoInformado);
  }
}
//// TRAZABILIDAD ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition traza */
/////////////////////////////////////////////////////////////////
//// TRAZABILIDAD ///////////////////////////////////////////////
function traza_copiarDatosLineaRec(idLinea, idLineaOriginal, factor)
{
  var util: FLUtil = new FLUtil;
  if (!this.iface.__copiarDatosLineaRec(idLinea, idLineaOriginal, factor)) {
    return false;
  }
  if (!this.iface.copiarMoviLoteLineaRec(idLinea, idLineaOriginal, factor)) {
    return false;
  }
  return true;
}

function traza_copiarMoviLoteLineaRec(idLinea, idLineaOriginal, factor)
{
  var util: FLUtil = new FLUtil;

  var curLinea = this.child("tdbLineasFacturasCli").cursor();
  curLinea.select("idlinea = " + idLinea);
  if (!curLinea.first()) {
    return false;
  }
  curLinea.setModeAccess(curLinea.Browse);
  curLinea.refreshBuffer();
  if (!flfacturac.iface.pub_lineaPorLotes(curLinea)) {
    return true;
  }

  var fecha: String = util.sqlSelect("lineasfacturascli lf INNER JOIN facturascli f ON lf.idfactura = f.idfactura", "f.fecha", "idlinea = " + idLinea, "facturascli,lineasfacturascli");

  var curMoviOriginal: FLSqlCursor = new FLSqlCursor("movilote");
  this.iface.curMoviLoteRec_ = new FLSqlCursor("movilote");

  var camposML = util.nombreCampos("movilote");
  var totalCampos: Number = camposML[0];
  curMoviOriginal.select("idlineafc = " + idLineaOriginal);
  var movimientos = curMoviOriginal.size();
  if (!movimientos) {
    return true;
  }
  var cantidad;
  while (curMoviOriginal.next()) {
    curMoviOriginal.setModeAccess(curMoviOriginal.Browse);
    curMoviOriginal.refresh();
    this.iface.curMoviLoteRec_.setModeAccess(this.iface.curMoviLoteRec_.Insert);
    this.iface.curMoviLoteRec_.refresh();
    this.iface.curMoviLoteRec_.setValueBuffer("idlineafc", idLinea);
    this.iface.curMoviLoteRec_.setValueBuffer("fecha", fecha);

    var campoInformado = [];
    for (var i = 1; i <= totalCampos; i++) {
      campoInformado[camposML[i]] = false;
    }
    if (movimientos == 1) {
      /// Solo se permite variar la cantidad en la rectificación si hay un único lote asociado a la línea
      cantidad = util.sqlSelect("lineasfacturascli", "cantidad", "idlinea = " + idLinea);
      cantidad *= -1;
      campoInformado["cantidad"] = cantidad;
    } else {
      cantidad = curMoviOriginal.valueBuffer("cantidad") * factor;
    }
    this.iface.curMoviLoteRec_.setValueBuffer("cantidad", cantidad);
    campoInformado["cantidad"] = true;

    for (var i: Number = 1; i <= totalCampos; i++) {
      if (!this.iface.copiarCampoMoviRec(camposML[i], curMoviOriginal, campoInformado)) {
        return false;
      }
    }
    if (!this.iface.curMoviLoteRec_.commitBuffer()) {
      return false;
    }
  }

  return true;
}

function traza_copiarCampoMoviRec(nombreCampo, curMoviOriginal, campoInformado)
{
  if (campoInformado[nombreCampo]) {
    return true;
  }
  var valor: String;
  var nulo: Boolean = false;

  var cursor: FLSqlCursor = this.cursor();
  switch (nombreCampo) {
    case "id":
    case "idlineafc":
    case "fecha": {
      return true;
      break;
    }
    case "idlineaac": {
      nulo = true;
      break;
    }
    case "docorigen": {
      valor = "FC";
      break;
    }
    case "tipo": {
      if (parseFloat(this.iface.curMoviLoteRec_.valueBuffer("cantidad")) > 0) {
        valor = "Salida";
      } else {
        valor = "Entrada";
      }
      break;
    }
    default: {
      if (curMoviOriginal.isNull(nombreCampo)) {
        nulo = true;
      } else {
        valor = curMoviOriginal.valueBuffer(nombreCampo);
      }
    }
  }
  if (nulo) {
    this.iface.curMoviLoteRec_.setNull(nombreCampo);
  } else {
    this.iface.curMoviLoteRec_.setValueBuffer(nombreCampo, valor);
  }
  campoInformado[nombreCampo] = true;
  return true;
}

//// TRAZABILIDAD ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
