<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="yMax" value="0"/>
<div id="periodInfoGraph"></div>
<script type="text/javascript">
var periodInfoGraph; 
$(function() { 
	periodInfoGraph = c3.generate({	
		bindto : '#periodInfoGraph'	
		, color : { pattern: ['#D8D8D8'] }	
		, data: {
	        x: 'x'
        	, xFormat: '%Y%m%d %H%M'
	        , columns: [
				['x'
				 	<c:forEach items="${waterLevelOrDamList }" var="result">, '${result.baseDate } ${result.baseTime }'</c:forEach>
				]
				, ['수위'
				   <c:forEach items="${waterLevelOrDamList }" var="result">, '${result.val }'</c:forEach>
				]
	        ]
			, type : 'spline'
	    }
		, grid: {
	        y: {
	            lines: [
					<c:forEach items="${levelLines }" var="result" varStatus="status"><c:set var="yMax" value="${(result.value gt yMax)? result.value : yMax}"/>
					{value: '${result.value }', text: '${result.key eq "level2"? "준비" :(result.key eq "level2_1" ? "1단계 통제" : (result.key eq "level2_2" ? "2단계 통제" : (result.key eq "level4"? "통제":"침수")))}', position: 'start', class:'${result.key }'},
					</c:forEach>
	            ]
				, padding : { top : 10, bottom : 0 }
	        }
	    }
		/*
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
				max: ${yMax}
				/*
				, padding : { top : 10, bottom : 0 }
				*/
				, tick: {
		            format: d3.format('.2f')
		        }
				, label : {
					text : '[m]'
					, position : 'outer-top'
				}
			}
		}
		, zoom: {
			enabled: true
		}
		, tooltip: {
			format: {
				title : function(x){
					var y = x.getFullYear().toString();
					var m = (x.getMonth()+1).toString();
					var d = x.getDate().toString();
					
					var H = x.getHours().toString();
					var M = x.getMinutes().toString();
					return (m[1]? m:'0'+m[0])+'.'+(d[1]? d:'0'+d[0])+' '+(H[1]? H:'0'+H[0])+':'+(M[1]? M:'0'+M[0]);
				}
			}
		}
		/*
		, subchart: {
			show: true
		}
		*/
	});
});
</script>
