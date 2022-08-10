<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">
	
	// 팝업 쿠키 생성
	function setCookie(name, value, expiredays){ 
		var todayDate = new Date(); 
		todayDate.setDate( todayDate.getDate() + expiredays ); 
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";" 
	} 

	// 팝업창 닫기
	function closeWin(){
		if ($("input:checkbox[name=dayClose]").is(":checked")){
			setCookie("wcPopup<c:out value='${popupVO.popSeq}'/>", "no" , 1);
		} 
		self.close();
	}

</script>
<body>
<div class="pop_wrap">
	<c:if test="${!empty popupVO.popImgPath }">
		<c:if test="${!empty popupVO.popUrl }">
			<a href="${popupVO.popUrl }" target="_blank">
				<img src="<c:out value='/showImage.do?filePath=${popupVO.popImgPath }'/>" alt="" style="width: 100%;"/>
			</a>
		</c:if>
		<c:if test="${empty popupVO.popUrl }">
			<img src="<c:out value='/showImage.do?filePath=${popupVO.popImgPath }'/>" alt="" style="width: 100%;"/>
		</c:if>
	</c:if>
	<c:out value="${popupVO.popContent }" escapeXml="false"/>
	<%--
	<div class="btn_box">
		<a href="#" class="btn_go_list">바로가기</a>
	</div>
	--%>
	<div class="pop_foot">
		<ul>
			<li><input type="checkbox" name="dayClose" id="dayClose" /> <label for="dayClose">하루 창 열지 않기</label> </li>
			<li><a href="#" onclick="closeWin(); return false;">닫기</a></li>
		</ul>
	</div>
</div>
</body>
</html>