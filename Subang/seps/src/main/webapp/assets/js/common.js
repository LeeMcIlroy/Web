/*$(document).ready(function(){
	$(".menu>a").click(function(){
		var submenu = $(this).next("ul");

		// submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
		if(submenu.is(":visible") ){
			submenu.slideUp();
		}else {
			submenu.slideDown();
		}
	}).mouseover(function(){
		$(this).next("ul").slideDown();
	});
});*/

(function($){
$(document).ready(function(){

$('.left_menu li.active').addClass('open').children('ul').show();
	$('.left_menu li.has-sub>a').on('click', function(){
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
	});

});
})(jQuery);

$.datepicker.setDefaults({
	dateFormat: 'yy-mm-dd',
	prevText: '이전 달',
	nextText: '다음 달',
	monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	showMonthAfterYear: true
});


 $(function() {
                
            
	//오늘 날짜를 출력
	$(".today").text(new Date().toLocaleDateString());

	//datepicker 한국어로 사용하기 위한 언어설정
	$.datepicker.setDefaults($.datepicker.regional['ko']); 
	
	// 시작일(fromDate)은 종료일(toDate) 이후 날짜 선택 불가
	// 종료일(toDate)은 시작일(fromDate) 이전 날짜 선택 불가

	//시작일.
	$('.start_day').datepicker({
		//showOn: "both",                     // 달력을 표시할 타이밍 (both: focus or button)
		//buttonImage: "../../img/icon_calendar.png", // 버튼 이미지
		//buttonImageOnly : true,             // 버튼 이미지만 표시할지 여부
		//buttonText: "날짜선택",             // 버튼의 대체 텍스트
		dateFormat: "yy-mm-dd",             // 날짜의 형식
		changeYear: true,
		changeMonth: true,                  // 월을 이동하기 위한 선택상자 표시여부
		//minDate: -7,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이전 날짜 선택 불가)
		
		// timepicker 설정
        timeFormat:'HH:mm:ss',
        controlType:'select',
        oneLine:true,

		onClose: function( selectedDate ) {    
			// 시작일(fromDate) datepicker가 닫힐때
			// 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
			$(".finish_day").datepicker( "option", "minDate", selectedDate );
		}                
	});

	//종료일
	$('.finish_day').datepicker({
		//showOn: "both", 
		//buttonImage: "../../img/icon_calendar.png", 
		//buttonImageOnly : true,
		//buttonText: "날짜선택",
		dateFormat: "yy-mm-dd",
		changeYear: true,
		changeMonth: true,
		maxDate: 0, // 오늘 이전 날짜 선택 불가
		// timepicker 설정
        
		timeFormat:'HH:mm:ss',
        controlType:'select',
        oneLine:true,

		onClose: function( selectedDate ) {
			// 종료일(toDate) datepicker가 닫힐때
			// 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
			$(".start_day").datepicker( "option", "maxDate", selectedDate );
		}                
	});
});


/*div 드래그*/
$(document).ready(function(){	
	$(".absolute_div_cont > div").draggable({
		cursor:"move",
		stack:".absolute_div_cont",
		opacity:0.8
	});

	$(".absolute_div_cont").bind("dragstart",function(event, ui){
		$(this).addClass("color");	//bgi 체인지
	});
	$(".absolute_div_cont").bind("dragstop", function(event, ui){
		$(this).removeClass("color")	//bgi 체인지
	});
});
/*div 드래그*/

function popup_name3(n) {

	var id_name = n ;

	if($(id_name).css("visibility") == "hidden"){
		$(id_name).css("visibility", "visible");
	}else{
		$(id_name).css("visibility", "hidden");
	}
	cctv_on();
	
}

function popup_name(n, type, title) {

	$("#uDustGuide").hide();
	$("#dustGuide").hide();
	
	var id_name = n ;

	if($(id_name).css("visibility") == "hidden"){
		$(id_name).css("visibility", "visible");
	}else{
		$(id_name).css("visibility", "hidden");
	}
	
	if(type) {
		$("img#lifeMeasure").attr("src", "/assets/img/lifeMeasure/"+type+".jpg");
		$("span#life_measure_title").html(title);
	}
	
	if("dust" == type || "uDust" == type) {
		
		if("dust" == type ) {
			$("#dustGuide").show();
			$("#uDustGuide").hide();
		}else {
			$("#uDustGuide").show();
			$("#dustGuide").hide();
		}
		
		$("span.informer1").text(" 관련기준 ");
		$("span.informer2").text(" * 서울시 대기환경정보 ");
		
	}else if(type){
		$("span.informer1").text(" 대응요령 ");
		$("span.informer2").text(" * 기상청 제공 ");
	}
	
	cctv_on();
}

function cctv_on(){
	if($('#WatSearCtrl').length > 0){
		if($('#WatSearCtrl').css("visibility") == "hidden"){
			$('#WatSearCtrl').css("visibility", 'visible');
		}else{
			$('#WatSearCtrl').css("visibility", 'hidden');
		}
	}
	if($('#WatSearCtrl2').length > 0){
		if($('#WatSearCtrl2').css("visibility") == "hidden"){
			$('#WatSearCtrl2').css("visibility", 'visible');
		}else{
			$('#WatSearCtrl2').css("visibility", 'hidden');
		}
	}
}


function man_dchg(n, t){
	$(t).parent().parent().find("a").removeClass();
	$(t).addClass("on");
	
	for(i=1; i<=3; i++){
		tab_num = document.getElementById("ch_div"+i);
		if(tab_num != null){
			if (i == n)
			{
				tab_num.style.display = "block";
			}else{
				tab_num.style.display = "none";
			}
		}
	}
	return;
}


$(function() {
    $('.txt_counter').keyup(function (e){
        var content = $(this).val();
        
        $('#txt_counter02').html(content.length + '/38');
    });
    $('.txt_counter').keyup();
});


$(function() {
    $('.txt_counter03').keyup(function (e){
        var content = $(this).val();
        
        $('#txt_counter03').html(content.length + '/35');
    });
    $('.txt_counter03').keyup();
});


$(function() {
    $('.txt_counter04').keyup(function (e){
        var content = $(this).val();
        
        $('#txt_counter04').html(content.length + '/38');
    });
    $('.txt_counter04').keyup();
});


//Can also be used with $(document).ready()
$(window).load(function() {
  $('.flexslider').flexslider({
    animation: "slide",
    slideshowSpeed: 5000,
    maxItems: 6,
    customDirectionNav: $(".custom-navigation a")
  });
});



function isMobile() {
	
	// 모바일 감지
//	return jQuery.browser.mobile;
	// 아래는 모바일 장치들의 모바일 페이지 접속을위한 스크립트 
	var uAgent = navigator.userAgent.toLowerCase(); 
	var mobilePhones = new Array('iphone', 'ipod', 'ipad', 'android', 'blackberry', 'windows ce','nokia', 'webos', 'opera mini', 'sonyericsson', 'opera mobi', 'iemobile'); 
	for (var i = 0; i < mobilePhones.length; i++){ 
		if (uAgent.indexOf(mobilePhones[i]) != -1){
			return true;
		} 
	};
//	
//	var ratio = window.devicePixelRatio; 
//	if(ratio > 1){ 
//		return true;
//	}
	
	return false;
	
}


var legenColor = {
   "level1" : "blue"          
   , "level2" : "green"          
   , "level3" : "yellow"          
   , "level4" : "pink"          
   , "level5" : "red"          
};

function popup_name2(id, type) {
	
	var id_name = id ;

	if($(id_name).css("visibility") == "hidden"){
		$(id_name).css("visibility", "visible");
	}else{
		$(id_name).css("visibility", "hidden");
	}
	
	var values = lines[type];
	
	var html = "";
	
	for(var i=0; i<values.length;i++) {
		html+='<ul>';
			html+='<li>'+values[i].value+'m</li>';
			html+='<li>'+values[i].text2+'</li>';
			html+='<li><div style="width:90%;margin:0 auto;background-color: '+legenColor[values[i]["class"]]+'">&nbsp;</div></li>';
		html+='</ul>';
	}
	
	$("div#legend_popup div.tbl_td").html(html);
	
}
// 지역별 통제단계
// lines : lines["hangang"]
// 한강 
var lines = {
	cheongdam : [
       {value: 9.1, text: '', text2: '침수', osition: 'start', class:'level5'}, 
       {value: 8.1, text: '', text2: '통제', osition: 'start', class:'level3'},  
       {value: 7.6, text: '', text2: '준비', osition: 'start', class:'level1'},        
	]
	, daegok : [
       {value: 8.5, text: '', 	 text2: '침수', 	position: 'start', class:'level5'},
       {value: 7,   text: '',	 text2: '1단계 통제',	 position: 'start', class:'level3'},       
       {value: 5.5, text: '', 	 text2: '준비', 	position: 'start', class:'level2'}, 
	]
	, hangang : [
       {value: 5.4, text: '', text2: '침수', position: 'start', class:'level5'},
       {value: 4.4, text: '', text2: '통제', position: 'start', class:'level3'},
       {value: 3.9, text: '', text2: '준비', position: 'start', class:'level1'},
    ]
	, joongrang : [
	   {value: 4.5, text: '', 		text2: '침수', 			position: 'start', class:'level5'}, 
	   {value: 3.1, text: '', 	text2: '통제', 		position: 'start', class:'level3'},    
	   {value: 2.7, text: '', 		text2: '준비', 			position: 'start', class:'level2'},     
	], ogeum : [
       {value: 7, text: '', text2: '1단계 통제',	 position: 'start', class:'level3'},
       {value: 9, text: '', 	  text2: '침수',	 position: 'start', class:'level5'},        
	], paldang : [
       {value: 10500, text: '', text2: '여의상류 IC 침수', position: 'start', class:'level5'},
	], singok : [
	   {value: 2.6, text: '', text2: '통제', position: 'start', class:'level5'},          
	], wolgye1 : [
	   // {value: 14.43, text: '',		text2: '관심',		 position: 'start', class:'level1'},
	   {value: 17.23, text: '', 	text2: '침수', 	 position: 'start', class:'level5'},   
	   {value: 16.23, text: '', 	text2: '2차 통제', position: 'start', class:'level4'},      
	   {value: 15.83, text: '',		text2: '1차 통제',	 position: 'start', class:'level3'},  
	   {value: 15.43, text: '',		text2: '준비',		 position: 'start', class:'level2'},
	], wolleung : [
     // {value: 12.87, text: '',  text2: '관심', 		position: 'start', class:'level1'},
	   {value: 15.41, text: '',  text2: '침수', 		position: 'start', class:'level5'},
	   {value: 14.41, text: '',  text2: '2차 통제', 		position: 'start', class:'level4'},
	   {value: 14.01, text: '',  text2: '1차 통제',	position: 'start', class:'level3'},
	   {value: 13.61, text: '',  text2: '준비',	position: 'start', class:'level2'},
	]
	, yeoui : [
	   //{value: 3.4, text: '', text2: '관심',  position: 'start', class:'level2'},
	   {value: 5.4, text: '', text2: '침수',	position: 'start', class:'level5'},  
	   {value: 4.4, text: '', text2: '통제',  position: 'start', class:'level4'},      
	   {value: 3.9, text: '', text2: '준비',  position: 'start', class:'level2'},        
	]
};


