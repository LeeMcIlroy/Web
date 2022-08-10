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
            	<jsp:param name="dept1" value="센터소개"/>
            	<jsp:param name="dept2" value="사고와표현교육과정"/>
            </jsp:include>
			<div class="cont_box">			
				<div id="ch_cont01" style="display:block;">
					<div class="tab li3_i">
						<ul>						
							<li><a href="javascript:testDisplay('01');" class="active">교육 목표 및 육성 역량</a></li>
							<li><a href="javascript:testDisplay('02');">교육과정 체계</a></li>
							<li><a href="javascript:testDisplay('03');">교육과정 조직</a></li>
						</ul>
					</div>	
					<div class="gt_tit mt40">
						<strong>교육 목표 및 육성 역량</strong>						
					</div>
					<dl class="p09_txt02">
						<dt>교육 목표</dt>
						<dd>
							<ul class="p09_icon02">
								<li style="background:url(none); padding-left:0;">사고와표현교육과정은 공동선을 추구하는 창조적 인재를 양성하여 합리적인 사회인을 배출하는 것을 교육 목표로 하고, 다음과 같은 구체적인 인재상을 추구한다.</li>
								<li style="background:url(none); padding-left:0;">첫째, 논리적이고 창의적인 사고력과 의사소통능력을 갖춘 인재</li>
								<li style="background:url(none); padding-left:0;">둘째, 언어사용을 토대로 대인관계를 유지하고 개선하는 대인관계능력을 갖춘 인재 </li>
								<li style="background:url(none); padding-left:0;">셋째, 주어진 문제를 창의적이고 유연하게 해결하는 문제해결력을 갖춘 인재 </li>
								<li style="background:url(none); padding-left:0;">넷째, 자기 자신의 능력을 끊임없이 개발하는 자기개발능력을 갖춘 인재 </li>
							</ul>
						</dd>
					</dl>
					<dl class="p09_txt02">
						<dt>육성 역량</dt>
						<dd>
							<ul class="p09_icon02">
								<li style="background:url(none); padding-left:0;">사고와표현교육과정의 육성 역량은 다음과 같다.</li>
								<li style="background:url(none); padding-left:0;">첫째, 대학 및 사회생활에 필요한 논리적이고 창의적인 사고역량을 함양한다.</li>
								<li style="background:url(none); padding-left:0;">둘째, 성찰적 사고와 비판적 사고 역량을 갖춘 미래 지향적인 인성역량을 함양한다.</li> 
								<li style="background:url(none); padding-left:0;">셋째, 다양한 읽기를 통해 대학 교양 수준의 지식역량을 함양한다. </li>
								<li style="background:url(none); padding-left:0;">넷째, 전공 및 교양 지식을 활용하여 글쓰기와 말하기의 표현역량을 함양한다.</li> 
								<li style="background:url(none); padding-left:0;">다섯째,  올바르고 적절한 한국어 사용역량을 함양한다. </li>
								<li style="background:url(none); padding-left:0;">여섯째, 개인별, 팀별 글쓰기와 말하기 활동을 통해 자기주도적학습능력과 협동학습능력 및 대인관계역량을 함양한다.</li> 
								<li style="background:url(none); padding-left:0;">일곱째, 자신과 사회가 처한 과제를 해결하는 문제해결역량을 함양한다. </li>
								<li style="background:url(none); padding-left:0;">여덟째, 결국 우리 사회의 건강한 구성원으로서 살아가는 데 필요한 의사소통역량을 함양한다.</li>
							</ul>
						</dd>
					</dl>
					
				</div>
				<div id="ch_cont02" style="display:none;">
					<div class="tab li3_i">
						<ul>						
							<li><a href="javascript:testDisplay('01');">교육 목표 및 육성 역량</a></li>
							<li><a href="javascript:testDisplay('02');" class="active">교육과정 체계</a></li>
							<li><a href="javascript:testDisplay('03');">교육과정 조직</a></li>
						</ul>
					</div>
					<div class="gt_tit mt40">
						<strong>교육과정 체계</strong>						
					</div>
					<div class="mt40" style="text-align:center;"><img src="/assets/usr/img/wic_img03.jpg" /></div>
				</div>
				<div id="ch_cont03" style="display:none;">				
					<div class="tab li3_i">
						<ul>						
							<li><a href="javascript:testDisplay('01');">교육 목표 및 육성 역량</a></li>
							<li><a href="javascript:testDisplay('02');">교육과정 체계</a></li>
							<li><a href="javascript:testDisplay('03');" class="active">교육과정 조직</a></li>
						</ul>
					</div>
					<div class="gt_tit mt40">
						<strong>교육과정 조직</strong>						
					</div>
					<div class="map_box mt40">
						<div class="mt15">상상력 교양교육원</div>
						<div class="mt15">사고와표현교육과정</div>
						<div class="map_box02 mt30">
							<dl>
								<dt>사고와표현 연구실</dt>								
								<dd>
								
									<div>
										<div></div>
										<dl>
											<dt>권 정 현</dt>
											<dd>사고와표현교육과정</dd>
											<dd>학술연구원(책임연구원)</dd>
											<dd>02-760-4354</dd>
											<dd>mari7998@naver.com</dd>
										</dl>
									</div>
									<div>
										<div></div>
										<dl>
											<dt>곽 유 석</dt>
											<dd>사고와표현교육과정</dd>
											<dd>학술연구원</dd>
											<dd>02-760-4354</dd>
											<dd>usk0218@naver.com</dd>
										</dl>
									</div>
									<div>
										<div></div>
										<dl>
											<dt>이 원 지</dt>
											<dd>사고와표현교육과정</dd>
											<dd>학술연구원</dd>
											<dd>02-760-4354</dd>
											<dd>blairwonjee@naver.com</dd>
										</dl>
									</div>
									<div>
										<div></div>
										<dl>
											<dt>이 임 정</dt>
											<dd>사고와표현교육과정</dd>
											<dd>학술연구원</dd>
											<dd>02-760-4354</dd>
											<dd>re1980@naver.com</dd>
										</dl>
									</div>
									<div>
										<div></div>
										<dl>
											<dt>이 홍 미</dt>
											<dd>사고와표현교육과정</dd>
											<dd>학술연구원</dd>
											<dd>02-760-4354</dd>
											<dd>picture1132@naver.com</dd>
										</dl>
									</div>
									<div>
										<div></div>
										<dl>
											<dt>조 은 별</dt>
											<dd>사고와표현교육과정</dd>
											<dd>학술연구원</dd>
											<dd>02-760-4354</dd>
											<dd>ovely-eunbyeol@hanmail.net</dd>
										</dl>
									</div>
									<div>
										<div></div>
										<dl>
											<dt>박 민</dt>
											<dd>사고와표현교육과정 </dd>
											<dd>행정조교</dd>
											<dd>writing@hansung.ac.kr</dd>
										</dl>
									</div>
								</dd>
							</dl>
							<dl>
								<dt>담당교수</dt>								
								<dd>
									<div>
										<div><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/center_img01_02.jpg'/>" alt="이상혁" /></div>
										<dl>
											<dt>이 상 혁</dt>
											<dd>사고와표현교육과정 부교수</dd>
											<dd>02-760-4312</dd>
											<dd>leesh@hansung.ac.kr</dd>
										</dl>
									</div>
									<div>
									<%--
										<div><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/center_img01_01.jpg'/>" alt="나은미" /></div>
									--%>
										<div><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/center_img01_01_1.jpg'/>" alt="나은미" /></div>
										<dl>
											<dt>나 은 미</dt>
											<dd>사고와표현교육과정 부교수</dd>
											<dd>02-760-4319</dd>
											<dd>nem@hansung.ac.kr</dd>
										</dl>
									</div>
									<div>
										<div><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/center_img01_03.jpg'/>" alt="박선옥" /></div>
										<dl>
											<dt>박 선 옥</dt>
											<dd>사고와표현교육과정 부교수</dd>
											<dd>02-760-5882</dd>
											<dd>psunok01@naver.com</dd>
										</dl>
									</div>
									<div>
										<div><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/center_img01_04.jpg'/>" alt="권혁명" /></div>
										<dl>
											<dt>권 혁 명</dt>
											<dd>사고와표현교육과정 강의전담교수</dd>
											<dd>02-760-4250</dd>
											<dd>17857@hanmail.net</dd>
										</dl>
									</div>
									<div>
										<div><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/center_img01_05.jpg'/>" alt="이희영" /></div>
										<dl>
											<dt>이 희 영</dt>
											<dd>사고와표현교육과정 강의전담교수</dd>
											<dd>02-760-4379</dd>
											<dd>corkey@naver.com</dd>
										</dl>
									</div>
									<div>
										<div><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/center_img01_06.png'/>" alt="임형모" /></div>
										<dl>
											<dt>임 형 모</dt>
											<dd>사고와표현교육과정 강의전담교수</dd>
											<dd>02-760-4379</dd>
											<dd>simsimiwana@daum.net</dd>
										</dl>
									</div>
								</dd>
							</dl>
							<dl>
								<dt>위원회</dt>								
								<dd>
									<div>
										<div><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/center_img02_07.jpg'/>" alt="이상혁" /></div>
										<dl>
											<dt>이 상 혁</dt>
											<dd>사고와표현교육과정</dd>
											<dd>02-760-4312</dd>
											<dd>leesh@hansung.ac.kr</dd>
										</dl>
									</div>
									<div>
									<%--
										<div><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/center_img02_01.jpg'/>" alt="나은미" /></div>
									--%>
										<div><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/center_img01_01_1.jpg'/>" alt="나은미" /></div>
										<dl>
											<dt>나 은 미</dt>
											<dd>사고와표현교육과정</dd>
											<dd>02-760-4319</dd>
											<dd>nem@hansung.ac.kr</dd>
										</dl>
									</div>
									<div>
										<div><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/center_img02_08.jpg'/>" alt="박선옥" /></div>
										<dl>
											<dt>박 선 옥</dt>
											<dd>사고와표현교육과정</dd>
											<dd>02-760-5882</dd>
											<dd>psunok01@naver.com</dd>
										</dl>
									</div>
									<div>
										<div><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/center_img02_02_1.png'/>" alt="정호섭" /></div>
										<dl>
											<dt>정 호 섭</dt>
											<dd>글로컬역사 트랙</dd>
											<dd>02-760-8047</dd>
											<dd>hsjung@hansung.ac.kr</dd>
										</dl>
									</div>
									<div>
										<div><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/center_img02_03_1.png'/>" alt="안현주" /></div>
										<dl>
											<dt>안 현 주</dt>
											<dd>패션디자인 트랙</dd>
											<dd>02-760-5963</dd>
											<dd>ahj727@hansung.ac.kr</dd>
										</dl>
									</div>
									<div>
										<div><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/center_img02_04_1.png'/>" alt="우윤환" /></div>
										<dl>
											<dt>우 윤 환</dt>
											<dd>기계설계 트랙</dd>
											<dd>02-760-4149</dd>
											<dd>yhwoo@hansung.ac.kr</dd>
										</dl>
									</div>
									<div>
										<div><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/center_img02_05_1.png'/>" alt="최강화" /></div>
										<dl>
											<dt>최 강 화</dt>
											<dd>기업경영 트랙</dd>
											<dd>02-760-8015</dd>
											<dd>khchoi@hansung.ac.kr</dd>
										</dl>
									</div>
									<div>
										<div><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/center_img02_06_1.png'/>" alt="조난숙" /></div>
										<dl>
											<dt>조 난 숙</dt>
											<dd>기초교양 교육과정</dd>
											<dd>02-760-4166</dd>
											<dd>ncho@hansung.ac.kr</dd>
										</dl>
									</div>
								</dd>
							</dl>
						</div>
					</div>
				</div>
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