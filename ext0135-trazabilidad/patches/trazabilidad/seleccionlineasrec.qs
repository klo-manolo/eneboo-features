
/** @class_declaration traza */
/////////////////////////////////////////////////////////////////
//// TRAZABILIDAD ///////////////////////////////////////////////
class traza extends oficial
{
  function traza(context)
  {
    oficial(context);
  }
  function cargarTabla()
  {
    return this.ctx.traza_cargarTabla();
  }
}
//// TRAZABILIDAD ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition traza */
/////////////////////////////////////////////////////////////////
//// TRAZABILIDAD ///////////////////////////////////////////////
function traza_cargarTabla()
{
  var util = new FLUtil;
  var _i = this.iface;
  var tblLineas = this.child("tblLineas");
  tblLineas.setNumRows(0);

  var q = new FLSqlQuery;
  q.setTablesList(_i.aDatosFR.tabla);
  q.setSelect("l.idlinea, l.referencia, l.cantidad, l.descripcion, COUNT(ml.id), MAX(ml.codlote)");
  switch (_i.aDatosFR.tabla) {
    case "lineasfacturascli": {
      q.setFrom("lineasfacturascli l LEFT OUTER JOIN movilote ml ON l.idlinea = ml.idlineafc");
      break;
    }
    case "lineasfacturasprov": {
      q.setFrom("lineasfacturasprov l LEFT OUTER JOIN movilote ml ON l.idlinea = ml.idlineafp");
      break;
    }
  }
  q.setWhere("idfactura = " + _i.aDatosFR.idfactura + " GROUP BY l.idlinea, l.referencia, l.cantidad, l.descripcion ORDER BY l.referencia");
  q.setForwardOnly(true);
  if (!q.exec()) {
    return;
  }
  var f = 0, lotes, desc;
  while (q.next()) {
    lotes = q.value("COUNT(ml.id)");
    lotes = isNaN(lotes) ? 0 : lotes;
    desc = q.value("l.descripcion");
    tblLineas.insertRows(f, 1);
    switch (lotes) {
      case 0: {
        break;
      }
      case 1: {
        desc = "L." + q.value("MAX(ml.codlote)") + ". " + desc;
        break;
      }
      case 2: {
        desc = util.translate("scripts", "(Varios lotes)") + ". " + desc;
        tblLineas.setRowReadOnly(f, true);
        break;
      }
    }
    tblLineas.setText(f, _i.colLin, q.value("l.idlinea"));
    tblLineas.setText(f, _i.colSel, "X");
    tblLineas.setCellAlignment(f, _i.colSel, tblLineas.AlignHCenter);
    tblLineas.setCellBackgroundColor(f, _i.colSel, _i.verde);
    tblLineas.setText(f, _i.colRef, q.value("l.referencia"));
    tblLineas.setCellAlignment(f, _i.colRef, tblLineas.AlignLeft);
    tblLineas.setText(f, _i.colDes, desc);
    tblLineas.setText(f, _i.colPre, q.value("l.cantidad"));
    tblLineas.setText(f, _i.colRec, q.value("l.cantidad"));
    tblLineas.setCellAlignment(f, _i.colRec, tblLineas.AlignRight);
    f++;
  }
  tblLineas.repaintContents();
}
//// TRAZABILIDAD ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
