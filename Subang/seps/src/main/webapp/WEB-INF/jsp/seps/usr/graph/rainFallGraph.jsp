<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="rainFall"></div>
<script type="text/javascript">
var rainFall; 
$(function() { 
	rainFall = c3.generate({	
		bindto : '#rainFall'	
		, color : { pattern: ['#D8D8D8', '#ffff00'] }	
		, data: {
	        x: 'x'
	        , xFormat: '%Y%m%d %H%M'
	        , columns: [
	            ['x'
					<c:forEach items="${singokRainGraphData }" var="result">, '${result.baseDttm }'</c:forEach>
				]
				, ['강수량'
					<c:forEach items="${singokRainGraphData }" var="result">, '${result.rn1 }'</c:forEach>
				]
	            , ['누적강수량'
					<c:set var="totVal" value="0"/><c:forEach items="${singokRainGraphData }" var="result" varStatus="status"><c:set var="totVal" value="${totVal+result.rn1 }"/>, '${totVal }'</c:forEach>
				]
	        ],
	        axes: {
	        	강수량: 'y',
	        	누적강수량: 'y2'
	        }
			, type : 'spline' 
	    }
		, axis: {
			x: {
				type: 'timeseries'
				, tick: {
					format: '%d일 %H시'
				}
				, label : {
					text : '[시간]'
					, position : 'outer-right'
				}
			}
			, y: {
				max: 150
				,min: 0
				, padding : { top : 10, bottom : 0 }
				, tick: {
		            format: d3.format('.1f')
		        }
				, label : {
					text : '[㎜]'
					, position : 'outer-top'
				}
			}
	        , y2: {
	            show: true
	            //, max: 100
				, min: 0
				, padding : { top : 10, bottom : 0 }
		        , tick: {
		            format: d3.format('.1f')
		        }
		        , label : {
					text : '[㎜]'
					, position : 'outer-top'
				}
	        }
	    }
		, size: {
			 
			 height: 345
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