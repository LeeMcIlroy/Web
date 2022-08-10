<%@page import="egovframework.com.cmm.util.EgovUserDetailsHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="header">
	<div class="top">
		<h1 class="logo" style="z-index:10;">
			<a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/lgn/admLoginView.do'/>">
				<img style=" width:265px;" src="<c:url value='/assets/adm/img/top_logo.png'/>" alt="한성대학교 부설 디자인아트 교육원" />
				
			</a>
		</h1>
		<div class="util">
			<a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/lgn/admLogout.do'/>" class="gnb_btn">LOGOUT</a>
		</div>
	</div>
	<ul class="gnb">
		<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/interior/admMajorInteriorList.do'/>">전공</a>
			<ul>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/interior/admMajorInteriorList.do'/>">실내디자인</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/visual/admMajorVisualList.do'/>">시각디자인</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/industrial/admMajorIndustrialList.do'/>">산업디자인</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/digitalArt/admMajorDigitalArtList.do'/>">디지털아트(디자인)</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/digitalEnt/admMajorDigitalEntList.do'/>">디지털아트(엔터)</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/fassion/admMajorFassionList.do'/>">패션디자인</a></li>
<%-- 				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/fbusiness/admMajorFbusinessList.do'/>">패션비즈니스</a></li> --%>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/beauty/admMajorBeautyList.do'/>">미용학</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/beautyOne/admMajorBeautyOneList.do'/>">미용학(one-day)</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/teacher/admMajorTeacherList.do'/>">교수소개</a></li>
			</ul>
		</li>
		<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=01'/>">입학안내</a>
			<ul>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=01'/>">입학상담</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/enter/brochure/admBrochureList.do'/>">브로셔 신청</a></li>
<%-- 				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/enter/brodata/admBroDataList.do'/>">브로셔 자료</a></li> --%>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/enter/transferReview/admTransferReviewList.do'/>">편입성공사례</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/enter/graduateReview/admGraduateReviewList.do'/>">대학원&타대학 편입</a></li>
			</ul>
		</li>
		<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0501'/>">학사안내</a>
			<ul>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0501'/>">공지사항</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0301'/>">학사FAQ</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=02'/>">학사Q&A</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=1001'/>">한디원신문고</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0401'/>">양식자료실</a></li>
			</ul>
		</li>
		<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0601'/>">캠퍼스생활&취업진학</a>
			<ul>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0601'/>">한디원 이슈</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0701'/>">한디원행사</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0602'/>">작품자료실</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0801'/>">작품동영상&amp;UCC</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/webtoon/admWebtoonList.do'/>">한툰</a></li>
				<!-- 200420추가 -->
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0603'/>">해외인턴십</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0610'/>">해외연수</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0611'/>">해외봉사</a></li>
				<!-- //200420추가 -->
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0604'/>">취업프로그램</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0605'/>">기업 · 지역연계수업 현황</a></li>
			</ul>
		</li>
		<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/general/info/admGeneralInfoList.do'/>" >비학위과정&진로체험</a>
			<ul>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/general/info/admGeneralInfoList.do'/>">과정안내</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0901'/>">수강문의</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/cmmBoard/admCmmBoardList.do?menuType=0902'/>">개설문의</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/general/exper/admExperList.do'/>">진로체험신청</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/general/exper/admExperNewsList.do'/>">진로체험소식</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/event/admEventList.do'/>">행사참가신청</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/event/admEventCancelList.do'/>">행사참가취소</a></li>
			</ul>
		</li>
		<c:if test="${sessionScope.adminSession.admSeq eq 1 || sessionScope.adminSession.admSeq eq 6  }">
			<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/admin/admAdminList.do'/>" >사이트관리</a>
				<ul>
					<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/admin/admAdminList.do'/>">관리자관리</a></li>
					<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/banner/admBannerList.do'/>">배너관리</a></li>
					<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/popup/admPopupList.do'/>">팝업관리</a></li>
					<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/menu/admMajorMenuList.do'/>">전공메뉴관리</a></li>
					<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/code/admMajorCodeList.do'/>">코드관리</a></li>
					<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/admission/admAdmissionList.do'/>">입학상담회신청관리</a></li>
					<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/news/admNewsList.do'/>">전공소식관리</a></li>
				</ul>
			</li>
		</c:if>
		<c:if test="${sessionScope.adminSession.admSeq ne 1 && sessionScope.adminSession.admSeq ne 6 }">
			<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/siteMng/admin/admUserModify.do'/>" >비밀번호관리</a></li>
		</c:if>
			<!-- 200421수정 -->
<%-- 		<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/elite/interior/admEliteInteriorList.do'/>" >일학습엘리트과정</a> --%>
		<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/elite/fbusiness/admEliteFbusinessList.do'/>" >일학습엘리트과정</a>
			<ul>
<%-- 				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/elite/interior/admEliteInteriorList.do'/>">타일디자인시공</a></li> --%>
<%-- 				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/elite/digitalArt/admEliteDigitalArtList.do'/>">성우콘텐츠크리에이터</a></li> --%>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/elite/fbusiness/admEliteFbusinessList.do'/>">글로벨패션창업</a></li>
<%-- 				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/elite/beauty/admEliteBeautyList.do'/>">헤어디자이너</a></li> --%>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/elite/beauty/admEliteBeautyList.do'/>">뷰티교육자, 하야시두피모발</a></li>
				<li><a href="<c:out value='${pageContext.request.contextPath }/qxerpynm/elite/teacher/admEliteTeacherList.do'/>">교수소개</a></li>
			<!-- //200421수정 -->
			</ul>
		</li>
	</ul>
</div>
