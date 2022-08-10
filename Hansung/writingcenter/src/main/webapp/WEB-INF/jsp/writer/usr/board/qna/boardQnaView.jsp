<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script>
	//목록으로
	function fn_goList(){
		$("#frm").attr("method","post").attr("action","<c:out value='${pageContext.request.contextPath }/usr/board/qna/boardQnaList.do'/>").submit();
	}
	
	//수정 화면 이동
	function fn_modify(){
		$("#frm").attr("method","post").attr("action","<c:out value='${pageContext.request.contextPath }/usr/board/qna/boardQnaModifyView.do'/>").submit();
	}
	
	//삭제
	function fn_delete(){
		if(confirm("질문을 삭제하시겠습니까?")==true){
			$("#frm").attr("method","post").attr("action","<c:out value='${pageContext.request.contextPath }/usr/board/qna/boardQnaDelete.do'/>").submit();
		}else{
			return false;
		}
	}
</script>
<body>
<form:form commandName="qnaVO" id="frm">
<form:hidden path="qnaSeq" />
<input type="hidden" id="searchType" name="searchType" value="${searchVO.searchType }"/>
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<input type="hidden" id="searchCondition" name="searchCondition" value="${searchVO.searchCondition }"/>
<div class="wrap">
	<!-- 스킵 네비게이션 -->
	<div id="skip_navigation">
		<ul>
			<li><a href="#gnb">주 메뉴 바로가기</a></li>
			<li><a href="#content">본문 바로가기</a></li>
		</ul>
	</div>
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
	<!--// header -->
	<hr />
	<!-- container -->
	<div class="container">
		<!-- lnb -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu" />
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<jsp:include page="/WEB-INF/jsp/writer/usr/inc/incPageTitle.jsp">
            	<jsp:param name="dept1" value="게시판"/>
            	<jsp:param name="dept2" value="Q&A"/>
            </jsp:include>
			<div class="cont_box">
				<dl class="view_dl mb20">
					<dt><c:out value="${qnaVO.qstTitle }"/></dt>
					<%--
					<dd class="font12">작성자 : <c:out value="${qnaVO.qstRegName }"/>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;작성일 : <c:out value="${qnaVO.qstRegDate }"/>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;조회 : <c:out value="${qnaVO.qnaHitcount }"/></dd>
					--%>
					<dd class="font12">작성자 : <c:out value="${qnaVO.qstRegName }"/>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;작성일 : <c:out value="${qnaVO.qstRegDate }"/></dd>
					<dd class="view_dl_cont">
						<c:out value="${qnaVO.qstContent }" escapeXml="false" />
					</dd>
				</dl>
				<!-- 하단 영역 -->
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<common:eqSession pin="${qnaVO.qstRegId }" >
								<c:if test="${empty qnaVO.ansTitle }">
									<a href="#" class="btn_faq_del" onclick="fn_delete(); return false;">질문삭제</a>
									<a href="#" class="btn_modi" onclick="fn_modify(); return false;">수정</a>
								</c:if>
							</common:eqSession>
							<a href="#" class="btn_list" onclick="fn_goList(); return false;">목록</a>
						</div>
					</div>
				</div>
				<!-- 하단 영역 -->
				<c:if test="${!empty qnaVO.ansTitle }">
				<dl class="view_dl mb20">
					<dt><c:out value="${qnaVO.ansTitle }"/></dt>
					<dd class="font12">작성자 : <c:out value="${qnaVO.ansRegName }"/>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;답변일 : <c:out value="${qnaVO.ansRegDate }"/></dd>
					<dd class="view_dl_cont">
						<c:out value="${qnaVO.ansContent }" escapeXml="false"/>
					</dd>
				</dl>
				</c:if>
			</div>
		</div>
		<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
</div>
<input type="hidden" id="message" name="message" value="${message }"/>
</form:form>
</body>
</html>