<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*, java.text.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   	uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     	uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
function fn_add(seq){

	var lecAttendS 	= $('#semedate01').val();
	var lecAttendE 	= $('#semedate02').val();
	var valuationS 	= $('#semedate03').val();
	var valuationE 	= $('#semedate04').val();
	var registS 	= $('#semedate05').val();
	var registE 	= $('#semedate06').val();
	var enterRegiS 	= $('#semedate07').val();
	var enterRegiE 	= $('#semedate08').val();
	var dormS 		= $('#semedate09').val();
	var dormE 		= $('#semedate10').val();
	var dormIncS 	= $('#semedate11').val();
	var dormIncE	= $('#semedate12').val();
	var gradeS	 	= $('#semedate13').val();
	var gradeE		= $('#semedate14').val();
	var valuationS_M 	= $('#semedate03').val();
	var valuationE_M 	= $('#semedate04').val();

	if(lecAttendS == null || lecAttendE == null || lecAttendS == '' || lecAttendE == ''){
		alert("신청기간을 선택해 주세요.")
	}else if(lecAttendS > lecAttendE){
		alert('신청종료일이 시작일보다 큽니다.');
		$("#semedate02").focus(); 
		
	}else if(valuationS == null || valuationE == null || valuationS == '' || valuationE == ''){
		alert("평가기간을 선택해 주세요.")
	}else if(valuationS > valuationE){
		alert('평가종료일이 시작일보다 큽니다.');
		$("#semedate04").focus(); 
		
	}else if(registS == null || registE == null || registS == '' || registE == ''){
		alert("등록기간을 선택해 주세요.")
	}else if(registS > registE){
		alert('등록종료일이 시작일보다 큽니다.');
		$("#semedate06").focus(); 
		
	}else if(enterRegiS == null || enterRegiE == null || enterRegiS == '' || enterRegiE == ''){
		alert("개설기간을 선택해 주세요.")
	}else if(enterRegiS > enterRegiE){
		alert('개설종료일이 시작일보다 큽니다.');
		$("#semedate08").focus(); 
		
	}else if(dormS == null || dormE == null || dormS == '' || dormE == ''){
		alert("기숙사 입사기간(방학미포함)을 선택해 주세요.")
	}else if(dormS > dormE){
		alert('입사종료일이 시작일보다 큽니다.');
		$("#semedate10").focus(); 
		
	}else if(dormIncS == null || dormIncE == null || dormIncS == '' || dormIncE == ''){
		alert("기숙사 입사기간(방학포함)을 선택해 주세요.")
	}else if(dormIncS > dormIncE){
		alert('입사종료일이 시작일보다 큽니다.');
		$("#semedate12").focus(); 

	}else if(gradeS == null || gradeE == null || gradeS == '' || gradeE == ''){
		alert("성적등록기간을 선택해 주세요.")
	}else if(gradeS > gradeE){
		alert('성적등록종료일이 시작일보다 큽니다.');
		$("#semedate13").focus(); 
		
	}else if(confirm("학기등록 하시겠습니까 ?")){
		$('#detaleList').attr("method", "post").attr("action","<c:out value='${pageContext.request.contextPath}/qxsepmny/curr/addSeme.do'/>").submit();
		}
	};
	
	 $(function() {
			//input을 datepicker로 선언
			$("#semedate01, #semedate02,  #semedate05, #semedate06, #semedate07, #semedate08, #semedate09, #semedate10, #semedate11, #semedate12, #semedate13, #semedate14").datepicker({
				dateFormat: 'yy-mm-dd' //Input Display Format 변경
				,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
				,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
				,changeYear: true //콤보박스에서 년 선택 가능
				,changeMonth: true //콤보박스에서 월 선택 가능                		
				,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
				,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
				,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
				,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
				,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
				,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
				,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
				,minDate: "-10Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
				,maxDate: "+10Y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                
			});                    
			
			//초기값을 오늘 날짜로 설정
// 			$('#semedate01, #semedate02, #semedate03, #semedate04, #semedate05, #semedate06, #semedate07, #semedate08, #semedate09, #semedate10, #semedate11, #semedate12').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
		});
	 $(function() {
			//input을 datepicker로 선언
				
			$(" #semedate03, #semedate04").datetimepicker({
				dateFormat: 'yy-mm-dd' //Input Display Format 변경
				,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
				,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
				,changeYear: true //콤보박스에서 년 선택 가능
				,changeMonth: true //콤보박스에서 월 선택 가능                		
				,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
				,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
				,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
				,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
				,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
				,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
				,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
				,timeFormat:'HH:mm'		
				,controlType:'select'
			    ,oneLine:true
			    ,showSecond: false
	            ,showMillisec: false
	            ,showMicrosec: false
				,minDate: "-10Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
				,maxDate: "+10Y" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
			});                    
			
			//초기값을 오늘 날짜로 설정
//			$('#semedate01, #semedate02, #semedate03, #semedate04, #semedate05, #semedate06, #semedate07, #semedate08, #semedate09, #semedate10, #semedate11, #semedate12').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
		});
	function fn_hakgi(){
		var year = $('#sem_year').val();
		var sem = $('#semester').val();
		$('#sem_hakgi').val(year+sem);
	}
	
</script>
<body>
<form:form commandName="semesterVO" id="detaleList" name="detaleList">
<input type="hidden" name="sem_code" id="sem_code" value="${semesterVO.semCode }"/>
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="교육과정"/>
		            <jsp:param name="dept2" value="학기"/>
	           	</jsp:include>
				<p class="sub-title">학기 정보</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:11%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>학기</th>
								<td>
<!-- 								document.getElementById('sem_hakgi').value = this.options[this.selectedIndex].value -->
									<select id="sem_year" name="sem_year" onchange="fn_hakgi()">
										<option value="2023" <c:if test="${semesterVO.semYear eq '2023'}">selected="selected"</c:if>>2023</option>
										<option value="2022" <c:if test="${semesterVO.semYear eq '2022'}">selected="selected"</c:if>>2022</option>
										<option value="2021" <c:if test="${semesterVO.semYear eq '2021'}">selected="selected"</c:if>>2021</option>
									
									</select>
<!-- 									document.getElementById('sem_hakgi').value = this.options[this.selectedIndex].value -->
									<select id="semester" name="semester" onchange="fn_hakgi()">
										<option value="1" <c:if test="${semesterVO.semester eq '1'}">selected="selected"</c:if>>봄학기</option>
										<option value="2" <c:if test="${semesterVO.semester eq '2'}">selected="selected"</c:if>>여름학기</option>
										<option value="3" <c:if test="${semesterVO.semester eq '3'}">selected="selected"</c:if>>가을학기</option>
										<option value="4" <c:if test="${semesterVO.semester eq '4'}">selected="selected"</c:if>>겨울학기</option>
									</select>
									<input type="text" class="input-data txt-c w100px" id="sem_hakgi" name="sem_hakgi" value="${semesterVO.semHakgi }"/>
								</td>
							</tr>
							<%

							Date date = new Date();
							SimpleDateFormat simpleDate = new SimpleDateFormat("yyy-MM-dd");
							String strdate = simpleDate.format(date);
							
							%>
							<tr>
								<th><sup>*</sup>재등록신청기간</th>
								<td>
									<input type="text" class="w100px" id="semedate01" name="lec_attend_s" value="${semesterVO.lecAttendS }" placeholder="<%= strdate%>"/> ~
									<input type="text" class="w100px" id="semedate02" name="lec_attend_e" value="${semesterVO.lecAttendE }" placeholder="<%= strdate%>"/>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>수업평가기간</th>
								<td>
									<input type="text" class="w120px" id="semedate03" name="valuation_s" value="${semesterVO.valuationS }" placeholder="<%= strdate%>"/>  ~
									<input type="text" class="w120px" id="semedate04" name="valuation_e" value="${semesterVO.valuationE }" placeholder="<%= strdate%>"/>
									
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>등록기간</th>
								<td>
									<input type="text" class="w100px" id="semedate05" name="regist_s" value="${semesterVO.registS }" placeholder="<%= strdate%>" /> ~
									<input type="text" class="w100px" id="semedate06" name="regist_e" value="${semesterVO.registE }" placeholder="<%= strdate%>" />
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>개설기간</th>
								<td>
									<input type="text" class="w100px" id="semedate07" name="enter_regi_s" value="${semesterVO.enterRegiS }" placeholder="<%= strdate%>" /> ~
									<input type="text" class="w100px" id="semedate08" name="enter_regi_e" value="${semesterVO.enterRegiE }" placeholder="<%= strdate%>" />
								</td>
							</tr>
							<tr>
								<th><p><sup>*</sup>기숙사입사기간</p>(방학미포함)</th>
								<td>
									<input type="text" class="w100px" id="semedate09" name="dormS" value="${semesterVO.dormS }" placeholder="<%= strdate%>" /> ~
									<input type="text" class="w100px" id="semedate10" name="dormE" value="${semesterVO.dormE }" placeholder="<%= strdate%>" />
								</td>
							</tr>
							<tr>
								<th><p><sup>*</sup>기숙사입사기간</p>(방학포함)</th>
								<td>
									<input type="text" class="w100px" id="semedate11" name="dormIncS" value="${semesterVO.dormIncS }" placeholder="<%= strdate%>" /> ~
									<input type="text" class="w100px" id="semedate12" name="dormIncE" value="${semesterVO.dormIncE }" placeholder="<%= strdate%>" />
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>성적등록기간</th>
								<td>
									<input type="text" class="w100px" id="semedate13" name="gradeS" value="${semesterVO.gradeS }" placeholder="<%= strdate%>" /> ~
									<input type="text" class="w100px" id="semedate14" name="gradeE" value="${semesterVO.gradeE }" placeholder="<%= strdate%>" />
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>수업만족도<br/>결과공개</th>
								<td>
									<input type="radio" id="rad01" name="satisPrfYn" value="Y" <c:if test="${semesterVO.satisPrfYn eq 'Y'}"> checked = "checked" </c:if> checked/> <label for="rad01">공개</label> &nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" id="rad02" name="satisPrfYn" value="N" <c:if test="${semesterVO.satisPrfYn eq 'N'}"> checked = "checked" </c:if>/> <label for="rad02">비공개</label>
								</td>
							</tr>
<!-- 							<tr>
								<th><sup>*</sup>학기</th>
								<td>
									<select>
										<option>2019</option>
									</select>
									<select>
										<option>가을학기</option>
									</select>
									<input type="text" class="input-data txt-c w100px" placeholder="20193" />
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>재등록신청기간</th>
								<td>
									<input type="text" class="w100px" id="semedate01" placeholder="0000-00-00" /> ~
									<input type="text" class="w100px" id="semedate02" placeholder="0000-00-00" />
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>수업평가기간</th>
								<td>
									<input type="text" class="w100px" id="semedate03" placeholder="0000-00-00" /> ~
									<input type="text" class="w100px" id="semedate04" placeholder="0000-00-00" />
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>등록기간</th>
								<td>
									<input type="text" class="w100px" id="semedate05" placeholder="0000-00-00" /> ~
									<input type="text" class="w100px" id="semedate06" placeholder="0000-00-00" />
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>개설기간</th>
								<td>
									<input type="text" class="w100px" id="semedate07" placeholder="0000-00-00" /> ~
									<input type="text" class="w100px" id="semedate08" placeholder="0000-00-00" />
								</td>
							</tr> -->

						</tbody>
					</table>
				</div>
				<!--// table -->
				<p class="sub-title">상태정보</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:11%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>개설여부</th>
								<td>
									<input type="radio" id="rad01" name="open_sem" value="Y" <c:if test="${semesterVO.openSem eq 'Y'}"> checked = "checked" </c:if> checked/> <label for="rad01">개설</label> &nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" id="rad02" name="open_sem" value="N" <c:if test="${semesterVO.openSem eq 'N'}"> checked = "checked" </c:if>/> <label for="rad02">마감</label>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>신청여부</th>
								<td>
									<input type="radio" id="rad03" name="open_regi" value="Y" <c:if test="${semesterVO.openRegi eq 'Y'}"> checked = "checked" </c:if> checked/> <label for="rad03">신청</label> &nbsp;&nbsp;&nbsp;&nbsp;
									<input type="radio" id="rad04" name="open_regi" value="N" <c:if test="${semesterVO.openRegi eq 'N'}"> checked = "checked" </c:if>/> <label for="rad04">마감</label>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->
				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/curr/admSemeList.do'/>" class="white btn-list">목록</a>
						<button type="button" class="white btn-save" onclick="fn_add()" id="add" >저장</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
    <input type="hidden" id="message" name="message" value="<c:out value='${message }'/>"/>
	<!--// footer -->
	</form:form>
</body>
</html>