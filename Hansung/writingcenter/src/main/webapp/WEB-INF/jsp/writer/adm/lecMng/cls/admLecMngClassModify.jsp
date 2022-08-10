<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javaScript">
	
	// 등록
	function fn_update(){
		if($("#clsTitle").val() == ''){
			alert("타이틀을 입력해주세요.");
			$("#clsTitle").focus();
			return false;
		}
		
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lecMng/cls/admLecMngClassUpdate.do'/>").submit();
	}

	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/lecMng/cls/admLecMngClassList.do'/>").submit();
	}
	
</script>
<body>
<form:form commandName="classVO" id="frm" name="frm">
<form:hidden path="clsSeq" />
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
		<c:import url="/EgovPageLink.do?link=adm/inc/incLeftmenu" />
		<!--// lnb -->
		<!-- content -->
		<div class="content" id="content">
			<!-- 타이틀 영역 -->
			<jsp:include page="/WEB-INF/jsp/writer/adm/inc/incPageTitle.jsp">
            	<jsp:param name="dept1" value="강의실관리"/>
            	<jsp:param name="dept2" value="교수님 생성"/>
            </jsp:include>
			<div class="cont_box">
			<!-- content -->
				<!-- table -->
				<table class="view_tbl_03 mb30 mt30" summary="교수님 생성 관리">
					<caption>교수님 생성</caption>
					<colgroup>
						<col width="20%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr class="first" style="height:85px;">
							<th scope="row">* 타이틀</th>
							<td>
								<form:input path="clsTitle" style="width:100%;" />
								<div class="alt_txt" style="margin-top: 5px;">
									* '-' 을 입력하시면 문단이 바뀝니다.<br/>&nbsp;&nbsp;&nbsp;ex&gt; N(인문)-나은미 교수님 → [화면에서] N(인문) {다음단락} 나은미 교수님
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">* 학기 강의실 선택</th>
							<td>
								<form:select path="smtrSeq" class="se_base">
									<form:options items="${smtrList }" itemLabel="smtrTitle" itemValue="smtrSeq" />
								</form:select>
							</td>
						</tr>
						<tr>
							<th scope="row">계열 선택</th>
							<td>
								<form:select path="deptSeq" class="se_base">
									<form:options items="${deptList }" itemLabel="deptTitle" itemValue="deptSeq" />
								</form:select>
							</td>
						</tr>
						<tr>
							<th scope="row">주제 등록 및<br />첨삭 가능자 선택</th>
							<td>
								<c:forEach items="${memList }" var="mem">
									<input type="checkbox" id="memSeqChk${mem.memSeq }" name="memSeqChk" value="${mem.memSeq }" <c:if test="${mem.athrYn eq 'Y' }">checked</c:if>/>
									<label for="memSeqChk${mem.memSeq }"><c:out value="${mem.memName }"/></label>
								</c:forEach>
							</td>
							<%--
							<td>
								<p>
									<input type="checkbox" name="" id="p64_01" /> <label for="p64_01">홍길동</label>&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="" id="p64_02" /> <label for="p64_02">홍길동</label>&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="" id="p64_03" /> <label for="p64_03">홍길동</label>&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="" id="p64_04" /> <label for="p64_04">홍길동</label>&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="" id="p64_05" /> <label for="p64_05">홍길동</label>
								</p>
								<p>
									<input type="checkbox" name="" id="p64_06" /> <label for="p64_06">홍길동</label>&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="" id="p64_07" /> <label for="p64_07">홍길동</label>&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="" id="p64_08" /> <label for="p64_08">홍길동</label>&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="" id="p64_09" /> <label for="p64_09">홍길동</label>&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="" id="p64_10" /> <label for="p64_10">홍길동</label>&nbsp;&nbsp;&nbsp;
								</p>
								<p>
									<input type="checkbox" name="" id="p64_11" /> <label for="p64_11">홍길동</label>&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="" id="p64_12" /> <label for="p64_12">홍길동</label>&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="" id="p64_13" /> <label for="p64_13">홍길동</label>&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="" id="p64_14" /> <label for="p64_14">홍길동</label>&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="" id="p64_15" /> <label for="p64_15">홍길동</label>&nbsp;&nbsp;&nbsp;
								</p>
								<p>
									<input type="checkbox" name="" id="p64_16" /> <label for="p64_16">홍길동</label>&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="" id="p64_17" /> <label for="p64_17">홍길동</label>&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="" id="p64_18" /> <label for="p64_18">홍길동</label>&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="" id="p64_19" /> <label for="p64_19">홍길동</label>&nbsp;&nbsp;&nbsp;
									<input type="checkbox" name="" id="p64_20" /> <label for="p64_20">홍길동</label>
								</p>
							</td>
							--%>
						</tr>
						<tr>
							<th scope="row">순서</th>
							<td><form:input path="clsSort" style="width:50px; ime-mode: disabled;" onkeydown="return showKeyCode(event);"/></td>
						</tr>
						<tr>
							<th scope="row">View 여부</th>
							<td>
								<form:select path="clsViewYn" class="se_base">
									<form:option value="Y">보이기</form:option>
									<form:option value="N">숨기기</form:option>
								</form:select>
                            </td>
						</tr>
						<c:if test="${sessionScope.adminSession.memLevel ne '3' }">
							<tr>
								<th scope="row">블랙보드 링크</th>
								<td><form:input path="clsLink" style="width:100%;"/></td>
							</tr>
						</c:if>
					</tbody>
				</table>
				<div class="btm_area">
					<div class="btn_box">
						<div class="btn_r">
							<a href="#" class="b_type02" onclick="fn_update(); return false;">
								<c:if test="${empty classVO.clsSeq }">저장</c:if>
								<c:if test="${!empty classVO.clsSeq }">수정</c:if>
							</a>
							<a href="#" class="b_type03" onclick="fn_list(); return false;">목록</a>
						</div>
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

<input type="hidden" id="message" value="${message}" />
<input type="hidden" name="pageIndex" id="pageIndex" value="${searchVO.pageIndex }"/>
</form:form>
</body>
</html>