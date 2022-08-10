<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<body>
	<form:form commandName="searchVO" id="frm" name="frm">
		<form:hidden path="pageIndex" />
		<form:hidden path="searchType" />
		<form:hidden path="menuType" />
		<form:hidden path="searchCondition2" />
		<form:hidden path="searchWord" />
		<input type="hidden" id="mbSeq" name="mbSeq">
		<!-- skip_navigation -->
		<dl id="skip_nav">
			<dt>바로가기 메뉴</dt>
			<dd>
				<a href="#content">본문 바로가기</a>
			</dd>
			<dd>
				<a href="#top_menu">메뉴 바로가기</a>
			</dd>
			<dd>
				<a href="#footer">페이지 하단 바로가기</a>
			</dd>
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
					<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu" />
					<!--// lnb -->
					<!-- content -->
					<div class="sub_content">
						<!-- 타이틀 영역 -->
						<jsp:include
							page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle2.jsp">
							<jsp:param name="dept1" value="전공" />
							<jsp:param name="dept2" value="패션비즈니스" />
							<jsp:param name="dept3" value="전공안내" />
						</jsp:include>

						<div class="top_tab type_li2">
							<ul>
								<li
									<c:if test="${searchVO.menuType eq '01' }">class="active"</c:if>><a
									href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fbusiness/majorFbusinessInfo.do?menuType=01'/>">전공
										소개</a></li>
								<li
									<c:if test="${searchVO.menuType eq '02' }">class="active"</c:if>><a
									href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fbusiness/majorFbusinessInfo.do?menuType=02'/>">산학협력기업</a></li>
							</ul>
						</div>
						<div class="sub_cont_page">
							<c:if test="${searchVO.menuType eq '01' }">
								<dl class="info_dl">
									<dd>
										<p>한성대학교 한디원 패션비즈니스는 급변하는 시대에 발 빠르게 적응할 수 있는 창의적 패션인재를
											양성하기 위한 패션관련 전공입니다.</p>
										<p>현시대의 패션산업은 과거와 차별화 된 다양한 채널을 통해 이루어지고 있습니다. 인터넷을 기반으로
											하는 패션 비즈니스는 이미 고성장의 궤도에 올라섰으며 모바일을 활용한 패션 비즈니스, 해외시장을 타깃으로 한
											패션 비즈니스가 성장세에 있습니다. 또한 규모면에서 대기업 위주의 패션사업 뿐 아니라 개인이나 소자본을
											기반으로 한 비즈니스 등 다양한 형태로 이루어지고 있는 실정입니다. 또한 현재 패션시장은 Ddesigner의
											개념을 뛰어넘어 Creative Director 개념의 인재를 요구하고 있어 보다 창의적인 사고를 통해
											조화로운 미를 창조해 나가야 합니다.</p>
										<p>한디원 패션비즈니스전공은 이러한 변화에 민감하게 대처할 수 있는 패션MD, 패션VMD, 패션바이어,
											패션 마케터, 패션 디렉터, 패션 에디터, 패션 크리에티브 디렉터, 인터넷/모바일 패션창업주를 양성하는
											체계적인 교육시스템을 갖추고 있습니다.</p>
									</dd>
								</dl>
								<dt>&nbsp;</dt>
								<div class="s_tit">한디원 패션비즈니스 전공 특징</div>
								<div class="sub_cont_page">
									<dl class="info_dl">
										<dd>
											<p>패션 비즈니스전공은 급변하는 사회, 문화와 끊임없이 소통하고 발전하여 시대를 앞서가는, 나아가
												소비자의 Needs를 역으로 끌어내어 늘 새로운 스타일을 창조 할 수 있는 토탈 패션 전문인 양성 및 패션계
												곳곳에서 스페셜리스트로 일할 수 있는 역동적인 주역 양성을 목표로 합니다.</p>
											<p>따라서 세부전공별 체계적이고 효율적인 교과과정 및 교과내용을 통한 정확한 내용의 학습과 현업에
												계신 교수님을 통해 실무경험 및 프로젝트수업을 강화함으로써 시대의 트렌드와 전문성이 강화된 교육을 실시하여
												졸업 후 바로 해당 분야에서 뛰어난 능력을 발휘 할 수 있는 전문인을 배출하고 있습니다.</p>
										</dd>
									</dl>
									<div class="sub_cont_box">
										<div class="tit_3rd">패션비즈니스 전공과정</div>
										<img src="${pageContext.request.contextPath }/assets/usr/img/fbusiness/fbusinessInfo_01.jpg"/>
										<%--
										<div class="ta_type_dl">
											<dl>
												<dt><span>1학년</span></dt>
												<dd><span>[기초과정] 의복과색채, 패션디자인론, 패션소재연구, 패션일러스트레이션1, 의복구성, 패턴기초 등</span></dd>
											</dl>
											<dl>
												<dt><span>2학년</span></dt>
												<dd><span>[응용과정] 패션마케팅, 패션머천다이징, 패션CAD실습, 패션코디네이션, 패션트렌드분석, 서양복식사, 비주얼머천다이징, 패션e비즈니스 등</span></dd>
											</dl>
											<dl>
												<dt><span>3학년</span></dt>
												<dd><span>[심화과정] 패션산업론, 패션미디어, 패션스타일링, 패션유통론, 의상사회심리, 스토어 MD실습, 세일즈프로모션전략 등</span></dd>
											</dl>
											<dl>
												<dt><span>4학년</span></dt>
												<dd><span>[취업 및 창업준비과정] 글로벌패션비즈니스, 패션산업체연수실습, 패션마켓리서치, 패션아웃소싱, 패션기업경영론, 패션포트폴리오 등</span></dd>
											</dl>
										</div>
										--%>
										<div class="ta_txt">
											<ul>
												<li>패션비즈니스 매학기 2회 이상,  1년 4회 이상 패션창업과 관련된 특강이 진행되며 패션창업 및 취업에 관련한 멘토링 프로그램을 실시하고 있습니다. 또한 취업성공 선배와 재학생간의 교류를 통해 취업연계 및 학교생활 지원을 진행하고 있습니다.</li>
											</ul>
										</div>
									</div>
								</div>
							</c:if>
							<c:if test="${searchVO.menuType eq '02' }">
								<dl class="info_dl">
									<dd>
										<div class="partner_info">
											<dl>
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part0601_img.jpg'/>"
														alt="auction" />
												</dt>
												<dd>
													auction
													<p>산학협력의 취지에 입각하여 산업체에세 필요로 하는 경쟁력을 갖춘 창조적 전문 인력의 양성과
														대학생들의 원활한 취업 및 창업 지원을 목표로 실무산학협약을 맺었습니다.</p>
												</dd>
											</dl>

										</div>
										<div class="partner_info">
											<dl>
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part0602_img.jpg'/>"
														alt="ebay" />
												</dt>
												<dd>
													ebay
													<p>산학협력의 취지에 입각하여 산업체에세 필요로 하는 경쟁력을 갖춘 창조적 전문 인력의 양성과
														대학생들의 원활한 취업 및 창업 지원을 목표로 실무산학협약을 맺었습니다.</p>
												</dd>
											</dl>

										</div>
										<div class="partner_info">
											<dl>
												<dt>
													<img
														src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/part0603_img.jpg'/>"
														alt="gmarket" />
												</dt>
												<dd>
													gmarket
													<p>산학협력의 취지에 입각하여 산업체에세 필요로 하는 경쟁력을 갖춘 창조적 전문 인력의 양성과
														대학생들의 원활한 취업 및 창업 지원을 목표로 실무산학협약을 맺었습니다.</p>
												</dd>
											</dl>

										</div>
									</dd>
								</dl>
							</c:if>
						</div>
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