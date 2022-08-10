<!-- 200414추가 -->
<!-- 200420수정 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko" >
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script type="text/javascript">
	
	//목록으로 이동
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/jobs/worknet/breakingNews/brNewsList.do'/>").submit();
	}
	
	String.prototype.replaceAll = function(org, dest) {
	    return this.split(org).join(dest);
	}
	
	$(document).ready(function() {
		var empSeqno = $("#empSeqno").val();
		$.ajax({
			url : "/usr/jobs/worknet/breakingNews/AjaxbrNewsView.do?empSeqno="+empSeqno
			,type : "post"
			,data : JSON
			,dataType : 'json'
			,contentType: "application/json; charset=UTF-8"
			,success : function(data) {
				var resultList = data.resultList;
				var pList = JSON.parse(resultList);
				var rsList = pList.dhsOpenEmpInfoDetailRoot;

				var html = '';
				console.log(rsList)
				
				html += '<div class="tbl_view">';
				html += '<dl>';
				html += '	<dt style="font-weight: bold; font-size : 20px;"><br/>&nbsp;&nbsp;'+rsList.empWantedTitle+'<br/> <br/></dt>';
				html += '	<hr/ style="    visibility: visible; border:1px solid #cccccc;">';
				html += '	<dt style="font-weight: bold;"><br/>○ 모집부분 및 자격요건<br/> <br/></dt>';
				html += '	<dd>';
				html += '		<table class="rec_tbl">';
				html += '			<colgroup>';
				html += '				<col  style="width:20%;" />';
				html += '				<col />';
				html += '			</colgroup>';
				html += '			<tbody>';
				html += '				<tr>';
				html += '					<th>회사명</th>';
				html += '					<td>'+rsList.empBusiNm+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>고용형태</th>';
				html += '					<td>'+rsList.empWantedTypeNm+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>공통사항</th>';
				html += '					<td>'+rsList.recrCommCont+'</td>';
				html += '				</tr>';
				///////////////////////////////////////////////////////
				if(rsList.empRecrList.empRecrListInfo.length > 1){
					html += '				<tr>';
					html += '					<th>채용부문</th>';
					html += '					<td>'+rsList.empRecrList.empRecrListInfo[0].empRecrNm+'</td>';
					html += '				</tr>';
				
// 				var sptCertEtc = rsList.empRecrList.empRecrListInfo[0].sptCertEtc;
// 				sptCertEtc = sptCertEtc.replaceAll("-","<br/> -");
					
					html += '				<tr>';
					html += '					<th>수행업무 및 역할</th>';
					html += '					<td>'+rsList.empRecrList.empRecrListInfo[0].sptCertEtc+'</td>';
// 				html += '					<td>'+sptCertEtc+'</td>';
					html += '				</tr>';
				
// 				var jobCont = rsList.empRecrList.empRecrListInfo[0].jobCont;
// 				jobCont = jobCont.replaceAll("-","<br/> -");
				
					html += '				<tr>';
					html += '					<th>상세내용</th>';
					html += '					<td>'+rsList.empRecrList.empRecrListInfo[0].jobCont+'</td>';
					html += '				</tr>';
					html += '				<tr>';
					html += '					<th>지원자격</th>';
					html += '					<td>'+rsList.empRecrList.empRecrListInfo[0].empWantedEduNm+' | '+rsList.empRecrList.empRecrListInfo[0].empWantedCareerNm+'</td>';
					html += '				</tr>';
					html += '				<tr>';
					html += '					<th>지역</th>';
					html += '					<td>'+rsList.empRecrList.empRecrListInfo[0].workRegionNm+'</td>';
					html += '				</tr>';
				}else{
					html += '				<tr>';
					html += '					<th>채용부문</th>';
					html += '					<td>'+rsList.empRecrList.empRecrListInfo.empRecrNm+'</td>';
					html += '				</tr>';
					
//	 				var sptCertEtc = rsList.empRecrList.empRecrListInfo.sptCertEtc;
//	 				sptCertEtc = sptCertEtc.replaceAll("-","<br/> -");
					
					html += '				<tr>';
					html += '					<th>수행업무 및 역할</th>';
					html += '					<td>'+rsList.empRecrList.empRecrListInfo.sptCertEtc+'</td>';
//	 				html += '					<td>'+sptCertEtc+'</td>';
					html += '				</tr>';
					
//	 				var jobCont = rsList.empRecrList.empRecrListInfo.jobCont;
//	 				jobCont = jobCont.replaceAll("-","<br/> -");
					
					html += '				<tr>';
					html += '					<th>상세내용</th>';
					html += '					<td>'+rsList.empRecrList.empRecrListInfo.jobCont+'</td>';
					html += '				</tr>';
					html += '				<tr>';
					html += '					<th>지원자격</th>';
					html += '					<td>'+rsList.empRecrList.empRecrListInfo.empWantedEduNm+' | '+rsList.empRecrList.empRecrListInfo.empWantedCareerNm+'</td>';
					html += '				</tr>';
					html += '				<tr>';
					html += '					<th>지역</th>';
					html += '					<td>'+rsList.empRecrList.empRecrListInfo.workRegionNm+'</td>';
					html += '				</tr>';
				}
				///////////////////////////////////////////////////////
				html += '			</tbody>';
				html += '		</table>';
				html += '	</dd>';
				html += '</dl>';
				html += '<dl>';
				html += '	<dt style="font-weight: bold;"><br/>○ 전형절차 및 일정  <br/><br/>서류전형 > 1차면접 > 2차면접 > 인적성검사 > 건강검진 > 기타<br/><br/></dt>';
				html += '	<dd>';
				html += '		<table class="rec_tbl">';
				html += '			<colgroup>';
				html += '				<col  style="width:20%;" />';
				html += '				<col />';
				html += '			</colgroup>';
				html += '			<tbody>';
				html += '				<tr>';
				html += '					<th>기타</th>';
				html += '					<td>'+rsList.empSelsList.empSelsListInfo[rsList.empSelsList.empSelsListInfo.length-1].selsCont+'</td>';
				html += '				</tr>';
				html += '			</tbody>';
				html += '		</table>';
				html += '	</dd>';
				html += '</dl>';
				html += '<dl>';
				html += '	<dt style="font-weight: bold;"><br/>○ 접수기간 및 접수방법 <br/> <br/></dt>';
				html += '	<dd>';
				html += '		<table class="rec_tbl">';
				html += '			<colgroup>';
				html += '				<col  style="width:20%;" />';
				html += '				<col />';
				html += '			</colgroup>';
				html += '			<tbody>';
				html += '				<tr>';
				html += '					<th>접수기간</th>';
				var empWantedStdt = rsList.empWantedStdt.toString();
				var empWantedEndt = rsList.empWantedEndt.toString();
				html += '					<td>'+empWantedStdt.substr(2,2)+'/'+empWantedStdt.substr(4,2)+'/'+empWantedStdt.substr(6,2)+'&nbsp;~&nbsp;'+empWantedEndt.substr(2,2)+'/'+empWantedEndt.substr(4,2)+'/'+empWantedEndt.substr(6,2)+'</td>';
				html += '				</tr>';

// 				var empRcptMthdCont = rsList.empRcptMthdCont;
// 				empRcptMthdCont = empRcptMthdCont.replaceAll("※","<br/>※");
// 				empRcptMthdCont = empRcptMthdCont.replaceAll("1)","<br/>1)");
// 				empRcptMthdCont = empRcptMthdCont.replaceAll("2)","<br/>2)");
// 				empRcptMthdCont = empRcptMthdCont.replaceAll("3)","<br/>3)");
// 				empRcptMthdCont = empRcptMthdCont.replaceAll("4)","<br/>4)");
// 				empRcptMthdCont = empRcptMthdCont.replaceAll("5)","<br/>5)");
// 				empRcptMthdCont = empRcptMthdCont.replaceAll("6)","<br/>6)");
				
				html += '				<tr>';
				html += '					<th>접수방법</th>';
				html += '					<td>'+rsList.empRcptMthdCont+'</td>';
				html += '				</tr>';
				
// 				var empSubmitDocCont = rsList.empSubmitDocCont;
// 				empSubmitDocCont = empSubmitDocCont.replaceAll(".",".<br/>");
				
				html += '				<tr>';
				html += '					<th>제출서류</th>';
				html += '					<td>'+rsList.empSubmitDocCont+'</td>';
				html += '				</tr>';
				html += '			</tbody>';
				html += '		</table>';
				html += '	</dd>';
				html += '</dl>';
				html += '<dl>';
				html += '<dt style="font-weight: bold;"><br/>○ 기타<br/> <br/></dt>';
				html += '	<dd>';
				html += '		<table class="rec_tbl">';
				html += '			<colgroup>';
				html += '				<col  style="width:20%;" />';
				html += '				<col />';
				html += '			</colgroup>';
				html += '			<tbody>';
				html += '				<tr>';
				html += '					<th>문의사항</th>';
				html += '					<td>'+rsList.inqryCont+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>기타사항</th>';
				html += '					<td>'+rsList.empnEtcCont+'</td>';
				html += '				</tr>';
				html += '			</tbody>';
				html += '		</table>';
				html += '	</dd>';
				html += '</dl>';
				html += '</div> ';
			
				html += '<div class="btn_box">';
				html += '<a href="'+rsList.empWantedHomepgDetail+'" class="btn_go_list" style="width: 300px;" target="_blank" title="새창열림">공채속보 제공사이트로 이동</a>';
				html += '</div>';
				
			$(".view").append(html);
				
//					console.log(rsList.wanted[0].maxSal)
			}
		});
//			return false;
})
	
</script>
<body>
<form:form commandName="searchVO" id="frm" name="frm">
	<!-- skip_navigation -->
	<dl id="skip_nav">
		<dt>바로가기 메뉴</dt>
		<dd><a href="#content">본문 바로가기</a></dd>
		<dd><a href="#top_menu">메뉴 바로가기</a></dd>
		<dd><a href="#footer">페이지 하단 바로가기</a></dd>
	</dl>
	<!-- //skip_navigation -->
	<div class="content">
	<!-- header -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
	<!--// header -->
	<!-- container -->
	<div class="main_content" id="content">
		<div class="width_box">
			<!-- lnb -->
			<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu"/>
			<!--// lnb -->
			<!-- content -->
			<div class="sub_content">
				<!-- 타이틀 영역 -->
				<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle.jsp">
					<jsp:param name="dept1" value="취업센터"/>
		            <jsp:param name="dept2" value="공채속보"/>
	           	</jsp:include>
	           	<div><input type="hidden" id="empSeqno" value="${empSeqno}"/></div>
	           	<div id="viewPage">
					<div class="transform_table notice_type">
						<div class="view"></div>
					</div>
					<div class="btn_box">
						<a href="#" class="btn_go_del" onclick="fn_list(); return false;">전체글보기</a>
					</div>
				</div>
			</div>
			<!--// content -->
		</div>
	</div>
	<!--// container -->
	<hr />
	<!-- footer -->
	<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
	<!--// footer -->
</div>
<input type="hidden" id="message" value="${message}" />
</form:form>
</body>
</html>