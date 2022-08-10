kimsoft.util.editor = {
	editors : [],
	initEditor : function(id, textEl, isLink){
		var editor = new NamoSE(id);
		editor.params.Width = "100%";
		editor.params.UserLang = "auto";
		editor.params.FullScreen = false;
		editor.params.ReturnKeyActionBR = true;
		editor.EditorStart();

		var editorInfo = {
				id : id,
				textEl : textEl,
				editor : editor,
				isLink : isLink
		};
		this.editors[id] = editorInfo;
	},
	updateEditor : function() {
		for(var key in this.editors) {
			$("#" + this.editors[key].id).val(this.editors[key].editor.GetBodyValue("XHTML"));
//			$("#" + this.editors[key].textEl).val(this.editors[key].editor.GetTextValue());
		}
	},
	updateEditorTextEl : function(id) {
		$("#" + this.editors[id].textEl).val(this.editors[id].editor.GetTextValue());
	},
	setEditorLinkTextEl : function (id, isLink) {
		this.editors[id].isLink = isLink;
	},
	isBlank4se : function(val) {
		if (val == "" || val == "<p>&nbsp;</p>") {
			return true;
		} else {
			return false;
		}
	}
};
