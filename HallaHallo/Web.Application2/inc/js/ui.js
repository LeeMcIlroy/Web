$(function(){
	var winW = $(window).width();
	var winH = $(window).height();

	var ui = {
		init : function(){
			ui.search();
			ui.allMenu();
			ui.designSelect();
			ui.layerPopup();
			ui.ampmToggle();
			//ui.removeNotice();
			ui.attachFile();
			ui.moveTop();
		},
		search : function(){
			var $header = $("#header");
			var $btnOpenSrch = $header.find("#nav_util .search button");
			var $btnCloseSrch = $header.find(".btn_search_close");
			var $searchWrap = $header.find(".search_wrap");

			$btnOpenSrch.on("click", function(){
				$searchWrap.show();
				TweenMax.fromTo($searchWrap, .3, {opacity:0}, {opacity:1});
				$searchWrap.find("input").focus();
			});

			$btnCloseSrch.on("click", function(){
				$searchWrap.hide();
				TweenMax.fromTo($searchWrap, .5, {opacity:1}, {opacity:0});
			});
		},
		allMenu : function(){
			var $btnAllMenu = $("#header").find(".btn_allmenu");
			var currClass = "active";

			$btnAllMenu.on("click", function(){
				var $allMenu = $(this).parents("#nav").find("#allmenu");
				
				if( $(this).hasClass(currClass) === true ){
					$btnAllMenu.removeClass(currClass);
					$allMenu.hide();
					TweenMax.fromTo($allMenu, .3, {opacity:1}, {opacity:0});
				} else {
					$(this).addClass(currClass);
					$allMenu.show();
					TweenMax.fromTo($allMenu, .3, {opacity:0}, {opacity:1});
				}
			});		
		},
		designSelect : function(){
			var $select = $(".design_select");
			var $selectMenu = $select.find(".option_list > li");
			var $selectBtn = $select.find(".selected");
			var $selectViewWrap = $select.find(".option_wrap > .inner");
			var currClass = "current";
			var clicked = true;

			$select.each(function(idx){
				$(this).attr("data-select-key", idx).find(".option_wrap .option_list > li").each(function(_idx){
					$(this).attr("data-menu-key", _idx);
					if( $(this).hasClass("current") ){
					var key = $(this).attr("data-menu-key");
						var initTxt = $(this).text();
						$select.eq(idx).find(".selected > span").text(initTxt);
					}
				});
			});

			$selectBtn.on("click", function(){
				var tabKey = $(this).parents(".design_select").attr("data-select-key");

				if( clicked ){ // open
					clicked = false;
					$select.eq(tabKey).find(".option_wrap > .inner").show();
				} else { // close
					clicked = true;
					$select.eq(tabKey).find(".option_wrap > .inner").hide();
				}

				console.log(clicked);
			});

			$selectMenu.on("click", function(){
				var tabKey = $(this).parents(".design_select").attr("data-select-key");
				var menuKey = $(this).attr("data-menu-key");
				var currKey = $select.eq(tabKey).find(".option_wrap .option_list > li.current").attr("data-menu-key");

				var $selectMenu = $select.eq(tabKey).find(".option_wrap .inner > .option_list > li");
				var $selectViewWrap = $select.eq(tabKey).find(".option_wrap > .inner");
				var $selectBtnTxt = $selectViewWrap.siblings(".selected").find("span");
				var tabMenuTxt = $(this).find("a").text();

				clicked = true;

				$select.eq(tabKey).find(".option_wrap > .inner").hide();
				$selectMenu.eq(currKey).removeClass(currClass);

				$(this).addClass(currClass);

				$selectBtnTxt.text(tabMenuTxt);
			});
		},
		layerPopup : function(){
			var $layerPop = $('.layerpop');
			var $previewPop = $('#pop_preview');
			var $dim = $('.dim');

			$previewPop.css("height", winH - 150);

            $(document).on('click', ".btn_layer_open", function (e) {
				var tgId = $(this).attr('data-layer-id');
				var $tg = $('#' + tgId );
				var layerW = $tg.width();
				var layerH = $tg.height();

				$(window).trigger('resize');

				$tg.show();
				dimCtrl();
				popAlignCenter($tg, layerW, layerH);
			});

            $(document).on('click', '.dim, .btn_layer_close, .btn_confirm, .btn_cancel', function(){
				closeLayer();
			});

            $(document).on('click', ".btn_layer_close, .btn_confirm, .btn_cancel", function(){
				$(this).parents('.commonPop').hide();
			});

			function popAlignCenter($tg, lw, lh){
				var winW = $(window).width();
				var winH = $(window).height();

				$tg.css({
					left : (( winW - lw ) / 2),
					top : (( winH - lh ) / 2)
				});

				$(window).resize(function(){
					resizePopAlignCenter($tg);
				});
			}

			function resizePopAlignCenter($tg){
				var winW = $(window).width();
				var winH = $(window).height();
				var a = $tg.width();
				var b = $tg.height();	

				$tg.css({
					left : (( winW - a ) / 2),
					top : (( winH - b ) / 2)
				});
			}

			function closeLayer(){
                $('.layerpop').hide();
				$previewPop.hide();
				dimCtrl(false);
			}

			function dimCtrl(visibleState){
				if( visibleState === undefined ){ visibleState = true };
				if( visibleState ){
					$dim.show();
					TweenMax.to( $dim, .2, { opacity : 1, ease : Ease.Power0 });
				} else {
					TweenMax.to( $dim, .2, { opacity : 0, ease : Ease.Power0, onComplete : function(){ $dim.hide(); } });
				}
			}
		},
		ampmToggle : function(){
			var $ampmBtn = $('.ampm');

			$ampmBtn.on("click", function(){
				if( $(this).text() === "오전" ){
					$(this).text("오후");
				} else if( $(this).text() === "오후" ){
					$(this).text("오전");
				}
			});
		},
		removeNotice : function(){
			var $noticeList = $(".notice_group .notice_list"),
				$delBtn = $noticeList.find("li > .btn_del");

			$delBtn.on("click", function(){
				var $tg = $(this).parents(".notice_group");
				var listLen = $(this).parents(".notice_list").find("> li").length;

				$(this).parent("li").remove();
				--listLen;

				if( listLen === 0 ){ $tg.remove(); }
			});
		},
		attachFile : function(){
			var uploadFile = $('.file_box .btn_upload');
			
            $(document).on('change', '.file_box .btn_upload', function () {
                var filename;
                if (window.FileReader) {
                    filename = '';

                    var len = $(this)[0].files.length;
                    for (var i = 0; i < len; i++) {
                        filename += $(this)[0].files[i].name + ";";
                    }
				} else {
					filename = $(this).val().split('/').pop().split('\\').pop();
				}
				$(this).parent(".btn_file").siblings('.file_name').val(filename);
			});
		},
		moveTop : function(){
			var $btnTop = $("#footer").find('.btn_top');

			$btnTop.on('click', function(){
				TweenMax.to( "html, body", .4, { scrollTop : 0, ease : Expo.easeInOut } );
			});
		}
	};
	ui.init();
});