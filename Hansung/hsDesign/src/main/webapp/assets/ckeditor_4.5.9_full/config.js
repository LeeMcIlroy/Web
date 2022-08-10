/**
 * @license Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
/*
	config.extraPlugins = 'youtube,videodetector,dialogui,dialog,about,a11yhelp,toolbar,notification,clipboard,,image,lineutils,widgetselection,widget,notificationaggregator,embedbase,autoembed,autolink,embedsemantic,embed';
	config.youtube_width = '640';
	config.youtube_height = '480';
	config.youtube_responsive = true;
	config.youtube_related = true;
	config.youtube_older = false;
	config.youtube_privacy = false;
	config.youtube_autoplay = false;
	config.youtube_controls = true;
	
	config.toolbar = [
		              	['Cut','Copy','Paste','PasteText','PasteFromWord'],
		              	['Image','Table','HorizontalRule'],
		              	['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
		              	['VideoDetector'],
		              	['Source'],
		              	'/',
		              	['Bold','Italic','Underline','Strike'],	
		              	['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
		              	['Styles','Format','Font','FontSize'],['TextColor'],['About'],
		             ];
*/
	/*config.filebrowserImageUploadUrl = '/include/editor/upload/upload.asp';*/
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	config.extraPlugins = 'videoembed';
	//config.extraPlugins = 'oembed';
	config.extraAllowedContent = 'iframe[*]';
	
	config.toolbar = [
	              	['Cut','Copy','Paste','PasteText','PasteFromWord'],
	              	['Image','Table','HorizontalRule'],
	              	['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
	              	['Source'],
	              	'/',
	              	['Bold','Italic','Underline','Strike'],
	              	['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
	              	//['Styles','Format','Font','FontSize'],['TextColor'],['About'],['VideoEmbed'],['oembed']];
					['Styles','Format','Font','FontSize'],['TextColor'],['About'],['VideoEmbed']];
	
};
