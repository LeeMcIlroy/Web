<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
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
            	<jsp:param name="dept1" value="센터소개"/>
            	<jsp:param name="dept2" value="설립 취지"/>
            </jsp:include>
			<div class="cont_box">
				<ul class="gt_box">
					<li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/gt_img01.jpg'/>" alt="" /></li>
					<li>
						<div class="gt_tit">
							<strong>자신을 드러내는 행위가 바로 자기표현입니다.</strong><br/>
							<span>드러냄의 시대가 되면서, 자기표현의 방법도 다양해지고, 자기표현이 긍정적으로 받아들여지고 있습니다.</span>
						</div>

						<p>졸업 후 사회에 진출하기 위해 면접을 보는 과정에서도 자신의 장점을 적극적으로 드러내는 사람이 후한 점수를 받습니다. 사람마다 장점이 없는 사람은 없습니다. <br>
						그러나 그것을 남에게 인정받는 사람과 그렇지 않은 사람이 있습니다.<br>
						그것은 바로 자기표현 능력의 차이입니다.</p>
						<p>한 사람의 자기표현 행위가 사회에서 인정받으려면, 그것이 사회와 커뮤니케이션이 되어야 합니다. 커뮤니케이션이 되었다고 말하려면, 전달하는 사람의 의도를 전달받는 사람이 그대로 이해해야 합니다.</p>

						<p>따라서 한 사람이 자기표현을 통해 드러내려 했던 모습을 다른 사람들이 그 의도 그대로, 가능하면 긍정적으로 받아들일 수 있어야 합니다.<br>
						이것이 바로 자기표현을 통한 커뮤니케이션 능력입니다.</p>
						<p>자기표현을 통한 커뮤니케이션 능력은 넘쳐나는 사람들에 대한 정보 속에서 “나” 라는 정보를 다른 사람들에게 잘 드러내는 능력을 말합니다.<br>
						그것이 넘실대는 정보의 사회 속에서 ‘경쟁력 있는 나’를 만드는 핵심 역량인 것입니다.</p>
						<p>글쓰기센터는 이와 같은 시대의 흐름에 발맞춰 학생들의 표현 능력 향상을 돕고자 설립되었습니다.</p>
						<p>글쓰기센터는 학생들의 사고력을 신장시키고 이와 함께 글쓰기 능력과 발표 능력을 향상시킬 수 있는 친절한 길잡이가 될 것입니다.</p>
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