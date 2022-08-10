<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">
	// 목록
	function fn_list(pageNo, menuType){
		$("#pageIndex").val(pageNo);
		if(menuType != null) $("#menuType").val(menuType);
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/transfer/transferReview/transferReviewList.do'/>").submit();
	}
</script>
<form:form commandName="searchVO" id="frm" name="frm">
<form:hidden path="menuType"/>
<form:hidden path="searchType"/>
<body>
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
		<!-- header area -->
		<div class="main_content" id="content">
			<div class="width_box">
				<!-- left menu area-->
				<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu"/>
				<!-- //left menu area-->
				<div class="sub_content">
					<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle2.jsp">
						<jsp:param name="dept1" value="전공"/>
			            <jsp:param name="dept2" value="실내디자인"/>
			            <jsp:param name="dept3" value="대학원&편입사례"/>
		           	</jsp:include>
		           	<div class="top_tab type_li2">
						<ul>
							<li <c:if test="${searchVO.searchType eq '01' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/transfer/transferReview/transferReviewList.do?searchType=01'/>">편입 성공후기</a></li>
							<li <c:if test="${searchVO.searchType eq '02' }">class="active"</c:if> ><a href="<c:out value='${pageContext.request.contextPath }/usr/transfer/transferReview/transferReviewList.do?searchType=02'/>">대학원 진학 및 타대학 편입 성공후기</a></li>
						</ul>
					</div>
					<c:if test="${searchVO.searchType eq '01' }">
						<div class="sub_cont_page">
							<div class="sub_cont_box">
								<div class="tit_3rd">[편입생 개별지도]</div>
								<dl class="info_dl">
									<dd>
										<p>- 편입생은 매학기 개강 전에 수강신청과목 및 자격증 취득 정보 등의 내용에 대하여 1:1 개별상담을 시행<br>&nbsp;&nbsp;&nbsp;[전공필수 + 취업희망 관련과목 + 관심 과목]</p>
										<p>- 수강신청 후 선배와의 튜터 & 튜티 프로그램을 통하여 부족한 부분을 개별적으로 보완 및 지도 실시</p>
									</dd>
								</dl>
								<div class="tit_3rd">[편입생 교육과정]</div>
								<dl class="info_dl">
									<dd>
										<p style="margin-top: 30px;"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/interior/interior_transfer_course_01.gif'/>" /></p>
									</dd>
								</dl>
								<div class="tit_3rd">2년 과정 [한성대총장명의학위]</div>
								<div class="ta_overbox">
									<table class="ta874" summary="자격증 정보를 내용, 인정학점(전공, 일선) 순서로 보여줍니다.">
										<caption>자격증정보표</caption>
										<colgroup>
											<col style="width:10%;" />
											<col style="width:20%;" />
											<col style="width:" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col">연차</th>
												<th scope="col">학점</th>
												<th scope="col">내용</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td style="text-align: center;">1년차<br>(3학년)</td>
												<td style="text-align: center;">1, 2학년 과목 중<br>42학점<br>선택 수강</td>
												<td>
													<p style="margin: 5px;">1학년 교과목 : 공통기초과정 중 선택</p>
													<p style="margin: 5px;">(기초디자인, 인테리어설계1단계, 드로잉1, 디자인론, 컴퓨터그래픽스1, 표현기법, 실내디자인론, 실내건축제도, 인테리어그래픽1, 조형실습 등)</p>
													<p style="margin: 5px;margin-top: 15px;">2학년 교과목 : 전공실무과정 1단계 중 선택</p>
													<p style="margin: 5px;">(인테리어설계2/3단계, 디자인세미나, 사진과디자인, 가구디자인, 가구설계실습, 모형제작, 3DS MAX, 인테리어마감재 코디네이션, 생활과디자인 등)</p>
												</td>
											</tr>
											<tr>
												<td style="text-align: center;">2년차<br>(4학년)</td>
												<td style="text-align: center;">3, 4학년 과목 중<br>42학점<br>선택 수강</td>
												<td>
													<p style="margin: 5px;">3학년 교과목 : 전공실무과정 2단계 중 선택</p>
													<p style="margin: 5px;">(인테리어설계4/5단계, 인테리어 코디네이션, 공간디자인실습(무대디자인), 시각디자인, 디자인경영과브랜드전략, 디자인리서치와마케팅, 전시디자인, 디스플레이 등)</p>
													<p style="margin: 5px;margin-top: 15px;">4학년 교과목 : 전공실무과정 3단계 중 선택</p>
													<p style="margin: 5px;">(인테리어설계6단계, 졸업설계, 전시디자인, 포트폴리오제작, 인테리어 디테일, 프리젠테이션, 실시설계 외 실무연계수업 &amp; 기업인턴)</p>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="tit_3rd">1년 과정 [교과부장관명의학위]</div>
								<div class="ta_overbox">
									<table class="ta874" summary="자격증 정보를 내용, 인정학점(전공, 일선) 순서로 보여줍니다.">
										<caption>자격증정보표</caption>
										<colgroup>
											<col style="width:10%;" />
											<col style="width:20%;" />
											<col style="width:" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col">연차</th>
												<th scope="col">학점</th>
												<th scope="col">내용</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td style="text-align: center;">1년차</td>
												<td style="text-align: center;">1~4학년 과목 중<br>42학점<br>선택 수강</td>
												<td>
													<p style="margin: 5px;">1학년 교과목 : 공통기초과정 중 선택</p>
													<p style="margin: 5px;">(기초디자인, 인테리어설계1단계, 드로잉1, 디자인론, 컴퓨터그래픽스1, 표현기법, 실내디자인론, 실내건축제도, 인테리어그래픽1, 조형실습 등)</p>
													<p style="margin: 5px;margin-top: 15px;">2학년 교과목 : 전공실무과정 1단계 중 선택</p>
													<p style="margin: 5px;">(인테리어설계2/3단계, 디자인세미나, 사진과디자인, 가구디자인, 가구설계실습, 모형제작, 3DS MAX, 인테리어마감재 코디네이션, 생활과디자인 등)</p>
													<p style="margin: 5px;margin-top: 15px;">3학년 교과목 : 전공실무과정 2단계 중 선택</p>
													<p style="margin: 5px;">(인테리어설계4/5단계, 인테리어 코디네이션, 공간디자인실습(무대디자인), 시각디자인, 디자인경영과브랜드전략, 디자인리서치와마케팅, 전시디자인, 디스플레이 등)</p>
													<p style="margin: 5px;margin-top: 15px;">4학년 교과목 : 전공실무과정 3단계 중 선택</p>
													<p style="margin: 5px;">(인테리어설계6단계, 졸업설계, 전시디자인, 포트폴리오제작, 인테리어 디테일, 프리젠테이션, 실시설계 외 실무연계수업 &amp; 기업인턴)</p>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="hd_intro_box">
									<div class="int_title" style="padding-top:50px;">타대학에서 한디원 실내디자인전공 편입</div>
								</div>
								<div class="ta_overbox">
									<table class="ta874" summary="타대학에서 한디원 실내디자인전공 편입 리스트">
										<caption>타대학에서 한디원 실내디자인전공 편입</caption>
										<tbody>
											<tr>
												<td>
													<table class="ta874">
														<colgroup>
															<col style="width:10%;" />
															<col style="width:%;" />
														</colgroup>
														<thead>
															<tr>
																<th rowspan="2">2020-1</th>
																<th>8명</th>
															</tr>
															<tr>
																<td style="text-align: center; padding:5px 0 5px 0;">
																	<p>동서울대학교 실내디자인과 [최 * *]</p>
																	<p>동서울대학교 실내디자인과 [박 * *]</p>
																	<p>전주대학교 한문교육과 [김 * *]</p>
																	<p>경성대학교 문헌정보학과 [강 * *]</p>
																	<p>동원대학교 시각정보디자인학과 [이 * *]</p>
																	<p>한림대학교 청각학전공 [소 * *]</p>
																	<p>한양여자대학교 섬유디자인학과 [최 * *]</p>
																	<p>배화여자대학교 영어통번역과 [장 * *]</p>
																</td>
															</tr>
														</thead>
													</table>															
													<table class="ta874">
														<colgroup>
															<col style="width:10%;" />
															<col style="width:%;" />
														</colgroup>
														<thead>
															<tr>
																<th rowspan="2">2019</th>
																<th>6명</th>
															</tr>
															<tr>
																<td style="text-align: center; padding:5px 0 5px 0;">
																	<p>서일대학교 실내디자인학과 [정 * *]</p>
																	<p>수원여자대학교 아동미술과 [최 * *]</p>
																	<p>수원여자대학교 아동미술과 [이 * *]</p>
																	<p>가톨릭관동대학교 광고홍보학과 [김 * *]</p>
																	<p>강원대학교 생활조형디자인학과 [이 * *]</p>
																	<p>계원예술학교 융합예술과 [진 * *]</p>
																</td>
															</tr>
														</thead>
													</table>
													<table class="ta874">
														<colgroup>
															<col style="width:10%;" />
															<col style="width:%;" />
														</colgroup>
														<thead>
															<tr>
																<th rowspan="2">2018</th>
																<th style="border-top: 1px solid #cccccc">8명</th>
															</tr>
															<tr>
																<td style="text-align: center; padding:5px 0 5px 0;">
																	<p>고려대학교 영어영문학과 [이 * *]</p>
																	<p>중부대학교 건축디자인과 [배 * *]</p>
																	<p>아세아항공전문대 항공보안전공 [홍 * *]</p>
																	<p>아세아항공전문대학 비파괴검사전공 [구 * *]</p>
																	<p>계원예술대학교 리빙디자인과 [이 * *]</p>
																	<p>한양여자대학교 인테리어디자인과 [김 * *]</p>
																	<p>영남이공대학교 패션코디디자인과 [문 * *]</p>
																	<p>경상대학교 농업생명과학대학 [배 * *]</p>
																</td>
															</tr>
														</thead>
													</table>
													<table class="ta874">
														<colgroup>
															<col style="width:10%;" />
															<col style="width:%;" />
														</colgroup>
														<thead>
															<tr>
																<th rowspan="2">2017</th>
																<th style="border-top: 1px solid #cccccc">9명</th>
															</tr>
															<tr>
																<td style="text-align: center; padding:5px 0 5px 0;">
																	<p>서울종합예술대학 시각디자인학과 [이 * *]</p>
																	<p>연성대학교 컴퓨터 소프트웨어학과 [이 * *]</p>
																	<p>나사렛대학교 정보통신학과 [민 * *]</p>
																	<p>경원대학교 의상학과 [전 * *]</p>
																	<p>호서전문학교 실내디자인 [박 * *]</p>
																	<p>강원대학교 자동차 공학과 [류 * *]</p>
																	<p>한국방송통신대학교  경영학 [라 * *]</p>
																	<p>경민대학교 디지털 영상학과 [강 * *]</p>
																	<p>경상대학교강릉원주대학교 패션디자인학과 [권 * *]</p>
																</td>
															</tr>
														</thead>
													</table>
													<table class="ta874">
														<colgroup>
															<col style="width:10%;" />
															<col style="width:%;" />
														</colgroup>
														<thead>
															<tr>
																<th rowspan="2">2016</th>
																<th style="border-top: 1px solid #cccccc">8명</th>
															</tr>
															<tr>
																<td style="text-align: center; padding:5px 0 5px 0;">
																	<p>용인송담대 조명인테리어과[이 * *]</p>
																	<p>평택대학교  시각디자인[유 * *]</p>
																	<p>한림대학교 심리학과[임 * *]</p>
																	<p>서경대학교 공연예술학과[박 * *]</p>
																	<p>서울예술전문학교 뷰티예술학부[이 * *]</p>
																	<p>백석대학교 디자인영상학부[이 * *]</p>
																	<p>백석문화대학교  해외인턴십학부[모 * *]</p>
																	<p>동서울대학교 실내디자인과[김 * *]</p>
																</td>
															</tr>
														</thead>
													</table>
													<table class="ta874">
														<colgroup>
															<col style="width:10%;" />
															<col style="width:%;" />
														</colgroup>
														<thead>
															<tr>
																<th rowspan="2">2015</th>
																<th style="border-top: 1px solid #cccccc">6명</th>
															</tr>
															<tr>
																<td style="text-align: center; padding:5px 0 5px 0;">
																	<p>경남정보대학교 공업디자인학과[도 * *]</p>
																	<p>목원대학교  건축과[이 * *]</p>
																	<p>강릉대학교 산업경영학과[김 * *]</p>
																	<p>숭실호스피탈리티 전문학교  산업디자인[윤 * *]</p>
																	<p>서정대학교 실내디자인과[김 * *]</p>
																	<p>칼빈대학교 실내디자인[김 * *]</p>
																</td>
															</tr>
														</thead>
													</table>
													<table class="ta874">
														<colgroup>
															<col style="width:10%;" />
															<col style="width:%;" />
														</colgroup>
														<thead>
															<tr>
																<th rowspan="2">2014</th>
																<th style="border-top: 1px solid #cccccc">8명</th>
															</tr>
															<tr>
																<td style="text-align: center; padding:5px 0 5px 0;">
																	<p>예원예술대학교 한지조형학과 [전 * *]</p>
																	<p>백석대학교  경영학과 [장 *]</p>
																	<p>서울종합예술학교 환경디자인 [김 * *]</p>
																	<p>경남과학기술대학교  건축공학과 [남 * *]</p>
																	<p>동서울대학교 컴퓨터 정보과 [유 * *]</p>
																	<p>경민대학교  가구디자인 [이 * *]</p>
																	<p>장안대학교 시각디자인 [양 * *]</p>
																	<p>경민대학교 가구디자인 [김 * *]</p>
																</td>
															</tr>
														</thead>
													</table>
													<table class="ta874">
														<colgroup>
															<col style="width:10%;" />
															<col style="width:%;" />
														</colgroup>
														<thead>
															<tr>
																<th rowspan="2">2013</th>
																<th style="border-top: 1px solid #cccccc">1명</th>
															</tr>
															<tr>
																<td style="text-align: center; padding:5px 0 5px 0;">
																	<p>중앙대 학점은행제 공연제작전공 [윤 * *]</p>
																</td>
															</tr>
														</thead>
													</table>
													<table class="ta874">
														<colgroup>
															<col style="width:10%;" />
															<col style="width:%;" />
														</colgroup>
														<thead>
															<tr>
																<th rowspan="2">2012</th>
																<th style="border-top: 1px solid #cccccc">1명</th>
															</tr>
															<tr>
																<td style="text-align: center; padding:5px 0 5px 0;">
																	<p>한세대학교 실내디자인 [허 * *]</p>
																</td>
															</tr>
														</thead>
													</table>
													<table class="ta874">
														<colgroup>
															<col style="width:10%;" />
															<col style="width:%;" />
														</colgroup>
														<thead>
															<tr>
																<th rowspan="2">2011</th>
																<th style="border-top: 1px solid #cccccc">1명</th>
															</tr>
															<tr>
																<td style="text-align: center; padding:5px 0 5px 0;">
																	<p>경민대학교 가구디자인 [김 * *]</p>
																</td>
															</tr>
														</thead>
													</table>
													<table class="ta874">
														<colgroup>
															<col style="width:10%;" />
															<col style="width:%;" />
														</colgroup>
														<thead>
															<tr>
																<th rowspan="2">2010</th>
																<th style="border-top: 1px solid #cccccc">2명</th>
															</tr>
															<tr>
																<td style="text-align: center; padding:5px 0 5px 0;">
																	<p>공주영상대학 실내디자인 [변 * *]</p>
																	<p>유한대학교 회화과 [제 * *]</p>
																</td>
															</tr>
														</thead>
													</table>
													<table class="ta874">
														<colgroup>
															<col style="width:10%;" />
															<col style="width:%;" />
														</colgroup>
														<thead>
															<tr>
																<th rowspan="2">2009</th>
																<th style="border-top: 1px solid #cccccc">2명</th>
															</tr>
															<tr>
																<td style="text-align: center; padding:5px 0 5px 0;">
																	<p>서울호서전문학교 실내디자인 [차 * *]</p>
																	<p>백석대학교 무대디자인 [황 * *]</p>
																</td>
															</tr>
														</thead>
													</table>
													<table class="ta874">
														<colgroup>
															<col style="width:10%;" />
															<col style="width:%;" />
														</colgroup>
														<thead>
															<tr>
																<th rowspan="2">2008</th>
																<th style="border-top: 1px solid #cccccc">3명</th>
															</tr>
															<tr>
																<td style="text-align: center; padding:5px 0 5px 0;">
																	<p>극동정보대학 가구디자인 [맹 * *]</p>
																	<p>IT전문학교 실내디자인 [김 * *]</p>
																	<p>인천문예전문학교 실내디자인 [주 * *]</p>
																</td>
															</tr>
														</thead>
													</table>
													<table class="ta874">
														<colgroup>
															<col style="width:10%;" />
															<col style="width:%;" />
														</colgroup>
														<thead>
															<tr>
																<th rowspan="2">2007</th>
																<th style="border-top: 1px solid #cccccc">5명</th>
															</tr>
															<tr>
																<td style="text-align: center; padding:5px 0 5px 0;">
																	<p>서강대학교 영어영문학과 [엄 * *]</p>
																	<p>서울전문학교 실내디자인 [김 * *]</p>
																	<p>인천문예전문학교 실내디자인 [한 * *]</p>
																	<p>성결대학교 시각디자인 [신 * *]</p>
																	<p>경민대학교 가구디자인 [임 * *]</p>
																</td>
															</tr>
														</thead>
													</table>
													<table class="ta874">
														<colgroup>
															<col style="width:10%;" />
															<col style="width:%;" />
														</colgroup>
														<thead>
															<tr>
																<th rowspan="2">2006</th>
																<th style="border-top: 1px solid #cccccc">7명</th>
															</tr>
															<tr>
																<td style="text-align: center; padding:5px 0 5px 0;">
																	<p>인천문예전문학교 실내디자인 </p>
																	<p>[김 * *, 김 * *, 이 * *, 남 * *, 김 * *, 김 * *, 김 * *]</p>
																</td>
															</tr>
														</thead>
													</table>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="list_sh" style="margin-top:50px;" id="focus">
							<ul>
								<li>
									<form:select path="searchCondition1">
										<form:option value="preschool">전적대학</form:option>
										<form:option value="activity">활동</form:option>
										<form:option value="result">결과</form:option>
									</form:select>
								</li>
								<li>
									<form:input path="searchWord"/>
								</li>
								<li>
									<a href="#" onclick="fn_list(1); return false">
										<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/icon_sh.png'/>" alt="찾기" />
									</a>
								</li>
							</ul>
						</div>
						<div class="transform_table case_type">
							<ul class="tbl_th">
								<li>이름</li>
								<li>전적대학</li>
								<li>등록학기</li>
								<li>활동</li>
								<li>결과(취업센터)</li>
								<li>편입후기</li>
							</ul>
							<div class="tbl_td">
								<c:forEach items="${resultList }" var="result">
									<ul>
										<li><c:out value="${result.trName }"/></li>
										<li class="txt_left"><c:out value="${result.trPreSchool }"/></li>
										<li>
											<c:out value="${result.trRegSemesterBegin }"/>
											~
											<c:out value="${result.trRegSemesterEnd }"/>
										</li>
										<c:if test="${!empty result.trActivity }">
											<li class="txt_left">
												<c:out value="${result.trActivity }" escapeXml="false"/>
											</li>
										</c:if>
										<c:if test="${empty result.trActivity }">
											<li>
												-
											</li>
										</c:if>
										<li><c:out value="${result.trResult }"/></li>
										<li>
											<c:if test="${!empty result.trUrl }">
												<a href="<c:out value='${result.trUrl }'/>">편입후기</a>
											</c:if>
										</li>
									</ul>
								</c:forEach>
							</div>
						</div>
						<div class="pager">
							<ui:pagination paginationInfo="${paginationInfo }" type="image2" jsFunction="fn_list"/>
							<form:hidden path="pageIndex"/>
						</div>
					</c:if>
					<c:if test="${searchVO.searchType eq '02'}">
						<div class="tit_3rd">대학원 진학 & 학부편입</div>
						<div class="ta_overbox">
							<table class="ta874" summary="한디원 실내디자인전공 대학원 진학 & 학부편입 리스트">
								<caption>대학원 진학 & 학부편입 리스트</caption>
								<colgroup>
									<col style="width:10%;" />
									<col style="width:20%;" />
									<col style="width:" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">연도</th>
										<th scope="col">학교</th>
										<th scope="col">내용</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td style="text-align: center;" rowspan="3">2020-1</td>
										<td style="text-align: center; border-left:1px solid #cccccc;">홍익대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">일반대학원1명</p>
											<p style="margin: 5px;">공간디자인학과 [이 * *]</p>
											<p style="margin: 5px;">공연예술대학원1명</p>
											<p style="margin: 5px;">공연예술 뮤지컬전공 [진 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center;border-left:1px solid #cccccc;">국민대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">테크노디자인대학원3명</p>
											<p style="margin: 5px;">라이프스타일디자인학과</p>
											<p style="margin: 5px;">[정 * *, 김 * *, 권 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center;border-left:1px solid #cccccc;">건국대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">일반대학원1명</p>
											<p style="margin: 5px;">부동산학과 부동산건설개발전공</p>
											<p style="margin: 5px;">[홍 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center;" rowspan="6">2019</td>
										<td style="text-align: center; border-left:1px solid #cccccc;">한성대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">일반대학원1명</p>
											<p style="margin: 5px;">인테리어전공 [김 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center;border-left:1px solid #cccccc;">홍익대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">일반대학원1명</p>
											<p style="margin: 5px;">공간디자인학과 [이 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">한양대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">일반대학원3명</p>
											<p style="margin: 5px;">실내건축학과[김 * *, 설 * *, 김 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">국민대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">테크노디자인대학원2명</p>
											<p style="margin: 5px;">라이프스타일디자인학과[이 * *, 원 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">건국대학교</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">실내건축학과</p>
											<p style="margin: 5px;">학부편입1명</p>
											<p style="margin: 5px;">[한 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">덕성여자대학교</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">실내디자인전공</p>
											<p style="margin: 5px;">학부편입1명</p>
											<p style="margin: 5px;">[이 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center;" rowspan="6">2018</td>
										<td style="text-align: center;">연세대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">생활환경대학원1명</p>
											<p style="margin: 5px;">공간디자인학과 1명 [김 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">국민대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">테크노디자인대학원9명</p>
											<p style="margin: 5px;">라이프스타일디자인학과 [조 * *, 김 * *]</p>
											<p style="margin: 5px;">크리에이티브인테리어아키텍쳐 [이 * *, 김 * *]</p>
											<p style="margin: 5px;">건축디자인학과 퓨처폼파인딩</p>
											<p style="margin: 5px;">[한 * *, 윤 * *, 유 * *, 임 * *]</p>
											<p style="margin: 5px;">건축디자인학과 스마트스페이스 랩[최 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">덕성여자대학교</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">실내디자인학과</p>
											<p style="margin: 5px;">학부편입1명</p>
											<p style="margin: 5px;">[성 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">중앙대학교</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">산업디자인학과</p>
											<p style="margin: 5px;">학부편입1명</p>
											<p style="margin: 5px;">[오 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">서울과학기술대학교</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">금속공학과</p>
											<p style="margin: 5px;">학부편입1명</p>
											<p style="margin: 5px;">[한 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">상명대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">일반대학원1명</p>
											<p style="margin: 5px;">무대미술학과[윤 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center;" rowspan="2">2017</td>
										<td style="text-align: center;">홍익대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">일반대학원1명</p>
											<p style="margin: 5px;">목가구조형학과</p>
											<p style="margin: 5px;">[장 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">국민대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">테크노디자인대학원1명</p>
											<p style="margin: 5px;">건축디자인학과 퓨처폼파인딩</p>
											<p style="margin: 5px;">[이 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center;" rowspan="4">2016</td>
										<td style="text-align: center;">한성대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">일반대학원1명</p>
											<p style="margin: 5px;">인테리어전공[박 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">연세대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">일반대학원1명</p>
											<p style="margin: 5px;">실내건축학과[최 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">홍익대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">일반대학원2명</p>
											<p style="margin: 5px;">공간디자인학과[문 *]</p>
											<p style="margin: 5px;">목가구 조형학과[장 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">건국대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">건축전문대학원2명</p>
											<p style="margin: 5px;">실내건축학과[김 * *, 한 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center;" rowspan="6">2015</td>
										<td style="text-align: center;">한성대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">일반대학원4명</p>
											<p style="margin: 5px;">인테리어전공</p>
											<p style="margin: 5px;">[김 * *, 허 * *, 최 * *, 정 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">국민대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">일반대학원2명</p>
											<p style="margin: 5px;">크리에이티브인테리어아키텍쳐</p>
											<p style="margin: 5px;">[김 * *, 김 * *]</p>
											<p style="margin: 5px;">테크노디자인대학원1명</p>
											<p style="margin: 5px;">건축디자인학과 스마트스페이스 랩[허 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">한양대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">공과대학원1명</p>
											<p style="margin: 5px;">생태조형학과[이 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">건국대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">건축전문대학원2명</p>
											<p style="margin: 5px;">실내건축학과[황 * *, 김 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">한성대학교</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">인테리어디자인학과</p>
											<p style="margin: 5px;">학부편입1명</p>
											<p style="margin: 5px;">[장 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">상명대학교</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">무대디자인학과</p>
											<p style="margin: 5px;">학부편입1명</p>
											<p style="margin: 5px;">[고 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center;" rowspan="7">2014</td>
										<td style="text-align: center;">한성대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">일반대학원2명</p>
											<p style="margin: 5px;">인테리어전공[김 * *, 정 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">홍익대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">건축도시대학원 실내설계전공 [신 * *]</p>
											<p style="margin: 5px;">일반대학원 공간디자인학과 [정 * *]</p>
											<p style="margin: 5px;">건도시대학원 건축설계전공 [조 * *]</p>
											<p style="margin: 5px;">산업미술대학원 광고디자인학과 [한 * *]</p>
											<p style="margin: 5px;">광고홍보대학원 브랜드매니지먼트학과 [신 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">국민대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">테크노디자인대학원2명</p>
											<p style="margin: 5px;">크리에이티브인테리어아키텍쳐 [송 * *]</p>
											<p style="margin: 5px;">건축디자인학과[허 * *]</p>
											<p style="margin: 5px;">종합예술대학원 2명</p>
											<p style="margin: 5px;">무대기술 및 제작전공 [정 * *, 김 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">이화여대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">디자인대학원1명</p>
											<p style="margin: 5px;">크레프트디자인학과</p>
											<p style="margin: 5px;">[강 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">성균관대학교</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">일반대학원1명</p>
											<p style="margin: 5px;">브랜드메니지먼트전공</p>
											<p style="margin: 5px;">[노 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">Purdue University</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">Interior MFA 1명</p>
											<p style="margin: 5px;">[최 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">건국대학교</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">실내건축학과</p>
											<p style="margin: 5px;">학부편입1명</p>
											<p style="margin: 5px;">[김 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center;" rowspan="2">2013</td>
										<td style="text-align: center;">한성대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">일반대학원2명</p>
											<p style="margin: 5px;">인테리어전공[김 * *, 이 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">홍익대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">일반대학원1명 </p>
											<p style="margin: 5px;">실내디자인학과 [길 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center;" rowspan="4">2012</td>
										<td style="text-align: center;">한성대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">일반대학원2명</p>
											<p style="margin: 5px;">인테리어전공[김 * *, 정 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">홍익대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">일반대학원2명</p>
											<p style="margin: 5px;">건축도시대학원 실내설계전공 [심 * *, 서 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">국민대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">테크노디자인대학원 1명</p>
											<p style="margin: 5px;">실내디자인학과 [한 * *]</p>
											<p style="margin: 5px;">일반대학원  1명</p>
											<p style="margin: 5px;">실내디자인학과 [이 *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">성균관대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">일반대학원1명</p>
											<p style="margin: 5px;">브랜드메니지먼트전공</p>
											<p style="margin: 5px;">[최 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center;" rowspan="5">2011</td>
										<td style="text-align: center;">한성대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">일반대학원1명</p>
											<p style="margin: 5px;">인테리어전공[주 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">홍익대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">산업미술대학원1명</p>
											<p style="margin: 5px;">공간디자인학과 [김 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">동덕여자대학교</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">실내/시각디자인</p>
											<p style="margin: 5px;">학부편입1명</p>
											<p style="margin: 5px;">[손 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">단국대학교</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">금속공예과</p>
											<p style="margin: 5px;">학부편입2명</p>
											<p style="margin: 5px;">[김 * *, 윤 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">아주대학교</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">화학과</p>
											<p style="margin: 5px;">학부편입1명</p>
											<p style="margin: 5px;">[최 *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center;" rowspan="4">2010</td>
										<td style="text-align: center;">한성대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">일반대학원2명</p>
											<p style="margin: 5px;">인테리어전공[장 * *, 한 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">성균관대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">일반대학원3명</p>
											<p style="margin: 5px;">써피스디자인학과 [박 * *, 이 *, 정 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">경원대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">일반대학원2명</p>
											<p style="margin: 5px;">실내건축디자인학과[홍 * *, 임 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">한성대학교</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">인테리어디자인학과</p>
											<p style="margin: 5px;">학부편입1명</p>
											<p style="margin: 5px;">[노 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center;" rowspan="2">2009</td>
										<td style="text-align: center;">한성대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">일반대학원2명</p>
											<p style="margin: 5px;">인테리어전공[김 * *, 이 * *]</p>
										</td>
									</tr>
									<tr>
										<td style="text-align: center; border-left:1px solid #cccccc;">상명대</td>
										<td style="text-align: center;">
											<p style="margin: 5px;">문화예술대학원1명</p>
											<p style="margin: 5px;">무대디자인전공[엄 * *]</p>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="list_sh" style="margin-top:50px;" id="focus">
							<ul>
								<li>
									<form:select path="searchCondition1">
										<form:option value="aftschool">편입대학&대학원</form:option>
										<form:option value="activity">활동</form:option>
										<form:option value="result">결과</form:option>
									</form:select>
								</li>
								<li>
									<form:input path="searchWord"/>
								</li>
								<li>
									<a href="#" onclick="fn_list(1); return false">
										<img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/icon_sh.png'/>" alt="찾기" />
									</a>
								</li>
							</ul>
						</div>
						<div class="transform_table case_type">
							<ul class="tbl_th">
								<li>이름</li>
								<li>편입대학&대학원</li>
								<li>등록학기</li>
								<li>활동</li>
								<li>결과(취업센터)</li>
								<li>편입후기</li>
							</ul>
							<div class="tbl_td">
								<c:forEach items="${resultList }" var="result">
									<ul>
										<li><c:out value="${result.grName }"/></li>
										<li class="txt_left"><c:out value="${result.grAftSchool }"/></li>
										<li>
											<c:out value="${result.grRegSemesterBegin }"/>
											~
											<c:out value="${result.grRegSemesterEnd }"/>
										</li>
										<c:if test="${!empty result.grActivity }">
											<li class="txt_left">
												<c:out value="${result.grActivity }" escapeXml="false"/>
											</li>
										</c:if>
										<c:if test="${empty result.grActivity }">
											<li>
												-
											</li>
										</c:if>
										<li><c:out value="${result.grResult }"/></li>
										<li>
											<c:if test="${!empty result.grUrl }">
												<a href="<c:out value='${result.grUrl }'/>">편입후기</a>
											</c:if>
										</li>
									</ul>
								</c:forEach>
							</div>
						</div>
						<div class="pager">
							<ui:pagination paginationInfo="${paginationInfo }" type="image2" jsFunction="fn_list"/>
							<form:hidden path="pageIndex"/>
						</div>
					</c:if>
				</div>
			</div>
		</div>
		<!-- footer -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
		<!-- //footer -->
	</div>
</form:form>
<script type="text/javascript">
	var searchCondition1 = '<c:out value="${searchVO.searchCondition1}"/>';
	if("" != searchCondition1) location.href = "#focus";
</script>
</body>
</html>
