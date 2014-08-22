/***************************************************************************
                 opcionestv.qs  -  description
                             -------------------
    begin                : lun sep 21 2004
    copyright            : (C) 2004 by InfoSiAL S.L.
    email                : mail@infosial.com
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

/** @file */

////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_declaration interna */
//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna {
    var ctx:Object;
    function interna( context ) { this.ctx = context; }
    function init() { this.ctx.interna_init(); }
    function validateForm() { return this.ctx.interna_validateForm(); }
    function main() { this.ctx.interna_main(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
    function oficial( context ) { interna( context ); } 
	function cambiarDirWeb() { return this.ctx.oficial_cambiarDirWeb() ;}
	function cambiarPassword() {
		this.ctx.oficial_cambiarPassword();
	}
	function traducirTextoPre() {
		return this.ctx.oficial_traducirTextoPre();
	}
	function traducirTextoPie() {
		return this.ctx.oficial_traducirTextoPie();
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration fluxecPro */
/////////////////////////////////////////////////////////////////
//// FLUX EC PRO /////////////////////////////////////////////////
class fluxecPro extends oficial /** %from: oficial */
{
	function fluxecPro( context ) { oficial ( context ); }

    function init() { this.ctx.fluxecPro_init(); }

	function cambiarPassword() {
		this.ctx.fluxecPro_cambiarPassword();
	}
	function traducirTituloSEO() {
		return this.ctx.fluxecPro_traducirTituloSEO();
	}
	function traducirDescripcionSEO() {
		return this.ctx.fluxecPro_traducirDescripcionSEO();
	}
	function traducirKeywordsSEO() {
		return this.ctx.fluxecPro_traducirKeywordsSEO();
	}
}
//// FLUX EC PRO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends fluxecPro {
    function head( context ) { fluxecPro ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
}

const iface = new ifaceCtx( this );
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_definition interna */
//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////

function init() {
    this.iface.init();
}

function main() {
    this.iface.main();
}

function interna_init() 
{
	connect( this.child( "pbnCambiarDirWeb" ), "clicked()", this, "iface.cambiarDirWeb" );
	connect( this.child( "pbnCambiarPassword" ), "clicked()", this, "iface.cambiarPassword" );


	this.child("fdbRutaWeb").setDisabled(true);

	this.child("fdbTextoPre").setTextFormat(0);
	this.child("fdbTextoPie").setTextFormat(0);

	connect(this.child("pbnTradTextoPre"), "clicked()", this, "iface.traducirTextoPre");
	connect(this.child("pbnTradTextoPie"), "clicked()", this, "iface.traducirTextoPie");
}

function interna_validateForm() 
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();

	if (cursor.valueBuffer("enviogratis")) {
		if (!cursor.valueBuffer("codenviogratis") || !cursor.valueBuffer("enviogratisdesde")) {
			MessageBox.information( util.translate( "scripts", "Debes rellenar todos los datos de envío gratuito" ),
									MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
			return false;
		}
	}
	
	return true;
}

function interna_main()
{
	var f = new FLFormSearchDB("opcionestv");
	var cursor:FLSqlCursor = f.cursor();

	cursor.select();
	if (!cursor.first())
			cursor.setModeAccess(cursor.Insert);
	else
			cursor.setModeAccess(cursor.Edit);

	f.setMainWidget();
	cursor.refreshBuffer();
	var commitOk:Boolean = false;
	var acpt:Boolean;
	cursor.transaction(false);
	while (!commitOk) {
		acpt = false;
		f.exec("rutaweb");
		acpt = f.accepted();
		if (!acpt) {
			if (cursor.rollback())
					commitOk = true;
		} else {
			if (cursor.commitBuffer()) {
					cursor.commit();
					commitOk = true;
			}
		}
		f.close();
	}
}


//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_cambiarDirWeb()
{
	var util:FLUtil = new FLUtil();
	var ruta:String = FileDialog.getExistingDirectory( util.translate( "scripts", "" ), util.translate( "scripts", "RUTA A LOS MODULOS" ) );
	
	if ( !File.isDir( ruta ) ) {
		MessageBox.information( util.translate( "scripts", "Ruta errónea" ),
								MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return;
	}
	this.child("fdbRutaWeb").setValue(ruta);
}

function oficial_traducirTextoPre()
{
	return flfactppal.iface.pub_traducir("opcionestv", "textopre", this.cursor().valueBuffer("id"));
}

function oficial_traducirTextoPie()
{
	return flfactppal.iface.pub_traducir("opcionestv", "textopie", this.cursor().valueBuffer("id"));
}

function oficial_cambiarPassword()
{
	var util:FLUtil = new FLUtil;

	var res = MessageBox.information(util.translate("scripts", "Esta acción no podrá deshacerse. ¿Está seguro?"), MessageBox.Yes, MessageBox.No);
	if (res != MessageBox.Yes)
		return;

	var password:String = Input.getText( "Nuevo password:" );

	if (!password)
		return;

	if (password.length < 6) {
		MessageBox.critical(util.translate("scripts", "El password debe tener al menos 6 dígitos"), MessageBox.Ok);
		return;
	}

	password = util.sha1(password);
	this.cursor().setValueBuffer("managerpass", password.toLowerCase());
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/** @class_definition fluxecPro */
//////////////////////////////////////////////////////////////////
//// FLUX EC PRO //////////////////////////////////////////////////

function fluxecPro_init()
{
	this.iface.__init();
	connect(this.child("pbnCambiarPassword"), "clicked()", this, "iface.cambiarPassword");
	connect(this.child("pbnTradTituloSEO"), "clicked()", this, "iface.traducirTituloSEO");
	connect(this.child("pbnTradDescripcionSEO"), "clicked()", this, "iface.traducirDescripcionSEO");
	connect( this.child( "pbnTradKeywordsSEO" ), "clicked()", this, "iface.pbnTradKeywordsSEO" );

}

function fluxecPro_traducirTituloSEO()
{
	return flfactppal.iface.pub_traducir("opcionestv", "tituloseo", this.cursor().valueBuffer("id"));
}

function fluxecPro_traducirDescripcionSEO()
{
	return flfactppal.iface.pub_traducir("opcionestv", "descripcionseo", this.cursor().valueBuffer("id"));
}

function fluxecPro_traducirKeywordsSEO()
{
	return flfactppal.iface.pub_traducir("opcionestv", "keywordsseo", this.cursor().valueBuffer("id"));
}

function fluxecPro_cambiarPassword()
{
	var util:FLUtil = new FLUtil;

	var res = MessageBox.information(util.translate("scripts", "Esta acción no podrá deshacerse. ¿Está seguro?"), MessageBox.Yes, MessageBox.No);
	if (res != MessageBox.Yes)
		return;

	var password:String = Input.getText( "Nuevo password:" );

	if (!password)
		return;

	if (password.length < 6) {
		MessageBox.critical(util.translate("scripts", "El password debe tener al menos 6 dígitos"), MessageBox.Ok);
		return;
	}

	password = util.sha1(password);
	this.cursor().setValueBuffer("managerpass", password.toLowerCase());
}

//// FLUX EC PRO //////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////

//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
