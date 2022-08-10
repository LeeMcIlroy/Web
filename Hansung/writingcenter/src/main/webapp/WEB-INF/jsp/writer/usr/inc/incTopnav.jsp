<%@page import="egovframework.let.utl.fcc.service.EgovStringUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="egovframework.com.cmm.util.EgovUserDetailsHelper" %>
<div <c:if test="${empty param.type}">id="header" class="class_room_top_bg"</c:if><c:if test="${!empty param.type}">id="m_header"</c:if>>
	<div class="top_utill">
		<ul>
			<% if(EgovUserDetailsHelper.isAuthenticatedUser()){ %>
			<!-- <li><a href="https://hansung.ac.kr/c/portal/logout?redirect=http://writingcenter.hansung.ac.kr/usr/lgn/logout.do">로그아웃</a></li> -->
			<li><a href="<c:out value='${pageContext.request.contextPath }/usr/lgn/logout.do'/>">로그아웃</a></li>
			<li><a href="<c:out value='${pageContext.request.contextPath }/usr/cnslt/cnsltRecordList.do'/>">마이페이지</a></li>
			<li><a href="<c:out value='${pageContext.request.contextPath }/xabdmxgr/lec/admLecClassList.do'/>">교수페이지</a></li>
			<c:if test="${sessionScope.userSession.memType eq 'PROF' }">
				<li><a href="http://writingcenter.hansung.ac.kr/xabdmxgr/lgn/admLoginView.do">교수페이지</a></li>
			</c:if>
		<% }else{ %>
			<!-- <li><a href="https://hansung.ac.kr/hansung/link_login.jsp?p_p_id=58&_58_redirect=http://writingcenter.hansung.ac.kr/usr/lgn/login.do">로그인</a></li> -->
			<li><a href="<c:out value='${pageContext.request.contextPath }/usr/lgn/tmpLogin.do'/>">로그인</a></li>
		<% } %>
		</ul>
	</div>
	<div class="menu_roll">
		<div class="top_menu">
			<h1 class="logo"><a href="/"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/top_logo.jpg'/>" alt="한성대학교 글쓰기센터 Hansung Yniversity Writing Center" /></a></h1>
			<ul class="gnb">
				<li><a href="javascript:;">센터 소개</a></li>
				<li><a href="javascript:;">강의와 첨삭</a></li>
				<li><a href="javascript:;">상담</a></li>
				<li><a href="javascript:;">대회</a></li>
				<li><a href="javascript:;">글쓰기 길잡이</a></li>
				<li><a href="javascript:;">게시판</a></li>
			</ul>
		</div>
		<div class="gnb_wrap">
			<div class="gnb_depth2">
				<div class="gnb_menu">		
					<div class="menu_banner">
						<p><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/lecClassList.do'/>">강의실 바로가기</a></p>
						<p><a href="<c:out value='${pageContext.request.contextPath }/usr/board/boardCompareNpointView.do'/>">비교과 포인트 안내</a></p>
					</div>		
					<div class="main_menu">					
						<ul>						
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/main/wcInfoObjectView.do'/>">설립 취지</a></li>
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/main/wcInfoCurrculumView.do'/>">사고와표현과정</a></li>
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/main/wcInfoCourseView.do'/>">사고와 표현<br>강좌 소개</a></li>
						</ul>
						<ul>						
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/main/courseAndEditInfo01.do'/>">강의와 첨삭</a></li>
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/main/courseAndEditInfo02.do'/>">2022학년도<br/>운영 강좌</a></li>
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/main/courseAndEditInfo03.do'/>">첨삭 시스템</a></li>
						<%--
							<li><a href="<c:out value='${pageContext.request.contextPath }'/>" onclick="alert('준비중 입니다.'); return false;">준비중 입니다.</a></li>
							<li><a href="<c:out value='${pageContext.request.contextPath }'/>" onclick="alert('준비중 입니다.'); return false;">안내화면</a></li>
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/main/courseAndEditInfo01.do'/>">안내화면</a></li>
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/main/courseAndEditInfo02.do'/>">안내화면</a></li>
						--%>
						</ul>
						<ul>						
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/cnsltInfoView.do'/>">상담 안내</a></li>
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/cnsltRequestInfoView.do'/>">상담 신청</a></li>
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/cnslt/cnsltRecordList.do'/>">마이페이지</a></li>
						</ul>
						 <ul>						
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/cntst/cntstWriteView.do'/>">한성인 글쓰기 대회</a></li>
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/cntst/cntstPresentationView.do'/>">한성인<br>프레젠테이션 대회</a></li>
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/cntst/cntstDataList.do'/>">대회 자료실</a></li>
							<!-- <li><a href="<c:out value='${pageContext.request.contextPath }/usr/cntst/cntstWriteComList.do'/>">제15회 한성인<br/>글쓰기대회</a></li> -->
						</ul>
						<ul>						
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/wcGuide/tips/wcGuideTipsList.do'/>">라이팅 팁스</a></li>
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/wcGuide/exclnt/wcGuideExclntList.do'/>">우수 과제</a></li>
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/wcGuide/bkCtlg/wcGuideBookCatalogList.do'/>">도서 목록</a></li>
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/wcGuide/writInfo/wcGuideWritInfoList.do'/>">글쓰기 정보</a></li>
						</ul>
						<ul>						
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/board/notice/boardNoticeList.do'/>">공지사항</a></li>
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/board/qna/boardQnaList.do'/>">Q&amp;A</a></li>
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/board/free/boardFreeList.do'/>">자유 게시판</a></li>
							<li><a href="<c:out value='${pageContext.request.contextPath }/usr/board/boardCompareNpointView.do'/>">비교과 포인트<br>안내</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>