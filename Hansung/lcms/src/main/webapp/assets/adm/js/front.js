(function($){$(document).ready(function(){$('#cssmenu li.active').addClass('open').children('ul').show();
	$('#cssmenu li.has-sub>a.sub-menuopen').on('click', function(){
		$(this).removeAttr('href');
		var element = $(this).parent('li');
		if (element.hasClass('open')) {
			element.removeClass('open');
			element.find('li').removeClass('open');
			element.find('ul').slideUp(200);
		}
		else {
			element.addClass('open');
			element.children('ul').slideDown(200);
			element.siblings('li').children('ul').slideUp(200);
			element.siblings('li').removeClass('open');
			element.siblings('li').find('li').removeClass('open');
			element.siblings('li').find('ul').slideUp(200);
		}
	});});})(jQuery);

 $(function() {
	//input을 datepicker로 선언
	$("#datepicker, #datepicker01, #datepicker02, #datepicker03, #datepicker04, #datepicker05, #datepicker06, #datepicker07, #datepicker08, #datepicker09, #datepicker10, #datepicker11, #datepicker12, #datepicker13, #datepicker14, #reregpicker").datepicker({
		dateFormat: 'yy-mm-dd' //Input Display Format 변경
		,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
		,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
		,changeYear: true //콤보박스에서 년 선택 가능
		,changeMonth: true //콤보박스에서 월 선택 가능                		
		,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
		,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
		,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
		,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
		,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
		,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
		,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
		,minDate: "-20Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
		,maxDate: "+10Y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)   
		,yearRange: "c-20:c+20" // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할것인가.
	});                    
	
	//초기값을 오늘 날짜로 설정
//	$('#datepicker, #datepicker01, #datepicker02, #datepicker03, #datepicker04, #datepicker05, #datepicker06, #datepicker07, #datepicker08, #datepicker09, #datepicker10, #datepicker11, #datepicker12, #datepicker13, #datepicker14').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
	$('#reregpicker').datepicker('setDate', 'today');
});


$(document).ready(function(){
    $(".open-write01").click(function(){
        $("#open-write01").toggle();
    });
});

$(document).ready(function(){
    $(".open-write02").click(function(){
        $("#open-write02").toggle();
    });
});

function closeLayer( obj ) {
	$(obj).parent().parent().hide();
}

$(function(){

	/* 클릭시 클릭한 위치 근처에 레이어가 나타난다. */
	$('.imgSelect').click(function(e)
	{
		var sWidth = window.innerWidth;
		var sHeight = window.innerHeight;

		var oWidth = $('.popupLayer').width();
		var oHeight = $('.popupLayer').height();

		// 레이어가 나타날 위치를 셋팅한다.
		var divLeft = e.clientX + 10;
		var divTop = e.clientY + 5;

		// 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
		if( divLeft + oWidth > sWidth ) divLeft -= oWidth;
		if( divTop + oHeight > sHeight ) divTop -= oHeight;

		// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치하자.
		if( divLeft < 0 ) divLeft = 0;
		if( divTop < 0 ) divTop = 0;

		$('.popupLayer').css({
			"top": divTop,
			"left": divLeft,
			"position": "absolute"
		}).show();
	});

	/* 클릭시 클릭한 위치 근처에 레이어가 나타난다. */
	$('.imgSelect2').click(function(e)
	{
		var sWidth = window.innerWidth;
		var sHeight = window.innerHeight;
		
		var oWidth = $('.popupLayer2').width();
		var oHeight = $('.popupLayer2').height();
		
		// 레이어가 나타날 위치를 셋팅한다.
		var divLeft = e.clientX + 10;
		var divTop = e.clientY + 5;
		
		// 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
		if( divLeft + oWidth > sWidth ) divLeft -= oWidth;
		if( divTop + oHeight > sHeight ) divTop -= oHeight;
		
		// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치하자.
		if( divLeft < 0 ) divLeft = 0;
		if( divTop < 0 ) divTop = 0;
		
		$('.popupLayer2').css({
			"top": divTop,
			"left": divLeft,
			"position": "absolute"
		}).show();
	});

});

function execDaumPostcode(param) {
	var element_layer = document.getElementById('addrPop');
	
    new daum.Postcode({
        oncomplete: function(data) {
            // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                addr += extraAddr;
            
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('post'+param).value = data.zonecode;
            document.getElementById("addr1"+param).value = addr;
//            $("#post").val(data.zonecode); // 우편번호 (5자리)
//			$("#addr1").val(addr);
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("addr2"+param).value = '';
            document.getElementById("addr2"+param).focus();

            // iframe을 넣은 element를 안보이게 한다.
            // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
            $("#modi-pop").removeAttr('checked');
        },
        width : '100%',
        height : '100%',
        maxSuggestItems : 5
    }).embed(element_layer);
//    }).open();
    // iframe을 넣은 element를 보이게 한다.
    $("#modi-pop").click();
}



var cnt = 0;
var endSecond = 1800;

setInterval("fn_time_chk()", 1000);

function fn_time_chk(){
	cnt++;
	var html = '';
	var min = parseInt(cnt/60);
	
	if(cnt == 1500){
		alert('5분 후 로그아웃됩니다.');
	}
	
	if(cnt == endSecond){
		alert('접속시간이 경과되어 로그아웃됩니다.');
		window.location.href = "/qxsepmny/lgn/admLogout.do";
	}
	
	$("#cntTime").html(min);
}

function fn_extend(){
	cnt = 0;
	$("#user-pop").click();
}