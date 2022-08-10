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
            	<jsp:param name="dept1" value="강의와 첨삭"/>
            	<jsp:param name="dept2" value="2019학년도 운영 강좌"/>
            </jsp:include>
			<div class="cont_box">
				<div id="ch_cont01" style="display:block;">
					<div class="tab">
						<ul>						
							<li><a href="javascript:testDisplay('01');" class="active">사고와 표현</a></li>
							<li><a href="javascript:testDisplay('02');">핵심 교양</a></li>
						</ul>
					</div>
					<div class="gt_tit mt40">
						<!-- <strong>&lt;사고와표현Ⅰ&gt;</strong> -->
						<strong>&lt;2019년 2학기&gt;</strong>
					</div>
					<table class="list_p02 mt40" style="text-align:center;">
						<colgroup>
							<col width="15%" />
							<col width="15%" />
							<col width="%" />
							<col width="15%" />
							<col width="15%" />
							<col width="15%" />
						</colgroup>
						<thead>
							<tr>
								<th>코드</th>
								<th>단대별</th>
								<th>분반</th>
								<th>교수명</th>
								<th>학점</th>
								<th>요일/시간</th>
								<th>강의실</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td rowspan="21">REQ0002</td>
								<td rowspan="5">크리에이티브<br/>인문예술대학<br/>(주간)</td>
								<td>A</td>
								<td>이상혁</td>
								<td>2</td>
								<td>금 5 - 6M</td>
								<td>상상관 604</td>
							</tr>
							<tr>
								<td>B</td>
								<td>박혜순</td>
								<td>2</td>
								<td>금 5 - 6M</td>
								<td>상상관 605</td>
							</tr>
							<tr>
								<td>C</td>
								<td>윤경선</td>
								<td>2</td>
								<td>금 5 - 6M</td>
								<td>상상관 606</td>
							</tr>
							<tr>
								<td>D</td>
								<td>조 별</td>
								<td>2</td>
								<td>금 3 - 4M</td>
								<td>상상관 604</td>
							</tr>
							<tr>
								<td>E</td>
								<td>임형모</td>
								<td>2</td>
								<td>금 3 - 4M</td>
								<td>상상관 605</td>
							</tr>
							
							<tr>
								<td rowspan="2">크리에이티브<br/>인문예술대학<br/>(야간)</td>
								<td>N</td>
								<td>이현정</td>
								<td>2</td>
								<td>금 11 - 12M</td>
								<td>상상관 604</td>
							</tr>
							
							<tr>
								<td>O</td>
								<td>이자화</td>
								<td>2</td>
								<td>금 11 - 12M</td>
								<td>상상관 605</td>
							</tr>
							
							<tr>
								<td rowspan="6">상상력인재학부<br/>(주간)</td>
								<td>1</td>
								<td>권혁명</td>
								<td>2</td>
								<td>금 5 - 6M</td>
								<td>탐구관 401</td>
							</tr>
							
							<tr>
								<td>2</td>
								<td>정제호</td>
								<td>2</td>
								<td>금 5 - 6M</td>
								<td>탐구관  402</td>
							</tr>

							<tr>
								<td>J</td>
								<td>이희영</td>
								<td>2</td>
								<td>금 3 - 4M</td>
								<td>탐구관  401</td>
							</tr>
							<tr>
								<td>K</td>
								<td>정제호</td>
								<td>2</td>
								<td>금 3 - 4M</td>
								<td>탐구관  402</td>
							</tr>
							<tr>
								<td>L</td>
								<td>박혜순</td>
								<td>2</td>
								<td>금 3 - 4M</td>
								<td>탐구관  403</td>
							</tr>
							<tr>
								<td>M</td>
								<td>임형모</td>
								<td>2</td>
								<td>금 5 - 6M</td>
								<td>탐구관  403</td>
							</tr>
							
							<tr>
								<td rowspan="2">상상력인재학부<br/>(주간)</td>
								<td>R</td>
								<td>남궁정</td>
								<td>2</td>
								<td>금 9 - 10M</td>
								<td>탐구관 401</td>
							</tr>
							
							<tr>
								<td>S</td>
								<td>남궁정</td>
								<td>2</td>
								<td>금 11 - 12M</td>
								<td>탐구관  401</td>
							</tr>
							
							<tr>
								<td rowspan="4">디자인<br/>(주간)</td>
								<td>F</td>
								<td>권혁명</td>
								<td>2</td>
								<td>금 3 - 4M</td>
								<td>탐구관 406</td>
							</tr>
							
							<tr>
								<td>G</td>
								<td>윤경선</td>
								<td>2</td>
								<td>금 3 - 4M</td>
								<td>탐구관  407</td>
							</tr>

							<tr>
								<td>H</td>
								<td>이희영</td>
								<td>2</td>
								<td>금 5 - 6M</td>
								<td>탐구관  406</td>
							</tr>
							<tr>
								<td>I</td>
								<td>조 별</td>
								<td>2</td>
								<td>금 5 - 6M</td>
								<td>탐구관  407</td>
							</tr>
							<tr>
								<td rowspan="2">디자인<br/>(야간)</td>
								<td>P</td>
								<td>이현정</td>
								<td>2</td>
								<td>금 9 - 10M</td>
								<td>탐구관 406</td>
							</tr>
							
							<tr>
								<td>O</td>
								<td>이자화</td>
								<td>2</td>
								<td>금 9 - 10M</td>
								<td>탐구관  407</td>
							</tr>
						</tbody>
					</table>
					
					<table class="list_p02 mt40" style="text-align:center;">
						<colgroup>
							<col width="15%" />
							<col width="15%" />
							<col width="%" />
							<col width="15%" />
							<col width="15%" />
							<col width="15%" />
						</colgroup>
						<thead>
							<tr>
								<th>코드</th>
								<th>단대별</th>
								<th>분반</th>
								<th>교수명</th>
								<th>학점</th>
								<th>요일/시간</th>
								<th>강의실</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td rowspan="24">REQ0014</td>
								<td rowspan="4">미래융합사회과학대학<br/>(주간)</td>
								<td>I</td>
								<td>이상혁</td>
								<td>2</td>
								<td>화 1 - 2M</td>
								<td>탐구관 501</td>
							</tr>
							<tr>
								<td>J</td>
								<td>나은미</td>
								<td>2</td>
								<td>화 1 - 2M</td>
								<td>탐구관 502</td>
							</tr>
						
							<tr>
								<td>K</td>
								<td>이상혁</td>
								<td>2</td>
								<td>화 3 - 4M</td>
								<td>탐구관  501</td>
							</tr>
							
							<tr>
								<td>L</td>
								<td>나은미</td>
								<td>2</td>
								<td>화 3 - 4M</td>
								<td>탐구관  502</td>
							</tr>
							
							
							<tr>
								<td rowspan="3">미래융합사회과학대학<br/>(야간)</td>
								<td>R</td>
								<td>임형모</td>
								<td>2</td>
								<td>화 11 - 12M</td>
								<td>탐구관 501</td>
							</tr>
							
							<tr>
								<td>S</td>
								<td>권혁명</td>
								<td>2</td>
								<td>화 13 - 14M</td>
								<td>탐구관 501</td>
							</tr>

							<tr>
								<td>T</td>
								<td>정원채</td>
								<td>2</td>
								<td>화 13 - 14M</td>
								<td>탐구관 502</td>
							</tr>
							
							<tr>
								<td rowspan="8">IT공과대학<br/>(주간)</td>
								<td>A</td>
								<td>임형모</td>
								<td>2</td>
								<td>화 1 - 2M</td>
								<td>상상관  604</td>
							</tr>
							
							<tr>
								<td>B</td>
								<td>권혁명</td>
								<td>2</td>
								<td>화 1 - 2M</td>
								<td>상상관  605</td>
							</tr>

							<tr>
								<td>C</td>
								<td>박선옥</td>
								<td>2</td>
								<td>화 1 - 2M</td>
								<td>상상관  506</td>
							</tr>

							<tr>
								<td>D</td>
								<td>이희영</td>
								<td>2</td>
								<td>화 1 - 2M</td>
								<td>상상관  507</td>
							</tr>
							
							<tr>
								<td>E</td>
								<td>권혁명</td>
								<td>2</td>
								<td>화 3 - 4M</td>
								<td>상상관  604</td>
							</tr>
							
							<tr>
								<td>F</td>
								<td>이희영</td>
								<td>2</td>
								<td>화 3 - 4M</td>
								<td>상상관  605</td>
							</tr>
							
							<tr>
								<td>G</td>
								<td>박선옥</td>
								<td>2</td>
								<td>화 3 - 4M</td>
								<td>탐구관 506</td>
							</tr>
							
							<tr>
								<td>H</td>
								<td>임형모</td>
								<td>2</td>
								<td>화 3 - 4M</td>
								<td>탐구관 507</td>
							</tr>

							<tr>
								<td rowspan="4">IT공과대학<br/>(야간)</td>
								<td>N</td>
								<td>이희영</td>
								<td>2</td>
								<td>화 11 - 12M</td>
								<td>상상관 604</td>
							</tr>
							
							<tr>
								<td>O</td>
								<td>권혁명</td>
								<td>2</td>
								<td>화 11 - 12M</td>
								<td>상상관 605</td>
							</tr>
							
							<tr>
								<td>P</td>
								<td>이희영</td>
								<td>2</td>
								<td>화 13 - 14M</td>
								<td>상상관 604</td>
							</tr>
							
							<tr>
								<td>Q</td>
								<td>임형모</td>
								<td>2</td>
								<td>화 13 - 14M</td>
								<td>상상관 605</td>
							</tr>
							
							<tr>
								<td rowspan="1">재학생반</td>
								<td>1/Z</td>
								<td>박선옥</td>
								<td>2</td>
								<td>금 5 - 6M</td>
								<td>탐구관 404</td>
							</tr>
							
							
							<tr>
								<td rowspan="2">외국인반</td>
								<td>2</td>
								<td>박선옥</td>
								<td>2</td>
								<td>금 3 - 4M</td>
								<td>탐구관 404</td>
							</tr>
							
							<tr>
								<td>3</td>
								<td>이상혁</td>
								<td>2</td>
								<td>금 3 - 4M</td>
								<td>탐구관 405</td>
							</tr>
							
							<tr>
								<td >미래플러스대학 (야간) <br/> 뷰티디자인학과(야)</td>
								<td>V</td>
								<td>이희영</td>
								<td>2</td>
								<td>월 2 - 3M</td>
								<td>탐구관 107</td>
							</tr>
							
							<tr>
								<td>미래플러스대학 (야간) <br/>
									법·행정학과(야) <br/>
									호텔외식경영학과(야) <br/>
									비즈니스컨설팅학과(야)<br/>
								 </td>
								<td>U</td>
								<td>정원채</td>
								<td>2</td>
								<td>토 2 - 3M</td>
								<td>상상관  606</td>
							</tr>
							
						</tbody>
					</table>
					<!-- <table class="list_p02 mt40" style="text-align:center;">
						<colgroup>
							<col width="15%" />
							<col width="%" />
							<col width="%" />
							<col width="10%" />
							<col width="12%" />
							<col width="12%" />
							<col width="12%" />
							<col width="12%" />
							<col width="12%" />
						</colgroup>
						<thead>
							<tr>
								<th>코드</th>
								<th colspan="2">단대별</th>
								<th>분반</th>
								<th>교수명</th>
								<th>학점</th>
								<th>요일/시간</th>
								<th>강의실</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td rowspan="22">REQ0001</td>
								<td colspan="2" rowspan="5">크리에이티브<br/>인문예술대학<br/>(주간)</td>
								<td>A</td>
								<td>나은미</td>
								<td>2</td>
								<td>화 3-4M</td>
								<td>탐 403</td>
							</tr>
							<tr>								
								<td>B</td>
								<td>박선옥</td>
								<td>2</td>
								<td>화 3-4M</td>
								<td>탐 402</td>
							</tr>
							<tr>								
								<td>C</td>
								<td>이상혁</td>
								<td>2</td>
								<td>화 1-2M</td>
								<td>탐 401</td>
							</tr>
							<tr>								
								<td>D</td>
								<td>이상혁</td>
								<td>2</td>
								<td>화 3-4M</td>
								<td>탐 401</td>
							</tr>
							<tr>								
								<td>E</td>
								<td>임형모</td>
								<td>2</td>
								<td>화 1-2M</td>
								<td>탐 402</td>
							</tr>
							<tr>
								<td colspan="2" rowspan="2">크리에이티브<br/>인문예술대학<br/>(야간)</td>
								<td>N</td>
								<td>권혁명</td>
								<td>2</td>
								<td>화 13-14M</td>
								<td>탐 501</td>
							</tr>
							<tr>
								<td>P</td>
								<td>이희영</td>
								<td>2</td>
								<td>화 13-14M</td>
								<td>탐 502</td>
							</tr>
							<tr>								
								<td colspan="2" rowspan="6">상상력인재학부<br/>(주간)</td>
								<td>G</td>
								<td>나은미</td>
								<td>2</td>
								<td>화 1-2M</td>
								<td>탐 403</td>
							</tr>
							<tr>
								<td>K</td>
								<td>권혁명</td>
								<td>2</td>
								<td>화 3-4M</td>
								<td>상 603</td>
							</tr>
							<tr>
								<td>L</td>
								<td>이희영</td>
								<td>2</td>
								<td>화 1-2M</td>
								<td>상 604</td>
							</tr>
							<tr>
								<td>M</td>
								<td>권혁명</td>
								<td>2</td>
								<td>화 1-2M</td>
								<td>상 603</td>
							</tr>
							<tr>
								<td>1</td>
								<td>이희영</td>
								<td>2</td>
								<td>화 3-4M</td>
								<td>상 604</td>
							</tr>
							<tr>
								<td>2</td>
								<td>정제호</td>
								<td>2</td>
								<td>화 3-4M</td>
								<td>상 605</td>
							</tr>
							<tr>								
								<td colspan="2" rowspan="2">상상력인재학부<br/>(야간)</td>
								<td>T</td>
								<td>임형모</td>
								<td>2</td>
								<td>화 11-12M</td>
								<td>탐 407</td>
							</tr>
							<tr>
								<td>U</td>
								<td>임형모</td>
								<td>2</td>
								<td>화 13-14M</td>
								<td>탐 407</td>
							</tr>
							<tr>								
								<td colspan="2" rowspan="4">사회과학대학<br/>(주간)</td>
								<td>F</td>
								<td>이상혁</td>
								<td>2</td>
								<td>금 3-4M</td>
								<td>탐 401</td>
							</tr>
							<tr>
								<td>H</td>
								<td>이상혁</td>
								<td>2</td>
								<td>금 5-6M</td>
								<td>탐 401</td>
							</tr>
							<tr>
								<td>I</td>
								<td>김희경</td>
								<td>2</td>
								<td>금 5-6M</td>
								<td>탐 402</td>
							</tr>
							<tr>
								<td>J</td>
								<td>정원채</td>
								<td>2</td>
								<td>금 3-4M</td>
								<td>탐 402</td>
							</tr>
							<tr>								
								<td colspan="2" rowspan="3">사회과학대학<br/>(야간)</td>
								<td>Q</td>
								<td>이희영</td>
								<td>2</td>
								<td>금 9-10M</td>
								<td>상 606</td>
							</tr>
							<tr>
								<td>R</td>
								<td>이희영</td>
								<td>2</td>
								<td>금 11-12M</td>
								<td>상 606</td>
							</tr>
							<tr>
								<td>S</td>
								<td>곽승숙</td>
								<td>2</td>
								<td>금 11-12M</td>
								<td>상 607</td>
							</tr>
							<tr>
								<td rowspan="25">REQ0013</td>
								<td colspan="2" rowspan="4">디자인대학<br/>(주간)</td>
								<td>A</td>
								<td>김인경</td>
								<td>2</td>
								<td>화 1-2M</td>
								<td>상 606</td>
							</tr>
							<tr>								
								<td>B</td>
								<td>정제호</td>
								<td>2</td>
								<td>화 1-2M</td>
								<td>상 607</td>
							</tr>
							<tr>								
								<td>C</td>
								<td>곽승숙</td>
								<td>2</td>
								<td>화 3-4M</td>
								<td>상 606</td>
							</tr>
							<tr>								
								<td>D</td>
								<td>임형모</td>
								<td>2</td>
								<td>화 3-4M</td>
								<td>상 607</td>
							</tr>
							<tr>								
								<td colspan="2" rowspan="2">디자인대학<br/>(야간)</td>
								<td>N</td>
								<td>권혁명</td>
								<td>2</td>
								<td>화 11-12M</td>
								<td>탐 501</td>
							</tr>
							<tr>
								<td>P</td>
								<td>이희영</td>
								<td>2</td>
								<td>화 11-12M</td>
								<td>탐 502</td>
							</tr>
							<tr>								
								<td colspan="2" rowspan="8">공과대학<br/>(주간)</td>
								<td>E</td>
								<td>박선옥</td>
								<td>2</td>
								<td>금 3-4M</td>
								<td>상 603</td>
							</tr>
							<tr>																
								<td>F</td>
								<td>권혁명</td>
								<td>2</td>
								<td>금 5-6M</td>
								<td>상 604</td>
							</tr>
							<tr>																
								<td>G</td>
								<td>임형모</td>
								<td>2</td>
								<td>금 5-6M</td>
								<td>상 605</td>
							</tr>
							<tr>																
								<td>H</td>
								<td>이희영</td>
								<td>2</td>
								<td>금 5-6M</td>
								<td>상 606</td>
							</tr>
							<tr>																
								<td>I</td>
								<td>박선옥</td>
								<td>2</td>
								<td>금 5-6M</td>
								<td>상 603</td>
							</tr>
							<tr>																
								<td>J</td>
								<td>권혁명</td>
								<td>2</td>
								<td>금 3-4M</td>
								<td>상 604</td>
							</tr>
							<tr>																
								<td>K</td>
								<td>임형모</td>
								<td>2</td>
								<td>금 3-4M</td>
								<td>상 605</td>
							</tr>
							<tr>																
								<td>L</td>
								<td>이희영</td>
								<td>2</td>
								<td>금 3-4M</td>
								<td>상 606</td>
							</tr>
							<tr>								
								<td colspan="2" rowspan="4">공과대학<br/>(야간)</td>
								<td>Q</td>
								<td>권혁명</td>
								<td>2</td>
								<td>금 9-10M</td>
								<td>상 604</td>
							</tr>
							<tr>
								<td>R</td>
								<td>임형모</td>
								<td>2</td>
								<td>금 9-10M</td>
								<td>상 605</td>
							</tr>
							<tr>
								<td>S</td>
								<td>권혁명</td>
								<td>2</td>
								<td>금 11-12M</td>
								<td>상 604</td>
							</tr>
							<tr>
								<td>T</td>
								<td>임형모</td>
								<td>2</td>
								<td>금 11-12M</td>
								<td>상 605</td>
							</tr>
							<tr>								
								<td colspan="2">재학생반</td>
								<td>1</td>
								<td>유현정</td>
								<td>2</td>
								<td>금 5-6M</td>
								<td>탐 306</td>
							</tr>
							<tr>								
								<td colspan="2" rowspan="2">외국인반</td>
								<td>2</td>
								<td>이승희</td>
								<td>2</td>
								<td>금 3-4M</td>
								<td>탐 305</td>
							</tr>
							<tr>								
								<td>3</td>
								<td>김희경</td>
								<td>2</td>
								<td>금 3-4M</td>
								<td>탐 306</td>
							</tr>
							<tr>								
								<td rowspan="4">미래플러스대학<br/>(야간)</td>
								<td>법․행정학과(야)</td>
								<td>O</td>
								<td>곽승숙</td>
								<td>2</td>
								<td>토 2-3M</td>
								<td>상 605</td>
							</tr>
							<tr>								
								<td>호텔외식경영학과(야)</td>
								<td>U</td>
								<td>도재학</td>
								<td>2</td>
								<td>토 7-8M</td>
								<td>상 607</td>
							</tr>
							<tr>								
								<td>뷰티디자인학과(야)</td>
								<td>V</td>
								<td>나은미</td>
								<td>2</td>
								<td>월 6-7M</td>
								<td>진 307</td>
							</tr>
							<tr>								
								<td>비즈니스컨설팅학과(야)</td>
								<td>W</td>
								<td>도재학</td>
								<td>2</td>
								<td>토 5-6M</td>
								<td>상 606</td>
							</tr>
						</tbody>
					</table> -->
				</div>
            	<div id="ch_cont02" style="display:none;">
					<div class="tab">
						<ul>						
							<li><a href="javascript:testDisplay('01');">사고와 표현</a></li>
							<li><a href="javascript:testDisplay('02');" class="active">핵심 교양</a></li>
						</ul>
					</div>
					<div class="gt_tit mt40">
						<strong>&lt;핵심 교양&gt;</strong>						
					</div>
					<!-- <table class="list_p02 mt40" style="text-align:center;">
						<colgroup>
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
						</colgroup>
						<thead>
							<tr>
								<th>개설학과</th>
								<th>교과목명</th>
								<th>교과목 코드</th>
								<th>분반</th>
								<th>학점</th>
								<th>교수명</th>
								<th>요일 및 교시</th>
								<th>강의실</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>인문학</td>
								<td>정보사회와 글쓰기</td>
								<td>GCH0011</td>
								<td>A</td>
								<td>3</td>
								<td>박선옥</td>
								<td>
									<p>수 7–8</p>
									<p>목 7–8</p>
								</td>
								<td>
									<p>탐 105</p>
									<p>상 505</p>
								</td>
							</tr>
							<tr>
								<td>인문학</td>
								<td>나를 위한 글쓰기</td>
								<td>GCH0009</td>
								<td>A</td>
								<td>3</td>
								<td>나은미</td>
								<td>
									<p>수 7–8</p>
									<p>목 7–8</p>
								</td>
								<td>
									<p>탐 104</p>
									<p>탐 107</p>
								</td>
							</tr>
							<tr>
								<td>인문학</td>
								<td>실용글쓰기와 자기표현</td>
								<td>GCH0008</td>
								<td>A</td>
								<td>3</td>
								<td>나은미</td>
								<td>
									<p>수 8M–9M</p>
									<p>목 8M-9M</p>
								</td>
								<td>
									<p>탐 104</p>
									<p>탐 107</p>
								</td>
							</tr>
							<tr>
								<td>인문학</td>
								<td>설득전략과 글쓰기</td>
								<td>GCH0010</td>
								<td>A/N</td>
								<td>3</td>
								<td>이상혁</td>
								<td colspan="2">사이버 강의</td>
							</tr>
						</tbody>
					</table> -->
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