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
$(document).ready(function(){
    
  	
});

//각 테이블에서 동일한 값 셀병합
$(function (){
    $(".rowspan_td").each(function() {   	
        var rows = $(".rowspan_td" + ":contains('" + $(this).text() + "')");
        var rows_A = rows.siblings(".td_a");
        var rows_B = rows.siblings(".td_b");
        var rows_C = rows.siblings(".td_c");
        var rows_D = rows.siblings(".td_d");

        if (rows.length > 1) {
            rows.eq(0).attr("rowspan", rows.length);
            rows_A.eq(0).attr("rowspan",rows.length);
            rows_B.eq(0).attr("rowspan",rows.length);
            rows_C.eq(0).attr("rowspan",rows.length);
            rows_D.eq(0).attr("rowspan",rows.length);
            rows.not(":eq(0)").remove();
            rows_A.not(":eq(0)").remove();
            rows_B.not(":eq(0)").remove();
            rows_C.not(":eq(0)").remove();
            rows_D.not(":eq(0)").remove();
        } 
    });
})

$(function(){
	//엑셀다운로드권한 
	var ynexauth = '<c:out value="${exauth}"/>';
	if(ynexauth=='N') {
		$('.btn_excel').css("display","none");
	}
})
//피부자극결과 상세보기
function fn_view(rsNo,cfmCnt){		
	$("#rsNo").val(rsNo);
 	$("#cfmCnt").val(cfmCnt);
	localStorage.setItem("cfmCnt",cfmCnt);
    if(cfmCnt == 0){
    	
    	alert("참여 중인 피험자가 없습니다.");
    	return;
    }else{
    	
 		$("#listForm").attr("action","<c:url value='/qxsepmny/ech0207/ech0207View.do'/>").submit();
    }
}
// 피부자극결과 목록
function fn_list(pageNo){
	
	$("#pageIndex").val(pageNo);
	$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0207/ech0207List.do'/>").submit();
}
//공통코드분류관리 엑셀다운로드
function fn_excelDown(){
	$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0207/ech0207Excel.do'/>").submit();
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
<!-- wrap -->
<div class="wrap">
	
		<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
		<!-- container -->
		<div class="container">
			<h2>eCRF관리</h2>
			<!-- contents -->
			<div class="contents">
			<form:form commandName="searchVO" id="listForm" name="listForm">
				<input type="hidden" id="rsNo" name="rsNo"/>
				<input type="hidden" id="corpCd" name="corpCd"/>
				<input type="hidden" id="cfmCnt" name="cfmCnt"/>
				
				
								
				<!-- 타이틀 -->
				<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="자료추출"/>
		            <jsp:param name="dept2" value="피부자극결과"/>
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
									<form:select path="searchCondition7" id="rsCdList">
										<c:forEach items="${yearRsCdList }" var="rscd">
											<form:option value="${rscd.rsCd }"><c:out value="${rscd.rsCd }"/></form:option>
										</c:forEach>
									</form:select>
								</span>
						</li>
						<li>
							<p>연구상태</p>
							<span>
								<form:select id="searchCondition6" path="searchCondition6">
										<form:option value="">전체</form:option>
										<c:if test="${searchVO.searchCondition6 eq '' }">selected="selected"</c:if>
											<c:forEach var="result" items="${ct2050}">
												<option value="${result.cd}"<c:if test="${result.cd eq searchVO.searchCondition6 }">selected="selected"</c:if>>${result.cdName}</option>
										</c:forEach>					
								</form:select>
							</span>
						</li>
	                    <li>
							<p>사용여부</p>
							<span>					
								<select id="searchCondition5" name="searchCondition5" class="p60">
									<option value=""  <c:if test="${selected eq '' }"> selected="selected" </c:if>> 전체</option>
									<option value="N" <c:if test="${selected eq 'N' }">selected="selected" </c:if>> 사용</option>
									<option value="Y" <c:if test="${selected eq 'Y' }">selected="selected" </c:if>>미사용</option>
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
										<option value="3" <c:if test="${searchVO.searchCondition3  eq '3' }">selected="selected"</c:if> >연구코드</option>
									</select>
								</span>
		                      <span class="type02">
		                           <input type="text" name="searchWord" class="input-data" placeholder="연구명칭,연구코드를 입력하세요" style="width: 248px;"/>
		                      </span>
						</li>
					</ul>
					<!-- 조회버튼 -->
					<a href="#" onclick="fn_list(1); return false;">조회</a>
				</div>
				<!-- //검색영역 -->
				<!-- 테이블 상단 정보 -->
				<div class="tbl_top_info">
					<span>총 <c:out value="${totalCount}"></c:out>건이 검색되었습니다.  </span>
					<!-- 버튼 -->
					<div>
						<a href="#" class="btn_excel" onclick="fn_excelDown(); return false;">엑셀</a>
					</div>
				</div>
				<!-- //테이블 상단 정보 -->
				<!-- 목록 -->
				<table class="tbl_list tr_link">
					<colgroup>
						<col style="width:3%" />
						<col style="width:10%" />		
						<col style="width:43%" />
						<col style="width:5%" />
						<col style="width:5%" />
						<col style="width:5%" />
					    <col style="width:18%" />
						<col style="width:8%" />
						<col style="width:5%" />
						<col style="width:5%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">연구코드</th>
							<th scope="col">연구명 </th>						
 							<th scope="col">연구상태</th>
							<th scope="col">피험자수</th>
							<th scope="col">시험물질</th>
							<th scope="col">물질명</th>
							<th scope="col">로트번호</th>
							<th scope="col">자극지수</th>
							<th scope="col">판정</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${resultList}" varStatus="status">			
							<tr>
								<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
								<td class="rowspan_td"><c:out value="${result.rsCd } "/></td>			
								<td class="td_a" style="text-align: left; text-decoration: underline;"><a href="#" class="" onclick="fn_view('<c:out value='${result.rsNo }'/>','<c:out value='${result.cfmCnt}'/>', this); return false;"><c:out value="${result.rsName}"/></a></td>									
								<td class="td_b"><c:out value="${result.rsstClsNm}"/></td>
								<td class="td_c"><c:out value="${result.cfmCnt}"/></td>
								
								<td><c:out value="${result.mtlDsp}"/></td>
								<td style="text-align: left;"><c:out value="${result.mtlName}"/></td>
								<td><c:out value="${result.lotNo}"/></td>
								<td><c:out value="${result.total}"/></td>
								<td><c:out value="${result.judge}"/></td>
							</tr>
						</c:forEach>
					</tbody>
					<c:if test="${resultList.size() == 0 }">
						<tr>
							<td class="nodata" colspan="5">연구 정보가 없습니다.</td>
						</tr>
					</c:if>
				</table>
				<!-- //목록 -->
				<!-- 페이징 -->
				<div class="pagenate">
					<ui:pagination paginationInfo="${paginationInfo }" type="image" jsFunction="fn_list"/>
					<form:hidden path="pageIndex"/>
				</div>
				<!-- //페이징 -->			
			</form:form>	
			</div>	
			<!-- //contents -->
			<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
		</div>
		<c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
		<!-- //container -->
	</div>
<!-- //wrap -->
</body>
</html>