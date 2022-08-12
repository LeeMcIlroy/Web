<%@page import="egovframework.com.cmm.util.EgovUserDetailsHelper"%>
<%@ page import="egovframework.rte.psl.dataaccess.util.EgovMap" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="ctms.valueObject.UsrVO" %>
<%
	String lecMenuNo = ((String)session.getAttribute("lecMenuNo")!=null)?(String)session.getAttribute("lecMenuNo"):"";
	String chkLec = ((String)session.getAttribute("chkLec")!=null)?(String)session.getAttribute("chkLec"):"";
%>
<header>
	<div class="top-area">
		<div class="content-box">
			<!-- gnd -->
			<div class="header-info web">
				접속시간 : <c:out value="${usrSession.loginDateTime }"/> (<label id="cntTime">0</label>분 경과)
				<i class="ico-classroom ml20"></i>
				<label for="class-room">
					<c:out value="${semester.semYear }년도"/>&nbsp;
					<c:out value="${semester.semeNm }"/>&nbsp;
					<c:out value="${lecSession.lectName }"/>&nbsp;
					<c:out value="${lecSession.lectDivi }"/>
				</label>
				<i class="icon-user ml20"></i>
				
				<label for="user-pop"> <c:out value="${usrSession.name }"/>님</label>
				<input type="checkbox" id="user-pop">
				<div class="user-popup">
					<a href="<c:url value='/usr/lec/myPage/lecProfileView.do'/>">Profile</a>
					<a href="#" onclick="fn_extend(); return false;">시간연장</a>
					<a href="<c:out value='${pageContext.request.contextPath }/usr/login/admLogout.do'/>">Logout</a>
				</div>
			</div>
			<!-- // gnd -->
			<div class="header-menu">
				<!-- 모바일 메뉴 열기 -->
				<div class="btn_menu_list mob"> <!-- 모바일 수정 -->
					<a href="#"><img src="<c:url value='/assets/usr/img/menu_list_btn.png'/>" alt="메뉴 리스트 버튼" class="menu_list_btn"></a>
				</div>
				<!-- 모바일 메뉴 열기 -->

				<!-- logo -->
				<h1><a href="">한성대학교 HANSUNG UNIVERSITY 한국어교육과정 학사관리시스템</a></h1>
				<!--// logo -->

				<!-- top menu -->
				<nav class="web"> <!-- 모바일 수정 -->
					<c:if test="${not empty lecSession }">
						<a href="<c:out value='${pageContext.request.contextPath}/usr/lec/clss/lecSyllabusView.do'/>" <%if( lecMenuNo.indexOf("10")==0 ){%>class="on"<%}%>><span>수업</span></a>
						<a href="<c:out value='${pageContext.request.contextPath}/usr/lec/task/lecTaskList.do'/>" <%if( lecMenuNo.indexOf("20")==0 ){%>class="on"<%}%>><span>과제</span></a>
						<a href="<c:out value='${pageContext.request.contextPath}/usr/lec/attnd/lecAttndList.do'/>" <%if( lecMenuNo.indexOf("30")==0 ){%>class="on"<%}%>><span>출결</span></a>
						<a href="<c:out value='${pageContext.request.contextPath}/usr/lec/result/lecResultList.do'/>" <%if( lecMenuNo.indexOf("40")==0 ){%>class="on"<%}%>><span>성적</span></a>
					</c:if>
					<a href="<c:out value='${pageContext.request.contextPath}/usr/lec/myPage/lecNoticeList.do'/>" <%if( lecMenuNo.indexOf("50")==0 ){%>class="on"<%}%>><span>마이페이지</span></a>
				</nav>
				<!--// top menu -->

				<!-- 모바일 수정 -->
				<div class="sh-room icon-room">
					<label for="op-class-list">
						강의실
					</label>
				</div>
				<input type="checkbox" id="op-class-list" class="hidden" />
				<div class="op-class-list">
					<div class="pop-title">
						<p>강의실</p>
						<label for="op-class-list" class="icon-pop-close">닫기</label>
					</div>
					<div class="pop-classroom-list">
						<ul>
							<c:forEach var="lect" items="${lectList}" varStatus="status" >
								<li>
									<a href="#" onclick="javascript:fn_chg_lect('<c:out value="${lect.lectSeq }"/>', '<c:out value="${lect.lectName }"/>');">
										<c:out value="${lect.lectYear }년도"/>
										&nbsp;<c:out value="${lect.lectSem eq '1'?'봄학기':lect.lectSem eq '2'?'여름학기':lect.lectSem eq '3'?'가을학기':'겨울학기' }"/>
										&nbsp;<c:out value="${lect.lectName }"/>
										&nbsp;<c:out value="${lect.lectDivi }"/>
									</a>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<!-- 모바일 수정 -->
			</div>
		</div>
	</div>
     	<!-- 모바일 수정 -->
	<!-- mobile menu -->
	<div class="side_menu">
		<ul>
		<%if( !chkLec.equals("0") ){%>
			<li><a href="#" class="depth01"><span>수업</span></a>
				<ul class="depth02" style="display:none;">
					<li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecSyllabusView.do'/>"><span>- 강의계획</span></a></li>
					<li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecClssNoticeList.do'/>"><span>- 강의공지</span></a></li>
					<li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecClssPeopleList.do'/>"><span>- 수강인원</span></a></li>
					<li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecClssCounselList.do'/>"><span>- 상담</span></a></li>
					<li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecClssAppraiseList.do'/>"><span>- 학생평가</span></a></li>
					<li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecClssSatisfactionList.do'/>"><span>- 수업만족도</span></a></li>
				</ul>
			</li>
			<li><a href="#" class="depth01"><span>과제</span></a>
				<ul class="depth02" style="display:none;">
					<li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/task/lecTaskList.do'/>"><span>- 과제</span></a></li>
				</ul>
			</li>
			<li><a href="#" class="depth01"><span>출결</span></a>
				<ul class="depth02" style="display:none;">
					<li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/attnd/lecAttndList.do'/>"><span>- 출결</span></a></li>
					<li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/attnd/lecAbsCounselList.do'/>"><span>- 결석자상담</span></a></li> 
				</ul>
			</li>
			<li><a href="#" class="depth01"><span>성적</span></a>
				<ul class="depth02" style="display:none;">
					<li><a href="<c:out value='${pageContext.request.contextPath }/usr/lec/result/lecResultList.do'/>"><span>- 성적</span></a></li>
				</ul>
			</li>
		<%} %>
			<li><a href="#" class="depth01"><span>마이페이지</span></a>
				<ul class="depth02" style="display:none;">
					<li><a href="<c:out value='${pageContext.request.contextPath}/usr/lec/myPage/lecNoticeList.do'/>"><span>- 공지사항</span></a></li>
					<li><a href="<c:out value='${pageContext.request.contextPath}/usr/lec/myPage/lecScheduleList.do'/>"><span>- 강의시간표</span></a></li>
					<li><a href="<c:out value='${pageContext.request.contextPath}/usr/lec/myPage/lecProfileView.do'/>"><span>- Profile</span></a></li>
				</ul>
			</li>
		</ul>
		<div class="side_btn"><a href="<c:out value='${pageContext.request.contextPath }/usr/login/admLogout.do'/>">로그아웃</a></div>
	</div>
	<!--// mobile menu -->
	<!--// 모바일 수정 -->
</header>