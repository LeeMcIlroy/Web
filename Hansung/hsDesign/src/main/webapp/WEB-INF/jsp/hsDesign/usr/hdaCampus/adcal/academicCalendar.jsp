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
<form id="frm" name="frm">
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
				<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="학사안내"/>
		            <jsp:param name="dept2" value="학사 일정"/>
	           	</jsp:include>
				<div style="margin-top:30px;">
					<!--
					<iframe src="https://calendar.google.com/calendar/embed?src=4ms3auujb5k5racvem49n96pac%40group.calendar.google.com&amp;ctz=Asia/Seoul" style="border: 0" width="100%" height="600"  id="the_iframe" onLoad="iframeAutoResize(this);" frameborder="0" scrolling="no"></iframe>
					-->
					<div class="s_tit">2021학년도 학사일정<label style="font-size: 10px;"> &nbsp; &nbsp;( <label style="color:#ff0000; font-weight: bold;">[주]</label> 주요 학사일정 | <label style="color:#000fff; font-weight: bold;">[기]</label> 기타 (장학, 기숙사, 행사 등))</label></div>
						<table class="ta874_ty03" style="width:100%;" >
							<caption>HANSUNG UNIVERSITY DESIGN & ART INSTITUTE</caption>
							<colgroup>
								<col style="width:20%;">
								<col style="width:80%;">
							</colgroup>
							<tbody>
								<tr>
									<th class="ta_left">1月 (January)</th>
									<td class="ta_left">
										12월 22일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 학적변경(휴·복학,전과) 신청기간 <br>
										12월 28일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 동계 계절학기 개강(예정) <br>
										04일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 동계 계절학기 수강정정<br>
									</td>
								</tr>
								<tr>
									<th class="ta_left">2月 (February)</th>
									<td class="ta_left">
										05일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 1학기 수강신청 안내 공지<br>
										10일 ~ 19일 <label style="color:#000fff; font-weight: bold;">[기]</label> 1학기 기숙사생 모집기간<br>
										15일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 학적변경(휴ㆍ복학,전과) 신청마감<br>
										16일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수강신청 1일차(전체)<br>
										17일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수강신청 2일차(전체)<br>
										18일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수강신청 3일차(전체)<br>
										19일 <label style="color:#000fff; font-weight: bold;">[기]</label> 2020학년도 전기 학위수여식<br>
										21일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 동계 계절학기 종강(예정)<br>
										22일 ~ 25일 <label style="color:#000fff; font-weight: bold;">[기]</label> 1학기 기숙사비 납부기간<br>
										25일 ~ 26일 <label style="color:#000fff; font-weight: bold;">[기]</label> 1학기 등록금 납부기간<br>
										27일 <label style="color:#000fff; font-weight: bold;">[기]</label> 1학기 기숙사 OT 및 입실<br>
										24일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 한디원 전반기 학사협의회<br>
										26일 <label style="color:#000fff; font-weight: bold;">[기]</label> 2021학년도 신입생 입학식<br>
									</td>
								</tr>
								<tr>
									<th class="ta_left">3月 (March)<br> ☞ 2021학년도 1학기</th>
									<td class="ta_left">
										01일 <label style="color:#ff0000; font-weight: bold;">[주]</label> <label style="font-weight: bold;">2021학년도 1학기 개강</label><br>
										04일, 05일, 08일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수강신청 정정기간<br>
										11일 ~ 12일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 등록금 추가납부기간<br>
										17일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수업일수 17일(1/6)<br>
										25일 ~ 26일 <label style="color:#000fff; font-weight: bold;">[기]</label> 등록금 분할납부(2차)<br>
										31일 <label style="color:#000fff; font-weight: bold;">[기]</label> 1학기 장학생 선발(예정)<br>
							</td>
								</tr>
								<tr>
									<th class="ta_left">4月 (April)</th>
									<td class="ta_left">
										04일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수업일수 35일(1/3)<br>
										19일 ~ 24일 <label style="color:#ff0000; font-weight: bold;">[주]</label> <label style="color:#ff0000;">중간고사</label><br>
										21일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수업일수 52일(1/2)<br>
										22일 ~ 23일  <label style="color:#000fff; font-weight: bold;">[기]</label> 등록금 분할납부(3차)<br>
									</td>
								</tr>
								<tr>
									<th class="ta_left">5月 (May)</th>
									<td class="ta_left">
										5월 중 <label style="color:#000fff; font-weight: bold;">[기]</label> 대동제<br>
									</td>
								</tr>
								<tr>
									<th class="ta_left">6月 (June)</th>
									<td class="ta_left">
										01일 ~ 04일 <label style="color:#000fff; font-weight: bold;">[기]</label> 하계 기숙사생 모집<br>
										07일 ~ 12일 <label style="color:#ff0000; font-weight: bold;">[주]</label> <label style="color:#ff0000;">기말고사 (종강)</label><br>
										07일 ~ 18일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 강의평가 기간<br>
										08일 ~ 11일 <label style="color:#000fff; font-weight: bold;">[기]</label> 하계 기숙사비 납부기간<br>
										10일 ~ 11일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 2학기 등록금 분할납부 신청<br>
										14일 ~ 18일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 보강주<br>
										20일 <label style="color:#000fff; font-weight: bold;">[기]</label> 1학기 기숙사 운영종료일<br>
										18일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 성적이의신청 마감<br>
										22일 <label style="color:#ff0000; font-weight: bold;">[주]</label> <label style="font-weight: bold;">학기변경 : 2021-하계 계절학기</label><br>
										22일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 학적변경(휴·복학,전과) 신청기간<br>
										21일 ~ 22일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 하계 계절학기 수강신청<br>
										24일 ~ 25일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 하계 계절학기 등록금 납부기간<br>
										27일 <label style="color:#000fff; font-weight: bold;">[기]</label> 하계 기숙사 OT 및 입실<br>
										28일 <label style="color:#ff0000; font-weight: bold;">[주]</label> <label style="font-weight: bold;">하계 계절학기 개강</label><br>
									</td>
								</tr>
								<tr>
									<th class="ta_left">7月 (July)</th>
									<td class="ta_left">
										01일 ~ 8월 27일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 전공변경 신청기간<br>
										05일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 하계 계절학기 수강정정<br>
										26일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 2학기 수강신청 안내 공지<br>
									</td>
								</tr>
								<tr>
									<th class="ta_left">8月 (August)</th>
									<td class="ta_left">
										02일 ~ 06일 <label style="color:#000fff; font-weight: bold;">[기]</label> 2학기 기숙사생 모집<br>
										10일 ~ 13일 <label style="color:#000fff; font-weight: bold;">[기]</label> 2학기 기숙사비 납부<br>
										09일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 학적변경(휴ㆍ복학,전과) 신청마감<br>
										10일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수강신청 1일차 (전체)<br>
										11일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수강신청 2일차 (전체)<br>
										12일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수강신청 3일차 (전체)<br>
										20일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 2020학년도 후기 학위수여식<br>
										20일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 하계 계절학기 종강(예정)<br>
										21일 <label style="color:#000fff; font-weight: bold;">[기]</label> 하계 기숙사 운영종료일<br>
										23일 <label style="color:#ff0000; font-weight: bold;">[주]</label> <label style="font-weight: bold;">학기변경 : 2021-2학기</label><br>
										26일 ~ 27일 <label style="color:#000fff; font-weight: bold;">[기]</label> 2학기 등록금 납부기간<br>
										25일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 한디원 하반기 학사협의회<br>
										28일 <label style="color:#000fff; font-weight: bold;">[기]</label> 2학기 기숙사 OT 및 입실<br>
									</td>
								</tr>
								<tr>
									<th class="ta_left">9月 (September)<br> ☞ 2021학년도 2학기</th>
									<td class="ta_left">
										8월 30일 <label style="color:#ff0000; font-weight: bold;">[주]</label> <label style="font-weight: bold;">2021학년도 2학기 개강</label><br>
										02일 ~ 03일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수강신청 정정기간<br>
										09일 ~ 10일 <label style="color:#000fff; font-weight: bold;">[기]</label> 등록금 추가납부기간<br>
										15일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수업일수 17일(1/6)<br>
										23일 ~ 24일 <label style="color:#000fff; font-weight: bold;">[기]</label> 등록금 분할납부(2차)<br>
										30일 <label style="color:#000fff; font-weight: bold;">[기]</label> 2학기 장학생 선발(예정)<br>
									</td>
								</tr>
								<tr>
									<th class="ta_left">10月 (October)</th>
									<td class="ta_left">
										03일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수업일수 35일(1/3)<br>
										18일 ~ 24일 <label style="color:#ff0000; font-weight: bold;">[주]</label> <label style="color:#ff0000;">중간고사</label><br>
										20일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수업일수 52일(1/2)<br>
										21일 ~ 22일 <label style="color:#000fff; font-weight: bold;">[기]</label> 등록금 분할납부(3차)<br>
									</td>
								</tr>
								<tr>
									<th class="ta_left">11月 (November)</th>
									<td class="ta_left">
										22일 ~ 23일 <label style="color:#000fff; font-weight: bold;">[기]</label> 총학생회 선거<br>
										30일 ~ 12월 03일 <label style="color:#000fff; font-weight: bold;">[기]</label> 동계 기숙사생 모집기간<br>
									</td>
								</tr>
								<tr>
									<th class="ta_left">12月 (December)</th>
									<td class="ta_left">
										06일 ~ 12일 <label style="color:#ff0000; font-weight: bold;">[주]</label> <label style="color:#ff0000;">기말고사 (종강)</label><br>
										06일 ~ 17일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 강의평가 기간<br>
										07일 ~ 10일 <label style="color:#000fff; font-weight: bold;">[기]</label> 동계 기숙사비 납부기간<br>
										09일 ~ 10일 <label style="color:#000fff; font-weight: bold;">[기]</label> 등록금 분할납부 신청<br>
										13일 ~ 17일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 보강주<br>
										17일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 성적이의신청 마감<br>
										18일 <label style="color:#000fff; font-weight: bold;">[기]</label> 2학기 기숙사 운영종료일<br>
										20일 <label style="color:#ff0000; font-weight: bold;">[주]</label> <label style="font-weight: bold;">학기변경 : 2021-동계 계절학기</label><br>
										20일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 학적변경(휴·복학,전과) 신청기간<br>

										20일 ~ 21일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 동계 계절학기 수강신청<br>
										23일 ~ 24일 <label style="color:#000fff; font-weight: bold;">[기]</label> 동계 계절학기 등록금 납부기간<br>
										27일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 동계 계절학기 개강(예정) <br>
										27일 <label style="color:#000fff; font-weight: bold;">[기]</label> 동계기숙사 OT 및 입실<br>
									</td>
								</tr>
								<tr>
									<th class="ta_left">2022年 1月 (January)</th>
									<td class="ta_left">
										03일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 동계 계절학기 수강정정<br>
										28일 ~ 02월 24일 <label style="color:#000fff; font-weight: bold;">[기]</label> 1학기 기숙사생 모집기간<br>
									</td>
								</tr>
								<tr>
									<th class="ta_left">2022年 2月 (February)</th>
									<td class="ta_left">
										01일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 1학기 수강신청 안내 공지<br>
										08일 ~ 11일 <label style="color:#000fff; font-weight: bold;">[기]</label> 1학기 기숙사비 납부기간<br>
										07일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 학적변경(휴ㆍ복학,전과) 신청마감<br>
										08일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수강신청 1일차(전체)<br>
										09일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수강신청 2일차(전체)<br>
										10일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수강신청 3일차(전체)<br>
										18일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 2021학년도 전기 학위수여식<br>
										18일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 동계 계절학기 종강(예정)<br>
										23일 <label style="color:#000fff; font-weight: bold;">[기]</label> 한디원 전반기 학사협의회<br>
										24일 ~ 25일 <label style="color:#000fff; font-weight: bold;">[기]</label> 1학기 등록금 납부기간<br>
										25일 <label style="color:#000fff; font-weight: bold;">[기]</label> 2022학년도 신입생 입학식<br>
									</td>
								</tr>
							</tbody>
						</table>
					</div>	
					<%-- <div class="s_tit">2020학년도 학사일정<label style="font-size: 10px;"> &nbsp; &nbsp;( <label style="color:#ff0000; font-weight: bold;">[주]</label> 주요 학사일정 | <label style="color:#000fff; font-weight: bold;">[기]</label> 기타 (장학, 기숙사, 행사 등))</label></div>
						<table class="ta874_ty03" style="width:100%;" >
							<caption>HANSUNG UNIVERSITY DESIGN & ART INSTITUTE</caption>
							<colgroup>
								<col style="width:20%;">
								<col style="width:80%;">
							</colgroup>
							<tbody>
								<tr>
									<th class="ta_left">1月 (January)</th>
									<td class="ta_left">
										12월 30일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 동계 계절학기 개강 (예정) <br>
										06일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 동계계절학기 수강정정<br>
										06일 ~ 02월 07일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 전공변경신청기간<br>
										28일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수강신청안내 공지<br>
										30일 ~ 02월 07일 <label style="color:#000fff; font-weight: bold;">[기]</label> 1학기 기숙사생 모집<br>
										01월 중 <label style="color:#000fff; font-weight: bold;">[기]</label> ICCE 해외인턴십 파견<br>
									</td>
								</tr>
								<tr>
									<th class="ta_left">2月 (February)</th>
									<td class="ta_left">
										07일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 휴⦁복학 신청마감<br>
										10일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수강신청 1일차 (전체)<br>
										11일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수강신청 2일차 (전체)<br>
										13일 ~ 19일 <label style="color:#000fff; font-weight: bold;">[기]</label> 1학기 기숙사비 납부<br>
										12일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수강신청 3일차 (전체)<br>
										13일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수강신청 4일차 (전체, 시간제)<br>
										23일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 동계계절학기 종강(예정)<br>
										26일 ~ 27일 <label style="color:#000fff; font-weight: bold;">[기]</label> 등록금 납부기간<br>
									</td>
								</tr>
								<tr>
									<th class="ta_left">3月 (March)<br> ☞ 2020학년도 1학기</th>
									<td class="ta_left">
										23일 ~ 29일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 2020학년도 1학기 개강<label style="color:#ff0000;">(1주차 전체 휴강)</label><br>
										28일 <label style="color:#000fff; font-weight: bold;">[기]</label> 1학기 기숙사 OT 및 입실(운영시작일)<br>
										30일 ~ <label style="color:#ff0000; font-weight: bold;">[주]</label> <label style="color:#ff0000;"> 2주차 비대면 수업 진행</label>
							</td>
								</tr>
								<tr>
									<th class="ta_left">4月 (April)</th>
									<td class="ta_left">
										02일 ~ 04일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수강신청 정정기간<br>
										08일 ~ 09일  <label style="color:#000fff; font-weight: bold;">[기]</label> 등록금 추가납부기간<br>
										8일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수업일수 17일(1/6)<br>
										22일 ~ 23일  <label style="color:#000fff; font-weight: bold;">[기]</label> 등록금 분할납부(2차)<br>
										26일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수업일수 35일(1/3)<br>
										27일 <label style="color:#ff0000; font-weight: bold;">[주]</label> <label style="color:#ff0000;">제한적 대면수업 시행</label><br>
										30일  <label style="color:#000fff; font-weight: bold;">[기]</label> 1학기 장학생 선발(예정)<br>
									</td>
								</tr>
								<tr>
									<th class="ta_left">5月 (May)</th>
									<td class="ta_left">
										11일 ~ 17일 <label style="color:#ff0000; font-weight: bold;">[주]</label><label style="color:#ff0000;"> 중간고사</label> <br>
										13일 <label style="color:#000fff; font-weight: bold;">[기]</label> 한디원 전반기 학사협의회 (예정)<br>
										13일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수업일수 52일(1/2)<br>
										20일 ~ 21일  <label style="color:#000fff; font-weight: bold;">[기]</label> 등록금 분할납부(3차)<br>
										05월 중  <label style="color:#000fff; font-weight: bold;">[기]</label> ICCE 해외인턴십 선발공고(1차)<br>
									</td>
								</tr>
								<tr>
									<th class="ta_left">6月 (June)</th>
									<td class="ta_left">
										08일 ~ 12일 <label style="color:#000fff; font-weight: bold;">[기]</label> 하계 기숙사생 모집<br>
										17일 ~ 23일 <label style="color:#000fff; font-weight: bold;">[기]</label> 하계 기숙사비 납부<br>
										29일 ~ 30일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 하계계절학기 수강신청 (서면신청)<br>
										29일 ~ 07월 05일 <label style="color:#ff0000; font-weight: bold;">[주]</label> <label style="color:#ff0000;">기말고사 (종강)</label><br>
										29일 ~ 07월 05일  <label style="color:#ff0000; font-weight: bold;">[주]</label> 강의평가 기간<br>

									</td>
								</tr>
								<tr>
									<th class="ta_left">7月 (July)</th>
									<td class="ta_left">
										01일 ~ 02일 <label style="color:#000fff; font-weight: bold;">[기]</label> 등록금 분할납부 신청<br>
										02일 ~ 03일 <label style="color:#000fff; font-weight: bold;">[기]</label> 하계계절학기 등록금 납부<br>
										3일 <label style="color:#000fff; font-weight: bold;">[기]</label> 1학기 기숙사 운영종료일<br>
										06일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 성적이의신청 마감<br>
										06일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 학기변경:2020학년도 하계계절학기<br>
										06일 ~ 12일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 하계계절학기 개강<br>
										13일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 하계계절학기 수강정정<br>
										11일 <label style="color:#000fff; font-weight: bold;">[기]</label> 하계 기숙사 OT 및 입실(운영시작일)<br>
										27일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 2학기 수강신청 안내 공지<br>
										01일 ~ 31일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 전공변경신청기간<br>
										07월 중 <label style="color:#000fff; font-weight: bold;">[기]</label> 한디원 해외봉사단 파견 (예정)<br>
<!-- 										07월 중 <label style="color:#000fff; font-weight: bold;">[기]</label> H-Beauty Global Field Trip (하계) 파견<br> -->
									</td>
								</tr>
								<tr>
									<th class="ta_left">8月 (August)</th>
									<td class="ta_left">
										03일 ~ 07일 <label style="color:#000fff; font-weight: bold;">[기]</label> 2학기 기숙사생 모집<br>
										07일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 휴․  복학 신청마감<br>
										10일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수강신청 1일차 (전체)<br>
										11일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수강신청 2일차 (전체)<br>
										12일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수강신청 3일차 (전체)<br>
										12일 ~ 18일 <label style="color:#000fff; font-weight: bold;">[기]</label> 2학기 기숙사비 납부<br>
										13일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수강신청 4일차 (전체, 시간제)<br>
										20일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 후기 학위수여식<br>
										21일 <label style="color:#000fff; font-weight: bold;">[기]</label> 하계 기숙사 운영종료일<br>
										26일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 하계계절학기 종강(예정)<br>
										25일 ~ 26일 <label style="color:#000fff; font-weight: bold;">[기]</label> 등록금 납부<br>
										26일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 한디원 하반기 학사협의회<br>
										30일 <label style="color:#000fff; font-weight: bold;">[기]</label> 2학기 기숙사 OT 및 입실<br>
										31일 <label style="color:#000fff; font-weight: bold;">[기]</label> 2학기 기숙사 운영시작일<br>
										08월 중 <label style="color:#000fff; font-weight: bold;">[기]</label> ICCE 해외인턴십 선발공고(2차)<br>
									</td>
								</tr>
								<tr>
									<th class="ta_left">9月 (September)<br> ☞ 2020학년도 2학기</th>
									<td class="ta_left">
										01일 <label style="color:#ff0000; font-weight: bold;">[주]</label> <label style="color:#ff0000;">2020학년도 2학기 개강</label><br>
										06일 <label style="color:#000fff; font-weight: bold;">[기]</label> 2학기 기숙사 OT 및 입실<br>
										06일 <label style="color:#000fff; font-weight: bold;">[기]</label> 2학기 기숙사 운영시작일<br>
										10일, 11일, 14일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수강신청 정정기간<br>
										17일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수업일수 17일(1/6)<br>
										17일 ~ 18일 <label style="color:#000fff; font-weight: bold;">[기]</label> 등록금 추가납부기간<br>
										24일 ~ 25일 <label style="color:#000fff; font-weight: bold;">[기]</label> 등록금 분할납부 (2차)<br>
										30일 <label style="color:#000fff; font-weight: bold;">[기]</label> 2학기 장학생 선발 (예정)<br>
									</td>
								</tr>
								<tr>
									<th class="ta_left">10月 (October)</th>
									<td class="ta_left">
										05일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수업일수 35일(1/3)<br>
										20일 ~ 26일 <label style="color:#ff0000; font-weight: bold;">[주]</label> <label style="color:#ff0000;">중간고사</label><br>
										22일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 수업일수 52일(1/2)<br>
										22일 ~ 23일 <label style="color:#000fff; font-weight: bold;">[기]</label> 등록금 분할납부(3차)<br>
									</td>
								</tr>
								<tr>
									<th class="ta_left">11月 (November)</th>
									<td class="ta_left">
										11월 중 총학생회 선거
									</td>
								</tr>
								<tr>
									<th class="ta_left">12月 (December)</th>
									<td class="ta_left">
										07일 ~ 11일 <label style="color:#000fff; font-weight: bold;">[기]</label> 동계 기숙사생 모집<br>
										08일 ~ 14일 <label style="color:#ff0000; font-weight: bold;">[주]</label> <label style="color:#ff0000;">기말고사 (종강)</label><br>
										10일 ~ 11일 <label style="color:#000fff; font-weight: bold;">[기]</label> 등록금분할납부 신청<br>
										16일 ~ 22일 <label style="color:#000fff; font-weight: bold;">[기]</label> 동계 기숙사비 납부<br>
										15일 ~ 19일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 보강주<br>
										15일 ~ 19일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 강의평가 기간<br>
										21일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 성적이의신청 마감<br>
										19일 <label style="color:#000fff; font-weight: bold;">[기]</label> 2학기 기숙사 운영종료일<br>
										21일 ~ 22일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 동계계절학기 수강신청(서면신청)<br>
										23일 ~ 24일 <label style="color:#000fff; font-weight: bold;">[기]</label> 동계계절 등록금납부기간<br>
										28일 <label style="color:#000fff; font-weight: bold;">[기]</label> 동계기숙사OT 및 입실(운영시작일)<br>
										28일 <label style="color:#ff0000; font-weight: bold;">[주]</label> 동계 계절학기 개강 (예정) <br>
									</td>
								</tr>
							</tbody>
						</table>
					</div>	 --%>		
				
				<!-- rolling banner -->
				<c:import url="/EgovPageLink.do?link=usr/inc/incRollingBanner"/>
				<!-- //rolling banner -->
				<!-- //content -->
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
</form>
</body>
</html>