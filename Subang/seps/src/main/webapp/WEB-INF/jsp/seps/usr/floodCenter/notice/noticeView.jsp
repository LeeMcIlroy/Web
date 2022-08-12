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
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/floodCenter/noticeList.do'/>").submit();
	}
	
	// 수정
	function fn_modify(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/floodCenter/noticeModify.do'/>").submit();
	}
	
	// 삭제
	function fn_remove(){
		if(confirm('정말로 삭제하시겠습니까?\n삭제한 데이터는 복구가 불가능합니다.')){
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/floodCenter/noticeDelete.do'/>").submit();
		}
	}

	// 파일 다운로드
	function fn_filedownload(fileId, type){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+fileId+"&type="+type;
	}
</script>
<body  class="sub_page">
<form:form commandName="noticeVO" id="frm" name="frm">
<form:hidden path="noticeId"/>
</form:form>
	<!-- top menu - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incTopnav"/>
	<!-- top menu - end -->
		<div class="m_body" >
			<!-- left menu - start -->
			<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incLeftnav"/>
			<!-- left menu - end -->
			<div class="main_content">
				<div class="content">
					<div class="m_title">
						<div class="title">공지사항</div>
						<div class="navi">
							<ul>
								<li>HOME</li>
								<li>수방매뉴얼</li>
								<li>공지사항</li>
							</ul>
						</div>
					</div>
					<div class="cont_box ptb_50">
						<div class="transform_table notice_type">
							<div class="tbl_view">
								<ul class="tbl_view_m">
									<li class="txt_left"><c:out value="${noticeVO.title }"/></li>
								</ul>
								<ul class="tbl_view_cul">
									<li>작성자</li>
									<li><c:out value="${noticeVO.regNm}"/></li>
									<li>작성일</li>
									<li><c:out value="${noticeVO.regDttm}"/></li>
									<li>조회</li>
									<li><c:out value="${ noticeVO.hitCnt}"/></li>
								</ul>
								<ul class="tbl_file">
									<li>첨부파일</li>
									<li>
										<a href="#" onclick="fn_filedownload(<c:out value='${fileVO.attachFileId }'/>, 'NOTICE'); return false;">
											<c:out value="${fileVO.orgFileNm }"/>
										</a><p></p>
									</li>
								</ul>
								<div class="tbl_cont">
									<c:out value="${noticeVO.content }" escapeXml="false"/>
								</div>
							</div>
						</div>
						<div class="btn_box">
							<a href="#" class="btn_modi" onclick="fn_modify(); return false;">수정</a>
							<a href="#" class="btn_del" onclick="fn_remove(); return false;">삭제</a>
							<a href="#" class="btn_list" onclick="fn_list(); return false;">목록</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- footer -->
		<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incFooter"/>
		<!-- footer -->
		<!-- 목록 검색조건 - start -->
		<input type="hidden" id="searchCondition1" name="searchCondition1" value="${searchVO.searchCondition1 }">
		<input type="hidden" id="searchCondition2" name="searchCondition2" value="${searchVO.searchCondition2 }">
		<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }">
		<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }">
		<!-- 목록 검색조건 - end -->
	</body>
</html>