<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui"		uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring"	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common"	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
	$(function(){
		$("#all-chk").change(function(){
			$("input[name=regSeq]").prop("checked", $(this).prop('checked'));
		});
	});
	
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("action", "<c:url value='/qxsepmny/regist/admTuinotiList.do'/>").submit();
	}
	
	function fn_pop(){
		var regSeqList = "";
		if($("input[name=regSeq]:checked").length == 0){
			alert("인쇄할 고지서를 선택해 주세요.");
			return;
		}
		$("input[name=regSeq]:checked").each(function(){
			regSeqList = regSeqList + $(this).val() + ",";
		});
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/regist/admTuinotiPop.do?regSeqList='/>"+regSeqList, '고지서 인쇄', 'width=1000, height=600, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	function fn_excelDown(){
		$("#frm").attr("action", "<c:url value='/qxsepmny/regist/admTuinotiExcel.do'/>").submit();
	}
	
	function fn_modify(seq, enterNum, enterStdType){
		if(enterStdType == '1'){
			alert('교환학생은 등록금고지 대상이 아닙니다.');
			return;
		}
		
		$("#regSeq").val(seq);
		$("#enterNum").val(enterNum);
		$("#frm").attr("action", "<c:url value='/qxsepmny/regist/admTuinotiModify.do'/>").submit();
	}
</script>
<body>
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="등록"/>
		            <jsp:param name="dept2" value="등록금고지"/>
	           	</jsp:include>
				<!-- search -->
				<form:form commandName="searchVO" id="frm" name="frm">
				<input type="hidden" id="regSeq" name="regSeq"/>
				<input type="hidden" id="enterNum" name="enterNum"/>
				<div class="search-box none-option">
					<input type="checkbox" id="search-option-open" />
					<div class="search">
						<div class="search-input">
							<table class="shearch-option">
								<colgroup>
									<col style="width:8%;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th>접수학기</th>
										<td>
											<form:select path="searchCondition1" onchange="fn_search_seme(this);">
												<form:options items="${yearList }"/>
											</form:select>
											<form:select path="searchCondition2" id="semEster">
												<c:forEach items="${semeList }" var="seme">
													<form:option value="${seme.semester }"><c:out value="${seme.semeNm }"/></form:option>
												</c:forEach>
											</form:select>
											<form:input path="searchWord" class="input-data" placeholder="학번,이름,국적,학적을 입력하세요" />
										</td>
									</tr>
								</tbody>
							</table>
							<a href="#" onclick="fn_list(1); return false;">검색하기</a>
						</div>
					</div>
				</div>
				<!--// search -->
				<!--search info-->
				<div class="search-infomation">
					<div class="search-count">
						<strong><c:out value="${paginationInfo.totalRecordCount }"/></strong>건이 검색되었습니다.
					</div>
					<div class="paging-select">
						<c:out value="${paginationInfo.currentPageNo }"/> / <c:out value="${totalPageCount }"/>page &nbsp;&nbsp;
						<form:select path="recordCountPerPage" onchange="fn_list(1); return false;">
							<form:option value="10">10</form:option>
							<form:option value="15">15</form:option>
							<form:option value="20">20</form:option>
							<form:option value="25">25</form:option>
							<form:option value="30">30</form:option>
						</form:select>
					</div>
				</div>
				<!--// search info-->
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-list-table">
						<colgroup>
							<col style="width:5%;" />
							<col style="width:8%;" />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th><input type="checkbox" id="all-chk"/></th>
								<th>접수번호</th>
								<th>학번</th>
								<th class="sorting">
									이름
									<button>오름차순 정렬</button>
									<button>내림차순 정렬</button>
								</th>
								<th>국적</th>
								<th>학생구분</th>
								<th>신청구분</th>
								<th>등록금</th>
								<th>입학금</th>
								<th>보험료</th>
								<th>대상학기</th>
								<th>가상계좌번호</th>
								<th>기납<br/>여부</th>
								<th>입학연기</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList }" var="result" varStatus="status">
								<tr>
									<td><input type="checkbox" value="<c:out value='${result.regSeq }'/>" name="regSeq" /></td>
									<td>
										<a class="underline" href="#" onclick="fn_modify('<c:out value="${result.regSeq }"/>','<c:out value="${result.enterNum }"/>','<c:out value="${result.enterStdType }"/>'); return false;">
											<c:out value="${result.enterNum }"/>
										</a>
									</td>
									<td><a class="underline" href="#" onclick="fn_modify('<c:out value="${result.regSeq }"/>','<c:out value="${result.enterNum }"/>','<c:out value="${result.enterStdType }"/>'); return false;"><c:out value="${result.enterCode }"/></a></td>
									<td><c:out value="${result.enterName }"/></td>
									<td><c:out value="${result.enterNation }"/></td>
									<td><c:out value="${result.enterStdTypeNm }"/></td>
									<td><c:out value="${result.enterType }"/></td>
									<td class="txt-r"><fmt:formatNumber value="${result.regFee }" pattern="#,###"/></td>
									<td class="txt-r"><fmt:formatNumber value="${result.enterFee }" pattern="#,###"/></td>
									<td class="txt-r"><fmt:formatNumber value="${result.insuFee }" pattern="#,###"/></td>
									<td>
										<c:if test="${result.addYn ne 'Y' }">
											<c:out value="${result.regRgYear }"/>
										</c:if>
									</td>
									<td><c:out value="${result.bankAccount }"/></td>
									<td><c:out value="${result.addYn eq 'Y'?'추가':result.payYn eq 'Y'?'기납':'' }"/></td>
									<td><c:out value="${result.delayStatus }"/></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<button type="button" class="white btn-print" onclick="fn_pop(); return false;">고지서인쇄</button>
						<button type="button" class="white btn-down" onclick="fn_excelDown(); return false;">Download</button>
						<!-- <a class="white btn-newwrite" href="#" onclick="fn_modify(''); return false;">등록금등록</a> -->
					</div>
				</div>
				<!--// table button -->
				<!-- paging -->
				<div class="paging_wrap">
					<div class="paging">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_list" />
						<form:hidden path="pageIndex" />
					</div>
				</div>
				<!--// paging -->
				<input type="hidden" id="message" name="message" value="<c:out value='${message }'/>">
				</form:form>
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->
</body>
</html>