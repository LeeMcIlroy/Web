<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<link href="<c:out value='${pageContext.request.contextPath }/assets/adm/js/fullcalendar/fullcalendar.min.css'/>" rel="stylesheet" />
<link href="<c:out value='${pageContext.request.contextPath }/assets/adm/js/fullcalendar/fullcalendar.print.min.css'/>" rel="stylesheet" media="print" />
<script src="<c:out value='${pageContext.request.contextPath }/assets/adm/js/fullcalendar/lib/moment.min.js'/>"></script>
<script src="<c:out value='${pageContext.request.contextPath }/assets/adm/js/fullcalendar/lib/jquery.min.js'/>"></script>
<script src="<c:out value='${pageContext.request.contextPath }/assets/adm/js/fullcalendar/fullcalendar.js'/>"></script>
<script src="<c:out value='${pageContext.request.contextPath }/assets/adm/js/fullcalendar/locale-all.js'/>"></script>
<script>
	var events = [];
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
			events: function(start, end, timezone, callback) {
				
				$("#startDate").val(start.format());
				$("#endDate").val(end.format());
				
				$.ajax({
	            	url: "<c:out value='${pageContext.request.contextPath }/xabdmxgr/cnslt/schdul/admCnsltScheduleListAjax.do'/>",
	                dataType: "json",
	                data: $("#frm").serialize(),
	                success: function(data) {
	                	resultList = data.resultList;
	                	if(resultList.length > 0){
		                    $(resultList).each(function(i, result){
			                    events.push({
			                    	title: $(this).attr("regName"), 
			                    	start: $(this).attr("schYmd")+"T"+$(this).attr("schHm"),
			                    	id: $(this).attr("schSeq"),
			                    	//url: "<c:out value='${pageContext.request.contextPath }/xabdmxgr/cnslt/schdul/admCnsltScheduleModify.do?schSeq="+result.schSeq+"'/>",
			                    	color: "#EAEAEA"
		                       	});
		                    });
		                    callback(events);
	                	}
	                }
	            });
	        }
		});

	});
	
</script>
<body>
<form id="frm" name="frm">
	<input type="hidden" id="startDate" name="startDate"/>
	<input type="hidden" id="endDate" name="endDate"/>
	<div id='calendar'></div>
</form>
</body>
</html>