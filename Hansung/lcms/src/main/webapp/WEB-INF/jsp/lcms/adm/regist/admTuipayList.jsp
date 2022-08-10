<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<style>
	.ui-datepicker{ z-index: 9999 !important;}
</style>
<script type="text/javascript">
	$(function(){
		$("#all-chk").change(function(){
			$("input[name=regSeq]").prop("checked", $(this).prop('checked'));
		});
	});

	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("action", "<c:url value='/qxsepmny/regist/admTuipayList.do'/>").submit();
	}
	
	function fn_view(seq){
		$("#regSeq").val(seq);
		$("#frm").attr("action", "<c:url value='/qxsepmny/regist/admTuipayModify.do'/>").submit();
	}
	
	function fn_excelDown(){
		$("#frm").attr("action", "<c:url value='/qxsepmny/regist/admTuipayExcel.do'/>").submit();
	}
	
	function fn_openPop(){
		if($("input[name=regSeq]:checked").length < 1){
			alert('학생을 선택해 주세요.');
			return;
		}
		$("#modi-pop").prop("checked", "true");
	}
	
	function fn_payBat(){
		if(confirm('선택하신 학생들의 납부내역을 일괄 납부 처리합니다.\r\n저장하시겠습니까?')){
			var payDate = $("#datepicker03").val();
			if(payDate == ''){
				alert('납부일자를 선택해 주세요.');
				return;
			}
			
			$("#payDate").val(payDate);
			$("#frm").attr("action", "<c:url value='admTuipayBat'/>").submit();
		}
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
		            <jsp:param name="dept2" value="등록금납부"/>
	           	</jsp:include>
	           	<form:form commandName="searchVO" id="frm" name="frm">
	           	<input type="hidden" id="regSeq" name="regSeq"/>
	           	<input type="hidden" id="payDate" name="payDate"/>
				<!-- search -->
				<div class="search-box">
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
										<th>대상학기</th>
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
						<div class="search-option">
							<label for="search-option-open"><span>조건항목검색</span></label>
						</div>
						<!-- 확장 검색조건항목 -->
						<div class="shearch-option-box">
							<div class="shearch-option-list">
								<table class="shearch-option">
									<colgroup>
										<col style="width:15%;" />
										<col />
									</colgroup>
									<tbody>
										<tr>
											<th>납부일자</th>
											<td>
												<div>
													<form:input path="startDate" id="datepicker01" placeholder="0000-00-00" readonly="true"/> -
													<form:input path="endDate" id="datepicker02" placeholder="0000-00-00" readonly="true"/>
												</div>
											</td>
										</tr>
										<tr>
											<th>신청구분</th>
											<td>
												<form:checkbox path="searchCondition3" id="option-gubun01" value="1" /> <label for="option-gubun01">신규</label>&nbsp;&nbsp;&nbsp;
												<form:checkbox path="searchCondition3" id="option-gubun02" value="2" /> <label for="option-gubun02">재등록</label>
											</td>
										</tr>
										<tr>
											<th>납부여부</th>
											<td>
												<div>
													<form:select path="searchCondition4">
														<form:option value="">선택</form:option>
														<form:option value="1">완료</form:option>
														<form:option value="2">미납</form:option>
													</form:select>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="shearch-btn">
								<div class="btn-box">
									<button type="button" class="green" onclick="fn_list(1); return false;">검색</button>
								</div>
							</div>
						</div>
						<!--// 확장 검색조건항목 -->
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
								<th>구분</th>
								<th>등록금</th>
								<th>입학금</th>
								<th>보험금</th>
								<th>대상<br />학기</th>
								<th>가상계좌번호</th>
								<th>납부</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList }" var="result" varStatus="status">
								<tr>
									<td><input type="checkbox" value="<c:out value='${result.regSeq }'/>" name="regSeq"/></td>
									<td><span class="underline imgSelect" onclick="fn_view('<c:out value="${result.regSeq }"/>'); return false;"><c:out value="${result.enterNum }"/></span></td>
									<td><span class="underline imgSelect" onclick="fn_view('<c:out value="${result.regSeq }"/>'); return false;"><c:out value="${result.memberCode }"/></span></td>
									<td><span class="underline imgSelect" onclick="fn_view('<c:out value="${result.regSeq }"/>'); return false;"><c:out value="${result.enterName }"/></span></td>
									<td><c:out value="${result.enterNation }"/></td>
									<td><c:out value="${result.enterType }"/></td>
									<td class="txt-r"><fmt:formatNumber value="${result.regFee }" pattern="#,###"/></td>
									<td class="txt-r"><fmt:formatNumber value="${result.enterFee }" pattern="#,###"/></td>
									<td class="txt-r"><fmt:formatNumber value="${result.insuFee }" pattern="#,###"/></td>
									<td><c:out value="${result.regRgYear }"/>(<c:out value="${result.regRgSeme }"/>)</td>
									<td><c:out value="${result.bankAccount }"/></td>
									<c:if test="${result.pay eq '미납' }">
										<td><span class="txt-red"><c:out value="${result.pay }"/></span></td>
									</c:if>
									<c:if test="${result.pay ne '미납' }">
										<td><c:out value="${result.pay }"/></td>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<button type="button" class="white btn-type07" onclick="fn_openPop(); return false;">납부 일괄 처리</button>
						<button type="button" class="white btn-down" onclick="fn_excelDown(); return false;">Download</button>
						<%-- <a class="white btn-type09" href="<c:out value='${pageContext.request.contextPath }/qxsepmny/regist/admTuipayModify.do'/>">납부확인</a> --%>
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
		<!-- 팝업 -->
		<input type="checkbox" id="modi-pop" class="hidden" />
		<div class="black-pop">&nbsp;</div>
		<div class="modi-popup" style="width:250px; height:170px; top:60%; left:56%;">
			<p class="sub-title" id="popTit">급수 선택</p>
			<div class="search-box none-option">
				<input type="checkbox" id="search-option-open" />
				<div class="search">
					<div class="search-input">
						<table class="shearch-option">
							<colgroup>
								<col />
							</colgroup>
							<tbody>
								<tr>
									<td>
										<input type="text" class="input-data" id="datepicker01" placeholder="0000-00-00" readonly="readonly"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="table-button">
				<div class="btn-box">
					<button type="button" class="white btn-save" onclick="fn_payBat(); return false;">저장</button>
					<label for="modi-pop" class="white btn-cancel">취소</label>
				</div>
			</div>
		</div>
		<!-- // 팝업 -->
	</div>
	<!--// contents -->
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->
</body>
</html>