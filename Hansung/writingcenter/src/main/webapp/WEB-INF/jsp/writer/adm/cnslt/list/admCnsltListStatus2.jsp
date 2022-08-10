<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />

<link rel="stylesheet" type="text/css" href="<c:out value='${pageContext.request.contextPath }/assets/adm/css/Nwagon.css'/>" />
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/adm/js/nwagon/Nwagon.js?v=1.0'/>"></script>

<link rel="stylesheet" type="text/css" href="<c:out value='${pageContext.request.contextPath }/assets/c3/c3.css'/>" />
<script src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<c:out value='${pageContext.request.contextPath }/assets/c3/c3.js'/>"></script>

<script type="text/javascript">
	
	$(function(){
		// datepicker input 클릭시 - start
		$(document).on("click", ".common_datepicker", function(){
			$(this.nextElementSibling).click();
		});
		// datepicker input 클릭시 - end
	});

	// 기간 조회
	function fn_select(searchType){
		if(searchType != null) {
			$("#searchType").val(searchType);
			$("#startDate").val("");
			$("#endDate").val("");
		}
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/xabdmxgr/cnslt/list/admCnsltListStatus.do'/>").submit();
	}
	
	// 엑셀 다운로드
	function fn_excel_down(){
		if($("#startDate").val() == "" && $("#endDate").val() == ""){
			if(!confirm("기간을 정하시지 않으면 전체가 다운됩니다.\n그래도 진행하시겠습니까?")){
				return false;
			}
		}
		$.fileDownload("<c:out value='${pageContext.request.contextPath}/xabdmxgr/cnslt/list/cnsltStatusExcelDown.do'/>", {
			data : $("#frm").serialize()
			, httpMethod: "POST"
			, successCallback : function(url){
				// 로딩 end
				window.close();
			}
		});
		//$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/xabdmxgr/cnslt/list/cnsltCompleteExcelDown.do'/>").submit();
	}
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="searchType"/>
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
	            	<jsp:param name="dept2" value="상담 현황"/>
	            </jsp:include>
				<div class="cont_box">
				<!-- content -->
					<div class="btm_area">
						<div class="tbl_top_side mt20">
							<div class="side_c">
								<ul>
									<li>
										<form:input path="startDate" class="common_datepicker w100" readonly="true"/>
										&nbsp;~&nbsp;
										<form:input path="endDate" class="common_datepicker w100" readonly="true"/>
									</li>
									<li>
										<a href="#" class="btn_type05 input_btn ml10" onclick="fn_select(); return false;">검색</a>
									</li>
									<li>
										<a href="#" class="btn_type01 input_btn ml10" onclick="fn_excel_down(); return false;">엑셀다운로드</a>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<!-- mid_tab-->
					<div class="mid_tab01">
						<ul>
							<li><a href="#" onclick="fn_select('REGI'); return false;" <c:if test="${searchVO.searchType eq 'REGI' }">class="active"</c:if>>재학생</a></li>
							<li><a href="#" onclick="fn_select('OVER'); return false;" <c:if test="${searchVO.searchType eq 'OVER' }">class="active"</c:if>>외국인</a></li>
						</ul>
					</div>
					<!-- //mid_tab-->
					<c:if test="${searchVO.searchType eq 'REGI'}">
						<!-- 재학생 - start -->
						<!-- table -->
						<table class="list_tbl_03 mt10" summary="상담 목록">
							<tbody>
								<tr>
									<td style="text-align: left; border-top: 1px solid #e2e2e2; background-color: #f5f5f5; font-weight: bolder;">▷ 상담 대상 글</td>
								</tr>
								<tr>
									<td style="text-align: left;">
										<font>
											1) 상담 받을 글의 유형은 무엇입니까?&nbsp;
											(총 답변수 : <c:out value='${
															statusInfo.totAns11 + statusInfo.totAns12 + statusInfo.totAns13
															 + statusInfo.totAns14 + statusInfo.totAns15 + statusInfo.totAns16
															 + statusInfo.totAns17 + statusInfo.totAns18 + statusInfo.totAns19
															 + statusInfo.totAns1A + statusInfo.totAns1B + statusInfo.totAns10
											}'/>)
										</font>
										<div id="chart"></div>
										<script type="text/javascript">
											var chart = c3.generate({
												bindto : '#chart'
												, data : {
													x : 'x'
													//, xFormat : '%Y'
													, xFormat : '%Y-%m-%d %H:%M:%S'
													, columns: [
													            //['x', '2013-01-01', '2013-01-02', '2013-01-03', '2013-01-04', '2013-01-05', '2013-01-06']
													            //['x', '00:00', '00:15', '00:30', '00:45', '01:00', '01:15']
													            //['x', '2017-12-12 00:00:00', '2017-12-12 01:00:00', '2017-12-12 02:00:00', '2017-12-12 03:00:00', '2017-12-12 04:00:00', '2017-12-12 05:00:00']
													            ['x', '2017-12-12 00:00:00', '2017-12-12 00:15:00', '2017-12-12 00:30:00', '2017-12-12 00:45:00', '2017-12-12 01:00:00', '2017-12-12 01:15:00']
													            , ['data1', 30, 200, 100, 400, 150, 250]
													            , ['data2', 130, 340, 200, 500, 250, 350]
											        ]
												}
												, axis: {
											        x: {
											            type: 'timeseries'
											            //, localtime : false
											            , tick: {
											                //format: '%Y-%m-%d'
											                //format: '%I:%M'
											            	format: '%Y-%m-%d %H:%M:%S'
											            }
											        }
											    }
											});
											setTimeout(function(){
												chart.flow({
													columns : [
														//['x', '2017-12-12 06:00:00', '2017-12-12 07:00:00', '2017-12-12 08:00:00', '2017-12-12 09:00:00', '2017-12-12 10:00:00', '2017-12-12 11:00:00']
														['x', '2017-12-12 01:30:00', '2017-12-12 01:45:00', '2017-12-12 02:00:00', '2017-12-12 02:15:00', '2017-12-12 02:30:00', '2017-12-12 02:45:00']
														, ['data1', 300, 2000, 1000, 4000, 1500, 2500]
											            , ['data2', 1300, 3400, 2000, 5000, 2500, 3500]
													]
													//, length : 1
													, duration : 3000
													, done : function(){
														chart.flow({
															columns : [
																//['x', '2017-12-12 12:00:00', '2017-12-12 13:00:00', '2017-12-12 14:00:00', '2017-12-12 15:00:00', '2017-12-12 16:00:00', '2017-12-12 17:00:00']
																['x', '2017-12-12 03:00:00', '2017-12-12 03:15:00', '2017-12-12 03:30:00', '2017-12-12 03:45:00', '2017-12-12 04:00:00', '2017-12-12 04:15:00']
																, ['data1', 350, 2500, 1500, 4500, 1000, 2000]
													            , ['data2', 2000, 4000, 3000, 4000, 2000, 3000]
															]
															//, length : 1
															, duration : 3000
														});
													}
												});
											}, 1000);
/*
											setTimeout(function(){
												chart.flow({
													columns : [
															//['x', '2017-12-12 12:00:00', '2017-12-12 13:00:00', '2017-12-12 14:00:00', '2017-12-12 15:00:00', '2017-12-12 16:00:00', '2017-12-12 17:00:00']
															['x', '2017-12-12 03:00:00', '2017-12-12 03:15:00', '2017-12-12 03:30:00', '2017-12-12 03:45:00', '2017-12-12 04:00:00', '2017-12-12 04:15:00']
															, ['data1', 350, 2500, 1500, 4500, 1000, 2000]
												            , ['data2', 2000, 4000, 3000, 4000, 2000, 3000]
														]
														//, length : 0
														, duration : 3000
												});
											}, 5000);
*/
											/*
											setTimeout(function(){
												chart.flow({
													columns : [
														['x', '2017-12-12 11:00:00', '2017-12-12 12:00:00', '2017-12-12 13:00:00', '2017-12-12 14:00:00', '2017-12-12 15:00:00', '2017-12-12 11:00:00']
														, ['data1', 350, 2500, 1500, 4500, 1000, 2000]
											            , ['data2', 2000, 4000, 3000, 4000, 2000, 3000]
													]
													, duration : 1500
												});
											}, 2000);
											*/
										</script>
										
										<div id="chart0"></div>
										<script type="text/javascript">
											var chart0 = c3.generate({
												bindto : '#chart0'
												, data: {
											        columns: [
											            ['data', 91.4]
											        ]
													, type: 'gauge'
											    }
											});
											setTimeout(function(){
												chart0.load({
													columns : [
														['data', 10]
													]
												});
											}, 1000);
										</script>
										
										<div id="chart1"></div>
										<script type="text/javascript">
											var chart1 = c3.generate({
												bindto : "#chart1"
												, data : {
													columns: [
														['칼럼(<c:out value="${statusInfo.totAns11 }"/>)'						, '<c:out value="${statusInfo.totAns11 }"/>']
														, ['기사문(<c:out value="${statusInfo.totAns12 }"/>)'					, '<c:out value="${statusInfo.totAns12 }"/>']
														, ['비평문(<c:out value="${statusInfo.totAns13 }"/>)'					, '<c:out value="${statusInfo.totAns13 }"/>']
														, ['요약문(<c:out value="${statusInfo.totAns14 }"/>)'					, '<c:out value="${statusInfo.totAns14 }"/>']
														, ['제안서(<c:out value="${statusInfo.totAns15 }"/>)'					, '<c:out value="${statusInfo.totAns15 }"/>']
														, ['분석 보고서(<c:out value="${statusInfo.totAns16 }"/>)'				, '<c:out value="${statusInfo.totAns16 }"/>']
														, ['조사 보고서(<c:out value="${statusInfo.totAns17 }"/>)'				, '<c:out value="${statusInfo.totAns17 }"/>']
														, ['실험 보고서(<c:out value="${statusInfo.totAns18 }"/>)'				, '<c:out value="${statusInfo.totAns18 }"/>']
														, ['발표(프레젠테이션 문서)(<c:out value="${statusInfo.totAns19 }"/>)'		, '<c:out value="${statusInfo.totAns19 }"/>']
														, ['자기소개서(<c:out value="${statusInfo.totAns1A }"/>)'				, '<c:out value="${statusInfo.totAns1A }"/>']
														, ['면접(<c:out value="${statusInfo.totAns1B }"/>)'						, '<c:out value="${statusInfo.totAns1B }"/>']
														, ['기타(<c:out value="${statusInfo.totAns10 }"/>)'						, '<c:out value="${statusInfo.totAns10 }"/>']
													]
													, type : 'donut'
												}
												, legend : {
													position : 'right'
											    }
												, size : {
													height : 400
												}
												, donut : {
													title : '1) 상담 받을 글의 유형은 무엇입니까?'
													, width : 60
													/*
													, label: {
														format : function (value, ratio, id){
															return d3.format('#')(value);
														}
													}
													*/
												}
											});
										</script>
										<div id="Nwagon1" style="text-align: center;"></div>
										<script>
											var options = {
												'dataset':{
													title: '재학생 상담신청 답변현황 - 질문1',
													//values:[25, 3 , 10, 7],
													values:[
														<c:out value='${statusInfo.totAns11 }'/>
														, <c:out value='${statusInfo.totAns12 }'/>
														, <c:out value='${statusInfo.totAns13 }'/>
														, <c:out value='${statusInfo.totAns14 }'/>
														, <c:out value='${statusInfo.totAns15 }'/>
														, <c:out value='${statusInfo.totAns16 }'/>
														, <c:out value='${statusInfo.totAns17 }'/>
														, <c:out value='${statusInfo.totAns18 }'/>
														, <c:out value='${statusInfo.totAns19 }'/>
														, <c:out value='${statusInfo.totAns1A }'/>
														, <c:out value='${statusInfo.totAns1B }'/>
														, <c:out value='${statusInfo.totAns10 }'/>
													],
													colorset: [
													           	'#FF0000', '#FF8000', "#DF7401", '#FFFF00'
													           	, '#BFFF00', '#00FFFF', "#0040FF", '#FF00FF'
													           	, '#9F81F7', '#E2A9F3', "#088A08", '#8A4B08'
													],
													fields: [
														'칼럼', '기사문', '비평문', '요약문'
														, '제안서', '분석 보고서', '조사 보고서', '실험 보고서'
														, '발표(프레젠테이션 문서)', '자기소개서', '면접', '기타'
													],
												},
												'donut_width' : 85,
												'core_circle_radius':50,
												'chartDiv': 'Nwagon1',
												'chartType': 'donut',
												'chartSize': {width:900, height:400}
											};
											Nwagon.chart(options);
										</script>
									</td>
								</tr>
								<tr>
									<td style="text-align: left;">
										<font>
											2) 상담 받을 글의 단계는 무엇입니까?&nbsp;
											(총 답변수 : <c:out value='${
															statusInfo.totAns21 + statusInfo.totAns22 + statusInfo.totAns23 + statusInfo.totAns24
											}'/>)
										</font>
										<div id="Nwagon2" style="text-align: center;"></div>
										<script>
											var options = {
												'dataset':{
													title: '재학생 상담신청 답변현황 - 질문2',
													//values:[25, 3 , 10, 7],
													values:[
														<c:out value='${statusInfo.totAns21 }'/>
														, <c:out value='${statusInfo.totAns22 }'/>
														, <c:out value='${statusInfo.totAns23 }'/>
														, <c:out value='${statusInfo.totAns24 }'/>
													],
													colorset: [
													           	'#FF0000', '#FF8000', "#DF7401", '#E2A9F3'
													],
													fields: [
														'아이디어 생성 단계', '개요 작성 단계', '초안 작성 단계', '원고 완성 단계'
													],
												},
												'donut_width' : 85,
												'core_circle_radius':50,
												'chartDiv': 'Nwagon2',
												'chartType': 'donut',
												'chartSize': {width:900, height:400}
											};
											Nwagon.chart(options);
										</script>
									</td>
								</tr>
								<tr>
									<td style="text-align: left;">
										<font>
											3) 상담 받고 싶은 내용이 무엇입니까?&nbsp;(복수 응답 가능)&nbsp;
											(총 답변수 : <c:out value='${
															statusInfo.totAns3A + statusInfo.totAns3B + statusInfo.totAns3C
															 + statusInfo.totAns3D + statusInfo.totAns3E + statusInfo.totAns3F
															 + statusInfo.totAns3G + statusInfo.totAns3H + statusInfo.totAns3I
											}'/>)
										</font>
										<div id="Nwagon3" style="text-align: center;"></div>
										<script>
											var options = {
												'dataset':{
													title: '재학생 상담신청 답변현황 - 질문3',
													values:[
														<c:out value='${statusInfo.totAns3A }'/>
														, <c:out value='${statusInfo.totAns3B }'/>
														, <c:out value='${statusInfo.totAns3C }'/>
														, <c:out value='${statusInfo.totAns3D }'/>
														, <c:out value='${statusInfo.totAns3E }'/>
														, <c:out value='${statusInfo.totAns3F }'/>
														, <c:out value='${statusInfo.totAns3G }'/>
														, <c:out value='${statusInfo.totAns3H }'/>
														, <c:out value='${statusInfo.totAns3I }'/>
													],
													colorset: [
														'#FF0000', '#FF8000', "#DF7401", '#FFFF00'
														, '#9F81F7', '#E2A9F3', "#088A08", '#8A4B08'
														, '#BFFF00'
													],
													fields: [
														'아이디어 생성 방법', '자료 해석 및 평가 방법', '글의 맥락 파악 방법(독자, 목적, 상황 등)', '문장 표현 방법'
														, '글의 전개 방법', '글쓰기의 일반적 과정', '자신의 글쓰기 습관 점검', '바람직한 글쓰기 태도'
														, '기타'
													],
												},
												'donut_width' : 75,
												'core_circle_radius':50,
												'chartDiv': 'Nwagon3',
												'chartType': 'donut',
												'chartSize': {width:900, height:400}
											};
											Nwagon.chart(options);
										</script>
									</td>
								</tr>
								<tr>
									<td style="text-align: left; background-color: #f5f5f5; font-weight: bolder;">▷ 상담 받을 글 관련 강좌</td>
								</tr>
								<tr>
									<td style="text-align: left;">
										<font>
											1) 강좌의 성격은 무엇입니까?&nbsp;
											(총 답변수 : <c:out value='${
															statusInfo.totTans11 + statusInfo.totTans12
											}'/>)
										</font>
										<div id="Nwagon4" style="text-align: center;"></div>
										<script>
											var options = {
												'dataset':{
													title: '재학생 상담신청 답변현황 - 공통질문1',
													values:[
														<c:out value='${statusInfo.totTans11 }'/>
														, <c:out value='${statusInfo.totTans12 }'/>
													],
													colorset: [
														'#FF0000', '#4646CD'
													],
													fields: [
														'전공 과목', '교양 과목'
													],
												},
												'donut_width' : 130,
												'core_circle_radius':0,
												'chartDiv': 'Nwagon4',
												'chartType': 'pie',
												'chartSize': {width:900, height:400}
											};
											Nwagon.chart(options);
										</script>
									</td>
								</tr>
								<tr>
									<td style="text-align: left;">
										<font>
											2) 몇 학년을 수강 대상으로 한 강좌입니까?&nbsp;
											(총 답변수 : <c:out value='${
															statusInfo.totTans21 + statusInfo.totTans22 + statusInfo.totTans23
															 + statusInfo.totTans24 + statusInfo.totTans25
											}'/>)
										</font>
										<div id="Nwagon5" style="text-align: center;"></div>
										<script>
											var options = {
												'dataset':{
													title: '재학생 상담신청 답변현황 - 공통질문2',
													values:[
														<c:out value='${statusInfo.totTans21 }'/>
														, <c:out value='${statusInfo.totTans22 }'/>
														, <c:out value='${statusInfo.totTans23 }'/>
														, <c:out value='${statusInfo.totTans24 }'/>
														, <c:out value='${statusInfo.totTans25 }'/>
													],
													colorset: [
														'#DC143C', '#FF8C00', "#30a1ce", "#7700FF", "#00FFC7"
													],
													fields: [
														'1학년', '2학년', '3학년', '4학년', '전 학년 공통'
													],
												},
												'donut_width' : 130,
												'core_circle_radius':0,
												'chartDiv': 'Nwagon5',
												'chartType': 'pie',
												'chartSize': {width:900, height:400}
											};
											Nwagon.chart(options);
										</script>
									</td>
								</tr>
							</tbody>
						</table>
						<!-- 재학생 - end -->
					</c:if>
					<c:if test="${searchVO.searchType eq 'OVER'}">
						<!-- 외국인 - start -->
						<!-- table -->
						<table class="list_tbl_03 mt10" summary="상담 목록">
							<tbody>
								<tr>
									<td style="text-align: left; border-top: 1px solid #e2e2e2; background-color: #f5f5f5; font-weight: bolder;">▷ 상담 대상 글</td>
								</tr>
								<tr>
									<td style="text-align: left; border-top: 1px solid #e2e2e2;">
										<font>
											1) 상담 받을 글의 유형은 무엇입니까?&nbsp;
											(총 답변수 : <c:out value='${
															statusInfo.totAns11 + statusInfo.totAns12 + statusInfo.totAns13
															 + statusInfo.totAns14 + statusInfo.totAns15 + statusInfo.totAns16
															 + statusInfo.totAns17 + statusInfo.totAns18 + statusInfo.totAns10
											}'/>)
										</font>
										<div id="Nwagon6" style="text-align: center;"></div>
										<script>
											var options = {
												'dataset':{
													title: '외국인 상담신청 답변현황 - 질문1',
													//values:[25, 3 , 10, 7],
													values:[
														<c:out value='${statusInfo.totAns11 }'/>
														, <c:out value='${statusInfo.totAns12 }'/>
														, <c:out value='${statusInfo.totAns13 }'/>
														, <c:out value='${statusInfo.totAns14 }'/>
														, <c:out value='${statusInfo.totAns15 }'/>
														, <c:out value='${statusInfo.totAns16 }'/>
														, <c:out value='${statusInfo.totAns17 }'/>
														, <c:out value='${statusInfo.totAns18 }'/>
														, <c:out value='${statusInfo.totAns10 }'/>
													],
													colorset: [
													           	'#FF0000', '#FF8000', "#DF7401", '#FFFF00'
													           	, '#BFFF00', '#00FFFF', "#0040FF", '#FF00FF'
													           	, '#9F81F7'
													],
													fields: [
														'리포트', '분석 보고서', '조사 보고서', '실험 보고서'
														, '일반 한국어 글쓰기', '발표(프레젠테이션 문서)', '자기소개서', '면접', '기타'
													],
												},
												'donut_width' : 85,
												'core_circle_radius':50,
												'chartDiv': 'Nwagon6',
												'chartType': 'donut',
												'chartSize': {width:900, height:400}
											};
											Nwagon.chart(options);
										</script>
									</td>
								</tr>
								<tr>
									<td style="text-align: left;">
										<font>
											2) 상담 받고 싶은 내용이 무엇입니까? (두 개를 선택(V)해도 됩니다.)&nbsp;
											(총 답변수 : <c:out value='${
															statusInfo.totAns2A + statusInfo.totAns2B + statusInfo.totAns2C
															 + statusInfo.totAns2D + statusInfo.totAns2E + statusInfo.totAns2F
											}'/>)
										</font>
										<div id="Nwagon7" style="text-align: center;"></div>
										<script>
											var options = {
												'dataset':{
													title: '외국인 상담신청 답변현황 - 질문2',
													//values:[25, 3 , 10, 7],
													values:[
														<c:out value='${statusInfo.totAns2A }'/>
														, <c:out value='${statusInfo.totAns2B }'/>
														, <c:out value='${statusInfo.totAns2C }'/>
														, <c:out value='${statusInfo.totAns2D }'/>
														, <c:out value='${statusInfo.totAns2E }'/>
														, <c:out value='${statusInfo.totAns2F }'/>
													],
													colorset: [
													           	'#FF0000', '#FF8000', "#DF7401", '#E2A9F3'
													           	, "#0040FF", '#FF00FF'
													],
													fields: [
														'주제를 설정하는 방법', '글의 내용을 구성하는 방법', '글을 쓰는 과정에 대한 어려움', '한국어 문장 표현(문법, 어휘, 관용 표현 등)'
														, '자기 글의 문제점', '기타'
													],
												},
												'donut_width' : 70,
												'core_circle_radius':50,
												'chartDiv': 'Nwagon7',
												'chartType': 'donut',
												'chartSize': {width:900, height:400}
											};
											Nwagon.chart(options);
										</script>
									</td>
								</tr>
								<tr>
									<td style="text-align: left;">
										<font>
											3) 자신이 생각하는 한국어 실력은 어느 정도입니까?&nbsp;
											(총 답변수 : <c:out value='${
															statusInfo.totAns31 + statusInfo.totAns32 + statusInfo.totAns33 + statusInfo.totAns34
											}'/>)
										</font>
										<div id="Nwagon8" style="text-align: center;"></div>
										<script>
											var options = {
												'dataset':{
													title: '외국인 상담신청 답변현황 - 질문3',
													values:[
														<c:out value='${statusInfo.totAns31 }'/>
														, <c:out value='${statusInfo.totAns32 }'/>
														, <c:out value='${statusInfo.totAns33 }'/>
														, <c:out value='${statusInfo.totAns34 }'/>
													],
													colorset: [
														'#FF0000', '#FF8000', "#DF7401", '#8A4B08'
													],
													fields: [
														'1~2급', '3~4급', '5~6급', '6급 이상'
													],
												},
												'donut_width' : 85,
												'core_circle_radius':50,
												'chartDiv': 'Nwagon8',
												'chartType': 'donut',
												'chartSize': {width:900, height:400}
											};
											Nwagon.chart(options);
										</script>
									</td>
								</tr>
								<tr>
									<td style="text-align: left; background-color: #f5f5f5; font-weight: bolder;">▷ 상담 받을 글 관련 강좌</td>
								</tr>
								<tr>
									<td style="text-align: left;">
										<font>
											1) 강좌의 성격은 무엇입니까?&nbsp;
											(총 답변수 : <c:out value='${
															statusInfo.totTans11 + statusInfo.totTans12
											}'/>)
										</font>
										<div id="Nwagon9" style="text-align: center;"></div>
										<script>
											var options = {
												'dataset':{
													title: '재학생 상담신청 답변현황 - 공통질문1',
													values:[
														<c:out value='${statusInfo.totTans11 }'/>
														, <c:out value='${statusInfo.totTans12 }'/>
													],
													colorset: [
														'#FF0000', '#4646CD'
													],
													fields: [
														'전공 과목', '교양 과목'
													],
												},
												'donut_width' : 130,
												'core_circle_radius':0,
												'chartDiv': 'Nwagon9',
												'chartType': 'pie',
												'chartSize': {width:900, height:400}
											};
											Nwagon.chart(options);
										</script>
									</td>
								</tr>
								<tr>
									<td style="text-align: left;">
										<font>
											2) 몇 학년을 수강 대상으로 한 강좌입니까?&nbsp;
											(총 답변수 : <c:out value='${
															statusInfo.totTans21 + statusInfo.totTans22 + statusInfo.totTans23
															 + statusInfo.totTans24 + statusInfo.totTans25
											}'/>)
										</font>
										<div id="Nwagon10" style="text-align: center;"></div>
										<script>
											var options = {
												'dataset':{
													title: '재학생 상담신청 답변현황 - 공통질문2',
													values:[
														<c:out value='${statusInfo.totTans21 }'/>
														, <c:out value='${statusInfo.totTans22 }'/>
														, <c:out value='${statusInfo.totTans23 }'/>
														, <c:out value='${statusInfo.totTans24 }'/>
														, <c:out value='${statusInfo.totTans25 }'/>
													],
													colorset: [
														'#DC143C', '#FF8C00', "#30a1ce", "#7700FF", "#00FFC7"
													],
													fields: [
														'1학년', '2학년', '3학년', '4학년', '전 학년 공통'
													],
												},
												'donut_width' : 130,
												'core_circle_radius':0,
												'chartDiv': 'Nwagon10',
												'chartType': 'pie',
												'chartSize': {width:900, height:400}
											};
											Nwagon.chart(options);
										</script>
									</td>
								</tr>
							</tbody>
						</table>
						<!-- 외국인 - end -->
					</c:if>
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