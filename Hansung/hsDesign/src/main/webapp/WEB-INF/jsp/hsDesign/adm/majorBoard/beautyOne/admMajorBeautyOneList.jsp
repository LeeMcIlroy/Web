<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko" >
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javascript">
	
	// 목록
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/beautyOne/admMajorBeautyOneList.do'/>").submit();
	}

	// 조회
	function fn_select(mbSeq){
		$("#mbSeq").val(mbSeq);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/beautyOne/admMajorBeautyOneView.do'/>").submit();
	}
	
	// 등록 & 수정 화면
	function fn_modify(mbSeq){
		$("#mbSeq").val(mbSeq);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/beautyOne/admMajorBeautyOneModify.do'/>").submit();
	}
	
	// 구분1 선택
	function fn_change(){
		$("#menuType option").remove();
		$("#menuType").append("<option value=''>구분2</option>");
		var mmSeq = $("#searchType option:selected").val();
		$.ajax({
			url: "<c:url value='/qxerpynm/majorBoard/admMajorHeadList.do'/>"
			, type: "post"
			, data: "mmSeq="+mmSeq
			, dataType:"json"
			, success: function(data){
				listVO = data.listVO;
								
				$.each(listVO, function(i, result){
					var tags = '';
					tags += "<option value='"+result.bcSeq+"'>"+result.bcName+"</option>";
					$("#menuType").append(tags);
				});
				
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
		
	}
	
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="pageIndex"/>
<input type="hidden" id="mbSeq" name="mbSeq">
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
			<jsp:include page="/WEB-INF/jsp/hsDesign/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="전공"/>
	            <jsp:param name="dept2" value="미용학(one-day)"/>
           	</jsp:include>
			<div class="cont_box">
			<!-- content -->
				<div class="tbl_top_side">
					<div class="side_r">
						<ul>
							<li>
								<form:select path="searchType" class="se_base w100" onchange="fn_change(); return false;">
									<form:option value="">구분1</form:option>
									<c:forEach var="list" items="${boardCode }">
										<form:option value="${list.mmSeq }"><c:out value="${list.bcName }"/></form:option>
									</c:forEach>
								</form:select>
							</li>
							<li>
								<c:if test="${empty searchVO.searchType}">
									<form:select path="menuType" class="se_base w150">
										<form:option value="">구분2</form:option>
									</form:select>
								</c:if>
								<c:if test="${!empty searchVO.searchType }">
									<form:select path="menuType" class="se_base w150">
										<form:option value="">구분2</form:option>
										<c:forEach var="list" items="${headList }">
											<form:option value="${list.bcSeq }"><c:out value="${list.bcName }"/></form:option>
										</c:forEach>
									</form:select>
								</c:if>
							</li>
							<li>
								<form:select path="searchCondition2" class="se_base w100">
									<form:option value="title">제목</form:option>
									<form:option value="content">내용</form:option>
								</form:select>
							</li>
							
							<li>
								<form:input path="searchWord" class="in_base w150"/>
							</li>
							<li>
								<a href="#" class="btn_type05 input_btn" onclick="fn_list(1); return false;">검색</a>
							</li>
						</ul>
					</div>
				</div>
				<table class="list_tbl_03 mt30" summary="미용학(one-day)">
					<caption>미용학(one-day)</caption>
					<colgroup>
						<col style="width:6%" />
						<col style="width:10%" />
						<col style="width:15%" />
						<col style="width:%" />
						<col style="width:10%" />
						<col style="width:10%" />
						<col style="width:6%" />
					</colgroup>
					<thead>
						<tr class="first">
							<th scope="col">번호</th>
							<th scope="col">구분1</th>
							<th scope="col">구분2</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">작성일</th>
							<th scope="col">조회</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${resultList }" var="result" varStatus="status">
							<tr onclick="fn_select(<c:out value="${result.mbSeq}"/>); return false;" style="cursor: pointer;">
								<td>
									<c:if test="${result.mbNoticeYn eq 'N' }">
										<c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/>
									</c:if>
									<c:if test="${result.mbNoticeYn eq 'Y' }">
										공지
									</c:if>
									
								</td>
								<td><c:out value="${result.mbGubun1Name }"/></td>
								<td><c:out value="${result.mbGubun2Name }"/></td>
								<td><c:out value="${result.mbTitle }" escapeXml="false"/></td>
								<td><c:out value="${result.mbRegName }"/></td>
								<td><c:out value="${result.mbRegDate }"/></td>
								<td><c:out value="${result.mbCount }"/></td>
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
						<a href="#" class="b_type03" onclick="fn_modify(); return false;">글쓰기</a>
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
<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>