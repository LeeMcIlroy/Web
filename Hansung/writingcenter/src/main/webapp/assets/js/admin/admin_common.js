$(function(){
	gnb();

	// 테이블 홀수
	$('.odd_list tr:odd').addClass("odd");
});

function gnb(){
	var $gnb = $("#gnb_wrap");
	var $btn = $("#gnb > li");
	var liW = 100 / $("#gnb > li").length;
	// console.log(liW+"%");
	$("#gnb > li").width(liW+"%");
	
	$btn.on("mouseenter", function(){
		$(".dep02_wrap").hide();
		$(this).children('a').next(".dep02_wrap").show();
	});

	$gnb.on("mouseleave", function(){
		$(".dep02_wrap").hide();
	});
}


// 탑
/*$(window).scroll(function(){
	var topPos=$(window).scrollTop()+50;
	$('#btn_top').stop().animate({top:topPos+'px'},500);
});*/