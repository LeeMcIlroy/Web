<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="kr">
	<c:import url="/EgovPageLink.do?link=inc/incHead" />
	<body class="sub_page">
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
						<div class="title">기상정보</div>
						<div class="navi">
							<ul>
								<li>HOME</li>
								<li>상세관측정보</li>
								<li>기상정보</li>
							</ul>
						</div>
					</div>
					<div class="reload"><a href="#"><c:out value="${weather_1.baseDate }"/> <c:out value="${weather_1.baseTime }"/></a></div>
					<div class="cont_box">
						<div class="wt_box">
							<div class="wt_title">
								<p>서울시 현재날씨</p>
							</div>
							<div class="wt_icon">								
								<div><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_img1/w_icon${weather_1.pty }.png'/>"  alt="날씨" onerror='this.src="<c:out value="${pageContext.request.contextPath}/assets/img/w_icon.png" />"'/></div>
							</div>
							<div class="wt_info">
								<ul>
									<li>온도: <c:out value="${weather_1.t1h }"/>℃</li>
									<li>습도: <c:out value="${weather_1.reh }"/>%</li>
									<li>1시간 강수량: <c:out value="${weather_1.rn1 }"/>mm</li>
									<li>누적 강수량: <c:out value="${weather_1.rn24 }"/>mm</li>
								</ul>
							</div>
						</div>
						<div class="wt_table">
							<div class="grid_table td_h47">
								<table>
									<thead>
										<tr>
											<th>날짜</th>
											<th colspan="<c:out value="${colspan1_1*2 }"/>"><c:out value="${day1_1 }"/></th>
											<th colspan="<c:out value="${colspan2_1*2 }"/>"><c:out value="${day2_1 }"/></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>시간</td>
											<c:forEach items="${weatherList_1 }" var="weather" varStatus="status">
												<c:set var="time" value = "${fn:substring(weather.fcstTime, 0, 2)}" />
												<td colspan="2"><c:out value="${time }"/>시</td>
											</c:forEach>
										</tr>
										<tr>
											<td>날씨</td>
											<c:forEach items="${weatherList_1 }" var="weather" varStatus="status">
												<td colspan="2" class="wd_img"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_img3/w_icon${weather.status }.png'/>" style="width:40%;" alt="비" onerror='this.src="<c:out value="${pageContext.request.contextPath}/assets/img/w_icon.png" />"' alt=""/></td>
											</c:forEach>
										</tr>
										<tr>
											<td>강수확률</td>
											<c:forEach items="${weatherList_1 }" var="weather" varStatus="status">
												<td colspan="2"><c:out value="${weather.pop }"/>%</td>
											</c:forEach>
										</tr>
										<tr>
											<td>강수량</td>
											<c:forEach items="${weatherList_1 }" var="weather" varStatus="status">
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
																<c:if test="${fristTimeMap_1.r06 != '0' }"><c:out value="${fristTimeMap_1.r06 }"/>mm	</c:if>
																<c:if test="${fristTimeMap_1.r06 == '0' }">-</c:if>
															</td>
														</c:if>
													</c:when>
												</c:choose> --%>
											</c:forEach>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="cont_box">
						<div class="wt_box">
							<div class="wt_title">
								<p>신곡동 현재날씨</p>
							</div>
								<div class="wt_icon">								
								<div><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_img1/w_icon${weather_2.pty }.png'/>"  alt="비" onerror='this.src="<c:out value="${pageContext.request.contextPath}/assets/img/w_icon.png" />"' /></div>
							</div>
							<div class="wt_info">
								<ul>
									<li>온도: <c:out value="${weather_2.t1h }"/>℃</li>
									<li>습도: <c:out value="${weather_2.reh }"/>%</li>
									<li>1시간 강수량: <c:out value="${weather_2.rn1 }"/>mm</li>
									<li>누적 강수량: <c:out value="${weather_2.rn24 }"/>mm</li>
								</ul>
							</div>
						</div>
						<div class="wt_table">
							<div class="grid_table td_h47">
								<table>
									<thead>
										<tr>
											<th>날짜</th>
											<th colspan="<c:out value="${colspan1_2*2 }"/>"><c:out value="${day1_2 }"/></th>
											<th colspan="<c:out value="${colspan2_2*2 }"/>"><c:out value="${day2_2 }"/></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>시간</td>
											<c:forEach items="${weatherList_2 }" var="weather" varStatus="status">
												<c:set var="time" value = "${fn:substring(weather.fcstTime, 0, 2)}" />
												<td colspan="2"><c:out value="${time }"/>시</td>
											</c:forEach>
										</tr>
										<tr>
											<td>날씨</td>
											<c:forEach items="${weatherList_2 }" var="weather" varStatus="status">
												<td colspan="2" class="wd_img"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_img3/w_icon${weather.status }.png'/>" style="width:40%;" alt="비" onerror='this.src="<c:out value="${pageContext.request.contextPath}/assets/img/w_icon.png" />"' /></td>
											</c:forEach>
										</tr>
										<tr>
											<td>강수확률</td>
											<c:forEach items="${weatherList_2 }" var="weather" varStatus="status">
												<td colspan="2"><c:out value="${weather.pop }"/>%</td>
											</c:forEach>
										</tr>
										<tr>
											<td>강수량</td>
											<c:forEach items="${weatherList_2 }" var="weather" varStatus="status">
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
																<c:if test="${fristTimeMap_2.r06 != '0' }"><c:out value="${fristTimeMap_2.r06 }"/>mm	</c:if>
																<c:if test="${fristTimeMap_2.r06 == '0' }">-</c:if>
															</td>
														</c:if>
													</c:when>
												</c:choose> --%>
											</c:forEach>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="cont_box">
						<div class="wt_box">
							<div class="wt_title">
								<p>강서구 현재날씨</p>
							</div>
							<div class="wt_icon">								
								<div><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_img1/w_icon${weather_3.pty }.png'/>"  alt="비" onerror='this.src="<c:out value="${pageContext.request.contextPath}/assets/img/w_icon.png" />"' /></div>
							</div>
							<div class="wt_info">
								<ul>
									<li>온도: <c:out value="${weather_3.t1h }"/>℃</li>
									<li>습도: <c:out value="${weather_3.reh }"/>%</li>
									<li>1시간 강수량: <c:out value="${weather_3.rn1 }"/>mm</li>
									<li>누적 강수량: <c:out value="${weather_3.rn24 }"/>mm</li>
								</ul>
							</div>
						</div>
						<div class="wt_table">
							<div class="grid_table td_h47">
								<table>
									<thead>
										<tr>
											<th>날짜</th>
											<th colspan="<c:out value="${colspan1_3*2 }"/>"><c:out value="${day1_3 }"/></th>
											<th colspan="<c:out value="${colspan2_3*2 }"/>"><c:out value="${day2_3 }"/></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>시간</td>
											<c:forEach items="${weatherList_3 }" var="weather" varStatus="status">
												<c:set var="time" value = "${fn:substring(weather.fcstTime, 0, 2)}" />
												<td colspan="2"><c:out value="${time }"/>시</td>
											</c:forEach>
										</tr>
										<tr>
											<td>날씨</td>
											<c:forEach items="${weatherList_3 }" var="weather" varStatus="status">
												<td colspan="2" class="wd_img"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_img3/w_icon${weather.status }.png'/>" style="width:40%;" alt="비" onerror='this.src="<c:out value="${pageContext.request.contextPath}/assets/img/w_icon.png" />"' /></td>
											</c:forEach>
										</tr>
										<tr>
											<td>강수확률</td>
											<c:forEach items="${weatherList_3 }" var="weather" varStatus="status">
												<td colspan="2"><c:out value="${weather.pop }"/>%</td>
											</c:forEach>
										</tr>
										<tr>
											<td>강수량</td>
											<c:forEach items="${weatherList_3 }" var="weather" varStatus="status">
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
																<c:if test="${fristTimeMap_3.r06 != '0' }"><c:out value="${fristTimeMap_3.r06 }"/>mm	</c:if>
																<c:if test="${fristTimeMap_3.r06 == '0' }">-</c:if>
															</td>
														</c:if>
													</c:when>
												</c:choose> --%>
											</c:forEach>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="cont_box">
						<div class="wt_box">
							<div class="wt_title">
								<p>관악구 현재날씨</p>
							</div>
							<div class="wt_icon">								
								<div><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_img1/w_icon${weather_4.pty }.png'/>"  alt="비" onerror='this.src="<c:out value="${pageContext.request.contextPath}/assets/img/w_icon.png" />"' /></div>
							</div>
							<div class="wt_info">
								<ul>
									<li>온도: <c:out value="${weather_4.t1h }"/>℃</li>
									<li>습도: <c:out value="${weather_4.reh }"/>%</li>
									<li>1시간 강수량: <c:out value="${weather_4.rn1 }"/>mm</li>
									<li>누적 강수량: <c:out value="${weather_4.rn24 }"/>mm</li>
								</ul>
							</div>
						</div>
						<div class="wt_table">
							<div class="grid_table td_h47">
								<table>
									<thead>
										<tr>
											<th>날짜</th>
											<th colspan="<c:out value="${colspan1_4*2 }"/>"><c:out value="${day1_4 }"/></th>
											<th colspan="<c:out value="${colspan2_4*2 }"/>"><c:out value="${day2_4 }"/></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>시간</td>
											<c:forEach items="${weatherList_4 }" var="weather" varStatus="status">
												<c:set var="time" value = "${fn:substring(weather.fcstTime, 0, 2)}" />
												<td colspan="2"><c:out value="${time }"/>시</td>
											</c:forEach>
										</tr>
										<tr>
											<td>날씨</td>
											<c:forEach items="${weatherList_4 }" var="weather" varStatus="status">
												<td colspan="2" class="wd_img"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_img3/w_icon${weather.status }.png'/>" style="width:40%;" alt="비" onerror='this.src="<c:out value="${pageContext.request.contextPath}/assets/img/w_icon.png" />"' /></td>
											</c:forEach>
										</tr>
										<tr>
											<td>강수확률</td>
											<c:forEach items="${weatherList_4 }" var="weather" varStatus="status">
												<td colspan="2"><c:out value="${weather.pop }"/>%</td>
											</c:forEach>
										</tr>
										<tr>
											<td>강수량</td>
											<c:forEach items="${weatherList_4 }" var="weather" varStatus="status">
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
																<c:if test="${fristTimeMap_4.r06 != '0' }"><c:out value="${fristTimeMap_4.r06 }"/>mm	</c:if>
																<c:if test="${fristTimeMap_4.r06 == '0' }">-</c:if>
															</td>
														</c:if>
													</c:when>
												</c:choose> --%>
											</c:forEach>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="cont_box">
						<div class="wt_box">
							<div class="wt_title">
								<p>강동구 현재날씨</p>
							</div>
							<div class="wt_icon">								
								<div><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_img1/w_icon${weather_5.pty }.png'/>"  alt="비" onerror='this.src="<c:out value="${pageContext.request.contextPath}/assets/img/w_icon.png" />"' /></div>
							</div>
							<div class="wt_info">
								<ul>
									<li>온도: <c:out value="${weather_5.t1h }"/>℃</li>
									<li>습도: <c:out value="${weather_5.reh }"/>%</li>
									<li>1시간 강수량: <c:out value="${weather_5.rn1 }"/>mm</li>
									<li>누적 강수량: <c:out value="${weather_5.rn24 }"/>mm</li>
								</ul>
							</div>
						</div>
						<div class="wt_table">
							<div class="grid_table td_h47">
								<table>
									<thead>
										<tr>
											<th>날짜</th>
											<th colspan="<c:out value="${colspan1_5*2 }"/>"><c:out value="${day1_5 }"/></th>
											<th colspan="<c:out value="${colspan2_5*2 }"/>"><c:out value="${day2_5 }"/></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>시간</td>
											<c:forEach items="${weatherList_5 }" var="weather" varStatus="status">
												<c:set var="time" value = "${fn:substring(weather.fcstTime, 0, 2)}" />
												<td colspan="2"><c:out value="${time }"/>시</td>
											</c:forEach>
										</tr>
										<tr>
											<td>날씨</td>
											<c:forEach items="${weatherList_5 }" var="weather" varStatus="status">
												<td colspan="2" class="wd_img"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_img3/w_icon${weather.status }.png'/>" style="width:40%;" alt="비" onerror='this.src="<c:out value="${pageContext.request.contextPath}/assets/img/w_icon.png" />"' /></td>
											</c:forEach>
										</tr>
										<tr>
											<td>강수확률</td>
											<c:forEach items="${weatherList_5 }" var="weather" varStatus="status">
												<td colspan="2"><c:out value="${weather.pop }"/>%</td>
											</c:forEach>
										</tr>
										<tr>
											<td>강수량</td>
											<c:forEach items="${weatherList_5 }" var="weather" varStatus="status">
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
																<c:if test="${fristTimeMap_5.r06 != '0' }"><c:out value="${fristTimeMap_5.r06 }"/>mm	</c:if>
																<c:if test="${fristTimeMap_5.r06 == '0' }">-</c:if>
															</td>
														</c:if>
													</c:when>
												</c:choose> --%>
											</c:forEach>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="cont_box">
						<div class="wt_box">
							<div class="wt_title">
								<p>마포구 현재날씨</p>
							</div>
							<div class="wt_icon">								
								<div><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_img1/w_icon${weather_6.pty }.png'/>"  alt="비" onerror='this.src="<c:out value="${pageContext.request.contextPath}/assets/img/w_icon.png" />"' /></div>
							</div>
							<div class="wt_info">
								<ul>
									<li>온도: <c:out value="${weather_6.t1h }"/>℃</li>
									<li>습도: <c:out value="${weather_6.reh }"/>%</li>
									<li>1시간 강수량: <c:out value="${weather_6.rn1 }"/>mm</li>
									<li>누적 강수량: <c:out value="${weather_6.rn24 }"/>mm</li>
								</ul>
							</div>
						</div>
						<div class="wt_table">
							<div class="grid_table td_h47">
								<table>
									<thead>
										<tr>
											<th>날짜</th>
											<th colspan="<c:out value="${colspan1_6*2 }"/>"><c:out value="${day1_6 }"/></th>
											<th colspan="<c:out value="${colspan2_6*2 }"/>"><c:out value="${day2_6 }"/></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>시간</td>
											<c:forEach items="${weatherList_6 }" var="weather" varStatus="status">
												<c:set var="time" value = "${fn:substring(weather.fcstTime, 0, 2)}" />
												<td colspan="2"><c:out value="${time }"/>시</td>
											</c:forEach>
										</tr>
										<tr>
											<td>날씨</td>
											<c:forEach items="${weatherList_6 }" var="weather" varStatus="status">
												<td colspan="2" class="wd_img"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_img3/w_icon${weather.status }.png'/>" style="width:40%;" alt="비" onerror='this.src="<c:out value="${pageContext.request.contextPath}/assets/img/w_icon.png" />"' /></td>
											</c:forEach>
										</tr>
										<tr>
											<td>강수확률</td>
											<c:forEach items="${weatherList_6 }" var="weather" varStatus="status">
												<td colspan="2"><c:out value="${weather.pop }"/>%</td>
											</c:forEach>
										</tr>
										<tr>
											<td>강수량</td>
											<c:forEach items="${weatherList_6 }" var="weather" varStatus="status">
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
																<c:if test="${fristTimeMap_6.r06 != '0' }"><c:out value="${fristTimeMap_6.r06 }"/>mm	</c:if>
																<c:if test="${fristTimeMap_6.r06 == '0' }">-</c:if>
															</td>
														</c:if>
													</c:when>
												</c:choose> --%>
											</c:forEach>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					
					<div class="cont_box">
						<div class="wt_box">
							<div class="wt_title">
								<p>월계1동 현재날씨</p>
							</div>
							<div class="wt_icon">								
								<div><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_img1/w_icon${weather_7.pty }.png'/>"  alt="비" onerror='this.src="<c:out value="${pageContext.request.contextPath}/assets/img/w_icon.png" />"' /></div>
							</div>
							<div class="wt_info">
								<ul>
									<li>온도: <c:out value="${weather_7.t1h }"/>℃</li>
									<li>습도: <c:out value="${weather_7.reh }"/>%</li>
									<li>1시간 강수량: <c:out value="${weather_7.rn1 }"/>mm</li>
									<li>누적 강수량: <c:out value="${weather_7.rn24 }"/>mm</li>
								</ul>
							</div>
						</div>
						<div class="wt_table">
							<div class="grid_table td_h47">
								<table>
									<thead>
										<tr>
											<th>날짜</th>
											<th colspan="<c:out value="${colspan1_7*2 }"/>"><c:out value="${day1_7 }"/></th>
											<th colspan="<c:out value="${colspan2_7*2 }"/>"><c:out value="${day2_7 }"/></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>시간</td>
											<c:forEach items="${weatherList_7 }" var="weather" varStatus="status">
												<c:set var="time" value = "${fn:substring(weather.fcstTime, 0, 2)}" />
												<td colspan="2"><c:out value="${time }"/>시</td>
											</c:forEach>
										</tr>
										<tr>
											<td>날씨</td>
											<c:forEach items="${weatherList_7 }" var="weather" varStatus="status">
												<td colspan="2" class="wd_img"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_img3/w_icon${weather.status }.png'/>" style="width:40%;" alt="비" onerror='this.src="<c:out value="${pageContext.request.contextPath}/assets/img/w_icon.png" />"' /></td>
											</c:forEach>
										</tr>
										<tr>
											<td>강수확률</td>
											<c:forEach items="${weatherList_7 }" var="weather" varStatus="status">
												<td colspan="2"><c:out value="${weather.pop }"/>%</td>
											</c:forEach>
										</tr>
										<tr>
											<td>강수량</td>
											<c:forEach items="${weatherList_7 }" var="weather" varStatus="status">
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
																<c:if test="${fristTimeMap_7.r06 != '0' }"><c:out value="${fristTimeMap_7.r06 }"/>mm	</c:if>
																<c:if test="${fristTimeMap_7.r06 == '0' }">-</c:if>
															</td>
														</c:if>
													</c:when>
												</c:choose> --%>
											</c:forEach>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					
					<div class="cont_box">
						<div class="wt_box">
							<div class="wt_title">
								<p>마장동 현재날씨</p>
							</div>
							<div class="wt_icon">								
								<div><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_img1/w_icon${weather_8.pty }.png'/>"  alt="비" onerror='this.src="<c:out value="${pageContext.request.contextPath}/assets/img/w_icon.png" />"' /></div>
							</div>
							<div class="wt_info">
								<ul>
									<li>온도: <c:out value="${weather_8.t1h }"/>℃</li>
									<li>습도: <c:out value="${weather_8.reh }"/>%</li>
									<li>1시간 강수량: <c:out value="${weather_8.rn1 }"/>mm</li>
									<li>누적 강수량: <c:out value="${weather_8.rn24 }"/>mm</li>
								</ul>
							</div>
						</div>
						<div class="wt_table">
							<div class="grid_table td_h47">
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
							</div>
						</div>
					</div>
					
					<div class="cont_box">
						<div class="wt_box">
							<div class="wt_title">
								<p>동두천시 현재날씨</p>
							</div>
							<div class="wt_icon">								
								<div><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_img1/w_icon${weather_9.pty }.png'/>"  alt="비" onerror='this.src="<c:out value="${pageContext.request.contextPath}/assets/img/w_icon.png" />"' /></div>
							</div>
							<div class="wt_info">
								<ul>
									<li>온도: <c:out value="${weather_9.t1h }"/>℃</li>
									<li>습도: <c:out value="${weather_9.reh }"/>%</li>
									<li>1시간 강수량: <c:out value="${weather_9.rn1 }"/>mm</li>
									<li>누적 강수량: <c:out value="${weather_9.rn24 }"/>mm</li>
								</ul>
							</div>
						</div>
						<div class="wt_table">
							<div class="grid_table td_h47">
								<table>
									<thead>
										<tr>
											<th>날짜</th>
											<th colspan="<c:out value="${colspan1_9*2 }"/>"><c:out value="${day1_9 }"/></th>
											<th colspan="<c:out value="${colspan2_9*2 }"/>"><c:out value="${day2_9 }"/></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>시간</td>
											<c:forEach items="${weatherList_9 }" var="weather" varStatus="status">
												<c:set var="time" value = "${fn:substring(weather.fcstTime, 0, 2)}" />
												<td colspan="2"><c:out value="${time }"/>시</td>
											</c:forEach>
										</tr>
										<tr>
											<td>날씨</td>
											<c:forEach items="${weatherList_9 }" var="weather" varStatus="status">
												<td colspan="2" class="wd_img"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_img3/w_icon${weather.status }.png'/>" style="width:40%;" alt="비" onerror='this.src="<c:out value="${pageContext.request.contextPath}/assets/img/w_icon.png" />"' /></td>
											</c:forEach>
										</tr>
										<tr>
											<td>강수확률</td>
											<c:forEach items="${weatherList_9 }" var="weather" varStatus="status">
												<td colspan="2"><c:out value="${weather.pop }"/>%</td>
											</c:forEach>
										</tr>
										<tr>
											<td>강수량</td>
											<c:forEach items="${weatherList_9 }" var="weather" varStatus="status">
												<c:set var="time" value = "${fn:substring(weather.fcstTime, 0, 2)}" />
												<td colspan="2">
													<c:out value="${weather.pcp }"/>
												</td>
											<%-- 	<c:choose>
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
																<c:if test="${fristTimeMap_9.r06 != '0' }"><c:out value="${fristTimeMap_9.r06 }"/>mm	</c:if>
																<c:if test="${fristTimeMap_9.r06 == '0' }">-</c:if>
															</td>
														</c:if>
													</c:when>
												</c:choose> --%>
											</c:forEach>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					
					<div class="cont_box">
						<div class="wt_box">
							<div class="wt_title">
								<p>의정부시 현재날씨</p>
							</div>
							<div class="wt_icon">								
								<div><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_img1/w_icon${weather_10.pty }.png'/>"  alt="비" onerror='this.src="<c:out value="${pageContext.request.contextPath}/assets/img/w_icon.png" />"' /></div>
							</div>
							<div class="wt_info">
								<ul>
									<li>온도: <c:out value="${weather_10.t1h }"/>℃</li>
									<li>습도: <c:out value="${weather_10.reh }"/>%</li>
									<li>1시간 강수량: <c:out value="${weather_10.rn1 }"/>mm</li>
									<li>누적 강수량: <c:out value="${weather_10.rn24 }"/>mm</li>
								</ul>
							</div>
						</div>
						<div class="wt_table">
							<div class="grid_table td_h47">
								<table>
									<thead>
										<tr>
											<th>날짜</th>
											<th colspan="<c:out value="${colspan1_10*2 }"/>"><c:out value="${day1_10 }"/></th>
											<th colspan="<c:out value="${colspan2_10*2 }"/>"><c:out value="${day2_10 }"/></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>시간</td>
											<c:forEach items="${weatherList_10 }" var="weather" varStatus="status">
												<c:set var="time" value = "${fn:substring(weather.fcstTime, 0, 2)}" />
												<td colspan="2"><c:out value="${time }"/>시</td>
											</c:forEach>
										</tr>
										<tr>
											<td>날씨</td>
											<c:forEach items="${weatherList_10 }" var="weather" varStatus="status">
												<td colspan="2" class="wd_img"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_img3/w_icon${weather.status }.png'/>" style="width:40%;" alt="비" onerror='this.src="<c:out value="${pageContext.request.contextPath}/assets/img/w_icon.png" />"' /></td>
											</c:forEach>
										</tr>
										<tr>
											<td>강수확률</td>
											<c:forEach items="${weatherList_10 }" var="weather" varStatus="status">
												<td colspan="2"><c:out value="${weather.pop }"/>%</td>
											</c:forEach>
										</tr>
										<tr>
											<td>강수량</td>
											<c:forEach items="${weatherList_10 }" var="weather" varStatus="status">
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
																<c:if test="${fristTimeMap_10.r06 != '0' }"><c:out value="${fristTimeMap_10.r06 }"/>mm	</c:if>
																<c:if test="${fristTimeMap_10.r06 == '0' }">-</c:if>
															</td>
														</c:if>
													</c:when>
												</c:choose> --%>
											</c:forEach>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					
				</div>
			</div>
		</div>
			<!-- footer -->
		<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incFooter"/>
		<!-- footer -->
	</body>
</html>
