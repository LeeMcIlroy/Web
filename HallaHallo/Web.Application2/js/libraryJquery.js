String.prototype.trim = function () {
    return $.trim(this);
}


$.fn.extend({
    appendVal: function (text) {
        return $(this).val($(this).val() + text);
    }
});

$.fn.extend({
    cutTail: function (len) {
        return $(this).val($(this).val().substring(0, $(this).val().length - len));
    }
});

$.fn.extend({
    startWith: function (key, text) {
        var result = false;
        if ($(this).attr(key).length >= text.length) {
            result = ($(this).attr(key).substring(0, text.length) == text);
        }

        return result;
    }
});


$.fn.extend({
    htmlex: jQuery.fn["html"]
});

jQuery.fn["html"] = function (html) {
    if (html) {
        this.htmlex(html);
        this.find("input").not("[maxlength]").attr("maxlength", 100);
  
        this.find("[name],[f-validate]").each(function () {
            if ($(this).parents(".template").length > 0) return;
            new _library.Property($(this));
        });
        return this;
    }
    else {
        return this.htmlex();
    }
};

jQuery.fn["focus"] = function (fn) {
    return fn ? this.bind("focus", fn) : this.each(function () {
        this.focus();
    });
};

//jQuery.extend({
//    FromXMLString: function (strXML) {
//        if (window.DOMParser) {
//            return jQuery(new DOMParser().parseFromString(strXML, "text/xml"));
//        } else if (window.ActiveXObject) {
//            var doc = new ActiveXObject("Microsoft.XMLDOM");
//            doc.async = "false";
//            doc.loadXML(strXML);
//            return jQuery(doc);
//        } else {
//            return jQuery(strXML);
//        }
//    }
//});

jQuery.extend({
    postSync: function (url, data, type) {
        var rtn = null;
        if (type == null) type = 'text';
        $.ajax({
            url: url,
            type: 'POST',
            async: false,
            data: data,
            dataType: type,
            success: function (text) {
                rtn = text;
            },
            error: function (text) {
            }
        });
        return rtn;
    }
});

jQuery.extend({
    getSync: function (url, data, type) {
        var rtn = null;
        if (type == null) type = 'text';
        $.ajax({
            url: url,
            type: 'GET',
            async: false,
            data: data,
            dataType: type,
            success: function (text) {
                rtn = text;
            },
            error: function (text) {
            }
        });
        return rtn;
    }
});

jQuery.extend({
    queryURL: function (id) {
        var data = location.href.split('?');
        if (data.length < 2) return null;
        var queryitem = data[1].split('&');
        for (var i = 0; i < queryitem.length; i++) {
            var t = queryitem[i].split('=');
            if (t[0].toLowerCase() == id.toLowerCase()) {
                return t[1].split('#')[0];
            }
        }
        return null;
    }
});

$.fn.extend({
    cdata: function (val) {
        this.each(function () {
            $(this).empty();
            var data = this.ownerDocument.createCDATASection(val);
            this.appendChild(data);

        });

        return this;
    }
});

$.fn.extend({
    xml: function () {
        var x_string = "";
        if (this.each != undefined) {
            this.each(function () {
                if (window.DOMParser) { // Standard
                    x_string += (new XMLSerializer()).serializeToString(this) + "\n";
                } else { // IE
                    x_string += this.xml + "\n";
                }
            });
        }
        return x_string;
    }
});

$.fn.extend({
    fval: function (val, convertHTML) {

        if (val == null) {
            var rtn = '';
            this.each(function () {
                if (this.tagName == 'INPUT' || this.tagName == 'SELECT') {
                    rtn += $(this).val();
                }
                else {
                    rtn += $(this).text();
                }

            });

            return rtn;
        }
        else {
            this.each(function () {
                if (convertHTML) {
                    $(this).html(val.replace(/\n/g, '<br />'));
                }
                else {
                    var tag = this.tagName;
                    if (tag == 'INPUT' || tag == 'TEXTAREA' || tag == 'SELECT') {
                        var type = $(this).attr('type');
                        if (type == 'MONEY') {
                            val = val.toString().toMoney();
                        }

                        $(this).val(val);
                    }
                    else {
                        $(this).text(val);
                    }
                }
            });

            return this;
        }

    }
});



$.fn.reverse = [].reverse;


$.fn.rowspan = function (colIdx, isStats) {
    return this.each(function () {
        var that;
        $('tr', this).each(function (row) {
            $('td:eq(' + colIdx + ')', this).filter(':visible').each(function (col) {
                if ($(this).hasClass("non-span")) return;
                if ($(this).html() == $(that).html()
					&& (!isStats
							|| isStats && $(this).prev().html() == $(that).prev().html()
							)
					) {
                    rowspan = $(that).attr("rowspan") || 1;
                    rowspan = Number(rowspan) + 1;

                    $(that).attr("rowspan", rowspan);
        
                    $(this).hide();

                    //$(this).remove(); 

                } else {
                    that = this;
                }

                that = (that == null) ? this : that;
            });
        });
    });
};


$.fn.colspan = function (rowIdx) {
    return this.each(function () {

        var that;
        $('tr', this).filter(":eq(" + rowIdx + ")").each(function (row) {
            $(this).find('th').filter(':visible').each(function (col) {
                if ($(this).html() == $(that).html()) {
                    colspan = $(that).attr("colSpan") || 1;
                    colspan = Number(colspan) + 1;

                    $(that).attr("colSpan", colspan);
                    $(this).hide(); // .remove();
                } else {
                    that = this;
                }

                that = (that == null) ? this : that;

            });
        });
    });
}

$.fn.bindSelect = function (dt, text, value, head) {
    return this.each(function () {
        var el = this;
        if (el.tagName != "SELECT") return;

        var start = head ? 1 : 0;
        el.options.length = start;

        if (head == null) {
            head = true;
        }

        if (head) {
            if (typeof (head) == "boolean") {
                head = "---SELECT---";
            }
            el.options[0].text = head;
            el.options[0].value = "";
        }

        el.options.length = dt.length + start;
        for (var i = 0; i < dt.length; i++) {
            el.options[i + start].text = dt[i][text];
            el.options[i + start].value = dt[i][value];
        }

        el = $(el);
        if (el.attr("multiple") != null) {
            var width = parseInt(el.css("width"));
            if (width == 0) {
                width = "auto";
            }

            if (el.find("option:first").val() == "") {
                el.find("option:first").remove();
            }

            el.find("option").each(function () {
                if ($(this).attr("value") == undefined) {
                    $(this).attr("value", this.value);
                }
            })

            el.multiselect('reload');

            var columns = el.data('columns');
            if (columns == null || columns == '') columns = 1;

            el.multiselect(options);
            el.next().css("width", width);
            el.next().find("button:first").css("width", width);
            var width = el.width();
            if (width < 150) width = 150;
            el.next().find(".ms-options:first").css("left", "auto");
            el.next().find(".ms-options:first").css("overflow", "visible");
            el.next().find(".ms-options:first").css("overflow-y", "scroll");
            el.next().find(".ms-options:first").css("width", width * columns);

        }
        
    });
}

$.fn.extend({

    datePick: function (options) {
        return this.each(function () {
            var obj = $(this);

            obj.datepicker(options);
            obj.css('margin-right', '3px');
        });
    },
    
    /*
        텍스트박스 Comment 설정
        options.commentType = text | image
        options.attrName = "Comment"
    */
    comment: function (options) {

        var defaults = {
            commentType: 'text',
            attrName: 'Comment',
            onFocus: null,
            onBlur: null
        };

        var options = $.extend(defaults, options);

        return this.each(function () {
            var obj = $(this);

            obj.unbind('focus').unbind('blur');

            if (options.commentType == 'text') {
                obj.focus(function () {
                    obj.textFocus(options.attrName, options.onFocus);
                }).blur(function () {
                    obj.textBlur(options.attrName, options.onBlur);
                });

                obj.textBlur(options.attrName, options.onBlur);
            }

            if (options.commentType == 'image') {
                obj.focus(function () {
                    obj.imageFocus(options.attrName, options.onFocus);
                }).blur(function () {
                    obj.imageBlur(options.attrName, options.onBlur);
                });

                obj.imageBlur(options.attrName, options.onBlur);
            }
        });
    },
    textFocus: function (attrName, onFocus) {
        return this.each(function () {
            var obj = $(this);

            if (obj.val() == obj.attr(attrName)) {
                obj.val('');
            }

            if (onFocus)
                onFocus.apply(obj, arguments);
        });
    },
    textBlur: function (attrName, onBlur) {
        return this.each(function () {
            var obj = $(this);

            if (!obj.val()) {
                obj.val(obj.attr(attrName));
            }

            if (onBlur)
                onBlur.apply(obj, arguments);
        });
    },
    imageFocus: function (attrName, onFocus) {
        return this.each(function () {
            var obj = $(this);

            obj.css('background', '');

            if (onFocus)
                onFocus.apply(obj, arguments);
        });
    },
    imageBlur: function (attrName, onBlur) {
        return this.each(function () {
            var obj = $(this);

            if (!obj.val()) {
                obj.css('background', obj.attr(attrName));
            }

            if (onBlur)
                onBlur.apply(obj, arguments);
        });
    },

    /*
        input 에 수자만 입력가능하게 처리
    */
    numberOnly: function (options) {

        var defaults = {
            isDouble: false
        };

        var options = $.extend(defaults, options);

        return this.each(function () {
            var obj = $(this);

            obj.unbind('keydown');

            obj.keydown(function () {
                // f5
                if (event.keyCode == 116) {
                    return;
                }

                // dot
                if (options.isDouble && (event.keyCode == 46 || event.keyCode == 190)) {
                    return;
                }

                // backspace, delete, tab, escape, and enter
                if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 13 ||
                    // Ctrl+A
                    (event.keyCode == 65 && event.ctrlKey === true) ||
                    // home, end, left, right
                    (event.keyCode >= 35 && event.keyCode <= 39)) {
                    return;
                }
                else {
                    // Ensure that it is a number and stop the keypress
                    if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105)) {
                        if (event.preventDefault)
                            event.preventDefault();
                        else
                            event.returnValue = false;
                    }
                }
            })
        });
    }
});

$.safeSplit = function (value, separator, index) {
    var valueAry = value.split(separator);
    if (valueAry.length < index + 1) return '';

    return valueAry[index];
}

