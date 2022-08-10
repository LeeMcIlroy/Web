<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String admMenuNo = ((String)session.getAttribute("admMenuNo")!=null)?(String)session.getAttribute("admMenuNo"):"";
%>

<% if( admMenuNo.indexOf("10")==0 ){ %>
	<div class="lnb">
		<h2 class="notice"><span>강의실</span></h2>
		<ul>
			<c:forEach items="${smtrList }" var="smtr" varStatus="status">
				<li><a href="<c:url value='/xabdmxgr/lec/admLecClassList.do?searchSemester=${smtr.smtrSeq }'/>" <c:if test="${smtr.choiceYn eq 'Y' }">class="active"</c:if>><c:out value="${smtr.smtrTitle }"/></a></li>
			</c:forEach>
		</ul>
	</div>
	
<% } else if( admMenuNo.indexOf("20")==0 ){%>
	<div class="lnb">
		<h2 class="notice"><span>상담</span></h2>
		<ul>
			<li><a <% if( admMenuNo.indexOf("201")==0 ){ %> class="active" <%}%> href="<c:url value='/xabdmxgr/cnslt/list/admCnsltList.do'/>">상담 리스트</a></li>
			<li><a <% if( admMenuNo.indexOf("202")==0 ){ %> class="active" <%}%> href="<c:url value='/xabdmxgr/cnslt/schdul/admCnsltScheduleList.do'/>">상담 일정</a></li>
			<li><a <% if( admMenuNo.indexOf("203")==0 ){ %> class="active" <%}%> href="<c:url value='/xabdmxgr/cnslt/list/admCnsltListStatus.do'/>">상담 현황</a></li>
		</ul>
	</div>
<% } else if( admMenuNo.indexOf("30")==0 ){%>
	<div class="lnb">
		<h2 class="notice"><span>글쓰기 길잡이</span></h2>
		<ul>
			<li><a <% if( admMenuNo.indexOf("301")==0 ){ %> class="active" <%}%> href="<c:url value='/xabdmxgr/wcGuide/tips/admWcGuideTipsList.do'/>">라이팅 팁스</a></li>
			<li><a <% if( admMenuNo.indexOf("302")==0 ){ %> class="active" <%}%> href="<c:url value='/xabdmxgr/wcGuide/exclnt/admWcGuideExclntList.do'/>">우수 과제</a></li>
			<li><a <% if( admMenuNo.indexOf("303")==0 ){ %> class="active" <%}%> href="<c:url value='/xabdmxgr/wcGuide/bkCtlg/admWcGuideBookCatalogList.do'/>">도서 목록</a></li>
			<li><a <% if( admMenuNo.indexOf("304")==0 ){ %> class="active" <%}%> href="<c:url value='/xabdmxgr/wcGuide/writInfo/admWcGuideWritInfoList.do'/>">글쓰기 정보</a></li>
		</ul>
	</div>
<% } else if( admMenuNo.indexOf("40")==0 ){%>
	<div class="lnb">
		<h2 class="notice"><span>게시판관리</span></h2>
		<ul>
			<li><a <% if( admMenuNo.indexOf("401")==0 ){ %> class="active" <%}%> href="<c:url value='/xabdmxgr/boardMng/notice/admBoardMngNoticeList.do'/>">공지사항</a></li>
			<li><a <% if( admMenuNo.indexOf("402")==0 ){ %> class="active" <%}%> href="<c:url value='/xabdmxgr/boardMng/qna/admBoardMngQnaList.do'/>">Q&A</a></li>
			<li><a <% if( admMenuNo.indexOf("409")==0 ){ %> class="active" <%}%> href="<c:url value='/xabdmxgr/boardMng/cntst/admBoardMngContestMngList.do'/>">대회 관리</a></li>
			<li><a <% if( admMenuNo.indexOf("403")==0 ){ %> class="active" <%}%> href="<c:url value='/xabdmxgr/boardMng/cntst/admBoardMngCntstList.do'/>">대회 자료실</a></li>
			<li><a <% if( admMenuNo.indexOf("405")==0 ){ %> class="active" <%}%> href="<c:url value='/xabdmxgr/boardMng/writeCom/admBoardMngWriteComList.do'/>">대회공지사항</a></li>
			<li><a <% if( admMenuNo.indexOf("406")==0 ){ %> class="active" <%}%> href="<c:url value='/xabdmxgr/boardMng/cntst/admBoardMngWriteAplyList.do'/>">신청자(글쓰기대회)</a></li>
			<li><a <% if( admMenuNo.indexOf("407")==0 ){ %> class="active" <%}%> href="<c:url value='/xabdmxgr/boardMng/cntst/admBoardMngPptAplyList.do'/>">신청자(PT대회)</a></li>
			<li><a <% if( admMenuNo.indexOf("404")==0 ){ %> class="active" <%}%> href="<c:url value='/xabdmxgr/boardMng/free/admBoardMngFreeList.do'/>">자유 게시판</a></li>
		</ul>
	</div>
 
<% } else if( admMenuNo.indexOf("50")==0 ){%>
	<div class="lnb">
		<h2 class="notice"><span>강의실관리</span></h2>
		<ul>
			<li><a <% if( admMenuNo.indexOf("501")==0 ){ %> class="active" <%}%> href="<c:url value='/xabdmxgr/lecMng/smtr/admLecMngSemesterList.do'/>">학기 강의실 생성</a></li>
			<li><a <% if( admMenuNo.indexOf("502")==0 ){ %> class="active" <%}%> href="<c:url value='/xabdmxgr/lecMng/cls/admLecMngClassList.do'/>">교수님 생성</a></li>
		</ul>
	</div>
	
<% } else if( admMenuNo.indexOf("60")==0 ){%>
	<div class="lnb">
		<h2 class="notice"><span>사이트관리</span></h2>
		<ul>
			<li><a <% if( admMenuNo.indexOf("601")==0 ){ %> class="active" <%}%> href="<c:url value='/xabdmxgr/siteMng/member/admSiteMngMemberList.do'/>">회원 관리</a></li>
			<li><a <% if( admMenuNo.indexOf("602")==0 ){ %> class="active" <%}%> href="<c:url value='/xabdmxgr/siteMng/popup/admSiteMngPopupList.do'/>">팝업 관리</a></li>
		</ul>
	</div>
<% } else if( admMenuNo.indexOf("70")==0 ){%>
	<div class="lnb">
		<h2 class="notice"><span>설문조사</span></h2>
		<ul>
			<li><a href="<c:url value='/xabdmxgr/qestnar/admQuestionaireList.do'/>" class="active">설문조사</a></li>
		</ul>
	</div>
<% } else if( admMenuNo.indexOf("80")==0 ){%>
<%--
	<dl>
		<dt>설문조사</dt>
	</dl>
 --%>
<% } %>