<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<c:import url="/EgovPageLink.do?link=adm/inc/incHead" />
<script type="text/javascript">

	// 목록
	function fn_list(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/cnslt/list/admCnsltList.do'/>").submit();
	}
	// 삭제
	function fn_delete(){
	  if (!confirm("해당 상담내역을 삭제하시겠습니까?")) {
		  
		return false;
		
	  } else {
	        // 확인(예) 버튼 클릭 시 이벤트
			$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/cnslt/list/admCnsltDelete.do'/>").submit();
	   }
	}


	// 등록&수정
	function fn_update(){
		$("#frm").attr("method", "post").attr("action", "<c:url value='/xabdmxgr/cnslt/list/admCnsltUpdate.do'/>").submit();
	}

	//파일 다운로드
	function fn_download(type, upSeq){
		location.href = "<c:url value='/cmmn/file/downloadFile.do?type="+type+"&fileId="+upSeq+"'/>";
	}
</script>
<body>
<form:form commandName="cnsltApplyVO" id="frm" name="frm" enctype="multipart/form-data">
<form:hidden path="aplySeq" />
<form:hidden path="updtYn" />
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
            	<jsp:param name="dept1" value="상담"/>
            	<jsp:param name="dept2" value="상담리스트"/>
            </jsp:include>
			<div class="cont_box">
			<!-- content -->
				<div class="section_top_area mt30">
					<h4>기본정보</h4>
				</div>
				<div class="g_side">
					<div class="side_c">
						<ul>
							<li>[<c:out value="${cnsltApplyVO.aplyCollege }"/>]&nbsp;&nbsp;</li>
							<li><c:out value="${cnsltApplyVO.aplyGrade }"/></li>
							<li class="tit">학년</li>
							<li class="tit">학과</li>
							<li><c:out value="${cnsltApplyVO.aplyDept }"/></li>
							<li class="tit">학번</li>
							<li><c:out value="${cnsltApplyVO.aplyHakbun }"/></li>
							<li class="tit">성명</li>
							<li><c:out value="${cnsltApplyVO.aplyName }"/></li>
							<li class="tit" style="width: 60px;">학적/구분</li>
							<li>
								<c:choose>
									<c:when test="${cnsltApplyVO.aplyRegistYn eq 'Y' }">재학</c:when>
									<c:when test="${cnsltApplyVO.aplyRegistYn eq 'N' }">휴학</c:when>
								</c:choose>
							</li>
							<li class="tit">휴대폰</li>
							<li><c:out value="${cnsltApplyVO.aplyMphone1 }"/>-<c:out value="${cnsltApplyVO.aplyMphone2 }"/>-<c:out value="${cnsltApplyVO.aplyMphone3 }"/></li>
						</ul>
					</div>
				</div>
				<%--
				<div class="g_side" style="height:80px;">
					<div class="side_c">
						<p class="mb10">개인정보 수집 동의 여부</p>
						<p>
							<input type="radio" name="p66_01" id="p66_01" /> <label for="p66_01">동의함</label>&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="radio" name="p66_01" id="p66_02" /> <label for="p66_02">동의하지 않음</label>
						</p>
					</div>
				</div>
			 	--%>
				<div class="section_top_area mt30">
					<h4>상담 대상 글</h4>
				</div>
				<c:if test="${cnsltApplyVO.aplyUsrType eq 'REGI' }">
					<div class="line_side">
						<ul>
							<li>1) 상담 받을 글의 유형은 무엇입니까?
								<div class="rad_box">
									<ul>
										<li>
											<c:if test="${cnsltRegiAnswer.regiAns1 eq '1' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltRegiAnswer.regiAns1 ne '1' }">□</c:if>
											칼럼
										</li>
										<li>
											<c:if test="${cnsltRegiAnswer.regiAns1 eq '2' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltRegiAnswer.regiAns1 ne '2' }">□</c:if>
											기사문
										</li>
										<li>
											<c:if test="${cnsltRegiAnswer.regiAns1 eq '3' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltRegiAnswer.regiAns1 ne '3' }">□</c:if>
											비평문
										</li>
									</ul>
									<ul>
										<li>
											<c:if test="${cnsltRegiAnswer.regiAns1 eq '4' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltRegiAnswer.regiAns1 ne '4' }">□</c:if>
											요약문
										</li>
										<li>
											<c:if test="${cnsltRegiAnswer.regiAns1 eq '5' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltRegiAnswer.regiAns1 ne '5' }">□</c:if>
											제안서
										</li>
										<li>
											<c:if test="${cnsltRegiAnswer.regiAns1 eq '6' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltRegiAnswer.regiAns1 ne '6' }">□</c:if>
											분석 보고서
										</li>
									</ul>
									<ul>
										<li>
											<c:if test="${cnsltRegiAnswer.regiAns1 eq '7' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltRegiAnswer.regiAns1 ne '7' }">□</c:if>
											조사 보고서
										</li>
										<li>
											<c:if test="${cnsltRegiAnswer.regiAns1 eq '8' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltRegiAnswer.regiAns1 ne '8' }">□</c:if>
											실험 보고서
										</li>
										<li>
											<c:if test="${cnsltRegiAnswer.regiAns1 eq '9' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltRegiAnswer.regiAns1 ne '9' }">□</c:if>
											발표(프레젠테이션 문서)
										</li>
									</ul>
									<ul>
										<li>
											<c:if test="${cnsltRegiAnswer.regiAns1 eq 'a' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltRegiAnswer.regiAns1 ne 'a' }">□</c:if>
											자기소개서
										</li>
										<li>
											<c:if test="${cnsltRegiAnswer.regiAns1 eq 'b' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltRegiAnswer.regiAns1 ne 'b' }">□</c:if>
											면접
										</li>
									</ul>
									<ul class="last">
										<li>
											<c:if test="${cnsltRegiAnswer.regiAns1 eq '0' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltRegiAnswer.regiAns1 ne '0' }">□</c:if>
											기타&nbsp;:&nbsp;<c:out value="${cnsltRegiAnswer.regiAns1Txt }"/>
										</li>
									</ul>
								</div>
							</li>
							<li>2) 상담 받을 글의 단계는 무엇입니까?
								<div class="rad_box">
									<ul>
										<li>
											<c:if test="${cnsltRegiAnswer.regiAns2 eq '1' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltRegiAnswer.regiAns2 ne '1' }">□</c:if>
											아이디어 생성 단계
										</li>
										<li>
											<c:if test="${cnsltRegiAnswer.regiAns2 eq '2' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltRegiAnswer.regiAns2 ne '2' }">□</c:if>
											개요 작성 단계
										</li>
									</ul>
									<ul>
										<li>
											<c:if test="${cnsltRegiAnswer.regiAns2 eq '3' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltRegiAnswer.regiAns2 ne '3' }">□</c:if>
											초안 작성 단계
										</li>
										<li>
											<c:if test="${cnsltRegiAnswer.regiAns2 eq '4' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltRegiAnswer.regiAns2 ne '4' }">□</c:if>
											원고 완성 단계
										</li>
									</ul>
								</div>
							</li>
							<li>3) 상담 받고 싶은 내용이 무엇입니까? (복수 응답 가능)
								<div class="chk_box">
									<ul>
										<li>
											<c:if test="${!empty cnsltRegiAnswer.regiAns3A }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${empty cnsltRegiAnswer.regiAns3A }">□</c:if>
											아이디어 생성 방법
										</li>
										<li>
											<c:if test="${!empty cnsltRegiAnswer.regiAns3B }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${empty cnsltRegiAnswer.regiAns3B }">□</c:if>
											자료 해석 및 평가 방법
										</li>
										<li>
											<c:if test="${!empty cnsltRegiAnswer.regiAns3C }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${empty cnsltRegiAnswer.regiAns3C }">□</c:if>
											글의 맥락 파악 방법(독자, 목적, 상황 등)
										</li>
										<li>
											<c:if test="${!empty cnsltRegiAnswer.regiAns3D }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${empty cnsltRegiAnswer.regiAns3D }">□</c:if>
											문장 표현 방법
										</li>
										<li>
											<c:if test="${!empty cnsltRegiAnswer.regiAns3E }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${empty cnsltRegiAnswer.regiAns3E }">□</c:if>
											글의 전개 방법
										</li>
										<li>
											<c:if test="${!empty cnsltRegiAnswer.regiAns3F }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${empty cnsltRegiAnswer.regiAns3F }">□</c:if>
											글쓰기의 일반적 과정
										</li>
										<li>
											<c:if test="${!empty cnsltRegiAnswer.regiAns3G }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${empty cnsltRegiAnswer.regiAns3G }">□</c:if>
											자신의 글쓰기 습관 점검
										</li>
										<li>
											<c:if test="${!empty cnsltRegiAnswer.regiAns3H }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${empty cnsltRegiAnswer.regiAns3H }">□</c:if>
											바람직한 글쓰기 태도
										</li>
										<li>
											<c:if test="${!empty cnsltRegiAnswer.regiAns3I }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${empty cnsltRegiAnswer.regiAns3I }">□</c:if>
											기타&nbsp;:&nbsp;<c:out value="${cnsltRegiAnswer.regiAns3Txt }"/>
										</li>
									</ul>
								</div>
							</li>
							<li>4) 상담 받을 글의 예상 독자는 누구입니까?
								<div class="chk_box">
									<ul>
										<li>▷&nbsp;<c:out value="${cnsltRegiAnswer.regiAns4Txt }"/></li>
									</ul>
								</div>
							</li>
							<li>5) 상담 받기 전에 요청하실 내용이 있으시면 구체적으로 작성해 주십시오.(50자 이내)
								<div class="chk_box" style="margin-bottom:0;">
									<ul>
										<li>▷&nbsp;<c:out value="${cnsltRegiAnswer.regiAns5Txt }"/></li>
									</ul>
								</div>
							</li>
						</ul>
					</div>
				</c:if>
				<c:if test="${cnsltApplyVO.aplyUsrType eq 'OVER' }">
					<div class="line_side">
						<ul>
							<li>1) 상담 받을 글의 유형은 무엇입니까?
								<div class="rad_box">
									<ul>
										<li>
											<c:if test="${cnsltOverAnswer.overAns1 eq '1' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltOverAnswer.overAns1 ne '1' }">□</c:if>
											리포트
										</li>
										<li>
											<c:if test="${cnsltOverAnswer.overAns1 eq '2' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltOverAnswer.overAns1 ne '2' }">□</c:if>
											분석 보고서
										</li>
										<li>
											<c:if test="${cnsltOverAnswer.overAns1 eq '3' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltOverAnswer.overAns1 ne '3' }">□</c:if>
											조사 보고서
										</li>
									</ul>
									<ul>
										<li>
											<c:if test="${cnsltOverAnswer.overAns1 eq '4' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltOverAnswer.overAns1 ne '4' }">□</c:if>
											실험 보고서
										</li>
										<li>
											<c:if test="${cnsltOverAnswer.overAns1 eq '5' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltOverAnswer.overAns1 ne '5' }">□</c:if>
											일반 한국어 글쓰기
										</li>
										<li>
											<c:if test="${cnsltOverAnswer.overAns1 eq '6' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltOverAnswer.overAns1 ne '6' }">□</c:if>
											발표(프레젠테이션 문서)
										</li>
									</ul>
									<ul>
										<li>
											<c:if test="${cnsltOverAnswer.overAns1 eq '7' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltOverAnswer.overAns1 ne '7' }">□</c:if>
											자기소개서
										</li>
										<li>
											<c:if test="${cnsltOverAnswer.overAns1 eq '8' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltOverAnswer.overAns1 ne '8' }">□</c:if>
											면접
										</li>
									</ul>
									<ul class="last">
										<li>
											<c:if test="${cnsltOverAnswer.overAns1 eq '0' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltOverAnswer.overAns1 ne '0' }">□</c:if>
											기타&nbsp;:&nbsp;<c:out value="${cnsltOverAnswer.overAns1Txt }"/>
										</li>
									</ul>
								</div>
							</li>
							<li>2) 상담 받고 싶은 내용이 무엇입니까? (두 개를 선택(V)해도 됩니다.)
								<div class="chk_box">
									<ul>
										<li>
											<c:if test="${!empty cnsltOverAnswer.overAns2A }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${empty cnsltOverAnswer.overAns2A }">□</c:if>
											주제를 설정하는 방법
										</li>
										<li>
											<c:if test="${!empty cnsltOverAnswer.overAns2B }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${empty cnsltOverAnswer.overAns2B }">□</c:if>
											글의 내용을 구성하는 방법
										</li>
										<li>
											<c:if test="${!empty cnsltOverAnswer.overAns2C }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${empty cnsltOverAnswer.overAns2C }">□</c:if>
											글을 쓰는 과정에 대한 어려움
										</li>
										<li>
											<c:if test="${!empty cnsltOverAnswer.overAns2D }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${empty cnsltOverAnswer.overAns2D }">□</c:if>
											한국어 문장 표현(문법, 어휘, 관용 표현 등)
										</li>
										<li>
											<c:if test="${!empty cnsltOverAnswer.overAns2E }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${empty cnsltOverAnswer.overAns2E }">□</c:if>
											자기 글의 문제점
										</li>
										<li>
											<c:if test="${!empty cnsltOverAnswer.overAns2F }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${empty cnsltOverAnswer.overAns2F }">□</c:if>
											기타&nbsp;:&nbsp;<c:out value="${cnsltOverAnswer.overAns2Txt }"/>
										</li>
									</ul>
								</div>
							</li>
							<li>3) 자신이 생각하는 한국어 실력은 어느 정도입니까?
								<div class="rad_box">
									<ul>
										<li style="width: 100%;">
											<c:if test="${cnsltOverAnswer.overAns3 eq '1' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltOverAnswer.overAns3 ne '1'  }">□</c:if>
											1~2급&nbsp;&nbsp;&nbsp;
											<c:if test="${cnsltOverAnswer.overAns3 eq '2' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltOverAnswer.overAns3 ne '2'  }">□</c:if>
											3~4급&nbsp;&nbsp;&nbsp;
											<c:if test="${cnsltOverAnswer.overAns3 eq '3' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltOverAnswer.overAns3 ne '3'  }">□</c:if>
											5~6급&nbsp;&nbsp;&nbsp;
											<c:if test="${cnsltOverAnswer.overAns3 eq '4' }">
												<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
											</c:if>
											<c:if test="${cnsltOverAnswer.overAns3 ne '4'  }">□</c:if>
											6급 이상
										</li>
									</ul>
								</div>
							</li>
						</ul>
					</div>
				</c:if>
				<div class="section_top_area mt30">
					<h4>상담 받을 글 관련 강좌</h4>
				</div>
				<div class="line_side">
					<ul>
						<li>1) 강좌의 성격은 무엇입니까?
							<div class="chk_box">
								<ul>
									<li>
										<c:if test="${cnsltTotAnswer.tans1 eq '1' }">
											<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
										</c:if>
										<c:if test="${cnsltTotAnswer.tans1 ne '1'  }">□</c:if>
										전공 과목&nbsp;&nbsp;&nbsp;&nbsp;
										<c:if test="${cnsltTotAnswer.tans1 eq '2' }">
											<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
										</c:if>
										<c:if test="${cnsltTotAnswer.tans1 ne '2'  }">□</c:if>
										교양 과목
									</li>
								</ul>
							</div>
						</li>
						<li>2) 몇 학년을 수강 대상으로 한 강좌입니까?
							<div class="chk_box" style="margin-bottom:0;">
								<ul>
									<li>
										<c:if test="${cnsltTotAnswer.tans1 eq '1' }">
											<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
										</c:if>
										<c:if test="${cnsltTotAnswer.tans1 ne '1'  }">□</c:if>
										1학년&nbsp;&nbsp;&nbsp;&nbsp;
										<c:if test="${cnsltTotAnswer.tans1 eq '2' }">
											<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
										</c:if>
										<c:if test="${cnsltTotAnswer.tans1 ne '2'  }">□</c:if>
										2학년&nbsp;&nbsp;&nbsp;&nbsp;
										<c:if test="${cnsltTotAnswer.tans1 eq '3' }">
											<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
										</c:if>
										<c:if test="${cnsltTotAnswer.tans1 ne '3'  }">□</c:if>
										3학년&nbsp;&nbsp;&nbsp;&nbsp;
										<c:if test="${cnsltTotAnswer.tans1 eq '4' }">
											<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
										</c:if>
										<c:if test="${cnsltTotAnswer.tans1 ne '4'  }">□</c:if>
										4학년&nbsp;&nbsp;&nbsp;&nbsp;
										<c:if test="${cnsltTotAnswer.tans1 eq '5' }">
											<img src="<c:url value='/assets/adm/img/check.png'/>" width="15px;" height="15px;"/>
										</c:if>
										<c:if test="${cnsltTotAnswer.tans1 ne '5'  }">□</c:if>
										전 학년 공통
									</li>
								</ul>
							</div>
						</li>
					</ul>
				</div>
				<div class="section_top_area mt30">
					<h4>상담신청파일</h4>
				</div>
				<div class="line_side">
					<ul>
						<li>
							<c:forEach items="${cnsltAplyUpfileList }" var="upfile">
								<c:if test="${upfile.upType eq 'CONS' }">
									<a href="#" onclick="fn_download('CONSULT', <c:out value='${upfile.upSeq }'/>); return false;"><c:out value="${upfile.upOriginFileName }"/></a><br />
								</c:if>
							</c:forEach>
						</li>
					</ul>
				</div>
				<div class="section_top_area mt30">
					<h4>첨삭파일</h4>
				</div>
				<div class="line_side">
					<ul>
						<li>
							<c:set var="fcnt" value="0"/>
							<c:forEach items="${cnsltAplyUpfileList }" var="upfile" varStatus="status">
								<c:if test="${upfile.upType eq 'ANSW' }">
									<c:set var="fcnt" value="${fcnt + 1 }"/>
									<a href="#" onclick="fn_download('CONSULT', <c:out value='${upfile.upSeq }'/>); return false;"><c:out value="${upfile.upOriginFileName }"/></a>
									<input type="checkbox" id="upFileDelChk<c:out value='${status.count }'/>" name="upFileDelChk" value="<c:out value='${upfile.upSeq }'/>" style="margin-left:15px;"/>
									<label for="upFileDelChk<c:out value='${status.count }'/>">삭제</label><br />
								</c:if>
							</c:forEach>
						</li>
						<li class="mt10">
							<c:forEach begin="1" end="${2-fcnt }" step="1" var="afile">
							<input type="file" id="attachedFile_<c:out value='${afile }'/>" name="attachedFile"/></br>
							</c:forEach>
						</li>
					</ul>
				</div>
				<ul class="p66_box">
					<li>강좌명&nbsp;:&nbsp;<c:out value="${cnsltApplyVO.aplyCourseName }"/></li>
					<li>일자&nbsp;:&nbsp;<c:out value="${cnsltApplyVO.schYmd }"/></li>
					<li>상담연구원&nbsp;:&nbsp;<c:out value="${cnsltApplyVO.updtName }"/></li>
					<li>상담시간&nbsp;:&nbsp;<c:out value="${cnsltApplyVO.schHm }"/></li>
				</ul>
				<div class="section_top_area mt30">
					<h4>상담연구원 메모</h4>
				</div>
				<c:if test="${sessionScope.adminSession.memCode eq cnsltApplyVO.updtId }">
					<div class="line_side">
						<ul>
							<li class="mb10">
								<c:if test="${cnsltApplyVO.aplyStatus ne '4' }">
									<form:select path="aplyStatus" class="se_base">
										<form:option value="1">신청완료</form:option>
										<form:option value="2">상담완료</form:option>
										<form:option value="3">불참</form:option>
									</form:select>
								</c:if>
								<c:if test="${cnsltApplyVO.aplyStatus eq '4' }"><form:hidden path="aplyStatus" value="4"/>상담취소</c:if>
							</li>
							<li class="line_side"><form:textarea path="aplyAdmMemo" rows="5" cols="100" /></li>
						</ul>
					</div>
				</c:if>
				<c:if test="${sessionScope.adminSession.memCode ne cnsltApplyVO.updtId }">
					<div class="line_side">
						<ul>
							<li class="line_side" style="width: 80px;">
								<c:if test="${cnsltApplyVO.aplyStatus eq '1' }">신청완료</c:if>
								<c:if test="${cnsltApplyVO.aplyStatus eq '2' }">상담완료</c:if>
								<c:if test="${cnsltApplyVO.aplyStatus eq '3' }">불참</c:if>
								<c:if test="${cnsltApplyVO.aplyStatus eq '4' }">상담취소</c:if>
							</li>
<%-- 							<li class="line_side"><form:input path="aplyAdmMemo" style="width: 100%" /></li> --%>
							<li class="line_side"><c:out value="${cnsltApplyVO.aplyAdmMemo }"/></li>
						</ul>
					</div>
				</c:if>
				<div class="btn_box">
					<div class="btn_c">
						<c:if test="${sessionScope.adminSession.memCode eq cnsltApplyVO.updtId }">
							<a href="#" class="b_type01" onclick="fn_update(); return false;">
								<c:if test="${empty cnsltApplyVO.updtDate }">저장</c:if>
								<c:if test="${!empty cnsltApplyVO.updtDate }">수정</c:if>
							</a>
						</c:if>
						<a href="#" class="b_type03" onclick="fn_list(); return false;">목록</a>
						<a href="#" class="b_type03" onclick="fn_delete(); return false;">삭제</a>
						
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
<!-- 목록페이지 조건 -->
<input type="hidden" id="pageIndex" name="pageIndex" value="${searchVO.pageIndex }"/>
<input type="hidden" id="searchClass" name="searchClass" value="${searchVO.searchClass }"/>
<input type="hidden" id="searchType" name="searchType" value="${searchVO.searchType }"/>
<input type="hidden" id="searchCondition" name="searchCondition" value="${searchVO.searchCondition }"/>
<input type="hidden" id="searchWord" name="searchWord" value="${searchVO.searchWord }"/>
<!--// 목록페이지 조건 -->
</form:form>
</body>
</html>