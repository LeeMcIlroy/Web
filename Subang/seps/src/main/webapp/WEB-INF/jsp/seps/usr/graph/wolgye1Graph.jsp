<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="wolgye1"></div>
<script type="text/javascript">
var wolgye1; 
$(function() { 
	wolgye1 = c3.generate({	
		bindto : '#wolgye1'	
		, color : { pattern: ['#D8D8D8'] }	
		, data: {
	        x: 'x'
	        , xFormat: '%Y%m%d %H%M'
	        , columns: [
	            ['x'
				  <c:forEach items="${wolgyeWaterLevelGraphData }" var="result">, '${result.baseDttm }'</c:forEach>
				]
	            , ['수위'
	               <c:forEach items="${wolgyeWaterLevelGraphData }" var="result">, '${result.wl }'</c:forEach>
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
				max: 20
				, min: 12
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
// 	                {value: 15.43, text: '준비', position: 'start', class:'level2'},
// 	                {value: 16.23, text: '1단계 통제', position: 'start', class:'level3'},
// 	                {value: 16.83, text: '2단계 통제', position: 'start', class:'level4'},
// 	                {value: 17.23, text: '침수', position: 'start', class:'level5'},
// 	            ]
	        	lines : lines["wolgye1"]
				, padding : { top : 10, bottom : 0 }
	        }
	    }
		, size: {
			 width:420,
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
