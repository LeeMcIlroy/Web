$(function(){
	$(window).resize(function(){
		fn_grep_typ();
	})
	fn_grep_typ();
});

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

$(function() {
	//input을 datepicker로 선언
	$("#m-datepicker, #m-datepicker01, #m-datepicker02, #m-datepicker03, #m-datepicker04, #m-datepicker05, #m-datepicker06, #m-datepicker07, #m-datepicker08, #m-datepicker09, #m-datepicker10, #m-datepicker11, #m-datepicker12, #m-datepicker13, #m-datepicker14").datepicker({
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
//	$('#m-datepicker, #m-datepicker01, #m-datepicker02, #m-datepicker03, #m-datepicker04, #m-datepicker05, #m-datepicker06, #m-datepicker07, #m-datepicker08, #m-datepicker09, #m-datepicker10, #m-datepicker11, #m-datepicker12, #m-datepicker13, #m-datepicker14').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            	
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

// JavaScript Document



$(function (){
	
	var aff = "n"

	/*특정값 이하 내려갔을경우 스크롤 top버튼 보임*/
	$(window).scroll(function(){
		var winH = $(window).height()/10;
		var allH = $(window).scrollTop();
		//alert(winH);
		//alert(allH);
		if( winH >= allH){
			
			$('.top_btn').fadeOut();
		}
		if( winH < allH){
			$('.top_btn').fadeIn();
		}
	});

	$('.top_btn').click(function(){
		$('body,html').animate({scrollTop:0},1000);
	});

	
	
	side_menu_aco();
	sel_box();
	history_aco();
    pillar_aco();
	edu_aco();
	personal_more();

})

var body_height = ""
var left_value = "-80.5625%"
function side_menu_aco(){
	
	
	
	
	$('.menu_list_btn').click(function(){
		

		$('.side_menu').animate({left:0},500);
		
		body_height = $('#wrap').outerHeight();
		$('.black').css('height',body_height);
		$('.black').show();
		$('.side_menu').css('height',body_height);
		$('.m_x_btn').show();


	});

	$('.black,.m_x_btn').click(function(){
	
		$('.side_menu').animate({left:-80.5625+'%'},500);
		$('.black').hide();
		$('.depth02').hide();
		$('.depth02').hide();
		$('.m_x_btn').hide();
	});
/*
	$('.depth01').click(function(){
	
		$(this).siblings('.depth02').slideToggle();
	});

	
*/
	

	$('.depth01').click(function(){
			if($(this).siblings('.depth02').css('display') != 'none')
			{
				$(this).siblings('.depth02').slideUp(500);
				$(this).siblings('.depth02').children('li').children('a').siblings('.depth03').slideUp(500);
			}
			else
			{
				$('.depth02').slideUp(500);
				$(this).siblings('.depth02').slideDown(500);
				$(this).siblings('.depth02').children('li').children('a').siblings('.depth03').slideDown(500);
			}

/*

			$('.depth02').click(function(){
	
		if($(this).children('li').children('.depth03').css('display') != 'none')
			{
				$(this).children('li').children('.depth03').slideUp(500);
			}
			else
			{
				$('.depth03').slideUp(500);
				$(this).children('li').children('.depth03').slideDown(500);
				
			}
				});
			
				*/

		});





}

function sel_box(){
		
		$('.sel1_img').click(function(){
			$('.sel1_opt').toggle();
			$('.sel1_img p img').toggle();
			});
		
		$('.sel2_img').click(function(){
			$('.sel2_opt').toggle();
			$('.sel2_img p img').toggle();
			});
		
		$('.sel3_img').click(function(){
			$('.sel3_opt').toggle();
			$('.sel3_img p img').toggle();
			});
		
		$('.sel4_img').click(function(){
			$('.sel4_opt').toggle();
			$('.sel4_img p img').toggle();
			});

		
		}

function history_aco(){
			/*
            $('.aco_area dl dt').addClass('btn_bg2');
			$('.aco_area dl dt').removeClass('btn_bg');
			$('.aco_area dl dd:first').show();
			$('.aco_area dl dt h3').css('color','#000');
			$('.aco_area dl dt:first').removeClass('btn_bg2');
			$('.aco_area dl dt:first').addClass('btn_bg');
			$('.aco_area dl dt:first h3').css('color','#0c4da2');


			$('.aco_area dl dt').click(function(){
			    $('.aco_area dl dt h3').css('color','#000');
				if($(this).siblings('dd').css('display') != 'none')
				{

					$(this).children('h3').css('color','#000');
					$(this).siblings('dd').slideUp(500);
					$(this).addClass('btn_bg2');
					$(this).removeClass('btn_bg');
				}
				else
				{
					$('.aco_area dl dd').slideUp(500);
					$(this).children('h3').css('color','#0c4da2');
					$(this).siblings('dd').slideDown(500);
					$(this).addClass('btn_bg');
					$(this).removeClass('btn_bg2');
					
				}
			});

*/
			$('.faq_area dl dt').click(function(){


			    $('.faq dl dt h3').css('color','#000');
				if($(this).siblings('dd').css('display') != 'none')
				{

					$('.faq dl dt').addClass('btn_bg');
					$('.faq dl dt').removeClass('btn_bg2');
					$(this).children('h3').css('color','#000');
					$(this).siblings('dd').slideUp(500);
					$(this).addClass('btn_bg2');
					$(this).removeClass('btn_bg');
				}
				else
				{
					$('.faq dl dt').addClass('btn_bg2');
					$('.faq dl dt').removeClass('btn_bg');
					$('.faq dl dd').slideUp(500);
					$(this).children('h3').css('color','#00A0C9');
					$(this).siblings('dd').slideDown(500);
					$(this).addClass('btn_bg');
					$(this).removeClass('btn_bg2');
					
				}
			});
		}

function pillar_aco(){
			


			$('.aco_area_pillar dl dt').click(function(){
			    $('.aco_area_pillar dl dt h3').css('color','#000');
				if($(this).siblings('dd').css('display') != 'none')
				{
					$('.aco_area_pillar dl dt').addClass('btn_bg');
					$('.aco_area_pillar dl dt').removeClass('btn_bg2');
					$(this).children('h3').css('color','#000');
					$(this).siblings('dd').slideUp(500);
					$(this).addClass('btn_bg2');
					$(this).removeClass('btn_bg');
				}
				else
				{
					$('.aco_area_pillar dl dt').addClass('btn_bg2');
					$('.aco_area_pillar dl dt').removeClass('btn_bg');
					$('.aco_area_pillar dl dd').slideUp(500);
					$(this).children('h3').css('color','#0c4da2');
					$(this).siblings('dd').slideDown(500);
					$(this).addClass('btn_bg');
					$(this).removeClass('btn_bg2');
					
				}
			});
		}


function edu_aco(){
			


			$('.aco_area_edu dl dt').click(function(){
			    $('.aco_area_edu dl dt h3').css('color','#000');
				if($(this).siblings('dd').css('display') != 'none')
				{
					//$('.aco_area_edu dl dt').addClass('btn_bg');
					//$('.aco_area_edu dl dt').removeClass('btn_bg2');
					$(this).children('h3').css('color','#000');
					$(this).siblings('dd').slideUp(500);
					//$(this).addClass('btn_bg2');
					//$(this).removeClass('btn_bg');
				}
				else
				{
					//$('.aco_area_edu dl dt').addClass('btn_bg2');
					//$('.aco_area_edu dl dt').removeClass('btn_bg');
					$('.aco_area_edu dl dd').slideUp(500);
					$(this).children('h3').css('color','#0c4da2');
					$(this).siblings('dd').slideDown(500);
					//$(this).addClass('btn_bg');
					//$(this).removeClass('btn_bg2');
					
				}
			});
		}


function personal_more(){
	
		$('.more').click(function(){
			
			$('.dp_none').show();

		});

	
}

/**
 * 모바일과 웹을 구분해서 해당 없는 부분의 input은 disabled 처리
 */
function fn_grep_typ(){
	var typ = $(".mob").css("display");
	
	if( typ == "none" ){
		$(".mob input").prop("disabled", true);
		$(".mob select").prop("disabled", true);
		$(".mob textarea").prop("disabled", true);
		$(".web input").removeProp("disabled", true);
		$(".web select").removeProp("disabled", true);
		$(".web textarea").removeProp("disabled", true);
	}else{
		$(".web input").prop("disabled", true);
		$(".web select").prop("disabled", true);
		$(".web textarea").prop("disabled", true);
		$(".mob input").removeProp("disabled", true);
		$(".mob select").removeProp("disabled", true);
		$(".mob textarea").removeProp("disabled", true);
	}
}

/**
 * 사용자 강의실 변경
 */
function fn_chg_lect(selLectCode, selLectName){
	
	location.href="/usr/login/changeLect.do?selLectCode="+selLectCode+"&selLectName="+selLectName;
}

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
            document.getElementById('postNo'+param).value = data.zonecode;
//            document.getElementById('post').value = data.zonecode;
//            document.getElementById("addr1").value = addr;
//            // 커서를 상세주소 필드로 이동한다.
//            document.getElementById("addr2").value = '';
//            document.getElementById("addr2").focus();
            
            document.getElementById("addrMain"+param).value = addr;
            document.getElementById("addrGita"+param).value = '';
            document.getElementById("addrGita"+param).focus();
            
            // iframe을 넣은 element를 안보이게 한다.
            // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
            $("#modi-pop").removeAttr('checked');
        },
        width : '100%',
        height : '100%',
        maxSuggestItems : 5
    }).embed(element_layer);

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
		window.location.href = "/usr/login/logout.do";
	}
	
	$("#cntTime").html(min);
}

function fn_extend(){
	cnt = 0;
	$("#user-pop").click();
}


