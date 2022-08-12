<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>

<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=inc/incHead" />
<!-- cctv init! -->
<script language='VBScript' type="text/vbscript">
Sub Window_onBeforeUnload()
	WatSearCtrl.finalize
	WatSearCtrl2.finalize
End Sub
</script>
<style>
	iframe {
	  border: 0 ;
	}
</style>
<body>
	<!-- top menu - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incTopnav"/>
	<!-- top menu - end -->
	<div class="m_body">
		<div class="main_content02">
			<div class="content">
				<div class="new m_title">
					<div class="title">기후경영</div>
				</div>
				<div class="cont_box">
					<!-- GRAPH_BOX multi_box 안 div 최대 4개 -->
					<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/dashboard/dashboardTop"/>
					<!--// GRAPH_BOX -->
					<div class="grid_box2">
						<div>
							<div class="div_half">
								<div class="grid_title">
										<ul class="twoLi">
											<li>미세먼지 예보</li>
											<li><a href="#" onclick="popup_name(life_measure_popup, 'dust', '미세먼지 지수'); return false;">관련기준</a></li>
										</ul>
								</div>
								<dl class="state_article">
									<c:choose>
										<c:when test="${pm10VO.caistep == '좋음' }"><dd class="state01">좋음</dd></c:when>
										<c:when test="${pm10VO.caistep == '보통' }"><dd class="state02">보통</dd></c:when>
										<c:when test="${pm10VO.caistep == '나쁨' }"><dd class="state03">나쁨</dd></c:when>
										<c:when test="${pm10VO.caistep == '매우나쁨' }"><dd class="state04">매우나쁨</dd></c:when>
									</c:choose>
			       					<dd class="message"><c:out value="${pm10VO.applcDt }"/><br /><br /> <c:out value="${pm10VO.alarmCndt }"/></dd>
			       				</dl>
							</div>
							
							<div class="div_half">
								<div class="grid_title"> <!-- 초미세먼지 -->
										<ul class="twoLi">
											<li>초미세먼지 예보</li>
											<li><a href="#" onclick="popup_name(life_measure_popup, 'uDust', '초미세먼지 지수'); return false;">관련기준</a></li>
										</ul>
								</div>
								<dl class="state_article">
			       					<c:choose>
										<c:when test="${pm25VO.caistep == '좋음' }"><dd class="state01">좋음</dd></c:when>
										<c:when test="${pm25VO.caistep == '보통' }"><dd class="state02">보통</dd></c:when>
										<c:when test="${pm25VO.caistep == '나쁨' }"><dd class="state03">나쁨</dd></c:when>
										<c:when test="${pm25VO.caistep == '매우나쁨' }"><dd class="state04">매우나쁨</dd></c:when>
									</c:choose>
			       					<dd class="message"><c:out value="${pm25VO.applcDt }"/><br /><br /> <c:out value="${pm25VO.alarmCndt }"/></dd>
			       				</dl>
							</div>
							
							<div class="div_half">
								<div class="grid_title"> <!-- 자외선 -->
										<ul class="twoLi">
											<li>자외선 지수(연중)</li>
											<li><a href="#" onclick="popup_name(life_measure_popup, 'ultra', '자외선 지수'); return false;">대응요령</a></li>
										</ul>
								</div>
								<div class="boxstep_article">
			       					<ol>
			       						<!-- 선택단계의 span에 class="on"부여하고 텍스트에 <mark></mark> 태그를 씌워주세요 -->
			       						<li class="step01">
			       							<c:if test="${a07VO.value == '1' }"><span class="on"><mark>낮음</mark></span></c:if>
			       							<c:if test="${a07VO.value != '1' }"><span>낮음</span></c:if>
			       						</li>
			       						<li class="step02">
			       							<c:if test="${a07VO.value == '2' }"><span class="on"><mark>보통</mark></span></c:if>
			       							<c:if test="${a07VO.value != '2' }"><span>보통</span></c:if>
			       						</li>
			       						<li class="step03">
			       							<c:if test="${a07VO.value == '3' }"><span class="on"><mark>높음</mark></span></c:if>
			       							<c:if test="${a07VO.value != '3' }"><span>높음</span></c:if>
			       						</li>
			       						<li class="step04">
			       							<c:if test="${a07VO.value == '4' }"><span class="on"><mark>매우높음</mark></span></c:if>
			       							<c:if test="${a07VO.value != '4' }"><span>매우높음</span></c:if>
			       						</li>
			       						<li class="step05">
			       							<c:if test="${a07VO.value == '5' }"><span class="on"><mark>매우높음</mark></span></c:if>
			       							<c:if test="${a07VO.value != '5' }"><span>매우높음</span></c:if>
			       						</li>
			       					</ol>
			       				</div><!-- //boxstep_article  -->
			       				<div class="boxstep_content">
			       					<c:out value="${a07VO.baseDate }"/>
			       				</div>
							</div>
							
							<%-- <div class="div_half">
								<div class="grid_title"> <!-- 뇌졸중 -->
										<ul class="twoLi">
											<li>뇌졸중 지수(연중)</li>
											<li><a href="#" onclick="popup_name(life_measure_popup, 'brain', '뇌졸증 지수'); return false;" id="yeoui">대응요령</a></li>
										</ul>
								</div>
								<div class="boxstep_article">
			       					<ol>
			       						<!-- 선택단계의 span에 class="on"부여하고 텍스트에 <mark></mark> 태그를 씌워주세요 -->
			       						<li class="li_v2 step01">
			       							<c:if test="${d02VO.value == '0' }"><span class="on"><mark>낮음</mark></span></c:if>
			       							<c:if test="${d02VO.value != '0' }"><span>낮음</span></c:if>
			       						</li>
			       						<li class="li_v2 step02">
			       							<c:if test="${d02VO.value == '1' }"><span class="on"><mark>보통</mark></span></c:if>
			       							<c:if test="${d02VO.value != '1' }"><span>보통</span></c:if>
			       						</li>
			       						<li class="li_v2 step03">
			       							<c:if test="${d02VO.value == '2' }"><span class="on"><mark>높음</mark></span></c:if>
			       							<c:if test="${d02VO.value != '2' }"><span>높음</span></c:if>
			       						</li>
			       						<li class="li_v2 step04">
			       							<c:if test="${d02VO.value == '3' }"><span class="on"><mark>매우높음</mark></span></c:if>
			       							<c:if test="${d02VO.value != '3' }"><span>매우높음</span></c:if>
			       						</li>
			       					</ol>
			       				</div><!-- //boxstep_article  -->
			       				<div class="boxstep_content">
			       					<c:out value="${d02VO.baseDate }"/>
			       				</div>
							</div> --%>
							<%-- <div class="div_half">
								<div class="grid_title"> <!-- 초미세먼지 -->
										<ul class="twoLi">
											<li>초미세먼지 예보</li>
											<li><a href="#" onclick="popup_name(life_measure_popup, 'uDust', '초미세먼지 지수'); return false;">관련기준</a></li>
										</ul>
								</div>
								<dl class="state_article">
			       					<c:choose>
										<c:when test="${pm25VO.caistep == '좋음' }"><dd class="state01">좋음</dd></c:when>
										<c:when test="${pm25VO.caistep == '보통' }"><dd class="state02">보통</dd></c:when>
										<c:when test="${pm25VO.caistep == '나쁨' }"><dd class="state03">나쁨</dd></c:when>
										<c:when test="${pm25VO.caistep == '매우나쁨' }"><dd class="state04">매우나쁨</dd></c:when>
									</c:choose>
			       					<dd class="message"><c:out value="${pm25VO.applcDt }"/><br /><br /> <c:out value="${pm25VO.alarmCndt }"/></dd>
			       				</dl>
							</div>

							<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incWeatherLife"/> --%>
							
							<div class="w100_p">
								<div class="grid_table td_h47_2" style="padding-left:0;">
									<div class="grid_table_caption">
										<p class="middleTitle" style="width: 20% !important;">날씨예보</p>
										<p class="middleLink" style="width: 78% !important;">
											<a href="http://www.kma.go.kr" target="_blank1">한국기상청</a> 
											/
											<a href="https://www.metoc.navy.mil/jtwc/jtwc.html" target="_blan2">미국기상청</a> 
											/
											<a href="https:/tenki.jp/bousai/typhoon/" target="_blank3">일본기상청</a>
										</p>
									</div>
									
									<table>
									<thead>
										<tr>
											<th>날짜</th>
											<th colspan="<c:out value="${colspan1_8*2 }"/>"><c:out value="${day1_8 }"/></th>
											<th colspan="<c:out value="${colspan2_8*2 }"/>"><c:out value="${day2_8 }"/></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>시간</td>
											 <c:forEach items="${weatherList_8 }" var="weather" varStatus="status">
												<c:set var="time" value = "${fn:substring(weather.fcstTime, 0, 2)}" />
												<td colspan="2"><c:out value="${time }"/>시</td>
											</c:forEach> 
										</tr>
										<tr>
											<td>날씨</td>
											<c:forEach items="${weatherList_8 }" var="weather" varStatus="status">
												<td colspan="2" class="wd_img"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_img3/w_icon${weather.status }.png'/>" style="width:40%;" alt="비" onerror='this.src="<c:out value="${pageContext.request.contextPath}/assets/img/w_icon.png" />"' /></td>
											</c:forEach> 
										</tr>
										<tr>
											<td>강수확률</td>
										 <c:forEach items="${weatherList_8 }" var="weather" varStatus="status">
												<td colspan="2"><c:out value="${weather.pop }"/>%</td>
											</c:forEach> 
										</tr>
										<tr>
											<td>강수량</td>
										 	<c:forEach items="${weatherList_8 }" var="weather" varStatus="status">
												<c:set var="time" value = "${fn:substring(weather.fcstTime, 0, 2)}" />
												<td colspan="2">
												<c:out value="${weather.pcp }"/>
												</td>
												<%-- <c:choose>
													<c:when test="${(time%6)==0 }" >
														<c:choose>
															<c:when test="${status.first }">
																<td colspan="5">
																<c:if test="${weather.r06 != '0' }"><c:out value="${weather.r06 }"/>mm</c:if>
																	<c:if test="${weather.r06 == '0' }">-</c:if>
																</td>
															</c:when>
															<c:when test="${status.last }">
																<!-- 지우면 표가 깨짐 -->
															</c:when>
															<c:when test="${status.count==6 }">
																<td colspan="5">
																	<c:if test="${weather.r06 != '0' }"><c:out value="${weather.r06 }"/>mm</c:if>
																	<c:if test="${weather.r06 == '0' }">-</c:if>
																</td>
															</c:when>
															<c:when test="${status.count==7 }">
																<td colspan="3">
																	<c:if test="${weather.r06 != '0' }"><c:out value="${weather.r06 }"/>mm</c:if>
																	<c:if test="${weather.r06 == '0' }">-</c:if>
																</td>
															</c:when>
															<c:when test="${status.count!=6 }">
																<td colspan="4">
																	<c:if test="${weather.r06 != '0' }"><c:out value="${weather.r06 }"/>mm</c:if>
																	<c:if test="${weather.r06 == '0' }">-</c:if>
																</td>
															</c:when>
														</c:choose>
													</c:when>
													<c:when test="${(time%6)==3 }" >
														<c:if test="${status.first }">
															<td colspan="3">
																<c:if test="${fristTimeMap_8.r06 != '0' }"><c:out value="${fristTimeMap_8.r06 }"/>mm	</c:if>
																<c:if test="${fristTimeMap_8.r06 == '0' }">-</c:if>
															</td>
														</c:if>
													</c:when>
												</c:choose> --%>
											</c:forEach> 
										</tr>
									</tbody>
								</table>
									
									<%--
									 
									<table id="singokPreWeather">
										<thead>
											<tr>
												<th>날짜</th>
												<th colspan="2"><c:out value="${middleVO.date3 }"/></th>
												<th colspan="2"><c:out value="${middleVO.date4 }"/></th>
												<th colspan="2"><c:out value="${middleVO.date5 }"/></th>
												<th colspan="2"><c:out value="${middleVO.date6 }"/></th>
												<th colspan="2"><c:out value="${middleVO.date7 }"/></th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>시간</td>
												<td>오전</td>
												<td>오후</td>
												<td>오전</td>
												<td>오후</td>
												<td>오전</td>
												<td>오후</td>
												<td>오전</td>
												<td>오후</td>
												<td>오전</td>
												<td>오후</td>
											</tr>
											<tr>
												<td>날씨</td>
												<td class="wd_img02"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_icon${middleVO.wf3AmIcon }.png'/>" alt="<c:out value='${middleVO.wf3Am }'/>" /></td>
												<td class="wd_img02"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_icon${middleVO.wf3PmIcon }.png'/>" alt="<c:out value='${middleVO.wf3Pm }'/>" /></td>
												<td class="wd_img02"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_icon${middleVO.wf4AmIcon }.png'/>" alt="<c:out value='${middleVO.wf4Am }'/>" /></td>
												<td class="wd_img02"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_icon${middleVO.wf4PmIcon }.png'/>" alt="<c:out value='${middleVO.wf4Pm }'/>" /></td>
												<td class="wd_img02"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_icon${middleVO.wf5AmIcon }.png'/>" alt="<c:out value='${middleVO.wf5Am }'/>" /></td>
												<td class="wd_img02"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_icon${middleVO.wf5PmIcon }.png'/>" alt="<c:out value='${middleVO.wf5Pm }'/>" /></td>
												<td class="wd_img02"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_icon${middleVO.wf6AmIcon }.png'/>" alt="<c:out value='${middleVO.wf6Am }'/>" /></td>
												<td class="wd_img02"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_icon${middleVO.wf6PmIcon }.png'/>" alt="<c:out value='${middleVO.wf6Pm }'/>" /></td>
												<td class="wd_img02"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_icon${middleVO.wf7AmIcon }.png'/>" alt="<c:out value='${middleVO.wf7Am }'/>" /></td>
												<td class="wd_img02"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_icon${middleVO.wf7PmIcon }.png'/>" alt="<c:out value='${middleVO.wf7Pm }'/>" /></td>
											</tr>
											<tr>
												<td>온도</td>
												<td colspan="2">최저:<c:out value="${middleVO.taMin3 }"/>℃ / 최고:<c:out value="${middleVO.taMax3 }"/>℃</td>
												<td colspan="2">최저:<c:out value="${middleVO.taMin4 }"/>℃ / 최고:<c:out value="${middleVO.taMax4 }"/>℃</td>
												<td colspan="2">최저:<c:out value="${middleVO.taMin5 }"/>℃ / 최고:<c:out value="${middleVO.taMax5 }"/>℃</td>
												<td colspan="2">최저:<c:out value="${middleVO.taMin6 }"/>℃ / 최고:<c:out value="${middleVO.taMax6 }"/>℃</td>
												<td colspan="2">최저:<c:out value="${middleVO.taMin7 }"/>℃ / 최고:<c:out value="${middleVO.taMax7 }"/>℃</td>
											</tr>
											<tr>
												<td>강수<br/>확률</td>
												<td><c:out value="${middleVO.rnSt3Am }"/>%</td>
												<td><c:out value="${middleVO.rnSt3Pm }"/>%</td>
												<td><c:out value="${middleVO.rnSt4Am }"/>%</td>
												<td><c:out value="${middleVO.rnSt4Pm }"/>%</td>
												<td><c:out value="${middleVO.rnSt5Am }"/>%</td>
												<td><c:out value="${middleVO.rnSt5Pm }"/>%</td>
												<td><c:out value="${middleVO.rnSt6Am }"/>%</td>
												<td><c:out value="${middleVO.rnSt6Pm }"/>%</td>
												<td><c:out value="${middleVO.rnSt7Am }"/>%</td>
												<td><c:out value="${middleVO.rnSt7Pm }"/>%</td>
											</tr>
										</tbody>
									</table>
									--%>
								</div>
							</div>
						</div>
						<div>
							<div>
									<div class="grid_title">
										<ul class="twoLi">
											<li>
													교통정보
											</li>
											<li>
												<a id="seoulMapBtn" href="http://smartway.seoul.go.kr/m/StatMap.view" target="_blank">스마트웨이보기</a>
												<a id="gisMapBtn" href="javascript:chageMap(true);" style="display: none;" >이미지지도보기</a>
											</li>
										</ul>
									</div>
									<div class="gf_box2">
										<div id="seoulMap1" style="width: 100%;height: 100%;">
<!-- 											<embed src="http://www.smartway.seoul.kr/m/statMap.view" width="100%" height="100%"></embed> -->
											<iframe src="http://smartway.seoul.go.kr/m/StatMap.view" width="100%" height="100%" scrolling="no"></iframe>
										</div>
										<div id="map3" style="width:100%;height:100%;display: none; "></div>
										<div style="display: block;position: relative;width: 50px;height: 50px;z-index: 1;top:-99%;left: 1%;">

										<span class="map_plus" id="mapPlus"><a href="#" onclick="popup_name(map_popup); return false;"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/map_plus.png'/>" alt="지도확대" /></a></span>
											
										</div>
										<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/dashboard/map/map3"/>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	
	<!--지도 크게 보기 팝업 -->
	<div class="map_big_mode" id="map_popup" style="visibility: hidden;">
		<div class="mb_box">
			<div class="mb_mode">교통정보
				<button onclick="popup_name(map_popup); return false;">닫기</button>
			</div>
			<div class="mb_map">
				
<%-- 				<div class="mb_btn"><a href="#"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/map_plus.png'/>" /></a></div> --%>
				
				<div class="big_map">
					<div id="map4" style="width:100%;height:100%;display: none;"></div>
					<div id="seoulMap2" style="width:100%;height:100%;">
<!-- 						<embed src="http://www.smartway.seoul.kr/m/statMap.view" width="100%" height="100%"></embed> -->
						<iframe src="http://smartway.seoul.go.kr/m/StatMap.view" width="100%" height="100%" scrolling="no"></iframe>
						</div>
				</div>
				
				
				
				<div>
					<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/dashboard/map/map4"/>
				</div>
				
				
			</div>
		</div>
	</div>
	
	<!--// 대응요령 보기 팝업 -->
	<div class="map_big_mode" id="life_measure_popup" style="visibility: hidden;">
		<div class="mb_box2" style="height:auto !important;">
			<div class="mb_mode">
				<span id="life_measure_title"></span> <span class="informer1"></span>
				<button onclick="popup_name(life_measure_popup); return false;">닫기</button>
			</div>
			<div class="mb_map2">
				<div style="width:100%;height:95%;">
					<div id="dustGuide" style="display:none;font-size: 1.5em">
					<%--
						<b style="color:orange;">미세먼지 예·경보제</b>는 시민여러분의 실외활동과 건강관리를 위하여 시행하는 제도 입니다. 
						<br/>예보는 매일 미세먼지 농도지수를 예측하여 오늘 예보는 05시, 11시 기준, 
						<br/>내일 예보는 17시, 23시 기준으로 국립환경과학원 발표자료를 홈페이지를 통해 알려 드리며, 
						<br/>경보(주의보,경보)는 미세먼지 농도가 일정기준 이상으로 상승하여
						<br/> 건강에 해를 줄 염려가 있을 때 경보내용과 행동요령을 안내하고 있습니다.
					 --%>
					</div>
					<div id="uDustGuide" style="display:none;font-size: 1.5em">
					<%--
						<b style="color:orange;">초미세먼지 예·경보제</b>는 시민여러분의 실외활동과 건강관리를 위하여 시행하는 제도 입니다. 
						<br/>예보는 매일 초미세먼지 농도지수를 예측하여 오늘 예보는 05시, 11시 기준 , 
						<br/>내일 예보는 17시, 23시 기준으로 국립환경과학원 발표자료를 홈페이지를 통해 알려 드리며, 
						<br/>경보(주의보,경보)는 초미세먼지 농도가 일정기준 이상으로 상승하여 
						<br/>건강에 해를 줄 염려가 있을 때 경보내용과 행동요령을 안내하고 있습니다.
						<br/>
					 --%>
					</div>
					
					<img src="" id="lifeMeasure" alt="test"  width="100%"  height="100%"/>
					<br/>
					<span class="informer2"></span>
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- footer -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!-- footer -->
	<input type="hidden" id="message" name="message" value="${message }">
	<script type="text/javascript">
		
		function fn_snsSubmit(){
			var snsContent = $("#snsContent").val();
			
			if(snsContent == '' || snsContent.length >150){
				alert("150자 이하로 작성해주세요.");
			}else{
				$.ajax({
					url: "<c:url value='/usr/dashboard/mainSnsSubmitAjax.do'/>"
					, type: "post"
					, data: {
						snsContent : snsContent
					}
					, dataType:"json"
					, async : false
					, success: function(data){
						alert("등록되었습니다.");
						$("#snsContent").val('');
						fn_snsReload();
					}, error: function(){
						alert("오류가 발생하였습니다.");
					}
				});
			}
			
		}
		
		function fn_snsReload(){
			$.ajax({
				url: "<c:url value='/usr/dashboard/mainSnsReloadAjax.do'/>"
				, type: "post"
				, dataType:"json"
				, async : false
				, success: function(data){
					var resultList = data.resultList;
					var tag = '';
					for(var i=0; i<resultList.length; i++){
							tag += '<ul>';
							tag += '	<li>'+resultList[i].regNm+'<span>'+resultList[i].regDttm+'</span></li>';
						if(resultList[i].tType =='D'){
							tag += '	<li>'+resultList[i].content+'</li>';
						}else if(resultList[i].tType == 'FC'){
							tag +=  '<li>' +resultList[i].content +' 발령</li>';
						}else{
							tag += '	<li>'+resultList[i].title+'</br>'+resultList[i].content+'</li>';
						}
						tag += '</ul>';
					}
					$("#snsBoard").html(tag);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
		
		//탭전환
		function fn_changeDiv(value){
			
			if($("#changeDiv_"+value+"1").css("display") == "block"){
				$("#changeDiv_"+value+"1").css("display", "none");
				$("#changeDiv_"+value+"2").css("display", "block");
				$("#title_"+value).html("그래프보기");
			}else{
				$("#changeDiv_"+value+"2").css("display", "none");
				$("#changeDiv_"+value+"1").css("display", "block");
				$("#title_"+value).html("표로보기");
			}
		}
		
		$(function(){
			fn_createMap();
			$(window).resize(function(){
				fn_createMap3();
				fn_createMap();
			});
		});
		
		
		// 지도 전환
		function chageMap(mapFlag) {

			if(mapFlag) {
				$("#seoulMap1").show();
				$("#seoulMap2").show();
				$("#seoulMapBtn").show();

				$("#map3").hide();
				$("#map4").hide();
				$("#gisMapBtn").hide();
				
			}else {				
				
				$("#gisMapBtn").show();
				$("#map3").show();
				$("#map4").show();

				fn_createMap3();
				fn_createMap();
				
				$("#seoulMap1").hide();
				$("#seoulMap2").hide();
				$("#seoulMapBtn").hide();
				
			}
			
		}
	</script>
</body>

</html>