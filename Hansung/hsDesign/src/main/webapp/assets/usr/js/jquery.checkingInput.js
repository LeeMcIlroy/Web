if(jQuery) (function($) {
	
	$.extend($.fn, {
		
		checkingInput: function(method, data) {
			
			var init = function(input, data) {
				input = $(input);
				if(input.parent().get(0).tagName != "LABEL") {
					input.wrap('<label></label>');
				}
				var label = input.parent();
				label = $(label);
				
				label.addClass(input.attr('type'));
				if(input.get(0).checked){
					if(input.get(0).checked) input.parent().addClass('checked');
					else input.parent().removeClass('checked');
				}
				if(input.attr('disabled')){
					label.addClass('disabled');
				}
				input.css('opacity',0)
					.bind('click.checkingInput',function(event){
						if($(this).attr('type')=="checkbox"){
							if($(this).get(0).checked) $(this).parent().addClass('checked');
							else $(this).parent().removeClass('checked');
						}
						else if($(this).attr('type') == "radio"){
							var r = document.getElementsByName(input.attr('name'));
							for(var i=0; i<r.length; i++){
								if(r[i].checked) $(r[i]).parent().addClass('checked');
								else $(r[i]).parent().removeClass('checked');
							}
						}
				});
			}
			
			$(this).each( function() {
				if(this.type == "radio" || this.type == "checkbox"){
					init(this, method);
				}
			});
			
			return $(this);
			
		}
		
	});
	
})(jQuery);