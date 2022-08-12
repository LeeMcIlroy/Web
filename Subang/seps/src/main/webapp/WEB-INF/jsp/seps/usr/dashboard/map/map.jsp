<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">

	function fn_createMap(){
		

		var level = 9;
		var center = new daum.maps.LatLng(37.63, 127.00808871937565);
		if($(document).width() < 1024){
			level = 10;
			center = new daum.maps.LatLng(37.65, 127.10808871937565);
		}
		
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
			//center: new daum.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
			center: center, //지도의 중심좌표.
			level: level //지도의 레벨(확대, 축소 정도)
		};

		var map = new daum.maps.Map(container, options); //지도 생성 및 객체 리턴
		
		var yeouiVal = <c:out value="${empty yeoui? 0:yeoui}"/>;
		var hangangVal = <c:out value="${empty hangang? 0:hangang}"/>;
		var singokVal = <c:out value="${empty singok? 0:singok}"/>;
		var wolgyeVal = <c:out value="${empty wolgye? 0:wolgye}"/>;
		var wolleunVal = <c:out value="${empty wolleun? 0:wolleun}"/>;

		var cheongdamVal = <c:out value="${empty cheongdam? 0:cheongdam}"/>;
		var joongrangVal = <c:out value="${empty joongrang? 0:joongrang}"/>;
		var paldang ='${paldang }';		
		var paldang2 =	Math.round(paldang * 100) / 100;
		

		var positions = [
			{
				title: '여의상류IC 수위'
				, latlng: new daum.maps.LatLng(37.51480355656506, 126.94079421136409)
				, content : '<div class="pointer_info04" style="margin:-45px 0px 0px -74px;color:white;"><ul class="b_info"><li><span id="yeouiWaterLevel" style="color:yellow; font-weight:bold;">여의상류IC 수위 : '+yeouiVal+'m</span><p>(침수까지 : '+(yeouiVal-yeouiFloodWaterLevel).toFixed(2)+'m)</p></li></ul></div>'
			}
			, {
				title : '한강대교 수위'
				, latlng: new daum.maps.LatLng(37.517847472231146, 126.95911261001103)
				//, content : '<div class ="label"><span class="left"></span><span class="center">한강대교 수위 : 13.56EL.M</span><span class="right"></span></div>'
				, content : '<div class="pointer_info03" style="margin:-100px 0px 0px -74px;color:white"><ul class="t_info" style="padding-bottom:15px !important;"><li><span id="hangangWaterLevel" style="color:yellow; font-weight:bold;">한강대교 수위 : '+hangangVal+'m</span><p>(침수까지 : '+(hangangVal-hangangFloodWaterLevel).toFixed(2)+'m)</p></li></ul></div>'
			}
			, {
				title: '팔당댐 방류량' 
				, latlng: new daum.maps.LatLng(37.526754726113005, 127.27944353375005)
				//, content : '<div class ="label"><span class="left"></span><span class="center">팔당댐 방류량 : 2,000㎥/s</span><span class="right"></span></div>'
				, content : '<div class="pointer_info03" style="margin:-79px 0px 0px -74px;color:white;"><ul class="t_info"><li><span  style="color:yellow; font-weight:bold;">팔당댐 방류량 : '+paldang2+' ㎥/s</span></li></ul></div>'
			}
			,{
				title: '신곡교 수위'
				, latlng: new daum.maps.LatLng(37.73748946573351, 127.05340795989325)
				//, content : '<div class ="label"><span class="left"></span><span class="center">신곡교 수위 : 13.56EL.M</span><span class="right"></span></div>'
				//, content : '<div class="pointer_info" style="margin:-50px 0px 0px -10px;color:white;"><ul class="l_info"><li><span id="singokWaterLevel">신곡교 수위 : '+singokVal+'m<br>(침수까지 : '+(singokVal-singokFloodWaterLevel).toFixed(2)+'m)</span></li></ul></div>'
				, content : '<div class="pointer_info" style="margin:-50px 0px 0px -10px;color:white;"><ul class="l_info"><li><span id="singokWaterLevel" style="color:yellow; font-weight:bold;">신곡교 수위 : '+singokVal+'</span></li></ul></div>'


			}
			, {
				title : '의정부 강수량'
				//, latlng: new daum.maps.LatLng(37.72748946573351, 127.01340795989325)
				, latlng: new daum.maps.LatLng(37.73802374012536, 127.03396005509481)
				//, content : '<div class ="label"><span class="left"></span><span class="center">의정부 강수량 : 2mm</span><span class="right"></span></div>'
				, content : '<div class="pointer_info04" style="margin:-45px 0px 0px -74px;color:white;"><ul class="b_info"><li><span  style="color:yellow; font-weight:bold;">의정부 강수량 : ${rain}mm</span></li></ul></div>'
			}
			, {
				title: '월계1교 수위' 
				, latlng: new daum.maps.LatLng(37.63280676651266, 127.06323737892605)
				//, content : '<div class ="label"><span class="left"></span><span class="center">월계1교 수위 : 13.56EL.M</span><span class="right"></span></div>'
				, content : '<div class="pointer_info" style="margin:-50px 0px 0px -10px;color:white;"><ul class="l_info"><li><span id="wolgye1WaterLevel" style="color:yellow; font-weight:bold;">월계1교 수위 : '+wolgyeVal+'m</span><p>(침수까지 : '+(wolgyeVal-wolgye1FloodWaterLevel).toFixed(2)+'m)</p></li></ul></div>'
			}
			, { // 37.616184, 127.071292
				title: '월릉교 수위'
				, latlng: new daum.maps.LatLng(37.616184, 127.071292)
				, content : '<div class="pointer_info02" style="margin:-45px 0px 0px -160px;color:white;"><ul class="r_info"><li><span id="wolleunWaterLevel"  style="color:yellow; font-weight:bold;">월릉교 수위 : '+wolleunVal+'m</span></li></ul></div>'
				//  <br> (침수까지 : '+(wolleunVal-wolleunFloodWaterLevel).toFixed(2)+'m)
			}
			, { // 37.526625, 127.064461
				title: '청담대교 수위'
				, latlng: new daum.maps.LatLng(37.526625, 127.064461)
				, content : '<div class="pointer_info" style="margin:-40px 0px 0px -10px;color:white;"><ul class="l_info"><li><span id="cheongdamWaterLevel"  style="color:yellow; font-weight:bold;">청담대교 수위 : '+cheongdamVal+'m </span></li></ul></div>'
				//  <br> (침수까지 : '+(wolleunVal-wolleunFloodWaterLevel).toFixed(2)+'m)
			}
			, { // 37.592463, 127.070369
				title: '중랑교 수위'
				, latlng: new daum.maps.LatLng(37.592463, 127.070369)
				, content : '<div class="pointer_info02" style="margin:-45px 0px 0px -139px;color:white;"><ul class="r_info"><li><span id="joongrangWaterLevel"  style="color:yellow; font-weight:bold;">중랑교 수위 : '+joongrangVal+'m</span></li></ul></div>'
				//  <br> (침수까지 : '+(wolleunVal-wolleunFloodWaterLevel).toFixed(2)+'m)
			}
			
		];
                 
            for (var i = 0; i < positions.length; i ++) {
                
             // 커스텀 오버레이를 생성합니다
                var customOverlay = new daum.maps.CustomOverlay({
                    position: positions[i].latlng,
                    content: positions[i].content   
                });

                // 커스텀 오버레이를 지도에 표시합니다
                customOverlay.setMap(map);
            }
            map.addOverlayMapTypeId(daum.maps.MapTypeId.TRAFFIC);
	}
		
</script>