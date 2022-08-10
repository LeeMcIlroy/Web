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
						<c:param name="dept2" value="공모전 수상내역"/>
					</c:import>
					
					<div class="s_tit">주요공모전 수상현황</div>
					<div class="sub_cont_box">
						<div class="emp_icon">
							<ul class="exh">
								<li>
									<dl>
										<dt>보건복지부</dt>
										<dd>
											<p>보건복지부 장관상 수상</p>
											<p>공모주재<br>
											구강건강의 중요성과 예방</p>
											<a href="<c:out value='${pageContext.request.contextPath }/usr/news/proud/proudView.do?cbSeq=10907'/>" target="_blank" title="[새창]보건복지부 공모전으로 이동합니다.">바로가기</a>
										</dd>
									</dl>
								</li>
								<li>
									<dl>
										<dt>해양수산부</dt>
										<dd>
											<p>해양수산부 장관상 수상</p>
											<p>공모주재<br>
											내가 만드는 여객선 안전교육 UCC 부문</p>
											<a href="<c:out value='${pageContext.request.contextPath }/usr/news/proud/proudView.do?cbSeq=10886'/>" target="_blank" title="[새창]해양수산부 공모전으로 이동합니다.">바로가기</a>
										</dd>
									</dl>
								</li>
								<li>
									<dl>
										<dt>헌법재판소</dt>
										<dd>
											<p>헌법재판소 소장상 수상</p>
											<p>공모주재<br>
											2016 헌법사랑 공모전</p>
											<a href="<c:out value='${pageContext.request.contextPath }/usr/news/proud/proudView.do?cbSeq=10877'/>" target="_blank" title="[새창]헌법재판소 공모전으로 이동합니다.">바로가기</a>
										</dd>
									</dl>
								</li>
								<li>
									<dl>
										<dt>한국소비자원</dt>
										<dd>
											<p>한국소비자원 원장상 수상</p>
											<p>공모주재<br>
											정부3.0 올바른 예약문화 확산을 위한 콘텐츠 공모전</p>
											<a href="<c:out value='${pageContext.request.contextPath }/usr/news/proud/proudView.do?cbSeq=10875'/>" target="_blank" title="[새창]한국소비자원  공모전으로 이동합니다.">바로가기</a>
										</dd>
									</dl>
								</li>
							</ul>
						</div>
					</div>
					<div class="s_tit" style="margin-top:30px;">수상현황</div>
					<div class="ta_overbox">
						<table class="ta874_ty02" summary="진학현황을 이름, 진학학교 순서로 보여줍니다.">
							<caption>진학현황</caption>
							<colgroup>
								<col style="width:500px;" />
								<col style="width:200px;" />
								<col style="width:174px;" />
							</colgroup>
							<thead>
								<tr>
									<th scope="col">공모전명</th>
									<th scope="col">수상내역</th>
									<th scope="col">이름</th>
								</tr>
							</thead>
							<tbody>
								<tr><td class="ta_left">2016 USA creativity inter national Award</td><td>Platinum Best category winner Silver Bronze</td><td>최*훈*</td></tr>
								<tr><td class="ta_left">2016 Swizerland Goldrn Award</td><td>Finialist</td><td>최*훈*</td></tr>
								<tr><td class="ta_left">2016 Cannes future Lions</td><td>Shortist</td><td>최*훈*</td></tr>
								<tr><td class="ta_left">2016 헌법사랑공모전</td><td>헌법재판소장상(대상)</td><td>문*혜, 오*택 외</td></tr>
								<tr><td class="ta_left">2016 제49회 대한구강보건협회 작품공모전</td><td>보건복지부장관상(대상)</td><td>오*택*</td></tr>
								<tr><td class="ta_left">2016 제14회 매일신문 광고대상공모전</td><td>대상</td><td>최*은, 우*규 외</td></tr>
								<tr><td class="ta_left">디지털미디어콘텐츠 공모전</td><td>새정치상</td><td>문*석*</td></tr>
								<tr><td class="ta_left">서울꿈새김판 문안 공모전</td><td>우수상</td><td>문*석*</td></tr>
								<tr><td class="ta_left">5th 탐앤탐스 광고공모전</td><td>대상(환경부장관상)</td><td>최*훈, 김*서 외</td></tr>
								<tr><td class="ta_left">제9회 흡연에티켓 광고공모전</td><td>입선</td><td>최*훈*</td></tr>
								<tr><td class="ta_left">작가데뷔 프로젝트_당신의 작품을 겁니다</td><td>작가 선발</td><td>유*혜*</td></tr>
								<tr><td class="ta_left">제3회 서체&디자인상</td><td>동상</td><td>엄*림, 권*림 팀</td></tr>
								<tr><td class="ta_left">국정교과서 반대 콘텐츠공모전</td><td>우수상</td><td>문*석*</td></tr>
								<tr><td class="ta_left">2016 CACADEW AWARDS</td><td>입선</td><td>김*정*</td></tr>
								<tr><td class="ta_left">2016 코튼 T-셔츠 프린트 디자이콘텐스트</td><td>입선</td><td>유*진*</td></tr>
								<tr><td class="ta_left">2016 AD STARD</td><td>크리스탈상, Finialist</td><td>최*훈*</td></tr>
								<tr><td class="ta_left">제7회 2016양성평등디자인공모전</td><td>은상</td><td>김*서*</td></tr>
								<tr><td class="ta_left">2016년 여객선 안전교육 UCC공모전</td><td>대상</td><td>이*호*</td></tr>
								<tr><td class="ta_left">제1회 동국제약 대학생 UCC 아이디어 공모전</td><td>3등</td><td>안*기, 신*율 외</td></tr>
								<tr><td class="ta_left">2016 제4회 생명사랑 정신건강문화축제</td><td>(최우수상) 1등</td><td>김*수*</td></tr>
								<tr><td class="ta_left">아시아태평양디자인연감(그래픽디자인 애뉴얼 어워드) 12th 2016 Asia Pacific Design Annual Award</td><td>연감 작품 등제</td><td>정*라, 양*준</td></tr>
								<tr><td class="ta_left">제12회 에이즈예방 광고공모전</td><td></td><td>권*승*</td></tr>
								<tr><td class="ta_left">제14회 LH 대학생 광고공모전</td><td></td><td>최*은, 문*혜 외</td></tr>
								<tr><td class="ta_left">제3회 서울국제일러스트레이션 공모전</td><td>입선</td><td>김*명, 유*진 외</td></tr>
								<tr><td class="ta_left">제4회 서울국제일러스트레이션 공모전</td><td>동상</td><td>김*원, 김*름 외</td></tr>
								<tr><td class="ta_left">제5회 서울국제일러스트레이션 공모전</td><td>장려상</td><td>박*진, 오*진 외</td></tr>
								<tr><td class="ta_left">서울다반사 공모전</td><td>시민인기상</td><td>이*한*</td></tr>
								<tr><td class="ta_left">2016성매매방지 UCC디자인공모전</td><td>가작</td><td>안*기*</td></tr>
								<tr><td class="ta_left">국민참여 KOTRA 홍보 공모전</td><td>우수상</td><td>이*규, 조*희 외</td></tr>
								<tr><td class="ta_left">국민참여 KOTRA 홍보 공모전</td><td>장려상</td><td>안*기, 박*희 외</td></tr>
								<tr><td class="ta_left">2016 흡연에티켓 광고공모전</td><td>입선</td><td>최*은*</td></tr>
								<tr><td class="ta_left">제17회 KVMD 협회 디자인 공모전</td><td>대상</td><td>양*서*</td></tr>
								<tr><td class="ta_left">공간코디네이션대전</td><td>금상</td><td>김*훈, 최*경 외</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>금상</td><td>정*주, 변*영</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>금상</td><td>정*림, 이*슬</td></tr>
								<tr><td class="ta_left">KODIA 디스플레이賞</td><td>금상</td><td>박*미*</td></tr>
								<tr><td class="ta_left">제6회 한국공간디자인대전</td><td>은상</td><td>허*영, 이*혁 외</td></tr>
								<tr><td class="ta_left">부산국제문화제 실내건축대전</td><td>은상</td><td>김*현, 황*윤 외</td></tr>
								<tr><td class="ta_left">Store Design 공모전</td><td>은상</td><td>김*솔, 전*예</td></tr>
								<tr><td class="ta_left">Store Design 공모전</td><td>동상</td><td>임*연*</td></tr>
								<tr><td class="ta_left">제17회 KVMD 협회 디자인 공모전</td><td>은상</td><td>유*현, 최*아</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>동상</td><td>한*리, 조*재</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>동상</td><td>김*영, 조*재</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>동상</td><td>길*원*</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>동상</td><td>변*영*</td></tr>
								<tr><td class="ta_left">유니버셜디자인공모전</td><td>최우수상</td><td>김*이, 석*성 외</td></tr>
								<tr><td class="ta_left">대한민국 현대조형 미술대전</td><td>우수상</td><td>정*정, 임*연</td></tr>
								<tr><td class="ta_left">한국인테리어대전</td><td>장려상</td><td>이*석, 주*름 외</td></tr>
								<tr><td class="ta_left">차세대문화공간건축상</td><td>장려상</td><td>정*환, 김*영 외</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>유*현, 이*석 외</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>허*운, 한*은 외</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>이*지, 허*영 외</td></tr>
								<tr><td class="ta_left">한국인테리어대전</td><td>장려상</td><td>곽*건, 이*수 외</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>임*지, 남*태</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>신*영*</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>정*정, 윤*민</td></tr>
								<tr><td class="ta_left">차세대문화공간건축상</td><td>장려상</td><td>김*지, 이*수 외</td></tr>
								<tr><td class="ta_left">국제 청소년 건축설계 공모전</td><td>장려상</td><td>음*식, 박*호 외</td></tr>
								<tr><td class="ta_left">KDAI 우수작품전시회</td><td>장려상</td><td>정*환, 황*윤</td></tr>
								<tr><td class="ta_left">KDAI 우수작품전시회</td><td>장려상</td><td>김*호, 김*현 외</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>조*재, 김*영 외</td></tr>
								<tr><td class="ta_left">국제 청소년 건축설계 공모전</td><td>장려상</td><td>김*영, 이*지</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>장려상</td><td>이*슬, 정*림</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>장려상</td><td>곽*건, 석*성</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>장려상</td><td>옥*향, 박*은</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>김*영*</td></tr>
								<tr><td class="ta_left">공간코디네이션대전</td><td>특별상</td><td>최*경, 이*단 외</td></tr>
								<tr><td class="ta_left">제3회 한국공간코디네이션</td><td>특별상</td><td>장*하, 안*슬 외</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>특별상</td><td>장*하*</td></tr>
								<tr><td class="ta_left">한국인테리어대전</td><td>입선</td><td>이*석, 길*원</td></tr>
								<tr><td class="ta_left">한국인테리어대전</td><td>입선</td><td>김*금, 나*현</td></tr>
								<tr><td class="ta_left">전쟁기념관20주년'추억의사진'공모전</td><td>가작</td><td>윤*희*</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>우수상</td><td>김*영, 김*성</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>특선</td><td>김*영, 김*민</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>특선</td><td>유*현*</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>이*주, 이*영 외</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>조*진*</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>이*민, 김*국</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>양*빈, 이*영 외</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>박*경, 이*은</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>임*현, 조*진 외</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>최*진*</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>입선</td><td>김*나, 손*형 외</td></tr>
								<tr><td class="ta_left">실내건축대전</td><td>입선</td><td>이*석, 이*영</td></tr>
								<tr><td class="ta_left">제9회 차세대문화공간공모전</td><td>장려상</td><td>김*영*</td></tr>
								<tr><td class="ta_left">제9회 차세대문화공간공모전</td><td>장려상</td><td>허*운, 남*주</td></tr>
								<tr><td class="ta_left">제9회 차세대문화공간공모전</td><td>특선</td><td>유*현, 주*름 외</td></tr>
								<tr><td class="ta_left">제9회 차세대문화공간공모전</td><td>입선</td><td>이*영, 이*석</td></tr>
								<tr><td class="ta_left">제9회 차세대문화공간공모전</td><td>입선</td><td>이*지*</td></tr>
								<tr><td class="ta_left">제9회 차세대문화공간공모전</td><td>입선</td><td>최*진*</td></tr>
								<tr><td class="ta_left">제9회 차세대문화공간공모전</td><td>입선</td><td>남*식*</td></tr>
								<tr><td class="ta_left">제9회 차세대문화공간공모전</td><td>입선</td><td>원*성, 김*홍 외</td></tr>
								<tr><td class="ta_left">제43회 전국대학생디자인 대전</td><td>입선</td><td>이*은, 박*경</td></tr>
								<tr><td class="ta_left">국제청소년공간대전</td><td>특선</td><td>이*지, 김*재 외</td></tr>
								<tr><td class="ta_left">국제청소년공간대전</td><td>입선</td><td>이*영*</td></tr>
								<tr><td class="ta_left">국제청소년공간대전</td><td>입선</td><td>김*솔, 김*금 외</td></tr>
								<tr><td class="ta_left">제7회 한국 공간 디자인대전</td><td>동상</td><td>김*섭, 김*빈</td></tr>
								<tr><td class="ta_left">제7회 한국 공간 디자인대전</td><td>장려상</td><td>정*현, 김*민 외</td></tr>
								<tr><td class="ta_left">제7회 한국 공간 디자인대전</td><td>장려상</td><td>박*주, 양*빈 외</td></tr>
								<tr><td class="ta_left">제7회 한국 공간 디자인대전</td><td>장려상</td><td>김*홍, 원*성</td></tr>
								<tr><td class="ta_left">제7회 한국 공간 디자인대전</td><td>입선</td><td>정*윤*</td></tr>
								<tr><td class="ta_left">제7회 한국 공간 디자인대전</td><td>입선</td><td>신*웅*</td></tr>
								<tr><td class="ta_left">제7회 한국 공간 디자인대전</td><td>입선</td><td>최*용*</td></tr>
								<tr><td class="ta_left">제18회 KVMD 협회 디자인공모전</td><td>동상</td><td>서*윤, 김*재</td></tr>
								<tr><td class="ta_left">제4회 청소년 휴먼 영화제</td><td>대상</td><td>홍*욱, 유*호 외</td></tr>
								<tr><td class="ta_left">제8회 MTN 대한민국 대학생 광고공모전</td><td>대상</td><td>안*영*</td></tr>
								<tr><td class="ta_left">제10회 LH 대학생 광고 공모전</td><td>대상</td><td>김*비, 심*연 외</td></tr>
								<tr><td class="ta_left">sony 알파 nex 사진 공모전</td><td>대상</td><td>윤*늘*</td></tr>
								<tr><td class="ta_left">LA우표대전</td><td>금상</td><td>박*호, 이*아</td></tr>
								<tr><td class="ta_left">저출산 극복 포스터 공모전</td><td>금상</td><td>신*식, 한*범</td></tr>
								<tr><td class="ta_left">뉴던전 스트라이커 UCC 콘테스트</td><td>은상</td><td>양*국*</td></tr>
								<tr><td class="ta_left">국제광고제 클리오(CLIO)</td><td>은상</td><td>김*욱*</td></tr>
								<tr><td class="ta_left">제5회 MTN 대한민국 대학생 광고공모전</td><td>은상</td><td>임*이*</td></tr>
								<tr><td class="ta_left">제9회 에이즈 예방 대학생 광고공모전 광고기획부문</td><td>은상</td><td>안*영*</td></tr>
								<tr><td class="ta_left">삼성생명 대학생 공모전 UCC부문</td><td>은상</td><td>김*아*</td></tr>
								<tr><td class="ta_left">제2회 KB국민카드 꿈꾸는 광고인</td><td>동상</td><td>안*영*</td></tr>
								<tr><td class="ta_left">제15회 대학생 영남대학교 창업아이디어 경연대회</td><td>최우수상</td><td>이*훈*</td></tr>
								<tr><td class="ta_left">대학생 신용보증기금 창업아이템 경진대회</td><td>최우수상</td><td>이*훈*</td></tr>
								<tr><td class="ta_left">희망서울 엑스포 공모전</td><td>최우수상</td><td>양*지*</td></tr>
								<tr><td class="ta_left">3필착 그림영상 공모전</td><td>우수상</td><td>강*수, 이*진 외</td></tr>
								<tr><td class="ta_left">함께 여는 아름다운 세상 대학생 사회공헌 광고 공모전</td><td>우수상</td><td>김*성*</td></tr>
								<tr><td class="ta_left">㈜나눔로또 대학(원)생 홍보 아이디어 & 포스터 공모전</td><td>우수상</td><td>이*범, 한*범 외</td></tr>
								<tr><td class="ta_left">블랙스미스 아이디어 공모전</td><td>우수상</td><td>현*수*</td></tr>
								<tr><td class="ta_left">제11회 LH 대학생 광고 공모전 인쇄 광고부문</td><td>장려상</td><td>안*영*</td></tr>
								<tr><td class="ta_left">글로벌 게임제작 경진대회</td><td>장려상</td><td>유*호, 홍*욱</td></tr>
								<tr><td class="ta_left">NH농협대학생광고공모전</td><td>장려상</td><td>문*이*</td></tr>
								<tr><td class="ta_left">제1회 대한민국 인포그래픽 어워드</td><td>특별상</td><td>박*은, 김*민 외</td></tr>
								<tr><td class="ta_left">LA우표대전</td><td>특선</td><td>김*주, 정*혁</td></tr>
								<tr><td class="ta_left">제3회 JW중외 영아트 어워드 공모전 일러스트레이션부문</td><td>특선</td><td>차*철, 김*웅</td></tr>
								<tr><td class="ta_left">제11회 매일신문 광고대상 인쇄 광고부문</td><td>입선</td><td>신*식, 이*범</td></tr>
								<tr><td class="ta_left">제3회 JW중외 영아트 어워드 공모전 일러스트레이션부문</td><td>입선</td><td>길*라, 김*호 외</td></tr>
								<tr><td class="ta_left">희망서울 엑스포 공모전</td><td>입선</td><td>강*지*</td></tr>
								<tr><td class="ta_left">제1회 대한민국 인포그래픽 어워드</td><td>입선</td><td>김*훈, 한*홍 외</td></tr>
								<tr><td class="ta_left">제1회 대한민국 인포그래픽 어워드</td><td>입선</td><td>박*영, 이*림 외</td></tr>
								<tr><td class="ta_left">제1회 대한민국 인포그래픽 어워드</td><td>입선</td><td>이*우, 김*진 외</td></tr>
								<tr><td class="ta_left">제1회 대한민국 인포그래픽 어워드</td><td>입선</td><td>김*현, 김*호 외</td></tr>
								<tr><td class="ta_left">제1회 대한민국 인포그래픽 어워드</td><td>입선</td><td>김*성*</td></tr>
								<tr><td class="ta_left">흡연에티켓 광고공모전</td><td>입선</td><td>김*주, 김*라</td></tr>
								<tr><td class="ta_left">바람직한 간판문화 공모전(UCC)</td><td>입선</td><td>한*연, 김*솜</td></tr>
								<tr><td class="ta_left">제4회 비락 광고디자인공모전</td><td>입선</td><td>안*영, 정*혁 외</td></tr>
								<tr><td class="ta_left">제41회 전국대학생 디자인대전</td><td>입선</td><td>박*영, 송*혜</td></tr>
								<tr><td class="ta_left">전국대학생 디자인과제 공모전</td><td>입선</td><td>남*린, 강*인</td></tr>
								<tr><td class="ta_left">제3회 바람직한 간판문화 공모전</td><td>입선</td><td>한*연, 김*솜</td></tr>
								<tr><td class="ta_left">국토해양부 홍보 공모전 인쇄광고</td><td>입선</td><td>최*훈*</td></tr>
								<tr><td class="ta_left">대학(원)생 사회공헌 광고 공모전</td><td>우수상</td><td>김*성*</td></tr>
								<tr><td class="ta_left">샘표간장 노래자랑 UCC</td><td>너무프로상</td><td>김*래*</td></tr>
								<tr><td class="ta_left">커뮤니케이션디자인국제공모전</td><td>입선</td><td>이*연*</td></tr>
								<tr><td class="ta_left">제4회 비만예방디자인공모전</td><td>입선</td><td>이*희, 이*원 외</td></tr>
								<tr><td class="ta_left">전국 대학생 디자인공모전</td><td>특선</td><td>정*도, 조*선</td></tr>
								<tr><td class="ta_left">전국 대학생 디자인공모전</td><td>입선</td><td>백*화, 백*연 외</td></tr>
								<tr><td class="ta_left">신용보증기금 대학생 광고공모전</td><td>장려상</td><td>김*성, 이*범 외</td></tr>
								<tr><td class="ta_left">안전보건 UCC공모전</td><td>입선</td><td>양*국*</td></tr>
								<tr><td class="ta_left">제7회 즐거운환경UCC공모전</td><td>우수상</td><td>박*은, 조*은</td></tr>
								<tr><td class="ta_left">헌혈 공모전</td><td>생명나눔상</td><td>박*호, 이*아 외</td></tr>
								<tr><td class="ta_left">광동제약 헛개차 ucc공모전</td><td>2등</td><td>박*영, 박*준</td></tr>
								<tr><td class="ta_left">바이오아트 콘테스트</td><td>입선</td><td>양*국*</td></tr>
								<tr><td class="ta_left">광주 광역시 안전UCC공모전</td><td>안전상</td><td>이*호, 김*림</td></tr>
								<tr><td class="ta_left">첼로 UCC CONTEST</td><td>우수상</td><td>최*민, 이*호 외</td></tr>
								<tr><td class="ta_left">국립국악원UCC공모전</td><td>우수상</td><td>박*열, 최*우 외</td></tr>
								<tr><td class="ta_left">가스안전 디자인공모전</td><td>입선</td><td>박*나*</td></tr>
								<tr><td class="ta_left">THINK SAFETY UCC공모전</td><td>동상</td><td>박*호, 배*미</td></tr>
								<tr><td class="ta_left">전문병원홍보물 공모전</td><td>금상</td><td>최*우, 박*연</td></tr>
								<tr><td class="ta_left">인천광역시 치매인식개선 사진 및 UCC 공모전</td><td>장려상</td><td>김*림, 서*주</td></tr>
								<tr><td class="ta_left">아주특별한나눔BI공모전</td><td>입선</td><td>오*빈*</td></tr>
								<tr><td class="ta_left">UGIZ 1ST 티셔츠 그래픽디자인공모전</td><td>최우수상</td><td>신*경*</td></tr>
								<tr><td class="ta_left">디자인레이스 프리스타일 디자인아트 공모전</td><td>우수상</td><td>주*림*</td></tr>
								<tr><td class="ta_left">대한민국 지역특산 명품브랜드 공모전</td><td>한국지역 진흥재단 이사장상</td><td>이*호, 채*병 외</td></tr>
								<tr><td class="ta_left">첼로 UCC CONTEST</td><td>우수상</td><td>최*민, 이*호 외</td></tr>
								<tr><td class="ta_left">제2회 대학생 그림책 공모전</td><td>입선</td><td>홍*수*</td></tr>
								<tr><td class="ta_left">제1회 얼바인 아웃도어웨어 디자인 공모전</td><td>최우수상</td><td>임*하, 김*은</td></tr>
								<tr><td class="ta_left">제1회 Yo-콘테스트 유니폼디자인 공모전</td><td>금상</td><td>권*라*</td></tr>
								<tr><td class="ta_left">제2회 아웃도어웨어디자인 공모전</td><td>장려상</td><td>배*린*</td></tr>
								<tr><td class="ta_left">제2회 아웃도어웨어디자인 공모전</td><td>장려상</td><td>이*형*</td></tr>
								<tr><td class="ta_left">YDP 패션일러스트레이션 공모전</td><td>입선</td><td>김*은*</td></tr>
								<tr><td class="ta_left">YDP 패션일러스트레이션 공모전</td><td>입선</td><td>김*우*</td></tr>
								<tr><td class="ta_left">해외인턴쉽개발 국비지원프로그램</td><td>미국 국비지원 장학생 선발</td><td>이*이*</td></tr>
								<tr><td class="ta_left">패션상품기획콘테스트</td><td>장려상</td><td>조*비, 양*정</td></tr>
								<tr><td class="ta_left">웨딩드레스디자인공모전</td><td>특선</td><td>권*기*</td></tr>
								<tr><td class="ta_left">넥타이디자인공모전</td><td>입선</td><td>이*라, 유*라</td></tr>
								<tr><td class="ta_left">임부복디자인공모전</td><td>입선</td><td>류*은*</td></tr>
								<tr><td class="ta_left">서울 국제일러스트레이션공모전</td><td>입선</td><td>윤*혜*</td></tr>
								<tr><td class="ta_left">아웃도어웨어디자인 공모전</td><td>입선</td><td>박*훈, 이*재 외</td></tr>
								<tr><td class="ta_left">부산국제일러스트레이션공모전</td><td>입선</td><td>강*영, 김*리</td></tr>
								<tr><td class="ta_left">부산국제일러스트레이션공모전</td><td>입선</td><td>나*희, 이*라</td></tr>
								<tr><td class="ta_left">행복디자인공모전 -패션상품디자인부문</td><td>특선</td><td>김*민*</td></tr>
								<tr><td class="ta_left">THINK SAFETY UCC 공모전</td><td>동상</td><td>박*호, 배*미</td></tr>
								<tr><td class="ta_left">CJ 대학생 브랜드디자인 공모전</td><td>특별상</td><td>신*경*</td></tr>
								<tr><td class="ta_left">CJ 대학생 브랜드디자인 공모전</td><td>특선</td><td>오*빈, 최*선</td></tr>
								<tr><td class="ta_left">CJ 대학생 브랜드디자인 공모전</td><td>입선</td><td>정*도, 김*수 외</td></tr>
								<tr><td class="ta_left">CJ 대학생 브랜드디자인 공모전</td><td>입선</td><td>임*규, 이*훈 외</td></tr>
								<tr><td class="ta_left">CJ 대학생 브랜드디자인 공모전</td><td>입선</td><td>조*영, 김*희 외</td></tr>
								<tr><td class="ta_left">맘스터치 “먹스코리아” UCC 공모전</td><td>우수상</td><td>김*래*</td></tr>
								<tr><td class="ta_left">패션상품기획콘테스트</td><td>장려상</td><td>양*정*</td></tr>
								<tr><td class="ta_left">넥타이 디자인 공모전</td><td>특선</td><td>우*희*</td></tr>
								<tr><td class="ta_left">넥타이 디자인 공모전</td><td>입선</td><td>정*진*</td></tr>
								<tr><td class="ta_left">넥타이 디자인 공모전</td><td>입선</td><td>조*빛*</td></tr>
								<tr><td class="ta_left">넥타이 디자인 공모전</td><td>입선</td><td>채*민*</td></tr>
								<tr><td class="ta_left">YDP 일러스트레이션 공모전</td><td>입선</td><td>김*지*</td></tr>
								<tr><td class="ta_left">YDP 일러스트레이션 공모전</td><td>입선</td><td>문*수*</td></tr>
								<tr><td class="ta_left">YDP 일러스트레이션 공모전</td><td>입선</td><td>최*영*</td></tr>
								<tr><td class="ta_left">YDP 일러스트레이션 공모전</td><td>입선</td><td>최*정*</td></tr>
								<tr><td class="ta_left">YDP 일러스트레이션 공모전</td><td>입선</td><td>최*진*</td></tr>
								<tr><td class="ta_left">부산 국제일러스트레이션 공모전</td><td>특선</td><td>강*영*</td></tr>
								<tr><td class="ta_left">부산 국제일러스트레이션 공모전</td><td>입선</td><td>나*희*</td></tr>
								<tr><td class="ta_left">부산 국제일러스트레이션 공모전</td><td>입선</td><td>조*빛*</td></tr>
								<tr><td class="ta_left">부산 국제일러스트레이션 공모전</td><td>입선</td><td>권*기*</td></tr>
								<tr><td class="ta_left">국제 니트아트 소재 공모전</td><td>특선</td><td>김*이*</td></tr>
								<tr><td class="ta_left">국제 니트아트 소재 공모전</td><td>특선</td><td>서*현*</td></tr>
								<tr><td class="ta_left">국제 니트아트 소재 공모전</td><td>입선</td><td>정*영*</td></tr>
								<tr><td class="ta_left">국제 니트아트 소재 공모전</td><td>입선</td><td>문*수*</td></tr>
								<tr><td class="ta_left">국제 니트아트 소재 공모전</td><td>입선</td><td>승*림*</td></tr>
								<tr><td class="ta_left">국제 니트아트 소재 공모전</td><td>입선</td><td>곽*빈*</td></tr>
								<tr><td class="ta_left">국제 니트아트 소재 공모전</td><td>입선</td><td>장*진*</td></tr>
								<tr><td class="ta_left">한지섬유패션 디자인경진대회 지식경제부</td><td>입선</td><td>문*수*</td></tr>
								<tr><td class="ta_left">한지섬유패션 디자인경진대회 지식경제부</td><td>입선</td><td>이*연*</td></tr>
								<tr><td class="ta_left">국제넥타이디자인공모전</td><td>특선</td><td>김*은*</td></tr>
								<tr><td class="ta_left">국제넥타이디자인공모전</td><td>입선</td><td>안*환*</td></tr>
								<tr><td class="ta_left">국제넥타이디자인공모전</td><td>입선</td><td>최*진*</td></tr>
								<tr><td class="ta_left">제6회 부산 국제 패션일러스트레이션 공모전</td><td>특선</td><td>임*하*</td></tr>
								<tr><td class="ta_left">제6회 부산 국제 패션일러스트레이션 공모전</td><td>특선</td><td>김*은*</td></tr>
								<tr><td class="ta_left">제6회 부산 국제 패션일러스트레이션 공모전</td><td>입선</td><td>최*혜*</td></tr>
								<tr><td class="ta_left">YDP 패션일러스트레이션 공모전</td><td>특선</td><td>김*리*</td></tr>
								<tr><td class="ta_left">YDP 패션일러스트레이션 공모전</td><td>특선</td><td>안*솔*</td></tr>
								<tr><td class="ta_left">국제니팅아트디자인 공모전</td><td>소재부문 입선</td><td>류*은*</td></tr>
								<tr><td class="ta_left">국제니팅아트디자인 공모전</td><td>소재부문 입선</td><td>염*주*</td></tr>
								<tr><td class="ta_left">국제니팅아트디자인 공모전</td><td>소재부문 입선</td><td>양*윤*</td></tr>
								<tr><td class="ta_left">국제니팅아트디자인 공모전</td><td>소재부문 입선</td><td>이*진*</td></tr>
								<tr><td class="ta_left">국제니팅아트디자인 공모전</td><td>소재부문 입선</td><td>이*라*</td></tr>
								<tr><td class="ta_left">국제니팅아트디자인 공모전</td><td>소재부문 입선</td><td>이*희*</td></tr>
								<tr><td class="ta_left">국제니팅아트디자인 공모전</td><td>소재부문 특선</td><td>우*희*</td></tr>
								<tr><td class="ta_left">농업농촌 PRDP UCC공모전</td><td>최우수상</td><td>박*준, 서*우 외</td></tr>
								<tr><td class="ta_left">the 5th korea beauty health society international beauty art exhibition</td><td>대상</td><td>김*민*</td></tr>
								<tr><td class="ta_left">the 6th korea beauty health society international beauty art exhibition</td><td>은상</td><td>김*정*</td></tr>
								<tr><td class="ta_left">the 7th korea beauty health society international beauty art exhibition</td><td>우수상</td><td>박*미*</td></tr>
								<tr><td class="ta_left">the 8th korea beauty health society international beauty art exhibition</td><td>우수상</td><td>김*민*</td></tr>
								<tr><td class="ta_left">the 9th korea beauty health society international beauty art exhibition</td><td>우수상</td><td>최*영*</td></tr>
								<tr><td class="ta_left">the 10th korea beauty health society international beauty art exhibition</td><td>우수상</td><td>권*리*</td></tr>
								<tr><td class="ta_left">the 11th korea beauty health society international beauty art exhibition</td><td>우수상</td><td>맹*영*</td></tr>
								<tr><td class="ta_left">the 12th korea beauty health society international beauty art exhibition</td><td>우수상</td><td>김*진*</td></tr>
								<tr><td class="ta_left">안산대학교총장배 제 5회 전국미용 공모전</td><td>대상</td><td>한*지*</td></tr>
								<tr><td class="ta_left">안산대학교총장배 제 5회 전국미용 공모전</td><td>금상</td><td>백*희*</td></tr>
								<tr><td class="ta_left">안산대학교총장배 제 5회 전국미용 공모전</td><td>우수상</td><td>박*진*</td></tr>
								<tr><td class="ta_left">안산대학교총장배 제 5회 전국미용 공모전</td><td>우수상</td><td>김*선*</td></tr>
								<tr><td class="ta_left">안산대학교총장배 제 5회 전국미용 공모전</td><td>우수상</td><td>최*옥*</td></tr>
								<tr><td class="ta_left">안산대학교총장배 제 5회 전국미용 공모전</td><td>우수상</td><td>변*정*</td></tr>
								<tr><td class="ta_left">안산대학교총장배 제 5회 전국미용 공모전</td><td>우수상</td><td>김*혜*</td></tr>
								<tr><td class="ta_left">제4회 미추헤어쇼 미용경연대회 네일아트 부문</td><td>대상</td><td>임*명*</td></tr>
								<tr><td class="ta_left">제4회 미추헤어쇼 미용경연대회 네일아트 부문</td><td>금상</td><td>유*아*</td></tr>
								<tr><td class="ta_left">제4회 미추헤어쇼 미용경연대회 네일아트 부문</td><td>은상</td><td>유*란*</td></tr>
								<tr><td class="ta_left">제8회국제네일디자인컨테스트</td><td>은상</td><td>유*아*</td></tr>
								<tr><td class="ta_left">제8회국제네일디자인컨테스트</td><td>특별상</td><td>엄*비*</td></tr>
								<tr><td class="ta_left">제8회국제네일디자인컨테스트</td><td>그랜드챔피언</td><td>유*란*</td></tr>
								<tr><td class="ta_left">대체미용요법 엑스포 콘테스트</td><td>은상</td><td>임*연*</td></tr>
								<tr><td class="ta_left">전국 일러스트 공모전</td><td>장려상</td><td>이*화*</td></tr>
								<tr><td class="ta_left">제5회 대한민국 국제뷰티문화예술 기능대회 스킨아트부문</td><td>그랑프리</td><td>강*옥*</td></tr>
								<tr><td class="ta_left">제5회 대한민국 국제뷰티문화예술 기능대회 스킨아트부문</td><td>대상</td><td>엄*비*</td></tr>
								<tr><td class="ta_left">식품첨가물 바로알기 UCC,POSTER 공모전</td><td>최우수상</td><td>전*연, 이*경</td></tr>
								<tr><td class="ta_left">식품첨가물 바로알기 UCC,POSTER 공모전</td><td>우수상</td><td>이*은, 윤*수</td></tr>
								<tr><td class="ta_left">식품첨가물 바로알기 UCC,POSTER 공모전</td><td>장려상</td><td>최*재, 김*윤</td></tr>
								<tr><td class="ta_left">제2회 아웃도어웨어디자인 공모전</td><td>장려상</td><td>서*현*</td></tr>
								<tr><td class="ta_left">제2회 아웃도어웨어디자인 공모전</td><td>특선</td><td>이*이*</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>장려상</td><td>정*주*</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>장려상</td><td>정*림, 차*철</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>장려상</td><td>이*연*</td></tr>
								<tr><td class="ta_left">제7회 한국 공간 디자인대전</td><td>특별상</td><td>허*운, 남*주</td></tr>
								<tr><td class="ta_left">제7회 한국 공간 디자인대전</td><td>특선</td><td>백*림*</td></tr>
								<tr><td class="ta_left">제7회 한국 공간 디자인대전</td><td>장려상</td><td>손*수*</td></tr>
								<tr><td class="ta_left">제3회 JW중외 영아트 어워드 공모전</td><td>장려상</td><td>백*재*</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>장려상</td><td>나*영*</td></tr>
								<tr><td class="ta_left">제7회 한국 공간 디자인대전</td><td>우수상</td><td>윤*니, 문*솔</td></tr>
								<tr><td class="ta_left">제13회 싼타페 광고 공모전 인쇄 광고부문</td><td>입선</td><td>김*란, 윤*늘</td></tr>
								<tr><td class="ta_left">행복디자인공모전 -패션상품디자인부문</td><td>특선</td><td>우*희*</td></tr>
								<tr><td class="ta_left">국제니팅아트디자인 공모전</td><td>소재부문 입선</td><td>나*희*</td></tr>
								<tr><td class="ta_left">제17회 전통문양디자인공모전</td><td>장려상</td><td>최*정*</td></tr>
								<tr><td class="ta_left">제17회 전통문양디자인공모전</td><td>특선</td><td>정*연*</td></tr>
								<tr><td class="ta_left">제17회 전통문양디자인공모전</td><td>특선</td><td>고*재*</td></tr>
								<tr><td class="ta_left">제17회 전통문양디자인공모전</td><td>특선</td><td>김*경*</td></tr>
								<tr><td class="ta_left">제1회 에비수 IDEA UCC 광고공모전</td><td>우수상</td><td>김*식, 김*현</td></tr>
								<tr><td class="ta_left">새 우편번호 알리기 UCC&로고송 공모전</td><td>동상</td><td>김*야, 노*정 외</td></tr>
								<tr><td class="ta_left">헌법사랑 공모전</td><td>은상</td><td>오*택, 박*연 외</td></tr>
								<tr><td class="ta_left">화폐사랑 UCC 공모전</td><td>장려상</td><td>전*연*</td></tr>
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