<%@page import="egovframework.com.cmm.util.EgovUserDetailsHelper"%>
<%@ page import="egovframework.rte.psl.dataaccess.util.EgovMap" %>
<%@ page import="lcms.valueObject.UsrVO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt"		uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%
	String lecMenuNo = ((String)session.getAttribute("lecMenuNo")!=null)?(String)session.getAttribute("lecMenuNo"):"";
	UsrVO usrVO = ((UsrVO)session.getAttribute("usrSession")!=null)?(UsrVO)session.getAttribute("usrSession"):null;
	String selLectName = (String)session.getAttribute("selLectName")!=null?(String)session.getAttribute("selLectName"):"";
	EgovMap lecSession = (EgovMap)session.getAttribute("lecSession");
	String lectSemNm = (((String)lecSession.get("lectSem")).equals("1")?"봄학기":((String)lecSession.get("lectSem")).equals("2")?"여름학기":((String)lecSession.get("lectSem")).equals("3")?"가을학기":"겨울학기");
	String lectSemYear = (((String)lecSession.get("lectYear")));
%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>

<script>
	function fn_list(pageNo){
		$("#pageIndex").val(pageNo);
		$("#listForm").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/lec/clss/lecClssMeetList.do'/>").submit();
	}
	
	function fn_select(week, grade, meetSeq){
	 	$("#week").val(week);
	 	$("#grade").val(grade);
	 	$("#meetSeq").val(meetSeq);
		$("#listForm").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/lec/clss/lecClssMeetModify.do'/>").submit();
	}
	
	function fn_print(meetSeq){
		window.open("<c:url value='/qxsepmny/cmm/meetLogPop.do'/>?meetSeq="+meetSeq
					, '학생명단 인쇄', 'width=800, height=850, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
</script>
<body>
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnavLec"/>
	<form:form commandName="lecClssNoticeVO" id="listForm" name="listForm">
	<input type="hidden" name="week" id="week"/>
	<input type="hidden" name="grade" id="grade"/>
	<input type="hidden" name="meetSeq" id="meetSeq"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenuLec"/>
			<!--// left menu -->
			<div class="main-content">
				<div class="title-area">
					<p class="page-lv01">급별회의록</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>강의실</span>
						<span>수업</span>
						<span>급별회의록</span>
					</div>
				</div>
				<!-- search -->
				<div class="search-box none-option">
					<input type="checkbox" id="search-option-open" />
					<div class="search web"><!-- 모바일 수정 -->
						<div class="search-input">
							<table class="shearch-option">
								<colgroup>
									<col style="width:8%;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<td>대상학기</td>
										<td>
											<select>
												<option><%=lectSemYear %></option>
											</select>
											<select>
												<option><%=lectSemNm %></option>
											</select>
										</td>
									</tr>
								</tbody>
							</table>

							<a href="#">검색하기</a>
						</div>
					</div>
				<!-- 모바일 추가 -->
					<input type="checkbox" id="sh-op-cl01" class="hidden" />
					<div class="m-search-btn mob">
						<label for="sh-op-cl01">검색</label>
					</div>
					<div class="m-search mob">
						<div class="m-search-tit">
							<p>검색</p>
							<label for="sh-op-cl01" class="icon-pop-close">검색닫기</label>
						</div>
						<div class="w100-sh">
							<ul>
								<li>
									<select class="w49pc-01">
										<option><%=lectSemYear %></option>
									</select>
									<select class="w49pc-01">
										<option><%=lectSemNm %></option>
									</select>
								</li>
							</ul>
							<div class="m-search-btn">
								<button type="button" for="sh-op-cl01">검색</button>
							</div>
						</div>
					</div>
					<!--// 모바일 추가 -->
				</div>
				<!--// search -->

				<!--search info-->
				<div class="search-infomation">
					<div class="search-count">
						<strong><c:out value="${resultList.size() }"/></strong>건이 검색되었습니다.
					</div>
				</div>
				<!--// search info-->

				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-list-table">
						<colgroup>
							<col style="width:5%;" />
							<col style="width:5%;" />
							<col />
							<col />
							<col />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th>주차</th>
								<th>급</th>
								<th>분반</th>
								<th>참가교사</th>
								<th>제출여부</th>
								<th>급별회의록</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="result" items="${resultList}" varStatus="status" >
								<tr>
									<td><c:out value="${result.week }"/></td>
									<td>
										<c:choose>
											<c:when test="${result.submisYn eq '제출' }">
												<c:out value="${result.lectGrade }급"/>
											</c:when>
											<c:otherwise>
												<a href="#" onclick="fn_select('<c:out value="${result.week}"/>','<c:out value="${result.lectGrade}"/>','<c:out value="${result.meetSeq}"/>'); return false;" class="underline">
													<c:out value="${result.lectGrade }급"/>
												</a>
											</c:otherwise>
										</c:choose>
									</td>
									<td><c:out value="${result.lectDivi }"/></td>
									<td><c:out value="${result.partProf }"/></td>
									<td><c:out value="${result.submisYn }"/></td>
									<td>
										<c:if test="${result.meetSeq ne '' && result.meetSeq != null }">
											<a href="#" class="underline" onclick="fn_print('<c:out value="${result.meetSeq }"/>'); return false;">인쇄</a>
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<div class="mob mb20">
					<div class="mob-list">
						<ul>
							<c:forEach var="result" items="${resultList}" varStatus="status" >
								<li>
									<p>
										<span class="title">
											<a href="#" onclick="fn_select('<c:out value="${result.lcnotiSeq}"/>'); return false;" class="underline">
												${result.lcnotiTitle}
											</a>
										</span>
									</p>
									<p class="option">
										<span class="date"><c:out value="${result.lcnotiDate }"/></span>
									</p>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!--// footer -->

	<!-- 모바일 수정 -->
	<div class="black"></div>
	<!--// 모바일 수정 -->
	</form:form>
	<input type="hidden" id="message" name="message" value="<c:out value='${message }'/>"/>
</body>
</html>