<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	   uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko" >
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javascript">
$(function(){
	// 파일업로드 조건 확인
	$("input:file").change(function() {
		var fileSize = -1;
		if(this.files){
			fileSize = this.files[0].size;
		}
		fileCheck_adm(this.id, fileSize);
		
	})
	
	$("#tcMCode").on("change", function(){
		subject = $("#tcMCode option:selected").val();
		$("input [name='tcSubject']").prop("checked","false");
		$("#subject").empty();
		subjectList = $("#subjectList").val();
		var tags = "";
		tags += "<ul>";
		if(subject == '01'){
			tags += "<li><input type='checkbox' name='tcSubject'";
			if(subjectList.indexOf('인테리어디자인') != -1){
				tags += "checked";
			}
			tags += " value='인테리어디자인'/>인테리어디자인</li>";
			tags += "<li><input type='checkbox' name='tcSubject'";
			if(subjectList.indexOf('무대디자인') != -1){
				tags += "checked";
			}
			tags += "  value='무대디자인'/>무대디자인</li>";
			tags += "<li><input type='checkbox' name='tcSubject'"; 
			if(subjectList.indexOf('가구디자인') != -1){
				tags += "checked";
			}
			tags += " value='가구디자인'/>가구디자인</li>";
			tags += "<li><input type='checkbox' name='tcSubject'";
			if(subjectList.indexOf('VMD') != -1){
				tags += "checked";
			}
			tags += " value='VMD'/>VMD</li>";
			tags += "<li><input type='checkbox' name='tcSubject'";
			if(subjectList.indexOf('건축공간디자인') != -1){
				tags += "checked";
			}
			tags += " value='건축공간디자인'/>건축공간디자인</li>";
		}else if(subject == '02'){
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('시각 패키지디자이너') != -1){
				tags += "checked";
			}
			tags += " value='시각 패키지디자이너'/>시각 패키지디자이너</li>";
			tags += "<li><input type='checkbox'  name='tcSubject'";
			if(subjectList.indexOf('광고/브랜드디자이너') != -1){
				tags += "checked";
			}
			tags += "  value='광고/브랜드디자이너'/>광고/브랜드디자이너</li>";
			tags += "<li><input type='checkbox'  name='tcSubject' ";
			if(subjectList.indexOf('일러스트레이션 전문가') != -1){
				tags += "checked";
			}
			tags +="  value='일러스트레이션 전문가'/>일러스트레이션 전문가</li>";
			tags += "<li><input type='checkbox'  name='tcSubject' ";
			if(subjectList.indexOf('웹 UI/UX 디자이너') != -1){
				tags += "checked";
			}
			tags += " value='웹 UI/UX 디자이너'/>웹 UI/UX 디자이너</li>";
		}else if(subject == '03'){
			tags += "<li><input type='checkbox'  name='tcSubject' ";
			if(subjectList.indexOf('제품·자동차디자인') != -1){
				tags += "checked";
			}
			tags += " value='제품·자동차디자인'/>제품·자동차디자인</li>";
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('리빙디자인') != -1){
				tags += "checked";
			}
			tags +="  value='리빙디자인'/>리빙디자인</li>";
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('주얼리디자인') != -1){
				tags += "checked";
			}
			tags +=" value='주얼리디자인'/>주얼리디자인</li>";
		}else if(subject == '04'){
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('영상디자인') != -1){
				tags += "checked";
			}
			tags +=" value='영상디자인'/>영상디자인</li>";
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('디지털애니메이션 전문가') != -1){
				tags += "checked";
			}
			tags +=" value='디지털애니메이션 전문가'/>디지털애니메이션 전문가</li>";
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('만화콘텐츠') != -1){
				tags += "checked";
			}
			tags +=" value='만화콘텐츠'/>만화콘텐츠</li>";
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('성우콘텐츠 크리에이터') != -1){
				tags += "checked";
			}
			tags +=" value='성우콘텐츠 크리에이터'/>성우콘텐츠 크리에이터</li>";
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('보이스크리에이터') != -1){
				tags += "checked";
			}
			tags +=" value='보이스크리에이터'/>보이스크리에이터</li>";
		}else if(subject == '05'){
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('패션디자인') != -1){
				tags += "checked";
			}
			tags += " value='패션디자인'/>패션디자인</li>";
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('패션스타일링') != -1){
				tags += "checked";
			}
			tags += " value='패션스타일링'/>패션스타일링</li>";
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('패션소재/텍스타일 디자인') != -1){
				tags += "checked";
			}
			tags += " value='패션소재/텍스타일 디자인'/>패션소재/텍스타일 디자인</li>";
		}else if(subject == '06'){
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('패션마케팅') != -1){
				tags += "checked";
			}
			tags += " value='패션마케팅'/>패션마케팅</li>";
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('패션기획&연출') != -1){
				tags += "checked";
			}
			tags += " value='패션기획&연출'/>패션기획&연출</li>";
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('패션창업') != -1){
				tags += "checked";
			}
			tags += " value='패션창업'/>패션창업</li>";
		}else if(subject == '07'){
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('헤어디자인') != -1){
				tags += "checked";
			}
			tags += " value='헤어디자인'/>헤어디자인</li>";
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('메이크업디자인') != -1){
				tags += "checked";
			}
			tags += " value='메이크업디자인'/>메이크업디자인</li>";
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('피부디자인') != -1){
				tags += "checked";
			}
			tags += " value='피부디자인'/>피부디자인</li>";
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('네일디자인') != -1){
				tags += "checked";
			}
			tags += " value='네일디자인'/>네일디자인</li>";
		}else if(subject == '08'){
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('헤어디자인') != -1){
				tags += "checked";
			}
			tags += " value='헤어디자인'/>헤어디자인</li>";
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('메이크업디자인') != -1){
				tags += "checked";
			}
			tags += " value='메이크업디자인'/>메이크업디자인</li>";
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('피부디자인') != -1){
				tags += "checked";
			}
			tags += " value='피부디자인'/>피부디자인</li>";
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('네일디자인') != -1){
				tags += "checked";
			}
			tags += " value='네일디자인'/>네일디자인</li>";
		}else if(subject == '11'){
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('방송크리에이터') != -1){
				tags += "checked";
			}
			tags += " value='방송크리에이터'/>방송크리에이터</li>";
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('성우') != -1){
				tags += "checked";
			}
			tags += " value='성우'/>성우</li>";
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('e스포츠') != -1){
				tags += "checked";
			}
			tags += " value='e스포츠'/>e스포츠</li>";
			tags += "<li><input type='checkbox' name='tcSubject' ";
			if(subjectList.indexOf('게임일러스트레이션 전문가') != -1){
				tags += "checked";
			}
			tags +=" value='게임일러스트레이션 전문가'/>게임일러스트레이션 전문가</li>";
		}
		$("#subject").append(tags);
		tags += "</ul>";
		
	});
});
	// 등록
	function fn_update(){
		$("#tcContent").val(CKEDITOR.instances.tcContent.getData());
		
		if($("input[name='tcSubject']").is(":checked") == false){
			alert("과목을 선택해주세요.");
			return false;
		}else if($("#tcName").val() == ''){
			alert("이름을 입력해주세요.");
			$("#tcName").focus();
			return false;
		}else if($("#tcContent").val() == ''){
			alert("내용을 입력해주세요.");
			return false;
		
<c:if test="${empty teacherVO.tcSeq}">
		}else if($("#attachedFile_1").val() == ''){
			alert("썸네일을 등록해주세요");
			return false;
</c:if>
		}
		
		$("#frm").attr("method","post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/teacher/admMajorTeacherUpdate.do'/>").submit();
	}
	
	// 목록으로 이동
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/qxerpynm/majorBoard/teacher/admMajorTeacherList.do'/>").submit();
	}
	
	
	// 파일 다운로드
	function fn_filedownload(cbSeq, type){
		location.href = "<c:out value='${pageContext.request.contextPath}/cmmn/file/downloadFile.do'/>?fileId="+cbSeq+"&type="+type;
	}

</script>
<body>
<form:form commandName="teacherVO" id="frm" name="frm" enctype="multipart/form-data">
<form:hidden path="tcSeq"/>
<input type="hidden" id="subjectList" value="${teacherVO.tcSubject }"/>
<input type="hidden" id="tcupSeq" name="tcupSeq" value="${tcUpfileList.tcupSeq }">
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="searchCondition1" name="searchCondition1" value="${searchVO.searchCondition1 }"/>
<input type="hidden" id="searchCondition2" name="searchCondition2" value="${searchVO.searchCondition2 }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<div class="wrap">
	<!-- 스킵 네비게이션 -->
	<div id="skip_navigation">
		<ul>
			<li><a href="#gnb">주 메뉴 바로가기</a></li>
			<li><a href="#content">본문 바로가기</a></li>
		</ul>
	</div>
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incTopnav" />
	<!--// header -->
	<hr />
	<p class="container_top_bg"></p>
	<!-- container -->
	<div class="container">
		<!-- lnb -->
		<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu"/>
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<!-- 타이틀 영역 -->
			<div class="title_area">
				<jsp:include page="/WEB-INF/jsp/hsDesign/adm/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="전공"/>
		            <jsp:param name="dept2" value="교수소개"/>
            	</jsp:include>
			</div>
			<div class="cont_box">
			<!-- content -->
				<!-- table -->
				<div class="tbl_top_area2 mt30">
					<div class="btn_r">
						* 는 필수 입력항목입니다.
					</div>
				</div>
				<table class="view_tbl_03 mb30" summary="교수소개">
					<caption>교수소개</caption>
					<colgroup>
						<col width="20%" />
						<col width="80%" />
					</colgroup>
					<tbody>
						<tr class="first">
							<th scope="row">* 전공</th>
							<td>
								<c:if test="${!empty teacherVO.tcSeq }">
									<form:select path="tcMCode" class="se_base w150" >
										<c:forEach var="list" items="${majorList }">
											<c:if test="${list.mCode < 10 }">
												<form:option value="${list.mCode }"><c:out value="${list.mName }"/></form:option>
											</c:if>
										</c:forEach>
									</form:select>
								</c:if>
								<c:if test="${empty teacherVO.tcSeq }">
									<select id="tcMCode" name="tcMCode" class="se_base w150" >
										<c:forEach var="list" items="${majorList }">
											<c:if test="${list.mCode < 10 }">
												<option value="${list.mCode }" <c:if test="${list.mCode eq searchVO.searchCondition1 }" > selected="selected" </c:if> > <c:out value="${list.mName }"/> </option>
											</c:if>
										</c:forEach>
									</select>
								</c:if>
							</td>
						</tr>
						<tr>
							<th scope="row">* 과목</th>
							<td>
								<div id="subject">
									<ul>
									<c:if test="${!empty teacherVO.tcSeq }">
										<c:choose>
											<c:when test="${teacherVO.tcMCode eq '02' }">
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'시각 패키지디자이너') }">checked</c:if> value='시각 패키지디자이너'/>시각 패키지디자이너</li>
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'광고/브랜드디자이너') }">checked</c:if> value='광고/브랜드디자이너'/>광고/브랜드디자이너</li>
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'일러스트레이션 전문가') }">checked</c:if> value='일러스트레이션 전문가'/>일러스트레이션 전문가</li>
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'웹 UI/UX 디자이너') }">checked</c:if> value='웹 UI/UX 디자이너'/>웹 UI/UX 디자이너</li>
											</c:when>
											<c:when test="${teacherVO.tcMCode eq '03' }">
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'제품·자동차디자인') }">checked</c:if> value='제품·자동차디자인'/>제품·자동차디자인</li>
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'리빙디자인') }">checked</c:if> value='리빙디자인'/>리빙디자인</li>
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'주얼리디자인') }">checked</c:if> value='주얼리디자인'/>주얼리디자인</li>
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'제품·리빙디자인') }">checked</c:if> value='제품·리빙디자인'/>제품·리빙디자인</li>
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'자동차디자인') }">checked</c:if> value='자동차디자인'/>자동차디자인</li>
											</c:when>
											<c:when test="${teacherVO.tcMCode eq '04' }">
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'영상디자인') }">checked</c:if> value='영상디자인'/>영상디자인</li>
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'디지털애니메이션 전문가') }">checked</c:if> value='디지털애니메이션 전문가'/>디지털애니메이션 전문가</li>
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'만화콘텐츠') }">checked</c:if> value='만화콘텐츠'/>만화콘텐츠</li>
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'게임일러스트레이션 전문가') }">checked</c:if> value='게임일러스트레이션 전문가'/>게임일러스트레이션 전문가</li>
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'성우콘텐츠 크리에이터') }">checked</c:if> value='성우콘텐츠 크리에이터'/>성우콘텐츠 크리에이터</li>
											</c:when>
											<c:when test="${teacherVO.tcMCode eq '05' }">
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'패션디자인') }">checked</c:if> value='패션디자인'/>패션디자인</li>
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'패션스타일링') }">checked</c:if> value='패션스타일링'/>패션스타일링</li>
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'패션소재/텍스타일 디자인') }">checked</c:if> value='패션소재/텍스타일 디자인'/>패션소재/텍스타일 디자인</li>
											</c:when>
											<c:when test="${teacherVO.tcMCode eq '06' }">
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'패션마케팅') }">checked</c:if> value='패션마케팅'/>패션마케팅</li>
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'패션기획&연출') }">checked</c:if> value='패션기획&연출'/>패션기획&연출</li>
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'패션창업') }">checked</c:if> value='패션창업'/>패션창업</li>
											</c:when>
											<c:when test="${teacherVO.tcMCode eq '07' }">
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'헤어디자인') }">checked</c:if> value='헤어디자인'/>헤어디자인</li>
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'메이크업디자인') }">checked</c:if> value='메이크업디자인'/>메이크업디자인</li>
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'피부디자인') }">checked</c:if> value='피부디자인'/>피부디자인</li>
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'네일디자인') }">checked</c:if> value='네일디자인'/>네일디자인</li>		
											</c:when>
											<c:when test="${teacherVO.tcMCode eq '08' }">
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'헤어디자인') }">checked</c:if> value='헤어디자인'/>헤어디자인</li>
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'메이크업디자인') }">checked</c:if> value='메이크업디자인'/>메이크업디자인</li>
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'피부디자인') }">checked</c:if> value='피부디자인'/>피부디자인</li>
												<li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'네일디자인') }">checked</c:if> value='네일디자인'/>네일디자인</li>
											</c:when>
											<c:otherwise>
								<%--				   <li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'VMD') }">checked</c:if> value='VMD'/>VMD</li> --%>
							<%--                                     <li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'무대디자인') }">checked</c:if> value='무대디자인'/>무대디자인</li> --%>
                                    <li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'인테리어디자인') }">checked</c:if> value='인테리어디자인'/>인테리어디자인</li>
                                    <li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'가구디자인') }">checked</c:if> value='가구디자인'/>가구디자인</li>
                                    <li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'건축공간디자인') }">checked</c:if> value='건축공간디자인'/>건축공간디자인</li>
                                    <li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'부동산브랜드마케팅') }">checked</c:if> value='부동산브랜드마케팅'/>부동산브랜드마케팅</li>
                                    <li><input type="checkbox" name="tcSubject" <c:if test="${fn:contains(teacherVO.tcSubject,'특강강사') }">checked</c:if> value='특강강사'/>특강강사</li>											</c:otherwise>
										</c:choose>
									</c:if>
									<c:if test="${empty teacherVO.tcSeq }">
										<c:choose>
											<c:when test="${searchVO.searchCondition1 eq '02' }">
												<li><input type="checkbox" name="tcSubject" value='시각 패키지디자이너'/>시각 패키지디자이너</li>
												<li><input type="checkbox" name="tcSubject" value='광고/브랜드디자이너'/>광고/브랜드디자이너</li>
												<li><input type="checkbox" name="tcSubject" value='일러스트레이션 전문가'/>일러스트레이션 전문가</li>
												<li><input type="checkbox" name="tcSubject" value='웹 UI/UX 디자이너'/>웹 UI/UX 디자이너</li>
											</c:when>
											<c:when test="${searchVO.searchCondition1 eq '03' }">
												<li><input type="checkbox" name="tcSubject" value='제품·자동차디자인'/>제품·자동차디자인</li>
												<li><input type="checkbox" name="tcSubject" value='리빙디자인'/>리빙디자인</li>
												<li><input type="checkbox" name="tcSubject" value='주얼리디자인'/>주얼리디자인</li>
												<li><input type="checkbox" name="tcSubject" value='제품·리빙디자인'/>제품·리빙디자인</li>
												<li><input type="checkbox" name="tcSubject" value='자동차디자인'/>자동차디자인</li>
											</c:when>
											<c:when test="${searchVO.searchCondition1 eq '04' }">
												<li><input type="checkbox" name="tcSubject" value='영상디자인'/>영상디자인</li>
												<li><input type="checkbox" name="tcSubject" value='디지털애니메이션 전문가'/>디지털애니메이션 전문가</li>
												<li><input type="checkbox" name="tcSubject" value='만화콘텐츠'/>만화콘텐츠</li>
												<li><input type="checkbox" name="tcSubject" value='게임일러스트레이션 전문가'/>게임일러스트레이션 전문가</li>
												<li><input type="checkbox" name="tcSubject" value='성우콘텐츠 크리에이터'/>성우콘텐츠 크리에이터</li>
											</c:when>
											<c:when test="${searchVO.searchCondition1 eq '05' }">
												<li><input type="checkbox" name="tcSubject" value='패션디자인'/>패션디자인</li>
												<li><input type="checkbox" name="tcSubject" value='패션스타일링'/>패션스타일링</li>
												<li><input type="checkbox" name="tcSubject" value='패션소재/텍스타일 디자인'/>패션소재/텍스타일 디자인</li>
											</c:when>
											<c:when test="${searchVO.searchCondition1 eq '06' }">
												<li><input type="checkbox" name="tcSubject" value='패션마케팅'/>패션마케팅</li>
												<li><input type="checkbox" name="tcSubject" value='패션기획&연출'/>패션기획&연출</li>
												<li><input type="checkbox" name="tcSubject" value='패션창업'/>패션창업</li>
											</c:when>
											<c:when test="${searchVO.searchCondition1 eq '07' }">
												<li><input type="checkbox" name="tcSubject" value='헤어디자인'/>헤어디자인</li>
												<li><input type="checkbox" name="tcSubject" value='메이크업디자인'/>메이크업디자인</li>			
												<li><input type="checkbox" name="tcSubject" value='피부디자인'/>피부디자인</li>
												<li><input type="checkbox" name="tcSubject" value='네일디자인'/>네일디자인</li>																						
											</c:when>
											<c:when test="${searchVO.searchCondition1 eq '08' }">
												<li><input type="checkbox" name="tcSubject" value='헤어디자인'/>헤어디자인</li>
												<li><input type="checkbox" name="tcSubject" value='메이크업디자인'/>메이크업디자인</li>
												<li><input type="checkbox" name="tcSubject" value='피부디자인'/>피부디자인</li>
												<li><input type="checkbox" name="tcSubject" value='네일디자인'/>네일디자인</li>
											</c:when>
											<c:otherwise>
												<li><input type="checkbox" name="tcSubject" value='건축공간디자인'/>건축공간디자인</li>
												<li><input type="checkbox" name="tcSubject" value='인테리어디자인'/>인테리어디자인</li>
<!-- 												<li><input type="checkbox" name="tcSubject" value='무대디자인'/>무대디자인</li> -->
												<li><input type="checkbox" name="tcSubject" value='가구디자인'/>가구디자인</li>
<!-- 												<li><input type="checkbox" name="tcSubject" value='VMD'/>VMD</li> -->
												<li><input type="checkbox" name="tcSubject" value='부동산브랜드마케팅'/>부동산브랜드마케팅</li>
												<li><input type="checkbox" name="tcSubject" value='특강강사'/>특강강사</li>
											</c:otherwise>
										</c:choose>
									</c:if>
									</ul>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">* 이름</th>
							<td>
								<form:input path="tcName" class="in_base" style="width:80%;" maxlength="30" />
							</td>
						</tr>
						<tr>
							<th scope="row">* 썸네일 이미지</th>
							<td>
								<ul class="file_up">
									<li id="imageUpfile" >
										<c:if test="${!empty tcUpfileList.tcupSeq }">
					       				<input type="file" id="attachedFile_1" name="attachedFile_1" class="file"/>
					        				<a href="#" onclick="fn_filedownload(<c:out value='${tcUpfileList.tcupSeq}'/>, 'teacher'); return false;"><c:out value='${tcUpfileList.tcupOriginFilename}'/></a>
										</c:if>
										<c:if test="${empty tcUpfileList.tcupSeq }">
											<input type="file" id="attachedFile_1" name="attachedFile_1" class="file"/>
										</c:if>
									</li>
								</ul>
								<div id="imageTxt" class="alt_txt" style="margin-left:197px;" >JPG, GIF, PNG 형식으로 입력해 주세요 (최대 15MB)</div>
							</td>
						</tr>
						<tr>
							<th scope="row">노출순서</th>
							<td>
								<form:input path="turn" class="in_base" style="width:20%; ime-mode: disabled; "  onkeydown="return showKeyCode(event);" maxlength="4"  />
							</td>
						</tr>
						<tr>
							<td colspan="2" class="editer">
								<form:textarea path="tcContent" style="width:100%;height: 250px;margin-top: 5px;margin-bottom: 5px;ime-mode:active;"/>
								<script type="text/javascript">
									CKEDITOR.replace( 'tcContent', {
										filebrowserImageUploadUrl: "<c:out value='${pageContext.request.contextPath}/cmmn/ckeditor/uploadCkeditorFile.do'/>"
									});
								</script>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btn_box">
					<div class="btn_r">
						<a href="#"  class="b_type04" onclick="fn_update(); return false;">저장</a>
						<a href="#"  class="b_type03" onclick="fn_list(); return false;">목록</a>
					</div>
				</div>
			<!-- //content -->
			</div>
		</div>
		<!--// content -->
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=adm/inc/incFooter" />
	<!--// footer -->
</div>
</form:form>
</body>
</html>