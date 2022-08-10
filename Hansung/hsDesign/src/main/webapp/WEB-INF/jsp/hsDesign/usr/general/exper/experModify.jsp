<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<c:import url="/EgovPageLink.do?link=usr/inc/incHead" />
<script>
	$(function(){
		// datepicker input click
		$(document).on("click", ".datepicker", function(){
			$(this).next().click();
		});
	});

	// 신청
	function fn_update(){
		//var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		
		if($("#exaAplyName").val() == ''){
			alert("신청자명을 입력해주세요.");
			return false;
		}else if($("#exaSchName").val() == ''){
			alert("학교명을 선택해주세요.");
			 return false;
		}else if($("#exaTel1").val() == '' || $("#exaTel2").val() == '' || $("#exaTel3").val() == ''){
			alert("연락처를 입력해주세요.");
			 return false;
		}else if($("#exaEmail").val() == ''){
			alert("이메일을 입력해주세요.");
			 return false;
		}else if(!$.trim($("#exaEmail").val()).match(regExp)){
			alert("이메일 형식에 맞지 않습니다. 다시 입력해주세요.");
			 return false;
		}else if($("#exaStDate").val() == '' || $("#exaEnDate").val() == ''){
			alert("신청일정을 선택해주세요.");
			return false;
		}else if($("input:checkbox[name=excCd]:checked").length == 0){
			alert("체험과정을 선택해주세요.");
			return false;
		}else if($("#chkBox").is(":checked") == false){
			alert("개인정보 수집동의를 확인해 주세요.");
			return false;
		}
		if(confirm("작성된 내용으로 신청하시겠습니까?\n신청한 내용은 조회가 불가능합니다.")){
			$("#frm").attr("method", "post").attr("action", "<c:out value='${pageContext.request.contextPath}/usr/general/exper/experUpdate.do'/>").submit();
		}
	}
	
</script>
<body>
<form id="frm" name="frm">
	<!-- skip_navigation -->
	<dl id="skip_nav">
		<dt>바로가기 메뉴</dt>
		<dd><a href="#content">본문 바로가기</a></dd>
		<dd><a href="#top_menu">메뉴 바로가기</a></dd>
		<dd><a href="#footer">페이지 하단 바로가기</a></dd>
	</dl>
	<!-- //skip_navigation -->
	<div class="content">
		<!-- header area -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incTopnav" />
		<!-- header area -->
		<div class="main_content" id="content">
			<div class="width_box">
				<!-- left menu area-->
				<c:import url="/EgovPageLink.do?link=usr/inc/incLeftmenu"/>
				<!-- //left menu area-->
				<div class="sub_content">
					<!-- 타이틀 영역 -->
					<jsp:include page="/WEB-INF/jsp/hsDesign/usr/inc/incPageTitle.jsp">
						<jsp:param name="dept1" value="진로체험"/>
			            <jsp:param name="dept2" value="진로체험신청"/>
		           	</jsp:include>
					<div class="transform_table notice_type">
						<div class="tbl_write">
							<ul class="tbl_view_m">
								<li class="txt_left w100p " style="width: 150px;">* 신청자명</li>
								<li><input type="text" id="exaAplyName" name="exaAplyName"></li>
							</ul>
							<ul class="tbl_view_m">
								<li class="txt_left w100p " style="width: 150px;">* 학교명</li>
								<li><input type="text" id="exaSchName" name="exaSchName"><span style="margin-left: 10px;">ex. 한성여자고등학교 </span></li>
							</ul>
							<ul class="tbl_view_m">
								<li class="txt_left w100p " style="width: 150px;">* 연락처</li>
								<li>
									<select id="exaTel1" name="exaTel1" style="min-width: 5%;">
										<option value="010">010</option>
										<option value="011">011</option>
									</select>
									&nbsp;-&nbsp;<input type="text" id="exaTel2" name="exaTel2" style="width: 50px;text-align: center;" maxlength="4">
									&nbsp;-&nbsp;<input type="text" id="exaTel3" name="exaTel3" style="width: 50px;text-align: center;" maxlength="4">
								</li>
							</ul>
							<ul class="tbl_view_m">
								<li class="txt_left w100p " style="width: 150px;">* 이메일</li>
								<li><input type="text" id="exaEmail" name="exaEmail" style="width: 200px;"><span style="margin-left: 10px;">ex. example@naver.com</span></li>
							</ul>
							<ul class="tbl_view_m">
								<li class="txt_left w100p " style="width: 150px;">* 신청일정</li>
								<li>
									<input type="text" id="exaStDate" name="exaStDate" class="datepicker" style="width: 90px;text-align: center;" readonly="readonly"/>
									~
									<input type="text" id="exaEdDate" name="exaEdDate" class="datepicker" style="width: 90px;text-align: center;" readonly="readonly"/>
								</li>
							</ul>
							<ul class="tbl_view_m">
								<li class=" txt_left w100p" style="width: 150px;">* 체험과정<br>(복수선택가능)</li>
								<li>
<!-- 		200407주석				<ul class="experCoure"> 
										<li><input type="checkbox" id="excCd01" name="excCd" value="01"><label for="excCd01">시각패키지디자이너</label></li>
										<li><input type="checkbox" id="excCd02" name="excCd" value="02"><label for="excCd02">광고디자이너(광고마케팅)</label></li>
										<li><input type="checkbox" id="excCd03" name="excCd" value="03"><label for="excCd03">동화일러스트작가</label></li>
										<li><input type="checkbox" id="excCd04" name="excCd" value="04"><label for="excCd04">웹코딩(웹디자이너)</label></li>
										<li><input type="checkbox" id="excCd05" name="excCd" value="05"><label for="excCd05">영상디자이너/방송PD</label></li>
										<li><input type="checkbox" id="excCd06" name="excCd" value="06"><label for="excCd06">웹툰/게임그래픽작가</label></li>
										<li><input type="checkbox" id="excCd07" name="excCd" value="07"><label for="excCd07">실내건축디자이너</label></li>
										<li><input type="checkbox" id="excCd08" name="excCd" value="08"><label for="excCd08">주얼리디자이너</label></li>
										<li><input type="checkbox" id="excCd09" name="excCd" value="09"><label for="excCd09">패션디자이너</label></li>
										<li><input type="checkbox" id="excCd10" name="excCd" value="10"><label for="excCd10">패션코디/패션스타일리스트</label></li>
										<li><input type="checkbox" id="excCd11" name="excCd" value="11"><label for="excCd11">뷰티메이크업 코디네이터</label></li>
										<li><input type="checkbox" id="excCd12" name="excCd" value="12"><label for="excCd12">헤어코디네이터</label></li>
									</ul>-->
<!-- 									200407추가 -->
								<div class="ta_smallbox">
								<table class="ta874_ty07">
									<colgroup>
										<col width="20%"/>
										<col />
									</colgroup>
									<thead>
										<tr style="height: 40px;">
											<th scope="col" colspan="3">디자인(IT융합)</th>
										</tr>
										<tr style="height: 30px;">
											<th scope="col">전공</th>
											<th scope="col">내용</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>실내디자인</td>
											<td>
												<input type="checkbox" id="excCd01" name="excCd" value="01"><label for="excCd01"> 인테리어디자이너</label><br />
												<input type="checkbox" id="excCd02" name="excCd" value="02"><label for="excCd02"> 크리에이티브 건축디자이너 </label><br />
												<input type="checkbox" id="excCd03" name="excCd" value="03"><label for="excCd03"> 스마트 빌딩 디자이너 </label><br />
												<input type="checkbox" id="excCd04" name="excCd" value="04"><label for="excCd04"> 무대연출디자이너</label><br />
											</td>
										</tr>
										<tr>
											<td>시각디자인</td>
											<td>
												<input type="checkbox" id="excCd05" name="excCd" value="05"><label for="excCd05"> 미디어그래픽디자이너</label><br />
												<input type="checkbox" id="excCd06" name="excCd" value="06"><label for="excCd06"> 스마트패키징디자이너</label><br />
												<input type="checkbox" id="excCd07" name="excCd" value="07"><label for="excCd07"> 동화일러스트작가</label><br />
												<input type="checkbox" id="excCd08" name="excCd" value="08"><label for="excCd08"> 북아트미디어디자이너</label><br />
												<input type="checkbox" id="excCd09" name="excCd" value="09"><label for="excCd09"> 웹코딩(웹디자이너)</label><br />
												<input type="checkbox" id="excCd10" name="excCd" value="10"><label for="excCd10"> 타이포그래픽디자이너</label><br />
												<input type="checkbox" id="excCd11" name="excCd" value="11"><label for="excCd11"> 콘텐츠광고매체자이너</label><br />
												<input type="checkbox" id="excCd12" name="excCd" value="12"><label for="excCd12"> 모바일캐릭터디자이너</label><br />
												<input type="checkbox" id="excCd13" name="excCd" value="13"><label for="excCd13"> 엔터테인먼트 아트워크(예술가)</label><br />
											</td>
										</tr>
										<tr>
											<td>산업디자인</td>
											<td>
												<input type="checkbox" id="excCd14" name="excCd" value="14"><label for="excCd14"> 스마트 자동차디자이너</label><br />
												<input type="checkbox" id="excCd15" name="excCd" value="15"><label for="excCd15"> 이두이노제품디자이너금속주얼리 디자이너(<label style="color: red;">고등학생 이상 신청</label>)</label><br />
												<input type="checkbox" id="excCd16" name="excCd" value="16"><label for="excCd16"> 라이프스타일디자이너</label><br />
											</td>
										</tr>
										<tr>
											<td>디지털아트</td>
											<td>
												<input type="checkbox" id="excCd17" name="excCd" value="17"><label for="excCd17"> 유튜버(크리에이터)</label><br />
												<input type="checkbox" id="excCd18" name="excCd" value="18"><label for="excCd18"> 웹툰(만화) 크리에이터</label><br />
												<input type="checkbox" id="excCd19" name="excCd" value="19"><label for="excCd19"> 영상미디어디자이너</label><br />
												<input type="checkbox" id="excCd20" name="excCd" value="20"><label for="excCd20"> e 스포츠(준비중)</label><br />
											</td>
										</tr>
									</tbody>
								</table>
								<br />
								<table class="ta874_ty07">
									<colgroup>
										<col width="20%"/>
										<col />
									</colgroup>
									<thead>
										<tr style="height: 40px;">
											<th scope="col" colspan="3">패션(IT융합)</th>
										</tr>
										<tr style="height: 30px;">
											<th scope="col">전공</th>
											<th scope="col">내용</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>패션디자인<br>패션 비즈니스</td>
											<td>
												<input type="checkbox" id="excCd21" name="excCd" value="21"><label for="excCd21"> 패션디자이너 </label><br />
												<input type="checkbox" id="excCd22" name="excCd" value="22"><label for="excCd22"> 패션스타일리스트  </label><br />
												<input type="checkbox" id="excCd23" name="excCd" value="23"><label for="excCd23"> 디지털 패션크리에이터</label><br />
											</td>
										</tr>
									</tbody>
								</table>
								<br />
								<table class="ta874_ty07">
									<colgroup>
										<col width="20%"/>
										<col />
									</colgroup>
									<thead>
										<tr style="height: 40px;">
											<th scope="col" colspan="3">뷰티(IT융합)</th>
										</tr>
										<tr style="height: 30px;">
											<th scope="col">전공</th>
											<th scope="col">내용</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>미용학</td>
											<td>
												<input type="checkbox" id="excCd24" name="excCd" value="24"><label for="excCd24"> AI메디컬스킨테어</label><br />
												<input type="checkbox" id="excCd25" name="excCd" value="25"><label for="excCd25"> AI스마트 메이크업 컨설턴트  </label><br />
												<input type="checkbox" id="excCd26" name="excCd" value="26"><label for="excCd26"> 뷰티크리에이터 </label><br />
												<input type="checkbox" id="excCd27" name="excCd" value="27"><label for="excCd27"> 퍼스널컬러네일아티스트  </label><br />
												<input type="checkbox" id="excCd28" name="excCd" value="28"><label for="excCd28"> 화장품브랜딩디자이너   </label><br />
											</td>
										</tr>
									</tbody>
								</table>
							</div>
								</li>
							</ul>
							<input type="checkbox" id="chkBox" ><label for="chkBox" style="margin-left: 4px;">개인정보 수집동의  (입력된 정보는 진로체험신청 업무에만 사용됩니다.)</label>
						</div>
						<div style="margin-top: 10px;font-weight: bolder;">※ 진로체험신청은 학교의 진로담당 선생님만 가능합니다.<br/>
						※ 교육비용은 1인당 1만원(유동적이오니 접수시 문의해주시기 바랍니다)<br/>
						※ 교육장소는 한성대학교내로 구체적인 장소는 접수시 문의해주시기 바랍니다.<br/>
						※ 진로학기의 경우 <a href="http://www.sbcareer.or.kr/main/program/view.php?prdcode=1910160005&dep_code=&dep2_code=&page=1&" style="color: #00B0F0;">성북진로센터</a>,
						 <a href="http://www.youthdream.kr/bbs_shop/read.htm?me_popup=&auto_frame=&cate_sub_idx=0&list_mode=board&board_code=notice&search_key=&key=&page=2&idx=92573
						 " style="color: #00B0F0;">동작구진로직업체험지원센터</a> 에서도 신청 가능합니다.<br/></div>
					</div>
					<div class="btn_box">
						<a href="#" class="btn_go_list" onclick="fn_update(); return false;">신청하기</a>
					</div>

					<!-- rolling banner -->
					<c:import url="/EgovPageLink.do?link=usr/inc/incRollingBanner"/>
					<!-- //rolling banner -->
				</div>
			</div>
		</div>
		<!-- footer -->
		<c:import url="/EgovPageLink.do?link=usr/inc/incFooter" />
		<!--// footer -->
	</div>
<input type="hidden" id="message" value="${message}" />
</form>
</body>
<style>
	.experCoure li label{margin-left: 4px;}
</style>

</html>