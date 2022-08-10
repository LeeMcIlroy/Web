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
            	<jsp:param name="dept1" value="게시판"/>
            	<jsp:param name="dept2" value="비교과 포인트 안내"/>
            </jsp:include>
			<div class="cont_box">
				<div class="mid_tit02">‘사고와 표현 교육과정’ 비교과 프로그램 목록</div>
				<table class="list_p">
					<colgroup>
						<col width="9%" />
						<col width="10%" />
						<col width="10%" />
						<col width="9%" />
						<col width="10%" />
						<col width="8%" />
						<col width="8%" />
						<col width="10%" />
						<col width="9%" />
						<col width="9%" />
						<col width="8%" />
					</colgroup>
					<thead>
						<tr>
							<th>프로그램 성격(영역)</th>
							<th>프로그램 명</th>
							<th>핵심역량</th>
							<th>참여시간</th>
							<th>지급 포인트</th>
							<th>학기당<br/>최대 포인트</th>
							<th>참여 권장<br/>학년</th>
							<th>운영시기</th>
							<th>수용인원<br/>(그룹당)</th>
							<th>총 수용 인원</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td align="center">기타(상담)</td>
							<td>표현능력상담</td>
							<td align="center">의사소통 능력</td>
							<td class="txt_c">1H</td>
							<td class="txt_c">10P</td>
							<td class="txt_c">30P</td>
							<td>전 학년</td>
							<td>매학기(3, 9월)<br/>방학(6, 12월)</td>
							<td>-</td>
							<td class="txt_c">-</td>
							<td>상시</td>
						</tr>
						<tr>
							<td align="center">기타(상담)</td>
							<td align="center">외국인 유학생을<br/>위한<br/>표현능력상담</td>
							<td align="center">의사소통 능력</td>
							<td class="txt_c">1H</td>
							<td class="txt_c">10P</td>
							<td class="txt_c">50P</td>
							<td>외국인<br/>전 학년</td>
							<td>매학기(3, 9월)<br/>방학(6, 12월)</td>
							<td>-</td>
							<td class="txt_c">-</td>
							<td>외국인 특수 상황 고려</td>
						</tr>
						<tr>
							<td>공모전ㆍ대회</td>
							<td align="center">한성인<br/>글쓰기<br/>대회</td>
							<td align="center">의사소통 능력</td>
							<td class="txt_c">2H</td>
							<td class="lh_30">참여 20P<br/>최우수상 60P<br/>우수상 50P<br/>장려상 40P</td>
							<td class="txt_c">60P</td>
							<td>전 학년</td>
							<td>1학기(5월 중)</td>
							<td>-</td>
							<td class="txt_c">400명</td>
							<td>수상은 10명 내외</td>
						</tr>
						<tr>
							<td>공모전ㆍ대회</td>
							<td align="center">한성인<br/>프레젠테이션<br/>대회</td>
							<td align="center">의사소통 능력</td>
							<td class="txt_c">4H~6H<br/>(예선 및 본선)</td>
							<td class="lh_30">참여 40P<br/>최우수상 100P<br/>우수상 80P<br/>장려상 60P<br/>단순 방청 5P</td>
							<td class="txt_c">100P</td>
							<td>전 학년</td>
							<td>2학기(11월 중)</td>
							<td class="alt_txt">협의 후 결정</td>
							<td class="txt_c">100명</td>
							<td>수상은 10팀 내외</td>
						</tr>
					</tbody>
				</table>
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