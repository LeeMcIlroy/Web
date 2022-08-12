<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html>
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav"/>
	<!-- contents -->
	<div class="contents">
		<!-- 회원정보 -->
		<div class="profile">			
			<ul>
				<li>
					<div>
						<p>아이디</p>
						<div>
							<input type="text" />
						</div>
					</div>
				</li>
				<li>
					<div>
						<p>이름</p>
						<div>
							<input type="text" />
						</div>
					</div>
				</li>
				<li>
					<div>
						<p>성별</p>
						<div>
							<input type="radio" name="gender" id="gender01" class="form_base" />
						    <label for="gender01">남</label>
						    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						    <input type="radio" name="gender" id="gender02" class="form_base" />
						    <label for="gender02">여</label>
						</div>
					</div>
				</li>
				<li>
					<div>
						<p>생년월일</p>
						<div>
							<input type="text" />
						</div>
					</div>
				</li>
				<li>
					<div>
						<p>핸드폰</p>
						<div>
							<select class="phone">
								<option>선택</option>
							</select>
							-
							<input type="text" class="phone" />
							-
							<input type="text" class="phone" />
						</div>
					</div>
				</li>
				<li>
					<div>
						<p>이메일</p>
						<div>
							<input type="text" class="email1" />
							@
							<input type="text" class="email2" />
							<select class="email2">
								<option>직접입력</option>
							</select>
						</div>
					</div>
				</li>
				<li>
					<div>
						<p>주소</p>
						<div>
							<div class="address">
								<a href="#" class="btn_sub2">주소검색</a>
								<input type="text" />
							</div>
							<input type="text" />
							<input type="text" placeholder="상세주소" />
						</div>
					</div>
				</li>
				<li>
					<div>
						<p>통장사본</p>
						<div>
							<input type="text" placeholder="은행명" class="bankbook1" />
							<input type="text" placeholder="계좌번호" class="bankbook2" />
							<input type="text" placeholder="예금주" class="bankbook1" />
							<div class="attach_sec">
	                           	<input type="file" id="in_file01" />
	                           	<label for="in_file01" class="btn_sub2">통장사본파일</label>
	                           	<div>
	                           		<span>파일명.jpg<a href="#">삭제</a></span>
	                           		
	                           	</div>
							</div>
						</div>
					</div>
				</li>
				<li>
					<div>
						<p>임상시험 정보</p>
						<div class="clinic_info">
							<div>
								<p>안면여드름</p>
								<select>
									<option>선택</option>
								</select>
							</div>
							<div>
								<p>등여드름</p>
								<select>
									<option>선택</option>
								</select>
							</div>
							<div>
								<p>팔자주름</p>
								<select>
									<option>선택</option>
								</select>
							</div>
							<div>
								<p>셀룰라이트</p>
								<select>
									<option>선택</option>
								</select>
							</div>
							<div>
								<p>눈가주름</p>
								<select>
									<option>선택</option>
								</select>
							</div>
							<div>
								<p>다크서클</p>
								<select>
									<option>선택</option>
								</select>
							</div>
							<div>
								<p>광피부타입</p>
								<select>
									<option>선택</option>
								</select>
							</div>
							<div>
								<p>색소침착</p>
								<select>
									<option>선택</option>
								</select>
							</div>
							<div>
								<p>탈모</p>
								<select>
									<option>선택</option>
								</select>
							</div>
							<div>
								<p>아이백</p>
								<select>
									<option>선택</option>
								</select>
							</div>
							<div>
								<p>민감여부</p>
								<select>
									<option>선택</option>
								</select>
							</div>
							<div>
								<p>비듬</p>
								<select>
									<option>선택</option>
								</select>
							</div>
							<div>
								<p>홍조</p>
								<select>
									<option>선택</option>
								</select>
							</div>
						</div>
					</div>
				</li>
			</ul>
		</div>
		<!-- //회원정보 -->
		<!-- 하단버튼 -->
		<div class="btn_area">
			<span><a href="#" class="type02">취소</a></span>
			<span><a href="#">저장</a></span>
		</div>
		<!-- //하단버튼 -->
	</div>
	<!-- //contents -->
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!-- //footer -->
</div>
<!-- //wrap -->
</body>
</html>