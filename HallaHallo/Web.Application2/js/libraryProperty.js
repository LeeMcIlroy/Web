_library.PropertyIndex = 0;

_library.Property = function (element) {
    _library.PropertyIndex++;

    var _value = null;
    var _element = element;
    var _setter = null;
    var _getter = null;

    var _tagName = element[0].tagName;
    var _inputType = element.attr('type');
    var _fieldType = element.attr('f-type');
    var _fieldFormat = element.attr('f-format');
    var _name = element.attr("f-name");
    if (_name == null) {
        _name = element.attr("name");
    }

    element.data("prop", this);
    if (_fieldType == 'number') {
        element.css("text-align", "right");
    }

    if (_fieldType == "date") {
        element.attr("autocomplete", "off");
    }

    function _getNewValidaty() {
        return {
            badInput: false,
            customError: false,
            patternMismatch: false,
            rangeOverflow: false,
            rangeUnderflow: false,
            stepMismatch: false,
            tooLong: false,
            typeMismatch: false,
            valid: true,
            valueMissing: false
        };
    }

    var _prop = this;
    var _validater = function () {
        var validaty = _getNewValidaty();
        if ($.trim(_prop.Get()).length == 0) {
            validaty.valueMissing = true;
            validaty.valid = false;
        }
        return validaty;
    }

    if (_tagName == "INPUT") {

        if (_inputType == 'checkbox') {

            _setter = function (val) {
                var dataGroup = element.parents("[data-id]:first");
                if (dataGroup.length == 0) dataGroup = $(document);
                var target = dataGroup.find("input[name='" + _name + "']");
                if (target.length == 1) {
                    var checked = target.prop("checked");
                    if (typeof (val) == "boolean") {
                        target.prop("checked", val);
                    }
                    else {
                        target.prop("checked", val == target.val());
                    }

                    if (checked != target.prop("checked")) target.change();
                }
                else {
                    if ($.isArray(val)) {
                        for (var i = 0; i < target.length; i++) {
                            var el = $(target[i]);
                            var checked = el.prop("checked");
                            el.prop("checked", false);
                            for (var j = 0; j < val.length; j++) {
                                if (target[i].value == val[j]) {
                                    el.prop("checked", true);
                                    if (checked != el.prop("checked")) el.change();
                                    break;
                                }
                            }
                        }
                    }
                }
            }

            _getter = function () {
                var dataGroup = element.parents("[data-id]:first");
                if (dataGroup.length == 0) dataGroup = $(document);
                var target = dataGroup.find("input[name='" + _name + "']");
                if (target.length == 1) {
                    var val = target.val();
                    if (val == null) {
                        return target.is(":checked") ? "True" : "False";
                    }
                    else {
                        return target.is(":checked") ? val : null;
                    }
                    
                }
                else {
                    var val = [];
                    for (var i = 0; i < target.length; i++) {
                        var el = $(target[i]);
                        if (el.is(":checked")) {
                            val[val.length] = el.val();
                        }
                    }
                    return val;
                }
            }

            _validater = function () {
                var validaty = _getNewValidaty();

                var val = _getter();
                if ($.isArray(val)) {
                    if (val.length == 0) {
                        validaty.valueMissing = true;
                        validaty.valid = false;
                    }
                }
                else {

                }

                return validaty;
            }
        }
        else if (_inputType == 'radio') {
            _setter = function (val) {
                var dataGroup = element.parents("[data-id]:first");
                if (dataGroup.length == 0) dataGroup = $(document);
                var target = dataGroup.find("input[name='" + _name + "']");
                for (var i = 0; i < target.length; i++) {
                    var el = $(target[i]);
                    if (el.val() == val) {
                        el.attr("checked", true);
                    }
                }
            }
            _getter = function () {
                var dataGroup = element.parents("[data-id]:first");
                if (dataGroup.length == 0) dataGroup = $(document);
                var target = dataGroup.find("input[name='" + _name + "']");
                for (var i = 0; i < target.length; i++) {
                    var el = $(target[i]);

                    if (el.is(":checked")) {
                        var val = el.val();
                        if (val == null) {
                            return true;
                        }
                        else {
                            return val;
                        }
                    }
                }

                return null;
            }
            _validater = function () {
                var validaty = _getNewValidaty();
                var val = _getter();
                if (val == null) {
                    validaty.valueMissing = true;
                    validaty.valid = false;
                }
                return validaty;
            }
        }
        else {
            if (_fieldType == "date") {
                element.datepicker().next(".ui-datepicker-trigger").addClass("btn_date");
            }

            _setter = function (val) {
                _element.val(val);
                _element.keyup();
            }
            _getter = function (plain) {
                var val = _element.val();
                if (!plain) {
                    if (_fieldType == "money" || _fieldType == "number") {
                        val = val.replace(/,/ig, "");
                    }
                }
                return val;
            }
        }
    }
    else if (_tagName == "TEXTAREA") {
        _setter = function (val) {
            _element.val(val);
        }
        _getter = function () {
            return _element.val();
        }
    }
    else if (_tagName == "SELECT") {
        if (_fieldType == "multi") {
            var width = element.width();
            if (width == 0) {
                width = "auto";
            }

            element.attr("multiple", "multiple");
            if (element.find("option:first").val() == "") {
                element.find("option:first").remove();
            }

            var columns = element.data('columns');
            if (columns == null || columns == '') columns = 1;

            var maxSelect = element.data('max-select');

            var options = {
                columns: columns,
                search: true,
                selectAll: true,
                texts: {
                    placeholder: '---SELECT---',
                    search: '검색'
                },
                maxSelect: maxSelect
            }


            element.multiselect(options);
            var control = element.next();
            control.css("width", width);
            control.find("button:first").css("width", width);
            var width = element.width();
            if (width < 150) width = 150;
            control.find(".ms-options:first").css("left", "auto");
            control.find(".ms-options:first").css("overflow", "visible");
            control.find(".ms-options:first").css("overflow-y", "scroll");
            control.find(".ms-options:first").css("width", width * columns);


            var checkedItems = element.data("value");
            if (typeof (checkedItems) == "number") checkedItems = checkedItems.toString();
            if (checkedItems != null) checkedItems = checkedItems.split(',');


            element.find("option").each(function (i) {
                if ($(this).attr("value") == undefined) {
                    $(this).attr("value", this.value);
                }
                if (checkedItems != null) {
                    for (var i = 0; i < checkedItems.length; i++) {
                        if (checkedItems[i] == $(this).val()) {
                            control.find(".ms-options input[type=checkbox][value=" + checkedItems[i] + "]").click();
                            //control.find(".ms-options li:eq(" + ($(this).val() - 1) + ") input").click();
                            break;
                        }
                    }
                }
            });
        }
        else {
            
        }
        _setter = function (val) {
            _element.val(val);
        }
        _getter = function () {
            return _element.val();
        }
    }
    else if (_tagName == "BUTTON") {
        _setter = function (val) {
            this._value = val;
        }
        _getter = function () {
            return _value;
        }
    }
    else {
        if (_element.attr("f-text") != null) {
            _setter = function (val) {
                _element.text(val);
            }
            _getter = function () {
                return _element.text();
            }
        }
        else if (_fieldType == "editor") {
            _setter = function (val) {
                _element.html(val);
            }
            _getter = function () {
                $(document).click();
                var html = $("<div>" + _element.html() + "</div>");
                html.find(".field_help").remove();
                return html.html();
            }

            _validater = function () {
                var validaty = _getNewValidaty();
                var val = $(_getter());
                if (val.text().trim().length == 0 && val.find('img,table').length == 0) {
                    validaty.valueMissing = true;
                    validaty.valid = false;
                }
                return validaty;
            }
        }
        else if (_fieldType == "editor_dext") {
            var id = _element.attr("id");
            if (id == null || id.length == 0) {
                id = "_editor_dext_" + _library.PropertyIndex;
                _element.attr("id", id);
            }

            _setter = function (val) {
                DEXT5.setHtmlValue(html, id);

            }
            _getter = function () {
                return DEXT5.getHtmlValue(html, id);
            }

            _validater = function () {
                var validaty = _getNewValidaty();
                var val = DEXT5.isEmpty(id);
                if (val) {
                    validaty.valueMissing = true;
                    validaty.valid = false;
                }
                return validaty;
            }
        }
        else if (_fieldType == "editable") {
            _setter = function (val) {
                _element.html(val);
            }
            _getter = function () {
                var html = $("<div>" + _element.html() + "</div>");
                return html.html();
            }

            _validater = function () {
                var validaty = _getNewValidaty();
                if ($("<div>" + _getter() + "</div>").text().trim().length == 0) {
                    validaty.valueMissing = true;
                    validaty.valid = false;
                }
                return validaty;
            }
        }
        else {
            _setter = function (val) {
                _element.html(val);
            }
            _getter = function () {
                return _element.text();
            }
        }

    }


    function bindEvent(el) {
        if (_fieldType == 'number') {
            el.keydown(function (e) {
                var target = e.target;
                if (_library.CheckNumberKey(e) == false) {
                    e.preventDefault();
                }
            });
            el.keyup(function (e) {
                var target = e.target;

                if (e.ctrlKey && e.keyCode == 86) {
                    target.value = _library.ExtractNumber(target.value);
                }
                target.value = target.value.toMoney();
            });

            el.blur(function (e) {
                var target = e.target;
                target.value = _library.ExtractNumber(target.value).toMoney();
            });
        }
        else if (_fieldType == 'money') {
            el.keydown(function (e) {
                var target = e.target;
                if (_library.CheckNumberKey(e) == false) {
                    e.preventDefault();
                }
            });
            el.keyup(function (e) {
                var target = e.target;

                if (e.ctrlKey && e.keyCode == 86) {
                    target.value = _library.ExtractNumber(target.value);
                }
                target.value = target.value.toMoney();
            });

            el.blur(function (e) {
                var target = e.target;
                target.value = _library.ExtractNumber(target.value).toMoney();
            });
        }
        else if (_fieldType == 'date') {
            _element.keydown(function (e) {
                var target = e.target;
                if (e.keyCode == '191' || e.keyCode == '186') {
                    return;
                }

                if (_library.CheckNumberKey(e) == false) {
                    e.preventDefault();
                }
            });

            _element.keyup(function (e) {
                var target = e.target;
                if (e.ctrlKey && e.keyCode == 86) {//crtl+v
                    target.value = _library.ExtractNumber(target.value, true);
                }
            });

            _element.blur(function (e) {
                var target = e.target;

                setTimeout(function () {
                    if (target.value == "") return;

                    var exist = _element.datepicker("getDate");

                    var result = _library.ConvertDate(target.value);
                    var date = new Date(result);
                    if (date.toDateString() != exist.toDateString()) _element.datepicker("setDate", date);
                }, 1);

            });
        }
        else if (_fieldType == 'userId') {
            el.keydown(function (e) {
                var target = e.target;
                //if (_library.CheckNumberKey(e) == false) {
                //    e.preventDefault();
                //}
            });
            el.keyup(function (e) {
                var target = e.target;

                //if (e.ctrlKey && e.keyCode == 86) {
                //    target.value = _library.ExtractNumber(target.value);
                //}
                //target.value = target.value.toMoney();
            });

            el.blur(function (e) {
                var target = e.target;
                target.value = target.value.replace(/[^a-zA-Z0-9\.]/ig, "");
            });
        }
        else if (_fieldType == 'password') {
            el.keydown(function (e) {
                var target = e.target;
                if (_library.CheckNumberKey(e) == false) {
                    e.preventDefault();
                }
            });
            el.keyup(function (e) {
                var target = e.target;

                if (e.ctrlKey && e.keyCode == 86) {
                    target.value = _library.ExtractNumber(target.value);
                }
                target.value = target.value.toMoney();
            });

            el.blur(function (e) {
                var target = e.target;
                target.value = _library.ExtractNumber(target.value).toMoney();
            });
        }
    }
    bindEvent(element);

    this.SetElement = function (el) {
        _element = _element.add(el);
        el.data("prop", this);
        bindEvent(el);
    }

    this.GetElement = function () {
        return _element.eq(0);
    }

    this.GetElements = function () {
        return _element;
    }

    this.Get = function (plain) {
        return _getter(plain);
    }

    this.Set = function (val) {
        _value = val;
        _setter(val);
    }




    this.WillValidate = function (will) {
        var _validate = element.attr('f-validate');
        if (_validate == null) {
            _validate = element.parents("[f-validate]:first").attr('f-validate');
        }
        else {
            if (element.find('[name],[f-validate]').length > 0) {
                _validate = null;
            }
        }
        var _willValidate = _validate == "required";

        if (will == null) {
            var visibleTarget = element;
            if (_inputType == "radio" || _inputType == "checkbox") {
                visibleTarget = $(element).parents("label:first");
                if (visibleTarget.length == 0) visibleTarget = element;
            }
            return _validater != null && _willValidate && !element.is(":disabled") && visibleTarget.is(":visible");
        }
        else {
            _willValidate = will;
        }

    }

    var _validaty = null;
    this.CheckValidity = function () {
        if (this.WillValidate()) {
            _validaty = _validater();
            if (_validaty.valid) return true;
            else return _validaty;
        }
        else return true;
    }

    this.SetCustomValidate = function (validater) {
        _validater = validater;
    }

    var validationMessage = {
        badInput: "",
        customError: "",
        patternMismatch: "",
        rangeOverflow: "",
        rangeUnderflow: "",
        stepMismatch: "",
        tooLong: "",
        typeMismatch: "",
        valid: "",
        valueMissing: ""
    }



    this.ValidationMessage = function (message) {
        if (message == null) {
            for (var p in _validaty) {
                if (_validaty[p]) {
                    var message = validationMessage[p];
                    if (message == null || message == "") {
                        var name;

                        var container = element.parents("td:first");
                        if (container.length > 0) {
                            var prev = container.prev();
                            if (prev.prop('tagName') == 'TH') {
                                var prev = prev.clone();
                                prev.find("span").remove();
                                name = prev.text();
                            }
                        }


                        if (element.parents(".grid").length > 0) {
                            var idx = element.parents("td:first").index();

                            var th = element.parents(".grid:first").find(".grid-header thead th:eq(" + idx + ") .item span:first");
                            name = th.text();
                        }

                        if (name == null) {
                            name =element.siblings("label").text();
                        }

                        if (name == null) {
                            name = element.attr("title");
                        }
                        

                        name = $.trim(name);
                        if (name.length > 0 && name[0] == "*") {
                            name = $.trim(name.substring(1));
                        }

                        if (p == "valueMissing") {
                            if (_tagName == "INPUT" && _inputType == "radio" || _tagName == "INPUT" && _inputType == "checkbox" && _element.length > 1 || _tagName == "SELECT") {
                                message = _text("msgSelectField", { Name: name });
                            }
                            else {
                                message = _text("msgInputField", { Name: name });
                            }
                        }

                        validationMessage[p] = message;
                    }
                    return message;
                }
            }
        }
        else {
            for (var p in message) {
                validationMessage[p] = message[p];
            }
        }
    }
}

jQuery.extend({
    toQueryString: function (entity) {
        var url = "";
        var idx = 0;
        for (var p in entity) {
            var type = typeof (entity[p]);
            if (type != "function" && type != "object") {

                if (idx == 0) {
                    url += p + "=" + entity[p];
                }
                else {
                    url += "&" + p + "=" + entity[p];
                }
                idx++;
            }
        }

        return url;
    }
});


$.getEntity = function (wrap, entity) {
    if (entity == undefined) entity = {};
    if (wrap.prop("tagName") == "TR" && wrap.parents(".grid-right:first").length > 0) {
        var index = wrap.index() + 1;
        var leftRow = wrap.parents(".grid-body:first").find(".grid-left tbody.item tr").eq(index);
        $.getEntity(leftRow, entity);
    }

    wrap.find("[name]").each(function () {
        var name = $(this).attr("name");
        var fieldType = $(this).attr("f-type");

        if (this.tagName == "INPUT" || this.tagName == "SELECT" || this.tagName == "TEXTAREA") {
            if (this.tagName == "INPUT") {
                if (fieldType == "money" || fieldType == "number") {
                    entity[name] = $(this).val().replace(/,/g, '');
                    return;
                }

                var type = $(this).attr("type");
                if (type == "radio") {
                    if (entity[name] === undefined || entity[name].length == 0) {

                        var dataGroup = $(this).parents("[data-id]:first");
                        if (dataGroup.length == 0) dataGroup = $(document);

                        entity[name] = dataGroup.find("[name='" + name + "']:checked").val();
                    }
                    return;
                }
                else if (type == "checkbox") {
                    if (entity[name] === undefined || entity[name].length == 0) {
                        entity[name] = '';

                        var dataGroup = $(this).parents("[data-id]:first");
                        if (dataGroup.length == 0) dataGroup = $(document);

                        var temp = dataGroup.find("[name='" + name + "']:checked");
                        temp.each(function (i) {
                            entity[name] += this.value;
                            if (i < temp.length - 1) entity[name] += ",";
                        });
                    }
                    return;
                }
            }

            
            if (this.tagName == "SELECT") {
                if (fieldType == "multi") {
                    var list = $(this).val();
                    entity[name] = '';
                    for (var i = 0; i < list.length; i++) {
                        entity[name] += list[i];
                        if (i + 1 < list.length) {
                            entity[name] += ",";
                        }
                    }

                    return;
                }
            }

            entity[name] = $(this).val();

            var val = $(this).data("value");
            if (val != null) {
                var dataName = $(this).data("name");
                if (dataName == null) {
                    entity[name] = $(this).data("value");
                }
                else {
                    entity[dataName] = $(this).data("value");
                }
            }

            var textName = $(this).data("text-name");
            if (textName) {
                if (this.tagName == "SELECT") {
                    entity[textName] = $(this).find("option:selected").text();
                }
                else {
                    entity[textName] = $(this).text();
                }
                
            }
            
        }
        else if (fieldType == "editor_dext") {
            entity[name] = DEXT5.getBodyValue(this.id);
            return;
        }
        else {
            entity[name] = $(this).text();
            if (fieldType == "money" || fieldType == "number") {
                entity[name] = entity[name].replace(/,/g, '');
            }

            var val = $(this).data("value");
            if (val != null) {
                var dataName = $(this).data("name");
                if (dataName == null) {
                    entity[name] = val.toString();
                    if (fieldType == "money" || fieldType == "number") {
                        entity[name] = entity[name].replace(/,/g, '');
                    }
                }
                else {
                    entity[dataName] = val.toString();
                    if (fieldType == "money" || fieldType == "number") {
                        entity[dataName] = entity[dataName].replace(/,/g, '');
                    }
                }
            }

        }
    });

    //entity.toQueryString = function () {
    //    return $.toQueryString(entity);
    //}
    
    return entity;
}


$.fn.extend({
    getEntity: function (forceArray) {
        if (this.length > 1 || forceArray) {
            var list = [];
            this.each(function () {
                var entity = $.getEntity($(this));
                list[list.length] = entity;
            });

            return list;
        }
        else {
            return $.getEntity($(this));
        }
    }
});

$.fn.extend({
    getEntityList: function (parent) {
        var list = [];
        this.each(function () {
            if (parent) {
                var entity = $.getEntity($(this).parent());
                list[list.length] = entity;
            }
            else {
                var entity = $.getEntity($(this));
                list[list.length] = entity;
            }
            
        });

        return list;
    }
});

$.fn.extend({
    validate: function (custom, summary) {
        var target = $(this).find("[name],[f-validate]");
        var currentFor = null;
        var currentIndex = 0;

        var valid = true;
        target.each(function () {
            var element = $(this);
            var prop = element.data('prop');
            if (prop == null) return;

            if (custom != null && custom(element)) {

            }
            else {
                var validaty = prop.CheckValidity();
                if (validaty == true) {

                }
                else {
                    var message = prop.ValidationMessage();
                    alert(message);

                    var el = prop.GetElement();
                    if (el.hasClass('datepick')) {
                        setTimeout(function () {
                            el.datetimepicker('show');
                        }, 1);
                    }
                    else if (el.attr('f-type') == "editor") {
                        //timeout event target 을 변경하기 위함
                        setTimeout(function () {
                            el.click();
                        }, 1);
                    }
                    else if (el.attr('f-type') == "editor_dext") {
                        setTimeout(function () {
                            DEXT5.setFocusToEditor(el.attr("id"));
                        }, 1);
                    }
                    else {
                        el.focus();
                    }

                    valid = false;
                    return false;
                }
            }
        })

        if (summary != null && summary() == false) {
            return false;
        }

        return valid;
    }
});


$.fn.extend({
    mappingTo: function (form) {
        var area = $(this);

        if (form == null) {
            form = $("form:first");
        }

        if (form.jquery === undefined) {
            form = $(form);
        }

        area.find("[name]").each(function () {
            var name = $(this).attr("name");
            var target = form.find("[name='" + name + "']");
            $(target).val($(this).val());
        });
    }
});

$.fn.extend({
    mapping: function (item) {
        var form = $(this);

        for (var p in item) {
            var name = p;
            var target = form.find("[name='" + name + "']");
            if (target.length == 0) continue;

            target.data("prop").Set(item[p]);
        }
    }
});

$.validate = function (custom, summary) {
    return $(document).validate(custom, summary);
}