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

	var courName = $("#courName").val();
	var courCode = $("#courCode").val(); 

	if (courName == '' || courName == null) {
		alert('과목명 입력해 주세요');
		$("#courName").focus(); 
	}else if(courCode == '' || courCode == null){
		alert('과목코드 입력해 주세요');
		$("#courCode").focus(); 
	}else{
		confirm("등록 하시겠습니까 ?")
		$('#detaleList').attr("method", "post").attr("action","<c:out value='${pageContext.request.contextPath}/qxsepmny/curr/addCour.do'/>").submit();			
		}
	};
</script>
<body>
<form:form commandName="courVO" id="detaleList" name="detaleList">
<input type="hidden" name="courSeq" id="courSeq" value="${courVO.courSeq }"/>
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="교육과정"/>
		            <jsp:param name="dept2" value="교과목 - 교과목등록"/>
	           	</jsp:include>
				<p class="sub-title">교과목</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>교과목명</th>
								<td>
									<input type="text" class="input-data txt-c w100px" id="courName" name="courName" value="${courVO.courName }" placeholder="한국어1" />
									<input type="text" class="input-data txt-c w100px" id="courCode" name="courCode" value="${courVO.courCode }" placeholder="K01" />
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>프로그램</th>
								<td>
									<select id="courPro" name="courPro">
										<option value="정규과정" <c:if test="${courVO.courPro eq '정규과정' }">selected = "selected"</c:if> >정규과정</option>
										<option value="특별과정" <c:if test="${courVO.courPro eq '특별과정' }">selected = "selected"</c:if> >특별과정</option>
									</select>
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
									<input type="radio" id="rad01" name="courState" value="Y" <c:if test="${courVO.courState eq 'Y'}"> checked = "checked" </c:if> checked /> <label for="rad01">개강</label> &nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" id="rad02" name="courState" value="N" <c:if test="${courVO.courState eq 'N'}"> checked = "checked" </c:if> /> <label for="rad02">폐강</label>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/curr/admCourList.do'/>" class="white btn-list">목록</a>
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