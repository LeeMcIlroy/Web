<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>
<script type="text/javascript">
//버튼 마우스 오버 시 효과
$(document).ready(function () {
	$(".con_list div > a").on("mouseenter focus" , function() {
		$(".con_list div").removeClass("on");
		$(this).parent().addClass("on");
	});
	$(".con_list div > a").on("mouseleave blur" , function() {
		$(".con_list div").removeClass("on");
	});
});
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav"/>
	<!-- contents -->
	<div class="contents">
		<!-- 시험대상자 상시지원 -->
		<div class="apply_top">
			<div>
				<p>
					<span>시험대상자 상시지원</span>
					시험대상자에 상시지원 하시면 적합한 시험이 있을 경우 사전 대상자로 선정하여 연락 드립니다. 
				</p>
			</div>
			<a href="#">지원하기<i></i></a>
		</div>
		<!-- //시험대상자 상시지원 -->
		<!-- 시험지원 -->
		<div class="con_list type02">			
			<ul>
				<li>
					<div>
						<em>HBSE-MLG-20057-1</em>
						<p>눈가주름 개선효과 평가시험 / 3회 방문</p>
						<span>2020-00-00 ~ 2020-00-00</span>
						<a href="#" class="type01">지원하기</a>
					</div>
				</li>
				<li>
					<div>
						<em>HBSE-MLG-20057-1</em>
						<p>눈가주름 개선효과 평가시험 / 3회 방문</p>
						<span>2020-00-00 ~ 2020-00-00</span>
						<a href="#" class="type01">지원하기</a>
					</div>
				</li>
				<li>
					<div>
						<em>HBSE-MLG-20057-1</em>
						<p>눈가주름 개선효과 평가시험 / 3회 방문</p>
						<span>2020-00-00 ~ 2020-00-00</span>
						<a href="#" class="type01">지원하기</a>
					</div>
				</li>
				<li>
					<div>
						<em>HBSE-MLG-20057-1</em>
						<p>눈가주름 개선효과 평가시험 / 3회 방문</p>
						<span>2020-00-00 ~ 2020-00-00</span>
						<a href="#" class="type02">예정</a>
					</div>
				</li>
				<li>
					<div>
						<em>HBSE-MLG-20057-1</em>
						<p>눈가주름 개선효과 평가시험 / 3회 방문</p>
						<span>2020-00-00 ~ 2020-00-00</span>
						<a href="#" class="type02">예정</a>
					</div>
				</li>
			</ul>
		</div>
		<!-- //시험지원 -->
	</div>
	<!-- //contents -->
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!-- //footer -->
</div>
<!-- //wrap -->
</body>
</html>