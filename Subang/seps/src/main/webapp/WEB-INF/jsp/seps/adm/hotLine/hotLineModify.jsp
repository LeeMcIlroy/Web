<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="common" 	uri="/WEB-INF/tld/common.tld"%>
<!doctype html>
<html lang="kr">
<c:import url="/EgovPageLink.do?link=inc/incHead" />
<script type="text/javascript">

	var flag = false;
	$(function(){
		
		$("input:file").change(function() {
			var fileSize = -1;
			if(this.files){
				fileSize = this.files[0].size;
			}
			fileCheck_adm(this.id, fileSize);
			flag = true;
		})
	});


	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/adm/hotLine/hotLineList.do'/>").submit();
	}
	
	// 저장
	function fn_modify(){
		if(!flag){
			var regExp = /^[0-9]*$/;
			
			if($("#hotLineDept").val() == ""){
				alert("소속은 필수선택 항목입니다.");
				return false;
			}
			
			if($("#hotLineName").val() == ""){
				alert("이름은 필수입력 항목입니다.");
				return false;
			}
			
			if($("#hotLineTel1").val() == "" || $("#hotLineTel2").val() == "" || $("#hotLineTel3").val() == ""){
				alert("연락처는 필수입력 항목입니다.");
				return false;
			}
			
			if(!regExp.test($('#hotLineTel2').val()) || !regExp.test($('#hotLineTel3').val())){
				alert('숫자만 입력가능합니다.');
				return false;
			}
		}
		
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/adm/hotLine/hotLineSubmit.do'/>").submit();
	}
	
</script>
<body>
<form:form commandName="hotLineVO" id="frm" name="frm" enctype="multipart/form-data">
<form:hidden path="hotLineId"/>
	<!-- top menu - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/inc/incTopnav"/>
	<!-- top menu - end -->
	<div class="m_body">
		<!-- WEB LEFT_MENU -->
		<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=adm/inc/incLeftnav"/>
		<!--// WEB LEFT_MENU -->
		<div class="main_content">
			<!-- PAGE_TITLE -->
			<div class="page_title">비상연락망</div>
			<!--// PAGE_TITLE -->
			<div class="content">
				<div class="cont_box">
					<div>
						<div>
							<table class="input_table">
								<colgroup>
									<col width="15%" />
									<col width="85%" />
								</colgroup>
								<tbody>
									<tr>
										<th>*기관</th>
										<td>
											<form:input path="hotLineDept"/>
										</td>
									</tr>
									<tr>
										<th>*이름</th>
										<td>
											<form:input path="hotLineName"/>
										</td>
									</tr>
									<tr>
										<th>*연락처</th>
										<td>
											<form:select path="hotLineTel1" style="width: 70px;">
												<form:option value="">선택</form:option>
												<form:option value="010">010</form:option>
												<form:option value="011">011</form:option>
												<form:option value="02">02</form:option>
												<form:option value="031">031</form:option>
												<form:option value="032">032</form:option>
												<form:option value="033">033</form:option>
												<form:option value="041">041</form:option>
												<form:option value="042">042</form:option>
												<form:option value="043">043</form:option>
												<form:option value="044">044</form:option>
												<form:option value="051">051</form:option>
												<form:option value="052">052</form:option>
												<form:option value="053">053</form:option>
												<form:option value="054">054</form:option>
												<form:option value="055">055</form:option>
												<form:option value="061">061</form:option>
												<form:option value="062">062</form:option>
												<form:option value="063">063</form:option>
												<form:option value="064">064</form:option>
												<form:option value="070">070</form:option>
											</form:select>
											-<form:input path="hotLineTel2" maxlength="4" style="width:70px;"/>-<form:input path="hotLineTel3" maxlength="4" style="width:70px;"/>
										</td>
									</tr>
									<tr>
										<th>이메일</th>
										<td>
											<form:input path="hotLineEmail1"/>@
											<form:select path="hotLineEmail2">
												<form:option value="">선택</form:option>
												<form:option value="sisul.or.kr">sisul.or.kr</form:option>
												<form:option value="gmail.com">gmail.com</form:option>
												<form:option value="naver.com">naver.com</form:option>
											</form:select>
										</td>
									</tr>
									<tr>
										<th>엑셀업로드</th>
										<td>
											<div>
												<input type="file" name="attachFile" id="attachFile_hotLine" class="ch_file"/><br/>
												<span class="alt_txt">첨부파일은 최대 5MB까지 첨부 가능합니다.  (xlsx 파일만 첨부 됩니다)</span>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
							<div class="btn_box">
								<button class="btn_list" onclick="fn_modify(); return false;">저장</button>
								<button class="btn_list" onclick="fn_list(); return false;">목록</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- footer - start -->
	<c:import url="${pageContext.request.contextPath }/EgovPageLink.do?link=inc/incFooter"/>
	<!-- footer - end -->
	
<!-- 목록 검색조건 - start -->
<input type="hidden" id="searchCondition1" name="searchCondition1" value="${searchVO.searchCondition1 }">
<input type="hidden" id="searchCondition2" name="searchCondition2" value="${searchVO.searchCondition2 }">
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }">
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }">
<!-- 목록 검색조건 - end -->
</form:form>
</body>
</html>