
/** @class_declaration tiposremprov */
//////////////////////////////////////////////////////////////////
//// TIPOSREMPROV ////////////////////////////////////////////////
class tiposremprov extends recibosProv {
    function tiposremprov( context ) { recibosProv ( context ); }
    function aplicarCriterio(tabla:String, campo:String, valor:String, signo:String):String {
        return this.ctx.tiposremprov_aplicarCriterio(tabla, campo, valor, signo);
    }
}
//// TIPOSREMPROV /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition tiposremprov */
/////////////////////////////////////////////////////////////////
//// TIPOSREMPROV ///////////////////////////////////////////////
function tiposremprov_aplicarCriterio(tabla:String, campo:String, valor:String, signo:String):String
{
        var criterio:String = "";
        switch (tabla) {
                case "i_recibosprov": {
                        switch (campo) {
                                case "recibosprov.estado": {
                                        switch (valor) {
                                                case "Pendiente": {
                                                        criterio = "recibosprov.estado IN ('Emitido', 'Devuelto','Remesado','Confirmado')";
                                                        break;
                                                }
                                        }
                                        break;
                                }
                        }
                        break;
                }
        }

        if (criterio == "") {
                criterio = this.iface.__aplicarCriterio(tabla, campo, valor, signo);
        }
        return criterio;
}
//// TIPOSREMPROV ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

