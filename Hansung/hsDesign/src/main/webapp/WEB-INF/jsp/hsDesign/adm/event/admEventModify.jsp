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
				<h3>행사참가신청</h3>
				<div class="navi">
					<span><a href="/">Home</a> &gt; 진로&교양과정 &gt; 행사참가신청 &nbsp;&nbsp;&nbsp;</span>
				</div>
			</div>
			<div class="cont_box">
			<!-- content -->
			<form:form commandName="eventVO" id="frm" name="frm">
			<form:hidden path="eveSeq"/>
				<!-- table -->
				<table class="view_tbl_03 mb30" summary="행사참가신청">
					<caption>행사참가신청</caption>
					<colgroup>
						<col width="15%" />
						<col width="35%" />
						<col width="15%" />
						<col width="35%" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">참가 행사명</th>
							<td colspan="3"><c:out value="${eventVO.eveEvname }"/></td>
						</tr>
						<tr>
							<th scope="row">이름</th>
							<td><c:out value="${eventVO.eveName }"/></td>
							<th scope="row">행사회차</th>
							<td><c:out value="${eventVO.eveNum }"/>회차</td>
						</tr>
						<tr>
							<th scope="row">연락처</th>
							<td><c:out value="${eventVO.eveTel }"/></td>
							<th scope="row">이메일</th>
							<td><c:out value="${eventVO.eveEmail }"/></td>
						</tr>
						<c:if test="${!(eventVO.eveQues1 eq '') }">
						<tr>
							<td colspan="4" style="padding: 15px;"><form:textarea path="eveQues1" class="in_base" style="width:100%; height:80px;" readonly="true" /></td>
						</tr>
						</c:if>
						<c:if test="${!(eventVO.eveQues2 eq '') }">
						<tr>
							<td colspan="4" style="padding: 15px;"><form:textarea path="eveQues2" class="in_base" style="width:100%; height:80px;" readonly="true" /></td>
						</tr>
						</c:if>
						<c:if test="${!(eventVO.eveQues3 eq '') }">
						<tr>
							<td colspan="4" style="padding: 15px;"><form:textarea path="eveQues3" class="in_base" style="width:100%; height:80px;" readonly="true" /></td>
						</tr>
						</c:if>
						<c:if test="${!(eventVO.eveQues4 eq '') }">
						<tr>
							<td colspan="4" style="padding: 15px;"><form:textarea path="eveQues4" class="in_base" style="width:100%; height:80px;" readonly="true" /></td>
						</tr>
						</c:if>
						<c:if test="${!(eventVO.eveQues5 eq '') }">
						<tr>
							<td colspan="4" style="padding: 15px;"><form:textarea path="eveQues5" class="in_base" style="width:100%; height:80px;" readonly="true" /></td>
						</tr>
						</c:if>
						<tr>
							<th scope="row">입금자명</th>
							<td><c:out value="${eventVO.eveDepoName }"/></td>
							<th scope="row">입금날짜</th>
							<td><c:out value="${eventVO.eveDepoDate }"/></td>
						</tr>
						<tr>
							<th scope="row">환불계좌</th>
							<td <c:if test="${eventVO.eveCancelYn eq 'N' }">colspan="3"</c:if>><c:out value="${eventVO.eveRefundAcnm }"/> [<c:out value="${eventVO.eveRefundBank }"/>]</td>
							<c:if test="${eventVO.eveCancelYn eq 'Y' }">
							<th scope="row">취소날짜</th>
							<td><c:out value="${eventVO.eveCancelDate }"/></td>
							</c:if>
						</tr>
						<tr>
							<th scope="row">입금여부</th>
							<td <c:if test="${eventVO.eveCancelYn eq 'N' }">colspan="3"</c:if>>
								<form:select path="eveDepoYn" class="se_base w150">
									<form:option value="Y">입금</form:option>
									<form:option value="N">미입금</form:option>
								</form:select>
							</td>
							<c:if test="${eventVO.eveCancelYn eq 'Y' }">
								<th scope="row">환불여부</th>
								<td>
									<form:select path="eveRefundYn" class="se_base w150">
										<form:option value="Y">환불</form:option>
										<form:option value="N">미환불</form:option>
									</form:select>
								</td>
							</c:if>
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
				<input type="hidden" name="menuType" value="<c:out value='${searchVO.menuType }'/>"/>
				<input type="hidden" name="searchCondition1" value="<c:out value='${searchVO.searchCondition1 }'/>"/>
				<input type="hidden" name="searchCondition2" value="<c:out value='${searchVO.searchCondition2 }'/>"/>
				<input type="hidden" name="searchCondition3" id="searchCondition3" value="<c:out value='${searchVO.searchCondition3 }'/>"/>
				<input type="hidden" name="searchWord" value="<c:out value='${searchVO.searchWord }'/>"/>
				
				<input type="hidden" id="befEveDepoYn" value="<c:out value='${eventVO.eveDepoYn }'/>"/>
				<input type="hidden" id="eveCancelYn" value="<c:out value='${eventVO.eveCancelYn }'/>"/>
				<c:if test="${eventVO.eveCancelYn eq 'Y' }">
					<input type="hidden" id="befEveRefundYn" value="<c:out value='${eventVO.eveRefundYn }'/>"/>
				</c:if>
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
<script type="text/javascript">
	if($("#eveQues1").val() != null) var ques1 = $("#eveQues1").val().split("/");
	if($("#eveQues2").val() != null) var ques2 = $("#eveQues2").val().split("/");
	if($("#eveQues3").val() != null) var ques3 = $("#eveQues3").val().split("/");
	if($("#eveQues4").val() != null) var ques4 = $("#eveQues4").val().split("/");
	if($("#eveQues5").val() != null) var ques5 = $("#eveQues5").val().split("/");
	
	if($("#eveQues1").val() != null){
		$("#eveQues1").before(ques1[0]+"<br/>");
		$("#eveQues1").val(ques1[1]);
	}
	if($("#eveQues2").val() != null){
		$("#eveQues2").before(ques2[0]+"<br/>");
		$("#eveQues2").val(ques2[1]);
	}
	if($("#eveQues3").val() != null){
		$("#eveQues3").before(ques3[0]+"<br/>");
		$("#eveQues3").val(ques3[1]);
	}
	if($("#eveQues4").val() != null){
		$("#eveQues4").before(ques4[0]+"<br/>");
		$("#eveQues4").val(ques4[1]);
	}
	if($("#eveQues5").val() != null){
		$("#eveQues5").before(ques5[0]+"<br/>");
		$("#eveQues5").val(ques5[1]);
	}
	
	// 목록
	function fn_list(){
		if($("#eveCancelYn").val() == 'Y') {
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/event/admEventCancelList.do'/>").submit();
		}else{
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/event/admEventList.do'/>").submit();
		}
	}
	
	// 등록&수정
	function fn_save(){
		if($("#befEveDepoYn").val() == $("#eveDepoYn").val() && $("#befEveRefundYn").val() == $("#eveRefundYn").val()){
			alert("변경된 내용이 없습니다.");
			return false;
		}
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/event/admEventDepoYnUpdate.do'/>").submit();
	}
	
</script>
</body>
</html>