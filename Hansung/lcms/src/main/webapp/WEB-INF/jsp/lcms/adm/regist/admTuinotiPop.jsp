<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt"	   uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead"/>
<link rel="stylesheet" media="print" href="<c:out value='${pageContext.request.contextPath }/assets/adm/css/style.css'/>">
<style type="text/css" media="print">
@page {
    size: auto;  /* auto is the initial value */
    margin: 0;  /* this affects the margin in the printer settings */
}
</style>
<script type="text/javascript">
	function pageprint() {
		var g_oBeforeBody = document.getElementById('print-pop').innerHTML;
		
		window.onbeforeprint = function (ev) {
			document.body.innerHTML = g_oBeforeBody;
		};
		
		window.print();
	}
</script>
<body onload="pageprint();">
	<div id="print-pop">
		<c:forEach items="${resultList }" var="result">
			<!-- contents -->
			<div class="pop-box">
				<div class="contents">
					<!-- table -->
					<div class="pop-table-box">
						<table class="normal-pop-table">
							<colgroup>
								<col style="width:20%;"/>
								<col />
								<col style="width:1%;"/>
								<col style="width:20%;"/>
								<col />
							</colgroup>
							<tbody>
								<tr>
									<td colspan="2">(학생용)</td>
									<td rowspan="10">&nbsp;</td>
									<td colspan="2">(은행용)</td>
								</tr>
								<tr>
									<td colspan="2" class="table-tit">한국어 프로그램 등록금 고지서</td>
									<td colspan="2" class="table-tit">한국어 프로그램 등록금 고지서</td>
								</tr>
								<tr>
									<td class="table-tit">성명</td>
									<td>
										<c:out value="${result.enterName }"/>
									</td>
									<td class="table-tit">성명</td>
									<td>
										<c:out value="${result.enterName }"/>
									</td>
								</tr>
								<tr>
									<td>보험료(Insurance)</td>
									<td class="fee-data"><fmt:formatNumber value="${result.insuFee }" pattern="#,###"/>원</td>
									<td>보험료(Insurance)</td>
									<td class="fee-data"><fmt:formatNumber value="${result.insuFee }" pattern="#,###"/>원</td>
								</tr>
								<tr>
									<td>입학금(Application fee)</td>
									<td class="fee-data"><fmt:formatNumber value="${result.enterFee }" pattern="#,###"/>원</td>
									<td>입학금(Application fee)</td>
									<td class="fee-data"><fmt:formatNumber value="${result.enterFee }" pattern="#,###"/>원</td>
								</tr>
								<tr>
									<td>등록금(Tuition fee)</td>
									<td class="fee-data"><fmt:formatNumber value="${result.regFee }" pattern="#,###"/>원</td>
									<td>등록금(Tuition fee)</td>
									<td class="fee-data"><fmt:formatNumber value="${result.regFee }" pattern="#,###"/>원</td>
								</tr>
								<tr>
									<td>합계(Total)</td>
									<td class="fee-data"><fmt:formatNumber value="${result.enterFee + result.regFee + result.insuFee }" pattern="#,###"/>원</td>
									<td>합계(Total)</td>
									<td class="fee-data"><fmt:formatNumber value="${result.enterFee + result.regFee + result.insuFee }" pattern="#,###"/>원</td>
								</tr>
								<tr>
									<td colspan="2" class="area-data">
										<p>납부 해당 기간 : <c:out value="${result.regRgSeme }"/>개 학기(<c:out value="${result.regRgSeme }"/> semesters) <c:out value="${result.enterRegiS }"/> ~ <c:out value="${result.enterRegiE }"/></p>
									</td>
									<td colspan="2" class="area-data">
										<p>납부 해당 기간 : <c:out value="${result.regRgSeme }"/>개 학기(<c:out value="${result.regRgSeme }"/> semesters) <c:out value="${result.enterRegiS }"/> ~ <c:out value="${result.enterRegiE }"/></p>
									</td>
								</tr>
								<tr>
									<td colspan="2" class="area-data">
										은행 : 기업은행<br/>
										가상계좌번호 : <c:out value="${result.bankAccount }"/><br/>
										납부기간 : <c:out value="${result.regStDate }"/> ~ <c:out value="${result.regEdDate }"/>
									</td>
									<td colspan="2" class="area-data">
										은행 : 기업은행<br/>
										가상계좌번호 : <c:out value="${result.bankAccount }"/><br/>
										납부기간 : <c:out value="${result.regStDate }"/> ~ <c:out value="${result.regEdDate }"/>
									</td>
								</tr>
								<tr>
									<td colspan="2" class="area-data">
										※등록금을 납부 후, 재학증명서, 등록금납입영수증을 받을 수 있습니다.
										<p class="alt-txt">한 성 대 학 교</p>
									</td>
									<td colspan="2" class="area-data">
										※등록금을 납부 후, 재학증명서, 등록금납입영수증을 받을 수 있습니다.
										<p class="alt-txt">한 성 대 학 교</p>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<!--// contents -->
		</c:forEach>
	</div>
</body>
</html>