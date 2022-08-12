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
		$("#frm2").attr("action", "<c:url value='/qxsepmny/ech0204/ech0204List.do'/>").submit();
	}

	function fn_update(){
		$("#frm").attr("action", "<c:url value='/qxsepmny/ech0204/ech0204Modify.do'/>").submit();
	}
	
	//파일 다운로드
	function fn_filedownload(attachSeq, boardType){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+attachSeq+"&type="+boardType;
	}
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- 검색조건유지 설정 -->
            <form:form commandName="searchVO" id="frm2" name="frm2">
            	<form:hidden path="searchCondition1"/>
            	<form:hidden path="searchCondition2"/>
            	<form:hidden path="searchCondition3"/>
            	<form:hidden path="searchCondition4"/>
            	<form:hidden path="searchCondition5"/>
            	<form:hidden path="searchCondition6"/>
            	<form:hidden path="searchCondition7"/>
            	<form:hidden path="searchCondition8"/>
            	<form:hidden path="searchYear"/>
            	<form:hidden path="searchWord"/>
            </form:form>
	<form:form commandName="rs1000mVO" id="frm" name="frm" method="post">
		<input type="hidden" id="file" name="file"/>
		<form:hidden path="rsNo"/>
		<!-- container -->
		<div class="container">
			<h2>eCRF관리</h2>
			<!-- contents -->
			<div class="contents">
				<!-- 타이틀 -->
				<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="eCRF관리"/>
		            <jsp:param name="dept2" value="피부특성관리"/>
	           	</jsp:include>
				<!-- //타이틀 -->
				<!-- 서브타이틀 -->
				<div class="sub_title_area type02">
					<h4>기본정보</h4>
				</div>
				<!-- //서브타이틀 -->
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
							<th scope="row">연구코드</th>
							<td><c:out value="${rs1000mVO.rsCd }"/></td>
							<th scope="row" class="bl">연구명</th>
							<td><c:out value="${rs1000mVO.rsName }"/></td>
						</tr>
						<tr>
							<th scope="row">eCRF상태</th>
							<td colspan="3">
								<c:out value="${rs1000mVO.ecrfState }"/>
								<%-- <c:forEach items="${stateList }" var="state" varStatus="status">
									<c:if test="${rs1000mVO.ecrfState eq state.cd }">
										<c:out value="${state.cdName }"/>
									</c:if>
							    </c:forEach> --%>
							</td>
						</tr>
					</tbody>
				</table>
				<!-- //기본정보 -->
	            <!-- 버튼 -->
				<div class="btn_area">
					<a href="#" class="type02" onclick="fn_list(); return false;">취소</a>
					<a href="#" onclick="fn_update(); return false;">수정</a>
				</div>
				<!-- //버튼 -->
				<!-- 피부특성관리 정보 -->
				<c:forEach items="${eCrfList }" var="eCRF" varStatus="status">
					<!-- 설문지 정보 -->
					<div class="survey_info sv_div_<c:out value='${status.index }'/>">
						<table class="tbl_view">
							<colgroup>
								<col style="width:15%" />
								<col style="width:85%" />
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">설문차수</th>
									<td>
										피부특성관리
										<form:hidden path="cr1000mVOList[${status.index }].svSeq" value="${eCRF.svSeq }"/>
										<form:hidden path="cr1000mVOList[${status.index }].svCnt" value="${eCRF.svCnt }"/>
									</td>
								</tr>					
								<tr>
									<th scope="row">템플릿</th>
									<td>
										<c:forEach items="${tempList }" var="temp">
											<c:if test="${temp.tempNo eq eCRF.tempNo }">
												<c:out value="${temp.tempNm }"/>
												<c:set value="${eCRF.tempNo }" var="tempNo"/>
											</c:if>
										</c:forEach>
									</td>
								</tr>
								<tr>
									<th scope="row">설문명</th>
									<td>
										<c:out value="${eCRF.title }"/>
									</td>
								</tr>
								<tr>
									<th scope="row">조사내용</th>
									<td>
										<c:out value="${eCRF.content }"/>
									</td>
								</tr>
								<tr>
									<th scope="row">참여기간</th>
									<td>
										<div class="date_sec">
											<c:out value="${eCRF.svStdt }"/>
											<em>~</em>
											<c:out value="${eCRF.svEndt }"/>
										</div>
										<form:checkbox path="cr1000mVOList[${status.index }].mtCls" id="mtCls_${status.index }" checked="${eCRF.mtCls eq '1'?'checked':'' }" value="1" disabled="true"/>
									    <label for="mtCls_<c:out value='${status.index }'/>">방문 설문</label>
									</td>
								</tr>
							</tbody>
						</table>
						<!-- 삭제버튼 -->
						<%-- <div class="sub_btn_area">
							<a style="cursor:pointer;" onclick="fn_del(<c:out value='${status.index }'/>);">삭제</a>
						</div> --%>
						<!-- //삭제버튼 -->
					</div>
					<!-- //설문지 정보 -->
				</c:forEach>
				<c:if test="${eCrfList != null && eCrfList.size() != 0 }">
					<!-- 테이블 상단 정보 -->
					<div class="tbl_top_info mt30">
						<h4>피험자정보</h4>
					</div>
					<!-- //테이블 상단 정보 -->
		            <!-- 피험자정보 -->
					<table class="tbl_list">
						<colgroup>
							<col style="width:5%" />
							<col style="width:10%" />
							<col style="width:10%" />
							<col style="width:8%" />
							<col style="width:8%" />
							<col style="width:14%" />
							<col style="width:8%" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col">번호</th>
								<th scope="col">이름</th>
								<th scope="col">생년월일</th>
								<th scope="col">나이</th>
								<th scope="col">성별</th>
								<th scope="col">핸드폰</th>
								<th scope="col">피부특성</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>					
								<td><c:out value="${result.rownum }"/></td>
								<td><c:out value="${result.rsjName }"/></td>
								<td><c:out value="${result.brDt }"/></td>
								<td><c:out value="${result.age}"/></td>
								<td><c:out value="${result.genYnNm}"/></td>
								<td><c:out value="${result.hpNo}"/></td>
								<td>
									<c:if test="${result.answState eq 'FALSE' }">
										<a href="#" onclick="fn_ubi_pop('frm', 'survey_1', 'corpCd#<c:out value='${result.corpCd }'/>#rsNo#<c:out value='${result.rsNo }'/>#tempNo#<c:out value='${tempNo }'/>#rsiNo#<c:out value='${result.rsiNo }'/>#rsjNo#<c:out value='${result.rsjNo }'/>#usrName#<c:out value="${result.rsiNo }"/>#type#survey_1'); return false;" class="btn_sub">등록</a>
									</c:if>
									<c:if test="${result.answState ne 'FALSE' }">
										<!-- <a href="#" class="btn_sub">확인</a> -->
										<c:set var="chkNo" value="${result.mapKey }"/>
										<c:forEach items="${mtList[chkNo] }" var="resutlMt" varStatus="status">
											<div class="que_item ques_div_0">
												<a href="#" class ="btnLockNonDisp" onclick="fn_filedownload('<c:out value="${resutlMt.attachNo }"/>','<c:out value="${resutlMt.boardType }"/>'); return false;" style="text-decoration: underline;"><c:out value="${resutlMt.orgFileName}"/></a>						
											</div>
										</c:forEach>
									</c:if>
								</td>
							</tr>
						</c:forEach>
						<c:if test="${resultList.size() == 0 }">
							<tr>
								<td class="nodata" colspan="7">연구대상자 정보가 없습니다.</td>
							</tr>
						</c:if>
						</tbody>
					</table>
					<!-- //피험자정보 -->	
				</c:if>
				<!-- //피부특성관리 정보 -->
			</div>
			<!-- //contents -->
		</div>
		<!-- //container -->
	</form:form>
</div>	
<!-- //wrap -->
</body>
</html>