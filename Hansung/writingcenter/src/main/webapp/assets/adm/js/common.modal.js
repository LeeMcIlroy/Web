var jqModalPopupObjs = [];
var closePopup = function(arg) {
	jqModalPopupObjs[jqModalPopupObjs.length - 1].disablePopup(arg);
};

(function($) {
	$.fn.jqModalPopup = function(el, options) {
		var opts  = $.extend({}, $.fn.jqModalPopup.defaults, options);
		var layer = $(el);
		var backgroundLayer = null;

		backgroundLayer = $("<div class='noprint'></div>")
			.css({
				"display"		: "none",
				"overflow"		: "hidden",
				"position"		: "fixed",
				"top"			: "0px",
				"left"			: "0px",
				"right"			: "0px",
				"bottom"		: "0px",
				"background"	: opts.bg_color,
				"z-index"		: opts.zindex - 1,
				"opacity"		: opts.bg_opacity
			});
		$('body').append(backgroundLayer);

		if (opts.bOnclickHide) {
			backgroundLayer.click(function() {
				disablePopup("");
    		});
		}

		showPopup();

		function showPopup() {
			$("input").blur();
			$("a").blur();

			layer.css({
				"position"	: "absolute",
				"z-index"	: opts.zindex + 10 * jqModalPopupObjs.length
			});
			layer.fadeIn(opts.speed);
			layer.focus();

			backgroundLayer.css("z-index", layer.css("z-index") - 1);
			if (jqModalPopupObjs.length == 0) {
				backgroundLayer.fadeIn(opts.speed);
			} else {
				backgroundLayer.show();
				jqModalPopupObjs[jqModalPopupObjs.length - 1].backgroundLayer.hide();
			}

			if (opts.onOpen != null) {
				opts.onOpen();
			}

			jqModalPopupObjs.push({
				opts : opts,
				layer : layer,
				backgroundLayer : backgroundLayer,
				showPopup : showPopup,
				disablePopup : disablePopup
			});
		};

		function disablePopup(closeMode) {
			layer.fadeOut(opts.speed);

			jqModalPopupObjs.splice(jqModalPopupObjs.length - 1, 1);
			if (jqModalPopupObjs.length == 0) {
				backgroundLayer.fadeOut(opts.speed);
			} else {
				backgroundLayer.hide();
				jqModalPopupObjs[jqModalPopupObjs.length - 1].backgroundLayer.show();
			}
			if (opts.autoDestroy) {
				destroy();
			}

			if (closeMode == "ok") {
				if (opts.onOk != null) {
					opts.onOk();
				}
			} else if (closeMode == "cancel") {
				if (opts.onCancel != null) {
					opts.onCancel();
				}
			}
			if (opts.onClose != null) {
				opts.onClose();
			}
		};

		function destroy() {
			backgroundLayer.remove();
		}
	};

	$.fn.jqModalPopup.defaults = {
		speed				: 'fast',
		zindex				: 100,
		bg_color			: "#ffffff",
		bg_opacity			: 0,
		bOnclickHide		: true,
		onOpen				: null,
		onClose				: null,
		onOk				: null,
		onCancel			: null,
		autoDestroy			: true
	};

})(jQuery);
