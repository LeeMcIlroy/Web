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
		
		var ynClsCat = '<c:out value="${cm4000mVO.clsCat}"/>';
		switch (ynClsCat) {
			case '1':
				$("#clsCat1").attr('checked', 'checked');
		    	break;
			case '2':
				$("#clsCat2").attr('checked', 'checked');
		    	break;
			case '3':
				$("#clsCat3").attr('checked', 'checked');
		    	break;
		  	default:
		     	console.log(`Sorry, we are out of ${expr}.`);
		}
	});
	
	//목록으로
	function fn_list(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0707/ech0707List.do'/>").submit();
	}
	
	//수정페이지로
	function fn_update(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0707/ech0707Modify.do'/>").submit();
	}
	
	//공지 페이지 삭제
	function fn_delete(){
		if (confirm("공통코드분류 정보를 삭제하시겠습니까?")) {
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0707/ech0707Delete.do'/>").submit();
			
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
	            <jsp:param name="dept2" value="공통코드분류"/>
           	</jsp:include>
			<!-- //타이틀 -->			
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>공통코드분류</h4>
			</div>
			<!-- //서브타이틀 -->
			<form:form commandName="searchVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="corpCd" name="corpCd" value="${cm4000mVO.corpCd }"/>
			<input type="hidden" id="cdCls" name="cdCls" value="${cm4000mVO.cdCls }"/>
			<input type="hidden" id="cd" name="cd" value="${cm4000mVO.cd }"/>
			<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/>
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
							<input type="radio" name="clsCat" id="clsCat1" value="1" checked="checked" readonly />
							<label for="clsCat1">대분류</label>
							<input type="radio" name="clsCat" id="clsCat2" value="2" readonly />
							<label for="clsCat2">중분류</label>
							<input type="radio" name="clsCat" id="clsCat3" value="3" readonly />
							<label for="clsCat3">소분류</label>
						</td>
						<th scope="row" class="bl">코드분류</th>
						<td>
							<c:out value="${cm4000mVO.cdCls}" />
						</td>
					</tr>
					<tr>
						<th scope="row">공통코드</th>
						<td>
							<c:out value="${cm4000mVO.cd}" />
						</td>
						<th scope="row" class="bl">사용여부</th>
						<td>
							<c:out value="${cm4000mVO.useYn}" />
						</td>
					</tr>
					<tr>
						<th scope="row">코드명</th>
						<td>
							<c:out value="${cm4000mVO.cdName}" />
						</td>
						<th scope="row" class="bl">정렬순서</th>
						<td>
							<c:out value="${cm4000mVO.dspSeq}" />
						</td>
					</tr>
					<tr>
						<th scope="row">설명</th>
						<td colspan="3">
							<c:out value="${cm4000mVO.cdDesc}" />
						</td>
					</tr>
					<tr>
						<th scope="row">참조1</th>
						<td>
							<c:out value="${cm4000mVO.refer1}" />
						</td>
						<th scope="row" class="bl">참조2</th>
						<td>
							<c:out value="${cm4000mVO.refer2}" />
						</td>
					</tr>
					<tr>
						<th scope="row">회사코드</th>
						<td colspan="3">
							<c:out value="${cm4000mVO.corpCd}" />
						</td>
					</tr>
					<tr>				
						<th scope="row">등록수정일자</th>
						<td>
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