
/** @class_declaration usupedcli */
/////////////////////////////////////////////////////////////////
//// USUPEDCLI /////////////////////////////////////////////////
class usupedcli extends oficial {
	function usupedcli( context ) { oficial ( context ); }
	function generarFactura(where:String, curAlbaran:FLSqlCursor, datosAgrupacion):Number {
		return this.ctx.usupedcli_generarFactura(where, curAlbaran, datosAgrupacion);
	}
	function actualizaUsuPedidosDeAlbCli(cursor:FLSqlCursor, campo:String):Boolean {
		return this.ctx.usupedcli_actualizaUsuPedidosDeAlbCli(cursor, campo);
	}
}
//// USUPEDCLI /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubUsuPedCli */
/////////////////////////////////////////////////////////////////
//// PUB_USUPEDCLI /////////////////////////////////////////////
class pubUsuPedCli extends head {
	function pubUsuPedCli( context ) { head( context ); }
	function pub_actualizaUsuPedidosDeAlbCli(curAlbCli:FLSqlCursor, campo:String):Boolean {
		return this.actualizaUsuPedidosDeAlbCli(curAlbCli, campo);
	}
}

//// PUB_USUPEDCLI /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition usupedcli */
/////////////////////////////////////////////////////////////////
//// USUPEDCLI /////////////////////////////////////////////////

function usupedcli_generarFactura(where:String, curAlbaran:FLSqlCursor, datosAgrupacion:Array):Number
{
	var curAlbaranes:FLSqlCursor = new FLSqlCursor("albaranescli");
	curAlbaranes.select(where);
	while (curAlbaranes.next()) {
		curAlbaranes.setModeAccess(curAlbaranes.Browse);
		curAlbaranes.refreshBuffer();
		if (!this.iface.actualizaUsuPedidosDeAlbCli(curAlbaranes, "idusufactura")) {
			return false;
		}
	}

	var idFactura:String = this.iface.__generarFactura(where, curAlbaran, datosAgrupacion);
	if (!idFactura) {
		return false;
	}

	return idFactura;
}

/** Asignamos el usuario actual a los pedidos
 * que correspondan las líneas del albarán
 */
function usupedcli_actualizaUsuPedidosDeAlbCli(curAlbCli:FLSqlCursor, campo:String):Boolean
{
	var util:FLUtil = new FLUtil;
	var idPedido:Number;
	var idUsuario:String = sys.nameUser();

	var qryLinAlb:FLSqlQuery = new FLSqlQuery;

	qryLinAlb.setTablesList("lineasalbaranescli");
	qryLinAlb.setSelect("pc.idpedido");
	qryLinAlb.setFrom("lineasalbaranescli lac INNER JOIN lineaspedidoscli lpc ON lpc.idlinea = lac.idlineapedido INNER JOIN pedidoscli pc ON pc.idpedido = lpc.idpedido");
	qryLinAlb.setWhere("lac.idalbaran = "+curAlbCli.valueBuffer("idalbaran")+" GROUP BY pc.idpedido");
	qryLinAlb.setForwardOnly(true);
	debug("KLO--> SQL: "+qryLinAlb.sql());
	if (!qryLinAlb.exec()) {
		return false;
	}
	while (qryLinAlb.next()) {
		idPedido = qryLinAlb.value("pc.idpedido")
		formpedidoscli.iface.pub_actualizarUsuarioPedCli(idPedido, campo, idUsuario);
		debug("KLO--> Id pedido de origen: "+idPedido);
	}

	return true;
}
//// USUPEDCLI /////////////////////////////////////////////////
////////////////////////////////////////////////

