<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<script type="text/javascript">
	function fn_createMap2(){
		var container2 = document.getElementById('map2'); //지도를 담을 영역의 DOM 레퍼런스
		var options2 = { //지도를 생성할 때 필요한 기본 옵션
			//center: new daum.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
			center: new daum.maps.LatLng(37.697511510014696, 127.05536054098228), //지도의 중심좌표.
			level: 9 //지도의 레벨(확대, 축소 정도)
		};
		
		var map2 = new daum.maps.Map(container2, options2); //지도 생성 및 객체 리턴
		
		var singokVal = <c:out value="${empty singok? 0:singok}"/>;
		var wolgyeVal = <c:out value="${empty wolgye? 0:wolgye}"/>;
		var wolleunVal = <c:out value="${empty wolleun? 0:wolleun}"/>;
		
		var joongrangVal = <c:out value="${empty joongrang? 0:joongrang}"/>;
		
		var miniWolgye = { // 37.632774, 127.063131
			title: '월계1교 수위' 
			, latlng: new daum.maps.LatLng(37.63280676651266, 127.06323737892605)
			//, content : '<div class ="label"><span class="left"></span><span class="center">월계1교 수위 : 13.56EL.M</span><span class="right"></span></div>'
			, content : '<div class="pointer_info02" style="margin:-80px 0px 0px -175px;"><ul class="r_info"><li><span id="wolgye1WaterLevel" style="color:yellow; font-weight:bold;">월계1교 수위 : '+wolgyeVal+'m</span><p>(침수까지 : '+(wolgyeVal-wolgye1FloodWaterLevel).toFixed(2)+'m)</p></li></ul></div>'
		};
		
		var miniWolleun = { // 37.616228, 127.071297
			title: '월릉교 수위'
			, latlng: new daum.maps.LatLng(37.63280676651266, 127.06323737892605)
			, content : '<div class="pointer_info03" style="margin:-100px 0px 0px 5px;"><ul class="t_info"><li><span id="wolleunWaterLevel" style="color:yellow; font-weight:bold;">월릉교 수위 : '+wolleunVal+'m</span><p>(침수까지 : '+(wolleunVal-wolleunFloodWaterLevel).toFixed(2)+'m)</p></li></ul></div>'
		};

		var miniJoongrang= { // 37.632774, 127.063131
			title: '중랑교 수위' 
// 			, latlng: new daum.maps.LatLng(37.592463, 127.070369)
			// 중랑교 좌표로 찍은 후, margin 으로 조정할려니까 잘 안되서 월계1 좌표로 조정.
			, latlng: new daum.maps.LatLng(37.63280676651266, 127.06323737892605)
			, content : '<div class="pointer_info02" style="margin:-35px 0px 0px -127px;"><ul class="r_info"><li><span id="joongrangWaterLevel"  style="color:yellow; font-weight:bold;">중랑교 수위 : '+joongrangVal+'m</span></li></ul></div>'
		};
		
// 		var bigWolgye =  {
// 			title: '월계1교 수위' 
// 			, latlng: new daum.maps.LatLng(37.63280676651266, 127.06323737892605)
// 			//, content : '<div class ="label"><span class="left"></span><span class="center">월계1교 수위 : 13.56EL.M</span><span class="right"></span></div>'
// 			, content : '<div class="pointer_info" style="margin:-50px 0px 0px -10px;color:white;"><ul class="l_info"><li><span id="wolgye1WaterLevel">월계1교 수위 : '+wolgyeVal+'m<br>(침수까지 :						'+(wolgyeVal-wolgye1FloodWaterLevel).toFixed(2)+'m)</span></li></ul></div>'
// 		};
		
		var bigWolgye =  {
			title: '월계1교 수위' 
			, latlng: new daum.maps.LatLng(37.63280676651266, 127.06323737892605)
			//, content : '<div class ="label"><span class="left"></span><span class="center">월계1교 수위 : 13.56EL.M</span><span class="right"></span></div>'
			, content : '<div class="pointer_info03" style="margin:-95px 0px 0px -64px;color:white;"><ul class="t_info"><li><span id="wolgye1WaterLevel" style="color:yellow; font-weight:bold;">월계1교 수위 : '+wolgyeVal+'m</span><p>(침수까지 : '+(wolgyeVal-wolgye1FloodWaterLevel).toFixed(2)+'m)</p></li></ul></div>'
		};
		
		var bigWolleun =  { // 37.616184, 127.071292
			title: '월릉교 수위'
			, latlng: new daum.maps.LatLng(37.616184, 127.071292)
			, content : '<div class="pointer_info02" style="margin:-45px 0px 0px -160px;color:white;"><ul class="r_info"><li><span id="wolleunWaterLevel" style="color:yellow; font-weight:bold;">월릉교 수위 : '+wolleunVal+'m</span><p>(침수까지 : '+(wolleunVal-wolleunFloodWaterLevel).toFixed(2)+'m)</p></li></ul></div>'
		};
		
		
		var bigJoongrang = { // 37.592463, 127.070369
			title: '중랑교 수위'
			, latlng: new daum.maps.LatLng(37.592463, 127.070369)
			, content : '<div class="pointer_info02" style="margin:-45px 0px 0px -139px;color:white;"><ul class="r_info"><li><span id="joongrangWaterLevel" style="color:yellow; font-weight:bold;">중랑교 수위 : '+joongrangVal+'m</span></li></ul></div>'
			//  <br> (침수까지 : '+(wolleunVal-wolleunFloodWaterLevel).toFixed(2)+'m)
			//<br> (침수까지 : '+(joongrangVal-joongrangFloodWaterLevel).toFixed(2)+'m)
		}
		
		
		var positions2 = [
			{
				title: '신곡교 수위'
				, latlng: new daum.maps.LatLng(37.73748946573351, 127.05340795989325)
				//, content : '<div class ="label"><span class="left"></span><span class="center">신곡교 수위 : 13.56EL.M</span><span class="right"></span></div>'
				, content : '<div class="pointer_info" style="margin:-50px 0px 0px -10px;"><ul class="l_info"><li><span id="singokWaterLevel" style="color:yellow; font-weight:bold;">신곡교 수위 : '+singokVal+'m</span></li></ul></div>'
			//<br>(침수까지 : '+(singokVal-singokFloodWaterLevel).toFixed(2)+'m)
			}
			, {
				title : '의정부 강수량'
				//, latlng: new daum.maps.LatLng(37.72748946573351, 127.01340795989325)
				, latlng: new daum.maps.LatLng(37.73802374012536, 127.03396005509481)
				//, content : '<div class ="label"><span class="left"></span><span class="center">의정부 강수량 : 2mm</span><span class="right"></span></div>'
				, content : '<div class="pointer_info04" style="margin:-45px 0px 0px -74px;"><ul class="b_info"><li><span id="uijeongbuRainFall" style="color:yellow; font-weight:bold;">의정부 강수량 : <c:out value="${rain}"/>㎜</span></li></ul></div>'
			}
			, (location.pathname.indexOf('dongbu') >= 0) ? bigWolgye : miniWolgye
			, (location.pathname.indexOf('dongbu') >= 0) ? bigWolleun : miniWolleun
			, (location.pathname.indexOf('dongbu') >= 0) ? bigJoongrang : miniJoongrang
		];
                 
            for (var i = 0; i < positions2.length; i ++) {
                
             // 커스텀 오버레이를 생성합니다
                var customOverlay = new daum.maps.CustomOverlay({
                    position: positions2[i].latlng,
                    content: positions2[i].content
                });

                // 커스텀 오버레이를 지도에 표시합니다
                customOverlay.setMap(map2);
            }
            map2.addOverlayMapTypeId(daum.maps.MapTypeId.TRAFFIC);
            map2.setDraggable(false);
            map2.setZoomable(false);
	}
</script>