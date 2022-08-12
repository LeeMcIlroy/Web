<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="cheongdam" style="margin-left:-11px;"></div>
<script type="text/javascript">
var cheongdam; 
$(function() { 
	cheongdam = c3.generate({	
		bindto : '#cheongdam'	
		, color : { pattern: ['#D8D8D8'] }	
	, data: {
        x: 'x'
   		, xFormat: '%Y%m%d %H%M'
        , columns: [
			['x'
			 	<c:forEach items="${cheongdamWaterLevelGraphData }" var="result">, '${result.baseDttm }'</c:forEach>
			]
			, ['수위'
			   <c:forEach items="${cheongdamWaterLevelGraphData }" var="result">, '${result.wl }'</c:forEach>
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
				max: 10
				, min: 0
				, padding : { top : 10, bottom : 0 }
				, tick: {
		            format: d3.format('.2f')
		        }
				, label : {
					text : '[m]'
					, position : 'outer-top'
				}
			}
		}
		, grid: {
	        y: {
// 	            lines: [
// 	                {value: 7.6, text: '준비', position: 'start', class:'level1'},
// 	                {value: 8.1, text: '통제', position: 'start', class:'level3'},
// 	                {value: 9.1, text: '침수', position: 'start', class:'level5'},
// 	            ]
	        	lines : lines["cheongdam"]
	        }
	    }
		, size: {
			height: 320
		}
		, point: {	
			show : false	
		}
		,legend: {
	        show: false
	    }
	});
});
</script>
