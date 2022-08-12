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
		var ynVal = '<c:out value="${cm4010mVO.useYn}"/>';
			
		if(ynVal == 'Y'){
			$("#stat1").attr('checked', 'checked');
		}else{
			$("#stat2").attr('checked', 'checked');	}
		
		
	});

	//목록으로
	function fn_list(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0708/ech0708List.do'/>").submit();
	}
	
	function fn_save(){
		//$('#noti_content').val(CKEDITOR.instances.noti_content.getData());
		
		var commCode = $('#commCode').val();
		var codeName = $('#codeName').val();
		var useYn = $('#useYn').val();		
		
		if(commCode==''){
			alert('공통코드를 입력해주세요.')
			$('#commCode').focus();
			return;
		}
		
		if(codeName==''){
			alert('코드명을 입력해주세요.')
			$('#codeName').focus();
			return;
		}
		
		if(useYn==''){
			alert('사용여부를 선택해주세요.');
			$('#useYn').focus();
			return;
		}
		
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0708/ech0708Save.do'/>").submit();
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
	            <jsp:param name="dept2" value="공통코드"/>
           	</jsp:include>
			<!-- //타이틀 -->			
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>공통코드분류</h4>
			</div>
			<!-- //서브타이틀 -->
			<form:form commandName="cm4010mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="commCodeNo" name="commCodeNo" value="${cm4010mVO.commCodeNo}">
	            <!-- 공통코드분류 -->
				<table class="tbl_view">
					<colgroup>
						<col style="width:15%" />
						<col style="width:35%" />
						<col style="width:15%" />
						<col style="width:35%" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">분류코드</th>
							<td colspan="3">
								<input type="text" value="<c:out value="${cm4010mVO.commCodeclsNo }" />"  class="input-data" id="commCodeclsNo" name="commCodeclsNo"/>
							</td>							
						</tr>
						<tr>
							<th scope="row">분류명</th>
							<td colspan="3">
								<input type="text" value="<c:out value="${cm4010mVO.commCodeclsName }" />"  class="input-data" id="commCodeclsName" name="commCodeclsName"/>
							</td>							
						</tr>					
						<tr>
							<th scope="row">공통코드</th>
							<td>
								<input type="text" value="<c:out value="${cm4010mVO.commCode }" />"  class="input-data" id="commCode" name="commCode"/>
							</td>
							<th scope="row" class="bl">사용여부</th>
							<td>
								<input type="radio" name="useYn" id="stat1" value="Y" checked="checked" />
							    <label for="stat1">사용</label>
							    <input type="radio" name="useYn" id="stat2" value="N"/>
							    <label for="stat2">미사용</label>
							</td>
						</tr>
						<tr>
							<th scope="row">코드명</th>
							<td>
								<input type="text" value="<c:out value="${cm4010mVO.codeName }" />"  class="input-data" id="codeName" name="codeName"/>
							</td>
							<th scope="row" class="bl">정렬순서</th>
							<td>
								<input type="text" value="<c:out value="${cm4010mVO.ordSeq }" />"  class="input-data" id="ordSeq" name="ordSeq"/>
							</td>							
						</tr>
						<tr>
							<th scope="row">코드설명</th>
							<td colspan="3">
								<input type="text" value="<c:out value="${cm4010mVO.codeDesc }" />"  class="input-data" id="codeDesc" name="codeDesc"/>
							</td>							
						</tr>
						<tr>
							<th scope="row">참조1</th>
							<td>
								<input type="text" value="<c:out value="${cm4010mVO.refer1 }" />"  class="input-data" id="refer1" name="refer1"/>
							</td>
							<th scope="row" class="bl">참조2</th>
							<td>
								<input type="text" value="<c:out value="${cm4010mVO.refer2 }" />"  class="input-data" id="refer2" name="refer2"/>
							</td>
						</tr>
					</tbody>
				</table>
	            <!-- //공통코드분류 -->
			</form:form>
            <!-- 버튼 -->
			<div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">취소</a>
				<a href="#" onclick="fn_save(); return false;" >저장</a>
			</div>
			<!-- //버튼 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- 팝업 -->
	<input type="checkbox" id="modi-pop" class="hidden" />
	<div class="black-pop">&nbsp;</div>
	<!-- 주소찾기 -->
	<div class="modi-popup" id="addrPop">
	</div>
	<!--// 주소찾기 -->
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>