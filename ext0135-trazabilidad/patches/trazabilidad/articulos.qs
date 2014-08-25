
/** @class_declaration lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
class lotes extends oficial
{
  function lotes(context)
  {
    oficial(context);
  }
  function init()
  {
    return this.ctx.lotes_init();
  }
  function bufferChanged(fN: String)
  {
    return this.ctx.lotes_bufferChanged(fN);
  }
}
//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
/** \C
Si el artículo no tiene gestión de lotes, el campo --diasconsumo-- y la tabla de lotes activos estarán inhabilitados

En la tabla de lotes se mostrarán los lotes activos, es decir, los que tengan su campo 'En almacén' distinto de cero o su fecha de caducidad no esté cumplida
*/
function lotes_init()
{
  this.iface.__init();

  this.child("tdbLotes").setReadOnly(true);

  this.child("tdbLotes").cursor().setMainFilter("(enalmacen > 0 OR caducidad > CURRENT_DATE) AND referencia = '" + this.cursor().valueBuffer("referencia") + "'");
  this.child("tdbLotes").refresh();
  if (this.cursor().valueBuffer("porlotes") == false) {
    this.child("fdbDiasConsumo").setDisabled(true);
    this.child("tdbLotes").setDisabled(true);
  }
  this.iface.bufferChanged("porlotes");
}

/** \C
Si se modifica el indicador --porlotes--, los controles asociados se habilitan o inhabilitan de acuerdo con el indicador
*/
function lotes_bufferChanged(fN: String)
{
  switch (fN) {
    case "porlotes" : {
      if (this.cursor().valueBuffer("porlotes") == false) {
        this.child("fdbDiasConsumo").setDisabled(true);
        this.child("tdbLotes").setDisabled(true);
      } else {
        this.child("fdbDiasConsumo").setDisabled(false);
        this.child("tdbLotes").setDisabled(false);
      }
      break;
    }
    default :
      return this.iface.__bufferChanged(fN);
  }
}

//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
