<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=inc/incHead" />
<script type="text/javascript">

	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/adm/floodCenter/floodControlList.do'/>").submit();
	}
	
	// 저장
	function fn_modify(){
		
		if($("#floodLevel").val() == ""){
			alert("수방단계를 선택해주세요.");
			return false;
		}
		
		if($("#issueDate").val() == ""){
			alert("발령일자를 선택해주세요.");
			return false;
		}
		
		if($("#issueTime1").val() == "" || $("#issueTime2").val() == ""){
			alert("발령시간을 입력해주세요.");
			return false;
		}else{
			if($("#issueTime1").val() < 10 && $("#issueTime1").val() != 0){
				$("#issueTime1").val("0"+parseInt($("#issueTime1").val()));
			}
			if($("#issueTime2").val() < 10 && $("#issueTime2").val() != 0){
				$("#issueTime2").val("0"+parseInt($("#issueTime2").val()));
			}
			$("#issueTime").val($("#issueTime1").val()+":"+$("#issueTime2").val());
		}
		
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/adm/floodCenter/floodControlSubmit.do'/>").submit();
	}
	
</script>
<body>
<form:form commandName="floodControlVO" id="frm" name="frm">
<form:hidden path="floodControlId"/>
<form:hidden path="issueTime"/>
<form:hidden path="regNm"/>
	<!-- top menu - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- top menu - end -->
	<div class="m_body">
		<!-- WEB LEFT_MENU -->
		<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/inc/incLeftnav"/>
		<!--// WEB LEFT_MENU -->
		<div class="main_content">
			<!-- PAGE_TITLE -->
			<div class="page_title">수방단계설정</div>
			<!--// PAGE_TITLE -->
			<div class="content">
				<div class="cont_box">
					<div>
						<div>
							<table class="input_table">
								<colgroup>
									<col width="15%" />
									<col width="85%" />
								</colgroup>
								<tbody>
									<tr>
										<th>*단계</th>
										<td>
											<form:select path="floodLevel" style="text-indent:0;">
												<form:option value="">수방단계</form:option>
												<form:option value="4">평시</form:option>
												<form:option value="5">포트홀</form:option>
												<form:option value="6">보강</form:option>
												<form:option value="1">1단계</form:option>
												<form:option value="2">2단계</form:option>
												<form:option value="3">3단계</form:option>
											</form:select>
										</td>
									</tr>
									<tr>
										<th>*발령일시</th>
										<td>
											<form:input path="issueDate" class="datepicker" style="width:110px;margin-right:10px;" autocomplete="off"/>
											<form:select path="issueTime1" style="width: 50px;margin-right:10px;">
												<c:forEach begin="0" end="23" varStatus="status">
													<c:set var="hour" value="0${status.index }"/>
													<c:if test="${fn:length(hour) eq 3 }"><c:set var="hour" value="${fn:substring(hour, 1, 3) }"/></c:if>
													<form:option value="${hour }">${hour }</form:option>
												</c:forEach>
											</form:select>시
											<form:select path="issueTime2" style="width: 50px;margin-right:10px;">
												<c:forEach begin="0" end="59" varStatus="status">
													<c:set var="hour" value="0${status.index }"/>
													<c:if test="${fn:length(hour) eq 3 }"><c:set var="hour" value="${fn:substring(hour, 1, 3) }"/></c:if>
													<form:option value="${hour }">${hour }</form:option>
												</c:forEach>
											</form:select>분
											<%--
											<input type="text" name="tmpDate" id="tmpDate" value="<c:out value='${floodControlVO.issueDate }'/>" disabled="true"/>&nbsp;&nbsp;
											<input type="text" name="issueTime1" id="issueTime1" value="<c:out value='${issueTime1 }'/>" style="width:32px;"/>&nbsp;시 &nbsp;&nbsp;
											<input type="text" name="issueTime2" id="issueTime2" value="<c:out value='${issueTime2 }'/>" style="width:32px;"/>&nbsp;분
											--%>
										</td>
									</tr>
									<tr>
										<th>작성자</th>
										<td>
											<c:out value="${floodControlVO.regNm }"/>
										</td>
									</tr>
								</tbody>
							</table>
							<div class="btn_box">
								<button class="btn_list" onclick="fn_modify(); return false;">저장</button>
								<button class="btn_list" onclick="fn_list(); return false;">목록</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- footer - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=inc/incFooter"/>
	<!-- footer - end -->
	
<!-- 목록 검색조건 - start -->
<input type="hidden" id="searchCondition1" name="searchCondition1" value="${searchVO.searchCondition1 }">
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }">
<!-- 목록 검색조건 - end -->
</form:form>
</body>
</html>