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
	if(num == "01"){
		ch_cont01.style.display = 'block';
		ch_cont02.style.display = 'none';
	}else if (num == "02") {
		ch_cont01.style.display = 'none';
		ch_cont02.style.display = 'block';
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
            	<jsp:param name="dept1" value="센터 소개"/>
            	<jsp:param name="dept2" value="사고와 표현 강좌 소개"/>
            </jsp:include>
            <div class="cont_box">
            	<div id="ch_cont01" style="display:block;">
					<div class="tab">
						<ul>						
							<li><a href="javascript:testDisplay('01');" class="active">기초교양</a></li>
							<li><a href="javascript:testDisplay('02');">핵심교양</a></li>
						</ul>
					</div>
					<div class="gt_tit mt40">
						<strong>기초교양</strong>						
					</div>
					<table class="list_p02">
						<colgroup>
							<col width="15%" />
							<col width="23%" />
							<col width="15%" />
							<col width="23%" />
							<col width="24%" />						
						</colgroup>
						<thead>
							<tr>
								<th>영역</th>
								<th>교과목명</th>
								<th>학점</th>
								<th>개설학기</th>
								<th>비고</th>							
							</tr>
						</thead>
						<tbody>
							<tr>
								<td rowspan="4">기초교양</td>
								<td>사고와 표현 Ⅰ</td>
								<td>2</td>
								<td>1학기 개설</td>
								<td>글쓰기 중심</td>
							</tr>
							<tr>
								<td colspan="4" class="cont">
									&lt;사고와 표현 Ⅰ, Ⅱ&gt;는 필수 교양 과목으로 대학 수학 과정 및 사회생활에 필요한 논리적이고 창의적인 사고와 표현 능력을 함양하도록 하는 데 목적이 있다. 이 교과목의 교육 요소는 구체적인 활동 영역들인 독해, 작문, 발표 및 토의와 토론 활동 등이 서로 긴밀하게 연관되는 맥락에서 구성되었다. <사고와 표현Ⅰ>에서는 읽기를 통한 사고와 패턴별 쓰기 표현에 중점을 두고 있다. 수강생들은 대학별 특성을 고려한 강의계획에 따라 수업에 능동적으로 참여함으로써 대학 및 사회가 요구하는 기초적인 경쟁력이 형성될 것이다.
								</td>
							</tr>
							<tr>						
								<td>사고와 표현 Ⅱ</td>
								<td>2</td>
								<td>2학기 개설</td>
								<td>말하기 중심</td>
							</tr>
							<tr>
								<td colspan="4" class="cont">
									&lt;사고와 표현 Ⅱ&gt;는 정보전달 및 설득적 말하기 능력을 함양하는 것을 목적으로 한다. 모든 수강생은 직접 PPT 따위의 도구를 이용하여 정보 전달 및 설득형 발표를 하고, 시의적절한 토론, 토의, 협상 주제를 설정하여 집단 화법을 경험함으로써 사회구성원으로서 필요한 의사소통능력이 함양된다.
								</td>
							</tr>
						</tbody>
					</table>
				</div>
            	<div id="ch_cont02" style="display:none;">
					<div class="tab">
						<ul>						
							<li><a href="javascript:testDisplay('01');">기초교양</a></li>
							<li><a href="javascript:testDisplay('02');" class="active">핵심교양</a></li>
						</ul>
					</div>
					<div class="gt_tit mt40">
						<strong>핵심교양</strong>						
					</div>
					<table class="list_p02">
						<colgroup>
							<col width="15%" />
							<col width="23%" />
							<col width="15%" />
							<col width="23%" />
							<col width="24%" />						
						</colgroup>
						<thead>
							<tr>
								<th>영역</th>
								<th>교과목명</th>
								<th>학점</th>
								<th>개설학기</th>
								<th>비고</th>							
							</tr>
						</thead>
						<tbody>
							<tr>
								<td rowspan="16">핵심교양</td>
								<td>실용글쓰기와 자기표현</td>
								<td>3</td>
								<td>1학기 개설</td>
								<td>2~4학년 중심 취업 대비</td>
							</tr>
							<tr>
								<td colspan="4" class="cont">
									이 과목은 직업인으로서 갖추어야 할 의사소통 능력 향상을 목적으로 한다. 수강생들은 직종 및 직무에 적합한 자기소개서를 이해하고 작성하며, 다양한 면접 상황(프레젠테이션, 집단토론, 경험면접, 상황면접)을 이해하고 실습을 함으로써 취업에 필요한, 더 나아가 취업 후 직장생활에 적응할 수 있는 기초직업능력의 핵심인 의사소통 능력을 갖추게 될 것이다.							
								</td>
							</tr>	
							<tr>							
								<td>나를 위한 글쓰기</td>
								<td>3</td>
								<td>1학기 개설</td>
								<td>모든 단과대 수강 가능</td>
							</tr>
							<tr>
								<td colspan="4" class="cont">
									이 과목은 글쓰기를 통해서 자신의 삶을 성찰하고 치유하며, 더 나아가 세계와의 관계 속에서 ‘되고 싶은 나’에 다가가는 방법을 모색하는 ‘자기 표현적 글쓰기’이자 ‘성찰과 설계를 위한 글쓰기’이다. 이 과목에서는 쓰기 행위가 자기 탐색 및 성찰 그리고 설계를 위한 보조적 수단으로 활용되기 때문에 쓰기 결과물에 초점을 둔다기보다 자기 탐색과 타인과의 공유에 초점을 둔다.  이러한 과정에서 영화, 소설, 음악 등 다양한 매체가 타인과 세상 읽기의 매체로 활용될 것이다. 							
								</td>
							</tr>				
							<tr>							
								<td>사회비평과 글쓰기</td>
								<td>3</td>
								<td>2학기 개설</td>
								<td>모든 단과대 수강 가능</td>
							</tr>
							<tr>
								<td colspan="4" class="cont">
									이 교과목은 급변하는 사회의 다양한 이슈에 주목하고 고차원적인 글쓰기 표현 능력을 제고하고 함양하는 것을 목적으로 한다. 21세기 의사소통 시대에 사회적 비평과 이에 대한 대응 능력은 점점 중요해지고 있다. 사회적 비평의 개념과 그 유형을 학습하고 정치, 경제, 법률, 언론 등의 사회적 이슈에 주목하여 논리적이고 비판적인 사고를 바탕으로 비평적 에세이와 칼럼 쓰기 능력을 배양한다. 이를 통해 문제 해결 능력, 고도의 의사소통 능력을 달성할 수 있다. 							
								</td>
							</tr>				
							<tr>							
								<td>정보사회와 글쓰기</td>
								<td>3</td>
								<td>1학기 개설</td>
								<td>모든 단과대 수강 가능</td>
							</tr>
							<tr>
								<td colspan="4" class="cont">
									이 교과목의 목적은 새롭게 도래한 지능정보사회의 다양한 핵심적 사안을 정확하게 읽고 이해하며 이에 대한 분석적, 비판적, 창의적, 종합적 사고의 양상을 글쓰기로 표현하는 능력을 함양하는 데 있다. 현재 우리 사회는 이른바 4차 산업혁명으로 급변하고 있다. 이러한 시대적 흐름을 이해하고 이와 관련된 정보를 찾아 적확하게 읽어내며 글쓰기를 통해 정보의 재창출과 미래 사회인으로서의 태도와 삶의 자세를 갖출 수 있도록 한다.							
								</td>
							</tr>
							<tr>							
								<td>논리적 사고와 토의, 토론</td>
								<td>3</td>
								<td>2학기 개설</td>
								<td>모든 단과대 수강 가능</td>
							</tr>
							<tr>
								<td colspan="4" class="cont">
									이 교과목은 설득전략을 바탕으로 고차원적인 말하기 표현 능력을 제고하고 함양하는 것을 목적으로 한다. 다변화하고 있는 21세기 커뮤니케이션 시대에 토론과 협상 능력은 점점 중요해지고 있다. 토론과 협상의 전략을 학습하고 토론과 협상 문제의 심층적 분석 및 실습을 통해 문제 해결 능력, 고도의 의사소통 능력 및 대인 관계 능력을 배양하게 된다. 							
								</td>
							</tr>
							<tr>							
								<td>세상읽기와 글쓰기</td>
								<td>3</td>
								<td>2학기 개설</td>
								<td>모든 단과대 수강 가능</td>
							</tr>
							<tr>
								<td colspan="4" class="cont">
									이 교과목은 다양한 매체 속에 드러난 사회의 모습을 능동적이고 비판적으로 읽어내고 이를 토대로 주체적인 글쓰기 주체로서 능력을 갖추기 위한 것이다. 나를 둘러 싼 제반 환경을 이해하고 시대의 흐름 속에서 시대에 대한 이해하는 것은 사람들과 조화를 이루고 세상 속에서 건강한 개인으로 살기 위해 필요한 능력이다. 수강생들은 영화, 뉴스, 인터넷 이슈 등 매체 속에 드러난 사회의 모습을 통해 세상을 읽고 더 나아가 글쓰기 활동을 통해 건강한 사회 구성원으로서 삶을 사는 방법을 배우게 될 것이다. 
								</td>
							</tr>
							<tr>							
								<td>설득전략과 글쓰기</td>
								<td>3</td>
								<td>1학기 개설</td>
								<td>사이버 강좌</td>
							</tr>
							<tr>
								<td colspan="4" class="cont">
									이 교과목은 독자 혹은 청자를 보다 빠르게 이해시키기 위해 설득전략을 바탕으로 고차원적인 표현 능력인 글쓰기 수준을 제고하고 함양하는 것을 목적으로 한다. 다변화하고 있는 21세기 커뮤니케이션 시대에 적극적으로 부응하는 의사소통 능력 과목으로 학생들의 과제 수행 과정에서의 글쓰기, 그리고 실용적 글쓰기에 도움을 줌으로써 글쓰기 실전 능력을 배양하고자 마련되었다. 							
								</td>
							</tr>
							<tr>							
								<td>휴먼커뮤니케이션과 상호작용</td>
								<td>3</td>
								<td>2학기 개설</td>
								<td>사이버 강좌</td>
							</tr>
							<tr>
								<td colspan="4" class="cont">
									이 과목은 인간의 의사소통 본질을 이해하고, 행복한 삶을 위한 의사소통능력을 향상하는 것을 목적으로 한다. 현대 사회와 가까운 미래(인공지능 및 4차 산업혁명 시대) 사회에서 휴먼커뮤니케이션은 매우 중요한 능력으로 부각될 것이다. 사이버 강의인 점을 고려하여 다양한 매체(영화, 드라마, 뉴스 등)를 통해 인간의 의사소통의 본질에 흥미롭게 접근할 것이여, 학생들은 이러한 의사소통의 실천 행위가 행복한 삶을 위한 방법임을 깨닫고 실천하게 될 것이다.
								</td>
							</tr>						
						</tbody>
					</table>
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