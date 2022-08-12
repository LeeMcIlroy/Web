if (window.console === undefined) {
    window.console = {}
    window.console.log = function () { }
    window.console.info = function () { }
    window.console.warn = function () { }
    window.console.error = function () { }
    window.console.fatel = function () { }
}
Number.prototype.padLeft = function (n, str) {
    return (this < 0 ? '-' : '') +
        Array(n - String(Math.abs(this)).length + 1)
            .join(str || '0') +
        (Math.abs(this));
}


String.prototype.toPascalCase = function () {
    return this[0].toUpperCase() + this.substring(1);
}
String.prototype.removeTrim = function () {
    return this.split(' ').join('');
}


String.prototype.toMoney = function () {
    return this.convert("3");
}

Number.prototype.toMoney = function () {
    return this.toString().convert("3");
}

String.prototype.convert = function (format) {
    var str = this.toString().replace(/,/gi, "");
    var reg = /(^[+-]?\d+)(\d{3})/;
    var n = str;
    while (reg.test(n)) {
        n = n.replace(reg, '$1' + ',' + '$2');
    }

    if (n == 'NaN') n = '';
    return n;
}

String.prototype.digits = function (len) {
    var num = "";
    if (this.length < len) {
        for (var i = 0; i < len - this.length; i++) {
            num += "0";
        }
    }
    return num + this;
}

String.prototype.startsWith = function (str) {
    if (this.length < str.length) { return false; }
    return this.indexOf(str) == 0;
}

String.prototype.endsWith = function (str) {
    if (this.length < str.length) { return false; }
    return this.lastIndexOf(str) + str.length == this.length;
}



//array for 구문에서 오류 발생
//Array.prototype.isArray = function (arg) {
//    return Object.prototype.toString.call(arg) === '[Object Array]';
//}

String.prototype.Trim = function () {
    return this.replace(/(^\s*)|(\s*$)/gi, "");
}

String.prototype.toInt = function () {
    var val = this.trim();
    if (val == "")
        return 0;

    if (!isNaN(val))
        return parseInt(val);

    var DotPoint = val.indexOf('.');
    if (DotPoint > 0)
        val = val.substring(0, DotPoint);
    val = val.replace(/[^0-9]/g, "");
    if (val == "")
        return 0;
    return val * 1;
}

String.prototype.toFloat = function (length) {
    var val = this.trim().replace(/[^0-9.]/g, "");
    if (val == "")
        return 0.0;

    var point = val.indexOf('.');
    if (point == -1)
        return val * 1.0;

    if (length) {
        var decimal = val.substring(point + 1);
        var pointSecond = decimal.indexOf('.');
        if ((pointSecond == -1) || (pointSecond > length)) {
            return val.substring(0, (point + length + 1)) * 1.0;
        } else {
            return val.substring(0, (point + pointSecond + 1)) * 1.0;
        }
    } else {
        if (!isNaN(this))
            return parseFloat(this);
        var decimal = val.substring(point + 1);
        var pointSecond = decimal.indexOf('.');
        if (pointSecond == -1)
            return val * 1.0;
        return val.substring(0, (point + pointSecond + 1)) * 1.0;
    }
}


String.prototype.toFloor = function (d) {
    return this.toFloat(d);
    if (d == 0) {
        return Math.floor(number);
    } else {
        d = Math.pow(10, d);
        number += 0.000000000000001;
        return Math.floor(number * d) / d;
    }
}


String.prototype.toRound = function (d) {
    return this.toFloat().toRound(d);
}

String.prototype.toCeil = function (d) {
    return this.toFloat().toCeil(d);
}

Number.prototype.toFloor = function (d) {
    if (d == 0) {
        return Math.floor(this);
    } else {
        d = Math.pow(10, d);
        var number = this + 1e-10;
        return Math.floor(number * d) / d;
    }
}

Number.prototype.toRound = function (d) {
    if (d == 0) {
        return Math.round(this);
    } else {
        d = Math.pow(10, d);
        return Math.round(this * d) / d;
    }
}

Number.prototype.toCeil = function (d) {
    if (d == 0) {
        return Math.ceil(this);
    } else {
        d = Math.pow(10, d);
        return Math.ceil(this * d) / d;
    }
}

if (Array.prototype.indexOf === undefined) {
    Array.prototype.indexOf = function (str) {
        for (var p in this) {
            if (this[p] == str) {
                return p;
            }
        }

        return -1;
    }
}

String.prototype.replaceAll = function (oldstr, newstr) {
    re = eval("/" + oldstr + "/gi");
    return this.replace(re, newstr);
}



if (String.prototype.endsWith === undefined) {
    String.prototype.endsWith = function (suffix) {
        return this.indexOf(suffix, this.length - suffix.length) !== -1;
    };
}



var dateDiff = function (datePart, from, to) {
    var NewDate = function (str) {
        str = str.split('-');
        if (0 < str[1] && str[1] <= 12 && checkDate(str)) {
            var date = new Date();
            date.setUTCFullYear(str[0], str[1] - 1, str[2]);
            date.setUTCHours(0, 0, 0, 0);

            return date;
        }
        return 'NaN';
    }

    var checkDate = function (str) {
        var tempDate = new Date(str[0], str[1], 0);
        var endDay = tempDate.getDate();

        if (0 < str[2] && str[2] <= endDay) {
            return true;
        }

        return false;
    }

    datePart = datePart.toLowerCase();

    //yyyy-MM-dd
    //var fromDate = new Date(from);
    //var toDate = new Date(to);
    if (from != "" && to != "" && from.length == 10 && to.length == 10) {
        var fromDate = NewDate(from);
        var toDate = NewDate(to);
        var diff = toDate.getTime() - fromDate.getTime();
        var divideBy = {
            w: 604800000,
            d: 86400000,
            h: 3600000,
            m: 60000,
            s: 1000
        };

        return Math.floor(diff / divideBy[datePart]);
    }
    else
        return;
}


function tableRowSpan(target, index, union) {
    var rowSpanTd = false;
    var rowSpanText = false;
    var rowSpanCount = 0;

    $.each(target, function (i) {
        var This = target.eq(i).find("td").eq(index);
        var ThisText = $(This).text();

        if (rowSpanTd == false) {
            rowSpanTd = This;
            rowSpanText = ThisText;
            rowSpanCount = 1;
        }
        else if (rowSpanText != ThisText) {
            $(rowSpanTd).attr("rowSpan", rowSpanCount);

            rowSpanTd = This;
            rowSpanText = ThisText;
            rowSpanCount = 1;
        }
        else {
            switch (union.toLowerCase()) {
                case "blank":
                    if ($.trim(ThisText) == "") {
                        $(This).remove();
                        rowSpanCount++;
                    }
                    break;
                case "text":
                    if ($.trim(ThisText) != "") {
                        $(This).remove();
                        rowSpanCount++;
                    }
                    break;
            }
        }
    });

    $(rowSpanTd).attr("rowSpan", rowSpanCount);
}

function tableColSpan(target, index, union, isDivision) {
    var colSpanTd = false;
    var colSpanText = false;
    var colSpanCount = 1;

    $.each(target, function (i) {
        var This = target.eq(i).find("td").eq(index);
        var ThisText = $(This).text();

        $.each(target.eq(i).find("td"), function (j) {
            colNextIndex = index + 1;
            colSpanTd = target.eq(i).find("td").eq(colNextIndex);
            colSpanText = $(colSpanTd).text();

            if (colSpanTd == false) {
                colSpanTd = This;
                colSpanText = ThisText;
                colSpanCount = 1;
                return false;
            }
            else {
                switch (union.toLowerCase()) {
                    case "blank":
                        if ($.trim(ThisText) == "") {
                            colSpanTd = This;
                            colSpanText = ThisText;
                            colSpanCount = 1;
                            return false;
                        }
                        else if ($.trim(ThisText) != "" && $.trim(colSpanText) == "") {
                            $(colSpanTd).remove();
                            colSpanCount++;
                        }
                        break;
                }
            }

            if ($.trim(colSpanText) != "")
                return false;
        });

        $(This).attr("colSpan", colSpanCount);

        if (isDivision == true)
            colSpanCount = 1;
    });
}

function arrayRemoveAt(array, index) {
    array.splice(index, 1);
}

function GetRandomASCIICode2Char() {
    return String.fromCharCode(parseInt(((Math.random() * 26) + 65)))
}

function WriteError(content, category) {
    $.post(_config.AppPath + "Log/WriteError", { content: content, category: category });
}


function CheckActiveX(progID) {
    try {
        var obj = new ActiveXObject(progID);
        if (obj)
            return obj;
        else
            ret = null;
    }
    catch (e) {
        ret = null;
    }
    return ret;
}


//
//Base64 코덱 클랙스
//
var Base64 = {

    // private property
    _keyStr: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",

    // public method for encoding
    encode: function (input) {
        var output = "";
        var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
        var i = 0;

        input = Base64._utf8_encode(input);

        while (i < input.length) {

            chr1 = input.charCodeAt(i++);
            chr2 = input.charCodeAt(i++);
            chr3 = input.charCodeAt(i++);

            enc1 = chr1 >> 2;
            enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
            enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
            enc4 = chr3 & 63;

            if (isNaN(chr2)) {
                enc3 = enc4 = 64;
            } else if (isNaN(chr3)) {
                enc4 = 64;
            }

            output = output +
			this._keyStr.charAt(enc1) + this._keyStr.charAt(enc2) +
			this._keyStr.charAt(enc3) + this._keyStr.charAt(enc4);

        }

        return output;
    },

    // public method for decoding
    decode: function (input) {
        var output = "";
        var chr1, chr2, chr3;
        var enc1, enc2, enc3, enc4;
        var i = 0;

        input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");

        while (i < input.length) {

            enc1 = this._keyStr.indexOf(input.charAt(i++));
            enc2 = this._keyStr.indexOf(input.charAt(i++));
            enc3 = this._keyStr.indexOf(input.charAt(i++));
            enc4 = this._keyStr.indexOf(input.charAt(i++));

            chr1 = (enc1 << 2) | (enc2 >> 4);
            chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
            chr3 = ((enc3 & 3) << 6) | enc4;

            output = output + String.fromCharCode(chr1);

            if (enc3 != 64) {
                output = output + String.fromCharCode(chr2);
            }
            if (enc4 != 64) {
                output = output + String.fromCharCode(chr3);
            }

        }

        output = Base64._utf8_decode(output);

        return output;

    },

    // private method for UTF-8 encoding
    _utf8_encode: function (string) {
        string = string.replace(/\r\n/g, "\n");
        var utftext = "";

        for (var n = 0; n < string.length; n++) {

            var c = string.charCodeAt(n);

            if (c < 128) {
                utftext += String.fromCharCode(c);
            }
            else if ((c > 127) && (c < 2048)) {
                utftext += String.fromCharCode((c >> 6) | 192);
                utftext += String.fromCharCode((c & 63) | 128);
            }
            else {
                utftext += String.fromCharCode((c >> 12) | 224);
                utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                utftext += String.fromCharCode((c & 63) | 128);
            }

        }

        return utftext;
    },

    // private method for UTF-8 decoding
    _utf8_decode: function (utftext) {
        var string = "";
        var i = 0;
        var c = c1 = c2 = 0;

        while (i < utftext.length) {

            c = utftext.charCodeAt(i);

            if (c < 128) {
                string += String.fromCharCode(c);
                i++;
            }
            else if ((c > 191) && (c < 224)) {
                c2 = utftext.charCodeAt(i + 1);
                string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
                i += 2;
            }
            else {
                c2 = utftext.charCodeAt(i + 1);
                c3 = utftext.charCodeAt(i + 2);
                string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
                i += 3;
            }

        }

        return string;
    }

}

function SetClientInfo() {
    if (_pageLogID == '' || _pageLogID == 0 || _pageLogID == '0' || _pageLogID == null) return;

    try {
        var uri = _config.AppPath + "Log/SetClientInfo?id=" + _pageLogID;
        var qry = uri;
        qry += "&app=" + window.navigator.appName;
        qry += "&platform=" + window.navigator.platform;
        qry += "&width=" + window.screen.width;
        qry += "&height=" + window.screen.height;
        qry += "&system=" + window.navigator.systemLanguage;
        qry += "&user=" + window.navigator.userLanguage;

        $(window).on("beforeunload", function () {
            $.get(_config.AppPath + "log/pageout", { "id": _pageLogID }, function (text, status) { });
            //document.write(" ");
        });

        $.get(qry, {}, function (text, status) { });

    }
    catch (e) {
        alert(e);
    }
}






function GetFileSize(size) {
    size = parseFloat(size);
    var unit = GetUnitSize(size) + "B";
    var dsize = size;
    var lunit = 1024;
    if (dsize > lunit) {
        unit = GetUnitSize(dsize / lunit) + "KB";
        lunit *= 1024;
    }
    if (dsize > lunit) {
        unit = GetUnitSize(dsize / lunit) + "MB";
        lunit *= 1024;
    }
    if (dsize > lunit) {
        unit = GetUnitSize(dsize / lunit) + "GB";
        lunit *= 1024;
    }
    return unit;
}

function GetUnitSize(size, isfix) {
    if (isfix == null) isfix = false;
    var asSize = size.toString().split('.');
    if (isfix) {
        if (asSize.length == 1) return asSize[0] + ".00";
        //asSize[1] = asSize[1].TrimEnd('0');
        var s = asSize[1].substr(0, 1);
        if (asSize[1].toString().length > 1) s += asSize[1].substr(1, 1);
        else s += "0";
        return asSize[0] + "." + s;
    }
    else {
        if (asSize.length == 1) return asSize[0];
        //asSize[1] = asSize[1].TrimEnd('0');
        var s = asSize[1].substr(0, 1);
        if (asSize[1].length > 1) s += asSize[1].substr(1, 1);

        return asSize[0] + "." + s;
    }
}


function execDaumPostcode() {

    new daum.Postcode({
        autoMapping: false,
        oncomplete: function (data) {
            var fullRoadAddr = data.roadAddress;
            var extraRoadAddr = '';

            if (data.bname !== '') {
                extraRoadAddr += data.bname;
            }

            if (data.buildingName !== '') {
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }

            if (extraRoadAddr !== '') {
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            if (fullRoadAddr !== '') {
                fullRoadAddr += extraRoadAddr;
            }

            $("#tbZip").val(data.postcode1 + data.postcode2);
            if (data.userSelectedType == "R") {
                $("#tbAddressMain").val(fullRoadAddr);
            }
            else {
                $("#tbAddressMain").val(data.jibunAddress);
            }
            $("#tbAddressSub").focus();
        }
    }).open();
}

function ShowDetailMvc(page, param) {
    var path = page + '?' + param
    _library.SwitchPage(path);
    return;
}

var StringBuilder = function () {
    this.buffer = new Array();
}


StringBuilder.prototype.Append = function (strValue) {
    this.buffer[this.buffer.length] = strValue;
}


StringBuilder.prototype.AppendFormat = function () {
    var count = arguments.length;
    if (count < 2) return "";
    var strValue = arguments[0];
    for (var i = 1; i < count; i++)
        strValue = strValue.replace("{" + (i - 1) + "}", arguments[i]);
    this.buffer[this.buffer.length] = strValue;
}


StringBuilder.prototype.Insert = function (idx, strValue) {
    this.buffer.splice(idx, 0, strValue);
}


StringBuilder.prototype.Replace = function (from, to) {
    for (var i = this.buffer.length - 1; i >= 0; i--)
        this.buffer[i] = this.buffer[i].replace(new RegExp(from, "g"), to);
}


StringBuilder.prototype.ToString = function () {
    return this.buffer.join("");
}

