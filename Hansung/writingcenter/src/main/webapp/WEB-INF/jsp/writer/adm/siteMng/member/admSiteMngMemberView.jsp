<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script>


	//목록으로 
	function fn_list(){
		$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/siteMng/member/admSiteMngMemberList.do'/>").submit();
	}
	
	//수정 화면 이동
	function fn_modify(){
		$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/siteMng/member/admSiteMngMemberModifyView.do'/>").submit();
	}
	
	//삭제
	function fn_delete(){
		if(confirm("회원을 삭제하시겠습니까?")==true){
			$("#frm").attr("method","post").attr("action","<c:url value='/xabdmxgr/siteMng/member/admSiteMngMemberDelete.do'/>").submit();
			
		}else{
			return false;
		}
	}

</script>
<body>
<form:form commandName="adminVO" id="frm" name="frm">
<form:hidden path="memSeq" />
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="searchCondition" name="searchCondition" value="${searchVO.searchCondition }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
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
					<jsp:param name="dept1" value="사이트관리"/>
		            <jsp:param name="dept2" value="회원관리"/>
            	</jsp:include>
			</div>
			<div class="cont_box">
			<!-- content -->
				<table class="view_tbl_03 mb30 mt30" summary="회원관리">
					<caption>회원관리</caption>
					<colgroup>
						<col width="20%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">사번</th>
							<td>
								<c:out value="${adminVO.memCode }"/>
							</td>
						</tr>
						<tr>
							<th scope="row">이름</th>
							<td>
								<c:out value="${adminVO.memName }"/>
							</td>
						</tr>
						<tr>
							<th scope="row">이메일</th>
							<td>
								<c:out value="${adminVO.memEmail }"/>
							</td>
						</tr>
						<tr>
							<th scope="row">휴대전화</th>
							<td>
								<c:out value="${adminVO.memMphone }"/>
							</td>
						</tr>
						<tr>
							<th scope="row">회원레벨</th>
							<td>
								<c:if test="${adminVO.memLevel == 1 }">
									관리자
								</c:if>
								<c:if test="${adminVO.memLevel == 2 }">
									교수
								</c:if>
								<c:if test="${adminVO.memLevel == 3 }">
									연구원
								</c:if>
							</td>
						</tr>
						<tr>
							<th scope="row">첨삭여부</th>
							<td>
								<c:if test="${adminVO.memUpdtYn eq 'Y' }">
									가능
								</c:if>
								<c:if test="${adminVO.memUpdtYn eq 'N' }">
									불가능
								</c:if>
							</td>
						</tr>
						<tr>
							<th scope="row">관리자 메모</th>
							<td>
								<c:out value="${adminVO.memMemo }" />
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type02" onclick="fn_modify(); return false;">수정</a>
							<a href="#" class="b_type03" onclick="fn_delete(); return false;">삭제</a>
							<a href="#" class="b_type02" onclick="fn_list(); return false;">목록</a>
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