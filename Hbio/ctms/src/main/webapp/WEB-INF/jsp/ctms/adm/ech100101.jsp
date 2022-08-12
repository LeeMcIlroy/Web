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
		<h2>피험자 조회</h2>
		<a href="javascript:window.close();" title="닫기">닫기</a>
	</div>
	<!-- //pop_header -->
	<!-- pop_con -->
	<div class="pop_con">
		<!-- 검색영역 -->
		<div class="srch_area">
			<ul>
				<li>
					<p>연구조회</p>
					<span class="type01">
						<input type="text" placeholder="연구코드" />
					</span>
					<span>
						<select>
							<option>년도</option>
						</select>
					</span>
					<span class="type01">
						<select>
							<option>연구코드/연구명</option>
						</select>
					</span>
				</li>
				<li>
					<p>검색어</p>
					<span>
						<select>
							<option>검색조건</option>
						</select>
					</span>
					<span class="type02">
						<input type="text" placeholder="검색어 입력" />
					</span>
				</li>
			</ul>
			<!-- 조회버튼 -->
			<a href="#">조회</a>
		</div>
		<!-- //검색영역 -->
		<!-- 목록 -->
		<table class="tbl_list">
			<colgroup>
				<col style="width:4%" />
				<col style="width:6%" />
				<col style="width:8%" />
				<col style="width:8%" />
				<col style="width:6%" />
				<col style="width:6%" />
				<col style="width:6%" />
				<col style="width:14%" />
				<col style="width:6%" />
				<col style="width:auto" />
				<col style="width:10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col"><input type="checkbox" /></th>
					<th scope="col">번호</th>
					<th scope="col">이름</th>
					<th scope="col">생년월일</th>
					<th scope="col">나이</th>
					<th scope="col">성별</th>
					<th scope="col">거주지</th>
					<th scope="col">핸드폰</th>
					<th scope="col">연구<br />순응도</th>
					<th scope="col">참여연구</th>
					<th scope="col">메모</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="nodata" colspan="11">피험자 정보가 없습니다.</td>
				</tr>
				<tr>
					<td><input type="checkbox" /></td>
					<td>3</td>					
					<td>홍길동</td>
					<td>000000</td>
					<td>00</td>
					<td>남</td>
					<td>서울</td>
					<td>010-0000-0000</td>
					<td>상</td>
					<td>HBSE-MLG-20057-1</td>
					<td>확인</td>
				</tr>
				<tr>
					<td><input type="checkbox" /></td>
					<td>2</td>					
					<td>홍길동</td>
					<td>000000</td>
					<td>00</td>
					<td>남</td>
					<td>서울</td>
					<td>010-0000-0000</td>
					<td>상</td>
					<td>HBSE-MLG-20057-1</td>
					<td>확인</td>
				</tr>
				<tr>
					<td><input type="checkbox" /></td>
					<td>1</td>					
					<td>홍길동</td>
					<td>000000</td>
					<td>00</td>
					<td>남</td>
					<td>서울</td>
					<td>010-0000-0000</td>
					<td>상</td>
					<td>HBSE-MLG-20057-1</td>
					<td>확인</td>
				</tr>
			</tbody>
		</table>
		<!-- //목록 -->
		<!-- 버튼 -->
		<div class="btn_area">
			<a href="#" class="type02">취소</a>
			<a href="#">선택</a>
		</div>
		<!-- //버튼 -->
	</div>
	<!-- //pop_con -->
</div>	
<!-- //pop_wrap -->
</body>
</html>
