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
	function fn_list(){
		$("#frm").attr("action", "<c:url value='/usr/ecf0301/ecf0301List.do'/>").submit();
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
	<form:form commandName="searchVO" id="frm" name="frm" method="post">
		<input type="hidden" id="file" name="file"/>
		<!-- contents -->
		<div class="contents">
			<c:choose>
				<c:when test="${rsList != null && rsList.size() != 0 && usrSession.regLv eq '2' }">
					<!-- 임상시험 선택 -->
					<div class="top_select">
						<form:select path="rsNo" class="top_select_se" onchange="fn_list(); return false;">
							<form:option value="">임상시험 선택</form:option>
							<c:forEach items="${rsList }" var="rsMap">
								<form:option value="${rsMap.rsNo }"><c:out value="${rsMap.rsName }"/></form:option>
								<c:if test="${searchVO.rsNo eq rsMap.rsNo }">
									<c:set var="rsiNo" value="${rsMap.rsiNo }"/>
									<c:set var="rsjNo" value="${rsMap.rsjNo }"/>
									<c:set var="mtSt" value="${rsMap.mtSt }"/>
								</c:if>
							</c:forEach>
						</form:select>
					</div>
					<!-- //임상시험 선택 -->
					<c:if test="${resultList != null}">
						<!-- 설문참여 -->
						<div class="con_list">			
							<ul>
								<c:forEach items="${resultList }" var="result" varStatus="status">
									<c:if test="${result.mtCls ne '1' || mtSt eq 'TRUE' }">
										<li>
											<div>
												<p><c:out value="${result.title }"/></p>
												<span>응답기간 : <c:out value="${result.svStdt }"/> ~ <c:out value="${result.svEndt }"/></span>
												<c:if test="${result.dtState eq 'BEFORE' }">
													<a href="#" class="type02">예정</a>
												</c:if>
												<c:if test="${result.dtState eq 'NOW' }">
													<c:if test="${result.answState eq 'TRUE' }">
														<a href="#" class="type02">완료</a>
													</c:if>
													<c:if test="${result.answState eq 'FALSE' }">
														<a href="#" onclick="fn_ubi_pop('frm', 'survey', 'corpCd#<c:out value='${result.corpCd }'/>#rsNo#<c:out value='${result.rsNo }'/>#tempNo#<c:out value='${result.tempNo }'/>#rsiNo#<c:out value='${rsiNo }'/>#rsjNo#<c:out value='${rsjNo }'/>#usrName#<c:out value="${rsiNo }"/>#type#survey'); return false;" class="type01">참여하기</a>
													</c:if>
												</c:if>
												<c:if test="${result.dtState eq 'AFTER' }">
													<c:if test="${result.answState eq 'TRUE' }">
														<a href="#" class="type02">완료</a>
													</c:if>
													<c:if test="${result.answState eq 'FALSE' }">
														<a href="#" class="type02">미완료</a>
													</c:if>
												</c:if>
											</div>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</div>
						<!-- //설문참여 -->
					</c:if>
				</c:when>
				<c:otherwise>
					<!-- 임상시험 없는 경우 -->
					<div class="text_box">
						참여중인 임상시험이 없습니다.<br />임상에 참여하시려면 회원정보를 정확하게 등록하여야 합니다.<br />회원정보 등록 후 임상에 지원하시기 바랍니다.
					</div>
					<!-- 하단버튼 -->
					<div class="btn_area">
						<span><a href="<c:url value='/usr/ecf0501/ecf0501Modify.do'/>">회원정보 변경</a></span>
						<span><a href="<c:url value='/usr/ecf0401/ecf0401List.do'/>">임상시험 지원</a></span>
					</div>
					<!-- //임상시험 없는 경우 -->
				</c:otherwise>
			</c:choose>
		</div>
		<!-- //contents -->
	</form:form>
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!-- //footer -->
</div>
<!-- //wrap -->
</body>
</html>