/**
 * @license Copyright (c) 2003-2012, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here.
	// For the complete reference:
	// http://docs.ckeditor.com/#!/api/CKEDITOR.config

	config.toolbar =[
	                 ['Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo'],
	                 ['Find','Replace','SelectAll'],['Image','Table','SpecialChar','HorizontalRule'],
	                 ['Bold','Italic','Underline','-','RemoveFormat'],
	                 ['NumberedList','BulletedList','Outdent','Indent'],
	                 ['TextColor','BGColor','Maximize', 'ShowBlocks'],
	                 '/',
	                 ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
	                 ['Styles','Format','Font','FontSize']
	          ];
};
