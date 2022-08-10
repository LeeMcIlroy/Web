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
		$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath }/usr/jobs/worknet/recruitment/recruList.do'/>").submit();
	}
	
	$(document).ready(function() {
		//var giNo = ${giNo}
		var wantedAuthNo = '${wantedAuthNo}';
		$.ajax({
		 //	url : "/usr/jobs/worknet/recruitment/AjaxRecruView.do?giNo="+giNo
		 	url : "/usr/jobs/worknet/recruitment/AjaxRecruView.do?wantedAuthNo="+wantedAuthNo

			,type : "post"
			,data : JSON
			,dataType : 'json'
			,contentType: "application/json; charset=UTF-8"
			,success : function(data) {
				var resultList = data.resultList;
				var pList = JSON.parse(resultList);
				var rsList = pList.wantedDtl;
				console.log(pList)
				//console.log(pList)
				//console.log(rsList)
				//var empchargeInfoList = rsList.empchargeInfo;
				//var corpInfoList = rsList.corpInfo;
				//var wantedInfoList = rsList.wantedInfo;

				//console.log(rsList)
			//	console.log(wantedInfoList.dtlRecrContUrl)
				var html = '';
				
				html += '<div class="tbl_view">';
				html += '<dl>';
				html += '	<dt style="font-weight: bold; font-size : 20px;"><br/>&nbsp;&nbsp;<br/> <br/></dt>';
				html += '	<hr/ style="    visibility: visible; border:1px solid #cccccc;">';
				html += '	<dt style="font-weight: bold;"><br/> ○ 모집요강<br/> <br/></dt>';
				html += '	<dd>';
				html += '		<table class="rec_tbl">';
				html += '			<colgroup>';
				html += '				<col  style="width:20%;" />';
				html += '				<col />';
				html += '			</colgroup>';
				html += '			<tbody>';
				html += '				<tr>';
				html += '					<th>회사명</th>';
				html += '					<td>'+corpInfoList.corpNm+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>직무내용</th>';
				html += '					<td>'+wantedInfoList.jobCont+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>접수마감일</th>';
				var receiptCloseDt = wantedInfoList.receiptCloseDt.toString();
				html += '					<td>'+receiptCloseDt.substr(2,2)+'/'+receiptCloseDt.substr(4,2)+'/'+receiptCloseDt.substr(6,2)+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>고용형태</th>';
				html += '					<td>'+wantedInfoList.empTpNm+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>모집인원</th>';
				html += '					<td>'+wantedInfoList.collectPsncnt+'명</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>경력조건</th>';
				html += '					<td>'+wantedInfoList.enterTpNm+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>학력</th>';
				html += '					<td>'+wantedInfoList.eduNm+'</td>';
				html += '				</tr>';
				html += '			</tbody>';
				html += '		</table>';
				html += '	</dd>';
				html += '</dl>';
				html += '<dl>';
				html += '	<dt style="font-weight: bold;"><br/> ○ 근무조건  <br/> <br/></dt>';
				html += '	<dd>';
				html += '		<table class="rec_tbl">';
				html += '			<colgroup>';
				html += '				<col  style="width:20%;" />';
				html += '				<col />';
				html += '			</colgroup>';
				html += '			<tbody>';
				html += '				<tr>';
				html += '					<th>임금조건</th>';
				html += '					<td>'+wantedInfoList.salTpNm.substr(0,2)+' '+wantedInfoList.salTpNm.substr(2)+'</td>';
				html += '				</tr>';
				
					const str = wantedInfoList.workdayWorkhrCont;
				const words = str.split(',');
				
				html += '				<tr>';
				html += '					<th>근무시간</th>';
				html += '					<td>'+words[0]+'<br/>'+words[2]+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>근무형태</th>';
				html += '					<td>'+words[1]+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>사회보험</th>';
				html += '					<td>'+wantedInfoList.fourIns+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>퇴직금</th>';
				html += '					<td>'+wantedInfoList.retirepay+'</td>';
				html += '				</tr>';
				html += '			</tbody>';
				html += '		</table>';
				html += '	</dd>';
				html += '</dl>';
				html += '<dl>';
				html += '	<dt style="font-weight: bold;"><br/> ○ 전형방법 <br/> <br/></dt>';
				html += '	<dd>';
				html += '		<table class="rec_tbl">';
				html += '			<colgroup>';
				html += '				<col  style="width:20%;" />';
				html += '				<col />';
				html += '			</colgroup>';
				html += '			<tbody>';
				html += '				<tr>';
				html += '					<th>전형방법</th>';
				html += '					<td>'+wantedInfoList.selMthd+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>접수방법</th>';
				html += '					<td>'+wantedInfoList.rcptMthd+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>제출서류양식 첨부</th>';
 				html += '					<td>'+wantedInfoList.corpAttachList.attachFileUrl+'</td>';
				html += '					<td>-</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>제출서류 준비물</th>';
				html += '					<td>'+wantedInfoList.submitDoc+'</td>';
				html += '				</tr>';
				html += '			</tbody>';
				html += '		</table>';
				html += '	</dd>';
				html += '</dl>';
				html += '<dl>';
				html += '<dt style="font-weight: bold;"><br/> ○ 우대사항 <br/> <br/></dt>';
				html += '	<dd>';
				html += '		<table class="rec_tbl">';
				html += '			<colgroup>';
				html += '				<col  style="width:20%;" />';
				html += '				<col />';
				html += '			</colgroup>';
				html += '			<tbody>';
				html += '				<tr>';
				html += '					<th>외국어능력</th>';
				html += '					<td>'+wantedInfoList.forLang+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>전공</th>';
				html += '					<td>'+wantedInfoList.major+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>자격먼허</th>';
				html += '					<td>'+wantedInfoList.certificate+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>병역특례채용희망</th>';
				html += '					<td>'+wantedInfoList.mltsvcExcHope+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>컴퓨터활용능력</th>';
				html += '					<td>'+wantedInfoList.compAbl+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>우대조건</th>';
				html += '					<td>'+wantedInfoList.pfCond+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>장애인 채용희망</th>';
				html += '					<td>-</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>기타 우대사항</th>';
				html += '					<td>'+wantedInfoList.etcPfCond+'</td>';
				html += '				</tr>';
				html += '			</tbody>';
				html += '		</table>';
				html += '	</dd>';
				html += '</dl>';
				html += '<dl>';
				html += '	<dt style="font-weight: bold;"><br/> ○ 복리후생 <br/> <br/></dt>';
				html += '	<dd>';
				html += '		<table class="rec_tbl">';
				html += '			<colgroup>';
				html += '				<col  style="width:20%;" />';
				html += '				<col />';
				html += '			</colgroup>';
				html += '			<tbody>';
				html += '				<tr>';
				html += '					<th>복리후생</th>';
				html += '					<td>'+wantedInfoList.etcWelfare+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>기타 복리후생</th>';
				html += '					<td>-</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>장애인 편의시설</th>';
				html += '					<td>'+wantedInfoList.disableCvntl+'</td>';
				html += '				</tr>';
				html += '			</tbody>';
				html += '		</table>';
				html += '	</dd>';
				html += '</dl>';
				html += '<dl>';
				html += '	<dt style="font-weight: bold;"><br/> ○ 위치정보 <br/> <br/></dt>';
				html += '	<dd>';
				html += '		<table class="rec_tbl">';
				html += '			<colgroup>';
				html += '				<col  style="width:20%;" />';
				html += '				<col />';
				html += '			</colgroup>';
				html += '			<tbody>';
				html += '				<tr>';
				html += '					<th>근무예정지</th>';
				html += '					<td>'+wantedInfoList.workRegion+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>소속산업단지</th>';
				html += '					<td>'+wantedInfoList.indArea+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>인근전철역</th>';
				html += '					<td>'+wantedInfoList.nearLine+'</td>';
				html += '				</tr>';
				html += '			</tbody>';
				html += '		</table>';
				html += '	</dd>';
				html += '</dl>';
				html += '<dl>';
				html += '	<dt style="font-weight: bold;"><br/> ○ 기타사항 <br/> <br/></dt>';
				html += '	<dd>';
				html += '		<table class="rec_tbl">';
				html += '			<colgroup>';
				html += '				<col  style="width:20%;" />';
				html += '				<col />';
				html += '			</colgroup>';
				html += '			<tbody>';
				html += '				<tr>';
				html += '					<th>추가조건</th>';
				html += '					<td>-</td>';
				html += '				</tr>';
				html += '			</tbody>';
				html += '		</table>';
				html += '	</dd>';
				html += '</dl>';
				html += '<dl>';
				html += '	<dt style="font-weight: bold;"><br/> ○ 채용담당자 <br/> <br/></dt>';
				html += '	<dd>';
				html += '		<table class="rec_tbl">';
				html += '			<colgroup>';
				html += '				<col  style="width:20%;" />';
				html += '				<col />';
				html += '			</colgroup>';
				html += '			<tbody>';
				html += '				<tr>';
				html += '					<th>부서/담당자</th>';
				html += '					<td>'+empchargeInfoList.empChargerDpt+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>전화번호</th>';
				html += '					<td>'+empchargeInfoList.contactTelno+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>팩스번호</th>';
				html += '					<td>'+empchargeInfoList.chargerFaxNo+'</td>';
				html += '				</tr>';
				html += '			</tbody>';
				html += '		</table>';
				html += '	</dd>';
				html += '</dl>';
/* 				html += '<dl>';
				html += '	<dt style="font-weight: bold;"><br/> ○ 위치정보 <br/> <br/></dt>';
				html += '	<dd>';
				html += '		<table class="rec_tbl">';
				html += '		<colgroup>';
				html += '			<col  style="width:20%;" />';
				html += '			<col />';
				html += '		</colgroup>';
				html += '			<tbody>';
				html += '				<tr>';
				html += '					<th>근무예정지</th>';
				html += '					<td>'+wantedInfoList.+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>소속산업단지</th>';
				html += '					<td>'+wantedInfoList.+'</td>';
				html += '				</tr>';
				html += '				<tr>';
				html += '					<th>인근전철역</th>';
				html += '					<td>'+wantedInfoList.+'</td>';
				html += '				</tr>';
				html += '			</tbody>';
				html += '		</table>';
				html += '	</dd>';
				html += '</dl>'; */
				html += '</div> ';
			
				html += '<div class="btn_box">';
				html += '<a href="http://www.work.go.kr/empInfo/empInfoSrch/detail/empDetailAuthView.do?callPage=detail&wantedAuthNo='+rsList.wantedAuthNo+'" class="btn_go_list"  target="_blank" title="새창열림" style="width: 300px;">채용정보 제공사이트로 이동</a>';
//				모바일 url : http://m.work.go.kr/regionJobsWorknet/jobDetailView2.do?srchInfotypeNm=VALIDATION&srchWantedAuthNo=
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
		            <jsp:param name="dept2" value="채용정보"/>
	           	</jsp:include>
	           	<div><input type="hidden" id="wantedAuthNo" value="${wantedAuthNo}"/></div>
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