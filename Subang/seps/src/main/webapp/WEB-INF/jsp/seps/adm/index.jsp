<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=inc/incHead" />
<style>
	.c3 path, .c3 line {stroke:#fff; font-weight:normal;}
	text {fill:white; font-weight:normal; font-size:13px;}	
	.c3-tooltip td {color:black;}

</style>
<body>
	<!-- top menu - start -->
	<c:import url="${pageContext.request.contextPath }/adm/inc/incTopnav.do"/>
	<%--
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/inc/incTopnav"/>
	--%>
	<!-- top menu - end -->
	<!-- 발전소 현황 - start -->
	<c:import url="${pageContext.request.contextPath }/adm/inc/incDevList.do"/>
	<%--
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/inc/incDevList"/>
	--%>
	<!-- 발전소 현황 - end -->
	<div class="m_body">
		<div class="main_content02">
			<div class="page_title">
				<div>종합현황</div>
			</div>
			<div class="content">
				<!-- 발전량 및 발전수익 - start -->
				<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=inc/incMainDevRevenue"/>
				<!-- 발전량 및 발전수익 - end -->
				<div class="da_cont">
						<div>
							<div class="dc_tit">시간대별 발전량 추이</div>
							<div class="dc_cont">
							<%--
								<common:graph id="chart1" data="${dataList1 }" axisXType="timeseries" graphType="line" dataTitleList="오늘, 어제, 전년오늘" xValue="1H"/>
							--%>
								<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/index_graph1"/>
							</div>
						</div>
						<div>
							<div class="dc_tit">일별 발전량 추이</div>
							<div class="dc_cont">
							<%--
								<common:graph id="chart2" data="${dataList2 }" axisXType="timeseries" graphType="line" dataTitleList="이번달, 지난달, 전년동월" xValue="DAY"/>
							--%>
								<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/index_graph2"/>
							</div>
						</div>
						<div>
							<div class="dc_tit">일별 발전시간 추이</div>
							<div class="dc_cont">
							<%--
								<common:graph id="chart3" data="${dataList3 }"
										axisXType="timeseries" graphType="line" avgTarget="전년동월" avgTitle="전년동월 일평균"
										dataTitleList="이번달, 지난달, 전년동월" xValue="DAY"/>
							--%>
								<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/index_graph3"/>
							</div>
						</div>
						<div>
							<div class="dc_tit">월별 발전량 추이</div>
							<div class="dc_cont">
							<%--
								<common:graph id="chart4" data="${dataList4 }"
										axisXType="timeseries" graphType="line" avgTarget="전년" avgTitle="전년도(월평균)"
										dataTitleList="금년, 전년" xValue="MONTH"/>
							--%>
								<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/index_graph4"/>
							</div>
						</div>
						<div>
							<div class="dc_tit">월별 발전시간 추이</div>
							<div class="dc_cont">
							<%--
								<common:graph id="chart5" data="${dataList5 }"
										axisXType="timeseries" graphType="line" avgTarget="전년(월별일평균)" avgTitle="전년도(일평균)"
										dataTitleList="금년(월별일평균), 전년(월별일평균)" xValue="MONTH"/>
							--%>
								<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/index_graph5"/>
							</div>
						</div>
						<div>
							<div class="dc_tit">연도별 발전량</div>
							<div class="dc_cont">
							<%--
								<common:graph id="chart6" data="${dataList6 }"
										axisXType="timeseries" graphType="bar" colData="${year }" selectedY2Line="년도별일평균 발전시간"
										dataTitleList="발전량, 년도별일평균 발전시간" xValue="YEAR"/>
							--%>
								<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/index_graph6"/>
							</div>
						</div>
					</div>
			</div>
			<!-- footer - start -->
			<c:import url="${pageContext.request.contextPath }/cmmn/incFooter.do">
				<c:param name="type" value="MAIN"/>
				<c:param name="siteInfoId" value="${sessionScope.sSiteInfoId }"/>
			</c:import>
			<!-- footer - end -->
			
		</div>
	</div>
	<!-- footer - start -->
<%-- 	<c:import url="${pageContext.request.contextPath }/cmmn/incFooter.do"> --%>
<%-- 		<c:param name="siteInfoId" value="${sessionScope.sSiteInfoId }"/> --%>
<%-- 	</c:import> --%>
	<!-- footer - end -->
<!-- setInterval - start -->
<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=inc/incSetinterval"/>
<!-- setInterval - end -->
</body>
</html>