$(function(){
	
	// message 값이 존재하는 경우 alert을 띄웁니다.
    if( $("#message").length==1 && $("#message").val()!='' ){
        alert( $("#message").val() );
        $("#message").val('');
    }
	
	//enter
	$("#searchWord").on("keydown", function(e) {
		if (e.keyCode == 13) {
			fn_list(1);
			return false;
		}
	});
    
});

//지정된 파일 & 용량 확인(관리자)
function fileCheck_adm(id, fileSize) {

	var file = $("#"+id).val();
	
	//파일확장자 검사
	var fileExt = file.substring(file.lastIndexOf('.') + 1).toUpperCase();
	if (id == "titleImg") {
		if (fileExt != "BMP" && fileExt != "JPG" && fileExt != "GIF" && fileExt != "PNG") {
			alert("가능한 파일이 아닙니다.");
			$("#"+id).replaceWith( $("#"+id).clone(true) );
			return;
		}			
	}else if (id == "attachedFile_PDF"){
		if(fileExt != "PDF"){
			alert("가능한 파일이 아닙니다.");
			$("#"+id).replaceWith( $("#"+id).clone(true) );
			return;
		}
	}else if (fileExt != "HWP" && fileExt != "DOC" && fileExt != "TXT"
		&& fileExt != "PPT" && fileExt != "XLS" && fileExt != "PDF"
			&& fileExt != "BMP" && fileExt != "JPG" && fileExt != "GIF" 
				&& fileExt != "PNG") {
		
		alert("가능한 파일이 아닙니다.");
		$("#"+id).replaceWith( $("#"+id).clone(true) );
		return;
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
		return;
	}
}

//지정된 파일 & 용량 확인(사용자)
function fileCheck(id, fileSize) {

	var file = $("#"+id).val();
	
	//하위브라우저에서는 확인이 안됨.
	if(fileSize== -1){
		alert("오류가 발생하였습니다. 구 버전의 브라우저에서는 동작하지 않을 수 있습니다.");
		$("#"+id).replaceWith( $("#"+id).clone(true) );
		return false;
	}
	
	//파일확장자 검사
	var fileExt = file.substring(file.lastIndexOf('.') + 1).toUpperCase();
	if (id == "uploadImage") {
		if (fileExt != "BMP" && fileExt != "JPG" && fileExt != "GIF" && fileExt != "PNG") {
			alert("가능한 파일이 아닙니다.");
			$("#"+id).replaceWith( $("#"+id).clone(true) );
			return;
		}			
	}else if (fileExt != "HWP" && fileExt != "DOC" && fileExt != "TXT"
		 && fileExt != "PPT" && fileExt != "XLS" && fileExt != "PDF"
		 && fileExt != "BMP" && fileExt != "JPG" && fileExt != "GIF" 
		 && fileExt != "PNG") {
		
		alert("가능한 파일이 아닙니다.");
		$("#"+id).replaceWith( $("#"+id).clone(true) );
		return;
	}
	
	//파일사이즈 검사
	var maxSize = 5*1024*1024; //5메가
	if (fileSize > maxSize) {
		alert("첨부된 파일의 용량이 초과하였습니다.");
		$("#"+id).replaceWith( $("#"+id).clone(true) );
		return;
	}
}

//html 태그 제거
function fn_removeTag(str) {
	return str.replace(/(<([^>]+)>)/gi, "");
}

//뒤로가기
function fn_hisback(){
	history.back();
}

//숫자 & 백스페이스만 입력가능
function showKeyCode(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) ||  keyID == 8 || keyID == 9)
	{
		return;
	}
	else
	{
		
		return false;
	}
}