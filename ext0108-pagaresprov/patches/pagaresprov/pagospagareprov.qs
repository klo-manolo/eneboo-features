/***************************************************************************
                 pagospagareprov.qs  -  description
                             -------------------
    begin                : mie ene 31 2006
    copyright            : (C) 2006 by InfoSiAL S.L.
    email                : mail@infosial.com
 ***************************************************************************/
/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

/** @ file */

/** @class_declaration interna */
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna
{
  var ctx;
  function interna(context)
  {
    this.ctx = context;
  }
  function init()
  {
    this.ctx.interna_init();
  }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna
{
  var ejercicioActual;
  var bloqueoSubcuenta;
  var longSubcuenta;
  var contabActivada;
  var noGenAsiento;
  function oficial(context)
  {
    interna(context);
  }

  function datosAperturaFormulario()
  {
    return this.ctx.oficial_datosAperturaFormulario();
  }
  function desconexion()
  {
    return this.ctx.oficial_desconexion();
  }
  function validateForm()
  {
    return this.ctx.oficial_validateForm();
  }
  function controlarContabilidadActivada()
  {
    return this.ctx.oficial_controlarContabilidadActivada();
  }
  function comprobarFechasValidate()
  {
    return this.ctx.oficial_comprobarFechasValidate();
  }
  function acceptedForm()
  {
    return this.ctx.oficial_acceptedForm();
  }
  function bufferChanged(fN)
  {
    return this.ctx.oficial_bufferChanged(fN);
  }
  function calculateField(fN)
  {
    return this.ctx.oficial_calculateField(fN);
  }

}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial
{
  function head(context)
  {
    oficial(context);
  }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head
{
  function ifaceCtx(context)
  {
    head(context);
  }
}

const iface = new ifaceCtx(this);
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
/** \C El marco 'Contabilidad' se habilitará en caso de que esté cargado el módulo principal de contabilidad.
\end */
function interna_init()
{
  var _i = this.iface;
  var cursor = this.cursor();

  _i.noGenAsiento = false;
  _i.contabActivada = sys.isLoadedModule("flcontppal") && AQUtil.sqlSelect("empresa", "contintegrada", "1 = 1");
  _i.ejercicioActual = flfactppal.iface.pub_ejercicioActual();

  if (_i.contabActivada) {
    _i.longSubcuenta = AQUtil.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + _i.ejercicioActual + "'");
    this.child("fdbIdSubcuenta").setFilter("codejercicio = '" + _i.ejercicioActual + "'");
  } else {
    this.child("tbwPagDevProv").setTabEnabled("contabilidad", false);
  }

  this.child("fdbTipo").setDisabled(true);
  this.child("tdbPartidas").setReadOnly(true);

  connect(cursor, "bufferChanged(QString)", _i, "bufferChanged");
  connect(this, "closed()", _i, "desconexion");

  _i.datosAperturaFormulario();

}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_datosAperturaFormulario()
{
  var _i = this.iface;
  var cursor = this.cursor();

  switch (cursor.modeAccess()) {
      /** \C
      En modo inserción. Los pagos y devoluciones funcionan de forma alterna: un nuevo pagarés generará un pago. El siguiente será una devolucion, después un pago y así sucesivamente
      */
    case cursor.Insert: {
      var curPagosDevol = new FLSqlCursor("pagospagareprov");
      curPagosDevol.select("idpagare = " + cursor.cursorRelation().valueBuffer("idpagare") + " ORDER BY fecha, idpagodevol");
      var last = false;
      if (curPagosDevol.last()) {
        last = true;
        curPagosDevol.setModeAccess(curPagosDevol.Browse);
        curPagosDevol.refreshBuffer();
        if (curPagosDevol.valueBuffer("nogenerarasiento") && curPagosDevol.valueBuffer("tipo") == "Pago") {
          _i.noGenAsiento = true;
          this.child("fdbNoGenerarAsiento").setValue(true);
        }
      }
      if (last) {
        curPagosDevol.setModeAccess(curPagosDevol.Browse);
        curPagosDevol.refreshBuffer();
        if (curPagosDevol.valueBuffer("tipo") == "Pago") {
          this.child("fdbTipo").setValue("Devolución");
          this.child("fdbCodCuenta").setValue(AQUtil.sqlSelect("pagospagareprov", "codcuenta", "idpagare = " + cursor.valueBuffer("idpagare") + " AND tipo = 'Pago' ORDER BY fecha DESC"));
          if (_i.contabActivada) {
            this.child("fdbCodSubcuenta").setValue(AQUtil.sqlSelect("pagospagareprov", "codsubcuenta", "idpagare = " + cursor.valueBuffer("idpagare") + " AND tipo = 'Pago' ORDER BY fecha DESC"));
            this.child("fdbIdSubcuenta").setDisabled(true);
            this.child("fdbCodSubcuenta").setDisabled(true);
          }
        } else {
          this.child("fdbTipo").setValue("Pago");
          this.child("fdbCodCuenta").setValue(_i.calculateField("codcuenta"));
        }
        this.child("fdbFecha").setValue(AQUtil.addDays(curPagosDevol.valueBuffer("fecha"), 1));
      } else {
        this.child("fdbTipo").setValue("Pago");
        this.child("fdbCodCuenta").setValue(_i.calculateField("codcuenta"));
        if (_i.contabActivada) {
          this.child("fdbIdSubcuenta").setValue(_i.calculateField("idsubcuentadefecto"));
        }
      }
      break;
    }
    case cursor.Edit: {
      if (cursor.valueBuffer("idsubcuenta") == "0") {
        cursor.setValueBuffer("idsubcuenta", "");
      }
      break;
    }
  }
}

function oficial_desconexion()
{
  var _i = this.iface;
  var cursor = this.cursor();

  disconnect(cursor, "bufferChanged(QString)", _i, "bufferChanged");
}

function oficial_validateForm()
{
  var _i = this.iface;
  var cursor = this.cursor();

  if (!_i.controlarContabilidadActivada()) {
    return false;
  }
  if (!_i.comprobarFechasValidate()) {
    return false;
  }

  return true;
}

/** \C
Si es una devolución, está activada la contabilidad y su pago correspondiente no genera asiento no puede generar asiento
Si la contabilidad está integrada, se debe seleccionar una subcuenta válida a la que asignar el asiento de pago o devolución
\end */
function oficial_controlarContabilidadActivada()
{
  var _i = this.iface;
  var cursor = this.cursor();

  if (_i.contabActivada && _i.noGenAsiento && cursor.valueBuffer("tipo") == "Devolución" && !this.child("fdbNoGenerarAsiento").value()) {
    MessageBox.warning(sys.translate("No se puede generar el asiento de una devolución cuyo pago no tiene asiento asociado"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    return false;
  }

  if (_i.contabActivada && !this.child("fdbNoGenerarAsiento").value() && (this.child("fdbCodSubcuenta").value().isEmpty() || this.child("fdbIdSubcuenta").value() == 0)) {
    MessageBox.warning(sys.translate("Debe seleccionar una subcuenta válida a la que asignar el asiento de pago o devolución"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    return false;
  }
  return true;
}

/** \C
La fecha de un pago o devolución debe ser siempre posterior\na la fecha del pago o devolución anterior
\end */
function oficial_comprobarFechasValidate()
{
  var _i = this.iface;
  var cursor = this.cursor();

  var curPagosDevol = new FLSqlCursor("pagospagareprov");
  curPagosDevol.select("idpagare = " + cursor.cursorRelation().valueBuffer("idpagare") + " AND idpagodevol <> " + cursor.valueBuffer("idpagodevol") + " ORDER BY  fecha, idpagodevol");
  if (curPagosDevol.last()) {
    curPagosDevol.setModeAccess(curPagosDevol.Browse);
    curPagosDevol.refreshBuffer();
    if (AQUtil.daysTo(curPagosDevol.valueBuffer("fecha"), cursor.valueBuffer("fecha")) <= 0) {
      MessageBox.warning(sys.translate("La fecha de un pago o devolución debe ser siempre posterior\na la fecha del pago o devolución anterior."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
      return false;
    }
  }
  return true;
}

function oficial_acceptedForm()
{

}

function oficial_bufferChanged(fN)
{
  var _i = this.iface;
  var cursor = this.cursor();

  switch (fN) {
      /** \C
      Si el usuario pulsa la tecla del punto '.', la subcuenta se informa automaticamente con el código de cuenta más tantos ceros como sea necesario para completar la longitud de subcuenta asociada al ejercicio actual.
      \end */
    case "codsubcuenta":
      if (!_i.bloqueoSubcuenta && this.child("fdbCodSubcuenta").value().endsWith(".")) {
        var codSubcuenta = this.child("fdbCodSubcuenta").value().toString();
        codSubcuenta = codSubcuenta.substring(0, codSubcuenta.length - 1);
        var numCeros = _i.longSubcuenta - codSubcuenta.toString().length;
        for (var i = 0; i < numCeros; i++)
          codSubcuenta += "0";
        _i.bloqueoSubcuenta = true;
        this.child("fdbCodSubcuenta").setValue(codSubcuenta);
        _i.bloqueoSubcuenta = false;
      }
      if (!_i.bloqueoSubcuenta && this.child("fdbCodSubcuenta").value().length ==
          _i.longSubcuenta) {
        this.child("fdbIdSubcuenta").setValue(_i.calculateField("idsubcuenta"));
      }
      break;
      /** \C
      Si el usuario selecciona una cuenta bancaria, se tomará su cuenta contable asociada como cuenta contable para el pago. La subcuenta contable por defecto será la asociada a la cuenta bancaria. Si ésta está vacía, será la subcuenta correspondienta a Caja
      \end */
    case "cuenta":
      this.child("fdbIdSubcuenta").setValue(_i.calculateField("idsubcuentadefecto"));
      break;
  }
}

function oficial_calculateField(fN)
{
  var _i = this.iface;
  var cursor = this.cursor();

  var res;
  switch (fN) {
      /** \D
      La subcuenta contable por defecto será la asociada a la cuenta bancaria. Si ésta está vacía, será la subcuenta correspondienta a Caja
      \end */
    case "idsubcuentadefecto": {
      if (_i.contabActivada) {
        var codSubcuenta = AQUtil.sqlSelect("cuentasbanco", "codsubcuenta", "codcuenta = '" + cursor.valueBuffer("codcuenta") + "'");
        if (codSubcuenta)
          res = AQUtil.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + codSubcuenta + "' AND codejercicio = '" + _i.ejercicioActual + "'");
      }
      break;
    }
    case "idsubcuenta": {
      var codSubcuenta = cursor.valueBuffer("codsubcuenta").toString();
      if (codSubcuenta.length == _i.longSubcuenta)
        res = AQUtil.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + codSubcuenta + "' AND codejercicio = '" + _i.ejercicioActual + "'");
      break;
    }
    /** \C
    La cuenta bancaria por defecto será la del pagaré.
    \end */
    case "codcuenta": {
      res = cursor.cursorRelation().valueBuffer("codcuenta");
      break;
    }
  }
  return res;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////

//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
