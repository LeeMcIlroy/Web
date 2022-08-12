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
		<h2>피부자극관리</h2>
		<a href="javascript:window.close();" title="닫기">닫기</a>
	</div>
	<!-- //pop_header -->
	<!-- pop_con -->
	<div class="pop_con type03">
		<!-- 식별코드 -->
		<table class="tbl_view mb01">
			<colgroup>
				<col style="width:90px" />
				<col style="width:auto" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">식별코드</th>
					<td>20013-5-01</td>
				</tr>
			</tbody>
		</table>
		<!-- //식별코드 -->
		<!-- 입력창 -->
		<table class="tbl_list multi_hd">
			<colgroup>
				<col style="width:16.6%" />
				<col style="width:16.6%" />
				<col style="width:16.6%" />
				<col style="width:16.6%" />
				<col style="width:16.6%" />
				<col style="width:16.6%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" colspan="3" class="bl">첩포 제거 30분 후</th>
					<th scope="col" colspan="3">첩포 제거 24시간 후</th>
				</tr>
				<tr>
					<th scope="col" class="bl">#12<br />(N.C)</th>
					<th scope="col">#13<br />(N.C)</th>
					<th scope="col">#3</th>
					<th scope="col">#12<br />(N.C)</th>
					<th scope="col">#13<br />(N.C)</th>
					<th scope="col">#3</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" class="ta_c" /></td>						
					<td><input type="text" class="ta_c" /></td>	
					<td><input type="text" class="ta_c" /></td>	
					<td><input type="text" class="ta_c" /></td>	
					<td><input type="text" class="ta_c" /></td>	
					<td><input type="text" class="ta_c" /></td>	
				</tr>
			</tbody>
		</table>
		<p class="guide_txt type02">※ 0 / 0.5 / 1 / 2 / 3 / 4 / 5 숫자만 입력 가능합니다.</p>
		<!-- //입력창 -->
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