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

	function fn_add(seq){

	    var re= /[a-z0-9]|[ \[\]{}()<>?|`~!@#$%^&*-_+=,.;:\"'\\]/g;
		var re2 = /^[a-zA-Z0-9]*$/; 

		var currName = $("#currName").val();
		var currCode = $("#currCode").val(); 
		
		if (currName == '' || currName == null) {
			alert('과목명 입력해 주세요');
			$("#currName").focus(); 
		}else if(currCode == '' || currCode == null){
			alert('과목코드 입력해 주세요');
			$("#currCode").focus(); 
		}else if(re.test(currName)){
		 	alert("한글만 입력해 주세요.");
		 	$("#currName").focus();
		}else if(!re2.test(currCode)){
			alert("다시 입력해 주세요.");
			$("#currCode").focus();
		}else if(!re.test(currName) && re2.test(currCode)){
			confirm("등록 하시겠습니까 ?")
			$('#detaleList').attr("method", "post").attr("action","<c:out value='${pageContext.request.contextPath}/qxsepmny/curr/addCurr.do'/>").submit();		
			}
		};
</script>
<body>
<form:form commandName="currVO" id="detaleList" name="detaleList">
<input type="hidden" name="currSeq" id="currSeq" value="${currVO.currSeq }"/>	
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="교육과정"/>
		            <jsp:param name="dept2" value="교육과정"/>
	           	</jsp:include>
				<p class="sub-title">교육과정</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>교육과정명</th>
								<td>
									<input type="text" class="input-data txt-c w100px" id="currName" name="currName" value="${currVO.currName }" placeholder="한국어교육과정" />
									<input type="text" class="input-data txt-c w100px" id="currCode" name="currCode" value="${currVO.currCode }" placeholder="K01" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<p class="sub-title">상태정보</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:11%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>운영여부</th>
								<td>
									<input type="radio" id="rad01" name="currState" value="Y" <c:if test="${currVO.currState eq 'Y'}"> checked = "checked" </c:if> checked/> <label for="rad01">운영</label> &nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" id="rad02" name="currState" value="N" <c:if test="${currVO.currState eq 'N'}"> checked = "checked" </c:if>/> <label for="rad02">미운영</label>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/curr/admCurrList.do'/>" class="white btn-list">목록</a>
						<button type="button" class="white btn-save" onclick="fn_add()" id="add" >저장</button>
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