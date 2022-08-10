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
			
				<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="입학안내"/>
		            <jsp:param name="dept2" value="일학습엘리트 모집요강"/>
	           	</jsp:include>
	
	           	<!-- 200420추가 -->
	           	<div class="top_tab type_li2">
					<ul>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/enter/prospectus.do'/>">신ㆍ편입생 모집요강</a></li>
						<li class="active"><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/eliteProspect.do'/>">일학습엘리트 모집요강</a></li>
					</ul>
				</div>

				<div class="pros_box">
					<div class="pros_title">
						2021학년도 일학습엘리트과정 모집요강
					</div>
					<div class="s_tit" style="margin-top: 30px;">모집일정</div>
					<div class="ta_overbox">
						<table class="ta874_ty04"
							summary="모집일정을 모집시기, 접수일정, 비고 순서로 보여줍니다.">
							<caption>모집일정</caption>
							<colgroup>
								<col style="width: 20%;" />
								<col style="width: 30%;" />
								<col style="width: 50%;" />
							</colgroup>
							<thead>
								<tr style="height: 50px;">
									<th scope="col">모집시기</th>
									<th scope="col">원서접수일정</th>
									<th scope="col">비고</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1차</td>
									<td>2020. 04. 02 ~ 2020. 08. 21</td>
									<td rowspan="3">전형일정은<br>홈페이지 및 개별 전화 안내</td>
								</tr>
								<tr>
									<td>2차</td>
									<td>2020. 08. 23 ~ 2020. 12. 12</td>
								</tr>
								<tr>
									<td>3차</td>
									<td>2020. 12. 20 ~ 2021. 02. 19</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="s_tit" style="margin-top: 30px;">모집전공</div>
					<div class="ta_overbox">
						<table class="ta874_ty04"
							summary="모집전공을 계열, 진출분야, 졸업학위, 비고 순서로 보여줍니다.">
							<caption>모집전공</caption>
							<colgroup>
								<col style="width: 20%;" />
								<col style="width: 25%;" />
								<col style="width: 25%;" />
								<col style="width: 30%;" />
							</colgroup>
							<thead>
								<tr style="height: 50px;">
									<th scope="col">계열</th>
									<th scope="col">진출분야</th>
									<th scope="col">졸업학위</th>
									<th scope="col">비고</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>패션계열</td>
									<td>글로벌패션창업</td>
									<td>패션학사<br>(패션마케팅전공)</td>
									<td rowspan="2">한성대학교 총장명의<br>4년제 학사학위과정</td>
								</tr>
								<tr>
									<td>뷰티계열</td>
									<td>뷰티교육자 / 하야시두피모발</td>
									<td>미용학사<br>(뷰티디자인매니지먼트전공)</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="s_tit" style="margin-top: 30px;">지원자격</div>
					<div class="ta_overbox">
						<table class="ta874_ty02"
							summary="기원자격을 구분, 지원자격 순서로 보여줍니다.">
							<caption>지원자격</caption>
							<colgroup>
								<col style="width: 20%;" />
								<col style="width: %;" />
							</colgroup>
							<thead>
								<tr style="height: 50px;">
									<th scope="col">구분</th>
									<th scope="col">지원자격</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>신입학</td>
									<td class="ta_left">
										<p>1. 고등학교 졸업(예정)자 또는 법령에 의하여 위와 동등한 학력이 인정되는 자</p>
										<p>2. 전적대학 또는 학점은행제 기관에서 36학점 미만 취득한 자</p>
										<p>3. 기관 소속 재직자</p>
									</td>
								</tr>
								<tr>
									<td>편입학</td>
									<td class="ta_left">
										<p>1. 전문대학 및 대학교 졸업자</p>
										<p>2. 전적대학 또는 학점은행제 기관에서 36학점 이상 취득한 자</p>
										<p>3. 기관 소속 재직자</p>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="s_tit" style="margin-top: 30px;">전형요소</div>
					<div class="ta_overbox">
						<table class="ta874_ty02"
							summary="전형요소를 전형요소, 전형방법 순서로 보여줍니다.">
							<caption>전형요소</caption>
							<colgroup>
								<col style="width:20%;" />
								<col style="width:25%;" />
								<col style="width:%;" />
							</colgroup>
							<thead>
								<tr style="height: 50px;">
									<th scope="col">계열</th>
									<th scope="col">모집시기</th>
									<th scope="col">전형요소별 반영비율(%)</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>패션계열</td>
									<td>1~3차</td>
									<td>적성 50 + 면접 50</td>
								</tr>
								<tr>
									<td>뷰티계열</td>
									<td>1~3차</td>
									<td>적성 50 + 면접 50</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="s_tit" style="margin-top: 30px;">전형방법</div>
					<div class="ta_overbox">
						<table class="ta874_ty02" summary="전형방법을 전형요소 전형방법 순서로 보여줍니다.">
							<caption>지원자격</caption>
							<colgroup>
								<col style="width: 20%;" />
								<col style="width: 80%;" />
							</colgroup>
							<thead>
								<tr style="height: 50px;">
									<th scope="col">전형요소</th>
									<th scope="col">전형방법</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>적성</td>
									<td class="ta_left">
										<p>-방식 : 지필고사</p>
										<p>-시간 : 60분</p>
										<p>-문제유형 : 지원동기 및 학업계획 관련 서술형, 전공 관련 객관식</p>
									</td>
								</tr>
								<tr>
									<td>면접</td>
									<td class="ta_left">
										<p>-방식 : 2인 조별 면접</p>
										<p>-시간 : 20분 내외</p>
										<p>-평가기준 : 태도 및 커뮤니케이션 능력, 전공 관련 기초 소양</p>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="s_tit" style="margin-top: 30px;">전형일 제출서류</div>
					<div class="ta_overbox">
						<table class="ta874_ty02" summary="전형일 제출서류를 구분, 제출서류 순서로 보여줍니다.">
							<caption>전형일 제출서류</caption>
							<colgroup>
								<col style="width: 20%;" />
								<col style="width: %;" />
							</colgroup>
							<thead>
								<tr style="height: 50px;">
									<th scope="col">구분</th>
									<th scope="col">제출서류</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>신입학</td>
									<td class="ta_left">
										<!--// <p>1. 고등학교 생활기록부 1부</p> -->
										<p>1. 재직증명서 1부</p>
										<p>2. 증명사진 2매</p>
									</td>
								</tr>
								<tr>
									<td>편입학</td>
									<td class="ta_left">
										<p>1. 전적대학 성적증명서 1부</p>
										<p>2. 재직증명서 1부</p>
										<p>3. 증명사진 2매</p>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="s_tit" style="margin-top: 30px;">선발과정</div>
					<div class="ta_overbox">
						<ul class="ctm_ul">
							<li>
								<table class="ta874_ty06">
									<thead>
										<tr>
											<th>원서접수</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>한디원 홈페이지<br/>인터넷 접수</td>
										</tr>
									</tbody>
								</table>
							</li>
							<li class="ctm_ul_li2"><img src="${pageContext.request.contextPath }/assets/usr/img/left_2d_icon_on.png"></li>
							<li>
								<table class="ta874_ty06">
									<thead>
										<tr>
											<th>전형일정</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>홈페이지 및<br>개별 전화 안내</td>
										</tr>
									</tbody>
								</table>
							</li>
							<li class="ctm_ul_li2"><img src="${pageContext.request.contextPath }/assets/usr/img/left_2d_icon_on.png"></li>
							<li>
								<table class="ta874_ty06">
									<thead>
										<tr>
											<th>합격자 발표</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>전형 후 1주일<br/>이내 홈페이지<br/>및 SMS 공지</td>
										</tr>
									</tbody>
								</table>
							</li>
							<li class="ctm_ul_li2"><img src="${pageContext.request.contextPath }/assets/usr/img/left_2d_icon_on.png"></li>
							<li>
								<table class="ta874_ty06">
									<thead>
										<tr>
											<th>등록금 납부</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>합격자 대상<br/>개별 안내</td>
										</tr>
									</tbody>
								</table>
							</li>
							<li class="ctm_ul_li2"><img src="${pageContext.request.contextPath }/assets/usr/img/left_2d_icon_on.png"></li>
							<li>
								<table class="ta874_ty06">
									<thead>
										<tr>
											<th>입학식</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>2020년<br/>2월말 예정</td>
										</tr>
									</tbody>
								</table>
							</li>
						</ul>
					</div>
					<div class="btn_box">
						<a href="#" onclick="fn_appliForm_choose_sub(); return false;" class="btn_cun">원서접수</a> 
					</div>
					
					<div class="go_top"><a href="javascript:window.scrollTo(0,0)"><strong>▲</strong><br>TOP</a></div>
				</div>
			</div>		
		</div>
	<!--// container -->
	<hr />
	</div>
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
	</div>
<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>