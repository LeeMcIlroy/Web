<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"     uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<style type="text/css">
    .fc-center { display:flex; align-items:center; }
    .fc-title  { color:white; font-weight:bold;}
</style>
<script>

var dataset = 
[
		 <c:forEach var="result" items="${resultList}" varStatus="status">
			 {
				   "title":'<c:out value="${result.rsCd}" /> 시작'
			 	  ,"start":'<c:out value="${result.rsStdt}" />'  
				<c:choose>
			 	  <c:when test="${fn:substring(result.rsCd,0,4 ) == 'HBSE' }"> ,"color" : "#EEAFAF"</c:when>
				  <c:when test="${fn:substring(result.rsCd,0,4 ) == 'HBSF' }"> ,"color" : "#AFC4E7"</c:when>
				  <c:otherwise>  ,"color": "#BAE7AF"</c:otherwise>
				</c:choose>
	
			 },
		</c:forEach>
];      
 document.addEventListener('DOMContentLoaded', function() {
	
    var calendarEl = document.getElementById('calendar');
			$('.fc-center').css('display','flex');
			$('.fc-center').css('align-items','center');
    var calendar = new FullCalendar.Calendar(calendarEl, {
    	
      plugins: ["dayGrid"],
      header : { left   : '',  
	    	     center : 'prev title next', 
	    	     right  : 'today' 
    	        },
       
      //한글버전
      locale: 'ko',
      
      events: dataset,
      eventClick: function (info){
    	 
    	  var start = moment(info.event.start).format('YYYY-MM-DD');
    
  		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0302/ech0302View.do'/>?rsStdt="+start
				, '연구일정팝업', 'width=830, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
		}

     });
    calendar.render();
    
  }); 
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>피험자관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="피험자관리"/>
	            <jsp:param name="dept2" value="연구일정"/>
           	</jsp:include>
			<!-- 달력 -->			
				<div id="calendar"></div>
			<!-- //달력 -->
			<!-- //타이틀 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	
</div>	
<!-- //wrap -->
</body>
</html>