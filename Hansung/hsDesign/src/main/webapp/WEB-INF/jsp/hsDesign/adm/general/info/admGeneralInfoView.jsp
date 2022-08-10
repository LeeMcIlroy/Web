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
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxerpynm/general/info/admGeneralInfoList.do'/>").submit();
	}

	// 수정화면
	function fn_modify(geSeq){
		$("#geSeq").val(geSeq);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxerpynm/general/info/admGeneralInfoModify.do'/>").submit();
	}
	
	// 삭제
	function fn_delete(geSeq){
		if(confirm("정말 삭제하시겠습니까?\n삭제한 데이터는 복구할 수 없습니다.")){
			$("#geSeq").val(geSeq);
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxerpynm/general/info/admGeneralInfoDelete.do'/>").submit();
		}
	}

	// 파일 다운로드
	function fn_filedownload(geupSeq, type){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+geupSeq+"&type="+type;
	}

</script>
<body>
	<form id="frm" name="frm">
		<input type="hidden" id="geSeq" name="geSeq" />
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
						<!-- table -->
						<table class="view_tbl_03 mb30 mt30" summary="교양수강문의">
							<caption>교양수강문의</caption>
							<colgroup>
								<col width="13%" />
								<col width="20%" />
								<col width="13%" />
								<col width="20%" />
								<col width="14%" />
								<col width="20%" />
							</colgroup>
							<tbody>
								<tr class="first">
									<th scope="row" colspan="6"><c:out
											value="${generalEduVO.geName }" escapeXml="false" /></th>
								</tr>
								<tr>
									<th scope="row">연도</th>
									<td colspan="2"><c:out value="${generalEduVO.geYear }" />
									</td>
								</tr>
								<tr>
									<th scope="row">학기</th>
									<td colspan="2"><c:out value="${generalEduVO.geSemester }" />
									</td>
								</tr>
								<tr>
									<th scope="row">교육기간</th>
									<td colspan="2"><c:out
											value="${generalEduVO.geLectureBegin }" />(<c:out
											value="${generalEduVO.geLectureBeginWeek }" />)
										&nbsp;~&nbsp; <c:out value="${generalEduVO.geLectureEnd }" />(<c:out
											value="${generalEduVO.geLectureEndWeek }" />)</td>
								</tr>
								<tr>
									<th scope="row">수업시간</th>
									<td colspan="2"><c:out
											value="${generalEduVO.geClasstime }" escapeXml="false" /></td>
								</tr>
								<tr>
									<th scope="row">교강사</th>
									<td colspan="2"><c:out value="${generalEduVO.geTeacher }" />
									</td>
								</tr>
								<tr>
									<th scope="row">강의실</th>
									<td colspan="2"><c:out
											value="${generalEduVO.geClassrome }" /></td>
								</tr>
								<tr>
									<th scope="row">학습비</th>
									<td colspan="2"><fmt:formatNumber
											value="${generalEduVO.geExpense }" type="currency"
											groupingUsed="true" /></td>
								</tr>
								<tr>
									<th scope="row">수강신청</th>
									<td colspan="2"><c:choose>
											<c:when test="${generalEduVO.geType eq 'aply'}">
												<c:out value="신청가능" />
											</c:when>
											<c:when test="${generalEduVO.geType eq 'ready'}">
												<c:out value="준비중" />
											</c:when>
											<c:otherwise>
												<c:out value="신청마감" />
											</c:otherwise>
										</c:choose></td>
								</tr>
								<tr>
									<th scope="row">강의계획서</th>
									<td colspan="2"><c:forEach items="${geUpfileList }"
											var="geUpfile">
											<a href="#"
												onclick="fn_filedownload(<c:out value='${geUpfile.geupSeq }'/>, 'GENERALEDU'); return false;">
												<c:out value="${geUpfile.geupOriginFilename }" />
											</a>
											<br />
										</c:forEach></td>
								</tr>
								<tr>
									<td colspan="6"><c:out value="${generalEduVO.geContent }"
											escapeXml="false" /></td>
								</tr>
							</tbody>
						</table>
						<div class="btn_box">
							<div class="btn_r">
								<a href="#"
									onclick="fn_modify(<c:out value='${generalEduVO.geSeq }'/>); return false;"
									class="b_type01">수정</a> <a href="#"
									onclick="fn_delete(<c:out value='${generalEduVO.geSeq }'/>); return false;"
									class="b_type02">삭제</a> <a href="#"
									onclick="fn_list(); return false;" class="b_type03">목록</a>
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
		<!-- 목록 검색 조건 -->
		<input type="hidden" id="searchCondition1" name="searchCondition1"
			value="${searchVO.searchCondition1 }" /> <input type="hidden"
			id="searchCondition2" name="searchCondition2"
			value="${searchVO.searchCondition2 }" /> <input type="hidden"
			id="searchWord" name="searchWord" value="${searchVO.searchWord }" />
		<input type="hidden" id="pageIndex" name="pageIndex"
			value="${searchVO.pageIndex }" />
		<!--// 목록 검색 조건 -->
		<input type="hidden" id="message" name="message" value="${message }" />
	</form>
</body>
</html>