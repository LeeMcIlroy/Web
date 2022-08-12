<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="tide"></div>
<script type="text/javascript">
var tide; 
$(function() { 
	tide = c3.generate({	
		bindto : '#tide'	
		, color : { pattern: ['#D8D8D8', '#ffeb3b'] }	
		, data: {
	        x: 'x'
	        , xFormat: '%Y%m%d %H%M'
	        , columns: [
            	['x'
				 	<c:forEach items="${tideGraphData }" var="result">, '${result.baseDate } ${result.baseTime }'</c:forEach>
				]
				, ['조위(실측)'
				   <c:forEach items="${tideGraphData }" var="result">, '${result.realValue }'</c:forEach>
				]
				, ['조위(예측)'
				   <c:forEach items="${tideGraphData }" var="result">, '${result.prvValue }'</c:forEach>
				]
            ]
		, type : 'spline'
	    }
		, axis: {
			x: {
				type: 'timeseries'
				, tick: {
					format: '%H:%M'
					//, count : 12
				}
				, label : {
					text : '[시간]'
					, position : 'outer-right'
				}
			}
			, y: {
				/*
				min : 1
				, padding : { top : 10, bottom : 0 }
				, tick: {
		            format: d3.format('.2f')
		        }
				*/
				label : {
					text : '[㎝]'
					, position : 'outer-top'
				}
			}
		}
		, point: {	
			show : false	
		}
		,legend: {
	        show: false
	    }
		/*
		, grid: {
	        y: {
	            lines: [
	            ]
				, padding : { top : 10, bottom : 0 }
	        }
	    }
		*/
		, size: {
			height: 200
		}
		, zoom: {
			enabled: true
		}
		
	});
});
</script>
