<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
	var resultList;
	var complList;
	
	function fn_search(){
		$.ajax({
			url: "<c:url value='/qxsepmny/cmm/admAjaxSearchStd.do'/>"
			, type: "post"
			, data: "searchWord="+$("#searchWord").val()
			, dataType:"json"
			, success: function(data){
				resultList = data.resultList;
				var html = "";
				
				for(var i=0; i<resultList.length; i++){
					html += '<tr onclick="fn_select('+i+'); return false;">';
					html += '	<td>'+resultList[i].name+'</td>';
					html += '	<td>'+resultList[i].memberCode+'</td>';
					html += '	<td>'+resultList[i].eName+'</td>';
					html += '	<td>'+resultList[i].status+'</td>';
					html += '	<td>'+resultList[i].step+'급</td>';
					html += '	<td>'+resultList[i].nation+'</td>';
					html += '</tr>';
				}
				
				if(resultList.length == 0){
					html += '<tr>';
					html += '	<td colspan="6">검색된 내용이 없습니다.</td>';
					html += '</tr>';
				}
				
				$("#stdBody").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	function fn_select(i){
		var result = resultList[i];
		
		$("#nameTd").html(result.name);
		$("#name").val(result.name);
		$("#code").html(result.memberCode);
		$("#memberCode").val(result.memberCode);
		$("#eName").html(result.eName);
		$("#status").html(result.status);
		$("#step").html(result.step+'급');
		$("#nation").html(result.nation);
		$("#mName").html(result.name);
		$("#mCode").html(result.memberCode);
		$("#mEName").html(result.eName);
		$("#mStatus").html(result.status);
		$("#mStep").html(result.step+'급');
		$("#mNation").html(result.nation);
		
		$("#modi-pop").click();
		
		resultList = null;
		
		fn_select_seme();
	}
	
	function fn_select_seme(){
		$.ajax({
			url: "<c:url value='/qxsepmny/admstr/admAjaxSearchComplList.do'/>"
			, type: "post"
			, data: "memberCode="+$("#memberCode").val()
			, dataType:"json"
			, success: function(data){
				complList = data.resultList;
				var certiType = $("#certiType").val();
				var html = '';
				var option = '<option value="">-학기-</option>';
				
				for(var i=0; i<complList.length; i++){
					html += '<tr>';
					html += '	<td>'+(i+1)+'</td>';
					html += '	<td class="txt-l">'+complList[i].lectYear+'-'+complList[i].lectSemNm+'</td>';
					html += '	<td>'+complList[i].lectCurr+'</td>';
					html += '	<td>'+complList[i].lectProg+'</td>';
					html += '	<td>'+complList[i].avgGrade+'</td>';
					html += '	<td>'+complList[i].avgAttend+'</td>';
					html += '	<td>'+complList[i].grade+'급</td>';
					html += '	<td>'+complList[i].compleSta+'</td>';
					html += '</tr>';
					
					if(complList[i].compleSta == '수료' || certiType != '3'){
						option += '<option value="'+complList[i].lectYear+complList[i].lectSem+'">'+complList[i].lectYear+' '+complList[i].lectSemNm+'</option>';
					}
				}
				
				$("#complBody").html(html);
				$("#sel-seme").html(option);
				
				$("#sel-seme").change(function(){
					var curr = '<option value="">-교육과정-</option>';
					
					for(var i=0; i<complList.length; i++){
						if((complList[i].lectYear+complList[i].lectSem) == $(this).val() && (complList[i].compleSta == '수료' || certiType != '3')){
							curr += '<option value="'+complList[i].lectCurr+'">'+complList[i].lectCurr+'</option>';
						}
					}
					
					$("#semCurr").html(curr);
				});

				$("#semCurr").change(function(){
					var prog = '<option value="">-프로그램-</option>';
					
					for(var i=0; i<complList.length; i++){
						if(complList[i].lectCurr == $(this).val() && (complList[i].compleSta == '수료' || certiType != '3')){
							prog += '<option value="'+complList[i].lectProg+'">'+complList[i].lectProg+'</option>';
						}
					}
					
					$("#semProg").html(prog);
				});
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	$(function(){
		$("#modi-pop").change(function(){
			$("#stdBody").html('<td colspan="6">학번 또는 이름을 검색해주세요.</td>');
		});

		$("#sel-seme").change(function(){
			var sem = $("#sel-seme").val();
			var year = sem.substr(0,4);
			var semester = sem.substr(4,1);
			
			$("#semYear").val(year);
			$("#semester").val(semester);
		});
	});
	
	function fn_update(){
		if(fn_validate("frm")){
			$("#frm").attr("action", "<c:url value='/qxsepmny/admstr/admCertiUpdate.do'/>").submit();
		}
	}
</script>
<body>
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<input type="checkbox" id="modi-pop" class="hidden" />
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="행정"/>
		            <jsp:param name="dept2" value="증명서"/>
	           	</jsp:include>
	           	<form:form commandName="certiVO" id="frm" name="frm">
	           	<form:hidden path="memberCode"/>
				<p class="sub-title">접수 정보</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>접수일자</th>
								<td>
									<form:input path="certiDate" id="datepicker01" placeholder="0000-00-00" class="required" title="접수일자"/>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>이름</th>
								<td>
									<input type="text" class="input-data w173px required" title="학생" id="name" placeholder="" readonly="readonly" />
									<label class="normal-btn" for="modi-pop">학생찾기</label>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<p class="sub-title">학생 정보</p>
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:13%;" />
							<col style="width:20%;"/>
							<col style="width:13%;" />
							<col style="width:20%;"/>
							<col style="width:14%;" />
							<col style="width:20%;"/>
						</colgroup>
						<tbody>
							<tr>
								<th>이름</th>
								<td id="nameTd">
								</td>
								<th>학번</th>
								<td id="code">
								</td>
								<th>영문명</th>
								<td id="eName">
								</td>
							</tr>
							<tr>
								<th>상태</th>
								<td id="status">
								</td>
								<th>급수</th>
								<td id="step">
								</td>
								<th>국적</th>
								<td id="nation">
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<p class="sub-title">수료정보</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-list-table">
						<colgroup>
							<col style="width:5%;" />
							<col />
							<col />
							<col />
							<col />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th>No.</th>
								<th>학기</th>
								<th>교육과정</th>
								<th>프로그램</th>
								<th>평균성적</th>
								<th>출석율(%)</th>
								<th>급수</th>
								<th>수료</th>
							</tr>
						</thead>
						<tbody id="complBody">
						</tbody>
					</table>
				</div>
				<!--// table -->

				<p class="sub-title">발급신청</p>
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>증명서</th>
								<td>
									<form:select path="certiType" class="required select-one" title="증명서 종류" onchange="fn_select_seme(); return false;">
										<form:option value="1">재학증명서</form:option>
										<form:option value="2">성적증명서</form:option>
										<form:option value="3">수료증명서</form:option>
										<form:option value="4">납입증명서</form:option>
										<form:option value="5">(전체학기)재학증명서</form:option>
										<form:option value="6">(전체학기)성적증명서</form:option>
									</form:select>&nbsp;
									<form:select path="printNum" class="required select-one" title="부수">
										<form:option value="1">1부</form:option>
										<form:option value="2">2부</form:option>
										<form:option value="3">3부</form:option>
										<form:option value="4">4부</form:option>
										<form:option value="5">5부</form:option>
									</form:select>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>대상학기</th>
								<td>
									<select id="sel-seme" class="required select-one" title="대상학기">
										<option value="">-학기-</option>
									</select>
									<form:hidden path="semYear"/>
									<form:hidden path="semester"/>
									<form:select path="semCurr" class="required select-one" title="교육과정">
										<form:option value="">-교육과정-</form:option>
									</form:select>
									<form:select path="semProg" class="required select-one" title="프로그램">
										<form:option value="">-프로그램-</form:option>
									</form:select>
								</td>
							</tr>
							<tr>
								<th>발급사유</th>
								<td>
									<form:input path="certiEtc" class="input-data w173px" placeholder="" />
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/admstr/admCertiList.do'/>" class="white btn-list">목록</a>
						<button type="button" class="white btn-save" onclick="fn_update(); return false;">발급신청</button>
					</div>
				</div>
				</form:form>
			</div>
		</div>
		<div class="black-pop">&nbsp;</div>
		<div class="modi-popup">
			<p class="sub-title">신청자찾기</p>
			<div class="search-box none-option">
				<input type="checkbox" id="search-option-open" />
				<div class="search">
					<div class="search-input">
						<table class="shearch-option">
							<colgroup>
								<col style="width:8%;" />
								<col />
							</colgroup>
							<tbody>
								<tr>
									<td>
										<input type="text" class="input-data" placeholder="학번,이름을 입력하세요" id="searchWord" />
									</td>
								</tr>
							</tbody>
						</table>
						<a href="#" onclick="fn_search(); return false;">검색하기</a>
					</div>
				</div>
			</div>
			<div class="list-table-box">
				<table class="normal-list-table">
					<colgroup>
						<col />
						<col />
						<col />
						<col />
						<col />
						<col />
					</colgroup>
					<thead>
						<tr>
							<th>이름</th>
							<th>학번</th>
							<th>영문명</th>
							<th>상태</th>
							<th>급수</th>
							<th>국적</th>
						</tr>
					</thead>
					<tbody id="stdBody">
						<tr>
							<td colspan="6">학번 또는 이름을 검색해주세요.</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="table-button">
				<div class="btn-box">
					<label for="modi-pop" class="white btn-cancel">취소</label>
				</div>
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->
</body>
</html>