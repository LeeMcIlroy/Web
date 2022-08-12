var _library = {}
_library.PopupObject = {}
_library.PopupCount = 0;
_library.Popup = function (url, name, args, width, height, options) {
    _library.PopupCount++;

    this.Url = url;
    this.Name = name;
    this.Args = args;
    this.Width = width;
    this.Height = height;
    this.Help = "no";
    this.Menubar = "no";
    this.Toolbar = "no";
    this.Directories = "no";
    this.Scrollbars = options == null ? "no" : options.indexOf("Scrollbars") > -1 ? "yes" : "no";
    this.Status = "no";
    this.Location = "no";
    this.Resizable = "no";

    this.Left = null;
    this.Top = null;

    this.Window = null;
    this.Open = function (modal) {
        if (this.Left == null) {
            this.Left = (window.screen.width / 2) - (this.Width / 2);
        }
        if (this.Top == null) {
            this.Top = (window.screen.height / 2) - (this.Height / 2);
        }

        if (modal) {
            var features = "dialogwidth=" + this.Width + "px";
            features += ";dialogheight=" + this.Height + "px";
            features += ";dialogtop=" + this.Top + "px";
            features += ";dialogleft=" + this.Left + "px";
            features += ";help=" + this.Help;
            features += ";scroll=" + this.Scrollbars;
            features += ";status=" + this.Status;
            features += ";resizable=" + this.Resizable;

            if (this.Window == null) {
                Window = window.showModalDialog(this.Url, this.Args, features);
                return Window;
            }
            else {
                return this.Window.showModalDialog(this.Url, this.Args, features);
            }
        }
        else {
            var features = "width=" + this.Width + "px";
            features += ",height=" + this.Height + "px";
            features += ",top=" + this.Top + "px";
            features += ",left=" + this.Left + "px";
            features += ",help=" + this.Help;
            features += ",menubar=" + this.Menubar;
            features += ",toolbar=" + this.Toolbar;
            features += ",directories=" + this.Directories;
            features += ",scrollbars=" + this.Scrollbars;
            features += ",status=" + this.Status;
            features += ",location=" + this.Location;
            features += ",resizable=" + this.Resizable;

            if (this.Name == null || this.Name == '') {
                this.Name = 'Popup' + _library.PopupCount;
            }
            _library.PopupObject[this.Name] = this;
            if (this.Window == null) {
                this.Window = window.open(this.Url, this.Name, features);
            }
            else {
                return this.Window.open(this.Url, this.Name, features);
            }

            return this.Window;

        }


    }

}
_library.OpenPopup = function (url, name, args, width, height, options) {
    var popup = new _library.Popup(url, name, args, width, height, options);
    return popup.Open();
}

_library.OpenModalPopup = function (url, name, args, width, height, options) {
    var popup = new _library.Popup(url, name, args, width, height, options);
    return popup.Open(true);
}

_library.BindSelect = function (el, dt, text, value, head) {
    var start = head ? 1 : 0;
    el.options.length = start;
    el.options.length = dt.length + start;
    for (var i = 0; i < dt.length; i++) {
        var t = "dt[i]." + text;
        el.options[i + start].text = eval(t);
        var v = "dt[i]." + value;
        el.options[i + start].value = eval(v);
    }
}

_library.HideModal = function (callback) {
    var shown = $(".modal.in");

    if (G_UploadID != undefined)
        DEXT5UPLOAD.SetPopupMode(0, G_UploadID);

    if (shown.length > 0) {
        if (callback != null) {
            shown.one('hidden.bs.modal', function (e) {
                callback();
            });
        }
        shown.find("[data-dismiss='modal']:first").click();
    }
    else {
        if (callback != null) callback();
    }
}

_library.ShowModal = function (target, callback) {
    _library.HideModal(function () {
        if (callback != null) {
            target.one('shown.bs.modal', function (e) {
                callback();
            });
        }

        var left = ($("body").width() - target.width()) / 2;
        target.css({ "left": left });
        target.modal("show");

        if (G_UploadID != undefined)
            DEXT5UPLOAD.SetPopupMode(1, G_UploadID);
    });
}


var _prcessing = false;
_library.LockProcess = function () {
    if (!_prcessing) {
        _prcessing = true;
        return true;
    }

    return false;
}
_library.ReleaseProcess = function () {
    _prcessing = false;
}



_library.ShowLayer = function (layer, target, wrap){
    
    if (layer.is(":visible")) {
        layer.hide();
        return;
    }
    var width = parseInt(layer.css("width"), 10);
    var rect = target[0].getBoundingClientRect();
    if (wrap == null) wrap = $(document);
    var left = rect.left + wrap.scrollLeft();
    if (left > 300) {
        left = rect.right - width;
    }

    layer.css("left", left + "px");
    layer.css("top", (rect.bottom + wrap.scrollTop() + 2) + "px");
    layer.show();
}



_library.ExtractNumber = function (str, noparse) {
    str = str.replace(/[^0-9\.\+\-]/ig, '');
    var sign = '';
    if (str[0] == '+' || str[0] == '-') {
        sign = str[0];
    }
    str = sign + str.replace(/[\-\+]/ig, '');
    var data = str.split('.');
    if (data.length > 1) {
        str = data[0] + ".";
        for (var i = 1; i < data.length; i++) {
            str += data[i];
        }
    }
    else {
        if (noparse) {
            
        }
        else {
            str = parseInt(str, 10);
        }
        
    }
    if (isNaN(str)) str = "";
    return str + "";
}

_library.CheckNumberKey = function (e) {
    if (e.altKey || e.ctrlKey) return true;
    if ((e.keyCode >= 48 && e.keyCode <= 57) || e.keyCode == 46 || e.keyCode == 8 || e.keyCode == 9 ||
        (e.keyCode >= 33 && e.keyCode <= 40) || (e.keyCode >= 96 && e.keyCode <= 105) ||
        e.keyCode == 190 || e.keyCode == 110 || e.keyCode == 107 || e.keyCode == 109 || e.keyCode == 189 || e.keyCode == 190) return true;

    return false;
}
_library.ConvertDate = function (datestring) {
    var now = new Date();

    var val = datestring.replace(/[^0-9]+/g, '-').replace(/[\s]*/, '');

    if (val == "-") {
        val = now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + now.getDate();
    }

    var info = val.split('-');

    if (info.length < 3) {
        if (info.length == 2) {
            if (info[1].length == 4) {
                val = info[0] + "-" + info[1].substring(0, 2) + "-" + info[1].substring(2, 4);
            }
            else {
                val = now.getFullYear() + "-" + val;

            }
        }
        else if (info.length == 1) {
            if (info[0].length >= 8) {
                var y = info[0].substring(0, 4);
                var m = info[0].substring(4, 6);
                var d = info[0].substring(6, 8);
                val = y + "-" + m + "-" + d;
            }
            else if (info[0].length == 6) {
                var y = info[0].substring(0, 2);
                if (y < "40") y = "20" + y;
                else y = "19" + y;
                var m = info[0].substring(2, 4);
                var d = info[0].substring(4, 6);
                val = y + "-" + m + "-" + d;
            }
            else if (info[0].length == 4) {
                var y = now.getFullYear()
                var m = info[0].substring(0, 2);
                var d = info[0].substring(2, 4);
                val = y + "-" + m + "-" + d;
            }
            else {
                val = now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + val;

            }
        }
    }

    info = val.split('-');
    info[0] = info[0].toString().digits(4);
    info[1] = info[1].toString().digits(2);
    info[2] = info[2].toString().digits(2);

    var date = info[0] + "-" + info[1] + "-" + info[2];

    return date;
}

_library.ConvertDateUTC = function (datestring) {
    var now = new Date();
    var val = datestring.replace(/[^0-9]+/g, '-').replace(/[\s]*/, '');

    if (val == "-") {
        val = now.getUTCFullYear() + "-" + (now.getUTCMonth() + 1) + "-" + now.getUTCDate();
        //return "";

    }

    var info = val.split('-');

    if (info.length < 3) {
        if (info.length == 2) {
            if (info[1].length == 4) {
                val = info[0] + "-" + info[1].substring(0, 2) + "-" + info[1].substring(2, 4);
            }
            else {
                val = now.getUTCFullYear() + "-" + val;

            }
        }
        else if (info.length == 1) {
            if (info[0].length >= 8) {
                var y = info[0].substring(0, 4);
                var m = info[0].substring(4, 6);
                var d = info[0].substring(6, 8);
                val = y + "-" + m + "-" + d;
            }
            else if (info[0].length == 6) {
                var y = info[0].substring(0, 2);
                if (y < "40") y = "20" + y;
                else y = "19" + y;
                var m = info[0].substring(2, 4);
                var d = info[0].substring(4, 6);
                val = y + "-" + m + "-" + d;
            }
            else if (info[0].length == 4) {
                var y = now.getUTCFullYear()
                var m = info[0].substring(0, 2);
                var d = info[0].substring(2, 4);
                val = y + "-" + m + "-" + d;
            }
            else {
                val = now.getUTCFullYear() + "-" + (now.getUTCMonth() + 1) + "-" + val;

            }
        }
    }

    info = val.split('-');
    info[0] = info[0].toString().digits(4);
    info[1] = info[1].toString().digits(2);
    info[2] = info[2].toString().digits(2);

    var date = info[0] + "-" + info[1] + "-" + info[2];
    return date;
}

_library.isValidTime2 = function (time) {
    try {
        var year = time.substring(0, 4);
        var month = time.substring(4, 6);
        var day = time.substring(6, 8);
        if (parseInt(year, 10) >= 1900 && _library.isValidMonth(month) &&
            _library.isValidDay(year, month, day)) {
            return true;
        }
    }
    catch (e) {
        return false;
    }
    return false;
}

_library.isValidTime = function (time) {
    time = time.replace(/[^0-9]+/g, '').replace(/[\s]*/, '');
    if (time.length != 8) return false;
    return _library.isValidTime2(time);
}
_library.isValidMonth = function (mm) {
    var m = parseInt(mm, 10);
    return (m >= 1 && m <= 12);
}


_library.isValidDay = function (yyyy, mm, dd) {
    var m = parseInt(mm, 10) - 1;
    var d = parseInt(dd, 10);

    var end = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
    if ((yyyy % 4 == 0 && yyyy % 100 != 0) || yyyy % 400 == 0) {
        end[1] = 29;
    }

    return (d >= 1 && d <= end[m]);
}


_library.HandleSelectRow = function (target, toggle) {
    if (toggle == null) toggle = true;
    if (toggle) {
        if (target.hasClass("selected")) {
            target.removeClass("selected")
        }
        else {
            var parent = target.parent();
            parent.find(".selected").removeClass("selected");
            target.addClass("selected")
        }
    }
    else {
        var parent = target.parent();
        parent.find(".selected").removeClass("selected");
        target.addClass("selected")
    }

}

_library.GetSequence = function (count) {
    if (count == null) count = 1;
    var result = $.postSync(_config.AppPath + 'Default/Sequence', { count: count });
    return result;
}

_library.SwitchPage = function (url) {
    var frmContents = parent.$("#frmContents")
    var frmBackground = parent.$("#frmBackground")

    frmContents.attr("data-url", location.pathname.toLowerCase());
    frmBackground[0].contentWindow.history.pushState({}, "", frmContents.attr("src"));
    frmBackground.attr("src", url);

    $('#_ajax_loading').removeClass('display-none');

    var timer = setInterval(function () {
        if (frmBackground[0].contentWindow.document.readyState == 'complete') {
            $('#_ajax_loading').addClass('display-none');
            clearInterval(timer);
        }
        else {
            return;
        }

        frmBackground.show();
        frmBackground.attr("id", "frmContents");

        frmContents.hide();
        frmContents.attr("id", "frmBackground");
    },100);
}


_library.RestorePage = function (url,restore) {
    var frmContents = parent.$("#frmContents")
    var frmBackground = parent.$("#frmBackground")

    var backPageUrl = frmBackground.attr("data-url");
    if (backPageUrl == url.toLowerCase()) {
        frmBackground.show();
        frmBackground.attr("id", "frmContents");

        frmContents.hide();
        frmContents.attr("src", "/App/Blank");
        frmContents.attr("id", "frmBackground");

        restore(frmBackground);
    }
    else {
        location.href = url;
    }
    
}
