$(function(){

	//이미지 리사이징
	$(".cts_area img").each(function(){
		if( !$(this).attr("style") ) return;
		
		$(this).css({
			'max-width': $(this).width()+'px'
			,'max-height': $(this).height()+'px'
			, 'width' : '100%'
			, 'height' : '100%' 
		});
	})

});