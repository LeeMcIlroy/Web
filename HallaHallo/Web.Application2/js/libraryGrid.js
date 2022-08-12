_library.FindGrid = function (grid) {

    if (grid != null && grid.jquery) {
        return grid;
    }

    if (grid == null) {
        grid = $(".grid:first");
    }
    else if (typeof (grid) == "object") {
        grid = $(grid).parents(".grid:first");
    }
    else if (typeof (grid) == "string") {
        grid = $(".grid[data-name='" + grid + "']");
        if (grid.length == 0) {
            grid = $(grid);
        }
    }

    return grid;
}

_library.FindGridForm = function (name) {
    if (name === undefined) name = '';
    if (name == null) name = '';

    var form;
    if (name.length == 0) {
        form = $("form[data-grid]:first");
    }
    else {
        form = $("form[data-grid='" + name + "']");
    }

    if (form.length == 0) {
        form = $("form:first");
    }

    return form;
}


_library.CreateGridRow = function (transform, grid) {
    if (typeof (transform) == "string" || transform != null && transform.jquery != null) {
        grid = transform;
        transform = null;
    }

    grid = _library.FindGrid(grid);

    var row = grid.find(".grid-body tbody.template>tr").clone();
    row.addClass("edit");
    row.attr("data-id", "");
    row.data("id", "");

    row.children().each(function (i) {
        var src = $(this);
        var name = grid.find("thead th.header").eq(i).data("name");
        if (name == null) name = '';
        if (transform != null) {
            transform(name, $(this));
        }
    });

    row.find("[name],[f-type],[f-validate]").each(function () {
        var target = $(this);
        new _library.Property(target);
        if (target.data("type") == "checkbox") {
            if (this.value == null || this.value == "") {
                this.value = "Y";
            }
        }
    });

    return row;
}


_library.AddGridRow = function (transform, prepend, grid) {
    if (typeof (transform) == "string" || transform != null && transform.jquery != null) {
        grid = transform;
        prepend = false;
        transform = null;
    }
    if (typeof (transform) == "boolean") {
        grid = prepend;
        prepend = transform;
        transform = null;
        
    }
    if (typeof (prepend) == "string" || prepend != null && prepend.jquery != null) {
        grid = prepend;
        prepend = false;
    }
    

    if (prepend === undefined) prepend = false;

    grid = _library.FindGrid(grid);

    var row = _library.CreateGridRow(transform, grid);

    grid.find(".not-found").remove();

    if (prepend) {
        grid.find(".grid-body tbody.item").prepend(row);
    }
    else {
        grid.find(".grid-body tbody.item").append(row);
    }

    var blank = grid.find("tbody.blank tr:visible");
    if (blank.length > 0) {
        blank.eq(0).hide();
    }

    _library.SelectGridRow(row);

    var option = grid.data('option');
    if (option !== undefined && option.updateCallback !== undefined) {
        option.updateCallback(grid);
    }
    else {
        row.find("input").not(":checkbox").eq(0).focus();
    }

    return row;
}



_library.SelectGridRow = function (row) {
    var body = row.parents(".grid-body:first");
    var tbody = body.find("tbody.item");
    var index = row.index() + 1;
    tbody.find("tr:nth-child(" + index + ")").each(function () {
        tbody.find("tr").removeClass("selected");
        $(this).addClass("selected");
    });


}

_library.MappingGridRow = function (source, target, transform) {
    var grid = source.parents(".grid:first");
    var sourceList = source.find("[name],[data-name]");
    var nameList = {}
    for (var i = 0; i < sourceList.length; i++) {
        var src = sourceList.eq(i);
        var name = src.attr("name");
        var dataName = src.data("name");
        if (dataName != null && dataName.length > 0) {
            name = dataName;
        }
        nameList[name] = "";
    }

    for (var name in nameList) {

        source.find("[name='" + name + "'],[data-name='" + name + "']").each(function (j) {
            var src = $(this);
            var dataValue = src.data("value");
            var targetElement = target.find("[name='" + name + "'],[data-name='" + name + "']").eq(j);
            if (targetElement.length == 0) return;

            //src.html("a<br>s<br>sss&nbsp;c");
            var val;
            var tagName = targetElement.prop("tagName");
            if (tagName == "TEXTAREA") {
                val = src.html().replace(/(<br>|<br\/>|<br \/>)/g, '\r\n').replace(/\&nbsp;/g, ' ');
            }
            else {
                if (dataValue == null) {
                    val = src.fval();
                }
                else {
                    val = dataValue;
                }
            }

            if (dataValue != null && tagName == "SPAN") {
                targetElement.data("value", dataValue);
                targetElement.attr("data-value", dataValue);
            }

            var prop = new _library.Property(targetElement);
            if (tagName == "TEXTAREA" || tagName == "INPUT" || tagName == "SELECT") {
                prop.Set(val);
            }
            else {
                if (dataValue == null) {
                    prop.Set(val);
                }
                else {
                    prop.Set(src.text());
                }

            }
        });
    }

    target.children().each(function (i) {
        var src = $(this);
        var name = grid.find("thead tr:last th").eq(i).data("name");
        if (name == null) name = '';
        if (transform != null) {
            transform(name, $(this));
        }

        //var field = newTd.find("[name]");
        //if (field.length == 0) {
        //    if (src.find(".grid-command-edit").length == 0) {
        //        newTd.html(src.html());
        //    }
        //}
    });


}

_library.EditGridRow = function (target, transform, callback) {
    if (target == null) {
        target = window.event.target;
    }

    if (target.jquery === undefined) {
        target = $(target);
    }

    target = target.parents("tr:first");

    grid = target.parents(".grid:first");

    var editTarget = grid.find("tbody.item>tr.edit");
    if (editTarget.length > 0) {
        if (editTarget[0] == target[0]) return;
    }

    var isBatch = grid.data("Batch") != null;
    var wrapItem = grid.find("tbody.item");
    if (isBatch) {

    }
    else {
        wrapItem.find("tr.edit").remove();
        wrapItem.find("tr").show();
    }

    if (target.hasClass("blank")) return;

    var row = grid.find(".grid-body tbody.template>tr").clone();
    row.addClass("edit");
    row.data("id", target.data("id"));
    row.attr("data-id", target.data("id"));
    target.after(row);
    target.hide();

    _library.MappingGridRow(target, row, transform);
    _library.SelectGridRow(row);
    row.find("[name],[f-type],[f-validate]").each(function () {
        if ($(this).data("prop") == null) {
            new _library.Property($(this));
        }
    });


    if (callback != null) callback(row);

    var option = grid.data('option');
    if (option !== undefined && option.updateCallback !== undefined) {
        option.updateCallback(grid);
    }

    return row;
}


_library.CancelGridRow = function (target) {
    if (target == null) {
        target = window.event.target;
    }

    if (target.jquery === undefined) {
        target = $(target);
    }

    var tr = target.parents("tr:first");
    grid = tr.parents(".grid:first");

    if (tr.hasClass("edit")) {
        //tr = _library.GetBothSideRow(tr);

        //grid.find("tbody.item>tr.edit").remove();
        tr.prev().show();
        tr.remove();

        var blank = grid.find("tbody.blank tr:hidden:nth-child(1)");
        blank.show();
    }
    else if (tr.hasClass("delete")) {
        //tr = _library.GetBothSideRow(tr);
        var td = target.parents("td:first");
        td.find(".cancel").remove();
        td.find(".grid-row-command").show();
        tr.removeClass("delete");
    }
    else {
        return;
    }


}

_library.SaveGridRow = function (target, grid) {
    grid = _library.FindGrid(grid);

    if (target.tagName == "TR") {
        target = $(target);
    }
    else {
        target = $(target).parents("tr:first");
    }

    grid.find("tbody.item>tr.edit").removeClass("edit").addClass("save");
    grid.find("tbody.item>tr").removeClass("selected");
    grid.find("tbody.item>tr").show();

    if (callback != null) callback(row);
}

_library.DeleteGridRow = function (ask, grid) {
    if (ask == null) ask = true;
    if (ask) {
        if (!confirm("삭제하시겠습니까?")) {
            return false;
        }
    }

    grid = _library.FindGrid(grid);
    var isBatch = grid.data("Batch") != null;

    var list = [];
    var target = $(window.event.target);
    if (target.hasClass("grid-row-command") && target.hasClass("delete")) {
        var row = target.parents("tr:first");
        //row = _library.GetBothSideRow(row);

        if (isBatch) {
            row.addClass("delete");
            var td = target.parents("td:first");
            td.find(".grid-row-command").hide();
            //td.append("<a href='#' class='grid-row-command cancel'>취소</a>");
            td.append('<button class="table-btn-save grid-row-command cancel">취소</button>');
            //row.hide();
        }
        else {
            row.remove();
        }

        var blank = grid.find("tbody.blank tr:hidden:nth-child(1)");
        blank.show();
    }
    else {
        var all = grid.find("input.all");
        var index = all.parents("th:first").index();

        grid.find("tbody.item>tr").each(function () {
            var row = $(this);

            var c = row.find("td:eq(" + index + ") input[data-type='checkbox']");
            if (c.prop("checked")) {
                list[list.length] = c.val();
                if (isBatch) {
                    row.addClass("delete");
                    row.hide();
                }
                else {
                    row.remove();
                }
            }
        });

        all.prop("checked", false);
        grid.find("tbody.template tr:first").find("td:eq(" + index + ") input[data-type='checkbox']").prop("checked", false);

    }


    $(window).resize();
    return list;
}

_library.CopyGridRow = function (grid) {

    grid = _library.FindGrid(grid);
    var cbAll = grid.find("input.cbAll");
    var index = cbAll.parents("th:first").index();

    var list = [];
    grid.find("tbody.item>tr").each(function () {
        var target = $(this);

        var c = target.find("td:eq(" + index + ") input[data-type='checkbox']");
        if (c.prop("checked")) {
            list[list.length] = c.val();

            var row = _library.CreateGridRow(grid);
            var pos = target;
            while (true) {
                var next = pos.next();
                if (next == null) break;
                if (!pos.next().hasClass("edit")) break;
                pos = next;
            }
            pos.after(row);

            _library.MappingGridRow(target, row, function (name, cell) {
                if (name == '') {
                    cell.html('');
                }
                else if (name[0] == '_') {
                    cell.find("[name='" + name + "']").fval('');
                }
            });
            _library.SelectGridRow(row);

        }
    });


    var option = grid.data('option');
    if (option !== undefined && option.updateCallback !== undefined) {
        option.updateCallback(grid);
    }

    return list;
}

_library.GetGridEntity = function (containAll, grid) {
    if (typeof (containAll) == "string" && grid === undefined) {
        grid = containAll;
        containAll = null;
    }
    if (containAll == null) containAll = false;
    grid = _library.FindGrid(grid);

    var list = [];
    grid.find("tbody.item:first tr").not(".not-found").each(function () {
        var row = $(this);
        var id = row.data("id");
        if (id == null) id = '';

        var key = grid.find("input[data-name='Key']").val();
        if (key == null || key == "") key = "_ItemId";

        var entity = $.getEntity(row);
        if (entity[key] === undefined) {
            entity[key] = id;
        }

        entity._ItemState = 'None';

        if (row.hasClass("delete")) {
            entity._ItemState = "Delete";
        }
        else if (row.css("display") == "none") {
            return;
        }
        else if (row.hasClass("edit")) {
            if (id.length == 0) {
                entity._ItemState = "Create";
            }
            else {
                entity._ItemState = "Update";
            }
        }

        if (!containAll && entity._ItemState == 'None') {
            return;
        }

        entity._row = row;
        list[list.length] = entity;
    });

    return list;
}

_library.ForceArray = function (obj) {
    if ($.isArray(obj)) return obj;

    var array = [];
    array[0] = obj;
    return array;
}

_library.ResolveArrayElement = function (entity_or_list, arrayElement, propertyName, valueFunc) {

    entity_or_list = _library.ForceArray(entity_or_list);
    arrayElement = _library.ForceArray(arrayElement);
    if (typeof (propertyName) == "function") {
        valueFunc = propertyName;
        propertyName = arrayElement;
    }
    else {
        propertyName = _library.ForceArray(propertyName);
    }

    for (var i = 0; i < entity_or_list.length; i++) {
        var item = entity_or_list[i];
        for (var i = 0; i < arrayElement.length; i++) {
            item[propertyName[i]] = [];
            item._row.find("[name='" + arrayElement[i] + "']").each(function (idx) {
                var el = $(this);
                var val = undefined;
                if (valueFunc !== undefined) {
                    val=valueFunc(idx, el);
                }
                    
                if (val == undefined) {
                    val = el.data("prop").Get();
                }
                
                item[propertyName[i]][idx] = val;
            });
        }
    }
}

_library.BindGrid = function (result, grid) {
    grid = _library.FindGrid(grid);

    if (typeof (result) == "string") {
        result = $(result);
    }

    var name = grid.data("name");
    var temp = result.find(".grid[data-name='" + name + "']");
    if (temp.length > 0) {
        result = temp;
    }

    if (!result.hasClass("grid-result-root")) {
        result = $("<div class='grid-result-root'/>").append(result);
    }

    var containHeader = result.find("thead").length>0;
    var item = containHeader ? result.find("table") : result.find("tbody");
    var body = grid.find(".grid-body");
    if (containHeader) {
        body.html('');
        body.html(item);
    }
    else {
        body.find("tbody.item").remove();
        body.find("tbody.blank").remove();
        body.find("table").append(item);
    }

    _library.SplitTable(grid, true);

    var command = result.find("input[name='Grid.Command']").val();
    if (command == "Sort") {
        var column = result.find("input[name='Grid.SortColumn']").val();
        var direction = result.find("input[name='Grid.SortDirection']").val();

        body.find(".grid-sort-direction i").remove();

        var th = body.find("thead th[data-name='" + column + "']");
        if (direction == "Desc") {
            th.find(".grid-sort-direction").html("<i class='fa fa-sort-down'></i>");
        }
        else {
            th.find(".grid-sort-direction").html("<i class='fa fa-sort-up'></i>");
        }
    }

    if (command != "Sort") {
        var item = result.find(".grid-navi>div");
        if (item.length == 0) {
            item = result.next(".grid-navi").find("div:first");
        }

        var navi = grid.find(".grid-navi>div");
        if (navi.length == 0) {
            navi = grid.next(".grid-navi").find("div:first");
        }
        navi.replaceWith(item);
    }

    var option = grid.data('option');
    if (option !== undefined && option.updateCallback !== undefined) {
        option.updateCallback(grid);
    }
}

_library.SetGridOption = function (option, grid) {
    grid = _library.FindGrid(grid);

    grid.data('option', option);

}

_library.SubmitGrid = function (option, grid) {
    grid = _library.FindGrid(grid);

    if (typeof (option) == "function") {
        var temp = {};
        temp.success = option;
        option = temp;
    }
    else if (typeof (option) == "string") {
        var temp = {};
        temp.command = option;
        option = temp;
    }
    else if (typeof (option) == "object") {
        if (option.jquery === undefined) {

        }
        else {
            grid = option;
            option = {};
        }

    }
    if (option === undefined) {
        option = {};
    }

    var command = option.command;

    var defaultOption = grid.data('option');
    if (defaultOption != null) {
        for (var p in defaultOption) {
            if (option[p] == null) {
                option[p] = defaultOption[p];
            }
        }
    }

    var name = grid.data("name");
    var form = _library.FindGridForm(name);

    var source = form.data("source");
    if (source != null) {
        $(source).mappingTo(form);
        if (option.arrangeParameter != null) {
            option.arrangeParameter();
        }
    }

    if (command != null) {
        form.find("input[name='Grid.Command']").val(command);
    }
    
    if (command == 'Excel') {
        form.ajaxSubmit({
            success: function (result) {
                var frame = $("#frameGridDownload");
                if (frame.length == 0) {
                    frame = $('<iframe id="frameGridDownload" style="display:none;"></iframe>');
                    frame.appendTo($("body"));
                }
                frame.attr("src", _config.AppPath + "Affairs/Default/GridDownload?name=" + result.FileName);
            },
            fail: function () {

            },
            dataType: "json"
        });
    }
    else if (command != null && command.indexOf('Excel') == 0) {
        var frame = $("#frameGridDownload");
        if (frame.length == 0) {
            frame = $('<iframe name="frameGridDownload" style="display:none;"></iframe>');
            frame.appendTo($("body"));
        }
        form.attr("target", 'frameGridDownload');
        form.submit();
        form.removeAttr("target");
    }
    else if (command == 'Reset') {
        var entity = {}
        form.find("input:hidden").each(function () {
            $(this).attr("name");
        });
    }
    else {
        form.ajaxSubmit({
            success: function (result) {
                if (typeof (result) == "string") {
                    result = $(result);
                }

                result = $("<div class='grid-result-root'/>").append(result);

                _library.BindGrid(result, grid);

                if (option.success != null) {
                    option.success(result, grid);
                }
                if (option.successCallback != null) {
                    option.successCallback(result, grid);
                }
            },
            fail: function () {
                if (option.fail != null) {
                    option.fail(result, grid);
                }
            },
            dataType: "html"
        });
    }
}

_library.SplitTable = function (grid, onlyItem) {
    grid = _library.FindGrid(grid);

    var body = grid.find(".grid-body");
    var frameFix = grid.data("FrameFix");
    if (frameFix != null) {
        var leftTable = body.find(".grid-left table");
        var rightTable = body.find(".grid-right table");
        if (rightTable.length == 0) {
            body.css("position", "relative");

            var leftWidth = 0;
            for (var i = 0; i <= frameFix; i++) {
                leftWidth += grid.find("thead th:eq(" + i + ")").width();
            }

            var right = $('<div class="grid-right" style="position:absolute; left:0px; top:0px; width:100%; overflow-x:auto; box-sizing:padding-box;"></div>')
                .css('padding-left', leftWidth - 1)
                .appendTo(body);
            rightTable = body.find('table:first').appendTo(right);

            var left = $('<div class="grid-left" style="position:absolute; left:0px; top:0px;"></div>')
                .css('width', leftWidth)
                .appendTo(body);
            leftTable = $("<table></table>").appendTo(left);
        }

        setTimeout(function () {
            if (body.find(".grid-right").width() < body.find(".grid-right table").width()) {
                body.height(body.find(".grid-right").height());
            }
            else {
                body.height(body.find(".grid-right").height() + 20);
            }

            if (body.find(".not-found").length > 0) {
                leftTable.css("border-right-width", "0px");
            }
            else {
                leftTable.css("border-right-width", "1px");
            }
        }, 1);



        var range = rightTable;
        if (onlyItem) {
            leftTable.find("tbody.item").remove();
            range = rightTable.find("tbody.item");
        }
        else {
            leftTable.find("*").remove();
        }

        range.find("tr").each(function (rowIndex) {
            var row = $(this);
            var parent = row.parent();
            var group;
            if (parent.hasClass("item")) {
                group = leftTable.find("tbody.item");
                if (group.length == 0) {
                    group = $("<tbody class='item'/>").appendTo(leftTable);
                }
            }
            else if (parent.prop("tagName") == "THEAD") {
                group = leftTable.find("thead");
                if (group.length == 0) {
                    group = $("<thead/>").appendTo(leftTable);
                }
            }
            else if (parent.hasClass("template")) {
                group = leftTable.find("tbody.template");
                if (group.length == 0) {
                    group = $("<tbody class='template'/>").appendTo(leftTable);
                }
            }

            var leftRow = $("<tr></tr>").appendTo(group);
            for (var i = 0; i <= frameFix; i++) {
                leftRow.append(row.children().eq(0));
            }
        });
    }



}

var _gridCurrentCell;

$(function () {
    
    $(".grid").each(function () {
        var grid = $(this);
        var headerFix = grid.data("fix") == "Y";
        var sort = grid.data("sort");
        var body = grid.find(".grid-body");
        var navi = grid.find(".grid-navi");
        var name = grid.data("name");

        var setting = grid.find(".grid-setting");
        if (navi.length == 0) {
            navi = grid.next(".grid-navi");
        }

        var properties = grid.find(".grid-property");
        properties.find("input").each(function () {
            grid.data($(this).data("name"), this.value);
        });

        var isTable = grid.data("table") == "Y";
        var form = _library.FindGridForm(name);
        
        if (form.length == 0) {
            form = $("<form data-grid='" + name + "'></form>");
            setting.wrap(form);
            form = _library.FindGridForm(name);
        }
        else {
            setting.find("input:hidden").clone().appendTo(form);
        }

        var source = form.attr("data-source");
        if (source) {
            var area = $(source);
            var type = form.attr("data-source-type");
            if (type == "copy") {
                area.find("[name]").each(function () {
                    var name = $(this).attr("name");
                    form.append("<input type='hidden' name='" + name + "' />");
                });
            }
        }
        

        if (grid.data("EditOnly") != null) {
            var template = body.find("tbody.item>tr:first")
            template.remove();
            body.find("tbody.template").append(template.show());
        }

        _library.SplitTable(grid);

        var headerArea = body;
        var dataArea = body;
        if (headerFix) {
            headerArea = body.find("table:first");
            dataArea = body.find("table.data");

            var maxwidth = headerArea.width() + 20;
            grid.scroll(function () {
                var width = grid.scrollLeft() + grid.width();
                if (width > maxwidth) width = maxwidth;
                dataArea.css("width", width);
            });

            $(window).resize(function () {
                grid.scroll();
            });
        }

        if (true) {
            headerArea.find("thead th .grid-sort").click(function () {
                var th = $(this).parents("th:first");
                var exist = th.find(".grid-sort-direction i");

                var oldColumn = form.find("input[name='Grid.SortColumn']").val();
                var oldDirection = form.find("input[name='Grid.SortDirection']").val();

                var direction = 'Auto';
                if (th.data("name") == oldColumn) {
                    if (oldDirection == "Asc") {
                        direction = 'Desc';
                    }
                    else if (oldDirection == "Desc") {
                        direction = 'Asc';
                    }
                }
                else {
                    direction = 'Asc';
                }

                form.find("input[name='Grid.Command']").val("Sort");
                form.find("input[name='Grid.SortColumn']").val(th.data("name"));
                form.find("input[name='Grid.SortDirection']").val(direction);
                _library.SubmitGrid(grid);
            });



            body.on("click", ".grid-group-row", function () {
                var group = $(this).data("group");
                var icon = $(this).find("i");

                if (icon.hasClass('fa-caret-right')) {
                    body.find("." + group).show();
                    icon.removeClass('fa-caret-right');
                    icon.addClass('fa-caret-down');
                }
                else {
                    body.find("." + group).hide();
                    icon.removeClass('fa-caret-down');
                    icon.addClass('fa-caret-right');
                }

            });

            navi.on("click", ".grid-navi-page", function (e) {
                e.preventDefault();

                form.find("input[name='Grid.Command']").val("Page");
                var page = $(this).data("page");
                if (page == null) {
                    page = parseInt($(this).text());
                }
                form.find("input[name='Grid.PageNumber']").val(page);
                _library.SubmitGrid(grid);
            });

            navi.on("change", "select", function (e) {
                e.preventDefault();

                form.find("input[name='Grid.Command']").val("Page");
                form.find("input[name='Grid.PageSize']").val($(this).val());
                form.find("input[name='Grid.PageNumber']").val(1);
                _library.SubmitGrid(grid);
            });
        }

        body.on("mouseover", ".grid-left tbody.item>tr", function () {
            var index = $(this).index();
            body.find(".grid-right tbody.item>tr:eq(" + index + ")").addClass("hover");
        });

        body.on("mouseout", ".grid-left tbody.item>tr", function () {
            var index = $(this).index();
            body.find(".grid-right tbody.item>tr:eq(" + index + ")").removeClass("hover");
        });


        body.on("mouseover", ".grid-right tbody.item>tr", function () {
            var index = $(this).index();
            body.find(".grid-left tbody.item>tr:eq(" + index + ")").addClass("hover");
        });

        body.on("mouseout", ".grid-right tbody.item>tr", function () {
            var index = $(this).index();
            body.find(".grid-left tbody.item>tr:eq(" + index + ")").removeClass("hover");
        });

        body.on("focus", "tbody.item td *", function (e) {
            var cell = $(this).parents("td:first");
            var row = cell.parent();
            if ($(this).hasClass("grid-row-command")) {
                return;
            }

            _library.SelectGridRow(row);

            var target = $(e.currentTarget);
            body.find("td.selected").removeClass("selected");
            cell.addClass("selected");
            _gridCurrentCell = target;
        });

        body.on("blur", "tbody.item td", function (e) {
            _gridCurrentCell = null;
            body.find("td.selected").removeClass("selected");
        });

        body.on("click", "tbody.item td", function (e) {
            var tagName = e.target.tagName;
            if (tagName == "INPUT" || tagName == "SELECT" || tagName == "TEXTAREA") {
                return;
            }

            var row = $(this).parents("tr:first");
            _library.SelectGridRow(row);

            var target = $(e.currentTarget);
            body.find("td.selected").removeClass("selected");
            target.addClass("selected");
            _gridCurrentCell = target;
        });

        body.on("click", ".grid-row-command.edit", function (e) {
            e.preventDefault();

            var option = grid.data('option');
            if (option !== undefined) {
                if (option.grid_command_edit !== undefined) {
                    option.grid_command_edit();
                    return false;
                }
            }

            _library.EditGridRow();
            return false;
        });

        body.on("click", ".grid-row-command.cancel", function (e) {
            e.preventDefault();

            _library.CancelGridRow();

            return false;
        });

        body.on("click", ".grid-row-command.delete", function (e) {
            e.preventDefault();

            _library.DeleteGridRow(false, grid);
        });



        //body.keydown(function (e) {
        //    var target = e.target;
        //    if (target.tagName == "TEXTAREA") return;
        //
        //    if (e.which == 13 || e.keyCode == 13) {
        //        e.preventDefault();
        //
        //        var next = $(target).parents("td:first").next();
        //        //if (next.length == 0) {
        //        //    var nextRow = $(target).parents("tr:first");
        //        //    if (nextRow.length == 0) {
        //        //        nextRow = $(target).parents("tbody:first").find("tr:first");
        //        //    }
        //        //    next = nextRow.find("td:first");
        //        //}
        //
        //        next = next.find("input,select,textarea");
        //        next.focus();
        //        if (next.length > 0 && next[0].tagName == "INPUT") {
        //            if (!next.hasClass("search-user")) {
        //                next.select();
        //            }
        //        }
        //    }
        //});

        





        return;
        var totalCount = data.length;
        var pageNumber = 1;
        var pageSize = grid.find(".grid-navi select").val();
        var max = 10;

        var totalPage = Math.ceil(totalCount / pageSize);
        var startPage = (Math.ceil(pageNumber / max) - 1) * max + 1;
        var endPage = startPage + max - 1;
        if (endPage > totalPage) {
            endPage = totalPage;
        }

        var previous = startPage - max;
        if (previous < 1) {
            previous = 1;
        }
        var next = endPage + 1;
        if (next > totalPage) {
            next = totalPage;
        }

        var pages = grid.find(".grid-navi-pages");
        for (var i = startPage; i <= endPage; i++) {
            if (i == pageNumber) {
                pages.append("<b class=\"grid-navi-page current\">[" + i + "]</b>");
            }
            else {
                pages.append("<a class=\"grid-navi-page\">" + i + "</a>");
            }
        }


        for (var i = 0; i < pageSize; i++) {
            trs.eq((startPage - 1) * pageSize + i).show();

        }

        grid.on("click", "a.grid-navi-page", function (e) {
            e.preventDefault();


        });


        return;
        var ths = grid.find("thead th");
        ths.each(function () {
            if (this.width == "" && this.style.width == "") {
                $(this).css("width", $(this).width());
            }
        });

        var table = grid.find("table");

        var header = $("<table/>").append(ths.clone());
        header.css("width", table[0].getBoundingClientRect().width);
        table.before(header);

    });


    var resize = false;
    var left;
    var target;

    var x;
    var w1, w2;
    var t1, t2;
    var fix;
    $(".grid-body .left").mousedown(function (e) {
        e.preventDefault();

        target = e.target;
        //if (target.find(".band").length > 0) {
        //
        //}

        x = e.clientX;
        t1 = $(target).parents("th:first");
        w1 = t1.width();

        t2 = $(target).parents("th:first").prev();
        w2 = t2.width();

        fix = $(target).parents(".grid").data("fix") == "Y";

        resize = true;
        left = true;

    });

    $(".grid-body .right").mousedown(function (e) {
        e.preventDefault();

        target = e.target;
        x = e.clientX;
        t1 = $(target).parents("th:first");
        w1 = t1.width();

        t2 = $(target).parents("th:first").next();
        w2 = t2.width();

        resize = true;
        left = false;

    });

    $(document).mouseup(function (e) {
        resize = false;
    });

    $(document).mousemove(function (e) {
        if (resize) {
            if (left) {
                //t1.width(w1 + (x - e.clientX));
                t2.width(w2 - (x - e.clientX));

                //if (fix) {
                //    var idx = t1.index();
                //    $(".data table col").eq(idx).attr('width', t1.width() + 2);
                //    //$(".data table col").eq(idx - 1).attr('width', t2.width() + 2);
                //}

            }
            else {
                t1.width(w1 - (x - e.clientX));
                //t2.width(w2 + (x - e.clientX));

                //if (fix) {
                //    var idx = t1.index();
                //    $(".data table col").eq(idx).attr('width', t1.width() + 2);
                //    //$(".data table col").eq(idx + 1).attr('width', t2.width() + 2);
                //}
            }
        }
    });

    $(document).keydown(function (e) {
        var target = $(":focus");
        if (_gridCurrentCell == null && target.length == 0) return;

        var grid = target.parents(".grid:first");
        if (grid.length == 0) return;

        var tabMode = grid.data("TabMode");
        var headerColumns = grid.find("thead tr th.header");
        var tagName = target.prop("tagName");

        var cell = target.parents("td:first");
        var focusMode = 'control';
        if (tagName == 'TD') {
            focusMode = 'cell';
            cell = target;
        }

        var cellIndex = cell.index();
        var row = cell.parent();


        var direction = '';
        var nextTarget;
        var containCurrentCell = false;
        var findNextRow = true;

        if (e.keyCode == 27) {
            e.preventDefault();

            if (focusMode == 'control') {
                var empty = $("<input style='width:0px; height:0px; position:absolute; top:0px; left:0px; z-index:0;'/>");
                $('body').append(empty);
                empty.focus();
                empty.remove();

                cell.focus();
                cell.click();
            }
            else {
                _gridCurrentCell = null;
                grid.find("tbody.item .selected").removeClass("selected");
            }
            return;
        }


        if (e.keyCode == 13) {
            if (tagName == "SELECT" || tagName == "TEXTAREA") return;

            e.preventDefault();

            //var nextRow = false;
            //var headerColumn = headerColumns.eq(cellIndex);
            //
            //if (tabMode == null) {
            //    
            //}
            //else {
            //    if (body.find("thead tr th.grid-tabbable:last")[0] == headerColumn[0]) {
            //        nextRow = true;
            //    }
            //}
            //
            //if (nextRow) {
            //    row = row.next();
            //    cell = row.find("td:first");
            //    containCurrentCell = true;
            //}

            if (focusMode == 'cell') {
                containCurrentCell = true;
            }

            if (e.altKey || e.shiftKey) {
                direction = 'left';
            }
            else {
                direction = 'right';
            }

        }

        if (e.keyCode == 38 || e.keyCode == 40) {
            if (tagName == "SELECT" || tagName == "TEXTAREA") return;
            if (e.keyCode == 38) {//위
                row = row.prev();
            }
            else {
                row = row.next();
            }
            _library.SelectGridRow(row);
            cell = row.find("td").eq(cellIndex);
            direction = 'left';
            containCurrentCell = true;
        }
        else if (focusMode == 'cell') {

            if (e.keyCode == 37) {
                direction = 'left';
            }
            else if (e.keyCode == 39) {
                direction = 'right';
            }
        }

        if (direction != '') {
            e.preventDefault();

            while (true) {
                if (!containCurrentCell) {
                    if (direction == 'left') {
                        cell = cell.prev();
                    }
                    else {
                        cell = cell.next();
                    }
                }
                else {
                    containCurrentCell = false;
                }

                if (cell.length == 0) {
                    if (direction == 'left') {
                        row = row.prev();
                        cell = row.find("td:last");
                    }
                    else {
                        row = row.next();
                        cell = row.find("td:first");
                    }
                    if (row.length == 0) break;
                }

                if (focusMode == 'control' && tabMode == "Alter") {
                    var idx = cell.index();
                    if (!headerColumns.eq(idx).hasClass("grid-tabbable")) {
                        continue;
                    }
                }

                if (focusMode == 'cell' && e.keyCode != 13) {
                    break;
                }
                else {
                    nextTarget = cell.find("input,select,textarea");
                    if (nextTarget.length > 0) break;
                }

            }
        }

        if (nextTarget != null && nextTarget.length > 0) {
            nextTarget.focus();
            if (nextTarget[0].tagName == "INPUT") {
                if (!nextTarget.hasClass("search-user") || !nextTarget.hasClass("search-partno")) {
                    setTimeout(function () {
                        nextTarget.select();
                    }, 1);

                }
            }
        }
        else {
            if (focusMode == 'control') {

            }
            else {
                cell.focus();
                cell.click();
            }
        }
    });

    $(".grid-prepend-row").click(function () {
        var name = $(this).data("grid");

        _library.AddGridRow(name, true);
    });

    $(".grid-add-row").click(function () {
        var name = $(this).data("grid");

        _library.AddGridRow(name);
    });

    $(".grid-copy-row").click(function () {
        var name = $(this).data("grid");

        _library.CopyGridRow(name);
    });

    $(".grid-command-excel").click(function (e) {
        e.preventDefault();
        _library.SubmitGrid('Excel');
    });

    $(".grid-command-excel-html").click(function (e) {
        e.preventDefault();
        _library.SubmitGrid('ExcelHtml');
        $("[name='Grid.Command']").val('');
    });

});