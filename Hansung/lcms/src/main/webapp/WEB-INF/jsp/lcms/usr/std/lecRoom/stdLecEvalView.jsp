<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead"/>
<script src="<c:out value='${pageContext.request.contextPath }/assets/usr/js/language.js'/>"></script>
<script>
	$(function(){
		var message = '<c:out value="${message }"/>';
		
		if(message != ''){
			alert(message);
			opener.location.reload();
			window.close();
		}
	});
	
	function fn_save(){
		if(fn_validate("frm")){
			$("#frm").attr("action", "<c:url value='/usr/std/lecRoom/stdLecEvalUpdate.do'/>").submit();
		}
	}

	function fn_close(){
		window.close();
	}

	var lang = '<c:out value="${resultMap.lang }"/>';

	window.onload = function(){
		var textList;

		if(lang == 'Korean'){
			textList = Korean;
		}else if(lang == 'Vietnamese'){
			textList = Vietnames;
		}else if(lang == 'Japanese'){
			textList = Japanese;
		}else if(lang == 'English'){
			textList = English;
		}else if(lang == 'Chinese'){
			textList = Chinese;
		}else if(lang == 'Mongolian'){
			textList = Mongol;
		}

		$(".sect").html(textList[0]);
		$(".ques").html(textList[1]);
		$(".answ").html(textList[2]);
		$(".prof").html(textList[3]);

		var phrTit = document.getElementsByClassName('phrTit');

		for(var i=0; i<phrTit.length; i++){
			var title = phrTit[i];

			if(title.innerHTML == Korean[4]){
				title.innerHTML = textList[4];
			}else if(title.innerHTML == Korean[5]){
				title.innerHTML = textList[5];
			}else if(title.innerHTML == Korean[6]){
				title.innerHTML = textList[6];
			}else if(title.innerHTML == Korean[7]){
				title.innerHTML = textList[7];
			}else if(title.innerHTML == Korean[8]){
				title.innerHTML = textList[8];
			}
		}
	}
</script>
<body>
	<!-- contents -->
	<div class="content-box">
		<div class="contents">
			<div class="pop-content">
				<!-- table -->
				<div class="list-table-box">
					<table class="normal-wmv-table">
						<colgroup>
							<col />
						</colgroup>
						<tbody>
							<tr>
								<td><c:out value="${resultMap.content }" escapeXml="false"/></td>
							</tr>
						</tbody>
					</table>
				</div>
				<p class="sub-title">
					강의평가
				</p>
				<c:forEach items="${resultList }" var="result" varStatus="status">
					<c:if test="${result.quesType eq 'LEC' }">
						<div class="list-table-box">
							<table class="normal-wmv-table">
								<colgroup>
									<col width="10%"/>
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th class="sect">조사구분</th>
										<td class="phrTit"><c:out value="${result.phrTitle }"/></td>
									</tr>
									<tr>
										<th class="ques">질문</th>
										<td>
											<c:out value="${result.question }"/>
										</td>
									</tr>
									<tr>
										<th class="answ">답변</th>
										<td>
											<c:out value="${result.answer }"/>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</c:if>
				</c:forEach>
				<c:forEach items="${profList }" var="prof" varStatus="status">
					<p class="sub-title mt50">
						<img alt="<c:out value='${prof.imgName }'/>" src="<c:url value='/showImage.do?filePath=${prof.imgPath }'/>" style="width:113px; height:151px;">
						<span class="prof">선생님</span> : <c:out value="${prof.name }"/>
					</p>
					<c:forEach items="${resultList }" var="result" varStatus="status">
						<c:if test="${result.quesType eq 'PRF' && prof.lectTea eq result.profCode }">
							<div class="list-table-box">
								<table class="normal-wmv-table">
									<colgroup>
										<col width="10%"/>
										<col />
									</colgroup>
									<tbody>
										<tr>
											<th class="sect">조사구분</th>
											<td class="phrTit"><c:out value="${result.phrTitle }"/></td>
										</tr>
										<tr>
											<th class="ques">질문</th>
											<td>
												<c:out value="${result.question }"/>
											</td>
										</tr>
										<tr>
											<th class="answ">답변</th>
											<td>
												<c:out value="${result.answer }"/>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</c:if>
					</c:forEach>
				</c:forEach>
				<!-- table button -->
				<div class="table-button">
					<div class="btn-box">
						<a href="#" onclick="fn_close();" class="white btn-cancel">닫기</a>
					</div>
				</div>
				<!--// table button -->
			</div>
		</div>
	</div>
	<!--// contents -->
</body>
</html>