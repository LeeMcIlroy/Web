<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"    	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"  	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"    	uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>

<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=inc/incHead" />
<!-- cctv init! -->
<script language='VBScript' type="text/vbscript">
Sub Window_onBeforeUnload()
	WatSearCtrl.finalize
End Sub

</script>
<script>
$(function(){
	
	
})
</script>
<body>
	<!-- top menu - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incTopnav"/>
	<!-- top menu - end -->
		<!-- //PAGE_HEAD-->
		<div class="m_body">
			<div class="main_content02">
				<div class="content">
					<div class="new m_title">
						<div class="title">올림픽대로(한강수계)</div>
					</div>
					<div class="cont_box">
						<!-- GRAPH_BOX multi_box 안 div 최대 4개 -->
					<!-- 	<div class="dashboardDpn"> -->
							<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/dashboard/dashboardTop"/>
					<!-- 	</div>	 -->					
						<!--// GRAPH_BOX -->
						<div class="grid_box2">
							<div>
								<div class="div_half">
									<div class="grid_title">
										<ul class="twoLi">
											<li style="width:55%;">여의상류IC 수위
											<a href="#" onclick="popup_name2(legend_popup, 'yeoui'); return false;">
												[범례]
											</a>
											</li>
											<li class="tit_num" style="width:45%;">
												<a href="#" onclick="fn_changeDiv('yeoui'); return false;" id="title_yeoui">그래프보기</a>&nbsp;<label id="dt_now1"></label>
											</li>
										</ul>
									</div>
									<div  id="changeDiv_yeoui1" style="display:none;">
										<div class="gf_box">
										<div><c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/graph/yeouiGraph"/></div>
									</div>
									</div>
									<div  id="changeDiv_yeoui2" >
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
											<tbody id="yeouiList">
												<c:forEach items="${wlList1 }" var="wl" varStatus="status" end="4">
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
											<li>한강대교 수위
											<a href="#" onclick="popup_name2(legend_popup, 'hangang'); return false;">
												[범례]
											</a>
											</li>
											<li class="tit_num">
												<a href="#" onclick="fn_changeDiv('hangang'); return false;" id="title_hangang">그래프보기</a>&nbsp;<label id="dt_now2"></label>
											</li>
										</ul>
									</div>
									<div  id="changeDiv_hangang1" style="display:none;">
										<div class="gf_box">
											<div><c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/graph/hangangGraph"/></div>
										</div>
									</div>
									<div  id="changeDiv_hangang2" >
										<div class="grid_table" >
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
												<tbody id="hangangList">
													<c:forEach items="${wlList2 }" var="wl" varStatus="status" end="4">
														<tr <c:if test="${wl.level == '3' }"> class="grid_table_alt"</c:if>>
															<td><c:out value="${wl.baseTime }"/></td>
															<td><c:out value="${wl.wl }"/></td>
															<td>
																<c:choose>
																	<c:when test="${wl.level == '0'}">평시</c:when>
																	<c:when test="${wl.level == '1'}">준비</c:when>
																	<c:when test="${wl.level == '2'}">경고</c:when>
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
											<li>청담대교 수위
											<a href="#" onclick="popup_name2(legend_popup, 'cheongdam'); return false;">
												[범례]
											</a>
											</li>
											<li class="tit_num">
												<a href="#" onclick="fn_changeDiv('cheongdam'); return false;" id="title_cheongdam">그래프보기</a>&nbsp;<label id="dt_now3"></label>
											</li>
										</ul>
									</div>
									<div  id="changeDiv_cheongdam1" style="display:none;">
										<div class="gf_box">
											<div><c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/graph/cheongdamGraph"/></div>
										</div>
									</div>
									<div  id="changeDiv_cheongdam2" >
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
												<tbody id="cheongdamList">
													<c:forEach items="${wlList3 }" var="wl" varStatus="status" end="4">
														<tr <c:if test="${wl.level == '3' }"> class="grid_table_alt"</c:if>>
															<td><c:out value="${wl.baseTime }"/></td>
															<td><c:out value="${wl.wl }"/></td>
															<td>
																<c:choose>
																	<c:when test="${wl.level == '0'}">평시</c:when>
																	<c:when test="${wl.level == '1'}">준비</c:when>
																	<c:when test="${wl.level == '2'}">경고</c:when>
																	<c:when test="${wl.level == '3'}">침수</c:when>
																</c:choose>
															</td>
														</tr>
													</c:forEach>
<!-- 												</tbody> -->
											</table>
										</div>
									</div>
								</div>
								<%-- <div class="div_half">
									<div class="grid_title">
										<ul class="twoLi">
											<li>오금교 수위
											<a href="#" onclick="popup_name2(legend_popup, 'ogeum'); return false;">
												[범례]
											</a>
											</li>
											<li class="tit_num">
												<a href="#" onclick="fn_changeDiv('ogeum'); return false;" id="title_ogeum">표로보기</a>&nbsp;<label id="dt_now4"></label>
											</li>
										</ul>
									</div>
									<div  id="changeDiv_ogeum1">
										<div class="gf_box">
											<div><c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/graph/ogeumGraph"/></div>
										</div>
									</div>
									<div  id="changeDiv_ogeum2" style="display:none;">
										<div class="grid_table">
											<table>
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
												<tbody id="ogeumList">
													<c:forEach items="${wlList3 }" var="wl" varStatus="status" end="4">
														<tr <c:if test="${wl.level == '3' }"> class="grid_table_alt"</c:if>>
															<td><c:out value="${wl.baseTime }"/></td>
															<td><c:out value="${wl.wl }"/></td>
															<td>
																<c:choose>
																	<c:when test="${wl.level == '0'}">평시</c:when>
																	<c:when test="${wl.level == '1'}">준비</c:when>
																	<c:when test="${wl.level == '2'}">경고</c:when>
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
								<div>
									<div class="grid_title">
										<ul class="twoLi">
											<li>대곡교 수위
											<a href="#" onclick="popup_name2(legend_popup, 'daegok'); return false;">
												[범례]
											</a>
											</li>
											<li class="tit_num">
												<a href="#" onclick="fn_changeDiv('daegok'); return false;" id="title_daegok">표로보기</a>&nbsp;<label id="dt_now5"></label>
											</li>
										</ul>
									</div>
									<div  id="changeDiv_daegok1">
										<div class="gf_box">
											<div><c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/graph/daegokGraph"/></div>
										</div>
									</div>
									<div  id="changeDiv_daegok2" style="display:none;">
										<div class="grid_table">
											<table>
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
												<tbody id="daegokList">
													<c:forEach items="${wlList3 }" var="wl" varStatus="status" end="4">
														<tr <c:if test="${wl.level == '3' }"> class="grid_table_alt"</c:if>>
															<td><c:out value="${wl.baseTime }"/></td>
															<td><c:out value="${wl.wl }"/></td>
															<td>
																<c:choose>
																	<c:when test="${wl.level == '0'}">평시</c:when>
																	<c:when test="${wl.level == '1'}">준비</c:when>
																	<c:when test="${wl.level == '2'}">경고</c:when>
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
								<div>
									<div class="grid_title">
										<ul class="twoLi">
											<li style="width: 40% !important;">팔당댐 방류량
											<a href="#" onclick="popup_name2(legend_popup, 'paldang'); return false;">
												[범례]
											</a>
											</li>
											<li class="tit_num" id="paldangDam" style="width: 60% !important;">
												<a href="#" onclick="fn_changeDiv('paldang'); return false;" id="title_paldang">표로보기</a>&nbsp;
												<c:if test="${paldangDamGraphData.size() gt 0 }">
													<fmt:formatDate value="${paldangDamGraphData.get(paldangDamGraphData.size()-1).get('regDttm')}" pattern="yyyy.MM.dd(E) HH:mm"/>
												</c:if>
											</li>
										</ul>
									</div>
									<div  id="changeDiv_paldang1">
										<div class="gf_box">
											<div><c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/graph/paldangGraph"/></div>
										</div>
									</div>
									<div  id="changeDiv_paldang2" style="display:none;">
										<div class="grid_table">
											<table>
												<colgroup>
													<col width="40%" />
													<col width="60%" />
												</colgroup>
												<thead>
													<tr>
														<th>시간</th>
														<th>팔당댐 방류량</th>
													</tr>
												</thead>
												<tbody id="paldangList">
													<c:forEach items="${wlList7 }" var="wl" varStatus="status" end="4">
													<tr <c:if test="${wl.level == '3' }"> class="grid_table_alt"</c:if>>
														<td><c:out value="${wl.baseTime }"/></td>
														<td><fmt:formatNumber value="${wl.tototf }" pattern=""/>㎥/s</td>
													</tr>
												</c:forEach>
											</table>
										</div>
									</div>
								</div> --%>
								<div>
									<div class="grid_title">
										<ul>
											<li class="">올림픽대로</li>
										</ul>
									</div>
									<div class="gf_box">
										<div style="height: 451px;">
											<div id="map1" style="width:100%;height:100%;"></div>
											<div style="display: block;position: relative;width: 30px;height: 30px;z-index: 1;top:-95%;left: 1%;">
												<span class="map_plus" id="mapPlus"><a href="#" onclick="popup_name(map_popup)"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/map_plus.png'/>" alt="지도확대" /></a></span>
											</div>
										</div>
										<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/dashboard/map/map1"/>
									</div>
								</div>
							</div>
							<div style="height:850px;">
								<div style="background-color:transparent;">
								
									<div class="right_grid_box" style="height:364px;">
										<div class="grid_title">
											<ul class="twoLi">
												<li style="width: 45% !important;">팔당댐 방류량
												<a href="#" onclick="popup_name2(legend_popup, 'paldang'); return false;">
													[범례]
												</a>
												</li>
												<li class="tit_num" id="paldangDam" style="width: 55% !important;">
													<a href="#" onclick="fn_changeDiv('paldang'); return false;" id="title_paldang">표로보기</a>&nbsp;
													<%-- <c:if test="${paldangDamGraphData.size() gt 0 }">
														<fmt:formatDate value="${paldangDamGraphData.get(paldangDamGraphData.size()-1).get('regDttm')}" pattern="yyyy.MM.dd(E) HH:mm"/>
													</c:if> --%>
												</li>
											</ul>
										</div>
										<div  id="changeDiv_paldang1">
										<table>
											<tbody>
												<tr id="paldangIsMobile">
													<td>
														<div><c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/graph/paldangGraph"/></div>
													</td>
												</tr>
											</tbody>
										</table>
										<%-- 	<div class="gf_box">
												<div><c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/graph/paldangGraph"/></div>
											</div> --%>
										</div>
										<div  id="changeDiv_paldang2" style="display:none;">
											<div class="grid_table">
												<table style="height:300px;">
													<colgroup>
														<col width="40%" />
														<col width="60%" />
													</colgroup>
													<thead>
														<tr>
															<th>시간</th>
															<th>팔당댐 방류량</th>
														</tr>
													</thead>
													<tbody id="paldangList">
														<c:forEach items="${wlList7 }" var="wl" varStatus="status" end="4">
														<tr <c:if test="${wl.level == '3' }"> class="grid_table_alt"</c:if>>
															<td><c:out value="${wl.baseTime }"/></td>
															<td><fmt:formatNumber value="${wl.tototf }" pattern=""/>㎥/s</td>
														</tr>
													</c:forEach>
												</table>
											</div>
										</div>
									</div> 
									<div class="right_grid_box">
										<div class="grid_title">
											<ul>
												<li>인천앞바다 조위정보</li>
											</ul>
										</div>
										<div class="gf_box">
											<div class="gf_stit">
												<ul>
													<li></li>
													<li>조석예보(cm)</li>
												</ul>
											</div>
											<div class="gf_list" id="tideList">
												<c:forEach items="${wlList8 }" var="wl" varStatus="status" end="4">
													<ul <c:if test="${wl.hlCode == '고조' }"> class="red_txt"</c:if>>
											
														<li>${fn:substring(wl.baseDate,0,4)}년 ${fn:substring(wl.baseDate,4,6)}월 ${fn:substring(wl.baseDate,6,8)}일 <c:out value="${wl.baseTime }"/></li>

														<li>
															<c:choose>
																<c:when test="${wl.hlCode=='고조' }">고</c:when>
																<c:when test="${wl.hlCode=='저조' }">저</c:when>
															</c:choose>
														</li>
														<li><c:out value="${wl.tphLevel }"/></li>
													</ul>
												</c:forEach>
											</div>
										</div>
									</div>
									<div class="right_grid_box" style="background-color:#404753;  margin-bottom:1%;">
										<div class="grid_title">
											<ul>
												<li>인천앞바다 조위 실측 정보</li>
											</ul>
										</div>
										
										<div class="gf_box">
											<div><c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/graph/tideGraph"/></div>
										</div>
									</div>
								<%-- 	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/dashboard/dashboardFooter"/>
 --%>								</div>
							</div>
						</div>
<!-- 					</div> -->
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
			fn_createMap1();
			
			$(window).resize(function(){
				fn_createMap();
				fn_createMap1();
			});
			
// 			timer1 = setInterval(function() {
// 	        <c:if test="${!empty wlTime1}">fn_timeCheck(1, '<c:out value="${wlTime1}"/>', 'Y');</c:if>
// 	        }, 1000);
// 	       timer2 = setInterval(function() {
// 	        <c:if test="${!empty wlTime2}">fn_timeCheck(2, '<c:out value="${wlTime2}"/>', 'N');</c:if>
// 	        }, 1000);
	       
			// 여의
	       timer1 = setInterval(function() {
	        <c:if test="${!empty wlTime1}">fn_timeCheck(1, '<c:out value="${wlTime1}"/>', 'Y');</c:if>
	        }, 1000);
		 	
			// 한강
	       timer2 = setInterval(function() {
	        <c:if test="${!empty wlTime2}">fn_timeCheck(2, '<c:out value="${wlTime2}"/>', 'N');</c:if>
	        }, 1000);
	       
	       // 청담
	       timer3 = setInterval(function() {
	        <c:if test="${!empty wlTime3}">fn_timeCheck(3, '<c:out value="${wlTime3}"/>', 'N');</c:if>
	        }, 1000);
	       
	       // 오금
	       timer4 = setInterval(function() {
	        <c:if test="${!empty wlTime4}">fn_timeCheck(4, '<c:out value="${wlTime4}"/>', 'N');</c:if>
	        }, 1000);
	       
	       // 대곡
	       timer5 = setInterval(function() {
	        <c:if test="${!empty wlTime5}">fn_timeCheck(5, '<c:out value="${wlTime5}"/>', 'N');</c:if>
	        }, 1000);
	       
	       
	       
		});
	</script>
	</body>
</html>
