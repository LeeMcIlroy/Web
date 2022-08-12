<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<script type="text/javascript">
	function fn_createMap3(){
		var level = 9
// 		var center = new daum.maps.LatLng(37.63, 127.00808871937565);
		var center = new daum.maps.LatLng(37.552741, 126.992720);
// 		if($(document).width() < 1024){
// 			level = 10;
// 			center = new daum.maps.LatLng(37.65, 127.10808871937565);
// 		}
		
		var container3 = document.getElementById('map3'); //지도를 담을 영역의 DOM 레퍼런스
		var options3 = { //지도를 생성할 때 필요한 기본 옵션
			//center: new daum.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
			center: center, //지도의 중심좌표.
			level: level //지도의 레벨(확대, 축소 정도)
		};
		var map3 = new daum.maps.Map(container3, options3); //지도 생성 및 객체 리턴
        map3.addOverlayMapTypeId(daum.maps.MapTypeId.TRAFFIC);
        map3.setDraggable(false);
        map3.setZoomable(false);
	}
</script>