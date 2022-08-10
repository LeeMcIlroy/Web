<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<link href="<c:url value='/assets/adm/js/fullcalendar/fullcalendar.min.css'/>" rel="stylesheet" />
<link href="<c:url value='/assets/adm/js/fullcalendar/fullcalendar.print.min.css'/>" rel="stylesheet" media="print" />
<script src="<c:url value='/assets/adm/js/fullcalendar/lib/moment.min.js'/>"></script>
<script src="<c:url value='/assets/adm/js/fullcalendar/lib/jquery.min.js'/>"></script>
<script src="<c:url value='/assets/adm/js/fullcalendar/fullcalendar.js'/>"></script>
<script src="<c:url value='/assets/adm/js/fullcalendar/locale-all.js'/>"></script>
<script>
	$(document).ready(function() {
		
		$('#calendar').fullCalendar({
			
			header: {
				left: '',
				center: 'prev, title, next',
				right: ''
			},
			lang: "ko",
			monthNames:["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
			monthNamesShort:["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
			dayNames: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"],
			dayNamesShort: ["일", "월", "화", "수", "목", "금", "토"],
			editable: false,
			eventLimit: true,
			selectable: true,
			selectHelper: true,
			select: function(start, end){
				$("#searchType").val(start.format("YYYY-MM-DD"));
				fn_modify(start.format());
			},
			events: function(start, end, timezone, callback) {
				
				$("#startDate").val(start.format());
				$("#endDate").val(end.format());
				
				$.ajax({
	            	url: "<c:url value='/xabdmxgr/cnslt/schdul/admCnsltScheduleListAjax.do'/>",
	                dataType: "json",
	                data: $("#frm").serialize(),
	                success: function(data) {
	                	resultList = data.resultList;
	                	if(resultList.length > 0){
		                    var events = [];
		                    $(resultList).each(function(i, result){
			                    events.push({
			                    	title: $(this).attr("regName"), 
			                    	start: $(this).attr("schYmd")+"T"+$(this).attr("schHm"),
			                    	url: "<c:url value='/xabdmxgr/cnslt/schdul/admCnsltScheduleModify.do?schSeq="+result.schSeq+"'/>",
			                    	color: "#EAEAEA"
		                       	});
		                    });
		                    callback(events);
	                	}
	                }
	            });
	        }
			<c:if test="${searchVO.searchType ne ''}">
				, defaultDate: "<c:out value="${searchVO.searchType}" />"
			</c:if>
		});
	});
	
	// 등록&수정화면
	function fn_modify(schYmd){
		$("#schYmd").val(schYmd);
		$("#searchType").val(getMonth());
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/cnslt/schdul/admCnsltScheduleModify.do'/>").submit();
	}
	
	function getMonth(){
	 	var moment = $('#calendar').fullCalendar('getDate');
	 	return moment.format("YYYY-MM-DD");
	}

</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="startDate" />
<form:hidden path="endDate" />
<form:hidden path="searchType" /> <%--화면에 보이는 년도-월-01일 --%>
<input type="hidden" id="schYmd" name="schYmd"/>
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
            	<jsp:param name="dept2" value="상담일정"/>
            </jsp:include>
			<div class="cont_box">
			<!-- content -->
				<div id='calendar'></div>
				<div class="btn_box">
					<div class="btn_r">
						<a href="#" class="b_type03" onclick="fn_modify(); return false;">일정등록</a>
					</div>
				</div>
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
<input type="hidden" id="message" value="${message }"/>
</form:form>
</body>
</html>