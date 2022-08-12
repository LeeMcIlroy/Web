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
		$("#frm").attr("action", "<c:url value='/usr/ecf0101/ecf0101List.do'/>").submit();
	}
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav"/>
	<form:form commandName="searchVO" id="frm" name="frm">
		<input type="hidden" id="file" name="file"/>
		<!-- contents -->
		<div class="contents">
			<c:choose>
				<c:when test="${rsList != null && rsList.size() != 0 && usrSession.regLv eq '2' }">
					<!-- 임상시험 선택 -->
					<div class="top_select type02">
						<form:select path="rsNo" class="top_select_se" onchange="fn_list(); return false;">
							<form:option value="">임상시험 선택</form:option>
							<c:forEach items="${rsList }" var="rsMap">
								<form:option value="${rsMap.rsNo }"><c:out value="${rsMap.rsName }"/></form:option>
								<c:if test="${searchVO.rsNo eq rsMap.rsNo }">
									<c:set var="subNo" value="${rsMap.subNo }"/>
									<c:set var="rsiNo" value="${rsMap.rsiNo }"/>
									<c:set var="pricfYn" value="${rsMap.pricfYn }"/>
									<c:set var="rsicfYn" value="${rsMap.rsicfYn }"/>
									<c:set var="mtSt" value="${rsMap.mtSt }"/>
								</c:if>
							</c:forEach>
						</form:select>
					</div>
					<!-- //임상시험 선택 -->
					<c:if test="${resultList != null}">
						<!-- 참여일정 -->
						<div class="schedule_con">
							<c:if test="${mtSt eq 'TRUE' }">
								<!-- 상단 -->
								<div>
									<c:if test="${pricfYn ne 'Y' }">
										<%-- <a href="#" onclick="fn_ubi_pop('frm', 'agree_1', 'corpCd#<c:out value="${searchVO.corpCd }"/>#rsNo#<c:out value="${searchVO.rsNo }"/>#subNo#<c:out value="${subNo }"/>#rsjNo#<c:out value="${searchVO.rsjNo }"/>#usrName#<c:out value="${sessionScope.usrSession.rsjName }"/>#type#agree_1'); return false;" class="btn_sub">개인정보 동의서</a> --%>
										<a href="#" onclick="fn_ubi_pop('frm', 'agree_1', 'corpCd#<c:out value="${searchVO.corpCd }"/>#rsNo#<c:out value="${searchVO.rsNo }"/>#subNo#<c:out value="${subNo }"/>#rsjNo#<c:out value="${searchVO.rsjNo }"/>#usrName#<c:out value="${rsiNo }"/>#type#agree_1'); return false;" class="btn_sub">개인정보 동의서</a>
									</c:if>
									<c:if test="${pricfYn eq 'Y' }">
										<a href="#" class="btn_sub type03">개인정보 동의서</a>
									</c:if>
									<c:if test="${rsicfYn ne 'Y' }">
										<a href="#" onclick="fn_ubi_pop('frm', 'agree_2', 'corpCd#<c:out value="${searchVO.corpCd }"/>#rsNo#<c:out value="${searchVO.rsNo }"/>#subNo#<c:out value="${subNo }"/>#rsjNo#<c:out value="${searchVO.rsjNo }"/>#usrName#<c:out value="${rsiNo }"/>#type#agree_2'); return false;" class="btn_sub">연구참여 동의서</a>
									</c:if>
									<c:if test="${rsicfYn eq 'Y' }">
										<a href="#" class="btn_sub type03">연구참여 동의서</a>
									</c:if>
								</div>
								<!-- //상단 -->
							</c:if>
							<ul>
								<c:forEach begin="0" end="5" var="i">
									<c:set var="num">${i }</c:set>
									<c:set value="${resultMap[num] }" var="result"/>
									<c:choose>
										<c:when test="${result != null }">
											<li>
												<div>
													<p><c:out value="${i == 0?'초기':(result.mtCnt += '차 방문') }"/></p>
													<span><c:out value="${result.resrDttm }"/> ~ 00:00</span>
													<c:choose>
														<c:when test="${result.mtSt eq '10' }">
															<em class="type02">예약</em>
														</c:when>
														<c:when test="${result.mtSt eq '20' }">
															<em class="type01">예약취소</em>
														</c:when>
														<c:when test="${result.mtSt eq '30' }">
															<em class="type01">참여</em>
														</c:when>
														<c:when test="${result.mtSt eq '40' }">
															<em class="type01">참여취소</em>
														</c:when>
														<c:when test="${result.mtSt eq '50' }">
															<em class="type01">온라인참여</em>
														</c:when>
													</c:choose>
												</div>
											</li>
										</c:when>
										<c:otherwise>
											<li>
												<div>
													<p><c:out value="${i == 0?'초기':(i += '차 방문') }"/></p>
													<span>-</span>
												</div>
											</li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</ul>
						</div>
						<!-- //참여일정 -->
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