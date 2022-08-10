<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<body>
<script>
var events = [];
$.ajax({
	url: "<c:url value='/usr/cnsltScheduleListAjax.do'/>",
	dataType: "json",
	data: $("#frm").serialize()
	async : false
}).done(function(data) {
	
	resultList = data.resultList;
	if(resultList.length > 0){
	   
	   $(resultList).each(function(i, result){
		    events.push({
    			title: $(this).attr("regName"), 
    			start: $(this).attr("schYmd")+"T"+$(this).attr("schHm"),
				textColor : "black",
			color : "white" 
   			});
		});
	}
	
});
</script>
<div class="wrap">
	<!-- 스킵 네비게이션 -->
	<div id="skip_navigation">
		<ul>
			<li><a href="#gnb">주 메뉴 바로가기</a></li>
			<li><a href="#content">본문 바로가기</a></li>
		</ul>
	</div>
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
	<!--// header -->
	<hr />
	<!-- container -->
	<div class="container">
		<!-- lnb -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu" />
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<jsp:include page="/WEB-INF/jsp/writer/usr/inc/incPageTitle.jsp">
            	<jsp:param name="dept1" value="상담"/>
            	<jsp:param name="dept2" value="상담안내"/>
            </jsp:include>
            <div class="cont_box">
				<div class="book_line">
					<ul>
						<li><a href="#p_link01"><span>상담 프로그램 소개</span></a></li>
						<li><a href="#p_link02"><span>글쓰기 상담 신청 안내</span></a></li>
						<li><a href="#p_link03"><span>글쓰기 상담 일정표</span></a></li>
					</ul>
				</div>
				<div class="p09mid_title"><a name="p_link01">상담 프로그램 소개</a></div>
				<dl class="p09_txt">
					<dt>프로그램 소개</dt>
					<dd>
						<p>표현 능력 상담 프로그램 목적</p>
						<dl class="p09_txt_dl">
							<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/p09_img01.jpg'/>" alt="" /></dt>
							<dd>한성대학교 학생들의<br/>표현 능력 향상을 위한 설계</dd>
						</dl>
						<dl class="p09_txt_dl">
							<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/p09_img02.jpg'/>" alt="" /></dt>
							<dd>면대면 상담으로<br/>학습자의 글쓰기 고민 해결</dd>
						</dl>
						<dl class="p09_txt_dl">
							<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/p09_img03.jpg'/>" alt="" /></dt>
							<dd>창의적이고 논리적인<br/>사고와 표현 능력 향상</dd>
						</dl>
						<dl class="p09_txt_dl">
							<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/p09_img04.jpg'/>" alt="" /></dt>
							<dd>경쟁력 있는 리포트를<br/>작성하는 능력 향상</dd>
						</dl>
						<dl class="p09_txt_dl">
							<dt><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/p09_img05.jpg'/>" alt="" /></dt>
							<dd>다양한 장르(유형)의<br/>글쓰기 능력 함양</dd>
						</dl>
					</dd>
				</dl>
				<dl class="p09_txt">
					<dt>신청 자격</dt>
					<dd>
						<ul class="p09_icon">
							<li>한성대학교 학생이라면 누구나 표현 능력 상담 프로그램 이용 가능</li>
							<li>한성대학교 외국인 유학생이라면 누구나 표현 능력 상담 프로그램 이용 가능</li>
						</ul>
					</dd>
				</dl>
				<dl class="p09_txt">
					<dt>상담 영역</dt>
					<dd>
						<ul class="p09_icon">
							<li>리포트, 서평, 칼럼, 프레젠테이션 문서 등 모든 유형의 글</li>
							<li>단, 자기소개서, 졸업 논문, 교내 공모전 제출용 프레젠테이션 문서나 글, 사고와 표현 공통첨삭과제는 상담 불가</li>
						</ul>
					</dd>
				</dl>
				<dl class="p09_txt">
					<dt>상담 내용</dt>
					<dd>
						<p>모든 단계에서 상담 가능</p>
						<ul class="p09_arrow">
							<li>주제 이해</li>
							<li>아이디어 생성</li>
							<li>목차 구성</li>
							<li>글의 전개</li>
							<li>문장 표현</li>
						</ul>
					</dd>
				</dl>
				<dl class="p09_txt">
					<dt>상담 장소</dt>
					<dd>
						<p>표현 능력 상담실 [진리관 104호, 사고와 표현 연구실]</p>
					</dd>
				</dl>
				<div class="p09mid_title"><a name="p_link02">글쓰기 상담 신청 안내</a></div>
				<dl class="p09_txt">
					<dt>상담 신청</dt>
					<dd>
						<p>희망 상담 일시 24시간 전에 상담을 신청해야 합니다.</p>
						<ul class="p09_box_arrow">
							<li>글쓰기 센터<br/>홈페이지 로그인</li>
							<li>‘상담’<br/>‘상담 신청’ 클릭</li>
							<li>신청자 정보<br/>입력</li>
							<li>상담 일시<br/>상담 연구원 선택</li>
							<li>상담 신청<br/>완료</li>
						</ul>
						<p></p>
						<p>※ 상담 신청 후 취소시 같은 시간에 상담을 다시 신청할 수 없습니다.<br>&nbsp;&nbsp;&nbsp;&nbsp;상담 신청 날짜와 시간을 확인 후 신청해 주세요.</p>
					</dd>
				</dl>
				<div class="p09mid_title"><a name="p_link03">글쓰기 상담 일정표</a></div>
				
				<%-- (시간표 내용이 출력되는데 시간이 걸릴 수 있습니다.) --%>
				<dl class="p09_txt">
					<dt>2019년 2학기 상담 일정표</dt>
					<dd>
						<%-- 
						<table summary="" class="p09_dd_table">
							<caption></caption>
							<colgroup>
								<col width="10%" />
								<col width="18%" />
								<col width="18%" />
								<col width="18%" />
								<col width="18%" />
								<col width="18%" />
							</colgroup>
							<thead>
								<tr>
									<th>시간</th>
									<th>월</th>
									<th>화</th>
									<th>수</th>
									<th>목</th>
									<th>금</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="t_first">10~11</td>
									<td>곽유석</td>
									<td>이원지</td>
									<td>곽유석</td>
									<td>이임정</td>
									<td>이원지</td>
								</tr>
								<tr>
									<td class="t_first">11~12</td>
									<td>곽유석</td>
									<td>조은별</td>
									<td>곽유석</td>
									<td>이임정</td>
									<td>이원지</td>
								</tr>
								<tr>
									<td class="t_first">12~13</td>
									<td colspan="5">점 심 시 간</td>
								</tr>
								<tr>
									<td class="t_first">13~14</td>
									<td>곽유석</td>
									<td>조은별</td>
									<td>곽유석</td>
									<td>이홍미</td>
									<td>이원지</td>
								</tr>
								<tr>
									<td class="t_first">14~15</td>
									<td>권정현</td>
									<td>조은별</td>
									<td>이임정</td>
									<td>이홍미</td>
									<td>이원지</td>
								</tr>
								<tr>
									<td class="t_first">15~16</td>
									<td>권정현</td>
									<td>조은별</td>
									<td>이임정</td>
									<td>이홍미</td>
									<td>이원지</td>
								</tr>
								<tr>
									<td class="t_first">16~17</td>
									<td>권정현</td>
									<td>조은별</td>
									<td>이임정</td>
									<td>이홍미</td>
									<td>이홍미</td>
								</tr>
								<tr>
									<td class="t_first">17~18</td>
									<td>권정현</td>
									<td>조은별</td>
									<td>이임정</td>
									<td>권정현</td>
									<td>이홍미</td>
								</tr>
							</tbody>
						</table>					
						--%>
						<div id="calendar" ></div>
						</dd>
				</dl>
				
								
				
			</div>
		</div>
		<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
</div>
</body>
<script>


/*  <div id="calendar" ></div>
	$(document).ready(function() {
		$('#calendar').fullCalendar({
			
			header: {
				left: '',
				center: 'prev, title, next',
				right: ''
			},
			lang: "ko",
			monthNames:["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
			monthNamesShort:["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
			dayNames: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"],
			dayNamesShort: ["일", "월", "화", "수", "목", "금", "토"],
			editable: false,
			eventLimit: true,
			selectable: true,
			selectHelper: true,
			events: function(start, end, timezone, callback) {
				
				$("#startDate").val(start.format());
				$("#endDate").val(end.format());
				
				$.ajax({
	            			url: "<c:url value='/usr/cnsltScheduleListAjax.do'/>",
	              			dataType: "json",
	                		data: $("#frm").serialize(),
	               			 success: function(data) {
	             	   		resultList = data.resultList;
	                		if(resultList.length > 0){
		                		    var events = [];
		                 	   $(resultList).each(function(i, result){
		                    		    events.push({
			                    	title: $(this).attr("regName"), 
			                    	start: $(this).attr("schYmd")+"T"+$(this).attr("schHm"),
		                    		textColor : "black",
						color : "white" 
		                       			});
		                    });
		                    callback(events);
	                	}
	                }
	            });
	        }
		});
	
	});
*/
</script>
</html>