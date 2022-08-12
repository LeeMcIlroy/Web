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
<body>
	<!-- top menu - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/inc/incTopnav"/>
	<!-- top menu - end -->
	<div class="m_body">
		<div class="main_content02">
			<div class="content">
				<div class="new m_title">
					<div class="title">수방종합상황</div>
				</div>
				<div class="cont_box">
					<!-- GRAPH_BOX multi_box 안 div 최대 4개 -->
					
							<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/dashboard/dashboardTop"/>
					
					<!--// GRAPH_BOX -->
					<div class="grid_box3">
						
						<div>
								<div class="w50_p">
								<div class="grid_table td_h47" style="padding-left:0; padding-top:0;">
									<div class="grid_table_caption">
										<p class="middleTitle">동부간선도로</p>
										<p></p>
									</div>
									<table>											
										<tbody>
											<tr>
												<td class="map_btn_r">
												<div style="height: 440px;">
													<div id="map2" style="width:100%;height:100%;"></div>
													<div style="display: block;position: absolute;width: 50px;height: 50px;z-index: 1;top: 10px;">
														<span class="map_plus" id="mapPlus02"><a href="#" onclick="popup_name(map_popup);"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/map_plus.png'/>" alt="지도확대" /></a></span>
													</div>
												</div>
												<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/dashboard/map/map2"/>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="grid_table td_h47" style="padding-right:5px;">
									<div class="grid_table_caption">
										<p class="middleTitle">올림픽대로</p>
										<p></p>
									</div>
									<table>
										<tbody>
											<tr>
												<td class="map_btn_r">
												<div style="height: 440px;">
													<div id="map1" style="width:100%;height:100%;"></div>
													<div style="display: block;position: absolute;width: 50px;height: 50px;z-index: 1;top: 10px;">
														<span class="map_plus" id="mapPlus01"><a href="#" onclick="popup_name(map_popup);"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/map_plus.png'/>" alt="지도확대" /></a></span>
													</div>
												</div>
												<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/dashboard/map/map1"/>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
							<div class="div_half">
								<div class="grid_title">
									<ul class="twoLi">
										<li>시간대별 기상현황</li>
										
									</ul>
								</div>
								<div  id="changeDiv_wolgye1">
									<div class="cont_box">
										<div class="grid_table grid_table_over ">
											<table class="mainTable" style="width:100%; !important;">
												<thead>
													<tr>
														<th rowspan="3">시간</th>
														<th colspan="6">수위 및 방류량</th>
														<th colspan="4">강수량</th>
													</tr>
													<tr>
<!-- 														<th rowspan="2">단계</th>
 -->														
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
													<c:set var="totRn1B" value="0"/>	<%-- 7개 표출 --%>
													
													<c:set var="criteriaNum" value="${fn:length(weatherStatusList) - 7}" />
													<c:forEach items="${weatherStatusList }" var="result" varStatus="status">
													<tr style="display:<c:out value="${(0 >= criteriaNum) or (0 < criteriaNum and status.count > criteriaNum ) ? 'table-row' : 'none'}"/>;">
															<td>
																<fmt:parseDate value="${result.dttm }" pattern="yyyyMMdd HHmm" var="dttm"/>
																<fmt:formatDate value="${dttm }" pattern="yyyy-MM-dd HH:mm"/>
															</td>
															<%-- <td>
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
									</div>
								</div>
								<div  id="changeDiv_wolgye2" style="display:none;">
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
											<tbody id="wolgye1List">
												<c:forEach items="${wlList1 }" var="wl" varStatus="status" end="4">
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
			fn_createMap1();
			fn_createMap2();
			
			$(window).resize(function(){
				fn_createMap();
				fn_createMap1();
				fn_createMap2();
			});
			
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
	       
	       // 여의
	       timer4 = setInterval(function() {
	        <c:if test="${!empty wlTime4}">fn_timeCheck(4, '<c:out value="${wlTime4}"/>', 'Y');</c:if>
	        }, 1000);
	       
	       // 한강
	       timer5 = setInterval(function() {
	        <c:if test="${!empty wlTime5}">fn_timeCheck(5, '<c:out value="${wlTime5}"/>', 'N');</c:if>
	        }, 1000);
	       
	       
		});
	</script>
</body>
</html>
