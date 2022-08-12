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
	
	//제품사용관리 상세보기 화면
	function fn_view(corpCd, rsNo){		
	 	$("#corpCd").val(corpCd);
	 	$("#rsNo").val(rsNo);
	 	$("#listForm").attr("action","<c:url value='/qxsepmny/ech0205/ech0205View.do'/>").submit();
	}
	
	//제품사용관리 목록으로
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0205/ech0205List.do'/>").submit();
	}
	
	//제품사용관리 등록화면
	function fn_regist(){
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0205/ech0205Modify.do'/>").submit();
	}
	
	//제품사용관리 엑셀다운로드
	function fn_excelDown(){
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0205/ech0205Excel.do'/>").submit();
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
				$("#datepicker02").datepicker().datepicker("setDate", '');
			break;
			default : 
				$("#datepicker01").datepicker().datepicker("setDate", new Date());
				$("#datepicker02").datepicker().datepicker("setDate", new Date());
		}
	}
	//-- 검색항목 제어 기능 끝
	
</script>
<body>
<form:form commandName="searchVO" id="listForm" name="listForm">
<input type="hidden" id="corpCd" name="corpCd"/>
<input type="hidden" id="rsNo" name="rsNo"/>
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
	            <jsp:param name="dept2" value="제품사용관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 검색영역 -->
			<div class="srch_area">
				<ul>
					<li>
						<p>년도</p>
						<!-- <span class="type01">
							<input type="text" placeholder="연구코드" />
						</span>  -->
						<span>
							<form:select path="searchYear" onchange="fn_search(this); return false;">
								<option value="">선택</option>
								<form:options items="${yearList }"/>
							</form:select>
						</span>
						<span class="type01" >
							<form:select path="searchCondition8" id="rsCdList">
								<c:forEach items="${yearRsCdList }" var="rscd">
									<form:option value="${rscd.rsCd }"><c:out value="${rscd.rsCd }"/></form:option>
								</c:forEach>
							</form:select>
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
						<p>임상분류</p>
						<span>
                           <!-- 임상분류 목록(공통코드) CM4000M - CT2030  M P G O -->
						<select id="searchCondition5" name="searchCondition5">
							<option value="">선택</option>
							<c:if test="${searchVO.searchCondition5 eq '' }">selected="selected"</c:if>
							<c:forEach var="result" items="${ct2030}">									
								<option value="${result.cd}"<c:if test="${result.cd eq searchVO.searchCondition5 }">selected="selected"</c:if>>${result.cdName}</option>
							</c:forEach>
						</select>
						</span>
					</li>
                    <li>
						<p>연구상태</p>
						<span>
							<!-- 연구상태 목록(공통코드) CM4000M - CT2050   -->
							<select id="searchCondition6" name="searchCondition6">
								<option value="">선택</option>
								<c:if test="${searchVO.searchCondition6 eq '' }">selected="selected"</c:if>
								<c:forEach var="result" items="${ct2050}">									
									<option value="${result.cd}"<c:if test="${result.cd eq searchVO.searchCondition6 }">selected="selected"</c:if>>${result.cdName}</option>
								</c:forEach>
							</select>
						</span>
					</li>
					<li>
						<p>기간</p>
                        <span>
                        	<select name="searchCondition4" id="searchCondition4" onchange="fn_resetTerm(); return false;">
								<option value="" <c:if test="${searchVO.searchCondition4  eq '' }">selected="selected"</c:if> >선택</option>
								<option value="1" <c:if test="${searchVO.searchCondition4  eq '1' }">selected="selected"</c:if> >연구시작</option>
								<option value="2" <c:if test="${searchVO.searchCondition4  eq '2' }">selected="selected"</c:if> >연구종료</option>
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
								<option value="2" <c:if test="${searchVO.searchCondition3  eq '2' }">selected="selected"</c:if> >연구명칭</option>
								<option value="3" <c:if test="${searchVO.searchCondition3  eq '3' }">selected="selected"</c:if> >고객사명</option>
								<option value="3" <c:if test="${searchVO.searchCondition3  eq '4' }">selected="selected"</c:if> >연구코드</option>
							</select>
						</span>
                        <span class="type02">
                            <input type="text" name="searchWord" class="input-data" placeholder="연구명칭,고객사명,연구코드를 입력하세요" style="width: 248px;"/>
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
					<col style="width:12%" />
					<col style="width:6%" />
					<col style="width:auto" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:10%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">연구코드</th>
						<th scope="col">임상분류</th>
						<th scope="col">연구명</th>
						<th scope="col">연구상태</th>
						<th scope="col">고객사명</th>
						<th scope="col">피험자수</th>
						<th scope="col">사용체크자수</th>
                        <th scope="col">사용여부</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr onclick="fn_view('<c:out value='${result.corpCd}'/>','<c:out value='${result.rsNo}'/>'); return false;">					
						<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
						<td><c:out value="${result.rsCd }"/></td>
						<td><c:out value="${result.rsNo3Nm }"/></td>
						<td><c:out value="${result.rsName }"/></td>
						<td>
							<c:choose>
                          		<c:when test="${result.dataLockYn eq 'Y' }"><c:out value="${result.rsstClsNm }"/><span style="color:red;">(Data Locked)</span></c:when>
                          		<c:when test="${result.dataLockYn eq 'N' }"><c:out value="${result.rsstClsNm }"/></c:when>
                         	</c:choose>
						</td>
						<td><c:out value="${result.vendName}"/></td>
						<td><c:out value="${result.rsScnt}"/></td>
						<td><c:out value="${result.usechkCnt}"/></td>
						<td><c:out value="${result.useYnNm}"/></td>
					</tr>
				</c:forEach>
				<c:if test="${resultList.size() == 0 }">
					<tr>
						<td class="nodata" colspan="9">제품사용 정보가 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>
			<!-- //목록 -->
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
		</div>		
		<!-- //contents -->
		<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</form:form>
</body>
</html>