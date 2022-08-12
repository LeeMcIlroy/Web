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
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech100201.do'/>"
					, 'SMS발송', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	function fn_list(){
		location.href = "<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech030101.do'/>";
	}	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>피험자관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="피험자관리"/>
	            <jsp:param name="dept2" value="피험자관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>기본정보</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 기본정보 -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>					
					<tr>
						<th scope="row">번호</th>
						<td>
							<input type="text" />
						</td>
						<th scope="row" class="bl">이름</th>
						<td>
							<input type="text" />
						</td>
					</tr>
					<tr>
						<th scope="row">성별</th>
						<td>
							<input type="radio" name="gender" id="gender01" />
						    <label for="gender01">남</label>
						    <input type="radio" name="gender" id="gender02" />
						    <label for="gender02">여</label>
						</td>
						<th scope="row" class="bl">주민등록번호</th>
						<td>
							<input type="text" class="p40" />
							-
							<input type="text" class="p50" />
						</td>
					</tr>
					<tr>
						<th scope="row">핸드폰</th>
						<td>
							<select class="p25">
                                <option>선택</option>
                            </select>
                            -
                            <input type="text" class="p30" />
                             -
                            <input type="text" class="p30" />
						</td>
						<th scope="row" class="bl">이메일</th>
						<td>
							<input type="text" class="p30" />
                             @
                            <input type="text" class="p30" />
                            <select class="p30">
                                <option>직접입력</option>
                            </select>
						</td>
					</tr>
					<tr>
						<th scope="row">주소</th>
						<td colspan="3">
							<a href="#" class="btn_sub2">주소검색</a>
							<input type="text" class="p15" />
							<input type="text" class="ta_l p40" />
							<input type="text" class="ta_l p35" placeholder="상세주소" />
						</td>
					</tr>
					<tr>
						<th scope="row">통장사본</th>
						<td colspan="3">
							<input type="text" class="p15" placeholder="은행명" />
							<input type="text" class="p30" placeholder="계좌번호" />
							<input type="text" class="p15" placeholder="예금주" />
							<div class="attach_sec">
	                           	<input type="file" id="in_file01" />
	                           	<label for="in_file01" class="btn_sub2">파일업로드</label>
	                           	<div>
	                           		<span>파일명.jpg</span>
	                           		<a href="#">삭제</a>
	                           	</div>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<!-- //기본정보 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>연구대상자 상태</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 연구대상자 상태 -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>								
					<tr>
						<th scope="row">관리자 확인</th>
						<td>
							<input type="checkbox" name="subIdent" id="subIdent" />
							<label for="subIdent">피험자 확인</label>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<span>확인일 :</span> 
							<div class="date_sec">								
								<span>
									<input type="text" class="date" />
									<a href="#" class="btn_cld">날짜검색</a>
								</span>
							</div>
						</td>
						<th scope="row" class="bl">연구순응도</th>
						<td>
							<input type="radio" name=researchComp id="researchComp01" />
						    <label for="researchComp01">상</label>
						    <input type="radio" name="researchComp" id="researchComp02" />
						    <label for="researchComp02">중</label>
						    <input type="radio" name=researchComp id="researchComp03" />
						    <label for="researchComp03">하</label>
						    <input type="radio" name="researchComp" id="researchComp04" />
						    <label for="researchComp04">모두</label>
						</td>
					</tr>
					<tr>
						<th scope="row">연구대상자유형</th>
						<td colspan="3">
							<div class="unit_wrap">
								<!-- 유형 -->
								<div class="unit">
									<p>안면여드름</p>
									<select class="p60">
										<option>선택</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>등여드름</p>
									<select class="p60">
										<option>선택</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>팔자주름</p>
									<select class="p60">
										<option>선택</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>셀룰라이트</p>
									<select class="p60">
										<option>선택</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>눈가주름</p>
									<select class="p60">
										<option>선택</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>다크서클</p>
									<select class="p60">
										<option>선택</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>광피부타입</p>
									<select class="p60">
										<option>선택</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>색소침착</p>
									<select class="p60">
										<option>선택</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>탈모</p>
									<select class="p60">
										<option>선택</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>아이백</p>
									<select class="p60">
										<option>선택</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>민감여부</p>
									<select class="p60">
										<option>선택</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>비듬</p>
									<select class="p60">
										<option>선택</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>홍조</p>
									<select class="p60">
										<option>선택</option>
									</select>
								</div>
								<!-- //유형 -->
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">메모</th>
						<td colspan="3">
							<textarea class="type02 type03"></textarea>
						</td>
					</tr>
					<tr>
						<th scope="row">상태</th>
						<td colspan="3">
							<input type="radio" name="subState" id="subState01" />
						    <label for="subState01">정상</label>
						    <input type="radio" name="subState" id="subState02" />
						    <label for="subState02">정지(로그인 차단)</label>
						</td>
					</tr>
				</tbody>
			</table>
			<!-- //연구대상자 상태 -->
            <!-- 버튼 -->
			<div class="btn_area">
				<a href="#" class="type02">취소</a>
				<a href="#">저장</a>
			</div>
			<!-- //버튼 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<h4>예약현황</h4>
				<!-- 버튼 -->
				<div>
					<a onclick="fn_pop(); return false;" class="btn_sub">SMS 발송</a>
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
            <!-- 예약현황 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:20%" />
					<col style="width:30%" />
					<col style="width:20%" />
					<col style="width:10%" />
					<col style="width:20%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">연구코드</th>
						<th scope="col">연구명</th>
						<th scope="col">연구기간</th>
						<th scope="col">예약상태</th>
						<th scope="col">예약일시</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>HBSE-MLG-20057-1</td>
						<td>Ecrf 관찰연구 1회</td>
						<td>2020-09-22 ~ 2020-09-25</td>
						<td>예약</td>
						<td>2020-09-22 09:00</td>
					</tr>
					<tr>
						<td>HBSE-MLG-20057-1</td>
						<td>Ecrf 관찰연구 1회</td>
						<td>2020-09-22 ~ 2020-09-25</td>
						<td>예약</td>
						<td>2020-09-22 09:00</td>
					</tr>
					<tr>
						<td>HBSE-MLG-20057-1</td>
						<td>Ecrf 관찰연구 1회</td>
						<td>2020-09-22 ~ 2020-09-25</td>
						<td>예약</td>
						<td>2020-09-22 09:00</td>
					</tr>
				</tbody>
			</table>
			<!-- //예약현황 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>