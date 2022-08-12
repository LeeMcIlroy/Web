

function onPaging(form, pageIndex) {
    form.PageIndex.value = pageIndex;
    form.method = "get";
    form.submit();
}

// 설명 : 같은 이름의 input가 있을때 모든 name의 값이 있는지를 체크한다.
// 변수 :
//      - inputName : Html 태그 이름
//      - message : 같이 없는 항목이 있을때 보여주는 메세지
// 반환 :
//      - Bool : 빈값이 없으면 true, 있으면 false
function onCheckMultipleNameBlankValues(inputName, message) {
    var returnVaild = true;
    $("input[name=" + inputName + "]").each(function (idx) {
        var value = $(this).val();

        if (value == "") {
            alert(message);
            $(this).focus();
            returnVaild = false;
            return false;
        }
    });
    return returnVaild;
}

function onCheckMultipleNameDoubleValues(inputName, message) {
    var returnVaild = true;
    $("input[name=" + inputName + "]").each(function (idx) {
        var pattern = /^-?(\d{1,12}([.]\d{0,2})?)?$/;
        var value = $(this).val();

        if (!pattern.test(value)) {
            alert(message);
            $(this).focus();
            returnVaild = false;
            return false;
        }
    });
    return returnVaild;
}
 
function onCheckInputDoubleTextValues(message) {
    var returnVaild = true;
    $(':text').each(function (idx) {
        var pattern = /^-?(\d{1,12}([.]\d{0,2})?)?$/;
        var value = $(this).val();

        if (!pattern.test(value)) {
            alert($(this).attr('alt') + ' ' + message);
            $(this).focus();
            returnVaild = false;
            return false;
        }
    });
    return returnVaild;
}

function onCheckInputTextValues(message) {
    var returnVaild = true;
    $(':text').each(function (idx) {
        var pattern = /^-?(\d{1,12}([.]\d{0,0})?)?$/;
        var value = $(this).val();

        if (!pattern.test(value)) {
            alert($(this).attr('name') + ' ' + message);
            $(this).focus();
            returnVaild = false;
            return false;
        }
    });
    return returnVaild;
}

function onCheckMultipleNameIntValues(inputName, message) {
    var returnVaild = true;
    $("input[name=" + inputName + "]").each(function (idx) {
        var pattern = /^-?(\d{1,12}([.]\d{0,0})?)?$/;
        var value = $(this).val();

        if (!pattern.test(value)) {
            alert(message);
            $(this).focus();
            returnVaild = false;
            return false;
        }
    });
    return returnVaild;
}
function onCheckMultipleNameDoubleValuesById(idx, id, message) {
    var returnVaild = true;
    $("#"+idx+"_"+id).each(function (idx) {
        var pattern = /^-?(\d{1,12}([.]\d{0,2})?)?$/;
        var value = $(this).val();

        if (!pattern.test(value)) {
            alert(message);
            $(this).focus();
            returnVaild = false;
            return false;
        }
    });
    return returnVaild;
} 
function setNhnSmartEditor(obj, id, folderName) {
    //스마트에디터 프레임생성
    nhn.husky.EZCreator.createInIFrame({
        oAppRef: obj,
        elPlaceHolder: id,
        sSkinURI: "/Contents/SiteMngHome/Common/se/SmartEditor2Skin.html",
        htParams: {
            // 저장 폴더 경로
            sFolder: folderName,
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseToolbar: true,
            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer: true,
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger: true,
            fOnBeforeUnload: function () { } // 이페이지 나오기 alert 삭제
        }
    });
}
