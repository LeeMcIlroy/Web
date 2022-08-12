var MYAPP = MYAPP || {};

// MYAPP의 프로퍼티 중복 방지
MYAPP.namespace = function(str){
	var parts = str.split("."),
		parent = MYAPP,
		i;

	// 처음에 중복되는 전역 객체명은 제거
	if(parts[0] === "MYAPP"){
		parts = parts.slice(1);
	}

	for(i=0; i<parts.length; i++){
		// 프로퍼티가 존재하지 않으면 생성한다.
		if(typeof parent[parts[i]] === "undefined"){
			parent[parts[i]] = {};
		}

		parent = parent[parts[i]];
	}
	return parent;
};

//------------------------MYAPP 시작------------------------------
(function(app, $){
	app.namespace("selectorManager");
	app.selectorManager = {
		"minWidth":1200,
		"body":$("body"),
		"header":$("#header"),
		"lnb":$("#lnb"),
		"container": $("#container"),
        "mask": $("#mask")
	}

	// COMMON function
	app.namespace("common");
	app.common = (function(){
		var $header, $lnb, $container;
		var minWidth;

		var _init = function(){
			$header = app.selectorManager.header;
			$lnb = app.selectorManager.lnb;
			$container = app.selectorManager.container;
			minWidth = app.selectorManager.minWidth;

			lnbFunc();
		};

		// LNB
		function lnbFunc(){
			var time = 400,
				lnbOriWidth =  170,
				lnbChaWidth = 50,
				preventClick = false;       // 1200픽셀 이하일 때 메뉴 클릭 방지

			$(window).on("load resize", function(){
				var w = $(window).width();

				if (w < minWidth) {
				    preventClick = true;
					lnbFold();
				} else {
				    preventClick = false;
					lnbUnFold();
				}
			});

			$lnb.find(".depth1>li>a").click(function(e){
			    e.preventDefault();

				if (preventClick) {
				    return;

				} else { // 1200픽셀 이상일 때
				    if ($(this).hasClass("on")) {
				        $(this).removeClass("on");
				        $(this).siblings(".depth2").stop().slideUp(time);
				    } else {
				        $lnb.find(".depth1>li>a").removeClass("on");
				        $lnb.find(".depth2").stop().slideUp(time);
				        $(this).addClass("on");
				        $(this).siblings(".depth2").stop().slideDown(time);
				    }
				}
			});

			$lnb.find(".btn_fold").click(function (e) {
			    e.preventDefault();
			    if ($lnb.hasClass("fold")) {
			        lnbUnFold();
			    } else {
			        lnbFold();
			    }
			});

			function lnbFold() {
			    $lnb.find(".depth1>li>a").removeClass("on");
			    $lnb.find(".depth2").stop().slideUp(time);
				TweenMax.set($header, {"className":"+=fold"});
				TweenMax.set($lnb, {"className":"+=fold"});
				TweenMax.set($container, {"className":"+=fold"});
				TweenMax.to($header.find("h1"), 0.3, {"width":lnbChaWidth, ease:"Quint.easeOut"});
				TweenMax.to($lnb, 0.3, { "width": lnbChaWidth, ease: "Quint.easeOut" });
				TweenMax.to($lnb.find(".btn_fold"), 0.3, { "left": "28px", ease: "Quint.easeOut" });
				preventClick = true;
			}

			function lnbUnFold(){
				TweenMax.set($header, {"className":"-=fold"});
				TweenMax.set($lnb, {"className":"-=fold"});
				TweenMax.set($container, {"className":"-=fold"});
				TweenMax.to($header.find("h1"), 0.4, { "width": lnbOriWidth, ease: "Quint.easeOut" });
				TweenMax.to($lnb, 0.4, { "width": lnbOriWidth, ease: "Quint.easeOut" });
				TweenMax.to($lnb.find(".btn_fold"), 0.4, { "left": "148px", ease: "Quint.easeOut" });
				preventClick = false;
			}
		}

		return {
			init:_init
		}
	})();


    // 레이어 띄우기
	app.namespace("layerControl");
	app.layerControl = (function () {
	    var $mask = app.selectorManager.mask;

	    // 레이어 노출
	    var _layerShow = function (layerId) {
	        $mask.fadeTo("fast", 0.8);
	        TweenMax.set($(layerId), {"display":"block", "x":"-50%", "y":"-51%", delay:0.05});
	    }

	    // 레이어 숨김
	    var _layerHide = function (layerId) {
	        $mask.fadeOut("fast");
	        TweenMax.set($(layerId), {"display":"none"});
	    }

	    return {
	        layerShow: _layerShow,
	        layerHide: _layerHide
	    }
	})();

	// FORM style
	app.namespace("form");
	app.form = (function(){
		/*var _styleCheck = function(ele){
			var $ele = ele;

			$ele.change(function(){
				if($(this).is(":checked")){
					$(this).parent("label").addClass("on");
				}else{
					$(this).parent("label").removeClass("on");
				}
			});
		};*/

		var _styleSelect = function(ele){
			var $ele = ele;

			$ele.each(function(i){
				if($(this).find("option:selected")){
					var txt = $(this).find("option:selected").text();
					$(this).siblings("span").text(txt);
				}
			});

			$ele.on({
				"focusin":function(){
					$(this).parent("label").addClass("on");
				},
				"focusout":function(){
					$(this).parent("label").removeClass("on");
				},
				"change":function(){
					var val = $(this).children("option:selected").text();
					$(this).siblings("span").text(val);
				}
			});
		};

		/*var _styleFile = function (ele) {
		    var $ele = ele;

		    $ele.change(function () {
		        var name = $(this).val();
		        var val = name.substring(name.lastIndexOf("\\") + 1);

		        $(this).siblings("span").text(val);
		    });
		};*/

		var _styleFile = function () {

		    $(".tbl ").on("change", ".style_file input[type=file]", function () {
		        var name = $(this).val();
		        var val = name.substring(name.lastIndexOf("\\") + 1);

		        $(this).siblings("span").text(val);
		    });


		};

		var _styleGauge = function (ele) {
		    var $ele = ele;
		    $ele.change(function(){
		        $ele.siblings(".gauge_val").val($ele.val());
		    });
		}

		var _datePicker = function (inputId) {
		    $(inputId).datepicker({
		        showOn: "button",
		        dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
		        monthNames:[ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
		        buttonText: "<i class='fa fa-calendar'></i>",
		        dateFormat: "yy-mm-dd"
		    });
		}

		var _datePickerTime = function (inputId) {
		    $(inputId).datepicker({
		        showOn: "button",
		        dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
		        monthNames:[ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
		        buttonText: "<i class='fa fa-calendar'></i>",
		        dateFormat: "yy-mm-dd hh:nn",			// yy-mm-dd / yy-mm-dd hh:nn
		        changeTime: true,			// true 이면 시간 UI 생김
		        changeTimeType: "select"	// input 이면 input[type=text] type, select 이면 selectbox 형태
		    });
		}

		return {
			//styleCheck:_styleCheck,
		    styleSelect: _styleSelect,
		    styleFile: _styleFile,
            styleGauge:_styleGauge,
            datePicker:_datePicker,
            datePickerTime:_datePickerTime
		}
	})();

    // 테이블 필드 추가/삭제
	app.namespace("tblControl");
	app.tblControl = (function () {
	    var addBtns = "<a href='#none' class='addBtn'><i class='fa fa-plus-circle'></i></a><a href='#none' class='delBtn'><i class='fa fa-minus-circle'></i></a>";
	    var addBtn = "<a href='#none' class='addBtn'><i class='fa fa-plus-circle'></i></a>";

	    var _init = function () {

	        $(".tbl").on("click", ".addBtn", function (e) {

	            e.preventDefault();

	            var cloneRow = $(this).parent().parent().clone();
	            var $thisTbody = $(this).parent().parent().parent();
	            var rowLeng = $thisTbody.find("tr").length;


	            $(this).remove();
	            cloneRow.find("td:last").html(addBtns);
	            $thisTbody.find("tr:first-child th").attr("rowspan", rowLeng + 1);
	            $thisTbody.find("tr:last").before(cloneRow);

	            rowLeng++;
	            console.log(rowLeng);

	        });

	        $(".tbl").on("click", ".delBtn", function (e) {

	            e.preventDefault();

	            var $thisRow = $(this).parent().parent();
	            var $thisTbody = $(this).parent().parent().parent();
	            var rowLeng = $thisTbody.find("tr").length;


	            if (rowLeng <= 4) {

	                return;

	            } else {
	                $thisRow.remove();
	                $thisTbody.find("tr:first-child th").attr("rowspan", rowLeng - 1);

	                if (rowLeng == 5) {
	                    $thisTbody.find("tr:last").prev().find("td:last").html(addBtn);
	                } else {
	                    $thisTbody.find("tr:last").prev().find("td:last").html(addBtns);
	                }

	                rowLeng--;

	            }

	            console.log(rowLeng);

	        });
	    }


	    return {
	        init: _init
	    }
	})();

    // fileStyle function
	app.namespace("fileStyle");
	app.fileStyle = (function () {
	    var _init = function () {
	        var fileTarget = $('.filebox .upload-hidden');
	        fileTarget.on('change', function () { // 값이 변경되면
	            if (window.FileReader) { // modern browser
	                var filename = $(this)[0].files[0].name;
	            } else { // old IE var
	                filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출
	            }
	            // 추출한 파일명 삽입
	            $(this).siblings('.upload-name').val(filename);
	        });
	    };
	    return {
	        init: _init
	    }
	})();

    // fileStyle function
	app.namespace("btnHover");
	app.btnHover = (function () {
	    var _init = function () {
	        $btnHoverlist = $(".upload_list").find("li");
	        $btnHoverlist.on('mouseenter mouseleave', function (e) {
	            switch (e.type) {
	                case 'mouseenter':
	                case 'focusin':
	                    $(this).addClass("hover");
	                    $(this).find(".hover_btn").show();
	                    break;
	                case 'focusout':
	                case 'mouseleave':
	                    $(this).find(".hover_btn").hide();
	                    $(this).removeClass("hover");
	                    break;
	            }
	        });

	    };
	    return {
	        init: _init
	    }
	})();


    // 파일 추가/삭제/초기화
	app.namespace("fileControl");
	app.fileControl = (function () {
	    var maxFile = 4;
	    var $fileControl = $(".file_control");
	    var $fileBox = $(".file_control .style_file");
	    var $btnAdd = $("button.add");
	    var $btnRemove = $("button.remove");
	    var cloneFile = $(".file_control .style_file .input_file").clone();

	    var fileleng = $fileBox.length;
	    var count = 1;

	    var _init = function () {
	        $btnAdd.on("click", function (e) {
	            e.preventDefault();

	            var html = "<div class='style_file' style='width:60%;'><label><span></span><input type='file' name='uploadMms" + count + "' class='input_file'/><button type='button' class='btn_file'>파일찾기</button><button class='btn del small full_gray'></button></label></div>";

	            if (fileleng <= maxFile) {
	                count++;

	                $fileControl.append(html);
	                $btnRemove.fadeIn();
	                fileleng++;
	                console.log(fileleng);

	            } else {
	                alert("최대 5개까지만 추가 가능합니다.");
	            }

	            return false;

	        });

	        $btnRemove.on("click", function (e) {
	            e.preventDefault();

	            if (fileleng > 1) {
	                count--;

	                $fileControl.find(".style_file:last").remove();

	                fileleng--;
	                console.log(fileleng);

	                if (fileleng == 1) {
	                    $btnRemove.fadeOut();
	                }

	            }

	            return false;

	        });

	        $(".tbl").on("click", "button.del", function (e) {
	            e.preventDefault();

	            $(this).siblings(".input_file").val("");
	            $(this).siblings("span").text("");


	        });
	    }


	    return {
	        init: _init
	    }
	})();

})(MYAPP||{}, jQuery);
//------------------------MYAPP 종료------------------------------
