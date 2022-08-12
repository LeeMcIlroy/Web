<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>
<script type="text/javascript">
	function fn_view(){
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech010102.do'/>";
	}

	//버튼 마우스 오버 시 효과
	$(document).ready(function () {
		$(".con_list div > a").on("mouseenter focus" , function() {
			$(".con_list div").removeClass("on");
			$(this).parent().addClass("on");
		});
		$(".con_list div > a").on("mouseleave blur" , function() {
			$(".con_list div").removeClass("on");
		});
	});
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav"/>
	<!-- contents -->
	<div class="contents">
		<!-- 임상시험 선택 -->
		<div class="top_select">
			<select class="top_select_se">
				<option>임상시험 선택</option>
				<option>임상시험 1</option>
				<option>임상시험 2</option>
			</select>
		</div>
		<!-- //임상시험 선택 -->
		<!-- 설문참여 -->
		<div class="con_list">			
			<ul>
				<li>
					<div>
						<p>Ecrf 관찰연구 1차 2회</p>
						<span>응답기간 : 2020-10-00</span>
						<a href="#" class="type02">완료</a>
					</div>
				</li>
				<li>
					<div>
						<p>Ecrf 관찰연구 1차 2회</p>
						<span>응답기간 : 2020-10-00</span>
						<a href="#" class="type01">참여하기</a>
					</div>
				</li>
				<li>
					<div>
						<p>Ecrf 관찰연구 1차 2회</p>
						<span>응답기간 : 2020-10-00</span>
						<a href="#" class="type02">예정</a>
					</div>
				</li>
				<li>
					<div>
						<p>Ecrf 관찰연구 1차 2회</p>
						<span>응답기간 : 2020-10-00</span>
						<a href="#" class="type02">예정</a>
					</div>
				</li>
				<li>
					<div>
						<p>Ecrf 관찰연구 1차 2회 Ecrf 관찰연구 1차 2회</p>
						<span>응답기간 : 2020-10-00</span>
						<a href="#" class="type02">예정</a>
					</div>
				</li>
			</ul>
		</div>
		<!-- //설문참여 -->
		<!-- 임상시험 없는 경우 -->
		<div class="text_box">
			참여중인 임상시험이 없습니다.<br />임상에 참여하시려면 회원정보를 정확하게 등록하여야 합니다.<br />회원정보 등록 후 임상에 지원하시기 바랍니다.
		</div>
		<!-- 하단버튼 -->
		<div class="btn_area">
			<span><a href="#">회원정보 변경</a></span>
			<span><a href="#">임상시험 지원</a></span>
		</div>
		<!-- //임상시험 없는 경우 -->
	</div>
	<!-- //contents -->
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!-- //footer -->
</div>
<!-- //wrap -->
</body>
</html>