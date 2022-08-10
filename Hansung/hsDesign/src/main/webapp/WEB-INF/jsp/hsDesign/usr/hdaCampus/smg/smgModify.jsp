<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko" >
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">
	
	// 목록
	function fn_list(pageNo){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/smg/smgList.do'/>").submit();
	}
	
	// 등록
	function fn_update(){
		if($("#cbTitle").val() == ''){
			alert("제목을 입력해주세요.");
			$("#cbTitle").focus();
			return false;
		}else if($("#cbPassword").val() == '' && $("cbSeq").val() == ''){
			alert("비밀번호를 입력해주세요.");
			$("#cbPassword").focus();
			return false;
		}else if($("#regName").val() == '' && $("cbSeq").val() == ''){
			alert("작성자를 입력해주세요.");
			$("#regName").focus();
			return false;
		}else if($("#cbContent").val() == ''){
			alert("내용을 입력해주세요.");
			$("#cbContent").focus();
			return false;
		}
			
		 
		$("#frm").attr("method","post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/smg/smgUpdate.do'/>").submit();
	}
	
</script>
<body>
<form:form commandName="cmmBoardVO" id="frm" name="frm">
<form:hidden path="cbSeq"/>
<input type="hidden" id="password" value="${cmmBoardVO.cbPassword }"/>
	<!-- skip_navigation -->
	<dl id="skip_nav">
		<dt>바로가기 메뉴</dt>
		<dd><a href="#content">본문 바로가기</a></dd>
		<dd><a href="#top_menu">메뉴 바로가기</a></dd>
		<dd><a href="#footer">페이지 하단 바로가기</a></dd>
	</dl>
	<!-- //skip_navigation -->
	<div class="content">
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
	<!--// header -->
	<!-- container -->
	<div class="main_content" id="content">
		<div class="width_box">
			<!-- lnb -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu"/>
			<!--// lnb -->
			<!-- content -->
			<div class="sub_content">
				<!-- 타이틀 영역 -->
				<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="캠퍼스생활"/>
		            <jsp:param name="dept2" value="한디원신문고"/>
	           	</jsp:include>
	           	<div class="transform_table notice_type">
					<div class="tbl_write">
						<ul class="tbl_view_m">
							<li class="txt_left">* 제목</li>
							<li><form:input path="cbTitle" style="width:100%;" maxlength="50"/></li>
						</ul>
						<c:if test="${empty cmmBoardVO.cbSeq }">
							<ul class="tbl_view_m">
								<li class="txt_left">* 비밀번호</li>
								<li><form:password path="cbPassword" maxlength="19"/></li>
							</ul>
							<ul class="tbl_view_m">
								<li class="txt_left">* 작성자</li>
								<li><form:input path="regName" maxlength="20"/></li>
							</ul>
						</c:if>
						<c:if test="${!empty cmmBoardVO.cbSeq }">
							<ul class="tbl_view_m">
								<li class="txt_left">* 작성자</li>
								<li><c:out value="${cmmBoardVO.regName }"/></li>
							</ul>
						</c:if> 
						<div class="tbl_editer"><form:textarea path="cbContent" style="width:100%;height: 250px;margin-top: 5px;margin-bottom: 5px;ime-mode:active;"/></div>
					</div>
				</div>
				<div class="btn_box">
					<a href="#" class="btn_go_save" onclick="fn_update(); return false;">저장</a>
					<a href="#" class="btn_go_list" onclick="fn_list(); return false;">목록</a>
				</div>
				<!-- rolling banner -->
				<c:import url="/EgovPageLink.do?link=usr/inc/incRollingBanner"/>
				<!-- //rolling banner -->
				<!-- //content -->
			</div>			
			<!--// content -->
		</div>
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
</div>
<input type="hidden" id="message" value="${message}" />
<input type="hidden" id="searchCondition1" name="searchCondition1" value="${searchVO.searchCondition1 }"/>
<input type="hidden" id="searchCondition2" name="searchCondition2" value="${searchVO.searchCondition2 }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
</form:form>
</body>
</html>