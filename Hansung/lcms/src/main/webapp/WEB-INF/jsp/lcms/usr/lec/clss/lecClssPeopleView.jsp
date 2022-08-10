<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     	uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>

<script>
	$(function(){

		/* 클릭 클릭시 클릭을 클릭한 위치 근처에 레이어가 나타난다. */
		$('.imgSelect').click(function(e)
		{
			var sWidth = window.innerWidth;
			var sHeight = window.innerHeight;

			var oWidth = $('.popupLayer').width();
			var oHeight = $('.popupLayer').height();

			// 레이어가 나타날 위치를 셋팅한다.
			var divLeft = e.clientX + 10;
			var divTop = e.clientY + 5;

			// 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
			if( divLeft + oWidth > sWidth ) divLeft -= oWidth;
			if( divTop + oHeight > sHeight ) divTop -= oHeight;

			// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치하자.
			if( divLeft < 0 ) divLeft = 0;
			if( divTop < 0 ) divTop = 0;

			$('.popupLayer').css({
				"top": divTop,
				"left": divLeft,
				"position": "absolute"
			}).show();
		});
	});
</script>
<style>
.stdView-layout th
	{
		font-weight : bold;
		font-size : 13px;
		text-align : center;
		border : 1px solid black;
		padding: 10px;
		word-break:break-all;
	}	
.stdView-layout td
	{
		text-align : center;
		border : 1px solid black;
		padding: 10px;
		word-break:break-all;
	}	
.stdView-layout th:nth-child(1){border-left : 0;}
.stdView-layout td:nth-child(1){border-left : 0;}
.stdView-layout th:last-child{border-right : 0;}
.stdView-layout td:last-child{border-right : 0;}
</style>
<body>
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnavLec"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenuLec"/>
			<!--// left menu -->
			<div class="main-content">
				<div class="title-area">
					<p class="page-lv01">학생상세보기</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>강의실</span>
						<span>수업</span>
						<span>수강인원</span>
					</div>
				</div>
				<form:form commandName="memberVO" id="frm" name="frm">
				<form:hidden path="memberSeq"/>
				<!-- 기본정보 -->
				<p class="sub-title">기본정보</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:40%;" />
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>학번</th>
								<td>
									<c:out value="${memberVO.memberCode }" />
								</td>
								<th>급수</th>
								<td>
									<c:out value="${memberVO.step }" />급
								</td>
								<td rowspan="4">
									<div id="attachFile" style="text-align: center; margin-top: 15px;"><img src="<c:url value='/showImage.do?filePath=${memberVO.imgPath}'/>"  alt="<c:out value="${memberVO.imgName}"/>" style="width:113px; height:151px; text-align: center;"/></div>
								</td>
							</tr>
							<tr>
								<th>성명</th>
								<td>
									<c:out value="${memberVO.name }" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<c:out value="${memberVO.eName }" />
								</td>
								<th>상태</th>
								<td>
									<c:out value="${memberVO.status }" />
								</td>
							</tr>
							<tr>
								<th>생년월일</th>
								<td>
									<c:out value="${memberVO.birthYear }" />-<c:out value="${memberVO.birthMonth }" />-<c:out value="${memberVO.birthDay }" />
								</td>
								<th>성별</th>
								<td>
									<c:out value="${memberVO.gender }" />
								</td>
							</tr>
							<tr>
								<th>국적</th>
								<td>
									<c:out value="${memberVO.nation }" />
								</td>
								<th>출생국</th>
								<td>
									<c:out value="${memberVO.depart }" />
								</td>
							</tr>
							<tr>
								<th>과정</th>
								<td>
									<c:out value="${memberVO.stdCurr }" />
								</td>
								<th>학생구분</th>
								<td colspan="2">
									<c:choose>
										<c:when test="${memberVO.stdType eq 1}">교환학생</c:when>
										<c:when test="${memberVO.stdType eq 2}">한국어교육과정생(어학연수생)</c:when>
										<c:when test="${memberVO.stdType eq 3}">학부(유학생)</c:when>
										<c:when test="${memberVO.stdType eq 4}">대학원(유학생)</c:when>
									</c:choose>
								</td>
							</tr>
							<tr>
								<th>입학일자</th>
								<td>
									<c:out value="${memberVO.appDate }" />
								</td>
								<th>TOPIK취득</th>
								<td>
									<c:if test="${!empty memberVO.tpStep || memberVO.tpStep eq '' }">
										<c:out value="${memberVO.tpStep }" />급 <c:out value="${memberVO.tpScore }" />점  취득일자 : <c:out value="${memberVO.tpDate }" />
									</c:if>
								</td>
							</tr>
							<tr>
								<th>수강현황</th>
								<td colspan="4">
									<c:forEach items="${lectList }" var="lect">
										<p>
											<c:out value="${lect.lectYear }년"/>&nbsp;
											<c:out value="${lect.lectSem }"/>&nbsp;
											<c:out value="${lect.lectName }"/>&nbsp;
											<c:out value="${lect.lectDivi }"/>&nbsp;/&nbsp;
											<c:out value="${lect.grade }급"/>&nbsp;
											<c:out value="${lect.compleSta }"/>
										</p>
									</c:forEach>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="mob mb20">
					<div class="mob-write">
						<dl>
							<dd>
								<div id="attachFile" style="text-align: center; margin-top: 15px;"><img src="<c:url value='/showImage.do?filePath=${memberVO.imgPath}'/>"  alt="<c:out value="${memberVO.imgName}"/>" style="width:113px; height:151px; text-align: center; margin-right: 110px;"/></div>
							</dd>
						</dl>
						<dl>
							<dt>학번</dt>
							<dd>
								<c:out value="${memberVO.memberCode }" />&nbsp;
							</dd>
						</dl>
						<dl>
							<dt>급수</dt>
							<dd>
								<c:out value="${memberVO.step }" />급&nbsp;
							</dd>
						</dl>
						<dl>
							<dt>성명</dt>
							<dd>
								<c:out value="${memberVO.name }" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<c:out value="${memberVO.eName }" />&nbsp;
							</dd>
						</dl>
						<dl>
							<dt>상태</dt>
							<dd>
								<c:out value="${memberVO.status }" />&nbsp;
							</dd>
						</dl>
						<dl>
							<dt>생년월일</dt>
							<dd>
								<c:out value="${memberVO.birthYear }" />-<c:out value="${memberVO.birthMonth }" />-<c:out value="${memberVO.birthDay }" />&nbsp;
							</dd>
						</dl>
						<dl>
							<dt>성별</dt>
							<dd>
								<c:out value="${memberVO.gender }" />&nbsp;
							</dd>
						</dl>
						<dl>
							<dt>국적</dt>
							<dd>
								<c:out value="${memberVO.nation }" />&nbsp;
							</dd>
						</dl>
						<dl>
							<dt>출생국</dt>
							<dd>
								<c:out value="${memberVO.depart }" />&nbsp;
							</dd>
						</dl>
						<dl>
							<dt>과정</dt>
							<dd>
								<c:out value="${memberVO.stdCurr }" />&nbsp;
							</dd>
						</dl>
						<dl>
							<dt>학생구분</dt>
							<dd>
								<c:choose>
									<c:when test="${memberVO.stdType eq 1}">교환학생</c:when>
									<c:when test="${memberVO.stdType eq 2}">한국어교육과정생(어학연수생)</c:when>
									<c:when test="${memberVO.stdType eq 3}">학부(유학생)</c:when>
									<c:when test="${memberVO.stdType eq 4}">대학원(유학생)</c:when>
								</c:choose>
								&nbsp;
							</dd>
						</dl>
						<dl>
							<dt>입학일자</dt>
							<dd>
								<c:out value="${memberVO.appDate }" />&nbsp;
							</dd>
						</dl>
						<dl>
							<dt>TOPIK취득</dt>
							<dd>
								<c:if test="${!empty memberVO.tpStep || memberVO.tpStep eq '' }">
									<c:out value="${memberVO.tpStep }" />급 <c:out value="${memberVO.tpScore }" />점  취득일자 : <c:out value="${memberVO.tpDate }" />&nbsp;
								</c:if>
								&nbsp;
							</dd>
						</dl>
						<dl>
							<dt>수강현황</dt>
							<dd>
								<c:forEach items="${lectList }" var="lect">
									<p>
										<c:out value="${lect.lectYear }년"/>&nbsp;
										<c:out value="${lect.lectSem }"/>&nbsp;
										<c:out value="${lect.lectName }"/>&nbsp;
										<c:out value="${lect.lectDivi }"/>&nbsp;/&nbsp;
										<c:out value="${lect.grade }급"/>&nbsp;
										<c:out value="${lect.compleSta }"/>
									</p>
								</c:forEach>
								&nbsp;
							</dd>
						</dl>
					</div>
				</div>
				<!-- //기본정보 -->
<!-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
				<!-- 학력사항 -->
				<p class="sub-title">학력사항</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:40%;" />
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>최종학력</th>
								<td>
									<c:out value="${memberVO.finalEdu }" />
								</td>
								<th>학교명</th>
								<td>
									<c:out value="${memberVO.feSchoolname }" />
								</td>
							</tr>
							<tr>
								<th>국가</th>
								<td>
									<c:out value="${memberVO.feCountry }" />
								</td>
								<th>재학기간</th>
								<td>
									<c:out value="${memberVO.feDateS }" /> ~ <c:out value="${memberVO.feDateE }" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="mob mb20">
					<div class="mob-write">
						<dl>
							<dt>최종학력</dt>
							<dd>
								<c:out value="${memberVO.finalEdu }" />&nbsp;
							</dd>
						</dl>
						<dl>
							<dt>학교명</dt>
							<dd>
								<c:out value="${memberVO.feSchoolname }" />&nbsp;
							</dd>
						</dl>
						<dl>
							<dt>국가</dt>
							<dd>
								<c:out value="${memberVO.feCountry }" />&nbsp;
							</dd>
						</dl>
						<dl>
							<dt>재학기간</dt>
							<dd>
								<c:out value="${memberVO.feDateS }" /> ~ <c:out value="${memberVO.feDateE }" />&nbsp;
							</dd>
						</dl>
					</div>
				</div>
				<!-- //학력사항 -->
<!-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
				<!-- 연수계획 -->
				<p class="sub-title">연수계획</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:40%;" />
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>한국어 연수경험</th>
								<td>
									<c:choose>
										<c:when test="${memberVO.trExperience eq 'N'}">연수경험 없음</c:when>
										<c:when test="${memberVO.trExperience eq 'Y'}">연수경험 있음</c:when>
									</c:choose>
								<c:out value="" />
								</td>
								<th>프로그램 인지경로</th>
								<td>
									<c:choose>
										<c:when test="${memberVO.trGetpath eq '1'}">한성대학 학생</c:when>
										<c:when test="${memberVO.trGetpath eq '2'}">지인(친구,가족등)</c:when>
										<c:when test="${memberVO.trGetpath eq '3'}">홈페이지</c:when>
										<c:when test="${memberVO.trGetpath eq '4'}">팸플릿</c:when>
										<c:when test="${memberVO.trGetpath eq '5'}">기타</c:when>
									</c:choose>
								</td>
							</tr>
							<tr>
								<th>연수 예정기간</th>
								<td colspan="3">
									<c:out value="${memberVO.trTerm }" />개 학기
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="mob mb20">
					<div class="mob-write">
						<dl>
							<dt style="font-size:12px;">한국어연수경험</dt>
							<dd>
								<c:choose>
									<c:when test="${memberVO.trExperience eq 'N'}">연수경험 없음</c:when>
									<c:when test="${memberVO.trExperience eq 'Y'}">연수경험 있음</c:when>
								</c:choose>
							<c:out value="" />
							&nbsp;
							</dd>
						</dl>
						<dl>
							<dt style="font-size:12px;">프로그램인지경로</dt>
							<dd>
								<c:choose>
									<c:when test="${memberVO.trGetpath eq '1'}">한성대학 학생</c:when>
									<c:when test="${memberVO.trGetpath eq '2'}">지인(친구,가족등)</c:when>
									<c:when test="${memberVO.trGetpath eq '3'}">홈페이지</c:when>
									<c:when test="${memberVO.trGetpath eq '4'}">팸플릿</c:when>
									<c:when test="${memberVO.trGetpath eq '5'}">기타</c:when>
								</c:choose>
								&nbsp;
							</dd>
						</dl>
						<dl>
							<dt>연수 예정기간</dt>
							<dd>
								<c:out value="${memberVO.trTerm }" />개 학기&nbsp;
							</dd>
						</dl>
					</div>
				</div>
				<!-- //연수계획 -->
<!-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
				<!-- 연락처 -->
				<p class="sub-title">연락처</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:10%;" />
							<col style="width:35%;" />
							<col style="width:10%;" />
							<col style="width:35%;" />
						</colgroup>
						<tbody>
							<tr>
								<th>개인연락처</th>
								<td class="txt-c">SNS</td>
								<td colspan="3">
									<c:out value="${memberVO.naSns }" />
								</td>
							</tr>
							<tr>
								<th rowspan="2">본국</th>
								<td class="txt-c">전화번호</td>
								<td colspan="3">
									<c:out value="${memberVO.naTel }" />
								</td>
							</tr>
							<tr>
								<td class="txt-c">주소</td>
								<td colspan="3">
									<c:out value="${memberVO.naAddr }" />
								</td>
							</tr>
							<tr>
								<th rowspan="2">국내 주소</th>
								<td class="txt-c">전화번호</td>
								<td>
									<c:out value="${memberVO.tel }" />
								</td>
								<th>이메일</th>
								<td>
								<c:out value="${memberVO.email }" />
								</td>
							</tr>
							<tr>
								<td class="txt-c">주소<br />(현거주지)</td>
								<td colspan="3">
									<c:out value="${memberVO.post }" /> <br>
									<c:out value="${memberVO.addr1 }" /> <c:out value="${memberVO.addr2 }" />
								</td>
							</tr>
							<tr>
								<th rowspan="3">비상시 연락처</th>
								<td class="txt-c">이름</td>
								<td>
									<c:out value="${memberVO.emerName }" />
								</td>
								<th>관계</th>
								<td>
									<c:out value="${memberVO.emerRelation }" />
								</td>
							</tr>
							<tr>
								<td class="txt-c">전화번호</td>
								<td>
									<c:out value="${memberVO.telEmer }" />
								</td>
								<th>이메일</th>
								<td>
									<c:out value="${memberVO.emailEmer }" />
								</td>
							</tr>
							<tr>
								<td class="txt-c">주소</td>
								<td colspan="3">
									<c:out value="${memberVO.postEmer }" /><br>
									<c:out value="${memberVO.addr1Emer }" /> <c:out value="${memberVO.addr2Emer }" />
								</td>
							</tr>
							<tr>
								<th rowspan="3">국내 신원보증인</th>
								<td class="txt-c">이름</td>
								<td>
									<c:out value="${memberVO.guarName }" />
								</td>
								<th>관계</th>
								<td>
									<c:out value="${memberVO.guarRelation }" />
								</td>
							</tr>
							<tr>
								<td class="txt-c">전화번호</td>
								<td>
									<c:out value="${memberVO.telGuar }" />
								</td>
								<th>이메일</th>
								<td>
									<c:out value="${memberVO.emailGuar }" />
								</td>
							</tr>
							<tr>
								<td class="txt-c">주소</td>
								<td colspan="3">
									<c:out value="${memberVO.postGuar }" /><br>
									<c:out value="${memberVO.addr1Guar }" /> <c:out value="${memberVO.addr2Guar }" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="mob mb20">
					<div class="mob-write">
						<dl>
							<dt style="width:105%; text-align: left; padding-left: 13px;">&lt;개인연락처&gt;</dt>
							<dd>&nbsp;</dd>
						</dl>
						<dl>
							<dt>SNS</dt>
							<dd><c:out value="${memberVO.naSns }" />&nbsp;</dd>
						</dl>
						<dl>
							<dt style="width:105%; text-align: left; padding-left: 13px;">&lt;본국&gt;</dt>
							<dd>&nbsp;</dd>
						</dl>
						<dl>
							<dt>전화번호</dt>
							<dd><c:out value="${memberVO.naTel }" />&nbsp;</dd>
						</dl>
						<dl>
							<dt>주소</dt>
							<dd><c:out value="${memberVO.naAddr }" />&nbsp;</dd>
						</dl>
						<dl>
							<dt style="width:105%; text-align: left; padding-left: 13px;">&lt;국내 주소&gt;</dt>
							<dd>&nbsp;</dd>
						</dl>
						<dl>
							<dt>전화번호</dt>
							<dd><c:out value="${memberVO.tel }" />&nbsp;</dd>
						</dl>
						<dl>
							<dt>이메일</dt>
							<dd><c:out value="${memberVO.email }" />&nbsp;</dd>
						</dl>
						<dl>
							<dt>주소 <br> (현거주지)</dt>
							<dd>
								<c:out value="${memberVO.post }" /> <br>
								<c:out value="${memberVO.addr1 }" /> <c:out value="${memberVO.addr2 }" />&nbsp;
							</dd>
						</dl>
						<dl>
							<dt style="width:105%; text-align: left; padding-left: 13px;">&lt;비상시 연락처&gt;</dt>
							<dd>&nbsp;</dd>
						</dl>
						<dl>
							<dt>이름</dt>
							<dd><c:out value="${memberVO.emerName }" />&nbsp;</dd>
						</dl>
						<dl>
							<dt>관계</dt>
							<dd><c:out value="${memberVO.emerRelation }" />&nbsp;</dd>
						</dl>
						<dl>
							<dt>전화번호</dt>
							<dd><c:out value="${memberVO.telEmer }" />&nbsp;</dd>
						</dl>
						<dl>
							<dt>이메일</dt>
							<dd><c:out value="${memberVO.emailEmer }" />&nbsp;</dd>
						</dl>
						<dl>
							<dt>주소</dt>
							<dd>
								<c:out value="${memberVO.postEmer }" /><br>
								<c:out value="${memberVO.addr1Emer }" /> <c:out value="${memberVO.addr2Emer }" />&nbsp;
							</dd>
						</dl>
						<dl>
							<dt style="width:105%; text-align: left; padding-left: 13px;">&lt;국내신원보증인&gt;</dt>
							<dd>&nbsp;</dd>
						</dl>
						<dl>
							<dt>이름</dt>
							<dd><c:out value="${memberVO.guarName }" />&nbsp;</dd>
						</dl>
						<dl>
							<dt>관계</dt>
							<dd><c:out value="${memberVO.guarRelation }" />&nbsp;</dd>
						</dl>
						<dl>
							<dt>전화번호</dt>
							<dd><c:out value="${memberVO.telGuar }" />&nbsp;</dd>
						</dl>
						<dl>
							<dt>이메일</dt>
							<dd><c:out value="${memberVO.emailGuar }" />&nbsp;</dd>
						</dl>
						<dl>
							<dt>주소</dt>
							<dd>
								<c:out value="${memberVO.postGuar }" /><br>
								<c:out value="${memberVO.addr1Guar }" /> <c:out value="${memberVO.addr2Guar }" />&nbsp;
							</dd>
						</dl>
					</div>
				</div>
				<!-- //연락처 -->
<!-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
				<!-- 학적정보 -->
				<p class="sub-title">학적정보</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col width="7%" />
							<col  />
							<col  />
							<col  />
							<col  />
							<col  />
							<col  />
						</colgroup>
						<tbody>
							<tr>
								<th>No.</th>
								<th>학기</th>
								<th>급/반</th>
								<th>성적</th>
								<th>출석율(%)</th>
								<th>급수</th>
								<th>수료</th>
							</tr>
							<c:forEach var="result" items="${regiList }" varStatus="status">
								<tr>
									<td class="txt-c"><c:out value="${regiList.size()-status.index}"/></td>
									<td class="txt-c">
										<c:if test="${result.lectYear ne '' }">
											<c:out value="${result.lectYear }"/>년 <c:out value="${result.lectSem }"/>
										</c:if>
									</td>
									<td class="txt-c">
										<c:set var = "string1" value = "${result.lectName }"/>
									    <c:set var = "length" value = "${fn:length(string1)}"/>
									    <c:set var = "string2" value = "${fn:substring(string1, length -1, length)}" />
									    <c:if test="${string2.matches('[0-9]+') }">
									    	<c:out value="${string2 }"/>급
									    </c:if>
									    <c:if test="${!string2.matches('[0-9]+') }">
									    	1급
									    </c:if>
										<c:if test="${result.lectName ne '' && result.lectDivi ne ''}">/</c:if>
										<c:out value="${result.lectDivi }"/>
									</td>
									<td class="txt-c"><c:out value="${result.finals eq null?'':(result.midterm+result.finals)/2 }"/></td>
									<td class="txt-c"><c:out value="${result.gradeAttnd }"/></td>
									<td class="txt-c"><c:out value="${result.grade }"/>급</td>
									<td class="txt-c"><c:out value="${result.compleSta }"/></td>
								</tr>
							</c:forEach>
							<c:if test="${empty regiList }">
								<tr>
									<td colspan="7">학적정보가 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
				<div class="mob mb20">
					<div class="mob-write">
						<table class="normal-wmv-table">
						<colgroup>
							<col width="7%" />
							<col  />
							<col  />
							<col  />
							<col  />
							<col  />
							<col  />
						</colgroup>
						<tbody class="stdView-layout">
							<tr>
								<th>No.</th>
								<th>학기</th>
								<th>급/반</th>
								<th>성적</th>
								<th>출석율(%)</th>
								<th>급수</th>
								<th>수료</th>
							</tr>
							<c:forEach var="result" items="${regiList }" varStatus="status">
								<tr>
									<td><c:out value="${regiList.size()-status.index}"/></td>
									<td>
										<c:if test="${result.lectYear ne '' }">
											<c:out value="${result.lectYear }"/>년 <c:out value="${result.lectSem }"/>
										</c:if>
									</td>
									<td>
										<c:set var = "string1" value = "${result.lectName }"/>
									    <c:set var = "length" value = "${fn:length(string1)}"/>
									    <c:set var = "string2" value = "${fn:substring(string1, length -1, length)}" />
									    <c:if test="${string2.matches('[0-9]+') }">
									    	<c:out value="${string2 }"/>급
									    </c:if>
									    <c:if test="${!string2.matches('[0-9]+') }">
									    	1급
									    </c:if>
										<c:if test="${result.lectName ne '' && result.lectDivi ne ''}">/</c:if>
										<c:out value="${result.lectDivi }"/>
									</td>
									<td><c:out value="${result.finals eq null?'':(result.midterm+result.finals)/2 }"/></td>
									<td><c:out value="${result.gradeAttnd }"/></td>
									<td><c:out value="${result.grade }"/>급</td>
									<td><c:out value="${result.compleSta }"/></td>
								</tr>
							</c:forEach>
							<c:if test="${empty regiList }">
								<tr>
									<td colspan="7">학적정보가 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
					</div>
				</div>
				<!-- //학적정보 -->
<!-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
				<!-- 성적정보 -->
				<p class="sub-title">성적정보</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col width="7%" />
							<col  />
							<col  />
							<col  />
							<col  />
							<col  />
							<col  />
							<col  />
						</colgroup>
						<tbody>
							<tr>
								<th rowspan="3">No.</th>
								<th rowspan="3">학기</th>
								<th rowspan="3">급/반</th>
								<th colspan="4">영역별 평균</th>
								<th rowspan="3">평균</th>
							</tr>
							<tr>
								<th colspan="2">표현능력</th>
								<th colspan="2">이해능력</th>
							</tr>
							<tr>
								<th>말하기</th>
								<th>쓰기</th>
								<th>듣기</th>
								<th>읽기</th>
							</tr>
							<c:forEach var="result" items="${gradeList }" varStatus="status">
								<tr>
									<td class="txt-c"><c:out value="${gradeList.size()-status.index}"/></td>
									<td class="txt-c">
										<c:if test="${result.lectYear ne '' }">
											<c:out value="${result.lectYear }"/>년 <c:out value="${result.lectSem }"/>
										</c:if>
									</td>
									<td class="txt-c">
										<c:set var = "string1" value = "${result.lectName }"/>
									    <c:set var = "length" value = "${fn:length(string1)}"/>
									    <c:set var = "string2" value = "${fn:substring(string1, length -1, length)}" />
									    <c:if test="${string2.matches('[0-9]+') }">
									    	<c:out value="${string2 }"/>급
									    </c:if>
									    <c:if test="${!string2.matches('[0-9]+') }">
									    	1급
									    </c:if>
										<c:out value="${result.lectDivi }"/>
									</td>
									<td class="txt-c" style="<c:out value='${result.avgSpeak < 60?"color:#fc6039":"" }'/>"><c:out value="${result.avgSpeak }"/></td>
									<td class="txt-c" style="<c:out value='${result.avgWrite < 60?"color:#fc6039":"" }'/>"><c:out value="${result.avgWrite }"/></td>
									<td class="txt-c" style="<c:out value='${result.avgListen < 60?"color:#fc6039":"" }'/>"><c:out value="${result.avgListen }"/></td>
									<td class="txt-c" style="<c:out value='${result.avgRead < 60?"color:#fc6039":"" }'/>"><c:out value="${result.avgRead }"/></td>
									<td class="txt-c" style="<c:out value='${result.avgTotal < 70?"color:#fc6039":"" }'/>"><c:out value="${result.avgTotal }"/></td>
								</tr>
							</c:forEach>
							<c:if test="${empty gradeList }">
								<tr>
									<td colspan="8">성적정보가 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
				<div class="mob mb20">
					<div class="mob-write">
						<table class="normal-wmv-table">
							<colgroup>
								<col width="7%" />
								<col  />
								<col  />
								<col  />
								<col  />
								<col  />
								<col  />
								<col  />
							</colgroup>
							<tbody class="stdView-layout">
								<tr>
									<th rowspan="3">No.</th>
									<th rowspan="3">학기</th>
									<th rowspan="3">급/반</th>
									<th colspan="4">영역별 평균</th>
									<th rowspan="3">평균</th>
								</tr>
								<tr>
									<th colspan="2">표현능력</th>
									<th colspan="2">이해능력</th>
								</tr>
								<tr>
									<th>말하기</th>
									<th>쓰기</th>
									<th>듣기</th>
									<th>읽기</th>
								</tr>
								<c:forEach var="result" items="${gradeList }" varStatus="status">
									<tr>
										<td><c:out value="${gradeList.size()-status.index}"/></td>
										<td>
											<c:if test="${result.lectYear ne '' }">
												<c:out value="${result.lectYear }"/>년 <c:out value="${result.lectSem }"/>
											</c:if>
										</td>
										<td>
											<c:set var = "string1" value = "${result.lectName }"/>
										    <c:set var = "length" value = "${fn:length(string1)}"/>
										    <c:set var = "string2" value = "${fn:substring(string1, length -1, length)}" />
										    <c:if test="${string2.matches('[0-9]+') }">
										    	<c:out value="${string2 }"/>급
										    </c:if>
										    <c:if test="${!string2.matches('[0-9]+') }">
										    	1급
										    </c:if>
											<c:out value="${result.lectDivi }"/>
										</td>
										<td style="<c:out value='${result.avgSpeak < 60?"color:#fc6039":"" }'/>"><c:out value="${result.avgSpeak }"/></td>
										<td style="<c:out value='${result.avgWrite < 60?"color:#fc6039":"" }'/>"><c:out value="${result.avgWrite }"/></td>
										<td style="<c:out value='${result.avgListen < 60?"color:#fc6039":"" }'/>"><c:out value="${result.avgListen }"/></td>
										<td style="<c:out value='${result.avgRead < 60?"color:#fc6039":"" }'/>"><c:out value="${result.avgRead }"/></td>
										<td style="<c:out value='${result.avgTotal < 70?"color:#fc6039":"" }'/>"><c:out value="${result.avgTotal }"/></td>
									</tr>
								</c:forEach>
								<c:if test="${empty gradeList }">
									<tr>
										<td colspan="8">성적정보가 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</div>
				</div>
				<!-- //성적정보 -->
<!-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
				<!-- 상담정보 -->
				<p class="sub-title">상담정보</p>
				<!-- table -->
				<c:forEach var="result" items="${consulList }">
					<div class="list-table-box web">
						<table class="normal-wmv-table">
							<colgroup>
								<col width="15%" />
								<col width="35%" />
								<col width="15%" />
								<col width="35%" />
							</colgroup>
							<tbody>
								<tr>
									<th>상담일자</th>
									<td><c:out value="${result.consultdate }"/></td>
									<th>상담자</th>
									<td><c:out value="${result.profcode }"/></td>
								</tr>
								<tr>
									<th>상담구분</th>
									<td><c:out value="${result.consulttype }"/></td>
									<th>상담장소</th>
									<td><c:out value="${result.place }"/></td>
								</tr>
								<tr>
									<th>상담내용</th>
									<td colspan="3"><c:out value="${result.content }" escapeXml="false"/></td>
								</tr>
							</tbody>
						</table>
					</div>
				</c:forEach>
				<c:if test="${empty consulList }">
					<div class="list-table-box web">
						<table class="normal-wmv-table">
							<colgroup>
								<col width="15%" />
								<col width="35%" />
								<col width="15%" />
								<col width="35%" />
							</colgroup>
							<tbody>
								<tr>
									<th>상담일자</th><td></td>
									<th>상담자</th><td></td>
								</tr>
								<tr>
									<th>상담구분</th><td></td>
									<th>상담장소</th><td></td>
								</tr>
								<tr>
									<th>상담내용</th><td colspan="3">상담정보가 없습니다.</td>
								</tr>
							</tbody>
						</table>
					</div>
				</c:if>
				<div class="mob mb20">
					<c:forEach var="result" items="${consulList }">
						<div class="mob-write">
							<table class="normal-wmv-table">
								<colgroup>
									<col width="15%" />
									<col width="35%" />
									<col width="15%" />
									<col width="35%" />
								</colgroup>
								<tbody class="stdView-layout">
									<tr>
										<th>상담일자</th>
										<td><c:out value="${result.consultdate }"/></td>
										<th>상담자</th>
										<td><c:out value="${result.profcode }"/></td>
									</tr>
									<tr>
										<th>상담구분</th>
										<td><c:out value="${result.consulttype }"/></td>
										<th>상담장소</th>
										<td><c:out value="${result.place }"/></td>
									</tr>
									<tr>
										<th>상담내용</th>
										<td style="text-align: left;" colspan="3"><c:out value="${result.content }" escapeXml="false"/></td>
									</tr>
								</tbody>
							</table>
						</div>
					</c:forEach>
					<c:if test="${empty consulList }">
						<div class="mob-write">
							<table class="normal-wmv-table">
								<colgroup>
									<col />
								</colgroup>
								<tbody class="stdView-layout">
									<tr>
										<td colspan="3">상담정보가 없습니다.</td>
									</tr>
								</tbody>
							</table>
						</div>
					</c:if>
				</div>
				<!-- //상담정보 -->
<!-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->

				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecClssPeopleList.do'/>" class="white btn-list">목록</a>
					</div>
				</div>
				<!--// table button -->
				</form:form>
			</div>
		</div>

	</div>
	<!--// contents -->
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter"/>
	<!--// footer -->

	<!-- 모바일 수정 -->
	<div class="black"></div>
	<!--// 모바일 수정 -->

</body>
</html>