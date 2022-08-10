kimsoft.util.form = {
	//라디오버튼 값 구하기
	getRadioValue : function(obj) {
		if (obj.length) {
			for (var i=0; i<obj.length; ++i) {
				if (obj[i].checked) {
					return obj[i].value;
				}
			}
		} else {
			if (obj.checked) {
				return obj.value;
			}
		}
		return "";
	},
	// 라디오버튼 초기화하기
	clearRadioValue : function(obj) {
		for (var i=0; i<obj.length; ++i) {
			obj[i].checked = false;;
		}
	},
	// input 배열 합치기
	joinInputArr : function(obj, seperator) {
		var tmpObj = [];
		for (var i=0; i<obj.length; ++i) {
			var el = $(obj[i]);
			if (el.prop("tagName").toLowerCase() == "input") {
				tmpObj[i] = $(obj[i]).val();
			} else if (el.prop("tagName").toLowerCase() == "select") {
				tmpObj[i] = $(":selected", el).val();
			}
		}
		return tmpObj.join(seperator);
	},
	//checkbox 배열 합치기
	joinCheckBoxArr : function(obj, seperator) {
		if (obj) {
			if (obj.length) {
				var tmpObj = [];
				for (var i=0; i<obj.length; ++i) {
					if (obj[i].checked) {
						tmpObj[tmpObj.length] = obj[i].value;
					}
				}
				return tmpObj.join(seperator);
			} else {
				if (obj.checked) {
					return obj.value;
				} else {
					return "";
				}
			}
		} else {
			return "";
		}
	},
	setSelectionRange : function(obj, start, end) {
		if (obj.setSelectionRange) {
			obj.setSelectionRange(start, end);
		} else if (obj.createTextRange) {
			var range = obj.createTextRange();
			range.collapse(true);
			range.moveStart("character", start);
			range.moveEnd("character", end);
			range.select();

//			obj.blur();
		}
	},
	defaultSuccessHandler : function(data){
		try {
			var result = $.parseJSON(data);
			if (result.message && result.message != "") {
				alert(result.message);
			}
			if (result.callback && result.callback != "") {
				window[result.callback](result.data);
			}
			if (result.redirectUrl && result.redirectUrl != "") {
				document.location.href = result.redirectUrl;
			}
			return true;
		} catch(e) {
			return false;
		} finally {
		}
	},
	defaultErrorHandler : function(data){
		try {
			alert("에러가 발생하였습니다.");
		} finally {
		}
	},
	submitPost : function(formId, isUpload) {
		var form = $("#" + formId);
		if (isUpload == true) {
			form.attr("encoding", "multipart/form-data");
		} else if (isUpload == false){
			form.attr("encoding", "");
		}

		form.ajaxSubmit({
			type: 'post',
			debug: true,
			success: kimsoft.util.form.defaultSuccessHandler,
			error: kimsoft.util.form.defaultErrorHandler
		});
	},
	sendPost : function(url, param, cbSuccess, cbError) {
		if (!cbSuccess) { cbSuccess = kimsoft.util.form.defaultSuccessHandler; }
		if (!cbError) { cbError = kimsoft.util.form.defaultErrorHandler; }
		$.ajax({
			type: "post",
			url: url,
			data: param,
			success: cbSuccess,
			error: cbError
		});
	},
	setSubmitFunc : function(el, func) {
		el.keydown(function(e) {
			if (e.keyCode == 13) {
				e.preventDefault();
				$(this).blur();
				func();
			}
		});
	},
	setDefaultString : function(el, str) {
		el.focusin(function(e) {
			if ($(this).val() == str) {
				$(this).val("");
			}
		});
		el.focusout(function(e) {
			if ($(this).val() == "") {
				$(this).val(str);
			}
		});

		el.each(function() {
			if ($(this).val() == "") {
				$(this).val(str);
			}
		});
	},
	copyForm : function(srcForm, targetForm) {
		$("#" + srcForm + " input[type=hidden]").each(function() {
			var name = $(this).attr("name");
			if (!!name && name.substring(0, 4) != "tmp_") {
				$("#" + targetForm + " input[name=" + name + "]").val($("#" + srcForm + " input[name=" + name + "]").val());
			}
		});
		$("#" + srcForm + " input[type=text]").each(function() {
			var name = $(this).attr("name");
			if (!!name && name.substring(0, 4) != "tmp_") {
				$("#" + targetForm + " input[name=" + name + "]").val($("#" + srcForm + " input[name=" + name + "]").val());
			}
		});
		$("#" + srcForm + " textarea").each(function() {
			var name = $(this).attr("name");
			if (!!name && name.substring(0, 4) != "tmp_") {
				$("#" + targetForm + " input[name=" + name + "]").val($("#" + srcForm + " textarea[name=" + name + "]").val());
			}
		});
		$("#" + srcForm + " select").each(function() {
			var name = $(this).attr("name");
			if (!!name && name.substring(0, 4) != "tmp_") {
				$("#" + targetForm + " input[name=" + name + "]").val($("#" + srcForm + " select[name=" + name + "]").val());
			}
		});
		$("#" + srcForm + " input[type=radio]").each(function() {
			var name = $(this).attr("name");
			if (!!name && name.substring(0, 4) != "tmp_") {
				$("#" + targetForm + " input[name=" + name + "]").val($("#" + srcForm + " input[name=" + name + "]:checked").val());
			}
		});
	},
	object2form : function(obj, formId, include, exclude) {
		var includes = "," + (include ? include : "") + ",";
		var excludes = "," + (exclude ? exclude : "") + ",";
		function checkInclude(name) {
			if (excludes.indexOf("," + name + ",") >= 0) {
				return false;
			}
			if (includes == ",,") {
				return true;
			}
			if (includes.indexOf("," + name + ",") >= 0) {
				return true;
			}
			return false;
		}

		$("#" + formId + " input[type=hidden]").each(function() {
			var name = $(this).attr("name");
			if (!!name && name.substring(0, 4) != "tmp_") {
				if (checkInclude(name)) {
					$(this).val(obj[name]);
				}
			}
		});
		$("#" + formId + " input[type=text]").each(function() {
			var name = $(this).attr("name");
			if (!!name && name.substring(0, 4) != "tmp_") {
				if (checkInclude(name)) {
					$(this).val(obj[name]);
				}
			}
		});
		$("#" + formId + " input[type=checkbox]").each(function() {
			var name = $(this).attr("name");
			if (!!name && name.substring(0, 4) != "tmp_") {
				if (checkInclude(name)) {
					if (obj[name] == $(this).val()) {
						$(this).attr("checked", true);
					} else {
						$(this).attr("checked", false);
					}
				}
			}
		});
		$("#" + formId + " textarea").each(function() {
			var name = $(this).attr("name");
			if (!!name && name.substring(0, 4) != "tmp_") {
				if (checkInclude(name)) {
					$(this).val(obj[name]);
				}
			}
		});
		$("#" + formId + " select").each(function() {
			var name = $(this).attr("name");
			if (!!name && name.substring(0, 4) != "tmp_") {
				if (checkInclude(name)) {
					$(this).val(obj[name]);
				}
			}
		});
		$("#" + formId + " input[type=radio]").each(function() {
			var name = $(this).attr("name");
			if (!!name && name.substring(0, 4) != "tmp_") {
				if (checkInclude(name)) {
					if (obj[name] == $(this).val()) {
						$(this).attr("checked", true);
					} else {
						$(this).attr("checked", false);
					}
				}
			}
		});
	},
	form2object : function(formId, obj) {
		if (!obj) {
			obj = {};
		}
		$.each($("#" + formId).serializeArray(), function(idx, arr) {
			obj[arr.name] = arr.value;
		});
		return obj;
	},
	form2objectList : function(formId) {
		var list = [];
		var obj = null;
		$.each($("#" + formId).serializeArray(), function(idx, arr) {
			if (obj == null) {
				obj = {};
			}
			if (obj[arr.name] != undefined) {
				list[list.length] = obj;
				obj = {};
			}
			obj[arr.name] = arr.value;
		});
		if (obj != null) {
			list[list.length] = obj;
		}
		return list;
	},
	inputs2object : function(id, obj) {
		if (!obj) {
			obj = {};
		}
		$.each($("#" + id + " input").serializeArray(), function(idx, arr) {
			obj[arr.name] = arr.value;
		});
		$.each($("#" + id + " select").serializeArray(), function(idx, arr) {
			obj[arr.name] = arr.value;
		});
		return obj;
	},
	autoInputData : function() {
		var index = 0;
		$("input").each(function(){
			if ($(this).attr("type") != "hidden" && $(this).attr("type") != "radio" && $(this).attr("type") != "checkbox") {
				++index;
				$(this).val($(this).val() + index);
			}
		});
	}
};
