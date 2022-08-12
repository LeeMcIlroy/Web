<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<body>
<!-- pop_wrap -->
<div class="pop_wrap">
	<!-- pop_header -->
	<div class="pop_header">
		<h1 class="hidden"><a href="#">H&amp;Bio</a></h1>
		<h2>미리보기</h2>
		<a href="javascript:window.close();" title="닫기">닫기</a>
	</div>
	<!-- //pop_header -->
	<!-- pop_con -->
	<div class="pop_con type02">
		<!-- 설문정보 -->
		<table class="tbl_list type02">
			<colgroup>
				<col style="width:20%" />
				<col style="width:30%" />
				<col style="width:15%" />
				<col style="width:35%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">연구코드</th>
					<th scope="col">연구명</th>
					<th scope="col">설문차수</th>
					<th scope="col">설문명</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>HBSE-MLG-20057-1</td>
					<td>연구명이 들어갑니다.</td>
					<td>1차 1회</td>
					<td>피부임상 1차설문</td>
				</tr>
			</tbody>
		</table>
		<!-- //설문정보 -->
		<!-- 버튼 -->
		<div class="btn_area">
			<a href="#" class="type02">닫기</a>
			<a href="#">PDF 다운로드</a>
			<a href="#">이미지 다운로드</a>
		</div>
		<!-- //버튼 -->
		<!-- 설문 미리보기 -->
		<div class="survey_view">
			<div>
				설문명이 들어갑니다.
				<br />
				조사내용이 들어갑니다. 조사내용이 들어갑니다. 조사내용이 들어갑니다. 조사내용이 들어갑니다. 조사내용이 들어갑니다. 조사내용이 들어갑니다. 조사내용이 들어갑니다. 조사내용이 들어갑니다.
				<br />
				<br />
				<br />
				<br />
				사용자 설문 내용 추가
			</div>
		</div>
		<!-- //설문 미리보기 -->
	</div>
	<!-- //pop_con -->
</div>	
<!-- //pop_wrap -->
</body>
</html>