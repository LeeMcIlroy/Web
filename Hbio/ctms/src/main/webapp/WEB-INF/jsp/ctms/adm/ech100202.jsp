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
		<h2>이메일 발송</h2>
		<a href="javascript:window.close();" title="닫기">닫기</a>
	</div>
	<!-- //pop_header -->
	<!-- pop_con -->
	<div class="pop_con type02">
		<!-- 받는사람 -->
		<table class="tbl_view mb01">
			<colgroup>
				<col style="width:200px" />
				<col style="width:auto" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">받는사람 이메일</th>
					<td>
					    <textarea class="type03 mb02"></textarea>
					    <a href="#" class="btn_sub first">피험자 조회</a>
					    <a href="#" class="btn_sub">고객사 조회</a>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- //받는사람 -->
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
					    <input type="radio" name="H10020201" id="H10020201_01" />
					    <label for="H10020201_01">즉시발송</label>
					    <input type="radio" name="H10020201" id="H10020201_02" />
					    <label for="H10020201_02">예약발송</label>
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
					<th scope="row">발송 제목</th>
					<td>
						<input type="text" class="ta_l" />
					</td>
				</tr>
				<tr>
					<th scope="row">내용</th>
					<td>
						<textarea class="type03"></textarea>
					</td>
				</tr>
				<tr>
					<th scope="row">첨부파일</th>
					<td>
						<div class="attach_sec">
                           	<input type="file" id="in_file01" />
                           	<label for="in_file01" class="btn_sub">파일업로드</label>
                           	<div>
                           		<span>파일명.jpg</span>
                           		<a href="#">삭제</a>
                           	</div>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
		<p class="guide_txt">※ 수신자가 여러명일 경우 이메일 사이에 콤마로 구분</p>
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