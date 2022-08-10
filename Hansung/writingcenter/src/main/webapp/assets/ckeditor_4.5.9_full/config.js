/**
 * @license Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	config.toolbar = [
	              	['Cut','Copy','Paste','PasteText','PasteFromWord'],
	              	['Image','Table','HorizontalRule'],
	              	['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
	              	['Link', 'Unlink'],
	              	['Source'],
	              	'/',
	              	['Bold','Italic','Underline','Strike'],
	              	['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
	              	['Styles','Format','Font','FontSize'],['TextColor'],['About']];
	
};
CKEDITOR.on( 'dialogDefinition', function( ev )
		{
			// Take the dialog name and its definition from the event data.
			var dialogName = ev.data.name;
			var dialogDefinition = ev.data.definition;
	 
			// Check if the definition is from the dialog we're
			// interested on (the Link dialog).
			if ( dialogName == 'link' )
			{
				// FCKConfig.LinkDlgHideAdvanced = true
				//dialogDefinition.removeContents( 'advanced' );
	 
				// FCKConfig.LinkDlgHideTarget = true
				//dialogDefinition.removeContents( 'target' );
	/*
	Enable this part only if you don't remove the 'target' tab in the previous block.
	*/
				// FCKConfig.DefaultLinkTarget = '_blank'
				// Get a reference to the "Target" tab.
				var targetTab = dialogDefinition.getContents( 'target' );
				// Set the default value for the URL field.
				var targetField = targetTab.get( 'linkTargetType' );
				targetField[ 'default' ] = '_blank';
			}
	 
			if ( dialogName == 'image' )
			{
				// FCKConfig.ImageDlgHideAdvanced = true	
				dialogDefinition.removeContents( 'advanced' );
				// FCKConfig.ImageDlgHideLink = true
				dialogDefinition.removeContents( 'Link' );
			}
	 
			if ( dialogName == 'flash' )
			{
				// FCKConfig.FlashDlgHideAdvanced = true
				dialogDefinition.removeContents( 'advanced' );
			}
	 
		});