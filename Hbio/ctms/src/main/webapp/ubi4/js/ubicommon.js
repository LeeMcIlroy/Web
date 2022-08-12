var __isDebug = true;

var __gap = 6;
var __ubiViewer;
var __viewerDivId;
var __headTag = document.getElementsByTagName('head')[0];

function UbiLoad(params) {
	
	var pUbiFile = params['ubifile'];
	var runType = 'report';
	if( pUbiFile.lastIndexOf(".jef") == (pUbiFile.length - 4) )
		runType = 'eform';
	
	if( __isDebug )
		console.log('[ubicommon]runType===' + runType);
	
	if( runType == 'report' )
		openReportViewer(params);	// 리포트 뷰어 호출
	else
		openEformViewer(params);	// 이폼 뷰어 호출
	return __ubiViewer;
};

function openReportViewer(params) {

	// 속성 설정
	var pAppName = params['appname'];
	var pUbiKey = params['ubikey'];
	var pUbiServer = params['ubiserver'];
	var pUbiResource = params['ubiresource'];
	var pUbiFile = params['ubifile'];
	var pUbiArg = params['ubiarg'];
	var pUbiResId = params['ubiresid'];
	var pUbiScale = params['ubiscale'];
	var pUbiEncrypt = params['ubiencrypt'];
	var pUbiReportTitle = params['reporttitle'];

	if( pUbiEncrypt == 'undefined' || pUbiEncrypt != 'false' )
		pUbiEncrypt = 'true';
	
	// 이벤트 설정
	var pReportPreviewEnd = params['reportevent.previewend'];
	var pReportPrintEnd = params['reportevent.printend'];
	var pReportExportEnd = params['reportevent.exportend'];
	
	var appUrl = self.location.protocol + '//' + self.location.host + (pAppName==''?'':('/' + pAppName));
	
	if( __isDebug ) {
		console.log('[ubicommon]pAppName===' + pAppName);
		console.log('[ubicommon]pUbiKey===' + pUbiKey);
		console.log('[ubicommon]pUbiServer===' + pUbiServer);
		console.log('[ubicommon]pUbiResource===' + pUbiResource);
		console.log('[ubicommon]pUbiFile===' + pUbiFile);
		console.log('[ubicommon]pUbiArg===' + pUbiArg);
		console.log('[ubicommon]pUbiResId===' + pUbiResId);
		console.log('[ubicommon]pUbiScale===' + pUbiScale);
		console.log('[ubicommon]pUbiEncrypt===' + pUbiEncrypt);
		console.log('[ubicommon]appUrl===' + appUrl);
	}

	__viewerDivId = 'UbiReportViewerDiv';
	
	//뷰어가 보여질 DIV를 동적으로 생성
	if( document.getElementById(__viewerDivId) == null || document.getElementById(__viewerDivId) == 'undefined' ) {
		var div = document.createElement('div');
		div.id = __viewerDivId;
		div.style.border = '1px solid #767676';
		div.style.borderBottomWidth = '2px'; 
		document.body.style.margin = '1px';
		document.body.appendChild(div);
	}
	window.addEventListener("resize", UbiResize);

	UbiResize();
	__ubiViewer = new UbiViewer( {
		key : pUbiKey,
		ubiserverurl : appUrl + pUbiServer,
		resource : appUrl + pUbiResource,
		divid : __viewerDivId,
		scale : pUbiScale,
		//	issvg : 'false',
		resid : pUbiResId,
		jrffile : pUbiFile,
		arg : pUbiArg,
		isencrypt64 : pUbiEncrypt,
		reporttitle : pUbiReportTitle,
		docxTableFixed : 'false'
	});

	if( pReportPreviewEnd != undefined )
		__ubiViewer.showReport(pReportPreviewEnd);
	else
		__ubiViewer.showReport();
	
	if( pReportPrintEnd != undefined )
		__ubiViewer.events.printEnd = pReportPrintEnd;
	if( pReportExportEnd != undefined )
		__ubiViewer.events.exportEnd = pReportExportEnd;

	return __ubiViewer 
};

function openEformViewer(params) {

	// 속성 설정
	var pAppName = params['appname'];
	var pUbiKey = params['ubikey'];
	var pUbiServer = params['ubiserver'];
	var pUbiSave = params['ubisave'];
	var pUbiResource = params['ubiresource'];
	var pUbiFile = params['ubifile'];
	var pUbiArg = params['ubiarg'];
	var pUbiResId = params['ubiresid'];
	var pUbiScale = params['ubiscale'];
	var pUbiEncrypt = params['ubiencrypt'];
	if( pUbiEncrypt == 'undefined' || pUbiEncrypt != 'false' )
		pUbiEncrypt = 'true';
	
	// 이벤트 설정
	var pEformPreviewEnd = params['eformevent.previewend'];
	var pEformSaveEnd = params['eformevent.saveend'];
	
	var appUrl = self.location.protocol + '//' + self.location.host + (pAppName==''?'':('/' + pAppName));
	
	if( __isDebug ) {
		console.log('[ubicommon]pAppName===' + pAppName);
		console.log('[ubicommon]pUbiKey===' + pUbiKey);
		console.log('[ubicommon]pUbiServer===' + pUbiServer);
		console.log('[ubicommon]pUbiResource===' + pUbiResource);
		console.log('[ubicommon]pUbiFile===' + pUbiFile);
		console.log('[ubicommon]pUbiArg===' + pUbiArg);
		console.log('[ubicommon]pUbiResId===' + pUbiResId);
		console.log('[ubicommon]pUbiScale===' + pUbiScale);
		console.log('[ubicommon]pUbiEncrypt===' + pUbiEncrypt);
		console.log('[ubicommon]appUrl===' + appUrl);
	}
	
	__viewerDivId = 'UbiEFormViewerDiv';

	if( document.getElementById(__viewerDivId) == null || document.getElementById(__viewerDivId) == 'undefined' ) {
		var div = document.createElement('div');
		div.id = __viewerDivId;
		document.body.style.margin = '0px';
		document.body.style.padding = '0px';
		document.body.appendChild(div);
	}
	
	__ubiViewer = new ubireport.eform.Viewer( {
		key : pUbiKey,
		ubiserverurl: appUrl + pUbiServer,
		saveurl: appUrl + pUbiSave,
		resource : appUrl + pUbiResource,
		divid: __viewerDivId,
		scale: pUbiScale,
		resid: pUbiResId,
		jrffile: pUbiFile,
		arg : pUbiArg,
		isencrypt64 : pUbiEncrypt
	});

	if( pEformPreviewEnd != undefined )
		__ubiViewer.showReport(pEformPreviewEnd);
	else
		__ubiViewer.showReport();
	if( pEformSaveEnd != undefined )
		__ubiViewer.events.saveEnd = pEformSaveEnd;
};

function UbiResize() {

	document.getElementById(__viewerDivId).style.width = getViewerWidth() + 'px';
	document.getElementById(__viewerDivId).style.height = getViewerHeight() + 'px';
};



function getViewerWidth() {
	return ((self.innerWidth || (document.documentElement && document.documentElement.clientWidth) || document.body.clientWidth)) - __gap;
};

function getViewerHeight() {
	return 	((self.innerHeight || (document.documentElement && document.documentElement.clientHeight) || document.body.clientHeight)) - __gap;
};
