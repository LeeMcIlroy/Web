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
		<h2>예약관리</h2>
		<a href="javascript:window.close();" title="닫기">닫기</a>
	</div>
	<!-- //pop_header -->
	<!-- pop_con -->
	<div class="pop_con type03">
		<!-- 예약관리 -->
		<table class="tbl_view mb01">
			<colgroup>
				<col style="width:90px" />
				<col style="width:auto" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">연구코드</th>
					<td>HBSE-MLG-20057-1</td>
				</tr>
				<tr>
					<th scope="row">방문횟수</th>
					<td>
					    <select class="p50">
                       		<option>선택</option>
                       	</select>        
                       	&nbsp;&nbsp;회차
					</td>
				</tr>
				<tr>
					<th scope="row">예약일</th>
					<td>
						<div class="date_sec type02 mb02">
							<span>
								<input type="text" class="date" />
								<a href="#" class="btn_cld">날짜검색</a>
							</span>
						</div>
						<br />
						<select class="p30">
							<option>00</option>
						</select>
						시
						&nbsp;&nbsp;
						<select class="p30">
							<option>00</option>
						</select>
						분
					</td>
				</tr>
				<tr>
					<th scope="row">참여상태</th>
					<td>
						<input type="radio" name="H10030101" id="H10030101_01" />
					    <label for="H10030101_01">참여</label>
					    <input type="radio" name="H10030101" id="H10030101_02" />
					    <label for="H10030101_02">불참</label>
					    <input type="radio" name="H10030101" id="H10030101_03" />
					    <label for="H10030101_03">온라인참여</label>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- //예약관리 -->
		<!-- 버튼 -->
		<div class="btn_area">
			<a href="#" class="type02">취소</a>
			<a href="#">저장</a>
		</div>
		<!-- //버튼 -->
	</div>
	<!-- //pop_con -->
</div>	
<!-- //pop_wrap -->
</body>
</html>