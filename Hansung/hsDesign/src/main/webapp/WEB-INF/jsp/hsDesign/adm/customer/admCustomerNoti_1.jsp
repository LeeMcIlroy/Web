<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<body>
	<div class="wrap">
		<!-- 스킵 네비게이션 -->
		<div id="skip_navigation">
			<ul>
				<li><a href="#gnb">주 메뉴 바로가기</a></li>
				<li><a href="#content">본문 바로가기</a></li>
			</ul>
		</div>
		<!-- header -->
		<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav" />
		<!--// header -->
		<hr />
		<p class="container_top_bg"></p>
		<!-- container -->
		<div class="container">
			<!-- lnb -->
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<!--// lnb -->
			<!-- content -->
			<div class="content" id="content">
				<!-- 타이틀 영역 -->
				<c:import url="/EgovPageLink.do?link=adm/inc/incPageTitle">
					<c:param name="dept1" value="전공"/>
					<c:param name="dept2" value="고객센터"/>
				</c:import>
				<div class="cont_box">
				<!-- content -->
					<!-- table -->
					<table class="view_tbl_03 mb30 mt30" summary="고객센터">
						<caption>고객센터</caption>
						<colgroup>
							<col width="13%" />
							<col width="20%" />
							<col width="13%" />
							<col width="20%" />
							<col width="14%" />
							<col width="20%" />
						</colgroup>
						<tbody>
							<tr class="first">
								<th scope="row" colspan="6">"The requested URL was rejected. ..." 화면 관련</th>
							</tr>
							<tr>
								<th scope="row">작성자</th>
								<td>테스트관리자</td>
								<th scope="row">작성일</th>
								<td>2017-12-08</td>
								<th scope="row">조회수</th>
								<td>-</td>
							</tr>
							<tr>
								<td colspan="6">
									<p><br/><img src="${pageContext.request.contextPath }/assets/adm/img/security_img.jpg" /></p>
									<p><br/>위와 같은 메세지는 한성대 보안장비에서 외부침입공격으로 간주하여 접근을 막으면서 생기는 현상입니다.</p>
									<p><br/><strong>현재(2017-12-08 12:00) 작업완료</strong>하여 위와 같은 현상은 발생하지 않습니다.</p>
									<p><br/>그러나 동일한 현상이 발생한다면 <strong>접근 URL 정보와 전후 화면 이미지를 캡쳐해서 글을 등록해주세요.</strong></p>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="btn_box">
						<div class="btn_r">
							<a href="javascript:history.back(-1);" class="b_type03">목록</a>
						</div>
					</div>
				<!-- //content -->
				</div>
			</div>
			<!--// content -->
		</div>
		<!--// container -->
		<hr />
		<!-- footer -->
		<c:import url="/EgovPageLink.do?link=adm/inc/incFooter" />
		<!--// footer -->
	</div>
</body>
</html>