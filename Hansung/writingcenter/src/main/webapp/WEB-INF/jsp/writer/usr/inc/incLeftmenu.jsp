<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String menuNo = ((String)session.getAttribute("menuNo")!=null)?(String)session.getAttribute("menuNo"):"";
%>

<div class="lnb">
<% if( menuNo.indexOf("10")==0 ){ %>
	<h2 class="tit"><span>강의실</span></h2>
	<ul>
		<c:forEach items="${smtrList }" var="smtr" varStatus="status">
			<li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/lecClassList.do?searchSemester=${smtr.smtrSeq }'/>" <c:if test="${smtr.choiceYn eq 'Y' }">class="active"</c:if>><c:out value="${smtr.smtrTitle }"/></a></li>
		</c:forEach>
	</ul>
<% } else if( menuNo.indexOf("20")==0 ){%>
	<h2 class="tit"><span>센터 소개</span></h2>
	<ul>
		<li><a <% if( menuNo.indexOf("201")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/usr/main/wcInfoObjectView.do'/>">설립 취지</a></li>
		<li><a <% if( menuNo.indexOf("202")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/usr/main/wcInfoCurrculumView.do'/>">사고와표현과정</a></li>
		<li><a <% if( menuNo.indexOf("203")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/usr/main/wcInfoCourseView.do'/>">사고와 표현 강좌 소개</a></li>
	</ul>
<% } else if( menuNo.indexOf("30")==0 ){%>
	<h2 class="tit"><span>강의와 첨삭</span></h2>
	<ul>
		<li><a <% if( menuNo.indexOf("301")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/usr/main/courseAndEditInfo01.do'/>">강의와 첨삭</a></li>
		<li><a <% if( menuNo.indexOf("302")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/usr/main/courseAndEditInfo02.do'/>">2022학년도 운영 강좌</a></li>
		<li><a <% if( menuNo.indexOf("303")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/usr/main/courseAndEditInfo03.do'/>">첨삭 시스템</a></li>
	<%--
		<li><a <% if( menuNo.indexOf("301")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }'/>" onclick="alert('준비중 입니다.'); return false;">안내 화면</a></li>
		<li><a <% if( menuNo.indexOf("302")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }'/>" onclick="alert('준비중 입니다.'); return false;">안내 화면</a></li>
		<li><a <% if( menuNo.indexOf("302")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/usr/main/courseAndEditInfo02.do'/>">안내화면</a></li>
	 --%>
	</ul>
<% } else if( menuNo.indexOf("40")==0 ){%>
	<h2 class="tit"><span>상담</span></h2>
	<ul>
		<li><a <% if( menuNo.indexOf("401")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/usr/cnsltInfoView.do'/>">상담 안내</a></li>
		<li><a <% if( menuNo.indexOf("402")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/usr/cnsltRequestInfoView.do'/>">상담 신청</a></li>
		<li><a <% if( menuNo.indexOf("403")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/usr/cnslt/cnsltRecordList.do'/>">마이페이지</a></li>
	</ul>
<% } else if( menuNo.indexOf("50")==0 ){%>
	<h2 class="tit"><span>대회</span></h2>
	<ul>
		<li><a <% if( menuNo.indexOf("501")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/usr/cntst/cntstWriteView.do'/>">한성인 글쓰기 대회</a></li>
		<li><a <% if( menuNo.indexOf("502")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/usr/cntst/cntstPresentationView.do'/>">한성인 프레젠테이션&nbsp; 대회</a></li>
		<li><a <% if( menuNo.indexOf("503")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/usr/cntst/cntstDataList.do'/>">대회 자료실</a></li>
		<!-- <li><a <% if( menuNo.indexOf("504")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/usr/cntst/cntstWriteComList.do'/>">제15회 한성인 글쓰기<br/>대회</a></li> -->
	</ul>
<% } else if( menuNo.indexOf("60")==0 ){%>
	<h2 class="tit"><span>글쓰기 길잡이</span></h2>
	<ul>
		<li><a <% if( menuNo.indexOf("601")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/usr/wcGuide/tips/wcGuideTipsList.do'/>">라이팅 팁스</a></li>
		<li><a <% if( menuNo.indexOf("602")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/usr/wcGuide/exclnt/wcGuideExclntList.do'/>">우수 과제</a></li>
		<li><a <% if( menuNo.indexOf("603")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/usr/wcGuide/bkCtlg/wcGuideBookCatalogList.do'/>">도서 목록</a></li>
		<li><a <% if( menuNo.indexOf("604")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/usr/wcGuide/writInfo/wcGuideWritInfoList.do'/>">글쓰기 정보</a></li>
	</ul>
<% } else if( menuNo.indexOf("70")==0 ){%>
	<h2 class="tit"><span>게시판</span></h2>
	<ul>
		<li><a <% if( menuNo.indexOf("701")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/usr/board/notice/boardNoticeList.do'/>">공지사항</a></li>
		<li><a <% if( menuNo.indexOf("702")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/usr/board/qna/boardQnaList.do'/>">Q&A</a></li>
		<li><a <% if( menuNo.indexOf("703")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/usr/board/free/boardFreeList.do'/>">자유 게시판</a></li>
		<li><a <% if( menuNo.indexOf("704")==0 ){ %> class="active" <%}%> href="<c:out value='${pageContext.request.contextPath }/usr/board/boardCompareNpointView.do'/>">비교과 포인트 안내</a></li>
	</ul>
<% } else if( menuNo.indexOf("80")==0 ){%>
<%--
	<dl>
		<dt>설문조사</dt>
	</dl>
 --%>
<% } %>
	<div class="left_banner">
		<p><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/lecClassList.do'/>"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/left_banner01.jpg'/>" alt="강의실 바로가기" /></a></p>
		<!-- <p><a href="<c:out value='${pageContext.request.contextPath }/usr/cntst/cntstWriteComList.do'/>"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/writing_img.jpg'/>" width="200px" alt="제 15회 한성인 글쓰기 대회" /></a></p> -->
	</div>
</div>