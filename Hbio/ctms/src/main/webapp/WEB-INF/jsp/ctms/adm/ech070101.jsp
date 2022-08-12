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
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>기준정보</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="기준정보"/>
	            <jsp:param name="dept2" value="회사관리"/>
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
						<th scope="row">회사명</th>
						<td>
							<input type="text" />
						</td>
						<th scope="row" class="bl">사업자번호</th>
						<td>
							<input type="text" class="p30" />
                            -
                            <input type="text" class="p20" />
                             -
                            <input type="text" class="p40" />
						</td>
					</tr>
					<tr>
						<th scope="row">대표이사</th>
						<td>
							<input type="text" />
						</td>
						<th scope="row" class="bl">개인정보책임자</th>
						<td>
							<input type="text" />
						</td>
					</tr>
					<tr>
						<th scope="row">홈페이지</th>
						<td>
							<input type="text" />
						</td>
						<th scope="row" class="bl">대표전화번호</th>
						<td>
							<select class="p25">
                                <option>선택</option>
                            </select>
                            -
                            <input type="text" class="p30" />
                             -
                            <input type="text" class="p30" />
						</td>
					</tr>
					<tr>
						<th scope="row">고객센터번호</th>
						<td>
							<select class="p25">
                                <option>선택</option>
                            </select>
                            -
                            <input type="text" class="p30" />
                             -
                            <input type="text" class="p30" />
						</td>
						<th scope="row" class="bl">대표이메일</th>
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
						<th scope="row">로고이미지</th>
						<td colspan="3">
							<div class="attach_sec type02">
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
            <!-- //기본정보 -->
            <!-- 탭버튼 -->
            <div class="tab_area tab06">
                <ul>
                	<li><a href="#" class="on">이용약관</a></li>
                	<li><a href="#">개인정보처리방침</a></li>
                </ul>
            </div>
            <!-- //탭버튼 -->
            <!-- 상세내용 -->
            <div class="tab_con">
            	내용
            </div>
            <!-- //상세내용 -->
            <!-- 버튼 -->
			<div class="btn_area">
				<a href="#" class="type02">취소</a>
				<a href="#">저장</a>
			</div>
			<!-- //버튼 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>