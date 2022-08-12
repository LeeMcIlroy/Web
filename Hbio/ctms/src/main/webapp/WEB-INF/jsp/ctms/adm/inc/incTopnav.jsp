<%@page import="egovframework.com.cmm.util.EgovUserDetailsHelper"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="ctms.valueObject.AdminVO" %>
<%
	AdminVO adminVO = ((AdminVO)session.getAttribute("adminSessionCtms")!=null)?(AdminVO)session.getAttribute("adminSessionCtms"):null;
%>
<!-- header -->
<!-- header -->
<div class="header">
	<div>
		<h1><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0105/ech0105List.do'/>">H&amp;Bio</a></h1>
		<!-- util -->		
		<div class="util">
			<span><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0702/ech0702AdminProfileView.do'/>"><em><%= adminVO.getName() %></em>(<%= adminVO.getAdminId() %>)님</a></span>
			<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/lgn/admLogout.do'/>" title="로그아웃">로그아웃</a>
			<span><a class="mkCrf" href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ecr0101/ecr0101List.do'/>" title="CRF작성">CRF작성</a></span>			
		</div>
		<!-- gnb -->
		<nav class="gnb" id="gnb">
			<ul>
				<li>
					<% if("Y".equals(adminVO.getRsmg()) || "1".equals(adminVO.getAdminType())){ %>
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0105/ech0105List.do'/>" class="top-heading">연구관리</a>
						<div class="dropdown sub1_1">
							<ul>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0105/ech0105List.do'/>">연구관리</a></li>								
								<%-- <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0101/ech0101List.do'/>">연구차수관리</a></li> --%>
								<%-- <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0104/ech0104List.do'/>">IRB심의</a></li> --%>
								<%--  <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0102/ech0102List.do'/>">피험자선정</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0103/ech0103List.do'/>">예약관리</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0106/ech0106List.do'/>">시험제품</a></li> --%>
							</ul>
						</div>
					<% } %>					
				</li>
				<li>
					<% if("Y".equals(adminVO.getEcrf()) || "1".equals(adminVO.getAdminType())){ %>	
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0202/ech0202List.do'/>" class="top-heading">eCRF관리</a>
						<div class="dropdown sub2">
							<ul>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0202/ech0202List.do'/>">설문템플릿관리</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0203/ech0203List.do'/>">질문답변관리</a></li>
								<%-- <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0206/ech0206List.do'/>">ICF관리</a></li> --%>
								<%-- <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0201/ech0201List.do'/>">유효성설문관리</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0204/ech0204List.do'/>">피부특성관리</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0205/ech0205List.do'/>">제품사용관리</a></li> --%>								
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0210/ech0210List.do'/>">CRF템플릿관리</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0211/ech0211List.do'/>">CRF설정관리</a></li>
								<%-- <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0207/ech0207List.do'/>">피부자극결과</a></li> --%>
								<%-- <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0212/ech0212List.do'/>">CRF작성관리</a></li> --%>							
							</ul>
						</div>
					<% } %>
				</li>
				<%-- <li>
					<% if("Y".equals(adminVO.getRsjt()) || "1".equals(adminVO.getAdminType())){ %>
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0301/ech0301List.do'/>" class="top-heading">피험자관리</a>
						<div class="dropdown sub3">
							<ul>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0301/ech0301List.do'/>">피험자관리</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0302/ech0302List.do'/>">연구일정</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0303/ech0303List.do'/>">예약일정</a></li>
							</ul>
						</div>
					<% } %>
				</li> --%>
				<li>
					<% if("Y".equals(adminVO.getExtr()) || "1".equals(adminVO.getAdminType())){ %>
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0401/ech0401List.do'/>" class="top-heading">자료추출</a>
						<div class="dropdown sub3_1">
							<ul>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0401/ech0401List.do'/>">시험결과추출</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0207/ech0207List.do'/>">피부자극결과</a></li>
								<%-- <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0501/ech0501List.do'/>">보고서관리</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0602/ech0602Modify.do'/>">보고서발송</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0602/ech0602List.do'/>">이메일발송내역</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0901/ech0901List.do'/>">상담관리</a></li> --%>							
								<%-- <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0402/ech0402List.do'/>">종합통계</a></li> --%>
							</ul>
						</div>
					<% } %>
				</li>
				<%-- <li>
					<% if("Y".equals(adminVO.getRept()) || "1".equals(adminVO.getAdminType())){ %>
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0501/ech0501List.do'/>" class="top-heading">보고서</a>
						<div class="dropdown sub5">
							<ul>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0501/ech0501List.do'/>">보고서관리</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0502/ech0502List.do'/>">보고서 양식관리</a></li>
							</ul>
						</div>
					<% } %>
				</li>
				<li>
					<% if("Y".equals(adminVO.getSend()) || "1".equals(adminVO.getAdminType())){ %>
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0602/ech0602Modify.do'/>" class="top-heading">발송관리</a>
						<div class="dropdown sub6">
							<ul>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0602/ech0602Modify.do'/>">보고서발송</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0602/ech0602List.do'/>">이메일발송내역</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0603/ech0603List.do'/>">SMS발송내역</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0604/ech0604List.do'/>">SMS메시지</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0605/ech0605List.do'/>">이메일메시지</a></li>
							</ul>
						</div>
					<% } %>	
				</li> --%>
				<%-- <li>
					<% if("Y".equals(adminVO.getSale()) || "1".equals(adminVO.getAdminType())){ %>
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0901/ech0901List.do'/>" class="top-heading">영업관리</a>
						<div class="dropdown sub6">
							<ul>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0901/ech0901List.do'/>">상담관리</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0902/ech0902List.do'/>">견적관리</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0903/ech0903List.do'/>">계약관리</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0904/ech0904List.do'/>">입금관리</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0905/ech0905List.do'/>">자산관리</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0906/ech0906List.do'/>">대외공문관리</a></li>
							</ul>
						</div>
					<% } %>	
				</li> --%>
				<li>
					<% if("Y".equals(adminVO.getStnd()) || "1".equals(adminVO.getAdminType())){ %>
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0701/ech0701View.do'/>" class="top-heading">기준정보관리</a>
						<div class="dropdown sub4_1">
							<ul>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0701/ech0701View.do'/>">회사관리</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0702/ech0702List.do'/>">사용자관리</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0703/ech0703List.do'/>">지사관리</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0704/ech0704List.do'/>">고객사관리</a></li>
								<%-- <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0605/ech0605List.do'/>">이메일메시지</a></li> --%>
								<!--  <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech070501.do'/>">메뉴관리</a></li>
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech070601.do'/>">권한관리</a></li> -->
								<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0707/ech0707List.do'/>">공통코드관리</a></li>
								<!-- <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0708/ech0708List.do'/>">공통코드관리</a></li>  -->
							</ul>
						</div>
					<% } %>
				</li>
				<li>
					<% if("Y".equals(adminVO.getOper()) || "1".equals(adminVO.getAdminType())){ %>
					<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0801/ech0801List.do'/>" class="top-heading">운영관리</a>
					<div class="dropdown sub5_1">
						<ul>
							<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0801/ech0801List.do'/>">로그인접속이력(사용자)</a></li>
							<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0803/ech0803List.do'/>">개인정보처리(로그)</a></li>
							<li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0804/ech0804List.do'/>">작업로그</a></li>
							<!-- <li><a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0809/ech0809View.do'/>">운영환경설정</a></li> -->
						</ul>
					</div>
					<% } %>
				</li>
			</ul>		
		</nav>
		<!-- //gnb -->
	</div>
</div>
<!-- //header -->