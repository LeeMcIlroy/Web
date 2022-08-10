 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>

<script>
		function closeLayer( obj ) {
			$(obj).parent().parent().hide();
		}

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
		
	//파일 다운로드
	function fn_filedownload(clssSeq,type){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+clssSeq+"&type="+type;
	}
	</script>
<body>
<form:form commandName="searchVO" id="listForm" name="listForm">

<input type="hidden" id="clssSeq" name="clssSeq" value="${syllabusVO.clssSeq }"/>
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnavLec"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
		
			<!-- left menu -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenuLec"/>
			<!--// left menu -->
			<div class="main-content">
				<div class="title-area">
					<p class="page-lv01">강의계획서</p>
					<div class="navi web"> <!-- 모바일 수정 -->
						<span class="icon-home">Home</span>
						<span>강의실</span>
						<span>수업</span>
						<span>강의계획서</span>
					</div>
				</div>

				<p class="sub-title">기본 정보</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:15%;" />
							<col style="width:10%;" />
							<col style="width:15%;" />
							<col style="width:10%;" />
							<col style="width:15%;" />
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>프로그램</th>
								<td>
									<c:out value="${lectSession.lectProg }"/>
								</td>
								<th>교과목명</th>
								<td>
									<c:out value="${lectSession.lectName }"/>
								</td>
								<th>분반</th>
								<td>
									<c:out value="${lectSession.lectDivi }"/>
								</td>
								<th>담임</th>
								<td>
									<c:out value="${lectSession.name }"/>(<c:out value="${lectSession.lectClaTea }"/>)
								</td>
							</tr>
							<tr>
								<th>수업시간</th>
								<td colspan="3" class="txt-l">
									월요일 ~ 금요일 1교시(09:00) ~ 4교시(12:50)
								</td>
								<th>게시여부</th>
								<td colspan="3">
									<c:out value="${result.syllaYn }"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				 <div class="mob mb20">
					<div class="mob-write">
						<dl>
							<dt>프로그램</dt>
							<dd><c:out value="${lectSession.lectProg }"/></dd>
						</dl>
						<dl>
							<dt>교과목명</dt>
							<dd><c:out value="${lectSession.lectName }"/></dd>
						</dl>
						<dl>
							<dt>분반</dt>
							<dd><c:out value="${lectSession.lectDivi }"/></dd>
						</dl>
						<dl>
							<dt>담임</dt>
							<dd><c:out value="${lectSession.name }"/>(<c:out value="${lectSession.lectClaTea }"/>)</dd>
						</dl>
						<dl>
							<dt>수업시간</dt>
							<dd>월요일 ~ 금요일 1교시(09:00) ~ 4교시(12:50)</dd>
						</dl>
						<dl>
							<dt>게시여부</dt>
							<dd><c:out value="${result.syllaYn }"/></dd>
						</dl>
					</div>
				</div>

				<p class="sub-title">평가기준</p>
				<!-- table -->
				<div class="list-table-box web">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>평가기준</th>
									<td><c:out value="${result.syllaStnd}" escapeXml="false"/></td>
								</tr>
							<tr>
								<th>첨부파일</th>
									<td>
										<c:forEach items="${attachList }" var="file" varStatus="status">
											<a href="#" onclick="fn_filedownload('<c:out value='${file.attachSeq}'/>','SYLL'); return false;">
												<c:out value="${file.orgFileName }"/>
											</a>
											<br />
										</c:forEach>
									</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				 <div class="mob mb20">
					<div class="mob-list">
						<dl>
							<dt>평가기준</dt>
							<dd><c:out value="${result.syllaStnd}" escapeXml="false"/></dd>
						</dl>
						<dl>
							<dt>첨부파일</dt>
							<dd>
								<c:forEach items="${attachList }" var="file" varStatus="status">
									<a href="#" onclick="fn_filedownload('<c:out value='${file.attachSeq}'/>','SYLL'); return false;">
										<c:out value="${file.orgFileName }"/>
									</a>
									<br />
								</c:forEach>
							</dd>
						</dl>
					</div>
				</div>

				<%-- <p class="sub-title">주차별 계획</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:15%;" />
							<col />
							<col />
							<col style="width:15%;" />
						</colgroup>
						<form:form commandName="lectureVO" id="detaleList" name="detaleList">
						<input type="hidden" name="lectSeq" id="lectSeq" value="${lectureVO.lectSeq }"/>
						<tbody>
							
							<tr>
								<c:forEach items="${resultList }" var="result" varStatus="status">
									<td>
										<c:out value="${resultList.lectWeek }"/>
									</td>
									<td>
										<c:out value="${resultList.lectSclass }"/> -
										<c:out value="${resultList.lectSclass }"/>
									</td>
									<td>
										<c:out value="${resultList.lectGrammar }"/> 
									</td>
									<c:forEach var="teacher" items="${teacher}">
									<td>
										<c:out value="${teacher.memberCode}"/> 
									</td>
									</c:forEach>
								</c:forEach>
							</tr>
							<tr>
								<th>월</th>
								<td><c:out value="${week.syllaweekMon1}"/></td>
								<td><c:out value="${week.syllaweekMon2}"/></td>
								<td><c:out value="${week.syllaweekMonRmk}"/></td>
							</tr>
							<tr>
								<th>화</th>
								<td><c:out value="${week.syllaweekTue1}"/></td>
								<td><c:out value="${week.syllaweekTue2}"/></td>
								<td><c:out value="${week.syllaweekTueRmk}"/></td>
							</tr>
							<tr>
								<th>수</th>
								<td><c:out value="${week.syllaweekWed1}"/></td>
								<td><c:out value="${week.syllaweekWed2}"/></td>
								<td><c:out value="${week.syllaweekWedRmk}"/></td>
							</tr>
							<tr>
								<th>목</th>
								<td><c:out value="${week.syllaweekThu1}"/></td>
								<td><c:out value="${week.syllaweekThu2}"/></td>
								<td><c:out value="${week.syllaweekThuRmk}"/></td>
							</tr>
							<tr>
								<th>금</th>
								<td><c:out value="${week.syllaweekFri1}"/></td>
								<td><c:out value="${week.syllaweekFri2}"/></td>
								<td><c:out value="${week.syllaweekFriRmk}"/></td>
							</tr>
						</tbody>
						</form:form>
					</table>
				</div>  --%>
				
				<p class="sub-title">주차별 계획</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:15%;" />
							<col />
							<col />
							<col />
							<col />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th scope="col">교시</th> 
								<th scope="col">시간</th>
								<th scope="col">월</th>
								<th scope="col">화</th>
								<th scope="col">수</th>
								<th scope="col">목</th>
								<th scope="col">금</th> 
							</tr>
						</thead>
						<tbody>
							
							<c:forEach items="${timeTableList }" var="result" varStatus="status">
								<c:set value="09" var="hour"/>
								<tr>
									<td scope="row"><c:out value="${status.count }"/>교시</td>
									<td scope="row"><c:out value="${hour+status.index }"/>:00 ~ <c:out value="${hour+status.index }"/>:50</td>
									<td scope="row"><c:out value="${result.mon}"/></td>
									<td scope="row"><c:out value="${result.tue}"/></td>
									<td scope="row"><c:out value="${result.wed}"/></td>
									<td scope="row"><c:out value="${result.thu}"/></td>
									<td scope="row"><c:out value="${result.fri}"/></td>
								</tr>
							</c:forEach>
								<%-- <td><c:out value="${result.lectSclass }"/></td>
								
								<td><c:out value="${result.lectWeek }"/></td> --%>
						</tbody>
					</table>
				</div> 
				
				<!--// table -->

				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<c:if test="${empty result.clssSeq }">
							<a href="<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecSyllabusModify.do'/>" class="white btn-newwrite sem-chk">강의계획서작성</a>
						</c:if>
						<c:if test="${!empty result.clssSeq }">
							<a href="<c:out value='${pageContext.request.contextPath }/usr/lec/clss/lecSyllabusModify.do'/>" class="white btn-newwrite sem-chk">수정</a>
						</c:if>
						</div>
				</div>
				<!--// table button -->
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
</form:form>
</body>
</html>