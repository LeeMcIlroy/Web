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
	function fn_pop(){
		window.open("<c:out value='${pageContext.request.contextPath }/qxsepmny/tmp/ech100201.do'/>"
					, 'SMS발송', 'width=1000, height=500, menubar=no, status=no, toolbar=no, scrollbars=1');
	}
	
	//목록으로
	function fn_list(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0602/ech0602List.do'/>").submit();
	}
	
	//수정페이지로
	function fn_update(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0602/ech0602Modify.do'/>").submit();
	}
	
	//이메일발송관리 페이지 삭제
	function fn_delete(){
		if (confirm("이메일발송정보를 삭제하시겠습니까?")) {
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0602/ech0602Delete.do'/>").submit();
			
		}
	}
	
	//이메일 재발송
	function fn_resend(){
		if(confirm('이메일을 재발송합니다.\r\n저장하시겠습니까?')){
			//발송번호 
			var corpCd = $("#corpCd").val();
			var recmNo = $("#recmNo").val();
			var rsjNo = $("input[name=rsjSeq]:checked").serialize();
			var form = $('#detailForm')[0];
			var data = new FormData(form);
			alert(recmNo);
			<%-- , data: "corpCd="+corpCd+"&"+"recmNo="+recmNo+"&"+$("input[name=rsjSeq]:checked").serialize()
			, dataType:"json" --%>
			$.ajax({
				url: "<c:url value='${pageContext.request.contextPath }/qxsepmny/cmm/cmmAjaxResendMail.do'/>"
				, type: "post"
				, enctype: 'multipart/form-data'
				, data: data
	            , processData: false
	            , contentType: false
	            , cache: false
	            , timeout: 600000
				, success: function(data){
					alert(data.message);
				}, error: function(){
					alert("오류가 발생하였습니다.");
				}
			});
		}
	}
	
	$(function(){
		// 발송구분 1 즉시발송 2 예약발송
		var ynSendmCls = '<c:out value="${rm1000mVO.sendmCls}"/>';
		
		switch (ynSendmCls) {
			case '1':
				$("#sendmCls1").attr('checked', 'checked');
		    	break;
			case '2':
				$("#sendmCls2").attr('checked', 'checked');
		    	break;			    	
		  default:
		    console.log(`Sorry, we are out of ${expr}.`);
		}
		
		// 발송설정 1 이메일 2 이메일+SMS
		var ynSendsCls = '<c:out value="${rm1000mVO.sendsCls}"/>';
		
		switch (ynSendsCls) {
			case '1':
				$("#sendsCls1").attr('checked', 'checked');
		    	break;
			case '2':
				$("#sendsCls2").attr('checked', 'checked');
		    	break;				
		  default:
		    console.log(`Sorry, we are out of ${expr}.`);
		}
		
		var ynSubmitStat = '<c:out value="${rm1000mVO.tsenCls}"/>';
		if (ynSubmitStat == '100') {
			$("#btn_del").css('display', 'none');
			$("#btn_Modi").css('display', 'none');
			$("#btn_Send").css('display', 'none');
		} 
		
				
	});

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
		<h2>발송관리</h2>
		<!-- contents -->
		<div class="contents">
			<!-- 타이틀 -->
			<jsp:include page="/WEB-INF/jsp/ctms/adm/inc/incPageTitle.jsp">
				<jsp:param name="dept1" value="발송관리"/>
	            <jsp:param name="dept2" value="이메일발송내역"/>
           	</jsp:include>			
			<!-- //타이틀 -->
			<form:form commandName="searchVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="corpCd" name="corpCd" value="${rm1000mVO.corpCd }"/>
				<input type="hidden" id="recmNo" name="recmNo" value="${rm1000mVO.recmNo }"/>
				<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/>
            <!-- 발송내용 -->
            <table class="tbl_view mb03">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:85%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">연구과제</th>
                        <td><c:out value="${rm1000mVO.rsCd}" />/<c:out value="${rm1000mVO.rsName}" />/<c:out value="${rm1000mVO.rsNo}" /></td>
                    </tr>
                    <tr>
                        <th scope="row">첨부보고서</th>
                        <td><span style="color:blue;">
                        <c:choose>
							<c:when test="${rm1000mVO.fileNames1 eq '1'}">초안보고서</c:when>
							<c:when test="${rm1000mVO.fileNames1 eq '2'}">최종보고서</c:when>
						</c:choose>
						/
                        <c:choose>
							<c:when test="${rm1000mVO.fileNames2 eq '1'}">초안보고서</c:when>
							<c:when test="${rm1000mVO.fileNames2 eq '2'}">최종보고서</c:when>
						</c:choose></span>
                        
                        
                        <%-- <c:out value="${rm1000mVO.fileNames1}" />,<c:out value="${rm1000mVO.fileNames2}" /></td> --%>
                        <%-- <c:choose>
							<c:when test="${rm1000mVO.fileNames eq '1010'}">연구이미지</c:when>
							<c:when test="${rm1000mVO.fileNames eq '1020'}">연구계획서</c:when>
						</c:choose> --%>
                    </tr>
                </tbody>
            </table>
            <table class="tbl_view mb03">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:85%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">받는사람 이메일</th>
                        <td>
                        	<c:out value="${rm1000mVO.receEmail}" />                 	
                        </td>
                    </tr>
                </tbody>
            </table>
            <table class="tbl_view mb03">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">발송구분</th>
                        <td>
                        <input type="radio" name="sendmCls" id="sendmCls1" value="1" readonly />
						<label for="sendmCls1">즉시발송</label>
						<input type="radio" name="sendmCls" id="sendmCls2" value="2" readonly />
						<label for="sendmCls2">예약발송</label>
						<c:choose>
							<c:when test="${rm1000mVO.sendmCls eq '2'}">발송예약일시
								<c:out value="${rm1000mVO.resrDt}" />
								<c:out value="${rm1000mVO.resrHr}" />시<c:out value="${rm1000mVO.resrMm}" />분	
							</c:when>
						</c:choose>
                        </td>
                        <th scope="row" class="bl">발송설정</th>
                        <td>
                        	<input type="radio" name="sendsCls" id="sendsCls1" value="1" readonly />
							<label for="sendsCls1">이메일</label>
							<input type="radio" name="sendsCls" id="sendsCls2" value="2" readonly />
							<label for="sendsCls2">이메일+SMS</label>
                        </td>                       
                    </tr>
                    <tr>
                    	<th scope="row">전송상태</th>
                        <td>
                        <c:choose>
							<c:when test="${rm1000mVO.tstaCls eq '10'}">접수
							<c:out value="${rm1000mVO.recmDt}" />							
							</c:when>
							<c:when test="${rm1000mVO.tstaCls eq '20'}">변환중																	
							</c:when>
							<c:when test="${rm1000mVO.tstaCls eq '30'}"><span style="color:blue;">처리완료</span>																	
							</c:when>												
						</c:choose>
						</td>
                        <th scope="row" class="bl">전송결과</th>
                        <td>
                        <c:choose>
							<c:when test="${rm1000mVO.tsenCls eq '100'}">발송완료
								<c:out value="${rm1000mVO.sendDt}" />							
							</c:when>
							<c:when test="${rm1000mVO.tsenCls eq '900'}"><span style="color:red;">전송대기</span>
							</c:when>
							<c:when test="${rm1000mVO.tsenCls eq '200'}">오류
							</c:when>
						</c:choose>
						</td>
                    </tr>
                    <tr>
                        <th scope="row">발송제목</th>
                        <td colspan="3"><c:out value="${rm1000mVO.title}" /></td>
                    </tr>
                    <tr>
                        <th scope="row">내용</th>
                        <td colspan="3">
                        	<textarea class="type02 type03"><c:out value="${rm1000mVO.cont}" escapeXml="false;" /></textarea>      	
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">첨부파일</th>
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
                        <th scope="row">메모</th>
                        <td colspan="3">
                        	<c:out value="${rm1000mVO.remk}" />
                        </td>
                    </tr>
                </tbody>
            </table>
            <table class="tbl_view mb03">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:85%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row">휴대폰 번호</th>
                        <td>
                        	<c:out value="${rm1000mVO.receNo}" />
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">메시지</th>
                        <td>
                       		<c:out value="${rm1000mVO.smscont}" />
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- //발송내용 -->
       
			<!-- 버튼 -->
			<div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">취소</a>
				<a id="btn_del" href="#" onclick="fn_delete(); return false;">삭제</a>
				<a id="btn_Modi" href="#" onclick="fn_update(); return false;">수정</a>
				<a id="btn_Send"href="#" onclick="fn_resend(); return false;">재발송</a>
			</div>
			<!-- //버튼 -->
			     </form:form>

		<!-- 테이블 상단 정보 -->
			<div class="tbl_top_info">
				<h4>재발송현황</h4>
				<!-- 버튼 -->
			</div>
			<!-- //테이블 상단 정보 -->
            <!-- 재발송현황 -->
			<table class="tbl_list">
				<colgroup>
					<col style="width:5%" />
					<col style="width:auto" />
					<col style="width:15" />
					<col style="width:15%" />
					<col style="width:15%" />
					<col style="width:15%" />
					<col style="width:15%" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">재발송번호</th>
						<th scope="col">전송상태</th>
						<th scope="col">전송상태명</th>
						<th scope="col">전송결과</th>
						<th scope="col">전송결과명</th>
						<th scope="col">발송일시</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="result" items="${resendList}" varStatus="status">
					<tr>
						<td><c:out value="${result.rownum }"/></td>
						<td><c:out value="${result.recmNo }"/></td>
						<td><c:out value="${result.tstaCls }"/></td>
						<td><c:out value="${result.tstaClsNm }"/></td>
						<td><c:out value="${result.tsenCls }"/></td>
						<td><c:out value="${result.tsenClsNm }"/></td>
						<td><c:out value="${result.accpDt }"/></td>
					</tr>
				</c:forEach>
				<c:if test="${resultList.size() == 0 }">
					<tr>
						<td class="nodata" colspan="7">재발송 정보가 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>
			<!-- //재발송현황 -->
			</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>