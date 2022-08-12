<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="egovframework.com.cmm.util.EgovUserDetailsHelper" %>
<%@ page import="seps.valueObject.UserInfoVO" %>
<%@ page import="seps.valueObject.AuthVO" %>
<%@ page import="java.util.List" %>
<%
	UserInfoVO userVO = (UserInfoVO) session.getAttribute("userSession");
	List<AuthVO> menuList = userVO.getMenuList();
	boolean main=false, dongbu=false, olympic=false, totalInfo=false, floodCenter=false, hotLine=false;
	for(AuthVO menuVO : menuList){
		if(menuVO.getAuthNm().equals("종합상황판")){ 
			main = true;
		}else if(menuVO.getAuthNm().equals("동부간선")){ 
			dongbu = true;
		}else if(menuVO.getAuthNm().equals("올림픽대로")){ 
			olympic = true;
		}else if(menuVO.getAuthNm().equals("기상정보")){ 
			totalInfo = true;
		}else if(menuVO.getAuthNm().equals("수방센터")){ 
			floodCenter = true;
		}else if(menuVO.getAuthNm().equals("비상연락망")){
			hotLine = true;
		}
	}
	// 서울 대기 정보
%>
<style>

	/* 	툴팁1 */
	.balloon {   
		position:relative; 
		width:400px;  
		height:55px; 
		background:grey;  
		border-radius: 10px; 
		top : 20px;
		display: none;
		font-size:20px;
		text-align: left;
		padding: 5px;
		box-sizing: border-box;
	} 
		
	.balloon:after {  
		border-top:0px solid transparent;  
		border-left: 10px solid transparent;  
		border-right: 10px solid transparent;  
		border-bottom: 10px solid grey;  
		content:"";  
		position:absolute; 
		top:-10px; 
		left:200px;   
	} 
	
	.balloon.b5:after {left:330px;}
	.balloon.b6:after {left:330px;}
	.balloon.b7:after {left:340px;}
		
	.balloon.b1 { left : -45%; }   
	.balloon.b2 { left : -42%; }
	.balloon.b3 { left : -38%; }
	.balloon.b4 { left : -38%; }
	.balloon.b5 { left : -75%; } 
	.balloon.b6 { left : -75%; } 
	.balloon.b7 { left : -80%; } 

	/* 	툴팁2 */

	.tooltip + .tooltiptext {
	  visibility: hidden;
	  width: 430px;
	  background-color: black;
	  color: #fff;
	  text-align: center;
	  border-radius: 6px;

	  /* Position the tooltip */
	  position: absolute;
	  z-index: 1;
	  top: 5px;
 	  right: 86%;
	}
	
	.tooltip:hover + .tooltiptext {
	  visibility: visible;
	}
	
	.tooltip + .tooltiptext::after {
	  content: " ";
	  position: absolute;
	  top: 50%;
	  left: 100%; /* To the right of the tooltip */
	  margin-top: -5px;
	  border-width: 5px;
	  border-style: solid;
	  border-color: transparent transparent transparent black;
	}
	
</style>
<!-- PAGE_HEAD -->
	<div class="m_header">
		<div class="t_logo">
			기후경영 <span>도로관리정보시스템</span>
			<%--
 			<a href="#" onclick="fn_reload(); return false;"><img src="<c:out value='${pageContext.request.contextPath }/assets/img/top_reset.png'/>" title="새로고침" /></a>
 			--%>			 
		</div>
		<div id="clickme">
			<%if(userVO.getAlarmYn().equals("Y")) {%>
				<a href="#" onclick="popup_name3(share_box);"><img src="<c:out value='${pageContext.request.contextPath }/assets/img/kakao_icon.png'/>" title="공유하기" /> <span>공유하기</span></a>
			<%} %>
			<button id="clickme02" onclick="return false;"><img src="<c:out value='${pageContext.request.contextPath }/assets/img/mobile_menu_open.png'/>" alt="메뉴열기" /></button>				
		</div>	
		<!-- TOP_MENU -->
		<div class="t_menu">
			<!-- PC_TOP_MENU -->
			<div class="pc_menu">
				<div class="log_in">
					<ul>
						<%if("Y".equals(userVO.getAdminYn())) {%>
							<li><a href="<c:out value='${pageContext.request.contextPath }/adm/userManage/userManageList.do'/>">관리자화면 바로가기</a></li>
						<%} %>
						<li><a href="#"><%=userVO.getUserNm() %></a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/logout.do'/>">로그아웃</a></li>
<%-- 						<li><a href="#" onclick="popup_name3(share_box);"><img src="<c:out value='${pageContext.request.contextPath }/assets/img/kakao_icon.png'/>" alt="공유하기" />&nbsp;&nbsp;공유하기</a></li> --%>
					</ul>
				</div>	
				<ul class="tooltip">
					<%if(main){ %>
					<!--  <li>
					<a href="<c:out value='${pageContext.request.contextPath }/usr/dashboard/main2.do'/>"
						<c:if test="${fn:indexOf(sessionScope.leftMeneNo, '70') > -1 }">class="on"</c:if>
					>
						기후경영
					</a>
					<div style="position: absolute;"><div class="balloon b1">
						미세먼지 정보, 보건기상정보, 주간날씨 등 <br/> 다양한 기상정보 제공
					</div></div>
					</li>-->
					<li><a href="<c:out value='${pageContext.request.contextPath }/usr/dashboard/main.do'/>"
						<c:if test="${fn:indexOf(sessionScope.leftMeneNo, '10') > -1 }">class="on"</c:if>
					>기후종합상황</a>
					<div style="position: absolute;"><div class="balloon b2">
						하절기 수방업무와 관련된 기상정보, 수위정보 <br/>등을 제공하고 근무상황 공유
					</div></div>
					</li>
					<%} %>
					<%if(dongbu){ %>
					<li><a href="<c:out value='${pageContext.request.contextPath }/usr/dashboard/dongbu.do'/>"
						<c:if test="${fn:indexOf(sessionScope.leftMeneNo, '20') > -1 }">class="on"</c:if>
					>동부간선도로(중랑천수계)</a>
					
					<div style="position: absolute;"><div class="balloon b3">
						동부간선도로 수방업무와 관련된 기상정보,<br/> 수위정보 등 제공
					</div></div>
					</li>
					<%} %>
					<%if(olympic){ %>
					<li><a href="<c:out value='${pageContext.request.contextPath }/usr/dashboard/olympic.do'/>"
						<c:if test="${fn:indexOf(sessionScope.leftMeneNo, '30') > -1 }">class="on"</c:if>
					>올림픽대로(한강수계)</a>
					
					<div style="position: absolute;"><div class="balloon b4">
						올림픽대로 수방업무와 관련된 수위정보, 팔당댐 방류정보 등 제공
					</div></div>
					</li>
					<%} %>
					<%if(totalInfo){ %>
					<li><a href="<c:out value='${pageContext.request.contextPath }/usr/totalInfo/periodWeatherInfo.do'/>"
						<c:if test="${fn:indexOf(sessionScope.leftMeneNo, '40') > -1 }">class="on"</c:if>
					>상세관측정보</a>
					
					<div style="position: absolute;"><div class="balloon b5">
						기간별 기상정보 및 수위정보 제공
					</div></div>
					<%} %>
					<!-- <li><a href="http://lbs.slink.kr/sisul/login" target="_blank">복구차량</a></li> -->
					<%if(floodCenter){ %>
					<li><a href="<c:out value='${pageContext.request.contextPath }/usr/floodCenter/noticeList.do'/>"
						<c:if test="${fn:indexOf(sessionScope.leftMeneNo, '50') > -1 }">class="on"</c:if>
					>수방매뉴얼</a>
					
					<div style="position: absolute;"><div class="balloon b6">
						공지사항 및 수방업무와 관련된 자료 제공
					</div></div>
					</li>
					<%} %>
					<%-- <%if(hotLine){ %>
					<li><a href="<c:out value='${pageContext.request.contextPath }/usr/hotLine/hotLineList.do'/>"
						<c:if test="${fn:indexOf(sessionScope.leftMeneNo, '60') > -1 }">class="on"</c:if>
					>비상연락망</a>
					
					<div style="position: absolute;"><div class="balloon b7">
						기관별 비상연락처 제공
					</div></div>
					</li>
					<%} %> --%>
				</ul>
<!-- 				<span class="tooltiptext">Tooltip text</span> -->
			</div>
			<!--// PC_TOP_MENU -->
		</div>
		<!--// TOP_MENU -->
	</div>
	<!-- 공유하기 팝업 -->
	<div class="share_box" id="share_box" style="visibility:hidden;">
		<div class="share_cont">
			<div class="share_title">카카오톡 공유하기<button onclick="popup_name3(share_box); return false;">닫기</button></div>			
			<div class="share_cont_box">
				<ul>
					<li class="copy_box_t" id="copy_box_t"><a href="#" class="on" onclick="man_dchg(1, this)">상황전파</a></li>
					<li class="write_box_t" id="write_box_t"><a href="#" class="" onclick="man_dchg(2, this)">직접입력</a></li>
				</ul>
				<div id="ch_div1" class="copy_box" style="display:block;">
					<div class="copy_txt">
						<ul>							
							<li>구분 : 
								<select id="kakaoTitle1">
									<option value="">선택</option>
									<option value="종합상황">종합상황</option>
									<option value="동부간선로">동부간선로</option>
									<option value="올림픽대로">올림픽대로</option>
								</select>
								<script type="text/javascript">
									$(function(){
										$(document).on('change', '#kakaoTitle1', function(){
											$('#kakaoTitle2Result').empty();
											$.ajax({
												url: "<c:url value='/usr/dashboard/mainKakaoAjax.do'/>"
												, type: "post"
												, data: { kakaoTitleSel : this.value }
												, dataType:"json"
												, async : false
												, success: function(data){
													var wolgyeVal = parseFloat(data.wolgye==null? 0:data.wolgye);
													var yeouiVal = parseFloat(data.yeoui==null? 0:data.yeoui);
													var singokVal = parseFloat(data.singok==null? 0:data.singok);
													var paldangVal = parseFloat(data.paldang==null? 0:data.paldang);
													
													var tags = '';
													if($('#kakaoTitle1').val() == '종합상황'){
														tags += '월계1교'+wolgyeVal+'m(잔여'+(wolgyeVal-wolgye1FloodWaterLevel).toFixed(2)+'m)/';
														tags += '여의상류IC(잔여'+(yeouiVal-yeouiFloodWaterLevel).toFixed(2)+'m)';
													}else if($('#kakaoTitle1').val() == '동부간선로'){
														tags += '월계1교 '+wolgyeVal+'m(잔여'+(wolgyeVal-wolgye1FloodWaterLevel).toFixed(2)+'m)/';
														tags += '신곡교'+singokVal+'m';
													}else if($('#kakaoTitle1').val() == '올림픽대로'){
														tags += '여의상류IC(잔여'+(yeouiVal-yeouiFloodWaterLevel).toFixed(2)+'m)/팔당댐'+paldangVal+'T/s';
													}
													
													$('#kakaoTitle2').val(tags);
													$('#kakaoTitle2Result').append(tags);
												}, error: function(){
													alert("오류가 발생하였습니다.");
												}
											});
										});
									});
								</script>
							</li>
							<li>
								<input type="hidden" id="kakaoTitle2" value="">
								<div id="kakaoTitle2Result"></div>
							</li>
						</ul>
						<div class="t_area"  style="margin-bottom:0;">
							<div id="txt_counter02">###</div>
						    <textarea id="kakaoContent" class="txt_counter" maxlength="38"></textarea>						    
						</div>
					</div>
				</div>
				<div id="ch_div2" class="write_box" style="display:none;">
					<div class="copy_txt">	
						<ul>							
							<li>제목 
								<div class="t_area">
									<div id="txt_counter03">###</div>
								    <input type="text" id="kakaoTitle" class="txt_counter03" maxlength="35" />						    
								</div>	
							</li>			
							<li>내용  
								<div class="t_area" style="margin-bottom:0;">
									<div id="txt_counter04">###</div>
								    <textarea id="kakaoContent" class="txt_counter04" maxlength="38"></textarea>						    
								</div>	
							</li>						
						</ul>
					</div>
				</div>	
			</div>
			<div class="pop_btn">
				<button onclick="fn_kakaoShare(); return false;">카카오톡 공유하기</button>
			</div>
		</div>
	</div>
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=usr/dashboard/kakao/kakao"/>
	<!-- //공유하기 팝업 -->
	<!-- MOBILE_MENU -->
	<div class="mob_menu">
		<div class="cssmenu">
			<div id="cssmenu">
				<div class="log_info_box">					
					<a href="#"><c:out value="${sessionScope.userSession.userNm }"/></a>
					<a href="<c:out value='${pageContext.request.contextPath }/logout.do'/>" id="logout">로그아웃</a>
				</div>
				<ul>
					<%if(main){ %>
					<!--<li><a href="<c:out value='${pageContext.request.contextPath }/usr/dashboard/main2.do'/>"
					<c:if test="${fn:indexOf(sessionScope.leftMeneNo, '70') > -1 }">class="on"</c:if>
					>기후경영</a></li>-->
					<li><a href="<c:out value='${pageContext.request.contextPath }/usr/dashboard/main.do'/>"
					<c:if test="${fn:indexOf(sessionScope.leftMenuCode, '10') > -1 }">class="on"</c:if>
					>기후종합상황</a></li>
					<%} %>
					<%if(dongbu){ %>
					<li><a href="<c:out value='${pageContext.request.contextPath }/usr/dashboard/dongbu.do'/>"
						<c:if test="${fn:indexOf(sessionScope.leftMenuCode, '20') > -1 }">class="on"</c:if>
					>동부간선도로(중랑천수계)</a></li>
					<%} %>
					<%if(olympic){ %>
					<li><a href="<c:out value='${pageContext.request.contextPath }/usr/dashboard/olympic.do'/>"
						<c:if test="${fn:indexOf(sessionScope.leftMenuCode, '30') > -1 }">class="on"</c:if>
					>올림픽대로(한강수계)</a></li>
					<%} %>
					<%if(totalInfo){ %>
				   <li class="has-sub"><a href="<c:out value='${pageContext.request.contextPath }/usr/totalInfo/floodLevel.do'/>"
						<c:if test="${fn:indexOf(sessionScope.leftMenuCode, '40') > -1 }">class="on"</c:if>
					>상세관측정보</a>
					  <ul>
						<li>
						 	<a href="<c:out value='${pageContext.request.contextPath }/usr/totalInfo/periodWeatherInfo.do'/>"
						 	<c:if test="${fn:indexOf(sessionScope.leftMenuCode, '301') > -1 }">class="on"</c:if> 
						 	>시간대별기상현황</a>
						 </li>
						 <li>
						 	<a href="<c:out value='${pageContext.request.contextPath }/usr/totalInfo/periodLevelInfo.do'/>"
						 	<c:if test="${fn:indexOf(sessionScope.leftMenuCode, '302') > -1 }">class="on"</c:if>
						 	>기간별수위정보</a>
						 </li>
						 <li>
						 	<a href="<c:out value='${pageContext.request.contextPath }/usr/totalInfo/weatherInfo.do'/>"
						 	<c:if test="${fn:indexOf(sessionScope.leftMenuCode, '303') > -1 }">class="on"</c:if>
						 	>기상정보</a>
						 </li>
						 <li>
						 	<a href="<c:out value='${pageContext.request.contextPath }/usr/totalInfo/tideInfo.do'/>"
						 	<c:if test="${fn:indexOf(sessionScope.leftMenuCode, '305') > -1 }">class="on"</c:if>
						 	>조위정보</a>
						 </li>
						  <li>
						 	<a href="https://www.metoc.navy.mil/jtwc/jtwc.html" target="_blank">미국기상청</a>
						 </li>
						 <li>
						 	<a href="https://tenki.jp/bousai/typhoon/" target="_blank">일본기상청</a>
						 </li>
						 <li>
						 	<a href="http://www.hrfco.go.kr/main.do" target="_blank">한강홍수통제소</a>
						 </li>
					  </ul>
				   </li>
					<%} %>
				   <%if(floodCenter){ %>
				   <li class="has-sub"><a href="<c:out value='${pageContext.request.contextPath }/usr/floodCenter/noticeList.do'/>"
						<c:if test="${fn:indexOf(sessionScope.leftMenuCode, '50') > -1 }">class="on"</c:if>
					>수방매뉴얼</a>
					  <ul>
						 <li>
							<a href="<c:out value='${pageContext.request.contextPath }/usr/floodCenter/noticeList.do'/>"
							<c:if test="${fn:indexOf(sessionScope.leftMenuCode, '401') > -1 }">class="on"</c:if>
							>공지사항</a>
						</li>
						<li>
							<a href="<c:out value='${pageContext.request.contextPath }/usr/floodCenter/floodAlarmList.do'/>"
							<c:if test="${fn:indexOf(sessionScope.leftMenuCode, '402') > -1 }">class="on"</c:if> 
							>기간별알람현황</a>
						</li>
						 <li><a href="<c:out value='${pageContext.request.contextPath }/usr/hotLine/hotLineList.do'/>"
						<c:if test="${fn:indexOf(sessionScope.leftMenuCode, '60') > -1 }">class="on"</c:if>
							>비상연락망</a></li>
					  </ul>
				   </li>
					<%} %>
				<%-- 	<%if(hotLine){ %>
				   <li><a href="<c:out value='${pageContext.request.contextPath }/usr/hotLine/hotLineList.do'/>"
						<c:if test="${fn:indexOf(sessionScope.leftMenuCode, '60') > -1 }">class="on"</c:if>
					>비상연락망</a></li>
					<%} %> --%>
				</ul>
			</div>
		</div>
	</div>
	<!--// MOBILE_MENU -->
	<!-- //PAGE_HEAD-->
	
	<script>
		$(".m_header .t_menu > .pc_menu > ul > li").hover(
			  function(){
			    var balloon = $(this).children("div").children("div.balloon");
				balloon.css({
			  		"display" : "block"
			  	});
			  }
			  , function(){
				var balloon = $(this).children("div").children("div.balloon");
				balloon	.css({
			  		"display" : "none"
			  	});
			  }
		);
	</script>
	
	<!--// 범례 보기 팝업 -->
	<div class="map_big_mode" id="legend_popup" style="visibility: hidden;">
		<div class="mb_box2" style="height:auto !important;">
			<div class="mb_mode">
				<span>통제수위 기준 범례</span>
				<button onclick="popup_name(legend_popup); return false;">닫기</button>
			</div>
			<div class="mb_map2">
				<div style="width:100%;height:95%;margin:0 auto;">
					<div class="cont_box">
						<div class="transform_table legend_type">
							<ul class="tbl_th">
								<li>기준치[m]</li>
								<li>단계</li>
								<li>색깔</li>
							</ul>
							<div class="tbl_td">
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	