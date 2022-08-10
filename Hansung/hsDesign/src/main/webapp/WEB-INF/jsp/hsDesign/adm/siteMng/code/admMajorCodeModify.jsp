<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>한성대학교 디자인아트 교육원</title>
<!-- header -->
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<!--// header -->
</head>
<body>
<div class="wrap">
	<!-- topnav -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav" />
	<!-- topnav -->
	<hr />
	<p class="container_top_bg"></p>
	<!-- container -->
	<div class="container">
		<!-- lnb -->
		<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu" />
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<!-- 타이틀 영역 -->
			<div class="title_area">
				<h3>코드관리</h3>
				<div class="navi">
					<span><a href="/">Home</a> &gt; 사이트관리 &gt; 코드관리 &nbsp;&nbsp;&nbsp;</span>
				</div>
			</div>
			<div class="cont_box">
			<!-- content -->
			<form:form commandName="codeVO" id="frm" name="frm">
			<form:hidden path="bcSeq"/>
				<!-- table -->
				<table class="view_tbl_03 mb30" summary="코드관리">
					<caption>코드관리</caption>
					<colgroup>
						<col width="20%" />
						<col width="80%" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">코드명</th>
							<td>
								<form:input path="bcName"  class="in_base" style="width:80%;" />
							</td>
						</tr>
						<tr>
							<th scope="row">코드구분</th>
							<td>
								<form:select path="bcType" class="se_base w100">
									<form:option value="A">공통</form:option>
									<form:option value="B">게시판이름</form:option>
									<form:option value="H">말머리</form:option>
								</form:select>
							</td>
						</tr>
						<tr>
							<th scope="row">사용여부</th>
							<td>
								<form:select path="bcUseYn" class="se_base w100">
									<form:option value="Y">사용</form:option>
									<form:option value="N">미사용</form:option>
								</form:select>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btn_box">
					<div class="btn_r">
						<a href="#" onclick="fn_save(); return false;" class="b_type04">저장</a>
						<a href="#" onclick="fn_list(); return false;" class="b_type03">목록</a>
					</div>
				</div>
				<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex }'/>"/>
				<input type="hidden" name="searchType" value="<c:out value='${searchVO.searchType }'/>"/>
				<input type="hidden" name="searchWord" value="<c:out value='${searchVO.searchWord }'/>"/>
			</form:form>
			<!-- //content -->
			</div>
		</div>
		<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter" />
	<!--// footer -->
</div>
<input type="hidden" id="message" value="${message}" />
</body>
<script type="text/javascript">
	
	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/code/admMajorCodeList.do'/>").submit();
	}
	
	// 등록&수정
	function fn_save(){
		if($("#bcName").val() == ''){
			alert("코드명을 입력해주세요.");
			return false;
		}
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/code/admMajorCodeUpdate.do'/>").submit();
	}

</script>
</html>