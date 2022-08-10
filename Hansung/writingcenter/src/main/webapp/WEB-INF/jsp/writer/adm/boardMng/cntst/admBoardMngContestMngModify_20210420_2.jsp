<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script>
	window.onload = function(){
		var brdType = '<c:out value="${boardVO.brdType }"/>';
		
		if(brdType != 'CONPPT'){
			$(".subject").attr("style", "display:none;");
		}
	};
	
	function fn_goList(){
		$("#frm").attr("method","post").attr("action", "<c:url value='/xabdmxgr/boardMng/cntst/admBoardMngContestMngList.do'/>").submit();
	}
	
	function fn_subject(){
		var brdType = $("#brdType").val();
		
		if(brdType != 'CONPPT'){
			$(".subject").attr("style", "display:none;");
			$("#subject1").val('');
			$("#subject2").val('');
			$("#subject3").val('');
		}else{
			$(".subject").removeAttr("style");
		}
	}

	function fn_update(){
		$("#brdContent").val(CKEDITOR.instances.brdContent.getData());
		
		if($("#brdType").val() == ''){
			alert("대회구분을 선택해주세요.");
			$("#brdType").focus();
			return false;
		}else if($("#brdTitle").val() == ''){
			alert("제목을 입력해주세요.");
			$("#brdTitle").focus();
			return false;
		}else if($("#openYear").val() == ''){
			alert("개최연도를 선택해주세요.");
			$("#brdTitle").focus();
			return false;
		}else if($("#appNum").val() == ''){
			alert("모집인원을 입력해주세요.");
			$("#brdTitle").focus();
			return false;
		}else if($("brdNoticeYn").val() == ''){
			alert("상태를 선택해주세요.");
			return false;
		}
		if(confirm(($("#brdSeq").val()==""? "등록":"수정") + "하시겠습니까?")){
			$("#frm").attr("method","post").attr("action", "<c:url value='/xabdmxgr/boardMng/cntst/admBoardMngContestMngUpdate.do'/>").submit();
		}
	}
</script>
<body>
<form:form commandName="boardVO" id="frm" enctype="multipart/form-data">
<form:hidden path="brdSeq" />
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="searchCondition" name="searchCondition" value="${searchVO.searchCondition }"/>
<input type="hidden" id="searchWord" name="searchType" value="${searchVO.searchType }"/>
<input type="hidden" id="searchWord" name="searchYear" value="${searchVO.searchYear }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<form:hidden path="brdNoticeYn" value="N"/>
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
		            <jsp:param name="dept2" value="대회 관리"/>
            	</jsp:include>
			</div>
			<div class="cont_box">
			<!-- content -->
				<div class="tbl_top_area2" style="height:10px;">
					<div class="btn_r">
						* 는 필수 입력항목입니다.
					</div>
				</div>
				<table class="view_tbl_03 mb30" summary="제15회 한성인 프레젠테이션대회">
					<caption>제15회 한성인 프레젠테이션대회</caption>
					<colgroup>
						<col width="20%" />
						<col width="30%" />
						<col width="20%" />
						<col width="30%" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">* 대회구분</th>
							<td colspan="3">
								<form:select path="brdType" class="se_base w100" onchange="fn_subject(); return false;">
									<form:option value="">선택</form:option>
									<form:option value="CONWRITE">글쓰기</form:option>
									<form:option value="CONPPT">프레젠테이션</form:option>
								</form:select>
							</td>
						</tr>
						<tr>
							<th scope="row">* 제목</th>
							<td colspan="3">
								<form:input path="brdTitle" style="width:100%; ime-mode:active;" maxlength="60"/>
							</td>
						</tr>
						<tr>
							<th scope="row">* 개최연도</th>
							<td>
								<form:select path="openYear" class="se_base w100">
									<form:option value="">선택</form:option>
									<form:option value="2020">2020</form:option>
								</form:select>
							</td>
							<th scope="row">* 모집인원</th>
							<td>
								<form:input path="appNum" style="width:100%; ime-mode:active;"/>
							</td>
						</tr>
						<tr>
							<th scope="row">신청접수일시</th>
							<td colspan="3">
								<form:input path="appSDate" class="datepicker w100"/>
								<form:select path="appSHour" class="se_base w100">
									<c:forEach begin="0" end="23" var="hour">
										<form:option value="${hour }"><fmt:formatNumber value="${hour }" pattern="00"/>시</form:option>
									</c:forEach>
								</form:select>
								<form:select path="appSMinu" class="se_base w100">
									<c:forEach begin="0" end="59" var="minu">
										<form:option value="${minu }"><fmt:formatNumber value="${minu }" pattern="00"/>분</form:option>
									</c:forEach>
								</form:select>
								~
								<form:input path="appEDate" class="datepicker w100"/>
								<form:select path="appEHour" class="se_base w100">
									<c:forEach begin="0" end="23" var="hour">
										<form:option value="${hour }"><fmt:formatNumber value="${hour }" pattern="00"/>시</form:option>
									</c:forEach>
								</form:select>
								<form:select path="appEMinu" class="se_base w100">
									<c:forEach begin="0" end="59" var="minu">
										<form:option value="${minu }"><fmt:formatNumber value="${minu }" pattern="00"/>분</form:option>
									</c:forEach>
								</form:select>
							</td>
						</tr>
						<tr>
							<th scope="row">* 상태</th>
							<td colspan="3">
								<form:select path="useYn" class="se_base w100">
									<form:option value="">선택</form:option>
									<form:option value="Y">진행</form:option>
									<form:option value="N">종료</form:option>
								</form:select>
							</td>
						</tr>
						<tr>
							<td colspan="4" class="editer">
								<form:textarea path="brdContent" style="ime-mode:active;"/>
								<script type="text/javascript">
									CKEDITOR.replace( 'brdContent', {
										filebrowserImageUploadUrl: "<c:url value='/cmmn/ckeditor/uploadCkeditorFile.do'/>"
									});
								</script>
							</td>
						</tr>
						<tr class="subject">
							<th scope="row">주제1</th>
							<td colspan="3">
								<form:textarea path="subject1" style="width:100%; ime-mode:active;" maxlength="800" rows="5"/>
							</td>
						</tr>
						<tr class="subject">
							<th scope="row">주제2</th>
							<td colspan="3">
								<form:textarea path="subject2" style="width:100%; ime-mode:active;" maxlength="800" rows="5"/>
							</td>
						</tr>
						<tr class="subject">
							<th scope="row">주제3</th>
							<td colspan="3">
								<form:textarea path="subject3" style="width:100%; ime-mode:active;" maxlength="800" rows="5"/>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type02" onclick="fn_update(); return false;">
								<c:if test="${empty boardVO.brdSeq }">저장</c:if>
								<c:if test="${!empty boardVO.brdSeq }">수정</c:if>
							</a>
							<a href="#" class="b_type03" onclick="fn_goList(); return false;">목록</a>
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