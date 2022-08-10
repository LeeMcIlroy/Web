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
	
	$(function(){
		$("#searchWord").keydown(function(e){
			if(e.keyCode == 13){
				fn_search();
			}
		});
		
		$("#modi-pop").change(function(){
			if(!($("#modi-pop").is(":checked"))){
				resultList = null;
				$("#stdBody").html('<tr><td colspan="3">학번 또는 이름을 검색해주세요.</td></tr>');
			}
		});
		
		$("#regRgSeme").change(function(){
			var year = $("#regStYear").val();
			var seme = $("#semEster").val();
			var regSeme = $(this).val();
			var html = '';
			
			for(var i=1; i < regSeme; i++){
				var semeNm = '';
				var semeCnt = ++seme;
				if(semeCnt > 4){
					year++;
					seme = 1;
					semeCnt = semeCnt-4;
				}
				
				if(semeCnt == 1){
					semeNm = '봄학기';
				}else if(semeCnt == 2){
					semeNm = '여름학기';
				}else if(semeCnt == 3){
					semeNm = '가을학기';
				}else if(semeCnt == 4){
					semeNm = '겨울학기';
				}
				
				html += year + '년 ' + semeNm + '<br/>';
			}
			
			$("#regRgYear").html(html);
		});
	});
	
	function fn_pop(type){
		var html = '';
		$("#searchType").val(type);
		if(type == 'ENTR'){
			html = '신청자찾기'
		}else{
			html = '학생찾기'
		}
		$("#popTit").html(html);
	}

	function fn_search(){
		$.ajax({
			url: "<c:url value='/qxsepmny/regist/admAjaxSearchStdList.do'/>"
			, type: "post"
			, data: $("#searchFrm").serialize()
			, dataType:"json"
			, success: function(data){
				resultList = data.resultList;
				var html = "";
				
				for(var i=0; i<resultList.length; i++){
					html += '<tr onclick="fn_select('+i+'); return false;">';
					html += '	<td>'+resultList[i].enterNum+'</td>';
					html += '	<td>'+resultList[i].memberCode+'</td>';
					html += '	<td>'+resultList[i].enterName+'</td>';
					html += '</tr>';
				}
				
				if(resultList.length == 0){
					html += '<tr>';
					html += '	<td colspan="3">검색된 내용이 없습니다.</td>';
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
		
		$("#semester").html(result.enterYear + ' ' + result.enterSemeNm);
		$("#name").val(result.enterName);
		$("#entNum").html(result.enterNum + ' / ' + result.enterType);
		$("#code").html(result.memberCode);
		$("#enterNum").val(result.enterNum);
		$("#nation").html(result.enterNation);
		$("#birth").html(result.enterBirth);
		$("#account").val(result.bankAccount);
		
		$("#modi-pop").click();
	}
	
	function fn_save(){
		if(fn_validate("frm")){
			$("#regFee").val($("#regFee").val().replace(/,/g,''));
			$("#enterFee").val($("#enterFee").val().replace(/,/g,''));
			$("#insuFee").val($("#insuFee").val().replace(/,/g,''));
			$("#frm").attr("action", "<c:url value='/qxsepmny/regist/admTuinotiUpdate.do'/>").submit();
		}
	}
	
	function fn_save_acco(){
		var enterNum = $("#enterNum").val();
		var enterCode = $("#enterCode").val();
		var account = $("#account").val();
		if(enterNum == ''){
			alert('학생을 선택해 주세요.');
			return;
		}
		if(account != ''){
			alert('가상계좌번호가 존재합니다.');
			return;
		}
		
		$.ajax({
			url: "<c:url value='/qxsepmny/regist/admAjaxAdmAccoSaveOne.do'/>"
			, type: "post"
			, data: "enterNum="+enterNum+"enterCode="+enterCode
			, dataType:"json"
			, success: function(data){
				alert(data.message);
				$("#account").val(data.account)
			}, error: function(){
				alert("오류가 발생하였습니다.");
			}
		});
	}
	
	function fn_add(){
		$("#addYnFrm").val('Y');
		$("#enterNumFrm").val($("#enterNum").val());
		$("#addFrm").attr("action", "<c:url value='/qxsepmny/regist/admTuinotiModify.do'/>").submit();
	}
</script>
<body>
    <c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
			<div class="main-content">
				<jsp:include page="/WEB-INF/jsp/lcms/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="등록"/>
		            <jsp:param name="dept2" value="등록금고지"/>
	           	</jsp:include>
				<p class="sub-title">접수 정보</p>
				<form:form commandName="regFeeVO" id="frm" name="frm">
				<form:hidden path="regSeq"/>
				<form:hidden path="addYn"/>
				<form:hidden path="enterNum"/>
				<form:hidden path="enterCode"/>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:150px;" />
							<col />
							<col style="width:150px;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>이름</th>
								<td colspan="3">
									<%-- <c:if test="${regFeeVO.regSeq != '' }"> --%>
										<c:out value="${regFeeVO.enterName }"/>
									<%-- </c:if>
									<c:if test="${regFeeVO.regSeq == '' }">
										<input type="text" class="input-data required" title="학생" id="name" placeholder="" readonly="readonly"/>
										<label class="normal-btn" for="modi-pop" onclick="fn_pop('STD');">학생찾기</label>&nbsp;&nbsp;&nbsp;
										<label class="normal-btn" for="modi-pop" onclick="fn_pop('ENTR');">신청자찾기</label>
									</c:if> --%>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>접수학기</th>
								<td colspan="3" id="semester"><c:out value="${regFeeVO.enterYear }"/> <c:out value="${regFeeVO.enterSeme }"/></td>
							</tr>
							<tr>
								<th>접수번호</th>
								<td id="entNum"><c:out value="${regFeeVO.enterNum }"/></td>
								<th>학번</th>
								<td id="code"><c:out value="${regFeeVO.memberCode }"/></td>
							</tr>
							<tr>
								<th>국적</th>
								<td id="nation"><c:out value="${regFeeVO.enterNation }"/></td>
								<th>생년월일</th>
								<td id="birth"><c:out value="${regFeeVO.enterBirth }"/></td>
							</tr>

							<tr>
								<th><sup>*</sup>고지일자</th>
								<td colspan="3">
									<form:input path="regDate" id="datepicker01" class="required" title="고지일자" placeholder="0000-00-00"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<p class="sub-title">등록금정보</p>
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col style="width:150px;" />
							<col />
							<col style="width:150px;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th><sup>*</sup>가상계좌번호</th>
								<td colspan="3">
									<input type="text" class="input-data required" title="가상계좌번호" placeholder="" id="account" readonly="readonly" value="<c:out value='${account }'/>" />
									<c:if test="${account == '' or account == null }">
										<button class="normal-btn" onclick="fn_save_acco(); return false;">가상계좌발급</button>
									</c:if>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>납부시작학기</th>
								<td colspan="<c:out value='${regFeeVO.addYn eq "Y"?"3":"1" }'/>">
									<form:select path="regStYear" onchange="fn_search_seme(this);">
										<form:options items="${yearList }"/>
									</form:select>
									<form:select path="regStSeme" id="semEster">
										<c:forEach items="${semeList }" var="seme">
											<form:option value="${seme.semester }"><c:out value="${seme.semeNm }"/></form:option>
										</c:forEach>
									</form:select>
								</td>
								<c:if test="${regFeeVO.addYn ne 'Y' }">
									<th><sup>*</sup>대상학기</th>
									<td>
										<form:select path="regRgSeme">
											<form:option value="1">1학기</form:option>
											<form:option value="2">2학기</form:option>
											<form:option value="3">3학기</form:option>
											<form:option value="4">4학기</form:option>
										</form:select>
									</td>
								</c:if>
								<c:if test="${regFeeVO.addYn eq 'Y' }">
									<form:hidden path="regRgSeme" value="1"/>
								</c:if>
							</tr>
							<c:if test="${regFeeVO.addYn ne 'Y' }">
								<tr>
									<th>추가학기</th>
									<td colspan="3" id="regRgYear">
										<c:if test="${regFeeVO.regRgSeme ne '' }">
											<c:forEach begin="1" end="${regFeeVO.regRgSeme-1 }" step="1" var="regSeme">
												<c:if test="${regFeeVO.regStSeme+regSeme > 4 }">
													<c:out value="${regFeeVO.regStYear+1 }년 "/>
													<c:set value="${regFeeVO.regStSeme+regSeme-4 }" var="seme"/>
												</c:if>
												<c:if test="${regFeeVO.regStSeme+regSeme <= 4 }">
													<c:out value="${regFeeVO.regStYear }년 "/>
													<c:set value="${regFeeVO.regStSeme+regSeme }" var="seme"/>
												</c:if>
												<c:choose>
													<c:when test="${seme == 1 }">
														봄학기
													</c:when>
													<c:when test="${seme == 2 }">
														여름학기
													</c:when>
													<c:when test="${seme == 3 }">
														가을학기
													</c:when>
													<c:when test="${seme == 4 }">
														겨울학기
													</c:when>
												</c:choose>
												<br/>
											</c:forEach>
										</c:if>
									</td>
								</tr>
							</c:if>
							<tr>
								<th><sup>*</sup>등록금</th>
								<td>
									<form:input path="regFee" class="input-data required txt-r" title="등록금" onkeyup="fn_number(this);"/>
								</td>
								<th>입학금</th>
								<td>
									<form:input path="enterFee" class="input-data txt-r" onkeyup="fn_number(this);"/>
								</td>
							</tr>
							<tr>
								<th>보험료</th>
								<td colspan="3">
									<form:input path="insuFee" class="input-data txt-r" onkeyup="fn_number(this);"/>
								</td>
							</tr>
							<tr>
								<th><sup>*</sup>납부기간</th>
								<td colspan="3">
									<form:input path="regStDate" id="datepicker03" class="required" title="납부기간" placeholder="0000-00-00"/>&nbsp;-&nbsp; 
									<form:input path="regEdDate" id="datepicker04" class="required" title="납부기간" placeholder="0000-00-00"/>
								</td>
							</tr>
							<tr>
								<th>고지서발송일자</th>
								<td colspan="3">
									<form:input path="regSeDate" id="datepicker02" placeholder="0000-00-00"/>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!--// table -->

				<div class="table-button">
					<div class="btn-box">
						<c:if test="${regFeeVO.regSeq ne '' && regFeeVO.regSeq != null && regFeeVO.addYn ne 'Y' }">
							<button type="button" class="white btn-save" onclick="fn_add(); return false;">추가납부</button>
						</c:if>
						<a href="<c:out value='${pageContext.request.contextPath }/qxsepmny/regist/admTuinotiList.do'/>" class="white btn-list">목록</a>
						<button type="button" class="white btn-save" onclick="fn_save(); return false;">저장</button>
					</div>
				</div>
				</form:form>
			</div>
		</div>
		<!-- 팝업 -->
		<form:form commandName="searchVO" id="searchFrm" name="searchFrm">
			<form:hidden path="searchType"/>
			<input type="checkbox" id="modi-pop" class="hidden" />
			<div class="black-pop">&nbsp;</div>
			<div class="modi-popup">
				<p class="sub-title" id="popTit">신청자찾기</p>
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
											<form:input path="searchWord" class="input-data" placeholder="학번,이름을 입력하세요" />
										</td>
									</tr>
								</tbody>
							</table>
							<a href="#" onclick="fn_search('ENTR'); return false;">검색하기</a>
						</div>
					</div>
				</div>
				<div class="list-table-box">
					<table class="normal-list-table">
						<colgroup>
							<col style="width:150px;" />
							<col style="width:150px;" />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th>접수번호</th>
								<th>학번</th>
								<th>이름</th>
							</tr>
						</thead>
						<tbody id="stdBody">
							<tr>
								<td colspan="3">학번 또는 이름을 검색해주세요.</td>
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
		</form:form>
	</div>
	<!--// contents -->
	<form id="addFrm" name="addFrm">
		<input type="hidden" id="addYnFrm" name="addYn"/>
		<input type="hidden" id="enterNumFrm" name="enterNum"/>
	</form>
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter"/>
	<!--// footer -->
</body>
</html>