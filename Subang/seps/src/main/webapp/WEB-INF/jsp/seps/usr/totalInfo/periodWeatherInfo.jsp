<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt"			uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=inc/incHead" />
<body class="sub_page">
<form:form commandName="searchVO" id="frm" name="frm">
	<!-- top menu - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incTopnav"/>
	<!-- top menu - end -->
	<div class="m_body" >
		<!-- left menu - start -->
		<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incLeftnav"/>
		<!-- left menu - end -->
		<div class="main_content">
			<div class="content">
				<div class="m_title">
					<div class="title">시간대별 기상현황</div>
					<div class="navi">
						<ul>
							<li>HOME</li>
							<li>상세관측정보</li>
							<li>시간대별 기상현황</li>
						</ul>
					</div>
				</div>
				<fieldset>
					<legend>검색하기</legend>
					<div class="top_sh_box">
						<div class="sh_box">
							<dl>
								<dt>기간</dt>
								<dd>
									<form:input path="startDate" class="start_day input_date"  placeholder="날짜" autocomplete="off"/>
									<form:select path="startTime" class="input_time">
										<c:forEach begin="0" end="23" varStatus="status">
											<c:set var="time" value="0${status.index }"/>
											<c:if test="${fn:length(time) eq 3 }"><c:set var="time" value="${fn:substring(time, 1, 3) }"/></c:if>
											<form:option value="${time }"><c:out value="${time }"/></form:option>
										</c:forEach>
									</form:select>
									&nbsp;~&nbsp;
									<form:input path="endDate" class="finish_day input_date"  placeholder="날짜" autocomplete="off"/>
									<form:select path="endTime" class="input_time">
										<c:forEach begin="0" end="23" varStatus="status">
											<c:set var="time" value="0${status.index }"/>
											<c:if test="${fn:length(time) eq 3 }"><c:set var="time" value="${fn:substring(time, 1, 3) }"/></c:if>
											<form:option value="${time }"><c:out value="${time }"/></form:option>
										</c:forEach>
									</form:select>
								</dd>
							</dl>
						</div>
						<div class="btn_sh"><button onclick="fn_list(); return false;">검색</button></div>
						<div class="dw_exl"><a href="#" onclick="fn_excelDownload(); return false;"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/excel_icon.png'/>" alt="엑셀파일 다운로드" /></a></div>
					</div>
				</fieldset>
				<div class="cont_box">
					<div class="grid_table grid_table_over ">
						<table>
							<thead>
								<tr>
									<th rowspan="3">시간</th>
									<th colspan="6">수위 및 방류량      *자체수위 및 한강통수통제소</th>
									<th colspan="4">강수량</th>
								</tr>
								<tr>
									<!-- <th rowspan="2">단계</th> -->
									<th rowspan="2">신곡교<br>[수위(M)]</th>
									<th rowspan="2">월계1교<br>[EL.m]</th>
									<th rowspan="2">월릉교<br>[EL.m]</th>
									<th rowspan="2">여의상류<br>[EL.m]</th>
									<th rowspan="2">한강대교<br>[수위(M)]</th>
									<th rowspan="2">팔당댐방류량<br>(㎥/s)</th>
									<th colspan="2">서울</th>
									<th colspan="2">의정부</th>
								</tr>
								<tr>
									<th>시간당</th>
									<th>누적</th>
									<th>시간당</th>
									<th>누적</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="totRn1A" value="0"/>
								<c:set var="totRn1B" value="0"/>
								<c:forEach items="${weatherStatusList }" var="result">
									<tr>
										<td>
											<fmt:parseDate value="${result.dttm }" pattern="yyyyMMdd HHmm" var="dttm"/>
											<fmt:formatDate value="${dttm }" pattern="yyyy-MM-dd HH:mm"/>
										</td>
									<%-- 	<td>
											<c:choose>
												<c:when test="${result.floodLevel.get('floodLevel') eq '1'}">1단계(주의)</c:when>
												<c:when test="${result.floodLevel.get('floodLevel') eq '2'}">2단계(경계)</c:when>
												<c:when test="${result.floodLevel.get('floodLevel') eq '3'}">3단계(심각)</c:when>
												<c:when test="${result.floodLevel.get('floodLevel') eq '4'}">평시(관심)</c:when>
												<c:when test="${result.floodLevel.get('floodLevel') eq '5'}">포트홀단계(예방)</c:when>
												<c:when test="${result.floodLevel.get('floodLevel') eq '6'}">보강(주의)</c:when>
												<c:otherwise>확인중</c:otherwise>
											</c:choose>
										</td> --%>
										<td><c:out value="${result.wlList.get('1018665') }"/></td>
										<td><c:out value="${result.wlList.get('0000001') }"/></td>
										
										<td><c:out value="${result.wlList.get('0000003') }"/></td>
										<td><c:out value="${result.wlList.get('0000002') }"/></td>
										<td><c:out value="${result.wlList.get('1018683') }"/></td>
										<td><c:out value="${result.tototf }"/></td>
										<td>
											<c:out value="${result.rainList.get('1') }"/>
											<c:set var="totRn1A" value="${totRn1A + result.rainList.get('1') }"/>
										</td>
										<td><fmt:formatNumber value="${totRn1A }"/></td>
										<td>
											<c:out value="${result.rainList.get('2') }"/>
											<c:set var="totRn1B" value="${totRn1B + result.rainList.get('2') }"/>
										</td>
										<td><fmt:formatNumber value="${totRn1B }"/></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<!-- <div class="b_table_caption">*사례 근무일시 : 2017.8.15(화) 10:00 ~ 8.15(화) 18:00 상황 표시 함.</div>-->
					</div>
			</div>
		</div>
	</div>
	<!-- footer -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!-- footer -->
</form:form>
<script type="text/javascript">
	// 검색
	function fn_list(){
		$('#frm').attr('method', 'post').attr('action', '<c:out value="${pageContext.request.contextPath}/usr/totalInfo/periodWeatherInfo.do"/>').submit();
	}
	
	// 엑셀다운로드
	function fn_excelDownload(){
		if(confirm("엑셀다운로드를 하시겠습니까?\n데이터양에 따라 시간이 오래걸릴 수 있습니다.")){
			// fn_loading_on();
			/* $.fileDownload("<c:out value='${pageContext.request.contextPath }/usr/totalInfo/periodWeatherInfoExcelDownload.do'/>", {
				httpMethod : "POST"
				, data : $("#frm").serialize()
			}).done(function(){
				fn_loading_off();
			}); */
			$('#frm').attr('method', 'post').attr('action', '<c:out value="${pageContext.request.contextPath}/usr/totalInfo/periodWeatherInfoExcelDownload.do"/>').submit();
			fn_loading_off();
		}
	}
</script>
</body>
</html>
