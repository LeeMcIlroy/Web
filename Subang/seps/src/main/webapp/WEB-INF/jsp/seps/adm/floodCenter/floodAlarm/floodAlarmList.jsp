<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=inc/incHead" />
<script type="text/javascript">
	//검색
	function fn_list(pageNo){
		$('#pageIndex').val(pageNo);
		$('#frm').attr('method', 'post').attr('action', '<c:out value="${pageContext.request.contextPath}/adm/floodCenter/floodAlarmList.do"/>').submit();
	}
	
	//삭제
	function fn_delete(searchCode, searchType){
		var flag = confirm("삭제하시겠습니까?");
		if(flag){
			$('#searchCode').val(searchCode);
			$('#searchType').val(searchType);
			$('#frm').attr('method', 'post').attr('action', '<c:out value="${pageContext.request.contextPath}/adm/floodCenter/floodAlarmDelete.do"/>').submit();
		}
	}

	//달력 출력
	$(function() {
		
		//날짜 선택
		$( "#startDate" ).datepicker({
			showOn: "button",
			buttonImage: "<c:url value='/assets/img/icon_calendar.jpg'/>",
			buttonImageOnly: true,
			buttonText: "날짜선택",
			dateFormat: "yy-mm-dd",
			onClose: function( selectedDate ) {
				$( "#endDate" ).datepicker( "option", "minDate", selectedDate );
			}
		});
		
		$( "#endDate" ).datepicker({
			showOn: "button",
			buttonImage: "<c:url value='/assets/img/icon_calendar.jpg'/>",
			buttonImageOnly: true,
			buttonText: "날짜선택",
			dateFormat: "yy-mm-dd",
			onClose: function( selectedDate ) {
				$( "#startDate" ).datepicker( "option", "maxDate", selectedDate );
			}
		});
	});
	
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="searchCode"/>
<form:hidden path="searchType"/>
	<!-- top menu - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- top menu - end -->
	<div class="m_body">
		<!-- WEB LEFT_MENU -->
		<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/inc/incLeftnav"/>
		<!--// WEB LEFT_MENU -->
		<div class="main_content">
			<!-- PAGE_TITLE -->
			<div class="page_title">기간별알람현황</div>
			<!--// PAGE_TITLE -->
			<div class="content">
				<fieldset>
					<legend>검색하기</legend>

					<div class="top_sh_box">
						<div class="sh_box02">
							<form:select path="searchCondition1" style="text-indent:0;">
								<form:option value="">전체</form:option>
								<form:option value="wl">수위</form:option>
								<form:option value="FC">수방단계</form:option>
								<form:option value="K">SNS공유</form:option>
								<form:option value="D">수방근무현황</form:option>
								<form:option value="NC">특보코드</form:option>
							</form:select>
							<form:input path="startDate" type="text" style="width:95px; margin-right: 5px;" autocomplete="off"/>
							~
							<form:input path="endDate" type="text" style="width:95px; margin-right: 5px;" autocomplete="off"/>
							&nbsp;
							<div class="btn_sh03"><button onclick="fn_list(1); return false;">검색</button></div>
						</div>
					</div>
				</fieldset>
				<div class="cont_box white_bg">
					<!-- 단일 GRAPH_BOX -->
					<div class="box_div_1" style="margin-bottom:0;">
						<div>
							<!-- box graph table -->
							<table class="box_table_t01">
								<colgroup>
									<col width="5%" />
									<col width="10%" />
									<col width="*" />
									<col width="17%" />
									<col width="8%" />
								</colgroup>
								<thead>
									<tr>
										<th>번호</th>
										<th>구분</th>
										<th>알람내용</th>
										<th colspan="2">발생일시</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${resultList }" var="result" varStatus="status">
										<tr>
											<td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * 10 + status.count)}"/></td>
											<td>
												<c:choose>
													<c:when test="${result.tType == 'FC' }">수방단계</c:when>
													<c:when test="${result.tType == 'wl' }">수위</c:when>
													<c:when test="${result.tType == 'K' }">SNS공유</c:when>
													<c:when test="${result.tType == 'D' }">수방근무현황</c:when>
													<c:when test="${result.tType == 'NC' }">특보코드</c:when>
												</c:choose>
											</td>
											<td>
												<c:choose>
													<c:when test="${result.tType == 'FC' }"><c:out value="${result.content }"/> <c:out value="${result.issueDate } ${result.issueTime }"/> 발령</c:when>
													<c:when test="${result.tType == 'wl' }"><c:out value="${result.content }"/></c:when>
													<c:when test="${result.tType == 'K' }"><c:out value="${result.title }"/> <c:out value="${result.content }"/></c:when>
													<c:when test="${result.tType == 'D' }"><c:out value="${result.content }"/></c:when>
													<c:when test="${result.tType == 'NC' }"><c:out value="${result.content }"/></c:when>
												</c:choose>
											</td>
											<c:choose>
												<c:when test="${result.tType == 'wl' || result.tType == 'NC'}">
													<td colspan="2">
														<c:out value="${result.regDttm } "/>
													</td>
												</c:when>
												<c:when test="${result.tType != 'wl' && result.tType != 'NC'}">
													<td>
														<c:out value="${result.regDttm } "/>
													</td>
													<td>
														<button onclick="fn_delete('<c:out value="${result.id }"/>', '<c:out value="${result.tType }"/>'); return false;">삭제</button>
													</td>
												</c:when>
											</c:choose>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<!-- 웹페이징 -->
							<div class="paging">
								<ui:pagination paginationInfo="${paginationInfo }" type="image2" jsFunction="fn_list"/>
								<form:hidden path="pageIndex"/>
							</div>
							<!-- // 웹페이징 -->
						</div>
					</div>
					<!--// 단일 GRAPH_BOX -->
				</div>
			</div>
		</div>
	</div>
	<!-- footer - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=inc/incFooter"/>
	<!-- footer - end -->
<input type="hidden" id="message" name="message" value="${message }">
</form:form>
</body>
</html>