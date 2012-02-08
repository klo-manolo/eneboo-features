@@add-classes
  interna
  oficial
+ gtesoreria
  recibosProv
  compRecibos
  head
  ifaceCtx
..
@@added-class gtesoreria
  /** @class_declaration gtesoreria */
  /////////////////////////////////////////////////////////////////
  //// GTESORERIA ///////////////////////////////////////////////
  class gtesoreria extends PARENT_CLASS {
          function gtesoreria( context ) { PARENT_CLASS ( context ); }
          function aplicarCriterio(tabla:String, campo:String, valor:String, signo:String):String {
                  return this.ctx.gtesoreria_aplicarCriterio(tabla, campo, valor, signo);
          }
  }
  //// GTESORERIA ///////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////
  
  /** @class_definition gtesoreria */
  /////////////////////////////////////////////////////////////////
  //// GTESORERIA /////////////////////////////////////////////////
  function gtesoreria_aplicarCriterio(tabla:String, campo:String, valor:String, signo:String):String
  {
          var criterio:String = "";
          switch (tabla) {
                  case "i_reciboscli": {
                          switch (campo) {
                                  case "reciboscli.estado": {
                                                  switch (valor) {
                                                          case "Pendiente": {
                                                                  criterio = this.iface.__aplicarCriterio(tabla, campo, valor, signo);
                                                          break;
                                                          }
                                                          case "En Riesgo": {
                                                                  criterio = "reciboscli.estado IN ('Emitido', 'Devuelto', 'Riesgo', 'Remesado')";
                                                          break;
                                                          }
                                                  }
                                  break;
                                  }
                          }
                  break;
                  }
                  default {
                          criterio = this.iface.__aplicarCriterio(tabla, campo, valor, signo);
                  }
          }
  
          return criterio;
  }
  //// GTESORERIA /////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////
  
..

