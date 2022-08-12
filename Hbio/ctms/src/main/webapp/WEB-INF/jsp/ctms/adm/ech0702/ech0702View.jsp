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
		
		var ynVal = '<c:out value="${ct1030mVO.rsmg}"/>';		
		if(ynVal=='Y') {$("#rsmg").attr('checked', 'checked');}
	
		var ynVal = '<c:out value="${ct1030mVO.ecrf}"/>';		
		if(ynVal=='Y') {$("#ecrf").attr('checked', 'checked');}
		
		var ynVal = '<c:out value="${ct1030mVO.rsjt}"/>';		
		if(ynVal=='Y') {$("#rsjt").attr('checked', 'checked');}
		
		var ynVal = '<c:out value="${ct1030mVO.extr}"/>';		
		if(ynVal=='Y') {$("#extr").attr('checked', 'checked');}
		
		var ynVal = '<c:out value="${ct1030mVO.rept}"/>';		
		if(ynVal=='Y') {$("#rept").attr('checked', 'checked');}
		
		var ynVal = '<c:out value="${ct1030mVO.send}"/>';		
		if(ynVal=='Y') {$("#send").attr('checked', 'checked');}
		
		var ynVal = '<c:out value="${ct1030mVO.sale}"/>';		
		if(ynVal=='Y') {$("#sale").attr('checked', 'checked');}
		
		var ynVal = '<c:out value="${ct1030mVO.stnd}"/>';		
		if(ynVal=='Y') {$("#stnd").attr('checked', 'checked');}
		
		var ynVal = '<c:out value="${ct1030mVO.oper}"/>';		
		if(ynVal=='Y') {$("#oper").attr('checked', 'checked');}
	
		var ynVal = '<c:out value="${ct1030mVO.mcrf}"/>';		
		if(ynVal=='Y') {$("#mcrf").attr('checked', 'checked');}
		
		var ynVal = '<c:out value="${ct1030mVO.acrf}"/>';		
		if(ynVal=='Y') {$("#acrf").attr('checked', 'checked');}
		
		var ynadminType = '<c:out value="${admintype}"/>';
		if(ynadminType == '2'){ //일반사용자권한 - 삭제, 수정 버튼 숨기기
			$('.nonDisp').css("display","none");
		}
	
	});

	function fn_clearPw(){
		if(confirm('사용자의 비밀번호를 재설정 하시겠습니까?')){
			$.ajax({
				url: "<c:url value='/qxsepmny/ech0702/ech0702AjaxProfClearPw.do'/>"
				, type: "post"
				, data: $("#detailForm").serialize()
				, dataType: "json"
				, success: function(data){
					var message = data.message;
					alert(message);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}


	function fn_clearLgnFail(){
		if(confirm('사용자의 로그인 횟수를 초기화 하시겠습니까?')){
			var userId = $("#userId").val();
			$.ajax({
				url: "<c:url value='/qxsepmny/ech0702/ech0702AjaxClearLgnFail.do'/>"
				, type: "post"
				, data: "adminId="+userId
				, dataType: "json"
				, success: function(data){
					var message = data.message;
					alert(message);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}


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
				<input type="hidden" id="userId" name="userId" value="${ct1030mVO.userId }"/>
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
								<a href="#" onclick="fn_clearPw(); return false;" class="nonDisp btn_sub2">비밀번호 재설정</a>
								<!-- <a href="#" class="btn_sub2">임시비밀번호 SMS발송</a> -->
								<a href="#" onclick="fn_clearLgnFail(); return false;" class="nonDisp btn_sub2">로그인횟수 초기화</a>
							</td>
						</tr>
						<tr>
							<th scope="row">구분</th>
							<td>
								<c:out value="${ct1030mVO.rsClsNm}" />
							</td>
							<th scope="row" class="bl">권한</th>
							<td>
								<c:out value="${ct1030mVO.rsAuthClsNm }" />
							</td>
						</tr>
						<tr>
							<th scope="row" >가입일시</th>
							<td><c:out value="${ct1030mVO.incDt}" /></td>
							<th scope="row" class="bl">상태</th>
							<td colspan="3">
								<c:out value="${ct1030mVO.userStNm }" />
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
							<th scope="row">구성원번호</th>
							<td>
								<c:out value="${ct1030mVO.empNo }" />							
							</td>
							<th scope="row" class="bl">사원구분</th>
							<td>
								<c:out value="${ct1030mVO.empClsNm }" />								
							</td>
						</tr>
						<tr>
							<th scope="row">사용자명</th>
							<td>
								<c:out value="${ct1030mVO.empName}" />
							</td>
							<th scope="row" class="bl">지사정보</th>
							<td>
								<c:out value="${ct1030mVO.branchName}" />
							</td>
						</tr>
						<tr>
							<th scope="row">부서</th>
							<td>
								<c:out value="${ct1030mVO.orgNm }" />
							</td>
							<th scope="row" class="bl">직위</th>
							<td>
								<c:out value="${ct1030mVO.spot}" />
							</td>
						</tr>
						<tr>
							<th scope="row">핸드폰</th>
							<td>
								<c:out value="${ct1030mVO.hpNo}" />
							</td>
							<th scope="row" class="bl">이메일</th>
							<td>
								<c:out value="${ct1030mVO.email}" />
							</td>
						</tr>
					</tbody>
				</table>
	            <!-- //사용자정보 -->
	            <!-- 서브타이틀 -->
				<div class="sub_title_area">
					<h4>권한정보</h4>
				</div>
				<!-- //서브타이틀 -->
	            <!-- 권한정보 -->
				<table class="tbl_view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:35%" />
						<col style="width:15%" />
						<col style="width:35%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">접속허용IP</th>
							<td>
								<!--<c:out value="${ct1030mVO.acceIp }" /> -->
								
								<c:out value="${ct1030mVO.acceIp eq ''?'설정된 IP가 없습니다':ct1030mVO.acceIp}" />							
							</td>
							<th scope="row" class="bl">모든 IP허용</th>
							<td>
								<%-- <c:out value="${ct1030mVO.ipAllYn }" /> --%>
								
								<c:choose>
	                          		<c:when test="${ct1030mVO.ipAllYn eq 'Y' }"><span style="color:blue;">모든IP허용</span></c:when>
	                          		<c:when test="${ct1030mVO.ipAllYn eq 'N' }">고정IP사용</c:when>
	                          	</c:choose>
																
							</td>
						</tr>
						<tr>
							<th scope="row">사용자구분</th>
							<td>
								<!--<c:out value="${ct1030mVO.adminType}" />-->
								<c:choose>
	                          		<c:when test="${ct1030mVO.adminType eq '1' }"><span style="color:red;">Admin 권한</span></c:when>
	                          		<c:when test="${ct1030mVO.adminType eq '2' }">일반사용자 권한</c:when>
	                          	</c:choose>
							</td>
							<th scope="row" class="bl">최근 로그인일자</th>
							<td>
								<c:out value="${ct1030mVO.rloginDt}" />
							</td>	
						</tr>
						<tr>
							<th scope="row">사용권한</th>
							<td colspan="3">
								<ul>
									<li>
										<input type="checkbox" name="rsmg" id="rsmg" />
										<label for="rsmg">연구관리</label>	
									</li>
									<li>
										<input type="checkbox" name="ecrf" id="ecrf" />
										<label for="ecrf">eCRF관리</label>	
									</li>
									<li>
										<input type="checkbox" name="rsjt" id="rsjt" />
										<label for="rsjt">피험자관리</label>	
									</li>
									<li>
										<input type="checkbox" name="extr" id="extr" />
										<label for="extr">자료추출</label>	
									</li>
									<li>
										<input type="checkbox" name="rept" id="rept" />
										<label for="rept">보고서</label>	
									</li>
									<li>
										<input type="checkbox" name="send" id="send" />
										<label for="send">발송관리</label>	
									</li>
									<li>
										<input type="checkbox" name="sale" id="sale" />
										<label for="sale">영업관리</label>	
									</li>
									<li>
										<input type="checkbox" name="stnd" id="stnd" />
										<label for="stnd">기준정보관리</label>	
									</li>
									<li>
										<input type="checkbox" name="oper" id="oper" />
										<label for="oper">운영관리</label>	
									</li>
									<li>
										<input type="checkbox" name="mcrf" id="mcrf" />
										<label for="mcrf">CRF작성</label>	
									<li>
										<input type="checkbox" name="acrf" id="acrf" />
										<label for="acrf">종료확인</label>	
									</li>
								</ul>
							</td>
						</tr>
						<tr>
							<th scope="row">엑셀다운로드권한</th>
							<td colspan="3">
								<c:choose>
	                          		<c:when test="${ct1030mVO.exauth eq 'Y' }"><span style="color:blue;">엑셀다운로드허용</span></c:when>
	                          		<c:when test="${ct1030mVO.exauth eq 'N' }">허용안됨</c:when>
	                          	</c:choose>
							</td>
						</tr>	
					</tbody>
				</table>
	            <!-- //권한정보 -->
            </form:form>
            <!-- 버튼 -->
			<div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">취소</a>
				<a href="#" onclick="fn_delete(); return false;" class="nonDisp">삭제</a>
				<a href="#" onclick="fn_update(); return false;" class="nonDisp">수정</a>
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