<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String admMenuNo = ((String)session.getAttribute("admMenuNo")!=null)?(String)session.getAttribute("admMenuNo"):"";
%>

<% if( admMenuNo.indexOf("10")==0 ){ %>
	<div class="lnb">
		<h2 class="notice"><span>전공</span></h2>
		<ul>
			<li><a <% if( admMenuNo.indexOf("101")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/interior/admMajorInteriorList.do'/>">실내디자인</a></li>
			<li><a <% if( admMenuNo.indexOf("102")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/visual/admMajorVisualList.do'/>">시각디자인</a></li>
			<li><a <% if( admMenuNo.indexOf("103")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/industrial/admMajorIndustrialList.do'/>">산업디자인</a></li>
			<li><a <% if( admMenuNo.indexOf("104")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/digitalArt/admMajorDigitalArtList.do'/>">디지털아트(디자인)</a></li>
			<li><a <% if( admMenuNo.indexOf("10B")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/digitalEnt/admMajorDigitalEntList.do'/>">디지털아트(엔터)</a></li>
			<li><a <% if( admMenuNo.indexOf("105")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/fassion/admMajorFassionList.do'/>">패션디자인</a></li>
<!-- 			200417수정 -->
<%-- 			<li><a <% if( admMenuNo.indexOf("106")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/fbusiness/admMajorFbusinessList.do'/>">패션비즈니스</a></li> --%>
			<li><a <% if( admMenuNo.indexOf("107")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/beauty/admMajorBeautyList.do'/>">미용학</a></li>
			<li><a <% if( admMenuNo.indexOf("108")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/beautyOne/admMajorBeautyOneList.do'/>">미용학(one-day)</a></li>
			<li><a <% if( admMenuNo.indexOf("109")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/teacher/admMajorTeacherList.do'/>">교수소개</a></li>
			<li><a <% if( admMenuNo.indexOf("10A")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=1101'/>">고객센터</a></li>
		</ul>
	</div>
<!-- 	200408 수정/추가 -->
<% } else if( admMenuNo.indexOf("20")==0 ){%>
	<div class="lnb">
		<h2 class="notice"><span>입학안내 관리</span></h2>
		<ul>
			<li><a <% if( admMenuNo.indexOf("201")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=01'/>">입학상담</a></li>
			<li><a <% if( admMenuNo.indexOf("202")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/enter/brochure/admBrochureList.do'/>">브로셔 신청</a></li>
<%-- 			<li><a <% if( admMenuNo.indexOf("204")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/enter/brodata/admBroDataList.do'/>">브로셔자료</a></li> --%>
			<li><a <% if( admMenuNo.indexOf("203")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/enter/transferReview/admTransferReviewList.do'/>">편입성공사례</a></li>
			<li><a <% if( admMenuNo.indexOf("205")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/enter/graduateReview/admGraduateReviewList.do'/>">대학원&타대학 편입</a></li>
		</ul>
	</div>
<% } else if( admMenuNo.indexOf("30")==0 ){%>
	<div class="lnb">
		<h2 class="notice"><span>학사안내</span></h2>
		<ul>
			<li><a <% if( admMenuNo.indexOf("305")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0501'/>">공지사항</a></li>
			<li><a <% if( admMenuNo.indexOf("301")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0301'/>">학사FAQ</a></li>
			<li><a <% if( admMenuNo.indexOf("302")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=02'/>">학사Q&amp;A</a></li>
			<li><a <% if( admMenuNo.indexOf("303")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=1001'/>">한디원신문고</a></li>
			<li><a <% if( admMenuNo.indexOf("304")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0401'/>">양식자료실</a></li>
		</ul>
	</div>
<% } else if( admMenuNo.indexOf("40")==0 ){%>
	<div class="lnb">
		<h2 class="notice"><span style="font-size: 19px">캠퍼스생활&취업진학</span></h2>
		<ul>
			<li><a <% if( admMenuNo.indexOf("402")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0601'/>">한디원 이슈</a></li>
			<li><a <% if( admMenuNo.indexOf("403")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0701'/>">한디원행사</a></li>
			<li><a <% if( admMenuNo.indexOf("406")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0602'/>">작품자료실</a></li>
			<li><a <% if( admMenuNo.indexOf("404")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0801'/>">작품동영상 &amp; UCC</a></li>
			<li><a <% if( admMenuNo.indexOf("405")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/webtoon/admWebtoonList.do'/>">한툰</a></li>
			<!-- 200420추가 -->
			<li><a <% if( admMenuNo.indexOf("407")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0603'/>">해외인턴십</a></li>
			<li><a <% if( admMenuNo.indexOf("4010")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0610'/>">해외연수</a></li>
			<li><a <% if( admMenuNo.indexOf("4011")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0611'/>">해외봉사</a></li>
			<!-- //200420추가 -->
			<li><a <% if( admMenuNo.indexOf("408")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0604'/>">취업프로그램</a></li>
			<li><a <% if( admMenuNo.indexOf("409")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0605'/>">기업 · 지역연계수업 현황</a></li>
		</ul>
	</div>
<!-- //	200408 수정/추가 -->
<% } else if( admMenuNo.indexOf("50")==0 ){%>
	<div class="lnb">
		<h2 class="notice"><span style="font-size: 19px">비학위과정&amp;진로체험</span></h2>
		<ul>
			<li><a <% if( admMenuNo.indexOf("501")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/general/info/admGeneralInfoList.do'/>">과정안내</a></li>
			<li><a <% if( admMenuNo.indexOf("502")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0901'/>">수강문의</a></li>
			<!-- 200407 추가 -->
			<li><a <% if( admMenuNo.indexOf("507")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0902'/>">개설문의</a></li>
			<li><a <% if( admMenuNo.indexOf("503")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/general/exper/admExperList.do'/>">진로체험신청</a></li>
			<li><a <% if( admMenuNo.indexOf("504")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/general/exper/admExperNewsList.do'/>">진로체험소식</a></li>
			<li><a <% if( admMenuNo.indexOf("505")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/event/admEventList.do'/>">행사참가신청</a></li>
			<li><a <% if( admMenuNo.indexOf("506")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/event/admEventCancelList.do'/>">행사참가취소</a></li>
		</ul>
	</div>
<% } else if( admMenuNo.indexOf("60")==0 ){%>
	<div class="lnb">
		<h2 class="notice"><span>사이트관리</span></h2>
		<ul>
			<li><a <% if( admMenuNo.indexOf("601")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/admin/admAdminList.do'/>">관리자관리</a></li>
			<li><a <% if( admMenuNo.indexOf("602")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/banner/admBannerList.do'/>">배너관리</a></li>
			<li><a <% if( admMenuNo.indexOf("603")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/popup/admPopupList.do'/>">팝업관리</a></li>
			<li><a <% if( admMenuNo.indexOf("604")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/menu/admMajorMenuList.do'/>">전공메뉴관리</a></li>
			<li><a <% if( admMenuNo.indexOf("605")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/code/admMajorCodeList.do'/>">코드관리</a></li>
			<li><a <% if( admMenuNo.indexOf("606")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/admission/admAdmissionList.do'/>">입학상담회 신청관리</a></li>
			<li><a <% if( admMenuNo.indexOf("607")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/news/admNewsList.do'/>">전공소식관리</a></li>
		</ul>
	</div>
<% } else if( admMenuNo.indexOf("70")==0 ){%>
	<div class="lnb">
		<h2 class="notice"><span>비밀번호관리</span></h2>
		<ul>
			<li><a <% if( admMenuNo.indexOf("701")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/admin/admUserModify.do'/>">비밀번호관리</a></li>
		</ul>
	</div>
<% } else if( admMenuNo.indexOf("80")==0 ){%>
	<div class="lnb">
		<h2 class="notice"><span>일학습엘리트과정</span></h2>
		<ul>
		<!-- 200421수정 -->
<%-- 			<li><a <% if( admMenuNo.indexOf("801")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/elite/interior/admEliteInteriorList.do'/>">타일디자인시공</a></li> --%>
<%-- 			<li><a <% if( admMenuNo.indexOf("802")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/elite/digitalArt/admEliteDigitalArtList.do'/>">성우콘텐츠크리에이터</a></li> --%>
			<li><a <% if( admMenuNo.indexOf("803")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/elite/fbusiness/admEliteFbusinessList.do'/>">글로벌패션창업</a></li>
<%-- 			<li><a <% if( admMenuNo.indexOf("804")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/elite/beauty/admEliteBeautyList.do'/>">헤어디자이너</a></li> --%>
			<li><a style="font-size: 13px;"<% if( admMenuNo.indexOf("804")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/elite/beauty/admEliteBeautyList.do'/>">뷰티교육자,하야시두피모발</a></li>
			<li><a <% if( admMenuNo.indexOf("805")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/qxerpynm/elite/teacher/admEliteTeacherList.do'/>">교수소개</a></li>
		<!-- //200421수정 -->
		</ul>
	</div>
<% } %>			