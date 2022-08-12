<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>
<script type="text/javascript">
	function fn_setAuthNo(){
		var name = $("#user_Name").val();
		var hpNo = $("#user_phone").val();
		if(confirm('인증번호를 핸드폰번호로 수신 하시겠습니까?')){
			$.ajax({
				url: "<c:url value='/usr/login/sendAjaxSetAuthNoId.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"hpNo="+hpNo+"&"+"name="+name
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
	
	function fn_login(){
		$("#listForm").attr("action", "<c:url value='/usr/login/loginView.do'/>").submit();
	}
	
	
	
</script>
<body>
<!-- wrap -->
<div class="com_wrap">
	<h1>H&amp;Bio</h1>
	<div class="com_top">
		<h2>아이디 목록</h2>
		하단 등록된 아이디를 확인하세요
	</div>
	<form:form commandName="searchVO" id="listForm" name="listForm">
		<input type="hidden" id="corpCd" name="corpCd">
		<input type="hidden" id="rsjNo" name="rsjNO">
	<!-- 정보입력 -->
	<div class="com_reg">
	<!-- 목록 -->
		<table class="tbl_list tr_link">
			<colgroup>
				<col style="width:50%" />
				<col style="width:auto" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">아이디</th>
					<th scope="col">등록일자</th>			
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">			
				<tr>
					<td><c:out value="${result.userId }"/></td>
					<td><c:out value="${result.regDt }"/></td>
				</tr>
			</c:forEach>
			<c:if test="${resultList.size() == 0 }">
				<tr>
					<td class="nodata" colspan="2">등록된 아이디 정보가 없습니다.</td>
				</tr>
			</c:if>
			</tbody>
		</table>
		</form:form>
		<div>
			<ul>
				<li><a href="<c:out value='${pageContext.request.contextPath }/usr/login/joinMem.do'/>">회원가입</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/usr/login/searchPw.do'/>">비밀번호 찾기</a></li>
			</ul>
		</div>
		<a href="#" onclick="fn_login();">로그인</a>
	</div>
	<!-- //정보입력 -->
	<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
</div>
<!-- //wrap -->
</body>
</html>
