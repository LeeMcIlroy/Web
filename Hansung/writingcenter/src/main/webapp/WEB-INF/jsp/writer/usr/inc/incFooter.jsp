<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<div class="footer">
	<div class="foot_cont">
		<p><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/footer_logo_org.png'/>" alt="한성대학교 글쓰기센터 Hansung University Writing Center" /></p>
		<!-- 정보 -->
		<div class="foot_link">
			<ul>
				<!-- <li><a href="<c:out value='${pageContext.request.contextPath }/usr/cntst/cntstWriteComList.do'/>" rel="noreferrer">제15회 한성인 글쓰기대회</a></li> -->
				<li><a href="http://stdweb2.korean.go.kr/main.jsp" target="_blank" rel="noreferrer">표준국어대사전</a></li>
				<li><a href="http://info.hansung.ac.kr/" target="_blank" rel="noreferrer">종합정보시스템</a></li>
				<li><a href="http://hsel.hansung.ac.kr/" target="_blank" rel="noreferrer">학술정보관</a></li>
				<li><a href="https://learn.hansung.ac.kr/" target="_blank" rel="noreferrer">사이버강의실</a></li>
				<li><a href="https://hsportal.hansung.ac.kr/" target="_blank" rel="noreferrer">비교과 포인트</a></li>
			</ul>
			<p>서울특별시 성북구 삼선교로 16길 116(삼선동2가) 진리관 104호 사고와 표현 연구실 | 전화: 02) 760-4354</p>
			<p>COPYRIGHT (C) 2017 by HANSUNG UNIVERSITY. ALL RIGHTS RESERVED</p>
		</div>
		<div class="sns_link">
		<!--
			<a href="#" class="f_btn01" onclick="alert('준비중 입니다.'); return false;">비교과 포인트</a>
		-->
			<a href="https://www.facebook.com/profile.php?id=100033504013187(한성대글쓰기센터_Facebook)" target="_blank" rel="noreferrer"><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/icon_f.jpg'/>" alt="페이스북" /></a>
		</div>
	</div>
</div>
