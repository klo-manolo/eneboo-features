
/** @class_declaration megarOil */
//////////////////////////////////////////////////////////////////
//// MEGAROIL ////////////////////////////////////////////////////////////////
class megarOil extends oficial {

	var toolBVerGrupoDto:Object;

	function megarOil( context ) { oficial( context ); }
	function init() { this.ctx.megarOil_init(); }

	function abrirGrupoDtoLineal() {
		return this.ctx.megarOil_abrirGrupoDtoLineal();
	}
	function capturaTab(QString:QWidget) {
		return this.ctx.megarOil_capturaTab(QString);
	}
	function calculaDtoLinealAgrupado(codCliente:String, codFamilia:String):Number {
		return this.ctx.megarOil_calculaDtoLinealAgrupado(codCliente, codFamilia);
	}
}
//// MEGAROIL ////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration pubMegarOil */
/////////////////////////////////////////////////////////////////
//// PUBMEGAROIL ///////////////////////////////////////////////
class pubMegarOil extends ifaceCtx {
	function pubMegarOil( context ) { ifaceCtx( context ); }

	function pub_calculaDtoLinealAgrupado(codCliente:String, codFamilia:String):Number {
		return this.calculaDtoLinealAgrupado(codCliente, codFamilia);
	}
}
//// PUBMEGAROIL ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition megarOil */
/////////////////////////////////////////////////////////////////
//// MEGAROIL ////////////////////////////////////////////////////////////////
function megarOil_init()
{
	this.iface.__init();

	var cursor:FLSqlCursor = this.cursor();

	this.iface.toolBVerGrupoDto = this.child("toolBVerGrupoDto");
	connect(this.iface.toolBVerGrupoDto, "clicked()", this, "iface.abrirGrupoDtoLineal()");

	connect(this.child("tbwGruposDto"), "currentChanged(QString)", this, "iface.capturaTab(QString)");
}

function megarOil_abrirGrupoDtoLineal()
{
	var codGrupoDto:String = this.child("tdbGruposDtoCli").cursor().valueBuffer("codgrupodto");
	var curGruposDto = new FLSqlCursor("gruposdto");

	curGruposDto.setAction("gruposdto");
	curGruposDto.select("codgrupodto = '" + codGrupoDto + "'");

	if (curGruposDto.first())
		curGruposDto.editRecord();
}

/*
Al pulsar la pestaña de venta.
Vuelve a rehacer la tabla con las tarifas y sus correspondientes precios.
 */
function megarOil_capturaTab(QString:QWidget)
{
	var cursor:FLSqlCursor = this.cursor();
	if (QString == "gruposdto") {
		cursor.setValueBuffer("dtolineal", this.iface.calculaDtoLinealAgrupado(cursor.valueBuffer("codcliente"),""));
		this.child("tdbGruposDtoCli").cursor().refreshBuffer();
	}
}

function megarOil_calculaDtoLinealAgrupado(codCliente:String, codFamilia:String):Number
{
	var util:FLUtil;
	var codPago:String = util.sqlSelect("clientes", "codpago", "codcliente = '" + codCliente + "'");
	var codNivConsCli:String = util.sqlSelect("clientes", "codnivelconsumo", "codcliente = '" + codCliente + "'");
	var valor:Number = 0;
	var valorGrupo:Number = 0;
	var filtro:String;

	//debug("CODCLIENTE: "+codCliente);
	//debug("CODPAGO: "+codPago);

	var qryLSGrDto:FLSqlQuery = new FLSqlQuery;
	var qryLGrDto:FLSqlQuery = new FLSqlQuery;
	var qryGrDto:FLSqlQuery = new FLSqlQuery;
	with (qryGrDto) {
		setTablesList("gruposdtocli");
		setSelect("codgrupodto");
		setFrom("gruposdtocli");
		setWhere("codcliente = '" + codCliente + "'");
	}
	if (!qryGrDto.exec())
		return false;

	while (qryGrDto.next()) {
		filtro = "lineasgruposdto.codgrupodto = '"+qryGrDto.value("codgrupodto")+"' and gruposdtocli.codcliente = '"+codCliente+"' and lineasgruposdto.codpago = '"+codPago+"' and lineasgruposdto.codnivelconsumo = '"+codNivConsCli+"'";
		if (codFamilia=="undefined" || codFamilia != "")
			filtro = filtro + " and lineasgruposdto.codfamilia = '"+codFamilia+"'";
		//debug("WHERE 1: "+filtro);
		//debug("CODGRUPODTO: "+qryGrDto.value("codgrupodto"));
		with (qryLGrDto) {
			setTablesList("lineasgruposdto");
			setSelect("codpago, codnivelconsumo, lineasgruposdto.dtolineal");
			setFrom("lineasgruposdto inner join gruposdtocli on lineasgruposdto.codgrupodto = gruposdtocli.codgrupodto");
			setWhere(filtro);
		}
		//debug("SQL LINEASGRUPO: "+qryLGrDto.sql());
		if (qryLGrDto.exec()) {
			// Si no hay lineas que cumplan teniendo forma de pago se mira si las hay sin forma de pago.
			if (qryLGrDto.size() == 0) {
				//debug("NO HAY LINEAS DE GRUPO CON FORMA DE PAGO. MIRA SIN FORMA DE PAGO.");
				filtro = "lineasgruposdto.codgrupodto = '"+qryGrDto.value("codgrupodto")+"' and gruposdtocli.codcliente = '"+codCliente+"' and (lineasgruposdto.codpago = '' or lineasgruposdto.codpago is null) and lineasgruposdto.codnivelconsumo = '"+codNivConsCli+"'";
				if (codFamilia == "undefined" || codFamilia != "")
					filtro = filtro + " and lineasgruposdto.codfamilia = '"+codFamilia+"'";
				qryLGrDto.setWhere(filtro);
				//debug("SQL LINEASGRUPO SIN FORMA PAGO: "+qryLGrDto.sql());
				if (!qryLGrDto.exec()) {
					return 0;
				}
			}
			while (qryLGrDto.next()) {
				//debug("LINEAGRUPODTO: "+qryLGrDto.value("codnivelconsumo"));
				valorGrupo = valorGrupo + qryLGrDto.value("lineasgruposdto.dtolineal");
				valor = valor + qryLGrDto.value("lineasgruposdto.dtolineal");
				//debug("VALOR LINEAGRUPODTO: "+valor);
			}
		}
		if (qryLGrDto.size() == 0) {
			//debug("NO HAY LINEAS DE GRUPO. MIRA EN SUBGRUPOS");
			with (qryLGrDto) {
				setTablesList("subgruposdto");
				setSelect("sg.codsubgrupodto");
				setFrom("subgruposdto sg inner join gruposdtocli g on sg.codgrupodto = g.codgrupodto");
				setWhere("sg.codgrupodto = '"+qryGrDto.value("codgrupodto")+"' and g.codcliente = '"+codCliente+"'");
			}
			//debug("SQL SUBGRUPO: "+qryLGrDto.sql());
			if (qryLGrDto.exec()) {
				while (qryLGrDto.next()) {
					//debug("SUBGRUPODTO: "+qryLGrDto.value("sg.codsubgrupodto"));
					filtro = "lsg.codsubgrupodto = '"+qryLGrDto.value("sg.codsubgrupodto")+"' and lsg.codpago = '"+codPago+"' and lsg.codnivelconsumo = '"+codNivConsCli+"'";
					if (codFamilia=="undefined" || codFamilia != "")
						filtro = filtro + " and lsg.codfamilia = '"+codFamilia+"'";
					with (qryLSGrDto) {
						setTablesList("lineassubgruposdto");
						setSelect("lsg.codnivelconsumo, lsg.dtolineal");
						setFrom("lineassubgruposdto lsg inner join subgruposdto sg on lsg.codsubgrupodto = sg.codsubgrupodto");
						setWhere(filtro);
					}
					//debug("FILTRO SG: "+filtro);
					//debug("SQL LINEASSUBGRUPO: "+qryLSGrDto.sql());
					if (qryLSGrDto.exec()) {
						// Si no hay lineas que cumplan teniendo forma de pago se mira si las hay sin forma de pago.
						if (qryLSGrDto.size() == 0) {
							debug("NO HAY LINEAS DE SUBGRUPO CON FORMA DE PAGO. MIRA SIN FORMA DE PAGO.");
							filtro = "lsg.codsubgrupodto = '"+qryLGrDto.value("sg.codsubgrupodto")+"' and (lsg.codpago = '' or lsg.codpago is null) and lsg.codnivelconsumo = '"+codNivConsCli+"'";
							if (codFamilia=="undefined" || codFamilia != "")
								filtro = filtro + " and lsg.codfamilia = '"+codFamilia+"'";
							qryLSGrDto.setWhere(filtro);
							//debug("SQL LINEASSUBGRUPO SIN FORMA PAGO: "+qryLSGrDto.sql());
							if (!qryLSGrDto.exec()) {
								return 0;
							}
						}
						while (qryLSGrDto.next()) {
							debug("LINEASSUBGRUPODTO->DTOLINEAL: "+qryLSGrDto.value("lsg.dtolineal"));
							valorGrupo = valorGrupo + qryLSGrDto.value("lsg.dtolineal");
							valor = valor + qryLSGrDto.value("lsg.dtolineal");
							debug("VALOR LINEASUBGRUPODTO: "+valor);
						}
					}
				}
			}
		}
		//debug("CANTIDAD DE REGISTROS: "+qryLGrDto.size());
		util.sqlUpdate("gruposdtocli","dtolineal",valorGrupo,"codcliente = '" + codCliente + "' and codgrupodto = '"+qryGrDto.value("codgrupodto")+"'");

		//debug("VALORGRUPO: "+valorGrupo);
		valorGrupo = 0;
		//debug("PASADA");
	}
	debug("calculaDtoLinealAgrupado: "+valor);
	return valor;
}
//// MEGAROIL ////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

