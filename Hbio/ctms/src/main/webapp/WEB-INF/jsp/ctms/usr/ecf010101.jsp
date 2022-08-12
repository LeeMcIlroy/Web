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
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav"/>
	<!-- contents -->
	<div class="contents">
		<!-- 임상시험 선택 -->
		<div class="top_select type02">
			<select class="top_select_se">
				<option>임상시험 선택</option>
				<option>임상시험 1</option>
				<option>임상시험 2</option>
			</select>
		</div>
		<!-- //임상시험 선택 -->
		<!-- 참여일정 -->
		<div class="schedule_con">
			<!-- 상단 -->
			<div>
				<a href="#" class="btn_sub">동의서 확인</a>
			</div>
			<!-- //상단 -->
			<ul>
				<li>
					<div>
						<p>초기</p>
						<span>2020-00-00 00:00 ~ 00:00</span>
						<em class="type01">완료</em>
					</div>
				</li>
				<li>
					<div>
						<p>1차 방문</p>
						<span>2020-00-00 00:00 ~ 00:00</span>
						<em class="type02">예정</em>
					</div>
				</li>
				<li>
					<div>
						<p>2차 방문</p>
						<span>-</span>
					</div>
				</li>
				<li>
					<div>
						<p>3차 방문</p>
						<span>-</span>
					</div>
				</li>
				<li>
					<div>
						<p>4차 방문</p>
						<span>-</span>
					</div>
				</li>
			</ul>
		</div>
		<!-- //참여일정 -->
		<!-- 임상시험 없는 경우 -->
		<div class="text_box">
			참여중인 임상시험이 없습니다.<br />임상에 참여하시려면 회원정보를 정확하게 등록하여야 합니다.<br />회원정보 등록 후 임상에 지원하시기 바랍니다.
		</div>
		<!-- 하단버튼 -->
		<div class="btn_area">
			<span><a href="<c:out value='${pageContext.request.contextPath }/tmp/ecf050101.do'/>">회원정보 변경</a></span>
			<span><a href="<c:out value='${pageContext.request.contextPath }/tmp/ecf040101.do'/>">임상시험 지원</a></span>
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