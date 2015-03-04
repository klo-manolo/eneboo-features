
/** @class_declaration traza */
/////////////////////////////////////////////////////////////////
//// TRAZABILIDAD ///////////////////////////////////////////////
class traza extends oficial {
    function traza( context ) { oficial ( context ); }
    function whereFijoExtendido(nombreInforme:String):String {
        return this.ctx.traza_whereFijoExtendido(nombreInforme);
    }
}
//// TRAZABILIDAD ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition traza */
/////////////////////////////////////////////////////////////////
//// TRAZABILIDAD ///////////////////////////////////////////////
/** Agrega parametros directamente al whereFijo
\end */
function traza_whereFijoExtendido(nombreInforme:String)
{
    if (!this.iface.whereFijoExt || this.iface.whereFijoExt == "") {
        this.iface.whereFijoExt = "PARAM_LOAD_traza\nSi\n";
    } else {
        this.iface.whereFijoExt = this.iface.whereFijoExt + "PARAM_LOAD_traza\nSi\n";
    }

    this.iface.__whereFijoExtendido(nombreInforme);
    return;
}

//// TRAZABILIDAD ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

