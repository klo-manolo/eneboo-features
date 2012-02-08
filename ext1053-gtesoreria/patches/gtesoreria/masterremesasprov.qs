@@add-classes
  interna
  oficial
+ gtesoreria
  norma34
  head
  ifaceCtx
..
@@added-class gtesoreria
  /** @class_declaration gtesoreria */
  //////////////////////////////////////////////////////////////////
  //// GTESORERIA /////////////////////////////////////////////////////
  class gtesoreria extends PARENT_CLASS {
      function gtesoreria( context ) { PARENT_CLASS( context ); }
          function imprimir() {
                  return this.ctx.gtesoreria_imprimir();
          }
  }
  //// GTESORERIA /////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////
  
  /** @class_definition gtesoreria */
  //////////////////////////////////////////////////////////////////
  //// GTESORERIA /////////////////////////////////////////////////////
  
  // KLO. OJO: Rompe herencia
  function gtesoreria_imprimir()
  {
          if (this.cursor().size() == 0)
                  return;
  
          if (sys.isLoadedModule("flfactinfo")) {
                  var idRemesa:Number = this.cursor().valueBuffer("idremesa");
                  var idRecibos:String = formRecordremesasprov.iface.idRecibosRemesa(idRemesa);
                  var curImprimir:FLSqlCursor = new FLSqlCursor("i_recibosprov");
                  curImprimir.setModeAccess(curImprimir.Insert);
                  curImprimir.refreshBuffer();
                  curImprimir.setValueBuffer("descripcion", "temp");
                  flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_resrecibosprov", "recibosprov.codigo", "", false, false, "idrecibo IN ("+idRecibos+")");
          } else
                  flfactppal.iface.pub_msgNoDisponible("Informes");
  }
  //// GTESORERIA /////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  
..

