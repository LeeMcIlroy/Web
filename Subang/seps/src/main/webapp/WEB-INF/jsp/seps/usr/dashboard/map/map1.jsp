<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<script type="text/javascript">
	function fn_createMap1(){
		var level1 = 8;
		//var latlng1 = new daum.maps.LatLng(37.51480355656506, 126.94079421136409);
		var latlng1 = new daum.maps.LatLng(37.516794560705854, 126.94079138527091);
		var latlng2 = new daum.maps.LatLng(37.51680355656506, 127.09079421136409);
		if($(document).width() < 1024){
			level1 = 9;
			//latlng1 = new daum.maps.LatLng(37.50380355656506, 126.94079421136409);
			latlng2 = new daum.maps.LatLng(37.526754726113005, 127.07944353375005);
		}
		
		var container1 = document.getElementById('map1'); //지도를 담을 영역의 DOM 레퍼런스
		var options1 = { //지도를 생성할 때 필요한 기본 옵션
			//center: new daum.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
			center: new daum.maps.LatLng(37.526055649951424, 127.00808871937565), //지도의 중심좌표.
			level: level1 //지도의 레벨(확대, 축소 정도)
		};

		var map1 = new daum.maps.Map(container1, options1); //지도 생성 및 객체 리턴
		
		var yeouiVal = <c:out value="${empty yeoui? 0:yeoui}"/>;
		var hangangVal = <c:out value="${empty hangang? 0:hangang}"/>;
		
		var wolleunVal = <c:out value="${empty wolleun? 0:wolleun}"/>;
		
		var cheongdamVal = <c:out value="${empty cheongdam? 0:cheongdam}"/>;
		var paldang ='${paldang }';		
		var paldang2 =	Math.round(paldang * 100) / 100;
		
		var positions1 = [
			{
				title: '여의상류IC 수위'
				, latlng: latlng1
				//, content : '<div class ="label"><span class="left"></span><span class="center">여의상류IC 수위 : 13.56EL.M</span><span class="right"></span></div>'
				, content : '<div class="pointer_info04" style="margin:-45px 0px 0px -74px;"><ul class="b_info"><li><span id="yeouiWaterLevel" style="color:yellow; font-weight:bold;">여의상류IC 수위 : '+yeouiVal+'m</span><p>(침수까지 : '+(yeouiVal-yeouiFloodWaterLevel).toFixed(2)+'m)</p></li></ul></div>'
			}
			, {
				title : '한강대교 수위'
				, latlng: new daum.maps.LatLng(37.517847472231146, 126.95911261001103)
				//, content : '<div class ="label"><span class="left"></span><span class="center">한강대교 수위 : 13.56EL.M</span><span class="right"></span></div>'
				, content : '<div class="pointer_info03" style="margin:-100px 0px 0px -74px;"><ul class="t_info" style="padding-bottom:15px !important;"><li><span id="hangangWaterLevel" style="color:yellow; font-weight:bold;">한강대교 수위 : '+hangangVal+'m</span><p>(침수까지 : '+(hangangVal-hangangFloodWaterLevel).toFixed(2)+'m)</p></li></ul></div>'
			}
			, {
				title: '팔당댐 방류량' 
				, latlng: latlng2
				//, content : '<div class ="label"><span class="left"></span><span class="center">팔당댐 방류량 : 2,000㎥/s</span><span class="right"></span></div>'
				, content : '<div class="pointer_info02" style="margin:10px 0px 0px -54px;background:none;"><ul class="r_info" style="background:none;"><li><span id="paldangTototf"  style="color:yellow; font-weight:bold;">팔당댐 방류량 :  '+paldang2+' ㎥/s</span></li></ul></div>'
			}
			, { // 37.526625, 127.064461
				title: '청담대교 수위'
				, latlng: new daum.maps.LatLng(37.526625, 127.064461)
				, content : '<div class="pointer_info03" style="margin:-88px 0px 0px -56px;"><ul class="t_info"><li><span id="cheongdamWaterLevel"  style="color:yellow; font-weight:bold;">청담대교 수위 : '+cheongdamVal+'m </span></li></ul></div>'
				//  <br> (침수까지 : '+(wolleunVal-wolleunFloodWaterLevel).toFixed(2)+'m)
			}
		];
                 
            for (var i = 0; i < positions1.length; i ++) {
                
             // 커스텀 오버레이를 생성합니다
                var customOverlay = new daum.maps.CustomOverlay({
                    position: positions1[i].latlng,
                    content: positions1[i].content
                });

                // 커스텀 오버레이를 지도에 표시합니다
                customOverlay.setMap(map1);
            }
            map1.addOverlayMapTypeId(daum.maps.MapTypeId.TRAFFIC);
            map1.setDraggable(false);
            map1.setZoomable(false);
	}

</script>