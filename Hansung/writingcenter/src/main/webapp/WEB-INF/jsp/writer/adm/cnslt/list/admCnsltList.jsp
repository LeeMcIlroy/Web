<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javascript">
	/* pagination 페이지 링크 function */
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/cnslt/list/admCnsltList.do'/>").submit();
	}
	
	// 등록&수정화면
	function fn_modify(aplySeq){
		$("#aplySeq").val(aplySeq);
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/cnslt/list/admCnsltModify.do'/>").submit();
	}
	
	// 상담완료 엑셀 다운로드 popup
	function fn_cnsltCompleteExcel_popup(){
		url = "<c:out value='${pageContext.request.contextPath}/EgovPageLink.do?link=adm/cnslt/list/admCnsltCompleteExcelPopup'/>";
		window.open(url, "", "width=480, height=190");
	}
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<input type="hidden" id="aplySeq" name="aplySeq"/>
<div class="wrap">
	<!-- 스킵 네비게이션 -->
	<div id="skip_navigation">
		<ul>
			<li><a href="#gnb">주 메뉴 바로가기</a></li>
			<li><a href="#content">본문 바로가기</a></li>
		</ul>
	</div>
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav" />
	<!--// header -->
	<hr />
	<p class="container_top_bg"></p>
	<!-- container -->
	<div class="container">
		<!-- lnb -->
		<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu" />
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<!-- 타이틀 영역 -->
			<jsp:include page="/WEB-INF/jsp/writer/adm/inc/incPageTitle.jsp">
            	<jsp:param name="dept1" value="상담"/>
            	<jsp:param name="dept2" value="상담리스트"/>
            </jsp:include>
			<div class="cont_box">
			<!-- content -->
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type02" onclick="fn_cnsltCompleteExcel_popup(); return false;">상담 엑셀 다운로드</a>
						</div>
					</div>
				</div>
				<!-- table -->
				<table class="list_tbl_03 mt30" summary="상담 목록">
					<caption>상담리스트</caption>
					<colgroup>
						<col style="width:6%" />
						<col style="width:10%" />
						<col style="width:10%" />
						<col style="width:18%" />
						<col style="width:12%" />
						<col style="width:12%" />
						<col style="width:12%" />
						<col style="width:10%" />
					</colgroup>
					<thead>
						<tr class="first">
							<th scope="col">번호</th>
							<th scope="col">상담구분</th>
							<th scope="col">신청인</th>
							<th scope="col">강좌명</th>
							<th scope="col">상담일</th>
							<th scope="col">상담신청일</th>
							<th scope="col">상태</th>
							<th scope="col">연구원</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${resultList }" var="result" varStatus="status">
							<tr>
								<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
								<td>
									<c:if test="${result.aplyType eq '1'}">온라인</c:if>
									<c:if test="${result.aplyType eq '2'}">면대면</c:if>
								</td>
								<td><c:out value="${result.aplyName }"/></td>
								<td class="ta_left">
									<a href="#" onclick="fn_modify(<c:out value='${result.aplySeq }'/>); return false;">
										<c:out value="${result.aplyCourseName }"/>
									</a>
								</td>
								<td>
									<strong><c:out value="${result.schYmd }"/></strong>
								</td>
								<td><c:out value="${result.regDate }"/></td>
								<td>
									<c:if test="${result.aplyStatus eq '1' }">신청완료</c:if>
									<c:if test="${result.aplyStatus eq '2' }">상담완료</c:if>
									<c:if test="${result.aplyStatus eq '3' }">불참</c:if>
									<c:if test="${result.aplyStatus eq '4' }">상담취소</c:if>
								</td>
								<td><c:out value="${result.updtName }"/></td>
							</tr>
						</c:forEach>
						<%--
						<tr>
							<td>10</td>
							<td>면대면</td>
							<td>홍길동</td>
							<td class="ta_left"><a href="#">철학의 이해</a></td>
							<td><strong>2017-01-13</strong></td>
							<td>2017-01-13</td>
							<td>상담완료</td>
							<td>한성대</td>
						</tr>
					 	--%>
					</tbody>
				</table>
				<div class="btm_area">
					<!-- 페이징 -->
					<div class="pagenate">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_list" />
						<form:hidden path="pageIndex" />
					</div>
					<div class="tbl_top_side">
						<div class="side_c">
							<ul>
								<li>
									<form:select path="searchType" class="se_base w100">
										<form:option value="">상태</form:option>
										<form:option value="1">신청완료</form:option>
										<form:option value="2">상담완료</form:option>
										<form:option value="3">불참</form:option>
										<form:option value="4">상담취소</form:option>
									</form:select>
								</li>
								<li>
									<form:select path="searchCondition" class="se_base w100">
										<form:option value="1">신청인</form:option>
										<form:option value="2">연구원</form:option>
									</form:select>
								</li>
								<li>
									<form:input path="searchWord" class="in_base w150" />
								</li>
								<li>
									<a href="#" class="btn_type05 input_btn" onclick="fn_list(1); return false;">검색</a>
								</li>
							</ul>
						</div>
						<div class="total">
							게시물 <span><c:out value="${paginationInfo.totalRecordCount }"/></span>건
						</div>
					</div>
				</div>
			<!-- //content -->
			</div>
		</div>
		<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter" />
	<!--// footer -->
</div>
<input type="hidden" id="message" value="${message }"/>
</form:form>
</body>
</html>