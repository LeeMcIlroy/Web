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
	$(function(){
		//엑셀다운로드권한 
		var ynexauth = '<c:out value="${exauth}"/>';
		if(ynexauth=='N') {
			$('.btn_excel').css("display","none");
		}
	})

	//사용자관리 상세보기 화면
	function fn_view(corpCd, empNo){		
	 	$("#corpCd").val(corpCd);
	 	$("#empNo").val(empNo);
	 	$("#listForm").attr("action","<c:url value='/qxsepmny/ech0702/ech0702View.do'/>").submit();
	}
	
	//사용자관리 목록으로
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0702/ech0702List.do'/>").submit();
	}
	//사용자관리 등록화면
	function fn_regist(){
		$("#corpCd").val(corpCd);
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0702/ech0702Modify.do'/>").submit();
	}	
	//지사관리 엑셀다운로드
	function fn_excelDown(){
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0702/ech0702Excel.do'/>").submit();
	}
	
	// from ~ to 기간은 최대 365일이내 	
	function fn_date(i){
		$("input[name=period]:checked").attr("checked", false);
		var termDate = 365; // 차이일수 설정
		var staDate = new Date($("#datepicker01").val());
		var endDate = new Date($("#datepicker02").val())
		var dateDiff = Math.ceil((endDate.getTime() - staDate.getTime())/(1000*3600*24));
		if(dateDiff > termDate || dateDiff < -termDate){
			$("#datepicker02").val("");
			$("#datepicker02").focus();
			alert('작업기간은 '+termDate+'일 이내로 검색할 수 있습니다.');
		}
	}
	
	//검색항목 제어 기능 시작
	//기간 clear 
	function fn_resetTerm(){
		var chkTerm = $("#searchCondition4").val();
		if(chkTerm == '') {
			$("#datepicker01").datepicker().datepicker("setDate", '');
			$("#datepicker02").datepicker().datepicker("setDate", '');
			$("#searchCondition1").focus();
			$("input[name=period]:checked").prop("checked", false);  
		} 
		//$("#searchCondition1").val("");
		//$("#searchCondition2").val("");
		//$("#searchCondition1").focus();
	}
	
	//검색어 clear
	function fn_resetWord(){
		$("#searchWord").val("");
		$("#searchWord").focus();
	}
	
	
	function fn_resetWord(){
		$("#searchWord").val("");
		$("#searchWord").focus();
	}

	function fn_getDatePrev(dayCnt) {
		var dDate = new Date();
		var dDate = new Date(dDate.getTime()+(1000*60*60*24*-dayCnt));
		return dDate;
	}
	
	function fn_resetDate(){
		//alert('검색기간을 재설정합니다.');

		// 1 1년  2 3개월  3 1개월  4 전체
		switch($("input[name=period]:checked").val()) {
			case '1':
				$("#datepicker01").datepicker().datepicker("setDate", fn_getDatePrev(365));
				$("#datepicker02").datepicker().datepicker("setDate", new Date());
			break;
			case '2':
				$("#datepicker01").datepicker().datepicker("setDate", fn_getDatePrev(90));
				$("#datepicker02").datepicker().datepicker("setDate", new Date());
			break;
			case '3':
				$("#datepicker01").datepicker().datepicker("setDate", fn_getDatePrev(30));
				$("#datepicker02").datepicker().datepicker("setDate", new Date());
			break;
			case '4':
				$("#datepicker01").datepicker().datepicker("setDate", '');
				$("#datepicker02").datepicker().datepicker("setDate", new Date());
			break;
			default : 
				$("#datepicker01").datepicker().datepicker("setDate", new Date());
				$("#datepicker02").datepicker().datepicker("setDate", new Date());
		}
	}
	
	
</script>
<body>
<form:form commandName="searchVO" id="listForm" name="listForm">
<input type="hidden" id="corpCd" name="corpCd"/>
<input type="hidden" id="empNo" name="empNo"/>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>기준정보</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="기준정보"/>
	            <jsp:param name="dept2" value="사용자관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 검색영역 -->
			<div class="srch_area">
				<ul>
					<li>
						<p>상태</p>
                        <span>
                        	<select name="searchCondition5" id="searchCondition5">
								<option value="" <c:if test="${searchVO.searchCondition5  eq '' }">selected="selected"</c:if> >선택</option>
								<option value="1" <c:if test="${searchVO.searchCondition5  eq '1' }">selected="selected"</c:if> >정상</option>
								<option value="2" <c:if test="${searchVO.searchCondition5  eq '2' }">selected="selected"</c:if> >정지(로그인차단)</option>
							</select>
                        </span>
					</li>
					<li>
						<p>권한</p>
						<span>
							<select name="searchCondition6" id="searchCondition6">
								<option value="" <c:if test="${searchVO.searchCondition6  eq '' }">selected="selected"</c:if> >선택</option>
								<option value="1" <c:if test="${searchVO.searchCondition6  eq '1' }">selected="selected"</c:if> >연구담당자</option>
								<option value="2" <c:if test="${searchVO.searchCondition6  eq '2' }">selected="selected"</c:if> >연구책임자</option>
							</select>
						</span>
					</li>
					<li>
						<p>지사</p>
						<span>
						<!-- 지사목록 CT1020M 테이블    지사이름, 지사코드  -->							
						<select id="searchCondition7" name="searchCondition7">
							<option value="">선택</option>
							<c:if test="${searchVO.searchCondition7 eq '' }">selected="selected"</c:if>
							<c:forEach var="result" items="${branch}">
								<option value="${result.branchCd}"<c:if test="${result.branchCd eq searchVO.searchCondition7}">selected="selected"</c:if>>${result.branchName}</option>
							</c:forEach>
						</select>
						</span>
					</li>
					<li>
						<p>기간</p>
                        <span>
                        	<select name="searchCondition4" id="searchCondition4" onchange="fn_resetTerm(); return false;">
								<option value="" <c:if test="${searchVO.searchCondition4  eq '' }">selected="selected"</c:if> >선택</option>
								<option value="1" <c:if test="${searchVO.searchCondition4  eq '1' }">selected="selected"</c:if> >가입일자</option>
								<option value="2" <c:if test="${searchVO.searchCondition4  eq '2' }">selected="selected"</c:if> >최근로그인</option>
							</select>
                        </span>
						<span>
							<input type="text" name="searchCondition1" id="datepicker01" value="<c:out value="${searchVO.searchCondition1 }" />" placeholder="0000-00-00" class="date" onchange="fn_date(1); return false;" title="시작일자"/>
							<label for="datepicker01" class="btn_cld">날짜검색</label>
						</span>
						<em>~</em>
						<span>
							<input type="text" name="searchCondition2" id="datepicker02" value="<c:out value="${searchVO.searchCondition2 }" />" placeholder="0000-00-00" class="date" onchange="fn_date(2); return false;" title="종료일자"/>							
							<label for="datepicker02" class="btn_cld">날짜검색</label>
						</span>
						<span class="type00" onchange="fn_resetDate(); return false;">
							<input type="radio" name="period" id="period01" value="1"/> <label for="period01">1년</label>
							<input type="radio" name="period" id="period02" value="2"/> <label for="period02">3개월</label>
							<input type="radio" name="period" id="period03" value="3"/> <label for="period03">1개월</label>
							<input type="radio" name="period" id="period04" value="4"/> <label for="period04">전체</label>
						</span>
					</li>      					
                    <li>
						<p>검색어</p>
						<span>
							<select name="searchCondition3" id="searchCondition3" onchange="fn_resetWord(); return false;">
								<option value="" <c:if test="${searchVO.searchCondition3  eq '' }">selected="selected"</c:if> >선택</option>
								<option value="1" <c:if test="${searchVO.searchCondition3  eq '1' }">selected="selected"</c:if> >전체</option>
								<option value="2" <c:if test="${searchVO.searchCondition3  eq '2' }">selected="selected"</c:if> >이름</option>
								<option value="3" <c:if test="${searchVO.searchCondition3  eq '3' }">selected="selected"</c:if> >아이디</option>
							</select>
						</span>
                        <span class="type02">
                            <input type="text" name="searchWord" class="input-data" placeholder="이름,아이디,부서명칭을 입력하세요" />
                        </span>
					</li>
				</ul>
				<!-- 조회버튼 -->
				<a href="#" onclick="fn_list(1); return false;">조회</a>
			</div>
			<!-- //검색영역 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<span>
					총<strong><c:out value="${totalCount }"/></strong>건
				</span>				
				<!-- 버튼 -->
				<div>
					<a href="#" onclick="fn_excelDown(); return false;" class="btn_excel">엑셀</a>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
			<!-- 목록 -->
			<table class="tbl_list tr_link">
				<colgroup>
					<col style="width:5%" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:10%" />
					<col style="width:12%" />
					<col style="width:8%" />
					<col style="width:10%" />
					<col style="width:14%" />
                    <col style="width:10%" />
                    <col style="width:10%" />
                    <col style="width:8%" />
                    <col style="width:8%" />
                    <col style="width:5%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">구성원번호</th>
						<th scope="col">구분</th>
						<th scope="col">연구권한</th>
						<th scope="col">아이디</th>
						<th scope="col">이름</th>
						<th scope="col">핸드폰</th>
                        <th scope="col">이메일</th>
						<th scope="col">지사</th>
						<th scope="col">부서</th>
						<th scope="col">관리권한</th>
						<th scope="col">가입일</th>
						<th scope="col">상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="result" items="${resultList}" varStatus="status">			
						<tr onclick="fn_view('<c:out value='${result.corpCd }'/>','<c:out value='${result.empNo }'/>'); return false;">
							<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
							<td><c:out value="${result.empNo}"/></td>
							<td><c:out value="${result.rsClsNm}"/></td>
							<td><c:out value="${result.rsAuthClsNm}"/></td>
							<td><c:out value="${result.userId}"/></td>						
							<td><c:out value="${result.empName }"/></td>
							<td><c:out value="${result.hpNo}"/></td>
							<td><c:out value="${result.email}"/></td>
							<td><c:out value="${result.branchName}"/></td>
							<td><c:out value="${result.orgNm}"/></td>
							<%-- <td><c:out value="${result.adminType}"/></td> --%>
							<td>
								<c:choose>
	                          		<c:when test="${result.adminType eq '1' }"><span style="color:blue;">Admin권한</span></c:when>
	                          		<c:when test="${result.adminType eq '2' }">일반사용자권한</c:when>
	                          	</c:choose>
	                        </td>
							<td><c:out value="${result.incDt}"/></td>
							<td><c:out value="${result.userStNm}"/></td>
						</tr>
					</c:forEach>	
				</tbody>
			</table>
			<!-- //목록 -->
			<!--  목록 하단 -->
			<div class="list_btm">
				<!-- 페이징 -->
				<div class="pagenate">
					<div class="paging_wrap">
						<div class="paging">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_list" />
							<form:hidden path="pageIndex" />
						</div>
					</div>
				</div>
				<!-- //페이징 -->
				<!-- 하단버튼 -->
				<div class="list_btm_btn">
					<a href="#" onclick="fn_regist();">등록</a>
				</div>
				<!-- //하단버튼 -->
			</div>
			<!-- //목록 하단 -->
		</div>
		<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
		<!-- //contents -->
	</div>
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!-- //container -->
</div>	
<!-- //wrap -->
</form:form>
</body>
</html>