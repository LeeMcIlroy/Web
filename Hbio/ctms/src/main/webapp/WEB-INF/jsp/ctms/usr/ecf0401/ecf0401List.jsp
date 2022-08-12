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

	function fn_update(rsNo){
		$("#rsNo").val(rsNo);
		$("#frm").attr("action", "<c:url value='/usr/ecf0401/ecf0401RsiCode.do'/>").submit();
	}
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav"/>
	<form:form commandName="searchVO" id="frm" name="frm" method="post">
		<form:hidden path="rsNo"/>
		<!-- contents -->
		<div class="contents">
			<c:choose>
				<c:when test="${usrSession.regLv eq '2' }">
					<!-- 시험대상자 상시지원 -->
					<div class="apply_top">
						<div>
							<p>
								<span>시험대상자 상시지원</span>
								시험대상자에 상시지원 하시면 적합한 시험이 있을 경우 사전 대상자로 선정하여 연락 드립니다. 
							</p>
						</div>
						<a href="#">지원하기<i></i></a>
					</div>
					<!-- //시험대상자 상시지원 -->
					<!-- 시험지원 -->
					<div class="con_list type02">			
						<ul>
							<c:forEach items="${resultList }" var="result">
								<li>
									<div>
										<em><c:out value="${result.rsCd }"/></em>
										<p><c:out value="${result.rsName }"/></p>
										<span><c:out value="${result.rsStdt }"/> ~ <c:out value="${result.rsEndt }"/></span>
										<c:choose>
											<c:when test="${result.rsstCls eq '20' && (result.rsjNo == null || result.rsjNo eq '') }">
												<a href="#" onclick="fn_update(<c:out value='${result.rsNo }'/>); return false;" class="type01">지원하기</a>
											</c:when>
											<c:when test="${result.rsstCls eq '20' && result.rsjNo != null && result.rsjNo ne '' }">
												<a href="#" class="type02">참여(지원)</a>
											</c:when>
											<c:when test="${result.rsstCls eq '10' }">
												<a href="#" class="type02">예정</a>
											</c:when>
										</c:choose>
									</div>
								</li>
							</c:forEach>
						</ul>
					</div>
					<!-- //시험지원 -->
				</c:when>
				<c:otherwise>
					<!-- 개인정보 추가등록이 없는 경우 -->
					<div class="text_box">
						임상에 참여하시려면 회원정보를 정확하게 등록하여야 합니다.<br />회원정보 등록 후 임상에 지원하시기 바랍니다.
					</div>
					<!-- 하단버튼 -->
					<div class="btn_area">
						<span><a href="<c:url value='/usr/ecf0501/ecf0501Modify.do'/>">회원정보 변경</a></span>
					</div>
					<!-- //개인정보 추가등록이 없는 경우 -->
				</c:otherwise>
			</c:choose>
		</div>
		<!-- //contents -->
		<input type="hidden" id="message" name="message" value="<c:out value='${message }'/>"/>
	</form:form>
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!-- //footer -->
</div>
<!-- //wrap -->
</body>
</html>