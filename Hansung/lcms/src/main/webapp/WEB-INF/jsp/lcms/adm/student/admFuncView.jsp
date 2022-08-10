<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">

function edit(){
	$("#detailForm").attr("action", "<c:url value='/qxsepmny/student/admFuncModify.do'/>").submit();
}
function del(){
	var funcSeq = $("#funcSeq").val();
	var maxSeq = $("#maxSeq").val();
	
	if(funcSeq != maxSeq){
		alert('마지막 변동내역만 삭제하실 수 있습니다.');
		return;
	}
	
	if(confirm('삭제 하시겠습니까?')){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/student/admFuncDelete.do'/>").submit();
	}
}
//파일 다운로드
function fn_filedownload(geupSeq, type){
	location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+geupSeq+"&type="+type;
}
</script> 

<body>
<form:form commandName="funcVO" id="detailForm" name="detailForm" method="post">
<form:hidden path="memberSeq" value="${result.memberSeq }"/>
<form:hidden path="funcSeq" value="${funcResult.funcSeq }"/>
<form:hidden path="funcBefState" value="${funcResult.funcBefState }"/>
<input type="hidden" id="maxSeq" value="<c:out value='${maxSeq }'/>"/>
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="학생"/>
		            <jsp:param name="dept2" value="학적변동"/>
	           	</jsp:include>
				<p class="sub-title">대상자 정보</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>학번</th>
								<td colspan="3">
									<c:out value="${result.memberCode }" />
								</td>
							</tr>
							<tr>
								<th>이름</th>
								<td colspan="3">
									<c:out value="${result.name }" />
								</td>
							</tr>
							<tr>
								<th>국적</th>
								<td>
									<c:out value="${result.nation }" />
								</td>
								<th class="txt-c">
									생년월일
								</th>
								<td>
									<c:out value="${result.birthYear }" />.<c:out value="${result.birthMonth }" />.<c:out value="${result.birthDay }" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<p class="sub-title">학적변동</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>변동사항</th>
								<td>
									<c:out value="${funcResult.funcState }" />
								</td>
							</tr>
							<tr>
								<th>변동일</th>
								<td>
									<c:out value="${funcResult.funcDate }" />
								</td>
							</tr>
							<tr>
								<th>사유</th>
								<td class="">
									<c:out value="${funcResult.funcReason }" />
								</td>
							</tr>
							<tr>
								<th>첨부파일</th>
								<td>
								<a href="#" onclick="fn_filedownload(<c:out value='${attachList[0].attachSeq }'/>, 'FUNC'); return false;"><c:out value="${attachList[0].orgFileName}"/></a>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/student/admFuncList.do'/>" class="white btn-list">목록</a>
						<!-- <a href="#" onclick="edit()" class="white btn-newwrite">수정</a> -->
						<button type="button" onclick="del()" class="white btn-del">삭제</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->
	</form:form>
</body>
</html>