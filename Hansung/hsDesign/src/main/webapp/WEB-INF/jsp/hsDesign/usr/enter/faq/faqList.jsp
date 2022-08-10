<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<body>
	<form:form commandName="searchVO" id="frm" name="frm">
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
			<!-- header area -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
			<!-- //header area -->
			<div class="main_content" id="content">
				<div class="width_box">
					<!-- left menu area-->
					<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu" />
					<!-- //left menu area-->
					<div class="sub_content">
						<c:import url="/EgovPageLink.do?link=usr/inc/incPageTitle">
							<c:param name="dept1" value="입학안내" />
							<c:param name="dept2" value="자주하는질문" />
						</c:import>

						<div class="top_tab type_li4">
							<ul>
								<li
									<c:if test="${searchVO.menuType eq '01' }">class="active"</c:if>><a
									href="<c:out value='${pageContext.request.contextPath }/usr/enter/faq/faqList.do?menuType=01'/>">입학, 학사학위, 졸업후 진로 관련</a></li>
								<li
									<c:if test="${searchVO.menuType eq '02' }">class="active"</c:if>><a
									href="<c:out value='${pageContext.request.contextPath }/usr/enter/faq/faqList.do?menuType=02'/>">강의, 수강신청 관련</a></li>
								<li
									<c:if test="${searchVO.menuType eq '03' }">class="active"</c:if>><a
									href="<c:out value='${pageContext.request.contextPath }/usr/enter/faq/faqList.do?menuType=03'/>">학교생활, 기숙사 관련</a></li>
								<li
									<c:if test="${searchVO.menuType eq '04' }">class="active"</c:if>><a
									href="<c:out value='${pageContext.request.contextPath }/usr/enter/faq/faqList.do?menuType=04'/>">기타</a></li>
							</ul>
						</div>

						<c:if test="${searchVO.menuType eq '01' }">
							<div class="sub_cont_page">
								<dl class="info_dl">
									<dd>

										<dl class="info_dl_txt">
											<dt>Q. 한디원 선발기준과 지원 자격은 어떻게 되나요?</dt>
											<dd>디자인 예술분야에 대한 학업 의지가 강한 학생을 선발하고자 하는 선진화된 교육 철학에 따라 수능이나 내신성적을 반영하지 않고 학생들을 선발합니다. 또한 다양한 경험과 사고를 지닌 학생들간의 융합을 위해 미술 및 디자인에 대한 공부경험이 없는 학생들도 고등학교 졸업 이상의 학력소지자라면 누구나 지원할 수 있도록 하고 있습니다.</dd>

											<dt>Q. 면접은 어떻게 진행되나요?</dt>
											<dd>지원자들은 각 전공교수님과 1:1 또는 2:2 심층면접을 보게 됩니다. 면접에서는 전공에 대한 깊은 지식보다는 지원 전공에 대한 열정, 학생의 인성 등을 폭넓게 판단합니다. 면접 시 추천서나 포트폴리오, 수상경력 등이 있다면 이점이 있겠지만 필수 조건은 아닙니다. 해당 전공에 대한 기본적인 수준의 소양과 학생 자신의 꿈과 비전에 대하여 교수님께 잘 피력할 수만 있다면 좋은 결과를 기대할 수 있습니다.</dd>

											<dt>Q. 한성대학교 총장명의 학사학위란?</dt>
											<dd>한성대학교 총장명의 학사학위란 학점은행제를 통해 4년제 대학교인 한성대학교의 총장 명의로 수여하는 학사학위입니다. 이 학사학위는 4년제 대학교 졸업자와 동등한 자격으로 수여하는 것이며 회사에 취업을 하실 경우 초대졸이 아닌 4년제 대학교 졸업자 자격으로 지원이 가능하며, 편입을 희망하는 경우 '학사편입'을 하실 수 있습니다. 또한 대학원으로 바로 진학하실 수 있습니다.</dd>
											
											<dt>Q. 학위증(졸업장)과 학위증명서(졸업증명서)의 차이는 무엇인가요?</dt>
											<dd>'학위증'은 학위수여시 교부되는 증서로 대학의 졸업장과 같은 효력의 다른 양식입니다. 학위증은 교육부장관 혹은 대학의 총장 등에 의해 교부되는 것이므로 분실시 재발급이 불가능한 서류이며 보관용일뿐 제출하는 용도로는 사용할 수 없습니다. 반면 '학위증명서'는 진학 또는 취업 시 <font style="text-decoration: underline;">최종학력증명서로 제출하기 위한 제출용 증명서로서 복수 발급이 가능합니다.</font> 한디원에서는 학위수여 요건을 갖춘 자에게  '학위증'과 '학위증명서'를 모두 수여 또는 발급하고 있습니다.</dd>

											<dt>Q. 한성대학교 본교 학사학위와 어떠한 차이가 있나요?</dt>
											<dd>
												한디원에서 학점 이수를 마치고 졸업작품 심사를 통과하면 한성 대학교 총장명의 학사학위가 수여됩니다. 현재 한성대학교에서 발급되는 총장명의 학위에는 두 가지 방식이 있습니다.<br><br>
												① 「고등교육법」에 의한 학사학위<br>
												② 「평생교육법」에 의한 학사학위<br><br>
												①번의 경우에는 한성대학교 본교 학생들에게 적용이 되며, ②번 평생교육법에 의거한 총장명의 학위는 한디원 학생들에게 적용됩니다. <font style="text-decoration: underline;">둘 다 한성대학교에서 발급되는 학사학위로 법적인 효력은 동일합니다.</font><br>
												보통 기업 공채에 지원하는 한디원 학생들은 이력서상에 한성대학교로 기입하고 비고란에 학점은행제라고 적습니다. 단, 한디원에서 한성대 총장명의가 아닌 교육부장관명의로 학위를 취득했다면 한성대학교로 기재할 수 없으며 국가평생교육진흥원이라고 적어야 합니다. 현재 졸업생의 약 95%는 한성대학교 총장명의 학위를 받고 있습니다.(2017학년도 학위수여식 기준)
											</dd>

											<dt>Q. 졸업 후 취업은 잘 되나요?</dt>
											<dd>
												디자인분야 취업시장에서는 실력이 출중한 한디원 졸업생과 평범한 실력의 일반대학 졸업생이 경쟁한다면 한디원 졸업생이 뽑힐 가능성이 더욱 높습니다.<br>
												기업의 채용 과정에서 학벌이 중요한 변수로 작용하는 문/이과 계열 전공과 달리 디자인 전공의 경우 실무 능력이 더욱 중요한 요인으로 평가됩니다. 포트폴리오나 공모전 수상경력을 통해 지원자의 실제 디자인 실력 검증이 가능하기 때문입니다.<br>
												한디원은 실무현장에 재직 중인 교수진의 비율을 90%까지 높이고 기업과 함께하는 프로젝트식 수업을 도입하는 등 디자인 취업시장에 특성화된 교육 환경을 갖추고 있습니다. 일반대학에 서는 제공하기 힘든 실무 중심의 커리큘럼을 통해 현재 여러 디자인회사는 물론 대기업 대졸 공채에 합격하는 졸업생들도 꾸준히 나오고 있습니다.
											</dd>

											<dt>Q. 편입이나 대학원 진학도 할 수 있나요?</dt>
											<dd>
												가능합니다. 보통 일반편입의 경우 한디원에서 총 70학점 이상을 이수한 후 지원할 수 있습니다.(학교에 따라 지원자격은 다를수 있음)<br>
												또한 학점은행제 특성 상 빠른 학사학위 취득이 가능하므로 한디원에서 3년만에 4년제 학사학위를 취득하여 학사편입으로 지원하는 것도 가능합니다. 일반적으로 경쟁률이 높은 일반편입에 비해 정원 외로 선발하는 학사편입이 조금 더 수월합니다.<br>
												졸업 후 대학원에 진학하여 석사 과정을 밟을 수도 있습니다. 매년 다수의 졸업생들이 국내외 디자인 대학원으로 진학하고 있으 며, 만일 한성대학교 일반대학원으로 진학하는 경우에는 성적에 관계없이 2년 동안 수업료의 50%(특수대학원 30%)를 장학금 으로 지원받습니다.
											</dd>

											<dt>Q. 일반대학과 복수지원이 가능한가요?</dt>
											<dd>한디원은 고등교육법의 적용을 받지 않으므로 일반대학의 수시, 정시 전형과 관계없이 얼마든지 복수지원이 가능합니다.</dd>
										</dl>

									</dd>
								</dl>
							</div>
						</c:if>
						<c:if test="${searchVO.menuType eq '02' }">
							<div class="sub_cont_page">
								<dl class="info_dl">
									<dd>

										<dl class="info_dl_txt">
											<dt>Q. 강의는 어디서 받나요? 온라인 강의인가요?</dt>
											<dd>한디원은 100% 오프라인 수업이며 한성대학교 본교에서 모든 수업이 진행됩니다. 또한 입학과 동시에 한성대학교 학생증이 발급되어 학술정보관(도서관)이나 체력단련실과 같은 교내 시설을 자유롭게 이용할 수 있습니다.</dd>
											
											<dt>Q. 강의시간은 어떻게 되나요?</dt>
											<dd>강의시간은 일반적으로 월~금요일 주간에 배정됩니다.(전공마다 다르므로 매 학기 시간표 참고) 단, 일학습엘리트과정(재직자과정)의 경우 주말 또는 평일 야간에 배정되므로 개강 전 시간표를 확인하시기 바랍니다.</dd>
											
											<dt>Q. 수강신청은 어떻게 하나요?</dt>
											<dd>수강신청은 개강 2~3주 전에 실시하며, 수강신청 방법은 신입생의 경우 해당 전공에서 일괄 신청합니다. 재학생의 경우 학사정보시스템(http://edulms.hansung.ac.kr)을 통해 본인이 개별신청합니다. 또한 수강신청 정정은 정정기간에만 가능하며, 수강신청정정원을 작성하여 교학팀에 제출하면 됩니다.</dd>
										</dl>
										
									</dd>
								</dl>
							</div>
						</c:if>
						<c:if test="${searchVO.menuType eq '03' }">
							<div class="sub_cont_page">
								<dl class="info_dl">
									<dd>

										<dl class="info_dl_txt">
											<dt>Q. 학생증은 나오나요?</dt>
											<dd>학생증은 한성대 본교 학생들과 동일한 포맷의 모바일 학생증을 교부받습니다. 모바일 학생증을 이용하여 학술정보관(도서관)이나 체력단련실 등의 복지시설을 이용할 수 있습니다.</dd>
											
											<dt>Q. O.T나 M.T도 가나요?</dt>
											<dd>신입생 오리엔테이션은 입학식을 마친 이후 학교생활안내, 전공안내, 학생회소개, 동아리 축하공연 등의 다양한 행사로 진행됩니다.1학기 중에는 2~3일의 일정으로 학과별 연합 M.T가 진행되며 2학기에는 반별 또는 학년별 소규모 M.T가 진행됩니다. 또한 축제를 비롯하여 해외답사, 졸업작품전시회, 체육대회, 과제전 등 매 학기가 다양한 학과 행사들로 채워져 있습니다.</dd>

											<dt>Q. 장학금을 받을 수 있나요?</dt>
											<dd>일반대학교의 장학제도(성적장학금, 공로장학금, 국가유공자 장학금 등)와 동일한 다양한 혜택이 있으며,특히, 우리기관의 성적우수 장학금은 등록금전액면제를 비롯한 많은 학생에게 장학금혜택을 드리고 있습니다.(학사안내-장학규정 참조)</dd>

											<dt>Q. 한성대학교 도서관을 이용할 수 있나요?</dt>
											<dd>입학 시 발급해 드리는 학생증을 이용하여 한성대학 미래관에 위치한 학술정보관(도서관)을 언제든지 이용하실 수 있습니다.</dd>

											<dt>Q. 동아리는 어떤 것이 있나요?</dt>
											<dd>한성대학교에 있는 모든 동아리에 가입할 수 있습니다. 밴드동아리-왕산악, 댄스동아리-NOD 등 40여개의 동아리에서 가입을 희망하는 학생들을 기다리고 있습니다!</dd>

											<dt>Q. 기숙사 신청 기간은 언제인가요?</dt>
											<dd>기숙사 신청은 매해 2월 초, 8월 초에 진행되며, 정확한 일시와 조건 등은 매년 변경되니 공지사항을 필독하여 주시기 바랍니다.</dd>

											<dt>Q. 기숙사 추첨 방식은 어떻게 되나요? 어떤 기준으로 뽑나요?</dt>
											<dd>기본적으로 현 거주지가 먼 학생을 우선적으로 선발하며, 추가적으로 기초생활보장법수급자, 차상위계층, 재외국민에게 우선순위를 드립니다. ※ 모든 조건이 동일할 경우 학업성적을 고려하여 선발하게 됩니다.</dd>
											
											<dt>Q. 기숙사 비용은 얼마인가요?</dt>
											<dd>기숙사 비용은 1일 6,500원으로 책정되어있으며, 사용일수 × 6,500원으로 계산됩니다. 그리고 보증금으로 100,000원이 부과됩니다. (보증금은 계약기간이 끝나면 환급되는 비용입니다.) ※ 정확한 기숙사 비용은 기숙사 신청 공지사항을 통해 확인하실 수 있습니다.</dd>

											<dt>Q. 학기 중 휴학이나 장학금 신청이 가능한가요?</dt>
											<dd>재학 중 일반휴학은 최소 6개월~ 최대 3년까지 가능합니다.(단, 휴학신청시 1회 최대 1년에 한함) 또한 군입영휴학은 일반휴학과 별도로 2년동안 휴학이 가능합니다(학사안내 참고) 또한 한디원 재학생들에게는 성적장학금, 공로장학금, 국가유공자장학금 등의 다양한 장학금 혜택이 주어집니다.</dd>
										</dl>
									</dd>
								</dl>
							</div>

						</c:if>
						<c:if test="${searchVO.menuType eq '04' }">
							<div class="sub_cont_page">
								<dl class="info_dl">
									<dd>
										<dl class="info_dl_txt">
											<dt>Q. 학자금 대출은 되나요?</dt>
											<dd>
												현재 학점은행제도에 의해 운영되는 모든 교육기관은 정부융자학자금 대출이 되고 있지 않습니다. (단, 공무원자녀와 교원자녀에게는 학자금 대출이 가능) 관련되는 많은 학교에서 교육과학기술부 산하 평생교육진흥원에 지속적으로 민원을 넣고 있으며, 근래에 어려운 경제 여건으로 인해 학비부담이 더욱 커질 것으로 예상되어 빠른 시일 내에 우리 학생들도 정부융자 학자금대출 혜택을 받을 수 있게 되기를 희망합니다. <br>
												한디원에서는 학비에 대한 부담을 덜어 드리고자 아래와 같이 다양한 노력을 기하고 있습니다.<br><br>
												1. 재학생들에게는 등록금을 3차례에 걸쳐서 분할납부 할 수 있게 하고 있습니다.<br>
												2. 재학생들에게는 등록금전액을 비롯한 다양한 장학금을 드리고 있습니다. (성적장학금/공로장학금/근로장학금 등)<br>
												3. 신입생에게는 등록금 납부기한 연기를 통해 부담을 덜어드립니다. 그리고 최대한 많은 학생들이 혜택을 받을 수 있도록 다양한 장학규정이 마련되어 있으니 홈페이지에서 장학제도를 꼭 참고하시기 바랍니다. (상담 02-760-5781)
											</dd>
										</dl>
									</dd>
								</dl>
								<%--
								<div class="s_tit" style="margin-top: 30px;">특별한 혜택은 어떤
									것들이 있나요?</div>
								<dl class="faq_dl">
									<dt>1. 한성대학교 총장명의 학사학위 취득</dt>
									<dd>한성대학교 디자인아트교육원에 개설된 학사학위과정은 졸업 후 한성대학교 총장명의 학사학위(4년제
										졸업학위)를 수여합니다.</dd>
								</dl>
								<dl class="faq_dl">
									<dt>2. 한성대학교 캠퍼스에서의 학교생활</dt>
									<dd>한성대학교 본교에서 모든 캠퍼스 생활을 누릴 수 있으며, 한성대학교 학생증을 발급받아 교내 시설을
										이용할 수 있습니다.</dd>
								</dl>
								<dl class="faq_dl">
									<dt>3. 다양하고 풍성한 장학혜택!</dt>
									<dd>학생들의 학업의욕을 고취시키고 후생복지를 향상시키기 위해 한성대학교 총장 장학금, 교수추천
										장학금, 근로장학금, 성적우수 장학금 등 폭넓은 장학혜택을 드리고 있습니다.</dd>

								</dl>

								<dl class="faq_dl">
									<dt>4. 전문자격증 취득과 특별초청강의 및 전공 세미나 실시!</dt>
									<dd>전문분야의 자격증 취득은 학점으로 인정받을 수 있으며 취업에 있어서도 유리한 조건을 부여합니다.
										사회 각 분야 저명인사들의 특별초청강의 및 실무자들의 전공세미나 등 유익한 프로그램을 정기적으로 시행합니다.</dd>
								</dl>

								<dl class="faq_dl">
									<dt>5. 한성대학교 대학원 진학시 장학혜택 부여!</dt>
									<dd>더 놓은 꿈을 위해 달려나가는 열정있는 학생들을 위해 한성대학교 대학원에서는 2년간 등록금의
										50% 장학혜택을 부여합니다. (계열 전공)</dd>
								</dl>
								--%>


							</div>
							<div class="go_top"><a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a></div>
						</c:if>
					</div>
				</div>
			</div>
			<!-- footer -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
			<!-- //footer -->
		</div>
		<input type="hidden" id="message" value="${message}" />
	</form:form>
</body>
</html>