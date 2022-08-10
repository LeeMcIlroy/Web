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
	// 이미지 리사이징
	if ( $(".boardViewStyle").length > 0 ) {
/*
		$(".boardViewStyle img").each(function(){
			$(this).load(function(){
				if( !$(this).attr("style") ) return;
				
				$(this).css({
					'max-width': $(this).width()+'px'
					,'max-height': $(this).height()+'px'
					, 'width' : '100%'
					, 'height' : '100%' 
				});
			});
		});
*/
	}else if( $(".tbl_cont").length > 0) {
/*
		$(".tbl_cont img").each(function(){
			$(this).load(function(){
				if( !$(this).attr("style") ) return;
				
				$(this).css({
					'max-width': $(this).width()+'px'
					, 'max-height': $(this).height()+'px'
					, 'width' : '100%'
					, 'height' : '100%' 
				});
			});
		});
*/
	}
    
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
				&& fileExt != "PNG"  && fileExt != "XLSX" && fileExt != "AI"
//					200410 수정
					&& fileExt != "MP4"  && fileExt != "AVI"
	) {
		
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
	var maxSize = 10*1024*1024; //5메가
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
	var maxSize = 10*1024*1024; //10메가
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

//원서접수 화면 - 메인

function fn_appliForm_choose(){
	
	/*
	$(".m_notice").vTicker('pause',true);
	slider.stopAuto();
	
	btmSlider.stopAuto();
	 */
	
	
//	$("body").css({'-webkit-overflow-scrolling': 'hidden'});
	$('body').css({'overflow': 'hidden'});
	$('.content').css({'position': 'fixed'});
	
	
	
	var tags = "";

	tags += '<div class="pop_pw" style="display:block;">';
	tags += '	<div class="ch_btn_box">';
	tags += '		<a href="#" onclick="fn_appliForm_open(01); return false;">신·편입생 온라인 원서접수</a>';
	tags += '		<a href="#" onclick="fn_appliForm_open(01); return false;">일학습엘리트과정 원서접수</a>';
	tags += '		<div class="frame_close" >';
	tags += '			<label for="pop_close" onclick="fn_appliForm_close(); return false;">X</label>';
	tags += '		</div>';
	tags += '	</div>';
	tags += '</div>';
	
	$(".content").append(tags);
		
}


function fn_appliForm_open(status){
	
	
	// 롤링 멈춤
	
	$(".content > .pop_pw").remove();
	
	$(".m_notice").vTicker('pause',true);
	//$(".m_notice02").vTicker('pause',true);
	slider.stopAuto();
	btmSlider.stopAuto();
	//aviSlider.stopAuto();
	
	//$("body").bind('touchmove', function(e){e.preventDefault()}); //스크롤방지

	var filter = "win16|win32|win64|mac";
	
	
	//alert(navigator.userAgent);
	if(navigator.platform){
		if(0 > filter.indexOf(navigator.platform.toLowerCase())){
				
			
			$(".content > *").css("display","none");
			
		}
	}

	
	var url = '';
	if(status == '01'){
		url = 'https://edulms.hansung.ac.kr/application/application_check1.php';
		/*
		if(navigator.userAgent.match("iPhone") != null){
			window.open('https://edulms.hansung.ac.kr/application/application_check1.php','_blank');
			return false;
		}
		*/
	}else if(status == '02'){
		url = 'https://edulms.hansung.ac.kr/application/application_search.php';
	}else if(status == '03'){
		url = 'https://edulms.hansung.ac.kr/application/application_pass_check.php';
	}
	
	var tags = "";
	if(status == '04'){
		alert('현재는 원서접수기간이 아닙니다.');
		/*
		$(".content > .pop_pw").remove();
		$("input[name='t_menu']").val("0");
		$("input[name='t_menu']").attr("checked",false);
		// 롤링 시작
		$(".m_notice").vTicker('pause',false);
		slider.startAuto();
		btmSlider.startAuto();
		*/
		location.reload();
	}else{
		tags += '<div class="pop_pw" style="display:block;">';
		tags += '	<div class="pop_frame">';
		tags += '		<iframe src="'+url+'" name="iframe_online" title="온라인 원서접수" frameborder="0" ></iframe>';
		tags += '		<div class="frame_close" >';
		tags += '			<label for="pop_close" onclick="fn_appliForm_close(); return false;">X</label>';
		tags += '		</div>';
		tags += '	</div>';
		tags += '</div>';
		
		//$(".content > .pop_pw").remove();
		$(".content").append(tags);
		
		
		
	}
	
	
	
	
	
}

//원서접수 닫기
function fn_appliForm_close(){
	/*
	$("input[name='t_menu']").val("0");
	$("input[name='t_menu']").attr("checked",false);
	$(".content > .pop_pw").remove();
	// 롤링 시작
	$(".m_notice").vTicker('pause',false);
	//slider.startAuto();
	btmSlider.startAuto();
	$('#element').off('scroll touchmove mousewheel');
	//aviSlider.startAuto();
	var filter = "win16|win32|win64|mac";
	if(navigator.platform){
		if(0 > filter.indexOf(navigator.platform.toLowerCase())){
			$("#header").show();
			// popup close 
			$('body').unbind('touchmove');

		}
	}
	$('html, body').css({'overflow': 'visible'});
	*/
	location.reload();
	
	
}

//원서접수 화면 - 서브
function fn_appliForm_choose_sub(){
	
	$("input[name='t_menu']").val("0");

	
	
	var filter = "win16|win32|win64|mac";
	
	//alert(navigator.userAgent);
	if(navigator.platform){
		if(0 > filter.indexOf(navigator.platform.toLowerCase())){
			
			$('body').css({'position': 'fixed'});
		}
	}

	var tags = "";

	tags += '<div class="pop_pw" style="display:block;">';
	tags += '	<div class="ch_btn_box">';
	tags += '		<a href="#" onclick="fn_appliForm_open_sub(01); return false;">신·편입생 온라인 원서접수</a>';
	tags += '		<a href="#" onclick="fn_appliForm_open_sub(01); return false;">일학습엘리트과정 원서접수</a>';
	tags += '		<div class="frame_close" >';
	tags += '			<label for="pop_close" onclick="fn_appliForm_close(); return false;">X</label>';
	tags += '		</div>';
	tags += '	</div>';
	tags += '</div>';
	
	$(".content").append(tags);
		
}

function fn_appliForm_open_sub(status){
	
	$("input[name='t_menu']").val("0");
	
	var url = '';
	if(status == '01'){
		//url = 'https://edulms.hansung.ac.kr/application/application_check1.php';
		window.open('https://edulms.hansung.ac.kr/application/application_check1.php',"_blank", "width=400,height=400");
	}else if(status == '02'){
		url = 'https://edulms.hansung.ac.kr/application/application_search.php';
	}else if(status == '03'){
		url = 'https://edulms.hansung.ac.kr/application/application_pass_check.php';
	}
	
	//$(".content").append(tags);
	
	var tags = "";
	if(status == '04'){
		alert('현재는 원서접수기간이 아닙니다.');
		$("input[name='t_menu']").val("0");
		$("input[name='t_menu']").attr("checked",false);
		$(".content > .pop_pw").remove();
		// 롤링 시작
		
	}else{
		tags += '<div class="pop_pw" style="display:block;">';
		tags += '	<div class="pop_frame">';
		tags += '		<iframe src="'+url+'" name="iframe_online" title="온라인 원서접수" frameborder="0"></iframe>';
		tags += '		<div class="frame_close" >';
		tags += '			<label for="pop_close" onclick="fn_appliForm_close(); return false;">X</label>';
		tags += '		</div>';
		tags += '	</div>';
		tags += '</div>';
		
		$(".content").append(tags);
		
	}
}

//원서접수 닫기 - 서브
function fn_appliForm_close_sub(){
	$("input[name='t_menu']").val("0");
	$("input[name='t_menu']").attr("checked",false);
	$(".content > .pop_pw").remove();
}


function open_chatroom(){
	   var windowWidth = $( window ).width();
	   if(windowWidth < 1100) {
		   $(window).load(function(){
				$(function() {
					$(".all_menu_open > div > ul > li > ul").hide(); //숨어있어
					$(".all_menu_open > div > ul > li").hover(function() {
					$(this).children("ul").fadeIn(); //부드럽게 튀어나와
					}, function() {
					$(this).children("ul").fadeOut(); //부드럽게 들어가
				});
				});
			});	   
		  } else {
		      //창 가로 크기가 500보다 클 경우
		   }
		}

