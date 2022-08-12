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
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>연구관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<div class="title_area">
				<h3>IRB심의</h3>
				<!-- 현재위치 -->
				<div class="breadcrumb">
					<a href="#">홈</a>
					<span>&gt;</span>
					연구관리
					<span>&gt;</span>
					IRB심의
				</div>
			</div>
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
                        <td>연구명이 들어갑니다.</td>
                    </tr>
                    <tr>
                        <th scope="row">연구지사</th>
                        <td>서울지사</td>
                        <th scope="row" class="bl">연구목적</th>
                        <td>연구목적이 들어갑니다.</td>
                    </tr>
                    <tr>
                        <th scope="row">연구기간</th>
                        <td>0000-00-00 ~ 0000-00-00</td>
                        <th scope="row" class="bl">고객사명</th>
                        <td>고객사명이 들어갑니다.</td>
                    </tr>
                </tbody>
            </table>
            <!-- //연구정보 -->
            <!-- 서브타이틀 -->
            <div class="sub_title_area">
                <h4>IRB 심의정보</h4>
            </div>
            <!-- //서브타이틀 -->
            <!-- IRB 심의정보 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">고객사명</th>
                        <td colspan="3">
                            <input type="text" class="p15" value="HBABN01" disabled="disabled" />
                            -
                            <input type="text" class="p15" placeholder="신청년월" />
                            -
                             <input type="text" class="p15" placeholder="심의종류" />
                            -
                             <input type="text" class="p15" placeholder="일련번호" />
                            -
                             <input type="text" class="p15" placeholder="관리번호" />
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">심의종류</th>
                        <td>
							<input type="radio" name="H01040201" id="H01040201_01" />
							<label for="H01040201_01">신속</label>
							<input type="radio" name="H01040201" id="H01040201_02" />
							<label for="H01040201_02">정규</label>
                        </td>
                        <th scope="row" class="bl">심의문서</th>
                        <td>
                            <input type="radio" name="H01040202" id="H01040202_01" />
							<label for="H01040202_01">신규계획</label>
							<input type="radio" name="H01040202" id="H01040202_02" />
							<label for="H01040202_02">결과보고</label>
							<input type="radio" name="H01040202" id="H01040202_03" />
							<label for="H01040202_03">기타</label>
							&nbsp;<input type="text" class="p40" />
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">심의상태</th>
                        <td>
							<input type="radio" name="H01040203" id="H01040203_01" />
							<label for="H01040203_01">심의중</label>
							<input type="radio" name="H01040203" id="H01040203_02" />
							<label for="H01040203_02">완료</label>
                        </td>
                        <th scope="row" class="bl">심의결과</th>
                        <td>
                            <input type="radio" name="H01040204" id="H01040204_01" />
							<label for="H01040204_01">승인</label>
							<input type="radio" name="H01040202" id="H01040204_02" />
							<label for="H01040204_02">보완</label>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">심의접수일</th>
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
                        </td>
                        <th scope="row" class="bl">IRB 승인일</th>
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
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">IRB 결과심의</th>
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
                        </td>
                        <th scope="row" class="bl">IRB 계획심의</th>
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
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- //IRB 심의정보 -->
            <!-- 서브타이틀 -->
            <div class="sub_title_area">
                <h4>첨부파일</h4>
            </div>
            <!-- //서브타이틀 -->
            <!-- 첨부파일 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">IRB신규계획서</th>
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
                        <th scope="row" class="bl">IRB결과보고서</th>
                        <td>
                            <div class="attach_sec">
                            	<input type="file" id="in_file02" />
                            	<label for="in_file02" class="btn_sub">파일업로드</label>
                            	<div>
                            		<span>파일명.jpg</span>
                            		<a href="#">삭제</a>
                            	</div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">승인통보서</th>
                        <td>
                            <div class="attach_sec">
                            	<input type="file" id="in_file03" />
                            	<label for="in_file03" class="btn_sub">파일업로드</label>
                            	<div>
                            		<span>파일명.jpg</span>
                            		<a href="#">삭제</a>
                            	</div>
                            </div>
                        </td>
                        <th scope="row" class="bl">보완통보서</th>
                        <td>
                            <div class="attach_sec">
                            	<input type="file" id="in_file04" />
                            	<label for="in_file04" class="btn_sub">파일업로드</label>
                            	<div>
                            		<span>파일명.jpg</span>
                            		<a href="#">삭제</a>
                            	</div>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- //첨부파일 -->
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