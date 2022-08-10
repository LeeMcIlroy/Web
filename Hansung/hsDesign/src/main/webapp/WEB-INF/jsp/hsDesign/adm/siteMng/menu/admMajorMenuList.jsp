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
				<h3>전공메뉴관리</h3>
				<div class="navi">
					<span><a href="/">Home</a> &gt; 사이트관리 &gt; 전공메뉴관리 &nbsp;&nbsp;&nbsp;</span>
				</div>
			</div>
			<div class="cont_box">
			<!-- content -->
			<form:form commandName="searchVO" id="frm" name="frm">
				<input type="hidden" id="mmSeq" name="mmSeq"/>
				<div class="tbl_top_side">
					<div class="side_r">
						<ul>
							<li>
								<form:select path="searchCondition1" class="se_base w100" onchange="fn_list('1'); return false;">
									<form:option value="">전체</form:option>
									<c:forEach items="${majorList}" var="major">
										<form:option value="${major.mCode}"><c:out value="${major.mName}"/></form:option>
									</c:forEach>
								</form:select>
								<form:select path="searchCondition2" class="se_base w100"  onchange="fn_list('1'); return false;">
									<form:option value="">전체</form:option>
									<form:option value="Y">사용</form:option>
									<form:option value="N">미사용</form:option>
								</form:select>
							</li>
						</ul>
					</div>
				</div>
				<table class="list_tbl_03" summary="전공메뉴 관리 목록">
					<caption>전공메뉴관리</caption>
					<colgroup>
						<col style="width:8%" />
						<col style="width:25%" />
						<col style="width:20%" />
						<col style="width:30%" />
						<col style="width:9%" />
						<col style="width:9%" />
					</colgroup>
					<thead>
						<tr class="first">
							<th scope="col">번호</th>
							<th scope="col">전공</th>
							<th scope="col">게시판 이름</th>
							<th scope="col">말머리</th>
							<th scope="col">표출순서</th>
							<th scope="col">사용여부</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${resultList }" var="result" varStatus="status">
						<tr onclick="fn_modify('<c:out value='${result.mmSeq}'/>'); return false;" style="cursor: pointer;">
							<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
							<td><c:out value="${result.mName}"/></td>
							<td><c:out value="${result.bcName }"/></td>
							<td><c:out value="${result.bcHeadName }"/></td>
							<td><c:out value="${result.mmSortNum }"/></td>
							<td>
								<c:if test="${result.mmUseYn == 'Y' }">사용</c:if>
								<c:if test="${result.mmUseYn == 'N' }">미사용</c:if>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="btm_area">
					<!-- 페이징 -->
					<div class="pagenate">
						<ui:pagination paginationInfo="${paginationInfo }" type="image" jsFunction="fn_list"/>
						<form:hidden path="pageIndex"/>
					</div>
					<div class="page_btn">
						<a href="#" onclick="fn_modify(0); return false;" class="b_type03">등록</a>
					</div>
				</div>
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
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/menu/admMajorMenuList.do'/>").submit();
	}
	
	// 조회
	function fn_modify(mmSeq){
		$("#mmSeq").val(mmSeq);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/menu/admMajorMenuModify.do'/>").submit();
	}

</script>
</html>