<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=inc/incHead" />
<script type="text/javascript">

	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/adm/floodCenter/noticeList.do'/>").submit();
	}
	
	// 수정
	function fn_modify(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/adm/floodCenter/noticeModify.do'/>").submit();
	}
	
	// 삭제
	function fn_remove(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/adm/floodCenter/noticeDelete.do'/>").submit();
	}

	// 파일 다운로드
	function fn_filedownload(fileId, type){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+fileId+"&type="+type;
	}
</script>
<body>
<form:form commandName="noticeVO" id="frm" name="frm">
<form:hidden path="noticeId"/>
	<!-- top menu - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- top menu - end -->
	<div class="m_body">
		<!-- WEB LEFT_MENU -->
		<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/inc/incLeftnav"/>
		<!--// WEB LEFT_MENU -->
		<div class="main_content">
			<!-- PAGE_TITLE -->
			<div class="page_title">공지사항</div>
			<!--// PAGE_TITLE -->
			<div class="content">
				<div class="cont_box">
					<div>
						<div>
							<table class="input_table">
								<colgroup>
									<col width="15%" />
									<col width="85%" />
								</colgroup>
								<tbody>
									<tr>
										<th>글쓴이</th>
										<td>
											<c:out value="${noticeVO.regNm}"/>
										</td>
									</tr>
									<tr>
										<th>작성일</th>
										<td>
											<c:out value="${noticeVO.regDttm}"/>
										</td>
									</tr>
									<tr>
										<th>조회</th>
										<td>
											<c:out value="${ noticeVO.hitCnt}"/>
										</td>
									</tr>
									<tr>
										<th>공지여부</th>
										<td>
											<c:if test="${noticeVO.noticeYn == 'Y' }">사용</c:if><c:if test="${noticeVO.noticeYn == 'N' }">미사용</c:if>
										</td>
									</tr>
									<tr>
										<th>첨부파일</th>
										<td>
											<a href="#" onclick="fn_filedownload(<c:out value='${fileVO.attachFileId }'/>, 'NOTICE'); return false;">
											<c:out value="${fileVO.orgFileNm }"/>
										</a>
										</td>
									</tr>
									<tr>
										<td colspan="2"><c:out value="${noticeVO.content }" escapeXml="false"/></td>
									</tr>
								</tbody>
							</table>
							<div class="btn_box">
								<button class="btn_list" onclick="fn_modify(); return false;">수정</button>
								<button class="btn_list" onclick="fn_remove(); return false;">삭제</button>
								<button class="btn_list" onclick="fn_list(); return false;">목록</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- footer - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=inc/incFooter"/>
	<!-- footer - end -->
	
<!-- 목록 검색조건 - start -->
<input type="hidden" id="searchCondition1" name="searchCondition1" value="${searchVO.searchCondition1 }">
<input type="hidden" id="searchCondition2" name="searchCondition2" value="${searchVO.searchCondition2 }">
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }">
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }">
<!-- 목록 검색조건 - end -->
</form:form>
</body>
</html>