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
						<c:param name="dept1" value="한디원뉴스"/>
						<c:param name="dept2" value="취업현황"/>
					</c:import>
					
					<div class="s_tit">주요대학 진학현황</div>
					<div class="sub_cont_box">
						<div class="emp_icon">
							<ul class="uni">
								<li>한성대학교</li>
								<li>홍익대학교</li>
								<li>건국대학교</li>
								<li>국민대학교</li>
								<li>성균관 대학교</li>
								<li>이화여자대학교</li>
							</ul>
						</div>
					</div>
					<div class="s_tit" style="margin-top:30px;">진학현황</div>
					<div class="ta_overbox">
						<table class="ta874_ty02" summary="진학현황을 이름, 진학학교 순서로 보여줍니다.">
							<caption>진학현황</caption>
							<colgroup>
								<col style="width:200px;" />
								<col style="width:674px;" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">이름</th>
									<th scope="col">진학학교</th>
								</tr>
							</thead>
							<tbody>
								<tr><td>장* 빈</td><td>홍익대학교 일반대학원 목가구조형학과</td></tr>
								<tr><td>최* 지</td><td>연세대학교 일반대학원</td></tr>
								<tr><td>이* 종</td><td>국민대학교 일반대학원</td></tr>
								<tr><td>최* 우</td><td>한성대학교 일반대학원 뉴미디어광고프로모션전공</td></tr>
								<tr><td>조* 은</td><td>한성대학교 일반대학원 뉴미디어광고프로모션전공</td></tr>
								<tr><td>조* 은</td><td>국민대학교 일반대학원</td></tr>
								<tr><td>조* 은</td><td>건국대학교 일반대학원</td></tr>
								<tr><td>최* 우</td><td>한성대학교 일반대학원 뉴미디어광고프로모션전공</td></tr>
								<tr><td>조* 은</td><td>한성대학교 일반대학원 시각영상커뮤니케이션전공</td></tr>
								<tr><td>김* 민</td><td>한성대학교 일반대학원 뉴미디어광고프로모션전공</td></tr>
								<tr><td>조* 은</td><td>국민대학교 디자인대학원 시각디자인전공</td></tr>
								<tr><td>조* 은</td><td>건국대학교 예술디자인대학원 시각디자인전공</td></tr>
								<tr><td>조* 은</td><td>홍익대학교 광고홍보대학원 시각디자인전공</td></tr>
								<tr><td>박* 열</td><td>서울시립대학교 디자인전문대학원 시각디자인전공</td></tr>
								<tr><td>정* 진</td><td>홍익대학교 광고홍보대학원 시각디자인전공</td></tr>
								<tr><td>박* 예</td><td>한성대학교 일반대학원 인테리어디자인전공</td></tr>
								<tr><td>최* 지</td><td>연세대학교 일반대학원 생활과학대학 실내건축학과</td></tr>
								<tr><td>문*솔</td><td>홍익대학교 일반대학원 공간디자인학과</td></tr>
								<tr><td>김* 솔</td><td>건국대학교 건축전문대학원 실내건축디자인학과</td></tr>
								<tr><td>한* 정</td><td>건국대학교 건축전문대학원 실내건축디자인학과</td></tr>
								<tr><td>이* 지</td><td>한양대학교 공학대학원 생태조경학과</td></tr>
								<tr><td>허* 운</td><td>국민대학교 일반대학원 건축디자인학과</td></tr>
								<tr><td>이* 라</td><td>건국대학교 패션마케팅학과</td></tr>
								<tr><td>강* 숙</td><td>건국대학교 패션마케팅학과</td></tr>
								<tr><td>윤* 나</td><td>건국대학교 패션디자인학과</td></tr>
								<tr><td>김* 경</td><td>건국대학교 패션마케팅학과</td></tr>
								<tr><td>노* 훈</td><td>건국대학교 패션디자인학과</td></tr>
								<tr><td>정* 선</td><td>한성대학교 일반대학원 패션디자인기획전공</td></tr>
								<tr><td>노* 훈</td><td>건국대학교 의상디자인학과</td></tr>
								<tr><td>유* 해</td><td>세종대학교 패션디자인학과</td></tr>
								<tr><td>고* 준</td><td>홍익대학교 마케팅전공</td></tr>
								<tr><td>홍* 영</td><td>상지대학교 제품디자인학과</td></tr>
								<tr><td>김* 지</td><td>한성대학교 일반대학원 미디어디자인전공</td></tr>
								<tr><td>신* 솔</td><td>국민대학교 일반대학원 실내디자인학과</td></tr>
								<tr><td>정* 주</td><td>홍익대학교 일반대학원 공간디자인학과</td></tr>
								<tr><td>조* 재</td><td>홍익대학교 건축도시대학원 건축설계전공</td></tr>
								<tr><td>한* 구</td><td>홍익대학교 산업미술대학원 광고디자인학과</td></tr>
								<tr><td>방* 운</td><td>서울시립대학교 디자인전문대학원 공공시각디자인전공</td></tr>
								<tr><td>박* 미</td><td>중앙대학교 의학대학원</td></tr>
								<tr><td>김* 정</td><td>한성대학교 예술대학원 뷰티예술대학과</td></tr>
								<tr><td>박* 은</td><td>한성대학교 예술대학원 뷰티예술대학과</td></tr>
								<tr><td>유* 희</td><td>한성대학교 예술대학원 뷰티예술대학과</td></tr>
								<tr><td>최* 연</td><td>한성대학교 예술대학원 뷰티예술대학과</td></tr>
								<tr><td>이* 화</td><td>한성대학교 일반대학원 뉴미디어광고프로모션전공</td></tr>
								<tr><td>길* 원</td><td>홍익대학교 일반대학원 공간디자인학과</td></tr>
								<tr><td>김* 훈</td><td>한성대학교 일반대학원 인테리어디자인전공</td></tr>
								<tr><td>이* 희</td><td>한성대학교 일반대학원 인테리어디자인전공</td></tr>
								<tr><td>김* 슬</td><td>홍익대학교 건축도시대학원 실내설계전공</td></tr>
								<tr><td>이* 화</td><td>한성대학교 일반대학원 뉴미디어광고프로모션전공</td></tr>
								<tr><td>유* 늬</td><td>한성대학교 일반대학원 뉴미디어광고프로모션전공</td></tr>
								<tr><td>박* 영</td><td>한성대학교 일반대학원 뉴미디어광고프로모션전공</td></tr>
								<tr><td>강* 란</td><td>한성대학교 일반대학원 뉴미디어광고프로모션전공</td></tr>
								<tr><td>윤* 늘</td><td>한성대학교 일반대학원 시각영상커뮤니케이션전공</td></tr>
								<tr><td>김* 샘</td><td>한성대학교 일반대학원 애니메이션제품디자인전공</td></tr>
								<tr><td>강* 숙</td><td>건국대학교 디자인대학원 패션마케팅학과</td></tr>
								<tr><td>정* 인</td><td>홍익대학교 일반대학원 의상디자인학과</td></tr>
								<tr><td>한* 현</td><td>세종대학교 일반대학원 패션디자인학과</td></tr>
								<tr><td>김* 경</td><td>건국대학교 디자인대학원 패션마케팅학과</td></tr>
								<tr><td>박* 은</td><td>한성대학교 예술대학원 뷰티예술대학과</td></tr>
								<tr><td>김* 희</td><td>한성대학교 일반대학원 인테리어디자인전공</td></tr>
								<tr><td>이*슬</td><td>국민대학교 일반대학원 공간디자인학과</td></tr>
								<tr><td>한* 정</td><td>국민대학교 테크노디자인전문대학원 실내디자인학과</td></tr>
								<tr><td>심* 경</td><td>홍익대학교 건축도시대학원 실내설계전공</td></tr>
								<tr><td>서* 영</td><td>홍익대학교 건축도시대학원 실내설계전공</td></tr>
								<tr><td>정* 호</td><td>한성대학교 일반대학원 인테리어디자인전공</td></tr>
								<tr><td>최* 석</td><td>성균관대학교 대학원 브랜드매니지먼트전공</td></tr>
								<tr><td>김* 수</td><td>한성대학교 일반대학원 뉴미디어광고프로모션전공</td></tr>
								<tr><td>한* 주</td><td>한성대학교 일반대학원 인테리어디자인전공</td></tr>
								<tr><td>박* 란</td><td>성균관대학교 일반대학원 써비스디자인학과</td></tr>
								<tr><td>이* 영</td><td>홍익대학교 일반대학교 공간디자인학과</td></tr>
								<tr><td>이* 민</td><td>한성대학교 일반대학원 뉴미디어광고프로모션전공</td></tr>
								<tr><td>함* 정</td><td>한성대학교 일반대학원 뉴미디어광고프로모션전공</td></tr>
								<tr><td>조* 림</td><td>한성대학교 일반대학원 뉴미디어광고프로모션전공</td></tr>
								<tr><td>송* 라</td><td>한성대학교 일반대학원 뉴미디어광고프로모션전공</td></tr>
								<tr><td>김* 주</td><td>한성대학교 일반대학원 인테리어디자인전공</td></tr>
								<tr><td>강* 연</td><td>한성대학교 일반대학원 인테리어디자인전공</td></tr>
								<tr><td>김* 현</td><td>한성대학교 일반대학원 인테리어디자인전공</td></tr>
								<tr><td>송* 선</td><td>한성대학교 일반대학원 인테리어디자인전공</td></tr>
								<tr><td>황* 윤</td><td>건국대학교 건출전문대학원 실내건축학과</td></tr>
								<tr><td>김* 슬</td><td>건국대학교 실내건축학과</td></tr>
								<tr><td>고* 혜</td><td>상명대학교 무대디자인학과</td></tr>
								<tr><td>박* 연</td><td>한성대학교 일반대학원 뉴미디어광고프로모션전공</td></tr>
								<tr><td>양* 미</td><td>홍익대학교 일반대학원 광고홍보학과</td></tr>
								<tr><td>최* 은</td><td>홍익대학교 광고홍보대학원 브랜드매니지먼트학과</td></tr>
								<tr><td>이* 미</td><td>숙명여자대학교 일반대학원 광고홍보학과</td></tr>
								<tr><td>권* 륜</td><td>세종대학교 일반대학원 광고홍보학과</td></tr>
								<tr><td>우* 아</td><td>홍익대학교 미술대학원 회화전공</td></tr>
								<tr><td>신* 원</td><td>홍익대학교 미술대학원 예술기획전공</td></tr>
								<tr><td>이* 라</td><td>건국대학교 디자인대학원 패션디자인학과</td></tr>
								<tr><td>윤* 나</td><td>건국대학교 디자인대학원 패션디자인학과</td></tr>
								<tr><td>이*휘</td><td>성균관대학교 일반대학원 써피스디자인학과</td></tr>
								<tr><td>이* 진</td><td>성균관대학교 일반대학원 의상학과</td></tr>
								<tr><td>최* 희</td><td>한성대학교 예술대학원 패션디자인 기획학과</td></tr>
								<tr><td>박* 인</td><td>세종대학교 일반대학원 패션디자인학과</td></tr>
								<tr><td>허* 영</td><td>한성대학교 일반대학원 인테리어디자인전공</td></tr>
								<tr><td>강* 연</td><td>한성대학교 일반대학원 인테리어디자인전공</td></tr>
								<tr><td>김* 주</td><td>한성대학교 일반대학원 인테리어디자인전공</td></tr>
								<tr><td>정* 정</td><td>국민대학교 종합예술대학원 무대기술 및 제작전공</td></tr>
								<tr><td>김* 리</td><td>국민대학교 종합예술대학원 무대기술 및 제작전공</td></tr>
								<tr><td>신* 원</td><td>홍익대학교 미술대학원 예술기획전공</td></tr>
								<tr><td>강* 인</td><td>한성대학교 일반대학원 시각영상커뮤니케이션전공</td></tr>
								<tr><td>홍* 욱</td><td>한성대학교 일반대학원 시각영상커뮤니케이션전공</td></tr>
								<tr><td>이* </td><td>한성대학교 일반대학원 뉴미디어광고프로모션전공</td></tr>
								<tr><td>김* 희</td><td>한성대학교 일반대학원 애니메이션제품디자인전공</td></tr>
								<tr><td>이* 정</td><td>한성대학교 예술대학원 패션디자인기획학과</td></tr>
								<tr><td>홍* 민</td><td>한성대학교 예술대학원 패션디자인기획학과</td></tr>
								<tr><td>홍* 미</td><td>경원대학교 일반대학원 실내건축학과</td></tr>
								<tr><td>정* 선</td><td>성균관대학교 일반대학원 써비스디자인학과</td></tr>
								<tr><td>임* 리</td><td>경원대학교 일반대학원 실내건축학과</td></tr>
								<tr><td>장* 하</td><td>한성대학교 일반대학원 인테리어디자인전공</td></tr>
								<tr><td>주* 문</td><td>한성대학교 일반대학원 인테리어디자인전공</td></tr>
								<tr><td>신* 영</td><td>홍익대학교 광고홍보대학원 브랜드매니지먼트학과</td></tr>
								<tr><td>강* 은</td><td>이화여자대학교 디자인대학원 크레프트디자인학과</td></tr>
								<tr><td>노* 혜</td><td>성균관대학교 대학원 브랜드매니지먼트전공</td></tr>
								<tr><td>송* 혜</td><td>한성대학교 일반대학원 뉴미디어광고프로모션전공</td></tr>
								<tr><td>함* 아</td><td>한성대학교 일반대학원 시각영상커뮤니케이션전공</td></tr>
								<tr><td>권* 옥</td><td>한성대학교 일반대학원 애니메이션제품디자인전공</td></tr>
								<tr><td>송* 선</td><td>국민대학교 일반대학원 실내디자인학과</td></tr>
								<tr><td>황* 윤</td><td>건국대학교 건축대학원 실내건축디자인학과</td></tr>
								<tr><td>장* 아</td><td>한성대학교 인테리어디자인학과</td></tr>
								<tr><td>김* 국</td><td>한성대학교 일반대학원 인테리어디자인전공</td></tr>
								<tr><td>김* 호</td><td>건국대학교 건축전문대학원 실내건축디자인학과</td></tr>
								<tr><td>정* 현</td><td>한성대학교 일반대학원 인테리어디자인전공</td></tr>
								<tr><td>정* 경</td><td>한성대학교 일반대학원 미디어디자인학과</td></tr>
								<tr><td>박* 혁</td><td>한성대학교 일반대학원 뉴미디어광고프로모션전공</td></tr>
							</tbody>
						</table>
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