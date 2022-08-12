

$(document).ready(function($){	
	// checkbox, radio 디자인 적용
	$(".form_base").inputChecker();	
});

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

