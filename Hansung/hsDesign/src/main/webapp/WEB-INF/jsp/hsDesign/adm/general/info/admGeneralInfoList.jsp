<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javascript">

	// 목록
	function fn_list(pageIndex){
		$("#pageIndex").val(pageIndex);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/general/info/admGeneralInfoList.do'/>").submit();
	}

	// 조회
	function fn_select(geSeq){
		$("#geSeq").val(geSeq);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/general/info/admGeneralInfoView.do'/>").submit();
	}

	// 등록화면
	function fn_modify(geSeq){
		$("#geSeq").val(geSeq);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/general/info/admGeneralInfoModify.do'/>").submit();
	}
	
	// 파일 다운로드
	function fn_filedownload(geupSeq, type){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+geupSeq+"&type="+type;
	}
</script>
<body>
	<form:form commandName="searchVO" id="frm" name="frm">
		<input type="hidden" id="geSeq" name="geSeq" />
		<input type="hidden" id="geupSeq" name="geupSeq" />
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
					<c:import url="/EgovPageLink.do?link=adm/inc/incPageTitle">
						<c:param name="dept1" value="교양과정" />
						<c:param name="dept2" value="교양과정안내" />
					</c:import>
					<div class="cont_box">
						<!-- content -->
						<div class="tbl_top_side">
							<div class="side_r">
								<ul>
									<li style="margin-right: 5px;">연도</li>
									<li><form:select path="searchCondition4"
											class="se_base w100">
											<form:option value="all">전체</form:option>
											<form:option value="2022">2022</form:option>
											<form:option value="2021">2021</form:option>
											<form:option value="2020">2020</form:option>
											<form:option value="2019">2019</form:option>
											<form:option value="2018">2018</form:option>
											<form:option value="2017">2017</form:option>
											<form:option value="2016">2016</form:option>
											<form:option value="2015">2015</form:option>
										</form:select></li>
									<li style="margin-right: 5px;">학기</li>
									<li><form:select path="searchCondition3"
											class="se_base w100">
											<form:option value="all">전체</form:option>
											<form:option value="1학기">1학기</form:option>
											<form:option value="하계학기">하계학기</form:option>
											<form:option value="2학기">2학기</form:option>
											<form:option value="동계학기">동계학기</form:option>
										</form:select></li>
									<li><form:select path="searchCondition1"
											class="se_base w100">
											<form:option value="title">과정명</form:option>
											<form:option value="expense">수강료</form:option>
										</form:select></li>
									<li><form:select path="searchCondition2"
											class="se_base w100">
											<form:option value="">전체</form:option>
											<form:option value="aply">신청가능</form:option>
											<form:option value="ready">준비중</form:option>
											<form:option value="finish">신청마감</form:option>
										</form:select></li>
									<li><form:input path="searchWord" class="in_base w150" />
									</li>
									<li><a href="#" onclick="fn_list(1); return false;"
										class="btn_type05 input_btn">검색</a></li>
								</ul>
							</div>
						</div>
						<table class="list_tbl_03" summary="교양수강문의 목록">
							<caption>교양수강문의</caption>
							<colgroup>
								<col style="width: 30%" />
								<col style="width: 10%" />
								<col style="width: 10%" />
								<col style="width: 30%" />
								<col style="width: 10%" />
								<col style="width: 10%" />
							</colgroup>
							<thead>
								<tr class="first">
									<th scope="col">과정명</th>
									<th scope="col">학기</th>
									<th scope="col">수강신청</th>
									<th scope="col">수강기간</th>
									<th scope="col">학습비</th>
									<th scope="col">강의계획서</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${resultList }" var="result"
									varStatus="status">
									<tr>
										<td class="ta_left"><a href="#"
											onclick="fn_select(<c:out value='${result.geSeq }'/>); return false;">
												<c:out value="${result.geName }" escapeXml="false" />
										</a></td>
										<td><c:out value="${result.geSemester }" /></td>
										<td><c:if test="${result.geType eq '1' }">
												<span class="txt_col_r">신청가능</span>
											</c:if> <c:if test="${result.geType eq '2' }">
												<span class="txt_col_bc">준비중</span>
											</c:if> <c:if test="${result.geType eq '3' }">
												<span class="txt_col_b">신청마감</span>
											</c:if></td>
										<td><c:out value="${result.geLectureBegin }" />&nbsp;~&nbsp;<c:out
												value="${result.geLectureEnd }" /></td>
										<td><fmt:formatNumber value="${result.geExpense }"
												type="currency" groupingUsed="true" /></td>
										<td>
											<c:if test="${result.geupSeq != '' && result.geupSeq != null }">
												<a href="#" onclick="fn_filedownload(<c:out value='${result.geupSeq }'/>, 'GENERALEDU'); return false;">
													다운로드
												</a>
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div class="btm_area">
							<!-- 페이징 -->
							<div class="pagenate">
								<ui:pagination paginationInfo="${paginationInfo }" type="image"
									jsFunction="fn_list" />
								<form:hidden path="pageIndex" />
							</div>
							<div class="page_btn">
								<a href="#" onclick="fn_modify(); return false;"
									class="b_type03">글쓰기</a>
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
		<input type="hidden" id="message" name="message" value="${message}" />
	</form:form>
</body>
</html>