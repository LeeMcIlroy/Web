<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko" >
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">

function detailView(status, title){
	
	var url = '';
	if(status == '01'){
		url = '';
	}else if(status == '02'){
		url = 'https://edulms.hansung.ac.kr/application/application_search.php';
	}else if(status == '03'){
		url = 'https://edulms.hansung.ac.kr/application/application_pass_check.php';
	}
	var tags = "";
		tags += '<div class="pop_pw" style="display:block;">';
		tags += '	<div class="pop_frame">';
		tags += '		<iframe src="'+url+'" name="iframe_online" title="'+title+' 상세보기" frameborder="0"></iframe>';
		tags += '		<div class="frame_close" >';
		tags += '			<label for="pop_close" onclick="fn_appliForm_close(); return false;">X</label>';
		tags += '		</div>';
		tags += '	</div>';
		tags += '</div>';
		
		$(".content").append(tags);
		
	}
</script>
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
				<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="진로체험"/>
		            <jsp:param name="dept2" value="진로체험안내"/>
	           	</jsp:include>
				<%-- <div class="top_tab type_li2">
					<ul>
						<li <c:if test="${searchVO.menuType eq '01' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/general/exper/experInfo.do?menuType=01'/>">디자인분야 진로체험 안내</a></li>
						<li <c:if test="${searchVO.menuType eq '02' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/general/exper/experInfo.do?menuType=02'/>">진로체험연혁</a></li>
					</ul>
				</div> --%>
				
				<c:if test="${searchVO.menuType eq '01' }">
					<!--<ol class="ag_box">
						<li>디자인분야 진로체험 안내
							<dl>
								<dt>1. 내용</dt>
								<dd>
									- 디자인과 패션 그리고 뷰티 분야 진로교육 총 17분야
									<table class="ta874_ty04" style="width: 800px;">
										<colgroup>
											<col style="width: 50%;" />
											<col style="width: 50%;" />
										</colgroup>
										<thead>
											<tr style="height: 50px;">
												<th scope="col">IT융합 디자인분야 진로교육(총 11개 분야)</th>
												<th scope="col">패션‧뷰티분야 진로교육(총 6개 분야)</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>
													그래픽디자이너 / 패키지디자이너 / 동화일러스트작가 /<br>
													아트북디자이너 / 웹코딩(웹디자인) / 웹툰(만화)작가 /<br>
													영상디자이너 / 제품‧리빙디자이너 / 인테리어디자이너 <br>
													주얼리디자이너(<font style="color: red;">고등학생만 가능</font>)/자동차디자인
												</td>
												<td>
													패션디자인/패션스타일리스트(패션마케터)/ <br>
													뷰티코디네이터(메이크업)/헤어코디네이터/네일아트/<br>
													피부코디네이터
												</td>
											</tr>
										</tbody>
									</table>
								</dd>
							</dl>
							<dl>
								<dt>2. 장소 : 한성대학교 한디원</dt>
								<dd>
									- 2017년 부산내성고, 개운중, 서울사대부고, 삼선중, 한성여고 등 100회 진로프로그램 운영<br>
									- 2016 미래창창 진로박람회, 2017 미래 방송인 박람회 참여<br>
									- 디자인·패션·뷰티 분야 전문 교수진이 직접 프로그램 운영 
								</dd>
							</dl>
							<dl>
								<dt>3. 교육 비용 : 1인당 1만원(유동성이 있을 수 있으니 접수 시 문의 바람)</dt>
								<dd></dd>
							</dl>
							<dl>
								<dt>4. 한디원과 함께하는 대학 진로프로그램 일정</dt>
								<dd>
									<table class="ta874_ty04" style="width: 800px;">
										<colgroup>
											<col style="width: 20%;" />
											<col style="width: 20%;" />
											<col style="width: 60%;" />
										</colgroup>
										<thead>
											<tr style="height: 50px;">
												<th scope="col">구분</th>
												<th scope="col">일정</th>
												<th scope="col">내용</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>진로캠프</td>
												<td>2월/8월</td>
												<td class="ta_left">
													- 3일간 진행(하루 5시간 수업)<br>
													&nbsp;&nbsp;2018년은 2월20 ~ 22일 진행<br>
													- 고등학생 대상
												</td>
											</tr>
											<tr>
												<td>진로스쿨</td>
												<td>
													학기중 진행<br>
													1학기 : 3 ~ 7월<br>
													2학기 : 9 ~ 12월
												</td>
												<td class="ta_left" style="border-right: 0;'">
													- 강북 : 성북(미래창창) 진로센터<br>
													- 강남 : 동작구(두드림) 진로센터 문의<br>
													- 또는 직접문의(02-760-5781)
												</td>
											</tr>
										</tbody>
									</table>
								</dd>
							</dl>
							<dl>
								<dt><font color="red">(*중학교는 기초과정부터 신청하시기 바랍니다.)</font></dt>
								<dd><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo1_img1.jpg" style="margin-top: 10px; width: 100%;"></dd>
								<dd><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo1_img2.jpg" style="margin-top: 10px; width: 100%;"></dd>
							</dl>
						</li>
 					</ol> -->
 					
 					<!-- 0408추가 -->
 					<div class="sub_cont_page">
					<dl class="info_dl">
						<dd>
							<p><label style="font-weight: bold;">○ 진로체험 프로그램 특징</label><br/>
							  &nbsp;&nbsp;&nbsp;-한디원만의 세분화된 커리큘럼을 가진 다양한 프로그램을 통해 학생의 디자인분야 직업 이해를 돕고 현직 실무자, 전문가와 함께하는 실습 중심의   &nbsp;&nbsp;&nbsp;&nbsp;교육을 통해 학생의 진로 탐색과 직업 선택을 도움 </p>
						</dd><dd>
							<p><label style="font-weight: bold;">○ 진로체험 프로그램 안내</label><br/>
							  &nbsp;&nbsp;&nbsp;-진로체험: 학기중 1일 체험<br/>
							  &nbsp;&nbsp;&nbsp;-진로학기: 학기중(3~7월, 9~12월) 10주 심화 체험 <br/>
							  &nbsp;&nbsp;&nbsp;-진로캠프: 방중(2,8월) 2박3일 체험<br/></p>
						</dd>
					</dl>
					<br>
					<br>
					<dl>
							<dt style="font-weight: bold;"> ○ 진로체험 프로그램 구성</dt>
							<br>
								<dd>
									<table class="ta874_ty09">
									<colgroup>
										<col width="30%"/>
										<col />
										<%-- <col width="20%"/> --%>
									</colgroup>
									<thead>
										<tr style="height: 40px;">
											<th scope="col" colspan="3">디자인(IT융합)</th>
										</tr>
										<tr style="height: 30px;">
											<th scope="col">전공</th>
											<th scope="col">내용</th>
											<!-- <th scope="col">커리큘럼</th> -->
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>실내디자인</td>
											<td>
												인테리어디자이너<br/>
												크리에이티브 건축디자이너 <br/>
												스마트 빌딩 디자이너  <br/>
												무대연출디자이너 <br/>
											</td>
<!-- 											<td class="btn_box "><a href="" type="button" onclick="detailView('01','실내디자인'); return false;" class="btn_go_list">상세보기</a></td> -->
										</tr>
										<tr>
											<td>시각디자인</td>
											<td>
												미디어그래픽디자이너 <br/>
												스마트패키징디자이너 <br/>
												동화일러스트작가 <br/>
												북아트미디어디자이너 <br/>
												웹코딩(웹디자이너)  <br/>
												타이포그래픽디자이너 <br/>
												콘텐츠광고매체자이너 <br/>
												모바일캐릭터디자이너 <br/>
												엔터테인먼트 아트워크(예술가)   <br/>
											</td>
<!-- 											<td class="btn_box "><a href="" type="button" onclick="detailView('01','시각디자인'); return false;" class="btn_go_list">상세보기</a></td> -->
										</tr>
										<tr>
											<td>산업디자인</td>
											<td>
												스마트 자동차디자이너 <br/>
												이두이노제품디자이너금속주얼리 디자이너(<label style="color: red;">고등학생 이상 신청</label>) <br/>
												라이프스타일디자이너 <br/>
											</td>
<!-- 											<td class="btn_box "><a href="" type="button" onclick="detailView('01','산업디자인'); return false;" class="btn_go_list">상세보기</a></td> -->
										</tr>
										<tr>
											<td>디지털아트</td>
											<td>
												유튜버(크리에이터) <br/>
												웹툰(만화) 크리에이터  <br/>
												영상미디어디자이너 <br/>										
												e 스포츠(준비중) <br/>
											</td>
<!-- 											<td class="btn_box "><a href="" type="button" onclick="detailView('01','디지털아트'); return false;" class="btn_go_list">상세보기</a></td> -->
										</tr>
									</tbody>
								</table>
								</dd><br>
								<dd>
								<table class="ta874_ty09">
									<colgroup>
										<col width="30%"/>
										<col />
<%-- 									<%-- <col width="20%"/> --%> 
									</colgroup>
									<thead>
										<tr style="height: 40px;">
											<th scope="col" colspan="3">패션(IT융합)</th>
										</tr>
										<tr style="height: 30px;">
											<th scope="col">전공</th>
											<th scope="col">내용</th>
<!-- 										<!-- <th scope="col">커리큘럼</th> --> 
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>패션디자인<br>패션 비즈니스</td>
											<td>
												패션디자이너  <br/>
												패션스타일리스트 <br/>  
												디지털 패션크리에이터 <br/>
											</td>
<!-- 											<td class="btn_box "><a href="" type="button" onclick="detailView('01','패션디자인/패션 비즈니스'); return false;" class="btn_go_list">상세보기</a></td> -->
										</tr>
									</tbody>
								</table>
								</dd><br>
								<dd>
								<table class="ta874_ty09">
									<colgroup>
										<col width="30%"/>
										<col />
										<%-- <col width="20%"/> --%>
									</colgroup>
									<thead>
										<tr style="height: 40px;">
											<th scope="col" colspan="3">뷰티(IT융합)</th>
										</tr>
										<tr style="height: 30px;">
											<th scope="col">전공</th>
											<th scope="col">내용</th>
											<!-- <th scope="col">커리큘럼</th> -->
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>미용학</td>
											<td>
												AI메디컬스킨테어 <br/>
												AI스마트 메이크업 컨설턴트  <br/>
												뷰티크리에이터 <br/>
												퍼스널컬러네일아티스트  <br/>
												화장품브랜딩디자이너  <br/>
											</td>
<!-- 											<td class="btn_box "><a href="" type="button" onclick="detailView('01','미용학'); return false;" class="btn_go_list">상세보기</a></td> -->
										</tr>
									</tbody>
								</table>
								</dd>
							</dl>
							<br/>
							<div style="color: #FF0000; float: left; text-align: left;" class="btn_box">* 성우, 모델, 아나운서 프로그램은 진로캠프에만 추가 개설 &nbsp;
<!-- 							<a href="" type="button" class=" btn_go_list" style="width: 70px; height: 25px; line-height: 25px;">상세보기</a> -->
							</div>
					</div> 					
				</c:if>
				<c:if test="${searchVO.menuType eq '02' }">
					<!--<ol class="ag_box">
						<li>IT 융합 디자인
							<dl>
								<dt>1. 그래픽 디자이너</dt>
								<dd>- 대상 : 중/고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr style="border-top: 0;">
													<td rowspan="3" style="border-left: 0;">고등학생</td>
													<td>중급A</td>
													<td>그래픽디자인</td>
													<td class="ta_left">
														오리엔테이션 및 그래픽디자이너 소개<br>
														포토샵 활용<br>
														앨범 자켓 만들기<br>
														기념 카드 만들기
													</td>
													<td></td>
												</tr>
												<tr>
													<td>중급B</td>
													<td>그래픽디자인</td>
													<td class="ta_left">
														오리엔테이션 및 그래픽디자이너 소개<br>
														포토샵 활용<br>
														영화 포스터 만들기
													</td>
													<td></td>
												</tr>
												<tr>
													<td>중급C</td>
													<td>그래픽디자인</td>
													<td class="ta_left">
														오리엔테이션 및 그래픽디자이너 소개<br>
														포토샵 / 일러스트레이션 활용<br>
														이미지와 타이포그래피 적용<br>
														아트 포스터 만들기
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td style="border-left: 0;">고등학생</td>
													<td>고급A</td>
													<td>그래픽디자인</td>
													<td class="ta_left">
														오리엔테이션 및 그래픽디자이너 소개<br>
														포토샵 / 일러스트레이션 활용<br>
														그래픽디자인과 레이아웃 구성<br>
														아트 포스터 만들기 / 시리즈 디자인
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd>
									<img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img1.jpg" style="margin-top: 10px; width: 100%;">
								</dd>
							</dl>
							<dl>
								<dt>2. 패키지 디자이너</dt>
								<dd>- 대상 : (초)중학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">(초)중학생</td>
													<td>초급A</td>
													<td>패키지디자이너</td>
													<td class="ta_left">
														오리엔테이션 및 패키지디자인 소개<br>
														패키지에 그래픽 요소 구성하기<br>
														(패턴을 만들어 패키지 디자인 만들기)
													</td>
													<td></td>
												</tr>
												<tr>
													<td>초급B</td>
													<td>패키지디자이너</td>
													<td class="ta_left">
														오리엔테이션 및 패키지디자인 소개<br>
														패키지에 그래픽 요소 구성하기<br>
														(그림을 이용한 패키지 디자인 만들기) 
													</td>
													<td></td>
												</tr>
												<tr>
													<td>초급C</td>
													<td>패키지디자이너</td>
													<td class="ta_left">
														오리엔테이션 및 패키지디자인 소개<br>
														팝업 형식의 패키지 디자인 만들기<br>
														(펼쳐지는 입체적인 패키지 디자인 만들기)
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 중/고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="2" style="border-left: 0;">중/고등학생</td>
													<td>중급A</td>
													<td>패키지디자이너</td>
													<td class="ta_left">
														오리엔테이션 및 패키지디자인 소개<br>
														디자인 ideation &amp; sketch:패키지 구성 그래픽 요소 만들기<br> 
														패키지 디자인 제작하기
													</td>
													<td></td>
												</tr>
												<tr>
													<td>중급B</td>
													<td>패키지디자이너</td>
													<td class="ta_left">
														오리엔테이션 및 패키지디자인 소개<br>
														디자인 ideation &amp; sketch:패키지 구성 그래픽 요소 만들기<br> 
														지기구조 만들어 구성하고 제작하기 
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td style="border-left: 0;">고등학생</td>
													<td>고급A</td>
													<td>패키지디자이너</td>
													<td class="ta_left">
														오리엔테이션 및 패키지디자인 소개<br>
														프로젝트 주제 설정 및 컨셉 설정<br>
														디자인 ideation &amp; sketch:패키지 구성 그래픽 요소 만들기<br>  
														브랜드 패키지디자인 제작하기<br>
														브랜드 패키지 쇼핑백 제작하기
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
							</dl>
							<dl>
								<dt>3. 동화일러스트작가</dt>
								<dd>- 대상 : (초)중학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">(초)중학생</td>
													<td>초급A</td>
													<td>동화일러스트작가</td>
													<td class="ta_left">
														동화책&그림책 일러스트레이션의 이야기 세계<br> 
														(스토리텔링, 이야기 창작 스튜디오)
													</td>
													<td>재료 : 필기도구</td>
												</tr>
												<tr>
													<td>초급B</td>
													<td>동화일러스트작가</td>
													<td class="ta_left">
														동화책&그림책 일러스트레이션의 이미지 세계<br> 
														(일러스트레이션 창작 스튜디오)
													</td>
													<td></td>
												</tr>
												<tr>
													<td>초급C</td>
													<td>동화일러스트작가</td>
													<td class="ta_left">
														동화책 &amp; 그림책 제작의 과정<br> 
														(책 커버 제작 스튜디오)
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 중/고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="2" style="border-left: 0;">중/고등학생</td>
													<td>중급A</td>
													<td>동화일러스트작가</td>
													<td class="ta_left">
														동화책 &amp; 그림책 이야기 상상하기<br>
														(스토리텔링과 스토리보드 제작 실험)
													</td>
													<td></td>
												</tr>
												<tr>
													<td>중급B</td>
													<td>동화일러스트작가</td>
													<td class="ta_left">
														동화책 &amp; 그림책 이미지 창작하기<br> 
														(창의적 일러스트레이션 표현 실험) 
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td style="border-left: 0;">고등학생</td>
													<td>고급A</td>
													<td>동화일러스트작가</td>
													<td class="ta_left">
														동화책 &amp; 그림책의 특별한 세계<br> 
														(팝업 그림책 제작과 책 커버 창작 실험)
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd>
									<img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img3.jpg" style="margin-top: 10px; width: 100%;">
								</dd>
							</dl>
							<dl>
								<dt>4. 아트북디자이너</dt>
								<dd>- 대상 : 초/중학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="2" style="border-left: 0;">(초)중학생</td>
													<td>초급A</td>
													<td>아트북</td>
													<td class="ta_left">
														오리엔테이션 및 아트북디자인 소개<br>
														팝업 카드 만들기
													</td>
													<td>만들기재료</td>
												</tr>
												<tr>
													<td>초급B</td>
													<td>아트북제작</td>
													<td class="ta_left">
														오리엔테이션 및 아트북디자인 소개<br>
														아트북 만들기 / 중철 노끈 활용 북만들기
													</td>
													<td>만들기재료</td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 중/고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">중/고등학생</td>
													<td>중급A</td>
													<td>
														북디자니어<br>
														(아트북)
													</td>
													<td class="ta_left">
														오리엔테이션 및 아트북디자인 소개<br>
														아트북 만들기 / 중철 노끈 활용 북만들기
													</td>
													<td>만들기재료</td>
												</tr>
												<tr>
													<td>중급B</td>
													<td>북디자이너</td>
													<td class="ta_left">
														오리엔테이션 및 아트북디자인 소개<br>
														아트북 만들기 / 떡제본 책자 만들기<br>
														북디자인 구성하기 
													</td>
													<td>만들기재료</td>
												</tr>
												<tr>
													<td>중급C</td>
													<td>
														북디자이너<br>
														(디지털)
													</td>
													<td class="ta_left">
														오리엔테이션 및 북디자이너 소개<br>
														북편집디자인 이해<br>
														편집디자인 구성<br>
														책디자인 프린팅 및 디지털 잡지 제작 
													</td>
													<td>
														컴퓨터<br> 
														인디자인
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="2" style="border-left: 0;">고등학생</td>
													<td>고급A</td>
													<td>
														북편집디자인<br>
														(디지털)
													</td>
													<td class="ta_left">
														오리엔테이션 및 북디자이너 소개<br>
														북편집디자인 이해<br>
														편집디자인 구성 및 디지털잡지 만들기
													</td>
													<td>
														컴퓨터<br> 
														인디자인
													</td>
												</tr>
												<tr>
													<td>고급B</td>
													<td>
														북편집디자인<br>
														(디지털)
													</td>
													<td class="ta_left">
														오리엔테이션 및 북디자이너 소개<br>
														북편집디자인 이해<br>
														편집디자인 구성 및 디지털 편집디자인 만들기<br>
														그래픽디자인
													</td>
													<td>
														컴퓨터<br> 
														인디자인<br>
														일러스트레이션
													</td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd>
									<img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img4.jpg" style="margin-top: 10px; width: 100%;">
								</dd>
							</dl>
							<dl>
								<dt>5. 웹코딩(웹디자이너)</dt>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td style="border-left: 0;">(초)중학생</td>
													<td>초급A</td>
													<td>웹코딩</td>
													<td class="ta_left">
														오리엔테이션 및 OT<br>
														HTML 언어 입문, 기초 테그연습<br>
														링크걸기, 문서연결하기, 화면 만들기
													</td>
													<td>로컬기반 웹페이지 코딩</td>
												</tr>
												<tr>
													<td style="border-left: 0;">중/고등학생</td>
													<td>중급A</td>
													<td>웹코딩</td>
													<td class="ta_left">
														오리엔테이션 및 OT<br>
														HTML 언어 입문, 기초 테그연습<br>
														이미지 다루기, 문서링크걸기, 컬러 다루기<br>
														웹호스팅
													</td>
													<td>웹호스팅으로 직접 홈페이지 구축(온라인)</td>
												</tr>
												<tr>
													<td style="border-left: 0;">고등학생</td>
													<td>고급A</td>
													<td>웹디자인</td>
													<td class="ta_left">
														오리엔테이션 및 OT<br>
														HTML 언어 입문, 기초 테그연습<br>
														이미지 다루기, 문서링크걸기, 컬러 다루기<br>
														웹스팅을 이용하여 웹디자이너 경험<br>
														스마트폰 연계 수업
													</td>
													<td>웹 저작도구를 이용하여 웹디자이너 체험</td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd>
									<img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img5.jpg" style="margin-top: 10px; width: 100%;">
								</dd>
							</dl>
							<dl>
								<dt>6. 웹툰작가(만화)</dt>
								<dd>- 대상 : (초)중학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="2" style="border-left: 0;">(초)중학생</td>
													<td>초급A</td>
													<td rowspan="2">
														만화콘텐츠<br>
														디자이너(웹툰)
													</td>
													<td class="ta_left">
														<p>1. 디지털프로그램 및 장비 체험</p>
														<p>2. 웹툰제작 기초(캐릭터 스토리텔링)</p>
													</td>
													<td></td>
												</tr>
												<tr>
													<td>초급B</td>
													<td class="ta_left">
														<p>1. 만화 캐릭터 표현 기초 </p>
														<p>2. 캐리커쳐의 기초</p>
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 중/고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="2" style="border-left: 0;">중/고등학생</td>
													<td>중급A</td>
													<td rowspan="2">
														만화콘텐츠<br>
														디자이너(웹툰)
													</td>
													<td class="ta_left">
														<p>1. 디지털프로그램 중급</p>
														<p>2. 웹툰제작 중급(만화 플롯연출)</p>
													</td>
													<td></td>
												</tr>
												<tr>
													<td>초급B</td>
													<td class="ta_left">
														<p>1. 디지털프로그램과 장비를 활용한 캐리커처</p>
														<p>2. 캐릭터 동세 연출</p>
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd>- 대상 : 고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td style="border-left: 0;">고등학생</td>
													<td>고급</td>
													<td rowspan="2">
														만화콘텐츠<br>
														디자이너(웹툰)
													</td>
													<td class="ta_left">
														<p>
															1. 클립스튜디오 프로그램 활용<br>
															- 디지털 컬러링 및 이펙트 기능
														</p>
														<p>2. 웹툰제작 고급(캐릭터 연기연출)</p>
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd>
									<img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img6.jpg" style="margin-top: 10px; width: 100%;">
								</dd>
							</dl>
							<dl>
								<dt>7. 영상디자이너</dt>
								<dd><font color="red">(모든 수업에는 반드시 이어폰, 휴대폰과 PC연결케이블이 필요합니다)</font></dd>
								<dd>- 대상 : (초)중학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">(초)중학생</td>
													<td>초급A</td>
													<td>뮤직비디오 제작자</td>
													<td class="ta_left">
														오리엔테이션 및 프리미어 프로그램 소개<br>
														- 기존 뮤직비디오를 이용한 교차편집
													</td>
													<td></td>
												</tr>
												<tr>
													<td>초급B</td>
													<td>방송영상 제작자</td>
													<td class="ta_left">
														오리엔테이션 및 프리미어 프로그램 소개<br>
														- 간단한 스토리를 만들어 인터넷에서 찾을 수 있는 이미지와 영상을 사용해서 지식채널e와 같은 방송영상제작
													</td>
													<td></td>
												</tr>
												<tr>
													<td>초급C</td>
													<td>스톱모션 제작자</td>
													<td class="ta_left">
														오리엔테이션 및 프리미어 프로그램 소개<br>
														- 주변에서 볼수 있는 소품을 이용 핸드폰으로 촬영하여 스톱모션 애니메이션 제작(핸드폰과 컴퓨터를 연결할 수 있는 케이블 필요)
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 중/고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">중/고등학생</td>
													<td>중급A</td>
													<td>뮤직비디오 제작자</td>
													<td class="ta_left">
														오리엔테이션 및 프리미어 프로그램 소개<br>
														- 기존 뮤직비디오에 본인 촬영영상을 더해 교차편집
													</td>
													<td></td>
												</tr>
												<tr>
													<td>중급B</td>
													<td>방송영상 제작자</td>
													<td class="ta_left">
														오리엔테이션 및 프리미어 프로그램 소개<br>
														- 간단한 스토리를 만들어 인터넷에서 찾을 수 있는 이미지와 영상에 본인 촬영 영상을 더해 지식채널e와 같은 방송영상제작
													</td>
													<td></td>
												</tr>
												<tr>
													<td>중급C</td>
													<td>모션그래픽 영상 디자이너</td>
													<td class="ta_left">
														오리엔테이션 및 AfterEffect 프로그램 소개<br>
														- 툴 사용법과 간단한 애니메이션 사용법 학습
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">고등학생</td>
													<td>고급A</td>
													<td>뮤직비디오 제작자</td>
													<td class="ta_left">
														오리엔테이션 및 프리미어 프로그램 소개<br>
														- 기존 음악의 일부분에 본인이 직접 촬영한 영상을 이용해 편집
													</td>
													<td></td>
												</tr>
												<tr>
													<td>고급B</td>
													<td>방송영상 제작자</td>
													<td class="ta_left">
														오리엔테이션 및 프리미어 프로그램 소개<br>
														- 사회적 이슈에 관련된 스토리를 만들어 인터넷에서 찾을 수 있는 이미지와 영상에 본인 촬영 영상을 더해 지식채널e와 같은 방송영상제작
													</td>
													<td></td>
												</tr>
												<tr>
													<td>고급C</td>
													<td>모션그래픽 영상 디자이너</td>
													<td class="ta_left">
														오리엔테이션 및 AfterEffect 프로그램 소개<br>
														- 타이포를 이용한 간단한 애니메이션 제작
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
							</dl>
							<dl>
								<dt>8. 제품‧리빙디자이너</dt>
								<dd>- 대상 : 초/중학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">(초)중학생</td>
													<td>초급A</td>
													<td>
														제품디자이너<br>
														(3D 프린터 사용)
													</td>
													<td class="ta_left">
														오리엔테이션 및 제품디자이너 소개<br>
														디자이너 ideation &amp; sketch :기본도형 만들기, 3D프린터로 제품만들기 실습
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img8_1.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>초급B</td>
													<td>리빙디자이너</td>
													<td class="ta_left">
														오리엔테이션 및 리빙디자이너 소개<br>
														디자인 ideation &amp; sketch : 공통주제 디자인제작(쿠션, 컵받침 등)
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img8_2.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>초급C</td>
													<td>
														주얼리디자이너<br>
														(비즈공예)
													</td>
													<td class="ta_left">
														오리엔테이션 및 주얼리디자이너 소개<br>
														비즈 주얼리 기초 제작기법 설명<br>
														디자인 제작
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img8_3.jpg" style="width:100%;"></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 중/고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">중/고등학생</td>
													<td>중급A</td>
													<td>
														제품디자이너<br>
														(3D 프린터 사용)
													</td>
													<td class="ta_left">
														오리엔테이션 및 제품디자이너 소개<br>
														디자이너 ideation &amp; sketch :응용도형 만들기, 3D프린터로 제품 출력
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img8_4.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>중급B</td>
													<td>
														리빙디자이너<br>
														(내방꾸미기)
													</td>
													<td class="ta_left">
														오리엔테이션 및 리빙디자이너 소개<br>
														디자인 ideation &amp; sketch : 공통주제 디자인제작(드림캐쳐, 파우치 등)
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img8_5.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>중급C</td>
													<td>
														주얼리디자이너<br>
														(비즈공예)
													</td>
													<td class="ta_left">
														오리엔테이션 및 주얼리디자이너 소개<br>
														비즈 주얼리 중급 제작기법 설명<br>
														디자인 제작
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img8_6.jpg" style="width:100%;"></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">고등학생</td>
													<td>고급A</td>
													<td>
														제품디자이너<br>
														(3D 프린터 사용)
													</td>
													<td class="ta_left">
														오리엔테이션 및 제품디자이너 소개<br>
														디자이너 ideation &amp; sketch :제품디자인 및 3D프린터 출력
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img8_7.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>고급B</td>
													<td>
														리빙디자이너<br>
														(내방꾸미기)
													</td>
													<td class="ta_left">
														오리엔테이션 및 리빙디자이너 소개<br>
														디자인 ideation &amp; sketch : 공통주제 디자인제작(화병, 에코백, 리빙소품 등)
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img8_8.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>고급C</td>
													<td>
														주얼리디자이너<br>
														(금속 및 실버)
													</td>
													<td class="ta_left">
														오리엔테이션 및 주얼리디자이너 소개<br>
														금속/실버 주얼리 제작기법 설명<br>
														제품 제작
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img8_9.jpg" style="width:100%;"></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
							</dl>
							<dl>
								<dt>9. 주얼리디자이너</dt>
								<dd>- 대상 : - 고등학생만 가능(철판 톱질, 땜질 등 고급 기법 활용)</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="2" style="border-left: 0;">고등학생</td>
													<td>고급A</td>
													<td>주얼리디자이너</td>
													<td class="ta_left">
														오리엔테이션 및 주얼리디자이너 소개<br>
														디자인 ideation &amp; sketch :<br>
														반지디자인 제작실습<br>
														(silver ring, 은 다듬기, 땜 등 기법 활용)
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img11_1.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>고급B</td>
													<td>금속 악세사리디자이너</td>
													<td class="ta_left">
														오리엔테이션 및 금속 악세사리디자이너 소개<br>
														디자인 ideation &amp; sketch : <br>
														뱃지 및 소품 제작실습<br>
														(동판 톱질, 다듬기, 땜 등 기법활용)
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img11_2.jpg" style="width:100%;"></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 중학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="2" style="border-left: 0;">중학생</td>
													<td>중급A</td>
													<td>공간만들기</td>
													<td class="ta_left">
														 공간 모형의 다양한 모형제작을 시도해본다.<br>
														우드로 된 미니어처에 마카, 아크릴물감, 유성펜을 이용하여 컬러링 한다.<br>
														형식_그룹 별 작업, 4명이 1모델 작업 
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img9_3.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>중급B</td>
													<td>외관만들기</td>
													<td class="ta_left">
														공간 외부모형의 다양한 모형제작을 시도해본다.<br>
														형식_그룹 별 작업, 4명이 1모델 작업
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img9_4.jpg" style="width:100%;"></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">고등학생</td>
													<td>고급A</td>
													<td>맞춤공간 설계</td>
													<td class="ta_left">
														형식_그룹 별 작업<br>
														진행_PT강연/아이디어 스케치 /토론 및 발표<br>
														직업별, 취미별 거주자의 라이프 스타일 분석 및 디자인 &amp; 표현한다. 
													</td>
													<td>
														<img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img9_5.jpg" style="width:100%;"><br>
														<img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img9_6.jpg" style="width:100%;">
													</td>
												</tr>
												<tr>
													<td>고급B</td>
													<td>공간만들기2</td>
													<td class="ta_left">
														인테리어 디자인의 과정을 이해하고 공간의 규모/형태를 고민하고, 팀작업의 모형제작을 시도해본다.<br>
														형식_그룹 별 작업, 6명이 1모델 작업 
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img9_7.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>고급C</td>
													<td>핫플레이스 자료분석 및 토론발표</td>
													<td class="ta_left">
														트랜디한 공간의 특성을 그룹별로 서치 한 후 일정한 시간내에 분석하여 발표하는 시간을 갖는다. 형식_그룹 별 토의 및 발표 
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img9_8.jpg" style="width:100%;"></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
							</dl>
							<dl>
								<dt>10. 인테리어디자이너</dt>
								<dd>- 대상 : (초)중학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="2" style="border-left: 0;">(초)중학생</td>
													<td>초급A</td>
													<td>인테리어디자이너</td>
													<td class="ta_left">
														인테리어 디자인관련 소개와 컬러링연습<br>
														색연필, 마카를 이용하여 컬러링<br>
														개인별 1인 1~2스케치 작업
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img9_1.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>초급B</td>
													<td>가구디자이너</td>
													<td class="ta_left">
														인테리어 디자인의 과정을 이해하고 가구의 종류 소재를 이해하고 가구 모형제작을 시도해본다.<br>
														형식_그룹 별 작업, 4명이 1모델 작업
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img9_2.jpg" style="width:100%;"></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 중학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="2" style="border-left: 0;">중학생</td>
													<td>중급A</td>
													<td>공간만들기</td>
													<td class="ta_left">
														 공간 모형의 다양한 모형제작을 시도해본다.<br>
														우드로 된 미니어처에 마카, 아크릴물감, 유성펜을 이용하여 컬러링 한다.<br>
														형식_그룹 별 작업, 4명이 1모델 작업 
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img9_3.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>중급B</td>
													<td>외관만들기</td>
													<td class="ta_left">
														공간 외부모형의 다양한 모형제작을 시도해본다.<br>
														형식_그룹 별 작업, 4명이 1모델 작업
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img9_4.jpg" style="width:100%;"></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">고등학생</td>
													<td>고급A</td>
													<td>맞춤공간 설계</td>
													<td class="ta_left">
														형식_그룹 별 작업<br>
														진행_PT강연/아이디어 스케치 /토론 및 발표<br>
														직업별, 취미별 거주자의 라이프 스타일 분석 및 디자인 &amp; 표현한다. 
													</td>
													<td>
														<img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img9_5.jpg" style="width:100%;"><br>
														<img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img9_6.jpg" style="width:100%;">
													</td>
												</tr>
												<tr>
													<td>고급B</td>
													<td>공간만들기2</td>
													<td class="ta_left">
														인테리어 디자인의 과정을 이해하고 공간의 규모/형태를 고민하고, 팀작업의 모형제작을 시도해본다.<br>
														형식_그룹 별 작업, 6명이 1모델 작업 
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img9_7.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>고급C</td>
													<td>핫플레이스 자료분석 및 토론발표</td>
													<td class="ta_left">
														트랜디한 공간의 특성을 그룹별로 서치 한 후 일정한 시간내에 분석하여 발표하는 시간을 갖는다. 형식_그룹 별 토의 및 발표 
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img9_8.jpg" style="width:100%;"></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
							</dl>
							<dl>
								<dt>11. 자동차디자이너</dt>
								<dd>- 대상 : 중/고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="2" style="border-left: 0;">중/고등학생</td>
													<td>중급A</td>
													<td>자동차디자이너</td>
													<td class="ta_left">
														오리엔테이션 및 자동차디자이너 소개<br>
														- 기초 투시법<br>
														- 컨셉 드로잉 및 컬러링
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img12_1.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>중급B</td>
													<td>자동차디자이너</td>
													<td class="ta_left">
														오리엔테이션 및 자동차디자이너 소개<br>
														- 정량적 드로잉: 데드뷰/4면도<br>
														- 컨셉 드로잉 및 컬러링
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img12_2.jpg" style="width:100%;"></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="2" style="border-left: 0;">고등학생</td>
													<td>고급A</td>
													<td>자동차디자이너</td>
													<td class="ta_left">
														오리엔테이션 및 자동차디자이너 소개<br>
														- 에고노믹스 디자인 패키지 실습<br>
														- 컨셉 드로잉 및 컬러링
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img12_3.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>고급B</td>
													<td>자동차디자이너</td>
													<td class="ta_left">
														오리엔테이션 및 자동차디자이너 소개<br>
														- 컨셉 드로잉 및 컬러링<br>
														- 클레이 볼륨 스터디
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img12_4.jpg" style="width:100%;"></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
							</dl>
						</li>
						<li>패션‧뷰티
							<dl>
								<dt>1. 패션디자이너</dt>
								<dd>- 대상 : (초)중학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">(초)중학생</td>
													<td>초급A</td>
													<td>패션디자이너</td>
													<td class="ta_left">
														전사염으로 나만의 손수건 만들기<br> 
														(재료: 백색손수건, 전사색종이) 
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img10_1.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>초급B</td>
													<td>패션디자이너</td>
													<td class="ta_left">
														홀치기염<br>
														(재료: 손수건, 직접염료) 
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img10_2.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>초급C</td>
													<td>패션디자이너</td>
													<td class="ta_left">
														CLO 3D 구성 및 툴바 활용: 아바타 조작 및 의상 착장하기 
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img10_3.jpg" style="width:100%;"></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 중학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">중학생</td>
													<td>중급A</td>
													<td>패션디자이너</td>
													<td class="ta_left">
														패션 악세서리 만들기<br>
														(펠트 원단, 바늘, 실, 부자재, 가위) 
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img10_4.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>중급B</td>
													<td>패션디자이너</td>
													<td class="ta_left">
														홀치기염으로 나만의 티셔츠 만들기<br>
														(2~3가지 색 활용)<br>
														(재료: 티셔츠, 염료, 앞치마) 
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img10_5.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>중급C</td>
													<td>패션디자이너</td>
													<td class="ta_left">
														CLO 3D 구성 및 툴바 활용: 아바타 조작 및 의상 착장하기 
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img10_6.jpg" style="width:100%;"></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">고등학생</td>
													<td>고급A</td>
													<td>패션디자이너</td>
													<td class="ta_left">
														패션 악세서리 만들기<br>
														(펠트 원단, 바늘, 실, 부자재, 가위) 
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img10_7.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>고급B</td>
													<td>패션디자이너</td>
													<td class="ta_left">
														홀치기염으로 나만의 티셔츠 만들기<br>
														(4~5가지 색 활용)<br>
														(재료: 티셔츠, 염료, 앞치마) 
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img10_8.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>고급C</td>
													<td>패션디자이너</td>
													<td class="ta_left">
														CLO 3D 구성 및 툴바 활용: 아바타 조작 및 의상 착장하기 
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img10_9.jpg" style="width:100%;"></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
							</dl>
							<dl>
								<dt>2. 패션스타일리스트(패션마케터)</dt>
								<dd>- 대상 : (초)중학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">(초)중학생</td>
													<td>초급A</td>
													<td>패션스타일리스트</td>
													<td class="ta_left">
														패션이미지맵 만들기<br>
														(잡지, 가위, 풀, 종이) 
													</td>
													<td></td>
												</tr>
												<tr>
													<td>초급B</td>
													<td>패션스타일리스트</td>
													<td class="ta_left">
														나에게 어울리는 컬러 찾기<br> 
														(잡지, 원단, 거울) 
													</td>
													<td></td>
												</tr>
												<tr>
													<td>초급C</td>
													<td>패션마케터</td>
													<td class="ta_left">
														재미있는 패션광고 
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 중/고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="2" style="border-left: 0;">중/고등학생</td>
													<td>중급A</td>
													<td>패션스타일리스트</td>
													<td class="ta_left">
														패션사진(효과적으로 패션사진 찍는법) 
													</td>
													<td></td>
												</tr>
												<tr>
													<td>중급B</td>
													<td>패션마케터</td>
													<td class="ta_left">
														패션브랜드 히스토리 연구  
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td style="border-left: 0;">고등학생</td>
													<td>고급A</td>
													<td>패션마케터</td>
													<td class="ta_left">
														나만의 패션브랜드 만들기(필기도구, 잡지, 가위, 풀, 우드락(폼보드)) 
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
							</dl>
							<dl>
								<dt>3. 메이크업디자이너</dt>
								<dd>- 대상 : (초)중학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">(초)중학생</td>
													<td>초급A</td>
													<td>메이크업 아티스트</td>
													<td class="ta_left">
														컬러칩을 활용한 퍼스널 컬러 찾기 
													</td>
													<td></td>
												</tr>
												<tr>
													<td>초급B</td>
													<td>메이크업 아티스트</td>
													<td class="ta_left">
														컬러칩을 활용하여 퍼스널 컬러 맵 제작 
													</td>
													<td></td>
												</tr>
												<tr>
													<td>초급C</td>
													<td>메이크업 아티스트</td>
													<td class="ta_left">
														메이크업 코디네이터 실습 
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 중/고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">중/고등학생</td>
													<td>중급A</td>
													<td>메이크업 크리에이터</td>
													<td class="ta_left">
														컨셉 메이크업 기획 체험 
													</td>
													<td></td>
												</tr>
												<tr>
													<td>중급B</td>
													<td>메이크업 크리에이터</td>
													<td class="ta_left">
														컨셉 메이크업 실습 체험  
													</td>
													<td></td>
												</tr>
												<tr>
													<td>중급C</td>
													<td>메이크업 크리에이터</td>
													<td class="ta_left">
														메이크업 사진찍기 올바른 방법 체험
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">고등학생</td>
													<td>고급A</td>
													<td>
														뷰티 크리에이터<br>
														(메이크업)
													</td>
													<td class="ta_left">
														뷰티 크리에이터 메이크업 컨셉 제작 
													</td>
													<td></td>
												</tr>
												<tr>
													<td>고급B</td>
													<td>
														뷰티 크리에이터<br>
														(메이크업)
													</td>
													<td class="ta_left">
														뷰티 크리에이터 메이크업 방송 제작 체험 
													</td>
													<td></td>
												</tr>
												<tr>
													<td>고급C</td>
													<td>
														뷰티 크리에이터<br>
														(메이크업)
													</td>
													<td class="ta_left">
														뷰티 크리에이터 메이크업 실시간 방송 체험 
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
							</dl>
							<dl>
								<dt>4. 헤어디자이너</dt>
								<dd>- 대상 : (초)중학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">(초)중학생</td>
													<td>초급A</td>
													<td>헤어디자이너</td>
													<td class="ta_left">
														화보 및 방송 헤어를 위한 세팅 실습 
													</td>
													<td></td>
												</tr>
												<tr>
													<td>초급B</td>
													<td>헤어디자이너</td>
													<td class="ta_left">
														화보 및 방송 헤어를 위한 기초 업스타일 실습 
													</td>
													<td></td>
												</tr>
												<tr>
													<td>초급C</td>
													<td>헤어디자이너</td>
													<td class="ta_left">
														크리에이터를 위한 작품 제작 후 사진 기록물 만들기 
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 중/고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">중/고등학생</td>
													<td>중급A</td>
													<td>헤어 크리에이터</td>
													<td class="ta_left">
														컨셉 헤어 기획 체험 
													</td>
													<td></td>
												</tr>
												<tr>
													<td>중급B</td>
													<td>헤어 크리에이터</td>
													<td class="ta_left">
														컨셉 헤어 실습 체험  
													</td>
													<td></td>
												</tr>
												<tr>
													<td>중급C</td>
													<td>헤어 크리에이터</td>
													<td class="ta_left">
														헤어 사진찍기 올바른 방법 체험
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">고등학생</td>
													<td>고급A</td>
													<td>
														뷰티 크리에이터<br>
														(헤어)
													</td>
													<td class="ta_left">
														뷰티 크리에이터 헤어 컨셉 제작 
													</td>
													<td></td>
												</tr>
												<tr>
													<td>고급B</td>
													<td>
														뷰티 크리에이터<br>
														(헤어)
													</td>
													<td class="ta_left">
														뷰티 크리에이터 헤어 방송 제작 체험 
													</td>
													<td></td>
												</tr>
												<tr>
													<td>고급C</td>
													<td>
														뷰티 크리에이터<br>
														(헤어)
													</td>
													<td class="ta_left">
														뷰티 크리에이터 헤어 실시간 방송 체험 
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
							</dl>
							<dl>
								<dt>5. 네일아티스트</dt>
								<dd>- 대상 : (초)중학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">(초)중학생</td>
													<td>초급A</td>
													<td>네일아티스트</td>
													<td class="ta_left">
														손톱구조, 기본쉐입잡기, 손톱광내기, 칼라링 
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img13_1.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>초급B</td>
													<td>네일아티스트</td>
													<td class="ta_left">
														(딥)프렌치네일,응용 네일아트 
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img13_2.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>초급C</td>
													<td>네일아티스트</td>
													<td class="ta_left">
														그라데이션, 마블아트, 응용네일아트 
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img13_3.jpg" style="width:100%;"></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 중/고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">중/고등학생</td>
													<td>중급A</td>
													<td>네일아티스트</td>
													<td class="ta_left">
														스톤아트, 데칼아트, 응용네일아트 
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img13_4.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>중급B</td>
													<td>네일아티스트</td>
													<td class="ta_left">
														호피, 지브라 네일  
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img13_5.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>중급C</td>
													<td>네일아티스트</td>
													<td class="ta_left">
														사선, 체크아트
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img13_6.jpg" style="width:100%;"></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">고등학생</td>
													<td>고급A</td>
													<td>네일아티스트</td>
													<td class="ta_left">
														시스루네일, 와니아트 
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img13_7.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>고급B</td>
													<td>네일아티스트</td>
													<td class="ta_left">
														별, 눈, 입술아트 
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img13_8.jpg" style="width:100%;"></td>
												</tr>
												<tr>
													<td>고급C</td>
													<td>네일아티스트</td>
													<td class="ta_left">
														플라워네일(장미, 데이지, 기타 꽃)
													</td>
													<td><img src="${pageContext.request.contextPath }/assets/usr/img/exper/experInfo_img13_9.jpg" style="width:100%;"></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
							</dl>
							<dl>
								<dt>6. 피부코디네이터(맑은 피부로 다시 태어나기)</dt>
								<dd>- 대상 : (초)중학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">(초)중학생</td>
													<td>초급A</td>
													<td>피부코디네이터</td>
													<td class="ta_left">
														피부타입별 클렌징제품과 사용방법 실습 
													</td>
													<td></td>
												</tr>
												<tr>
													<td>초급B</td>
													<td>피부코디네이터</td>
													<td class="ta_left">
														부드러운 손을 위한 핸드마사지 실습
													</td>
													<td></td>
												</tr>
												<tr>
													<td>초급C</td>
													<td>피부코디네이터</td>
													<td class="ta_left">
														여드름예방을 위한 각질제거방법 실습
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 중/고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">중/고등학생</td>
													<td>중급A</td>
													<td>피부코디네이터</td>
													<td class="ta_left">
														피부상태에 따른 올바른 클렌징 방법과 각질제거 실습 
													</td>
													<td></td>
												</tr>
												<tr>
													<td>중급B</td>
													<td>피부코디네이터</td>
													<td class="ta_left">
														체질별 아로마로 맞춤형 화장품 제작  
													</td>
													<td></td>
												</tr>
												<tr>
													<td>중급C</td>
													<td>피부코디네이터</td>
													<td class="ta_left">
														귀를 보면 건강이 보이는 이혈테라피
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
								<dd style="margin-top: 10px;">- 대상 : 고등학생</dd>
								<dd>
									<div class="ta_overbox">
										<table class="ta874_ty05">
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 10%;">
												<col style="width: 20%;">
												<col style="width: 50%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr style="height: 50px;">
													<th scope="col">구분</th>
													<th scope="col">종류</th>
													<th scope="col">분야</th>
													<th scope="col">프로그램</th>
													<th scope="col">비고</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td rowspan="3" style="border-left: 0;">고등학생</td>
													<td>고급A</td>
													<td>피부코디네이터</td>
													<td class="ta_left">
														여드름개선을 위한 필링 실습 
													</td>
													<td></td>
												</tr>
												<tr>
													<td>고급B</td>
													<td>피부코디네이터</td>
													<td class="ta_left">
														미끈한 바디를 위한 왁싱 실습 
													</td>
													<td></td>
												</tr>
												<tr>
													<td>고급C</td>
													<td>피부코디네이터</td>
													<td class="ta_left">
														체질분석과 맞춤형 화장품 제작
													</td>
													<td></td>
												</tr>
											</tbody>
										</table>
									</div>
								</dd>
							</dl>
						</li>
 					</ol> -->
				
			<!-- 0408추가 -->
				<table class="ta874_ty08">
				<colgroup>
					<col width="20%"/>
					<col />
					<col width="30%"/>
				</colgroup>
				<tbody>
					<tr>
						<th>2016년</th>
						<td>내용</td>
						<td class="btn_box "><a href="" type="button" class="btn_go_list">안내책자</a></td>
					</tr>
					<tr>
						<th>2017년</th>
						<td>내용</td>
						<td class="btn_box "><a href="" type="button" class="btn_go_list">안내책자</a></td>
					</tr>
					<tr>
						<th>2018년</th>
						<td>내용</td>
						<td class="btn_box "><a href="" type="button" class="btn_go_list">안내책자</a></td>
					</tr>
					<tr>
						<th>2019년</th>
						<td>내용</td>
						<td class="btn_box "><a href="" type="button" class="btn_go_list">안내책자</a></td>
					</tr>
				</tbody>
			</table>
				
				</c:if>
				<div class="go_top"><a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a></div>
			<!--// content -->
			</div>		
		</div>
	<!--// container -->
	<hr />
	</div>
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>