
/** @class_declaration actPrecios */
/////////////////////////////////////////////////////////////////
//// ACT_PRECIOS //////////////////////////////////////////////////
class actPrecios extends oficial
{
	var sep:String = "ð";
	var tablaDestino:String = "articulos";
	var crearSiNoExiste:Boolean = false;
	var corr = [];
	var pos = [];
	var arrayNomCampos = [];
	var tableDBRecords:Object;

    function actPrecios( context ) { oficial ( context ); }
	function init() {
		return this.ctx.actPrecios_init();
	}
	function importar() {
		return this.ctx.actPrecios_importar();
	}
	function preprocesarFichero(tabla:String, file, posClaveFich:String, encabezados:String):Array {
		return this.ctx.actPrecios_preprocesarFichero(tabla, file, posClaveFich, encabezados);
	}
	function leerLinea(file, numCampos):String {
		return this.ctx.actPrecios_leerLinea(file, numCampos);
	}
	function crearCorrespondencias() {
		return this.ctx.actPrecios_crearCorrespondencias();
	}
	function crearPosiciones(cabeceras:String) {
		return this.ctx.actPrecios_crearPosiciones(cabeceras);
	}
	function comprobarFichero(cabeceras:String) {
		return this.ctx.actPrecios_comprobarFichero(cabeceras);
	}
	function whereTablaDestino( linea:String ):String {
		return this.ctx.actPrecios_whereTablaDestino( linea );
	}
}
//// ACT_PRECIOS //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition actPrecios */
/////////////////////////////////////////////////////////////////
//// ACT_PRECIOS //////////////////////////////////////////////////

function actPrecios_init()
{
	this.iface.tableDBRecords = this.child("tableDBRecords")
	connect(this.child("pbnImportar"), "clicked()", this, "iface.importar");

	this.iface.__init();
}

function actPrecios_importar()
{
	var util:FLUtil = new FLUtil();

	var res:Object = MessageBox.information(util.translate("scripts",  "Van a realizarse el proceso de importación. Esta acción no podrá deshacerse.\nEs aconsejable tener copias de seguridad en su base de datos antes de proceder.\n\n¿Desea continuar?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
	if (res != MessageBox.Yes) return;

	this.iface.corr = [];
	this.iface.pos = [];
	this.iface.arrayNomCampos = [];

	var fichero:String = FileDialog.getOpenFileName( util.translate( "scripts", "Texto CSV (precios.csv)" ), util.translate( "scripts", "Elegir fichero de artículos" ) );

	if (!fichero) return;
	if ( !File.exists( fichero ) ) {
		MessageBox.information( util.translate( "scripts", "Ruta errónea" ),
								MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return ;
	}

	var file = new File( fichero );
	file.open( File.ReadOnly );

	var encabezados:String = file.readLine();

	if (!this.iface.comprobarFichero(encabezados))
		return false;

	this.iface.crearCorrespondencias();
	this.iface.crearPosiciones(encabezados);

	if (!encabezados) {
		MessageBox.information( util.translate( "scripts", "El fichero está vácío" ),
								MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return ;
	}

	var arrayLineas = this.iface.preprocesarFichero(this.iface.tablaDestino, file, this.iface.pos["REF"], encabezados);

	var curTab:FLSqlCursor = new FLSqlCursor(this.iface.tablaDestino);
	var referencia:String;
	var pvp:Number;
	var actualizados:Number = 0;
	var creados:Number = 0;
	var faltanFila:Number = 0;
	var faltan:String = "";

	util.createProgressDialog( util.translate( "scripts", "Actualizando precios..." ), arrayLineas.length);

	for (var i:Number = 0; i < arrayLineas.length; i++) {
		linea = arrayLineas[i];
		campos = linea.split(this.iface.sep);
		referencia = campos[this.iface.pos["REF"]];

		curTab.select( this.iface.whereTablaDestino( linea ) );

		// Edición
		if (curTab.first()) {
			actualizados++;
			curTab.setModeAccess(curTab.Edit);
			curTab.refreshBuffer();
 		}
		// No existe
		else {
			if ( this.iface.crearSiNoExiste ) {
				creados++;
				curTab.setModeAccess(curTab.Insert);
				curTab.refreshBuffer();
			} else {
				faltan += referencia + " ";
				faltanFila++;
				// 5 por fila
				if (faltanFila == 5) {
					faltan += "\n";
					faltanFila = 0;
				}
				util.setProgress(i);
				continue;
			}
		}

		for (var j:Number = 0; j < this.iface.arrayNomCampos.length; j++) {
			nomCampo = this.iface.arrayNomCampos[j];
			// Control de campos numéricos cuando el dato está vacío
			tipoCampo = curTab.fieldType(this.iface.corr[nomCampo]);
			if (tipoCampo >= 17 && tipoCampo <= 19)
				if (!campos[this.iface.pos[nomCampo]])
					campos[this.iface.pos[nomCampo]] = 0;
				else {
					valor = campos[this.iface.pos[nomCampo]];
					valor = valor.toString().replace(",",".");
					campos[this.iface.pos[nomCampo]] = valor;
				}

			curTab.setValueBuffer(this.iface.corr[nomCampo], campos[this.iface.pos[nomCampo]]);
		}
		if (!curTab.commitBuffer())
			debug("Error al actualizar/crear el artículo " + referencia + " en la línea válida " + i);

		util.setProgress(i);
	}

	util.destroyProgressDialog();

	var util:FLUtil = new FLUtil();
	MessageBox.information( util.translate( "scripts", "Se actualizaron los precios de %0 artículos.\n\nSe crearon los precios de %1 articulos.").arg(actualizados).arg(creados), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );

	if (faltan)
		MessageBox.information( util.translate( "scripts", "Los siguientes artículos no se encuentran registrados:\n\n%0\n\nPuede crearlos y repetir la actualización").arg(faltan), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );

}

/** \D
Indica la clausula where necesaria para determinar si existe el registro destino para la linea de texto pasada
@param	linea	Linea de texto del fichero correspondiente a un registro
\end */
function actPrecios_whereTablaDestino( linea:String ):String {
	var campos:Array = linea.split(this.iface.sep);
	var referencia:String = campos[this.iface.pos["REF"]];
	var where:String = "referencia = '" + referencia + "'";

	return where;
}

/** \D Recorre el fichero buscando registros existentes y devuelve un
array con los registros a importar
@param posClaveFich Posición del campo clave en el fichero
*/
function actPrecios_preprocesarFichero(tabla:String, file, posClaveFich:String, encabezados:String):Array
{
	var arrayLineas:Array = [];

	var i:Number = 0;
	var j:Number = 0;
	var bufferLinea:String;
	var arrayBuffer = [];

	var campos:Array = encabezados.split(this.iface.sep);
	var numCampos:Number = campos.length;
	var campoClave:String;
	var numLineas:Number = 0;

	var util:FLUtil = new FLUtil();
	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Preprocesando datos..." ), 30);

	while ( !file.eof ) {
		linea = this.iface.leerLinea(file, numCampos);
		campos = linea.split(this.iface.sep);
		campoClave = campos[posClaveFich];
		if (!campoClave || campoClave.toString().length < 2 ) continue;

		if (campos.length != numCampos) {
			debug("Se ignora la línea " + parseInt(numLineas - 1) + ". No contiene un registro válido")
			continue;
		}

		arrayLineas[numLineas++] = linea;
		util.setProgress(paso++);
		if (paso == 29)
			paso = 1;
	}
	util.destroyProgressDialog();

	file.close();

	return arrayLineas;
}

function actPrecios_leerLinea(file, numCampos):String
{
	var regExp:RegExp = new RegExp( "\"" );
	regExp.global = true;

	contCampos = 0;
	var linea:String = "";

	while (contCampos < numCampos) {
		bufferLinea = file.readLine().replace( regExp, "" );
		if (bufferLinea.length < 2 || bufferLinea.left(1) == "#") continue;
		linea += bufferLinea;
		arrayBuffer = bufferLinea.split(this.iface.sep);
		contCampos += arrayBuffer.length;
	}

	// Eliminamos el salto de línea
	if (linea.charCodeAt( linea.length - 1 ) == 10)
		linea = linea.left(linea.length - 1);

	return linea;
}

function actPrecios_crearCorrespondencias()
{
	this.iface.arrayNomCampos = new Array("REF","PVP");

	this.iface.corr["REF"] = "referencia";
	this.iface.corr["PVP"] = "pvp";
}

/** Crea un array con las posiciones de los nombres de campos en el fichero
@param cabeceras String con la primera línea del fichero que contiene las cabeceras
*/
function actPrecios_crearPosiciones(cabeceras:String)
{
	// Eliminar el retorno de carro
	cabeceras = cabeceras.left(cabeceras.length - 1);

	var campos = cabeceras.split(this.iface.sep);
	var campo:String;

	for (var i:Number = 0; i < campos.length; i++) {
		campo = campos[i];
		campo = campo.toString();
		this.iface.pos[campo] = i;
	}
}

/** Comprueba que la primera línea del fichero contiene un campo REF y un PVP
@param cabeceras String con la primera línea del fichero que contiene las cabeceras
*/
function actPrecios_comprobarFichero(cabeceras:String)
{
	var util:FLUtil = new FLUtil();

	// Eliminar el retorno de carro
	cabeceras = cabeceras.left(cabeceras.length - 1);

	var campos = cabeceras.split(this.iface.sep);
	var campo:String;
	var ref:Boolean = false;
	var pvp:Boolean = false;

	for (var i:Number = 0; i < campos.length; i++) {
		campo = campos[i];
		if (campo == "REF")
			ref = true;
		if (campo == "PVP")
			pvp = true;
	}

	if (!ref || !pvp) {
		MessageBox.critical( util.translate( "scripts", "El fichero no es válido.\nLa primera línea debe contener los campos REF (referencia) y PVP (precio)"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return false;
	}

	return true;
}


//// ACT_PRECIOS /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////

