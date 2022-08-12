<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
	//목록으로
	function fn_list(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0702/ech0702List.do'/>").submit();
	}
	
	//수정페이지로
	function fn_update(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0702/ech0702Modify.do'/>").submit();
	}
	
	//사용자 페이지 삭제
	function fn_delete(){
		if (confirm("사용자를 삭제하시겠습니까?")) {
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0702/ech0702Delete.do'/>").submit();
			
		}
	}
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>기준정보</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="기준정보"/>
	            <jsp:param name="dept2" value="사용자관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>기본정보</h4>
			</div>
			<!-- //서브타이틀 -->
			<form:form commandName="searchVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="corpCd" name="corpCd" value="${ct1030mVO.corpCd }"/>
				<input type="hidden" id="empNo" name="empNo" value="${ct1030mVO.empNo }"/>
				<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/>
	            <!-- 기본정보 -->
				<table class="tbl_view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:35%" />
						<col style="width:15%" />
						<col style="width:35%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">사용자ID</th>
							<td>
								<c:out value="${ct1030mVO.userId}" />
							</td>
							<th scope="row" class="bl">비밀번호</th>
							<td>
								<a href="#" class="btn_sub2">임시비밀번호 SMS발송</a>
							</td>
						</tr>
						<tr>
							<th scope="row">구분</th>
							<td>
								<c:out value="${ct1030mVO.rsClsNm}" />
							
							
								<c:choose>
								<c:when test="${ct1030mVO.userGb eq '1001'}">연구원</c:when>
								<c:when test="${ct1030mVO.userGb eq '1002'}">관리자</c:when>
								</c:choose>
							</td>
							<th scope="row" class="bl">권한</th>
							<td>
								<c:choose>
								<c:when test="${ct1030mVO.resererStat eq '1'}">연구담당자</c:when>
								<c:when test="${ct1030mVO.resererStat eq '2'}">연구책임자</c:when>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th scope="row">최근로그인</th>
							<td><c:out value="${ct1030mVO.recnLoginDate}" /></td>
							<th scope="row" class="bl">가입일시</th>
							<td><c:out value="${ct1030mVO.enterYmd}" /></td>
						</tr>
						<tr>
							<th scope="row">상태</th>
							<td colspan="3">
								<c:choose>
									<c:when test="${ct1030mVO.stat eq 1}">정상</c:when>
									<c:when test="${ct1030mVO.stat eq 2}">정지(로그인차단)</c:when>
								</c:choose>
							</td>
						</tr>
					</tbody>
				</table>
	            <!-- //기본정보 -->
	            <!-- 서브타이틀 -->
				<div class="sub_title_area">
					<h4>사용자정보</h4>
				</div>
				<!-- //서브타이틀 -->
	            <!-- 사용자정보 -->
				<table class="tbl_view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:35%" />
						<col style="width:15%" />
						<col style="width:35%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">사용자명</th>
							<td>
								<c:out value="${ct1030mVO.name}" />
							</td>
							<th scope="row" class="bl">지사정보</th>
							<td>
								<c:out value="${ct1030mVO.branchName}" />
							</td>
						</tr>
						<tr>
							<th scope="row">부서</th>
							<td>
								<c:choose>
									<c:when test="${ct1030mVO.buso eq '1001'}">임상시험1팀</c:when>
									<c:when test="${ct1030mVO.buso eq '1002'}">임상시험2팀</c:when>
									<c:when test="${ct1030mVO.buso eq '1003'}">임상시험3팀</c:when>
									<c:when test="${ct1030mVO.buso eq '1004'}">임상시험4팀</c:when>
								</c:choose>
							</td>
							<th scope="row" class="bl">직위</th>
							<td>
								<c:out value="${ct1030mVO.spot}" />
							</td>
						</tr>
						<tr>
							<th scope="row">핸드폰</th>
							<td>
								<c:out value="${ct1030mVO.hphone}" />
							</td>
							<th scope="row" class="bl">이메일</th>
							<td>
								<c:out value="${ct1030mVO.email}" />
							</td>
						</tr>
					</tbody>
				</table>
	            <!-- //사용자정보 -->
            </form:form>
            <!-- 버튼 -->
			<div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">취소</a>
				<a href="#" onclick="fn_delete(); return false;" >삭제</a>
				<a href="#" onclick="fn_update(); return false;" >수정</a>
			</div>
			<!-- //버튼 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>