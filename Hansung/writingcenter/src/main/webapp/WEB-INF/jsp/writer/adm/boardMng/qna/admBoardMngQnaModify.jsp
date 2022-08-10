<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script>
	$(function(){
		$('#ansContent').on('keyup', function() {
	        if($(this).val().length > 50) {
	            $(this).val($(this).val().substring(0, 1300));
	        }
			var content = $(this).val();
			$('#counter').html(content.length + '/1300');
		});
	});

	/* 목록으로 */
	function fn_list(){
		$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/boardMng/qna/admBoardMngQnaList.do'/>").submit();
	}
	
	/* 저장 */
	function fn_modify(){
		if($("#ansTitle").val()=="" || $("#ansTitle").val()==null){
			alert("제목을 입력하세요");
			return false;
		}
		if($("#ansContent").val()=="" || $("#ansContent").val()==null){
			alert("내용을 입력하세요");
			return false;
		}
		if(confirm("답변을 등록하시겠습니까?")){
			$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/boardMng/qna/admBoardMngQnaModify.do'/>").submit();
		}
	}
</script>
<body>
<form:form commandName="result" id="frm" name="frm">
<input type="hidden" id="searchType" name="searchType" value="${searchVO.searchType }"/>
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<input type="hidden" id="searchCondition" name="searchCondition" value="${searchVO.searchCondition }"/>
<form:hidden path="qnaSeq"/>
<input type="hidden" id="ansTitle" name="ansTitle" value="[Re:]<c:out value='${result.qstTitle }'/>" />
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
							<th scope="row" colspan="6"><c:out value="${result.qstTitle }"/></th>
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
				<table class="view_tbl_03 mb30 mt30" summary="Q&A">
					<caption>Q&A</caption>
					<colgroup>
						<col width="20%" />
						<col width="80%" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th colspan="2">
								<label style="text-align: center;">내용</label>
							</th>
						</tr>
						<tr>
							<td colspan="2" style="padding-left:0;">
								<form:textarea path="ansContent" cols="5" rows="5" style="width:100%; height:100px; ime-mode:active;" />
								<div id="counter" style="text-align: right;">0/1300</div>					
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type02" onclick="fn_modify(); return false;">저장</a>
							<a href="#" class="b_type03" onclick="fn_list(); return false;">목록</a>
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
<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>