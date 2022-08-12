$(function () {

    $("form").append("<input type='text' style='display:none; width:0px;height:0px;'/>");

    var html = '<div id="_ajax_loading" class="wrap-loading display-none"><div><img src="/HallaTube/images/loading.gif" /></div></div>';
    //$("body").append(html);

    var html = '<div id="_popup" class="wrap-loading display-none"><div></div></div>';
    //$("body").append(html);

    $(".popup-frame, #_popup").click(function (e) {
        if ($(e.target).parents(".popup").length == 0) {
            $("#_popup").addClass("display-none");
            $(".popup-frame").attr("src","");
            $(".popup-frame").hide();
        }
    })

    var _loading_count = 0;
    $.ajaxSetup({
        cache:false
        , beforeSend: function (xhr) {
            _loading_count++;
            if ($(document).data("ajax_loading_hide")) return;
            $('#_ajax_loading').show();
        }
        , complete: function () {
            _loading_count--;
            if (_loading_count == 0) {
                $('#_ajax_loading').hide();
            }
        }
    });

    $("form").submit(function (e) {
        var target = $(this).attr("target");
        if (target != null) {
            var iframe = $("iframe[name='" + target + "']")[0];
            var timer = setInterval(function (e) {
                if (iframe.contentWindow.document.readyState == 'interactive') {
                    clearInterval(timer);
                    _loading_count--;
                    if (_loading_count == 0) {
                        $("#_ajax_loading").hide();
                    }
                }
            }, 100);
        }
    });

    $.each(['show', 'hide'], function (i, ev) {
        var el = $.fn[ev];
        $.fn[ev] = function () {
            this.trigger(ev);
            return el.apply(this, arguments);
        };
    });

    $(document).on("click", "input:checkbox.all", function () {
        var checked = $(this).is(":checked");
        var target = $(this).attr("data-target");
        if (target == null) {
            var th = $(this).parents("th:first");
            var idx = th.index();
            var check = $(this).parents("table:first").find("tbody>tr td:nth-child(" + (idx + 1) + ") input:checkbox").not(":disabled");
            check.prop("checked", checked);
            check.change();
        }
        else {
            var check = $(target);
            if (check.length > 0) {
                if (check.is(":checkbox") && check[0].tagName == "INPUT") {

                }
                else {
                    check = $(target).find("input:checkbox")
                }
            }
            check = check.not(":disabled");
            check.prop("checked", checked);
            check.change();
        }
    });


    $.datepicker.setDefaults($.datepicker.regional["ko"]);
    $.datepicker.setDefaults({
        changeMonth: true,
        changeYear: true,
        showOn: "both",
        dateFormat: "yy-mm-dd"
    });

    $("input").not("[maxlength]").attr("maxlength", 100);

    $("[name],[f-name],[f-validate]").each(function () {
        if ($(this).parents(".template").length > 0) return;
        new _library.Property($(this));
    });




});


