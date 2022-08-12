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
var day = "<c:out value="${resrDt}" />";

var nextDay = new Date(day);
var prevDay = new Date(day);
prevDay.setDate(new Date(day).getDate()-1);
nextDay.setDate(new Date(day).getDate()+1);
var next = moment(nextDay).format('YYYY-MM-DD');
var prev = moment(prevDay).format('YYYY-MM-DD');

function fn_next(){
	
	$.ajax({
			
	       type: "get",
	       url:  "/qxsepmny/ech0303/ech0303View.do?resrDt="+next,
	       data: next,      
	    
	         success: function (data) {
	        	window.location.href="/qxsepmny/ech0303/ech0303View.do?resrDt="+next;
				       
	        }, error: function (jqXHR, textStatus, errorThrown) {
	          alert(jqXHR + ' ' + textStatus.msg);
	       }
		});
}

function fn_prev(){
	
	$.ajax({
			
	       type: "get",
	       url:  "/qxsepmny/ech0303/ech0303View.do?resrDt="+prev,
	       data: prev,      
	    
	         success: function (data) {
	        	window.location.href="/qxsepmny/ech0303/ech0303View.do?resrDt="+prev;
				       
	        }, error: function (jqXHR, textStatus, errorThrown) {
	          alert(jqXHR + ' ' + textStatus.msg);
	       }
		});
}
</script>
<body>
<!-- pop_wrap -->
<div class="pop_wrap">
	<!-- pop_header -->
	<div class="pop_header">
		<h1 class="hidden"><a href="#">H&amp;Bio</a></h1>
		<h2>예약일정</h2>
		<a href="javascript:window.close();" title="닫기">닫기</a>
	</div>
	<!-- //pop_header -->
	<!-- pop_con -->
	<div class="pop_con type02">
		<div class="calendar_top type02">
		 	<a onclick="fn_prev();">이전날</a>
			  ${resrDt}
			<a onclick="fn_next();">다음날</a>	
		</div>		
		<!-- 연구일정 -->
		<div class="hd_fix">
			<div>
				<table>
					<colgroup>
						<col style="width:40px" />
						<col style="width:140px" />
						<col style="width:80px" />
						<col style="width:100px" />
						<col style="width:60px" />
						<col style="width:60px" />
						<col style="width:120px" />
						<col style="width:160px" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col" width="40">번호</th>
							<th scope="col" width="140">연구코드</th>
							<th scope="col" width="80">이름</th>
							<th scope="col" width="100">생년월일</th>
							<th scope="col" width="60">나이</th>
							<th scope="col" width="60">성별</th>
							<th scope="col" width="120">핸드폰</th>
							<th scope="col" width="160">예약상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${rs4000mVO}" var="result" varStatus="status" >
							<tr>
						        <td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * paginationInfo.recordCountPerPage - status.count)}"/></td>			
							    <td><c:out value="${result.rsCd }"/></td>
							    <td><c:out value="${result.rsjName }"/></td>
							    <td><c:out value="${result.brDt }"/></td>
							    <td><c:out value="${result.age }"/></td>
							    <td><c:out value="${result.genYnNm }"/> </td> 
								<td><c:out value="${result.hpNo }"/> </td> 
								<td><c:out value="${result.resrStat } (${result.mtStNm})"/> </td> 
							</tr>				
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
			<!-- //예약일정 -->
		<!-- 버튼 -->
		<div class="btn_area">
			<a onclick="javascript:window.close();" class="type02">닫기</a>
		</div>
		<!-- //버튼 -->
	</div>
	<!-- //pop_con -->
</div>	
<!-- //pop_wrap -->
</body>
</html>