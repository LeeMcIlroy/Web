<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="paldang"></div>
<script type="text/javascript">
var paldang; 

$(function() { 
	paldang = c3.generate({	
		bindto : '#paldang'	
		, color : { pattern: ['#D8D8D8'] }	
		, data: {
	        x: 'x'
       		, xFormat: '%H%M'
	        , columns: [
				['x'
					<c:forEach items="${paldangDamGraphData }" var="result">, '${result.baseTime }'</c:forEach>
				]
				, ['방류량'
					<c:forEach items="${paldangDamGraphData }" var="result">, '${result.tototf }'</c:forEach>
				]
	        ]
		, type : 'spline'
	    }
		, axis: {
			x: {
				type: 'timeseries'
				, tick: {
					format: '%H:%M'
				}
				, label : {
					text : '[시간]'
					, position : 'outer-right'
				}
			}
			, y: {
				tick: {
					format: d3.format("s")
				}
				, max: 25000
				, min: 0
				, padding : { top : 10, bottom : 0 }
				, label : {
					text : '[㎥/s]'
					, position : 'outer-top'
				}
			}
		}
		, grid: {
	        y: {
// 	            lines: [
// 	                {value: 10500, text: '침수', position: 'start', class:'level5'},
// 	            ]
	        	lines : lines["paldang"]
	        }
	    }
		, size: function(){
				if (/Mobi|Android/i.test(navigator.userAgent)) {
				   
					width: '350px';
					height: '310px';
				}else{
					width: '500px';
					height: '380px';
				}
			 
		},point: {	
			show : false	
		}
		,legend: {
	        show: false
	    }
		, zoom: {
			enabled: true
		}
	});
	
});
</script>
