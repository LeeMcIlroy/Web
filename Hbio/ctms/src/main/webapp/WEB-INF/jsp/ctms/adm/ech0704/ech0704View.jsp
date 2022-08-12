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
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0704/ech0704List.do'/>").submit();
	}
	
	//수정페이지로
	function fn_update(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0704/ech0704Modify.do'/>").submit();
	}
	
	//고객사 페이지 삭제
	function fn_delete(){
		if (confirm("삭제된 고객사정보는 복구되지 않습니다. 고객사정보가 연구과제에 사용된 경우 삭제할 수 없습니다.\r\n고객사정보를 삭제하시겠습니까?")) {
			$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0704/ech0704Delete.do'/>").submit();			
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
	            <jsp:param name="dept2" value="고객사관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>회사정보</h4>
			</div>
			<!-- //서브타이틀 -->
			<form:form commandName="searchVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="corpCd" name="corpCd" value="${ct2000mVO.corpCd }"/>
			<input type="hidden" id="vendNo" name="vendNo" value="${ct2000mVO.vendNo }"/>
			<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/>
            <!-- 회사정보 -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">회사명</th>
						<td>
							<c:out value="${ct2000mVO.vendName}" />
						</td>
						<th scope="row" class="bl">회사약칭</th>
						<td>
							<c:out value="${ct2000mVO.vendSm}" />
						</td>
					</tr>
					<tr>
						<th scope="row">대표자명</th>
						<td>
							<c:out value="${ct2000mVO.excutName}" />
						</td>
						<th scope="row" class="bl">회사구분</th>
						<td>
							<c:out value="${ct2000mVO.vendClsNm}" />
						</td>
					</tr>
					<tr>
						<th scope="row">사업자등록번호</th>
						<td>
							<c:out value="${ct2000mVO.regno1}" />-<c:out value="${ct2000mVO.regno2}" />-<c:out value="${ct2000mVO.regno3}" />
						</td>
						<th scope="row" class="bl">법인번호</th>
						<td>
							<c:out value="${ct2000mVO.cregno1}" />-<c:out value="${ct2000mVO.cregno2}" />
							<!--<c:out value="${ct2000mVO.corpNo}" /> -->
						</td>
					</tr>
					<tr>
						<th scope="row">업태</th>
						<td>
							<c:out value="${ct2000mVO.bsln}" />
						</td>
						<th scope="row" class="bl">업종(종목)</th>
						<td>
							<c:out value="${ct2000mVO.bscl}" />
						</td>
					</tr>
					<tr>
						<th scope="row">전화번호</th>
						<td>
							<c:out value="${ct2000mVO.telno}" />
						</td>
						<th scope="row" class="bl">팩스번호</th>
						<td>
							<c:out value="${ct2000mVO.faxno}" />
						</td>
					</tr>
					<tr>
						<th scope="row">주소</th>
						<td colspan="3">
							<c:out value="${ct2000mVO.postNo}" />
							<c:out value="${ct2000mVO.addrMain}" />
							<c:out value="${ct2000mVO.addrGita}" />
						</td>
					</tr>
					<tr>
						<th scope="row">비고</th>
						<td colspan="3">
							<textarea class="type02 type03"><c:out value="${ct2000mVO.remk}" /></textarea>
						</td>
					</tr>
					<tr>
						<th scope="row">사용여부</th>
						<td colspan="3">
							<c:out value="${ct2000mVO.useYn}" />
						</td>
					</tr>
					<tr>
						<th scope="row">고객사코드(자동생성)</th>
						<td colspan="3">
							<c:out value="${ct2000mVO.vendNo}" />
						</td>
					</tr>
				</tbody>
			</table>
            <!-- //회사정보 -->
            <!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>담당자정보</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 담당자정보 -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">담당자명</th>
						<td>
							<c:out value="${ct2000mVO.mngName}" /> 
						</td>
						<th scope="row" class="bl">부서/직위</th>
						<td>
							<c:out value="${ct2000mVO.mngOrg}" />
						</td>
					</tr>
					<tr>
						<th scope="row">담당자휴대폰</th>
						<td>
							<c:out value="${ct2000mVO.mnghpNo}" />
						</td>
						<th scope="row" class="bl">담당자이메일</th>
						<td>
							<c:out value="${ct2000mVO.mngEmail}" />
						</td>
					</tr>
					<tr>
						<th scope="row">담당지사</th>
						<td colspan="3">
							<c:out value="${ct2000mVO.branchName}" />
						</td>
					</tr>
				</tbody>
			</table>
			<!-- //담당자정보 -->            
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
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>