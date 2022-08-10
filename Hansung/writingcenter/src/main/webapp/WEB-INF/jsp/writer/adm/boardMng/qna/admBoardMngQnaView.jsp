<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script>
	function fn_list(){
		$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/boardMng/qna/admBoardMngQnaList.do'/>").submit();
	}
	
	function fn_modify(){
		$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/boardMng/qna/admBoardMngQnaModifyView.do'/>").submit();
	}
	
	function fn_delete(){
		if(confirm("삭제하시겠습니까?")==true){
			$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/boardMng/qna/admBoardMngQnaDelete.do'/>").submit();
			
		}else{
			return false;
		}
	}

</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="searchType" />
<form:hidden path="searchWord" />
<form:hidden path="searchCondition" />
<form:hidden path="pageIndex" />
<input type="hidden" id="qnaSeq" name="qnaSeq" value="${result.qnaSeq }"/>
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
		<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<!-- 타이틀 영역 -->
			<div class="title_area">
				<jsp:include page="/WEB-INF/jsp/writer/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="게시판관리"/>
		            <jsp:param name="dept2" value="Q&A"/>
            	</jsp:include>
			</div>
			<div class="cont_box">
			<!-- content -->
				<table class="view_tbl_03 mb30 mt30" summary="Q&A">
					<caption>Q&A</caption>
					<colgroup>
						<col width="14%" />
						<col width="20%" />
						<col width="13%" />
						<col width="20%" />
						<col width="13%" />
						<col width="20%" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th colspan="6">
								<c:out value="${result.qstTitle }"/>
							</th>
						</tr>
						<tr>
							<th>작성자</th>
							<td><c:out value="${result.qstRegName }"/></td>
							<th>작성일</th>
							<td><c:out value="${result.qstRegDate }"/></td>
							<th>조회</th>
							<td><c:out value="${result.qnaHitcount }"/></td>
						</tr>
						<tr>
							<td colspan="6">
								<c:out value="${result.qstContent }" escapeXml="false"/>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_c">
							<a href="#" class="b_type03" onclick="fn_delete(); return false;">질문삭제</a>
						</div>
					</div>
				</div>
				<c:if test="${empty result.ansTitle }">
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_c">
							<a href="#" class="b_type02" onclick="fn_modify(); return false;">답변등록</a>
							<a href="#" class="b_type03" onclick="fn_list(); return false;">목록</a>
						</div>
					</div>
				</div>
				</c:if>
				<c:if test="${!empty result.ansTitle }">
				<table class="view_tbl_03 mb30 mt30" summary="Q&A">
					<caption>Q&A</caption>
					<colgroup>
						<col width="15%" />
						<col width="35%" />
						<col width="15%" />
						<col width="35%" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th colspan="4"><c:out value="${result.ansTitle }"/></th>
						</tr>
						<tr>
							<th>작성자</th>
							<td><c:out value="${result.ansRegName }"/></td>
							<th>답변일</th>
							<td><c:out value="${result.ansRegDate }"/></td>
						</tr>
						<tr>
							<td colspan="4">
								<c:out value="${result.ansContent }" escapeXml="false"/>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_c">
							<a href="#" class="b_type02" onclick="fn_modify(); return false;">답변수정</a>
							<a href="#" class="b_type03" onclick="fn_list(); return false;">목록</a>
						</div>
					</div>
				</div>
				</c:if>
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
<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>