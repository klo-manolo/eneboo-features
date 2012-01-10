
/** @class_declaration megarOil */
/////////////////////////////////////////////////////////////////
//// MEGAT OIL /////////////////////////////////////////////////
class megarOil extends oficial {
	function megarOil( context ) { oficial ( context ); }
	function init() { this.ctx.megarOil_init(); }
}
//// MEGAR OIL /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition megarOil */
/////////////////////////////////////////////////////////////////
//// MEGAR OIL /////////////////////////////////////////////////
function megarOil_init()
{
	var cursor:FLSqlCursor = this.cursor();
	this.iface.pbnCambiarEjercicioActual = this.child("pbnCambiarEjercicioActual");
	this.iface.bloqueoProvincia = false;
	connect(this.iface.pbnCambiarEjercicioActual, "clicked()", this, "iface.pbnCambiarEjercicioActual_clicked");
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");

	if (!flfactppal.iface.pub_ejercicioActual())
		flfactppal.iface.pub_cambiarEjercicioActual(this.cursor().valueBuffer("codejercicio"));

	//KLO. this.child("fdbCodEjercicio").close();
	//KLO. this.child("fdbNombreEjercicio").close();

	this.iface.mostrarEjercicioActual();
}
//// MEGAR OIL /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

