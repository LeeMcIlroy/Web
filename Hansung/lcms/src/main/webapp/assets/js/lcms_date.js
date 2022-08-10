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