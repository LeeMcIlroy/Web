<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="joongrang"></div>
<script type="text/javascript">
var joongrang; 
$(function() { 
	joongrang = c3.generate({	
		bindto : '#joongrang'	
		, color : { pattern: ['#D8D8D8'] }	
		, data: {
	        x: 'x'
	        , xFormat: '%Y%m%d %H%M'
	        , columns: [
	            ['x'
					<c:forEach items="${joongrangWaterLevelGraphData }" var="result">, '${result.baseDttm }'</c:forEach>
				]
	            , ['수위'
	               <c:forEach items="${joongrangWaterLevelGraphData }" var="result">, '${result.wl }'</c:forEach>
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
				max: 5
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
// 	                {value: 2.8, text: '준비', position: 'start', class:'level2'},
// 	                {value: 5, text: '1단계 통제', position: 'start', class:'level3'},
// 	                {value: 6.5, text: '침수', position: 'start', class:'level5'},

// 	                {value: 12.785, text: '준비', position: 'start', class:'level2'},
// 	                {value: 13.185, text: '1단계 통제', position: 'start', class:'level3'},
// 	                {value: 13.585, text: '2단계 통제', position: 'start', class:'level4'},
// 	                {value: 14.585, text: '침수', position: 'start', class:'level5'},
// 	            ]
	        	lines : lines["joongrang"]
				, padding : { top : 10, bottom : 0 }
	        }
	    }
		, size: {
			 width:380,
			  height: 350
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
