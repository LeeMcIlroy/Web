<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<%@ page import="lcms.valueObject.AdminVO" %>
<%
	String admMenuNo = ((String)session.getAttribute("admMenuNo")!=null)?(String)session.getAttribute("admMenuNo"):"";
	AdminVO adminVO = ((AdminVO)session.getAttribute("adminSessionLcms")!=null)?(AdminVO)session.getAttribute("adminSessionLcms"):null;
%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<script type="text/javascript">
// 	체크박스 전체선택
	function cAll() {
	    if ($("#checkAll").is(':checked')) {
	        $(".all").prop("checked", true);
	    } else {
	        $(".all").prop("checked", false);
	    }
	}
	/* 등록하기 */
	function fn_modify(){
		if(fn_validate("frm")){
			var memberCode = $("#memberCode").val();
			$("#frm").attr("action","<c:out value='${pageContext.request.contextPath}/qxsepmny/student/admFuncUpdate.do'/>").submit();
		}
	}
// 	학생상세보기페이지로
	function detailView(){
		var memberCode = $("#memberCode").val();
		$("#frm").attr("action","<c:out value='${pageContext.request.contextPath}/qxsepmny/student/admStatusView.do'/>").submit();
	}
// 	파일이름 가져오기
	$(function(){
		$("#upload_file").change(function(){
			var fileValue = $('#upload_file').val().split("\\");
			var fileName = fileValue[fileValue.length-1];
			var extension = fileName.split(".")[1].toUpperCase();
	 		
			$("#fileName").val(fileName);
			$("#deleteYn").val('Y');
		});
	});
	
	// 팝업창 값 뿌려주기
    function select(obj){ 
        var seq = $(obj).attr('value1');
        var code = $(obj).attr('value2');
        var name = $(obj).attr('value');
        var ename = $(obj).attr('value3');
        var birth = $(obj).attr('value4');
        var nation = $(obj).attr('value5');
        var tel = $(obj).attr('value6');

        document.getElementById('memberSeq').value=seq;
        document.getElementById('memberCode').value=code;
        document.getElementById('name').value=name;
        document.getElementById('eName').value=ename;
        document.getElementById('birth').value=birth;
        document.getElementById('nation').value=nation;
        document.getElementById('tel').value=tel;
        
        $(".pop-bg").css("display", "none" );
    };
//     체크박스 클릭후 선택버튼 클릭
function fn_selectOne(){
    var ck_length = $("input:checkbox[name=check]:checked").length;
	var popSeq = $("input:checkbox[name=check]:checked").val()
	
	if(ck_length > 1 ){
		alert('선택한 값이 너무 많습니다.');
		return false;
	}else if(ck_length < 1 ){
		alert('한명 이상 선택해 주세요.');
	}else if(ck_length = 1 ){
		$.ajax({
			url: "<c:url value='/qxsepmny/student/admAjaxStudSelect.do' />"
			, type: "post"
			, data: "popSeq="+popSeq
			, dataType:"json"
			, success: function(data){
				var popResult = data.popResult;
				document.getElementById('memberSeq').value=popResult.memberSeq;
				document.getElementById('memberCode').value=popResult.memberCode;
				document.getElementById('name').value=popResult.name;
				document.getElementById('eName').value=popResult.eName;
				document.getElementById('birth').value=popResult.birth;
				document.getElementById('nation').value=popResult.nation;
				document.getElementById('tel').value=popResult.tel;
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
		
        $(".pop-bg").css("display", "none" );
        $(".all").prop("checked", false);
	}
}
// 학생찾기 팝업
    function searchStud(){
    	 $(".pop-bg").css("display", "block" );
    }
//     팝업창 닫기
    function fn_close(){
    	 $(".pop-bg").css("display", "none" );
    }
    
//     팝업 검색
	function fn_select(){

    	$("#checkAll").prop("checked", false);
    	
		$.ajax({
			url: "<c:url value='/qxsepmny/student/admAjaxStudSearch.do' />"
			, type: "post"
			, data: $("#frm").serialize()
			, dataType:"json"
			, success: function(data){
				var resultList = data.resultList;
				var html = '';
				
				for(var i=0; i < resultList.length; i++){
					html += '<tr>';
					html += '	<td class="txt-c"><input type="checkbox" class="all" name="check" id="popSeq" value="'+resultList[i].memberSeq+'"/></td>';
					html += '	<td class="txt-c"><p class="underline" id="popCode">'+resultList[i].memberCode+'</p></td>';
					html += '	<td class="txt-c"><a href="javascript:void(0);" class="underline imgSelect" ondblclick="select(this);" name="name" ';
					html += '		value="'+resultList[i].name+'" value2="'+resultList[i].memberCode+'" value3="'+resultList[i].eName+'" value4="'+resultList[i].birth+'" ';
					html += '		value5="'+resultList[i].nation+'" value6="'+resultList[i].tel+'" value1="'+resultList[i].memberSeq+'">'+resultList[i].name+'</a></td>';
					html += '	<td class="txt-c">'+resultList[i].eName+'</td>';
					html += '	<td class="txt-c">';
						if(resultList[i].tel != null){
							html += resultList[i].tel;
						}
					html += '	</td>';
					html += '	<td class="txt-c">'+resultList[i].step+'급</td>';
					html += '</tr>';
				}
				if(resultList.length == 0){
					html += '<tr>';
					html += '	<td class="txt-c" colspan="6">검색된 학생이 없습니다.</td>';
					html += '</tr>';
				}
				
				$("#stdList").html(html);
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	$(document).ready(function(){
		$('#datepicker01').datepicker('setDate', 'today');
	});
</script>
	
<body>
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="학생"/>
		            <jsp:param name="dept2" value="학적변동"/>
	           	</jsp:include>
				 	<form:form commandName="memberVO" id="frm" name="frm" enctype="multipart/form-data">
<%-- 	           	<input type="hidden" name="memberSeq" id="memberSeq" value="${memberVO.memberSeq }"/> --%>
<%-- 				<form:hidden path="memberSeq"/> --%>
				<p class="sub-title">대상자 정보</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>학번</th>
								<td>
									<input type="text" class="input-data w173px" readonly="readonly" />&nbsp;&nbsp;
									<a href="" class="student-search">검색</a>&nbsp;&nbsp;&nbsp;&nbsp;
									<label for="student-option" class="label-btn" onclick="searchStud();">학생찾기</label>
									<!-- 팝업 -->
									<input type="checkbox" id="student-option" />
									<div class="pop-bg">
										<div class="pop-table">
											<!-- table -->
											<div class="list-table-box">
												<table class="normal-wmv-table">
													<colgroup>
														<col style="width:15%;" />
														<col />
													</colgroup>
													<tbody>
														<tr>
															<th class="txt-l" colspan="2"><strong>학생찾기</strong></th>
														</tr>
														<tr>
															<td colspan="2">
																<select name="searchType">
																	<option value="name">이름</option>
																	<option value="eName">영문이름</option>
																	<option value="code">학번</option>
																	<option value="nation">국적</option>
																</select>
																<input type="text" name="searchWord" class="input-data w173px"/>
																<button type="button" class="normal-btn" onclick="fn_select(); return false;">검색</button>
															</td>
														</tr>
													</tbody>
												</table>
											</div>
											<!--// table -->

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
															<th><input type="checkbox" id="checkAll" onclick="cAll();" /></th>
															<th>학번</th>
															<th>이름</th>
															<th>영문이름</th>
															<th>연락처</th>
															<th>급수</th>
														</tr>
													</thead>
													<tbody>
													<tbody id="stdList">
														<c:forEach var="result" items="${member}" varStatus="status">
														<tr>
															<td class="txt-c"><input type="checkbox" class="all required" title="학생" name="check" id="popSeq" value="${result.memberSeq }"/></td>
															<td class="txt-c"><p class="underline" id="popCode"><c:out value="${result.memberCode }" /> </p></td>
															<td class="txt-c">
															<a href="javascript:void(0);" class="underline imgSelect" ondblclick="select(this);" name="name" 
															value="${result.name }" value1="${result.memberSeq }" value2="${result.memberCode }" value3="${result.eName }" value4="${result.birth }" value5="${result.nation }" value6="${result.tel }"  >
															<c:out value="${result.name }" /></a>
															</td>
															<td class="txt-c"><c:out value="${result.eName }" /></td>
															<td class="txt-c">
															<c:if test="${result.tel != null}">
															<c:out value="${result.tel }" />
															</c:if>
															</td>
															<td class="txt-c"><c:out value="${result.step }" />급</td>
														</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>
											<!--// table -->

											<!-- table button -->
											<div class="table-button">
												<div class="btn-box">
<!-- 													<label for="student-option" class="white btn-cancel" onclick="close();">닫기</label> -->
													<button type="button" class="white btn-cancel" onclick="fn_close(); return false;">닫기</button>
													<button type="button" class="white btn-newwrite" onclick="fn_selectOne(); return false;">선택</button>
												</div>
											</div>
											<!--// table button -->
										</div>
									</div>
									<!-- // 팝업 -->
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<p class="sub-title">사용정보</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:23%;" />
							<col style="width:10%;" />
							<col style="width:23%;" />
							<col style="width:10%;" />
							<col style="width:24%;" />
						</colgroup>
						<tbody>
							<tr>
								<th>학번</th>
								<td>
								<input type="hidden" name="memberSeq" id="memberSeq" value="${memberVO.memberSeq }"/>
								<input type="text" id="memberCode" name="memberCode" class="required" title="학생" style="border: none;" value="<c:out value="${memberVO.memberCode }" />" readonly="readonly"></td>
								<th>이름</th>
								<td><input type="text" id="name" name="name" style="border: none;" value="<c:out value="${memberVO.name }" />" readonly="readonly"></td>
								<th>영문명</th>
								<td><input type="text" id="eName" name="eName" style="border: none;" value="<c:out value="${memberVO.eName }" />" readonly="readonly"></td>
							</tr>
							<tr>
								<th>생년월일</th>
								<td><input type="text" id="birth" name="birth" style="border: none;" value="<c:out value="${memberVO.birth }" />" readonly="readonly"></td>
								<th>국적</th>
								<td><input type="text" id="nation" name="nation" style="border: none;" value="<c:out value="${memberVO.nation }" />" readonly="readonly"></td>
								<th>연락처</th>
								<td>
								<c:if test="${memberVO.tel ne null}">
								<input type="text" id="tel" name="tel" style="border: none;" value="<c:out value="${memberVO.tel }" />" readonly="readonly">
								</c:if>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="txt-r mt10">
						<a href="#" onclick="detailView()" class="underline">학생정보 상세보기</a>
					</div>
				</div>
				<!--// table -->

				<p class="sub-title">학적이력</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>변동이력</th>
								<td>
									<ul>
									<c:forEach items="${funcList }" var="result" varStatus="status">
									<input type="hidden" name="funcList[<c:out value='${status.index }'/>].funcSeq" value="<c:out value='${result.funcSeq }'/>"/>
										<li>
											<c:out value='${result.funcDate }'/>&nbsp;<c:out value='${result.funcState }'/>&nbsp;<c:out value='${result.funcReason }'/>
										</li>
									</c:forEach>
									</ul>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<p class="sub-title">학적변동</p>
				<input type="hidden" id="funcWriter" name="funcWriter" value="<%= adminVO.getName() %>"/>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:10%;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>변동사항</th>
								<td>
									<select id="funcState" name="funcState" class="required select-one" title="변동사항">
										<option value="자퇴" >자퇴</option>
										<option value="행방불명" >행방불명</option>
										<option value="퇴학" >퇴학</option>
										<option value="미등록" >미등록</option>
									</select>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>변동학기</th>
								<td>
									<select id="year" name="year" class="required select-one" title="변동학기" onchange="fn_search_seme(this);">
										<c:forEach items="${yearList }" var="year">
											<option value="${year }" selected="<c:out value='${year eq semester.semYear?"selected":"" }'/>"><c:out value="${year }"/></option>
										</c:forEach>
									</select>
									<select id="semester" name="semester" class="required select-one" title="변동학기">
										<c:forEach items="${semeList }" var="seme">
											<option value="${seme.semester }" selected="<c:out value='${seme.semester eq semester.semester?"selected":"" }'/>"><c:out value="${seme.semeNm }"/></option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>변동일</th>
								<td>
									<input type="text" id="datepicker01" name="funcDate" class="w173px required" title="변동일"/>
								</td>
							</tr>
							<tr>
								<th>사유</th>
								<td>
									<textarea id="reason" name="funcReason" cols="5" rows="5" maxlength="200" class="w100pc"></textarea>
								</td>
							</tr>
							<tr>
								<th>첨부파일</th>
								<td>
<%-- 									<input type="text" value="<c:out value='${attachList != null?attachList[0].orgFileName:"파일선택" }'/>" class="input-data" id="fileName" disabled="disabled"> --%>
									<input type="text" value="<c:out value='파일선택'/>" class="input-data" id="fileName" disabled="disabled">
									<label for="upload_file" class="btn-upload-file">파일업로드</label>
									<input type="file" class="hidden" id="upload_file" name="upload_file" />
									<input type="hidden" id="deleteFile" name="deleteFile" value='<c:out value="${attachList[0].attachSeq }"></c:out>'/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<div class="table-button">
					<div class="btn-box">
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/student/admFuncList.do'/>" class="white btn-list">목록</a>
						<button type="button" class="white btn-save" onclick="fn_modify(); return false;">저장</button>
				</div>
				</div>
				</form:form>
			</div>
		</div>
	</div>
	<!--// contents -->
	<!-- footer -->
    <c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->
</body>
</html>