$(function(){
	
	// message 값이 존재하는 경우 alert을 띄웁니다.
    if( $("#message").length==1 && $("#message").val()!='' ){
        alert( $("#message").val() );
        $("#message").val('');
    }
    
    // 상황판 인터벌용 변수
    var timer1 = null;
    var timer2 = null;
    
    var timer3 = null;
    var timer4 = null;
    var timer5 = null;
    var timer6 = null;
    
	if($(document).width() > 1024) $("#rader").attr("href", 'http://www.weather.go.kr/weather/images/rader_integrate.jsp');
});

//지정된 파일 & 용량 확인(관리자)
function fileCheck_adm(id, fileSize) {

	var file = $("#"+id).val();
	
	//파일확장자 검사
	var fileExt = file.substring(file.lastIndexOf('.') + 1).toUpperCase();
	if (id == "titleImg") {
		if (fileExt != "BMP" && fileExt != "JPG" && fileExt != "GIF" && fileExt != "PNG") {
			alert("가능한 파일이 아닙니다.");
			$("#"+id).replaceWith( $("#"+id).clone(true) );
			return;
		}			
	}else if (id == "attachedFile_PDF"){
		if(fileExt != "PDF"){
			alert("가능한 파일이 아닙니다.");
			$("#"+id).replaceWith( $("#"+id).clone(true) );
			return;
		}
	}else if (fileExt != "HWP" && fileExt != "DOC" && fileExt != "TXT"
		&& fileExt != "PPT" && fileExt != "XLS" && fileExt != "PDF"
			&& fileExt != "BMP" && fileExt != "JPG" && fileExt != "GIF" 
				&& fileExt != "PNG"  && fileExt != "XLSX" && fileExt != "AI") {
		
		alert("가능한 파일이 아닙니다.");
		$("#"+id).replaceWith( $("#"+id).clone(true) );
		return;
	}else if (id == "attachedFile_hotLine"){
		if(fileExt != "XLSX"){
			alert("가능한 파일이 아닙니다.");
			$("#"+id).replaceWith( $("#"+id).clone(true) );
			return;
		}
	}
	
	//하위브라우저에서는 확인이 안됨.
	if(fileSize== -1){
		console.log("구 버전의 브라우저에서는 파일사이즈 검사가 정상적으로 동작하지 않습니다.");
		return false;
	}
	
	//파일사이즈 검사
	var maxSize = 10*1024*1024; //10메가
	if (fileSize > maxSize) {
		alert("첨부된 파일의 용량이 초과하였습니다.");
		$("#"+id).replaceWith( $("#"+id).clone(true) );
		return;
	}
}


//지정된 파일 & 용량 확인(사용자)
function fileCheck(id, fileSize) {

	var file = $("#"+id).val();
	
	//하위브라우저에서는 확인이 안됨.
	if(fileSize== -1){
		alert("오류가 발생하였습니다. 구 버전의 브라우저에서는 동작하지 않을 수 있습니다.");
		$("#"+id).replaceWith( $("#"+id).clone(true) );
		return false;
	}
	
	//파일확장자 검사
	var fileExt = file.substring(file.lastIndexOf('.') + 1).toUpperCase();
	if (id == "uploadImage") {
		if (fileExt != "BMP" && fileExt != "JPG" && fileExt != "GIF" && fileExt != "PNG") {
			alert("가능한 파일이 아닙니다.");
			$("#"+id).replaceWith( $("#"+id).clone(true) );
			return;
		}			
	}else if (fileExt != "HWP" && fileExt != "DOC" && fileExt != "TXT"
		 && fileExt != "PPT" && fileExt != "XLS" && fileExt != "PDF"
		 && fileExt != "BMP" && fileExt != "JPG" && fileExt != "GIF" 
		 && fileExt != "PNG") {
		
		alert("가능한 파일이 아닙니다.");
		$("#"+id).replaceWith( $("#"+id).clone(true) );
		return;
	}
	
	//파일사이즈 검사
	var maxSize = 5*1024*1024; //5메가
	if (fileSize > maxSize) {
		alert("첨부된 파일의 용량이 초과하였습니다.");
		$("#"+id).replaceWith( $("#"+id).clone(true) );
		return;
	}
}

//html 태그 제거
function fn_removeTag(str) {
	return str.replace(/(<([^>]+)>)/gi, "");
}

//뒤로가기
function fn_hisback(){
	history.back();
}

//숫자 & 백스페이스만 입력가능
function showKeyCode(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) ||  keyID == 8 || keyID == 9)
	{
		return;
	}
	else
	{
		
		return false;
	}
}

function connect(id)
{
	if(id=='1'){
		fn_createCCTV('cctv1', 'WatSearCtrl');
		
	    var temp = WatSearCtrl.setCameraMap(0, 0, 'sisul6', 'sisul6', 0, 'admin', 'rkdqnr1!', 8016, 0, false, true, 'dvrnames.net', 10088, 8116);
	    WatSearCtrl.setupOSD(true, false, false, false, false, false);
	    WatSearCtrl.setLayout(0);
		WatSearCtrl.connectEx(false);
	}else{
		fn_createCCTV('cctv2', 'WatSearCtrl2');
		
		var temp = WatSearCtrl2.setCameraMap(0, 0, 'seoulsi6', 'seoulsi6', 0, 'admin', 'rkdska1!', 8016, 0, false, true, 'dvrnames.net', 10088, 8116);
		WatSearCtrl2.setupOSD(true, false, false, false, false, false);
	    WatSearCtrl2.setLayout(0);
		WatSearCtrl2.connectEx(false);
	}

	setTimeout(function() {
		fn_disconnectCCTV(id);
	}, 30*1000);
}

function fn_createCCTV(id, target){
	// id = cctv1 or cctv2
	// target = WatSearCtrl or WatSearCtrl2
	var tags = '';
	tags += '<OBJECT id="'+target+'" codebase="/assets/cctv/WatSearCtrl.cab#Version=2,6,6,6" classid="clsid:03C0000A-CF6D-4ef4-A2D6-376622318018" standby="Downloading the ActiveX Control..." width=100% height=100% align=center hspace=0 vspace=0>';
	tags += '	<PARAM name="Language"	value="5">';
	tags += '	<PARAM name="Oem"		value="0">';
	tags += '	<PARAM name="Audio"		value="1">';
	tags += '	<PARAM name="RBTN"		value="false">';
	tags += '	<PARAM name="wmode"		value="transparent">';
	tags += '</OBJECT>';
	
	$('#'+id).append(tags);
}

function fn_disconnectCCTV(id){
	// id = cctv1 or cctv2
	var flag = false;
	if(id=='1'){
		flag = WatSearCtrl.disconnectbyCamera(0);
		if(flag){
			WatSearCtrl.finalize()
			$('#cctv'+id).html("");
		}
	}else{
		flag = WatSearCtrl2.disconnectbyCamera(0);
		if(flag){
			WatSearCtrl2.finalize()
			$('#cctv'+id).html("");
		}
	}
}

function fn_timeCheck(id, lastTime, flag){
	var now = new Date();
	var lastInit = new Date(lastTime.replace(/\./g, "/"));
	
	var overTime = new Date(now.getTime()-lastInit.getTime()-(10 * 60 * 1000));
	if(flag == 'Y'){
		overTime = new Date(now.getTime()-lastInit.getTime());
	}
	
	var diffMinutes = Math.floor(overTime.getTime()/(1000*60));
	
	if(diffMinutes <= 59){
//		var dt_now = overTime.getMinutes()+"분 "+overTime.getSeconds()+"초 전 갱신"; 
		var dt_now = overTime.getMinutes()+"분 전 갱신"; 
		if(overTime.getMinutes() >= 32){
			dt_now = '<font color="yellow">'+dt_now+'</font>';
		}
	}else{
		dt_now = '<font color="yellow">점검필요</font>';
	}
    $("#dt_now"+id).html(dt_now);
}

function fn_week(weekNum){
	var result = '확인 불가';
	switch (weekNum){
		case 0 : result = '일'; break;
		case 1 : result = '월'; break;
		case 2 : result = '화'; break;
		case 3 : result = '수'; break;
		case 4 : result = '목'; break;
		case 5 : result = '금'; break;
		case 6 : result = '토'; break;
	}
	return result;
}

function fn_reload(){
	
	var tmpUrl = location.pathname.replace('.do', 'ReloadAjax.do');
	
	// 기후경영 페이지 리로딩
	if(location.pathname.indexOf('main2') >= 0) {
		location.reload();
	}else if(location.pathname.indexOf('main') >= 0 || location.pathname.indexOf('dongbu') >= 0 || location.pathname.indexOf('olympic') >= 0){
		$.ajax({
			url: tmpUrl
			, type: "post"
				, dataType:"json"
					, async : false
					, success: function(data){
						if(location.pathname.indexOf('main') >= 0){
							// 종합상황판
							fn_mainReload(data);
						}else if(location.pathname.indexOf('dongbu') >= 0){
							// 동부간선도로
							fn_dongbuReload(data);
						}else if(location.pathname.indexOf('olympic') >= 0){
							fn_olympicReload(data);
						}
					}, error: function(){
						alert("오류가 발생하였습니다.");
					}
		});
	}else{
		location.reload();
	}
}

function fn_setWaterLevelGraphAndList(target, waterLevelData, wlList, wlTime, wlTimeId){
	// graph - start
	var arrBaseDttm = ['x'];
	var arrWl = ['수위'];
	$.each(waterLevelData, function(i, result){
		arrBaseDttm.push(result.baseDttm);
		arrWl.push(result.wl);
	});
	target.load({
		columns: [arrBaseDttm, arrWl]
	});
	// graph - end
	// list - start
	$('#'+target.element.id+'List').empty();
	var tags = '';
	$.each(wlList, function(i, result){
		tags += '<tr';
		if(result.level == '3') tags += ' class="grid_table_alt"';
		tags += '>';
		tags += '<td>'+result.baseTime+'</td>';
		tags += '<td>'+result.wl+'</td>';
		tags += '<td>';
		if(result.level == '0'){ tags += '평시'; }
		else if(result.level == '1'){ tags += '준비'; }
		else if(result.level == '2'){ tags += '경고'; }
		else if(result.level == '3'){ tags += '침수'; }
		tags += '</td>';
		tags += '</tr>';
	});
	$('#'+target.element.id+'List').append(tags);
	// list - end
	// time - start
	if(wlTime != null){
		if(wlTimeId == 1){
			clearInterval(timer1);
			timer1 = setInterval(function() {
				if(target.element.id == 'wolgye1' || target.element.id == 'yeoui'){
					fn_timeCheck(wlTimeId, wlTime, 'Y');
				}else{
					fn_timeCheck(wlTimeId, wlTime, 'N');
				}
			}, 1000);
		}else{
			clearInterval(timer2);
			timer2 = setInterval(function() {
				if(target.element.id == 'wolgye1' || target.element.id == 'yeoui'){
					fn_timeCheck(wlTimeId, wlTime, 'Y');
				}else{
					fn_timeCheck(wlTimeId, wlTime, 'N');
				}
			}, 1000);
		}
	}
	// time - end
}

function fn_setRainfallGraph(target, rainfallData){
	
	var arrBaseDttm = ['x'];
	var arrRainfall = ['강수량'];
	var arrTotRainfall = ['누적강수량'];
	var totRainfall = 0;
	
	$.each(rainfallData, function(i, result){
		arrBaseDttm.push(result.baseDttm);
		arrRainfall.push(result.rn1);
		totRainfall = parseFloat(result.rn1)+totRainfall;
		arrTotRainfall.push(totRainfall.toFixed(2));
	});
	
	target.load({
		columns: [arrBaseDttm, arrRainfall, arrTotRainfall]
	});
}

function fn_setFloodControl(floodMap){
	// 발령일시 emtpy
	var issueDttmObj = $('#floodControlView').children().eq(1); 
	issueDttmObj.empty();
	// 단계 emtpy
	var issueLevelObj = $('#floodControlView').children().eq(2);
	issueLevelObj.empty();
	
	var tags = '';
	// 발령일시 set - start
	tags = '<p>'+floodMap.issueDate+' '+floodMap.issueTime+' 발령</p>'+floodMap.floodContent;
	issueDttmObj.append(tags);
	// 발령일시 set - end
	// 단계 set - start
	if(floodMap.floodLevel == 1){ tags = '<img src="/assets/img/step_orange.png" alt="주의"/>'; }
	else if(floodMap.floodLevel == 2){ tags = '<img src="/assets/img/step_red.png" alt="경계"/>'; }
	else if(floodMap.floodLevel == 3){ tags = '<img src="/assets/img/step_purple.png" alt="심각"/>'; }
	else if(floodMap.floodLevel == 4){ tags = '<img src="/assets/img/step_green.png" alt="평시"/>'; }
	else if(floodMap.floodLevel == 5){ tags = '<img src="/assets/img/step_blue.png" alt="포트홀"/>'; }
	else if(floodMap.floodLevel == 6){ tags = '<img src="/assets/img/step_yellow.png" alt="보강"/>'; }
	issueLevelObj.append(tags);
	// 단계 set - end
}

function fn_setMainAlarm(mainAlarm, alarmList){
	var tags = '';
	// top - start
	$('#viewMainAlarm').empty();
	$('#viewMainAlarm').append(mainAlarm);
	// top - end
	// bottom flexslider - start
	var flexsliderParentObj = $('#viewMainAlarm').parent().next();
	flexsliderParentObj.empty();
	tags += '<div class="flexslider"><ul class="slides">';
	if(alarmList != null){
		$.each(alarmList, function(i , result){
			tags += '<li><div>'+result.alarmContent+' <span>'+result.baseDate+' '+result.baseTime+'</span></div></li>';
		});
	}else{
		tags += '<li><div>안전을 누리고 서울을 즐기다 - 서울시설공단</div></li>';
	}
	tags += '</ul></div>';
	flexsliderParentObj.append(tags);
	$('.flexslider').flexslider({
	    animation: "slide",
	    slideshowSpeed: 5000,
	    maxItems: 6,
	    customDirectionNav: $(".custom-navigation a")
	  });
	// bottom flexslider - end
}

function fn_setWeather(weatherMap, weatherMap2){
	var tags = '';
	// top 발표시간 - start
	var issueDttmObj = $('.wd_top_box').children().eq(0).find('label');
	issueDttmObj.empty();
	issueDttmObj.append('발표시간 : '+weatherMap.updateTime);
	// top 발표시간 - end
	// bottom - start
		// 현재 날씨 - start
		var weatherInfoObj = $('.wd_top_box').children().eq(1).find('ul');
		weatherInfoObj.children().eq(1).empty();
		tags += '<dl><dt>'+weatherMap.t1h+'℃</dt>';
		tags += '<dd>습도 '+weatherMap.reh+'%<br>강수량 '+weatherMap.rn1+'㎜<br>누적강수량 '+weatherMap.rn24.toFixed(1)+'㎜</dd></dl>';
		weatherInfoObj.children().eq(1).append(tags);
		// 현재 날씨 - end
		
		// 예보 - start
		weatherInfoObj.children().eq(2).empty();
		tags = '<div><ul style="vertical-align:middle; text-align:center;">';
		tags += '<li><img src="/assets/img/w_icon'+weatherMap.status+'.png" alt="" style="width: 50%; height: 50%;"/><p class="mt5"></p></li></ul></div>';
		weatherInfoObj.children().eq(2).append(tags);
		
		weatherInfoObj.children().eq(3).empty();
		tags = '<dl><dt>'+weatherMap2.updateTime+'시 예보</dt>';
		tags += '<dd>'+weatherMap2.t1h+'℃<br>강수량 '+weatherMap2.rn1+'㎜<br>누적강수량 '+((parseFloat(weatherMap.rn24) + parseFloat(weatherMap2.rn1))).toFixed(1)+'㎜</dd></dl>';
		weatherInfoObj.children().eq(3).append(tags);
		// 예보 - end
	// bottom - end
}

// 여의상류IC 침수 수위
const yeouiFloodWaterLevel = 5.4;
// 한강대교 침수 수위
const hangangFloodWaterLevel = 5.4;
// 신곡교 침수 수위
const singokFloodWaterLevel = 2.6;
// 월계1교 침수 수위
const wolgye1FloodWaterLevel = 17.23;

// 월릉교 침수 수위
const wolleunFloodWaterLevel = 15.41;

function fn_setMapData(yeouiWaterLevel, hangangWaterLevel, paldangTototf, singokWaterLevel, uijeongbuRainFall, wolgye1WaterLevel){
	
	yeouiWaterLevel = parseFloat(yeouiWaterLevel==null? 0:yeouiWaterLevel);
	hangangWaterLevel = parseFloat(hangangWaterLevel==null? 0:hangangWaterLevel);
	paldangTototf = parseFloat(paldangTototf==null? 0:paldangTototf);
	singokWaterLevel = parseFloat(singokWaterLevel==null? 0:singokWaterLevel);
	uijeongbuRainFall = parseFloat(uijeongbuRainFall==null? 0:uijeongbuRainFall);
	wolgye1WaterLevel = parseFloat(wolgye1WaterLevel==null? 0:wolgye1WaterLevel);
	
	if($('#yeouiWaterLevel').length > 0) $('#yeouiWaterLevel').html('여의상류IC 수위 : '+yeouiWaterLevel+'m<br>(침수까지 : '+(yeouiWaterLevel-yeouiFloodWaterLevel).toFixed(2)+'m)');
	if($('#hangangWaterLevel').length > 0) $('#hangangWaterLevel').html('한강대교 수위 : '+hangangWaterLevel+'m<br>(침수까지 : '+(hangangWaterLevel-hangangFloodWaterLevel).toFixed(2)+'m)');
	if($('#paldangTototf').length > 0) $('#paldangTototf').html('팔당댐 방류량 : '+paldangTototf+'㎥/s');
	if($('#singokWaterLevel').length > 0) $('#singokWaterLevel').html('신곡교 수위 : '+singokWaterLevel+'m<br>(침수까지 : '+(singokWaterLevel-singokFloodWaterLevel).toFixed(2)+'m)');
	if($('#uijeongbuRainFall').length > 0) $('#uijeongbuRainFall').html('의정부 강수량 : '+uijeongbuRainFall+'㎜');
	if($('#wolgye1WaterLevel').length > 0) $('#wolgye1WaterLevel').html('월계1교 수위 : '+wolgye1WaterLevel+'m<br>(침수까지 : '+(wolgye1WaterLevel-wolgye1FloodWaterLevel).toFixed(2)+'m)');
	
	$('.end_info').empty();
	var tags = '';
	tags += '<div><ul><li><p>한강대교수위</p>'+hangangWaterLevel+'m</li></ul></div>';
	tags += '<div><ul><li><p>팔당댐방류량</p>'+paldangTototf+'㎥/s</li></ul></div>';
	$('.end_info').append(tags);
}

function fn_setDamGraphAndList(target, damData, damList, damTimeId){
	// graph - start
	var arrBaseDttm = ['x'];
	var arrWl = ['방류량'];
	$.each(damData, function(i, result){
		arrBaseDttm.push(result.baseTime);
		arrWl.push(result.tototf);
	});
	target.load({
		columns: [arrBaseDttm, arrWl]
	});
	// graph - end
	// list - start
	$('#'+target.element.id+'List').empty();
	var tags = '';
	$.each(damList, function(i, result){
		tags += '<tr';
		if(result.level == '3') tags += ' class="grid_table_alt"';
		tags += '>';
		tags += '<td>'+result.baseTime+'</td>';
		tags += '<td>'+result.tototf.toFixed(1)+'㎥/s</td>';
		tags += '</tr>';
	});
	$('#'+target.element.id+'List').append(tags);
	// list - end
	// time - start
	if(damData.length > 0){
//		console.log(damData[damData.length-1].regDttm);
		var tmpDate = new Date(damData[damData.length-1].regDttm);
		var y = tmpDate.getFullYear().toString();
		var m = (tmpDate.getMonth()+1).toString();
		var d = tmpDate.getDate().toString();
		
		var w = fn_week(tmpDate.getDay());
		
		var H = tmpDate.getHours().toString();
		var M = tmpDate.getMinutes().toString();
		
		$('#'+damTimeId).html('('+y+'.'+(m[1]? m:'0'+m[0])+'.'+(d[1]? d:'0'+d[0])+'('+w+') '+(H[1]? H:'0'+H[0])+':'+(M[1]? M:'0'+M[0])+')');
	}
	// time - end
}

var status1 = {src : "/assets/img/step_blue.png", alt: "양호"};
var status2 = {src : "/assets/img/step_red.png", alt: "통제"};
var status3 = {src : "/assets/img/w_icon.png", alt: "데이터 오류"};

function fn_mainReload(data){
	// 단계설정 - start
	fn_setFloodControl(data.floodMap);
	// 단계설정 - end
	
	// 메인알림 - start
	fn_setMainAlarm(data.mainAlarm, data.alarmList);
	// 메인알림 - end
	
	// 기상정보 - start
	fn_setWeather(data.weatherMap, data.weatherMap2);
	// 기상정보 - end
	
	// 월계1교 set - start
	fn_setWaterLevelGraphAndList(wolgye1, data.wolgyeWaterLevelGraphData, data.wlList1, data.wlTime1, 1);
	// 월계1교 set - end

	// 월릉 - start
	fn_setWaterLevelGraphAndList(wolleung, data.wolleungWaterLevelGraphData, data.wlList2, data.wlTime2, 2);
	// 월릉 set - end
	
	// 중랑 - start
	fn_setWaterLevelGraphAndList(joongrang, data.joongrangWaterLevelGraphData, data.wlList3, data.wlTime3, 3);
	// 중랑 set - end
	
	// 여의 - start
	fn_setWaterLevelGraphAndList(yeoui, data.yeouiWaterLevelGraphData, data.wlList4, data.wlTime4, 4);
	// 여의 set - end
	
	// 한강 - start
	fn_setWaterLevelGraphAndList(hangang, data.hangangWaterLevelGraphData, data.wlList5, data.wlTime5, 5);
	// 한강 set - end
	
	// 수방근무현황 - start
	fn_snsReload();
	// 수방근무현황 - end
	
	// 지도 셋팅?
	
	// 올림픽대로 & 동부간선도로 & 전체맵 - start
	fn_setMapData(data.yeoui, data.hangang, data.paldang, data.singok, data.rain, data.wolgye);
	// 올림픽대로 & 동부간선도로 & 전체맵 - end
	
	// 하천 
	
	var hacheon4 = data.wolgye1Hacheon;
	var hacheon5 = data.wolleungHacheon;
	var hacheon6 = data.joongrangHacheon;

	if(hacheon4 == 1) $("img#hacheon4").attr(status1);
	else if(hacheon4 == 2 || hacheon4 == 0) $("img#hacheon4").attr(status2);
	else  $(status3);

	if(hacheon5 == 1) $("img#hacheon5").attr(status1);
	else if(hacheon5 == 2 || hacheon5 == 0) $("img#hacheon5").attr(status2);
	else  $(status3);
	
	if(hacheon6 == 1) $("img#hacheon6").attr(status1);
	else if(hacheon6 == 2 || hacheon6 == 0) $("img#hacheon6").attr(status2);
	else  $(status3);

}

function fn_dongbuReload(data){
	// 단계설정 - start
	fn_setFloodControl(data.floodMap);
	// 단계설정 - end
	
	// 메인알림 - start
	fn_setMainAlarm(data.mainAlarm, data.alarmList);
	// 메인알림 - end
	
	// 기상정보 - start
	fn_setWeather(data.weatherMap, data.weatherMap2);
	// 기상정보 - end
	
	// 월계1교 set - start
	fn_setWaterLevelGraphAndList(wolgye1, data.wolgyeWaterLevelGraphData, data.wlList1, data.wlTime1, 1);
	// 월계1교 set - end

	// 월릉 - start
	fn_setWaterLevelGraphAndList(wolleung, data.wolleungWaterLevelGraphData, data.wlList2, data.wlTime2, 2);
	// 월릉 set - end
	
	// 중랑 - start
	fn_setWaterLevelGraphAndList(joongrang, data.joongrangWaterLevelGraphData, data.wlList3, data.wlTime3, 3);
	// 중랑 set - end
	
	// 신곡교 수위 set - start
	fn_setWaterLevelGraphAndList(singok, data.singokWaterLevelGraphData, data.wlList4, data.wlTime4, 4);
	// 신곡교 수위 set - end
	
	// 신곡동 기상 현황 - start
	$('.weather').empty();
	var tags = '';
	tags += '<div class="weather"><ul><li>발표시간 : '+data.singokWeather.baseDate+' '+data.singokWeather.baseTime+'</li>';
	tags += '<li><div><img src="/assets/img/w_icon'+data.singokWeather.status+'.png" alt="" /></div></li>';
	tags += '<li><ul><li><strong>온도:</strong> '+data.singokWeather.t1h+'℃</li>';
	tags += '<li><strong>습도:</strong> '+data.singokWeather.reh+'%</li>';
	tags += '<li><strong>1시간 강수량:</strong> '+data.singokWeather.rn1+'㎜</li>';
	tags += '<li><strong>누적 강수량:</strong> '+data.singokWeather.rn24+'㎜</li></ul></li></ul></div>';
	$('.weather').append(tags);
	// 신곡동 기상 현황 - end
	
	// 올림픽대로 & 동부간선도로 & 전체맵 - start
	fn_setMapData(data.yeoui, data.hangang, data.paldang, data.singok, data.rain, data.wolgye);
	// 올림픽대로 & 동부간선도로 & 전체맵 - end
	
	// 신곡동 강수량 - start
	fn_setRainfallGraph(rainFall, data.singokRainGraphData);
	// 신곡동 강수량 - end
	
	// 신곡동 기상예보 - start
	$('#singokPreWeather').empty();
	tags = '';
	
	tags += '<thead><tr><th>날짜</th><th colspan="'+parseInt(data.colspan1)*2+'">'+data.day1+'</th>';
	tags += '<th colspan="'+parseInt(data.colspan2)*2+'">'+data.day2+'</th></tr></thead>';
	tags += '<tbody><tr><td>시간</td>';
	$.each(data.weatherList, function(i, result){
		var time = result.fcstTime.substring(0, 2);
		tags += '<td colspan="2">'+time+'시</td>';
	});
	tags += '</tr><tr><td>날씨</td>';
	$.each(data.weatherList, function(i, result){
		tags += '<td colspan="2" class="wd_img"><img src="/assets/img/w_icon0'+result.status+'.png" alt="" /></td>';
	});
	tags += '</tr><tr><td>강수확률</td>';
	$.each(data.weatherList, function(i, result){
		tags += '<td colspan="2">'+result.pop+'%</td>';
	});
	tags += '</tr><tr><td>강수량</td>';
	$.each(data.weatherList, function(i, result){
		var time = parseInt(result.fcstTime.substring(0, 2));
		if(time%6 == 0){
			if(i==0){ tags += '<td colspan="5">'; }
			else if(i == data.weatherList.length-1){}
			else if(i == 5){ tags += '<td colspan="5">'; }
			else if(i == 6){ tags += '<td colspan="3">'; }
			else if(i != 5){ tags += '<td colspan="4">'; }
			
			if(result.r06 != 0) { tags += result.r06+'㎜'; }
			else{ tags += '-'; }
			
			tags += '</td>';
		}else if(time%6 == 3){
			if(i==0){
				tags += '<td colspan="3">';
				if(result.r06 != 0) { tags += result.r06+'㎜'; }
				else{ tags += '-'; }
				tags += '</td>';
			}
		}
	});
	tags += '</tr></tbody>';
	$('#singokPreWeather').append(tags);
	// 신곡동 기상예보 - end
	
	// 하천 
	var hacheon4 = data.wolgye1Hacheon;
	var hacheon5 = data.wolleungHacheon;
	var hacheon6 = data.joongrangHacheon;
	
	if(hacheon4 == 1) $("img#hacheon4").attr(status1);
	else if(hacheon4 == 2 || hacheon4 == 0) $("img#hacheon4").attr(status2);
	else  $(status3);

	if(hacheon5 == 1) $("img#hacheon5").attr(status1);
	else if(hacheon5 == 2 || hacheon5 == 0) $("img#hacheon5").attr(status2);
	else  $(status3);
	
	if(hacheon6 == 1) $("img#hacheon6").attr(status1);
	else if(hacheon6 == 2 || hacheon6 == 0) $("img#hacheon6").attr(status2);
	else  $(status3);

}


function fn_olympicReload(data){
	// 단계설정 - start
	fn_setFloodControl(data.floodMap);
	// 단계설정 - end
	
	// 메인알림 - start
	fn_setMainAlarm(data.mainAlarm, data.alarmList);
	// 메인알림 - end
	
	// 기상정보 - start
	fn_setWeather(data.weatherMap, data.weatherMap2);
	// 기상정보 - end
	
	// 여의상류IC set - start
	fn_setWaterLevelGraphAndList(yeoui, data.yeouiWaterLevelGraphData, data.wlList1, data.wlTime1, 1);
	// 여의상류IC set - end
	
	// 한강대교 set - start
	fn_setWaterLevelGraphAndList(hangang, data.hangangWaterLevelGraphData, data.wlList2, data.wlTime2, 2);
	// 한강대교 set - end
	
	// 청담 set - start
	fn_setWaterLevelGraphAndList(cheongdam, data.cheongdamWaterLevelGraphData, data.wlList3, data.wlTime3, 3);
	// 청담 set - end
	
	// 오금교 set - start
	fn_setWaterLevelGraphAndList(ogeum, data.ogeumWaterLevelGraphData, data.wlList4, data.wlTime4, 4);
	// 오금교 set - end
	
	// 대곡 set - start
	fn_setWaterLevelGraphAndList(daegok, data.daegokWaterLevelGraphData, data.wlList5, data.wlTime5, 5);
	// 대곡 set - end
	
	// 팔당댐 방류량 set - start
	fn_setDamGraphAndList(paldang, data.paldangDamGraphData, data.wlList7, 'paldangDam');
	// 팔당댐 방류량 set - end
	
	// 인천앞바다 조위정보 set - start
	$('#tideList').empty();
	var tags = '';
	$.each(data.wlList8, function(i, result){
		tags += '<ul';
		if(result.hlCode == '고조') tags += ' class="red_txt"';
		tags += '>';
		tags += '<li>'+result.baseTime+'</li>';
		tags += '<li>'+(result.hlCode=='고조'? '고':'저')+'</li>';
		tags += '<li>'+result.tphLevel+'</li>';
		tags += '</ul>';
	});
	$('#tideList').append(tags);
	// 인천앞바다 조위정보 set - end
	
	
	// 올림픽대로 & 동부간선도로 & 전체맵 - start
	fn_setMapData(data.yeoui, data.hangang, data.paldang, data.singok, data.rain, data.wolgye);
	// 올림픽대로 & 동부간선도로 & 전체맵 - end
}
