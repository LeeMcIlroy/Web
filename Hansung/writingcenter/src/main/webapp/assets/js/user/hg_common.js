$(function(){
/* start */
	// 모바일 기기 체크
	var mfilter = "win16|win32|win64|mac|macintel";
	// gnb fn
	/*if( navigator.platform  ){
		if( mfilter.indexOf(navigator.platform.toLowerCase())>0 ){
		}else{
			alert();
		}
	}*/
	fnPcGnb();
	fnAllmenu();

	// 브라우저 업데이트 얼럿창
	$(".btn-update-close").click(function(){
		$(".alert-brw-update").slideUp(300);
	});

	// 모바일 검색 버튼 노출
	$(".btn_sh_open").on("click", function(e){
		e.preventDefault();
		ovlClose();
		$("#allmenu_wrap").hide();
		$(".cm_search").stop().slideToggle();
	});

	// 테이블 홀수/짝수
	$('.odd_list tr:odd').addClass("odd");
	$('.even_list tr:even').addClass("even");

	// 리스트 홀수/짝수
	$('.odd_list > li:odd').addClass("odd");
	$('.even_list > li:even').addClass("even");

	$(".odd_list > li").each(function(index){
		$(this).addClass("n"+index);
	});
	$(".even_list > li").each(function(index){
		$(this).addClass("n"+index);
	});

	// 워터마크
	if ($(".wm_sh").length) {
		$(".wm_sh").watermark( "검색어를 입력해 주세요");
	};
	if ($(".wm_sh").length) {
		$(".wm_login").watermark( "로그인 후 글 입력이 가능합니다.", { useNative: false });
	};

	// 상단으로가기 버튼 스크롤 에니메이션
	$(window).scroll(function(){
		var topPos=$(window).scrollTop()+25;
		$('.quick_bn.pc').stop().animate({top:topPos+'px'},500);
	});
	$('.btn_top').on('click', function(e){
		e.preventDefault();

		var pos = $('#wrap').offset().top;

		$('html, body').animate({
			scrollTop:pos
		}, 500);
	});
	// 상단으로가기 버튼 스크롤 에니메이션 //

	// 텝버튼 스타일 클릭
	$(".tab_btn_type1 > ul > li").on("click", function(e){
		e.preventDefault();

		$(".tab_btn_type1 > ul > li").removeClass("on");
		$(this).addClass("on");
	});
/* end */
});
// 메인 메뉴
function fnPcGnb(){
	var $mbtn = $("#gnb > li.titm");
	var $subm = $("#gnb > li.titm > ul");

	$mbtn.on("mouseenter", function(){
		ovlClose();
		$("#allmenu_wrap").hide();
		$("#gnb_wrap .allmenu").removeClass("on");

		var $mbtn_img = $(this).find("img").attr("src");
		var $allmenu_img = $("#gnb > li.allmenu").find("img").attr("src");

		$mbtn_img = $mbtn_img.replace('_off', '_on');
		$allmenu_img = $allmenu_img.replace('_on', '_off');


		$(this).find("img").attr("src", $mbtn_img);
		$("#gnb > li.allmenu").find("img").attr("src", $allmenu_img);

		$subm.hide();
		$(this).children("ul").show();
	});
	$mbtn.on("mouseleave", function(){
		$mbtn.removeClass("on");

		var $mbtn_img = $(this).find("img").attr("src");
		$mbtn_img = $mbtn_img.replace('_on', '_off');
		$(this).find("img").attr("src", $mbtn_img);

		$subm.hide();
	});
}

// 브라우저창 크기
function getClientWidth() {
	var ret;
	if (self.innerHeight){     // IE 외 모든 브라우저
		ret = self.innerWidth;
	}else if (document.documentElement && document.documentElement.clientHeight){ // Explorer 6 Strict
		ret = document.documentElement.clientWidth;
	}else if (document.body){     // IE Browser
		ret = document.body.clientWidth;
	}
	return ret;
}
var doc_h = (window.innerHeight || self.innerHeight || document.documentElement.clientHeight || document.body.clientHeight);
var doc_w = (window.innerWidth || self.innerWidth || document.documentElement.clientWidth || document.body.clientWidth);

// 전체메뉴 보기
function fnAllmenu(){
	var $btn = $("#gnb_wrap .allmenu");
	var imgsrc = $btn.find("img").attr("src");
	var $btn_close = $("#allmenu_wrap .btn_am_close");
	var $allmenu = $("#allmenu_wrap");
	var $am_btn = $("#allmenu_wrap> .inner > ul > li > a");

	var w = (window.innerWidth || self.innerWidth || document.documentElement.clientWidth || document.body.clientWidth);

	// PC 초기 가로 값
	// var menu_wrap = $("#allmenu_wrap > .inner > ul").outerWidth();
	var menu_wrap = 100;
	var menu_length = $("#allmenu_wrap> .inner > ul > li").length;
	var mW = (100 / menu_length)+"%";

	// 모바일 100%
	if (w <= 1023) {
		$("#allmenu_wrap> .inner > ul > li").css({
			"width" : "100%"
		});
	}else {
	// PC
		$("#allmenu_wrap> .inner > ul > li").css({
			"width" : mW
		});
		// $("body").prepend("<p>"+mW+" / "+menu_wrap+"</p>");
	};
	$btn.on("click", function(e){
		e.preventDefault();

		var w = (window.innerWidth || self.innerWidth || document.documentElement.clientWidth || document.body.clientWidth);
		if ($allmenu.is(":visible")) {
			ovlClose();
			$btn.removeClass("on");

			imgsrc = imgsrc.replace('_on', '_off');
			$btn.find("img").attr("src", imgsrc);

			$allmenu.stop().hide();
		}else {
			if (w <= 1023) {
				ovlOpen();
				$allmenu.stop().show();
				$(".cm_search").stop().hide();
			}else {
			//PC
				ovlClose();

				$(this).addClass("on");

				imgsrc = imgsrc.replace('_off', '_on');
				$btn.find("img").attr("src", imgsrc);

				$allmenu.stop().show();
			};
		};

	});
	$btn_close.on("click", function(){
		ovlClose();
		$btn.removeClass("on");

		imgsrc = imgsrc.replace('_on', '_off');
		$btn.find("img").attr("src", imgsrc);

		$allmenu.hide();
	});

	// 모바일 전체메뉴 토글
	$am_btn.on("click", function(e){
		var w = (window.innerWidth || self.innerWidth || document.documentElement.clientWidth || document.body.clientWidth);
		if ($(this).next("ul").length) {
			if (w <= 1023) {
				e.preventDefault();
				$("#allmenu_wrap > .inner > ul > li > ul").stop().slideUp(300);
				$(this).next("ul").slideDown(300);
			};
		}
	});

	// window resize callback
	var resizeEnd;
	$(window).resize(function(){
		var w = (window.innerWidth || self.innerWidth || document.documentElement.clientWidth || document.body.clientWidth);
		clearTimeout(resizeEnd);

		if (w <= 1023) {
			mReset();
			$("#allmenu_wrap> .inner > ul > li").css({
				"width" : "100%"
			});
			if ($allmenu.is(":visible")) {
				ovlOpen();
			}else {
				ovlClose();
			};
		}else {
			pcReset();
			ovlClose();
			$("#allmenu_wrap> .inner > ul > li").css({
				"width" : mW
			});
		};
		/*resizeEnd = setTimeout(function(){
			// console.log("resize end");
		},750);*/
	});
	/*window.onorientationchange = function() {
		if (window.orientation == 0) {
			// alert("세로");
			mReset();
		}else {
			// alert("가로");
			pcReset();
		};
	}*/
	function pcReset(){
		$("#allmenu_wrap > .inner > ul > li > ul").show();
		$(".cm_search").stop().show();
	}
	function mReset(){
		$("#allmenu_wrap > .inner > ul > li > ul").hide();
		// $(".cm_search").stop().hide();
	}
}

// 모바일 가로모드 체크
/*window.onorientationchange = function() {
	if (window.orientation == 0) {
		alert("세로");
	}else {
		alert("가로");
	};
}*/
// TweenMax.to($gnb, 0.5, {left:0, delay:0.3, ease: Expo.easeInOut});
function ovlOpen(){
	if ($(".ovl").length) {
		return false;
	};
	$("body").append("<div class='ovl'></div>");
}
function ovlClose(){
	$(".ovl").animate({
		opacity : 0
	}, function(){
		$(this).remove();
	});
}

// 텝
function tab1(){
	var ontab = $(".tab_btn ul > li.on a").attr("href");

	$(ontab).show();

	$(".tab_btn ul > li > a").on("click", function(e){
		e.preventDefault();

		var cts = $(this).attr("href");

		$(".tab_btn ul > li").removeClass("on");
		$(this).closest("li").addClass("on");

		$(".tab_cts").hide();
		$(cts).show();

	});
}

;(function($){
	$.fn.tabs = function(options){
		var opts = $.extend({}, $.fn.tabs.defaults, options);

		var $trigger = $(this).children().children().children('a.trigger');
		//console.log($trigger);
		for (var i=0; i<$trigger.length; i++)
		{
			var $tbtn = $(this).children().children().children('a.tbtn0'+i);
			var num = $trigger.width();
			var btnW = i * $tbtn.width();

			//console.log(opts.elW);

			$tbtn.css({
				"left" : btnW
			});
		}

		//옵션
		$('.tbtn0'+opts.active).addClass("on");

		//console.log();

		$(this).children('ul.tab_wrap').each(function(){
			$(this).find('div.tab_content:eq('+opts.active+')').show();
		});

		$trigger.click(function(){
			$(this).addClass('on').parent('li').siblings('li').find('a.trigger').removeClass('on');
			$(this).parent('li').siblings('li').find('div.tab_content').hide();
			$(this).next('div.tab_content').show();

			this.blur();
			return false;
		});

	};

	$.fn.tabs.defaults = {
		elW : "120",
		active : 0
	};
})(jQuery);