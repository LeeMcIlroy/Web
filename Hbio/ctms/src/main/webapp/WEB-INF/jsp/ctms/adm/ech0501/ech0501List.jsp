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
	//보고서관리 상세보기 화면
	function fn_view(rsNo){		
		
	 	$("#rsNo").val(rsNo);
	 	$("#listForm").attr("action","<c:url value='/qxsepmny/ech0501/ech0501View.do'/>").submit();
	}
	//보고서 목록으로
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0501/ech0501List.do'/>").submit();
	}
	//보고서 등록화면
	function fn_regist(){
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0501/ech0501Modify.do'/>").submit();
	}
   
  	//공통코드분류관리 엑셀다운로드
	function fn_excelDown(){
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0501/ech0501Excel.do'/>").submit();
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
<input type="hidden" id="rsNo" name="rsNo"/>
<input type="hidden" id="corpCd" name="corpCd"/>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>보고서</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="보고서"/>
	            <jsp:param name="dept2" value="보고서관리"/>
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
								<form:select path="searchCondition6" id="rsCdList">
									<c:forEach items="${yearRsCdList }" var="rscd">
										<form:option value="${rscd.rsCd }"><c:out value="${rscd.rsCd }"/></form:option>
									</c:forEach>
								</form:select>
							</span>
					</li>
					<li>
						<p>연구상태</p>
						<span>
							<form:select id="searchCondition5" path="searchCondition5">
									<form:option value="">전체</form:option>
									<c:if test="${searchVO.searchCondition5 eq '' }">selected="selected"</c:if>
										<c:forEach var="result" items="${ct2050}">
											<option value="${result.cd}"<c:if test="${result.cd eq searchVO.searchCondition5 }">selected="selected"</c:if>>${result.cdName}</option>
									</c:forEach>					
							</form:select>
						</span>
					</li>
					<li>
						<p>기간</p>
	                        <span>
	                        	<select name="searchCondition4" id="searchCondition4" onchange="fn_resetTerm(); return false;">
									<option value="" <c:if test="${searchVO.searchCondition4  eq '' }">selected="selected"</c:if> >선택</option>
									<option value="1" <c:if test="${searchVO.searchCondition4  eq '1' }">selected="selected"</c:if> >심의시작</option>
									<option value="2" <c:if test="${searchVO.searchCondition4  eq '2' }">selected="selected"</c:if> >심의종료</option>

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
									<option value="3" <c:if test="${searchVO.searchCondition3  eq '3' }">selected="selected"</c:if> >연구코드</option>
								</select>
							</span>
	                      <span class="type02">
	                           <input type="text" id="searchWord" name="searchWord" value="${searchVO.searchWord }"class="input-data" placeholder="연구명칭,연구코드를 입력하세요" style="width: 248px;"/>
	                      </span>
					</li>
				</ul>
				<!-- 조회버튼 -->
				<a href="#" onclick="fn_list(1); return false;"> 조회</a>
			</div>
			<!-- //검색영역 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<span>
				
				<strong><c:out value="${totalCount }"/></strong>건이 검색되었습니다.
				
				</span>
				
				<!-- 버튼 -->
				<div>
					<a href="#" class="btn_excel" onclick="fn_excelDown(); return false;">엑셀</a>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
			<!-- 목록 -->
			<table class="tbl_list tr_link">
				<colgroup>
					<col style="width:5%" />
					<col style="width:13%" />
					<col style="width:auto" />
					<col style="width:8%" />
<%-- 					<col style="width:10%" /> --%>	
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:26%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">연구코드</th>
						<th scope="col">연구명</th>
						<th scope="col">연구상태</th>
					<!-- 	<th scope="col">연구계획서 작성일</th> -->
						<th scope="col">IRB계획심의</th>
                        <th scope="col">IRB결과심의</th>
                        <th scope="col">등록 보고서</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="result" items="${resultList}" varStatus="status">			
						<tr>
							<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
							<td><c:out value="${result.rsCd}"/></td>			
							<td><a href="#" class="underline imgSelect" onclick="fn_view('<c:out value='${result.rsNo }'/>', this); return false;"><c:out value="${result.rsName }"/></a></td>			
							<td><c:out value="${result.rsstClsNm}"/></td>
						<%-- 	<td><c:out value=""/></td> --%>
							<td><c:out value="${result.plrvStdt}"/> ~ <c:out value="${result.plrvEddt}"/></td>
							<td><c:out value="${result.rsrvStdt}"/> ~ <c:out value="${result.rsrvEddt}"/></td>
							<td><c:out value="${result.report}"/></td> <!--등록보고서  -->
												
						</tr>
					</c:forEach>
				
					<c:if test="${resultList.size() == 0 }">
						<tr>
							<td class="nodata" colspan="7">연구 정보가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<!-- //목록 -->
			<!-- 페이징 -->
			<div class="pagenate">
						<ui:pagination paginationInfo="${paginationInfo }" type="image" jsFunction="fn_list"/>
						<form:hidden path="pageIndex"/>
			</div>
			<!-- //페이징 -->
		</div>
		<!-- //contents -->
		
	</div>
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	
	<!-- //container -->
</div>	
<!-- //wrap -->
</form:form>
</body>
</html>