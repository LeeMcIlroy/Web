<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     	uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=inc/incHead" />
<!-- cctv init! -->
<script language='VBScript' type="text/vbscript">
Sub Window_onBeforeUnload()
	WatSearCtrl.finalize
End Sub
</script>
<body>
	<!-- top menu - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incTopnav"/>
	<!-- top menu - end -->
		<div class="m_body">
			<div class="main_content02">
				<div class="content">
					<div class="new m_title">
						<div class="title">동부간선도로(중랑천수계)</div>
					</div>
					<div class="cont_box">
						<!-- GRAPH_BOX multi_box 안 div 최대 4개 -->
						
							<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/dashboard/dashboardTop"/>
						
						<!--// GRAPH_BOX -->
						<div class="grid_box">
							<div>
								<div class="div_half">
									<div class="grid_title">
										<ul class="twoLi">
											<li>월계1교 수위
											<a href="#" onclick="popup_name2(legend_popup, 'wolgye1'); return false;">
												[범례]
											</a>
											</li>
											<li class="tit_num">
												<a href="#" onclick="fn_changeDiv('wolgye'); return false;" id="title_wolgye">그래프보기</a>&nbsp;<label id="dt_now1"></label>
											</li>
										</ul>
									</div>
									<div  id="changeDiv_wolgye1" style="display:none;">
										<table>
											<tbody>
												<tr>
													<td>
											<div><c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/graph/wolgye1Graph"/></div>
													</td>
												</tr>
											</tbody>
										</table>
									<%-- 	<div class="gf_box" style="margin-top:50px;">
											<div><c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/graph/wolgye1Graph"/></div>
										</div> --%>
									</div>
									<div  id="changeDiv_wolgye2" >
										<div class="grid_table">
										<table style="height:300px;"> 
												<colgroup>
													<col width="33.33%" />
													<col width="33.33%" />
													<col width="33.33%" />
												</colgroup>
												<thead>
													<tr>
														<th>시간</th>
														<th>수위</th>
														<th>단계</th>
													</tr>
												</thead>
												<tbody id="wolgye1List">
													<c:forEach items="${wlList1 }" var="wl" varStatus="status" end="4">
														<tr <c:if test="${wl.level == '4' }"> class="grid_table_alt"</c:if>>
															<td><c:out value="${wl.baseTime }"/></td>
															<td><c:out value="${wl.wl }"/></td>
															<td>
																<c:choose>
																	<c:when test="${wl.level == '0'}">평시</c:when>
																	<c:when test="${wl.level == '1'}">준비</c:when>
																	<c:when test="${wl.level == '2'}">1차통제</c:when>
																	<c:when test="${wl.level == '3'}">2차통제</c:when>
																	<c:when test="${wl.level == '4'}">침수</c:when>
															
																</c:choose>
															</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</div>
								</div>
								<div class="div_half">
									<div class="grid_title">
										<ul class="twoLi">
											<li>월릉교 수위
											<a href="#" onclick="popup_name2(legend_popup, 'wolleung'); return false;">
												[범례]
											</a>
											</li>
											<li class="tit_num">
												<a href="#" onclick="fn_changeDiv('wolleung'); return false;" id="title_wolleung">그래프보기</a>&nbsp;<label id="dt_now2"></label>
											</li>
										</ul>
									</div>
									<div  id="changeDiv_wolleung1" style="display:none;">
										<table>
											<tbody>
												<tr>
													<td>
														<div><c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/graph/wolleungGraph"/></div>
													</td>
												</tr>
											</tbody>
										</table>
									<%-- 	<div class="gf_box" style="margin-top:50px;">
											<div><c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/graph/wolleungGraph"/></div>
										</div> --%>
									</div>
									<div  id="changeDiv_wolleung2" >
										<div class="grid_table">
											<table style="height:300px;">
												<colgroup>
													<col width="33.33%" />
													<col width="33.33%" />
													<col width="33.33%" />
												</colgroup>
												<thead>
													<tr>
														<th>시간</th>
														<th>수위</th>
														<th>단계</th>
													</tr>
												</thead>
												<tbody id="wolleung1List">
													<c:forEach items="${wlList2 }" var="wl" varStatus="status" end="4">
														<tr <c:if test="${wl.level == '4' }"> class="grid_table_alt"</c:if>>
															<td><c:out value="${wl.baseTime }"/></td>
															<td><c:out value="${wl.wl }"/></td>
															<td>
																<c:choose>
																	<c:when test="${wl.level == '0'}">평시</c:when>
																	<c:when test="${wl.level == '1'}">준비</c:when>
																	<c:when test="${wl.level == '2'}">1차통제</c:when>
																	<c:when test="${wl.level == '3'}">2차통제</c:when>
																	<c:when test="${wl.level == '4'}">침수</c:when>
																</c:choose>
															</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</div>
								</div>
								<div class="div_half">
									<div class="grid_title">
										<ul class="twoLi">
											<li>중랑교 수위
											<a href="#" onclick="popup_name2(legend_popup, 'joongrang'); return false;">
												[범례]
											</a>
											</li>
											<li class="tit_num">
												<a href="#" onclick="fn_changeDiv('joongrang'); return false;" id="title_joongrang">그래프보기</a>&nbsp;<label id="dt_now3"></label>
											</li>
										</ul>
									</div>
									<div  id="changeDiv_joongrang1" style="display:none;">
										<table>
											<tbody>
												<tr>
													<td>
														<div><c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/graph/joongrangGraph"/></div>
													</td>
												</tr>
											</tbody>
										</table>
										<%-- <div class="gf_box" style="margin-top:50px;">
											<div><c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/graph/joongrangGraph"/></div>
										</div> --%>
									</div>
									<div  id="changeDiv_joongrang2" >
										<div class="grid_table">
											<table style="height:300px;"> 
												<colgroup>
													<col width="33.33%" />
													<col width="33.33%" />
													<col width="33.33%" />
												</colgroup>
												<thead>
													<tr>
														<th>시간</th>
														<th>수위</th>
														<th>단계</th>
													</tr>
												</thead>
												<tbody id="joongrangList">
													<c:forEach items="${wlList3 }" var="wl" varStatus="status" end="4">
														<tr <c:if test="${wl.level == '3' }"> class="grid_table_alt"</c:if>>
															<td><c:out value="${wl.baseTime }"/></td>
															<td><c:out value="${wl.wl }"/></td>
															<td>
																<c:choose>
																	<c:when test="${wl.level == '0'}">평시</c:when>
																	<c:when test="${wl.level == '1'}">준비</c:when>
																	<c:when test="${wl.level == '2'}">통제</c:when>
																	<c:when test="${wl.level == '3'}">침수</c:when>
																</c:choose>
															</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</div>
								</div>
								<div class="div_half">
									<div class="grid_title">
										<ul class="twoLi">
											<li style="width: 45% !important;">신곡교 수위
										
											<a href="#" onclick="popup_name2(legend_popup, 'singok'); return false;">
												[범례]
											</a>
											</li>
											<li class="tit_num" style="width: 55% !important;">
												<%-- 
														<span id="singokBr" style="display: none;"><br/></span>
															<script>if(isMobile()) $("#singokBr").show(); </script>
													관련정보 &nbsp;
												--%>
												<a href="#" onclick="fn_changeDiv('singok'); return false;" id="title_singok">그래프보기</a>&nbsp;
												<label id="dt_now4"></label>
											</li>
										</ul>
									
									</div>
									<div  id="changeDiv_singok1" style="display:none;">
									<table>
											<tbody>
												<tr>
													<td>
											<div><c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/graph/singokGraph"/></div>
													</td>
												</tr>
											</tbody>
										</table>
									<%-- 	<div class="gf_box" style="margin-top:50px;">
										
											<div><c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/graph/singokGraph"/></div>
										</div> --%>
									</div>
									<div  id="changeDiv_singok2" >
										<div class="grid_table">
											<table style="height:300px;">
												<colgroup>
													<col width="33.33%" />
													<col width="33.33%" />
													<col width="33.33%" />
												</colgroup>
												<thead>
													<tr>
														<th>시간</th>
														<th>수위</th>
														<th>단계</th>
													</tr>
												</thead>
												<tbody id="singokList">
													<c:forEach items="${wlList4 }" var="wl" varStatus="status" end="4">
														<tr <c:if test="${wl.level == '3' }"> class="grid_table_alt"</c:if>>
															<td><c:out value="${wl.baseTime }"/></td>
															<td><c:out value="${wl.wl }"/></td>
															<td>
																<c:choose>
																	<c:when test="${wl.level == '0'}">평시</c:when>
																	<c:when test="${wl.level == '1'}">통제</c:when>
																</c:choose>
															</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</div>
								</div>
								<div class="div_half">
									<div class="grid_title">
										<ul class="twoLi">
											<li style="width: 45% !important;">신곡동 강수량
										
											
											</li>
											<li class="tit_num" style="width: 55% !important;">
												
											</li>
										</ul>
									
									</div>
										
										<table>
											<tbody>
												<tr>
													<td>
													<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/graph/rainFallGraph"/>
													</td>
												</tr>
											</tbody>
										</table>
								</div>

																
								<%-- <div>
									<div class="grid_title">
										<ul>
											<li class="">신곡동 기상현황</li>
										</ul>
									</div>
									<div class="gf_box" style="margin-top:50px;">
										<div class="weather" style="margin-left:50px;">
											<ul>
												<li>발표시간 : <c:out value="${singokWeather.baseDate }"/> <c:out value="${singokWeather.baseTime }"/></li>
												<li>
													<div><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_img1/w_icon${singokWeather.pty}.png'/>" alt="신곡동 기상현황" onerror='this.src="${pageContext.request.contextPath}/assets/img/w_icon.png"' /></div>
												</li>
												<li>
													<ul>
														<li><strong>온도:</strong> <c:out value="${singokWeather.t1h }"/>℃</li>
														<li><strong>습도:</strong> <c:out value="${singokWeather.reh }"/>%</li>
														<li><strong>1시간 강수량:</strong> <fmt:formatNumber value="${singokWeather.rn1 }" pattern="0.0"/>mm</li>
														<li><strong>누적 강수량:</strong> <fmt:formatNumber value="${singokWeather.rn24 }" pattern="0.0"/>mm</li>
													</ul>
												</li>
											</ul>
										</div>
									</div>
								</div> --%>
							
							</div>
							<div>
								<div>
									<div class="grid_title">
										<ul>
											<li class="middleTitle">동부간선도로</li>
										</ul>
									</div>
									<div class="gf_box">
										<div id="map2" style="width:100%;height:100%;"></div>
										<div style="display: block;position: absolute;width: 50px;height: 50px;z-index: 1;top: 10px;">
											<span class="map_plus" id="mapPlus"><a href="#" onclick="popup_name(map_popup);"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/map_plus.png'/>" alt="지도확대" /></a></span>
										</div>
										<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/dashboard/map/map2"/>
									</div>
									<%-- <c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/dashboard/dashboardFooter"/> --%>
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
					<button onclick="popup_name(map_popup);">닫기</button>
				</div>
				<div class="mb_map">
					<div class="mb_btn"><a href="#"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/map_plus.png'/>" /></a></div>
					<div class="big_map">
						<div id="map" style="width:100%;height:100%;"></div>
					</div>
					<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/dashboard/map/map"/>
				</div>
			</div>
		</div>
		<!--// 지도 크게 보기 팝업 -->
		<!-- footer -->
		<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incFooter"/>
		<!-- footer -->
	<script type="text/javascript">
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
			fn_createMap2();
			
			$(window).resize(function(){
				fn_createMap();
				fn_createMap2();
			});
			
// 			timer1 = setInterval(function() {
// 	        <c:if test="${!empty wlTime1}">fn_timeCheck(1, '<c:out value="${wlTime1}"/>', 'Y');</c:if>
// 	        }, 1000);
// 	       timer2 = setInterval(function() {
// 	        <c:if test="${!empty wlTime2}">fn_timeCheck(2, '<c:out value="${wlTime2}"/>', 'N');</c:if>
// 	        }, 1000);

			// 월계
	       timer1 = setInterval(function() {
	        <c:if test="${!empty wlTime1}">fn_timeCheck(1, '<c:out value="${wlTime1}"/>', 'Y');</c:if>
	        }, 1000);
		 	
			// 월릉
	       timer2 = setInterval(function() {
	        <c:if test="${!empty wlTime2}">fn_timeCheck(2, '<c:out value="${wlTime2}"/>', 'Y');</c:if>
	        }, 1000);
	       
	       // 중랑
	       timer3 = setInterval(function() {
	        <c:if test="${!empty wlTime3}">fn_timeCheck(3, '<c:out value="${wlTime3}"/>', 'N');</c:if>
	        }, 1000);
	       
	       // 신곡
	       timer4 = setInterval(function() {
	        <c:if test="${!empty wlTime4}">fn_timeCheck(4, '<c:out value="${wlTime4}"/>', 'N');</c:if>
	        }, 1000);
	       

		});
	</script>
	</body>
</html>
