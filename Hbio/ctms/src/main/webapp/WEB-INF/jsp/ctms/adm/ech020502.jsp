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
	function fn_pop(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech020503.do'/>"
					, '제품사용체크결과', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>eCRF관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="eCRF관리"/>
	            <jsp:param name="dept2" value="제품사용관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>연구정보</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 연구정보 -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>					
					<tr>
						<th scope="row">연구코드</th>
						<td>HBSE-MLG-20057-1</td>
						<th scope="row" class="bl">연구명</th>
						<td>연구명</td>
					</tr>
				</tbody>
			</table>
			<!-- //연구정보 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>사용체크정보</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 사용체크정보 -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>	
					<tr>
						<th scope="row">전달사항</th>
						<td colspan="3">
							<textarea class="type02 type03"></textarea>
						</td>
					</tr>				
					<tr>
						<th scope="row">체크기간</th>
						<td>
							<div class="date_sec">
								<span>
									<input type="text" class="date" />
									<a href="#" class="btn_cld">날짜검색</a>
								</span>
								<em>~</em>
								<span>
									<input type="text" class="date" />
									<a href="#" class="btn_cld">날짜검색</a>
								</span>
							</div>
							<a href="#" class="btn_sub2">적용</a>
						</td>
						<th scope="row" class="bl">체크주기</th>
						<td>
							<select class="p90">
								<option>선택</option>
							</select>
							&nbsp;일
						</td>
					</tr>
					<tr>
						<th scope="row">체크수</th>
						<td>
							<select class="p80">
								<option>선택</option>
							</select>
							<a href="#" class="btn_sub2">적용</a>
						</td>
						<th scope="row" class="bl">사용여부</th>
						<td>
							<input type="radio" name="useYN" id="useY" />
						    <label for="useY">사용</label>
						    <input type="radio" name="useYN" id="useN" />
						    <label for="useN">미사용</label>
						</td>
					</tr>
					<tr>
						<th scope="row"><i>*</i>체크버튼명</th>
						<td colspan="3">
							<div class="check_btn">
								<span>항목1</span>
								<input type="text" class="ta_l p90" />
							</div>
							<div class="check_btn">
								<span>항목2</span>
								<input type="text" class="ta_l p90" />
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<!-- //사용체크정보 -->
            <!-- 버튼 -->
			<div class="btn_area">
				<a href="#" class="type02">취소</a>
				<a href="#">저장</a>
			</div>
			<!-- //버튼 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<h4>피험자정보</h4>
				<!-- 버튼 -->
				<div>
					<a href="#" class="btn_sub">SMS 발송</a>
					<a href="#" class="btn_sub type02">일정저장</a>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
            <!-- 피험자정보 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:5%" />
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
						<th scope="col"><input type="checkbox" /></th>
						<th scope="col">번호</th>
						<th scope="col">이름</th>
						<th scope="col">생년월일</th>
						<th scope="col">나이</th>
						<th scope="col">성별</th>
						<th scope="col">핸드폰</th>
						<th scope="col">체크시작일</th>
						<th scope="col">체크종료일</th>
						<th scope="col">체크응답</th>
						<th scope="col">체크결과</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="checkbox" /></td>
						<td>3</td>					
						<td>홍길동</td>
						<td>000000</td>
						<td>00</td>
						<td>남</td>
						<td>010-0000-0000</td>
						<td>
							<div class="date_sec type02">
								<span>
									<input type="text" class="date" />
									<a href="#" class="btn_cld">날짜검색</a>
								</span>
							</div>
						</td>
						<td>
							<div class="date_sec type02">
								<span>
									<input type="text" class="date" />
									<a href="#" class="btn_cld">날짜검색</a>
								</span>
							</div>
						</td>
						<td>3/21</td>
						<td><a onclick="fn_pop(); return false;" class="btn_sub">확인</a></td>
					</tr>
					<tr>
						<td><input type="checkbox" /></td>
						<td>2</td>
						<td>홍길동</td>			
						<td>000000</td>
						<td>00</td>
						<td>남</td>
						<td>010-0000-0000</td>
						<td>
							<div class="date_sec type02">
								<span>
									<input type="text" class="date" />
									<a href="#" class="btn_cld">날짜검색</a>
								</span>
							</div>
						</td>
						<td>
							<div class="date_sec type02">
								<span>
									<input type="text" class="date" />
									<a href="#" class="btn_cld">날짜검색</a>
								</span>
							</div>
						</td>
						<td>3/21</td>
						<td><a onclick="fn_pop(); return false;" class="btn_sub">확인</a></td>
					</tr>
					<tr>
						<td><input type="checkbox" /></td>
						<td>1</td>
						<td>홍길동</td>					
						<td>000000</td>
						<td>00</td>
						<td>남</td>
						<td>010-0000-0000</td>
						<td>
							<div class="date_sec type02">
								<span>
									<input type="text" class="date" />
									<a href="#" class="btn_cld">날짜검색</a>
								</span>
							</div>
						</td>
						<td>
							<div class="date_sec type02">
								<span>
									<input type="text" class="date" />
									<a href="#" class="btn_cld">날짜검색</a>
								</span>
							</div>
						</td>
						<td>3/21</td>
						<td><a onclick="fn_pop(); return false;" class="btn_sub">확인</a></td>
					</tr>
				</tbody>
			</table>
			<!-- //피험자정보 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>