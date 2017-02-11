/**
 * @license Copyright (c) 2003-2016, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */


CKEDITOR.editorConfig = function( config ) {
	config.toolbar_Admin =
	[
		{ name: 'document', items : [ 'Source','-','Save','NewPage','DocProps','Preview','Print','-','Templates' ] },
		{ name: 'clipboard', items : [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
		{ name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','SpellChecker', 'Scayt' ] },
		{ name: 'forms', items : [ 'Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton','HiddenField' ] },
		'/',
		{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
		{ name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','BidiLtr','BidiRtl' ] },
		{ name: 'links', items : [ 'Link','Unlink','Anchor' ] },
		{ name: 'insert', items : [ 'Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak','Iframe' ] },
		'/',
		{ name: 'styles', items : [ 'Styles','Format','Font','FontSize' ] },
		{ name: 'colors', items : [ 'TextColor','BGColor' ] },
		{ name: 'tools', items : [ 'Maximize', 'ShowBlocks','-','About' ] }
	];
 
	config.toolbar_User =
	[
		{ name: 'document', items : [ 'NewPage' ] },
		//{ name: 'document', items : [ 'Save' ] },
		{ name: 'editing', items : [ 'Undo','Redo' ] },
		{ name: 'clipboard', items : [ 'PasteText' ] },
		{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','Blockquote','-','RemoveFormat' ] },
		{ name: 'styles', items : [ 'FontSize' ] },
		{ name: 'colors', items : [ 'TextColor' ] },
		{ name: 'pictures', items : [ 'Image' ] },
		{ name: 'html', items : [ 'HorizontalRule' ] },
		{ name: 'paragraph', items : [ 'BulletedList','-','Outdent','Indent','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ] },
		{ name: 'links', items : [ 'Link','Unlink' ] },
		{ name: 'tools', items : [ 'Source' ] },
		{ name: 'tools', items : [ 'Smiley' ] },
		{ name: 'tools', items : [ 'About' ] }
	];
	
	config.toolbar_Product =
	[
		{ name: 'document', items : [ 'NewPage' ] },
		//{ name: 'document', items : [ 'Save' ] },
		{ name: 'editing', items : [ 'Undo','Redo' ] },
		{ name: 'clipboard', items : [ 'PasteText' ] },
		{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','Blockquote','-','RemoveFormat' ] },
		{ name: 'styles', items : [ 'FontSize' ] },
		{ name: 'colors', items : [ 'TextColor' ] },
		{ name: 'html', items : [ 'HorizontalRule' ] },
		{ name: 'paragraph', items : [ 'BulletedList','-','Outdent','Indent','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ] },
		{ name: 'links', items : [ 'Link','Unlink' ] },
		{ name: 'tools', items : [ 'Source' ] },
		{ name: 'tools', items : [ 'Smiley' ] },
		{ name: 'tools', items : [ 'About' ] }
	];
	
	config.toolbar_Newsletter =
	[
		{ name: 'document', items : [ 'NewPage' ] },
		{ name: 'editing', items : [ 'Undo','Redo' ] },
		{ name: 'clipboard', items : [ 'PasteText' ] },
		{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','Blockquote','-','RemoveFormat' ] },
		{ name: 'styles', items : [ 'FontSize' ] },
		{ name: 'colors', items : [ 'TextColor' ] },
		{ name: 'pictures', items : [ 'Image' ] },
		{ name: 'html', items : [ 'HorizontalRule' ] },
		{ name: 'paragraph', items : [ 'BulletedList','-','Outdent','Indent','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ] },
		{ name: 'links', items : [ 'Link','Unlink' ]},
		{ name: 'tools', items : [ 'Source' ] },
		{ name: 'tools', items : [ 'Smiley' ] },
		{ name: 'tools', items : [ 'About' ] }
	];
	
	config.toolbar_Banner =
	[
		{ name: 'document', items : [ 'NewPage' ] },
		{ name: 'editing', items : [ 'Undo','Redo' ] },
		{ name: 'clipboard', items : [ 'PasteText' ] },
		{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','Blockquote','-','RemoveFormat' ] },
		{ name: 'styles', items : [ 'FontSize' ] },
		{ name: 'colors', items : [ 'TextColor' ] },
		{ name: 'html', items : [ 'HorizontalRule' ] },
		{ name: 'paragraph', items : [ 'BulletedList','-','Outdent','Indent','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ] },
		{ name: 'links', items : [ 'Link','Unlink' ]},
		{ name: 'tools', items : [ 'Source' ] },
		{ name: 'tools', items : [ 'Smiley' ] },
		{ name: 'tools', items : [ 'About' ] }
	];
	
	config.toolbar_Email =
	[
		{ name: 'document', items : [ 'NewPage' ] },
		{ name: 'editing', items : [ 'Undo','Redo' ] },
		{ name: 'clipboard', items : [ 'PasteText' ] },
		{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','Blockquote','-','RemoveFormat' ] },
		{ name: 'styles', items : [ 'FontSize' ] },
		{ name: 'colors', items : [ 'TextColor' ] },
		{ name: 'pictures', items : [ 'Image' ] },
		{ name: 'html', items : [ 'HorizontalRule' ] },
		{ name: 'paragraph', items : [ 'BulletedList','-','Outdent','Indent','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ] },
		{ name: 'links', items : [ 'Link','Unlink' ] },
		{ name: 'tools', items : [ 'Source' ] },
		{ name: 'tools', items : [ 'Smiley' ] },
		{ name: 'tools', items : [ 'About' ] }
	];
	
	config.toolbar_Content =
	[
		{ name: 'document', items : [ 'NewPage' ] },
		{ name: 'editing', items : [ 'Undo','Redo' ] },
		{ name: 'clipboard', items : [ 'PasteText' ] },
		{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','Blockquote','-','RemoveFormat' ] },
		{ name: 'styles', items : [ 'FontSize' ] },
		{ name: 'colors', items : [ 'TextColor' ] },
		{ name: 'pictures', items : [ 'Image' ] },
		{ name: 'html', items : [ 'HorizontalRule' ] },
		{ name: 'paragraph', items : [ 'BulletedList','-','Outdent','Indent','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ] },
		{ name: 'links', items : [ 'Link','Unlink' ] },
		{ name: 'tools', items : [ 'Source' ] },
		{ name: 'tools', items : [ 'Smiley' ] },
		{ name: 'tools', items : [ 'About' ] }
	];
};