
/** @class_declaration servcliIvaInc */
/////////////////////////////////////////////////////////////////
//// SERVCLI_IVAINC ////////////////////////////////////////
class servcliIvaInc extends oficial
{
  function servcliIvaInc(context)
  {
    oficial(context);
  }
  function datosLineaServicio(datosArt: Array): Boolean {
    return this.ctx.servcliIvaInc_datosLineaServicio(datosArt);
  }
}
//// SERVCLI_IVAINC ////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition servcliIvaInc */
/////////////////////////////////////////////////////////////////
//// SERVCLI_IVAINC ////////////////////////////////////////
function servcliIvaInc_datosLineaServicio(datosArt: Array): Boolean {
  var util = new FLUtil;

  if (!this.iface.__datosLineaServicio(datosArt))
    return false;

  var ivaInc = formRecordlineaspedidoscli.iface.pub_commonCalculateField("ivaincluido", this.iface.curLineaServicio_)

  this.iface.curLineaServicio_.setValueBuffer("ivaincluido", ivaInc);

  if (ivaInc)
  {
    this.iface.curLineaServicio_.setValueBuffer("pvpunitarioiva", formRecordlineaspedidoscli.iface.pub_commonCalculateField("pvpunitarioiva", this.iface.curLineaServicio_));
    this.iface.curLineaServicio_.setValueBuffer("pvpunitario", formRecordlineaspedidoscli.iface.pub_commonCalculateField("pvpunitario2", this.iface.curLineaServicio_));
    this.iface.curLineaServicio_.setValueBuffer("pvpsindtoiva", formRecordlineaspedidoscli.iface.pub_commonCalculateField("pvpsindtoiva2", this.iface.curLineaServicio_));
    this.iface.curLineaServicio_.setValueBuffer("pvpsindto", formRecordlineaspedidoscli.iface.pub_commonCalculateField("pvpsindto2", this.iface.curLineaServicio_));
    this.iface.curLineaServicio_.setValueBuffer("pvptotaliva", formRecordlineaspedidoscli.iface.pub_commonCalculateField("pvptotaliva2", this.iface.curLineaServicio_));
    this.iface.curLineaServicio_.setValueBuffer("pvptotal", formRecordlineaspedidoscli.iface.pub_commonCalculateField("pvptotal2", this.iface.curLineaServicio_));
  } else {
    this.iface.curLineaServicio_.setValueBuffer("pvpunitario", formRecordlineaspedidoscli.iface.pub_commonCalculateField("pvpunitario", this.iface.curLineaServicio_));
    this.iface.curLineaServicio_.setValueBuffer("pvpunitarioiva", formRecordlineaspedidoscli.iface.pub_commonCalculateField("pvpunitarioiva2", this.iface.curLineaServicio_));
    this.iface.curLineaServicio_.setValueBuffer("pvpsindto", formRecordlineaspedidoscli.iface.pub_commonCalculateField("pvpsindto", this.iface.curLineaServicio_));
    this.iface.curLineaServicio_.setValueBuffer("pvpsindtoiva", formRecordlineaspedidoscli.iface.pub_commonCalculateField("pvpsindtoiva", this.iface.curLineaServicio_));
    this.iface.curLineaServicio_.setValueBuffer("pvptotal", formRecordlineaspedidoscli.iface.pub_commonCalculateField("pvptotal", this.iface.curLineaServicio_));
    this.iface.curLineaServicio_.setValueBuffer("pvptotaliva", formRecordlineaspedidoscli.iface.pub_commonCalculateField("pvptotaliva", this.iface.curLineaServicio_));
  }

  return true;
}
//// SERVCLI_IVAINC ////////////////////////////////////////
/////////////////////////////////////////////////////////////////
