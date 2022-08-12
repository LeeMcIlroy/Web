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
		<h2>체크결과</h2>
		<a href="javascript:window.close();" title="닫기">닫기</a>
	</div>
	<!-- //pop_header -->
	<!-- pop_con -->
	<div class="pop_con type02">
		<!-- 서브타이틀 -->
		<div class="sub_title_area type02">
			<h3>피험자 정보</h3>
		</div>
		<!-- //서브타이틀 -->
		<!-- 피험자 정보 -->
		<table class="tbl_list type02">
			<colgroup>
				<col style="width:10%" />
				<col style="width:10%" />
				<col style="width:8%" />
				<col style="width:8%" />
				<col style="width:14%" />
				<col style="width:10%" />
				<col style="width:10%" />
				<col style="width:10%" />
				<col style="width:10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">이름</th>
					<th scope="col">생년월일</th>
					<th scope="col">나이</th>
					<th scope="col">성별</th>
					<th scope="col">핸드폰</th>
					<th scope="col">체크시작일</th>
					<th scope="col">체크종료일</th>
					<th scope="col">체크주기</th>
					<th scope="col">체크응답</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>홍길동</td>
					<td>000000</td>
					<td>00</td>
					<td>남</td>
					<td>010-0000-0000</td>
					<td>0000-00-00</td>
					<td>0000-00-00</td>
					<td>1일</td>
					<td>3/21</td>
				</tr>
			</tbody>
		</table>
		<!-- //피험자 정보 -->
		<!-- 서브타이틀 -->
		<div class="sub_title_area">
			<h3>사용체크 결과</h3>
		</div>
		<!-- //서브타이틀 -->
		<!-- 사용체크 결과 -->
		<div class="check_result">
			<ul>
				<li>
					<div>
						<span>2020-10-23(금)</span>
						<div>
							<a href="#" class="btn_check_01">오전체크</a>
							-
						</div>
						<div>
							<a href="#" class="btn_check_01">오후체크</a>
							-
						</div>
						<p>특이사항</p>
						<textarea></textarea>
					</div>
				</li>
				<li>
					<div>
						<span>2020-10-23(금)</span>
						<div>
							<a href="#" class="btn_check_02">오전체크</a>
							2020-10-10 16:00
						</div>
						<div>
							<a href="#" class="btn_check_02">오후체크</a>
							2020-10-10 16:00
						</div>
						<p>특이사항</p>
						<textarea></textarea>
					</div>
				</li>
				<li>
					<div>
						<span>2020-10-23(금)</span>
						<div>
							<a href="#" class="btn_check_03">오전체크</a>
							<div class="date_sec type02">
								<span>
									<input type="text" class="date" />
									<a href="#" class="btn_cld">날짜검색</a>
								</span>								
							</div>
							<select class="p10">
								<option>시</option>
							</select>
							<select class="p10">
								<option>분</option>
							</select>
						</div>
						<div>
							<a href="#" class="btn_check_03">오후체크</a>
							<div class="date_sec type02">
								<span>
									<input type="text" class="date" />
									<a href="#" class="btn_cld">날짜검색</a>
								</span>								
							</div>
							<select class="p10">
								<option>시</option>
							</select>
							<select class="p10">
								<option>분</option>
							</select>
						</div>
						<p>특이사항</p>
						<textarea></textarea>
					</div>
				</li>
			</ul>
		</div>
		<!-- //사용체크 결과 -->
		<!-- 버튼 -->
		<div class="btn_area">
			<a href="#" class="type02">닫기</a>
			<a href="#">저장</a>
		</div>
		<!-- //버튼 -->
	</div>
	<!-- //pop_con -->
</div>	
<!-- //pop_wrap -->
</body>
</html>