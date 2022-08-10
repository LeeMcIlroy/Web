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
						<c:param name="dept1" value="한디원 소개"/>
						<c:param name="dept2" value="공모전 수상"/>
					</c:import>
						<div class="top_tab type_li2">
						<ul>
							<li <c:if test="${searchVO.menuType eq '0601' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/community/proud/proudList.do'/>">한디원 이슈</a></li>
							<li <c:if test="${menuType eq '0702' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/community/exhibit.do'/>">공모전 수상</a></li>
						</ul>
					</div>
					<div class="s_tit">주요공모전 수상현황</div>
					<div class="sub_cont_box">
						<div class="emp_icon">
							<ul class="exh">
								<li>
									<dl>
										<dt>뉴욕 그라피스 애뉴얼</dt>
										<dd>
											<p>2022 뉴욕 그라피스 애뉴얼</p>
											<p>Gold, Silver</p>
											<a href="<c:out value='${pageContext.request.contextPath }/usr/community/proud/proudView.do?cbSeq=17903'/>" target="_blank" title="[새창]뉴욕 그라피스 애뉴얼로 이동합니다.">바로가기</a>
										</dd>
									</dl>
								</li>
								<li>
									<dl>
										<dt>IDA 디자인 어워드</dt>
										<dd>
											<p>IDA 디자인 어워드 2021</p>
											<p>Gold, Silver, Bronze</p>
											<a href="<c:out value='${pageContext.request.contextPath }/usr/community/proud/proudView.do?cbSeq=17635'/>" target="_blank" title="[새창]IDA 디자인 어워드로 이동합니다.">바로가기</a>										</dd>
									</dl>
								</li>
								<li>
									<dl>
										<dt>iF 디자인 탤런트 어워드 2020</dt>
										<dd>
											<p>iF 디자인 탤런트 어워드 2020</p>
											<p>Best of the Year</p>
											<a href="<c:out value='${pageContext.request.contextPath }/usr/community/proud/proudView.do?cbSeq=15179'/>" target="_blank" title="[새창] iF 디자인 탤런트 어워드 2020으로 이동합니다.">바로가기</a>
										</dd>
									</dl>
								</li>
								<li>
									<dl>
										<dt>크리에이티비티 인터내셔널 어워드</dt>
										<dd>
											<p>제51회 크리에이티비티 인터내셔널 어워즈</p>
											<p>Gold, Bronze</p>
											<a href="https://edubank.hansung.ac.kr/usr/community/exhibit.do " target="_blank" title="[새창]크리에이티비티 인터내셔널 어워드로 이동합니다.">바로가기</a>
											<!--<a href="<c:out value='${pageContext.request.contextPath }/usr/community/proud/proudView.do?cbSeq=14300'/>" target="_blank" title="[새창]크리에이티비티 인터내셔널 어워드로 이동합니다.">바로가기</a>-->
										</dd>
									</dl>
								</li>
								<%-- <li>
									<dl>
										<dt>서울디자인페스티벌</dt>
										<dd>
											<p>제18회 서울디자인페스티벌</p>
											<p>2019 영 디자이너 프로모션 선정</p>
											<a href="<c:out value='${pageContext.request.contextPath }/usr/community/proud/proudView.do?cbSeq=14414'/>" target="_blank" title="[새창]서울디자인페스티벌로 이동합니다.">바로가기</a>										</dd>
									</dl>
								</li> --%>
								<%-- <li>
									<dl>
										<dt>성북구</dt>
										<dd>
											<p>청춘불패 단편영화 특별전</p>
											<p>특별 상영작 선정</p>
											<a href="<c:out value='${pageContext.request.contextPath }/usr/community/proud/proudView.do?cbSeq=13747'/>" target="_blank" title="[새창]청춘불패 단편영화 특별전으로 이동합니다.">바로가기</a>
										</dd>
									</dl>
								</li> --%>
							</ul>
						</div>
					</div>
					<div class="s_tit" style="margin-top:30px;">전체 수상현황</div>
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
								<!-- 2022.04.07 에이드 이형종 추가 - start  -->
								<tr><td>2022 뉴욕 그라피스 뉴탈랜트 애뉴얼</td><td>Gold</td><td>권*현, 김*진, 최*후 팀  외 </td></tr>
								<tr><td>2022 뉴욕 그라피스 뉴탈랜트 애뉴얼</td><td>Silver</td><td>김*현, 박*은, 신*지 외 </td></tr>
								<tr><td>2022 뉴욕 그라피스 뉴탈랜트 애뉴얼</td><td>Finalist</td><td>이*정, 이*연, 김*민 외  </td></tr>
								<tr><td>The 15th International Design Awards</td><td>Gold</td><td>최*후, 권*현, 김*진 팀 외 </td></tr>
								<tr><td>The 15th International Design Awards</td><td>Silver</td><td>최*후, 권*현, 김*진 팀 외</td></tr>
								<tr><td>The 15th International Design Awards</td><td>Bronze </td><td>김*민, 한*빈 팀 , 이*정 외 </td></tr>
								<tr><td>2021 부산국제광고제</td><td>Bronze </td><td>김*규,김*훈,박*협,이*은 팀  </td></tr>
								<tr><td>2021 부산국제광고제</td><td>Crystal Star </td><td>김*규,김*훈,박*협,이*은 팀 </td></tr>
								<tr><td>2021 Blue Awards 상품문화디자인 국제공모전</td><td>Silver</td><td>박*연, 이*정 팀</td></tr>
								<tr><td>2021 대학민국 대학생 패키징 공모전</td><td>장려상</td><td>송*영, 엄*연 팀</td></tr>
								<tr><td>2021 뉴욕 그라피스 뉴탈랜트 애뉴얼</td><td>Platinum </td><td>한*희 </td></tr>
								<tr><td>2021 뉴욕 그라피스 뉴탈랜트 애뉴얼</td><td>Gold  </td><td>문*영, 김*진</td></tr>
								<tr><td>2021 뉴욕 그라피스 뉴탈랜트 애뉴얼</td><td>Silver</td><td>한*민, 손*정, 김*지 외</td></tr>
								<tr><td>The 14th International Design Awards</td><td>Bronze </td><td>김*현</td></tr>
								<tr><td>2020 미국 크리에이티비티 인터내셔널 어워즈</td><td>Sirver  </td><td>김*현, 이*은, 임*현 팀 외 </td></tr>
								<tr><td>2020 미국 크리에이티비티 인터내셔널 어워즈</td><td>Bronze </td><td>박*경, 신*연, ,양*민 팀 외  </td></tr>
								<!-- 2019.12.02 celldio 김현영 추가 - start  -->
								<tr><td>iF 디자인 탤런트 어워드 2020</td><td>Best of the Year</td><td>현 * 주, 김 * 영 팀</td></tr>
								<tr><td>2020 뉴욕 그라피스 뉴탈랜트 애뉴얼</td><td> Platinum</td><td>신 * 희</td></tr>
								<tr><td>2020 뉴욕 그라피스 뉴탈랜트 애뉴얼</td><td>Gold </td><td> 김 * 윤, 김 * 필 팀</td></tr>
								<tr><td>2020 뉴욕 그라피스 뉴탈랜트 애뉴얼</td><td>Silver </td><td>김 * 희, 강 * 수 팀</td></tr>
								<tr><td>2019 미국 크리에이티비티 인터내셔널 어워즈</td><td>Platinum</td><td>신 * 희</td></tr>
								<tr><td>2019 미국 크리에이티비티 인터내셔널 어워즈</td><td>Gold</td><td>김 * 지 팀, 이 * 영 팀</td></tr>
								<tr><td>2019 미국 크리에이티비티 인터내셔널 어워즈</td><td>Bronze</td><td>강 * 수, 김 * 팀</td></tr>
								<tr><td>2019 아시아대학생 패키지디자인 공모전</td><td>Merit</td><td>김 * 지 팀 </td></tr>
								<tr><td>2019 부산국제광고제</td><td>Finalist</td><td>황 * 연 팀, 강 * 수</td></tr>
								<tr><td>2019 금융소비자권리찾기 크리에이터 공모전</td><td>대상(NH농협은행장상)</td><td>신 * 서</td></tr>
								<tr><td>2019 장례문화인식개선 컨텐츠 공모전</td><td>우수상(한국장례문화진흥원상)</td><td>송 * 연, 안 * 솔 외 </td></tr>
								<tr><td>2019 특허 출원</td><td>특허 취득</td><td>박 * 정 </td></tr>
								<tr><td>중소벤처기업부 예비창업패키지</td><td>창업지원금 최대금액 선정(1억원)</td><td>문 * 지</td></tr>
								<tr><td>문화역서울284 전시지원공모사업</td><td>전시지원사업 선정(886만원)</td><td>서 * 미, 이 * 희 외</td></tr>
								<tr><td>2019 서울디자인페스티벌</td><td>영디자이너 선정(3명)</td><td>이 * 희, 최 * 경 외</td></tr>
								<tr><td>2019 생활발명코리아 </td><td>지원사업 선정</td><td>문 * 지</td></tr>
								<tr><td>2019 Asia Design Prize</td><td>Finalist</td><td>박 * 정</td></tr>
								<tr><td>제7회 소방산업 우수 디자인 공모전</td><td>한국소방산업기술원장상</td><td>김 * 지</td></tr>
								<tr><td>제7회 대한민국 국가상징 디자인 공모전</td><td>조달청장상</td><td>박 * 우</td></tr>
								<tr><td>2019 약수동해장음료 영상 아이디어 공모전</td><td>3등상</td><td>이 * 민, 신 * 서 외</td></tr>
								<tr><td>2019 양평용문산 산나물 축제 홍보UCC공모전</td><td>우수상</td><td>김 * 진</td></tr>
								<tr><td>청춘불패 단편영화 특별전</td><td>상영작 선정</td><td>박 * 형 팀, 한 * 화</td></tr>
								<tr><td>제1회 샵#서울떡볶이 UCC공모전</td><td>우수상</td><td>김 * 진</td></tr>
								<tr><td>제5회 연안안전 공모전</td><td>우수상(2등상)</td><td>윤 * 영</td></tr>
								<tr><td>2019 뉴욕 그라피스 뉴탈랜트 애뉴얼</td><td> Platinum</td><td>김 * 지, 김 * 빈 팀 외</td></tr>
								<tr><td>2019 뉴욕 그라피스 뉴탈랜트 애뉴얼</td><td>Gold </td><td>전 * 린, 강 * 현 외</td></tr>
								<tr><td>2019 뉴욕 그라피스 뉴탈랜트 애뉴얼</td><td>Silver </td><td>장 * 우, 전 * 경 외</td></tr>
								<tr><td>제11회 공간디자인대전</td><td>은상</td><td>라 * 래 팀</td></tr>
								<tr><td>제11회 공간디자인대전</td><td>우수상</td><td>이 * 정</td></tr>
								<tr><td>제11회 공간디자인대전</td><td>장려상</td><td>강 * 수 팀, 지 * 지</td></tr>
								<tr><td>제21회 KVMD 디자인 공모전 </td><td>KVMD 회장상</td><td>이 * 윤</td></tr>
								<tr><td>제21회 KVMD 디자인 공모전 </td><td>특선</td><td>라 * 래, 동 * 은</td></tr>
								<tr><td>2018 DDP 영디자이너 챌린지</td><td>6개 작품 선정</td><td>이 * 은, 조 * 혜 외</td></tr>
								<tr><td>2018 DGID 실내건축디자인대전</td><td>특선</td><td>조 * 혜</td></tr>
								<tr><td>2018 DGID 실내건축디자인대전</td><td>장려상</td><td>지 * 지, 이 * 희 외</td></tr>
								<tr><td>2018 한국실내디자인학회 주제공모전</td><td>특선</td><td>김 * 영 팀</td></tr>
								<tr><td>2018 한국실내디자인학회 주제공모전</td><td>입선</td><td>김 * 민 팀</td></tr>
								<tr><td>2018 한국인테리어대전</td><td>장려상</td><td>이 * 비 팀</td></tr>
								<tr><td>2018 한국인테리어대전</td><td>입선</td><td>김 * 수, 류 * 혁 외</td></tr>
								<tr><td>2018 대한민국 디자인전람회</td><td>Finalist</td><td>이 * 희 팀</td></tr>
								<tr><td>2018 행복디자인 공모전</td><td>장려상</td><td>송 * 린, 이 * 헌 외</td></tr>
								<tr><td>2018 행복디자인 공모전</td><td>특선</td><td>김 * 찬, 강 * 재 외</td></tr>
								<tr><td> 2018 안전디자인 공모전 </td><td>장려상</td><td>황 * 연, 김 * 현</td></tr>
								<tr><td> 2018 안전디자인 공모전 </td><td>특별상</td><td>박 * 영, 김 * 영 외</td></tr>
								<tr><td>관악현대미술대전</td><td>장려상</td><td>문 * 지, 이 * 주 </td></tr>
								<tr><td>관악현대미술대전</td><td>특선</td><td>문 * 우, 박 * 정</td></tr>
								<tr><td>2018 서울디자인페스티벌</td><td>영디자이너 선정(4명) </td><td>박 * 진, 정 * 지 외</td></tr>
								<tr><td> 2018 부산국제광고제</td><td>Crystal Star</td><td>홍 * 림 팀</td></tr>
								<tr><td> 2018 부산국제광고제</td><td>Finalist</td><td>박 * 선 팀, 김 * 율</td></tr>
								<tr><td>서울시와 함께하는 2018 상상패션런웨이  </td><td>동상</td><td>박 * 민 팀</td></tr>
								<tr><td>2018 제로웨이스트패션디자인 공모전 </td><td>금상</td><td>박 * 민 </td></tr>
								<tr><td>2018 제로웨이스트패션디자인 공모전 </td><td>특선</td><td>김 * 지 </td></tr>
								<tr><td>2018 케이브랜드 ‘GU’ 데님 콘테스트</td><td>특별상 </td><td>김 * 락</td></tr>
								<tr><td>2018 케이브랜드 ‘GU’ 데님 콘테스트</td><td>장려상</td><td>문 * 정</td></tr>
								<tr><td>CLO Creative Challenge 공모전</td><td>우수상</td><td>김 * 혜</td></tr>
								<tr><td>CLO Creative Challenge 공모전</td><td>장려상</td><td>강 * 현, 이 * 희 외</td></tr>
								<tr><td>CLO Creative Challenge 공모전</td><td>특선</td><td>김 * 주, 이 * 련</td></tr>
								<tr><td>CLO Creative Challenge 공모전</td><td>입선</td><td>김 * 인, 나 * 윤 외</td></tr>
								<tr><td>제5회 서울국제일러스트공모전 </td><td>입선</td><td>김 * 연, 백 * 연</td></tr>
								<tr><td>강남신진디자이너 공모전</td><td>본선 진출</td><td>우 * 현</td></tr>
								<tr><td>2019 제로웨이스트패션디자인 공모전</td><td>동상</td><td>양 * 후</td></tr>
								<tr><td>2019 케이브랜드 ‘NIX’ 데님 콘테스트</td><td>특별상</td><td>김 * 락</td></tr>
								<tr><td>2019 케이브랜드 ‘NIX’ 데님 콘테스트</td><td>장려상</td><td>강 * 민</td></tr>
								<tr><td>제8회 국제 디지털 패션 콘테스트</td><td>장려상</td><td>이 * 련, 이 * 은</td></tr>
								<tr><td>제8회 국제 디지털 패션 콘테스트</td><td>특선</td><td>신 * 은, 이 * 솔 외</td></tr>
								<tr><td>제8회 국제 디지털 패션 콘테스트</td><td>입선</td><td>기 * 찬, 신 * 빈</td></tr>
								<tr><td>2019 한국의류학회 패션상품기획 콘테스트</td><td>장려상</td><td>이 * 희, 홍 * 진</td></tr>
								<tr><td>2018 미국 크리에이티비티 인터내셔널 어워즈</td><td>Gold </td><td>신 * 희</td></tr>
								<tr><td>2018 미국 크리에이티비티 인터내셔널 어워즈</td><td>Silver </td><td>김 * 윤, 박 * 미 외</td></tr>
								<tr><td>2018 미국 크리에이티비티 인터내셔널 어워즈</td><td>Bronze</td><td>박 * 서, 이 * 정 외</td></tr>
								<tr><td>2018 뉴욕 그라피스 뉴탈랜트 애뉴얼</td><td> Platinum</td><td>김 * 비, 장 * 준</td></tr>
								<tr><td>2018 뉴욕 그라피스 뉴탈랜트 애뉴얼</td><td>Gold </td><td>하 * 현, 이 * 원 외</td></tr>
								<tr><td>2018 뉴욕 그라피스 뉴탈랜트 애뉴얼</td><td>Silver </td><td>유 * 아, 안 * 환 외</td></tr>
								<tr><td> 2018 뉴욕 그라피스 포스터 어워드</td><td>Merit</td><td>정 * 라</td></tr>
								<tr><td>2018 스파크 디자인 어워드</td><td>Finalist</td><td>박 * 정</td></tr>
								<tr><td> 2018 핀업 콘셉트 디자인 어워드</td><td>Finalist</td><td>박 * 정</td></tr>
								<tr><td>2017 미국 크리에이티비티 인터내셔널 어워즈</td><td>Bronze</td><td>한 * 희</td></tr>
								<tr><td> 2017 K-DESIGN International Award</td><td>Winner</td><td>이 * 희</td></tr>
								<tr><td>KTV 평창동계올림픽 콘텐츠 공모전</td><td>우수상(한국정책방송원장상)</td><td>강 * 결 팀</td></tr>
								<tr><td>제1회 세계시민 UCC콘텐츠 공모전</td><td>대상(중앙선거관리위원장상)</td><td>고 * 미 팀</td></tr>
								<tr><td>제8회 나부터 시작하는 지식재산보호 국민공모전</td><td>특허청장상</td><td>이 * 훈</td></tr>
								<tr><td>제13회 생명의 빛 공해의 빛 빛공해 사진‧UCC공모전</td><td>우수상(조명박물관장상)</td><td>강 * 우 팀</td></tr>
								<tr><td>제2회 친자연적 장례문화 확산을 위한 공모전</td><td>진흥원장상</td><td>이 * 구 팀</td></tr>
								<tr><td>제1회 청춘상하 대학생 사진영상공모전</td><td>대상</td><td>이 * 진</td></tr>
								<tr><td>제10회 공간디자인대전</td><td>금상</td><td>임 * 성 팀</td></tr>
								<tr><td>서울시와 함께하는 2017 상상패션위크 공모전</td><td>대상(서울시장상)</td><td>팀 '하디'(김 * 구 외)</td></tr>
								<tr><td>제35회 대한민국 신미술대전</td><td>대상</td><td>성 * 현</td></tr>
								<tr><td>제35회 대한민국 신미술대전</td><td>우수상</td><td>박 * 나</td></tr>
								<tr><td>제7회 한영텍스타일 공모전</td><td>우수상</td><td>박 * 영</td></tr>
								<tr><td>제5회 서울국제일러스트레이션 공모전</td><td>동상</td><td>박 * 진 외</td></tr>
								<tr><td>제6회 코리아 디지털 패션 콘테스트</td><td>장려상</td><td>김 * 준</td></tr>
								<tr><td>2016 Asia Pacific Design Annual Award</td><td>연감 작품 등재</td><td>정 * 라, 양 * 준</td></tr>
								<tr><td>2016 미국 크리에이티비티 인터내셔널 어워즈</td><td>Platinum</td><td>최 * 훈</td></tr>
								<tr><td>2016 Swizerland Goldrn Award</td><td>Finalist</td><td>최 * 훈</td></tr>
								<tr><td>2016 Cannes future Lions</td><td>Shortist</td><td>최 * 훈</td></tr>
								<tr><td>2016 헌법사랑공모전</td><td>대상(헌법재판소장상)</td><td>오 * 택 팀</td></tr>
								<tr><td>제49회 대한구강보건협회 작품공모전</td><td>대상(보건복지부장관상)</td><td>오 * 택</td></tr>
								<tr><td>제14회 매일신문 광고대상공모전</td><td>대상</td><td>최 * 은 팀</td></tr>
								<tr><td>디지털미디어콘텐츠 공모전</td><td>새정치상</td><td>문 * 석</td></tr>
								<tr><td>서울꿈새김판 문안 공모전</td><td>우수상</td><td>문 * 석</td></tr>
								<tr><td>5th 탐앤탐스 광고공모전</td><td>대상(환경부장관상)</td><td>김 * 서 팀</td></tr>
								<tr><td>2016 부산국제광고제</td><td>Crystal</td><td>최 * 훈</td></tr>
								<tr><td>작가데뷔 프로젝트_당신의 작품을 겁니다</td><td>작가 선발</td><td>유 * 혜</td></tr>
								<tr><td>제3회 서체&디자인상</td><td>동상</td><td>엄 * 림 팀</td></tr>
								<tr><td>국정교과서 반대 콘텐츠공모전</td><td>우수상</td><td>문 * 석</td></tr>
								<tr><td>2016 CACADEW AWARDS</td><td>입선</td><td>김 * 정</td></tr>
								<tr><td>2016 코튼 T-셔츠 프린트 디자이콘텐스트</td><td>입선</td><td>유 * 진</td></tr>
								<tr><td>제7회 양성평등디자인공모전</td><td>은상</td><td>김 * 서</td></tr>
								<tr><td>2016 여객선 안전교육 UCC공모전</td><td>대상</td><td>이 * 호</td></tr>
								<tr><td>2016 제4회 생명사랑 정신건강문화축제</td><td>최우수상</td><td>김 * 수</td></tr>
								<tr><td>제12회 에이즈예방 광고공모전</td><td>최우수상</td><td>권 * 승</td></tr>
								<tr><td>제14회 LH 대학생 광고공모전</td><td>최우수상</td><td>최 * 은, 문 * 혜 외</td></tr>
								<tr><td>서울다반사 공모전</td><td>시민인기상</td><td>이 * 한</td></tr>
								<tr><td>국민참여 KOTRA 홍보 공모전</td><td>우수상</td><td>이 * 규, 조 * 희 외</td></tr>
								<tr><td>국민참여 KOTRA 홍보 공모전</td><td>장려상</td><td>안 * 기, 박 * 희 외</td></tr>
								<tr><td>2016 흡연에티켓 광고공모전</td><td>입선</td><td>최 * 은</td></tr>
								<tr><td>제17회 KVMD 협회 디자인 공모전</td><td>대상</td><td>양 * 서</td></tr>
								<tr><td>공간코디네이션대전</td><td>금상</td><td>김 * 훈, 최 * 경 외</td></tr>
								<tr><td>BIDA 인테리어디자인 공모전</td><td>금상</td><td>정 * 주, 변 * 영 외</td></tr>
								<tr><td>KODIA 디스플레이賞</td><td>금상</td><td>박 * 미</td></tr>
								<tr><td>제6회 한국공간디자인대전</td><td>은상</td><td>허 * 영, 이 * 혁 외</td></tr>
								<tr><td>부산국제문화제 실내건축대전</td><td>은상</td><td>김 * 현, 황 * 윤 외</td></tr>
								<tr><td>Store Design 공모전</td><td>은상</td><td>김 * 솔, 전 * 예</td></tr>
								<tr><td>Store Design 공모전</td><td>동상</td><td>임 * 연</td></tr>
								<tr><td>제17회 KVMD 협회 디자인 공모전</td><td>은상</td><td>유 * 현, 최 * 아</td></tr>
								<tr><td>BIDA 인테리어디자인 공모전</td><td>동상</td><td>한 * 리, 조 * 재 외</td></tr>
								<tr><td>BIDA 인테리어디자인 공모전</td><td>특별상</td><td>장 * 하</td></tr>
								<tr><td>유니버셜디자인공모전</td><td>최우수상</td><td>김 * 이, 석 * 성 외</td></tr>
								<tr><td>대한민국 현대조형 미술대전</td><td>우수상</td><td>정 * 정, 임 * 연</td></tr>
								<tr><td>한국인테리어대전</td><td>장려상</td><td>이 * 석, 주 * 름 외</td></tr>
								<tr><td>차세대문화공간건축상</td><td>장려상</td><td>정 * 환, 김 * 영 외</td></tr>
								<tr><td>국제 청소년 건축설계 공모전</td><td>장려상</td><td>음 * 식, 박 * 호 외</td></tr>
								<tr><td>KDAI 우수작품전시회</td><td>장려상</td><td>정 * 환, 황 * 윤 외</td></tr>
								<tr><td>DGID 실내건축디자인대전</td><td>장려상</td><td>조 * 재, 김 * 영 외</td></tr>
								<tr><td>국제 청소년 건축설계 공모전</td><td>장려상</td><td>김 * 영, 이 * 지</td></tr>
								<tr><td>BIDA 인테리어디자인 공모전</td><td>장려상</td><td>이 * 슬, 정 * 림 외</td></tr>
								<tr><td>DGID 실내건축디자인대전</td><td>장려상</td><td>김 * 영</td></tr>
								<tr><td>공간코디네이션대전</td><td>특별상</td><td>최 * 경, 이 * 단 외</td></tr>
								<tr><td>제3회 한국공간코디네이션</td><td>특별상</td><td>장 * 하, 안 * 슬 외</td></tr>
								<tr><td>전쟁기념관20주년 '추억의사진'공모전</td><td>가작</td><td>윤 * 희</td></tr>
								<tr><td>DGID 실내건축디자인대전</td><td>우수상</td><td>김 * 영, 김 * 성</td></tr>
								<tr><td>DGID 실내건축디자인대전</td><td>특선</td><td>김 * 영, 김 * 민 외</td></tr>
								<tr><td>DGID 실내건축디자인대전</td><td>장려상</td><td>이 * 주, 이 * 영 외</td></tr>
								<tr><td>제9회 차세대문화공간공모전</td><td>장려상</td><td>허 * 운, 남 * 주 외</td></tr>
								<tr><td>제9회 차세대문화공간공모전</td><td>특선</td><td>유 * 현, 주 * 름 외</td></tr>
								<tr><td>제43회 전국대학생디자인 대전</td><td>입선</td><td>이 * 은, 박 * 경</td></tr>
								<tr><td>국제청소년공간대전</td><td>특선</td><td>이 * 지, 김 * 재 외</td></tr>
								<tr><td>제7회 한국 공간 디자인대전</td><td>동상</td><td>김 * 섭, 김 * 빈</td></tr>
								<tr><td>제7회 한국 공간 디자인대전</td><td>장려상</td><td>정 * 현, 김 * 민 외</td></tr>
								<tr><td>제18회 KVMD 협회 디자인공모전</td><td>동상</td><td>서 * 윤, 김 * 재</td></tr>
								<tr><td>제4회 청소년 휴먼 영화제</td><td>대상</td><td>홍 * 욱, 유 * 호 외</td></tr>
								<tr><td>제8회 MTN 대한민국 대학생 광고공모전</td><td>대상</td><td>안 * 영</td></tr>
								<tr><td>제10회 LH 대학생 광고 공모전</td><td>대상</td><td>김 * 비, 심 * 연 외</td></tr>
								<tr><td>SONY 알파 nex 사진 공모전</td><td>대상</td><td>윤 * 늘</td></tr>
								<tr><td>LA우표대전</td><td>금상</td><td>박 * 호, 이 * 아</td></tr>
								<tr><td>저출산 극복 포스터 공모전</td><td>금상</td><td>신 * 식, 한 * 범</td></tr>
								<tr><td>뉴던전 스트라이커 UCC 콘테스트</td><td>은상</td><td>양 * 국</td></tr>
								<tr><td>국제광고제 클리오(CLIO)</td><td>은상</td><td>김 * 욱</td></tr>
								<tr><td>제5회 MTN 대한민국 대학생 광고공모전</td><td>은상</td><td>임 * 이</td></tr>
								<tr><td>제9회 에이즈 예방 대학생 광고공모전 광고기획부문</td><td>은상</td><td>안 * 영</td></tr>
								<tr><td>삼성생명 대학생 공모전 UCC부문</td><td>은상</td><td>김 * 아</td></tr>
								<tr><td>제2회 KB국민카드 꿈꾸는 광고인</td><td>동상</td><td>안 * 영</td></tr>
								<tr><td>제15회 대학생 영남대학교 창업아이디어 경연대회</td><td>최우수상</td><td>이 * 훈</td></tr>
								<tr><td>대학생 신용보증기금 창업아이템 경진대회</td><td>최우수상</td><td>이 * 훈</td></tr>
								<tr><td>희망서울 엑스포 공모전</td><td>최우수상</td><td>양 * 지</td></tr>
								<tr><td>3필착 그림영상 공모전</td><td>우수상</td><td>강 * 수, 이 * 진 외</td></tr>
								<tr><td>함께여는 아름다운 세상 대학생 사회공헌 광고공모전</td><td>우수상</td><td>김 * 성</td></tr>
								<tr><td>㈜나눔로또 대학(원)생 홍보 아이디어 & 포스터 공모전</td><td>우수상</td><td>이 * 범, 한 * 범 외</td></tr>
								<tr><td>블랙스미스 아이디어 공모전</td><td>우수상</td><td>현 * 수</td></tr>
								<tr><td>제11회 LH 대학생 광고 공모전 인쇄 광고부문</td><td>장려상</td><td>안 * 영</td></tr>
								<tr><td>글로벌 게임제작 경진대회</td><td>장려상</td><td>유 * 호, 홍 * 욱</td></tr>
								<tr><td>NH농협대학생광고공모전</td><td>장려상</td><td>문 * 이</td></tr>
								<tr><td>제1회 대한민국 인포그래픽 어워드</td><td>특별상</td><td>박 * 은, 김 * 민 외</td></tr>
								<tr><td>LA우표대전</td><td>특선</td><td>김 * 주, 정 * 혁</td></tr>
								<tr><td>제3회 JW중외 영아트 어워드 공모전 일러스트레이션부문</td><td>특선</td><td>차 * 철, 김 * 웅</td></tr>
								<tr><td>제11회 매일신문 광고대상 인쇄 광고부문</td><td>입선</td><td>신 * 식, 이 * 범</td></tr>
								<tr><td>희망서울 엑스포 공모전</td><td>입선</td><td>강 * 지</td></tr>
								<tr><td>제1회 대한민국 인포그래픽 어워드</td><td>입선</td><td>김 * 훈, 한 * 홍 외</td></tr>
								<tr><td>대학(원)생 사회공헌 광고 공모전</td><td>우수상</td><td>김 * 성</td></tr>
								<tr><td>샘표간장 노래자랑 UCC</td><td>너무프로상</td><td>김 * 래</td></tr>
								<tr><td>커뮤니케이션디자인국제공모전</td><td>입선</td><td>이 * 연</td></tr>
								<tr><td>제4회 비만예방디자인공모전</td><td>입선</td><td>이 * 희, 이 * 원 외</td></tr>
								<tr><td>신용보증기금 대학생 광고공모전</td><td>장려상</td><td>김 * 성, 이 * 범 외</td></tr>
								<tr><td>안전보건 UCC공모전</td><td>입선</td><td>양 * 국</td></tr>
								<tr><td>제7회 즐거운환경UCC공모전</td><td>우수상</td><td>박 * 은, 조 * 은</td></tr>
								<tr><td>헌혈 공모전</td><td>생명나눔상</td><td>박 * 호, 이 * 아 외</td></tr>
								<tr><td>광동제약 헛개차 ucc공모전</td><td>최우수상</td><td>박 * 영, 박 * 준</td></tr>
								<tr><td>바이오아트 콘테스트</td><td>입선</td><td>양 * 국</td></tr>
								<tr><td>광주광역시 안전UCC 공모전</td><td>안전상</td><td>이 * 호, 김 * 림</td></tr>
								<tr><td>첼로 UCC CONTEST</td><td>우수상</td><td>최 * 민, 이 * 호 외</td></tr>
								<tr><td>국립국악원UCC공모전</td><td>우수상</td><td>박 * 열, 최 * 우 외</td></tr>
								<tr><td>가스안전 디자인공모전</td><td>입선</td><td>박 * 나</td></tr>
								<tr><td>THINK SAFETY UCC공모전</td><td>동상</td><td>박 * 호, 배 * 미</td></tr>
								<tr><td>전문병원홍보물 공모전</td><td>금상</td><td>최 * 우, 박 * 연</td></tr>
								<tr><td>인천광역시 치매인식개선 사진 및 UCC 공모전</td><td>장려상</td><td>김 * 림, 서 * 주</td></tr>
								<tr><td>아주특별한나눔BI공모전</td><td>입선</td><td>오 * 빈</td></tr>
								<tr><td>UGIZ 1ST 티셔츠 그래픽디자인공모전</td><td>최우수상</td><td>신 * 경</td></tr>
								<tr><td>디자인레이스 프리스타일 디자인아트 공모전</td><td>우수상</td><td>주 * 림</td></tr>
								<tr><td>대한민국 지역특산 명품브랜드 공모전</td><td>한국지역진흥재단이사장상</td><td>이 * 호, 채 * 병 외</td></tr>
								<tr><td>첼로 UCC CONTEST</td><td>우수상</td><td>최 * 민, 이 * 호 외</td></tr>
								<tr><td>제2회 대학생 그림책 공모전</td><td>입선</td><td>홍 * 수</td></tr>
								<tr><td>제1회 얼바인 아웃도어웨어 디자인 공모전</td><td>최우수상</td><td>임 * 하, 김 * 은</td></tr>
								<tr><td>제1회 Yo-콘테스트 유니폼디자인 공모전</td><td>금상</td><td>권 * 라</td></tr>
								<tr><td>제2회 아웃도어웨어디자인 공모전</td><td>장려상</td><td>배 * 린, 이 * 형</td></tr>
								<tr><td>YDP 패션일러스트레이션 공모전</td><td>입선</td><td>김 * 은, 김 * 우</td></tr>
								<tr><td>해외인턴쉽개발 국비지원프로그램</td><td>미국 국비지원 장학생 선발</td><td>이 * 이</td></tr>
								<tr><td>패션상품기획콘테스트</td><td>장려상</td><td>조 * 비, 양 * 정</td></tr>
								<tr><td>웨딩드레스디자인공모전</td><td>특선</td><td>권 * 기</td></tr>
								<tr><td>넥타이디자인공모전</td><td>입선</td><td>이 * 라, 유 * 라</td></tr>
								<tr><td>임부복디자인공모전</td><td>입선</td><td>류 * 은</td></tr>
								<tr><td>서울 국제일러스트레이션공모전</td><td>입선</td><td>윤 * 혜</td></tr>
								<tr><td>아웃도어웨어디자인 공모전</td><td>입선</td><td>박 * 훈, 이 * 재 외</td></tr>
								<tr><td>부산국제일러스트레이션공모전</td><td>입선</td><td>강 * 영, 김 * 리</td></tr>
								<tr><td>행복디자인공모전 -패션상품디자인부문</td><td>특선</td><td>김 * 민</td></tr>
								<tr><td>THINK SAFETY UCC 공모전</td><td>동상</td><td>박 * 호, 배 * 미</td></tr>
								<tr><td>CJ 대학생 브랜드디자인 공모전</td><td>특별상</td><td>신 * 경</td></tr>
								<tr><td>CJ 대학생 브랜드디자인 공모전</td><td>특선</td><td>오 * 빈, 최 * 선</td></tr>
								<tr><td>CJ 대학생 브랜드디자인 공모전</td><td>입선</td><td>정 * 도, 김 * 수 외</td></tr>
								<tr><td>맘스터치 “먹스코리아” UCC 공모전</td><td>우수상</td><td>김 * 래</td></tr>
								<tr><td>패션상품기획콘테스트</td><td>장려상</td><td>양 * 정</td></tr>
								<tr><td>넥타이 디자인 공모전</td><td>특선</td><td>우 * 희</td></tr>
								<tr><td>YDP 일러스트레이션 공모전</td><td>입선</td><td>김 * 지 외</td></tr>
								<tr><td>부산 국제일러스트레이션 공모전</td><td>특선</td><td>강 * 영</td></tr>
								<tr><td>부산 국제일러스트레이션 공모전</td><td>입선</td><td>나 * 희 외</td></tr>
								<tr><td>국제 니트아트 소재 공모전</td><td>특선</td><td>김 * 이, 서 * 현</td></tr>
								<tr><td>국제 니트아트 소재 공모전</td><td>입선</td><td>정 * 영, 문 * 수 외</td></tr>
								<tr><td>국제넥타이디자인공모전</td><td>특선</td><td>김 * 은</td></tr>
								<tr><td>국제넥타이디자인공모전</td><td>입선</td><td>안 * 환</td></tr>
								<tr><td>제6회 부산 국제 패션일러스트레이션 공모전</td><td>특선</td><td>임 * 하, 김 * 은</td></tr>
								<tr><td>제6회 부산 국제 패션일러스트레이션 공모전</td><td>입선</td><td>최 * 혜</td></tr>
								<tr><td>YDP 패션일러스트레이션 공모전</td><td>특선</td><td>김 * 리, 안 * 솔</td></tr>
								<tr><td>국제니팅아트디자인 공모전</td><td>소재부문 입선</td><td>류 * 은, 염 * 주 외</td></tr>
								<tr><td>농업농촌 PRDP UCC공모전</td><td>최우수상</td><td>박 * 준, 서 * 우 외</td></tr>
								<tr><td>안산대학교총장배 제5회 전국미용 공모전</td><td>대상</td><td>한 * 지</td></tr>
								<tr><td>안산대학교총장배 제5회 전국미용 공모전</td><td>금상</td><td>백 * 희</td></tr>
								<tr><td>안산대학교총장배 제5회 전국미용 공모전</td><td>우수상</td><td>박 * 진 외</td></tr>
								<tr><td>제4회 미추헤어쇼 미용경연대회 네일아트 부문</td><td>대상</td><td>임 * 명</td></tr>
								<tr><td>제4회 미추헤어쇼 미용경연대회 네일아트 부문</td><td>금상</td><td>유 * 아</td></tr>
								<tr><td>제4회 미추헤어쇼 미용경연대회 네일아트 부문</td><td>은상</td><td>유 * 란</td></tr>
								<tr><td>제8회 국제네일디자인컨테스트</td><td>그랜드챔피언</td><td>유 * 란</td></tr>
								<tr><td>제8회 국제네일디자인컨테스트</td><td>은상</td><td>유 * 아</td></tr>
								<tr><td>제8회 국제네일디자인컨테스트</td><td>특별상</td><td>엄 * 비</td></tr>
								<tr><td>대체미용요법 엑스포 콘테스트</td><td>은상</td><td>임 * 연</td></tr>
								<tr><td>전국 일러스트 공모전</td><td>장려상</td><td>이 * 화</td></tr>
								<tr><td>제5회 대한민국 국제뷰티문화예술 기능대회 스킨아트부문</td><td>그랑프리</td><td>강 * 옥</td></tr>
								<tr><td>제5회 대한민국 국제뷰티문화예술 기능대회 스킨아트부문</td><td>대상</td><td>엄 * 비</td></tr>
								<tr><td>식품첨가물 바로알기 UCC,POSTER 공모전</td><td>최우수상</td><td>전 * 연, 이 * 경</td></tr>
								<tr><td>식품첨가물 바로알기 UCC,POSTER 공모전</td><td>우수상</td><td>이 * 은, 윤 * 수</td></tr>
								<tr><td>식품첨가물 바로알기 UCC,POSTER 공모전</td><td>장려상</td><td>최 * 재, 김 * 윤</td></tr>
								<tr><td>새 우편번호 알리기 UCC & 로고송 공모전</td><td>동상</td><td>김 * 야, 노 * 정 외</td></tr>
								<tr><td>제1회 에비수 IDEA UCC 광고공모전</td><td>우수상</td><td>김 * 식, 김 * 현</td></tr>
								<tr><td>제2회 아웃도어웨어디자인 공모전</td><td>장려상</td><td>서 * 현</td></tr>
								<tr><td>제2회 아웃도어웨어디자인 공모전</td><td>특선</td><td>이 * 이</td></tr>
								<tr><td>BIDA 인테리어디자인 공모전</td><td>장려상</td><td>정 * 림, 차 * 철 외</td></tr>
								<tr><td>제7회 한국 공간 디자인대전</td><td>특별상</td><td>허 * 운, 남 * 주</td></tr>
								<tr><td>제7회 한국 공간 디자인대전</td><td>특선</td><td>백 * 림</td></tr>
								<tr><td>제7회 한국 공간 디자인대전</td><td>장려상</td><td>손 * 수</td></tr>
								<tr><td>제3회 JW중외 영아트 어워드 공모전</td><td>장려상</td><td>백 * 재</td></tr>
								<tr><td>BIDA 인테리어디자인 공모전</td><td>장려상</td><td>나 * 영</td></tr>
								<tr><td>제7회 한국 공간 디자인대전</td><td>우수상</td><td>윤 * 니, 문 * 솔</td></tr>
								<tr><td>제13회 싼타페 광고 공모전(인쇄광고 부문)</td><td>입선</td><td>김 * 란, 윤 * 늘</td></tr>
								<tr><td>행복디자인 공모전(패션상품디자인 부문)</td><td>특선</td><td>우 * 희</td></tr>
								<tr><td>제17회 전통문양디자인공모전</td><td>장려상</td><td>최 * 정</td></tr>
								<tr><td>제17회 전통문양디자인공모전</td><td>특선</td><td>정 * 연 외</td></tr>
								<!-- 2018.12.18 celldio 이규호 추가 - start 
								<tr><td>2018 USA Creativity International Award</td><td>Gold</td><td>신 * 희</td></tr>
								<tr><td>2018 USA Creativity International Award</td><td>Silver</td><td>김 * 윤, 박 * 미 외</td></tr>
								<tr><td>2018 USA Creativity International Award</td><td>Bronze</td><td>박 * 서, 이 * 정 외</td></tr>
								<tr><td>2018 뉴욕 그라피스 어워드</td><td>Platinum</td><td>김 * 비, 장 * 준</td></tr>
								<tr><td>2018 뉴욕 그라피스 어워드</td><td>Gold</td><td>하 * 현, 이 * 원 외</td></tr>
								<tr><td>2018 뉴욕 그라피스 어워드</td><td>Silver</td><td>유 * 아, 안 * 환 외</td></tr>
								<tr><td>2018 뉴욕 그라피스 포스터 어워드</td><td>Merit</td><td>정 * 라</td></tr>
								<tr><td>2018 USA SPARK Design Award</td><td>Finalist</td><td>박 * 정</td></tr>
								<tr><td>PINUP Concept Design Award</td><td>Finalist</td><td>박 * 정</td></tr>
								<tr><td>2017 USA Creativity International Award</td><td>Bronze</td><td>한 * 희</td></tr>
								<tr><td>2017 K-DESIGN International Award</td><td>Winner</td><td>이 * 희</td></tr>
								<tr><td>KTV 평창동계올림픽 콘텐츠 공모전</td><td>우수상(한국정책방송원장상)</td><td>강 * 결 팀</td></tr>
								<tr><td>제1회 세계시민UCC콘텐츠 공모전</td><td>대상(중앙선거관리위원장상)</td><td>고 * 미 팀</td></tr>
								<tr><td>제8회 나부터 시작하는 지식재산보호 국민공모전</td><td>특허청장상</td><td>이 * 훈</td></tr>
								<tr><td>제13회 생명의 빛 공해의 빛 빛공해 사진‧UCC공모전</td><td>우수상(조명박물관장상)</td><td>강 * 우 팀</td></tr>
								<tr><td>제2회 친자연적 장례문화 확산을 위한 공모전</td><td>진흥원장상</td><td>이 * 구 팀</td></tr>
								<tr><td>제1회 청춘상하 대학생 사진영상공모전</td><td>대상</td><td>이 * 진</td></tr>
								<tr><td>제10회 공간디자인대전</td><td>금상</td><td>임 * 성 팀</td></tr>
								<tr><td>서울시와 함께하는 '2017 상상패션위크' 공모전</td><td>대상(서울시장상)</td><td>팀 '하디'(김 * 구 외)</td></tr>
								<tr><td>제35회 대한민국 신미술대전</td><td>대상</td><td>성 * 현</td></tr>
								<tr><td>제35회 대한민국 신미술대전</td><td>우수상</td><td>박 * 나</td></tr>
								<tr><td>제7회 한영텍스타일 공모전</td><td>우수상</td><td>박 * 영</td></tr>
								<tr><td>제5회 서울국제일러스트레이션 공모전</td><td>동상</td><td>박 * 진 외</td></tr>
								<tr><td>제6회 코리아 디지털 패션 콘테스트</td><td>장려상</td><td>김 * 준</td></tr>
								<tr><td>2016 Asia Pacific Design Annual Award</td><td>연감 작품 등재</td><td>정 * 라, 양 * 준</td></tr>
								<tr><td>2016 USA Creativity International Award</td><td>Platinum</td><td>최 * 훈</td></tr>
								<tr><td>2016 Swizerland Goldrn Award</td><td>Finalist</td><td>최 * 훈</td></tr>
								<tr><td>2016 Cannes future Lions</td><td>Shortist</td><td>최 * 훈</td></tr>
								<tr><td>2016 헌법사랑공모전</td><td>대상(헌법재판소장상)</td><td>오 * 택 팀</td></tr>
								<tr><td>제49회 대한구강보건협회 작품공모전</td><td>대상(보건복지부장관상)</td><td>오 * 택</td></tr>
								<tr><td>제14회 매일신문 광고대상공모전</td><td>대상</td><td>최 * 은 팀</td></tr>
								<tr><td>디지털미디어콘텐츠 공모전</td><td>새정치상</td><td>문 * 석</td></tr>
								<tr><td>서울꿈새김판 문안 공모전</td><td>우수상</td><td>문 * 석</td></tr>
								<tr><td>5th 탐앤탐스 광고공모전</td><td>대상(환경부장관상)</td><td>김 * 서 팀</td></tr>
								<tr><td>2016 AD STARS</td><td>Crystal</td><td>최 * 훈</td></tr>
								<tr><td>작가데뷔 프로젝트_당신의 작품을 겁니다</td><td>작가 선발</td><td>유 * 혜</td></tr>
								<tr><td>제3회 서체&디자인상</td><td>동상</td><td>엄 * 림 팀</td></tr>
								<tr><td>국정교과서 반대 콘텐츠공모전</td><td>우수상</td><td>문 * 석</td></tr>
								<tr><td>2016 CACADEW AWARDS</td><td>입선</td><td>김 * 정</td></tr>
								<tr><td>2016 코튼 T-셔츠 프린트 디자이콘텐스트</td><td>입선</td><td>유 * 진</td></tr>
								<tr><td>제7회 양성평등디자인공모전</td><td>은상</td><td>김 * 서</td></tr>
								<tr><td>2016 여객선 안전교육 UCC공모전</td><td>대상</td><td>이 * 호</td></tr>
								<tr><td>2016 제4회 생명사랑 정신건강문화축제</td><td>최우수상</td><td>김 * 수</td></tr>
								<tr><td>제12회 에이즈예방 광고공모전</td><td>최우수상</td><td>권 * 승</td></tr>
								<tr><td>제14회 LH 대학생 광고공모전</td><td>최우수상</td><td>최 * 은, 문 * 혜 외</td></tr>
								<tr><td>서울다반사 공모전</td><td>시민인기상</td><td>이 * 한</td></tr>
								<tr><td>국민참여 KOTRA 홍보 공모전</td><td>우수상</td><td>이 * 규, 조 * 희 외</td></tr>
								<tr><td>국민참여 KOTRA 홍보 공모전</td><td>장려상</td><td>안 * 기, 박 * 희 외</td></tr>
								<tr><td>2016 흡연에티켓 광고공모전</td><td>입선</td><td>최 * 은</td></tr>
								<tr><td>제17회 KVMD 협회 디자인 공모전</td><td>대상</td><td>양 * 서</td></tr>
								<tr><td>공간코디네이션대전</td><td>금상</td><td>김 * 훈, 최 * 경 외</td></tr>
								<tr><td>BIDA 인테리어디자인 공모전</td><td>금상</td><td>정 * 주, 변 * 영</td></tr>
								<tr><td>BIDA 인테리어디자인 공모전</td><td>금상</td><td>정 * 림, 이 * 슬</td></tr>
								<tr><td>KODIA 디스플레이賞</td><td>금상</td><td>박 * 미</td></tr>
								<tr><td>제6회 한국공간디자인대전</td><td>은상</td><td>허 * 영, 이 * 혁 외</td></tr>
								<tr><td>부산국제문화제 실내건축대전</td><td>은상</td><td>김 * 현, 황 * 윤 외</td></tr>
								<tr><td>Store Design 공모전</td><td>은상</td><td>김 * 솔, 전 * 예</td></tr>
								<tr><td>Store Design 공모전</td><td>동상</td><td>임 * 연</td></tr>
								<tr><td>제17회 KVMD 협회 디자인 공모전</td><td>은상</td><td>유 * 현, 최 * 아</td></tr>
								<tr><td>BIDA 인테리어디자인 공모전</td><td>동상</td><td>한 * 리, 조 * 재 외</td></tr>
								<tr><td>BIDA 인테리어디자인 공모전</td><td>특별상</td><td>장 * 하</td></tr>
								<tr><td>유니버셜디자인공모전</td><td>최우수상</td><td>김 * 이, 석 * 성 외</td></tr>
								<tr><td>대한민국 현대조형 미술대전</td><td>우수상</td><td>정 * 정, 임 * 연</td></tr>
								<tr><td>한국인테리어대전</td><td>장려상</td><td>이 * 석, 주 * 름 외</td></tr>
								<tr><td>차세대문화공간건축상</td><td>장려상</td><td>정 * 환, 김 * 영 외</td></tr>
								<tr><td>국제 청소년 건축설계 공모전</td><td>장려상</td><td>음 * 식, 박 * 호 외</td></tr>
								<tr><td>KDAI 우수작품전시회</td><td>장려상</td><td>정 * 환, 황 * 윤 외</td></tr>
								<tr><td>DGID 실내건축디자인대전</td><td>장려상</td><td>조 * 재, 김 * 영 외</td></tr>
								<tr><td>국제 청소년 건축설계 공모전</td><td>장려상</td><td>김 * 영, 이 * 지</td></tr>
								<tr><td>BIDA 인테리어디자인 공모전</td><td>장려상</td><td>이 * 슬, 정 * 림 외</td></tr>
								<tr><td>DGID 실내건축디자인대전</td><td>장려상</td><td>김 * 영</td></tr>
								<tr><td>공간코디네이션대전</td><td>특별상</td><td>최 * 경, 이 * 단 외</td></tr>
								<tr><td>제3회 한국공간코디네이션</td><td>특별상</td><td>장 * 하, 안 * 슬 외</td></tr>
								<tr><td>전쟁기념관20주년 '추억의사진'공모전</td><td>가작</td><td>윤 * 희</td></tr>
								<tr><td>DGID 실내건축디자인대전</td><td>우수상</td><td>김 * 영, 김 * 성</td></tr>
								<tr><td>DGID 실내건축디자인대전</td><td>특선</td><td>김 * 영, 김 * 민 외</td></tr>
								<tr><td>DGID 실내건축디자인대전</td><td>장려상</td><td>이 * 주, 이 * 영 외</td></tr>
								<tr><td>제9회 차세대문화공간공모전</td><td>장려상</td><td>허 * 운, 남 * 주 외</td></tr>
								<tr><td>제9회 차세대문화공간공모전</td><td>특선</td><td>유 * 현, 주 * 름 외</td></tr>
								<tr><td>제9회 차세대문화공간공모전</td><td>입선</td><td>이 * 영, 이 * 석 외</td></tr>
								<tr><td>제43회 전국대학생디자인 대전</td><td>입선</td><td>이 * 은, 박 * 경</td></tr>
								<tr><td>국제청소년공간대전</td><td>특선</td><td>이 * 지, 김 * 재 외</td></tr>
								<tr><td>제7회 한국 공간 디자인대전</td><td>동상</td><td>김 * 섭, 김 * 빈</td></tr>
								<tr><td>제7회 한국 공간 디자인대전</td><td>장려상</td><td>정 * 현, 김 * 민 외</td></tr>
								<tr><td>제7회 한국 공간 디자인대전</td><td>입선</td><td>정 * 윤 외</td></tr>
								<tr><td>제18회 KVMD 협회 디자인공모전</td><td>동상</td><td>서 * 윤, 김 * 재</td></tr>
								<tr><td>제4회 청소년 휴먼 영화제</td><td>대상</td><td>홍 * 욱, 유 * 호 외</td></tr>
								<tr><td>제8회 MTN 대한민국 대학생 광고공모전</td><td>대상</td><td>안 * 영</td></tr>
								<tr><td>제10회 LH 대학생 광고 공모전</td><td>대상</td><td>김 * 비, 심 * 연 외</td></tr>
								<tr><td>SONY 알파 nex 사진 공모전</td><td>대상</td><td>윤 * 늘</td></tr>
								<tr><td>LA우표대전</td><td>금상</td><td>박 * 호, 이 * 아</td></tr>
								<tr><td>저출산 극복 포스터 공모전</td><td>금상</td><td>신 * 식, 한 * 범</td></tr>
								<tr><td>뉴던전 스트라이커 UCC 콘테스트</td><td>은상</td><td>양 * 국</td></tr>
								<tr><td>국제광고제 클리오(CLIO)</td><td>은상</td><td>김 * 욱</td></tr>
								<tr><td>제5회 MTN 대한민국 대학생 광고공모전</td><td>은상</td><td>임 * 이</td></tr>
								<tr><td>제9회 에이즈 예방 대학생 광고공모전 광고기획부문</td><td>은상</td><td>안 * 영</td></tr>
								<tr><td>삼성생명 대학생 공모전 UCC부문</td><td>은상</td><td>김 * 아</td></tr>
								<tr><td>제2회 KB국민카드 꿈꾸는 광고인</td><td>동상</td><td>안 * 영</td></tr>
								<tr><td>제15회 대학생 영남대학교 창업아이디어 경연대회</td><td>최우수상</td><td>이 * 훈</td></tr>
								<tr><td>대학생 신용보증기금 창업아이템 경진대회</td><td>최우수상</td><td>이 * 훈</td></tr>
								<tr><td>희망서울 엑스포 공모전</td><td>최우수상</td><td>양 * 지</td></tr>
								<tr><td>3필착 그림영상 공모전</td><td>우수상</td><td>강 * 수, 이 * 진 외</td></tr>
								<tr><td>함께여는 아름다운 세상 대학생 사회공헌 광고공모전</td><td>우수상</td><td>김 * 성</td></tr>
								<tr><td>㈜나눔로또 대학(원)생 홍보 아이디어 & 포스터 공모전</td><td>우수상</td><td>이 * 범, 한 * 범 외</td></tr>
								<tr><td>블랙스미스 아이디어 공모전</td><td>우수상</td><td>현 * 수</td></tr>
								<tr><td>제11회 LH 대학생 광고 공모전 인쇄 광고부문</td><td>장려상</td><td>안 * 영</td></tr>
								<tr><td>글로벌 게임제작 경진대회</td><td>장려상</td><td>유 * 호, 홍 * 욱</td></tr>
								<tr><td>NH농협대학생광고공모전</td><td>장려상</td><td>문 * 이</td></tr>
								<tr><td>제1회 대한민국 인포그래픽 어워드</td><td>특별상</td><td>박 * 은, 김 * 민 외</td></tr>
								<tr><td>LA우표대전</td><td>특선</td><td>김 * 주, 정 * 혁</td></tr>
								<tr><td>제3회 JW중외 영아트 어워드 공모전 일러스트레이션부문</td><td>특선</td><td>차 * 철, 김 * 웅</td></tr>
								<tr><td>제11회 매일신문 광고대상 인쇄 광고부문</td><td>입선</td><td>신 * 식, 이 * 범</td></tr>
								<tr><td>희망서울 엑스포 공모전</td><td>입선</td><td>강 * 지</td></tr>
								<tr><td>제1회 대한민국 인포그래픽 어워드</td><td>입선</td><td>김 * 훈, 한 * 홍 외</td></tr>
								<tr><td>흡연에티켓 광고공모전</td><td>입선</td><td>김 * 주, 김 * 라</td></tr>
								<tr><td>바람직한 간판문화 공모전(UCC)</td><td>입선</td><td>한 * 연, 김 * 솜</td></tr>
								<tr><td>제4회 비락 광고디자인공모전</td><td>입선</td><td>안 * 영, 정 * 혁 외</td></tr>
								<tr><td>제41회 전국대학생 디자인대전</td><td>입선</td><td>박 * 영, 송 * 혜</td></tr>
								<tr><td>전국대학생 디자인과제 공모전</td><td>입선</td><td>남 * 린, 강 * 인</td></tr>
								<tr><td>제3회 바람직한 간판문화 공모전</td><td>입선</td><td>한 * 연, 김 * 솜</td></tr>
								<tr><td>국토해양부 홍보 공모전 인쇄광고</td><td>입선</td><td>최 * 훈</td></tr>
								<tr><td>대학(원)생 사회공헌 광고 공모전</td><td>우수상</td><td>김 * 성</td></tr>
								<tr><td>샘표간장 노래자랑 UCC</td><td>너무프로상</td><td>김 * 래</td></tr>
								<tr><td>커뮤니케이션디자인국제공모전</td><td>입선</td><td>이 * 연</td></tr>
								<tr><td>제4회 비만예방디자인공모전</td><td>입선</td><td>이 * 희, 이 * 원 외</td></tr>
								<tr><td>전국 대학생 디자인공모전</td><td>특선</td><td>정 * 도, 조 * 선</td></tr>
								<tr><td>전국 대학생 디자인공모전</td><td>입선</td><td>백 * 화, 백 * 연 외</td></tr>
								<tr><td>신용보증기금 대학생 광고공모전</td><td>장려상</td><td>김 * 성, 이 * 범 외</td></tr>
								<tr><td>안전보건 UCC공모전</td><td>입선</td><td>양 * 국</td></tr>
								<tr><td>제7회 즐거운환경UCC공모전</td><td>우수상</td><td>박 * 은, 조 * 은</td></tr>
								<tr><td>헌혈 공모전</td><td>생명나눔상</td><td>박 * 호, 이 * 아 외</td></tr>
								<tr><td>광동제약 헛개차 ucc공모전</td><td>최우수상</td><td>박 * 영, 박 * 준</td></tr>
								<tr><td>바이오아트 콘테스트</td><td>입선</td><td>양 * 국</td></tr>
								<tr><td>광주광역시 안전UCC 공모전</td><td>안전상</td><td>이 * 호, 김 * 림</td></tr>
								<tr><td>첼로 UCC CONTEST</td><td>우수상</td><td>최 * 민, 이 * 호 외</td></tr>
								<tr><td>국립국악원UCC공모전</td><td>우수상</td><td>박 * 열, 최 * 우 외</td></tr>
								<tr><td>가스안전 디자인공모전</td><td>입선</td><td>박 * 나</td></tr>
								<tr><td>THINK SAFETY UCC공모전</td><td>동상</td><td>박 * 호, 배 * 미</td></tr>
								<tr><td>전문병원홍보물 공모전</td><td>금상</td><td>최 * 우, 박 * 연</td></tr>
								<tr><td>인천광역시 치매인식개선 사진 및 UCC 공모전</td><td>장려상</td><td>김 * 림, 서 * 주</td></tr>
								<tr><td>아주특별한나눔BI공모전</td><td>입선</td><td>오 * 빈</td></tr>
								<tr><td>UGIZ 1ST 티셔츠 그래픽디자인공모전</td><td>최우수상</td><td>신 * 경</td></tr>
								<tr><td>디자인레이스 프리스타일 디자인아트 공모전</td><td>우수상</td><td>주 * 림</td></tr>
								<tr><td>대한민국 지역특산 명품브랜드 공모전</td><td>한국지역진흥재단이사장상</td><td>이 * 호, 채 * 병 외</td></tr>
								<tr><td>첼로 UCC CONTEST</td><td>우수상</td><td>최 * 민, 이 * 호 외</td></tr>
								<tr><td>제2회 대학생 그림책 공모전</td><td>입선</td><td>홍 * 수</td></tr>
								<tr><td>제1회 얼바인 아웃도어웨어 디자인 공모전</td><td>최우수상</td><td>임 * 하, 김 * 은</td></tr>
								<tr><td>제1회 Yo-콘테스트 유니폼디자인 공모전</td><td>금상</td><td>권 * 라</td></tr>
								<tr><td>제2회 아웃도어웨어디자인 공모전</td><td>장려상</td><td>배 * 린, 이 * 형</td></tr>
								<tr><td>YDP 패션일러스트레이션 공모전</td><td>입선</td><td>김 * 은, 김 * 우</td></tr>
								<tr><td>해외인턴쉽개발 국비지원프로그램</td><td>미국 국비지원 장학생 선발</td><td>이 * 이</td></tr>
								<tr><td>패션상품기획콘테스트</td><td>장려상</td><td>조 * 비, 양 * 정</td></tr>
								<tr><td>웨딩드레스디자인공모전</td><td>특선</td><td>권 * 기</td></tr>
								<tr><td>넥타이디자인공모전</td><td>입선</td><td>이 * 라, 유 * 라</td></tr>
								<tr><td>임부복디자인공모전</td><td>입선</td><td>류 * 은</td></tr>
								<tr><td>서울 국제일러스트레이션공모전</td><td>입선</td><td>윤 * 혜</td></tr>
								<tr><td>아웃도어웨어디자인 공모전</td><td>입선</td><td>박 * 훈, 이 * 재 외</td></tr>
								<tr><td>부산국제일러스트레이션공모전</td><td>입선</td><td>강 * 영, 김 * 리</td></tr>
								<tr><td>행복디자인공모전 -패션상품디자인부문</td><td>특선</td><td>김 * 민</td></tr>
								<tr><td>THINK SAFETY UCC 공모전</td><td>동상</td><td>박 * 호, 배 * 미</td></tr>
								<tr><td>CJ 대학생 브랜드디자인 공모전</td><td>특별상</td><td>신 * 경</td></tr>
								<tr><td>CJ 대학생 브랜드디자인 공모전</td><td>특선</td><td>오 * 빈, 최 * 선</td></tr>
								<tr><td>CJ 대학생 브랜드디자인 공모전</td><td>입선</td><td>정 * 도, 김 * 수 외</td></tr>
								<tr><td>맘스터치 “먹스코리아” UCC 공모전</td><td>우수상</td><td>김 * 래</td></tr>
								<tr><td>패션상품기획콘테스트</td><td>장려상</td><td>양 * 정</td></tr>
								<tr><td>넥타이 디자인 공모전</td><td>특선</td><td>우 * 희</td></tr>
								<tr><td>YDP 일러스트레이션 공모전</td><td>입선</td><td>김 * 지 외</td></tr>
								<tr><td>부산 국제일러스트레이션 공모전</td><td>특선</td><td>강 * 영</td></tr>
								<tr><td>부산 국제일러스트레이션 공모전</td><td>입선</td><td>나 * 희 외</td></tr>
								<tr><td>국제 니트아트 소재 공모전</td><td>특선</td><td>김 * 이, 서 * 현</td></tr>
								<tr><td>국제 니트아트 소재 공모전</td><td>입선</td><td>정 * 영, 문 * 수 외</td></tr>
								<tr><td>국제넥타이디자인공모전</td><td>특선</td><td>김 * 은</td></tr>
								<tr><td>국제넥타이디자인공모전</td><td>입선</td><td>안 * 환</td></tr>
								<tr><td>제6회 부산 국제 패션일러스트레이션 공모전</td><td>특선</td><td>임 * 하, 김 * 은</td></tr>
								<tr><td>제6회 부산 국제 패션일러스트레이션 공모전</td><td>입선</td><td>최 * 혜</td></tr>
								<tr><td>YDP 패션일러스트레이션 공모전</td><td>특선</td><td>김 * 리, 안 * 솔</td></tr>
								<tr><td>국제니팅아트디자인 공모전</td><td>소재부문 입선</td><td>류 * 은, 염 * 주 외</td></tr>
								<tr><td>농업농촌 PRDP UCC공모전</td><td>최우수상</td><td>박 * 준, 서 * 우 외</td></tr>
								<tr><td>the 12th korea beauty health society international beauty art exhibition</td><td>우수상</td><td>김 * 진</td></tr>
								<tr><td>안산대학교총장배 제5회 전국미용 공모전</td><td>대상</td><td>한 * 지</td></tr>
								<tr><td>안산대학교총장배 제5회 전국미용 공모전</td><td>금상</td><td>백 * 희</td></tr>
								<tr><td>안산대학교총장배 제5회 전국미용 공모전</td><td>우수상</td><td>박 * 진 외</td></tr>
								<tr><td>제4회 미추헤어쇼 미용경연대회 네일아트 부문</td><td>대상</td><td>임 * 명</td></tr>
								<tr><td>제4회 미추헤어쇼 미용경연대회 네일아트 부문</td><td>금상</td><td>유 * 아</td></tr>
								<tr><td>제4회 미추헤어쇼 미용경연대회 네일아트 부문</td><td>은상</td><td>유 * 란</td></tr>
								<tr><td>제8회 국제네일디자인컨테스트</td><td>그랜드챔피언</td><td>유 * 란</td></tr>
								<tr><td>제8회 국제네일디자인컨테스트</td><td>은상</td><td>유 * 아</td></tr>
								<tr><td>제8회 국제네일디자인컨테스트</td><td>특별상</td><td>엄 * 비</td></tr>
								<tr><td>대체미용요법 엑스포 콘테스트</td><td>은상</td><td>임 * 연</td></tr>
								<tr><td>전국 일러스트 공모전</td><td>장려상</td><td>이 * 화</td></tr>
								<tr><td>제5회 대한민국 국제뷰티문화예술 기능대회 스킨아트부문</td><td>그랑프리</td><td>강 * 옥</td></tr>
								<tr><td>제5회 대한민국 국제뷰티문화예술 기능대회 스킨아트부문</td><td>대상</td><td>엄 * 비</td></tr>
								<tr><td>식품첨가물 바로알기 UCC,POSTER 공모전</td><td>최우수상</td><td>전 * 연, 이 * 경</td></tr>
								<tr><td>식품첨가물 바로알기 UCC,POSTER 공모전</td><td>우수상</td><td>이 * 은, 윤 * 수</td></tr>
								<tr><td>식품첨가물 바로알기 UCC,POSTER 공모전</td><td>장려상</td><td>최 * 재, 김 * 윤</td></tr>
								<tr><td>새 우편번호 알리기 UCC & 로고송 공모전</td><td>동상</td><td>김 * 야, 노 * 정 외</td></tr>
								<tr><td>제1회 에비수 IDEA UCC 광고공모전</td><td>우수상</td><td>김 * 식, 김 * 현</td></tr>
								<tr><td>제2회 아웃도어웨어디자인 공모전</td><td>장려상</td><td>서 * 현</td></tr>
								<tr><td>제2회 아웃도어웨어디자인 공모전</td><td>특선</td><td>이 * 이</td></tr>
								<tr><td>BIDA 인테리어디자인 공모전</td><td>장려상</td><td>정 * 림, 차 * 철 외</td></tr>
								<tr><td>제7회 한국 공간 디자인대전</td><td>특별상</td><td>허 * 운, 남 * 주</td></tr>
								<tr><td>제7회 한국 공간 디자인대전</td><td>특선</td><td>백 * 림</td></tr>
								<tr><td>제7회 한국 공간 디자인대전</td><td>장려상</td><td>손 * 수</td></tr>
								<tr><td>제3회 JW중외 영아트 어워드 공모전</td><td>장려상</td><td>백 * 재</td></tr>
								<tr><td>BIDA 인테리어디자인 공모전</td><td>장려상</td><td>나 * 영</td></tr>
								<tr><td>제7회 한국 공간 디자인대전</td><td>우수상</td><td>윤 * 니, 문 * 솔</td></tr>
								<tr><td>제13회 싼타페 광고 공모전(인쇄광고 부문)</td><td>입선</td><td>김 * 란, 윤 * 늘</td></tr>
								<tr><td>행복디자인 공모전(패션상품디자인 부문)</td><td>특선</td><td>우 * 희</td></tr>
								<tr><td>제17회 전통문양디자인공모전</td><td>장려상</td><td>최 * 정</td></tr>
								<tr><td>제17회 전통문양디자인공모전</td><td>특선</td><td>정 * 연 외</td></tr>
								-->
								<!-- 2018.12.18 celldio 이규호 추가 - end -->
								<!-- 
								<tr><td class="ta_left">2018 뉴욕 그라피스 뉴탤런트 어워드</td><td>Platinum</td><td>김 * 비, 장 * 준</td></tr>
								<tr><td class="ta_left">2018 뉴욕 그라피스 뉴탤런트 어워드</td><td>Gold</td><td>하 * 현, 이 * 원 외</td></tr>
								<tr><td class="ta_left">2018 뉴욕 그라피스 뉴탤런트 어워드</td><td>Silver</td><td>유 * 아, 안 * 환 외</td></tr>
								<tr><td class="ta_left">2018 뉴욕 그라피스 포스터 어워드</td><td>Merit</td><td>정 * 라</td></tr>
								<tr><td class="ta_left">2018 USA Creativity International Award</td><td>Gold</td><td>신 * 희</td></tr>
								<tr><td class="ta_left">2018 USA Creativity International Award</td><td>Silver</td><td>김 * 윤, 박 * 미 외</td></tr>
								<tr><td class="ta_left">2018 USA Creativity International Award</td><td>Bronze</td><td>박 * 서, 이 * 정 외</td></tr>
								<tr><td class="ta_left">2017 USA Creativity International Award</td><td>Bronze</td><td>한 * 희</td></tr>
								<tr><td class="ta_left">2017 K-DESIGN International Award</td><td>WINNER</td><td>한 * 희</td></tr>
								<tr><td class="ta_left">2018 KTV 평창동계올림픽 콘텐츠 공모전</td><td>우수상(한국정책방송원장상)</td><td>강 * 결 팀</td></tr>
								<tr><td class="ta_left">제1회 세계시민UCC콘텐츠 공모전</td><td>대상(중앙선거관리위원장상)</td><td>고 * 미 팀</td></tr>
								<tr><td class="ta_left">제1회 청춘상하 대학생 사진영상공모전</td><td>대상</td><td>이 * 진</td></tr>
								<tr><td class="ta_left">제8회 '나'부터 시작하는 지식재산보호 국민공모전</td><td>특허청장상</td><td>이 * 훈</td></tr>
								<tr><td class="ta_left">제13회 생명의 빛 공해의 빛 빛공해 사진‧UCC공모전</td><td>우수상(조명박물관장상)</td><td>강 * 우 팀</td></tr>
								<tr><td class="ta_left">제2회 친자연적 장례문화 확산을 위한 공모전</td><td>진흥원장상</td><td>이 * 구 팀</td></tr>
								<tr><td class="ta_left">서울시와 함께하는 '2017 상상패션위크' 공모전</td><td>대상(서울시장상)</td><td>팀 '하디'(김 * 구 외)</td></tr>
								<tr><td class="ta_left">제35회 대한민국 신미술대전</td><td>대상</td><td>성 * 현</td></tr>
								<tr><td class="ta_left">제35회 대한민국 신미술대전</td><td>우수상</td><td>박 * 나</td></tr>
								<tr><td class="ta_left">제7회 한영텍스타일 공모전</td><td>우수상</td><td>박 * 영</td></tr>
								<tr><td class="ta_left">제6회 코리아 디지털 패션 콘테스트</td><td>장려상</td><td>김 * 준</td></tr>
								<tr><td class="ta_left">제4회 서울국제일러스트레이션 공모전</td><td>장려상</td><td>강 * 름</td></tr>
								<tr><td class="ta_left">2016 USA creativity inter national Award</td><td>Platinum Best category winner Silver Bronze</td><td>최 * 훈</td></tr>
								<tr><td class="ta_left">2016 Swizerland Goldrn Award</td><td>Finialist</td><td>최 * 훈</td></tr>
								<tr><td class="ta_left">2016 Cannes future Lions</td><td>Shortist</td><td>최 * 훈</td></tr>
								<tr><td class="ta_left">2016 헌법사랑공모전</td><td>헌법재판소장상(대상)</td><td>문 * 혜, 오 * 택 외</td></tr>
								<tr><td class="ta_left">2016 제49회 대한구강보건협회 작품공모전</td><td>보건복지부장관상(대상)</td><td>오 * 택</td></tr>
								<tr><td class="ta_left">2016 제14회 매일신문 광고대상공모전</td><td>대상</td><td>최 * 은, 우 * 규 외</td></tr>
								<tr><td class="ta_left">디지털미디어콘텐츠 공모전</td><td>새정치상</td><td>문 * 석</td></tr>
								<tr><td class="ta_left">서울꿈새김판 문안 공모전</td><td>우수상</td><td>문 * 석</td></tr>
								<tr><td class="ta_left">5th 탐앤탐스 광고공모전</td><td>대상(환경부장관상)</td><td>최 * 훈, 김 * 서 외</td></tr>
								<tr><td class="ta_left">제9회 흡연에티켓 광고공모전</td><td>입선</td><td>최 * 훈</td></tr>
								<tr><td class="ta_left">작가데뷔 프로젝트_당신의 작품을 겁니다</td><td>작가 선발</td><td>유 * 혜</td></tr>
								<tr><td class="ta_left">제3회 서체&디자인상</td><td>동상</td><td>엄 * 림, 권 * 림 팀</td></tr>
								<tr><td class="ta_left">국정교과서 반대 콘텐츠공모전</td><td>우수상</td><td>문 * 석</td></tr>
								<tr><td class="ta_left">2016 CACADEW AWARDS</td><td>입선</td><td>김 * 정</td></tr>
								<tr><td class="ta_left">2016 코튼 T-셔츠 프린트 디자이콘텐스트</td><td>입선</td><td>유 * 진</td></tr>
								<tr><td class="ta_left">2016 AD STARD</td><td>크리스탈상, Finialist</td><td>최 * 훈</td></tr>
								<tr><td class="ta_left">제7회 2016양성평등디자인공모전</td><td>은상</td><td>김 * 서</td></tr>
								<tr><td class="ta_left">2016년 여객선 안전교육 UCC공모전</td><td>대상</td><td>이 * 호</td></tr>
								<tr><td class="ta_left">제1회 동국제약 대학생 UCC 아이디어 공모전</td><td>3등</td><td>안 * 기, 신 * 율 외</td></tr>
								<tr><td class="ta_left">2016 제4회 생명사랑 정신건강문화축제</td><td>(최우수상) 1등</td><td>김 * 수</td></tr>
								<tr><td class="ta_left">아시아태평양디자인연감(그래픽디자인 애뉴얼 어워드) 12th 2016 Asia Pacific Design Annual Award</td><td>연감 작품 등제</td><td>정 * 라, 양 * 준</td></tr>
								<tr><td class="ta_left">제12회 에이즈예방 광고공모전</td><td></td><td>권 * 승</td></tr>
								<tr><td class="ta_left">제14회 LH 대학생 광고공모전</td><td></td><td>최 * 은, 문 * 혜 외</td></tr>
								<tr><td class="ta_left">제3회 서울국제일러스트레이션 공모전</td><td>입선</td><td>김 * 명, 유 * 진 외</td></tr>
								<tr><td class="ta_left">제4회 서울국제일러스트레이션 공모전</td><td>동상</td><td>김 * 원, 김 * 름 외</td></tr>
								<tr><td class="ta_left">제5회 서울국제일러스트레이션 공모전</td><td>장려상</td><td>박 * 진, 오 * 진 외</td></tr>
								<tr><td class="ta_left">서울다반사 공모전</td><td>시민인기상</td><td>이 * 한</td></tr>
								<tr><td class="ta_left">2016성매매방지 UCC디자인공모전</td><td>가작</td><td>안 * 기</td></tr>
								<tr><td class="ta_left">국민참여 KOTRA 홍보 공모전</td><td>우수상</td><td>이 * 규, 조 * 희 외</td></tr>
								<tr><td class="ta_left">국민참여 KOTRA 홍보 공모전</td><td>장려상</td><td>안 * 기, 박 * 희 외</td></tr>
								<tr><td class="ta_left">2016 흡연에티켓 광고공모전</td><td>입선</td><td>최 * 은</td></tr>
								<tr><td class="ta_left">제17회 KVMD 협회 디자인 공모전</td><td>대상</td><td>양 * 서</td></tr>
								<tr><td class="ta_left">공간코디네이션대전</td><td>금상</td><td>김 * 훈, 최 * 경 외</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>금상</td><td>정 * 주, 변 * 영</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>금상</td><td>정 * 림, 이 * 슬</td></tr>
								<tr><td class="ta_left">KODIA 디스플레이賞</td><td>금상</td><td>박 * 미</td></tr>
								<tr><td class="ta_left">제6회 한국공간디자인대전</td><td>은상</td><td>허 * 영, 이 * 혁 외</td></tr>
								<tr><td class="ta_left">부산국제문화제 실내건축대전</td><td>은상</td><td>김 * 현, 황 * 윤 외</td></tr>
								<tr><td class="ta_left">Store Design 공모전</td><td>은상</td><td>김 * 솔, 전 * 예</td></tr>
								<tr><td class="ta_left">Store Design 공모전</td><td>동상</td><td>임 * 연</td></tr>
								<tr><td class="ta_left">제17회 KVMD 협회 디자인 공모전</td><td>은상</td><td>유 * 현, 최 * 아</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>동상</td><td>한 * 리, 조 * 재</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>동상</td><td>김 * 영, 조 * 재</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>동상</td><td>길 * 원</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>동상</td><td>변 * 영</td></tr>
								<tr><td class="ta_left">유니버셜디자인공모전</td><td>최우수상</td><td>김 * 이, 석 * 성 외</td></tr>
								<tr><td class="ta_left">대한민국 현대조형 미술대전</td><td>우수상</td><td>정 * 정, 임 * 연</td></tr>
								<tr><td class="ta_left">한국인테리어대전</td><td>장려상</td><td>이 * 석, 주 * 름 외</td></tr>
								<tr><td class="ta_left">차세대문화공간건축상</td><td>장려상</td><td>정 * 환, 김 * 영 외</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>유 * 현, 이 * 석 외</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>허 * 운, 한 * 은 외</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>이 * 지, 허 * 영 외</td></tr>
								<tr><td class="ta_left">한국인테리어대전</td><td>장려상</td><td>곽 * 건, 이 * 수 외</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>임 * 지, 남 * 태</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>신 * 영</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>정 * 정, 윤 * 민</td></tr>
								<tr><td class="ta_left">차세대문화공간건축상</td><td>장려상</td><td>김 * 지, 이 * 수 외</td></tr>
								<tr><td class="ta_left">국제 청소년 건축설계 공모전</td><td>장려상</td><td>음 * 식, 박 * 호 외</td></tr>
								<tr><td class="ta_left">KDAI 우수작품전시회</td><td>장려상</td><td>정 * 환, 황 * 윤</td></tr>
								<tr><td class="ta_left">KDAI 우수작품전시회</td><td>장려상</td><td>김 * 호, 김 * 현 외</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>조 * 재, 김 * 영 외</td></tr>
								<tr><td class="ta_left">국제 청소년 건축설계 공모전</td><td>장려상</td><td>김 * 영, 이 * 지</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>장려상</td><td>이 * 슬, 정 * 림</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>장려상</td><td>곽 * 건, 석 * 성</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>장려상</td><td>옥 * 향, 박 * 은</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>김 * 영</td></tr>
								<tr><td class="ta_left">공간코디네이션대전</td><td>특별상</td><td>최 * 경, 이 * 단 외</td></tr>
								<tr><td class="ta_left">제3회 한국공간코디네이션</td><td>특별상</td><td>장 * 하, 안 * 슬 외</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>특별상</td><td>장 * 하</td></tr>
								<tr><td class="ta_left">한국인테리어대전</td><td>입선</td><td>이 * 석, 길 * 원</td></tr>
								<tr><td class="ta_left">한국인테리어대전</td><td>입선</td><td>김 * 금, 나 * 현</td></tr>
								<tr><td class="ta_left">전쟁기념관20주년'추억의사진'공모전</td><td>가작</td><td>윤 * 희</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>우수상</td><td>김 * 영, 김 * 성</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>특선</td><td>김 * 영, 김 * 민</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>특선</td><td>유 * 현</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>이 * 주, 이 * 영 외</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>조 * 진</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>이 * 민, 김 * 국</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>양 * 빈, 이 * 영 외</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>박 * 경, 이 * 은</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>임 * 현, 조 * 진 외</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>장려상</td><td>최 * 진</td></tr>
								<tr><td class="ta_left">DGID 실내건축디자인대전</td><td>입선</td><td>김 * 나, 손 * 형 외</td></tr>
								<tr><td class="ta_left">실내건축대전</td><td>입선</td><td>이 * 석, 이 * 영</td></tr>
								<tr><td class="ta_left">제9회 차세대문화공간공모전</td><td>장려상</td><td>김 * 영</td></tr>
								<tr><td class="ta_left">제9회 차세대문화공간공모전</td><td>장려상</td><td>허 * 운, 남 * 주</td></tr>
								<tr><td class="ta_left">제9회 차세대문화공간공모전</td><td>특선</td><td>유 * 현, 주 * 름 외</td></tr>
								<tr><td class="ta_left">제9회 차세대문화공간공모전</td><td>입선</td><td>이 * 영, 이 * 석</td></tr>
								<tr><td class="ta_left">제9회 차세대문화공간공모전</td><td>입선</td><td>이 * 지</td></tr>
								<tr><td class="ta_left">제9회 차세대문화공간공모전</td><td>입선</td><td>최 * 진</td></tr>
								<tr><td class="ta_left">제9회 차세대문화공간공모전</td><td>입선</td><td>남 * 식</td></tr>
								<tr><td class="ta_left">제9회 차세대문화공간공모전</td><td>입선</td><td>원 * 성, 김 * 홍 외</td></tr>
								<tr><td class="ta_left">제43회 전국대학생디자인 대전</td><td>입선</td><td>이 * 은, 박 * 경</td></tr>
								<tr><td class="ta_left">국제청소년공간대전</td><td>특선</td><td>이 * 지, 김 * 재 외</td></tr>
								<tr><td class="ta_left">국제청소년공간대전</td><td>입선</td><td>이 * 영</td></tr>
								<tr><td class="ta_left">국제청소년공간대전</td><td>입선</td><td>김 * 솔, 김 * 금 외</td></tr>
								<tr><td class="ta_left">제7회 한국 공간 디자인대전</td><td>동상</td><td>김 * 섭, 김 * 빈</td></tr>
								<tr><td class="ta_left">제7회 한국 공간 디자인대전</td><td>장려상</td><td>정 * 현, 김 * 민 외</td></tr>
								<tr><td class="ta_left">제7회 한국 공간 디자인대전</td><td>장려상</td><td>박 * 주, 양 * 빈 외</td></tr>
								<tr><td class="ta_left">제7회 한국 공간 디자인대전</td><td>장려상</td><td>김 * 홍, 원 * 성</td></tr>
								<tr><td class="ta_left">제7회 한국 공간 디자인대전</td><td>입선</td><td>정 * 윤</td></tr>
								<tr><td class="ta_left">제7회 한국 공간 디자인대전</td><td>입선</td><td>신 * 웅</td></tr>
								<tr><td class="ta_left">제7회 한국 공간 디자인대전</td><td>입선</td><td>최 * 용</td></tr>
								<tr><td class="ta_left">제18회 KVMD 협회 디자인공모전</td><td>동상</td><td>서 * 윤, 김 * 재</td></tr>
								<tr><td class="ta_left">제4회 청소년 휴먼 영화제</td><td>대상</td><td>홍 * 욱, 유 * 호 외</td></tr>
								<tr><td class="ta_left">제8회 MTN 대한민국 대학생 광고공모전</td><td>대상</td><td>안 * 영</td></tr>
								<tr><td class="ta_left">제10회 LH 대학생 광고 공모전</td><td>대상</td><td>김 * 비, 심 * 연 외</td></tr>
								<tr><td class="ta_left">sony 알파 nex 사진 공모전</td><td>대상</td><td>윤 * 늘</td></tr>
								<tr><td class="ta_left">LA우표대전</td><td>금상</td><td>박 * 호, 이 * 아</td></tr>
								<tr><td class="ta_left">저출산 극복 포스터 공모전</td><td>금상</td><td>신 * 식, 한 * 범</td></tr>
								<tr><td class="ta_left">뉴던전 스트라이커 UCC 콘테스트</td><td>은상</td><td>양 * 국</td></tr>
								<tr><td class="ta_left">국제광고제 클리오(CLIO)</td><td>은상</td><td>김 * 욱</td></tr>
								<tr><td class="ta_left">제5회 MTN 대한민국 대학생 광고공모전</td><td>은상</td><td>임 * 이/td></tr>
								<tr><td class="ta_left">제9회 에이즈 예방 대학생 광고공모전 광고기획부문</td><td>은상</td><td>안 * 영</td></tr>
								<tr><td class="ta_left">삼성생명 대학생 공모전 UCC부문</td><td>은상</td><td>김 * 아</td></tr>
								<tr><td class="ta_left">제2회 KB국민카드 꿈꾸는 광고인</td><td>동상</td><td>안 * 영</td></tr>
								<tr><td class="ta_left">제15회 대학생 영남대학교 창업아이디어 경연대회</td><td>최우수상</td><td>이 * 훈</td></tr>
								<tr><td class="ta_left">대학생 신용보증기금 창업아이템 경진대회</td><td>최우수상</td><td>이 * 훈</td></tr>
								<tr><td class="ta_left">희망서울 엑스포 공모전</td><td>최우수상</td><td>양 * 지</td></tr>
								<tr><td class="ta_left">3필착 그림영상 공모전</td><td>우수상</td><td>강 * 수, 이 * 진 외</td></tr>
								<tr><td class="ta_left">함께 여는 아름다운 세상 대학생 사회공헌 광고 공모전</td><td>우수상</td><td>김 * 성</td></tr>
								<tr><td class="ta_left">㈜나눔로또 대학(원)생 홍보 아이디어 & 포스터 공모전</td><td>우수상</td><td>이 * 범, 한 * 범 외</td></tr>
								<tr><td class="ta_left">블랙스미스 아이디어 공모전</td><td>우수상</td><td>현 * 수</td></tr>
								<tr><td class="ta_left">제11회 LH 대학생 광고 공모전 인쇄 광고부문</td><td>장려상</td><td>안 * 영</td></tr>
								<tr><td class="ta_left">글로벌 게임제작 경진대회</td><td>장려상</td><td>유 * 호, 홍 * 욱</td></tr>
								<tr><td class="ta_left">NH농협대학생광고공모전</td><td>장려상</td><td>문 * 이</td></tr>
								<tr><td class="ta_left">제1회 대한민국 인포그래픽 어워드</td><td>특별상</td><td>박 * 은, 김 * 민 외</td></tr>
								<tr><td class="ta_left">LA우표대전</td><td>특선</td><td>김 * 주, 정 * 혁</td></tr>
								<tr><td class="ta_left">제3회 JW중외 영아트 어워드 공모전 일러스트레이션부문</td><td>특선</td><td>차 * 철, 김 * 웅</td></tr>
								<tr><td class="ta_left">제11회 매일신문 광고대상 인쇄 광고부문</td><td>입선</td><td>신 * 식, 이 * 범</td></tr>
								<tr><td class="ta_left">제3회 JW중외 영아트 어워드 공모전 일러스트레이션부문</td><td>입선</td><td>길 * 라, 김 * 호 외</td></tr>
								<tr><td class="ta_left">희망서울 엑스포 공모전</td><td>입선</td><td>강 * 지</td></tr>
								<tr><td class="ta_left">제1회 대한민국 인포그래픽 어워드</td><td>입선</td><td>김 * 훈, 한 * 홍 외</td></tr>
								<tr><td class="ta_left">제1회 대한민국 인포그래픽 어워드</td><td>입선</td><td>박 * 영, 이 * 림 외</td></tr>
								<tr><td class="ta_left">제1회 대한민국 인포그래픽 어워드</td><td>입선</td><td>이 * 우, 김 * 진 외</td></tr>
								<tr><td class="ta_left">제1회 대한민국 인포그래픽 어워드</td><td>입선</td><td>김 * 현, 김 * 호 외</td></tr>
								<tr><td class="ta_left">제1회 대한민국 인포그래픽 어워드</td><td>입선</td><td>김 * 성</td></tr>
								<tr><td class="ta_left">흡연에티켓 광고공모전</td><td>입선</td><td>김 * 주, 김 * 라</td></tr>
								<tr><td class="ta_left">바람직한 간판문화 공모전(UCC)</td><td>입선</td><td>한 * 연, 김 * 솜</td></tr>
								<tr><td class="ta_left">제4회 비락 광고디자인공모전</td><td>입선</td><td>안 * 영, 정 * 혁 외</td></tr>
								<tr><td class="ta_left">제41회 전국대학생 디자인대전</td><td>입선</td><td>박 * 영, 송 * 혜</td></tr>
								<tr><td class="ta_left">전국대학생 디자인과제 공모전</td><td>입선</td><td>남 * 린, 강 * 인</td></tr>
								<tr><td class="ta_left">제3회 바람직한 간판문화 공모전</td><td>입선</td><td>한 * 연, 김 * 솜</td></tr>
								<tr><td class="ta_left">국토해양부 홍보 공모전 인쇄광고</td><td>입선</td><td>최 * 훈</td></tr>
								<tr><td class="ta_left">대학(원)생 사회공헌 광고 공모전</td><td>우수상</td><td>김 * 성</td></tr>
								<tr><td class="ta_left">샘표간장 노래자랑 UCC</td><td>너무프로상</td><td>김 * 래</td></tr>
								<tr><td class="ta_left">커뮤니케이션디자인국제공모전</td><td>입선</td><td>이 * 연</td></tr>
								<tr><td class="ta_left">제4회 비만예방디자인공모전</td><td>입선</td><td>이 * 희, 이 * 원 외</td></tr>
								<tr><td class="ta_left">전국 대학생 디자인공모전</td><td>특선</td><td>정 * 도, 조 * 선</td></tr>
								<tr><td class="ta_left">전국 대학생 디자인공모전</td><td>입선</td><td>백 * 화, 백 * 연 외</td></tr>
								<tr><td class="ta_left">신용보증기금 대학생 광고공모전</td><td>장려상</td><td>김 * 성, 이 * 범 외</td></tr>
								<tr><td class="ta_left">안전보건 UCC공모전</td><td>입선</td><td>양 * 국</td></tr>
								<tr><td class="ta_left">제7회 즐거운환경UCC공모전</td><td>우수상</td><td>박 * 은, 조 * 은</td></tr>
								<tr><td class="ta_left">헌혈 공모전</td><td>생명나눔상</td><td>박 * 호, 이 * 아 외</td></tr>
								<tr><td class="ta_left">광동제약 헛개차 ucc공모전</td><td>2등</td><td>박 * 영, 박 * 준</td></tr>
								<tr><td class="ta_left">바이오아트 콘테스트</td><td>입선</td><td>양 * 국</td></tr>
								<tr><td class="ta_left">광주 광역시 안전UCC공모전</td><td>안전상</td><td>이 * 호, 김 * 림</td></tr>
								<tr><td class="ta_left">첼로 UCC CONTEST</td><td>우수상</td><td>최 * 민, 이 * 호 외</td></tr>
								<tr><td class="ta_left">국립국악원UCC공모전</td><td>우수상</td><td>박 * 열, 최 * 우 외</td></tr>
								<tr><td class="ta_left">가스안전 디자인공모전</td><td>입선</td><td>박 * 나</td></tr>
								<tr><td class="ta_left">THINK SAFETY UCC공모전</td><td>동상</td><td>박 * 호, 배 * 미</td></tr>
								<tr><td class="ta_left">전문병원홍보물 공모전</td><td>금상</td><td>최 * 우, 박 * 연</td></tr>
								<tr><td class="ta_left">인천광역시 치매인식개선 사진 및 UCC 공모전</td><td>장려상</td><td>김 * 림, 서 * 주</td></tr>
								<tr><td class="ta_left">아주특별한나눔BI공모전</td><td>입선</td><td>오 * 빈</td></tr>
								<tr><td class="ta_left">UGIZ 1ST 티셔츠 그래픽디자인공모전</td><td>최우수상</td><td>신 * 경</td></tr>
								<tr><td class="ta_left">디자인레이스 프리스타일 디자인아트 공모전</td><td>우수상</td><td>주 * 림</td></tr>
								<tr><td class="ta_left">대한민국 지역특산 명품브랜드 공모전</td><td>한국지역 진흥재단 이사장상</td><td>이 * 호, 채 * 병 외</td></tr>
								<tr><td class="ta_left">첼로 UCC CONTEST</td><td>우수상</td><td>최 * 민, 이 * 호 외</td></tr>
								<tr><td class="ta_left">제2회 대학생 그림책 공모전</td><td>입선</td><td>홍 * 수</td></tr>
								<tr><td class="ta_left">제1회 얼바인 아웃도어웨어 디자인 공모전</td><td>최우수상</td><td>임 * 하, 김 * 은</td></tr>
								<tr><td class="ta_left">제1회 Yo-콘테스트 유니폼디자인 공모전</td><td>금상</td><td>권 * 라</td></tr>
								<tr><td class="ta_left">제2회 아웃도어웨어디자인 공모전</td><td>장려상</td><td>배 * 린</td></tr>
								<tr><td class="ta_left">제2회 아웃도어웨어디자인 공모전</td><td>장려상</td><td>이 * 형</td></tr>
								<tr><td class="ta_left">YDP 패션일러스트레이션 공모전</td><td>입선</td><td>김 * 은</td></tr>
								<tr><td class="ta_left">YDP 패션일러스트레이션 공모전</td><td>입선</td><td>김 * 우</td></tr>
								<tr><td class="ta_left">해외인턴쉽개발 국비지원프로그램</td><td>미국 국비지원 장학생 선발</td><td>이 * 이</td></tr>
								<tr><td class="ta_left">패션상품기획콘테스트</td><td>장려상</td><td>조 * 비, 양 * 정</td></tr>
								<tr><td class="ta_left">웨딩드레스디자인공모전</td><td>특선</td><td>권 * 기</td></tr>
								<tr><td class="ta_left">넥타이디자인공모전</td><td>입선</td><td>이 * 라, 유 * 라</td></tr>
								<tr><td class="ta_left">임부복디자인공모전</td><td>입선</td><td>류 * 은</td></tr>
								<tr><td class="ta_left">서울 국제일러스트레이션공모전</td><td>입선</td><td>윤 * 혜</td></tr>
								<tr><td class="ta_left">아웃도어웨어디자인 공모전</td><td>입선</td><td>박 * 훈, 이 * 재 외</td></tr>
								<tr><td class="ta_left">부산국제일러스트레이션공모전</td><td>입선</td><td>강 * 영, 김 * 리</td></tr>
								<tr><td class="ta_left">부산국제일러스트레이션공모전</td><td>입선</td><td>나 * 희, 이 * 라</td></tr>
								<tr><td class="ta_left">행복디자인공모전 -패션상품디자인부문</td><td>특선</td><td>김 * 민</td></tr>
								<tr><td class="ta_left">THINK SAFETY UCC 공모전</td><td>동상</td><td>박 * 호, 배 * 미</td></tr>
								<tr><td class="ta_left">CJ 대학생 브랜드디자인 공모전</td><td>특별상</td><td>신 * 경</td></tr>
								<tr><td class="ta_left">CJ 대학생 브랜드디자인 공모전</td><td>특선</td><td>오 * 빈, 최 * 선</td></tr>
								<tr><td class="ta_left">CJ 대학생 브랜드디자인 공모전</td><td>입선</td><td>정 * 도, 김 * 수 외</td></tr>
								<tr><td class="ta_left">CJ 대학생 브랜드디자인 공모전</td><td>입선</td><td>임 * 규, 이 * 훈 외</td></tr>
								<tr><td class="ta_left">CJ 대학생 브랜드디자인 공모전</td><td>입선</td><td>조 * 영, 김 * 희 외</td></tr>
								<tr><td class="ta_left">맘스터치 “먹스코리아” UCC 공모전</td><td>우수상</td><td>김 * 래</td></tr>
								<tr><td class="ta_left">패션상품기획콘테스트</td><td>장려상</td><td>양 * 정</td></tr>
								<tr><td class="ta_left">넥타이 디자인 공모전</td><td>특선</td><td>우 * 희</td></tr>
								<tr><td class="ta_left">넥타이 디자인 공모전</td><td>입선</td><td>정 * 진</td></tr>
								<tr><td class="ta_left">넥타이 디자인 공모전</td><td>입선</td><td>조 * 빛</td></tr>
								<tr><td class="ta_left">넥타이 디자인 공모전</td><td>입선</td><td>채 * 민</td></tr>
								<tr><td class="ta_left">YDP 일러스트레이션 공모전</td><td>입선</td><td>김 * 지</td></tr>
								<tr><td class="ta_left">YDP 일러스트레이션 공모전</td><td>입선</td><td>문 * 수</td></tr>
								<tr><td class="ta_left">YDP 일러스트레이션 공모전</td><td>입선</td><td>최 * 영</td></tr>
								<tr><td class="ta_left">YDP 일러스트레이션 공모전</td><td>입선</td><td>최 * 정</td></tr>
								<tr><td class="ta_left">YDP 일러스트레이션 공모전</td><td>입선</td><td>최 * 진</td></tr>
								<tr><td class="ta_left">부산 국제일러스트레이션 공모전</td><td>특선</td><td>강 * 영</td></tr>
								<tr><td class="ta_left">부산 국제일러스트레이션 공모전</td><td>입선</td><td>나 * 희</td></tr>
								<tr><td class="ta_left">부산 국제일러스트레이션 공모전</td><td>입선</td><td>조 * 빛</td></tr>
								<tr><td class="ta_left">부산 국제일러스트레이션 공모전</td><td>입선</td><td>권 * 기</td></tr>
								<tr><td class="ta_left">국제 니트아트 소재 공모전</td><td>특선</td><td>김 * 이</td></tr>
								<tr><td class="ta_left">국제 니트아트 소재 공모전</td><td>특선</td><td>서 * 현</td></tr>
								<tr><td class="ta_left">국제 니트아트 소재 공모전</td><td>입선</td><td>정 * 영</td></tr>
								<tr><td class="ta_left">국제 니트아트 소재 공모전</td><td>입선</td><td>문 * 수</td></tr>
								<tr><td class="ta_left">국제 니트아트 소재 공모전</td><td>입선</td><td>승 * 림</td></tr>
								<tr><td class="ta_left">국제 니트아트 소재 공모전</td><td>입선</td><td>곽 * 빈</td></tr>
								<tr><td class="ta_left">국제 니트아트 소재 공모전</td><td>입선</td><td>장 * 진</td></tr>
								<tr><td class="ta_left">한지섬유패션 디자인경진대회 지식경제부</td><td>입선</td><td>문 * 수</td></tr>
								<tr><td class="ta_left">한지섬유패션 디자인경진대회 지식경제부</td><td>입선</td><td>이 * 연</td></tr>
								<tr><td class="ta_left">국제넥타이디자인공모전</td><td>특선</td><td>김 * 은</td></tr>
								<tr><td class="ta_left">국제넥타이디자인공모전</td><td>입선</td><td>안 * 환</td></tr>
								<tr><td class="ta_left">국제넥타이디자인공모전</td><td>입선</td><td>최 * 진</td></tr>
								<tr><td class="ta_left">제6회 부산 국제 패션일러스트레이션 공모전</td><td>특선</td><td>임 * 하</td></tr>
								<tr><td class="ta_left">제6회 부산 국제 패션일러스트레이션 공모전</td><td>특선</td><td>김 * 은</td></tr>
								<tr><td class="ta_left">제6회 부산 국제 패션일러스트레이션 공모전</td><td>입선</td><td>최 * 혜</td></tr>
								<tr><td class="ta_left">YDP 패션일러스트레이션 공모전</td><td>특선</td><td>김 * 리</td></tr>
								<tr><td class="ta_left">YDP 패션일러스트레이션 공모전</td><td>특선</td><td>안 * 솔</td></tr>
								<tr><td class="ta_left">국제니팅아트디자인 공모전</td><td>소재부문 입선</td><td>류 * 은</td></tr>
								<tr><td class="ta_left">국제니팅아트디자인 공모전</td><td>소재부문 입선</td><td>염 * 주</td></tr>
								<tr><td class="ta_left">국제니팅아트디자인 공모전</td><td>소재부문 입선</td><td>양 * 윤</td></tr>
								<tr><td class="ta_left">국제니팅아트디자인 공모전</td><td>소재부문 입선</td><td>이 * 진</td></tr>
								<tr><td class="ta_left">국제니팅아트디자인 공모전</td><td>소재부문 입선</td><td>이 * 라</td></tr>
								<tr><td class="ta_left">국제니팅아트디자인 공모전</td><td>소재부문 입선</td><td>이 * 희</td></tr>
								<tr><td class="ta_left">국제니팅아트디자인 공모전</td><td>소재부문 특선</td><td>우 * 희</td></tr>
								<tr><td class="ta_left">농업농촌 PRDP UCC공모전</td><td>최우수상</td><td>박 * 준, 서 * 우 외</td></tr>
								<tr><td class="ta_left">the 5th korea beauty health society international beauty art exhibition</td><td>대상</td><td>김 * 민</td></tr>
								<tr><td class="ta_left">the 6th korea beauty health society international beauty art exhibition</td><td>은상</td><td>김 * 정</td></tr>
								<tr><td class="ta_left">the 7th korea beauty health society international beauty art exhibition</td><td>우수상</td><td>박 * 미</td></tr>
								<tr><td class="ta_left">the 8th korea beauty health society international beauty art exhibition</td><td>우수상</td><td>김 * 민</td></tr>
								<tr><td class="ta_left">the 9th korea beauty health society international beauty art exhibition</td><td>우수상</td><td>최 * 영</td></tr>
								<tr><td class="ta_left">the 10th korea beauty health society international beauty art exhibition</td><td>우수상</td><td>권 * 리</td></tr>
								<tr><td class="ta_left">the 11th korea beauty health society international beauty art exhibition</td><td>우수상</td><td>맹 * 영</td></tr>
								<tr><td class="ta_left">the 12th korea beauty health society international beauty art exhibition</td><td>우수상</td><td>김 * 진</td></tr>
								<tr><td class="ta_left">안산대학교총장배 제 5회 전국미용 공모전</td><td>대상</td><td>한 * 지</td></tr>
								<tr><td class="ta_left">안산대학교총장배 제 5회 전국미용 공모전</td><td>금상</td><td>백 * 희</td></tr>
								<tr><td class="ta_left">안산대학교총장배 제 5회 전국미용 공모전</td><td>우수상</td><td>박 * 진</td></tr>
								<tr><td class="ta_left">안산대학교총장배 제 5회 전국미용 공모전</td><td>우수상</td><td>김 * 선</td></tr>
								<tr><td class="ta_left">안산대학교총장배 제 5회 전국미용 공모전</td><td>우수상</td><td>최 * 옥</td></tr>
								<tr><td class="ta_left">안산대학교총장배 제 5회 전국미용 공모전</td><td>우수상</td><td>변 * 정</td></tr>
								<tr><td class="ta_left">안산대학교총장배 제 5회 전국미용 공모전</td><td>우수상</td><td>김 * 혜</td></tr>
								<tr><td class="ta_left">제4회 미추헤어쇼 미용경연대회 네일아트 부문</td><td>대상</td><td>임 * 명</td></tr>
								<tr><td class="ta_left">제4회 미추헤어쇼 미용경연대회 네일아트 부문</td><td>금상</td><td>유 * 아</td></tr>
								<tr><td class="ta_left">제4회 미추헤어쇼 미용경연대회 네일아트 부문</td><td>은상</td><td>유 * 란</td></tr>
								<tr><td class="ta_left">제8회국제네일디자인컨테스트</td><td>은상</td><td>유 * 아</td></tr>
								<tr><td class="ta_left">제8회국제네일디자인컨테스트</td><td>특별상</td><td>엄 * 비</td></tr>
								<tr><td class="ta_left">제8회국제네일디자인컨테스트</td><td>그랜드챔피언</td><td>유 * 란</td></tr>
								<tr><td class="ta_left">대체미용요법 엑스포 콘테스트</td><td>은상</td><td>임 * 연</td></tr>
								<tr><td class="ta_left">전국 일러스트 공모전</td><td>장려상</td><td>이 * 화</td></tr>
								<tr><td class="ta_left">제5회 대한민국 국제뷰티문화예술 기능대회 스킨아트부문</td><td>그랑프리</td><td>강 * 옥</td></tr>
								<tr><td class="ta_left">제5회 대한민국 국제뷰티문화예술 기능대회 스킨아트부문</td><td>대상</td><td>엄 * 비</td></tr>
								<tr><td class="ta_left">식품첨가물 바로알기 UCC,POSTER 공모전</td><td>최우수상</td><td>전 * 연, 이 * 경</td></tr>
								<tr><td class="ta_left">식품첨가물 바로알기 UCC,POSTER 공모전</td><td>우수상</td><td>이 * 은, 윤 * 수</td></tr>
								<tr><td class="ta_left">식품첨가물 바로알기 UCC,POSTER 공모전</td><td>장려상</td><td>최 * 재, 김 * 윤</td></tr>
								<tr><td class="ta_left">제2회 아웃도어웨어디자인 공모전</td><td>장려상</td><td>서 * 현</td></tr>
								<tr><td class="ta_left">제2회 아웃도어웨어디자인 공모전</td><td>특선</td><td>이 * 이</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>장려상</td><td>정 * 주</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>장려상</td><td>정 * 림, 차 * 철</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>장려상</td><td>이 * 연</td></tr>
								<tr><td class="ta_left">제7회 한국 공간 디자인대전</td><td>특별상</td><td>허 * 운, 남 * 주</td></tr>
								<tr><td class="ta_left">제7회 한국 공간 디자인대전</td><td>특선</td><td>백 * 림</td></tr>
								<tr><td class="ta_left">제7회 한국 공간 디자인대전</td><td>장려상</td><td>손 * 수</td></tr>
								<tr><td class="ta_left">제3회 JW중외 영아트 어워드 공모전</td><td>장려상</td><td>백 * 재</td></tr>
								<tr><td class="ta_left">BIDA 인테리어디자인 공모전</td><td>장려상</td><td>나 * 영</td></tr>
								<tr><td class="ta_left">제7회 한국 공간 디자인대전</td><td>우수상</td><td>윤 * 니, 문 * 솔</td></tr>
								<tr><td class="ta_left">제13회 싼타페 광고 공모전 인쇄 광고부문</td><td>입선</td><td>김 * 란, 윤 * 늘</td></tr>
								<tr><td class="ta_left">행복디자인공모전 -패션상품디자인부문</td><td>특선</td><td>우 * 희</td></tr>
								<tr><td class="ta_left">국제니팅아트디자인 공모전</td><td>소재부문 입선</td><td>나 * 희</td></tr>
								<tr><td class="ta_left">제17회 전통문양디자인공모전</td><td>장려상</td><td>최 * 정</td></tr>
								<tr><td class="ta_left">제17회 전통문양디자인공모전</td><td>특선</td><td>정 * 연</td></tr>
								<tr><td class="ta_left">제17회 전통문양디자인공모전</td><td>특선</td><td>고 * 재</td></tr>
								<tr><td class="ta_left">제17회 전통문양디자인공모전</td><td>특선</td><td>김 * 경</td></tr>
								<tr><td class="ta_left">제1회 에비수 IDEA UCC 광고공모전</td><td>우수상</td><td>김 * 식, 김 * 현</td></tr>
								<tr><td class="ta_left">새 우편번호 알리기 UCC&로고송 공모전</td><td>동상</td><td>김 * 야, 노 * 정 외</td></tr>
								<tr><td class="ta_left">헌법사랑 공모전</td><td>은상</td><td>오 * 택, 박 * 연 외</td></tr>
								<tr><td class="ta_left">화폐사랑 UCC 공모전</td><td>장려상</td><td>전 * 연</td></tr>
								 -->
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