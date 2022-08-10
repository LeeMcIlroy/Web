<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko" >
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javascript">
	// 목록
	function fn_list(pageNo){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/elite/fbusiness/admEliteFbusinessList.do'/>").submit();
	}
	
	// 삭제
	function fn_delete(){
		if(confirm("삭제하시겠습니까?")){
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/elite/fbusiness/admEliteFbusinessDelete.do'/>").submit();
			
		}
	}
	
	//수정화면
	function fn_modify(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/elite/fbusiness/admEliteFbusinessModify.do'/>").submit();
	}


</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<input type="hidden" id="mbSeq" name="mbSeq" value="${resultVO.mbSeq }">
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
				<jsp:include page="/WEB-INF/jsp/hsDesign/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="일학습엘리트과정"/>
		            <jsp:param name="dept2" value="패션전자상거래"/>
            	</jsp:include>
			</div>
			<div class="cont_box">
			<!-- content -->
				<!-- table -->
				<table class="view_tbl_03 mb30 mt30" summary="패션전자상거래">
					<caption>패션전자상거래</caption>
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
							<th scope="row" colspan="6"><c:out value="${resultVO.mbTitle }" escapeXml="false"/> </th>
						</tr>
						<tr>
							<th scope="row">게시판 구분</th>
							<td colspan="5">
								<div class="list_ch">
									<c:if test="${!empty resultVO.mbGubun1Name }">
										<div>
											<c:out value="${resultVO.mbGubun1Name }"/>
										</div>
									</c:if>
									<c:if test="${!empty resultVO.mbGubun2Name }">
										<div>
											<c:out value="${resultVO.mbGubun2Name }"/>
										</div>
									</c:if>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">공지여부</th>
							<td >
								<c:if test="${resultVO.mbNoticeYn eq 'Y' }">공지</c:if>
								<c:if test="${resultVO.mbNoticeYn eq 'N' }">일반</c:if>
							</td>
							<th scope="row">공지일</th>
							<td colspan="3">
								<c:if test="${resultVO.mbNoticeYn eq 'Y' }">
									<c:out value="${resultVO.mbNoticeDate }"/>
								</c:if>
								<c:if test="${resultVO.mbNoticeYn eq 'N' }">
									-
								</c:if>
							</td>
						</tr>
						<tr>
							<th scope="row">작성자</th>
							<td>
								<c:out value="${resultVO.mbRegName }"/>
							</td>
							<th scope="row">작성일</th>
							<td>
								<c:out value="${resultVO.mbRegDate }"/>
							</td>
							<th scope="row">조회수</th>
							<td>
								<c:out value="${resultVO.mbCount }"/>
							</td>
						</tr>
						<tr>
							<td colspan="6" class="boardViewStyle">
								<c:out value="${resultVO.mbContent }" escapeXml="false"/>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btn_box">
					<div class="btn_r">
						<a href="#" onclick="fn_modify(); return false;" class="b_type01">수정</a>
						<a href="#" onclick="fn_delete(); return false;" class="b_type02">삭제</a>
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
<form:hidden path="searchCondition1"/>
<form:hidden path="searchCondition2"/>
<form:hidden path="searchWord"/>
<form:hidden path="pageIndex"/>
</form:form>
</body>
</html>