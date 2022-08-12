<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt"	uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javascript">

	// 목록
	function fn_list(pageIndex){
		$("#pageIndex").val(pageIndex);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/enter/brodata/admBroDataList.do'/>").submit();
	}

	// 조회
	function fn_select(bdSeq){
		$("#bdSeq").val(bdSeq);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/enter/brodata/admBroDataView.do'/>").submit();
	}

	// 등록화면
	function fn_modify(bdSeq){
		$("#bdSeq").val(bdSeq);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/enter/brodata/admBroDataModify.do'/>").submit();
	}
	
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="menuType" />
<input type="hidden" id="bdSeq" name="bdSeq"/>
	<div class="wrap">
		<!-- 스킵 네비게이션 -->
		<div id="skip_navigation">
			<ul>
				<li><a href="#gnb">주 메뉴 바로가기</a></li>
				<li><a href="#content">본문 바로가기</a></li>
			</ul>
		</div>
		<!-- header -->
		<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav" />
		<!--// header -->
		<hr />
		<p class="container_top_bg"></p>
		<!-- container -->
		<div class="container">
			<!-- lnb -->
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<!--// lnb -->
			<!-- content -->
			<div class="content" id="content">
				<!-- 타이틀 영역 -->
				<c:import url="/EgovPageLink.do?link=adm/inc/incPageTitle">
					<c:param name="dept1" value="입학안내"/>
					<c:param name="dept2" value="작품자료실"/>
				</c:import>
				<div class="cont_box">
				<!-- content -->
					<div class="tbl_top_side">
						<div class="side_r">
							<ul>
								<li>
									<form:select path="searchCondition1" class="se_base w100">
										<form:option value="title">브로셔명</form:option>
										<form:option value="name">등록자명</form:option>
									</form:select>
								</li>
								<li>
									<form:input path="searchWord" class="in_base w150"/>
								</li>
								<li>
									<a href="#" class="btn_type05 input_btn">검색</a>
								</li>
							</ul>
						</div>
					</div>
					<table class="list_tbl_03" summary="작품자료실 목록">
						<caption>작품자료실</caption>
						<colgroup>
							<col style="width:6%" />
							<col style="width:30%" />
							<col style="width:*" />
							<col style="width:10%" />
							<col style="width:10%" />
						</colgroup>
						<thead>
							<tr class="first">
								<th scope="col">번호</th>
								<th scope="col">브로셔명</th>
								<th scope="col">대표이미지</th>
								<th scope="col">등록자명</th>
								<th scope="col">등록일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${resultList }" var="result" varStatus="status">
								<tr>
									<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
									<td>
										<img src="<c:out value='${pageContext.request.contextPath }/showImage.do?filePath=${result.bdSaveThumbPath }'/>" style="width: 100%;"/>
									</td>
									<td class="ta_left">
										<a href="#" onclick="fn_select(<c:out value='${result.bdSeq }'/>); return false;">
											<c:out value="${result.bdName }" escapeXml="false"/>
										</a>
									</td>
									<td><c:out value="${result.regName }"/></td>
									<td><fmt:formatDate value="${result.regDate }" type="both" pattern="yyyy-MM-dd"/></td>
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
							<a href="#" onclick="fn_modify(); return false;" class="b_type03">글쓰기</a>
						</div>
					</div>
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
<input type="hidden" id="message" name="message" value="${message}" />
</form:form>
</body>
</html>