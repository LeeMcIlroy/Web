<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
	function fn_list(){
		$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0202/ech0202List.do'/>").submit();
	}
	
	function fn_update(){
		$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0202/ech0202Modify.do'/>").submit();
		
	}
	
	function fn_pop(){
		var tempNo = $("#tempNo").val();
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0202/ech0202Pop.do?tempNo='/>"+tempNo
					, '템플릿관리미리보기', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	function fn_copy(){
		if(confirm('템플릿을 복사하시겠습니까?')){
			/* $("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0202/ech0202Copy.do'/>").submit(); */
			$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0202/ech0202Copy.do'/>").submit();
		}
	}
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>eCRF관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="eCRF관리"/>
	            <jsp:param name="dept2" value="템플릿관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>기본정보</h4>
			</div>
			<!-- //서브타이틀 -->
			<form:form commandName="searchVO" id="searchFrm" name="searchFrm" method="post">
				<form:hidden path="searchCondition1"/>
				<form:hidden path="searchCondition2"/>
				<form:hidden path="searchCondition3"/>
				<form:hidden path="startDate"/>
				<form:hidden path="endDate"/>
				<form:hidden path="searchType"/>
				<form:hidden path="searchWord"/>
			</form:form>
			<form:form commandName="cr2020mVO" id="frm" name="frm" method="post">
				<form:hidden path="tempNo"/>
	            <!-- 기본정보 -->
				<table class="tbl_view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:35%" />
						<col style="width:15%" />
						<col style="width:35%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">템플릿코드</th>
							<td>
								<c:out value="${cr2020mVO.tempNo }"/>
							</td>
							<th scope="row" class="bl">템플릿구분</th>
							<td>
								<c:out value="${cr2020mVO.tempTypeNm }"/>
							</td>
						</tr>
						<tr>
							<th scope="row">템플릿명</th>
							<td>
								<c:out value="${cr2020mVO.tempNm }"/>
							</td>
							<th scope="row" class="bl">사용기간</th>
							<td>
								<div class="date_sec">
									<c:out value="${cr2020mVO.stDate }"/>
									<em>~</em>
									<c:out value="${cr2020mVO.edDate }"/>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">사용여부</th>
							<td colspan='3'>
							    <c:out value="${cr2020mVO.useYn eq 'Y'?'사용':cr2020mVO.useYn eq 'N'?'미사용':'' }"/>
							</td>
							<%-- <th scope="row" class="bl">사용시기</th>
							<td>
								<c:out value="${cr2020mVO.termType }"/>
							    <c:out value="${cr2020mVO.termType eq '0'?'상시':cr2020mVO.termType eq '1'?'사전':cr2020mVO.termType eq '2'?'사후':'' }"/>
							</td> --%>
						</tr>
					</tbody>
				</table>
	            <!-- //기본정보 -->
	            <!-- 버튼 -->
				<div class="btn_area">
					<a href="#" onclick="fn_list();" class="type02">취소</a>
					<a href="#" onclick="fn_update();">수정</a>
					<a href="#" onclick="fn_copy();">복사</a>
					<!-- 미리보기 -->
					<div>
						<!-- <a href="#" onclick="fn_pop(); return false;" class="btn_sub type02">미리보기</a> -->
					</div>
					<!-- //미리보기 -->
				</div><span style="color:red;"><i>*설문(연구자대상자특성,사용성,효능설문)템플릿의 구성쪽수(페이지수)는 CRF설정관리에서 템플릿선택시 자동 적용됩니다.</i></span>
				<!-- //버튼 -->
				<div id="ques_box">
					<!-- 질문 정보 -->
					<c:forEach items="${cr2050List }" var="cr2050m" varStatus="status">
						<div class="question_info" id="ques_div_<c:out value='${status.index }'/>">
							<p>질문<c:out value="${status.count }"/></p>
							<table class="tbl_view">
								<colgroup>
									<col style="width:15%" />
									<col style="width:85%" />
								</colgroup>
								<tbody>
									<tr>
										<th scope="row"><i>*</i>유형</th>
										<td>
											<c:out value="${cr2050m.quesType eq 'S'?'단일응답':cr2050m.quesType eq 'M'?'복수응답':cr2050m.quesType eq 'F'?'자유기재형':'' }"/>
										</td>
									</tr>					
									<tr>
										<th scope="row"><i>*</i>질문</th>
										<td>
											<c:out value="${cr2050m.quesCon }"/>
										</td>
									</tr>
									<tr>
										<th scope="row"><i>*</i>답변</th>
										<td id="answTd_0">
											<c:set var="quesNo" value="${cr2050m.quesNo }"/>
											<c:forEach items="${cr2060Map[quesNo] }" var="cr2060m" varStatus="status">
												<div class="que_item ques_div_0">
													<span>항목<c:out value="${status.count }"/></span>
													<c:out value="${cr2060m.answCon }"/>
												</div>
											</c:forEach>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</c:forEach>
					<!-- //질문 정보 -->
				</div>
			</form:form>
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>