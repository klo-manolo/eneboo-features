
/** @class_declaration proyectoscc */
/////////////////////////////////////////////////////////////////
//// PROYECTOSCC ////////////////////////////////////////////////
class proyectoscc extends oficial {
    function proyectoscc( context ) { oficial ( context ); }
	function beforeCommit_cl_proyectos(curProyecto:FLSqlCursor):Boolean {
		return this.ctx.proyectoscc_beforeCommit_cl_proyectos(curProyecto);
	}
	function beforeCommit_cl_subproyectos(curSubProyecto:FLSqlCursor):Boolean {
		return this.ctx.proyectoscc_beforeCommit_cl_subproyectos(curSubProyecto);
	}
	function crearCentroCoste(codigo:String,descripcion:String):String {
		return this.ctx.proyectoscc_crearCentroCoste(codigo,descripcion);
	}
	function crearSubCentroCoste(codigo:String,descripcion:String,codCentro:String):String {
		return this.ctx.proyectoscc_crearSubCentroCoste(codigo,descripcion,codCentro);
	}
}
//// PROYECTOSCC ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition proyectoscc */
/////////////////////////////////////////////////////////////////
//// PROYECTOSCC ////////////////////////////////////////////////
function proyectoscc_beforeCommit_cl_proyectos(curProyecto:FLSqlCursor):Boolean
{
	var util:FLUtil;

	switch (curProyecto.modeAccess()) {
	 	case curProyecto.Insert: {
			var codCentro:String = curProyecto.valueBuffer("codcentro");
			if(codCentro && codCentro != "")
				return true;

			var codProyecto:String = curProyecto.valueBuffer("codproyecto");
			if(!codProyecto || codProyecto == "")
				return false;

			var descripcion:String = curProyecto.valueBuffer("descripcion");

			codCentro = this.iface.crearCentroCoste(codProyecto,descripcion);
			if(!codCentro || codCentro == "")
				return false;

			curProyecto.setValueBuffer("codcentro",codCentro);

			break;
		}
		case curProyecto.Del: {
			var codCentro:String = curProyecto.valueBuffer("codcentro");
			if(!codCentro || codCentro == "")
				return true;

			var codProyecto:String = curProyecto.valueBuffer("codproyecto");
			if(!codProyecto || codProyecto == "")
				return false;
			util.sqlUpdate("cl_proyectos","codcentro","","codproyecto = '" + codProyecto + "'");

			var curCentro:FLSqlCursor = new FLSqlCursor("centroscoste");
			curCentro.select("codcentro = '" + codCentro + "'");
			if(!curCentro.first())
				return false;
			curCentro.setModeAccess(curCentro.Del);
			curCentro.refreshBuffer();
			if(!curCentro.commitBuffer())
				return false;

			break;
		}
	}

	return true;
}

function proyectoscc_crearCentroCoste(codigo:String,descripcion:String):String
{
	var util:FLUtil;
	var curCentro:FLSqlCursor = new FLSqlCursor("centroscoste");
	curCentro.setModeAccess(curCentro.Insert);
	curCentro.refreshBuffer();
	curCentro.setValueBuffer("codcentro", codigo);
	curCentro.setValueBuffer("descripcion", descripcion);
	if(!curCentro.commitBuffer())
		return false;

	return codigo;
}

function proyectoscc_beforeCommit_cl_subproyectos(curSubProyecto:FLSqlCursor):Boolean
{
	var util:FLUtil;

	switch (curSubProyecto.modeAccess()) {
		case curSubProyecto.Insert: {
			var codSubCentro:String = curSubProyecto.valueBuffer("codsubcentro");
			if(codSubCentro && codsubCentro != "")
				return true;

			var codSubProyecto:String = curSubProyecto.valueBuffer("codsubproyecto");
			if(!codSubProyecto || codSubProyecto == "")
				return false;

			var descripcion:String = curSubProyecto.valueBuffer("descripcion");
			var proyecto:String = curSubProyecto.valueBuffer("codproyecto");
			var codCentro:String = util.sqlSelect("cl_proyectos","codcentro","codproyecto = '" + proyecto + "'");
			if(!codCentro || codCentro == "")
				return false;

			codSubCentro = this.iface.crearSubCentroCoste(codSubProyecto,descripcion,codCentro);
			if(!codSubCentro || codSubCentro == "")
				return false;

			curSubProyecto.setValueBuffer("codsubcentro",codSubCentro);

			break;
		}
		case curSubProyecto.Del: {
			var codSubCentro:String = curSubProyecto.valueBuffer("codsubcentro");
			if(!codSubCentro || codSubCentro == "")
				return true;

			var codSubProyecto:String = curSubProyecto.valueBuffer("codsubproyecto");
			if(!codSubProyecto || codSubProyecto == "")
				return false;
			util.sqlUpdate("cl_subproyectos","codsubcentro","","codsubproyecto = '" + codSubProyecto + "'");

			var curSubCentro:FLSqlCursor = new FLSqlCursor("subcentroscoste");
			curSubCentro.select("codsubcentro = '" + codSubCentro + "'");
			if(!curSubCentro.first())
				return false;
			curSubCentro.setModeAccess(curSubCentro.Del);
			curSubCentro.refreshBuffer();
			if(!curSubCentro.commitBuffer())
				return false;

			break;
		}
	}

	return true;
}

function proyectoscc_crearSubCentroCoste(codigo:String,descripcion:String,codCentro):String
{
	var util:FLUtil;
	var curCentro:FLSqlCursor = new FLSqlCursor("subcentroscoste");
	curCentro.setModeAccess(curCentro.Insert);
	curCentro.refreshBuffer();
	curCentro.setValueBuffer("codsubcentro", codigo);
	curCentro.setValueBuffer("descripcion", descripcion);
	curCentro.setValueBuffer("codcentro", codCentro);
	if(!curCentro.commitBuffer())
		return false;

	return codigo;
}
//// PROYECTOSCC ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

