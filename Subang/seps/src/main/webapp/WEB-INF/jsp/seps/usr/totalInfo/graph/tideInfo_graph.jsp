<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="tideInfoGraph"></div>
<script type="text/javascript">
var tideInfoGraph; 
$(function() { 
	tideInfoGraph = c3.generate({	
		bindto : '#tideInfoGraph'	
		, color : { pattern: ['#D8D8D8', '#ffeb3b'] }	
		, data: {
	        x: 'x'
        	, xFormat: '%Y%m%d %H%M'
	        , columns: [
				['x'
				 	<c:forEach items="${tideList }" var="result">, '${result.baseDate } ${result.baseTime }'</c:forEach>
				]
				, ['조위(실측)'
				   <c:forEach items="${tideList }" var="result">, '${result.realValue }'</c:forEach>
				]
				, ['조위(예측)'
				   <c:forEach items="${tideList }" var="result">, '${result.prvValue }'</c:forEach>
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
				max: 100
				, min: 0
				, padding : { top : 10, bottom : 0 }
				*/
				label : {
					text : '[㎝]'
					, position : 'outer-top'
				}
			}
		}
		/*
		, grid: {
	        y: {
	            lines: [
	            ]
				, padding : { top : 10, bottom : 0 }
	        }
	    }
		, size: {
			  height: 200
		}
		*/
		, point: {	
			show : false	
		}
		,legend: {
	        show: false
	    }
	});
});
</script>
