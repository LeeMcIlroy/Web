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
	$(function(){
		
		var ynadminType = '<c:out value="${adminType}"/>';	
		if(ynadminType=='2') {
			$('.btnLockNonDisp').css("display","none");
		}
	});
	
	//건별 예약관리
	function fn_pop(corpCd, rsNo, rsjNo, resrNo, rsCd){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/ech0103/ech1003MtmgPop.do'/>?corpCd="+corpCd+"&rsNo="+rsNo+"&rsjNo="+rsjNo+"&resrNo="+resrNo+"&rsCd="+rsCd
				, '예약관리', 'width=500, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}	
	
	//목록으로
	function fn_list(){
		
		
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0301/ech0301List.do'/>").submit();
	}
	
	//수정페이지로
	function fn_update(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0301/ech0301Modify.do'/>").submit();
	}
	
	//사용자 페이지 삭제
	function fn_delete(){
		if (confirm("사용자를 삭제하시겠습니까? 삭제후 복구할 수 없습니다")) {
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0301/ech0301Delete.do'/>").submit();
			
		}
	}
	
	
	function fn_clearPw(){
		if(confirm('사용자의 아이디를 부여 하시겠습니까?')){
			$.ajax({
				url: "<c:url value='/qxsepmny/ech0301/ech0301AjaxCreateId.do'/>"
				, type: "post"
				, data: $("#detailForm").serialize()
				, dataType: "json"
				, success: function(data){
					var message = data.message;
					alert(message);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
	
	
	
	function fn_clearPw(){
		if(confirm('사용자의 비밀번호를 재설정 하시겠습니까? 비밀번호는 아이디와 동일하게 생성됩니다')){
			$.ajax({
				url: "<c:url value='/qxsepmny/ech0301/ech0301AjaxProfClearPw.do'/>"
				, type: "post"
				, data: $("#detailForm").serialize()
				, dataType: "json"
				, success: function(data){
					var message = data.message;
					alert(message);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}


	function fn_clearLgnFail(){
		if(confirm('사용자의 로그인 횟수를 초기화 하시겠습니까?')){
			var userId = $("#userId").val();
			$.ajax({
				url: "<c:url value='/qxsepmny/ech0301/ech0301AjaxClearLgnFail.do'/>"
				, type: "post"
				, data: "adminId="+userId
				, dataType: "json"
				, success: function(data){
					var message = data.message;
					alert(message);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}

	
	
	/*$(function(){
		
		var ynrSubjctStat = '<c:out value="${sb1000mVO.rsjStCls}"/>';
		
		switch (ynrSubjctStat) {
			case '1':
				$("#rsubjctStat1").attr('checked', 'checked');
		    	break;
			case '2':
				$("#rsubjctStat2").attr('checked', 'checked');
		    	break;
			case '3':
				$("#rsubjctStat3").attr('checked', 'checked');
		    	break;
			case '4':
				$("#rsubjctStat4").attr('checked', 'checked');
		    	break;	
		  default:
		    console.log(`Sorry, we are out of ${expr}.`);
		}
	});*/

	function fn_createIdOne(corpCd, rsjNo){
		if(confirm('연구대상자의 아이디를 설정합니다. 비밀번호는 아이디와 동일하게 설정됩니다.\r\n저장하시겠습니까?')){
			alert(corpCd);
			alert(rsjNo);
			//var step1 = $("#step1").val();
			var step1 = "Y";
			var step2 = "N";
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/ech0301/ech0301AjaxSaveFirstOne.do'/>"
				, type: "post"
				, data: "corpCd="+corpCd+"&"+"rsjNo="+rsjNo
				, dataType:"json"
				, success: function(data){
					alert(data.message);
					fn_list(1);
					//window.location.reload();
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	
	}
	
	//파일 다운로드
	function fn_filedownload(attachSeq, boardType){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+attachSeq+"&type="+boardType;
	}
	
</script>
<body>
<!-- wrap -->
<div class="wrap">
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- container -->
	<div class="container">
		<h2>피험자관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="피험자관리"/>
	            <jsp:param name="dept2" value="피험자관리"/>
           	</jsp:include>
			<!-- //타이틀 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area type02">
				<h4>기본정보</h4>
			</div>
			<!-- //서브타이틀 -->
			<form:form commandName="searchVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="corpCd" name="corpCd" value="${sb1000mVO.corpCd }"/>
				<input type="hidden" id="rsjNO" name="rsjNo" value="${sb1000mVO.rsjNo }"/>
				<input type="hidden" id="userId" name="userId" value="${sb1000mVO.userId }"/>
				<input type="hidden" id="searchCondition1" name="searchCondition1" value="${searchVO.searchCondition1 }"/>
				<input type="hidden" id="searchCondition2" name="searchCondition2" value="${searchVO.searchCondition2 }"/>
				<input type="hidden" id="searchCondition3" name="searchCondition3" value="${searchVO.searchCondition3 }"/>
				<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
				<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/>
            <!-- 기본정보 -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">등록일자</th>
						<td>
							<c:out value="${sb1000mVO.regDt}" />
						</td>
						<th scope="row" class="bl">번호(자동생성)</th>
						<td>
							<c:out value="${sb1000mVO.rsjNo}" />
						</td>	
					</tr>
					<tr>						
						<th scope="row">이름</th>
						<td>
							<c:out value="${sb1000mVO.rsjName}" />
						</td>
						<th scope="row"  class="bl">생년월일</th>
						<td>
							<c:out value="${sb1000mVO.brDt}" />
						</td>
					</tr>
					<tr>
						<th scope="row">사용자ID</th>
						<td>
						
							<c:choose>
								<c:when test="${sb1000mVO.userId eq ''}"><a href="#" onclick="fn_createIdOne('<c:out value="${sb1000mVO.corpCd}" />', '<c:out value="${sb1000mVO.rsjNo}" />'); return false;" class="btn_sub2 btnLockNonDisp">사용자ID부여</a></c:when>
								<c:when test="${sb1000mVO.userId ne ''}"><c:out value="${sb1000mVO.userId}" /></c:when>
							</c:choose>
						
						
							<!--<c:out value="${sb1000mVO.userId}" />
							<a href="#" onclick="fn_createIdOne('<c:out value="${sb1000mVO.corpCd}" />', '<c:out value="${sb1000mVO.rsjNo}" />'); return false;" class="btn_sub2">사용자ID부여</a>-->
						</td>
						<th scope="row" class="bl">비밀번호</th>
						<td>
							<a href="#" onclick="fn_clearPw(); return false;" class="btn_sub2 btnLockNonDisp">비밀번호 재설정</a>
							<!-- <a href="#" class="btn_sub2">임시비밀번호 SMS발송</a> -->
							<a href="#" onclick="fn_clearLgnFail(); return false;" class="btn_sub2 btnLockNonDisp">로그인횟수 초기화</a>
						</td>
					</tr>
					<tr>
						<th scope="row">성별</th>
						<td>
							<c:out value="${sb1000mVO.genName}" />
						</td>
						<th scope="row" class="bl">주민등록번호</th>
						<td>
							<c:choose>
								<c:when test="${sb1000mVO.jregNo eq ''}"><c:out value="${sb1000mVO.jregNo}" /></c:when>
								<c:when test="${sb1000mVO.jregNo ne ''}">주민등록번호 암호화</c:when>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th scope="row">핸드폰</th>
						<td>
							<c:out value="${sb1000mVO.hpNo}" />
						</td>
						<th scope="row" class="bl">이메일</th>
						<td>
							<c:out value="${sb1000mVO.email}" />
						</td>
					</tr>
					<tr>
						<th scope="row">주소</th>
						<td colspan="3">
							<c:out value="${sb1000mVO.postNo}" />
							<c:out value="${sb1000mVO.addrMain}" />
							<c:out value="${sb1000mVO.addrGita}" />
						</td>
					</tr>
					<tr>
						<th scope="row">은행명</th>
						<td>
							<c:out value="${sb1000mVO.bankName}" />
						</td>
						<th scope="row" class="bl">예금주</th>
						<td>
							<c:out value="${sb1000mVO.acctName}" />
						</td>
					</tr>
					<tr>
						<th scope="row">계좌번호</th>
						<td colspan="3">
							<c:choose>
								<c:when test="${sb1000mVO.acctNo eq ''}"><c:out value="${sb1000mVO.acctNo}" /></c:when>
								<c:when test="${sb1000mVO.acctNo ne ''}">계좌번호 암호화</c:when>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th scope="row">통장사본</th>
							<td colspan="3">
							<div class="attach_sec type02 mb02" id="attachRpt01_div">
                            	<input type="file" id="in_file01" name="attachRpt01" />
                            	<c:choose>
                            		<c:when test="${attachMap.attachRpt01 == null }">
		                            	<script type="text/javascript">
		                            			 $('#attachRpt01_div').remove();
		                            	</script>	
                            		</c:when>    		
                            	</c:choose>
                            	<div>
                           			<span>
                            			<a href="#" onclick="fn_filedownload('<c:out value='${attachMap.attachRpt01.attachNo }'/>', '<c:out value='${attachMap.attachRpt01.boardType }'/>'); return false;">
	                           				<c:out value="${attachMap.attachRpt01.orgFileName }"/>
	                          			</a>
                            		</span>
                            	</div>
                            </div>
							</td>
					</tr>
					<tr>
						<th scope="row">지사정보</th>
						<td colspan="3">
							<c:out value="${sb1000mVO.branchName}" />
						</td>
					</tr>
					
				</tbody>
			</table>
			<!-- //기본정보 -->
			<!-- 서브타이틀 -->
			<div class="sub_title_area">
				<h4>연구대상자 상태</h4>
			</div>
			<!-- //서브타이틀 -->
            <!-- 연구대상자 상태 -->
			<table class="tbl_view">
				<colgroup>
					<col style="width:15%" />
					<col style="width:35%" />
					<col style="width:15%" />
					<col style="width:35%" />
				</colgroup>
				<tbody>								
					<tr>
						<th scope="row">관리자 확인</th>
						<td>
							<c:choose>
								<c:when test="${sb1000mVO.cfmYn eq 'Y'}">확인</c:when>
								<c:when test="${sb1000mVO.cfmYn eq 'N'}">미확인</c:when>
								</c:choose>
							
							&nbsp;&nbsp;&nbsp;&nbsp;
							<span>확인일 :</span> 
								<c:out value="${sb1000mVO.cfmDt}" />
							
						</td>
						<th scope="row" class="bl">연구순응도</th>
						<td>
							<c:out value="${sb1000mVO.rsjStClsNm}" />
						</td>
					</tr>
					<tr>
						<th scope="row">연구대상자유형</th>
						<td colspan="3">
							<div class="unit_wrap">
								<!-- 유형 -->
								<div class="unit">
									<p>안면여드름</p>									
									<select id="faYn" name="faYn" class="p60" disabled="disabled">
										<option value="" <c:if test="${sb1010mVO.faYn eq '' }">selected="selected"</c:if> >미등록</option>
										<option value="Y" <c:if test="${sb1010mVO.faYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.faYn eq 'N' }">selected="selected"</c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">								
									<p>등여드름</p>								
									<select id="baYn" name="baYn" class="p60" disabled="disabled">
										<option value="" <c:if test="${sb1010mVO.baYn eq '' }">selected="selected"</c:if> >미등록</option>
										<option value="Y" <c:if test="${sb1010mVO.baYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.baYn eq 'N' }">selected="selected"</c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>팔자주름</p>
									<select id="nfYn" name="nfYn" class="p60" disabled="disabled">
										<option value="" <c:if test="${sb1010mVO.nfYn eq '' }">selected="selected"</c:if> >미등록</option>
										<option value="Y" <c:if test="${sb1010mVO.nfYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.nfYn eq 'N' }">selected="selected"</c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>셀룰라이트</p>
									<select id="clYn" name="clYn" class="p60" disabled="disabled">
										<option value="" <c:if test="${sb1010mVO.clYn eq '' }">selected="selected"</c:if> >미등록</option>
										<option value="Y" <c:if test="${sb1010mVO.clYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.clYn eq 'N' }">selected="selected"</c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>눈가주름</p>
									<select id="weYn" name="weYn" class="p60" disabled="disabled">
										<option value="" <c:if test="${sb1010mVO.weYn eq '' }">selected="selected"</c:if> >미등록</option>
										<option value="Y" <c:if test="${sb1010mVO.weYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.weYn eq 'N' }">selected="selected"</c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>다크서클</p>
									<select id="dcYn" name="dcYn" class="p60" disabled="disabled">
										<option value="" <c:if test="${sb1010mVO.dcYn eq '' }">selected="selected"</c:if> >미등록</option>
										<option value="Y" <c:if test="${sb1010mVO.dcYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.dcYn eq 'N' }">selected="selected"</c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>광피부타입</p>
									<select id="ltYn" name="ltYn" class="p60" disabled="disabled">
										<option value="" <c:if test="${sb1010mVO.ltYn eq '' }">selected="selected"</c:if> >미등록</option>
										<option value="Y" <c:if test="${sb1010mVO.ltYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.ltYn eq 'N' }">selected="selected"</c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>색소침착</p>
									<select id="pmYn" name="pmYn" class="p60" disabled="disabled">
										<option value="" <c:if test="${sb1010mVO.pmYn eq '' }">selected="selected"</c:if> >미등록</option>
										<option value="Y" <c:if test="${sb1010mVO.pmYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.pmYn eq 'N' }">selected="selected"</c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>탈모</p>
									<select id="hlYn" name="hlYn" class="p60" disabled="disabled">
										<option value="" <c:if test="${sb1010mVO.hlYn eq '' }">selected="selected"</c:if> >미등록</option>
										<option value="Y" <c:if test="${sb1010mVO.hlYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.hlYn eq 'N' }">selected="selected"</c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>아이백</p>
									<select id="ebYn" name="ebYn" class="p60" disabled="disabled">
										<option value="" <c:if test="${sb1010mVO.ebYn eq '' }">selected="selected"</c:if> >미등록</option>
										<option value="Y" <c:if test="${sb1010mVO.ebYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.ebYn eq 'N' }">selected="selected"</c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>민감여부</p>
									<select id="snYn" name="snYn" class="p60" disabled="disabled">
										<option value="" <c:if test="${sb1010mVO.snYn eq '' }">selected="selected"</c:if> >미등록</option>
										<option value="Y" <c:if test="${sb1010mVO.snYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.snYn eq 'N' }">selected="selected"</c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>비듬</p>
									<select id="ddYn" name="ddYn" class="p60" disabled="disabled">
										<option value="" <c:if test="${sb1010mVO.ddYn eq '' }">selected="selected" </c:if> >미등록</option>
										<option value="Y" <c:if test="${sb1010mVO.ddYn eq 'Y' }">selected="selected" </c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.ddYn eq 'N' }">selected="selected" </c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
								<!-- 유형 -->
								<div class="unit">
									<p>홍조</p>
									<select id="flYn" name="flYn" class="p60" disabled="disabled">
										<option value="" <c:if test="${sb1010mVO.flYn eq '' }">selected="selected"</c:if> >미등록</option>
										<option value="Y" <c:if test="${sb1010mVO.flYn eq 'Y' }">selected="selected"</c:if> >있음</option>
										<option value="N" <c:if test="${sb1010mVO.flYn eq 'N' }">selected="selected"</c:if> >없음</option>
									</select>
								</div>
								<!-- //유형 -->
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">메모</th>
						<td colspan="3">						
							<textarea class="type02 type03"><c:out value="${sb1000mVO.remk}" /></textarea>
						</td>
					</tr>
					<tr>
						<th scope="row">상태</th>
						<td colspan="3">
							<c:choose>
								<c:when test="${sb1000mVO.userSt eq 1}">정상</c:when>
								<c:when test="${sb1000mVO.userSt eq 2}">정지(로그인차단)</c:when>
							</c:choose>
						</td>
					</tr>
				</tbody>
			</table>
			<!-- //연구대상자 상태 -->
            <!-- 버튼 -->
			<div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">취소</a>
				<a href="#" class="btnLockNonDisp" onclick="fn_delete(); return false;">삭제</a>
				<a href="#" onclick="fn_update(); return false;">수정</a>
			</div>
			</form:form>
			<!-- //버튼 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<h4>예약현황</h4>
				<!-- 버튼 -->
				<div>
					<!-- <a onclick="fn_pop(); return false;" class="btn_sub">SMS 발송</a>  -->
				</div>
			</div>
			<!-- //테이블 상단 정보 -->
            <!-- 예약현황 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:10%" />
					<col style="width:auto" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:10%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">예약일시</th>
						<th scope="col">예약상태</th>
						<th scope="col">연구코드</th>
						<th scope="col">연구명</th>
						<th scope="col">연구기간(시작)</th>
						<th scope="col">연구기간(종료)</th>
						<th scope="col">관리</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="result" items="${mtList}" varStatus="status">
					<tr>
						<!-- <td><a href="#" style="text-decoration: underline;" onclick="fn_resrModiPop('<c:out value="${result.corpCd }"/>','<c:out value="${result.resrNo }"/>'); return false;"><c:out value="${result.resrDt }"/>-<c:out value="${result.resrHr }"/>:<c:out value="${result.resrMm }"/></a></td>  -->
						<td><c:out value="${result.rownum }"/></td>
						<td><c:out value="${result.resrDt }"/> - <c:out value="${result.resrHr }"/>:<c:out value="${result.resrMm }"/></td>
						<td><c:out value="${result.mtStNm }"/></td>
						<td><c:out value="${result.rsCd }"/></td>
						<td><c:out value="${result.rsName }"/></td>
						<td><c:out value="${result.rsStdt }"/></td>
						<td><c:out value="${result.rsEndt }"/></td>
						<td>
							<a href="#" onclick="fn_pop('<c:out value="${result.corpCd }"/>','<c:out value="${result.rsNo }"/>','<c:out value="${result.rsjNo }"/>','<c:out value="${result.resrNo }"/>','<c:out value="${result.rsCd }"/>'); return false;" class="btn_sub">예약관리</a>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${resultList.size() == 0 }">
					<tr>
						<td class="nodata" colspan="7">예약 정보가 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>
			<!-- //예약현황 -->
			<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<h4>참여현황</h4>
				<!-- 버튼 -->
			</div>
			<!-- //테이블 상단 정보 -->
            <!-- 참여현황 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:10%" />
					<col style="width:auto" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:8%" />
					<col style="width:6%" />
					<col style="width:6%" />
					<col style="width:6%" />
					<col style="width:6%" />
					<col style="width:6%" />
					<col style="width:10%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">연구코드</th>
						<th scope="col">연구명</th>
						<th scope="col">연구기간(시작)</th>
						<th scope="col">연구기간(종료)</th>
						<th scope="col">참여기간(시작)</th>
						<th scope="col">참여기간(종료)</th>
						<th scope="col">참여상태</th>
						<th scope="col">지원</th>
						<th scope="col">풀선별</th>
						<th scope="col">1차선정</th>
						<th scope="col">확정</th>
						<th scope="col">특이사항</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="result" items="${jnList}" varStatus="status">
					<tr>
						<td><c:out value="${result.rownum }"/></td>
						<td><c:out value="${result.rsCd }"/></td>
						<td><c:out value="${result.rsName }"/></td>
						<td><c:out value="${result.rsStdt }"/></td>
						<td><c:out value="${result.rsEndt }"/></td>
						<td><c:out value="${result.appStdt }"/></td>
						<td><c:out value="${result.appEndt }"/></td>
						<td><c:out value="${result.appstaClsNm }"/></td>
						<td><c:out value="${result.appYn }"/></td>
						<td><c:out value="${result.poolYn }"/></td>
						<td><c:out value="${result.firstSt }"/></td>
						<td><c:out value="${result.cfmYn }"/></td>
						<td><c:out value="${result.etc }"/></td>
					</tr>
				</c:forEach>
				<c:if test="${resultList.size() == 0 }">
					<tr>
						<td class="nodata" colspan="13">참여 정보가 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>
			<!-- //참여현황 -->
		</div>
		<!-- //contents -->
		<input type="hidden" name="message" id="message" value="<c:out value='${message }'/>"/>
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>