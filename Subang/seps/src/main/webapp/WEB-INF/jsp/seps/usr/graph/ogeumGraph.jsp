<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="ogeum"></div>
<script type="text/javascript">
var ogeum; 
$(function() { 
	ogeum = c3.generate({	
		bindto : '#ogeum'	
		, color : { pattern: ['#D8D8D8'] }	
		, data: {
	        x: 'x'
	        , xFormat: '%Y%m%d %H%M'
	        , columns: [
	            ['x'
					<c:forEach items="${ogeumWaterLevelGraphData }" var="result">, '${result.baseDttm }'</c:forEach>
				]
	            , ['수위'
	               <c:forEach items="${ogeumWaterLevelGraphData }" var="result">, '${result.wl }'</c:forEach>
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
				max: 9
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
// 	                {value: 7, text: '1단계 통제', position: 'start', class:'level3'},
// 	                {value: 9, text: '침수', position: 'start', class:'level5'},
// 	            ]
	        	lines : lines["ogeum"]
				, padding : { top : 10, bottom : 0 }
	        }
	    }
		, size: {
			  height: 200
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