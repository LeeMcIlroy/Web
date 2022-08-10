<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javascript">

	// 등록&수정
	function fn_update(){
		
		if($.trim($("#wcTitle").val()) == ""){
			alert("제목을 입력해주세요.");
			return false;
		}
		
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxerpynm/webtoon/admWebtoonCategoryUpdate.do'/>").submit();
	}
	
	// 목록
	function fn_list(){
		$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxerpynm/webtoon/admWebtoonCategoryList.do'/>").submit();
	}
	
</script>
<body>
<form:form commandName="webtoonVO" id="frm" name="frm">
<form:hidden path="wcSeq" />
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
				<c:import url="/EgovPageLink.do?link=adm/inc/incPageTitle">
					<c:param name="dept1" value="한디원뉴스"/>
					<c:param name="dept2" value="한툰 관리"/>
				</c:import>
				<div class="cont_box">
				<!-- content -->
					<!-- table -->
					<div class="tbl_top_area2 mt30">
						<div class="btn_r">
							* 는 필수 입력항목입니다.
						</div>
					</div>
					<table class="view_tbl_03 mb30" summary="한툰 카테고리 관리">
						<caption>한툰 카테고리 관리</caption>
						<colgroup>
							<col width="20%" />
							<col width="80%" />
						</colgroup>
						<tbody>
							<tr class="first">
								<th scope="row">* 제목</th>
								<td>
									<form:input path="wcTitle" class="in_base"/>
								</td>
							</tr>
							<tr>
								<th scope="row">작성자</th>
								<td>
									<c:if test="${empty webtoonVO.wcSeq }">
										<c:out value="${sessionScope.adminSession.admName }"/>
									</c:if>
									<c:if test="${!empty webtoonVO.wcSeq }">
										<c:out value="${webtoonVO.regName }"/>
									</c:if>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" onclick="fn_update(); return false;" class="b_type04">저장</a>
							<a href="#" onclick="fn_list(); return false;" class="b_type03">목록</a>
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
<input type="hidden" id="searchCondition1" name="searchCondition1" value="${searchVO.searchCondition1 }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<!--// 목록 검색 조건 -->
</form:form>
</body>
</html>