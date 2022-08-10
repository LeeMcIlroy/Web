<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script>
function testDisplay(num){
	var ch_cont01 = document.getElementById("ch_cont01");
	var ch_cont02 = document.getElementById("ch_cont02");
	var ch_cont03 = document.getElementById("ch_cont03");
	if(num == "01"){
		ch_cont01.style.display = 'block';
		ch_cont02.style.display = 'none';
		ch_cont03.style.display = 'none';		
	}else if (num == "02") {
		ch_cont01.style.display = 'none';
		ch_cont02.style.display = 'block';
		ch_cont03.style.display = 'none';		
	}else {
		ch_cont01.style.display = 'none';
		ch_cont02.style.display = 'none';
		ch_cont03.style.display = 'block';	
	}
}
</script>
<body>
<div class="wrap">
	<!-- 스킵 네비게이션 -->
	<div id="skip_navigation">
		<ul>
			<li><a href="#gnb">주 메뉴 바로가기</a></li>
			<li><a href="#content">본문 바로가기</a></li>
		</ul>
	</div>
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
	<!--// header -->
	<hr />
	<!-- container -->
	<div class="container">
		<!-- lnb -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu" />
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<jsp:include page="/WEB-INF/jsp/writer/usr/inc/incPageTitle.jsp">
            	<jsp:param name="dept1" value="강의와 첨삭"/>
            	<jsp:param name="dept2" value="강의와 첨삭"/>
            </jsp:include>
			<div class="cont_box">
				<div class="gt_tit mt40">
					<strong>강의와 첨삭</strong>
				</div>
				<ul class="gt_box">
					<li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/pen_img.jpg'/>" alt="" style="width: 300px;height: 400px;"/></li>
					<li>
						<p>한성대학교 &lt;사고와 표현&gt; 강좌는 크게 세 가지 구도 속에 운영된다. 사고와표현교육과정과 강의 교재는 긴밀하게 연관되어 구안되었으며, 글쓰기 첨삭 지도는 글쓰기 센터를 중심으로 한 온라인 홈페이지를 통해 운영된다.</p>
						<p>한성대학교 사고와표현교육과정은 대학 1학년 학습자에게 요구되는 사고 능력과 이해/표현 능력은 하나의 문제 상황이 주어졌을 때, 그 문제를 해결하는 능력과 긴밀하게 관련된다고 전제하였다. 이에 대학교 교양 수준에서 다양한 갈래의 글을 읽고 쓰고 발표하는 과정을 경험한 후, 향후 2학년 이상의 전공 강의에서 요구되는 각 전공별 글을 읽고 쓰고 발표하는 단계로 확장하도록 의도하고 있다.</p>
						<p>이를 위해 &lt;사고와 표현&gt; 강좌는 1,2학기 공히 모든 대학의 공통 내용과 단과대학별 차별화된 내용으로 구성되어 있다. 그리고 1학기 &lt;사고와 표현Ⅰ&gt;는 읽고 쓰기 능력의 함양에, 2학기 &lt;사고와 표현Ⅱ&gt;는 읽기 쓰기 능력을 바탕으로 삼아 말하기와 듣기(발표 및 토론) 능력의 함양에 목표를 두고 강의가 운영된다.</p>
						<p>&lt;사고와 표현&gt; 강의는 홈페이지와 연동 속에 운영된다. &lt;사고와 표현&gt;을 수강하는 모든 학생은 온라인 홈페이지를 통해 2회의 첨삭을 받게 된다. 공통 과제는 단과대학별로 과제가 부여되며, 제출한 과제는 자체 제작한 ‘첨삭 지침 표준안’에 준거하여 사고와표현교육과정 소속 연구원들이 첨삭을 담당한다. 개별 과제는 실라버스와 교재의 허용 범위 내에서 담당교수가 부여하고 담당교수가 온라인상에서 첨삭(총평)을 한다.</p>
					</li>
				</ul>
			</div>
		</div>
		<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
</div>
</body>
</html>