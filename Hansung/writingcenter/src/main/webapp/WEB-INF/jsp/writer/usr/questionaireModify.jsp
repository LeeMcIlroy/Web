<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script>


	$(function(){
		<c:if test="${finish eq true}">
			window.close();
		</c:if>
		
		$(document).on("keyup", "textarea", function(){
			var memCode = "<c:out value='${sessionScope.userSession.memCode}'/>"
			
			if(memCode == ""){
				alert("로그인이 필요합니다.");
				location.href="http://writingcenter.hansung.ac.kr/usr/lgn/login.do";

			}
			
	        if($(this).val().length > 100) {
	            $(this).val($(this).val().substring(0, 100));
	        }
			var content = $(this).val();
			$(this.nextElementSibling).html(content.length + '/100');
		});
		
		
		

		
	});

	
	function fn_deptSelect(me){

		$("select[name='clsSeq']").attr("name","clsList").val("");
		$("select[name='clsList']").hide();
		
		$("select[name='clsDummy']").show();
		$("#clsDummy"+$(me).val()).hide();
		$("#clsSeq"+$(me).val()).attr("name","clsSeq").show();
		
	} 

	function fn_update(){
		if($("input[name='deptSeq']").is(":checked") == false){
			alert("강의실을 선택해주세요");
			return false;
		}
		if($("select[name='clsSeq']").val()==''){
			alert("강의를 선택해주세요");
			return false;
		}
		for(i=0;i<$("#ansListCnt").val();i++){
			
		/* 	var textId = $("input[name='ansList["+i+"].preNo']:checked").attr('id');
		  	var lblTxt = ($("label[for="+textId+"]").text());
		  	 
			if(lblTxt.indexOf('기타') == 0 && $.trim($("textarea[name='ansList["+i+1+"].pansTxt']").val()) == "" ){
				return true;
			} */
			 if($("input[name='ansList["+i+"].preNo']").length == 0 && $.trim($("textarea[name='ansList["+i+"].pansTxt']").val()) == "" && $("input[name='ansChk["+i+"]']").val() == 'Y'){
				alert("답변을 입력해주세요.");
				return false;
			}
				
	
	/* 		if($("input[name='ansList["+i+"].preNo']").length == 0 && $.trim($("textarea[name='ansList["+i+"].pansTxt']").val()) == ""){
				alert("답변을 입력해주세요.");
				return false;
			} */
			if($("input[name='ansList["+i+"].preNo']").length > 0 && $("input[name='ansList["+i+"].preNo']").is(":checked") == false){
				alert("답변을 선택해주세요.");
				return false;
			}
		
		}
		
		if(confirm("설문을 제출하면 수정이 불가능 합니다.\n제출하시겠습니까?")){
			
			$("#frm").attr("action","<c:out value='${pageContext.request.contextPath }/usr/main/questionaireUpdate.do'/>").submit();
		/* 
			alert("설문이 완료되었습니다.");
			window.close();
			 */
			
			
		}else{
			return false;
		}
	}
	

</script>
<body>
<form id="frm">
<input type="hidden" name="qstnrSeq" id="qstnrSeq" value="<c:out value='${resultVO.qstnrSeq }'/>" />
<c:set var="cnt" value="0"/>
<div class="pop_wrap w800">
	<div class="pop_cont w740" style="margin:0 auto;">
		<div><img src="<c:out value='${pageContext.request.contextPath }/assets/usr/img/pt47_top_visual.jpg'/>" alt="" /></div>
		<div class="pt47_tit"><c:out value="${resultVO.qstnrTitle }"/></div>
		<div class="mid_tit">나의 강의실은?</div>
		<div class="aw_box mb50">
			<div class="cont radio_input li2 in_se_h35">
				<ul>
					<c:forEach var="dept" items="${deptList }" varStatus="status">
						<li class="mb10 ">
							<input type="radio" name="deptSeq" id="pt4701_rc0<c:out value='${dept.deptSeq }'/>" value="<c:out value='${dept.deptSeq }'/>" onchange="fn_deptSelect(this); return false;"/>&nbsp;&nbsp;&nbsp;<label for="pt4701_rc0${dept.deptSeq }" style="width:100px; display:inline-block;"  ><c:out value="${dept.deptTitle }"/></label>
								
								<select name="clsList" id="clsSeq<c:out value='${dept.deptSeq }'/>" class="w90" style="display: none;" >
									<option value="">강의실</option>
									<c:forEach var="cls" items="${clsList }">
										<c:if test="${dept.deptSeq eq cls.deptSeq }">
											<option value="<c:out value='${cls.clsSeq }'/>"><c:out value="${cls.clsTitle }"/></option>
										</c:if>
									</c:forEach>
								</select>
								<select name="clsDummy" id="clsDummy<c:out value='${dept.deptSeq }'/>" class="w90" >
									<option value="">강의실</option>
								</select>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<c:forEach var="askList" items="${qestnarAskList }" varStatus="askStatus">
			<div class="aw_box mb20">
				<ul class="aw_tit">
					<li><c:out value="${askList.askNo }"/></li>
					<li>
						<c:out value="${askList.askContent }"/>
						<c:if test="${askList.askChk eq 'Y' }">
						<span style="color: red">[필수]</span>
						</c:if>
						<!--<c:if test="${askList.askType eq '3' }">(100자이내)</c:if>-->
					</li>
				</ul>
				<div class="cont check_input">
					<div class="cont check_input">
						<c:if test="${askList.askType eq '3' }">
							<textarea rows="5" cols="90" id="ansList[<c:out value='${askStatus.index }'/>].pansTxt" name="ansList[<c:out value='${askStatus.index }'/>].pansTxt"></textarea>
							<div style="text-align: right;">0/100</div>
							<input type="hidden" name="ansChk[<c:out value='${askStatus.index }'/>]" value="${askList.askChk }"></input>
						</c:if>
						<c:if test="${askList.askType ne '3' }">
							<ul>
								<c:forEach var="repList" items="${qestnarReplyList }" varStatus="repStatus">
									<c:if test="${askList.askNo eq repList.askNo }">
										<li style="display:block; margin-bottom:10px;">
											<c:if test="${askList.askType eq 2 }">
												<input type="checkbox" name="ansList[<c:out value='${askStatus.index }'/>].preNo" id="repNo<c:out value="${askList.askNo }"/><c:out value="${repList.repNo }"/>" value="<c:out value='${repList.repNo }'/>"/>
												<input type="hidden" name="ansChk[<c:out value='${askStatus.index }'/>]" value="${askList.askChk }"></input>
											</c:if>
											<c:if test="${askList.askType eq 1 }">
												<input type="radio" name="ansList[<c:out value='${askStatus.index }'/>].preNo" id="repNo<c:out value="${askList.askNo }"/><c:out value="${repList.repNo }"/>" value="<c:out value='${repList.repNo }'/>"/>
												<input type="hidden" name="ansChk[<c:out value='${askStatus.index }'/>]" value="${askList.askChk }"></input>
											</c:if>
											<label for="repNo<c:out value="${askList.askNo }"/><c:out value="${repList.repNo }"/>"><c:out value="${repList.repContent }"/></label>
										</li>
									</c:if>
								</c:forEach>
							</ul>
						</c:if>
					</div>
				</div>
			</div>
			<input type="hidden" name="ansList[<c:out value='${askStatus.index }'/>].askNo" value="<c:out value='${askList.askNo }'/>" />
			<input type="hidden" name="ansList[<c:out value='${askStatus.index }'/>].askType" value="<c:out value='${askList.askType }'/>" />
			<c:set var="cnt" value="${cnt+1 }"/>
		</c:forEach>
		<input type="hidden" id="ansListCnt"  value="${cnt }"/>
		<!-- 하단 영역 -->
		<div class="btm_area">
			<div class="btn_box">
				<div class="btn_c">
					<a href="#" class="btn_re_finishi" onclick="fn_update(); return false;">설문완료</a>
				</div>
			</div>
		</div>
		<!-- 하단 영역 -->
	</div>
</div>
<input type="hidden" id="message" name="message" value="${message }"/>
</form>
</body>
</html>