<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javascript">

	// 등록&수정
	function fn_update(){
		
		if($.trim($("#grName").val()) == ""){
			alert("이름을 입력해주세요.");
			return false;
		}else if($.trim($("#grAftSchool").val()) == ""){
			alert("편입대학&대학원을 입력해주세요.");
			return false;
		}
		else if($.trim($("#grRegSemesterBegin").val()) == "" || $.trim($("#grRegSemesterEnd").val()) == ""){
			alert("등록학기를 입력해주세요.");
			return false;
		}
		/* 
		else if($.trim($("#grActivity").val()) == ""){
			alert("활동을 입력해주세요.");
			return false;
		}
		 */
		
		else if($.trim($("#grResult").val()) == ""){
			alert("결과(취업,진학)을 입력해주세요.");
			return false;
		}
		
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/qxerpynm/enter/graduateReview/admGraduateReviewUpdate.do'/>").submit();
	}
	
	// 목록
	function fn_list(){
		$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxerpynm/enter/graduateReview/admGraduateReviewList.do'/>").submit();
	}
	
	// 삭제
	function fn_delete(){
		if(confirm("삭제하시겠습니까?")){
			$("#frm").attr("action", "<c:out value='${pageContext.request.contextPath}/qxerpynm/enter/graduateReview/admGraduateReviewDelete.do'/>").submit();
			
		}
	}
	
	
</script>
<body>
<form:form commandName="graduateReviewVO" id="frm" name="frm" enctype="multipart/form-data">
<form:hidden path="grSeq" />
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
					<c:param name="dept2" value="편입성공사례"/>
				</c:import>
				<div class="cont_box">
				<!-- content -->
					<!-- table -->
					<div class="tbl_top_area2 mt30">
						<div class="btn_r">
							* 는 필수 입력항목입니다.
						</div>
					</div>
					<table class="view_tbl_03 mb30" summary="편입성공사례">
						<caption>편입성공사례</caption>
						<colgroup>
							<col width="20%" />
							<col width="80%" />
						</colgroup>
						<tbody>
							<tr class="first">
								<th scope="row">학과 구분</th>
								<td>
									<form:select path="grMajor" class="se_base w150">
										<c:forEach var="list" items="${majorList }">
											<c:if test="${searchVO.menuType eq list.mCode }" > 
												<form:option value="${list.mCode }" selected = "selected"  ><c:out value="${list.mName }"/></form:option>
											</c:if>
											<c:if test="${searchVO.menuType ne list.mCode }" > 
												<form:option value="${list.mCode }" ><c:out value="${list.mName }"/></form:option>
											</c:if>
										</c:forEach>
									</form:select>
								</td>
							</tr>
							<tr>
								<th scope="row">* 이름</th>
								<td><form:input path="grName" class="in_base" style="width:80%;"/> </td>
							</tr>
							<tr>
								<th scope="row">* 대학원&편입대학</th>
								<td>
									<form:input path="grAftSchool" class="in_base" style="width:80%;"/>
								</td>
							</tr>
							<tr>
								<th scope="row">등록학기</th>
								<td><form:input path="grRegSemesterBegin"/> ~ <form:input path="grRegSemesterEnd" /></td>
							</tr>
							<tr>
								<th scope="row">* 활동</th>
								<td>
									<textarea id="grActivity" name="grActivity" style="width:100%;height: 250px;margin-top: 5px;margin-bottom: 5px;ime-mode:active;"><c:out value='${graduateReviewVO.grActivity}' escapeXml="false"/></textarea>
									<%--
									<form:textarea path="grActivity" cols="5" rows="5" style="width:80%; height:200px;" />
									--%>
								</td>
							</tr>
							<tr>
								<th scope="row">* 결과(취업센터)</th>
								<td>
									<form:input path="grResult" class="in_base" style="width:80%;"/>
								</td>
							</tr>
							<tr>
								<th scope="row">편입후기</th>
								<td>
									<form:input path="grUrl" class="in_base" style="width:80%;" />
									<div class="alt_txt">HTTP를 포함해 전체 주소를 입력해 주세요</div>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" onclick="fn_update(); return false;" class="b_type04">저장</a>
							<c:if test="${!empty graduateReviewVO.grSeq }">
								<a href="#" onclick="fn_delete(); return false;" class="b_type02">삭제</a>
							</c:if>
							<a href="#" onclick="fn_list(); return false;" class="b_type03">목록</a>
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
	
<!-- 목록 검색 조건 -->
<input type="hidden" id="menuType" name="menuType" value="${searchVO.menuType }"/>
<input type="hidden" id="searchCondition1" name="searchCondition1" value="${searchVO.searchCondition1 }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<!--// 목록 검색 조건 -->
</form:form>
</body>
</html>