<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>


<%--
		11~3
		a03VO : 체감 1~4
		a08VO : 동파가능 1~4 
		
				
		6~9
		a06VO : 불쾌지수 1~4		
		a20VO :  더위체감지수 1~5
		
		4~5, 10
		a012VO : 식중독 1~4
		d01VO : 천식폐질환 0~3
		
		

 --%>
<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="month"><fmt:formatDate value="${now}" pattern="M" /></c:set> 

<c:choose>
	<c:when test="${ (month >=1 and month <=3) or (month >=11 and month <=12) }">
		<div class="div_half">
			<div class="grid_title">
				<ul class="twoLi jisu">
					<li>체감온도 지수(11~3월)</li>
					<li><a href="#" onclick="popup_name(life_measure_popup, 'tempo', '체감온도 지수'); return false;" id="yeoui">대응요령</a></li>
				</ul>
			</div>
			<div class="boxstep_article">
				<ol>
					<!-- 선택단계의 span에 class="on"부여하고 텍스트에 <mark></mark> 태그를 씌워주세요 -->
					<li class="li_v2 step01">
						<c:if test="${a03VO.value == '1' }"><span class="on"><mark>낮음</mark></span></c:if>
						<c:if test="${a03VO.value != '1' }"><span>낮음</span></c:if>
					</li>
					<li class="li_v2 step02">
						<c:if test="${a03VO.value == '2' }"><span class="on"><mark>보통</mark></span></c:if>
						<c:if test="${a03VO.value != '2' }"><span>보통</span></c:if>
					</li>
					<li class="li_v2 step03">
						<c:if test="${a03VO.value == '3' }"><span class="on"><mark>높음</mark></span></c:if>
						<c:if test="${a03VO.value != '3' }"><span>높음</span></c:if>
					</li>
					<li class="li_v2 step04">
						<c:if test="${a03VO.value == '4' }"><span class="on"><mark>매우높음</mark></span></c:if>
						<c:if test="${a03VO.value != '4' }"><span>매우높음</span></c:if>
					</li>
				</ol>
			</div><!-- //boxstep_article  -->
			<div class="boxstep_content">
				<c:out value="${a03VO.baseDate }"/>
			</div>
		</div>
		
		<div class="div_half">
			<div class="grid_title">
					<ul class="twoLi jisu">
						<li>동파가능 지수(11~3월)</li>
						<li><a href="#" onclick="popup_name(life_measure_popup, 'ice', '동파가능 지수'); return false;" id="yeoui">대응요령</a></li>
					</ul>
			</div>
			<div class="boxstep_article">
				<ol>
					<!-- 선택단계의 span에 class="on"부여하고 텍스트에 <mark></mark> 태그를 씌워주세요 -->
					<li class="li_v2 step01">
						<c:if test="${a08VO.value == '1' }"><span class="on"><mark>낮음</mark></span></c:if>
						<c:if test="${a08VO.value != '1' }"><span>낮음</span></c:if>
					</li>
					<li class="li_v2 step02">
						<c:if test="${a08VO.value == '2' }"><span class="on"><mark>보통</mark></span></c:if>
						<c:if test="${a08VO.value != '2' }"><span>보통</span></c:if>
					</li>
					<li class="li_v2 step03">
						<c:if test="${a08VO.value == '3' }"><span class="on"><mark>높음</mark></span></c:if>
						<c:if test="${a08VO.value != '3' }"><span>높음</span></c:if>
					</li>
					<li class="li_v2 step04">
						<c:if test="${a08VO.value == '4' }"><span class="on"><mark>매우높음</mark></span></c:if>
						<c:if test="${a08VO.value != '4' }"><span>매우높음</span></c:if>
					</li>
				</ol>
			</div><!-- //boxstep_article  -->
			<div class="boxstep_content">
				<c:out value="${a08VO.baseDate }"/>
			</div>
		</div>
	
	</c:when>

	<c:when test="${ (month >=6 and month <=9)  }">
	
		<div class="div_half">
			<div class="grid_title">
				<ul class="twoLi jisu"> 
					<li>불쾌 지수(6~9월)</li>
					<li><a href="#" onclick="popup_name(life_measure_popup, 'unpleasure', '불쾌 지수'); return false;" id="yeoui">대응요령</a></li>
				</ul>
			</div>
			<div class="boxstep_article">
				<ol>
					<!-- 선택단계의 span에 class="on"부여하고 텍스트에 <mark></mark> 태그를 씌워주세요 -->
					<li class="li_v2 step01">
						<c:if test="${a06VO.value == '1' }"><span class="on"><mark>낮음</mark></span></c:if>
						<c:if test="${a06VO.value != '1' }"><span>낮음</span></c:if>
					</li>
					<li class="li_v2 step02">
						<c:if test="${a06VO.value == '2' }"><span class="on"><mark>보통</mark></span></c:if>
						<c:if test="${a06VO.value != '2' }"><span>보통</span></c:if>
					</li>
					<li class="li_v2 step03">
						<c:if test="${a06VO.value == '3' }"><span class="on"><mark>높음</mark></span></c:if>
						<c:if test="${a06VO.value != '3' }"><span>높음</span></c:if>
					</li>
					<li class="li_v2 step04">
						<c:if test="${a06VO.value == '4' }"><span class="on"><mark>매우높음</mark></span></c:if>
						<c:if test="${a06VO.value != '4' }"><span>매우높음</span></c:if>
					</li>
				</ol>
			</div><!-- //boxstep_article  -->
			<div class="boxstep_content">
				<c:out value="${a06VO.baseDate }"/>
			</div>
		</div>
		
		<div class="div_half">
			<div class="grid_title">
					<ul class="twoLi jisu">
						<li style="width: 70% !important;">더위체감 지수(6~9월)</li>
						<li style="width: 30% !important;"><a href="#" onclick="popup_name(life_measure_popup, 'hot', '더위체감 지수'); return false;" id="yeoui">대응요령</a></li>
					</ul>
			</div>
			<div class="boxstep_article">
				<ol>
					<!-- 선택단계의 span에 class="on"부여하고 텍스트에 <mark></mark> 태그를 씌워주세요 -->
					<li class="step01">
						<c:if test="${a20VO.value == '1' }"><span class="on"><mark>낮음</mark></span></c:if>
						<c:if test="${a20VO.value != '1' }"><span>낮음</span></c:if>
					</li>
					<li class="step02">
						<c:if test="${a20VO.value == '2' }"><span class="on"><mark>보통</mark></span></c:if>
						<c:if test="${a20VO.value != '2' }"><span>보통</span></c:if>
					</li>
					<li class="step03">
						<c:if test="${a20VO.value == '3' }"><span class="on"><mark>높음</mark></span></c:if>
						<c:if test="${a20VO.value != '3' }"><span>높음</span></c:if>
					</li>
					<li class="step04">
						<c:if test="${a20VO.value == '4' }"><span class="on"><mark>매우높음</mark></span></c:if>
						<c:if test="${a20VO.value != '4' }"><span>매우높음</span></c:if>
					</li>
					
					<li class="step05">
						<c:if test="${a20VO.value == '5' }"><span class="on"><mark>매우높음</mark></span></c:if>
						<c:if test="${a20VO.value != '5' }"><span>매우높음</span></c:if>
					</li>
					
				</ol>
			</div><!-- //boxstep_article  -->
			<div class="boxstep_content">
				<c:out value="${a20VO.baseDate }"/>
			</div>
		</div>
	
	</c:when>
	
	<c:when test="${ (month >=4 and month <=5) or month eq 10 }">
	
		<div class="div_half">
			<div class="grid_title">
				<ul class="twoLi jisu">
					<li style="width: 73% !important;">식중독 지수(4~5월, 10월)</li>
					<li style="width: 27% !important;"><a href="#" onclick="popup_name(life_measure_popup, 'foodPosion', '식중독 지수'); return false;" id="yeoui">대응요령</a></li>
				</ul>
			</div>
			<div class="boxstep_article">
				<ol>
					<!-- 선택단계의 span에 class="on"부여하고 텍스트에 <mark></mark> 태그를 씌워주세요 -->
					<li class="li_v2 step01">
						<c:if test="${a012VO.value == '1' }"><span class="on"><mark>낮음</mark></span></c:if>
						<c:if test="${a012VO.value != '1' }"><span>낮음</span></c:if>
					</li>
					<li class="li_v2 step02">
						<c:if test="${a012VO.value == '2' }"><span class="on"><mark>보통</mark></span></c:if>
						<c:if test="${a012VO.value != '2' }"><span>보통</span></c:if>
					</li>
					<li class="li_v2 step03">
						<c:if test="${a012VO.value == '3' }"><span class="on"><mark>높음</mark></span></c:if>
						<c:if test="${a012VO.value != '3' }"><span>높음</span></c:if>
					</li>
					<li class="li_v2 step04">
						<c:if test="${a012VO.value == '4' }"><span class="on"><mark>매우높음</mark></span></c:if>
						<c:if test="${a012VO.value != '4' }"><span>매우높음</span></c:if>
					</li>
				</ol>
			</div><!-- //boxstep_article  -->
			<div class="boxstep_content">
				<c:out value="${a012VO.baseDate }"/>
			</div>
		</div>
		
		<div class="div_half">
			<div class="grid_title">
					<ul class="twoLi jisu">
						<li style="width: 75% !important;">천식폐질환 지수(4~5월, 10월)</li>
						<li style="width: 25% !important;"><a href="#" onclick="popup_name(life_measure_popup, 'asthma', '천식폐질환 지수'); return false;" id="yeoui">대응요령</a></li>
					</ul>
			</div>
			<div class="boxstep_article">
				<ol>
					<!-- 선택단계의 span에 class="on"부여하고 텍스트에 <mark></mark> 태그를 씌워주세요 -->
					<li class="li_v2 step01">
						<c:if test="${d01VO.value == '0' }"><span class="on"><mark>낮음</mark></span></c:if>
						<c:if test="${d01VO.value != '0' }"><span>낮음</span></c:if>
					</li>
					<li class="li_v2 step02">
						<c:if test="${d01VO.value == '1' }"><span class="on"><mark>보통</mark></span></c:if>
						<c:if test="${d01VO.value != '1' }"><span>보통</span></c:if>
					</li>
					<li class="li_v2 step03">
						<c:if test="${d01VO.value == '2' }"><span class="on"><mark>높음</mark></span></c:if>
						<c:if test="${d01VO.value != '2' }"><span>높음</span></c:if>
					</li>
					<li class="li_v2 step04">
						<c:if test="${d01VO.value == '3' }"><span class="on"><mark>매우높음</mark></span></c:if>
						<c:if test="${d01VO.value != '3' }"><span>매우높음</span></c:if>
					</li>
				</ol>
			</div><!-- //boxstep_article  -->
			<div class="boxstep_content">
				<c:out value="${d01VO.baseDate }"/>
			</div>
		</div>
	
	
	</c:when>
	
	
</c:choose> 
 
 
