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
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0605/ech0605List.do'/>").submit();
	}
	//수정페이지로
	function fn_update(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0605/ech0605Modify.do'/>").submit();
	}
	
	//이메일발송메시지 페이지 삭제
	function fn_delete(){
		if (confirm("이메일발송메시지를 삭제하시겠습니까?")) {
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0605/ech0605Delete.do'/>").submit();
			
		}
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
	            <jsp:param name="dept2" value="이메일발송메시지"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<form:form commandName="searchVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
			<input type="hidden" id="corpCd" name="corpCd" value="${rm1010mVO.corpCd }"/>
			<input type="hidden" id="emailtNo" name="emailtNo" value="${rm1010mVO.emailtNo }"/>
			<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/>
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
                        	<c:out value="${rm1010mVO.title}" />
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">메시지내용</th>
                        <td>
                        	<textarea class="type02" readonly><c:out value="${rm1010mVO.cont}" /></textarea>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">비고</th>
                        <td>
                        	<textarea class="type02" readonly><c:out value="${rm1010mVO.remk}" /></textarea>
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- //발송메시지 -->
            </form:form>
			<!-- 버튼 -->
			<div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">취소</a>
				<a href="#" onclick="fn_delete(); return false;" >삭제</a>
				<a href="#" onclick="fn_update(); return false;" >수정</a>
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