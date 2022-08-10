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
		            <jsp:param name="dept2" value="미용학"/>
		            <jsp:param name="dept3" value="진출분야"/>
	           	</jsp:include>
				
				<div class="top_tab type_li3">
					<ul>
						<li <c:if test="${searchVO.menuType eq '01' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyJobList.do?menuType=01'/>">헤어 스타일리스트</a></li>
						<li <c:if test="${searchVO.menuType eq '02' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyJobList.do?menuType=02'/>">뷰티 헬스케어</a></li>
						<li <c:if test="${searchVO.menuType eq '03' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyJobList.do?menuType=03'/>">매디컬 뷰티코디네이트</a></li>
					</ul>
				</div>
				
				<c:if test="${searchVO.menuType eq '01' }">
					
					<p class="area_info">
					헤어 스타일리스트는 「헤어관련 스타일을 담당하는 사람」이란 뜻으로 정해진 테마에 따라 미용을 구성하고 아름다움을 스타일 하는 사람을 말합니다. 잡지사 에디터나 CF촬영코디 또는 쇼나 드라마의 무대를 구성할 때 탤런트들의 이미지 제고를 위해 기획 단계부터 스태프로 함께 참여하는 뛰어난 미용 감각을 가진 기획자를 말합니다.
					</p>
					<p class="area_info">
					한디원 미용학 전공은 미용 트랜드를 개척하고 美를 대중화하고 나아가 이를 이끌어나가는 인재를 키워가고 있습니다.
					</p>
					
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beauty/be_advan_hs01.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beauty/be_advan_hs02.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beauty/be_advan_hs03.jpg'/>" /></li>
						</ul>
						<%-- 
						<div id="bx-pager">
							<a data-slide-index="0" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beauty/photo_s_eximg01.jpg" /></a>
							<a data-slide-index="1" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beauty/photo_s_eximg02.jpg" /></a>
							<a data-slide-index="2" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beauty/photo_s_eximg03.jpg" /></a>
							<a data-slide-index="3" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beauty/photo_s_eximg04.jpg" /></a>
							<a data-slide-index="4" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beauty/photo_s_eximg05.jpg" /></a>
							<a data-slide-index="5" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beauty/photo_s_eximg06.jpg" /></a>
							<a data-slide-index="6" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beauty/photo_s_eximg07.jpg" /></a>
							<a data-slide-index="7" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beauty/photo_s_eximg08.jpg" /></a>
						</div>
						 --%>
					</div>
				</c:if>				
				<c:if test="${searchVO.menuType eq '02' }">
					
					<p class="area_info">
					넓은 의미로 건강관리 개념을 합친 전반적인 인체관리 산업분야를 말합니다. 좁은 의미의 헬스케어는 건강컨설팅, 인체미용 등의 사업을 지칭합니다.<br>건강한 삶은 우리 인생에 있어서 큰 희망이며 바라는 욕구입니다. 100세 시대를 맞이하는 현실에서 아름답고 건강한 삶은 누구나 추구하는 본능입니다. <br>한디원 미용학 전공은 미래의 블루오션으로 떠오르고 있는 헬스케어 사업 분야로 진출 할 수 있도록 학생들의 기본 지식과 능력을 키워가고 있습니다.
					</p>
					<p class="area_info">
					한디원 미용학전공은 ITEC DIPLOMA 취득과정을 통해 뷰티헬스케어, 뷰티산업분야, 뷰티관광 서비스 산업체에 취업을 할 수 있도록 교육하고 있습니다.
					</p>
						
					<div class="s_tit">교육목표</div>
					<p class="area_info">국내/외 뷰티 & 헬스 산업을 선도하는 창의적이고 진취적인 미용 전문인으로서 국제적인 경쟁력을 갖춘 웰니스 & 스파 디자이너 및 매니저로 양성합니다.</p>

					<div class="s_tit">인재상</div>
					<p class="area_info">국제 표준화된 전문적이고 실용적인 교육을 통한 글로벌 웰니스  서비스 전문가, 웰니스센터, 스파, 리조트 매니저, 컨시어지 및 테라피스트로 진출 할 수 있도록 합니다.</p>

					<div class="s_tit">교육내용</div>
					<p class="area_info">피부미용 / 메디컬스킨케어 / 스파테라피 / 매니지먼트<br>
					4개 영역을 4년에 걸쳐서 전공 교과 과정으로 운영하고 있으며 ITEC Diploma 취득하여  국내/외 취업을 추진하고 있습니다.</p>
					
					<div class="s_tit">전공교과과목 구성</div>
					
					<div class="sub_cont_page">
						<dl class="info_dl">
							<dd>
								<p>
									<strong>1) 피부 미용과정</strong>
									<br/>고객 상담 및 피부분석, 보건법규, 공중위생학, 미용경락, 발반사학, 제품 및 화장품학, 피부미용사 자격과정 등

								</p>
								<p>
									<strong>2) 메디컬 뷰티 & 헬스 케어과정</strong>
									<br/>메티컬기기관리, 체형및 비만관리, 산모관리, 통합기능 학습과정

								</p>
								<p>
									<strong>3) 스파테라피 과정</strong>
									<br/>CS, 스파영어, 스파 외국어(중국어, 일어), 헬스테인먼트, 리테일링 과정

								</p>
								<p>
									<strong>4) 매니지먼트 과정</strong>
									<br/>고객 상담과 불만관리, 광고와 소셜미디어, 직원채용 및 관리, 직원교육, 강사훈련, 미용교육, 뷰티&헬스 테라피 실습

								</p>
							</dd>
						</dl>
					</div>
				
					
						<%-- 
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beauty/photo_b_eximg01.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beauty/photo_b_eximg02.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beauty/photo_b_eximg03.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beauty/photo_b_eximg04.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beauty/photo_b_eximg05.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beauty/photo_b_eximg06.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beauty/photo_b_eximg07.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beauty/photo_b_eximg07.jpg'/>" /></li>
						</ul>
						<div id="bx-pager">
							<a data-slide-index="0" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beauty/photo_s_eximg01.jpg" /></a>
							<a data-slide-index="1" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beauty/photo_s_eximg02.jpg" /></a>
							<a data-slide-index="2" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beauty/photo_s_eximg03.jpg" /></a>
							<a data-slide-index="3" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beauty/photo_s_eximg04.jpg" /></a>
							<a data-slide-index="4" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beauty/photo_s_eximg05.jpg" /></a>
							<a data-slide-index="5" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beauty/photo_s_eximg06.jpg" /></a>
							<a data-slide-index="6" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beauty/photo_s_eximg07.jpg" /></a>
							<a data-slide-index="7" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beauty/photo_s_eximg08.jpg" /></a>
						</div>
					</div>
						 --%>
				</c:if>				
				<c:if test="${searchVO.menuType eq '03' }">
				
					<p class="area_info">
					일반적으로 병원서비스매니저라고도 한다. 병원의 중간 관리자로서, 환자들의 서비스 욕구를 충족시키기 위해 병원에서 해야 할 일을 기획·관리·개선 업무를 담당하는 사람을 말한다.

					</p>
					<p class="area_info">
					이들은 서비스 전문가로서 병원의 분위기를 밝게 연출하고, 차별화된 서비스를 제공함으로써 병원 이미지를 홍보하여 환자가 편한 마음으로 병원을 찾을 수 있도록 한다. 또한, 고객상담, 접수·수납 및 예약 관리, 병원마케팅, 직원교육 등의 업무도 맡는다. 이미 선직국에서는 오래 전부터 이 직업이 일반화되어 있으며 고객서비스를 위해 코디네이터를 두고 있다.

					</p>
				
						<%-- 
					<div class="photo_slider">
						<ul class="b_photo">
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beauty/photo_b_eximg01.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beauty/photo_b_eximg02.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beauty/photo_b_eximg03.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beauty/photo_b_eximg04.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beauty/photo_b_eximg05.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beauty/photo_b_eximg06.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beauty/photo_b_eximg07.jpg'/>" /></li>
						  <li><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/beauty/photo_b_eximg07.jpg'/>" /></li>
						</ul>
						<div id="bx-pager">
							<a data-slide-index="0" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beauty/photo_s_eximg01.jpg" /></a>
							<a data-slide-index="1" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beauty/photo_s_eximg02.jpg" /></a>
							<a data-slide-index="2" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beauty/photo_s_eximg03.jpg" /></a>
							<a data-slide-index="3" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beauty/photo_s_eximg04.jpg" /></a>
							<a data-slide-index="4" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beauty/photo_s_eximg05.jpg" /></a>
							<a data-slide-index="5" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beauty/photo_s_eximg06.jpg" /></a>
							<a data-slide-index="6" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beauty/photo_s_eximg07.jpg" /></a>
							<a data-slide-index="7" href=""><img src="${pageContext.request.contextPath }/assets/usr/img/beauty/photo_s_eximg08.jpg" /></a>
						</div>
					</div>
						 --%>
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