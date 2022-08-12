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

	$(function(){
		
		var ynadminType = '<c:out value="${admintype}"/>';
		if(ynadminType == '2'){ //일반사용자권한 - 삭제, 수정 버튼 숨기기
			$('.nonDisp').css("display","none");
		}
		
	});

	//목록으로
	function fn_list(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0703/ech0703List.do'/>").submit();
	}
	
	//수정페이지로
	function fn_update(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0703/ech0703Modify.do'/>").submit();
	}
	
	//공지 페이지 삭제
	function fn_delete(){
		if (confirm("삭제된 지사정보는 복구되지 않습니다. 지사정보가 연구과제, 구성원관리에 사용된 경우 삭제할 수 없습니다.\r\n지사정보를 삭제하시겠습니까?")) {
			$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0703/ech0703Delete.do'/>").submit();
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
	            <jsp:param name="dept2" value="지사관리"/>
           	</jsp:include>
			<!-- //타이틀 -->			
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>지사정보</h4>
			</div>
			<!-- //서브타이틀 -->
			<form:form commandName="searchVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="corpCd" name="corpCd" value="${ct1020mVO.corpCd }"/>
			<input type="hidden" id="branchCd" name="branchCd" value="${ct1020mVO.branchCd }"/>
			<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/>
            <!-- 지사정보 -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">지사명</th>
						<td>
							<c:out value="${ct1020mVO.branchName}" />
						</td>
						<th scope="row" class="bl">지사약침</th>
						<td>
							<c:out value="${ct1020mVO.branchSm}" />
						</td>
					</tr>
					<tr>
						<th scope="row">지사구분</th>
						<td>
							<c:out value="${ct1020mVO.branchClsNm}" />
						</td>
						<th scope="row" class="bl">사용여부</th>
						<td>
							<c:out value="${ct1020mVO.useYn}" />
						</td>
					</tr>					
					<tr>
						<th scope="row">전화번호</th>
						<td>
							<c:out value="${ct1020mVO.telno}" />
						</td>
						<th scope="row" class="bl">팩스번호</th>
						<td>
							<c:out value="${ct1020mVO.faxno}" />
						</td>
					</tr>
					<tr>
						<th scope="row">주소</th>
						<td colspan="3">
							<c:out value="${ct1020mVO.postNo}" />
							<c:out value="${ct1020mVO.addrMain}" />
							<c:out value="${ct1020mVO.addrGita}" />
						</td>
					</tr>
					<tr>
						<th scope="row">비고</th>
						<td colspan="3">
							<c:out value="${ct1020mVO.remk}" />
						</td>	
					</tr>
					<tr>
						<th scope="row">사업자번호</th>
						<td>
							<c:out value="${ct1020mVO.bregRsno}" />
						</td>
						<th scope="row" class="bl">법인번호</th>
						<td>
							<c:out value="${ct1020mVO.corpNo}" />
						</td>
					</tr>
					<tr>
						<th scope="row">업태</th>
						<td>
							<c:out value="${ct1020mVO.bsln}" />
						</td>
						<th scope="row" class="bl">업종(종목)</th>
						<td>
							<c:out value="${ct1020mVO.bscl}" />
						</td>
					</tr>
					<tr>
						<th scope="row">대표자명</th>
						<td colspan="3">
							<c:out value="${ct1020mVO.excutNm}" />
						</td>
					</tr>
					<tr>
						<th scope="row">담당자명</th>
						<td>
							<c:out value="${ct1020mVO.mngName}" />
						</td>
						<th scope="row" class="bl">담당자부서</th>
						<td>
							<c:out value="${ct1020mVO.mngOrg}" />
						</td>
					</tr>
					<tr>
						<th scope="row">담당자휴대폰</th>
						<td>
							<c:out value="${ct1020mVO.mnghpNo}" />
						</td>
						<th scope="row" class="bl">담당자이메일</th>
						<td>
							<c:out value="${ct1020mVO.mngEmail}" />
						</td>
					</tr>
					<tr>
						<th scope="row">지사코드(자동생성)</th>
						<td colspan="3">
							<c:out value="${ct1020mVO.branchCd}" />
						</td>
					</tr>
				</tbody>
			</table>
            <!-- //지사정보 -->
			</form:form>
            <!-- 버튼 -->
			<div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">취소</a>
				<a href="#" class="nonDisp" onclick="fn_delete(); return false;" >삭제</a>
				<a href="#" class="nonDisp" onclick="fn_update(); return false;" >수정</a>
			</div>
			<!-- //버튼 -->
		</div>
		<!-- //contents -->
		<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>