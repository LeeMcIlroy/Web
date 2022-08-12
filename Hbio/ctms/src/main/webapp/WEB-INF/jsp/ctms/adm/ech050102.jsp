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
		<h2>보고서</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="보고서"/>
	            <jsp:param name="dept2" value="보고서관리"/>
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
                    <tr>
                        <th scope="row">IRB계획심의</th>
                        <td>0000-00-00</td>
                        <th scope="row" class="bl">IRB결과심의</th>
                        <td>0000-00-00</td>
                    </tr>
                    <tr>
                        <th scope="row">IRB승인일</th>
                        <td>0000-00-00</td>
                        <th scope="row" class="bl">심의상태</th>
                        <td>완료</td>
                    </tr>
                </tbody>
            </table>
            <!-- //연구정보 -->
            <!-- 서브타이틀 -->
            <div class="sub_title_area">
                <h4>보고서 관리</h4>
            </div>
            <!-- //서브타이틀 -->
            <!-- 보고서 관리 -->
            <table class="tbl_view">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">연구이미지</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file01" />
                            	<label for="in_file01" class="btn_sub">파일업로드</label>
                            	<div>
                            		<span>파일명.jpg</span>
                            		<a href="#">삭제</a>
                            	</div>
                            	<p>등록일 2020-01-01</p>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">연구계획서</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file02" />
                            	<label for="in_file02" class="btn_sub">파일업로드</label>
                            	<div>
                            		<span>파일명.jpg</span>
                            		<a href="#">삭제</a>
                            	</div>
                            	<p>등록일 2020-01-01</p>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><i>*</i>초안보고서</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file03" />
                            	<label for="in_file03" class="btn_sub">파일업로드</label>
                            	<div>
                            		<span>파일명.jpg</span>
                            		<a href="#">삭제</a>
                            	</div>
                            	<p>등록일 2020-01-01</p>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><i>*</i>최종보고서</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file04" />
                            	<label for="in_file04" class="btn_sub">파일업로드</label>
                            	<div>
                            		<span>파일명.jpg</span>
                            		<a href="#">삭제</a>
                            	</div>
                            	<p>등록일 2020-01-01</p>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">최종요약문</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file05" />
                            	<label for="in_file05" class="btn_sub">파일업로드</label>
                            	<div>
                            		<span>파일명.jpg</span>
                            		<a href="#">삭제</a>
                            	</div>
                            	<p>등록일 2020-01-01</p>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">국문보고서</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file06" />
                            	<label for="in_file06" class="btn_sub">파일업로드</label>
                            	<div>
                            		<span>파일명.jpg</span>
                            		<a href="#">삭제</a>
                            	</div>
                            	<p>등록일 2020-01-01</p>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">영문보고서</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file07" />
                            	<label for="in_file07" class="btn_sub">파일업로드</label>
                            	<div>
                            		<span>파일명.jpg</span>
                            		<a href="#">삭제</a>
                            	</div>
                            	<p>등록일 2020-01-01</p>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">기타1</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file08" />
                            	<label for="in_file08" class="btn_sub">파일업로드</label>
                            	<div>
                            		<span>파일명.jpg</span>
                            		<a href="#">삭제</a>
                            	</div>
                            	<p>등록일 2020-01-01</p>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">기타2</th>
                        <td colspan="3">
                            <div class="attach_sec type02">
                            	<input type="file" id="in_file09" />
                            	<label for="in_file09" class="btn_sub">파일업로드</label>
                            	<div>
                            		<span>파일명.jpg</span>
                            		<a href="#">삭제</a>
                            	</div>
                            	<p>등록일 2020-01-01</p>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- //보고서 관리 -->
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