/**
 * @license Copyright (c) 2003-2017, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	
	// %REMOVE_START%
	// The configuration options below are needed when running CKEditor from source files.
	config.plugins = 'dialogui,dialog,about,a11yhelp,basicstyles,blockquote,button,panelbutton,colorbutton,toolbar,notification,clipboard,colordialog,panel,floatpanel,menu,contextmenu,resize,elementspath,enterkey,entities,popup,filebrowser,floatingspace,listblock,richcombo,format,horizontalrule,htmlwriter,wysiwygarea,image,indent,indentlist,fakeobjects,link,list,magicline,maximize,pastetext,pastefromword,removeformat,showborders,sourcearea,specialchar,menubutton,scayt,stylescombo,tab,table,tabletools,tableselection,tableresize,undo,wsc,lineutils,widgetselection,widget,notificationaggregator,embedbase,autolink,autoembed,videoembed,justify,font';
	config.skin = 'moono-lisa';
	// %REMOVE_END%

	// Define changes to default configuration here.
	// For complete reference see:
	// http://docs.ckeditor.com/#!/api/CKEDITOR.config

	// The toolbar groups arrangement, optimized for two toolbar rows.
	
	
/*	
 * 	config.toolbarGroups = [
		{ name: 'clipboard',   groups: [ 'clipboard', 'undo' ] },
		{ name: 'editing',     groups: [ 'find', 'selection', 'spellchecker' ] },
		{ name: 'links' },
		{ name: 'insert' },
		{ name: 'forms' },
		{ name: 'tools' },
		{ name: 'document',	   groups: [ 'mode', 'document', 'doctools' ]},
		{ name: 'others' },
		'/',
		{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
		
		{ name: 'paragraph',   groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ] },
		{ name: 'styles' },
		{ name: 'colors' },
		{ name: 'about' }
	];
*/
	
	config.extraAllowedContent = 'iframe[*]';
	//config.enterMode = '2';
	config.toolbar = [
		              	['Cut','Copy','Paste','PasteText','PasteFromWord'],
		              	['Image','Table','HorizontalRule'],
		              	['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
		              	['Source'],
		              	'/',
		              	['Bold','Italic','Underline','Strike'],
		              	['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
		              	//['Styles','Format','Font','FontSize'],['TextColor'],['About'],['VideoEmbed'],['oembed']];
						['Styles','Format','FontSize'],['TextColor','BGColor'],['About'],['VideoEmbed']];
	// Remove some buttons provided by the standard plugins, which are
	// not needed in the Standard(s) toolbar.
	config.removeButtons = 'Underline,Subscript,Superscript';

	// Set the most common block elements.
	config.format_tags = 'p;h1;h2;h3;pre';

	// Simplify the dialog windows.
	config.removeDialogTabs = 'image:advanced;link:advanced';
	config.allowedContent = true;
	CKEDITOR.dtd.$removeEmpty.a = 0;

	config.fontSize_defaultLabel = '12px';
	config.fontSize_sizes='8/8px;9/9px;10/10px;11/11px;12/12px;14/14px;16/16px;18/18px;20/20px;22/22px;24/24px;26/26px;28/28px;36/36px;48/48px;';

	
	//config.enterMode = CKEDITOR.ENTER_BR;


};
