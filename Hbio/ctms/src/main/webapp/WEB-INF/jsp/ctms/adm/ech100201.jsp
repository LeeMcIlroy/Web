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
		<h2>SMS 발송</h2>
		<a href="javascript:window.close();" title="닫기">닫기</a>
	</div>
	<!-- //pop_header -->
	<!-- pop_con -->
	<div class="pop_con type02">
		<!-- 서브타이틀 -->
		<div class="sub_title_area type02">
			<h3>발송 대상자</h3>
		</div>
		<!-- //서브타이틀 -->
		<!-- 대상자 -->
		<div class="hd_fix">
			<div>
				<table>
					<colgroup>
						<col style="width:70px" />
						<col style="width:150px" />
						<col style="width:150px" />
						<col style="width:220px" />
						<col style="width:auto" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col" width="70">번호</th>
							<th scope="col" width="150">이름</th>
							<th scope="col" width="150">핸드폰</th>
							<th scope="col" width="220">연구코드</th>
							<th scope="col" width="151">참여상태</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>11</td>		
							<td>홍길동</td>
							<td>010-0000-0000</td>
							<td>HBSE-MLG-20057-1</td>
							<td>참여중</td>
						</tr>
						<tr>
							<td>10</td>		
							<td>홍길동</td>
							<td>010-0000-0000</td>
							<td>HBSE-MLG-20057-1</td>
							<td>참여중</td>
						</tr>
						<tr>
							<td>9</td>		
							<td>홍길동</td>
							<td>010-0000-0000</td>
							<td>HBSE-MLG-20057-1</td>
							<td>참여중</td>
						</tr>
						<tr>
							<td>8</td>		
							<td>홍길동</td>
							<td>010-0000-0000</td>
							<td>HBSE-MLG-20057-1</td>
							<td>참여중</td>
						</tr>
						<tr>
							<td>7</td>		
							<td>홍길동</td>
							<td>010-0000-0000</td>
							<td>HBSE-MLG-20057-1</td>
							<td>참여중</td>
						<tr>
							<td>6</td>		
							<td>홍길동</td>
							<td>010-0000-0000</td>
							<td>HBSE-MLG-20057-1</td>
							<td>참여중</td>
						</tr>
						<tr>
							<td>5</td>		
							<td>홍길동</td>
							<td>010-0000-0000</td>
							<td>HBSE-MLG-20057-1</td>
							<td>참여중</td>
						</tr>
						<tr>
							<td>4</td>		
							<td>홍길동</td>
							<td>010-0000-0000</td>
							<td>HBSE-MLG-20057-1</td>
							<td>참여중</td>
						</tr>
						<tr>
							<td>3</td>		
							<td>홍길동</td>
							<td>010-0000-0000</td>
							<td>HBSE-MLG-20057-1</td>
							<td>참여중</td>
						</tr>
						<tr>
							<td>2</td>		
							<td>홍길동</td>
							<td>010-0000-0000</td>
							<td>HBSE-MLG-20057-1</td>
							<td>참여중</td>
						</tr>
						<tr>
							<td>1</td>		
							<td>홍길동</td>
							<td>010-0000-0000</td>
							<td>HBSE-MLG-20057-1</td>
							<td>참여중</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<!-- //대상자 -->
		<!-- 이메일발송 -->
		<table class="tbl_view">
			<colgroup>
				<col style="width:200px" />
				<col style="width:auto" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">발송일시</th>
					<td>
					    <input type="radio" name="H10020101" id="H10020101_01" />
					    <label for="H10020101_01">즉시발송</label>
					    <input type="radio" name="H10020101" id="H10020101_02" />
					    <label for="H10020101_02">예약발송</label>
					    &nbsp;&nbsp;
						<div class="date_sec type02">
							<span>
								<input type="text" class="date" />
								<a href="#" class="btn_cld">날짜검색</a>
							</span>
						</div>
						<select class="p10">
							<option>00</option>
						</select>
						시
						&nbsp;&nbsp;
						<select class="p10">
							<option>00</option>
						</select>
						분
					</td>
				</tr>
				<tr>
					<th scope="row">발송 메시지</th>
					<td>
						<div class="msg_select">
							<select class="p80">
								<option>자동입력</option>
							</select>
							<span>100/1000kb</span>
						</div>
						<textarea></textarea>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- //이메일발송 -->
		<!-- 버튼 -->
		<div class="btn_area">
			<a href="#" class="type02">닫기</a>
			<a href="#">발송</a>
		</div>
		<!-- //버튼 -->
	</div>
	<!-- //pop_con -->
</div>	
<!-- //pop_wrap -->
</body>
</html>