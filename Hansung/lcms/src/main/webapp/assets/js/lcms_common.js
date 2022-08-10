$(document).ready(function(){
	// message 값이 존재하는 경우 alert을 띄웁니다.
    if( $("#message").length==1 && $("#message").val()!='' ){
        alert( $("#message").val() );
        $("#message").val('');
    }
});


// 파일 초기화
function initInputFile(obj) {
	
	var agent = navigator.userAgent.toLowerCase();
	
	if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
		// ie 일때 input[type=file] init. 
		 obj.select();
         document.selection.clear();
	//	$(obj).replaceWith( $(obj).clone(true) );
	}else { 
		// other browser 일때 input[type=file] init. 
		$(obj).val(""); 
	}
	
}

//지정된 파일 & 용량 확인(관리자)
function fileCheck_adm(id) {

	var file = $("#"+id).val();
	var fileSize = document.getElementById(id).files[0].size;
	
	//파일확장자 검사
	var fileExt = file.substring(file.lastIndexOf('.') + 1).toUpperCase();
	if (id == "titleImg") {
		if (fileExt != "BMP" && fileExt != "JPG" && fileExt != "GIF" && fileExt != "PNG") {
			alert("가능한 파일이 아닙니다.");
			$("#"+id).replaceWith( $("#"+id).clone(true) );
			return false;
		}			
	}else if (id == "attachedFile_PDF"){
		if(fileExt != "PDF"){
			alert("가능한 파일이 아닙니다.");
			$("#"+id).replaceWith( $("#"+id).clone(true) );
			return false;
		}
	}else if (fileExt != "HWP" && fileExt != "DOC" && fileExt != "DOCX" && fileExt != "TXT"
		&& fileExt != "PPT" && fileExt != "XLS" && fileExt != "PDF"
			&& fileExt != "BMP" && fileExt != "JPG" && fileExt != "GIF" 
				&& fileExt != "PNG"  && fileExt != "XLSX" && fileExt != "AI") {
		
		alert("가능한 파일이 아닙니다.");
		$("#"+id).replaceWith( $("#"+id).clone(true) );
		return false;
	}
	
	//하위브라우저에서는 확인이 안됨.
	if(fileSize== -1){
		console.log("구 버전의 브라우저에서는 파일사이즈 검사가 정상적으로 동작하지 않습니다.");
		return false;
	}
	
	//파일사이즈 검사
	var maxSize = 5*1024*1024; //5메가
	if (fileSize > maxSize) {
		alert("첨부된 파일의 용량이 초과하였습니다.");
		$("#"+id).replaceWith( $("#"+id).clone(true) );
		return false;
	}
	return true;
}

function fn_search_seme(ele){
	
	$.ajax({
		url: '/usr/cmm/ajaxSearchSeme.do'
		, type: "post"
		, data: "year="+$(ele).val()
		, dataType:"json"
		, success: function(data){
			resultList = data.semeList;
			var html = "";
			
			for(var i=0; i<resultList.length; i++){
				html += '<option value="'+resultList[i].semester+'">'+resultList[i].semeNm+'</option>';
			}
			
			$("#semEster").html(html);
		}, error: function(){
			alert("오류가 발생하였습니다.");
		}
	});
}

function fn_number(ele){
	var x = $(ele).val().replace(/[^0-9]/g,'');   // 입력값이 숫자가 아니면 공백
	x = x.replace(/,/g,'');          // ,값 공백처리
	$(ele).val(x.replace(/\B(?=(\d{3})+(?!\d))/g, ",")); // 정규식을 이용해서 3자리 마다 , 추가 
}

function fn_validate(formName) {
	var oForm = eval("document." + formName);
	
	try{
	var oElement = null;

	var required   = null;
	var isNumber   = null;
	var isExcel    = null;
	var isImage    = null;
	var fileCheck  = null;
	var fileCheck2 = null;
	var dateCheck  = null;
	var rangeSize  = null;
	var isEmail    = null;

	var objStr = null;
	for (var i=0; i<oForm.elements.length; i++) {
		oElement   = oForm.elements[i];

		if((oElement.id == null || oElement.id == "") && (oElement.name == null || oElement.name == "") || oElement.hasAttribute("disabled")) {
			continue;
		}
		objStr = oElement.id == null || oElement.id == "" ? oElement.name : oElement.id;
		required   = $("#" + objStr).hasClass("required");		//필수 체크
		isNumber   = $("#" + objStr).hasClass("isNumber");		//숫자 체크 (값이 없으면 무시)
		isBizNo    = $("#" + objStr).hasClass("isBizNo");		//사업자번호 체크 (값이 없으면 무시)
		isExcel    = $("#" + objStr).hasClass("isExcel");		//첨부파일 체크 (엑셀 파일인지)
		isImage    = $("#" + objStr).hasClass("isImage");		//첨부파일 체크 (이미지 파일인지)
		fileCheck  = $("#" + objStr).hasClass("fileCheck");		//첨부파일 체크 (올릴수 없는 파일)
		fileCheck2 = $("#" + objStr).hasClass("fileCheck2");	//첨부파일 체크 (올릴수 있는 파일)
		dateCheck  = $("#" + objStr).hasClass("dateCheck");		//날짜 형식 체크
		isEmail    = $("#" + objStr).hasClass("isEmail");		//이메일 체크
		rangeSize  = oElement.getAttribute("rangeSize");		//글자 길이 범위 체크
		//alert("oElement.name="+oElement.name+", oElement.type="+oElement.type);
		switch (oElement.type) {
			case "text" :
			case "password" :
			case "textarea" :
				if(required) {
					if(trim(oElement.value) == "") {
						alert(oElement.title + "을(를) 입력해 주세요.");
						oElement.focus();
						return false;
					}
				}
				if(isNumber) {
					if(trim(oElement.value) != "") {
						if(!fnIsNumber(trim(oElement.value))) {
							alert(oElement.title + "은(는) 숫자로만 입력해 주세요.");
							oElement.focus();
							return false;
						}
					}
				}
				if(isEmail) {
					if(trim(oElement.value) != "") {
						if(!fnIsEmail(trim(oElement.value))) {
							oElement.focus();
							return false;
						}
					}
				}
				break;
			case "select-one" :
				if(required) {
					if(trim(oElement.value) == "") {
						alert(oElement.title + "을(를) 선택해 주세요.");
						oElement.focus();
						return false;
					}
				}
				break;
			case "radio" :
				if(required) {
					var radioValue = $(':radio[name="' + oElement.name + '"]:checked').val();
					if(trim(radioValue) == "") {
						alert(oElement.title + "을(를) 선택해 주세요.");
						oElement.focus();
						return false;
					}
				}
				break;
			case "checkbox" :
				break;
			case "file" :
				if(required) {
					if(trim(oElement.value) == "") {
						alert(oElement.title + "[첨부파일]을 선택해 주세요.");
						oElement.focus();
						return false;
					}
				}
				//엑셀만 가능할경우
				if(isExcel) {
					if(trim(oElement.value) != "") {
						if(oElement.value.toLowerCase().match(/\.(xls|xlsx)$/i) == null) {
							alert(oElement.title + "엑셀파일은 [xls], [xlsx]로 올려주시기 바랍니다.");
							return false;
						}
					}
				}
				//이미지만 가능할경우
				if(isImage) {
					if(trim(oElement.value) != "") {
						if(oElement.value.toLowerCase().match(/\.(gif|jpg|jpeg|png)$/i) == null) {
							alert(oElement.title + "파일은 [gif], [jpg], [jpeg], [png]로 올려주시기 바랍니다.");
							return false;
						}
					}
				}
				//올릴수 없는 파일
				if(fileCheck) {
					if(trim(oElement.value) != "") {
						if(oElement.value.toLowerCase().match(/\.(jsp|bat|exe|asp|php|js|html|htm|css|mdb|aspx|xml)$/i) != null) {
							alert("[" + oElement.title + "] 올릴수 없는 파일입니다.");
							oElement.focus();
							return false;
						}
					}
				}
				//올릴수 있는 파일
				if(fileCheck2) {
					if(trim(oElement.value) != "") {
						//TODO:
					}
				}
				break;
		}

		var result = true;
		//사업자번호 체크
		if(isBizNo) {
			var bizNostr = new String(oElement.value);
			if(bizNostr != '') {
				if(!yfn_bizNumChk(bizNostr)){
					alert(oElement.title + "의 입력값은 잘못된 사업자등록번호형식입니다.");
					oElement.focus();
					return false;
				}
			}
		}

		//날짜 형식 체크
		if(dateCheck) {
			var dateStr = new String(oElement.value);
			if(dateStr != '') {
				if(dateStr.length != 8) {
					result = false;
				} else if(dateStr.indexOf('.') != -1 || dateStr.indexOf('/') != -1 || dateStr.indexOf('-') != -1) {
					result = false;
				} else {
					var yearStr  = new Number(dateStr.substring(0, 4));
					var monthStr = new Number(dateStr.substring(4, 6));
					var dayStr   = new Number(dateStr.substring(6, 8));
					if(monthStr > 12 || monthStr < 1)
						result = false;
					else if(dayStr > 31 || dayStr < 1)
						result = false;
				}
				if(result == false) {
					alert(oElement.title + "의 입력값은 잘못된 날짜형식입니다.");
					oElement.focus();
					return false;
				}
			}
		}
		//글자길이 범위 체크
		if(typeof(rangeSize) != "undefined" && rangeSize != null) {

			var deliPos = rangeSize.indexOf("~");
			var sLimit = 0;
			var eLimit = 0;

			var valuesLength = fnStringByteLength(oElement.value);

			if(valuesLength != 0) {
				//ex) rangeSize="100"
				if(deliPos == -1) {
					sLimit = new Number(trim(rangeSize));
					if(valuesLength != sLimit) {
						alert(oElement.title + "의 글자수는 " + sLimit + "자(Byte) 여야 합니다.");
						oElement.focus();
						return false;
					}
				//ex) rangeSize="100~"
				} else if(deliPos == rangeSize.length-1) {
					sLimit = new Number(trim(rangeSize.substring(0, deliPos)));
					if(valuesLength < sLimit) {
						alert(oElement.title + "의 글자수는 " + sLimit + "자(Byte)를 넘어야 합니다.");
						oElement.focus();
						return false;
					}
				//ex) rangeSize="~100"
				} else if(deliPos == 0) {
					eLimit = new Number(trim(rangeSize.substring(deliPos+1)));
					if(valuesLength > eLimit) {
						alert(oElement.title + "의 글자수는 " + eLimit + "자(Byte)를 넘을 수 없습니다.");
						oElement.focus();
						return false;
					}
				//ex) rangeSize="100~200"
				} else {
					sLimit = new Number(trim(rangeSize.substring(0, deliPos)));
					eLimit = new Number(trim(rangeSize.substring(deliPos+1)));
					if(valuesLength < sLimit || valuesLength > eLimit) {
						alert(oElement.title + "의 글자수는 " + sLimit + "자(Byte) 이상이고 " + eLimit + "자(Byte) 이하여야 합니다.");
						oElement.focus();
						return false;
					}
				}
			}
		}
	} //for end
	} catch(e) {
		alert(e);
		return false;
	}
	return true;
}


function fn_dateMinus(){
	var date = new Date(); 
	var year = date.getFullYear(); 
	var month = new String(date.getMonth()+1); 
	var day = new String(date.getDate()); 

	// 한자리수일 경우 0을 채워준다. 
	if(month.length == 1){ 
	  month = "0" + month; 
	} 
	if(day.length == 1){ 
	  day = "0" + day; 
	} 

	return year + "-" + month + "-" + day;
}