<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
	.new.m_title {
		display: none;
	}
	
	table.mainTable th, td{
		height:30px !important;
	}
	
</style>
<div class="multi_box m_total dashboardTop">
	<!-- div1 -->
	<div id="div1">
		<dl class="total_top_box">									
			<dt>
				<%-- <span id="situationTxt" style="position: absolute;left: 15px;top: 5px; font-size:15px;">
					<c:out value="${floodMap.situationType eq 'F' ? '[수방단계]' : '[제설단계] : [강풍단계]'}"/>
				</span> --%>
				<a href="#" class="ar_icon"><label for="pop_ck" class="dashTopTxt">단계설정</label></a>
			</dt>
			<dd>
				<ul id="floodControlView">
<%--  				  	<li><img src="<c:out value='${pageContext.request.contextPath}/assets/img/alt_img.png'/>" alt="" /></li>
 --%> 					
 					<li><p><c:out value=" ${floodMap.floodContent }"/>  <c:out value="${floodMap.issueDate }"/> <c:out value="${floodMap.issueTime }"/> 발령 </p></li>
				<%-- 	<li>
					 <c:choose>
						<c:when test="${floodMap.floodLevel == 1 }"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/step_orange.png'/>" alt="주의" /></c:when>
						<c:when test="${floodMap.floodLevel == 2 }"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/step_red.png'/>" alt="경계" /></c:when>
						<c:when test="${floodMap.floodLevel == 3 }"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/step_purple.png'/>" alt="심각" /></c:when>
						<c:when test="${floodMap.floodLevel == 4 }"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/step_green.png'/>" alt="평시" /></c:when>
						<c:when test="${floodMap.floodLevel == 5 }"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/step_blue.png'/>" alt="포트홀" /></c:when>
						<c:when test="${floodMap.floodLevel == 6 }"><img src="<c:out value='${pageContext.request.contextPath}/assets/img/step_yellow.png'/>" alt="보강" /></c:when>
					</c:choose> 
					</li> --%>
				</ul>
			</dd>									
		</dl>
		<!-- 단계설정 팝업 -->
		<input type="checkbox" class="pop_ck" id="pop_ck" name="" />
		<div class="step_pop">
			<div class="pop_cont">
				<div class="pop_tit">
					단계설정
					<label for="pop_ck">닫기</label>
				</div>
				<table class="pop_table">
					<colgroup>
						<col width="20%" />
						<col width="80%" />
					</colgroup>
					<tbody>
						<tr>
							<th>*상황</th>
							<td>
								<input type="radio" name="situationType" id="floodControl" value="F" checked />
								<label for="floodControl">수방단계</label>
								<input type="radio" name="situationType" id="snowControl" value="S"/>
								<label for="snowControl">제설단계</label>
							</td>
						</tr>
						<tr>
							<th>*단계</th>
							<td>
								<select name="floodLevel" id="floodLevel">
									<option value="4">평시</option>
									<option value="5">포트홀</option>
									<option value="6">보강</option>
									<option value="1">1단계</option>
									<option value="2">2단계</option>
									<option value="3">3단계</option>
								</select>
							</td>
						</tr>
						<tr>
							<th>*발령일시</th>
							<td>
								<input type="text" name="day_st" id="day_st" class="start_day input_date"  placeholder="날짜" />&nbsp;&nbsp;&nbsp;
								<input type="text" name="issueTime1" id="issueTime1" style="width:30px;" /> 시&nbsp;&nbsp;&nbsp;
								<input type="text" name="issueTime2" id="issueTime2" style="width:30px;" /> 분
								<input type="hidden" name="issueDate" id="issueDate"/>
								<input type="hidden" name="issueTime" id="issueTime"/>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btn_box">					
					<label for="pop_ck"  class="btn_save" onclick="fn_modify(); return false;">저장</label>
					<label for="pop_ck" class="btn_cancel">취소</label>
				</div>
			</div>
		</div>
		<!-- 단계설정 팝업 -->
		
		<script type="text/javascript">
			// 저장
			function fn_modify(){
				
				if($("#floodLevel").val() == ""){
					alert("수방단계를 선택해주세요.");
					return false;
				}
				
				if($("#day_st").val() == ""){
					alert("발령일자를 선택해주세요.");
					return false;
				}else{
					$("#issueDate").val($("#day_st").val());
				}
				
				if($("#issueTime1").val() == "" || $("#issueTime2").val() == ""){
					alert("발령시간을 입력해주세요.");
					return false;
				}else{
					if($("#issueTime1").val() < 10 && $("#issueTime1").val() != 0){
						$("#issueTime1").val("0"+parseInt($("#issueTime1").val()));
					}
					if($("#issueTime2").val() < 10 && $("#issueTime2").val() != 0){
						$("#issueTime2").val("0"+parseInt($("#issueTime2").val()));
					}
					$("#issueTime").val($("#issueTime1").val()+":"+$("#issueTime2").val());					
				}
				
				$.ajax({
					url: "<c:url value='/usr/dashboard/mainFloodControlSubmitAjax.do'/>"
					, type: "post"
					, data: {
						floodLevel : $("#floodLevel").val()
						, issueDate : $("#issueDate").val()
						, issueTime : $("#issueTime").val()
						, situationType : $("input[type=radio][name=situationType]:checked").val()
					}
					, dataType:"json"
					, async : false
					, success: function(data){
						
						if(data.floodMap != ''){
							var floodMap = data.floodMap;
							$("#floodLevel").val('');
							$("#issueDate").val('');
							$("#issueTime").val('');
							$("#day_st").val('');
							$("#issueTime1").val('');
							$("#issueTime2").val('');
							$("#situationTxt").text("F" == floodMap.situationType ? "수방단계" : "제설단계");
							alert("수방단계가 수정되었습니다.");
							var tags = '<li><p>'+floodMap.floodContent+' '+floodMap.issueDate+' '+floodMap.issueTime+' 발령</p></li>';

							/*var tags = '<li><img src="<c:out value='${pageContext.request.contextPath}/assets/img/alt_img.png'/>" alt="" /></li>';
							tags += '<li><p>'+floodMap.issueDate+' '+floodMap.issueTime+' 발령</p>'+floodMap.floodContent+'</li>' */
							/* tags += '<li>';
								if(floodMap.floodLevel == 1 ){
									tags += '<img src="<c:out value="${pageContext.request.contextPath}/assets/img/step_orange.png"/>" alt="주의" />';
								}else if(floodMap.floodLevel == 2 ){
									tags += '<img src="<c:out value="${pageContext.request.contextPath}/assets/img/step_red.png"/>" alt="경계" />';
								}else if(floodMap.floodLevel == 3 ){
									tags += '<img src="<c:out value="${pageContext.request.contextPath}/assets/img/step_purple.png"/>" alt="심각" />';
								}else if(floodMap.floodLevel == 4 ){
									tags += '<img src="<c:out value="${pageContext.request.contextPath}/assets/img/step_green.png"/>" alt="평시" />';
								}else if(floodMap.floodLevel == 5 ){
									tags += '<img src="<c:out value="${pageContext.request.contextPath}/assets/img/step_blue.png"/>" alt="포트홀" />';
								}else if(floodMap.floodLevel == 6 ){
									tags += '<img src="<c:out value="${pageContext.request.contextPath}/assets/img/step_yellow.png"/>" alt="보강" />';
								}
							tags +='</li>'; */
							$("#floodControlView").html(tags);
						}
					}, error: function(){
						alert("오류가 발생하였습니다.");
					}					
				});
				document.pop_ck.checked=false;
			}
			
		</script>
	</div>
	<!--// div1 -->
	<!-- div2 -->
	<%-- <div style="position:relative;">
		<dl class="total_top_box notice_box">
			<dt>
				<a href="http://www.weather.go.kr/weather/warning/report.jsp?stn=109&kind=" target="_blank">
					<label class="dashTopTxt notice" style="display: none;">
						통보문&nbsp; &nbsp;
					</label>
				</a>	
				<a href="#" class="ar_icon">
					<label for="pop_ck02" class="dashTopTxt">
						메인알림
					</label>
				</a>
			</dt>
			<dd>
				<ul>
					<li>
						<div id="viewMainAlarm">
							<c:out value="${mainAlarm}"/>
						</div>
				    </li>
					<li>		
						<div class="flexslider">												  
						  <ul class="slides">
						  <c:choose>
						  	<c:when test="${alarmList != null }">
						  		<c:forEach items="${alarmList }" varStatus="status" var="alarm"> 
							  		<c:if test="${alarm.placeCode eq 'L1010100' or alarm.placeCode eq 'A000001' or alarm.placeCode eq 'A000002'}"> 
							  			<script>
							  				$("label.notice").show();
							  			</script>
							  		</c:if>
							  		<c:if test="${alarm.specialCode > 0 }">
								  		<li>
									  		<div>
									  			<a href="<c:out value='${pageContext.request.contextPath}/usr/special/solution.do?specialCode=${alarm.specialCode} '/>" style="color: #ffb400;" target="_blank" class="top speical">
									  				<c:out value="${alarm.alarmContent }"/>
									  			</a> 
										  		<span>
										  			<c:out value="${fn:substring(alarm.baseDate,5,fn:length(alarm.baseDate)) }"/> 
										  			<c:out value="${alarm.baseTime}"/>
										  		</span>
									  		</div>
								  		</li>
							  		</c:if>
							  		<c:if test="${alarm.specialCode == 0 }">
							  			<li>
							  				<div>
							  					<c:choose>
							  						<c:when test="${alarm.placeCode eq 'A000001' or alarm.placeCode eq 'A000002'}">
							  							<a href="<c:out value='${pageContext.request.contextPath}/usr/special/solution.do?specialCode=6 '/>" style="color: #ffb400;" target="_blank" class="top speical">
											  				<c:out value="${alarm.alarmContent }"/>
											  			</a>
							  						</c:when>
							  						<c:otherwise>
							  							<span style="color: #ffb400;" class="">
											  				<c:out value="${alarm.alarmContent }"/> 
									  					</span>
							  						</c:otherwise>
							  					</c:choose>
									  			<span>
									  				<c:out value="${fn:substring(alarm.baseDate,5,fn:length(alarm.baseDate)) }"/> 
									  				<c:out value="${alarm.baseTime}"/>
									  			</span>
							  				</div>
							  			</li>
							  		</c:if>
							  		
						  		</c:forEach>
						  	</c:when>
						  	<c:when test="${alarmList == null }">
						  		<li>
						  			<div style="font-size:18px">
						  				<a href="<c:out value='${pageContext.request.contextPath}/usr/special/solution.do?specialCode=2'/>" style="color: #ffb400;" target="_blank" class="top speical">
							  				호우
							  			</a>
						  				,<a href="<c:out value='${pageContext.request.contextPath}/usr/special/solution.do?specialCode=5'/>" style="color: #ffb400;" target="_blank" class="top speical">
							  			대설
							  			</a>
						  				,<a href="<c:out value='${pageContext.request.contextPath}/usr/special/solution.do?specialCode=4'/>" style="color: #ffb400;" target="_blank" class="top speical">
							  			가뭄
							  			</a>
						  				,<a href="<c:out value='${pageContext.request.contextPath}/usr/special/solution.do?specialCode=7'/>" style="color: #ffb400;" target="_blank" class="top speical">
							  			폭염
							  			</a>
						  				,<a href="<c:out value='${pageContext.request.contextPath}/usr/special/solution.do?specialCode=1'/>" style="color: #ffb400;" target="_blank" class="top speical">
							  			강풍
							  			</a>
						  				,<a href="<c:out value='${pageContext.request.contextPath}/usr/special/solution.do?specialCode=8'/>" style="color: #ffb400;" target="_blank" class="top speical">
							  			안개
							  			</a>
						  				,<a href="<c:out value='${pageContext.request.contextPath}/usr/special/solution.do?specialCode=3'/>" style="color: #ffb400;" target="_blank" class="top speical">
							  			한파
							  			</a>
						  				,<a href="<c:out value='${pageContext.request.contextPath}/usr/special/solution.do?specialCode=6'/>" style="color: #ffb400;" target="_blank" class="top speical">
							  			미세먼지 주의보 
							  			</a>
							  			클릭시 행동매뉴얼 표출
						  			</div>
						  		</li>
						  	</c:when>
						  </c:choose>
						  </ul>												  
						</div>
						<div class="custom-navigation" style="display:none;">
						  <a href="#" class="flex-prev">&lt;</a>												  
						  <a href="#" class="flex-next">&gt;</a>
						</div>										
					</li>											
				</ul>
			</dd>
		</dl>
		<!-- 메인알림 팝업 -->
		<input type="checkbox" class="pop_ck02" id="pop_ck02" name="" />
		<div class="step_pop02">
			<div class="pop_cont">		
				<div class="sp02_cont">
					<ul class="sp02_cont_box">
						<li><input type="text" name="mainAlarm" id="mainAlarm" value="<c:out value="${mainAlarm}"/>"/></li>
						<li>
							<label for="pop_ck02" class="btn_save" onclick="fn_updateMainAlarm(); return false;">저장</label>
							<label for="pop_ck02" class="btn_cancel">취소</label>
						</li>
					</ul>					
				</div>			
			</div>
		</div>
		<script type="text/javascript">
			function fn_updateMainAlarm(){
				var mainAlarm = $("#mainAlarm").val();
				
				if(mainAlarm == '' || mainAlarm.length > 40){
					alert("메인알림은 공백 제외 40자 미만의 글만 작성할 수 있습니다.");
				}else{
					$.ajax({
						url: "<c:url value='/usr/dashboard/mainAlarmSubmitAjax.do'/>"
						, type: "post"
						, data: {
							mainAlarm : mainAlarm
						}
						, dataType:"json"
						, async : false
						, success: function(data){
							$("#viewMainAlarm").html(data.text);
							$("#mainAlarm").val(data.text);
							alert("수정되었습니다.");
						}, error: function(){
							alert("오류가 발생하였습니다.");
						}
					});
				}
				
				document.pop_ck02.checked=false;
			}
		</script>
		<!-- 메인알림 팝업 -->
	</div> --%>
	<!--// div2 -->

	<!-- div3 -->
	<%-- <div>
	  	<dl class="wd_top_box">
			<dt>
				<a href="http://m.kma.go.kr/m/image/image_05.jsp" target="_blank" style="margin-right: 0;" id="rader" class="dashTopTxt">[레이더영상 보기]</a>&nbsp;|&nbsp;
				<a href="<c:out value='${pageContext.request.contextPath }/usr/totalInfo/weatherInfo.do'/>" class="ar_icon"><label class="dashTopTxt"> <c:out value="${weatherMap.updateTime }"/></label></a>										
			</dt>
			<dd>
				<ul>
					<li><img src="<c:out value='${pageContext.request.contextPath}/assets/img/gps_img.png'/>" alt="" /></li>
					<li>
						<dl>
							<dt><c:out value="${weatherMap.t1h }"/>℃</dt>
							<dd>습도 <c:out value="${weatherMap.reh }"/>%<br>강수량 <fmt:formatNumber value="${weatherMap.rn1 }" pattern="0.0"/>㎜<br>누적강수량 <c:out value="${weatherMap.rn24 }"/>㎜</dd>
						</dl>
					</li>
					<li>
						<div>
							<ul style="vertical-align:middle; text-align:center;">	
								<li><img src="<c:out value='${pageContext.request.contextPath}/assets/img/w_img2/w_icon${weatherMap2.status }.png'/>" alt="맑음" style="width: 50%; height: 50%;" onerror='this.src="${pageContext.request.contextPath}/assets/img/w_icon.png"'/><p class="mt5"></p></li>
							</ul>
						</div>
					</li>
					<li>
						<dl>
							<dt><c:out value="${weatherMap2.updateTime }"/>시 예보</dt>
							<dd><c:out value="${weatherMap2.t1h }"/>℃<br>강수량  <fmt:formatNumber value="${weatherMap2.rn1 }" pattern="0.0"/>㎜<br>누적강수량 <fmt:formatNumber value="${weatherMap.rn24 + weatherMap2.rn1 }" pattern="0.0"/>㎜</dd>
						</dl>
					</li>											
				</ul>
			</dd>
		</dl>							
	</div> --%>
	<!--// div3 -->
</div>
<script>
	$(document).ready(function() {
		var flag = isMobile();
		
		if(flag) {
			$(".new.m_title").show();
		}
		
	});
</script>