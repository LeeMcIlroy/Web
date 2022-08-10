
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
		
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/teacher/admMajorTeacherList.do'/>").submit();
	}
	
	function fn_list2(pageNo, searchCondition1){
		$("#pageIndex").val(pageNo);
		$("#searchCondition1").val(searchCondition1);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/teacher/admMajorTeacherList.do'/>").submit();
	}

	// 등록 & 수정 화면
	function fn_modify(tcSeq){
		$("#tcSeq").val(tcSeq);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/teacher/admMajorTeacherModify.do'/>").submit();
	}
	
	// 삭제
	function fn_delete(tcSeq){
		if(confirm("삭제 하시겠습니까?")){
			$("#tcSeq").val(tcSeq);
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/teacher/admMajorTeacherDelete.do'/>").submit();
		}
	}
	
	
	
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="pageIndex"/>
<form:hidden path="searchCondition1"/>
<form:hidden path="menuType"/>
<input type="hidden" id="tcSeq" name="tcSeq">
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
	            <jsp:param name="dept2" value="교수소개"/>
           	</jsp:include>
			<div class="cont_box">
			<!-- content -->
				<div class="mid_tab07 mt20">
					<ul>
						<c:forEach var="list" items="${majorList }">
							<c:if test="${list.mCode < 10 }">
								<li>
									<a style="cursor: pointer;" <c:if test="${list.mCode eq searchVO.searchCondition1 }">class="active"</c:if> onclick="fn_list2(1,'<c:out value='${list.mCode }'/>'); return false;"><c:out value="${list.mName }"/></a>
								</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
				<div class="tbl_top_side">
					<div class="side_r">
						<ul>
							<%-- 
							<li>
								<form:select path="searchCondition1" class="se_base w100">
									<form:option value="">전체</form:option>
									<c:forEach var="list" items="${majorList }">
										<form:option value="${list.mCode }"><c:out value="${list.mName }"/></form:option>
									</c:forEach>
								</form:select>
							</li>
							 --%>
							<li>
								<form:select path="searchCondition2" class="se_base w100">
									<form:option value="">전공분야</form:option>
									<c:choose>
										<c:when test="${searchVO.searchCondition1 eq '02' }">
											<form:option value='시각 패키지디자이너'>시각 패키지디자이너</form:option>
											<form:option value='광고/브랜드디자이너'>광고/브랜드디자이너</form:option>
											<form:option value='일러스트레이션 전문가'>일러스트레이션 전문가</form:option>
											<form:option value='웹 UI/UX 디자이너'>웹 UI/UX 디자이너</form:option>
										</c:when>
										<c:when test="${searchVO.searchCondition1 eq '03' }">
											<form:option value='제품·자동차디자인'>제품·자동차디자인</form:option>
											<form:option value='리빙디자인'>리빙디자인</form:option>
											<form:option value='주얼리디자인'>주얼리디자인</form:option>
											<form:option value='제품·리빙디자인'>제품·리빙디자인</form:option>
											<form:option value='자동차디자인'>자동차디자인</form:option>
										</c:when>
										<c:when test="${searchVO.searchCondition1 eq '04' }">
											<form:option value='영상디자인'>영상디자인</form:option>
											<form:option value='디지털애니메이션 전문가'>디지털애니메이션 전문가</form:option>
											<form:option value='만화/컨텐츠디자이너'>만화/컨텐츠디자이너</form:option>
											<form:option value='게임일러스트레이션 전문가'>게임일러스트레이션 전문가</form:option>
										</c:when>
										<c:when test="${searchVO.searchCondition1 eq '05' }">
											<form:option value='패션디자인'>패션디자인</form:option>
											<form:option value='패션스타일링'>패션스타일링</form:option>
											<form:option value='패션소재/텍스타일 디자인'>패션소재/텍스타일 디자인</form:option>
											<form:option value='패션마케팅'>패션마케팅</form:option>
											<form:option value='패션기획&연출'>패션기획&연출</form:option>
											<form:option value='패션창업'>패션창업</form:option>
										</c:when>
										
										<%-- 200417 수정																					 
										<c:when test="${searchVO.searchCondition1 eq '06' }">
											<form:option value='패션마케팅'>패션마케팅</form:option>
											<form:option value='패션기획&연출'>패션기획&연출</form:option>
											<form:option value='패션창업'>패션창업</form:option>
										</c:when>--%>
	
										<c:when test="${searchVO.searchCondition1 eq '07' }">
											<form:option value='헤어디자인'>헤어디자인</form:option>			
											<form:option value='메이크업디자인'>메이크업디자인</form:option>			
											<form:option value='피부디자인'>피부디자인</form:option>
											<form:option value='네일디자인'>네일디자인</form:option>			
																							
										</c:when>
										<c:when test="${searchVO.searchCondition1 eq '08' }">
											<form:option value='헤어디자인'>헤어디자인</form:option>			
											<form:option value='메이크업디자인'>메이크업디자인</form:option>			
											<form:option value='피부디자인'>피부디자인</form:option>
											<form:option value='네일디자인'>네일디자인</form:option>	
										
										</c:when>
										<c:otherwise>
											<form:option value='인테리어디자인'>인테리어디자인</form:option>");
											<form:option value='가구디자인'>가구디자인</form:option>");
											<form:option value='건축공간디자인'>건축공간디자인</form:option>");
											<form:option value='부동산브랜드마케팅'>부동산브랜드마케팅</form:option>");
											<form:option value='특강강사'>특강강사 </form:option>");
										</c:otherwise>
									</c:choose>
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
				<table class="list_tbl_03 mt30" summary="교수소개 목록">
					<caption>교수소개 목록</caption>
					<colgroup>
						<col style="width:5%" />
						<col style="width:10%" />
						<col style="width:45%" />
						<col style="width:20%" />
						<col style="width:20%" />
					</colgroup>
					<thead>
						<tr class="first">
							<th scope="col">번호</th>
							<th scope="col">노출순서</th>
							<th scope="col">전공분야</th>
							<th scope="col">이름</th>
							<th scope="col">수정/삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${resultList }" var="result" varStatus="status">
							<tr>
								<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
								<td><c:out value="${result.turn }"/></td>
								<td><c:out value="${result.tcSubject }"/></td>
								<td><c:out value="${result.tcName }"/></td>
								<td>
									<div class="btn_box">
										<a href="#"  class="b_type04" onclick="fn_modify(<c:out value='${result.tcSeq }'/>); return false;">수정</a>
										<a href="#"  class="b_type03" onclick="fn_delete(<c:out value='${result.tcSeq }'/>); return false;">삭제</a>
									</div>
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