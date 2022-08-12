//버튼 active 
$(document).on("touchstart", function(){});

// checkbox, radio 디자인 적용
$.fn.inputChecker = function(options){
	$.each(this, function(i,v){
		if(v.type === "radio" || v.type === "checkbox"){
			$(v).ezMark(options);
			try{
				if($(v).data("toggler").length > 0){
					$(this).bind("change", function(){
						$($(this).data("toggler")).toggle();
					});
					if($(this).is(":checked")){
						$($(this).data("toggler")).show();
					};
				};
			}catch(e){
			};
		};
		if(v.type === "select-one" || v.type === "select-multiple"){$(v).customSelect();};
	});
};


$(document).ready(function(){
	// checkbox, radio 디자인 적용
	$(".form_base").inputChecker();	
	
	//모바일 메뉴
	$('#main-sidebar').simpleSidebar({
		opener: '#toggle-sidebar',
		wrapper: '#main',
		animation: {
			easing: "easeOutQuint"
		},
		sidebar: {
			align: 'right',
			closingLinks: '.close_menu',
		},
		sbWrapper: {
			display: true
		}
	});
	
	//GNB
	$(".gnb > ul > li").hover(function(){ 
		$(this).find(".dropdown").stop(true, true).fadeToggle(70); 
		$(".gnb > ul > li").removeClass("over");
		$(this).addClass("over");
	}); 
	$(".gnb > ul > li").mouseleave(function(){ 
		$(".gnb > ul > li").removeClass("over");
	});
});