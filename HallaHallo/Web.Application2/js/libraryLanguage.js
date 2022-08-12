var _text = function () {
    var _resource = $.getSync(_config.AppPath+"js/libraryLanguageData.json", null, 'json');

    var order = {
        "KOR": 0,
        "ENG": 1,
        "CHN": 2,
        "JPN": 3,
        "ETC": 4
    };
    var languageType = 'KOR';
    //if (window._user != null && _user.Language != null) languageType = _user.Language;

    this.get = function (code, data, lang) {
        if (typeof (data) != "object") lang = data;//함수중첩구현
        if (lang == null) lang = languageType;

        if (_resource[code] == null) {
            console.warn(code + ": 텍스트가 정의되지 않았습니다.");
            return code;
        }
        var rtn = _resource[code][order[lang]];
        if (rtn == null) {
            console.warn(code + ":" + lang + ": 텍스트가 정의되지 않았습니다.");
            return code;
        }

        if (data != null) {
            var matches = rtn.match(/\[[^\]]+\]/ig);
            for (var p in matches) {

                try {
                    var m = matches[p];

                    var name = m.substring(1, m.length - 1);
                    var info = name.split(',');
                    var word = data[info[0]];
                    if (word == null) {
                        console.warn(code + ": 텍스트에 " + info[0] + ":가 입력되지 않았습니다.");
                        word = info[0];
                    }
                    var post = info.length == 1 ? "" : info[1];
                    if (lang == "KOR") {
                        if (this.hasFinal(word)) {
                            switch (post) {
                                case "를":
                                    post = "을";
                                    break;
                                case "가":
                                    post = "이";
                                    break;
                                case "는":
                                    post = "은";
                                    break;
                                case "와":
                                    post = "과";
                                case "로":
                                    post = "으로";
                                    break;
                            }
                        }
                        else {
                            switch (post) {
                                case "을":
                                    post = "를";
                                    break;
                                case "이":
                                    post = "가";
                                    break;
                                case "은":
                                    post = "는";
                                    break;
                                case "과":
                                    post = "와";
                                case "으로":
                                    post = "로";
                                    break;
                            }
                        }

                        rtn = rtn.replace(m, word + post);
                    }
                    else if (lang == "Eng") {
                        rtn = rtn.replace(m, word);

                        if (rtn != null && rtn.length > 0) {
                            if (post == "C") {// capitalize
                                rtn = rtn[0].toUpperCase() + rtn.substring(1);
                            }
                        }
                    }
                    else {
                        rtn = rtn.replace(m, word);
                    }
                }
                catch (err) {
                }
                
            }
        }
        return rtn;
    }
    this.setDefault = function (lang) {
        this.languageType = lang;
    }
    this.hasFinal = function (word) {
        if (typeof (word) != "string") return false;

        var code = word.charCodeAt(word.length - 1) - 44032;
        var cho = 19, jung = 21, jong = 28;
        var i1, i2, code1, code2;

        // 한글이 아닐때
        if (code < 0 || code > 11171) return false;

        if (code % 28 == 0) return false;
        else return true;
    }
    this.addText = function (resource) {
        for (var p in resource) {
            _resource[p] = resource[p];
        }
    }

    
}

$(function () {

    var temp = null;
    try {
        if (opener != null) temp = opener._text;
    }
    catch(e){

    }
    
    if (temp == null) temp = new _text();

    _text = function (code, data, lang) {
        return temp.get(code, data, lang);
    }

    for (var p in temp) {
        _text[p] = temp[p];
    }

});