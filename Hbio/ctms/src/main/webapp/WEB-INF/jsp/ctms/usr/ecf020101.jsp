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
		<div class="top_select">
			<select class="top_select_se">
				<option>임상시험 선택</option>
				<option>임상시험 1</option>
				<option>임상시험 2</option>
			</select>
		</div>
		<!-- //임상시험 선택 -->
		<!-- 사용체크 -->
		<div class="usage_check_con">
			<!-- 전달사항 -->
			<div class="text_box type02">
				관리자 전달사항이 들어갑니다
			</div>
			<!-- //전달사항 -->
			<!-- 일정 -->
			<p>사용체크 일정 <span>2020-10-16 ~ 2020-10-23</span></p>
			<!-- //일정 -->
			<ul>
				<li>
					<div>
						<em>2020-00-00 (월)</em>
						<span>
							<span><a href="#" class="btn_sub">오전 체크</a></span>
							<span><a href="#" class="btn_sub">오후 체크</a></span>
						</span>
						<p>특이사항</p>
						<div>
							<textarea></textarea>
							<a href="#">전송</a>
						</div>
					</div>
				</li>
				<li>
					<div>
						<em>2020-00-00 (월)</em>
						<span>
							<span><a href="#" class="btn_sub type03">오전 체크</a></span>
							<span><a href="#" class="btn_sub type03">오후 체크</a></span>
						</span>
						<p>특이사항</p>
						<div>
							<textarea></textarea>
							<a href="#">전송</a>
						</div>
					</div>
				</li>
				<li>
					<div>
						<em>2020-00-00 (월)</em>
						<span>
							<span><a href="#" class="btn_sub type02">오전 체크</a></span>
							<span><a href="#" class="btn_sub type02">오후 체크</a></span>
						</span>
						<p>특이사항</p>
						<div>
							<textarea></textarea>
							<a href="#">전송</a>
						</div>
					</div>
				</li>
			</ul>
		</div>
		<!-- //사용체크 -->
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