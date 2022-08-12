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
	function fn_copy(tempNo){		
		if(confirm('템플릿을 복사하시겠습니까?')){
			$("#tempNo").val(tempNo);
			$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0202/ech0202Copy.do'/>").submit();
		}
	}

	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("action", "<c:url value='/qxsepmny/ech0202/ech0202List.do'/>").submit();
	}

	function fn_view(tempNo){
		if(tempNo != ''){
			$("#tempNo").val(tempNo);
			$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0202/ech0202View.do'/>").submit();
		}else{
			alert('잘못된 요청입니다.');
		}
	}
	
	function fn_modify(tempNo){
		$("#tempNo").val(tempNo);
		$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0202/ech0202Modify.do'/>").submit();
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
	            <jsp:param name="dept2" value="설문템플릿관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<form:form commandName="searchVO" id="frm" name="frm">
				<input type="hidden" id="tempNo" name="tempNo"/>
				<!-- 검색영역 -->
				<div class="srch_area">
					<ul>
						<li>
							<p>템플릿구분</p>
							<span>
								<form:select path="searchCondition1">
									<form:option value="">전체</form:option>
									<c:forEach items="${typeList }" var="type">
										<form:option value="${type.cd }"><c:out value="${type.cdName }"/></form:option>
									</c:forEach>
								</form:select>
							</span>
						</li>
						<li>
							<p>사용여부</p>
							<span>
								<form:select path="searchCondition2">
									<form:option value="">전체</form:option>
									<form:option value="Y">사용</form:option>
									<form:option value="N">미사용</form:option>
								</form:select>
							</span>
						</li>
						<li>
							<p>기간</p>
	                        <span>
	                            <form:select path="searchCondition3">
									<form:option value="">검색조건</form:option>
									<form:option value="1">등록일</form:option>
									<form:option value="2">사용기간</form:option>
								</form:select>
	                        </span>
							<span>
								<form:input path="startDate" id="datepicker01" class="date" readonly="true"/>
								<label for="datepicker01" class="btn_cld">날짜검색</label>
							</span>
							<em>~</em>
							<span>
								<form:input path="endDate" id="datepicker02" class="date" readonly="true"/>
								<label for="datepicker02" class="btn_cld">날짜검색</label>
							</span>
							<span class="type00">
								<input type="radio" name="period" id="period01" /> <label for="period01">1년</label>
								<input type="radio" name="period" id="period02" /> <label for="period02">3개월</label>
								<input type="radio" name="period" id="period03" /> <label for="period03">1개월</label>
							</span>
						</li>                    
	                    <li>
							<p>검색어</p>
							<span>
								<form:select path="searchType">
									<form:option value="">검색조건</form:option>
									<form:option value="1">템플릿명</form:option>
								</form:select>
							</span>
	                        <span class="type02">
	                            <form:input path="searchWord" placeholder="검색어 입력" />
	                        </span>
						</li>
					</ul>
					<!-- 조회버튼 -->
					<a href="#" onclick="fn_list('1'); return false;">조회</a>
				</div>
				<!-- //검색영역 -->
				<!-- 테이블 상단 정보 -->
				<div class="tbl_top_info">
					<span>총 <c:out value="${paginationInfo.totalRecordCount }"/>건</span>
					<!-- 버튼 -->
					<div>
						<a href="#" class="btn_excel">엑셀</a>
					</div>
				</div>
				<!-- //테이블 상단 정보 -->
				<!-- 목록 -->
				<table class="tbl_list tr_link">
					<colgroup>
						<col style="width:5%" />
						<col style="width:20%" />
						<col style="width:auto" />
						<col style="width:10%" />
						<col style="width:10%" />
						<col style="width:10%" />
						<%-- <col style="width:5%" /> --%>
						<col style="width:10%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">설문템플릿구분</th>
							<th scope="col">템플릿명</th>
							<th scope="col">질문문항수</th>
							<th scope="col">등록일</th>
							<th scope="col">사용여부</th>
							<!-- <th scope="col">시기</th> -->
	                        <th scope="col">복사</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${resultList == null || resultList.size() == 0 }">
								<tr>
									<td class="nodata" colspan="7">템플릿 정보가 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${resultList }" var="result" varStatus="status">
									<%-- <tr onclick="fn_view('<c:out value="${result.tempNo }"/>');"> --%>
									<tr>
										<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage + status.count)}"/></td>
										<td><c:out value="${result.tempTypeNm }"/></td>						
										<td onclick="fn_view('<c:out value="${result.tempNo }"/>'); return false;" style="text-decoration: underline;"><c:out value="${result.tempNm }"/></td>	
										<td><c:out value="${result.quesNum }"/></td>
										<td><c:out value="${result.dataRegdt }"/></td>
										<td><c:out value="${result.useYn eq 'Y'?'사용':'미사용' }"/></td>
										<%-- <td>
											<c:choose>
												<c:when test="${result.termType eq '0' }">상시</c:when>
												<c:when test="${result.termType eq '1' }">사전</c:when>
												<c:when test="${result.termType eq '2' }">사후</c:when>
											</c:choose>
										</td> --%>
										<td><a href="#" onclick="fn_copy('<c:out value="${result.tempNo }"/>'); return false;" class="btn_sub">복사</a></td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<!-- //목록 -->
				<div class="list_btm">
					<!-- 페이징 -->
					<div class="pagenate">
						<ui:pagination paginationInfo="${paginationInfo }" type="image" jsFunction="fn_list"/>
						<form:hidden path="pageIndex"/>
					</div>
					<!-- //페이징 -->
					<!-- 하단버튼 -->
					<div class="list_btm_btn">
						<a href="#" onclick="fn_modify(''); return false;">등록</a>
					</div>
					<!-- //하단버튼 -->
				</div>
				<input type="hidden" id="message" name="message" value="<c:out value='${message }'/>"/>
			</form:form>
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>