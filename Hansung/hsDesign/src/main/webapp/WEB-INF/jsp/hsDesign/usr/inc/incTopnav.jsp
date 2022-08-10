
<%@page import="egovframework.com.cmm.util.EgovUserDetailsHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ page import="hsDesign.valueObject.cmm.CmmnSearchVO"%> 
<%
	String menuNo = ((String)session.getAttribute("menuNo")!=null)?(String)session.getAttribute("menuNo"):"";
	
	// 190304  김현영 자랑스러운 한디원  - festival 메뉴번호 지정.
	// 191111 김현영 재수정
	CmmnSearchVO searchVO = (CmmnSearchVO)request.getAttribute("searchVO");
	if(searchVO!=null) {
		String menuType = (String)searchVO.getMenuType();
		if("0701".equals(menuType)) {
			menuNo = "501";
		}
	}
%>

<!-- 메뉴 백그라운드 이미지 CSS -->
<header class="top_head 
<% if( menuNo.indexOf("101")==0 ){ %>
	visual_01
<% } else if( menuNo.indexOf("102")==0 ){%>
	visual_01
<% } else if( menuNo.indexOf("103")==0 ){%>
	visual_01
<% } else if( menuNo.indexOf("104")==0 ){%>
	visual_01
<% } else if( menuNo.indexOf("105")==0 ){%>
	visual_01
<% } else if( menuNo.indexOf("106")==0 ){%>
	visual_01
<% } else if( menuNo.indexOf("240")==0 ){%>
	visual_01
<% } else if( menuNo.indexOf("109")==0 ){%>
	visual_01
<% } else if( menuNo.indexOf("107")==0 ){%>
	visual_01
<% } else if( menuNo.indexOf("108")==0 ){%>
	visual_01
<% } else if( menuNo.indexOf("110")==0 ){%>
	visual_01
<% } else if( menuNo.indexOf("120")==0 ){%>
	visual_01
<% } else if( menuNo.indexOf("130")==0 ){%>
	visual_01
<% } else if( menuNo.indexOf("140")==0 ){%>
	visual_01
<% } else if( menuNo.indexOf("150")==0 ){%>
	visual_01
<% } else if( menuNo.indexOf("160")==0 ){%>
	visual_08
<% } else if( menuNo.indexOf("210")==0 ){%>
	visual_01
<% } else if( menuNo.indexOf("220")==0 ){%>
	visual_05
<% } else if( menuNo.indexOf("20")==0 ){%>
	visual_02
<% } else if( menuNo.indexOf("30")==0 ){%>
	visual_04
<% } else if( menuNo.indexOf("40")==0 ){%>
	visual_06
<% } else if( menuNo.indexOf("50")==0 ){%>
	visual_08
<% } else if( menuNo.indexOf("60")==0 ){%>
	visual_03
<% } else if( menuNo.indexOf("70")==0 ){%>
	visual_08
<% } else if( menuNo.indexOf("80")==0 ){%>
	visual_07
<% } else if( menuNo.indexOf("90")==0 ){%>
	visual_09
<% } else if( menuNo.indexOf("23001")==0 ){%>
	visual_08
<% } else if( menuNo.indexOf("23002")==0 ){%>
	visual_08
<% } else if( menuNo.indexOf("23003")==0 ){%>
	visual_08
<% } else if( menuNo.indexOf("260")==0 ){%>
	visual_03<% } %>" id="header">	
	<div class="width_box">
		<div class="sh_box">
			<div>
				<input type="checkbox" id="sh_open_btn" />					
				<div class="sh_close">
					<label for="sh_open_btn"  class="btn_sh">검색창 열기</label>
				</div>
				<div class="sh_open">
					<input type="text" id="word" name="word" placeholder="검색어를 입력하세요" /> 
					<a href="#" class="btn_sh" onclick="fn_search(); return false;">찾기</a>
					
				</div>					
			</div>				
		</div>		
		<div class="top_logo"><a href="<c:out value='${pageContext.request.contextPath }/usr/main/index.do'/>"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/top_logo_01.png'/>" alt="한성대학교 부설 디자인아트교육원" /></a></div> 		
		<!-- top_menu -->
		<!-- 200402 수정  -->
		<div class="top_menu">	
			<div class="menu_btn"><label for="toggleBtn"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/mobile_menu.png'/>" alt="전체메뉴" /></label></div>						
			<ul class="transition" id="top_menu">
				<li style="margin-right: -10px;"><a href="<c:out value='${pageContext.request.contextPath }/usr/info/hdIntro.do'/>">한디원소개</a>
					<ul>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/info/ledgerGreeting.do'/>">원장인사말</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/info/hdIntro.do'/>">한디원소개</a></li>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/info/presidentGreeting.do'/>">총장인사말</a></li> --%>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/proud/proudList.do'/>">한디원 이슈</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/overseas/overseas.do'/>">해외프로그램</a></li>

						<!-- <li><a href="<c:out value='${pageContext.request.contextPath }/usr/info/disclosure.do'/>">기관정보공시</a></li> -->
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/liberal.do'/>">보유과목안내</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/info/hotline.do'/>">조직및연락처</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/info/location.do'/>">오시는길</a></li>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/info/promotionVideo.do'/>">홍보영상</a></li> --%>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/info/brodata/broDataList.do'/>">브로셔 자료</a></li> --%>
					</ul>
				</li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorInfo.do?menuType=01'/>">전공</a>
					<ul>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorInfo.do?menuType=01'/>">실내디자인</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/visual/majorVisualInfo.do?menuType=01'/>">시각디자인학</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/industrial/majorIndustrialInfo.do?menuType=01'/>">산업디자인</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalArt/majorDigitalArtInfo.do?menuType=01'/>">디지털아트학(디자인)</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalEnt/majorDigitalEntInfo.do?menuType=01'/>">디지털아트학(게임)</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionInfo.do?menuType=01'/>">패션디자인학</a></li>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fbusiness/majorFbusinessInfo.do?menuType=01'/>">패션비즈니스</a></li> --%>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beauty/majorBeautyInfo.do?menuType=01'/>">미용학(뷰티2+2)</a></li>
					<!--	<li><a href="<c:out value='${pageContext.request.contextPath }/usr/course/courseInfo.do'/>">2+2본교연계과정</a></li> -->
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/elite.do'/>">일학습엘리트과정</a></li>
						<%--
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beautyOne/majorBeautyOneInfo.do?menuType=01'/>">미용학(one-day)</a></li>
						--%>
					</ul>				
				</li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/usr/enter/prospectus.do'/>">입학안내</a>
					<ul>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/enter/prospectus.do'/>">모집요강</a></li>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/eliteProspect.do'/>">모집요강(일학습엘리트)</a></li> --%>
						<li><a href="#" onclick="fn_appliForm_choose_sub(); return false;">원서접수</a></li>
						<li><a href="#" onclick="fn_appliForm_open_sub('02'); return false;">원서접수확인</a></li>
						<li><a href="#" onclick="fn_appliForm_open_sub('03'); return false;">합격자, 등록금 조회</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/enter/consult/consultList.do'/>">입학상담</a></li>
<!-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/enter/faq/faqList.do?menuType=01'/>">자주하는 질문</a></li>-->						
						 <li><a href="<c:out value='${pageContext.request.contextPath }/usr/enter/brochure/brochureModify.do'/>">브로셔신청</a></li>
					</ul>
				</li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/adcal/academicCalendar.do'/>">학사안내</a>
					<ul>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/adcal/academicCalendar.do'/>">학사일정</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/enter/faq/faqList.do?menuType=01'/>">학사정보</a></li>

					<!--	<li><a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/guide/affairsGuide.do?menuType=01'/>">학사정보</a></li>-->
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/scholarship.do'/>">장학제도</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/form/formList.do'/>">양식자료실</a></li>
						<li><a href="<c:url value='https://edulms.hansung.ac.kr/login.php'/>" target="_blank">학사정보시스템</a></li>
						<li><a href="<c:url value='https://uni.webminwon.com/servlet/WMINDEX?COMMAND=ACTIVEX&GIWANNO=021185'/>" target="_blank">제증명발급</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/faq/faqList.do'/>">자주 묻는 질문</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/qna/qnaList.do'/>">학사 Q&amp;A</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/smg/smgList.do'/>">한디원신문고</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/notice/noticeList.do'/>">공지사항</a></li>
					</ul>
				</li>
				<%-- <li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/exhibit.do'/>">캠퍼스생활</a>
					<ul>
						<!-- <li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/proud/proudList.do'/>">한디원 이슈</a></li> -->
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/employment.do'/>">졸업후 진로</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/exhibit.do'/>">공모전 수상</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/ass/assList.do'/>">기업 · 지역연계수업</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/info/brodata/broDataList.do'/>">작품자료실</a></li>
						<!-- <li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/overseas/overseas.do'/>">해외프로그램</a></li> -->
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/info/promotionVideo.do'/>">해외프로그램</a></li>
					</ul>
				</li> --%>
				<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/employment.do'/>">취업센터</a>
					<ul>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/employment.do'/>">취업현황</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/univercity.do'/>">진학현황</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/interview.do?menuType=01'/>">성공후기</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/enterprise.do'/>">산학협력(MOU)</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/employment/employList.do'/>">취업프로그램</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/jobs/worknet/recruitment/recruList.do'/>">채용공고</a></li>
					</ul>
				</li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/usr/general/info/generalInfoList.do'/>">D-School</a>
					<ul>										
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/general/question/generalQuestionList.do'/>">공지사항</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/general/info/generalInfoList.do'/>">과정안내</a></li>	
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/general/request/generalRequestList.do'/>">D-School Q&A</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/general/exper/experNewsList.do'/>">진로체험소식</a></li>

					</ul>
				</li>
				<!--<li><a href="<c:out value='${pageContext.request.contextPath }/usr/general/exper/experInfo.do'/>">진로체험</a>
					<ul>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/general/exper/experInfo.do'/>">진로체험안내</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/general/exper/experModify.do'/>">진로체험신청</a></li> 
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/general/exper/experNewsList.do'/>">진로체험소식</a></li>
					</ul>
				</li>-->
<%-- 				<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/elite.do'/>">일학습엘리트과정</a> --%>
<!-- 					<ul> -->
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/elite.do'/>">일학습엘리트과정</a></li> --%>
						
<%-- 						
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/interior/eliteInteriorInfo.do'/>">타일디자인시공</a></li> --%>
<!-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/digitalArt/eliteDigitalArtInfo.do'/>">성우콘텐츠크리에이터</a></li> -->
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/fbusiness/eliteFbusinessInfo.do'/>">글로벌패션창업</a></li> --%>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyInfo.do'/>">뷰티교육자</a></li> --%>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyInfo.do'/>">하야시두피모발</a></li> --%>
<!-- 					</ul> -->
<!-- 				</li> -->
			</ul>
		</div>
		<!-- //top_menu -->
	</div>
		
		
		<!-- 200402 수정  -->
		<!-- 모바일화면 -->
	<input type="checkbox" id="toggleBtn" />
	<div class="all_menu_open" id="all_menu_open">
		<div class="width_box">
			<div class="m_top">
				<div><a href="#"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/m_top_logo.jpg'/>" alt="한성대학교 부설 디자인아트교육원" ></a></div>				
				<div class="m_close_btn">					
					<label for="toggleBtn"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/m_top_close.jpg'/>" alt="메뉴닫기" id="allClose"></label>
				</div>
			</div>
			<ul>
				<li><a href="javascript:;"><div>한디원소개</div><label for="t_menu01" onclick>한디원소개</label></a>
					<input type="radio" name="t_menu" id="t_menu01" />				
					<ul>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/info/ledgerGreeting.do'/>">원장인사말</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/info/hdIntro.do'/>">한디원소개</a></li>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/info/presidentGreeting.do'/>">총장인사말</a></li> --%>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/proud/proudList.do'/>">한디원 이슈</a></li>
						<li><a class="th_menu03" href="<c:out value='${pageContext.request.contextPath }/usr/community/overseas/overseas.do'/>"><div>해외프로그램</div><label for="st_menu05">해외프로그램</label></a>
								<input type="radio" name="st_menu" id="st_menu05" />
							<ul>
								<li>							
								<a href="<c:out value='${pageContext.request.contextPath }/usr/community/overseas/overseas.do'/>">해외인턴십</a>
								</li>
								<li> 					
								<a href="<c:out value='${pageContext.request.contextPath }/usr/community/oveServ/oveServ.do'/>">해외봉사</a>

								</li>

							</ul>
						</li>
						<!-- <li><a href="<c:out value='${pageContext.request.contextPath }/usr/info/disclosure.do'/>">기관정보공시</a></li> -->
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/liberal.do'/>">보유과목안내</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/info/hotline.do'/>">조직및연락처</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/info/location.do'/>">오시는길</a></li>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/info/promotionVideo.do'/>">홍보영상</a></li> --%>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/info/brodata/broDataList.do'/>">브로셔 자료</a></li> --%>
					</ul>
				</li>
				<li><a href="javascript:;"><div>전공</div><label for="t_menu02" onclick>전공</label></a>
					<input type="radio" name="t_menu" id="t_menu02" />																		
					<ul>
						<li><a class="th_menu03" href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorInfo.do?menuType=01'/>"><div>실내디자인</div><label for="st_menu01">실내디자인</label></a>
							<input type="radio" name="st_menu" id="st_menu01" />
							<ul>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorInfo.do?menuType=01'/>">전공안내</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorTeacherList.do'/>">교수소개</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorJobList.do?menuType=01'/>">진출분야</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorCourse.do?menuType=01'/>">교과과정</a></li>
								<c:set var="num" value="5"/>
								<c:forEach var="list" items="${bcList }">
									<c:if test="${list.mCode eq '01'}">
										<c:set var="num" value="${num +1 }"/>
										<c:set var="menuNum" value="1010${num }"/>
										<li>
											<a  href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out value="${list.bcName }"/></a>
										</li>
									</c:if>
								</c:forEach>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/transfer/transferReview/transferReviewList.do?menuType=01'/>">편입사례</a></li>
							</ul>
						</li>
						<li><a class="th_menu03" href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/visual/majorVisualInfo.do?menuType=01'/>"><div>시각디자인학</div><label for="st_menu02">시각디자인학</label></a>
							<input type="radio" name="st_menu" id="st_menu02" />
							<ul>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/visual/majorVisualInfo.do?menuType=01'/>">전공안내</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/visual/majorVisualTeacherList.do'/>">교수소개</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/visual/majorVisualJobList.do?menuType=01'/>">진출분야</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/visual/majorVisualCourse.do?menuType=01'/>">교과과정</a></li>
								<c:set var="num" value="4"/>
								<c:forEach var="list" items="${bcList }">
									<c:if test="${list.mCode eq '02'}">
										<c:set var="num" value="${num +1 }"/>
										<c:set var="menuNum" value="1020${num }"/>
										<li>
											<a  href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/visual/majorVisualList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out value="${list.bcName }"/></a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</li>
						<li><a class="th_menu03" href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/industrial/majorIndustrialInfo.do?menuType=01'/>"><div>산업디자인</div><label for="st_menu03">산업디자인</label></a>
							<input type="radio" name="st_menu" id="st_menu03" />
							<ul>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/industrial/majorIndustrialInfo.do?menuType=01'/>">전공안내</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/industrial/majorIndustrialTeacherList.do'/>">교수소개</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/industrial/majorIndustrialJobList.do?menuType=01'/>">진출분야</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/industrial/majorIndustrialCourse.do?menuType=01'/>">교과과정</a></li>
								<c:set var="num" value="4"/>
								<c:forEach var="list" items="${bcList }">
									<c:if test="${list.mCode eq '03'}">
										<c:set var="num" value="${num +1 }"/>
										<c:set var="menuNum" value="1030${num }"/>
										<li>
											<a  href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/industrial/majorIndustrialList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out value="${list.bcName }"/></a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</li>
						<li><a class="th_menu03" href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalArt/majorDigitalArtInfo.do?menuType=01'/>"><div>디지털아트학(디자인)</div><label for="st_menu04">디지털아트학(디자인)</label></a>
							<input type="radio" name="st_menu" id="st_menu04" />
							<ul>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalArt/majorDigitalArtInfo.do?menuType=01'/>">전공안내</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalArt/majorDigitalArtTeacherList.do'/>">교수소개</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalArt/majorDigitalArtJobList.do?menuType=01'/>">진출분야</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalArt/majorDigitalArtCourse.do?menuType=01'/>">교과과정</a></li>
								<c:set var="num" value="4"/>
								<c:forEach var="list" items="${bcList }">
									<c:if test="${list.mCode eq '04'}">
										<c:set var="num" value="${num +1 }"/>
										<c:set var="menuNum" value="1040${num }"/>
										<li>
											<a  href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalArt/majorDigitalArtList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out value="${list.bcName }"/></a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</li>
						<li><a class="th_menu03" href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalEnt/majorDigitalEntInfo.do?menuType=01'/>"><div>디지털아트학(게임)</div><label for="st_menu06">디지털아트학(게임)</label></a>
							<input type="radio" name="st_menu" id="st_menu06" />
							<ul>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalEnt/majorDigitalEntInfo.do?menuType=01'/>">전공안내</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalEnt/majorDigitalEntTeacherList.do'/>">교수소개</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalEnt/majorDigitalEntJobList.do?menuType=01'/>">진출분야</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalEnt/majorDigitalEntCourse.do?menuType=01'/>">교과과정</a></li>
								<c:set var="num" value="4"/>
								<c:forEach var="list" items="${bcList }">
									<c:if test="${list.mCode eq '11'}">
										<c:set var="num" value="${num +1 }"/>
										<c:set var="menuNum" value="1090${num }"/>
										<li>
											<a  href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/digitalEnt/majorDigitalEntList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out value="${list.bcName }"/></a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</li>
						<li><a class="th_menu03" href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionInfo.do?menuType=01'/>"><div>패션디자인학</div><label for="st_menu05">패션디자인학</label></a>
							<input type="radio" name="st_menu" id="st_menu05" />
							<ul>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionInfo.do?menuType=01'/>">전공안내</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionTeacherList.do'/>">교수소개</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionJobList.do?menuType=01'/>">진출분야</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionCourse.do?menuType=01'/>">교과과정</a></li>
								<c:set var="num" value="4"/>
								<c:forEach var="list" items="${bcList }">
									<c:if test="${list.mCode eq '05'}">
										<c:set var="num" value="${num +1 }"/>
										<c:set var="menuNum" value="1050${num }"/>
										<li>
											<a  href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fassion/majorFassionList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out value="${list.bcName }"/></a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</li>
<%-- 						<li><a class="th_menu03" href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fbusiness/majorFbusinessInfo.do?menuType=01'/>"><div>패션비즈니스</div><label for="st_menu06">패션비즈니스</label></a> 
							<input type="radio" name="st_menu" id="st_menu06" />
							<ul>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fbusiness/majorFbusinessInfo.do?menuType=01'/>">전공안내</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fbusiness/majorFbusinessTeacherList.do'/>">교수소개</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fbusiness/majorFbusinessJobList.do?menuType=01'/>">진출분야</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fbusiness/majorFbusinessCourse.do?menuType=01'/>">교과과정</a></li>
								<c:set var="num" value="4"/>
								<c:forEach var="list" items="${bcList }">
									<c:if test="${list.mCode eq '06'}">
										<c:set var="num" value="${num +1 }"/>
										<c:set var="menuNum" value="1060${num }"/>
										<li>
											<a  href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/fbusiness/majorFbusinessList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out value="${list.bcName }"/></a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</li>--%>
						<li><a class="th_menu03" href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beauty/majorBeautyInfo.do?menuType=01'/>"><div>미용학(뷰티2+2)</div><label for="st_menu07">미용학(뷰티2+2)</label></a>
							<input type="radio" name="st_menu" id="st_menu07" />
							<ul>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beauty/majorBeautyInfo.do?menuType=01'/>">전공안내</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beauty/majorBeautyTeacherList.do'/>">교수소개</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beauty/majorBeautyJobList.do?menuType=01'/>">진출분야</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beauty/majorBeautyCourse.do?menuType=01'/>">교과과정</a></li>
								<c:set var="num" value="4"/>
								<c:forEach var="list" items="${bcList }">
									<c:if test="${list.mCode eq '07'}">
										<c:set var="num" value="${num +1 }"/>
										<c:set var="menuNum" value="1070${num }"/>
										<li>
											<a  href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beauty/majorBeautyList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out value="${list.bcName }"/></a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</li>
				<!--		<li><a class="th_menu03" href="<c:out value='${pageContext.request.contextPath }/usr/course/courseInfo.do'/>"><div>2+2본교연계과정</div><label for="st_menu20">2+2본교연계과정</label></a>
							<input type="radio" name="st_menu" id="st_menu20" />
							<ul>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/course/courseInfo.do'/>">2+2본교연계과정</a></li>
							</ul>
						</li>-->
				<!-- 200402추가 -->
						<li><a class="th_menu03" href="<c:out value='${pageContext.request.contextPath }/usr/elite/elite.do'/>"><div>일학습엘리트과정</div><label for="st_menu08">일학습엘리트과정</label></a>
							<input type="radio" name="st_menu" id="st_menu08" />
							<ul>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/elite.do'/>">일학습엘리트과정이란?</a></li>
								
								<!--20210402 관리자요청 <li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/fbusiness/eliteFbusinessInfo.do'/>"><div>글로벌패션창업</div><label for="sts_menu01">글로벌패션창업</label></a>
								<input type="radio" name="sts_menu" id="sts_menu01"/>
									<ul>
										<li>&nbsp;&nbsp;&nbsp;&nbsp;<a href="<c:out value='${pageContext.request.contextPath }/usr/elite/fbusiness/eliteFbusinessInfo.do'/>">전공안내</a></li>
										<li>&nbsp;&nbsp;&nbsp;&nbsp;<a href="<c:out value='${pageContext.request.contextPath }/usr/elite/fbusiness/eliteFbusinessTeacherList.do'/>">교수소개</a></li>
										<li>&nbsp;&nbsp;&nbsp;&nbsp;<a href="<c:out value='${pageContext.request.contextPath }/usr/elite/fbusiness/eliteFbusinessCourse.do?menuType=01'/>">교과과정</a></li>
										<li>&nbsp;&nbsp;&nbsp;&nbsp;<a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteFbusinessList.do?searchType=51&menuNo=13004'/>">전공소식</a></li>
									</ul>
								</li> -->
								
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyInfo.do'/>"><div>하야시두피모발/뷰티교육자</div><label for="sts_menu02">하야시두피모발/뷰티교육자</label></a>
								<input type="radio" name="sts_menu" id="sts_menu02"/>
									<ul>
										<li>&nbsp;&nbsp;&nbsp;&nbsp;<a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyInfo.do?'/>">전공안내</a></li>
										<li>&nbsp;&nbsp;&nbsp;&nbsp;<a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyTeacherList.do'/>">교수소개</a></li>
										<li>&nbsp;&nbsp;&nbsp;&nbsp;<a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyCourse.do?menuType=01'/>">교과과정</a></li>
										<li>&nbsp;&nbsp;&nbsp;&nbsp;<a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyList.do?searchType=51&menuNo=14004'/>">전공소식</a></li>
									</ul>
								</li>
									<%--
										<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/fbusiness/eliteFbusinessInfo.do'/>">글로벌패션창업</a></li>
										<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/fbusiness/eliteFbusinessInfo.do'/>">&nbsp;&nbsp;&nbsp;&nbsp;전공안내</a></li>
										<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/fbusiness/eliteFbusinessTeacherList.do'/>">&nbsp;&nbsp;&nbsp;&nbsp;교수소개</a></li>
										<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/fbusiness/eliteFbusinessCourse.do?menuType=01'/>">&nbsp;&nbsp;&nbsp;&nbsp;교과과정</a></li>
										<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteFbusinessList.do?searchType=51&menuNo=13004'/>">&nbsp;&nbsp;&nbsp;&nbsp;전공소식</a></li>
								
										<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyInfo.do?'/>">뷰티교육자</a></li>
										<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyInfo.do?'/>">&nbsp;&nbsp;&nbsp;&nbsp;전공안내</a></li>
										<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyTeacherList.do'/>">&nbsp;&nbsp;&nbsp;&nbsp;교수소개</a></li>
										<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyCourse.do?menuType=01'/>">&nbsp;&nbsp;&nbsp;&nbsp;교과과정</a></li>
										<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyList.do?searchType=51&menuNo=14004'/>">&nbsp;&nbsp;&nbsp;&nbsp;전공소식</a></li>
									 --%>
							</ul>
						</li>
				<!-- //200402추가 -->
						<%--
						<li><a class="th_menu03" href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beautyOne/majorBeautyOneInfo.do?menuType=01'/>"><div>미용학(one-day)</div><label for="st_menu08" onclick>미용학(one-day)</label></a>
							<input type="radio" name="st_menu" id="st_menu08" />
							<ul>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beautyOne/majorBeautyOneInfo.do?menuType=01'/>">전공안내</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beautyOne/majorBeautyOneTeacherList.do'/>">교수소개</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beautyOne/majorBeautyOneJobList.do?menuType=01'/>">진출분야</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beautyOne/majorBeautyOneCourse.do?menuType=01'/>">교과과정</a></li>
								<c:set var="num" value="4"/>
								<c:forEach var="list" items="${bcList }">
									<c:if test="${list.mCode eq '08'}">
										<c:set var="num" value="${num +1 }"/>
										<c:set var="menuNum" value="1080${num }"/>
										<li>
											<a  href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/beautyOne/majorBeautyOneList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out value="${list.bcName }"/></a>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</li>
						--%>
					</ul>
				</li>
				<li><a href="javascript:;"><div>입학</div><label for="t_menu03" onclick>입학안내</label></a>
					<input type="radio" name="t_menu" id="t_menu03" />
					<ul>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/enter/prospectus.do'/>">모집요강</a></li>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/elite/eliteProspect.do'/>">모집요강(일학습엘리트)</a></li> --%>
						<li><a href="#" onclick="fn_appliForm_choose_sub(); return false;">원서접수</a></li>
						<li><a href="#" onclick="fn_appliForm_open_sub('02'); return false;">원서접수확인</a></li>
						<li><a href="#" onclick="fn_appliForm_open_sub('03'); return false;">합격자, 등록금 조회</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/enter/consult/consultList.do'/>">입학상담</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/enter/faq/faqList.do?menuType=01'/>">자주하는질문</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/enter/brochure/brochureModify.do'/>">브로셔신청</a></li>
					</ul>
				</li>
				<li><a href="javascript:;"><div>학사안내</div><label for="t_menu04" onclick>학사안내</label></a>
					<input type="radio" name="t_menu" id="t_menu04" />	
					<ul>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/adcal/academicCalendar.do'/>">학사일정</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/guide/affairsGuide.do?menuType=01'/>">학사정보</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/scholarship.do'/>">장학제도</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/form/formList.do'/>">양식자료실</a></li>
						<li><a href="<c:url value='https://edulms.hansung.ac.kr/login.php'/>" target="_blank">학사정보시스템</a></li>
						<li><a href="<c:url value='https://uni.webminwon.com/servlet/WMINDEX?COMMAND=ACTIVEX&GIWANNO=021185'/>" target="_blank">제증명발급</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/faq/faqList.do'/>">학사 FAQ</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/qna/qnaList.do'/>">학사 Q&amp;A</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/smg/smgList.do'/>">한디원신문고</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/notice/noticeList.do'/>">공지사항</a></li>
					</ul>
				</li>
<!-- 				구 학사안내 -->
<!-- 				<li><a href="javascript:;"><div>캠퍼스생활</div><label for="t_menu04" onclick>캠퍼스생활</label></a> -->
<!-- 					<input type="radio" name="t_menu" id="t_menu04" />										 -->
<!-- 					<ul> -->
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/adcal/academicCalendar.do'/>">학사일정</a></li> --%>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/guide/affairsGuide.do?menuType=01'/>">학사안내</a></li> --%>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/scholarship.do'/>">장학제도</a></li> --%>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/form/formList.do'/>">양식자료실</a></li> --%>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/hdaCampus/liberal.do'/>">보유과목안내</a></li> --%>
<%-- 						<li><a href="<c:url value='https://edulms.hansung.ac.kr/login.php'/>" target="_blank">학사정보시스템</a></li> --%>
<%-- 						<li><a href="<c:url value='https://uni.webminwon.com/servlet/WMINDEX?COMMAND=ACTIVEX&GIWANNO=021185'/>" target="_blank">제증명발급</a></li> --%>
<!-- 					</ul> -->
<!-- 				</li> -->
			<%-- 	<li><a href="javascript:;"><div>캠퍼스생활</div><label for="t_menu05" onclick>캠퍼스생활</label></a>
					<input type="radio" name="t_menu" id="t_menu05" />
					<ul>

						<!-- <li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/proud/proudList.do'/>">한디원 이슈</a></li>
						 -->
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/employment.do'/>">졸업후 진로</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/exhibit.do'/>">공모전 수상</a></li>
						<li>
						<a class="th_menu03" href="<c:out value='${pageContext.request.contextPath }/usr/community/association.do'/>"><div>기업 · 지역연계수업</div><label for="st_menu11">기업 · 지역연계수업</label></a>
						<input type="radio" name="st_menu" id="st_menu11" />
							<ul>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/association.do'/>">기업 · 지역연계수업이란?</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/ass/assList.do'/>">기업 · 지역연계수업 현황</a></li>
							</ul>
						</li>
						<li>
						<a class="th_menu03" href="<c:out value='${pageContext.request.contextPath }/usr/community/ucc/uccList.do'/>"><div>작품자료실</div><label for="st_menu12">작품자료실</label></a>
						<input type="radio" name="st_menu" id="st_menu12" />
							<ul>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/info/brodata/broDataList.do'/>">작품자료실</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/ucc/uccList.do'/>">동영상</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/webtoon/webtoonList.do'/>">한툰(한디원웹툰)</a></li>
							</ul>
						</li>
<!-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/overseas/overseas.do'/>">해외프로그램</a></li>
						 -->					</ul>
				</li> --%>
				<li><a href="javascript:;"><div>취업센터</div><label for="t_menu06" onclick>취업센터</label></a>
					<input type="radio" name="t_menu" id="t_menu06" />
					<ul>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/employment.do'/>">취업현황</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/univercity.do'/>">진학현황</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/interview.do?menuType=01'/>">성공후기</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/enterprise.do'/>">산업협력(MOU)</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/employment/employList.do'/>">취업프로그램</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/jobs/worknet/recruitment/recruList.do'/>">채용공고</a></li>
					</ul>
				</li>
				
<!-- 				구)캠퍼스 생활 -->
<%-- 				<li><a href="javascript:;" href="<c:out value='${pageContext.request.contextPath }/usr/community/proud/proudList.do'/>"><div>커뮤니티</div><label for="t_menu08" onclick>커뮤니티</label></a> --%>
<!-- 					<input type="radio" name="t_menu" id="t_menu08" />					 -->
<!-- 					<ul> -->
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/proud/proudList.do'/>">한디원 이슈</a></li> --%>
<!-- 						<li> -->
<!-- 							<a class="th_menu03" -->
<%-- 								href="<c:out value='${pageContext.request.contextPath }/usr/community/employment.do'/>"><div>졸업후 진로</div> --%>
<!-- 									<label for="st_menu21">졸업후 진로</label></a> <input type="radio" -->
<!-- 								name="st_menu" id="st_menu21" /> -->
<!-- 							<ul> -->
<!-- 								<li><a -->
<%-- 									href="<c:out value='${pageContext.request.contextPath }/usr/community/employment.do'/>">취업현황</a></li> --%>
<!-- 								<li><a -->
<%-- 									href="<c:out value='${pageContext.request.contextPath }/usr/community/univercity.do'/>">진학현황</a></li> --%>
<!-- 								<li><a -->
<%-- 									href="<c:out value='${pageContext.request.contextPath }/usr/community/interview.do?menuType=01'/>">성공취업 인터뷰</a></li> --%>
<!-- 								<li><a -->
<%-- 									href="<c:out value='${pageContext.request.contextPath }/usr/community/enterprise.do'/>">함께하는 기업들</a></li> --%>
<!-- 							</ul> -->
						</li>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/exhibit.do'/>">공모전 수상</a></li> --%>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/association.do'/>">기업연계수업</a></li> --%>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/ucc/uccList.do'/>">웹툰&amp;동영상</a></li> --%>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/faq/faqList.do'/>">학사 FAQ</a></li> --%>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/qna/qnaList.do'/>">학사 Q&amp;A</a></li> --%>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/smg/smgList.do'/>">한디원신문고</a></li> --%>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/community/notice/noticeList.do'/>">공지사항</a></li> --%>
<!-- 					</ul> -->
<!-- 				</li> -->
				<li><a href="javascript:;"><div>D-School</div><label for="t_menu07" onclick>D-School</label></a>
					<input type="radio" name="t_menu" id="t_menu07" />
					<ul>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/general/question/generalQuestionList.do'/>">공지사항</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/general/info/generalInfoList.do'/>">과정안내</a></li>	
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/general/request/generalRequestList.do'/>">D-School Q&A</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/general/exper/experNewsList.do'/>">진로체험소식</a></li>

					</ul>
				</li>
				<!--<li><a href="javascript:;"><div>진로체험</div><label for="t_menu08" onclick>진로체험</label></a>
					<input type="radio" name="t_menu" id="t_menu08" />
					<ul>
						<li>
						<a class="th_menu03" href="<c:out value='${pageContext.request.contextPath }/usr/general/exper/experInfo.do'/>"><div>진로체험안내</div><label for="st_menu09">진로체험안내</label></a>
						<input type="radio" name="st_menu" id="st_menu09" />
							<ul>
								<li><a href="<c:out value='${pageContext.request.contextPath }/usr/general/exper/experInfo.do'/>">디자인분야 진로체험 안내</a></li>
								<!-- <li><a href="<c:out value='${pageContext.request.contextPath }/usr/general/exper/'/>">진로체험 연혁</a></li> 
							</ul>
						</li> 
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/general/exper/experModify.do'/>">진로체험신청</a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/general/exper/experNewsList.do'/>">진로체험소식</a></li>
					</ul>
				</li>-->

<!-- 구)비학위과정  + 진로체험 -->
<%-- 				<li><a href="javascript:;" href="<c:out value='${pageContext.request.contextPath }/usr/general/info/generalInfoList.do'/>"><div>진로&amp;교양과정</div><label for="t_menu07" onclick>진로&amp;교양과정</label></a> --%>
<!-- 					<input type="radio" name="t_menu" id="t_menu07" />					 -->
<!-- 					<ul> -->
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/general/info/generalInfoList.do'/>">교양과정안내</a></li> --%>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/general/request/generalRequestList.do'/>">교양수강문의</a></li> --%>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/general/exper/experInfo.do'/>">진로체험안내</a></li> --%>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/general/exper/experModify.do'/>">진로체험신청</a></li> --%>
<%-- 						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/general/exper/experNewsList.do'/>">진로체험소식</a></li> --%>
<!-- 					</ul> -->
<!-- 				</li> -->
<!-- 				<li><a href="javascript:;" ><div>일학습엘리트과정</div><label for="t_menu09" onclick>일학습엘리트과정</label></a>  -->
<!-- 					<input type="radio"	name="t_menu" id="t_menu09" /> -->
<!-- 					<ul> -->
<!-- 						<li><a -->
<%-- 							href="<c:out value='${pageContext.request.contextPath }/usr/elite/elite.do'/>">일학습엘리트과정이란?</a></li> --%>
<!-- 						<li><a -->
<%-- 							href="<c:out value='${pageContext.request.contextPath }/usr/elite/eliteProspect.do'/>">모집요강</a></li> --%>
						<%--
						<li>
							<a class="th_menu03"
							href="<c:out value='${pageContext.request.contextPath }/usr/majorBoard/interior/majorInteriorInfo.do?menuType=01'/>"><div>타일디자인시공</div>
								<label for="st_menu11">타일디자인시공</label></a> <input type="radio"
							name="st_menu" id="st_menu11" />
							<ul>
								<li><a
									href="<c:out value='${pageContext.request.contextPath }/usr/elite/interior/eliteInteriorInfo.do?menuType=01'/>">전공안내</a></li>
								<li><a
									href="<c:out value='${pageContext.request.contextPath }/usr/elite/interior/eliteInteriorTeacherList.do'/>">교수소개</a></li>
								<li><a
									href="<c:out value='${pageContext.request.contextPath }/usr/elite/interior/eliteInteriorCourse.do?menuType=01'/>">교과과정</a></li>
								<c:set var="num" value="3" />
								<c:forEach var="list" items="${bcList }">
									<c:if test="${list.mCode eq '11'}">
										<c:set var="num" value="${num +1 }" />
										<c:set var="menuNum" value="1100${num }" />
										<li><a
											href="<c:out value='${pageContext.request.contextPath }/usr/elite/interior/eliteInteriorList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out
													value="${list.bcName }" /></a></li>
									</c:if>
								</c:forEach>
							</ul>
						</li>
						--%>
						<!-- <li>
							<a class="th_menu03"
							href="<c:out value='${pageContext.request.contextPath }/usr/elite/digitalArt/eliteDigitalArtInfo.do?menuType=01'/>"><div>성우콘텐츠크리에이터</div>
								<label for="st_menu12">성우콘텐츠크리에이터</label></a> <input type="radio"
							name="st_menu" id="st_menu12" />
							<ul>
								<li><a
									href="<c:out value='${pageContext.request.contextPath }/usr/elite/digitalArt/eliteDigitalArtInfo.do?menuType=01'/>">전공안내</a></li>
								<li><a
									href="<c:out value='${pageContext.request.contextPath }/usr/elite/digitalArt/eliteDigitalArtTeacherList.do'/>">교수소개</a></li>
								<li><a
									href="<c:out value='${pageContext.request.contextPath }/usr/elite/digitalArt/eliteDigitalArtCourse.do?menuType=01'/>">교과과정</a></li>
								<c:set var="num" value="3" />
								<c:forEach var="list" items="${bcList }">
									<c:if test="${list.mCode eq '12'}">
										<c:set var="num" value="${num +1 }" />
										<c:set var="menuNum" value="1200${num }" />
										<li><a
											href="<c:out value='${pageContext.request.contextPath }/usr/elite/digitalArt/eliteDigitalArtList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out
													value="${list.bcName }" /></a></li>
									</c:if>
								</c:forEach>
							</ul>
						</li> -->
<!-- 						<li> -->
<!-- 							<a class="th_menu03" -->
<%-- 							href="<c:out value='${pageContext.request.contextPath }/usr/elite/fbusiness/eliteFbusinessInfo.do?menuType=01'/>"><div>글로벌패션창업</div> --%>
<!-- 								<label for="st_menu13">글로벌패션창업</label></a> <input type="radio" -->
<!-- 							name="st_menu" id="st_menu13" /> -->
<!-- 							<ul> -->
<!-- 								<li><a -->
<%-- 									href="<c:out value='${pageContext.request.contextPath }/usr/elite/fbusiness/eliteFbusinessInfo.do?menuType=01'/>">전공안내</a></li> --%>
<!-- 								<li><a -->
<%-- 									href="<c:out value='${pageContext.request.contextPath }/usr/elite/fbusiness/eliteFbusinessTeacherList.do'/>">교수소개</a></li> --%>
<!-- 								<li><a -->
<%-- 									href="<c:out value='${pageContext.request.contextPath }/usr/elite/fbusiness/eliteFbusinessCourse.do?menuType=01'/>">교과과정</a></li> --%>
<%-- 								<c:set var="num" value="3" /> --%>
<%-- 								<c:forEach var="list" items="${bcList }"> --%>
<%-- 									<c:if test="${list.mCode eq '13'}"> --%>
<%-- 										<c:set var="num" value="${num +1 }" /> --%>
<%-- 										<c:set var="menuNum" value="1300${num }" /> --%>
<!-- 										<li><a -->
<%-- 											href="<c:out value='${pageContext.request.contextPath }/usr/elite/fbusiness/eliteFbusinessList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out --%>
<%-- 													value="${list.bcName }" /></a></li> --%>
<%-- 									</c:if> --%>
<%-- 								</c:forEach> --%>
<!-- 							</ul> -->
<!-- 						</li> -->
<!-- 						<li> -->
<!-- 							<a class="th_menu03" -->
<%-- 							href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyInfo.do?menuType=01'/>"><div>뷰티교육자ㆍ엘리트</div> --%>
<!-- 								<label for="st_menu14">뷰티교육자ㆍ엘리트</label></a> <input type="radio" -->
<!-- 							name="st_menu" id="st_menu14" /> -->
<!-- 							<ul> -->
<!-- 								<li><a -->
<%-- 									href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyInfo.do?menuType=01'/>">전공안내</a></li> --%>
<!-- 								<li><a -->
<%-- 									href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyTeacherList.do'/>">교수소개</a></li> --%>
<!-- 								<li><a -->
<%-- 									href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyCourse.do?menuType=01'/>">교과과정</a></li> --%>
<%-- 								<c:set var="num" value="3" /> --%>
<%-- 								<c:forEach var="list" items="${bcList }"> --%>
<%-- 									<c:if test="${list.mCode eq '14'}"> --%>
<%-- 										<c:set var="num" value="${num +1 }" /> --%>
<%-- 										<c:set var="menuNum" value="1400${num }" /> --%>
<!-- 										<li><a -->
<%-- 											href="<c:out value='${pageContext.request.contextPath }/usr/elite/beauty/eliteBeautyList.do?searchType=${list.mmSeq }&menuNo=${menuNum}'/>"><c:out --%>
<%-- 													value="${list.bcName }" /></a></li> --%>
<%-- 									</c:if> --%>
<%-- 								</c:forEach> --%>
<!-- 							</ul> -->
<!-- 						</li> -->
<!-- 					</ul> -->
<!-- 				</li> -->
			</ul>
		</div>
	</div>
	<dl class="visual_txt"><dt></dt><dd></dd></dl>
	<script type="text/javascript">
	
		// 모바일 메뉴 여닫기
		$(document).on("click", "input:radio[name='t_menu']", function(){

			$("input[name='st_menu']").attr("checked",false);
			$("input[name='sts_menu']").attr("checked",false);
			
			if($(this).val() == "1"){
				$(this).attr("checked",false);
				$(this).val("0");
				
			}else{
				$("input[name='t_menu']").val("0");
				$(this).val("1");
			}
			
		});
		
		 
		$(document).on("click", "#allClose", function(){
			$("input[name='t_menu']").attr("checked",false);
			$("input[name='t_menu']").val("0");
			$("input[name='st_menu']").val("0");
			
			
		});
		////////////////////////////////////
		
		// 통합검색
		function fn_search(){
			$("#frm").attr("action","<c:out value='${pageContext.request.contextPath}/usr/main/searchList.do'/>").submit();
		}
		
		$(document).on("keydown", "#word", function(e){
			if (e.keyCode == 13) {
				fn_search();
				return false;
			}
		});
		
	</script>
</header>