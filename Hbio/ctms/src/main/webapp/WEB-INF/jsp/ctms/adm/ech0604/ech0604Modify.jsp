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
	//목록으로
	function fn_list(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0604/ech0604List.do'/>").submit();
	}
	
	function fn_update(){
		
		var ynTitle = $('#title').val();
		var ynCont = $('#cont').val();
		
		if(ynTitle==''){
			alert('제목을 입력해주세요.')
			$('#title').focus();
			return;
		}
		if(ynCont==''){
			alert('메시지내용를 입력해주세요.')
			$('#cont').focus();
			return;
		}
		
		$("#detailForm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxsepmny/ech0604/ech0604Update.do'/>").submit();
	}
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>발송관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="발송관리"/>
	            <jsp:param name="dept2" value="SMS발송메시지"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<form:form commandName="rm2010mVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="corpCd" name="corpCd" value="${rm2010mVO.corpCd}">
			<input type="hidden" id="smstNo" name="smstNo" value="${rm2010mVO.smstNo}">
            <!-- 발송메시지 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:85%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">제목</th>
                        <td>
                        	<input type="text" value="<c:out value="${rm2010mVO.title }" />" class="ta_l type02" id="title" name="title"/>                        	
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">메시지내용</th>
                        <td>
                        	<textarea class="type02" id="cont" name="cont"><c:out value="${rm2010mVO.cont }" /></textarea>                        	
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">비고</th>
                        <td>
                        	<textarea class="type02" id="remk" name="remk"><c:out value="${rm2010mVO.remk }" /></textarea>                        	
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- //발송메시지 -->
            </form:form>
			<!-- 버튼 -->
			<div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">취소</a>
				<a href="#" onclick="fn_update(); return false;" >저장</a>
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