<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<body>
<form:form commandName="searchVO" id="frm" name="frm">
	<!-- skip_navigation -->
	<dl id="skip_nav">
		<dt>바로가기 메뉴</dt>
		<dd><a href="#content">본문 바로가기</a></dd>
		<dd><a href="#top_menu">메뉴 바로가기</a></dd>
		<dd><a href="#footer">페이지 하단 바로가기</a></dd>
	</dl>
	<!-- //skip_navigation -->
	<div class="content">
		<!-- header area -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
		<!-- //header area -->
		<div class="main_content" id="content">
			<div class="width_box">
				<!-- left menu area-->
				<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu"/>
				<!-- //left menu area--> 
				<div class="sub_content">
					<c:import url="/EgovPageLink.do?link=usr/inc/incPageTitle">
						<c:param name="dept1" value="캠퍼스생활"/>
						<c:param name="dept2" value="기업 · 지역연계수업"/>
					</c:import>
					<div class="top_tab type_li2">
						<ul>
							<li><a href="<c:url value='/usr/community/employment/employList.do'/>">취업프로그램</a></li>
							<li class="active"><a href="<c:url value='/usr/community/association.do'/>">기업ㆍ지역연계수업</a></li>
						</ul>
					</div>
					<div class="hd_intro_box">
						<div class="int_title">기업연계형 프로젝트 수업(CLPC) 및 시행절차</div>
						<div class="page_img" id="target" style="margin-top:80px;"><img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/asso_img_01.jpg'/>" style="width:100%"></div>
						<div class="int_title">전공별 프로젝트 수업 운영현황</div>
						<div class="ta_overbox">
							<table class="ta874_ty03" summary="전공별 프로젝트 수업 운영현황을 보여줍니다.">
								<caption>전공별 프로젝트 수업 운영현황</caption>
								<colgroup>
									<col style="width:150px;" />
									<col style="width:200px;" />
									<col style="width:374px;" />
									<col style="width:150px;" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">전공</th>
										<th scope="col">참가기업</th>
										<th scope="col">실시내용</th>
										<th scope="col">비고</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>실내디자인</td>
										<td>한샘, LG하우시스, 이케아 등</br>인테리어 전문업체(12개)</td>
										<td>12주간 기업 연계수업</td>
										<td rowspan="15">지정기부금</br>(장학금 지급)</td>
									</tr>
									<tr>
										<td rowspan="5">시각디자인학</td>
										<td>대한적십자사</td>
										<td>캠페인 광고 및 홍보물 제작</td>
									</tr>
									<tr>
										<td style="border-left: 1px solid #cccccc;">올림푸스코리아</td>
										<td>사내 커뮤니케이션 디자인</td>
									</tr>
									<tr>
										<td style="border-left: 1px solid #cccccc;">제주맥주</td>
										<td>상품 패키지 및 브랜드 디자인</td>
									</tr>
									<tr>
										<td style="border-left: 1px solid #cccccc;">빙그레</td>
										<td>동화책 일러스트레이션</td>
									</tr>
									<tr>
										<td style="border-left: 1px solid #cccccc;">동부여성발전센터</td>
										<td>여성기업 맞춤형 디자인 프로젝트</td>
									</tr>
									<tr>
										<td rowspan="3">산업디자인</td>
										<td>삼천리자전거</td>
										<td>운송기기 디자인 및 콘텐츠개발</td>
									</tr>
									<tr>
										<td style="border-left: 1px solid #cccccc;">H&B21</td>
										<td>코스메틱 제품 디자인</td>
									</tr>
									<tr>
										<td style="border-left: 1px solid #cccccc;">성북문화재단</td>
										<td>성곽마을 유니버셜 디자인</td>
									</tr>
									<tr>
										<td rowspan="3">디지털아트학</td>
										<td>올림푸스코리아</td>
										<td>영상 콘텐츠 제작</td>
									</tr>
									<tr>
										<td style="border-left: 1px solid #cccccc;">한국모델협회</td>
										<td>영상 콘텐츠 제작</td>
									</tr>
									<tr>
										<td style="border-left: 1px solid #cccccc;">성북문화재단</td>
										<td>웹툰 및 출판만화 제작</td>
									</tr>
									<tr>
										<td rowspan="2">패션계열</td>
										<td>카페24</td>
										<td>의류쇼핑몰 마케팅/창업과정</td>
									</tr>
									<tr>
										<td style="border-left: 1px solid #cccccc;">더라커룸</td>
										<td>스포츠웨어 디자인 개발</td>
									</tr>
									<tr>
										<td>뷰티계열</td>
										<td>BIT살롱, 아이디헤어, 미니원 등<br>뷰티 전문기업 (9개)</td>
										<td>기업주도 교과과정 참여</td>
									</tr>
								</tbody>
							</table>
							<img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/asso_img_02.jpg'/>" alt="" style="margin-top: 10px;"/>
							<img src="<c:out value='${pageContext.request.contextPath}/assets/usr/img/asso_img_03.jpg'/>" alt="" style="margin-top: 10px;"/>
						</div>
					</div>
				</div>
			</div>
			<div class="go_top"><a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a></div>
		</div>
		<!-- footer -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
		<!-- //footer -->
	</div>
	<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>