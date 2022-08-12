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
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0603/ech0603List.do'/>").submit();
	}
	
	//수정페이지로
	function fn_update(){
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0603/ech0603Modify.do'/>").submit();
	}
	
	//SMS발송관리 페이지 삭제
	function fn_delete(){
		if (confirm("SMS발송정보를 삭제하시겠습니까?")) {
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0603/ech0603Delete.do'/>").submit();
			
		}
	}
	
	//SMS발송관리 재발송
	function fn_resend(){
		if (confirm("재발송하겠습니까?")) {
		$("#detailForm").attr("action", "<c:url value='/qxsepmny/ech0603/ech0603ReSend.do'/>").submit();
			
		}
	}
	
	$(function(){
		
		var ynSubmitStat = '<c:out value="${rm2000mVO.tsenCls}"/>';
		
		// 전송완료인 경우 버튼 제어
		if (ynSubmitStat == '100') {
			$("#btn_del").css('display', 'none');
			$("#btn_Modi").css('display', 'none');			
		}else {
			$("#btn_Modi").css('display', 'none');
			$("#btn_Send").css('display', 'none');
		} 
				
	});

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
	            <jsp:param name="dept2" value="SMS발송내역"/>
           	</jsp:include>			
			<!-- //타이틀 -->
			<form:form commandName="searchVO" id="detailForm" name="detailForm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="corpCd" name="corpCd" value="${rm2000mVO.corpCd }"/>
				<input type="hidden" id="recsNo" name="recsNo" value="${rm2000mVO.recsNo }"/>
				<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex }"/>
            <!-- 발송내용 -->
            <table class="tbl_view mb03">
                <colgroup>
                    <col style="width:15%" />
                    <col style="width:35%" />
                    <col style="width:15%" />
                    <col style="width:35%" />
                </colgroup>
                <tbody>
                	<tr>
                    	<th scope="row">접수번호</th>
                        <td>
                        	<c:out value="${rm2000mVO.recsNo}" />
						</td>
                        <th scope="row" class="bl">SMS구분</th>
                        <td>
                        	<c:out value="${rm2000mVO.smsClsName}" />
                        </td>
                    </tr> 
                    <tr>
                        <th scope="row">접수일자</th>
                        <td colspan="3"><c:out value="${rm2000mVO.recsDt}" /></td>
                    </tr>
                    <tr>
                    	<th scope="row">전송구분</th>
                        <td>
                        	<c:out value="${rm2000mVO.sendmCls}" />
                        	<c:out value="${rm2000mVO.sendmClsNm}" />
						</td>
                        <th scope="row" class="bl">예약일자</th>
                        <td>
                        	<c:out value="${rm2000mVO.resrDt}" /><c:out value="${rm2000mVO.resrHr}" /><c:out value="${rm2000mVO.resrMm}" />
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
                        <th scope="row">수신번호</th>
                        <td>
                        	<c:out value="${rm2000mVO.receNo}" />                 	
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
                    	<th scope="row">전송상태</th>
                        <td>
                        	<c:out value="${rm2000mVO.tstaClsNm}" />
						</td>
                        <th scope="row" class="bl">전송결과</th>
                        <td>
                        	<c:out value="${rm2000mVO.tsenClsNm}" />
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">전송일자</th>
                        <td colspan="3">
                        	<c:out value="${rm2000mVO.sendDt}" />
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">내용</th>
                        <td colspan="3">
                        	<textarea class="type02 type03"><c:out value="${rm2000mVO.cont}" escapeXml="false;" /></textarea>      	
                        </td>
                    </tr>                    
                    <tr>
                        <th scope="row">메모</th>
                        <td colspan="3">
                        	<c:out value="${rm2000mVO.remk}" />
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">지사</th>
                        <td colspan="3">
                        	<c:out value="${rm2000mVO.branchName}" />
                        </td>
                    </tr>
                </tbody>
            </table>            
            <!-- //발송내용 -->
            </form:form>
			<!-- 버튼 -->
			<div class="btn_area">
				<a href="#" onclick="fn_list(); return false;" class="type02">취소</a>
				<a id="btn_del" href="#" onclick="fn_delete(); return false;">삭제</a>
				<a id="btn_Modi" href="#" onclick="fn_update(); return false;">수정</a>
				<a id="btn_Send"href="#" onclick="fn_resend(); return false;">재발송</a>
			</div>
			<!-- //버튼 -->
		</div>
		<!-- //contents -->
	</div>
	<!-- //container -->
</div>	
<!-- //wrap -->
</body>
</html>