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
		var ynVal = '<c:out value="${cm4000mVO.useYn}"/>';
			
		switch (ynVal) {
		case 'Y':
			$("#useYn1").attr('checked', 'checked');
	    	break;
		case 'N':
			$("#useYn2").attr('checked', 'checked');
	    	break;	
	  	default:
	  		$("#useYn1").attr('checked', 'checked');
		}
		
		ynVal = '<c:out value="${cm4000mVO.clsCat}"/>';
		
		switch (ynVal) {
		case '1':
			$("#clsCat1").attr('checked', 'checked');
	    	break;
		case '2':
			$("#clsCat2").attr('checked', 'checked');
	    	break;
		case '3':
			$("#clsCat3").attr('checked', 'checked');
	    	break
	  	default:
	  		$("#clsCat1").attr('checked', 'checked');
		}
	});

	//목록으로
	function fn_list(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0707/ech0707List.do'/>").submit();
	}
	
	function fn_save(){
		//$('#noti_content').val(CKEDITOR.instances.noti_content.getData());
		
		var cd = $('#cd').val();
		var cdName = $('#cdName').val();
		var useYn = $('#useYn').val();
		
		
		if(cd==''){
			alert('공통코드를 입력해주세요.');
			$('#cd').focus();
			return;
		}
		
		if(cdName==''){
			alert('코드명을 입력해주세요.');s
			$('#cdNm').focus();
			return;
		}
		
		if(useYn==''){
			alert('사용여부를 선택해주세요.');
			$('#useYn').focus();
			return;
		}
		
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0707/ech0707Update.do'/>").submit();
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
	            <jsp:param name="dept2" value="공통코드분류"/>
           	</jsp:include>
			<!-- //타이틀 -->			
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>공통코드분류</h4>
			</div>
			<!-- //서브타이틀 -->
			<form:form commandName="cm4000mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="corpCd" name="corpCd" value="${cm4000mVO.corpCd}">
				<input type="hidden" id="dataRegdt" name="dataRegdt" value="${cm4000mVO.dataRegdt}">
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
							<th scope="row">분류카테고리</th>
							<td>
								<input type="radio" name="clsCat" id="clsCat1" value="1" checked="checked" />
							    <label for="clsCat1">대분류</label>
							    <input type="radio" name="clsCat" id="clsCat2" value="2"/>
							    <label for="clsCat2">중분류</label>						
					    	    <input type="radio" name="clsCat" id="clsCat3" value="3"/>
							    <label for="clsCat3">소분류</label>						
							
								<!-- <input type="text" value="<c:out value="${cm4000mVO.clsCat }" />"  class="input-data" id="clsCat" name="clsCat"/> -->
							</td>
							<th scope="row"  class="bl">분류코드</th>
							<td>
								<input type="text" value="<c:out value="${cm4000mVO.cdCls }" />"  class="input-data" id="cdCls" name="cdCls"/>
							</td>
							
						</tr>
						<tr>	
							<th scope="row">공통코드</th>
							<td>
								<input type="text" value="<c:out value="${cm4000mVO.cd }" />"  class="input-data" id="cd" name="cd"/>
							</td>
							<th scope="row" class="bl">사용여부</th>
							<td>
								<input type="radio" name="useYn" id="useYn1" value="Y" checked="checked" />
							    <label for="useYn1">사용</label>
							    <input type="radio" name="useYn" id="useYn2" value="N"/>
							    <label for="useYn2">미사용</label>
							</td>
						</tr>
						<tr>
							<th scope="row">코드명</th>
							<td>
								<input type="text" value="<c:out value="${cm4000mVO.cdName }" />"  class="input-data" id="cdName" name="cdName"/>
							</td>
							<th scope="row" class="bl">정렬순서</th>
							<td>
								<input type="text" value="<c:out value="${cm4000mVO.dspSeq }" />"  class="input-data" id="dspSeq" name="dspSeq"/>
							</td>							
						</tr>
						<tr>
							<th scope="row">코드설명</th>
							<td colspan="3">
								<input type="text" value="<c:out value="${cm4000mVO.cdDesc }" />"  class="input-data" id="cdDesc" name="cdDesc"/>
							</td>							
						</tr>
						<tr>
							<th scope="row">참조1</th>
							<td>
								<input type="text" value="<c:out value="${cm4000mVO.refer1 }" />"  class="input-data" id="refer1" name="refer1"/>
							</td>
							<th scope="row" class="bl">참조2</th>
							<td>
								<input type="text" value="<c:out value="${cm4000mVO.refer2 }" />"  class="input-data" id="refer2" name="refer2"/>
							</td>
						</tr>
						<tr>
						
							<th scope="row">회사코드(자동생성)</th>
							<td colspan="3">
								<c:out value="${cm4000mVO.corpCd }" />
							</td>
						<tr>				
							<th scope="row">등록수정일자</th>
							<td>
								<!-- <input type="text" value="<c:out value="${cm4000mVO.dataRegdt }" />"  class="input-data" id="dataRegdt" name="dataRegdt"/> -->
								<c:out value="${cm4000mVO.dataRegdt }" />
							</td>
							<th scope="row" class="bl">등록수정자</th>
							<td>
								<c:out value="${cm4000mVO.dataRegnt }" />
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