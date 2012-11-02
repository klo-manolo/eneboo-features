
/** @class_declaration prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN /////////////////////////////////////////////////
class prod extends oficial {
	function prod( context ) { oficial ( context ); }
	function afterCommit_lineaspedidosprov(curLP:FLSqlCursor):Boolean {
		return this.ctx.prod_afterCommit_lineaspedidosprov(curLP);
	}
	function beforeCommit_pedidoscli(curPedido:FLSqlCursor):Boolean {
		return this.ctx.prod_beforeCommit_pedidoscli(curPedido);
	}
	function beforeCommit_albaranescli(curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.prod_beforeCommit_albaranescli(curAlbaran);
	}
	function beforeCommit_pedidosprov(curPedido:FLSqlCursor):Boolean {
		return this.ctx.prod_beforeCommit_pedidosprov(curPedido);
	}
	function beforeCommit_albaranesprov(curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.prod_beforeCommit_albaranesprov(curAlbaran);
	}
}
//// PRODUCCIÓN /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition prod */
/////////////////////////////////////////////////////////////////
//// PRODUCCIÓN /////////////////////////////////////////////////
/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea si el sistema
está configurado para ello
\end */
function prod_afterCommit_lineaspedidosprov(curLP:FLSqlCursor):Boolean
{

 	if (sys.isLoadedModule("flfactalma"))
		if (!flfactalma.iface.pub_controlStockPedidosProv(curLP))
			return false;

	return true;
}

/** \C
Al modificar la fecha del pedido es necesario reajustar las fechas de producción y consumo asociadas a los artículos contenidos en el mismo
\end */
function prod_beforeCommit_pedidoscli(curPedido:FLSqlCursor):Boolean
{
	if (!this.iface.__beforeCommit_pedidoscli(curPedido))
		return false;

	switch (curPedido.modeAccess()) {
		case curPedido.Edit: {
			if (curPedido.valueBuffer("fechasalida") != curPedido.valueBufferCopy("fechasalida")) {
				if (!flfactalma.iface.pub_modificarFechaPedidoCli(curPedido))
					return false;
			}
			break;
		}
	}
	return true;
}

/** \C
Al modificar la fecha del albarán es necesario reajustar las fechas de producción y consumo asociadas a los artículos contenidos en el mismo
\end */
function prod_beforeCommit_albaranescli(curAlbaran:FLSqlCursor):Boolean
{
	if (!this.iface.__beforeCommit_albaranescli(curAlbaran)) {
		return false;
	}
	switch (curAlbaran.modeAccess()) {
		case curAlbaran.Edit: {
			if (curAlbaran.valueBuffer("fecha") != curAlbaran.valueBufferCopy("fecha")) {
				if (!flfactalma.iface.pub_modificarFechaAlbaranCli(curAlbaran)) {
					return false;
				}
			}
			break;
		}
	}
	return true;
}

/** \C
Al modificar la fecha del albarán es necesario reajustar las fechas de producción y consumo asociadas a los artículos contenidos en el mismo
\end */
function prod_beforeCommit_albaranesprov(curAlbaran:FLSqlCursor):Boolean
{
	if (!this.iface.__beforeCommit_albaranesprov(curAlbaran)) {
		return false;
	}
	switch (curAlbaran.modeAccess()) {
		case curAlbaran.Edit: {
			if (curAlbaran.valueBuffer("fecha") != curAlbaran.valueBufferCopy("fecha")) {
				if (!flfactalma.iface.pub_modificarFechaAlbaranProv(curAlbaran)) {
					return false;
				}
			}
			break;
		}
	}
	return true;
}

/** \C
Al modificar la fecha del pedido es necesario reajustar las fechas de producción y consumo asociadas a los artículos contenidos en el mismo
\end */
function prod_beforeCommit_pedidosprov(curPedido:FLSqlCursor):Boolean
{
	if (!this.iface.__beforeCommit_pedidosprov(curPedido))
		return false;

	switch (curPedido.modeAccess()) {
		case curPedido.Edit: {
			if (curPedido.valueBuffer("fechaentrada") != curPedido.valueBufferCopy("fechaentrada")) {
				if (!flfactalma.iface.pub_modificarFechaPedidoProv(curPedido))
					return false;
			}
			break;
		}
	}
	return true;
}

//// PRODUCCIÓN /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

