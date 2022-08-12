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

	//이메일발송관리 상세보기 화면
	function fn_view(corpCd, recmNo){	
		$("#corpCd").val(corpCd);
	 	$("#recmNo").val(recmNo);
	 	$("#listForm").attr("action","<c:url value='/qxsepmny/ech0602/ech0602View.do'/>").submit();
	}
	
	//이메일발송관리 목록으로
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0602/ech0602List.do'/>").submit();
	}
	//이메일발송관리 등록화면
	function fn_regist(){
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0602/ech0602Modify.do'/>").submit();
	}
	
	//이메일발송관리 엑셀다운로드
	function fn_excelDown(){
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0602/ech0602Excel.do'/>").submit();
	}
	
	//이메일발송관리 예약취소
	function fn_sendcancel(){
		// 예약취소
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
<input type="hidden" id="recmNo" name="recmNo"/>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>발송관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="발송관리"/>
	            <jsp:param name="dept2" value="이메일발송내역"/>
           	</jsp:include>			
			<!-- //타이틀 -->
			<!-- 검색영역 -->
			<div class="srch_area">
				<ul>
					<li>
						<p>기간</p>
                        <span>
                        	<select name="searchCondition4" id="searchCondition4" onchange="fn_resetTerm(); return false;">
								<option value="" <c:if test="${searchVO.searchCondition4  eq '' }">selected="selected"</c:if> >선택</option>
								<option value="1" <c:if test="${searchVO.searchCondition4  eq '1' }">selected="selected"</c:if> >접수일자</option>
								<option value="2" <c:if test="${searchVO.searchCondition4  eq '2' }">selected="selected"</c:if> >예약일자</option>
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
								<option value="2" <c:if test="${searchVO.searchCondition3  eq '2' }">selected="selected"</c:if> >제목</option>
								<option value="3" <c:if test="${searchVO.searchCondition3  eq '3' }">selected="selected"</c:if> >내용</option>
								<option value="4" <c:if test="${searchVO.searchCondition3  eq '4' }">selected="selected"</c:if> >비고</option>
								<option value="5" <c:if test="${searchVO.searchCondition3  eq '5' }">selected="selected"</c:if> >이메일</option>
							</select>
						</span>
                        <span class="type02">
                            <input type="text" name="searchWord" class="input-data" placeholder="제목,내용,비고,이메일를 입력하세요" style="width: 248px;"/>
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
			<table class="tbl_list">
				<colgroup>
					<col style="width:4%" />
					<col style="width:5%" />
					<col style="width:8%" />
					<col style="width:auto" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:6%" />
					<col style="width:6%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:10%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col"><input type="checkbox" /></th>
						<th scope="col">번호</th>
						<th scope="col">접수번호</th>
						<th scope="col">발송제목</th>
						<th scope="col">수신 이메일</th>
						<th scope="col">연구코드</th>
						<th scope="col">첨부보고서</th>
						<th scope="col">전송상태</th>
						<th scope="col">전송결과</th>
						<th scope="col">접수일시</th>
						<th scope="col">예약일시</th>
						<th scope="col">발송일시</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">			
						<tr >						
							<td><input type="checkbox" /></td>				
							<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
							<td><c:out value="${result.recmNo}"/></td>
							<td onclick="fn_view('<c:out value="${result.corpCd }"/>','<c:out value="${result.recmNo }"/>'); return false;" style="text-decoration: underline;"><a href="#" ><c:out value="${result.title }" /></a></td>
							<td><c:out value="${result.receEmail}"/></td>
							<td><c:out value="${result.rsCd}"/></td> 
							<%-- <td><c:out value="${result.fileNames}"/></td> --%>
							<td>
								<c:choose>
	                          		<c:when test="${result.fileNames eq '' }">없음</c:when>
	                          		<c:when test="${result.fileNames eq '1' }"><span style="color:blue;">초안보고서</span></c:when>
	                          		<c:when test="${result.fileNames eq '2' }"><span style="color:blue;">최종보고서</span></c:when>
	                          		<c:when test="${result.fileNames eq '1,2' }"><span style="color:blue;">초안보고서/최종보고서</span></c:when>
                          		</c:choose>
							</td>
							<td><c:out value="${result.tstaClsNm}"/></td>
							<td><c:out value="${result.tsenClsNm}"/></td>
							<td><c:out value="${result.accpDt}"/></td>
							<td>
								<c:choose>
	                          		<c:when test="${result.resrDt eq '' }">즉시발송</c:when>
	                          		<c:otherwise><span style="color:red;"><c:out value="${result.resrDt}"/>/<c:out value="${result.resrHr}"/>:<c:out value="${result.resrMm}"/></span></c:otherwise>
                          		</c:choose>
							</td>
							<td>
								<c:if test="${result.resrDt == ''}">
									<c:out value="${result.sendDt}"/>	
								</c:if>
								<c:if test="${result.resrDt != ''}">
									<c:choose>
		                          		<c:when test="${result.sendDt == null }">
		                          			<span style="color:red;">발송예약</span>
		                          		</c:when>
		                          		<c:otherwise>
		                          			<c:out value="${result.sendDt}"/>
		                          		</c:otherwise>
		                          	</c:choose>	
								</c:if>
 							</td>
							<%-- <td><c:out value="${result.sendDt}"/></td> --%>					
						</tr>
				</c:forEach>
				<c:if test="${resultList.size() == 0 }">
						<tr>
							<td class="nodata" colspan="12">이메일 발송내역 정보가 없습니다.</td>
						</tr>
				</c:if>
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
					<a href="#" onclick="fn_regist();">보고서발송</a>		
					<a href="#" onclick="fn_sendcancel();">발송취소</a>
				</div>
				<!-- //하단버튼 -->
			</div>
			<!-- //목록 하단 -->
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