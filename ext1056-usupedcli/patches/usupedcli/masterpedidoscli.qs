
/** @class_declaration usupedcli */
/////////////////////////////////////////////////////////////////
//// USUPEDCLI /////////////////////////////////////////////////
class usupedcli extends oficial {
	function usupedcli( context ) { oficial ( context ); }
	function actualizarUsuarioPedCli(idPedido:String, campo:String, idUsuario:String):Boolean {
		return this.ctx.usupedcli_actualizarUsuarioPedCli(idPedido, campo, idUsuario);
	}
	function generarAlbaran(where:String, cursor:FLSqlCursor, datosAgrupacion:Array):Number {
		return this.ctx.usupedcli_generarAlbaran(where, cursor, datosAgrupacion);
	}
}
//// USUPEDCLI /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubUsuPedCli */
/////////////////////////////////////////////////////////////////
//// PUB_USUPEDCLI /////////////////////////////////////////////
class pubUsuPedCli extends head {
	function pubUsuPedCli( context ) { head ( context ); }
	function pub_actualizarUsuarioPedCli(idPedido:String, campo:String, idUsuario:String):Boolean {
		return this.actualizarUsuarioPedCli(idPedido, campo, idUsuario);
	}
}
//// PUB_USUPEDCLI /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition usupedcli */
/////////////////////////////////////////////////////////////////
//// USUPEDCLI /////////////////////////////////////////////////
function usupedcli_actualizarUsuarioPedCli(idPedido:String, campo:String, idUsuario:String):Boolean
{
	if (!idUsuario)
		idUsuario = sys.nameUser();

	var curPedido:FLSqlCursor = new FLSqlCursor("pedidoscli");
	curPedido.setActivatedCommitActions(false);
	curPedido.select("idpedido = " + idPedido);
	if (!curPedido.first()) {
		return false;
	}
	var editable:Boolean = curPedido.valueBuffer("editable");
	if (!editable) {
		curPedido.setUnLock("editable", true);
		curPedido.select("idpedido = " + idPedido);
		if (!curPedido.first()) {
			return false;
		}
	}

	curPedido.setModeAccess(curPedido.Edit);
	curPedido.refreshBuffer();
	curPedido.setValueBuffer(campo, idUsuario);
	if (!curPedido.commitBuffer()) {
		return false;
	}

	if (!editable) {
		curPedido.select("idpedido = " + idPedido);
		if (!curPedido.first()) {
			return false;
		}
		curPedido.setUnLock("editable", false);
	}

	return true;
}

function usupedcli_generarAlbaran(where:String, cursor:FLSqlCursor):Number
{
	var idAlbaran:String = this.iface.__generarAlbaran(where, cursor);
	if (!idAlbaran) {
		return false;
	}

	// Ponemos el usuario en los pedidos de origen.
	var curAlbCli:FLSqlCursor = new FLSqlCursor("albaranescli");
	curAlbCli.select("idalbaran = "+idAlbaran);
	curAlbCli.next();
	formalbaranescli.iface.pub_actualizaUsuPedidosDeAlbCli(curAlbCli, "idusualbarana");

	return idAlbaran;
}
//// USUPEDCLI /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

