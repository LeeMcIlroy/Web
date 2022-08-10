<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<body>
<form:form commandName="searchVO" id="frm" name="frm">
<div class="wrap">
	<!-- 스킵 네비게이션 -->
	<div id="skip_navigation">
		<ul>
			<li><a href="#gnb">주 메뉴 바로가기</a></li>
			<li><a href="#content">본문 바로가기</a></li>
		</ul>
	</div>
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
	<!--// header -->
	<hr />
	<!-- container -->
	<div class="container">
		<!-- lnb -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu" />
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<jsp:include page="/WEB-INF/jsp/writer/usr/inc/incPageTitle.jsp">
            	<jsp:param name="dept1" value="상담"/>
            	<jsp:param name="dept2" value="상담신청"/>
            </jsp:include>
            <div class="cont_box">
				<div class="book_line03" style="text-align:center;">
					<ul>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/cnslt/cnsltRequestRegiModify.do'/>"><span>재학생 상담 신청하기</span></a></li>
						<li><a href="<c:out value='${pageContext.request.contextPath }/usr/cnslt/cnsltRequestOverModify.do'/>"><span>외국인 상담 신청하기</span></a></li>
					</ul>
				</div>
				<dl class="p09_txt">
					<dt>상담 진행</dt>
					<dd>
						<ul class="p09_arrow">
							<li>상담 신청</li>
							<li style="text-align:left; padding-left:24px;">상담 공지</li>
							<li>상담실 방문</li>
							<li>상담 진행</li>
							<li>상담 완료</li>
						</ul>
						<ul class="p09_icon mt30">
							<li>상담을 받고자 하는 학생은 홈페이지에서 온라인으로 글쓰기 상담을 신청합니다.<br/>※ 상담 받고자 하는 글에 대한 설명이 필요합니다. 중점적으로 봐주었으면 하는 사항에 대해 짧게 서술해 주십시오. </li>
							<li>상담 받을 글과 필기도구를 지참하여 상담을 신청한 일시에 ‘표현 능력 상담실 <font color="red">[진리관 104호, 사고와 표현 연구실]</font>’로 찾아옵니다.<br/>※ 상담 시간은 약 30분~60분 정도 소요됩니다.<br/>※ 상담 시간에 15분 이상 늦을 경우 상담은 자동으로 취소됩니다.</li>
						</ul>
					</dd>
				</dl>
				<dl class="p09_txt">
					<dt>참고사항</dt>
					<dd>
						<ul class="p09_icon">
							<li>상담 받을 파일을 올리지 않을 경우 상담이 불가합니다.</li>
							<li>단, 자기소개서, 졸업 논문, 교내 공모전 제출용 프레젠테이션 문서나 글, 사고와 표현 공통첨삭과제는 상담 불가</li>
							<li>‘구상’ 단계의 원고를 상담 받고자 하는 학생은 아이디어와 목차를 작성하여 올려야 합니다.</li>
							<li>제출한 글은 교육 및 연구 자료로 활용될 수 있습니다.</li>
						</ul>
					</dd>
				</dl>
			</div>
		</div>
		<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
</div>
<input type="hidden" id="message" name="message" value="${message }"/>
</form:form>
</body>
</html>
