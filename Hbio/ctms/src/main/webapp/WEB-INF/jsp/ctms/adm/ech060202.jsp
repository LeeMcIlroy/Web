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
		<h2>발송관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="발송관리"/>
	            <jsp:param name="dept2" value="이메일발송내역"/>
           	</jsp:include>
			<div class="title_area">
				<h3>이메일발송내역</h3>
				<!-- 현재위치 -->
				<div class="breadcrumb">
					<a href="#">홈</a>
					<span>&gt;</span>
					발송관리
					<span>&gt;</span>
					이메일발송내역
				</div>
			</div>
			<!-- //타이틀 -->
            <!-- 발송내용 -->
            <table class="tbl_view mb03">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:85%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">연구선택</th>
                        <td>HBSE-MLG-20057-1  연구명이 들어갑니다.</td>
                    </tr>
                    <tr>
                        <th scope="row">첨부보고서</th>
                        <td>연구이미지, 연구계획서</td>
                    </tr>
                </tbody>
            </table>
            <table class="tbl_view mb03">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:85%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">받는사람 이메일</th>
                        <td>
                        	hong@naver.com, hong2@naver.com                 	
                        </td>
                    </tr>
                </tbody>
            </table>
            <table class="tbl_view mb03">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">발송상태</th>
                        <td>예약 2020-01-11 18:00</td>
                        <th scope="row" class="bl">발송구분</th>
                        <td>메일,  SMS</td>                       
                    </tr>
                    <tr>
                        <th scope="row">발송제목</th>
                        <td colspan="3">발송제목이 들어갑니다.</td>
                    </tr>
                    <tr>
                        <th scope="row">내용</th>
                        <td colspan="3">
                        	발송내용      	
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">첨부파일</th>
                        <td colspan="3">
                        	<a href="#">파일명.jpg</a>
                        </td>
                    </tr>
                </tbody>
            </table>
            <table class="tbl_view mb03">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:85%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">핸드폰 번호</th>
                        <td>
                       		010-0000-0000, 010-5234-2124
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">메시지</th>
                        <td>
                       		발송내용
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- //발송내용 -->
			<!-- 버튼 -->
			<div class="btn_area">
				<a href="#" class="type02">취소</a>
				<a href="#">수정</a>
				<a href="#">재발송</a>
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