<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="wolleung"></div>
<script type="text/javascript">
var wolleung; 
$(function() { 
	
	wolleung = c3.generate({	
		bindto : '#wolleung'	
		, color : { pattern: ['#D8D8D8'] }	
		, data: {
	        x: 'x'
	        , xFormat: '%Y%m%d %H%M'
	        , columns: [
	            ['x'
					<c:forEach items="${wolleungWaterLevelGraphData }" var="result">, '${result.baseDttm }'</c:forEach>
				]
	            , ['수위'
	               <c:forEach items="${wolleungWaterLevelGraphData }" var="result">, '${result.wl }'</c:forEach>
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
				max: 18
				, min: 10
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
// 	                {value: 14.28, text: '준비', position: 'start', class:'level2'},
// 	                {value: 14.68, text: '1단계 통제', position: 'start', class:'level3'},
// 	                {value: 15.08, text: '2단계 통제', position: 'start', class:'level4'},
// 	                {value: 16.08, text: '침수', position: 'start', class:'level5'},
// 	            ]
	        	lines : lines["wolleung"]
				, padding : { top : 10, bottom : 0 }
				
	        }
	    }
		, size: {
		
			 width:400,
			  height: 380
		}
		, point: {	
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
