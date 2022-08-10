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
			            <jsp:param name="dept2" value="성우콘텐츠크리에이터"/>
			            <jsp:param name="dept3" value="교과과정"/>
		           	</jsp:include>
					<div class="sub_cont_page">
						<div class="ta_overbox">
							<table class="ta874_ty02" summary="교과 과정 정보를 학년, 이수구분, 1학기(교과목명, 학점), 이수구분, 2학기(교과목명, 학점) 순서로 보여줍니다.">
								<caption>교과 과정표</caption>
								<colgroup>
									<col style="width:;" />
									<col style="width:;" />
									<col style="width:;" />
									<col style="width:;" />
									<col style="width:;" />
									<col style="width:;" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">학기</th>
										<th scope="col">구분</th>
										<th scope="col">교과목명</th>
										<th scope="col">학점</th>
										<th scope="col">이론</th>
										<th scope="col">실습</th>
									</tr>
								</thead>
								<%--
								<tfoot>
									<tr>
										<td colspan="2">총계</td>
										<td>전공필수(과목수)</td>
										<td>7</td>
										<td></td>
										<td>전공선택(과목수)</td>
										<td>7</td>
									</tr>
								</tfoot>
								--%>
								<tbody>
								<!-- 1학기 - start -->
									<tr>
										<td rowspan="6">1</td>
										<td>전선</td>
										<td class="ta_left">기초디자인</td>
										<td>3</td>
										<td>2</td>
										<td>2</td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left">컴퓨터그래픽스I</td>
										<td>3</td>
										<td>1</td>
										<td>4</td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left r_txt">디지털스토리텔링</td>
										<td>3</td>
										<td>3</td>
										<td></td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left r_txt">디지털영상</td>
										<td>3</td>
										<td>3</td>
										<td></td>
									</tr>
									<tr>
										<td>일선</td>
										<td class="ta_left">디지털미디어개론</td>
										<td>3</td>
										<td>3</td>
										<td></td>
									</tr>
									<tr style="background-color: #faebd7;">
										<td>심화</td>
										<td class="ta_left r_txt">Empathy communication</td>
										<td>-</td>
										<td></td>
										<td>2</td>
									</tr>
								<!-- 1학기 - end -->
								<!-- 2학기 - start -->
									<tr>
										<td rowspan="6">2</td>
										<td>전선</td>
										<td class="ta_left r_txt">멀티미디어저작도구I</td>
										<td>3</td>
										<td>2</td>
										<td>2</td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left r_txt">디지털미디어프로덕션스튜디오I</td>
										<td>3</td>
										<td>2</td>
										<td>2</td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left">디지털미디어영상스튜디오I</td>
										<td>3</td>
										<td>2</td>
										<td>2</td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left">디지털사운드</td>
										<td>3</td>
										<td>3</td>
										<td></td>
									</tr>
									<tr>
										<td>일선</td>
										<td class="ta_left">타이포그래피</td>
										<td>3</td>
										<td>3</td>
										<td></td>
									</tr>
									<tr style="background-color: #faebd7;">
										<td>심화</td>
										<td class="ta_left r_txt">보이스 코칭</td>
										<td>-</td>
										<td></td>
										<td>2</td>
									</tr>
								<!-- 2학기 - end -->
								<!-- 3학기 - start -->
									<tr>
										<td rowspan="6">3</td>
										<td>전필</td>
										<td class="ta_left r_txt">실험영상</td>
										<td>3</td>
										<td>3</td>
										<td></td>
									</tr>
									<tr>
										<td>전필</td>
										<td class="ta_left r_txt">제작실습1</td>
										<td>3</td>
										<td>2</td>
										<td>2</td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left r_txt">멀티미디어디자인I</td>
										<td>3</td>
										<td>2</td>
										<td>2</td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left">3D캐릭터애니메이션</td>
										<td>3</td>
										<td>3</td>
										<td></td>
									</tr>
									<tr>
										<td>일선</td>
										<td class="ta_left">장면만들기I</td>
										<td>3</td>
										<td>2</td>
										<td>2</td>
									</tr>
									<tr style="background-color: #faebd7;">
										<td>심화</td>
										<td class="ta_left">실용화술</td>
										<td>-</td>
										<td></td>
										<td>2</td>
									</tr>
								<!-- 3학기 - end -->
								<!-- 4학기 - start -->
									<tr>
										<td rowspan="6">4</td>
										<td>전필</td>
										<td class="ta_left r_txt">제작실습II</td>
										<td>3</td>
										<td>2</td>
										<td>2</td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left">가상현실</td>
										<td>3</td>
										<td>3</td>
										<td></td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left">디지털특수효과</td>
										<td>3</td>
										<td>3</td>
										<td></td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left">영상디자인스튜디오1</td>
										<td>3</td>
										<td>1</td>
										<td>4</td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left">디지털애니메이션I</td>
										<td>3</td>
										<td>1</td>
										<td>4</td>
									</tr>
									<tr style="background-color: #faebd7;">
										<td>심화</td>
										<td class="ta_left r_txt">커뮤니케이션 리서치</td>
										<td>-</td>
										<td></td>
										<td>2</td>
									</tr>
								<!-- 4학기 - end -->
								<!-- 5학기 - start -->
									<tr>
										<td rowspan="6">5</td>
										<td>교양</td>
										<td class="ta_left r_txt">영화예술의이해</td>
										<td>3</td>
										<td>3</td>
										<td></td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left r_txt">멀티미디어콘텐츠개발</td>
										<td>3</td>
										<td>3</td>
										<td></td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left">뉴미디어실습</td>
										<td>3</td>
										<td>2</td>
										<td>2</td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left">드로잉I</td>
										<td>3</td>
										<td>2</td>
										<td>2</td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left r_txt">디지털미디어프로덕션스튜디오1</td>
										<td>3</td>
										<td>2</td>
										<td>2</td>
									</tr>
									<tr style="background-color: #faebd7;">
										<td>심화</td>
										<td class="ta_left r_txt">외화더빙</td>
										<td>-</td>
										<td></td>
										<td>2</td>
									</tr>
								<!-- 5학기 - end -->
								<!-- 6학기 - start -->
									<tr>
										<td rowspan="5">6</td>
										<td>전선</td>
										<td class="ta_left">디지털콘텐츠마케팅</td>
										<td>3</td>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td>전선</td>
										<td class="ta_left r_txt">모션그래픽</td>
										<td>3</td>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td>일선</td>
										<td class="ta_left">포토저널리즘</td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
									<tr>
										<td>일선</td>
										<td class="ta_left r_txt">뉴미디어실습</td>
										<td>1</td>
										<td>4</td>
										<td></td>
									</tr>
									<tr style="background-color: #faebd7;">
										<td>심화</td>
										<td class="ta_left"></td>
										<td>-</td>
										<td></td>
										<td></td>
									</tr>
								<!-- 6학기 - end -->
								</tbody>
							</table>
						</div>
						
						<div class="ta_overbox" style="margin-top: 40px;">
							<table class="ta874_ty02">
								<caption>교과 과정표</caption>
								<colgroup>
									<col style="width:;" />
									<col style="width:;" />
									<col style="width:;" />
									<col style="width:;" />
									<col style="width:;" />
								</colgroup>
								<thead>
									<tr>
										<th colspan="2" scope="col">구분</th>
										<th scope="col">교과목명</th>
										<th scope="col">학점</th>
										<th scope="col">이론</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td rowspan="7">자격증</td>
										<td rowspan="5">전공</td>
										<td class="ta_left r_txt">게임그래픽전문가</td>
										<td>20</td>
										<td></td>
									</tr>
									<tr>
										<td class="ta_left">게임프로그래밍전문가</td>
										<td>20</td>
										<td></td>
									</tr>
									<tr>
										<td class="ta_left">멀티미디어콘텐츠제작전문가</td>
										<td>18</td>
										<td></td>
									</tr>
									<tr>
										<td class="ta_left r_txt">컬러리스트산업기사</td>
										<td>16</td>
										<td></td>
									</tr>
									<tr>
										<td class="ta_left">GTQ1급/2급</td>
										<td>5/3</td>
										<td></td>
									</tr>
									<tr>
										<td>일선</td>
										<td class="ta_left r_txt">컴퓨터활용능력1급/2급</td>
										<td>14/6</td>
										<td></td>
									</tr>
									<tr>
										<td colspan="4" class="r_txt">기타자격증은 학과로 상담 바람</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="ta_txt">
							<ul>
								<li class="r_txt">※ (    )인가예정과목</li>
							</ul>
						</div>
					</div>
					<div class="go_top"><a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a></div>
				<!--// content -->
				</div>		
			</div>
		<!--// container -->
		<hr />
		</div>
	</div>
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>