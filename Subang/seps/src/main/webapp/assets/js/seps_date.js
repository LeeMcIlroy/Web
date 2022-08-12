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
			//, showOn: "button"
			//, buttonImage: "../../../assets_old/adm/img/btn_calendar.gif"
			//, buttonImageOnly: true
			, changeMonth: true
			, changeYear: true
			//, minDate : 0
		});
		
		
	}
/*	
	if($(".common_datepicker").length > 0){
		$(".common_datepicker").datepicker({
			dateFormat: "yy-mm-dd"
			, showOn: "button"
			, buttonImage: "../../../assets/adm/img/btn_calendar.gif"
			, buttonImageOnly: true
			, changeMonth: true
			, changeYear: true
		});
	}
*/
});

function fn_startDatepicker(){
	//var today = $.datepicker.formatDate('yy-mm-dd', new Date());
	$('.start_day').datepicker({
		altField: ".start_day",
		altFormat: ($(".start_day").attr("format") == null)? 'yy-mm-dd':$(".start_day").attr("format"),
		showOn: "both",                     // 달력을 표시할 타이밍 (both: focus or button)
		buttonImage: "/assets/img/icon_calendar.jpg", // 버튼 이미지
		buttonImageOnly : true,             // 버튼 이미지만 표시할지 여부
		buttonText: "날짜선택",             // 버튼의 대체 텍스트
		dateFormat: 'yy-mm-dd',             // 날짜의 형식
		changeYear: true,
		changeMonth: true,                  // 월을 이동하기 위한 선택상자 표시여부
		//minDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이전 날짜 선택 불가)
		//maxDate : today,
		
		// timepicker 설정
        //timeFormat:'HH:mm:ss',
        //controlType:'select',
        //oneLine:true,
		/*
		onChangeMonthYear: function(year, month, inst){
			console.log(year);
			console.log(month);
		},
		onSelect: function(selectedDate){
			console.log(selectedDate);
		},
		*/
		onClose: function( selectedDate ) {
			// 시작일(fromDate) datepicker가 닫힐때
			// 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
			if(selectedDate != '') {
				var arr = selectedDate.split("-");
				var date = new Date();
				date.setFullYear(arr[0]);
				date.setMonth((arr[1]==null? 1:arr[1])-1);
				date.setDate(arr[2]==null? 1:arr[2]);
				
				if($(".finish_day").length > 0){
					var tmp = new Date();
					var finishDate = $(".finish_day").val().split("-");
					tmp.setFullYear(finishDate[0]);
					tmp.setMonth((finishDate[1]==null? 1:finishDate[1])-1);
					tmp.setDate(finishDate[2]==null? 1:finishDate[2]);
					
					$(".finish_day").datepicker( "option", "minDate", date );
					//$(".finish_day").datepicker( "option", "minDate", selectedDate );
					if(date <= tmp) $(".finish_day").datepicker( "setDate", tmp );
				}
				
			}
		}
	});
}
function fn_endDatepicker(){
	//var today = $.datepicker.formatDate('yy-mm-dd', new Date());
	$('.finish_day').datepicker({
		altField: ".finish_day",
		altFormat: ($(".finish_day").attr("format") == null)? 'yy-mm-dd':$(".finish_day").attr("format"),
		showOn: "both", 
		buttonImage: "/assets/img/icon_calendar.jpg", 
		buttonImageOnly : true,
		buttonText: "날짜선택",
		dateFormat: 'yy-mm-dd',
		changeYear: true,
		changeMonth: true,
		//minDate: 0, // 오늘 이전 날짜 선택 불가
		// timepicker 설정
		//maxDate : today,
        
		//timeFormat:'HH:mm:ss',
        //controlType:'select',
        //oneLine:true,
		/*
		onChangeMonthYear: function(year, month, inst){
			console.log(year);
			console.log(month);
		},
		onSelect: function(selectedDate){
			console.log(selectedDate);
		},
		*/
		onClose: function( selectedDate ) {
			// 종료일(toDate) datepicker가 닫힐때
			// 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
			if(selectedDate != ''){
				var arr = selectedDate.split("-");
				var date = new Date();
				date.setFullYear(arr[0]);
				date.setMonth((arr[1]==null? 1:arr[1])-1);
				date.setDate(arr[2]==null? 1:arr[2]);

				var tmp = new Date();
				var startDate = $(".start_day").val().split("-");
				tmp.setFullYear(startDate[0]);
				tmp.setMonth((startDate[1]==null? 1:startDate[1])-1);
				tmp.setDate(startDate[2]==null? 1:startDate[2]);
				
				$(".start_day").datepicker( "option", "maxDate", date );
				if(date >= tmp) $(".start_day").datepicker( "setDate", tmp );
				//$(".start_day").datepicker( "option", "maxDate", selectedDate );
			}
		}
	});
}