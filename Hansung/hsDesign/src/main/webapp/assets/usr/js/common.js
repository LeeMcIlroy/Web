
$(document).ready(function(){
	$('.left_rolling_banner > ul').bxSlider({		
		auto: true,		
		autoHover:true		
	});

	$('.photo_slider > ul').bxSlider({	
		mode:'fade',				
		autoHover:true,
		adaptiveHeight: true,
		pagerCustom: '#bx-pager'
	});
});
/*
$(document).ready(function(){
	$('.m_visual > ul').bxSlider({		
		auto: true,		
		autoHover:true
	});
});
*/
$(document).ready(function(){
	$('.slide_banner > ul').bxSlider({
		mode:'fade',
		auto: true,		
		autoHover:true	
	});
});

$(document).ready(function(){
	aviSlider=$('.video_list02 > ul').bxSlider({
		autoHover:true	
	});
	
});
/*
$( window ).resize(function() {
	midSlider=$('.m_box_banner > ul').bxSlider({
		autoHover:true	
	});
	
	if($(window).width() < 600 ){
		midSlider.reloadSlider(); 
	}else{
		midSlider.remove();
	}
	

});
*/

$(document).ready(function(){		

	var slider1 = $('.s_photo > ul').bxSlider({		
		minSlides: 1,
		maxSlides: 1,
		moveSlides: 4,
		slideMargin: 10,
		infiniteLoop: false
	});	
});



//$(document).ready(function(){
//	var $header = $('#header')
//		$header.find('.all_menu_open > ul > li > ul > li > a').hover(function(){
//		$header.find('.all_menu_open > ul > li > ul > li > ul',this).show();
//	});
//		$header.find('.all_menu_open > ul > li > ul > li > a').mouseleave(function(){
//		$header.find('..all_menu_open > ul > li > ul > li > ul',this).hide();
//	});
//});


//$(document).ready(function(){
//	var $header = $('#header')
//		$header.find('.m_top > .m_close_btn').hover(function(){		
//		$header.find('.all_menu_open',this).hide();
//	});
//});

//#desktop .galleryWrap ul li, #tablet .galleryWrap ul li, 
//$(document).ready(function photoList(){
//	var $list_style1 = $(".img_list_type > a > ul > li"); 
//	$.each($list_style1, function() {
//		if($(this).find("img").width() >=  $(this).find("img").height()){
//			$(this).find("img").css({width:"auto",height:"100%"})
//			$(this).find("img").css({"margin-top":$(this).find("img").height()/-2,"margin-left":$(this).find("img").width()/-2})
//		}else if($(this).find("img").width() <=  $(this).find("img").height()){
//			$(this).find("img").css({width:"100%",height:"auto"})
//			$(this).find("img").css({"margin-top":$(this).find("img").height()/-2,"margin-left":$(this).find("img").width()/-2})
//		}
//	});
//});