<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">	
</script>
<body>
<!-- pop_wrap -->
<div class="pop_wrap">
	<!-- pop_header -->
	<div class="pop_header">
		<h1 class="hidden"><a href="#">H&amp;Bio</a></h1>
		<h2>예약일정</h2>
		<a href="javascript:window.close();" title="닫기">닫기</a>
	</div>
	<!-- //pop_header -->
	<!-- pop_con -->
	<div class="pop_con type02">
		<div class="calendar_top type02">
			<a href="#">이전달</a>
			2020-01-01 목요일
			<a href="#">다음달</a>
		</div>			
		<!-- 연구일정 -->
		<div class="hd_fix">
			<div>
				<table>
					<colgroup>
						<col style="width:40px" />
						<col style="width:140px" />
						<col style="width:80px" />
						<col style="width:100px" />
						<col style="width:60px" />
						<col style="width:60px" />
						<col style="width:120px" />
						<col style="width:auto" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col" width="40">번호</th>
							<th scope="col" width="140">연구코드</th>
							<th scope="col" width="80">이름</th>
							<th scope="col" width="100">생년월일</th>
							<th scope="col" width="60">나이</th>
							<th scope="col" width="60">성별</th>
							<th scope="col" width="120">핸드폰</th>
							<th scope="col" width="140">예약상태</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>11</td>		
							<td>HBSE-MLG-20057-1</td>
							<td>홍길동</td>
							<td>000000</td>
							<td>00</td>
							<td>남</td>
							<td>000-0000-0000</td>
							<td>예약<br />0000-00-00 00:00</td>
						</tr>
						<tr>
							<td>10</td>		
							<td>HBSE-MLG-20057-1</td>
							<td>홍길동</td>
							<td>000000</td>
							<td>00</td>
							<td>남</td>
							<td>000-0000-0000</td>
							<td>예약<br />0000-00-00 00:00</td>
						</tr>
						<tr>
							<td>9</td>		
							<td>HBSE-MLG-20057-1</td>
							<td>홍길동</td>
							<td>000000</td>
							<td>00</td>
							<td>남</td>
							<td>000-0000-0000</td>
							<td>예약<br />0000-00-00 00:00</td>
						</tr>
						<tr>
							<td>8</td>		
							<td>HBSE-MLG-20057-1</td>
							<td>홍길동</td>
							<td>000000</td>
							<td>00</td>
							<td>남</td>
							<td>000-0000-0000</td>
							<td>예약<br />0000-00-00 00:00</td>
						</tr>
						<tr>
							<td>7</td>		
							<td>HBSE-MLG-20057-1</td>
							<td>홍길동</td>
							<td>000000</td>
							<td>00</td>
							<td>남</td>
							<td>000-0000-0000</td>
							<td>예약<br />0000-00-00 00:00</td>
						<tr>
							<td>6</td>		
							<td>HBSE-MLG-20057-1</td>
							<td>홍길동</td>
							<td>000000</td>
							<td>00</td>
							<td>남</td>
							<td>000-0000-0000</td>
							<td>예약<br />0000-00-00 00:00</td>
						</tr>
						<tr>
							<td>5</td>		
							<td>HBSE-MLG-20057-1</td>
							<td>홍길동</td>
							<td>000000</td>
							<td>00</td>
							<td>남</td>
							<td>000-0000-0000</td>
							<td>예약<br />0000-00-00 00:00</td>
						</tr>
						<tr>
							<td>4</td>		
							<td>HBSE-MLG-20057-1</td>
							<td>홍길동</td>
							<td>000000</td>
							<td>00</td>
							<td>남</td>
							<td>000-0000-0000</td>
							<td>예약<br />0000-00-00 00:00</td>
						</tr>
						<tr>
							<td>3</td>		
							<td>HBSE-MLG-20057-1</td>
							<td>홍길동</td>
							<td>000000</td>
							<td>00</td>
							<td>남</td>
							<td>000-0000-0000</td>
							<td>예약<br />0000-00-00 00:00</td>
						</tr>
						<tr>
							<td>2</td>		
							<td>HBSE-MLG-20057-1</td>
							<td>홍길동</td>
							<td>000000</td>
							<td>00</td>
							<td>남</td>
							<td>000-0000-0000</td>
							<td>예약<br />0000-00-00 00:00</td>
						</tr>
						<tr>
							<td>1</td>		
							<td>HBSE-MLG-20057-1</td>
							<td>홍길동</td>
							<td>000000</td>
							<td>00</td>
							<td>남</td>
							<td>000-0000-0000</td>
							<td>예약<br />0000-00-00 00:00</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<!-- //연구일정 -->
		<!-- 버튼 -->
		<div class="btn_area">
			<a href="#" class="type02">닫기</a>
		</div>
		<!-- //버튼 -->
	</div>
	<!-- //pop_con -->
</div>	
<!-- //pop_wrap -->
</body>
</html>