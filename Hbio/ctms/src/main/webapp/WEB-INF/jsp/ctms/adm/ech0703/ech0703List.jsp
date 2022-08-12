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

	//지사관리 상세보기 화면
	function fn_view(corpCd, branchCd){		
	 	$("#corpCd").val(corpCd);
	 	$("#branchCd").val(branchCd);
	 	$("#listForm").attr("action","<c:url value='/qxsepmny/ech0703/ech0703View.do'/>").submit();
	}
	
	//지사관리 목록으로
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0703/ech0703List.do'/>").submit();
	}
	
	//지사관리 등록화면
	function fn_regist(){
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0703/ech0703Modify.do'/>").submit();
	}
	
	//지사관리 엑셀다운로드
	function fn_excelDown(){
		$("#listForm").attr("action", "<c:url value='/qxsepmny/ech0703/ech0703Excel.do'/>").submit();
	}
	
</script>
<body>
<form:form commandName="searchVO" id="listForm" name="listForm">
<input type="hidden" id="corpCd" name="corpCd"/>
<input type="hidden" id="branchCd" name="branchCd"/>
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
	            <jsp:param name="dept2" value="지사관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 검색영역 -->
			<div class="srch_area">
				<ul>
					
					<li>
						<p>사용여부</p>
						<span>
							<select  name="searchCondition1">
								<option value="">전체</option>
								<option value="Y">사용</option>
								<option value="N">미사용</option>
							</select> 
						</span>
					</li>
                    <li>
						<p>검색어</p>
						<!--  <span>
							<select name="searchCondition2">
								<option>검색조건</option>
								<option value="1">지사명</option>
							</select>
						</span> -->
                        <span class="type02">
                            <input type="text" name="searchWord" class="input-data" placeholder="지사명을  입력하세요" />
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
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:8%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:5%" />
					<col style="width:auto%" />
                    <col style="width:8%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">지사구분</th>
						<th scope="col">지사명</th>
						<th scope="col">지사약칭</th>
						<th scope="col">전화번호</th>
						<th scope="col">팩스번호</th>
						<th scope="col">담당자명</th>
						<th scope="col">우편번호</th>
						<th scope="col">주소</th>
						<th scope="col">사용여부</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">			
					<tr onclick="fn_view('<c:out value='${result.corpCd }'/>', '<c:out value='${result.branchCd }'/>'); return false;">
						<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
						<td><c:out value="${result.branchClsNm }"/></td>
						<td><c:out value="${result.branchName }"/></td>
						<td><c:out value="${result.branchSm }"/></td>
						<td><c:out value="${result.telno}"/></td>
						<td><c:out value="${result.faxno}"/></td>
						<td><c:out value="${result.mngName}"/></td>
						<td><c:out value="${result.postNo}"/></td>
						<td><c:out value="${result.addr}"/></td>
						<td>
							<c:choose>
								<c:when test="${result.useYn == 'Y' }">사용</c:when>
								<c:when test="${result.useYn == 'N' }">미사용</c:when>
							</c:choose>
						</td>
						<%-- <td><c:out value="${result.useYn}"/></td> --%>
					</tr>
				</c:forEach>
				<c:if test="${resultList.size() == 0 }">
					<tr>
						<td class="nodata" colspan="10">지사 정보가 없습니다.</td>
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
					<a href="#" onclick="fn_regist();">등록</a>					
				</div>
				<!-- //하단버튼 -->
			</div>
			<!-- //목록 하단 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>
<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
    <input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
<!--// footer -->	
<!-- //wrap -->
</form:form>
</body>
</html>