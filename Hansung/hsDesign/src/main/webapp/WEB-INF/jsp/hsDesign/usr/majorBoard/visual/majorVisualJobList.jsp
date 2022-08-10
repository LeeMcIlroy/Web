<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko" >
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="pageIndex"/>
<form:hidden path="searchType"/>
<form:hidden path="menuType"/>
<form:hidden path="searchCondition2"/>
<form:hidden path="searchWord"/>
<input type="hidden" id="mbSeq" name="mbSeq">
	<!-- skip_navigation -->
	<dl id="skip_nav">
		<dt>바로가기 메뉴</dt>
		<dd><a href="#content">본문 바로가기</a></dd>
		<dd><a href="#top_menu">메뉴 바로가기</a></dd>
		<dd><a href="#footer">페이지 하단 바로가기</a></dd>
	</dl>
	<!-- //skip_navigation -->
	<div class="content">
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
	<!--// header -->
	<!-- container -->
	<div class="main_content" id="content">
		<div class="width_box">
			<!-- lnb -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu"/>
			<!--// lnb -->
			<!-- content -->
			<div class="sub_content">
				<!-- 타이틀 영역 -->
				<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle2.jsp">
					<jsp:param name="dept1" value="전공"/>
		            <jsp:param name="dept2" value="시각디자인"/>
		            <jsp:param name="dept3" value="진출분야"/>
	           	</jsp:include>
				<div class="top_tab type_li4">
					<ul>
						<li <c:if test="${searchVO.menuType eq '01' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/visual/majorVisualJobList.do?menuType=01'/>">시각∙패키지디자인</a></li>
						<li <c:if test="${searchVO.menuType eq '02' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/visual/majorVisualJobList.do?menuType=02'/>">광고∙브랜드디자인</a></li>
						<li <c:if test="${searchVO.menuType eq '03' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/visual/majorVisualJobList.do?menuType=03'/>">일러스트레이션</a></li>
						<li <c:if test="${searchVO.menuType eq '04' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/visual/majorVisualJobList.do?menuType=04'/>">웹UX∙UI디자인</a></li>
					</ul>
				</div>
				<c:if test="${searchVO.menuType eq '01' }">
				
					<p class="area_info">브랜딩과 패키지디자인을 통해 새로운 가치를 창출 할 수 있도록 실습한다.<br>
					탄탄한 기초 조사를 바탕으로 전략을 세우고 브랜드 아이덴티티를 개발할 수 있으며, 이를 반영하여 패키지 디자인을 총괄할 수 있는 전문가를 양성한다.</p>
		
					<!--<div class="s_tit">취업문야</div>
					<p class="area_info">건축설계사무소, 인테리어디자인회사, 인테리어 재료 및 시공관련회사, 가구디자인회사, 인테리어스타일링회사, 환경디자인회사, 전시디자인회사, 디자인소품관련사, 조명디자인회사, 색채관련회사, 이벤트관련회사, 백화점 및 브랜드디스플레이회사, VMD(Visual Merchandising], 인테리어 재료관련회사</p>
		
					<div class="s_tit">관련자격증</div>
					<p class="area_info">실내건축(산업)기사, 컬러리스트(산업)기사, 건축(산업)기사, 건설안전(산업)기사, 건축설계(산업)기사, Auto CAD 자격증, 컴퓨터활용능력 1,2급 등</p>
					-->
		
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_vp01.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_vp02.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_vp03.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_vp04.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_vp05.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_vp06.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_vp07.jpg'/>" /></li>
						</ul>
						<%-- 
						<div id="bx-pager">
							<a data-slide-index="0" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/visual/photo_s_eximg01.jpg" /></a>
							<a data-slide-index="1" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg02.jpg" /></a>
							<a data-slide-index="2" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg03.jpg" /></a>
							<a data-slide-index="3" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg04.jpg" /></a>
							<a data-slide-index="4" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg05.jpg" /></a>
							<a data-slide-index="5" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg06.jpg" /></a>
							<a data-slide-index="6" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg07.jpg" /></a>
							<a data-slide-index="7" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg08.jpg" /></a>
						</div>
						 --%>
					</div>
				
				</c:if> 
				<c:if test="${searchVO.menuType eq '02' }">
					<p class="area_info">소비자가 사용하는 상품(브랜드)의 장점을 사람들에게 가장 효과적으로 전달하는 시각적 소통방법에 대해 연구한다. <br>
					탄탄한 기초 조사를 바탕으로 전략을 세우고 브랜드 아이덴티티를 개발할 수 있으며, 이를 반영하여 패키지 디자인을 총괄할 수 있는 전문가를 양성한다.</p>
					
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_ab01.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_ab02.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_ab03.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_ab04.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_ab05.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_ab06.jpg'/>" /></li>
						</ul>
						<%-- 
						<div id="bx-pager">
							<a data-slide-index="0" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg01.jpg" /></a>
							<a data-slide-index="1" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg02.jpg" /></a>
							<a data-slide-index="2" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg03.jpg" /></a>
							<a data-slide-index="3" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg04.jpg" /></a>
							<a data-slide-index="4" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg05.jpg" /></a>
							<a data-slide-index="5" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg06.jpg" /></a>
							<a data-slide-index="6" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg07.jpg" /></a>
							<a data-slide-index="7" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg08.jpg" /></a>
						</div>
						 --%>
					</div>
				</c:if> 
				<c:if test="${searchVO.menuType eq '03' }">
					<p class="area_info">디자인과 미술(회화)의 융합을 토대로 디지털과 아날로그를 자유로이 넘나들며 새로운 시각 이미지콘텐츠를 창조해내고, 이 창작물을 상업적으로 활용 할 수 있는 일러스트레이터를 양성한다.</p>

					<dl class="info_dl_txt">
							<dt>	아티스트	</dt>
                               <dd>	일러스트레이터, 시각 예술가, 작가, 그림책 작가, 북 아티스트, 큐레이팅 분야 등	</dd>
							<dt>	디자이너	</dt>
                               <dd>	패키지, 출판, 아이덴티티, 패션, 패브릭 패턴, 환경 및 공간 그래픽, 방송 영상 CG 분야 등 다양한 디자인 분야의 디자이너 진출 가능	</dd>
					</dl>
					</br></br>
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_il01.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_il02.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_il03.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_il04.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_il05.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_il06.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_il07.jpg'/>" /></li>
						</ul>
						<%-- 
						<div id="bx-pager">
							<a data-slide-index="0" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg01.jpg" /></a>
							<a data-slide-index="1" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg02.jpg" /></a>
							<a data-slide-index="2" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg03.jpg" /></a>
							<a data-slide-index="3" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg04.jpg" /></a>
							<a data-slide-index="4" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg05.jpg" /></a>
							<a data-slide-index="5" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg06.jpg" /></a>
							<a data-slide-index="6" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg07.jpg" /></a>
							<a data-slide-index="7" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg08.jpg" /></a>
						</div>
						 --%>
					</div>
				</c:if> 
				<c:if test="${searchVO.menuType eq '04' }">
					<p class="area_info">웹 상의 화면 레이아웃, 텍스트 활용, 아이콘 버튼 배열, 움직이는 이미지와 영상 배치, 색상 선택 등 기본적인 웹 환경을 디자인한다. 또한 모바일 환경이 지닌 특성을 파악해 어플리케이션 디자인을 학습한다.</p>

					<dl class="info_dl_txt">
							<dt>	아티스트	</dt>
                               <dd>	일러스트레이터, 시각 예술가, 작가, 그림책 작가, 북 아티스트, 큐레이팅 분야 등	</dd>
							<dt>	디자이너	</dt>
                               <dd>	패키지, 출판, 아이덴티티, 패션, 패브릭 패턴, 환경 및 공간 그래픽, 방송 영상 CG 분야 등 다양한 디자인 분야의 디자이너 진출 가능	</dd>
					</dl>
					</br></br>
					
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_wu01.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_wu02.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_wu03.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_wu04.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_wu05.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_wu06.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_wu07.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/visual/vi_advan_wu08.jpg'/>" /></li>
						</ul>
						<%-- 
						<div id="bx-pager">
							<a data-slide-index="0" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg01.jpg" /></a>
							<a data-slide-index="1" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg02.jpg" /></a>
							<a data-slide-index="2" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg03.jpg" /></a>
							<a data-slide-index="3" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg04.jpg" /></a>
							<a data-slide-index="4" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg05.jpg" /></a>
							<a data-slide-index="5" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg06.jpg" /></a>
							<a data-slide-index="6" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg07.jpg" /></a>
							<a data-slide-index="7" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/photo_s_eximg08.jpg" /></a>
						</div>
						 --%>
					</div>
				
				</c:if> 
			</div>
			<!--// content -->
		</div>
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
</div>
<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>