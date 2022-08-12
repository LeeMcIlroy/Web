$(function(){
	
	if($(".datepicker").length > 0){
		$.datepicker.regional['ko'] = {
				closeText: '닫기',
				prevText: '이전',
				nextText: '다음',
				currentText: '오늘',
				monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
				monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
				dayNames: ['일','월','화','수','목','금','토'],
				dayNamesShort: ['일','월','화','수','목','금','토'],
				dayNamesMin: ['일','월','화','수','목','금','토'],
				weekHeader: 'Wk',
				dateFormat: 'yy-mm-dd',
				firstDay: 0,
				isRTL: false,
				showMonthAfterYear: true,
				yearSuffix: ''
		};
		
		$.datepicker.setDefaults($.datepicker.regional['ko']);
		
		$(".datepicker").datepicker({
			dateFormat: "yy-mm-dd"
			, showOn: "button"
			, buttonImage: "../../../assets/adm/img/btn_calendar.gif"
			, buttonImageOnly: true
			, changeMonth: true
			, changeYear: true
			//, minDate : 0
		});
		
		//시작일.
		$('.start_date').datepicker({
			dateFormat: "yy-mm-dd",             // 날짜의 형식
			changeYear: true,
			changeMonth: true,                  // 월을 이동하기 위한 선택상자 표시여부

			showOn: "button",
			buttonImage: "../../../assets/adm/img/btn_calendar.gif",
			buttonImageOnly: true,
			// timepicker 설정
	        controlType:'select',
	        oneLine:true
		});

		//종료일
		$('.end_date').datepicker({
			dateFormat: "yy-mm-dd",
			changeYear: true,
			changeMonth: true,
			//maxDate: 0, // 오늘 이전 날짜 선택 불가

			showOn: "button",
			buttonImage: "../../../assets/adm/img/btn_calendar.gif",
			buttonImageOnly: true,
	        controlType:'select',
	        oneLine:true
		});
		
		
	}
});

$(function() {
	//input을 datepicker로 선언
	$("#datepicker, #datepicker01, #datepicker02, #datepicker03, #datepicker04, #datepicker05, #datepicker06, #datepicker07, #datepicker08, #datepicker09, #datepicker10, #datepicker11, #datepicker12, #datepicker13, #datepicker14").datepicker({
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
		,minDate: "-10Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
		,maxDate: "+10Y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
		,yearRange: "c-20:c+20" // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할것인가.
	});                    
	
	//초기값을 오늘 날짜로 설정
//	$('#datepicker, #datepicker01, #datepicker02, #datepicker03, #datepicker04, #datepicker05, #datepicker06, #datepicker07, #datepicker08, #datepicker09, #datepicker10, #datepicker11, #datepicker12, #datepicker13, #datepicker14').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
});

function fn_date_picker(id){
	$("#"+id).datepicker({
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
		,minDate: "-10Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
		,maxDate: "+10Y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)  
		,yearRange: "c-20:c+20" // 년도 선택 셀렉트박스를 현재 년도에서 이전, 이후로 얼마의 범위를 표시할것인가.
	});  
}