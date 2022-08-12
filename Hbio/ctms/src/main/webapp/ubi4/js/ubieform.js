var __ubi_EFORM_DATA = "50";
var __ubi_EFORM_VERSION = "4.0.2103.1801";
var __ubi_EFORM_NM = "UbiEFormViewer";
var __ubi_DEBUG = true;
function _ubi_XmlToString(oXML) {
    if (window.ActiveXObject) {
        var oString = oXML.xml;
        if (oString == undefined || oString == "undefined") {
            return(new XMLSerializer()).serializeToString(oXML);
        } else {
            return oString;
        }
    } else {
        return(new XMLSerializer()).serializeToString(oXML);
    }
};
var ubireport = {};
ubireport.eform = {};
ubireport.eform.Viewer = Base.extend({
    _arghash: new UbiMap(),
    _datasets: [],
    _reportxml: null,
    _editcanvases: [],
    _drawoption: {
        startEdit: false,
        isEraser: false,
        startEraser: false
    },
    _themeColor: [
        "#ff0000",
        "#ff8000",
        "#ffff00",
        "#00ff00",
        "#0000ff",
        "#0000a0",
        "#8000ff",
        "#d0d0d0",
        "#a0a0a0",
        "#000000"
    ],
    _themeWidth: [
        1,
        5,
        10,
        15,
        20
    ],
    _themeOpacity: [
        10,
        20,
        30,
        50,
        100
    ],
    _tabIndex: 0,
    
    _val:0, //추가
    _previousPreviewFrameWidth: 0,
    _previousPreviewScale: 0,
    batchSignPad: {
        headerContents: '',
        footerContents: '',
        event: {
            OnConfirm: null,
            OnCancel: null
        }
    },
    constructor: function (params, styles, events, edit) {
        this.params = {
            reqtype: __ubi_EFORM_DATA,
            cHJvY2lk: "GATEWAY",
            iseform: "true",
            viewerNm: params.viewerNm || "eformViewer",
            key: params.key || "",
            ubiserverurl: params.ubiserverurl || "",
            saveurl: params.saveurl || "",
            timeout: params.timeout || "600000",
            jrffile: params.jrffile || "",
            masterfilename: params.masterfilename || "",
            resid: params.resid || "",
            arg: params.arg || "",
            ismultireport: params.ismultireport || "false",
            multicount: params.multicount || "1",
            ismultireportpaging: params.ismultireportpaging || "true",
            exportseq: params.exportseq || "",
            reporttitle: params.reporttitle || "",
            toolbar: params.toolbar || "true",
            resource: params.resource || "",
            divid: params.divid || params.div.id,
            scale: params.scale || "PageWidth",
            isencrypt: params.isencrypt || "false",
            isencrypt64: params.isencrypt64 || "false",
            bgcolor: params.bgcolor || "#E4E4E4",
            bgimage: params.bgimage || "",
            scrollpage: params.scrollpage || "true",
            direction: params.direction || "",
            language: params.language || "ko",
            pageinfo: params.pageinfo || "true",
            pageunit: params.pageunit || "false",
            statusinfo: params.statusinfo || "false",
            height: params.height || "",
            iswa: params.iswa || "false",
            password: params.password || "",
            fontElement: params.fontElement || "",
            userHeader: params.userHeader || "",
            streamdata: params.streamdata || "",
            clienttype: params.clienttype || "",
            datasetinfos: params.datasetinfos || "",
            runtimedata: params.runtimedata || "",
            imageid: "",
            printurl: params.printurl || "",
            skin: params.skin || "standard",
            userscale: params.userscale || "0",
            flicking: params.flicking || "false",
            printlimit: params.printlimit || "20",
            imagescale: params.imagescale || "100",
            isexportchartimage: params.isexportchartimage || "true",
            sheetname: params.sheetname || "",
            exceladjustpage: params.exceladjustpage || "false",
            excelExportLineItem: params.excelExportLineItem || "false",
            excelPrintPaperSize: params.excelPrintPaperSize || "",
            excelPrintfitWidth: params.excelPrintfitWidth || "",
            excelPrintfitHeight: params.excelPrintfitHeight || "",
            excelSheetPerReport: params.excelSheetPerReport || "false",
            excelSheetPerMasterPage: params.excelSheetPerMasterPage || "false",
            excelSheetPerPage: params.excelSheetPerPage || "false",
            excelSkipMasterItem: params.excelSkipMasterItem || "false",
            excelSheetPerPageCount: params.excelSheetPerPageCount || "100",
            tiffType: params.tiffType || "GROUP3_2D",
            tiffPerPage: params.tiffPerPage || "false",
            hmlTableProtect: params.hmlTableProtect || "false",
            hmlTextWrap: params.hmlTextWrap || "InFrontOfText",
            isvoiceye: params.isvoiceye || "false",
            isredbc: params.isredbc || "false",
            drmdocnumber: params.drmdocnumber || "",
            drmdocname: params.drmdocname || "",
            drmpagenames: params.drmpagenames || "",
            useplugin: params.useplugin || "false",
            usepluginsave: params.usepluginsave || "false",
            pluginprogress: params.pluginprogress || "false",
            printIEobj: params.printIEobj || "false",
            useAdobeReader: params.useAdobeReader || "true",
            serviceid: ""
        };
        if (styles == undefined) 
            styles = {};
        
        this.styles = {
            margin: styles.margin || "10",
            pagegap: styles.pagegap || "10",
            pageborder: styles.pageborder || "true",
            pagebordercolor: styles.pagebordercolor || "#A0A0A0",
            toolbarbgcolor: styles.toolbarbgcolor || "#ffffff"
        };
        if (events == undefined) 
            events = {};
        
        this.events = {
            pageMove: events.pageMove,
            saveStart: events.saveStart,
            saveEnd: events.saveEnd,
            linkButtonDown: events.linkButtonDown
        };
        if (edit == undefined) {
            edit = {};
        }
        if (edit.theme == undefined) {
            edit.theme = {
                color: [],
                width: [],
                opacity: []
            };
        }
        this.edit = {
            penColor: edit.penColor || 10,
            penWidth: edit.penWidth || 2,
            penOpacity: edit.penOpacity || 5,
            theme: {
                color: edit.theme.color || [],
                width: edit.theme.width || [],
                opacity: edit.theme.opacity || []
            }
        };
        this.topId = this.params.divid;
        var params = this.params;
        var styles = this.styles;
        for (var viewerIndex in __ubi_viewers) {
            if (__ubi_viewers[viewerIndex]) {
                if (eformDivId == __ubi_viewers[viewerIndex].topId) {
                    __ubi_viewers[viewerIndex]._destroy();
                    __ubi_viewers[viewerIndex] = null;
                }
            }
        }
        __ubi_viewers[this.topId] = this;
        _ubi_AddEvent(window, "resize", function () {
            __ubi_viewers[params.divid]._resize();
        });
        this.page = 1;
        this.totalPage = 0;
        this.toolbarHeight = 60;
        this.msgWidth = 380;
        this.msgHeight = 122;
        this.msg = "";
        this.divMain = null;
        this.divToolbar = null;
        this.divPreviewFrame = null;
        this.divPageInfo = null;
        this.divStatusInfo = null;
        this.divLoadImage = null;
        this.divMsg = null;
        this.toolbar = null;
        this.doc = null;
        this.eformNm = __ubi_EFORM_NM;
        this.divMainTop = 0;
        this.divMainLeft = 0;
        this.divMain = document.getElementById(params.divid);
        var divMain = this.divMain;
        this.divMainTop = this
            .divMain
            .getBoundingClientRect()
            .top;
        this.divMainLeft = this
            .divMain
            .getBoundingClientRect()
            .left;
        this
            .divMain
            .style
            .width = "calc(100vw)";
        if (this.params.height == "") {
            this
                .divMain
                .style
                .height = ("calc(100vh - " + this.divMainTop + "px)");
        } else if (parseInt(this.params.height) < 0) {
            this
                .divMain
                .style
                .height = ("calc(100vh - " + (
                this.divMainTop + (parseInt(this.params.height) * -1)
            ) + "px)");
        } else 
            this
                .divMain
                .style
                .height = (parseInt(this.params.height) + "px");
        
        this.divToolbar = document.createElement("div");
        var divToolbar = this.divToolbar;
        divToolbar.id = this.eformNm + "_Toolbar";
        if (params.toolbar == "false") {
            this.toolbarHeight = 0;
            divToolbar.style.display = "none";
        }
        divMain.appendChild(divToolbar);
        this.toolbar = new UbiEformToolbar(this);
        this.divStatusInfo = document.createElement("div");
        var divStatusInfo = this.divStatusInfo;
        divStatusInfo.id = this.eformNm + "_StatusInfo";
        divStatusInfo.className = "editstatus-wrap";
        divStatusInfo.style.display = "none";
        var divEditStatus = document.createElement("div");
        divEditStatus.className = "editstatus";
        var divDisplayTitle = document.createElement("span");
        divDisplayTitle.innerHTML = "펜 쓰기 모드 상태입니다.";
        divEditStatus.appendChild(divDisplayTitle);
        divStatusInfo.appendChild(divEditStatus);
        divMain.appendChild(divStatusInfo);
        this.divPageInfo = document.createElement("div");
        var divPageInfo = this.divPageInfo;
        divPageInfo.id = this.eformNm + "_PageInfo";
        divPageInfo.className = "navigation-wrap";
        divPageInfo.style.display = "none";
        var divPageNavi = document.createElement("div");
        divPageNavi.className = "navigation";
        var divPageCurrent = document.createElement("span");
        divPageCurrent.id = "page_current";
        divPageCurrent.className = "page-now";
        divPageCurrent.innerHTML = "1";
        var divPageDim = document.createElement("span");
        divPageDim.innerHTML = "&nbsp;/&nbsp;";
        var divPageAll = document.createElement("span");
        divPageAll.id = "page_all";
        divPageAll.className = "page-all";
        divPageAll.innerHTML = "1";
        divPageNavi.appendChild(divPageCurrent);
        divPageNavi.appendChild(divPageDim);
        divPageNavi.appendChild(divPageAll);
        divPageInfo.appendChild(divPageNavi);
        divMain.appendChild(divPageInfo);
        this.divPreviewFrame = document.createElement("div");
        var divPreviewFrame = this.divPreviewFrame;
        divPreviewFrame.id = this.eformNm + "_PreviewFrame";
        this._setPreviewFrame();
        divMain.appendChild(divPreviewFrame);
        var tmpviewer = this;
        _ubi_AddEvent(divPreviewFrame, "scroll", function () {
            clearTimeout(tmpviewer._scrollUpdateTimerID);
            tmpviewer._scrollUpdateTimerID = setTimeout(function () {
                tmpviewer._scrollUpdate();
            }, 100);
        });
        if (!_ubi_lowerIE9()) {
            _ubi_AddEvent(divPreviewFrame, "touchmove", function (evt) {
                evt.stopPropagation();
            });
            _ubi_AddEvent(divPreviewFrame, "mousewheel", function (evt) {
                evt.stopPropagation();
            });
        }
        this.divLoadImage = document.createElement("div");
        var loadImgWidth = 54;
        var loadImgHeight = 55;
        var divLoadImage = this.divLoadImage;
        divLoadImage.style.display = "none";
        divLoadImage.style.position = "absolute";
        divLoadImage.style.left = (this.divMainLeft + (parseInt(this.divMain.clientWidth) - loadImgWidth) / 2) + 'px';
        divLoadImage.style.top = (this.divMainTop + (parseInt(this.divMain.clientHeight) - loadImgHeight) / 2) + 'px';
        divLoadImage.style.width = loadImgWidth + "px";
        divLoadImage.style.height = loadImgHeight + "px";
        divLoadImage.style.margin = "0 auto";
        var loadImg = "<img src='" + params.resource + "/images/eform/page_loading.gif' width='" + loadImgWidth + "px' height='" + loadImgHeight + "px'>";
        divLoadImage.innerHTML = loadImg;
        divMain.appendChild(divLoadImage);
    },
    _setPreviewFrame: function () {
        this
            .divPreviewFrame
            .style
            .width = this
            .divMain
            .style
            .width;
        if (this.params.height == "") {
            if (this.params.toolbar == "false") {
                this
                    .divPreviewFrame
                    .style
                    .height = parseInt(this.divMain.clientHeight) + "px";
                if (this
                        .divMain
                        .style
                        .height
                            .indexOf("calc") == -1) {
                    this
                        .divPreviewFrame
                        .style
                        .height = (window.innerHeight - this.divMainTop) + "px";
                }
            } else if (parseInt(this.divMain.clientWidth) <= 640) {
                this
                    .divPreviewFrame
                    .style
                    .height = (parseInt(this.divMain.clientHeight) - 42) + "px";
                if (this
                        .divMain
                        .style
                        .height
                            .indexOf("calc") == -1) {
                    this
                        .divPreviewFrame
                        .style
                        .height = (window.innerHeight - this.divMainTop - 42) + "px";
                }
            } else {
                this
                    .divPreviewFrame
                    .style
                    .height = (parseInt(this.divMain.clientHeight) - 60) + "px";
                if (this
                        .divMain
                        .style
                        .height
                            .indexOf("calc") == -1) {
                    this
                        .divPreviewFrame
                        .style
                        .height = (window.innerHeight - this.divMainTop - 60) + "px";
                }
            }
        } else {
            if (this.params.toolbar == "false") {
                this
                    .divPreviewFrame
                    .style
                    .height = parseInt(this.divMain.clientHeight) + "px";
            } else if (parseInt(this.divMain.clientWidth) <= 640) {
                this
                    .divPreviewFrame
                    .style
                    .height = (parseInt(this.divMain.clientHeight) - 42) + "px";
            } else {
                this
                    .divPreviewFrame
                    .style
                    .height = (parseInt(this.divMain.clientHeight) - 60) + "px";
            }
        }
    },
    _jobStart: function () {
        this.toolbar.enableDimBg(true);
        this
            .divLoadImage
            .style
            .display = "";
        var loadImgWidth = 54;
        var loadImgHeight = 55;
        this
            .divLoadImage
            .style
            .left = (this.divMainLeft + (parseInt(this.divMain.clientWidth) - loadImgWidth) / 2) + 'px';
        this
            .divLoadImage
            .style
            .top = (this.divMainTop + (parseInt(this.divMain.clientHeight) - loadImgHeight) / 2) + 'px';
    },
    _jobEnd: function () {
        if (this.params.pageinfo == "true") {
            if (this.getViewerStatus()) 
                this
                    .divPageInfo
                    .style
                    .display = "";
            
            this
                .divPreviewFrame
                .style
                .marginTop = "-70px";
        }
        this.toolbar.enableDimBg(false);
        this
            .divLoadImage
            .style
            .display = "none";
    },
    _resize: function () {
        if (this
                .divLoadImage
                .style
                .display == "") {
            var loadImgWidth = 54;
            var loadImgHeight = 55;
            this
                .divLoadImage
                .style
                .left = (this.divMainLeft + (parseInt(this.divMain.clientWidth) - loadImgWidth) / 2) + 'px';
            this
                .divLoadImage
                .style
                .top = (this.divMainTop + (parseInt(this.divMain.clientHeight) - loadImgHeight) / 2) + 'px';
        }
        this._setPreviewFrame();
        if (this._drawoption.startEdit || this.toolbar.isOpenPenConfigLayer()) {
            this.toolbar.enableEditbar(true);
        } else {
            if (this
                    .toolbar
                    .divEditbar
                    .style
                        .display == "") 
                this.toolbar.enableEditbar(false);
            
        }
        try {
            if (this.params) {
                if (this.toolbar) {
                    var scale = this.toolbar.getCurrScale();
                    if (scale == "PageWidth" || scale == "WholePage") {
                        var viewer = this;
                        setTimeout(function () {
                            viewer._changeScale();
                        }, 100);
                    }
                }
            }
        } catch (e) {}
    },
    _destroy: function () {
        _ubi_RemoveAddEvent(this.divPreviewFrame, "scroll", this._scrollUpdate);
        this.toolbar._destroy();
    },
    _getArguments: function () {
        var arghash = new UbiMap();
        if (this._arghash && this._arghash.GetCount() > 0) {
            if (this._arghash) {
                for (i = 0; i < this._arghash.GetCount(); i ++) {
                    arghash.SetAt(this._arghash.GetKey(i), this._arghash.GetValue(i));
                }
            }
            var argArray = [];
            for (i = 0; i < arghash.GetCount(); i ++) {
                argArray.push(arghash.GetKey(i));
                argArray.push('#');
                argArray.push(arghash.GetValue(i));
                argArray.push('#');
            }
            return argArray.join('');
        }
        return this.params.arg;
    },
    _getDatasets: function () {
        if (this._datasets && this._datasets.length > 0) {
            var _rs_ = String.fromCharCode(30);
            var _nrs_ = String.fromCharCode(28);
            var datasetinfos = [];
            datasetinfos.push("HTMLLOCALDATASET:" + _rs_);
            for (var i = 0; i < this._datasets.length; i++) {
                datasetinfos.push(this._datasets[i][0]);
                datasetinfos.push(_rs_ + this._datasets[i][2] + _rs_);
                datasetinfos.push(this._datasets[i][1]);
                datasetinfos.push(_nrs_);
            }
            return datasetinfos.join('');
        }
        return this.params.streamdata;
    },
    _showErrorDialog: function (title, msg) {
        this.toolbar.openPopupBox("ERROR", msg);
    },
    _createPreview: function (page) {
        var divPreview = document.createElement("div");
        divPreview.id = this.eformNm + "_Preview_" + page;
        divPreview.setAttribute("isloaded", "false");
        if (_ubi_strToBool(this.styles.pageborder)) {
            divPreview.style.border = "1px solid " + this.styles.pagebordercolor;
        }
        divPreview.style.backgroundColor = "#ffffff";
        divPreview.style.marginRight = "auto";
        divPreview.style.marginLeft = "auto";
        if (page > 1 && this.styles.pagegap != "") {
            divPreview.style.marginTop = this.styles.pagegap + "px";
        }
        if (_ubi_strToInt(this.styles.margin) > 0) {
            if (page == 1) {
                divPreview.style.marginTop = this.styles.margin + "px";
            }
            if (page == this.totalPage || _ubi_strToBool(this.params.scrollpage) == false) {
                divPreview.style.marginBottom = this.styles.margin + "px";
            }
        }
        divPreview.style.position = "relative";
        divPreview.style.overflow = "hidden";
        divPreview.style.display = "none";
        this.divPreviewFrame.appendChild(divPreview);
        return divPreview;
    },
    _drawPage: function (preview, page) {
        if (!this.doc || !this.doc.pages || this
                .doc
                .pages
                .GetSize() < 1) {
            return;
        }
        var scale = this.toolbar.getCurrScale();
        var previewFrameHeight = this.divPreviewFrame.clientHeight;
        var previewFrameWidth = this.divPreviewFrame.clientWidth;
        var previewFrameScrollHeight = this.divPreviewFrame.scrollHeight;
        this._previousPreviewFrameWidth = previewFrameWidth;
        this._previousPreviewScale = scale;
        if (!__ubi_isMobile && (scale == "PageWidth" || scale == "WholePage")) {
            if (previewFrameHeight >= previewFrameScrollHeight) 
                previewFrameWidth -= 17;
            
        }
        var previewFrameMargin = 2;
        var baseScale = 2.0;
        var ds = 1.0;
        var previewFrameBorderWidth = 0;
        if (_ubi_strToBool(this.styles.pageborder)) 
            previewFrameBorderWidth = 2;
        
        if (scale != "PageWidth" && scale != "WholePage") {
            scale = parseInt(scale * 1.33);
            ds = parseInt(scale) / 100;
            this.ds = ds;
        }
        if (_ubi_strToInt(this.styles.margin) > 0) {
            previewFrameMargin = parseInt(this.styles.margin) * 2;
        }
        var doc = this.doc;
        var pageObj = doc.pages.GetAt(page - 1);
        if (pageObj) {
            var pageWidth = pageObj.width;
            var pageHeight = pageObj.height;
            var previewds = 1.0;
            if (scale == "PageWidth") {
                ds = (previewFrameWidth - previewFrameMargin) / pageWidth;
            } else if (scale == "WholePage") {
                ds = Math.min((previewFrameHeight - previewFrameMargin - previewFrameBorderWidth) / pageHeight, (previewFrameWidth - previewFrameMargin - previewFrameBorderWidth) / pageWidth);
            }
            var width = pageWidth * ds;
            var height = pageHeight * ds;
            var svgWidth = 0;
            var svgHeight = 0;
            var pageScale = ds / baseScale;
            preview.style.width = (width) + "px";
            preview.style.height = (height) + "px";
            if (! preview.iscreate) {
                preview.innerHTML = pageObj.contents;
            }
            if (preview.children && preview.children[0]) {
                var svgObj = preview.children[0];
                var svgWidth = parseInt(svgObj.getAttribute("orgwidth"));
                var svgHeight = parseInt(svgObj.getAttribute("orgheight"));
                svgWidth = svgWidth / baseScale * ds;
                svgHeight = svgHeight / baseScale * ds;
                svgObj.setAttribute("width", width);
                svgObj.setAttribute("height", height);
                svgObj.style.position = "absolute";
                svgObj.style.left = "0px";
                svgObj.style.top = "0px";
                if (__ubi_isIE) {
                    svgObj.setAttribute("letter-spacing", (-0.15 * baseScale * 2) + "px");
                } else {
                    svgObj.setAttribute("letter-spacing", (-0.15 * baseScale) + "px");
                }
                var gObj = svgObj.childNodes;
                if (gObj) {
                    for (var i = 0; i < gObj.length; i++) {
                        if (gObj[i].tagName == "g") {
                            gObj = gObj[i];
                            break;
                        }
                    }
                    gObj.setAttribute("transform", "scale(" + pageScale + ")");
                }
            }
            var editSvg = document.getElementById(this.eformNm + "_PreviewPageEdit_" + page);
            var gObj = null;
            if (! editSvg) {
                pageObj.editcanvasid = this.eformNm + "_PreviewPageEdit_" + page;
                editSvg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
                editSvg.id = this.eformNm + "_PreviewPageEdit_" + page;
                editSvg.style.position = "absolute";
                editSvg.style.left = "0px";
                editSvg.style.top = "0px";
                editSvg.setAttribute("width", width);
                editSvg.setAttribute("height", height);
                editSvg.setAttribute("pagescale", pageScale);
                editSvg.setAttribute("basescale", baseScale);
                editSvg.setAttribute("basescale2", ds);
                editSvg.setAttribute("divid", preview.id);
                gObj = document.createElementNS("http://www.w3.org/2000/svg", "g");
                editSvg.appendChild(gObj);
                preview.appendChild(editSvg);
                _ubi_eform_editCapture(this, editSvg);
            } else {
                editSvg.setAttribute("width", width);
                editSvg.setAttribute("height", height);
                editSvg.setAttribute("pagescale", pageScale);
                editSvg.setAttribute("basescale", baseScale);
                editSvg.setAttribute("basescale2", ds);
                gObj = editSvg.childNodes[0];
            }
            if (gObj) {
                editSvg.setAttribute("pagescale", pageScale);
                editSvg.setAttribute("basescale", baseScale);
                editSvg.setAttribute("basescale2", ds);
                for (var i = 0; i < gObj.length; i++) {
                    if (gObj[i].tagName == "g") {
                        gObj = gObj[i];
                        break;
                    }
                }
                gObj.setAttribute("transform", "scale(" + pageScale + ")");
            }
            var inputDiv = document.getElementById(this.eformNm + "_PreviewPageInput_" + page);
            if (! inputDiv) {
                inputDiv = document.createElement("div");
                inputDiv.id = this.eformNm + "_PreviewPageInput_" + page;
                inputDiv.style.height = preview.style.height;
                inputDiv.style.width = preview.style.width;
                inputDiv.style.position = "absolute";
                inputDiv.style.left = "0px";
                inputDiv.style.top = "0px";
                preview.appendChild(inputDiv);
            } else {
                inputDiv.style.height = preview.style.height;
                inputDiv.style.width = preview.style.width;
                inputDiv.style.position = "absolute";
                inputDiv.style.left = "0px";
                inputDiv.style.top = "0px";
            } _ubi_eform_drawInputItems(this, doc, page, inputDiv, ds);
        }
        if (this.params.pageunit == "true") {
            if (page == 1) 
                preview.style.display = "";
             else 
                preview.style.display = "none";
            
        } else 
            preview.style.display = "";
         preview.iscreate = true;
    },
    _changeInputMode: function () {
        if (!this.doc || !this.doc.pages || this
                .doc
                .pages
                .GetSize() < 1) {
            return;
        }
        var inputobj = null;
        var editobj = null;
        for (var i = 1; i <= this.totalPage; i++) {
            inputobj = document.getElementById(this.eformNm + "_PreviewPageInput_" + i);
            editobj = document.getElementById(this.eformNm + "_PreviewPageEdit_" + i);
            inputobj.style.zIndex = 1;
            editobj.style.zIndex = 0;
        }
        this._drawoption.startEdit = false;
        this._drawoption.isEraser = false;
        if (this.params.statusinfo == "true") 
            this
                .divStatusInfo
                .style
                .display = "none";
        
    },
    _changeEditMode: function () {
        if (!this.doc || !this.doc.pages || this
                .doc
                .pages
                .GetSize() < 1) {
            return;
        }
        var inputobj = null;
        var editobj = null;
        for (var i = 1; i <= this.totalPage; i++) {
            inputobj = document.getElementById(this.eformNm + "_PreviewPageInput_" + i);
            editobj = document.getElementById(this.eformNm + "_PreviewPageEdit_" + i);
            inputobj.style.zIndex = 0;
            editobj.style.zIndex = 1;
        }
        this._drawoption.startEdit = true;
        this._drawoption.isEraser = false;
        if (this.params.statusinfo == "true") {
            if (!this.toolbar.isActiveButton("SAVE") && !this.toolbar.isActiveButton("PEN")) {} else 
                this
                    .divStatusInfo
                    .style
                    .display = "";
            
        }
    },
    _setEraser: function () {
        this._drawoption.isEraser = true;
    },
    _setPen: function () {
        this._drawoption.isEraser = false;
    },
    _movePage: function (page) {
        var currPreview = document.getElementById(this.eformNm + "_Preview_" + this.page);
        var preview = document.getElementById(this.eformNm + "_Preview_" + page);
        var previewFrameTop = this
            .divPreviewFrame
            .getBoundingClientRect()
            .top;
        if (preview) {
            if (page == 1) 
                this.divPreviewFrame.scrollTop = 0;
             else 
                this.divPreviewFrame.scrollTop = preview.offsetTop - parseInt(this.styles.pagegap) - previewFrameTop;
            
        }
        if (this.params.pageunit == "true") {
            currPreview.style.display = "none";
            preview.style.display = "";
        }
        this.page = page;
    },
    _changeScale: function () {
        if (this.totalPage < 1) 
            return;
        
        var scale = this.toolbar.getCurrScale();
        if (__ubi_isMobile && scale == this._previousPreviewScale && (scale == "PageWidth" || scale == "WholePage")) {
            if (this.divPreviewFrame.clientWidth == this._previousPreviewFrameWidth) {
                return;
            }
        }
        for (var i = 1; i <= this.totalPage; i++) {
            var preview = null;
            preview = document.getElementById(this.eformNm + "_Preview_" + i);
            if (preview) {
                this._drawPage(preview, i);
            }
        }
    },
    _scrollUpdate: function () {
        if (_ubi_strToBool(this.params.scrollpage) && !_ubi_strToBool(this.params.pageunit)) {
            var pagegap = this.styles.pagegap;
            var frameHeight = this.divPreviewFrame.clientHeight;
            var previewFrameTop = this
                .divPreviewFrame
                .getBoundingClientRect()
                .top;
            var previewFrameHeight = (frameHeight - (pagegap * (this.totalPage + 1))) / this.totalPage;
            var pageNum = 0;
            var pagePos = 0;
            for (var k = 1; k <= this.totalPage; k++) {
                pagePos = document
                    .getElementById(this.eformNm + "_Preview_" + k)
                    .getBoundingClientRect()
                    .top;
                if (pagePos > 0) 
                    break;
                
            }
            if (parseInt(pagePos) < (parseInt(self.innerHeight) / 2)) {
                pageNum = Math.min(this.totalPage, k);;
            } else {
                pageNum = Math.min(this.totalPage, k - 1);
            }
            this.toolbar.setCurrPage(pageNum);
        }
    },
    setArgument: function (key, value) {
        if (key == '') 
            return;
        
        var replaceStr = String.fromCharCode(26) + '#'.charCodeAt(0) + String.fromCharCode(26);
        try {
            value = value.replace(/#/g, replaceStr);
        } catch (e) {}
        this._arghash.SetAt(key, value);
    },
    clearDataset: function () {
        this._datasets = [];
    },
    setDataset: function (id, data, datatype) {
        if (! id || id == '') {
            if (__ubi_DEBUG) 
                console.log('[setDataset]ID가 정의되지 않았습니다.');
            
            return;
        }
        if (! datatype) {
            datatype = "STREAM";
        }
        datatype = datatype.trim();
        if (datatype == '') {
            datatype = "STREAM";
        }
        if (! data) {
            data = '';
        }
        this._datasets.push([id, data, datatype]);
    },
    setVisibleToolbar: function (id, flag) {
        switch (id) {
            case "SAVE":
                this.toolbar.setVisibleButton("SAVE_BOX", flag);
                break;
            case "ZOOMIN":
                this.toolbar.setVisibleButton("ZOOMIN", flag);
                break;
            case "ZOOMOUT":
                this.toolbar.setVisibleButton("ZOOMOUT", flag);
                break;
            case "SCALE":
                this.toolbar.setVisibleButton("SCALE", flag);
                break;
            case "NAVI":
                this.toolbar.setVisibleButton("NAVI_BOX", flag);
                break;
            case "NAVI_FIRST":
                this.toolbar.setVisibleButton("NAVI_FIRST", flag);
                break;
            case "NAVI_PREVIOUS":
                this.toolbar.setVisibleButton("NAVI_PREVIOUS", flag);
                break;
            case "NAVI_NEXT":
                this.toolbar.setVisibleButton("NAVI_NEXT", flag);
                break;
            case "NAVI_LAST":
                this.toolbar.setVisibleButton("NAVI_LAST", flag);
                break;
            case "OPEN_EDITBAR":
                this.toolbar.setVisibleButton("OPEN_EDITBAR", flag);
                break;
            case "EDITBAR":
                this.toolbar.setVisibleButton("EDITBAR", flag);
                break;
            case "ABOUT":
                this.toolbar.setVisibleButton("ABOUT", flag);
                break;
        }
    },
    showReport: function (callback) {
        function createControl(xml, viewer) {
            viewer._reportxml = xml;
            viewer.divPreviewFrame.innerHTML = "";
            var doc = UbiEformDoc.CreateInstance(xml, true);
            viewer.doc = doc;
            viewer.totalPage = doc.pagecount;
            for (var i = 1; i <= viewer.totalPage; i++) {
                var preview = viewer._createPreview(i);
                viewer._drawPage(preview, i);
            }
            viewer.toolbar.setCurrPage(1);
            viewer.toolbar.setTotalPage(viewer.totalPage);
        };
        function requestReport(viewer) {
            var isError = false;
            var reqDatatype = "xml";
            var params = _ubi_clone(viewer.params);
            params.arg = viewer._getArguments();
            params.streamdata = viewer._getDatasets();
            _ubi_ajax({
                type: "POST",
                datatype: reqDatatype,
                timeout: params.timeout,
                url: params.ubiserverurl,
                reqdata: params,
                exportseq: "",
                onSuccess: function (xml) {
                    viewer.serviceValid = true;
                    if (xml == null) {
                        viewer._showErrorDialog("", _ubi_getMessage(viewer.params.language, "CreateErrMsg"));
                        isError = true;
                    } else {
                        createControl(xml, viewer);
                        viewer.exportSeq = this.exportseq;
                        viewer.params.exportseq = this.exportseq;
                    }
                },
                onComplete: function () {
                    viewer._jobEnd();
                    if (callback) {
                        try {
                            callback();
                        } catch (e) {}
                    }
                },
                onError: function (msg) {
                    viewer.serviceValid = false;
                    if (msg.indexOf("ER0") == -1) {
                        msg = "ER0901#Unknown error. Check UbiServer URL.";
                        viewer._showErrorDialog("알수없는 오류가 발생하였습니다.", msg);
                        return;
                    } else {
                        msg = msg.split("#")[0] + " : " + msg.split("#")[1];
                        viewer._showErrorDialog("", msg);
                    } viewer.toolbar.setEnableButton("SAVE_BOX", false);
                    viewer.toolbar.setEnableButton("SAVE", false);
                    viewer.toolbar.setEnableButton("NAVI_FIRST", false);
                    viewer.toolbar.setEnableButton("NAVI_PREVIOUS", false);
                    viewer.toolbar.setEnableButton("NAVI_NEXT", false);
                    viewer.toolbar.setEnableButton("NAVI_LAST", false);
                    viewer.toolbar.setEnableButton("PEN", false);
                    viewer.toolbar.setEnableButton("PEN_CONFIG", false);
                    viewer.toolbar.setEnableButton("ERASER", false);
                    viewer.toolbar.setEnableButton("OPEN_EDITBAR", false);
                    viewer.toolbar.setEnableButton("V_PEN", false);
                    viewer.toolbar.setEnableButton("V_PEN_CONFIG", false);
                    viewer.toolbar.setEnableButton("V_ERASER", false);
                    viewer.setVisibleToolbar("SCALE", false);
                }
            });
        };
        if (this.params.scale != this.toolbar.getCurrScale()) {
            this.toolbar.setCurrScale(this.params.scale);
        }
        if ((this.params.toolbar == false && this.toolbarHeight != 0) || (this.params.toolbar == true && this.toolbarHeight == 0)) {
            this.setToolbar(this.params.toolbar);
        }
        this.exportSeq = -1;
        this.params.reqtype = __ubi_EFORM_DATA;
        var d = new Date();
        this.params.exportseq = d.getTime();
        this._jobStart();
        requestReport(this, callback);
    },
    saveReport: function () {
        function requestSaveReport(viewer) {
            var rxml = viewer._reportxml;
            var isError = false;
            var reqDatatype = "text";
            var params = _ubi_clone(viewer.params);
            params.arg = viewer._getArguments();
            params.reportxml = _ubi_XmlToString(rxml);
            _ubi_ajax({
                type: "POST",
                datatype: reqDatatype,
                timeout: params.timeout,
                url: params.saveurl,
                reqdata: params,
                errmessage: "",
                filename: "",
                onSuccess: function (msg) {
                    msg = msg.trim();
                    if (msg.indexOf("FILENAME") != -1) {
                        this.filename = msg.substring(msg.indexOf("#") + 1, msg.length);
                        this.errmessage = "";
                    } else if (msg.indexOf("ER1") == -1) {
                        this.errmessage = msg.substring(msg.indexOf("#", msg.indexOf("ER1")) + 1);
                    }
                },
                onComplete: function () {
                    viewer._jobEnd();
                    if (this.errmessage != "") {
                        viewer._showErrorDialog("", this.errmessage);
                    } else {
                        viewer.toolbar.setEnableButton("SAVE_BOX", false);
                        viewer.toolbar.setEnableButton("SAVE", false);
                        viewer.toolbar.setEnableButton("PEN", false);
                        viewer.toolbar.setEnableButton("PEN_CONFIG", false);
                        viewer.toolbar.setEnableButton("ERASER", false);
                        viewer.toolbar.setEnableButton("OPEN_EDITBAR", false);
                        viewer.toolbar.setEnableButton("V_PEN", false);
                        viewer.toolbar.setEnableButton("V_PEN_CONFIG", false);
                        viewer.toolbar.setEnableButton("V_ERASER", false);
                        viewer._changeEditMode();
                        viewer._drawoption.startEdit = false;
                        var msg = "정상적으로 저장되었습니다.";
                        viewer.toolbar.openPopupBox("NOTICE", msg);
                        opener.location.reload();
                        window.close();
                        if (viewer.events.saveEnd) {
                            try {
                                viewer.events.saveEnd(this.filename);
                            } catch (e) {}
                        }
                    }
                },
                onError: function (msg) {
                    if (msg.indexOf("ER1") == -1) {
                        var msg = "ER0901#Unknown error. Check UbiServer URL.";
                    } else {
                        msg = msg.split("#")[0] + " : " + msg.split("#")[1];
                    } viewer.toolbar.openPopupBox("ERROR", msg);
                }
            });
        };
        var rtn = true;
        if (this.events.saveStart) {
            try {
                rtn = this.events.saveStart();
                if (rtn == undefined) {
                    rtn = true;
                }
            } catch (e) {}
        }
        if (! rtn) {
            return;
        }
        if (_ubi_eform_checkValidInputItems(this.doc)) {
            this._jobStart();
            requestSaveReport(this);
        }
    },
    checkFieldOnPage: function (page) {
        return _ubi_eform_checkValidInputItemsOnPage(this.doc, page);
    },
    showBatchSignPad: function () {
        _ubi_eform_showBatchSignPopup(this);
    },
    hideBatchSignPad: function () {
        _ubi_eform_hideBatchSignPopup(this);
    },
    moveFirstPage: function () {
        this.toolbar.first();
    },
    movePreviousPage: function () {
        this.toolbar.previous();
    },
    moveNextPage: function () {
        this.toolbar.next();
    },
    moveLastPage: function () {
        this.toolbar.last();
    },
    getViewerStatus: function () {
        return this.serviceValid;
    }
});
function UbiEformToolbar(ubiviewer) {
    var viewer = ubiviewer;
    var eformNm = viewer.eformNm;
    this.buttons = [];
    this.buttonArray = [];
    this.boxArray = [];
    this.buttontds = [];
    this.buttonVisibles = [];
    this.zoomCombo = null;
    this.pageCombo = null;
    this.toolbarObj = null;
    this.scaleValues = [];
    this.scaleDispValues = [];
    this.scaleIndex = 13;
    this.page = 0;
    this.divDim = null;
    this.divPenConfigLayer = null;
    this.divPenPanel = null;
    this.divEditbar = null;
    var infos = [];
    var toolbarfontstyle = "font-family: 맑은고딕, Tahoma; font-weight:normal; font-size:12px; letter-spacing:0em; color: #333333; -moz-user-select: none;";
    this.initToolbar = function () {
        this.makeToolbarUI();
        this.makeDimBg();
        this.makeErrorBox();
        this.makeNoticeBox();
        this.makeAboutBox();
        _ubi_AddEvent(document, "click", clicked);
    };
    this.makeToolbarUI = function () {
        var toolbarLeftSection = document.createElement("section");
        toolbarLeftSection.className = "grid lft";
        var saveObj = document.createElement("div");
        saveObj.id = eformNm + "_SaveBox";
        saveObj.className = "save";
        this.buttonArray["SAVE_BOX"] = saveObj;
        var saveBtn = document.createElement("a");
        saveBtn.id = eformNm + "_SaveBtn";
        saveBtn.className = (
            __ubi_isMobile
                ? "mbtn"
                : "btn"
        );
        saveBtn.style.backgroundImage = "url(" + viewer.params.resource + "/images/eform/btn_save.png)";
        saveBtn.title = "저장하기";
        var saveBtnSpan = document.createElement("span");
        saveBtnSpan.innerHTML = "저장하기";
        saveBtn.appendChild(saveBtnSpan);
        saveObj.appendChild(saveBtn);
        this.buttonArray["SAVE"] = saveBtn;
        toolbarLeftSection.appendChild(saveObj);
        var zoomObj = document.createElement("ul");
        zoomObj.className = "zoom";
        var zoominObj = document.createElement("li");
        zoominObj.id = eformNm + "_ZOOMIN";
        var zoominBtn = document.createElement("a");
        zoominBtn.className = (
            __ubi_isMobile
                ? "mbtn ic-zoomin"
                : "btn ic-zoomin"
        );
        zoominBtn.style.backgroundImage = "url(" + viewer.params.resource + "/images/eform/btn_zoomin.png)";
        zoominBtn.title = "확대하기";
        var zoominBtnSpan = document.createElement("span");
        zoominBtnSpan.innerHTML = "확대하기";
        zoominBtn.appendChild(zoominBtnSpan);
        zoominObj.appendChild(zoominBtn);
        this.buttonArray["ZOOMIN"] = zoominBtn;
        zoomObj.appendChild(zoominObj);
        var zoomoutObj = document.createElement("li");
        zoomoutObj.id = eformNm + "_ZOOMOUT";
        var zoomoutBtn = document.createElement("a");
        zoomoutBtn.className = (
            __ubi_isMobile
                ? "mbtn ic-zoomout"
                : "btn ic-zoomout"
        );
        zoomoutBtn.style.backgroundImage = "url(" + viewer.params.resource + "/images/eform/btn_zoomout.png)";
        zoomoutBtn.title = "축소하기";
        var zoomoutBtnSpan = document.createElement("span");
        zoomoutBtnSpan.innerHTML = "축소하기";
        zoomoutBtn.appendChild(zoomoutBtnSpan);
        zoomoutObj.appendChild(zoomoutBtn);
        this.buttonArray["ZOOMOUT"] = zoomoutBtn;
        zoomObj.appendChild(zoomoutObj);
        var scaleObj = document.createElement("li");
        scaleObj.className = "zoom-select-wrap";
        scaleObj.id = eformNm + "_Scale";
        var scaleBoxObj = document.createElement("div");
        scaleBoxObj.className = "selectbox zoom-selectbox";
        var sacleSelectedLabel = document.createElement("label");
        sacleSelectedLabel.className = "zoom-select";
        sacleSelectedLabel.innerHTML = "쪽 맞춤";
        sacleSelectedLabel.setAttribute("for", eformNm + "_ScaleSelctList");
        var scaleSelectList = document.createElement("select");
        scaleSelectList.style.cursor = "pointer";
        scaleSelectList.id = eformNm + "_ScaleSelctList";
        for (var i = 60; i <= 340; i += 20) {
            var scaleListOption = document.createElement("option");
            if (i <= 300) {
                scaleListOption.value = ("" + i);
                scaleListOption.innerHTML = (scaleListOption.value + "%");
                scaleSelectList.appendChild(scaleListOption);
                this.scaleValues.push(i);
                this.scaleDispValues.push(i + "%");
            } else if (i == 320) {
                scaleListOption.value = "PageWidth";
                scaleListOption.innerHTML = "너비에 맞춤";
                scaleSelectList.appendChild(scaleListOption);
                this.scaleValues.push("PageWidth");
                this.scaleDispValues.push("너비에 맞춤");
            } else if (i == 340) {
                scaleListOption.value = "WholePage";
                scaleListOption.innerHTML = "페이지 맞춤";
                scaleSelectList.appendChild(scaleListOption);
                this.scaleValues.push("WholePage");
                this.scaleDispValues.push("페이지 맞춤");
            }
        }
        for (var i = 0; i < scaleSelectList.options.length; i++) {
            if (scaleSelectList.options[i].value == viewer.params.scale) {
                scaleSelectList.selectedIndex = i;
                sacleSelectedLabel.textContent = scaleSelectList.options[scaleSelectList.selectedIndex].text;
            }
        }
        scaleBoxObj.appendChild(sacleSelectedLabel);
        scaleBoxObj.appendChild(scaleSelectList);
        scaleObj.appendChild(scaleBoxObj);
        this.buttonArray["SCALE"] = scaleObj;
        zoomObj.appendChild(scaleObj);
        toolbarLeftSection.appendChild(zoomObj);
        var toolbarCenterSection = document.createElement("section");
        toolbarCenterSection.className = "grid cen";
        var naviObj = document.createElement("ul");
        var naviFirstObj = document.createElement("li");
        naviFirstObj.id = eformNm + "_NaviFirst";
        var naviFirstBtn = document.createElement("a");
        naviFirstBtn.id = "_NaviFirstBtn";
        naviFirstBtn.className = (
            __ubi_isMobile
                ? "mbtn ic-first"
                : "btn ic-first"
        );
        naviFirstBtn.style.backgroundImage = "url(" + viewer.params.resource + "/images/eform/btn_first.png)";
        naviFirstBtn.title = "맨처음";
        var naviFirstBtnSpan = document.createElement("span");
        naviFirstBtnSpan.innerHTML = "맨처음";
        naviFirstBtn.appendChild(naviFirstBtnSpan);
        naviFirstObj.appendChild(naviFirstBtn);
        this.buttonArray["NAVI_FIRST"] = naviFirstBtn;
        naviObj.appendChild(naviFirstObj);
        var naviPreviousObj = document.createElement("li");
        naviPreviousObj.id = eformNm + "_NaviPrevious";
        var naviPreviousBtn = document.createElement("a");
        naviPreviousBtn.id = "_NaviPreviousBtn";
        naviPreviousBtn.className = (
            __ubi_isMobile
                ? "mbtn ic-prev"
                : "btn ic-prev"
        );
        naviPreviousBtn.style.backgroundImage = "url(" + viewer.params.resource + "/images/eform/btn_pre.png)";
        naviPreviousBtn.title = "이전";
        var naviPreviousBtnSpan = document.createElement("span");
        naviPreviousBtnSpan.innerHTML = "이전";
        naviPreviousBtn.appendChild(naviPreviousBtnSpan);
        naviPreviousObj.appendChild(naviPreviousBtn);
        this.buttonArray["NAVI_PREVIOUS"] = naviPreviousBtn;
        naviObj.appendChild(naviPreviousObj);
        var naviNextObj = document.createElement("li");
        naviNextObj.id = eformNm + "_NaviNext";
        var naviNextBtn = document.createElement("a");
        naviNextBtn.id = "_NaviNextBtn";
        naviNextBtn.className = (
            __ubi_isMobile
                ? "mbtn ic-next"
                : "btn ic-next"
        );
        naviNextBtn.style.backgroundImage = "url(" + viewer.params.resource + "/images/eform/btn_next.png)";
        naviNextBtn.title = "다음";
        var naviNextBtnSpan = document.createElement("span");
        naviNextBtnSpan.innerHTML = "다음";
        naviNextBtn.appendChild(naviNextBtnSpan);
        naviNextObj.appendChild(naviNextBtn);
        this.buttonArray["NAVI_NEXT"] = naviNextBtn;
        naviObj.appendChild(naviNextObj);
        var naviLastObj = document.createElement("li");
        naviLastObj.id = eformNm + "_NaviLast";
        var naviLastBtn = document.createElement("a");
        naviNextBtn.id = "_NaviLastBtn";
        naviLastBtn.className = (
            __ubi_isMobile
                ? "mbtn ic-last"
                : "btn ic-last"
        );
        naviLastBtn.style.backgroundImage = "url(" + viewer.params.resource + "/images/eform/btn_last.png)";
        naviLastBtn.title = "맨마지막";
        var naviLastBtnSpan = document.createElement("span");
        naviLastBtnSpan.innerHTML = "맨마지막";
        naviLastBtn.appendChild(naviLastBtnSpan);
        naviLastObj.appendChild(naviLastBtn);
        this.buttonArray["NAVI_LAST"] = naviLastBtn;
        naviObj.appendChild(naviLastObj);
        this.buttonArray["NAVI_BOX"] = naviObj;
        toolbarCenterSection.appendChild(naviObj);
        var toolbarRightSection = document.createElement("section");
        toolbarRightSection.className = "grid rht";
        var openEditbarObj = document.createElement("div");
        openEditbarObj.className = "edit-open";
        var openEditbarBtn = document.createElement("a");
        openEditbarBtn.id = eformNm + "_OpenEditbarBtn";
        openEditbarBtn.className = (
            __ubi_isMobile
                ? "mbtn ic-edit-open popop-open"
                : "btn ic-edit-open popop-open"
        );
        openEditbarBtn.style.backgroundImage = "url(" + viewer.params.resource + "/images/eform/menu_edit.png)";
        openEditbarBtn.title = "편집창 열기";
        var openEditbarTitle = document.createElement("span");
        openEditbarTitle.innerHTML = "편집창 열기";
        openEditbarBtn.appendChild(openEditbarTitle);
        openEditbarObj.appendChild(openEditbarBtn);
        this.buttonArray["OPEN_EDITBAR"] = openEditbarBtn;
        var editbarObj = document.createElement("div");
        editbarObj.className = "edit-wrap";
        editbarObj.style.top = viewer.divMainTop + "px";
        var closeEditbarObj = document.createElement("div");
        closeEditbarObj.className = "edit-close";
        var closeEditbarBtn = document.createElement("a");
        closeEditbarBtn.className = (
            __ubi_isMobile
                ? "mbtn ic-edit-close"
                : "editbtn ic-edit-close"
        );
        closeEditbarBtn.style.backgroundImage = "url(" + viewer.params.resource + "/images/eform/menu_edit_close.png)";
        closeEditbarBtn.title = "편집창 닫기";
        var closeEditbarTitle = document.createElement("span");
        closeEditbarTitle.innerHTML = "편집창 닫기";
        closeEditbarBtn.appendChild(closeEditbarTitle);
        closeEditbarObj.appendChild(closeEditbarBtn);
        this.buttonArray["CLOSE_EDITBAR"] = closeEditbarObj;
        var editbarMenuObj = document.createElement("ul");
        var vPenObj = document.createElement("li");
        var vPenBtn = document.createElement("a");
        vPenBtn.id = eformNm + "_VPenBtn";
        vPenBtn.className = (
            __ubi_isMobile
                ? "mbtn ic-edit"
                : "editbtn ic-edit"
        );
        vPenBtn.style.backgroundImage = "url(" + viewer.params.resource + "/images/eform/btn_edit.png)";
        vPenBtn.title = "펜 쓰기";
        var vPenTitle = document.createElement("span");
        vPenTitle.innerHTML = "펜 쓰기";
        vPenBtn.appendChild(vPenTitle);
        vPenObj.appendChild(vPenBtn);
        this.buttonArray["V_PEN"] = vPenBtn;
        var vPenConfigObj = document.createElement("li");
        var vPenConfigBtn = document.createElement("a");
        vPenConfigBtn.id = eformNm + "_VPenConfigBtn";
        vPenConfigBtn.className = (
            __ubi_isMobile
                ? "mbtn ic-setup popup-open"
                : "editbtn ic-setup popup-open"
        );
        vPenConfigBtn.style.backgroundImage = "url(" + viewer.params.resource + "/images/eform/btn_setting.png)";
        vPenConfigBtn.title = "펜 설정하기";
        var vPenConfigBtnSpan = document.createElement("span");
        vPenConfigBtnSpan.innerHTML = "펜 설정하기";
        vPenConfigBtn.appendChild(vPenConfigBtnSpan);
        vPenConfigObj.appendChild(vPenConfigBtn);
        this.buttonArray["V_PEN_CONFIG"] = vPenConfigBtn;
        var vEraserObj = document.createElement("li");
        var vEraserBtn = document.createElement("a");
        vEraserBtn.id = eformNm + "_VEraserBtn";
        vEraserBtn.className = (
            __ubi_isMobile
                ? "mbtn ic-eraser"
                : "editbtn ic-eraser"
        );
        vEraserBtn.style.backgroundImage = "url(" + viewer.params.resource + "/images/eform/btn_eraser.png)";
        vEraserBtn.title = "지우개";
        var vEraserBtnSpan = document.createElement("span");
        vEraserBtnSpan.innerHTML = "지우개";
        vEraserBtn.appendChild(vEraserBtnSpan);
        vEraserObj.appendChild(vEraserBtn);
        this.buttonArray["V_ERASER"] = vEraserBtn;
        editbarMenuObj.appendChild(vPenObj);
        editbarMenuObj.appendChild(vPenConfigObj);
        editbarMenuObj.appendChild(vEraserObj);
        editbarObj.appendChild(closeEditbarObj);
        editbarObj.appendChild(editbarMenuObj);
        openEditbarObj.appendChild(editbarObj);
        this.divEditbar = editbarObj;
        toolbarRightSection.appendChild(openEditbarObj);
        var editAreaObj = document.createElement("div");
        editAreaObj.className = "edit-wrap";
        var editMenuObj = document.createElement("ul");
        var penObj = document.createElement("li");
        var penBtn = document.createElement("a");
        penBtn.id = eformNm + "_PenBtn";
        penBtn.className = (
            __ubi_isMobile
                ? "mbtn ic-edit"
                : "editbtn ic-edit"
        );
        penBtn.style.backgroundImage = "url(" + viewer.params.resource + "/images/eform/btn_edit.png)";
        penBtn.title = "펜 쓰기";
        var penBtnSpan = document.createElement("span");
        penBtnSpan.innerHTML = "펜 쓰기";
        penBtn.appendChild(penBtnSpan);
        penObj.appendChild(penBtn);
        this.buttonArray["PEN"] = penBtn;
        var penConfigObj = document.createElement("li");
        var penConfigBtn = document.createElement("a");
        penConfigBtn.id = eformNm + "_PenConfigBtn";
        penConfigBtn.className = (
            __ubi_isMobile
                ? "mbtn ic-setup popup-open"
                : "editbtn ic-setup popup-open"
        );
        penConfigBtn.style.backgroundImage = "url(" + viewer.params.resource + "/images/eform/btn_setting.png)";
        penConfigBtn.title = "펜 설정하기";
        var penConfigBtnSpan = document.createElement("span");
        penConfigBtnSpan.innerHTML = "펜 설정하기";
        penConfigBtn.appendChild(penConfigBtnSpan);
        penConfigObj.appendChild(penConfigBtn);
        this.buttonArray["PEN_CONFIG"] = penConfigBtn;
        var eraserObj = document.createElement("li");
        var eraserBtn = document.createElement("a");
        eraserBtn.id = eformNm + "_EraserBtn";
        eraserBtn.className = (
            __ubi_isMobile
                ? "mbtn ic-eraser"
                : "editbtn ic-eraser"
        );
        eraserBtn.style.backgroundImage = "url(" + viewer.params.resource + "/images/eform/btn_eraser.png)";
        eraserBtn.title = "지우개";
        var eraserBtnSpan = document.createElement("span");
        eraserBtnSpan.innerHTML = "지우개";
        eraserBtn.appendChild(eraserBtnSpan);
        eraserObj.appendChild(eraserBtn);
        this.buttonArray["ERASER"] = eraserBtn;
        editMenuObj.appendChild(penObj);
        editMenuObj.appendChild(penConfigObj);
        editMenuObj.appendChild(eraserObj);
        editAreaObj.appendChild(editMenuObj);
        this.buttonArray["EDITBAR"] = editAreaObj;
        toolbarRightSection.appendChild(editAreaObj);
        var aboutObj = document.createElement("div");
        aboutObj.className = "version";
        var aboutBtn = document.createElement("a");
        aboutBtn.className = (
            __ubi_isMobile
                ? "mbtn ic-version popup-open"
                : "btn ic-version popup-open"
        );
        aboutBtn.style.backgroundImage = "url(" + viewer.params.resource + "/images/eform/btn_version.png)";
        aboutBtn.title = "버전확인";
        var aboutBtnSpan = document.createElement("span");
        aboutBtnSpan.innerHTML = "버전확인";
        aboutBtn.appendChild(aboutBtnSpan);
        aboutObj.appendChild(aboutBtn);
        this.buttonArray["ABOUT"] = aboutBtn;
        toolbarRightSection.appendChild(aboutObj);
        viewer.divToolbar.appendChild(toolbarLeftSection);
        viewer.divToolbar.appendChild(toolbarCenterSection);
        viewer.divToolbar.appendChild(toolbarRightSection);
        var penConfigLayer = document.createElement("div");
        penConfigLayer.id = eformNm + "_PenConfigLayer";
        viewer.divMain.appendChild(penConfigLayer);
        this.divPenConfigLayer = penConfigLayer;
        saveBtn.onclick = function () {
            if (viewer.getViewerStatus()) {
                if (! viewer.toolbar.isActiveButton("SAVE")) {
                    var msg = "저장 후에는 편집 및 새로 저장이 불가합니다.";
                    if (viewer._drawoption.startEdit) {
                        msg = "펜 쓰기 모드를 해제하고 저장해주세요.";
                    }
                    viewer.toolbar.openPopupBox("NOTICE", msg);
                } else {
                    viewer.saveReport();
                }
                
            }
        };
        zoominBtn.onclick = function () {
            if (viewer.getViewerStatus()) {
                var curIndex = scaleSelectList.selectedIndex;
                if (curIndex < 14) {
                    scaleSelectList.selectedIndex = (curIndex + 1);
                    var scale = scaleSelectList.options[scaleSelectList.selectedIndex].value;
                    var text = scaleSelectList.options[scaleSelectList.selectedIndex].text;
                    sacleSelectedLabel.textContent = text;
                    viewer.toolbar.changeScale(scale);
                } else {
                    var msg = "더 이상 확대할 수 없습니다.";
                    viewer.toolbar.openPopupBox("NOTICE", msg);
                }
            }
        };
        zoomoutBtn.onclick = function () {
            if (viewer.getViewerStatus()) {
                var curIndex = scaleSelectList.selectedIndex;
                if (curIndex > 0) {
                    scaleSelectList.selectedIndex = (curIndex - 1);
                    var scale = scaleSelectList.options[scaleSelectList.selectedIndex].value;
                    var text = scaleSelectList.options[scaleSelectList.selectedIndex].text;
                    sacleSelectedLabel.textContent = text;
                    viewer.toolbar.changeScale(scale);
                } else {
                    var msg = "더 이상 축소 할 수 없습니다.";
                    viewer.toolbar.openPopupBox("NOTICE", msg);
                }
            }
        };
        scaleBoxObj.onclick = function () {
            scaleBoxObj.classList.add('on');
        };
        scaleSelectList.onblur = function () {
            scaleBoxObj.classList.remove('on');
        };
        scaleSelectList.onchange = function () {
            var scale = scaleSelectList.options[scaleSelectList.selectedIndex].value;
            var text = scaleSelectList.options[scaleSelectList.selectedIndex].text;
            sacleSelectedLabel.textContent = text;
            viewer.toolbar.changeScale(scale);
        };
        naviFirstBtn.onclick = function () {
            if (viewer.getViewerStatus()) {
                if (viewer.toolbar.page == 1) {
                    var msg = "현재 첫 페이지입니다.";
                    viewer.toolbar.openPopupBox("NOTICE", msg);
                } else 
                    viewer.toolbar.first();
                
            }
        };
        naviPreviousBtn.onclick = function () {
            if (viewer.getViewerStatus()) {
                if (viewer.toolbar.page == 1) {
                    var msg = "현재 첫 페이지입니다.";
                    viewer.toolbar.openPopupBox("NOTICE", msg);
                } else 
                    viewer.toolbar.previous();
                
            }
        };
        naviNextBtn.onclick = function () {
            if (viewer.getViewerStatus()) {
                if (viewer.toolbar.page == viewer.totalPage) {
                    var msg = "현재 마지막 페이지입니다.";
                    viewer.toolbar.openPopupBox("NOTICE", msg);
                } else 
                    viewer.toolbar.next();
                
            }
        };
        naviLastBtn.onclick = function () {
            if (viewer.getViewerStatus()) {
                if (viewer.toolbar.page == viewer.totalPage) {
                    var msg = "현재 마지막 페이지입니다.";
                    viewer.toolbar.openPopupBox("NOTICE", msg);
                } else 
                    viewer.toolbar.last();
                
            }
        };
        openEditbarBtn.onclick = function () {
            if (viewer.getViewerStatus()) {
                if (! viewer.toolbar.isActiveButton("OPEN_EDITBAR")) {
                    var msg = "저장 후에는 편집이 불가합니다.";
                    viewer.toolbar.openPopupBox("NOTICE", msg);
                } else {
                    viewer.toolbar.enableEditbar(true);
                    openEditbarBtn.style.display = 'none';
                    editbarObj.style.opacity = 0.5;
                }
            }
        };
        closeEditbarBtn.onclick = function () {
            viewer.toolbar.enableEditbar(false);
            if (viewer._drawoption.isEraser) {
                viewer.toolbar.setFocusButton("ERASER", false);
                viewer.toolbar.setFocusButton("V_ERASER", false);
            } else if (viewer._drawoption.startEdit) {
                viewer.toolbar.setFocusButton("PEN", false);
                viewer.toolbar.setFocusButton("V_PEN", false);
            }
            viewer._changeInputMode();
            viewer.toolbar.setEnableButton("SAVE_BOX", true);
            viewer.toolbar.setEnableButton("SAVE", true);
            openEditbarBtn.style.display = '';
            editbarObj.style.opacity = 1;
        };
        penBtn.onclick = vPenBtn.onclick = function () {
            if (viewer.toolbar.divPenPanel == null) {
                viewer.toolbar.initPenPanel();
            }
            if (viewer.getViewerStatus()) {
                if (! viewer.toolbar.isActiveButton("PEN")) {
                    var msg = "저장 후에는 편집이 불가합니다.";
                    viewer.toolbar.openPopupBox("NOTICE", msg);
                } else {
                    viewer.toolbar.enablePenConfigLayer(false);
                    viewer.toolbar.setFocusButton("PEN_CONFIG", false);
                    viewer.toolbar.setFocusButton("V_PEN_CONFIG", false);
                    viewer.toolbar.setFocusButton("ERASER", false);
                    viewer.toolbar.setFocusButton("V_ERASER", false);
                    if (! viewer._drawoption.startEdit) {
                      //  viewer.toolbar.setEnableButton("SAVE_BOX", false);
                      //  viewer.toolbar.setEnableButton("SAVE", false);
                        viewer.toolbar.setEnableButton("SAVE_BOX", true);
                        viewer.toolbar.setEnableButton("SAVE", true);
                        viewer.toolbar.setFocusButton("PEN", true);
                        viewer.toolbar.setFocusButton("V_PEN", true);
                        viewer._changeEditMode();
                        viewer
                            .divPreviewFrame
                            .style
                            .cursor = 'url("' + viewer.params.resource + '/images/eform/pen.cur"),auto';
                    } else {
                        if (viewer._drawoption.isEraser) {
                            viewer.toolbar.setFocusButton("ERASER", false);
                            viewer.toolbar.setFocusButton("V_ERASER", false);
                            viewer._changeInputMode();
                            viewer._setPen();
                            viewer.toolbar.setFocusButton("PEN", true);
                            viewer.toolbar.setFocusButton("V_PEN", true);
                            viewer._changeEditMode();
                            viewer
                                .divPreviewFrame
                                .style
                                .cursor = 'url("' + viewer.params.resource + '/images/eform/pen.cur"),auto';
                        } else {
                            viewer.toolbar.setEnableButton("SAVE_BOX", true);
                            viewer.toolbar.setEnableButton("SAVE", true);
                            viewer.toolbar.setFocusButton("PEN", false);
                            viewer.toolbar.setFocusButton("V_PEN", false);
                            viewer._changeInputMode();
                            viewer
                                .divPreviewFrame
                                .style
                                .cursor = 'auto';
                            penBtn.style.backgroundColor = '';
                        }
                    }
                }
            }
        };
        penConfigBtn.onclick = vPenConfigBtn.onclick = function () {
            if (viewer.toolbar.divPenPanel == null) {
                viewer.toolbar.initPenPanel();
            }
            if (viewer.getViewerStatus()) {
                if (! viewer.toolbar.isActiveButton("PEN_CONFIG")) {
                    var msg = "저장 후에는 편집이 불가합니다.";
                    viewer.toolbar.openPopupBox("NOTICE", msg);
                } else {
                    if (viewer.toolbar.isOpenPenConfigLayer()) {
                        viewer.toolbar.enablePenConfigLayer(false);
                        viewer.toolbar.setFocusButton("PEN_CONFIG", false);
                        viewer.toolbar.setFocusButton("V_PEN_CONFIG", false);
                        if (viewer._drawoption.isEraser) {
                            viewer.toolbar.setFocusButton("ERASER", true);
                            viewer.toolbar.setFocusButton("V_ERASER", true);
                        } else if (viewer._drawoption.startEdit) {
                            viewer.toolbar.setFocusButton("PEN", true);
                            viewer.toolbar.setFocusButton("V_PEN", true);
                        }
                    } else {
                        viewer.toolbar.enablePenConfigLayer(true);
                        viewer.toolbar.setFocusButton("PEN_CONFIG", true);
                        viewer.toolbar.setFocusButton("V_PEN_CONFIG", true);
                        viewer.toolbar.setFocusButton("PEN", false);
                        viewer.toolbar.setFocusButton("V_PEN", false);
                        viewer.toolbar.setFocusButton("ERASER", false);
                        viewer.toolbar.setFocusButton("V_ERASER", false);
                        viewer._changeEditMode();
                        viewer
                            .divPreviewFrame
                            .style
                            .cursor = 'url("' + viewer.params.resource + '/images/eform/pen.cur"),auto';
                    }
                }
            }
        };
        eraserBtn.onclick = vEraserBtn.onclick = function () {
            if (viewer.getViewerStatus()) {
                if (! viewer.toolbar.isActiveButton("ERASER")) {
                    var msg = "저장 후에는 편집이 불가합니다.";
                    viewer.toolbar.openPopupBox("NOTICE", msg);
                } else {
                    viewer.toolbar.enablePenConfigLayer(false);
                    viewer.toolbar.setFocusButton("PEN", false);
                    viewer.toolbar.setFocusButton("V_PEN", false);
                    viewer.toolbar.setFocusButton("PEN_CONFIG", false);
                    viewer.toolbar.setFocusButton("V_PEN_CONFIG", false);
                    if (! viewer._drawoption.startEdit) {
                        viewer.toolbar.setEnableButton("SAVE_BOX", false);
                        viewer.toolbar.setEnableButton("SAVE", false);
                        viewer.toolbar.setFocusButton("ERASER", true);
                        viewer.toolbar.setFocusButton("V_ERASER", true);
                        viewer._changeEditMode();
                        viewer._setEraser();
                        viewer
                            .divPreviewFrame
                            .style
                            .cursor = 'url("' + viewer.params.resource + '/images/eform/eraser.cur"),auto';
                    } else {
                        if (viewer._drawoption.isEraser) {
                            viewer.toolbar.setEnableButton("SAVE_BOX", true);
                            viewer.toolbar.setEnableButton("SAVE", true);
                            viewer.toolbar.setFocusButton("ERASER", false);
                            viewer.toolbar.setFocusButton("V_ERASER", false);
                            viewer._changeInputMode();
                            viewer
                                .divPreviewFrame
                                .style
                                .cursor = 'auto';
                            viewer._setPen();
                        } else {
                            viewer.toolbar.setFocusButton("ERASER", true);
                            viewer.toolbar.setFocusButton("V_ERASER", true);
                            viewer._changeEditMode();
                            viewer
                                .divPreviewFrame
                                .style
                                .cursor = 'url("' + viewer.params.resource + '/images/eform/eraser.cur"),auto';
                            viewer._setEraser();
                        }
                    }
                }
            }
        };
        aboutBtn.onclick = function () {
            viewer.toolbar.openPopupBox("ABOUT", "");
        }
    };
    this.initPenPanel = function () {
        var penPanel = document.createElement("div");
        penPanel.className = "edit-setup";
        penPanel.id = eformNm + "_PenPanel";
        var penColorTitle = document.createElement("h4");
        penColorTitle.innerHTML = "색상선택";
        penPanel.appendChild(penColorTitle);
        var svgColorObj = document.createElementNS("http://www.w3.org/2000/svg", "svg");
        svgColorObj.setAttributeNS(null, "class", "setting01");
        var gColor1Obj = document.createElementNS("http://www.w3.org/2000/svg", "g");
        gColor1Obj.setAttributeNS(null, "transform", "translate(22,22)");
        var defaultColor = parseInt(viewer.edit.penColor);
        if (defaultColor < 1 || defaultColor > 10) 
            defaultColor = 3;
        
        for (var i = 1; i <= 5; i++) {
            var colors = [
                "#ef2121",
                "#ff8400",
                "#f6dc00",
                "#38ee00",
                "#005aff"
            ];
            var circleColorBg = document.createElementNS("http://www.w3.org/2000/svg", "circle");
            circleColorBg.setAttributeNS(null, "id", "option_color_bg_" + i);
            circleColorBg.setAttributeNS(null, "cx", ("" + (
                44 * (i - 1)
            )));
            circleColorBg.setAttributeNS(null, "cy", "0");
            circleColorBg.setAttributeNS(null, "r", "19");
            if (i == defaultColor) {
                circleColorBg.setAttributeNS(null, "stroke", "#eb6c6c");
                circleColorBg.setAttributeNS(null, "stroke-width", "5");
                viewer.edit.penColor = colors[i - 1];
            } else {
                circleColorBg.setAttributeNS(null, "stroke", "#dddddd");
                circleColorBg.setAttributeNS(null, "stroke-width", "1");
            } circleColorBg.setAttributeNS(null, "fill", "#ffffff");
            var circleColor = document.createElementNS("http://www.w3.org/2000/svg", "circle");
            circleColor.setAttributeNS(null, "id", ("option_color_" + i));
            circleColor.setAttributeNS(null, "cx", ("" + (
                44 * (i - 1)
            )));
            circleColor.setAttributeNS(null, "cy", "0");
            circleColor.setAttributeNS(null, "r", "13");
            circleColor.setAttributeNS(null, "fill", colors[i - 1]);
            gColor1Obj.appendChild(circleColorBg);
            gColor1Obj.appendChild(circleColor);
        }
        var gColor2Obj = document.createElementNS("http://www.w3.org/2000/svg", "g");
        gColor2Obj.setAttributeNS(null, "transform", "translate(22,66)");
        for (var i = 6; i <= 10; i++) {
            var colors = [
                "#0900c3",
                "#8100ef",
                "#c3c3c3",
                "#727272",
                "#000000"
            ];
            var circleColorBg = document.createElementNS("http://www.w3.org/2000/svg", "circle");
            circleColorBg.setAttributeNS(null, "id", "option_color_bg_" + i);
            circleColorBg.setAttributeNS(null, "cx", ("" + (
                44 * (i - 6)
            )));
            circleColorBg.setAttributeNS(null, "cy", "0");
            circleColorBg.setAttributeNS(null, "r", "19");
            if (i == defaultColor) {
                circleColorBg.setAttributeNS(null, "stroke", "#eb6c6c");
                circleColorBg.setAttributeNS(null, "stroke-width", "5");
                viewer.edit.penColor = colors[i - 6];
            } else {
                circleColorBg.setAttributeNS(null, "stroke", "#dddddd");
                circleColorBg.setAttributeNS(null, "stroke-width", "1");
            } circleColorBg.setAttributeNS(null, "fill", "#ffffff");
            var circleColor = document.createElementNS("http://www.w3.org/2000/svg", "circle");
            circleColor.setAttributeNS(null, "id", ("option_color_" + i));
            circleColor.setAttributeNS(null, "cx", ("" + (
                44 * (i - 6)
            )));
            circleColor.setAttributeNS(null, "cy", "0");
            circleColor.setAttributeNS(null, "r", "13");
            circleColor.setAttributeNS(null, "fill", colors[i - 6]);
            gColor2Obj.appendChild(circleColorBg);
            gColor2Obj.appendChild(circleColor);
        }
        svgColorObj.appendChild(gColor1Obj);
        svgColorObj.appendChild(gColor2Obj);
        penPanel.appendChild(svgColorObj);
        var penThicknessTitle = document.createElement("h4");
        penThicknessTitle.innerHTML = "선 두께";
        penPanel.appendChild(penThicknessTitle);
        var svgThicknessObj = document.createElementNS("http://www.w3.org/2000/svg", "svg");
        svgThicknessObj.setAttributeNS(null, "class", "setting02");
        var gThicknessObj = document.createElementNS("http://www.w3.org/2000/svg", "g");
        gThicknessObj.setAttributeNS(null, "transform", "translate(22,22)");
        var defaultWidth = parseInt(viewer.edit.penWidth);
        if (defaultWidth < 1 || defaultWidth > 5) 
            defaultWidth = 3;
        
        var penWidthSelected = false;
        for (var i = 1; i <= 5; i++) {
            var radiuses = [
                "2",
                "3",
                "5",
                "8",
                "10"
            ];
            var values = [
                "3",
                "5",
                "10",
                "15",
                "20"
            ];
            var circleThicknessBg1 = document.createElementNS("http://www.w3.org/2000/svg", "circle");
            circleThicknessBg1.setAttributeNS(null, "id", "option_thickness_bg1_" + i);
            circleThicknessBg1.setAttributeNS(null, "cx", ("" + (
                44 * (i - 1)
            )));
            circleThicknessBg1.setAttributeNS(null, "cy", "0");
            circleThicknessBg1.setAttributeNS(null, "r", "19");
            if (! penWidthSelected) {
                if (i == defaultWidth) {
                    circleThicknessBg1.setAttributeNS(null, "stroke", "#eb6c6c");
                    circleThicknessBg1.setAttributeNS(null, "stroke-width", "5");
                    viewer.edit.penWidth = values[i - 1];
                    penWidthSelected = true;
                } else {
                    circleThicknessBg1.setAttributeNS(null, "stroke", "#dddddd");
                    circleThicknessBg1.setAttributeNS(null, "stroke-width", "1");
                }
            } else {
                circleThicknessBg1.setAttributeNS(null, "stroke", "#dddddd");
                circleThicknessBg1.setAttributeNS(null, "stroke-width", "1");
            } circleThicknessBg1.setAttributeNS(null, "fill", "#ffffff");
            var circleThicknessBg2 = document.createElementNS("http://www.w3.org/2000/svg", "circle");
            circleThicknessBg2.setAttributeNS(null, "id", "option_thickness_bg2_" + i);
            circleThicknessBg2.setAttributeNS(null, "cx", ("" + (
                44 * (i - 1)
            )));
            circleThicknessBg2.setAttributeNS(null, "cy", "0");
            circleThicknessBg2.setAttributeNS(null, "r", "14");
            circleThicknessBg2.setAttributeNS(null, "fill", "#f3f3f9");
            var circleThickness = document.createElementNS("http://www.w3.org/2000/svg", "circle");
            circleThickness.setAttributeNS(null, "id", "option_thickness_" + i);
            circleThickness.setAttributeNS(null, "cx", ("" + (
                44 * (i - 1)
            )));
            circleThickness.setAttributeNS(null, "cy", "0");
            circleThickness.setAttributeNS(null, "r", radiuses[i - 1]);
            circleThickness.setAttributeNS(null, "fill", viewer.edit.penColor);
            circleThickness.setAttributeNS(null, "thick", values[i - 1]);
            gThicknessObj.appendChild(circleThicknessBg1);
            gThicknessObj.appendChild(circleThicknessBg2);
            gThicknessObj.appendChild(circleThickness);
        }
        svgThicknessObj.appendChild(gThicknessObj);
        penPanel.appendChild(svgThicknessObj);
        var penOpacityTitle = document.createElement("h4");
        penOpacityTitle.innerHTML = "투명도";
        penPanel.appendChild(penOpacityTitle);
        var svgOpacityObj = document.createElementNS("http://www.w3.org/2000/svg", "svg");
        svgOpacityObj.setAttributeNS(null, "class", "setting03");
        var gOpacityObj = document.createElementNS("http://www.w3.org/2000/svg", "g");
        gOpacityObj.setAttributeNS(null, "transform", "translate(0,0)");
        var defaultOpacity = parseInt(viewer.edit.penOpacity);
        if (defaultOpacity < 1 || defaultOpacity > 5) 
            defaultOpacity = 3;
        
        for (var i = 1; i <= 5; i++) {
            var colors = [
                "#0900c3",
                "#8100ef",
                "#c3c3c3",
                "#727272",
                "#000000"
            ];
            var opacities = [
                "0.1",
                "0.2",
                "0.3",
                "0.5",
                "1"
            ];
            var rectOpacityBg = document.createElementNS("http://www.w3.org/2000/svg", "rect");
            rectOpacityBg.setAttributeNS(null, "id", "option_opacity_bg_" + i);
            rectOpacityBg.setAttributeNS(null, "x", ("" + (
                44 * (i - 1) + 3
            )));
            rectOpacityBg.setAttributeNS(null, "y", "2");
            rectOpacityBg.setAttributeNS(null, "width", "38");
            rectOpacityBg.setAttributeNS(null, "height", "38");
            rectOpacityBg.setAttributeNS(null, "rx", "4");
            rectOpacityBg.setAttributeNS(null, "ry", "4");
            if (i == defaultOpacity) {
                rectOpacityBg.setAttributeNS(null, "stroke", "#eb6c6c");
                rectOpacityBg.setAttributeNS(null, "stroke-width", "5");
                viewer.edit.penOpacity = parseFloat(opacities[i - 1]);
            } else {
                rectOpacityBg.setAttributeNS(null, "stroke", "#dddddd");
                rectOpacityBg.setAttributeNS(null, "stroke-width", "1");
            } rectOpacityBg.setAttributeNS(null, "fill", "#ffffff");
            var imageOpacity = document.createElementNS("http://www.w3.org/2000/svg", "image");
            imageOpacity.setAttributeNS(null, "href", viewer.params.resource + "/images/eform/opacity_bg.png");
            imageOpacity.setAttributeNS(null, "width", "28");
            imageOpacity.setAttributeNS(null, "height", "28");
            imageOpacity.setAttributeNS(null, "x", ("" + (
                44 * (i - 1) + 8
            )));
            imageOpacity.setAttributeNS(null, "y", "7");
            var rectOpacityObj = document.createElementNS("http://www.w3.org/2000/svg", "rect");
            rectOpacityObj.setAttributeNS(null, "id", "option_opacity_" + i);
            rectOpacityObj.setAttributeNS(null, "x", ("" + (
                44 * (i - 1) + 8
            )));
            rectOpacityObj.setAttributeNS(null, "y", "7");
            rectOpacityObj.setAttributeNS(null, "width", "28");
            rectOpacityObj.setAttributeNS(null, "height", "28");
            rectOpacityObj.setAttributeNS(null, "rx", "2");
            rectOpacityObj.setAttributeNS(null, "ry", "2");
            rectOpacityObj.setAttributeNS(null, "fill", viewer.edit.penColor);
            rectOpacityObj.setAttributeNS(null, "opacity", opacities[i - 1]);
            gOpacityObj.appendChild(rectOpacityBg);
            gOpacityObj.appendChild(imageOpacity);
            gOpacityObj.appendChild(rectOpacityObj);
        }
        svgOpacityObj.appendChild(gOpacityObj);
        penPanel.appendChild(svgOpacityObj);
        viewer.toolbar.divPenPanel = penPanel;
        viewer
            .toolbar
            .divPenConfigLayer
            .appendChild(viewer.toolbar.divPenPanel);
        var colorSelect = document.querySelector('.setting01');
        var colorObj = colorSelect.querySelectorAll('circle');
        var thicknessSelect = document.querySelector('.setting02');
        var thicknessObj = thicknessSelect.querySelectorAll('circle');
        var opacitySelect = document.querySelector('.setting03');
        var opacityObj = opacitySelect.querySelectorAll('rect');
        for (var i = 1; i < colorObj.length; i++) {
            colorObj[i].addEventListener('click', function () {
                var objId = this.getAttribute('id');
                var index = objId.substring(objId.lastIndexOf('_') + 1);
                var thisColor = colorSelect.getElementById('option_color_' + index);
                var color = thisColor.getAttribute('fill');
                viewer.edit.penColor = color;
                for (var i = 1; i < 11; i++) {
                    var bgObj = colorSelect.getElementById('option_color_bg_' + i);
                    bgObj.setAttributeNS(null, 'stroke', '#dddddd');
                    bgObj.setAttributeNS(null, 'stroke-width', 1);
                }
                var thisBg = colorSelect.getElementById('option_color_bg_' + index);
                thisBg.setAttributeNS(null, 'stroke', '#eb6c6c');
                thisBg.setAttributeNS(null, 'stroke-width', 5);
                for (var i = 1; i < 6; i++) {
                    var thisTarget = thicknessSelect.getElementById('option_thickness_' + i);
                    thisTarget.setAttributeNS(null, 'fill', color);
                }
                for (var i = 1; i < 6; i++) {
                    var thisTarget = opacitySelect.getElementById('option_opacity_' + i);
                    thisTarget.setAttributeNS(null, 'fill', color);
                }
            });
        }
        for (var i = 1; i < thicknessObj.length; i++) {
            thicknessObj[i].addEventListener('click', function () {
                var objId = this.getAttribute('id');
                var index = objId.substring(objId.lastIndexOf('_') + 1);
                var thisThickness = thicknessSelect.getElementById('option_thickness_' + index);
                var thickness = thisThickness.getAttribute('thick');
                viewer.edit.penWidth = thickness;
                for (var i = 1; i < 6; i++) {
                    var bgObj = thicknessSelect.getElementById('option_thickness_bg1_' + i);
                    bgObj.setAttributeNS(null, 'stroke', '#dddddd');
                    bgObj.setAttributeNS(null, 'stroke-width', 1);
                }
                var thisBg = thicknessSelect.getElementById('option_thickness_bg1_' + index);
                thisBg.setAttributeNS(null, 'stroke', '#eb6c6c');
                thisBg.setAttributeNS(null, 'stroke-width', 5);
            });
        }
        for (var i = 1; i < opacityObj.length; i++) {
            opacityObj[i].addEventListener('click', function () {
                var objId = this.getAttribute('id');
                var index = objId.substring(objId.lastIndexOf('_') + 1);
                var thisOpacity = opacitySelect.getElementById('option_opacity_' + index);
                var opacity = thisOpacity.getAttribute('opacity');
                viewer.edit.penOpacity = opacity;
                for (var i = 1; i < 6; i++) {
                    var bgObj = opacitySelect.getElementById('option_opacity_bg_' + i);
                    bgObj.setAttributeNS(null, 'stroke', '#dddddd');
                    bgObj.setAttributeNS(null, 'stroke-width', 1);
                }
                var thisBg = opacitySelect.getElementById('option_opacity_bg_' + index);
                thisBg.setAttributeNS(null, 'stroke', '#eb6c6c');
                thisBg.setAttributeNS(null, 'stroke-width', 4);
            });
        }
    };
    this.makeDimBg = function () {
        var dimBgObj = document.createElement("div");
        dimBgObj.id = viewer.eformNm + "_DimBg";
        dimBgObj.className = "dim-bg";
        dimBgObj.style.width = viewer
            .divMain
            .style
            .width;
        dimBgObj.style.height = viewer
            .divMain
            .style
            .height;
        dimBgObj.style.left = viewer.divMainLeft + "px";
        dimBgObj.style.top = viewer.divMainTop + "px";
        viewer.divMain.appendChild(dimBgObj);
        this.divDim = dimBgObj;
        dimBgObj.onclick = function () {
            var visiblePopup = document.querySelectorAll('.is-on');
            for (var i = 0; i < visiblePopup.length; i++) {
                visiblePopup[i].classList.remove('is-on');
            }
            if (viewer._drawoption.isEraser) {
                viewer.toolbar.setFocusButton("ERASER", true);
                viewer.toolbar.setFocusButton("V_ERASER", true);
            } else if (viewer._drawoption.startEdit) {
                viewer.toolbar.setFocusButton("PEN", true);
                viewer.toolbar.setFocusButton("V_PEN", true);
            }
        }
    };
    this.makeErrorBox = function () {
        var errorBox = document.createElement("div");
        errorBox.id = viewer.eformNm + "_ErrorBox";
        errorBox.className = "pop-error";
        var str = [];
        var i = 0;
        str[i++] = "<div class=\"pop-container\">";
        str[i++] = "<h3 id=\"" + errorBox.id + "_Title\">Error</h3>";
        str[i++] = "<div class=\"pop-conts\">";
        str[i++] = "<a id=\"" + errorBox.id + "_BtnClose\" class=\"btn-layerClose popup-close\" style=\"background:url(" + viewer.params.resource + "/images/eform/pop_close.png) no-repeat 50% 50%;\" title=\"닫기\"><span>닫기</span></a>";
        str[i++] = "<p class=\"pop-txt\">";
        str[i++] = "<span id=\"" + errorBox.id + "_Contents\">" + _ubi_getMessage(viewer.params.language, "ErrMsg") + "</span>";
        str[i++] = "<span>&nbsp;</span>";
        str[i++] = "</p>";
        str[i++] = "<div class=\"btn-foot\"><a id=\"" + errorBox.id + "_BtnConfirm\" class=\"btn-footClose popup-close\" title=\"확인\">확인</a></div>";
        str[i++] = "</div>";
        errorBox.innerHTML = str.join("");
        viewer.divMain.appendChild(errorBox);
        var btnClose = document.getElementById(errorBox.id + "_BtnClose");
        btnClose.onclick = function () {
            viewer.toolbar.closePopupBox("ERROR");
        };
        var btnConfirm = document.getElementById(errorBox.id + "_BtnConfirm");
        btnConfirm.onclick = function () {
            viewer.toolbar.closePopupBox("ERROR");
        };
        this.boxArray["ERROR"] = errorBox;
    };
    this.makeNoticeBox = function () {
        var noticeBox = document.createElement("div");
        noticeBox.id = viewer.eformNm + "_NoticeBox";
        noticeBox.className = "pop-notice";
        var str = [];
        var i = 0;
        str[i++] = "<div class=\"pop-container\">";
        str[i++] = "<h3 id=\"" + noticeBox.id + "_Title\">Notice</h3>";
        str[i++] = "<div class=\"pop-conts\">";
        str[i++] = "<a id=\"" + noticeBox.id + "_BtnClose\" class=\"btn-layerClose popup-close\" style=\"background:url(" + viewer.params.resource + "/images/eform/pop_close.png) no-repeat 50% 50%;\" title=\"닫기\"><span>닫기</span></a>";
        str[i++] = "<p class=\"pop-txt\">";
        str[i++] = "<span id=\"" + noticeBox.id + "_Contents\"></span>";
        str[i++] = "<span>&nbsp;</span>";
        str[i++] = "</p>";
        str[i++] = "<div class=\"btn-foot\"><a id=\"" + noticeBox.id + "_BtnConfirm\" class=\"btn-footClose popup-close\" title=\"확인\">확인</a></div>";
        str[i++] = "</div>";
        noticeBox.innerHTML = str.join("");
        viewer.divMain.appendChild(noticeBox);
        var btnClose = document.getElementById(noticeBox.id + "_BtnClose");
        btnClose.onclick = function () {
            viewer.toolbar.closePopupBox("NOTICE");
        };
        var btnConfirm = document.getElementById(noticeBox.id + "_BtnConfirm");
        btnConfirm.onclick = function () {
            viewer.toolbar.closePopupBox("NOTICE");
        };
        this.boxArray["NOTICE"] = noticeBox;
    };
    this.makeAboutBox = function () {
        var aboutBox = document.createElement("div");
        aboutBox.id = viewer.eformNm + "_AboutBox";
        aboutBox.className = "pop-version";
        var str = [];
        var i = 0;
        str[i++] = "<div class=\"pop-container\">";
        str[i++] = "<h3>UbiReport</h3>";
        str[i++] = "<div class=\"pop-conts\">";
        str[i++] = "<a id=\"" + aboutBox.id + "_BtnClose\" class=\"btn-layerClose popup-close\" style=\"background:url(" + viewer.params.resource + "/images/eform/pop_close.png) no-repeat 50% 50%;\" title=\"닫기\"><span>닫기</span></a>";
        str[i++] = "<p class=\"pop-txt\">";
        str[i++] = ("<span>Build Version " + __ubi_EFORM_VERSION + "</span>");
        str[i++] = "<span>This copy is licensed to UbiDecision.</span>";
        str[i++] = "<a href=\"http://www.ubireport.com\" class=\"homelink\" target=\"_blank\" title=\"[새창]유비디시전홈페이지 바로가기\">www.ubireport.com</a>";
        str[i++] = "</p>";
        str[i++] = "<div class=\"btn-foot\"><a id=\"" + aboutBox.id + "_BtnConfirm\" class=\"btn-footClose popup-close\" title=\"version 확인\">확인</a></div>";
        str[i++] = "</div>";
        aboutBox.innerHTML = str.join("");
        viewer.divMain.appendChild(aboutBox);
        var btnClose = document.getElementById(aboutBox.id + "_BtnClose");
        btnClose.onclick = function () {
            viewer.toolbar.closePopupBox("ABOUT");
        };
        var btnConfirm = document.getElementById(aboutBox.id + "_BtnConfirm");
        btnConfirm.onclick = function () {
            viewer.toolbar.closePopupBox("ABOUT");
        };
        this.boxArray["ABOUT"] = aboutBox;
    };
    this.enableDimBg = function (flag) {
        if (__ubi_isIE && __ubi_ieVersion <= 9) {} else {
            if (flag) 
                this
                    .divDim
                    .classList
                    .add("is-on");
             else 
                this
                    .divDim
                    .classList
                    .remove("is-on");
            
        }
    };
    this.openPopupBox = function (id, msg) {
        var box = this.boxArray[id];
        if (box) {
            this.enableDimBg(true);
            box.classList.add("is-on");
            if (id != "ABOUT") 
                document.getElementById(box.id + "_Contents").innerHTML = msg;
            
        }
    };
    this.closePopupBox = function (id) {
        var box = this.boxArray[id];
        if (box) {
            this.enableDimBg(false);
            box.classList.remove("is-on");
        }
    };
    this.enablePenConfigLayer = function (flag) {
        if (flag) {
            this.enableDimBg(true);
            this
                .divPenConfigLayer
                .classList
                .add("is-on");
        } else {
            this.enableDimBg(false);
            this
                .divPenConfigLayer
                .classList
                .remove("is-on");
        }
    };
    this.enableEditbar = function (flag) {
        if (flag) 
            this
                .divEditbar
                .style
                .display = "block";
         else 
            this
                .divEditbar
                .style
                .display = "";
        
    };
    this.isOpenPenConfigLayer = function () {
        return(this.divPenConfigLayer.className == "is-on");
    };
    this.isActiveButton = function (id) {
        return(this
            .buttonArray[id]
            .className
            .indexOf("is-off") == -1);
    };
    this.setEnableButton = function (id, flag) {
        var button = this.buttonArray[id];
        if (button) {
            if (__ubi_isIE && __ubi_ieVersion <= 9) {} else {
                if (flag) {
                    button.classList.remove("is-off");
                    if (button
                            .style
                            .backgroundImage
                            .indexOf("_off.png") != -1) 
                        button.style.backgroundImage = button
                            .style
                            .backgroundImage
                            .replace("_off.png", ".png");
                    
                } else {
                    button.classList.add("is-off");
                    if (button
                            .style
                            .backgroundImage
                            .indexOf("_off.png") == -1) 
                        button.style.backgroundImage = button
                            .style
                            .backgroundImage
                            .replace(".png", "_off.png");
                    
                }
            }
        }
    };
    this.setVisibleButton = function (id, flag) {
        var button = this.buttonArray[id];
        if (button) {
            if (flag) {
                button.style.display = "";
            } else {
                button.style.display = "none";
            }
        }
    };
    this.setFocusButton = function (id, flag) {
        var button = this.buttonArray[id];
        if (button) {
            if (flag) 
                button.classList.add("is-on");
             else 
                button.classList.remove("is-on");
            
        }
    };
    this._destroy = function () {
        _ubi_RemoveAddEvent(document, "click", clicked);
    };
    this.setCurrScale = function (zoom) {
        var scaleValue = "PageWidth";
        this.scaleIndex = this.scaleValues.length - 2;
        var zoomStr = "" + zoom;
        if (zoomStr == "-9998") {
            zoomStr = "PageWidth";
        } else if (zoomStr == "-9999") {
            zoomStr = "WholePage";
        }
        var lowerValue = "";
        var lowerZoomValue = zoomStr.toLowerCase();
        for (var i = 0; i < this.scaleValues.length; i++) {
            lowerValue = ("" + this.scaleValues[i]).toLowerCase();
            if (lowerValue == lowerZoomValue) {
                scaleValue = this.scaleDispValues[i];
                this.scaleIndex = i;
                break;
            }
        }
        this.setEnableButton("ZOOMIN", false);
        this.setEnableButton("ZOOMOUT", false);
        if (viewer.totalPage > 0) {
            if (this.scaleIndex > 0) {
                this.setEnableButton("ZOOMOUT", true);
            }
            if (this.scaleIndex<(this.scaleValues.length-1)) { this.setEnableButton("ZOOMIN", true); } } }; this.getCurrScale=function() { return this.scaleValues[this.scaleIndex]; }; this.setCurrPage=function(page) { if (this.page != page) { this.page=page; document.getElementById("page_current").innerHTML=page; this.setStatus(); if (viewer.events.pageMove) { viewer.events.pageMove(page); } } }; this.setTotalPage=function(totalpage) { document.getElementById("page_all").innerHTML=totalpage; }; this.movePage=function(page) { if (page != this.page && page> 0 && page <= viewer.totalPage) {
                this.setCurrPage(page);
                viewer._movePage(page);
                this.setStatus();
            }
        };
        this.changeScale = function (scale) {
            if (viewer.totalPage < 1) 
                return;
            
            if (this.scaleValues[this.scaleIndex] != scale) {
                this.jobStart();
                setTimeout(function () {
                    viewer.toolbar.changeScaleJob(scale);
                }, 50);
            }
        };
        this.changeScaleJob = function (scale) {
            this.setCurrScale(scale);
            viewer._changeScale();
            this.jobEnd();
        };
        this.first = function () {
            if (viewer.totalPage > 0 && this.page != 1) {
                var page = 1;
                this.movePage(page);
            }
        };
        this.previous = function () {
            if (this.page > 1) {
                var page = this.page - 1;
                this.movePage(page);
            }
        };
        this.next = function () {
            if (this.page<viewer.totalPage) { var page=this.page+1; this.movePage(page); } }; this.last=function() { if (viewer.totalPage> 0 && this.page != viewer.totalPage) {
                var page = viewer.totalPage;
                this.movePage(page);
            }
        };
        this.zoomout = function () {
            if (this.scaleIndex > 0) {
                var scale = this.scaleValues[this.scaleIndex - 1];
                this.changeScale(scale);
            }
        };
        this.zoomin = function () {
            if ((this.scaleIndex + 1) < this.scaleValues.length) {
                var scale = this.scaleValues[this.scaleIndex + 1];
                this.changeScale(scale);
            }
        };
        this.setStatus = function () {
            if (this.page == viewer.totalPage || viewer.totalPage<= 1) { this.setEnableButton("NAVI_NEXT", false); this.setEnableButton("NAVI_LAST", false); } else { this.setEnableButton("NAVI_NEXT", true); this.setEnableButton("NAVI_LAST", true); } if (this.page == 1 || this.page == 0 || viewer.totalPage <= 1) { this.setEnableButton("NAVI_FIRST", false); this.setEnableButton("NAVI_PREVIOUS", false); } else { this.setEnableButton("NAVI_FIRST", true); this.setEnableButton("NAVI_PREVIOUS", true); } this.setEnableButton("ZOOMIN", false); this.setEnableButton("ZOOMOUT", false); if (viewer.totalPage > 0) { if (this.scaleIndex> 0) {
                this.setEnableButton("ZOOMOUT", true);
            }
            if (this.scaleIndex < (this.scaleValues.length - 1)) {
                this.setEnableButton("ZOOMIN", true);
            }
        }
    };
    this.jobStart = function () {};
    this.jobEnd = function () {};
    function clicked(e) {};
    this.initToolbar();
};
var UbiEformItemInfo = UbiObject.extend({
    name: "",
    type: 0,
    text: "",
    required: false,
    readonly: false,
    multiline: false,
    maxlength: 0,
    guidestring: "",
    description: "",
    groupname: "",
    codecolumns: [],
    datacolumns: [],
    batchinputids: [],
    value: "",
    page: 0,
    constructor: function (classname) {
        this.base(classname);
    }
}, {
    CLASSNAME: "UbiEformItemInfo",
    NODEEFORM: "EForm",
    ATTRNAME: "name",
    ATTRTYPE: "type",
    ATTRTEXT: "text",
    ATTRREQUIRED: "required",
    ATTRREADONLY: "readonly",
    ATTRMULTILINE: "multiline",
    ATTRMAXLENGTH: "maxlength",
    ATTRCODECOLUMN: "codecolumn",
    ATTRDATACOLUMN: "datacolumn",
    ATTRGUIDESTRING: "guidestring",
    ATTRDESCRIPTION: "description",
    ATTRGROUPNAME: "group",
    ATTRBATCHINPUTIDS: "batchinputids",
    TYPE_TEXT: 0,
    TYPE_RADIO: 1,
    TYPE_CHECKBOX: 2,
    TYPE_COMBOBOX: 3,
    TYPE_LIST: 4,
    TYPE_SIGNATURE: 5,
    TYPE_IMAGE: 6,
    CreateInstance: function (node, doc) {
        var data = UbiEformItemInfo.getData(node);
        var item = new UbiEformItemInfo();
        item.name = data.name;
        item.type = data.type;
        item.text = data.text;
        item.required = data.required;
        item.readonly = data.readonly;
        item.multiline = data.multiline;
        item.maxlength = data.maxlength;
        item.guidestring = data.guidestring;
        item.description = data.description;
        item.groupname = data.groupname;
        if (data.strbatchinputids) {
            item.batchinputids = data.strbatchinputids.split(',');
        }
        return item;
    },
    getData: function (node) {
        var attributes = node.attributes;
        return {
            name: getAttributeStringValue(attributes, UbiEformItemInfo.ATTRNAME),
            type: getAttributeIntValue(attributes, UbiEformItemInfo.ATTRTYPE),
            text: getAttributeIntValue(attributes, UbiEformItemInfo.ATTRTEXT),
            required: getAttributeBooleanValue(attributes, UbiEformItemInfo.ATTRREQUIRED),
            readonly: getAttributeBooleanValue(attributes, UbiEformItemInfo.ATTRREADONLY),
            multiline: getAttributeBooleanValue(attributes, UbiEformItemInfo.ATTRMULTILINE),
            maxlength: getAttributeIntValue(attributes, UbiEformItemInfo.ATTRMAXLENGTH, 0),
            guidestring: getAttributeStringValue(attributes, UbiEformItemInfo.ATTRGUIDESTRING),
            description: getAttributeStringValue(attributes, UbiEformItemInfo.ATTRDESCRIPTION),
            groupname: getAttributeStringValue(attributes, UbiEformItemInfo.ATTRGROUPNAME),
            strbatchinputids: getAttributeStringValue(attributes, UbiEformItemInfo.ATTRBATCHINPUTIDS)
        };
    }
});
var UbiEformItem = UbiObject.extend({
    id: "",
    x: 0,
    y: 0,
    width: 0,
    height: 0,
    halign: 0,
    valign: 0,
    leftMargin: 0,
    rightMargin: 0,
    topMargin: 0,
    bottomMargin: 0,
    borderleft: 0,
    borderright: 0,
    bordertop: 0,
    borderbottom: 0,
    fontname: "",
    fontstyle: 0,
    fontsize: 0,
    fontcolor: "000000",
    itemvalue: "",
    eforminfo: null,
    node: null,
    eformnode: null,
    inputobj: null,
    inputdivobj: null,
    constructor: function () {
        this.base(UbiEformItem.CLASSNAME);
    },
    setEformValue: function () {
        if (this.eformnode && this.inputobj) {
            switch (this.eforminfo.type) {
                case UbiEformItemInfo.TYPE_TEXT:
                    this
                        .node
                        .getElementsByTagName(UbiEformItem.NODEITEMVALUE)[0]
                        .textContent = encodeURIComponent(this.eforminfo.value);
                    this.eformnode.textContent = encodeURIComponent(this
                        .inputobj
                        .textnode
                        .textContent);
                    break;
                case UbiEformItemInfo.TYPE_CHECKBOX:
                case UbiEformItemInfo.TYPE_RADIO:
                    var ubiinputobj = this.inputobj.childNodes[0];
                    if (ubiinputobj.checked) {
                        this.eformnode.textContent = "checked";
                    } else {
                        this.eformnode.textContent = "";
                    }
                    break;
                case UbiEformItemInfo.TYPE_SIGNATURE:
                    if (this.inputobj.orgdata && typeof this.inputobj.orgdata != "string") {
                        var canvas = document.createElement('canvas');
                        canvas.width = this
                            .inputobj
                            .orgdata
                            .width;
                        canvas.height = this
                            .inputobj
                            .orgdata
                            .height;
                        var ctx = canvas.getContext('2d');
                        ctx.putImageData(this.inputobj.orgdata, 0, 0);
                        this.eformnode.textContent = encodeURIComponent(canvas.toDataURL("image/png"));
                    } else {
                        this.eformnode.textContent = encodeURIComponent(this.inputobj.orgdata);
                    }
                    break;
                case UbiEformItemInfo.TYPE_IMAGE:
                    if (this.inputobj.orgdata && typeof this.inputobj.orgdata != "string") {
                        var canvas = document.createElement('canvas');
                        canvas.width = this
                            .inputobj
                            .orgdata
                            .width;
                        canvas.height = this
                            .inputobj
                            .orgdata
                            .height;
                        var ctx = canvas.getContext('2d');
                        ctx.putImageData(this.inputobj.orgdata, 0, 0);
                        this.eformnode.textContent = encodeURIComponent(canvas.toDataURL("image/png"));
                    } else {
                        this.eformnode.textContent = encodeURIComponent(this.inputobj.orgdata);
                    }
                    break;
            }
        }
    },
    getVAlign: function () {
        var str;
        if (this.valign == 0) {
            str = "top";
        } else if (this.valign == 1) {
            str = "middle";
        } else if (this.valign == 2) {
            str = "bottom";
        }
        return str;
    },
    getHAlign: function () {
        var str;
        if (this.halign == 0) {
            str = "left";
        } else if (this.halign == 1) {
            str = "center";
        } else if (this.halign == 2) {
            str = "right";
        } else if (this.halign == 3) {
            str = "justify";
        } else if (this.halign == 4) {
            str = "justify";
        }
        return str;
    }
}, {
    CLASSNAME: "UbiEformItem",
    ATTRID: "id",
    ATTRX: "x",
    ATTRY: "y",
    ATTRWIDTH: "width",
    ATTRHEIGHT: "height",
    ATTRHALIGN: "halign",
    ATTRVALIGN: "valign",
    ATTRMARGINLEFT: "marginleft",
    ATTRMARGINRIGHT: "marginright",
    ATTRMARGINTOP: "margintop",
    ATTRMARGINBOTTOM: "marginbottom",
    ATTRBORDERLEFT: "borderleft",
    ATTRBORDERRIGHT: "borderright",
    ATTRBORDERTOP: "bordertop",
    ATTRBORDERBOTTOM: "borderbottom",
    ATTRFONTNAME: "fontname",
    ATTRFONTSIZE: "fontsize",
    ATTRFONTSTYLE: "fontstyle",
    ATTRFONTCOLOR: "fontcolor",
    NODEEFORM: "EForm",
    NODEITEMVALUE: "ItemValue",
    CreateInstance: function (node, doc) {
        var data = UbiEformItem.getData(node);
        var item = new UbiEformItem();
        item.node = node;
        item.id = data.id;
        item.x = data.x;
        item.y = data.y;
        item.width = data.width;
        item.height = data.height;
        item.halign = data.halign;
        item.valign = data.valign;
        item.leftMargin = data.leftMargin;
        item.rightMargin = data.rightMargin;
        item.topMargin = data.topMargin;
        item.bottomMargin = data.bottomMargin;
        item.borderleft = data.borderleft;
        item.borderright = data.borderright;
        item.bordertop = data.bordertop;
        item.borderbottom = data.borderbottom;
        item.fontname = data.fontname;
        item.fontstyle = data.fontstyle;
        item.fontsize = data.fontsize;
        if (data.fontcolor && data.fontcolor != '') {
            item.fontcolor = data.fontcolor;
        }
        if (data.eformnode != null) {
            item.eforminfo = UbiEformItemInfo.CreateInstance(data.eformnode, doc);
            item.eforminfo.value = data.itemvalue;
            item.eformnode = data.eformnode;
            if (item.eforminfo.type == UbiEformItemInfo.TYPE_SIGNATURE) {
                item.orgdata = encodeURIComponent(data.eformnode.textContent);
            }
        }
        return item;
    },
    getData: function (node) {
        var attributes = node.attributes;
        return {
            id: getAttributeStringValue(attributes, UbiEformItem.ATTRID),
            x: getAttributeIntValue(attributes, UbiEformItem.ATTRX),
            y: getAttributeIntValue(attributes, UbiEformItem.ATTRY),
            width: getAttributeIntValue(attributes, UbiEformItem.ATTRWIDTH),
            height: getAttributeIntValue(attributes, UbiEformItem.ATTRHEIGHT),
            halign: getAttributeIntValue(attributes, UbiEformItem.ATTRHALIGN, 0),
            valign: getAttributeIntValue(attributes, UbiEformItem.ATTRVALIGN, 1),
            leftMargin: getAttributeIntValue(attributes, UbiEformItem.ATTRMARGINLEFT),
            rightMargin: getAttributeIntValue(attributes, UbiEformItem.ATTRMARGINRIGHT),
            topMargin: getAttributeIntValue(attributes, UbiEformItem.ATTRMARGINTOP),
            bottomMargin: getAttributeIntValue(attributes, UbiEformItem.ATTRMARGINBOTTOM),
            borderleft: getAttributeIntValue(attributes, UbiEformItem.ATTRBORDERLEFT),
            borderright: getAttributeIntValue(attributes, UbiEformItem.ATTRBORDERRIGHT),
            bordertop: getAttributeIntValue(attributes, UbiEformItem.ATTRBORDERTOP),
            borderbottom: getAttributeIntValue(attributes, UbiEformItem.ATTRBORDERBOTTOM),
            fontname: getAttributeStringValue(attributes, UbiEformItem.ATTRFONTNAME),
            fontstyle: getAttributeIntValue(attributes, UbiEformItem.ATTRFONTSTYLE),
            fontsize: getAttributeIntValue(attributes, UbiEformItem.ATTRFONTSIZE),
            fontcolor: getAttributeStringValue(attributes, UbiEformItem.ATTRFONTCOLOR),
            itemvalue: (node.getElementsByTagName(UbiEformItem.NODEITEMVALUE)[0] == null)
                ? ""
                : getNodeValue(node.getElementsByTagName(UbiEformItem.NODEITEMVALUE)[0].childNodes[0]),
            eformnode: node.getElementsByTagName(UbiEformItem.NODEEFORM)[0]
        };
    }
});
var UbiEformPage = UbiObject.extend({
    editcanvas: null,
    editcanvasid: "",
    node: null,
    constructor: function (doc) {
        this.base(UbiEformPage.CLASSNAME);
        this.doc = doc;
        this.items = new UbiList();
        this.width = 0;
        this.height = 0;
        this.left = 0;
        this.top = 0;
        this.right = 0;
        this.bottom = 0;
        this.contents = "";
        this.pagesize = "";
        this.orientation = "";
    },
    setEditCanvas: function (str) {
        var editnode = this
            .doc
            .docxml
            .createElement(UbiEformPage.NODEEDITCANVAS);
        editnode.textContent = encodeURIComponent(encodeURIComponent(str));
        this.node.appendChild(editnode);
    }
}, {
    CLASSNAME: "UbiEformPage",
    NODEPAGE: "Page",
    NODECONTENTS: "Contents",
    NODEEDITCANVAS: "EditCanvas",
    ATTRPAGENUM: "pagenum",
    ATTRPAGEWIDTH: "width",
    ATTRPAGEHEIGHT: "height",
    ATTRPAGEMARGINTOP: "y",
    ATTRPAGEMARGINLEFT: "x",
    ATTRPAGESIZE: "pagesize",
    ATTRORIENTATION: "orientation",
    NODEITEM: "Item",
    CreateInstance: function (node, doc) {
        var data = UbiEformPage.getData(node);
        var page = new UbiEformPage(doc);
        var itemlist = data.itemlist;
        for (var i = 0; i < itemlist.length; i++) {
            var childnode = itemlist[i];
            page.items.Add(UbiEformItem.CreateInstance(childnode, doc));
        }
        page.node = node;
        page.width = data.width;
        page.height = data.height;
        page.top = data.top;
        page.left = data.left;
        page.right = data.width = data.left;
        page.bottom = data.height - data.top;
        page.pagesize = data.pagesize;
        page.orientation = data.orientation;
        page.contents = '';
        var contentsnode = node.getElementsByTagName(UbiEformPage.NODECONTENTS)[0];
        if (contentsnode != null) {
            if (contentsnode.childNodes[0]) {
                page.contents = decodeURIComponent(contentsnode.childNodes[0].nodeValue);
            }
        }
        return page;
    },
    getData: function (node) {
        var attributes = node.attributes;
        return {
            width: getAttributeIntValue(attributes, UbiEformPage.ATTRPAGEWIDTH),
            height: getAttributeIntValue(attributes, UbiEformPage.ATTRPAGEHEIGHT),
            top: getAttributeIntValue(attributes, UbiEformPage.ATTRPAGEMARGINTOP),
            left: getAttributeIntValue(attributes, UbiEformPage.ATTRPAGEMARGINLEFT),
            pagesize: getAttributeIntValue(attributes, UbiEformPage.ATTRPAGESIZE),
            orientation: getAttributeIntValue(attributes, UbiEformPage.ATTRORIENTATION),
            itemlist: node.getElementsByTagName(UbiEformPage.NODEITEM)
        };
    }
});
var UbiEformDoc = UbiObject.extend({
    version: "",
    docxml: null,
    pagecount: 0,
    isWA: false,
    eformNodes: [],
    eformItems: [],
    eformInputItems: [],
    constructor: function () {
        this.base(UbiEformDoc.CLASSNAME);
        this.pages = new UbiList();
    }
}, {
    CLASSNAME: "UbiEformDoc",
    NODEDOC: "Doc",
    ATTRVERSION: "version",
    ATTRPAGECOUNT: "pagecount",
    CreateInstance: function (node, flag) {
        var docnode = node.getElementsByTagName(UbiEformDoc.NODEDOC)[0];
        var data = UbiEformDoc.getData(docnode);
        var doc = new UbiEformDoc();
        doc.docxml = node;
        if (flag) {
            doc.version = data.version;
            doc.pagecount = data.pagecount;
        }
        var pagelist = data.pagelist;
        for (var i = 0; i < pagelist.length; i++) {
            var pagenode = pagelist[i];
            doc.currpagenum = i + 1;
            var page = UbiEformPage.CreateInstance(pagenode, doc);
            doc.pages.Add(page);
        }
        return doc;
    },
    getData: function (docnode) {
        var docattributes = docnode.attributes;
        return {
            version: getAttributeStringValue(docattributes, UbiEformDoc.ATTRVERSION),
            pagecount: getAttributeIntValue(docattributes, UbiEformDoc.ATTRPAGECOUNT),
            pagelist: docnode.getElementsByTagName(UbiEformPage.NODEPAGE)
        };
    }
});
function _ubi_eform_isEmptyCanvas(imageData) {
    if (! imageData) {
        return true;
    }
    var data = imageData.data;
    for (var i = 0; i < data.length; i++) {
        if (data[i] != 0 && data[i] > 0) {
            return false;
        }
    }
    return true;
};
function _ubi_eform_editCapture(viewer, svg) {
    var path = null;
    var g = svg.childNodes[0];
    var div = document.getElementById(svg.getAttribute("divid"));
    var pagescale = parseFloat(svg.getAttribute("pagescale"));
    var ds = 1 / pagescale;
    function remove_event_listeners() {
        svg.removeEventListener('mousemove', on_mousemove, false);
        svg.removeEventListener('mouseup', on_mouseup, false);
        svg.removeEventListener('touchmove', on_mousemove, false);
        svg.removeEventListener('touchend', on_mouseup, false);
    };
    function get_coords(e) {
        var x = 0,
            y = 0;
        try {
            if (e.changedTouches && e.changedTouches[0]) {
                var offsety = 0;
                var offsetx = 0;
                if (viewer && viewer.divToolbar) {}
                if (div) {
                    offsety += div.offsetTop;
                    offsetx += div.offsetLeft;
                }
                x = e.changedTouches[0].pageX - offsetx;
                y = e.changedTouches[0].pageY - offsety + viewer.divPreviewFrame.scrollTop;
            } else if (e.layerX || 0 == e.layerX) {
                x = e.layerX;
                y = e.layerY;
            } else if (e.offsetX || 0 == e.offsetX) {
                x = e.offsetX;
                y = e.offsetY;
            }
            x = Math.floor(x * 100 * ds) / 100;
            y = Math.floor(y * 100 * ds) / 100;
        } catch (e) {
            console.log(e);
        }
        return {x: x, y: y};
    };
    function on_mousedown(e) {
        if (! viewer._drawoption.startEdit) {
            return;
        }
        pagescale = parseFloat(svg.getAttribute("pagescale"));
        ds = 1 / pagescale;
        e.preventDefault();
        e.stopPropagation();
        svg.addEventListener('mouseup', on_mouseup, false);
        svg.addEventListener('touchend', on_mouseup, false);
        svg.addEventListener('mousemove', on_mousemove, false);
        svg.addEventListener('touchmove', on_mousemove, false);
        if (viewer._drawoption.isEraser) {
            viewer._drawoption.startEraser = true;
        } else {
            var penWidth = viewer.edit.penWidth;
            var penColor = viewer.edit.penColor;
            var penOpacity = viewer.edit.penOpacity;
            var xy = get_coords(e);
            path = document.createElementNS("http://www.w3.org/2000/svg", "path");
            path.setAttributeNS(null, "fill", "none");
            path.setAttributeNS(null, "stroke", penColor);
            path.setAttributeNS(null, "stroke-width", penWidth);
            path.setAttributeNS(null, "stroke-opacity", penOpacity);
            setPath("M " + xy.x + " " + xy.y + " ");
            g.appendChild(path);
            path.onclick = function () {
                if (viewer._drawoption.isEraser) {
                    g.removeChild(this);
                }
            };
            path.onmousemove = path.ontouchmove = function () {
                if (viewer._drawoption.isEraser && viewer._drawoption.startEraser) {
                    try {
                        g.removeChild(this);
                    } catch (e) {}
                }
            };
        }
    };
    function on_mousemove(e, finish) {
        e.preventDefault();
        e.stopPropagation();
        var xy = get_coords(e);
        if (viewer._drawoption.isEraser && viewer._drawoption.startEraser) {
            var pathobj = null;
            var x = 0;
            var y = 0;
            if (e.touches) {
                x = e.touches[0].clientX;
                y = e.touches[0].clientY;
            } else {
                x = e.pageX;
                y = e.pageY;
            } pathobj = document.elementFromPoint(x, y);
            if (pathobj.tagName == "path") {
                g.removeChild(pathobj);
            }
        } else {
            setPath("L " + xy.x + " " + xy.y + " ");
        }
    };
    function on_mouseup(e) {
        remove_event_listeners();
        if (viewer._drawoption.isEraser) {
            viewer._drawoption.startEraser = false;
        }
    };
    function setPath(str) {
        var points = [];
        points[0] = path.getAttribute("d");
        points[1] = str;
        path.setAttributeNS(null, "d", points.join(""));
    };
    svg.addEventListener('touchstart', on_mousedown, false);
    svg.addEventListener('mousedown', on_mousedown, false);
};
function _ubi_signatureCapture(canvas, signDiv) {
    var context = canvas.getContext("2d");
    var pixels = [];
    var cpixels = [];
    var xyLast = {};
    var xyAddLast = {};
    var calculate = false;
    function remove_event_listeners() {
        canvas.removeEventListener('mousemove', on_mousemove, false);
        canvas.removeEventListener('mouseup', on_mouseup, false);
        canvas.removeEventListener('touchmove', on_mousemove, false);
        canvas.removeEventListener('touchend', on_mouseup, false);
    };
    function get_coords(e) {
        var x,
            y;
        if (e.changedTouches && e.changedTouches[0]) {
            var offsety = canvas.offsetTop || 0;
            var offsetx = canvas.offsetLeft || 0;
            x = e.changedTouches[0].pageX - offsetx;
            y = e.changedTouches[0].pageY - offsety;
        } else if (e.layerX || 0 == e.layerX) {
            x = e.layerX;
            y = e.layerY;
        } else if (e.offsetX || 0 == e.offsetX) {
            x = e.offsetX;
            y = e.offsetY;
        }
        if (__ubi_isMobile) {
            x -= signDiv.getBoundingClientRect().left;
            y -= signDiv.getBoundingClientRect().top;
        }
        return {x: x, y: y};
    };
    function on_mousedown(e) {
        e.preventDefault();
        e.stopPropagation();
        canvas.addEventListener('mouseup', on_mouseup, false);
        canvas.addEventListener('mousemove', on_mousemove, false);
        canvas.addEventListener('touchend', on_mouseup, false);
        canvas.addEventListener('touchmove', on_mousemove, false);
        empty = false;
        var xy = get_coords(e);
        context.beginPath();
        pixels.push('moveStart');
        context.moveTo(xy.x, xy.y);
        pixels.push(xy.x, xy.y);
        xyLast = xy;
    };
    function on_mousemove(e, finish) {
        e.preventDefault();
        e.stopPropagation();
        var xy = get_coords(e);
        var xyAdd = {
            x: (xyLast.x + xy.x) / 2,
            y: (xyLast.y + xy.y) / 2
        };
        if (calculate) {
            var xLast = (xyAddLast.x + xyLast.x + xyAdd.x) / 3;
            var yLast = (xyAddLast.y + xyLast.y + xyAdd.y) / 3;
            pixels.push(xLast, yLast);
        } else {
            calculate = true;
        } context.quadraticCurveTo(xyLast.x, xyLast.y, xyAdd.x, xyAdd.y);
        pixels.push(xyAdd.x, xyAdd.y);
        context.stroke();
        context.beginPath();
        context.moveTo(xyAdd.x, xyAdd.y);
        xyAddLast = xyAdd;
        xyLast = xy;
    };
    function on_mouseup(e) {
        remove_event_listeners();
        context.stroke();
        pixels.push('e');
        calculate = false;
    };
    canvas.addEventListener('touchstart', on_mousedown, false);
    canvas.addEventListener('mousedown', on_mousedown, false);
};
function _ubi_signaturePadCapture(viewer, signPad, canvas, inputObj, clientWidth, clientHeight, canvasDs) {
    var signAreaH = parseInt(document
        .getElementById(viewer.eformNm + "_SignObj")
        .getBoundingClientRect()
        .height);
    var signCtx = canvas.getContext("2d");
    signCtx.fillStyle = "#fff";
    signCtx.lineWidth = 3 * canvasDs;
    if (signCtx.lineWidth < 3) 
        signCtx.lineWidth = 3;
     else if (signCtx.lineWidth > 6) 
        signCtx.lineWidth = 6;
    
    if (inputObj.orgdata) {
        signCtx.putImageData(inputObj.orgdata, 0, 0);
    }
    var disableSave = true;
    var pixels = [];
    var cpixels = [];
    var xyLast = {};
    var xyAddLast = {};
    var calculate = false;
    function remove_event_listeners() {
        canvas.removeEventListener('mousemove', on_mousemove, false);
        canvas.removeEventListener('mouseup', on_mouseup, false);
        canvas.removeEventListener('touchmove', on_mousemove, false);
        canvas.removeEventListener('touchend', on_mouseup, false);
    };
    function get_coords(e) {
        var x,
            y;
        if (e.changedTouches && e.changedTouches[0]) {
            var offsety = canvas.offsetTop || 0;
            var offsetx = canvas.offsetLeft || 0;
            x = e.changedTouches[0].pageX - offsetx;
            y = e.changedTouches[0].pageY - offsety;
        } else if (e.layerX || 0 == e.layerX) {
            x = e.layerX;
            y = e.layerY;
        } else if (e.offsetX || 0 == e.offsetX) {
            x = e.offsetX;
            y = e.offsetY;
        }
        if (__ubi_isMobile || __ubi_isIE || __ubi_isEdge || __ubi_isSafari || __ubi_isFF) {
            if (__ubi_isMobile) {
                x = x - window.scrollX;
                y = y - (clientHeight - signAreaH) - window.scrollY;
            } else if (__ubi_isSafari || __ubi_isFF) {
                x = x - (canvas.getBoundingClientRect().left - signPad.getBoundingClientRect().left);
                y = y - (canvas.getBoundingClientRect().top - signPad.getBoundingClientRect().top);
            } else {
                if (__ubi_isIE) {
                    var mainDiv = document.getElementById(viewer.eformNm + "Div");
                    if (mainDiv.style.width == 'calc(100vw)') {
                        x = x - canvas.getBoundingClientRect().left;
                        y = y - canvas.getBoundingClientRect().top;
                    } else {
                        x = mainDiv.getBoundingClientRect().left + x - canvas.getBoundingClientRect().left;
                        y = mainDiv.getBoundingClientRect().top + y - canvas.getBoundingClientRect().top;
                    }
                } else {
                    x = x - canvas.getBoundingClientRect().left;
                    y = y - canvas.getBoundingClientRect().top;
                }
            }
        }
        return {x: x, y: y};
    };
    function on_mousedown(e) {
        e.preventDefault();
        e.stopPropagation();
        canvas.addEventListener('mouseup', on_mouseup, false);
        canvas.addEventListener('mousemove', on_mousemove, false);
        canvas.addEventListener('touchend', on_mouseup, false);
        canvas.addEventListener('touchmove', on_mousemove, false);
        empty = false;
        var xy = get_coords(e);
        signCtx.beginPath();
        pixels.push('moveStart');
        signCtx.moveTo(xy.x, xy.y);
        pixels.push(xy.x, xy.y);
        xyLast = xy;
    };
    function on_mousemove(e, finish) {
        e.preventDefault();
        e.stopPropagation();
        var xy = get_coords(e);
        var xyAdd = {
            x: (xyLast.x + xy.x) / 2,
            y: (xyLast.y + xy.y) / 2
        };
        if (calculate) {
            var xLast = (xyAddLast.x + xyLast.x + xyAdd.x) / 3;
            var yLast = (xyAddLast.y + xyLast.y + xyAdd.y) / 3;
            pixels.push(xLast, yLast);
        } else {
            calculate = true;
        } signCtx.quadraticCurveTo(xyLast.x, xyLast.y, xyAdd.x, xyAdd.y);
        pixels.push(xyAdd.x, xyAdd.y);
        signCtx.stroke();
        signCtx.beginPath();
        signCtx.moveTo(xyAdd.x, xyAdd.y);
        xyAddLast = xyAdd;
        xyLast = xy;
    };
    function on_mouseup(e) {
        remove_event_listeners();
        disableSave = false;
        signCtx.stroke();
        pixels.push('e');
        calculate = false;
    };
    canvas.addEventListener('touchstart', on_mousedown, false);
    canvas.addEventListener('mousedown', on_mousedown, false);
};
function _ubi_eform_showSignPad(viewer, inputObj, padType) {
    var viewerWidth = viewer.divMain.offsetWidth;
    var viewerHeight = viewer.divMain.offsetHeight;
    var toolbarHeight = viewer.divToolbar.offsetHeight;
    viewer.toolbar.enableDimBg(true);
    var signAreaObj = document.getElementById(viewer.eformNm + "_SignArea");
    if (! signAreaObj) {
        var divSignAreaObj = document.createElement('div');
        divSignAreaObj.id = viewer.eformNm + "_SignArea";
        divSignAreaObj.className = "sign-wrap is-on";
        var signObj = document.createElement('div');
        signObj.id = viewer.eformNm + "_SignObj";
        signObj.className = "sign-container";
        var signCloseBtn = document.createElement("a");
        signCloseBtn.className = "btn-signClose popup-close";
        signCloseBtn.title = "서명입력 닫기";
        signCloseBtn.style.background = "#e9e9e9 url(" + viewer.params.resource + "/images/eform/pop_close.png) no-repeat 50% 50%";
        var saveCloseTitleObj = document.createElement("span");
        saveCloseTitleObj.innerHTML = "닫기";
        signCloseBtn.appendChild(saveCloseTitleObj);
        signObj.appendChild(signCloseBtn);
        var signPadObj = document.createElement('div');
        signPadObj.id = viewer.eformNm + "_SignPad";
        signPadObj.className = "sign-canvas";
        var signPadCanvasObj = document.createElement('canvas');
        signPadCanvasObj.id = viewer.eformNm + "_SignCanvas";
        var canvasWidth = 420;
        var canvasHeight = 420;
        if (viewerWidth <= 640) {
            canvasWidth = 360;
            canvasHeight = 360;
        }
        var canvasDs = 0.0;
        if (inputObj.width >= inputObj.height) {
            canvasHeight = inputObj.height * (canvasWidth / inputObj.width);
            canvasDs = canvasWidth / inputObj.width
        } else {
            canvasWidth = inputObj.width * (canvasHeight / inputObj.height);
            canvasDs = canvasHeight / inputObj.height
        } signPadCanvasObj.width = canvasWidth;
        signPadCanvasObj.height = canvasHeight;
        signPadCanvasObj.style.background = "#f3f3fa url(" + viewer.params.resource + "/images/eform/bg_canvas" + padType + ".png) no-repeat 50% 50%";
        var signBtnObj = document.createElement('div');
        signBtnObj.className = "btn-sign";
        var completeBtn = document.createElement("a");
        completeBtn.className = "btn-ok popup-close";
        completeBtn.title = "완료";
        completeBtn.innerHTML = "완료";
        var resetBtn = document.createElement("a");
        resetBtn.className = "btn-reset";
        resetBtn.title = "초기화";
        resetBtn.innerHTML = "초기화";
        signBtnObj.appendChild(completeBtn);
        signBtnObj.appendChild(resetBtn);
        signPadObj.appendChild(signPadCanvasObj);
        signPadObj.appendChild(signBtnObj);
        signObj.appendChild(signPadObj);
        divSignAreaObj.appendChild(signObj);
        viewer.divMain.appendChild(divSignAreaObj);
        var signCtx = signPadCanvasObj.getContext("2d");
        _ubi_signaturePadCapture(viewer, signPadObj, signPadCanvasObj, inputObj, window.innerWidth, window.innerHeight, canvasDs);
        signCloseBtn.onclick = function () {
            viewer.divMain.removeChild(divSignAreaObj);
            viewer.toolbar.enableDimBg(false);
        };
        signPadCanvasObj.onmouseover = function () {
            this.style.cursor = "pointer";
        };
        signPadCanvasObj.onmouseout = function () {
            this.style.cursor = "default";
        };
        completeBtn.onmouseover = function () {
            this.style.cursor = "pointer";
        };
        completeBtn.onmouseout = function () {
            this.style.cursor = "default";
        };
        completeBtn.onclick = function () {
            inputObj.orgdata = signCtx.getImageData(0, 0, parseInt(signPadCanvasObj.width), parseInt(signPadCanvasObj.height));
            if (_ubi_eform_isEmptyCanvas(inputObj.orgdata)) {
                alert('사인이 입력되지 않았습니다.\n사인 입력 후 완료를 누르십시오.');
                inputObj.orgdata = null;
                return;
            }
            var ctx = inputObj.getContext('2d');
            var width = parseInt(inputObj.width);
            var height = parseInt(inputObj.height);
            ctx.clearRect(0, 0, width, height);
            var ds = parseInt(signPadCanvasObj.height) / parseInt(signPadCanvasObj.width);
            var imgWidth = width;
            var imgHeight = height;
            if (height < width * ds) {
                ds = parseInt(signPadCanvasObj.width) / parseInt(signPadCanvasObj.height);
                imgWidth = height * ds;
            } else {
                imgHeight = width * ds;
            } ctx.drawImage(signPadCanvasObj, 0, 0, imgWidth, imgHeight);
            if (inputObj.formbatchids && inputObj.formbatchids.length > 0) {
                var ids = inputObj.formbatchids;
                for (var i = 0; i < ids.length; i++) {
                    var inputids = document.getElementsByTagName("canvas");
                    for (var j = 0; j < inputids.length; j++) {
                        if (inputids[j].id == ids[i]) {
                            inputids[j].orgdata = inputObj.orgdata;
                            var ctx = inputids[j].getContext('2d');
                            var width = parseInt(inputids[j].width);
                            var height = parseInt(inputids[j].height);
                            var imgwidth = width;
                            var imgheight = height;
                            if (height < width * ds) {
                                ds = parseInt(signPadCanvasObj.width) / parseInt(signPadCanvasObj.height);
                                imgwidth = height * ds;
                            } else {
                                imgheight = width * ds;
                            } ctx.drawImage(signPadCanvasObj, 0, 0, imgwidth, imgheight);
                        }
                    }
                }
            }
            viewer.divMain.removeChild(divSignAreaObj);
            viewer.toolbar.enableDimBg(false);
        };
        resetBtn.onmouseover = function () {
            this.style.cursor = "pointer";
        };
        resetBtn.onmouseout = function () {
            this.style.cursor = "default";
        };
        resetBtn.onclick = function () {
            signCtx.clearRect(0, 0, signPadCanvasObj.width, signPadCanvasObj.height);
        };
    } else {
        signAreaObj.classList.add('is-on');
    }
}
function centeredText(canvas, string, fontSize, color) {
    var ctx = canvas.getContext('2d');
    var i = string.length;
    i = i * fontSize * 0.62;
    if (i > canvas.width) {
        i = canvas.width;
    }
    ctx.fillStyle = "RGBA(243, 243, 250, 1)";
    ctx.fillRect(canvas.width / 2 - i / 2, canvas.height / 2 - (fontSize * 1.5) / 2, i, (fontSize * 1.5));
    ctx.font = fontSize.toString() + "px monospace";
    ctx.fillStyle = "RGBA(219, 219, 236, 1)";
    ctx.textBaseline = "middle";
    ctx.textAlign = "center";
    ctx.fillText(string, canvas.width / 2, canvas.height / 2);
}
function _ubi_eform_getCssText(csstext) {
    var cssStartIndex = 0,
        cssEndIndex = 0;
    var text = '';
    if (csstext && (cssStartIndex = csstext.indexOf('{')) >= 0) {
        cssEndIndex = csstext.indexOf('}');
        if (cssEndIndex > 0) {
            text = csstext.substring(cssStartIndex + 1, cssEndIndex);
        }
    }
    return text;
}
function _ubi_eform_showBatchSignPopup(viewer) {
    var batchSignPad = document.getElementById("ubireport_eform_BatchSignPad");
    if (batchSignPad) {
        return;
    }
    var viewerWidth = viewer.divMain.offsetWidth;
    var viewerHeight = viewer.divMain.offsetHeight;
    var toolbarHeight = viewer.divToolbar.offsetHeight;
    var divBatchSignPad = document.createElement('div');
    divBatchSignPad.id = 'ubireport_eform_BatchSignPad';
    divBatchSignPad.style.zIndex = 9999;
    var divHeaderArea = document.createElement('div');
    divHeaderArea.id = 'HeaderArea';
    var divSignArea = document.createElement('div');
    divSignArea.id = 'SignArea';
    var divSignButtonArea = document.createElement('div');
    divSignButtonArea.id = 'SignButtonArea';
    var btnConfirm = document.createElement('input');
    btnConfirm.id = 'BatchSignBtnOk';
    btnConfirm.type = 'button';
    btnConfirm.value = '확인';
    var btnCancel = document.createElement('input');
    btnCancel.id = 'BatchSignBtnCancel';
    btnCancel.type = 'button';
    btnCancel.value = '취소';
    var btnInit = document.createElement('input');
    btnInit.id = 'BatchSignBtnInit';
    btnInit.type = 'button';
    btnInit.value = '초기화';
    divSignButtonArea.appendChild(btnConfirm);
    divSignButtonArea.appendChild(btnCancel);
    divSignButtonArea.appendChild(btnInit);
    var divFooterArea = document.createElement('div');
    divFooterArea.id = 'FooterArea';
    var cssRules;
    if (document.all) {
        cssRules = 'rules';
    } else if (document.getElementById) {
        cssRules = 'cssRules';
    }
    var theRules = null;
    var csstext = '';
    for (var i = 0; i < document.styleSheets.length; i++) {
        theRules = document.styleSheets[i][cssRules];
        for (var j = 0; j < theRules.length; j++) {
            if (theRules[j].selectorText == 'div#ubireport_eform_BatchSignPad') {
                divBatchSignPad.style.cssText = _ubi_eform_getCssText(theRules[j].cssText);
            } else if (theRules[j].selectorText == 'div#ubireport_eform_BatchSignPad #HeaderArea') {
                divHeaderArea.style.cssText = _ubi_eform_getCssText(theRules[j].cssText);
            } else if (theRules[j].selectorText == 'div#ubireport_eform_BatchSignPad #SignArea') {
                divSignArea.style.cssText = _ubi_eform_getCssText(theRules[j].cssText);
            } else if (theRules[j].selectorText == 'div#ubireport_eform_BatchSignPad #SignButtonArea') {
                divSignButtonArea.style.cssText = _ubi_eform_getCssText(theRules[j].cssText);
            } else if (theRules[j].selectorText == 'div#ubireport_eform_BatchSignPad#SignButtonArea #BatchSignBtnOk') {
                btnConfirm.style.cssText = _ubi_eform_getCssText(theRules[j].cssText);
            } else if (theRules[j].selectorText == 'div#ubireport_eform_BatchSignPad#SignButtonArea #BatchSignBtnCancel') {
                btnCancel.style.cssText = _ubi_eform_getCssText(theRules[j].cssText);
            } else if (theRules[j].selectorText == 'div#ubireport_eform_BatchSignPad#SignButtonArea #BatchSignBtnInit') {
                btnInit.style.cssText = _ubi_eform_getCssText(theRules[j].cssText);
            } else if (theRules[j].selectorText == 'div#ubireport_eform_BatchSignPad #FooterArea') {
                divFooterArea.style.cssText = _ubi_eform_getCssText(theRules[j].cssText);
            }
        }
    }
    if (divBatchSignPad.style.background == '') {
        divBatchSignPad.style.background = 'white';
    }
    divBatchSignPad.style.position = 'fixed';
    if (viewer.batchSignPad.headerContents != '') {
        divHeaderArea.innerHTML = viewer.batchSignPad.headerContents;
    }
    divBatchSignPad.appendChild(divHeaderArea);
    divBatchSignPad.appendChild(divSignArea);
    divBatchSignPad.appendChild(divSignButtonArea);
    divBatchSignPad.appendChild(divFooterArea);
    viewer.divMain.appendChild(divBatchSignPad);
    divSignArea.style.margin = "0px;";
    var penWidth = 5.0;
    var canvas_w = divSignArea.clientWidth;
    var canvas_h = divSignArea.clientHeight;
    var signObj = document.createElement('canvas');
    signObj.width = canvas_w;
    signObj.height = canvas_h;
    signObj.position = "absolut";
    signObj.style.left = "0px";
    signObj.style.top = "0px";
    var sign_ctx = signObj.getContext('2d');
    sign_ctx.lineWidth = penWidth;
    sign_ctx.lineJoin = 'round';
    sign_ctx.lineCap = 'round';
    divSignArea.appendChild(signObj);
    _ubi_signatureCapture(signObj, divSignArea);
    btnConfirm.onclick = function () {
        var orgdata = sign_ctx.getImageData(0, 0, canvas_w, canvas_h);
        if (_ubi_eform_isEmptyCanvas(orgdata)) {
            alert('사인이 입력되지 않았습니다.\n사인 입력 후 확인을 누르십시오.');
            return;
        }
        var doc = viewer.doc;
        if (doc) {
            if (doc.pages && doc.pages.GetSize() > 0) {
                var pageobj = null;
                var items = null;
                var item = null;
                for (var i = 0; i < doc.pages.GetSize(); i++) {
                    pageobj = doc.pages.GetAt(i);
                    items = pageobj.items;
                    for (var j = 0; j < items.GetSize(); j++) {
                        item = items.GetAt(j);
                        if (item.eforminfo.type == UbiEformItemInfo.TYPE_SIGNATURE) {
                            var inputobj = item.inputobj;
                            inputobj.orgdata = orgdata;
                            var ctx = inputobj.getContext('2d');
                            var width = parseInt(inputobj.width);
                            var height = parseInt(inputobj.height);
                            ctx.clearRect(0, 0, width, height);
                            var ds = canvas_h / canvas_w;
                            var imgwidth = width;
                            var imgheight = height;
                            if (height < width * ds) {
                                ds = canvas_w / canvas_h;
                                imgwidth = height * ds;
                            } else {
                                imgheight = width * ds;
                            } ctx.drawImage(signObj, 0, 0, imgwidth, imgheight);
                        }
                    }
                }
            }
        }
        viewer.divMain.removeChild(divBatchSignPad);
        if (viewer
                .batchSignPad
                .event
                .OnConfirm) {
            viewer
                .batchSignPad
                .event
                .OnConfirm();
        }
    };
    btnInit.onclick = function () {
        sign_ctx.clearRect(0, 0, signObj.width, signObj.height);
    };
    btnCancel.onclick = function () {
        viewer.divMain.removeChild(divBatchSignPad);
        if (viewer
                .batchSignPad
                .event
                .OnCancel) {
            viewer
                .batchSignPad
                .event
                .OnCancel();
        }
    };
};
function _ubi_eform_hideBatchSignPopup(viewer) {
    var divBatchSignPad = document.getElementById('ubireport_eform_BatchSignPad');
    if (divBatchSignPad) {
        viewer.divMain.removeChild(divBatchSignPad);
    }
};
function _ubi_eform_drawInputItems(viewer, doc, page, inputdiv, ds) {
    if (doc) {
        var pageobj = doc.pages.GetAt(page - 1);
        var items = pageobj.items;
        var itemslen = items.GetSize();
        var inputobj = null;
        var inputhiddenobj = null;
        var item = null;
        var requiredWidth = 2;
        for (var i = 0; i < itemslen; i++) {
            item = items.GetAt(i);
            inputobj = null;
            inputhiddenobj = null;
            requiredWidth = 0;
            if (item.inputobj == null) {
                var textdiv = null;
                var textnode = null;
                if (item.eforminfo.type == UbiEformItemInfo.TYPE_TEXT) {
                    textdiv = document.createElement("div");
                    textdiv.style.position = 'absolute';
                    textdiv.style.border = "none";
                    textdiv.style.background = 'transparent';
                    textdiv.style.overflow = 'hidden';
                    var table = document.createElement("table");
                    var tbody = document.createElement("tbody");
                    var tr = document.createElement("tr");
                    var td = document.createElement("td");
                    table.style.width = "100%";
                    table.style.height = "100%";
                    table.style.margin = '0px';
                    table.style.padding = '0px';
                    table.style.border = '0px';
                    table.style.borderSpacing = '0px';
                    table.style.borderCollapse = 'collapse';
                    td.style.width = "100%";
                    td.style.height = "100%";
                    td.style.wordWrap = 'break-word';
                    td.style.whiteSpace = 'pre-wrap';
                    td.style.wordBreak = 'break-all';
                    td.style.textAlign = item.getHAlign();
                    td.style.verticalAlign = item.getVAlign();
                    if (item.eformnode.textContent != '') {
                        textnode = document.createTextNode(item.eformnode.textContent);
                    } else {
                        textnode = document.createTextNode(item.eforminfo.value);
                    } td.appendChild(textnode);
                    tr.appendChild(td);
                    tbody.appendChild(tr);
                    table.appendChild(tbody);
                    textdiv.appendChild(table);
                    if (item.eforminfo.multiline) {
                        inputobj = document.createElement('textarea');
                        inputobj.style.overflow = 'hidden';
                    } else {
                        inputobj = document.createElement('input');
                        inputobj.type = 'text';
                    }
                    if (item.eforminfo.maxlength > 0) {
                        inputobj.setAttributeNS(null, "maxlength", item.eforminfo.maxlength);
                    }
                    inputobj.textdiv = textdiv;
                    inputobj.textnode = textnode;
                    inputobj.inputdata = item.eforminfo.value;
                    inputobj.onfocus = function () {
                        this.style.background = '#fff';
                        if (this.textnode) {
                            this.value = this.textnode.textContent;
                        }
                        if (this.value) {
                            this.setSelectionRange(this.value.length, this.value.length);
                        }
                    };
                    inputobj.onblur = function () {
                        this.inputdata = this.value;
                        this.textnode.textContent = this.value;
                        this.style.background = 'transparent';
                        this.value = '';
                    };
                } else if (item.eforminfo.type == UbiEformItemInfo.TYPE_RADIO) {
                    inputobj = document.createElement("label");
                    inputobj.className = "ubieforminput";
                    var inputradiobtn = document.createElement("input");
                    inputradiobtn.type = 'radio';
                   
                    if (item.eformnode.textContent == "checked") 
                    
                        inputradiobtn.checked = true;
                    
                    if (item.eforminfo.groupname && item.eforminfo.groupname != '') {
                        inputradiobtn.name = item.eforminfo.groupname;
                        //09-24추가부분 남/녀 하나라도 체크되어있을시 나머지는 체크비활성화로 변경
                        if(inputradiobtn.name == 'GENDER'){
                        	
                        	inputradiobtn.disabled  = true;
                        }
                    }
                    var spanradiobtn = document.createElement("span");
                    spanradiobtn.className = "ubiradiobtn";
                    inputobj.appendChild(inputradiobtn);
                    inputobj.appendChild(spanradiobtn);
                    var spanradiocheckedbtn = document.createElement("span");
                    spanradiocheckedbtn.className = "ubiradiocheckedbtn";
                    inputobj.appendChild(spanradiocheckedbtn);
                } else if (item.eforminfo.type == UbiEformItemInfo.TYPE_CHECKBOX) {
                    inputobj = document.createElement("label");
                    inputobj.className = "ubieforminput";
                    var inputcheckbox = document.createElement("input");
                    inputcheckbox.type = 'checkbox';
                    if (item.eformnode.textContent == "checked") 
                        inputcheckbox.checked = true;
                    
                    var spancheckbox = document.createElement("span");
                    spancheckbox.className = "ubicheckbox";
                    inputobj.ubicheckbox = inputcheckbox;
                    inputobj.appendChild(inputcheckbox);
                    inputobj.appendChild(spancheckbox);
                } else if (item.eforminfo.type == UbiEformItemInfo.TYPE_COMBOBOX) {
                    inputobj = document.createElement('select');
                } else if (item.eforminfo.type == UbiEformItemInfo.TYPE_LIST) {} else if (item.eforminfo.type == UbiEformItemInfo.TYPE_SIGNATURE) {
                    inputobj = document.createElement('canvas');
                    inputobj.onmouseover = function () {
                        this.style.cursor = "pointer";
                    };
                    inputobj.onmouseout = function () {
                        this.style.cursor = "default";
                    };
                    inputobj.width = item.width;
                    inputobj.height = item.height;
                    inputobj.style.zIndex = 1;
                    var padName = item.eforminfo.name;
                    var padType = 1;
                    if (padName.indexOf("NAMEPAD") == 0) 
                        padType = 2;
                     else if (padName.indexOf("DATEPAD") == 0) 
                        padType = 3;
                    
                    var textContent = item.eformnode.textContent;
                    if (typeof textContent == "undefined" || textContent == null || textContent.indexOf("data:image") == -1) {
                        if (padType == 2) {
                            inputobj.onclick = function () {
                                _ubi_eform_showSignPad(viewer, this, 2);
                            };
                        } else if (padType == 3) {
                            inputobj.onclick = function () {
                                _ubi_eform_showSignPad(viewer, this, 3);
                            };
                        } else {
                            inputobj.onclick = function () {
                                _ubi_eform_showSignPad(viewer, this, 1);
                            };
                        }
                    } else {
                        inputobj.orgdata = textContent;
                        _ubi_eform_drawSavedImage(inputobj);
                    }
                } else if (item.eforminfo.type == UbiEformItemInfo.TYPE_IMAGE) {
                    inputhiddenobj = document.createElement('input');
                    inputhiddenobj.type = 'file';
                    inputhiddenobj.accept = 'image/*';
                    inputhiddenobj.style.width = '0px';
                    inputhiddenobj.style.height = '0px';
                    inputhiddenobj.style.opacity = '0';
                    inputobj = document.createElement('canvas');
                    inputobj.onmouseover = function () {
                        this.style.cursor = "pointer";
                    };
                    inputobj.onmouseout = function () {
                        this.style.cursor = "default";
                    };
                    inputobj.width = item.width;
                    inputobj.height = item.height;
                    inputobj.style.zIndex = 1;
                    var textContent = item.eformnode.textContent;
                    if (typeof textContent == "undefined" || textContent == null || textContent.indexOf("data:image") == -1) {
                        inputobj.onclick = function () {
                            _ubi_eform_inputImageFile(this);
                        };
                    } else {
                        inputobj.orgdata = textContent;
                        _ubi_eform_drawSavedImage(inputobj);
                    }
                }
                if (inputobj) {
                    var ubiinputtype = (item.eforminfo.type == UbiEformItemInfo.TYPE_CHECKBOX || item.eforminfo.type == UbiEformItemInfo.TYPE_RADIO);
                    var ubiinputobj = null;
                    var ubirealinputobj = null;
                    if (ubiinputtype) {
                        ubiinputobj = inputobj.childNodes[0];
                        ubirealinputobj = inputobj.childNodes[1];
                    }
                    if (ubiinputtype) {
                        if (item.eforminfo.groupname && item.eforminfo.groupname != '') {
                            ubiinputobj.id = item.eforminfo.groupname + "_" + item.id;
                        } else {
                            ubiinputobj.id = item.id;
                        } ubiinputobj.id = item.id;
                        ubiinputobj.tabIndex = (viewer._tabIndex ++);
                       //2021-09-09 추가부분
                        ubiinputobj.value = (viewer._val ++);
                       
                        if(item.eforminfo.groupname.indexOf('S') == 0){
                        	
	                        if(ubiinputobj.value == 0 ||ubiinputobj.value % 7 == 0){
	                        	
	                        	ubiinputobj.checked = "checked";
	                        }
                        }
                        //2021-09-24 추가부분(피부특성 피험자의 남녀 구분따라 출력시 디폴트값으로 라디오버튼 체크)
                    	if(item.eforminfo.groupname.indexOf('GENDER2') == 0){
                    		
                        	ubiinputobj.checked = "checked";            	
                        }
                    	if(item.eforminfo.groupname.indexOf('GENDER1') == 0){

                        	ubiinputobj.checked = "checked";
                    	}
                        //끝
	                        ubiinputobj.formtype = item.eforminfo.type;
                    } else {
                        inputobj.id = item.id;
                        inputobj.tabIndex = (viewer._tabIndex ++);
                        inputobj.formtype = item.eforminfo.type;
                        inputobj.style.position = 'absolute';
                        inputobj.style.border = "none";
                        inputobj.style.background = 'transparent';
                    }
                    if (item
                            .eforminfo
                            .batchinputids
                            .length > 0) {
                        if (ubiinputtype) 
                            ubiinputobj.formbatchids = item.eforminfo.batchinputids;
                         else 
                            inputobj.formbatchids = item.eforminfo.batchinputids;
                        
                    }
                    if (item.eforminfo.required) {
                        requiredWidth = 2;
                        if (textdiv) {
                            textdiv.style.border = (requiredWidth + "px solid red");
                        } else {
                            if (ubiinputtype) {} else 
                                inputobj.style.border = (requiredWidth + "px solid red");
                            
                        } inputobj.requiredWidth = requiredWidth;
                    }
                    if (item.eforminfo.readonly) {
                        if (ubiinputtype) 
                            ubiinputobj.readOnly = true;
                         else 
                            inputobj.readOnly = true;
                        
                    }
                    if (item.eforminfo.type == UbiEformItemInfo.TYPE_TEXT) {
                        inputobj.style.fontFamily = item.fontname;
                        if (item.fontstyle != -1) {
                            if (item.fontstyle == 0) 
                                inputobj.style.fontWeight = "normal";
                             else if (item.fontstyle == 1) 
                                inputobj.style.fontWeight = "bold";
                             else if (item.fontstyle == 2) 
                                inputobj.style.fontStyle = "italic";
                             else if (item.fontstyle == 3) {
                                inputobj.style.fontWeight = "bold";
                                inputobj.style.fontStyle = "italic";
                            }
                        }
                        if (textdiv) {
                            textdiv.style.fontFamily = inputobj.style.fontFamily;
                            if (inputobj.style.fontWeight) {
                                textdiv.style.fontWeight = inputobj.style.fontWeight;
                            }
                            if (inputobj.style.fontStyle) {
                                textdiv.style.fontStyle = inputobj.style.fontStyle;
                            }
                        }
                    }
                    if (item
                            .eforminfo
                            .batchinputids
                            .length > 0) {
                        if (ubiinputtype) {
                            ubiinputobj.onchange = function () {
                                var type = this.formtype;
                                var ids = this.formbatchids;
                                for (var i = 0; i < ids.length; i++) {
                                    var inputids = document.getElementsByTagName("input");
                                    for (var j = 0; j < inputids.length; j++) {
                                        if (inputids[j].id == ids[i]) {
                                            if (type == UbiEformItemInfo.TYPE_CHECKBOX) {
                                                inputids[j].checked = this.checked;
                                            }
                                        }
                                    }
                                }
                            }
                        } else {
                            inputobj.onchange = function () {
                                var type = this.formtype;
                                var ids = this.formbatchids;
                                for (var i = 0; i < ids.length; i++) {
                                    var inputids = document.getElementsByTagName("input");
                                    for (var j = 0; j < inputids.length; j++) {
                                        if (inputids[j].id == ids[i]) {
                                            if (type == UbiEformItemInfo.TYPE_TEXT) {
                                                if (inputids[j].textnode) {
                                                    inputids[j].textnode.textContent = this.value;
                                                }
                                            } else if (type == UbiEformItemInfo.TYPE_CHECKBOX) {
                                                inputids[j].checked = this.checked;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                item.inputobj = inputobj;
            } else {
                inputobj = item.inputobj;
            }
            if (inputobj) {
                requiredWidth = 0;
                if (inputobj.requiredWidth) {
                    requiredWidth = parseInt(inputobj.requiredWidth);
                }
                if (item.eforminfo.type == UbiEformItemInfo.TYPE_SIGNATURE || item.eforminfo.type == UbiEformItemInfo.TYPE_IMAGE) {
                    inputobj.style.top = ((pageobj.top + item.y) * ds) + 'px';
                    inputobj.style.left = ((pageobj.left + item.x) * ds) + 'px';
                    inputobj.width = ((item.width) * ds - requiredWidth);
                    inputobj.height = ((item.height) * ds - requiredWidth);
                    if (inputobj.orgdata && typeof inputobj.orgdata != "string") {
                        var orgcanvas = document.createElement('canvas');
                        orgcanvas.width = inputobj.orgdata.width;
                        orgcanvas.height = inputobj.orgdata.height;
                        var orgctx = orgcanvas.getContext('2d');
                        orgctx.putImageData(inputobj.orgdata, 0, 0);
                        var width = parseInt(inputobj.width);
                        var height = parseInt(inputobj.height);
                        var imgds = orgcanvas.height / orgcanvas.width;
                        var imgwidth = width;
                        var imgheight = height;
                        if (height < width * imgds) {
                            imgds = orgcanvas.width / orgcanvas.height;
                            imgwidth = height * imgds;
                        } else {
                            imgheight = width * imgds;
                        } inputobj.getContext('2d').drawImage(orgcanvas, 0, 0, imgwidth, imgheight);
                    }
                } else {
                    if (item.eforminfo.type != UbiEformItemInfo.TYPE_CHECKBOX && item.eforminfo.type != UbiEformItemInfo.TYPE_RADIO) {
                        inputobj.style.fontSize = (item.fontsize * ds) + "px";
                        inputobj.style.paddingLeft = (item.leftMargin * ds) + "px";
                        inputobj.style.paddingRight = (item.rightMargin * ds) + "px";
                        inputobj.style.paddingTop = (item.topMargin * ds) + "px";
                        inputobj.style.paddingBottom = (item.bottomMargin * ds) + "px";
                    }
                    if (item.eforminfo.type == UbiEformItemInfo.TYPE_CHECKBOX) {
                        var boxsize = 10;
                        inputobj.style.top = ((pageobj.top + item.y + (item.height - boxsize) / 2 - 1) * ds) + 'px';
                        inputobj.style.left = ((pageobj.left + item.x + 1) * ds) + 'px';
                        var spancheckbox = inputobj.childNodes[1];
                        spancheckbox.style.width = ((boxsize * ds) + 'px');
                        spancheckbox.style.height = ((boxsize * ds) + 'px');
                        spancheckbox.style.fontSize = ((boxsize * ds) + 'px');
                        spancheckbox.style.lineHeight = ((boxsize * ds) + 'px');
                    } else if (item.eforminfo.type == UbiEformItemInfo.TYPE_RADIO) {
                        var btnsize = 10;
                        var radioBtnSize = parseInt(btnsize * ds);
                        if (radioBtnSize % 2 == 1) 
                            radioBtnSize = radioBtnSize + 1;
                        
                        inputobj.style.top = ((pageobj.top + item.y + (item.height - btnsize) / 2 - 1) * ds) + 'px';
                        inputobj.style.left = ((pageobj.left + item.x + 1) * ds) + 'px';
                        var spanradiobtn = inputobj.childNodes[1];
                        spanradiobtn.style.width = radioBtnSize + 'px';
                        spanradiobtn.style.height = radioBtnSize + 'px';
                        var radioCheckedSize = radioBtnSize / 2;
                        if (radioCheckedSize % 2 == 1) 
                            radioCheckedSize = radioCheckedSize + 1;
                        
                        var radioCheckedPos = ((radioBtnSize + 2) - radioCheckedSize) / 2;
                        var spanradiocheckedbtn = inputobj.childNodes[2];
                        spanradiocheckedbtn.style.width = (radioCheckedSize + 'px');
                        spanradiocheckedbtn.style.height = (radioCheckedSize + 'px');
                        spanradiocheckedbtn.style.left = (radioCheckedPos + 'px');
                        spanradiocheckedbtn.style.top = (radioCheckedPos + 'px');
                    } else if (item.eforminfo.type == UbiEformItemInfo.TYPE_TEXT) {
                        var textdiv = inputobj.textdiv;
                        if (textdiv) {
                            textdiv.style.fontSize = (item.fontsize * ds) + "px";
                            textdiv.style.letterSpacing = (-0.3 * ds) + 'px';
                            textdiv.style.top = ((pageobj.top + item.y) * ds) + 'px';
                            textdiv.style.left = ((pageobj.left + item.x) * ds) + 'px';
                            textdiv.style.width = ((item.width - item.borderleft - item.borderright) * ds - requiredWidth) + 'px';
                            textdiv.style.height = ((item.height - item.bordertop - item.borderbottom) * ds - requiredWidth) + 'px';
                            textdiv.style.paddingLeft = (item.leftMargin * ds) + "px";
                            textdiv.style.paddingRight = (item.rightMargin * ds) + "px";
                            textdiv.style.paddingTop = (item.topMargin * ds) + "px";
                            textdiv.style.paddingBottom = (item.bottomMargin * ds) + "px";
                            inputdiv.appendChild(textdiv);
                        }
                        inputobj.style.top = ((pageobj.top + item.y + 1) * ds) + 'px';
                        inputobj.style.left = ((pageobj.left + item.x + 1) * ds) + 'px';
                        inputobj.style.width = ((item.width - item.borderleft - item.borderright - 1) * ds - requiredWidth) + 'px';
                        inputobj.style.height = ((item.height - item.bordertop - item.borderbottom - 1) * ds - requiredWidth) + 'px';
                    } else {
                        inputobj.style.top = ((pageobj.top + item.y) * ds) + 'px';
                        inputobj.style.left = ((pageobj.left + item.x) * ds) + 'px';
                        inputobj.style.width = ((item.width - item.borderleft - item.borderright) * ds - requiredWidth) + 'px';
                        inputobj.style.height = ((item.height - item.bordertop - item.borderbottom) * ds - requiredWidth) + 'px';
                    }
                } inputdiv.appendChild(inputobj);
                if (inputhiddenobj != null) {
                    inputhiddenobj.id = item.id + '_file';
                    inputdiv.appendChild(inputhiddenobj);
                }
            }
        }
    }
};
function _ubi_eform_drawSavedImage(inputObj) {
    var img = new Image();
    img.addEventListener('load', function () {
        var ctx = inputObj.getContext("2d");
        ctx.drawImage(img, 0, 0, parseInt(inputObj.width), parseInt(inputObj.height));
        var orgCanvas = document.createElement('canvas');
        orgCanvasCtx = orgCanvas.getContext("2d");
        orgCanvas.width = img.width;
        orgCanvas.height = img.height;
        orgCanvasCtx.drawImage(img, 0, 0);
        inputObj.orgdata = orgCanvasCtx.getImageData(0, 0, img.width, img.height);
    }, true);
    img.src = inputObj.orgdata;
};
function _ubi_eform_checkValidInputItems(doc) {
    if (doc) {
        if (doc.pages && doc.pages.GetSize() > 0) {
            var pageobj = null;
            var items = null;
            var item = null;
            for (var i = 0; i < doc.pages.GetSize(); i++) {
                pageobj = doc.pages.GetAt(i);
                items = pageobj.items;
                for (var j = 0; j < items.GetSize(); j++) {
                    item = items.GetAt(j);
                    if (item.eforminfo.required) {
                        var isNotValid = false;
                        if (item.eforminfo.type == UbiEformItemInfo.TYPE_TEXT) {
                            if (item
                                    .inputobj
                                    .textnode
                                    .textContent == '') {
                                isNotValid = true;
                            }
                        } else if (item.eforminfo.type == UbiEformItemInfo.TYPE_SIGNATURE) {
                            if (! item.inputobj.orgdata) {
                                isNotValid = true;
                            }
                        } else if (item.eforminfo.type == UbiEformItemInfo.TYPE_CHECKBOX) {
                            var ubiinputobj = item.inputobj.childNodes[0];
                            if (! ubiinputobj.checked) {
                                isNotValid = true;
                            }
                        } else if (item.eforminfo.type == UbiEformItemInfo.TYPE_RADIO) {
                            var ubiinputobj = item.inputobj.childNodes[0];
                            var objname = ubiinputobj.name;
                            var objs = document.getElementsByName(objname);
                            var check = true;
                            for (var k = 0; k < objs.length; k++) {
                                if (objs[k].checked) {
                                    check = false;
                                }
                            }
                            isNotValid = check;
                        }
                        if (isNotValid) {
                            var str = '필수 항목이 입력되지 않았습니다.';
                            if (item.eforminfo.description && item.eforminfo.description != '') {
                                str += '\n\n' + item.eforminfo.description;
                            }
                            str += '\n\n확인을 누르면 입력 항목로 이동합니다.';
                            if (confirm(str)) {
                                setTimeout(function () {
                                    if (item.eforminfo.type == UbiEformItemInfo.TYPE_CHECKBOX) {
                                        var ubiinputobj = item.inputobj.childNodes[1];
                                        ubiinputobj.style.outline = "-webkit-focus-ring-color auto 5px";
                                        ubiinputobj.onclick = function () {
                                            ubiinputobj.style.outline = "";
                                        }
                                    } else if (item.eforminfo.type == UbiEformItemInfo.TYPE_RADIO) {
                                        var ubiinputobj = item.inputobj.childNodes[1];
                                        var ubiinputraidoobj = item.inputobj.childNodes[0];
                                        ubiinputobj.style.border = "2px solid #000000";
                                        ubiinputraidoobj.onclick = function () {
                                            ubiinputobj.style.border = "1px solid #4289DB";
                                        }
                                    } else {
                                        item.inputobj.focus();
                                    }
                                }, 0);
                            }
                            return false;
                        }
                    }
                    item.setEformValue();
                }
            }
            for (var i = 0; i < doc.pages.GetSize(); i++) {
                pageobj = doc.pages.GetAt(i);
                if (pageobj.editcanvasid && pageobj.editcanvasid != '') {
                    var svg = document.getElementById(pageobj.editcanvasid);
                    if (svg && svg.childNodes) {
                        var g = svg.childNodes[0];
                        if (g.childNodes.length > 0) {
                            pageobj.setEditCanvas(_ubi_XmlToString(svg));
                        }
                    }
                }
            }
        }
    }
    return true;
};
function _ubi_eform_checkValidInputItemsOnPage(doc, page) {
    if (doc) {
        if (doc.pages && doc.pages.GetSize() > 0) {
            var pageobj = null;
            var items = null;
            var item = null;
            if (doc.pages.GetSize() > 0 && doc.pages.GetSize() >= page) {
                pageobj = doc.pages.GetAt(page - 1);
                items = pageobj.items;
                for (var j = 0; j < items.GetSize(); j++) {
                    item = items.GetAt(j);
                    if (item.eforminfo.required) {
                        var isNotValid = false;
                        if (item.eforminfo.type == UbiEformItemInfo.TYPE_TEXT) {
                            if (item
                                    .inputobj
                                    .textnode
                                    .textContent == '') {
                                isNotValid = true;
                            }
                        } else if (item.eforminfo.type == UbiEformItemInfo.TYPE_SIGNATURE) {
                            if (! item.inputobj.orgdata) {
                                isNotValid = true;
                            }
                        }
                        if (isNotValid) {
                            var str = '필수 항목이 입력되지 않았습니다.';
                            if (item.eforminfo.description && item.eforminfo.description != '') {
                                str += '\n\n' + item.eforminfo.description;
                            }
                            str += '\n\n확인을 누르면 입력 항목로 이동합니다.';
                            if (confirm(str)) {
                                setTimeout(function () {
                                    item.inputobj.focus();
                                }, 0);
                            }
                            return false;
                        }
                    }
                    item.setEformValue();
                }
            }
        }
    }
    return true;
};
function _ubi_eform_inputImageFile(inputobj) {
    console.log(inputobj.id);
    var inputhiddenobj = document.getElementById(inputobj.id + '_file');
    inputhiddenobj.addEventListener('change', function (ev) {
        if (ev.target.files) {
            var file = ev.target.files[0];
            var reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onloadend = function (e) {
                var image = new Image();
                image.src = e.target.result;
                image.onload = function (ev) {
                    var orgcanvas = document.createElement('canvas');
                    orgcanvas.width = image.width;
                    orgcanvas.height = image.height;
                    var orgctx = orgcanvas.getContext('2d');
                    orgctx.drawImage(image, 0, 0);
                    var width = parseInt(inputobj.width);
                    var height = parseInt(inputobj.height);
                    var imgds = orgcanvas.height / orgcanvas.width;
                    var imgwidth = width;
                    var imgheight = height;
                    inputobj.getContext('2d').clearRect(0, 0, inputobj.width, inputobj.height);
                    inputobj.getContext('2d').beginPath();
                    inputobj.getContext('2d').drawImage(orgcanvas, 0, 0, imgwidth, imgheight);
                    inputobj.orgdata = inputobj.getContext('2d').getImageData(0, 0, parseInt(inputobj.width) - 1, parseInt(inputobj.height) - 1);
                }
            }
        }
    });
    inputhiddenobj.click();
}