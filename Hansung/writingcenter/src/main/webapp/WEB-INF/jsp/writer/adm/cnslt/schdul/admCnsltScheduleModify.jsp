<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="egovframework.com.cmm.util.EgovUserDetailsHelper" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javascript">
	
	$(function(){
		$("#regId").change(function(){
			var regName = $("#regId option:selected").text();
			$("#regName").val(regName);
		});
	});
	
	// 등록&수정
	function fn_update(){
		
		if($("#schdulStartDate").val() == ''){
			alert("상담일자를 선택해주세요.");
			return false;
	<c:if test="${empty cnsltScheduleVO.schSeq }">
		}else if($("#schdulStartDate").val() > $("#schdulEndDate").val()){
			alert("종료일이 시작일보다 과거에 있습니다.\n종료일을 다시 선택해주세요.");
			return false;
		<c:if test="${sessionScope.adminSession.memLevel eq 1 }">
			}else if($("#regId").val() == ''){
				alert("상담교수를 선택해주세요.");
				return false;
		</c:if>
	</c:if>
		}
		
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/cnslt/schdul/admCnsltScheduleUpdate.do'/>").submit();
	}
	
	// 삭제
	function fn_delete(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/cnslt/schdul/admCnsltScheduleDelete.do'/>").submit();
	}
	
	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/cnslt/schdul/admCnsltScheduleList.do'/>").submit();
	}
	
</script>
<body>
<form:form commandName="cnsltScheduleVO" id="frm" name="frm">
<input type="hidden" id="searchType" name="searchType" value="<c:out value="${searchVO.searchType}" />"/>
<form:hidden path="schSeq" />
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
		<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu" />
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<!-- 타이틀 영역 -->
			<jsp:include page="/WEB-INF/jsp/writer/adm/inc/incPageTitle.jsp">
            	<jsp:param name="dept1" value="상담"/>
            	<jsp:param name="dept2" value="상담일정"/>
            </jsp:include>
			<div class="cont_box">
			<!-- content -->
				<table class="view_tbl_03 mb30" summary="상담일정 등록">
					<caption>상담일정</caption>
					<colgroup>
						<col width="20%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">상담일자</th>
							<td>
								<c:if test="${empty cnsltScheduleVO.schSeq && empty cnsltScheduleVO.schdulStartDate}">
									<form:input path="schdulStartDate" class="datepicker w100" readonly="true"/> 
									&nbsp;~&nbsp;
									<form:input path="schdulEndDate" class="datepicker w100" readonly="true"/>
								</c:if>
								<c:if test="${empty cnsltScheduleVO.schSeq && !empty cnsltScheduleVO.schdulStartDate}">
									<form:input path="schdulStartDate" class="datepicker w100" readonly="true"/> 
								</c:if>
								<c:if test="${!empty cnsltScheduleVO.schSeq }">
									<form:input path="schYmd" class="datepicker w100" readonly="true"/> 
								</c:if>
							</td>
						</tr>
						<tr>
							<th scope="row">상담시간</th>
							<td>
								<p>
									<form:select path="schHh" class="se_base w100 mb10">
										<c:forEach begin="0" end="23" varStatus="status">
											<c:set value="0${status.index }" var="Hh"/>
											<c:if test="${fn:length(Hh) eq 3 }">
												<c:set value="${status.index }" var="Hh"/>
											</c:if>
											<form:option value="${Hh }">${Hh }시</form:option>
										</c:forEach>
									</form:select>
									<form:select path="schMi" class="se_base w100 mb10">
										<form:option value="00">00분</form:option>
										<form:option value="10">10분</form:option>
										<form:option value="20">20분</form:option>
										<form:option value="30">30분</form:option>
										<form:option value="40">40분</form:option>
										<form:option value="50">50분</form:option>
									</form:select>
								</p>
							</td>
						</tr>
						<c:if test="${sessionScope.adminSession.memLevel eq 1 }">
							<tr>
								<th scope="row">상담교수</th>
								<td>
									<p>
										<form:select path="regId" class="se_base w100 mb10">
											<form:option value="">선택</form:option>
											<c:forEach items="${memList }" var="mem">
												<form:option value="${mem.memCode }"><c:out value="${mem.memName }"/></form:option>
											</c:forEach>
										</form:select>
										<form:hidden path="regName" />
									</p>
								</td>
							</tr>
						</c:if>
					</tbody>
				</table>
				<div class="btn_box">
					<div class="btn_r">
						<c:if test="${empty cnsltScheduleVO.schSeq }">
							<a href="#" class="b_type01" onclick="fn_update(); return false;">저장</a>
						</c:if>
						<c:if test="${!empty cnsltScheduleVO.schSeq }">
							<a href="#" class="b_type01" onclick="fn_update(); return false;">수정</a>
							<c:if test="${cnsltScheduleVO.aplyYn eq 'N' }">
								<a href="#" class="b_type02" onclick="fn_delete(); return false;">삭제</a>
							</c:if>
						</c:if>
						<a href="#" class="b_type03" onclick="fn_list(); return false;">목록</a>
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

</form:form>
</body>
</html>