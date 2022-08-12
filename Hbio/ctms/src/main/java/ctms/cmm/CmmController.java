package ctms.cmm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.excel.ExcelUtil;
import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.mail.MailSendUtil;
import component.sms.SmsSendUtil;
import component.util.ComStringUtil;
import ctms.adm.cmm.AdmCmmController;
import ctms.adm.ech0102.Ech0102DAO;
import ctms.adm.ech0105.Ech0105DAO;
import ctms.adm.ech0901.Ech0901DAO;
import ctms.adm.ech0904.Ech0904DAO;
import ctms.adm.ech0905.Ech0905DAO;
import ctms.adm.ecr0101.Ecr0101DAO;
import ctms.validator.MemberValidator;
import ctms.valueObject.AdminVO;
import ctms.valueObject.Cs1000mVO;
import ctms.valueObject.Cs2000mVO;
import ctms.valueObject.Cs2020mVO;
import ctms.valueObject.Ct1030mVO;
import ctms.valueObject.Ct3000mVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Rm1000mVO;
import ctms.valueObject.Rm1020mVO;
import ctms.valueObject.Rm2000mVO;
import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs1010mVO;
import ctms.valueObject.Rs2000mVO;
import ctms.valueObject.RsUploadVO;
import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cmm.web.EgovWebUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class CmmController extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(CmmController.class);
	@Autowired private Ech0901DAO ech0901DAO;
	@Autowired private Ech0904DAO ech0904DAO;
	@Autowired private Ech0905DAO ech0905DAO;
	@Autowired private Ech0105DAO ech0105DAO;
	@Autowired private Ecr0101DAO ecr0101DAO;
	@Autowired private Ech0102DAO ech0102DAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private MailSendUtil mailUtil;
	@Resource View jsonView;
	@Resource private ExcelUtil excelUtil;
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	
	/*// 공용 학기찾기
	@RequestMapping("/usr/cmm/ajaxSearchSeme.do")
	public View ajaxSearchSeme(String year,HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/cmm/ajaxSearchSeme.do - 공용 학기찾기");
		
		List<EgovMap> semeList = cmmDAO.selectSemeList(year);
		model.addAttribute("semeList", semeList);
		
		return jsonView;
	}
	
	// 공용 학생찾기
	@RequestMapping("/usr/lec/cmm/ajaxSearchStd.do")
	public View admSemeList(String searchWord, String searchType, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/cmm/ajaxSearchStd.do - 공용 학생찾기");
		LOGGER.debug("searchWord = " + searchWord);
		
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");

		EgovMap map = new EgovMap();
		map.put("searchWord", searchWord);
		map.put("searchType", searchType);
		map.put("selLectCode", selLectCode);
		
		List<EgovMap> resultList = cmmDAO.selectStdList(map);
		model.addAttribute("resultList", resultList);
		
		return jsonView;
	}

	// 업무담당자 공용 학생찾기
	@RequestMapping("/qxsepmny/cmm/admAjaxSearchStd.do")
	public View admAjaxSearchStd(String searchWord, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/cmm/admAjaxSearchStd.do - 업무담당자 공용 학생찾기");
		LOGGER.debug("searchWord = " + searchWord);
		
		List<EgovMap> resultList = cmmDAO.selectAdmStdList(searchWord);
		model.addAttribute("resultList", resultList);
		
		return jsonView;
	}

	// 업무담당자 교과목 찾기
	@RequestMapping("/qxsepmny/cmm/admAjaxSearchCour.do")
	public View admAjaxSearchCour(String searchWord, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/cmm/admAjaxSearchCour.do - 업무담당자 교과목 찾기");
		LOGGER.debug("searchWord = " + searchWord);
		
		List<String> resultList = cmmDAO.selectCourList(searchWord);
		model.addAttribute("resultList", resultList);
		
		return jsonView;
	}
	
	// 출석부 팝업
	@RequestMapping("/qxsepmny/cmm/attendancePop.do")
	public String attendancePop(String lectSeq, HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		LOGGER.debug("/qxsepmny/cmm/attendancePop.do - 출석부 팝업");
		LOGGER.debug("lectSeq = " + lectSeq.toString());
		
		EgovMap lectSeme = cmmDAO.selectLectSeme(lectSeq);
		
		EgovMap lecture = cmmDAO.selectAdmLecture(lectSeq);
		model.addAttribute("lecture", lecture);
		
		List<EgovMap> lectTimeList = cmmDAO.selectLectTimeList(lectSeq);
		model.addAttribute("lectTimeList", lectTimeList);
		
		lectSeme.put("lectProg", lecture.get("lectProg"));
		
		List<EgovMap> timeList = cmmDAO.selectTimeList(lectSeme);
		model.addAttribute("timeList", timeList);
		
		List<EgovMap> memberList = cmmDAO.selectAdmAttPopMemberList(lectSeq);
		model.addAttribute("memberList", memberList);
		
		List<EgovMap> attendList = cmmDAO.selectAdmAttendPopList(lectSeq);
		model.addAttribute("attendList", attendList);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date startDate = new Date();
		Date endDate = new Date();
		
		if("정규과정".equals(lecture.get("lectProg"))){
			startDate = sdf.parse((String) lectSeme.get("enterRegiS"));
			endDate = sdf.parse((String) lectSeme.get("enterRegiE"));
		}else{
			startDate = sdf.parse((String) lecture.get("lectSdate"));
			endDate = sdf.parse((String) lecture.get("lectEdate"));
		}
		
		List<EgovMap> dates = new ArrayList<EgovMap>();
		List<String> weekOfMonth = new ArrayList<String>();
		Date currentDate = startDate;
		int before = 0;
		int bfMonth = 0;
		int cnt = 0;
		
		while (currentDate.compareTo(endDate) <= 0) {
			
			Calendar c = Calendar.getInstance();
			c.setTime(currentDate);
			
			if(before == 0){
				before = c.get(Calendar.WEEK_OF_MONTH);
				bfMonth = c.get(Calendar.MONTH)+1;
			}
			
			int weekNum = c.get(Calendar.DAY_OF_WEEK);
			for(EgovMap map : lectTimeList){
				if(String.valueOf(weekNum).equals(map.get("lectWeekNum"))){
					SimpleDateFormat form = new SimpleDateFormat("yyyy-MM-dd");
					EgovMap dateMap = new EgovMap();
					dateMap.put("currDate", form.format(currentDate));
					dateMap.put("month", c.get(Calendar.MONTH)+1);
					dateMap.put("date", c.get(Calendar.DATE));
					dateMap.put("week", map.get("lectWeek"));
					dates.add(dateMap);
					cnt++;
				}
			}

			if(before != c.get(Calendar.WEEK_OF_MONTH) && cnt != 0){
				before = c.get(Calendar.WEEK_OF_MONTH);
				if(cnt == lectTimeList.size()){
					weekOfMonth.add(String.valueOf(cnt));
					cnt = 0;
				}
			}
			
			if(bfMonth != c.get(Calendar.MONTH)+1){
				bfMonth = c.get(Calendar.MONTH)+1;
			}
			
			c.add(Calendar.DAY_OF_MONTH, 1);
			currentDate = c.getTime();
		}
		if(cnt != 0){
			weekOfMonth.add(String.valueOf(cnt));
		}
		model.addAttribute("dates", dates);
		model.addAttribute("weekOfMonth", weekOfMonth);
		
		return "/adm/cmm/attendancePop";
	}

	// 급별회의록 팝업
	@RequestMapping("/qxsepmny/cmm/meetLogPop.do")
	public String meetLogPop(String meetSeq, HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		LOGGER.debug("/qxsepmny/cmm/meetLogPop.do - 급별회의록 팝업");
		LOGGER.debug("meetSeq = " + meetSeq);
		
		EgovMap meetLogMap = cmmDAO.selectMeetLogPop(meetSeq);
		model.addAttribute("meetLogMap", meetLogMap);
		
		EgovMap semester = new EgovMap();
		semester.put("semYear", meetLogMap.get("year"));
		semester.put("semester", meetLogMap.get("semester"));
		
		List<EgovMap> lectList = cmmDAO.selectGradeLectList(meetLogMap);
		model.addAttribute("lectList", lectList);
		
		List<EgovMap> timeList = cmmDAO.selectTimeList(semester);
		model.addAttribute("timeList", timeList);
		
		EgovMap meetWeek = cmmDAO.selectMeetWeekPop(meetLogMap);
		model.addAttribute("meetWeek", meetWeek);
		
		List<EgovMap> meetProfList = cmmDAO.selectMeetProfList(meetSeq);
		model.addAttribute("meetProfList", meetProfList);
		
		return "/adm/cmm/meetLogPop";
	}*/
	
	// 연구코드/연구명칭 찾기
	@RequestMapping("/qxsepmny/cmm/CmmAjaxSearchYearRsCdList.do")
	public View CmmAjaxSearchYearRsCdList(String searchYear, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/cmm/CmmAjaxSearchYearRsCdList.do - 연구코드/명칭 찾기-연도");
		LOGGER.debug("searchYear = " + searchYear);
		
		//세션 호출
	 	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//소속지사 설정 - 소속지사가 설정되면 해당 지사의 연구과제 목록만 표시 
		//관리자인 경우 소속지사를 설정하지 않는다 1:관리자권한 2:일반사용자권한
	 	EgovMap map = new EgovMap();
	 	
	 	if(adminVO.getAdminType().equals("2")) 
		{ 
			map.put("branchCd", adminVO.getBranchCd()); 
		}else {	
			map.put("branchCd", "");
		}
		map.put("searchYear", searchYear);
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());;
		
		List<EgovMap> resultList = cmmDAO.selectCmmYearRsCdList(map);

		LOGGER.debug("resultList = " + resultList.toString());
		model.addAttribute("resultList", resultList);
		
		return jsonView;
	}
	
	// 일괄SMS등록 
	@RequestMapping("/qxsepmny/cmm/cmmAjaxSaveAllSms.do")
	public View cmmAjaxSaveAllSms(String corpCd, String recsDt, String cont, String sendmCls, String rsNo, String resrDt, String resrHr, String resrMm, String[] rsjSeq, Rm2000mVO rm2000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/cmm/cmmAjaxSaveAllSms.do - 일괄SMS등록");
		String message = "";
		
		//SMS발송 정보를 설정해야한다 api key, secret key, 발송전화번호 등 
		
		LOGGER.debug("rm2000mVO="+rm2000mVO.toString());
		
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("recsDt", recsDt); //접수일자
		map.put("tstaCls", "10");  //전송상태 10
		map.put("sendNo", "01033550107"); //발신번호
		map.put("smsCls", "1"); //SMS구분 1 단문  2 장문 - 본문내용크기
		map.put("cont", cont); //SMS 내용
		map.put("rsNo", rsNo); //연구과제번호
		map.put("sendmCls", sendmCls); //SMS 내용
		map.put("resrDt", resrDt); //예약일자
		map.put("resrHr", resrHr); //예약시각
		map.put("resrMm", resrMm); //예약분);
		map.put("branchCd", EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
		map.put("dataRegnt", EgovUserDetailsHelper.getAuthenticatedAdminId());
		
		String trsjNo = "";
		String trsNo = "";
		String treceNo = "";
		
		for(int i=0;i<rsjSeq.length;i++) {
			LOGGER.debug("rsjSeq[i]="+rsjSeq[i]);
				trsjNo = rsjSeq[i].substring(0, 8); // 연구대상자번호 8자리
				treceNo = rsjSeq[i].substring(8, 19); // 연구대상자전화번호
			if(rsjSeq[i].length()>19) {
				trsNo = rsjSeq[i].substring(19, 27); // 연구과제번호 8자리	
			}else {
				trsNo ="";
			}
			map.put("rsNo", trsNo);
		    map.put("rsjNo", trsjNo);
		    map.put("receNo", treceNo);
		    
		    LOGGER.debug("trsjNo="+trsjNo);
		    LOGGER.debug("treceNo="+treceNo);
		    LOGGER.debug("trsNo="+trsNo);
		    
			//실제 SMS 발송기능 이곳에 작성해주세요.
			LOGGER.debug("SMS시작 =========================");
			LOGGER.debug("resrDt="+resrDt);
			String to = treceNo;
			String from = "01033550107";
			String text = cont;

			//예약발송 구분 필요합니다. 
			if(!EgovStringUtil.isEmpty(resrDt)){
				
				//예약일시 일자시분초 형식 변환 
				String tdate = EgovStringUtil.getSmsDate(resrDt, resrHr, resrMm);
				LOGGER.debug("예약발송테스트=");
				SmsSendUtil.sendSmsDate(to, from, text, tdate);
			}else {
				LOGGER.debug("일반발송테스트=");
				SmsSendUtil.sendSms(to, from, text);
			}
			LOGGER.debug("SMS종료 =========================");
			
		    //SMS 발송내역 등록 
		    cmmDAO.insertAjaxSaveSms(map);		
		}

		message = "저장되었습니다.";
		model.addAttribute("message", message);
		
		return jsonView;
		
	}

	// 예약SMS등록 
	@RequestMapping("/qxsepmny/cmm/cmmAjaxSaveSmsMt.do")
	public View ech0103AjaxSaveSmsMt(String corpCd, String receName, String receNo, String rsjNo, String recsDt, String sendmCls, String rsNo, String resrDt, String resrHr, String resrMm, String cont, String[] rsjSeq, Rm2000mVO rm2000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/cmm/cmmAjaxSaveSmsMt.do - 예약SMS등록");
		String message = "";
		
		LOGGER.debug("rm2000mVO="+rm2000mVO.toString());
		
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("recsDt", recsDt); //접수일자
		map.put("tstaCls", "10");  //전송상태 10
		map.put("sendNo", "01036100135"); //발신번호
		map.put("sendName", "에치앤바이오"); //발신번호
		map.put("smsCls", "1"); //SMS구분 1 단문  2 장문 - 본문내용크기
		map.put("cont", cont);
		map.put("rsNo", rsNo); //연구과제번호
		map.put("sendmCls", sendmCls); //SMS 내용
		map.put("resrDt", resrDt); //예약일자
		map.put("resrHr", resrHr); //예약시각
		map.put("resrMm", resrMm); //예약분);
		map.put("branchCd", EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
		map.put("dataRegnt", EgovUserDetailsHelper.getAuthenticatedAdminId());
		map.put("rsNo", rsNo);
		map.put("rsjNo", rsjNo);
		map.put("receNo", receNo);
		map.put("receName", receName);
		
		String trsjNo = "";
		String trsNo = "";
		String treceNo = "";
		
		//for(int i=0;i<rsjSeq.length;i++) {
			//trsNo = rsjSeq[i].substring(0, 8); // 연구과제번호 8자리
			//trsjNo = rsjSeq[i].substring(8, 16); // 연구대상자번호 8자리
			//treceNo = rsjSeq[i].substring(16, 25); // 연구대상자전화번호
		    //map.put("rsNo", trsNo);
		    //map.put("rsjNo", trsjNo);
		    //map.put("receNo", treceNo);
		    
		    //실제 SMS 발송기능 이곳에 작성해주세요. 
		    //LOGGER.debug("rsjSeq[i]="+rsjSeq[i]);
		  //SMS 발송내역 등록 
		    //ech0103DAO.insertEch1002AjaxSaveSms(map);		
		//}
		
		//실제 SMS 발송기능 이곳에 작성해주세요.
		String to = receNo;
		String from = "01033550107";
		String text = cont;

		//예약발송 구분 필요합니다. 
		if(!EgovStringUtil.isEmpty(resrDt)){
			//예약일시 일자시분초 형식 변환 
			String tdate = EgovStringUtil.getSmsDate(resrDt, resrHr, resrMm);
			SmsSendUtil.sendSmsDate(to, from, text, tdate);
		}else {
			SmsSendUtil.sendSms(to, from, text);
		}
		
		//SMS 발송내역 등록 
	    cmmDAO.insertAjaxSaveSms(map);
		
		message = "저장되었습니다.";
		model.addAttribute("message", message);
		
		return jsonView;
		
	}
	
	// 일괄이메일등록 
	@RequestMapping("/qxsepmny/cmm/cmmAjaxSaveAllMail.do")
	public View cmmAjaxSaveAllMail(String corpCd, String recmDt, String title, String cont, String sendmCls, String rsNo, String resrDt, String resrHr, String resrMm, String[] rsjSeq, Rm1000mVO rm1000mVO, Sb1000mVO sb1000mVO, MultipartHttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/cmm/cmmAjaxSaveAllMail.do - 일괄이메일등록");
		String message = "";
		
		//메일서버 정보 획득
		EgovMap map1 = new EgovMap();
		map1.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		String mailHost = cmmDAO.selectMailHost(map1);
		String[] spmailhost = mailHost.split(",");
		String thost	 = spmailhost[0].toString(); //host
		String tpassword = EgovFileScrty.decode(spmailhost[1].toString()); //password
		String tusername = spmailhost[2].toString(); //username

		//메일전송정보 설정
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("recmDt", recmDt); //접수일자
		map.put("tstaCls", "10");  //전송상태 10
		map.put("sendNo", "01036100135"); //발신번호
		map.put("sendName", "홍길동"); //발신자명
		map.put("sendEmail", "hjk114@naver.com"); //발신자명
		map.put("smsCls", "1"); //SMS구분 1 단문  2 장문 - 본문내용크기
		map.put("title", title); //메일제목
		map.put("cont", cont); //메일본문
		map.put("rsNo", rsNo); //연구과제번호
		map.put("sendmCls", sendmCls); //SMS 내용
		map.put("resrDt", resrDt); //예약일자
		map.put("resrHr", resrHr); //예약시각
		map.put("resrMm", resrMm); //예약분
		map.put("sendsCls", "1"); //발송설정 1:이메일 , 2:이메일+SMS
		map.put("branchCd", EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
		map.put("dataRegnt", EgovUserDetailsHelper.getAuthenticatedAdminId());
		
		String trsjNo, trsNo, treceNo = "";
		
		for(int i=0;i<rsjSeq.length;i++) {
			trsNo = rsjSeq[i].substring(0, 8); // 연구과제번호 8자리
			trsjNo = rsjSeq[i].substring(8, 16); // 연구대상자번호 8자리
			treceNo = rsjSeq[i].substring(16, 27); // 연구대상자전화번호
		    map.put("rsNo", trsNo);
		    map.put("rsjNo", trsjNo);
		    map.put("receNo", treceNo);
	
		    //rs1000mVO = cmmDAO.selectRsInfo(map);
		    //map.put("rsCd", rs1000mVO.getRsCd());
		    
		    //연구대상자 정보 설정
		    sb1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		    sb1000mVO.setRsjNo(trsjNo);
	
		    sb1000mVO = cmmDAO.selectRsjDetail2(sb1000mVO);
		    
		    map.put("receEmail", sb1000mVO.getEmail() ); //수신이메일
		    map.put("receName", sb1000mVO.getRsjName() ); //수신명
		    
		    String usrEmail = sb1000mVO.getEmail(); //수신이메일
		    String usrName = sb1000mVO.getRsjName(); //수신자명

		    String afterPwd = ComStringUtil.createPassword(6);
		    
		    // 첨부파일 저장 
		    // 해당 코드 위에서 첨부파일 서버 저장 후 파일 path를 넣어줘야함.
		    // 파일path가 피어있는 경우 첨부파일 없이 메일전송됨.
		    
		    //메일 발송내역 등록
		    String recmNo = cmmDAO.insertAjaxSaveMail(map);
		    
		    // 첨부파일 서버 저장
		    List<FileInfoVO> fileList = fileUtil.totUploadFiles(request, "MAIL");
		    if(fileList != null){
				for(FileInfoVO fileInfoVO : fileList){
					LOGGER.debug("----- fileKey = " + fileInfoVO.getFileKey() + " -----");
					Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
					attachVO.setBoardNo(String.valueOf(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd())+recmNo); //회사코드+메일접수번호 
					attachVO.setBoardType("MAIL");//폴더명
					//attachVO.setFileKey(fileInfoVO.getFileKey()); //파일명 네임값도 컬럼에넣기(삭제하거나 리스트출력시 키값사용)
					
					cmmDAO.insertAttachFile(attachVO);
				}
			}
		    
		    mailUtil.sendEmail(usrEmail, usrName, afterPwd, title, cont, thost, tusername, tpassword, fileList);
	
		}
	    
		message = "이메일이 발송되었습니다.";
		model.addAttribute("message", message);
		return jsonView;
		
	}
	
	// 이메일재발송 
	@RequestMapping("/qxsepmny/cmm/cmmAjaxResendMail.do")
	public View cmmAjaxResendMail(String corpCd, String recmNo, String[] rsjSeq, Rm1000mVO rm1000mVO, Rm1020mVO rm1020mVO, Sb1000mVO sb1000mVO, MultipartHttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/cmm/cmmAjaxResendMail.do - 이메일재발송");
		String message = "";
		
		//새로운 발송내역을 만들어야 하나? 재발송일시 목록만 필요, 재발송횟수, 재발송일자, 메일을 재발송한다
		//메일서버 정보 획득
		EgovMap map1 = new EgovMap();
		map1.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		String mailHost = cmmDAO.selectMailHost(map1);
		String[] spmailhost = mailHost.split(",");
		String thost	 = spmailhost[0].toString(); //host
		String tpassword = EgovFileScrty.decode(spmailhost[1].toString()); //password
		String tusername = spmailhost[2].toString(); //username

		//메일전송정보 설정
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		rm1000mVO.setRecmNo(recmNo);
		rm1000mVO = cmmDAO.selectRecmNoDetail(rm1000mVO);
		
		map.put("recmDt", rm1000mVO.getRecmDt()); //접수일자
		map.put("tstaCls", "10");  //전송상태 10
		map.put("sendNo", "01036100135"); //발신번호
		map.put("sendName", "홍길동"); //발신자명
		map.put("sendEmail", "hjk114@naver.com"); //발신자명
		map.put("smsCls", "1"); //SMS구분 1 단문  2 장문 - 본문내용크기
		map.put("title", rm1000mVO.getTitle()); //메일제목
		map.put("cont", rm1000mVO.getCont()); //메일본문
		map.put("rsNo", rm1000mVO.getRsNo()); //연구과제번호
		map.put("sendmCls", rm1000mVO.getSmscont()); //SMS 내용
		map.put("resrDt", rm1000mVO.getResrDt()); //예약일자
		map.put("resrHr", rm1000mVO.getResrHr()); //예약시각
		map.put("resrMm", rm1000mVO.getResrMm()); //예약분
		map.put("sendsCls", rm1000mVO.getSendsCls()); //발송설정 1:이메일 , 2:이메일+SMS
		map.put("branchCd", EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
		map.put("dataRegnt", EgovUserDetailsHelper.getAuthenticatedAdminId());
	    // 첨부파일 저장 
	    // 해당 코드 위에서 첨부파일 서버 저장 후 파일 path를 넣어줘야함.
	    // 파일path가 피어있는 경우 첨부파일 없이 메일전송됨.
	    String usrEmail = rm1000mVO.getReceEmail();
	    
	    String usrName = "";
	    String afterPwd = ComStringUtil.createPassword(6);
	    String title = "[재전송]"+rm1000mVO.getTitle();
	    String cont = rm1000mVO.getCont();
	    
	    // 첨부파일 서버 저장
	    List<FileInfoVO> fileList = fileUtil.totUploadFiles(request, "MAIL");
	    
	    mailUtil.sendEmail(usrEmail, usrName, afterPwd, title, cont, thost, tusername, tpassword, fileList);
	    
		//이메일 재발송내역 등록
	    rm1020mVO.setCorpCd(rm1000mVO.getCorpCd());
	    rm1020mVO.setRecmDt(EgovStringUtil.getDateMinus());
	    rm1020mVO.setOrecmNo(rm1000mVO.getRecmNo());
	    rm1020mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
	    rm1020mVO.setTstaCls("10");
	    rm1020mVO.setTsenCls("100");
	    
		cmmDAO.insertResendMail(rm1020mVO);
	    
		message = "이메일이 재발송되었습니다.";
		model.addAttribute("message", message);
		
		return jsonView;
		
	}
	
	// 연구정보찾기
	@RequestMapping("/qxsepmny/cmm/cmmAjaxSearchRsList.do")
	public View cmmAjaxSearchRsList(String searchWord, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/cmm/cmmAjaxSearchRsList.do - 연구과제찾기");
		LOGGER.debug("searchWord = " + searchWord);
		
		EgovMap map = new EgovMap();
		map.put("searchWord", searchWord);
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		List<EgovMap> resultList = cmmDAO.selectCmmRsList(map);
		model.addAttribute("resultList", resultList);
		
		return jsonView;
		
	}
	
	// 인증키 생성
	@RequestMapping("/qxsepmny/cmm/cmmAjaxGetAuthkey.do")
	public View cmmAjaxGetAuthkey(String corpCd, String rsNo, String rsjNo, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/cmm/cmmAjaxGetAuthkey.do - 연구과제찾기");
		LOGGER.debug("corpCd="+corpCd);
		LOGGER.debug("rsNo="+rsNo);
		LOGGER.debug("rsjNo="+rsjNo);
		
		//EgovMap map = new EgovMap();
		//map.put("searchWord", searchWord);
		//map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		//List<EgovMap> resultList = cmmDAO.selectCmmRsList(map);
		model.addAttribute("message", "1234");
		model.addAttribute("status", "ok");
		model.addAttribute("resultList", "1234");
		
		return jsonView;
		
	}

	// 연구계획서코드/연구명칭 찾기
	@RequestMapping("/qxsepmny/cmm/CmmAjaxSearchYearRsCdList2.do")
	public View CmmAjaxSearchYearRsCdList2(String searchYear, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/cmm/CmmAjaxSearchYearRsCdList.do - 연구계획서코드/명칭 찾기-연도");
		LOGGER.debug("searchYear = " + searchYear);
		
		//세션 호출
	 	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//소속지사 설정 - 소속지사가 설정되면 해당 지사의 연구과제 목록만 표시 
		//관리자인 경우 소속지사를 설정하지 않는다 1:관리자권한 2:일반사용자권한
	 	EgovMap map = new EgovMap();
	 	
	 	if(adminVO.getAdminType().equals("2")) 
		{ 
			map.put("branchCd", adminVO.getBranchCd()); 
		}else {	
			map.put("branchCd", "");
		}
		map.put("searchYear", searchYear);
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());;
		
		List<EgovMap> resultList = cmmDAO.selectCmmYearRsCdList2(map);

		LOGGER.debug("resultList = " + resultList.toString());
		model.addAttribute("resultList", resultList);
		
		return jsonView;
	}
	// 연구프로토콜 코드/명칭 찾기 
	@RequestMapping("/qxsepmny/cmm/CmmAjaxSearchRsProtocolList.do")
	public View CmmAjaxSearchRsProtocol(String rsNo2, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/cmm/CmmAjaxSearchRsProtocol.do - 연구프로토콜 코드/명칭 찾기-임상종류");
		LOGGER.debug("rsNo2 = " + rsNo2);

		EgovMap map = new EgovMap();
		map.put("rsNo2", rsNo2);
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("cdCls", "CT2060");
		if(rsNo2.equals("E")) {
			map.put("type", "유효성");
		}else if(rsNo2.equals("S")) {
			map.put("type", "안전성");
		}else if(rsNo2.equals("I")) {
			map.put("type", "in vitro");
		}else {
			map.put("type", "");
		}
		List<EgovMap> resultList = cmmDAO.selectCmmRsProtocolList(map);

		LOGGER.debug("resultList = " + resultList.toString());
		model.addAttribute("resultList", resultList);
		
		return jsonView;
	}
	
	// CRF템플릿파일명 찾기
	@RequestMapping("/qxsepmny/cmm/CmmAjaxSearchTmplFile.do")
	public View CmmAjaxSearchTmplFile(String type, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/cmm/CmmAjaxSearchTmplFile.do - CRF템플릿파일명 찾기");
		LOGGER.debug("type = " + type);
		
		//세션 호출
	 	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		String regFileName = "";

		//첨부파일 확인 
		EgovMap map = new EgovMap();
		map.put("boardSeq", type);
		map.put("boardType", "UBI4\\TMPL");
		List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
		for(Ct7000mVO attach : attachList){
			regFileName = attach.getRegFileName();
				
			int pos = regFileName.lastIndexOf( "\\" );
			regFileName = regFileName.substring( pos + 1 );
			
		}
		
		LOGGER.debug("regFileName = " + regFileName);
		
		model.addAttribute("resultList", regFileName);
		
		return jsonView;
	}
	
	// 연구과제 전체 CRF템플릿파일명 찾기
	@RequestMapping("/qxsepmny/cmm/CmmAjaxSearchTmplFile2.do")
	public View CmmAjaxSearchTmplFile2(String type, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/cmm/CmmAjaxSearchTmplFile2.do - 연구과제 전체 CRF템플릿파일명 찾기");
		LOGGER.debug("type = " + type);
		
		//세션 호출
	 	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		String regFileName = "";

		//첨부파일 확인 
		EgovMap map = new EgovMap();
		map.put("boardSeq", type);
		map.put("boardType", "UBI4\\TMPL");
		List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
		for(Ct7000mVO attach : attachList){
			regFileName = attach.getRegFileName();
				
			int pos = regFileName.lastIndexOf( "\\" );
			regFileName = regFileName.substring( pos + 1 );
			
		}
		
		LOGGER.debug("regFileName = " + regFileName);
		
		model.addAttribute("resultList", regFileName);
		
		return jsonView;
	}
	
	
	// 데이터 일괄등록 시작
	// 일괄등록 양식파일 업로드  - 추가
	@RequestMapping("/qxsepmny/cmm/CmmAjaxUploadFile.do")
	public View CmmAjaxUploadFile(String[] delFile, Ct7000mVO ct7000mVO, MultipartHttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/cmm/CmmAjaxUploadFile.do -  일괄등록 양식파일업로드");
		LOGGER.debug("request.getParameter('upls')= "+request.getParameter("upls"));
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		//회사코드설정
		String message = "";
		
		//양식파일 등록여부를 확인 > 등록된 경우 기존 파일을 삭제한다.
		//CT7000M 확인 UPLS CSUPLS -> ATTACH_NO 확인하여 seq에 설정한다.
		EgovMap map = new EgovMap();
		//map.put("boardSeq", "CSUPLS");
		map.put("boardSeq", request.getParameter("upls"));
		map.put("boardType", "UPLS");
		map.put("fileKey", "attachRpt01");
		ct7000mVO = cmmDAO.selectAttachListFileKeyOne(map);

		if(ct7000mVO != null) {
			Ct7000mVO delAttach = cmmDAO.selectAttachOne(ct7000mVO.getAttachNo());
			cmmDAO.deleteAttachFile(delAttach.getAttachNo());
			fileUtil.deleteFile(delAttach.getRegFileName());
		}
				
		//양식파일 첨부 
		List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "UPLS");
		if(fileInfoList != null){
			for(FileInfoVO fileInfoVO : fileInfoList){
				LOGGER.debug("----- fileKey = " + fileInfoVO.getFileKey() + " -----");
				Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
				attachVO.setBoardType("UPLS");
				/*attachVO.setBoardNo("CSUPLS");*/
				attachVO.setBoardNo(request.getParameter("upls"));
				attachVO.setRegName(EgovUserDetailsHelper.getAuthenticatedAdminId());
				attachVO.setRegDate(EgovStringUtil.getDateMinus());
				cmmDAO.insertAttachFile(attachVO);
			}
		}
		
		return jsonView;
	}
	
	// 일괄업로드 화면 표출 - 1)엑셀파일 업로드 화면 호출 
	@RequestMapping("/qxsepmny/cmm/CmmUplsUpload.do")
	public String CmmUplsUpload(@ModelAttribute CmmnSearchVO searchVO, Ct7000mVO ct7000mVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda, HttpSession session) throws Exception {
		LOGGER.debug("/qxsepmny/cmm/CmmUplsUpload.do - 일괄업로드 화면 표출");
		String message = "";		
		//회사코드 설정
		searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		LOGGER.debug("uploadFlag= "+request.getParameter("uploadFlag"));
		
		String uploadFlag = request.getParameter("uploadFlag");
				
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		searchVO.setSearchParam2(adminVO.getAdminType());
		
		// 엑셀 데이터 삭제
		session.removeAttribute("insertMemList");
		session.removeAttribute("excelDupMemList");
		
		//양식파일의 ATTACH_NO을 획득한다.
		EgovMap map = new EgovMap();
		if(uploadFlag.equals("CS")) { //고객사 일괄등록
			map.put("boardSeq", "CSUPLS");
		}else if(uploadFlag.equals("IN")) { //입금 일괄등록
			map.put("boardSeq", "INUPLS");
		}else if(uploadFlag.equals("AST")) { //자산 일괄등록
			map.put("boardSeq", "ASTUPLS");
		}else if(uploadFlag.equals("RS")) {	//연구 일괄등록
			map.put("boardSeq", "RSUPLS");
		}else if(uploadFlag.equals("SJ")) { //연구대상자 일괄등록
			map.put("boardSeq", "SJUPLS");
		} 
		
		map.put("boardType", "UPLS");
		map.put("fileKey", "attachRpt01");
		ct7000mVO = cmmDAO.selectAttachListFileKeyOne(map);
		if(ct7000mVO != null) {
			searchVO.setSearchParam1(ct7000mVO.getAttachNo());
			message = "양식파일이 등록되여 있습니다. 다운로드해서 사용해주세요";
		}else {
			message = "양식파일이 없습니다. 먼저 양식파일을 첨부해주세요(관리자권한 필요)";	
		}
		searchVO.setSearchParam3(uploadFlag);
		
		model.addAttribute("message", message);
		model.addAttribute("searchVO", searchVO);

		return "/adm/cmm/admUplsUpload";
		
	}
	
	// 데이터 일괄등록 - Data 검증 화면
	@RequestMapping("/qxsepmny/cmm/CmmUplsUpload2.do")
	public String CmmUplsUpload2(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.info("/qxsepmny/cmm/CmmUplsUpload2.do - 데이터 일괄등록 > Data 검증 화면");
		LOGGER.debug("searchVO = "+searchVO.toString());

		// CSRF 토큰 공유
		CtmsCmmMethods.setCsrfToken(session);
		
		//if(!CtmsCmmMethods.checkMemPermit(key)) {
			//return CtmsCmmMethods.redirectProfileView;
		//}
		LOGGER.debug("================+++++++++++++++++++++++++");
		
		//searchVO.setSearchParam3("CS");
		model.addAttribute("searchVO", searchVO);
		return "/adm/cmm/admUplsUpload";
		//return "/adm/ech0901/ech0901CsUpload";
	}
	
	// 상담정보 일괄등록 - 업로드 엑셀파일 파싱 
	@RequestMapping("/qxsepmny/cmm/CmmCsUploadMemData.do")
	public String CmmCsUploadMemData(MultipartHttpServletRequest multiRequest, Cs1000mVO cs1000mVO, Ct1030mVO ct1030mVO, ModelMap model, RedirectAttributes reda, HttpSession session) throws Exception {
		LOGGER.debug("/qxsepmny/cmm/CmmCsUploadMemData.do -  상담정보 일괄등록 엑셀파일 파싱(공통)");
		
		String message = "";
		String gubun = "";
		
		//첨부파일 확인
		/*첨부파일 존재할시 등록*/
		if(fileUtil.uploadFileRegiChk(multiRequest)){
			FileInfoVO fileInfoVO = fileUtil.uploadAttachedFile2(multiRequest, "UPL");
			
			//파일 확인
			if(fileInfoVO == null){
				LOGGER.info("첨부된 파일의 확장자가 잘못되었습니다.");
				message = "첨부된 파일의 확장자가 잘못되었습니다.";
			}else {
				
				//파일 업로드
				String filePath = fileInfoVO.getFilePath();
				LOGGER.debug(filePath);
	
				// 엑셀 데이터 파싱  filePath, 업로드타입 - 상담 cs
				List<EgovMap> excelMemList = excelUtil.getExcelUploadData(filePath, "cs");
				
				// 업로드된 파일 삭제
				//fileUtil.deleteFile(filePath);
				
				// 중복 목록 저장용도
				List<EgovMap> excelDupMemList = new ArrayList<EgovMap>();
				
				// 중복 제거한  목록 저장용도
				List<Cs1000mVO> insertMemList = new ArrayList<>();
				
				if(excelMemList.size() == 0) {
					message = "업로드 데이터 미존재";
				}else {
					boolean isValid = true;
					
					for(EgovMap memMap : excelMemList) {
						LOGGER.debug("memMap="+memMap.toString());
						String name = (String)memMap.get("corpCd");
						
						if(EgovStringUtil.isEmpty(name)) {
							message = "회사고유번호가  없는 데이터가 존재합니다.";
							break; 
						}else {
							Cs1000mVO rsUploadVO = new Cs1000mVO();
							//조건에 따른 값 설정 예시
							//if("core".equals(key)) rsUploadVO.setCore("Y");
							//else if("corr".equals(key)) rsUploadVO.setCorr("Y");
							//else if("reporter".equals(key)) rsUploadVO.setReporter("Y");
							//else if("tot".equals(key)) rsUploadVO.setTot("Y");
							//else if("payb".equals(key)) rsUploadVO.setPayb("Y");
							
							//값 매칭 예시
							//rsUploadVO.setName(EgovWebUtil.removeTag(memMap.get("name").toString()));			

							//작업자 확인  
							///EgovMap map2 = new EgovMap();
							
							//map2.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
							//map2.put("empNo", EgovUserDetailsHelper.getAuthenticatedAdminEmpNo());
							
							//ct1030mVO = ech0901DAO.selectEch0901EmpCheck(map2);

							rsUploadVO.setEmpNo(EgovUserDetailsHelper.getAuthenticatedAdminEmpNo());
							rsUploadVO.setBranchCd(EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
							
							rsUploadVO.setCorpCd(EgovWebUtil.removeTag(memMap.get("corpCd").toString()));
							rsUploadVO.setCsDt(EgovWebUtil.removeTag(memMap.get("csDt").toString()));
							rsUploadVO.setVendNo(EgovWebUtil.removeTag(memMap.get("vendNo").toString()));
							rsUploadVO.setCsCls(EgovWebUtil.removeTag(memMap.get("csCls").toString()));							
							rsUploadVO.setCsCont(EgovWebUtil.removeTag(memMap.get("csCont").toString()));
							rsUploadVO.setRcsName(EgovWebUtil.removeTag(memMap.get("rcsName").toString()));
							rsUploadVO.setRcsTel(EgovWebUtil.removeTag(memMap.get("rcsTel").toString()));
							rsUploadVO.setRcsEmail(EgovWebUtil.removeTag(memMap.get("rcsEmail").toString()));
							rsUploadVO.setRemk(EgovWebUtil.removeTag(memMap.get("remk").toString()));
							
							// 유효성 검사
							//Map<String, String> errors = MemberValidator.validate(rsUploadVO);
							//if(errors.size()!=0) {
								//message = "데이터 형식에 오류가 있어 업로드 등록에 실패하였습니다.";
								//reda.addFlashAttribute("errors", errors);
								//return redirectListPage(reda, message, "");
							//}
							
							// 중복검사 - 고객사,상담일자,내용 
							EgovMap map = new EgovMap();
							
							map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
							map.put("vendNo", rsUploadVO.getVendNo());
							map.put("csDt", rsUploadVO.getCsDt());
							map.put("csCont", rsUploadVO.getCsCont());
							List<EgovMap> list = ech0901DAO.selectEch0901DupCsList(map);
							
							if(list != null && list.size() >= 1) {
								memMap.put("dupMemList", list);
								excelDupMemList.add(memMap);
							}else {
								insertMemList.add(rsUploadVO);
							}
						}
					}
					
					if(isValid) {
						session.setAttribute("insertMemList", insertMemList);	// 중복 제거 신규  목록
						LOGGER.debug("insertMemList="+insertMemList.toString());
						session.setAttribute("excelDupMemList", excelDupMemList);	// 중복 목록
						LOGGER.debug("excelDupMemList="+excelDupMemList.toString());
						message = "검증 완료. 다음 버튼을 클릭하세요.";
						gubun = "2"; // 데이터 검증 탭으로 이동
					}
				}
			}
			
		}else{
			message = "첨부 파일 미존재";
		}

		//model.addAttribute("message", message);
		//model.addAttribute("searchVO", searchVO);
		
		return redirectListPage(reda, message, gubun, "CS");
		
	}
		
	//상담정보 일괄등록 - 상담정보 일괄 등록 처리 	
	@RequestMapping("/qxsepmny/cmm/CmmCsSaveCsData.do")
	public String CmmCsSaveCsData(HttpServletRequest request, ModelMap model, Cs1000mVO cs1000mVO, HttpSession session, RedirectAttributes reda, String memType) throws Exception {
		LOGGER.info("/qxsepmny/cmm/CmmCsSaveCsData.do - 상담정보 일괄 등록 처리(공통)");
	
		// CSRF 토큰 검사
		if(!CtmsCmmMethods.isCsrfToken(request, reda)){
		  return CtmsCmmMethods.redirectLoginView;
		}
		
		List<Cs1000mVO> insertMemList = (List<Cs1000mVO>) session.getAttribute("insertMemList");
		
		// 유효성 검사 통과 등록 작업.
		for(Cs1000mVO rsUploadVO : insertMemList) {
			//상담분야 1000 마케팅용 1010 과제용  명칭/코드 분리하기
			if (!EgovStringUtil.isEmpty(rsUploadVO.getCsCls())) {
				String tempCls = rsUploadVO.getCsCls();
				
				String[] sptempCls = tempCls.split("/");
				rsUploadVO.setCsCls(sptempCls[1].toString());
			}
			
			rsUploadVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
			LOGGER.info("rsUploadVO="+rsUploadVO.toString());
			
			ech0901DAO.insertEch0901(rsUploadVO);
			
		}
		
		//작업 로그 등록 
		String dspCnt = insertMemList.size()+"건";
		admLogInsert("영업관리 > 상담정보 일괄등록", dspCnt, "1010", request);
		
		String message = "등록 완료되었습니다.";
		
		return redirectListPage(reda, message, "", "CS");
	}	

	// 입금정보 일괄등록 - 엑셀파일 파싱 (공통)
	@RequestMapping("/qxsepmny/cmm/CmmInUploadMemData.do")
	public String CmmInUploadMemData(MultipartHttpServletRequest multiRequest, Cs2020mVO cs2020mVO, Ct1030mVO ct1030mVO, ModelMap model, RedirectAttributes reda, HttpSession session) throws Exception {
		LOGGER.info("/qxsepmny/cmm/CmmInUploadMemData.do -  입금정보 일괄등록 엑셀파일 파싱(공통)");
		
		String message = "";
		String gubun = "";
		
		//첨부파일 확인
		/*첨부파일 존재할시 등록*/
		if(fileUtil.uploadFileRegiChk(multiRequest)){
			FileInfoVO fileInfoVO = fileUtil.uploadAttachedFile2(multiRequest, "UPL");
			
			//파일 확인
			if(fileInfoVO == null){
				LOGGER.debug("첨부된 파일의 확장자가 잘못되었습니다.");
				message = "첨부된 파일의 확장자가 잘못되었습니다.";
			}else {
				
				//파일 업로드
				String filePath = fileInfoVO.getFilePath();
				LOGGER.debug(filePath);
	
				// 엑셀 데이터 파싱  filePath, 업로드타입 - 입금 in
				List<EgovMap> excelMemList = excelUtil.getExcelUploadData(filePath, "in");
				
				// 업로드된 파일 삭제
				//fileUtil.deleteFile(filePath);
				
				// 중복 목록 저장용도
				List<EgovMap> excelDupMemList = new ArrayList<EgovMap>();
				
				// 중복 제거한  목록 저장용도
				List<Cs2020mVO> insertMemList = new ArrayList<>();
				
				if(excelMemList.size() == 0) {
					message = "업로드 데이터 미존재";
				}else {
					boolean isValid = true;
					
					for(EgovMap memMap : excelMemList) {
						LOGGER.debug("memMap="+memMap.toString());
						String name = (String)memMap.get("corpCd");
						
						if(EgovStringUtil.isEmpty(name)) {
							message = "회사고유번호가  없는 데이터가 존재합니다.";
							break; 
						}else {
							Cs2020mVO rsUploadVO = new Cs2020mVO();
							//조건에 따른 값 설정 예시
							//if("core".equals(key)) rsUploadVO.setCore("Y");
							//else if("corr".equals(key)) rsUploadVO.setCorr("Y");
							//else if("reporter".equals(key)) rsUploadVO.setReporter("Y");
							//else if("tot".equals(key)) rsUploadVO.setTot("Y");
							//else if("payb".equals(key)) rsUploadVO.setPayb("Y");
							
							//값 매칭 예시
							//rsUploadVO.setName(EgovWebUtil.removeTag(memMap.get("name").toString()));			

							//작업자 확인  
							///EgovMap map2 = new EgovMap();
							
							//map2.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
							//map2.put("empNo", EgovUserDetailsHelper.getAuthenticatedAdminEmpNo());
							
							//ct1030mVO = ech0901DAO.selectEch0901EmpCheck(map2);

							rsUploadVO.setEmpNo(EgovUserDetailsHelper.getAuthenticatedAdminEmpNo());
							rsUploadVO.setBranchCd(EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
							
							rsUploadVO.setCorpCd(EgovWebUtil.removeTag(memMap.get("corpCd").toString()));
							rsUploadVO.setCtrtCd(EgovWebUtil.removeTag(memMap.get("ctrtCd").toString()));
							rsUploadVO.setInDt(EgovWebUtil.removeTag(memMap.get("inDt").toString()));
							rsUploadVO.setReciDt(EgovWebUtil.removeTag(memMap.get("reciDt").toString()));
							rsUploadVO.setInAmt(EgovWebUtil.removeTag(memMap.get("inAmt").toString()));
							rsUploadVO.setRemk(EgovWebUtil.removeTag(memMap.get("remk").toString()));
							
							LOGGER.debug("InAmt="+rsUploadVO.getInAmt());
							
							// 유효성 검사
							//Map<String, String> errors = MemberValidator.validate(rsUploadVO);
							//if(errors.size()!=0) {
								//message = "데이터 형식에 오류가 있어 업로드 등록에 실패하였습니다.";
								//reda.addFlashAttribute("errors", errors);
								//return redirectListPage(reda, message, "");
							//}
							
							// 중복검사 - 고객사,상담일자,내용 
							EgovMap map = new EgovMap();
							
							map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
							map.put("ctrtCd", rsUploadVO.getCtrtCd());
							map.put("inDt", rsUploadVO.getInDt());
							map.put("inAmt", rsUploadVO.getInAmt());
							List<EgovMap> list = ech0904DAO.selectEch0904DupInList(map);
							
							if(list != null && list.size() >= 1) {
								memMap.put("dupMemList", list);
								excelDupMemList.add(memMap);
							}else {
								insertMemList.add(rsUploadVO);
							}
						}
					}
					
					if(isValid) {
						session.setAttribute("insertMemList", insertMemList);	// 중복 제거 신규  목록
						LOGGER.debug("insertMemList="+insertMemList.toString());
						session.setAttribute("excelDupMemList", excelDupMemList);	// 중복 목록
						LOGGER.debug("excelDupMemList="+excelDupMemList.toString());
						message = "검증 완료. 다음 버튼을 클릭하세요.";
						gubun = "2"; // 데이터 검증 탭으로 이동
					}
				}
			}
			
		}else{
			message = "첨부 파일 미존재";
		}

		return redirectListPage(reda, message, gubun, "IN");
		
	}	
	
	//입금정보 일괄등록 - 입금정보 일괄 등록 처리 (공통)	
	@RequestMapping("/qxsepmny/cmm/CmmInSaveInData.do")
	public String CmmInSaveInData(HttpServletRequest request, ModelMap model, Cs2000mVO cs2000mVO, Cs2020mVO cs2020mVO, HttpSession session, RedirectAttributes reda, String memType) throws Exception {
		LOGGER.info("/qxsepmny/cmm/CmmInSaveInData.do - 입금정보 일괄 등록 처리(공통)");
	
		// CSRF 토큰 검사
		if(!CtmsCmmMethods.isCsrfToken(request, reda)){
		  return CtmsCmmMethods.redirectLoginView;
		}
		
		List<Cs2020mVO> insertMemList = (List<Cs2020mVO>) session.getAttribute("insertMemList");
		
		int inSq = 0;
		int inAmt = 0;
		int inTamt = 0;
		int inBamt = 0;
		// 유효성 검사 통과 등록 작업.
		for(Cs2020mVO rsUploadVO : insertMemList) {
			 
			//계약정보 설정
			cs2000mVO.setCorpCd(rsUploadVO.getCorpCd());
			cs2000mVO.setCtrtCd(rsUploadVO.getCtrtCd());
			cs2000mVO =  ech0904DAO.selectEch0904Ctrt(cs2000mVO);
			if(!cs2000mVO.equals("null")) {
				//계약번호, 고객사코드 설정 
				rsUploadVO.setCtrtNo(cs2000mVO.getCtrtNo());
				rsUploadVO.setVendNo(cs2000mVO.getVendNo());
				
				//계약금액 
				int rsTpay =  Integer.parseInt(cs2000mVO.getRsTpay());
				
				cs2020mVO.setCorpCd(rsUploadVO.getCorpCd());
				cs2020mVO.setCtrtNo(cs2000mVO.getCtrtNo());;
				cs2020mVO =  ech0904DAO.selectEch0904InAmt(cs2020mVO);
				if(cs2020mVO.getInSq().equals("0")) {//1차 입금
					rsUploadVO.setInSq(Integer.toString(inSq+1));
					rsUploadVO.setInTamt(rsUploadVO.getInAmt());
					rsUploadVO.setInBamt(Integer.toString(rsTpay - Integer.parseInt((rsUploadVO.getInAmt()))));
				}else {
						//입금차수,누적입금액,잔금 설정
						inSq = Integer.parseInt(cs2020mVO.getInSq());
						inAmt = Integer.parseInt(cs2020mVO.getInAmt());
						inTamt = Integer.parseInt(cs2020mVO.getInTamt());
						inBamt = Integer.parseInt(cs2020mVO.getInBamt());
						
						rsUploadVO.setInSq(Integer.toString(inSq+1));
						rsUploadVO.setInTamt(Integer.toString((inTamt+Integer.parseInt(rsUploadVO.getInAmt()))));
						rsUploadVO.setInBamt(Integer.toString(rsTpay - Integer.parseInt((rsUploadVO.getInTamt()))));
				}
				
				rsUploadVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
				rsUploadVO.setEmpNo(EgovUserDetailsHelper.getAuthenticatedAdminEmpNo());
				
				//int camt =  Integer.parseInt(rsUploadVO.getInAmt());
				//LOGGER.info("camt="+camt);
				LOGGER.info("rsUploadVO="+rsUploadVO.toString());
				
				ech0904DAO.insertEch0904(rsUploadVO);
				
				//계약정보 확인
			    cs2000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				cs2000mVO.setCtrtNo(rsUploadVO.getCtrtNo());
			    cs2000mVO = ech0904DAO.selectEch0904Ctrt2(cs2000mVO);
				
				//누적입금액 설정
				cs2000mVO.setInTamt(Integer.toString(Integer.parseInt(cs2000mVO.getInTamt()) + Integer.parseInt(rsUploadVO.getInAmt())));
				
				//잔금 설정
				cs2000mVO.setInBamt(Integer.toString(Integer.parseInt(cs2000mVO.getRsTpay()) - Integer.parseInt(cs2000mVO.getInTamt())));
			    ech0904DAO.updateEch0904Ctrt(cs2000mVO);
			}
		}
		
		//작업 로그 등록 
		String dspCnt = insertMemList.size()+"건";
		admLogInsert("영업관리 > 입금정보 일괄등록", dspCnt, "1010", request);
		
		String message = "등록 완료되었습니다.";
		
		return redirectListPage(reda, message, "", "IN");
	}
	
	// 자산정보 일괄등록 - 엑셀파일 파싱 (공통)
	@RequestMapping("/qxsepmny/cmm/CmmAstUploadMemData.do")
	public String CmmAstUploadMemData(MultipartHttpServletRequest multiRequest, Ct3000mVO ct3000mVO, Ct1030mVO ct1030mVO, ModelMap model, RedirectAttributes reda, HttpSession session) throws Exception {
		LOGGER.info("/qxsepmny/cmm/CmmAstUploadMemData.do -  자산정보 일괄등록 엑셀파일 파싱(공통)");
		
		String message = "";
		String gubun = "";
		
		//첨부파일 확인
		/*첨부파일 존재할시 등록*/
		if(fileUtil.uploadFileRegiChk(multiRequest)){
			FileInfoVO fileInfoVO = fileUtil.uploadAttachedFile2(multiRequest, "UPL");
			LOGGER.debug("fileInfoVO= "+fileInfoVO.toString());
			//FileInfoVO [fileId=, fileName=uploadSampleAst.xlsx, filePath=\UPL\20210527050551053.xlsx, fileTagName=, fileThumbPath=, fileThumbName=, fileBoardSeq=, fileBoardType=, fileKey=]
					
			//파일 확인
			if(fileInfoVO == null){
				LOGGER.debug("첨부된 파일의 확장자가 잘못되었습니다.");
				message = "첨부된 파일의 확장자가 잘못되었습니다.";
			}else {
				//업로드되는 파일명 검증 
				String fileName = fileInfoVO.getFileName();
				String fileName2 = fileName.substring(0, fileName.lastIndexOf("."));
				LOGGER.debug("fileName2= "+fileName2);
				
				if(!fileName2.equals("uploadSampleAst")) {
					message = "업로드 파일명을 확인해주세요(다운로드 파일명과 동일해야 합니다)";
				}else {
						String fileExt = fileName.substring(fileName.lastIndexOf(".")+1); // 확장자
						LOGGER.debug("fileExt= "+fileExt);
						
						//파일 업로드
						String filePath = fileInfoVO.getFilePath();
						LOGGER.debug(filePath);
			
						// 엑셀 데이터 파싱  filePath, 업로드타입 - 자산 ast
						List<EgovMap> excelMemList = excelUtil.getExcelUploadData(filePath, "ast");
						
						// 업로드된 파일 삭제
						//fileUtil.deleteFile(filePath);
						
						// 중복 목록 저장용도
						List<EgovMap> excelDupMemList = new ArrayList<EgovMap>();
						
						// 중복 제거한  목록 저장용도
						List<Ct3000mVO> insertMemList = new ArrayList<>();
						
						if(excelMemList.size() == 0) {
							message = "업로드 데이터 미존재";
						}else {
							boolean isValid = true;
							
							for(EgovMap memMap : excelMemList) {
								LOGGER.debug("memMap="+memMap.toString());
								String name = (String)memMap.get("corpCd");
								
								if(EgovStringUtil.isEmpty(name)) {
									message = "회사고유번호가  없는 데이터가 존재합니다.";
									break; 
								}else {
									Ct3000mVO rsUploadVO = new Ct3000mVO();
									//조건에 따른 값 설정 예시
									//if("core".equals(key)) rsUploadVO.setCore("Y");
									//else if("corr".equals(key)) rsUploadVO.setCorr("Y");
									//else if("reporter".equals(key)) rsUploadVO.setReporter("Y");
									//else if("tot".equals(key)) rsUploadVO.setTot("Y");
									//else if("payb".equals(key)) rsUploadVO.setPayb("Y");
									
									//값 매칭 예시
									//rsUploadVO.setName(EgovWebUtil.removeTag(memMap.get("name").toString()));			
		
									//작업자 확인  
									///EgovMap map2 = new EgovMap();
									
									//map2.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
									//map2.put("empNo", EgovUserDetailsHelper.getAuthenticatedAdminEmpNo());
									
									//ct1030mVO = ech0905DAO.selectEch0905EmpCheck(map2);
		
									rsUploadVO.setEmpNo(EgovUserDetailsHelper.getAuthenticatedAdminEmpNo());
									rsUploadVO.setBranchCd(EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
									
									rsUploadVO.setCorpCd(EgovWebUtil.removeTag(memMap.get("corpCd").toString()));
									rsUploadVO.setAstCls(EgovWebUtil.removeTag(memMap.get("astCls").toString()));
									rsUploadVO.setAstName(EgovWebUtil.removeTag(memMap.get("astName").toString()));
									rsUploadVO.setFctvName(EgovWebUtil.removeTag(memMap.get("fctvName").toString()));
									rsUploadVO.setPchvName(EgovWebUtil.removeTag(memMap.get("pchvName").toString()));
									rsUploadVO.setPchDt(EgovWebUtil.removeTag(memMap.get("pchDt").toString()));
									rsUploadVO.setPchAmt(EgovWebUtil.removeTag(memMap.get("pchAmt").toString()));
									rsUploadVO.setPchAmtvt(EgovWebUtil.removeTag(memMap.get("pchAmtvt").toString()));
									rsUploadVO.setPchTamt(EgovWebUtil.removeTag(memMap.get("pchTamt").toString()));
									rsUploadVO.setUseYn(EgovWebUtil.removeTag(memMap.get("useYn").toString()));
									rsUploadVO.setRemk(EgovWebUtil.removeTag(memMap.get("remk").toString()));
									
									// 유효성 검사
									Map<String, String> errors = MemberValidator.validate(rsUploadVO);
									if(errors.size()!=0) {
										message = "데이터 형식에 오류가 있어 업로드 등록에 실패하였습니다.";
										reda.addFlashAttribute("errors", errors);
										return redirectListPage2(reda, message, "", "AST");
									}
									
									// 중복검사 - 자산명,제조사,구매처,구매일자 
									EgovMap map = new EgovMap();
									
									map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
									map.put("astName", rsUploadVO.getAstName());
									map.put("fctvName", rsUploadVO.getFctvName());
									map.put("pchvName", rsUploadVO.getPchvName());
									map.put("pchDt", rsUploadVO.getPchDt());
									
									List<EgovMap> list = ech0905DAO.selectEch0905DupAstList(map);
									
									if(list != null && list.size() >= 1) {
										memMap.put("dupMemList", list);
										excelDupMemList.add(memMap);
									}else {
										insertMemList.add(rsUploadVO);
									}
								}
							}
							
							if(isValid) {
								session.setAttribute("insertMemList", insertMemList);	// 중복 제거 신규  목록
								LOGGER.debug("insertMemList="+insertMemList.toString());
								session.setAttribute("excelDupMemList", excelDupMemList);	// 중복 목록
								LOGGER.debug("excelDupMemList="+excelDupMemList.toString());
								message = "검증 완료. 다음 버튼을 클릭하세요.";
								gubun = "2"; // 데이터 검증 탭으로 이동
							}
						}
				}
			}
		}else{
			message = "첨부 파일 미존재";
		}

		return redirectListPage(reda, message, gubun, "AST");
		
	}
	
	// 연구 일괄등록 - 엑셀파일 파싱 
	@RequestMapping("/qxsepmny/cmm/CmmRsUploadMemData.do")
	public String CmmRsUploadMemData(MultipartHttpServletRequest multiRequest, ModelMap model, RedirectAttributes reda, HttpSession session) throws Exception {
		LOGGER.debug("/qxsepmny/cmm/CmmRsUploadMemData.do -  연구 일괄등록 엑셀파일 파싱");
		
		//세션 호출
		//AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
				
		//회사코드 설정
		//searchVO.setCorpCd(adminVO.getCorpCd());
		
		String message = "";
		String gubun = "";
		
		//첨부파일 확인
		/*첨부파일 존재할시 등록*/
		
		
		if(fileUtil.uploadFileRegiChk(multiRequest)){
			FileInfoVO fileInfoVO = fileUtil.uploadAttachedFile2(multiRequest, "UPL");
			
			//파일 확인
			if(fileInfoVO == null){
				LOGGER.info("첨부된 파일의 확장자가 잘못되었습니다.");
				message = "첨부된 파일의 확장자가 잘못되었습니다.";
			}else {
				
				//파일 업로드
				String filePath = fileInfoVO.getFilePath();
				LOGGER.debug(filePath);
	
				// 엑셀 데이터 파싱
				List<EgovMap> excelMemList = excelUtil.getExcelUploadData(filePath, "plan");
				
				// 업로드된 파일 삭제
				fileUtil.deleteFile(filePath);
				
				// 중복 연구계획서 목록 저장용도
				List<EgovMap> excelDupMemList = new ArrayList<EgovMap>();
				
				// 중복 제거한 연구계획서 목록 저장용도
				List<RsUploadVO> insertMemList = new ArrayList<>();
				
				if(excelMemList.size() == 0) {
					message = "연구계획서 데이터 미존재";
				}else {
					boolean isValid = true;
					
					for(EgovMap memMap : excelMemList) {
						LOGGER.debug("memMap="+memMap.toString());
						String name = (String)memMap.get("corpCd");
						
						if(EgovStringUtil.isEmpty(name)) {
							message = "회사고유번호가  없는 데이터가 존재합니다.";
							break; 
						}else {
							RsUploadVO rsUploadVO = new RsUploadVO();
							//조건에 따른 값 설정 예시
							//if("core".equals(key)) rsUploadVO.setCore("Y");
							//else if("corr".equals(key)) rsUploadVO.setCorr("Y");
							//else if("reporter".equals(key)) rsUploadVO.setReporter("Y");
							//else if("tot".equals(key)) rsUploadVO.setTot("Y");
							//else if("payb".equals(key)) rsUploadVO.setPayb("Y");
							
							//값 매칭 예시
							//rsUploadVO.setName(EgovWebUtil.removeTag(memMap.get("name").toString()));			
							//rsUploadVO.setBirthyear(EgovWebUtil.removeTag(memMap.get("birthyear").toString()));		
							//rsUploadVO.setGender(EgovWebUtil.removeTag(memMap.get("gender").toString()));			
							//rsUploadVO.setRespect(EgovWebUtil.removeTag(memMap.get("respect").toString()));			
							//rsUploadVO.setPhoneNo(EgovWebUtil.removeTag(memMap.get("phoneNo").toString()));			
							//rsUploadVO.setMphoneNo(EgovWebUtil.removeTag(memMap.get("mphoneNo").toString()));			
							//rsUploadVO.setFaxNo(EgovWebUtil.removeTag(memMap.get("faxNo").toString()));			
							rsUploadVO.setCorpCd(EgovWebUtil.removeTag(memMap.get("corpCd").toString()));			
							rsUploadVO.setRsNo1(EgovWebUtil.removeTag(memMap.get("rsNo1").toString()));
							rsUploadVO.setRsNo2(EgovWebUtil.removeTag(memMap.get("rsNo2").toString()));
							rsUploadVO.setRsNo3(EgovWebUtil.removeTag(memMap.get("rsNo3").toString()));
							rsUploadVO.setRsNo4(EgovWebUtil.removeTag(memMap.get("rsNo4").toString()));
							rsUploadVO.setRsNo5(EgovWebUtil.removeTag(memMap.get("rsNo5").toString()));
							rsUploadVO.setRsNo6(EgovWebUtil.removeTag(memMap.get("rsNo6").toString()));
							//rsUploadVO.setRsNo7(EgovWebUtil.removeTag(memMap.get("rsNo7").toString()));
							rsUploadVO.setRegDt(EgovWebUtil.removeTag(memMap.get("regDt").toString()));
							rsUploadVO.setRsMscnt(EgovWebUtil.removeTag(memMap.get("rsMscnt").toString()));
							rsUploadVO.setRsplDt(EgovWebUtil.removeTag(memMap.get("rsplDt").toString()));
							rsUploadVO.setRsitDt(EgovWebUtil.removeTag(memMap.get("rsitDt").toString()));
							rsUploadVO.setRsirbDt(EgovWebUtil.removeTag(memMap.get("rsirbDt").toString()));
							rsUploadVO.setRsrStdt(EgovWebUtil.removeTag(memMap.get("rsrStdt").toString()));
							rsUploadVO.setRsrEndt(EgovWebUtil.removeTag(memMap.get("rsrEndt").toString()));
							rsUploadVO.setRsStdt(EgovWebUtil.removeTag(memMap.get("rsStdt").toString()));
							rsUploadVO.setRsEndt(EgovWebUtil.removeTag(memMap.get("rsEndt").toString()));
							rsUploadVO.setRep2Dt(EgovWebUtil.removeTag(memMap.get("rep2Dt").toString()));
							rsUploadVO.setRepDt(EgovWebUtil.removeTag(memMap.get("repDt").toString()));
							rsUploadVO.setRsstCls(EgovWebUtil.removeTag(memMap.get("rsstCls").toString()));
							rsUploadVO.setVisitCnt(EgovWebUtil.removeTag(memMap.get("visitCnt").toString()));
							rsUploadVO.setDuplYn(EgovWebUtil.removeTag(memMap.get("duplYn").toString()));
							rsUploadVO.setRsName(EgovWebUtil.removeTag(memMap.get("rsName").toString()));
							rsUploadVO.setRsPps(EgovWebUtil.removeTag(memMap.get("rsPps").toString()));
							rsUploadVO.setRsPtc(EgovWebUtil.removeTag(memMap.get("rsPtc").toString()));
							rsUploadVO.setIrbsmYn(EgovWebUtil.removeTag(memMap.get("irbsmYn").toString()));
							//비교 예시
							//if("Y".equals(rsUploadVO.getCorr()) || "Y".equals(rsUploadVO.getReporter())) {
								// 현지통신원, KREI리포터
								//rsUploadVO.setNote(EgovWebUtil.removeTag(memMap.get("note").toString()));				
							//}else {
								// 핵심고객, 통합배부처
								//rsUploadVO.setNote2(EgovWebUtil.removeTag(memMap.get("note").toString()));				
							//}
							
							// 유효성 검사 - type검증 필요
							//Map<String, String> errors = MemberValidator.validate(rsUploadVO);
							//if(errors.size()!=0) {
								//message = "데이터 형식에 오류가 있어 연구계획서 등록에 실패하였습니다.";
								//reda.addFlashAttribute("errors", errors);
								//return redirectListPage2(reda, message, "", "RS");
							//}
							
							// 중복검사
							EgovMap map = new EgovMap();
							
							map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
							map.put("rsNo1", rsUploadVO.getRsNo1());
							map.put("rsNo2", rsUploadVO.getRsNo2());
							map.put("rsNo3", rsUploadVO.getRsNo3());
							map.put("rsNo4", rsUploadVO.getRsNo4());
							map.put("rsNo5", rsUploadVO.getRsNo5());
							map.put("rsNo6", rsUploadVO.getRsNo6());
							List<EgovMap> list = ech0105DAO.selectEch0105DupRsList(map);
							
							if(list != null && list.size() >= 1) {
								memMap.put("dupMemList", list);
								excelDupMemList.add(memMap);
							}else {
								insertMemList.add(rsUploadVO);
							}
							
						}
						
					}
					
					if(isValid) {
						session.setAttribute("insertMemList", insertMemList);	// 중복 제거 신규 회원 목록
						LOGGER.debug("insertMemList="+insertMemList.toString());
						session.setAttribute("excelDupMemList", excelDupMemList);	// 중복 회원 목록
						LOGGER.debug("excelDupMemList="+excelDupMemList.toString());
						message = "검증 완료. 다음 버튼을 클릭하세요.";
						gubun = "2"; // 데이터 검증 탭으로 이동
					}
				}
			}
			
		}else{
			message = "첨부 파일 미존재";
		}

		return redirectListPage(reda, message, gubun, "RS");
		
	}
	
	
	// 연구대상자 일괄등록 - 엑셀파일 파싱 
	@RequestMapping("/qxsepmny/cmm/CmmSjUploadMemData.do")
	public String CmmSjUploadMemData(Rs1010mVO rs1010mVO, MultipartHttpServletRequest multiRequest, ModelMap model, RedirectAttributes reda, HttpSession session) throws Exception {
		LOGGER.debug("/qxsepmny/cmm/CmmSjUploadMemData.do -  연구연구대상자 일괄등록 엑셀파일 파싱");
		
		//세션 호출
		//AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
				
		//회사코드 설정
		//searchVO.setCorpCd(adminVO.getCorpCd());
		
		String message = "";
		String gubun = "";
		
		//첨부파일 확인
		/*첨부파일 존재할시 등록*/
		
		if(fileUtil.uploadFileRegiChk(multiRequest)){
			FileInfoVO fileInfoVO = fileUtil.uploadAttachedFile2(multiRequest, "UPL");
			
			//파일 확인
			if(fileInfoVO == null){
				LOGGER.info("첨부된 파일의 확장자가 잘못되었습니다.");
				message = "첨부된 파일의 확장자가 잘못되었습니다.";
			}else {
				
				//파일 업로드
				String filePath = fileInfoVO.getFilePath();
				LOGGER.debug(filePath);
	
				// 엑셀 데이터 파싱
				List<EgovMap> excelMemList = excelUtil.getExcelUploadData(filePath, "sj");
				
				// 업로드된 파일 삭제
				fileUtil.deleteFile(filePath);
				
				// 중복 연구계획서 목록 저장용도
				List<EgovMap> excelDupMemList = new ArrayList<EgovMap>();
				
				// 중복 제거한 연구계획서 목록 저장용도
				List<RsUploadVO> insertMemList = new ArrayList<>();
				
				if(excelMemList.size() == 0) {
					message = "연구대상자 데이터 미존재";
				}else {
					boolean isValid = true;
					
					for(EgovMap memMap : excelMemList) {
						LOGGER.debug("memMap="+memMap.toString());
						String name = (String)memMap.get("corpCd");
						
						if(EgovStringUtil.isEmpty(name)) {
							message = "회사고유번호가  없는 데이터가 존재합니다.";
							break; 
						}else {
							RsUploadVO rsUploadVO = new RsUploadVO();
							//조건에 따른 값 설정 예시
							//if("core".equals(key)) rsUploadVO.setCore("Y");
							//else if("corr".equals(key)) rsUploadVO.setCorr("Y");
							//else if("reporter".equals(key)) rsUploadVO.setReporter("Y");
							//else if("tot".equals(key)) rsUploadVO.setTot("Y");
							//else if("payb".equals(key)) rsUploadVO.setPayb("Y");
							
							//값 매칭 예시
							//rsUploadVO.setName(EgovWebUtil.removeTag(memMap.get("name").toString()));			
							//rsUploadVO.setBirthyear(EgovWebUtil.removeTag(memMap.get("birthyear").toString()));		
							//rsUploadVO.setGender(EgovWebUtil.removeTag(memMap.get("gender").toString()));			
							//rsUploadVO.setRespect(EgovWebUtil.removeTag(memMap.get("respect").toString()));			
							//rsUploadVO.setPhoneNo(EgovWebUtil.removeTag(memMap.get("phoneNo").toString()));			
							//rsUploadVO.setMphoneNo(EgovWebUtil.removeTag(memMap.get("mphoneNo").toString()));			
							//rsUploadVO.setFaxNo(EgovWebUtil.removeTag(memMap.get("faxNo").toString()));			
							rsUploadVO.setCorpCd(EgovWebUtil.removeTag(memMap.get("corpCd").toString()));			
							rsUploadVO.setRsNo1(EgovWebUtil.removeTag(memMap.get("rsNo1").toString()));
							rsUploadVO.setRsNo2(EgovWebUtil.removeTag(memMap.get("rsNo2").toString()));
							rsUploadVO.setRsNo3(EgovWebUtil.removeTag(memMap.get("rsNo3").toString()));
							rsUploadVO.setRsNo4(EgovWebUtil.removeTag(memMap.get("rsNo4").toString()));
							rsUploadVO.setRsNo5(EgovWebUtil.removeTag(memMap.get("rsNo5").toString()));
							rsUploadVO.setRsNo6(EgovWebUtil.removeTag(memMap.get("rsNo6").toString()));
							//rsUploadVO.setRsNo7(EgovWebUtil.removeTag(memMap.get("rsNo7").toString()));
							rsUploadVO.setRsiNo(EgovWebUtil.removeTag(memMap.get("rsiNo").toString()));
							rsUploadVO.setRsjName(EgovWebUtil.removeTag(memMap.get("rsjName").toString()));
							rsUploadVO.setGenYn(EgovWebUtil.removeTag(memMap.get("genYn").toString()));
							rsUploadVO.setAge(EgovWebUtil.removeTag(memMap.get("age").toString()));
							//비교 예시
							//if("Y".equals(rsUploadVO.getCorr()) || "Y".equals(rsUploadVO.getReporter())) {
								// 현지통신원, KREI리포터
								//rsUploadVO.setNote(EgovWebUtil.removeTag(memMap.get("note").toString()));				
							//}else {
								// 핵심고객, 통합배부처
								//rsUploadVO.setNote2(EgovWebUtil.removeTag(memMap.get("note").toString()));				
							//}
							
							// 유효성 검사 - type검증 필요
							//Map<String, String> errors = MemberValidator.validate(rsUploadVO);
							//if(errors.size()!=0) {
								//message = "데이터 형식에 오류가 있어 연구계획서 등록에 실패하였습니다.";
								//reda.addFlashAttribute("errors", errors);
								//return redirectListPage2(reda, message, "", "RS");
							//}
							
							// 중복검사
							EgovMap map = new EgovMap();
							
							map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
							map.put("rsNo1", rsUploadVO.getRsNo1());
							map.put("rsNo2", rsUploadVO.getRsNo2());
							map.put("rsNo3", rsUploadVO.getRsNo3());
							map.put("rsNo4", rsUploadVO.getRsNo4());
							map.put("rsNo5", rsUploadVO.getRsNo5());
							map.put("rsNo6", rsUploadVO.getRsNo6());
							// 중복검증을 위한 식별번호 설정
							map.put("rsiNo", rsUploadVO.getRsNo5()+rsUploadVO.getRsNo6()+"-"+rsUploadVO.getRsiNo());
							
							//연구과제번호를 얻어야 한다.
							rs1010mVO = ecr0101DAO.selectEcr0101RsNo(map);
							 
							if(rs1010mVO == null) { // 연구코드 오기
								
								HashMap<String, Object> hashMap = new HashMap<>();
								
								String errRsCd = rsUploadVO.getRsNo1()+rsUploadVO.getRsNo2()+'-'+rsUploadVO.getRsNo3()+rsUploadVO.getRsNo4()+'-'+rsUploadVO.getRsNo5()+rsUploadVO.getRsNo6();
								hashMap.put("vendNo", "미등록연구: "+errRsCd);
								List<Object> list2 = new ArrayList<>();
								list2.add(hashMap);
								
								memMap.put("dupMemList", list2);
								excelDupMemList.add(memMap);
								
								//message = "등록되지 않은 연구코드가 존재합니다. 먼저 연구관리를 등록해주세요. 미등록연구: "+errRsCd;
								//gubun = "2"; // 데이터 검증 탭으로 이동
								//return redirectListPage(reda, message, gubun, "SJ"); 
							}else {
								rsUploadVO.setRsNo(rs1010mVO.getRsNo());
								
								//연구대상자번호 중복 check
								map.put("rsNo", rs1010mVO.getRsNo());
								
								List<EgovMap> list = ecr0101DAO.selectEcr0101DupRsjList(map);
								
								if(list != null && list.size() >= 1) {
									memMap.put("dupMemList", list);
									excelDupMemList.add(memMap);
								}else {
									insertMemList.add(rsUploadVO);
								}
							}							
							
						}
						
					}
					
					if(isValid) {
						session.setAttribute("insertMemList", insertMemList);	// 중복 제거 신규 연구대상자 목록
						LOGGER.debug("insertMemList="+insertMemList.toString());
						session.setAttribute("excelDupMemList", excelDupMemList);	// 중복 연구대상자 목록
						LOGGER.debug("excelDupMemList="+excelDupMemList.toString());
						message = "검증 완료. 다음 버튼을 클릭하세요.";
						gubun = "2"; // 데이터 검증 탭으로 이동
					}
				}
			}
			
		}else{
			message = "첨부 파일 미존재";
		}

		return redirectListPage(reda, message, gubun, "SJ");
		
	}	
	
	//자산정보 일괄등록 - 자산정보 일괄 등록 처리(공통) 	
	@RequestMapping("/qxsepmny/cmm/CmmAstSaveAstData.do")
	public String CmmAstSaveAstData(HttpServletRequest request, ModelMap model, Ct3000mVO ct3000mVO, HttpSession session, RedirectAttributes reda, String memType) throws Exception {
		LOGGER.info("/qxsepmny/cmm/CmmAstSaveAstData.do - 자산정보 일괄 등록 처리(공통)");
		LOGGER.debug("uploadFlag= "+request.getParameter("uploadFlag"));
		// CSRF 토큰 검사
		if(!CtmsCmmMethods.isCsrfToken(request, reda)){
		  return CtmsCmmMethods.redirectLoginView;
		}
		String chkFlag = request.getParameter("uploadFlag");
		String dspCnt = "";
		String dspTask = "";
		
		if(chkFlag.equals("AST")) {
			List<Ct3000mVO> insertMemList = (List<Ct3000mVO>) session.getAttribute("insertMemList");
			dspCnt = insertMemList.size()+"건";
			dspTask = "자산정보 일괄등록";
			
			// 유효성 검사 통과 등록 작업.
			for(Ct3000mVO rsUploadVO : insertMemList) {
				//자산분류 명칭/코드 분리하기
				if (!EgovStringUtil.isEmpty(rsUploadVO.getAstCls())) {
					String tempCls = rsUploadVO.getAstCls();
					
					String[] sptempCls = tempCls.split("/");
					rsUploadVO.setAstCls(sptempCls[1].toString());
				}
				rsUploadVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
				LOGGER.debug("rsUploadVO="+rsUploadVO.toString());
				
				ech0905DAO.insertEch0905(rsUploadVO);
			}	
		}
		
		//작업 로그 등록
		admLogInsert(dspTask, dspCnt, "1010", request);
		
		String message = "등록 완료되었습니다.";
		
		return redirectListPage(reda, message, "", chkFlag);
	}
	
	//데이터 일괄등록 - 데이터 일괄 등록 처리(공통) 	
	@RequestMapping("/qxsepmny/cmm/CmmSaveAllData.do")
	public String CmmSaveAllData(HttpServletRequest request, ModelMap model, Rs1010mVO rs1010mVO, Cs2000mVO cs2000mVO, Cs2020mVO cs2020mVO, Ct3000mVO ct3000mVO, Rs2000mVO rs2000mVO, HttpSession session, RedirectAttributes reda, String memType) throws Exception {
		LOGGER.info("/qxsepmny/cmm/CmmSaveAllData.do - 데이터 일괄 등록 처리(공통)");
		LOGGER.debug("uploadFlag= "+request.getParameter("uploadFlag"));
		// CSRF 토큰 검사
		if(!CtmsCmmMethods.isCsrfToken(request, reda)){
		  return CtmsCmmMethods.redirectLoginView;
		}
		String chkFlag = request.getParameter("uploadFlag");
		String dspCnt = "";
		String dspTask = "";
		String errmessage = "";
		int errcnt = 0;
		
		if(chkFlag.equals("CS")) {
			List<Cs1000mVO> insertMemList = (List<Cs1000mVO>) session.getAttribute("insertMemList");
			dspCnt = insertMemList.size()+"건";
			dspTask = "상담정보 일괄등록";
			
			// 유효성 검사 통과 등록 작업.
			for(Cs1000mVO rsUploadVO : insertMemList) {
				//상담분야 1000 마케팅용 1010 과제용  명칭/코드 분리하기
				if (!EgovStringUtil.isEmpty(rsUploadVO.getCsCls())) {
					String tempCls = rsUploadVO.getCsCls();
					
					String[] sptempCls = tempCls.split("/");
					rsUploadVO.setCsCls(sptempCls[1].toString());
				}
				
				rsUploadVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
				LOGGER.info("rsUploadVO="+rsUploadVO.toString());
				
				ech0901DAO.insertEch0901(rsUploadVO);
				
			}
		}else if(chkFlag.equals("IN")) {
			List<Cs2020mVO> insertMemList = (List<Cs2020mVO>) session.getAttribute("insertMemList");
			dspCnt = insertMemList.size()+"건";
			dspTask = "입금정보 일괄등록";
			
			int inSq = 0;
			int inAmt = 0;
			int inTamt = 0;
			int inBamt = 0;			
			// 유효성 검사 통과 등록 작업.
			for(Cs2020mVO rsUploadVO : insertMemList) {
				 
				//계약정보 설정
				cs2000mVO.setCorpCd(rsUploadVO.getCorpCd());
				cs2000mVO.setCtrtCd(rsUploadVO.getCtrtCd());
				cs2000mVO =  ech0904DAO.selectEch0904Ctrt(cs2000mVO);
				if(!cs2000mVO.equals("null")) {
					//계약번호, 고객사코드 설정 
					rsUploadVO.setCtrtNo(cs2000mVO.getCtrtNo());
					rsUploadVO.setVendNo(cs2000mVO.getVendNo());
					
					//계약금액 
					int rsTpay =  Integer.parseInt(cs2000mVO.getRsTpay());
					
					cs2020mVO.setCorpCd(rsUploadVO.getCorpCd());
					cs2020mVO.setCtrtNo(cs2000mVO.getCtrtNo());;
					cs2020mVO =  ech0904DAO.selectEch0904InAmt(cs2020mVO);
					if(cs2020mVO.getInSq().equals("0")) {//1차 입금
						rsUploadVO.setInSq(Integer.toString(inSq+1));
						rsUploadVO.setInTamt(rsUploadVO.getInAmt());
						rsUploadVO.setInBamt(Integer.toString(rsTpay - Integer.parseInt((rsUploadVO.getInAmt()))));
					}else {
							//입금차수,누적입금액,잔금 설정
							inSq = Integer.parseInt(cs2020mVO.getInSq());
							inAmt = Integer.parseInt(cs2020mVO.getInAmt());
							inTamt = Integer.parseInt(cs2020mVO.getInTamt());
							inBamt = Integer.parseInt(cs2020mVO.getInBamt());
							
							rsUploadVO.setInSq(Integer.toString(inSq+1));
							rsUploadVO.setInTamt(Integer.toString((inTamt+Integer.parseInt(rsUploadVO.getInAmt()))));
							rsUploadVO.setInBamt(Integer.toString(rsTpay - Integer.parseInt((rsUploadVO.getInTamt()))));
					}
					
					rsUploadVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
					rsUploadVO.setEmpNo(EgovUserDetailsHelper.getAuthenticatedAdminEmpNo());
					
					//int camt =  Integer.parseInt(rsUploadVO.getInAmt());
					//LOGGER.info("camt="+camt);
					LOGGER.debug("rsUploadVO="+rsUploadVO.toString());
					
					ech0904DAO.insertEch0904(rsUploadVO);
					
					//계약정보 확인
				    cs2000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
					cs2000mVO.setCtrtNo(rsUploadVO.getCtrtNo());
				    cs2000mVO = ech0904DAO.selectEch0904Ctrt2(cs2000mVO);
					
					//누적입금액 설정
					cs2000mVO.setInTamt(Integer.toString(Integer.parseInt(cs2000mVO.getInTamt()) + Integer.parseInt(rsUploadVO.getInAmt())));
					
					//잔금 설정
					cs2000mVO.setInBamt(Integer.toString(Integer.parseInt(cs2000mVO.getRsTpay()) - Integer.parseInt(cs2000mVO.getInTamt())));
				    ech0904DAO.updateEch0904Ctrt(cs2000mVO);
				}
			}
		}else if(chkFlag.equals("AST")) {
			List<Ct3000mVO> insertMemList = (List<Ct3000mVO>) session.getAttribute("insertMemList");
			dspCnt = insertMemList.size()+"건";
			dspTask = "자산정보 일괄등록";
			
			// 유효성 검사 통과 등록 작업.
			for(Ct3000mVO rsUploadVO : insertMemList) {
				//자산분류 명칭/코드 분리하기
				if (!EgovStringUtil.isEmpty(rsUploadVO.getAstCls())) {
					String tempCls = rsUploadVO.getAstCls();
					
					String[] sptempCls = tempCls.split("/");
					rsUploadVO.setAstCls(sptempCls[1].toString());
				}
				rsUploadVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
				LOGGER.debug("rsUploadVO="+rsUploadVO.toString());
				
				ech0905DAO.insertEch0905(rsUploadVO);
			}	
		}else if(chkFlag.equals("RS")) {
			List<RsUploadVO> insertMemList = (List<RsUploadVO>) session.getAttribute("insertMemList");
			dspCnt = insertMemList.size()+"건";
			dspTask = "연구정보 일괄등록";
			
			// 유효성 검사 통과 등록 작업.
			for(RsUploadVO rsUploadVO : insertMemList) {
				//기본값 설정 
				rsUploadVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				rsUploadVO.setRsDrt(EgovUserDetailsHelper.getAuthenticatedAdminEmpNo());
				rsUploadVO.setRsGrt(EgovUserDetailsHelper.getAuthenticatedAdminEmpNo());
				rsUploadVO.setBranchCd(EgovUserDetailsHelper.getAuthenticatedAdminBranchCd());
				rsUploadVO.setDelYn("N");
				rsUploadVO.setDataLockYn("N");
				rsUploadVO.setEcrfState("WAIT");
				
				//연구상태 값 전환하기 예정 10 진행 20 완료 30 취소 40  명칭만
				if(rsUploadVO.getRsstCls().equals("예정")) {
					rsUploadVO.setRsstCls("10");
				}else if(rsUploadVO.getRsstCls().equals("진행")) {
					rsUploadVO.setRsstCls("20");
				}else if(rsUploadVO.getRsstCls().equals("완료")) {
					rsUploadVO.setRsstCls("30");
				}else if(rsUploadVO.getRsstCls().equals("취소")) {
					rsUploadVO.setRsstCls("40");
				}	
				
				//제품정보 1010 화장품 1020 보습제 1030 수분제 코드(명칭) 분리하기
				//if (!EgovStringUtil.isEmpty(rsUploadVO.getItemCls())) {
					//String itemCls = rsUploadVO.getItemCls();
					
					//String[] spitemCls = itemCls.split("/");
					//rsUploadVO.setItemCls(spitemCls[1].toString());
				//}
				
				rsUploadVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
				
				ech0105DAO.insertEch0105RsUpload(rsUploadVO);
				LOGGER.info("rsUploadVO="+rsUploadVO.toString());
			}
		}else if(chkFlag.equals("SJ")) {
			List<RsUploadVO> insertMemList = (List<RsUploadVO>) session.getAttribute("insertMemList");
			dspCnt = insertMemList.size()+"건";
			dspTask = "연구대상자정보 일괄등록";			
			
			// 유효성 검사 통과 등록 작업.
			for(RsUploadVO rsUploadVO : insertMemList) {
				//기본값 설정 
				rsUploadVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				rsUploadVO.setAppYn("N");
				rsUploadVO.setFirstSt("Y");
				rsUploadVO.setCfmYn("Y");					
				rsUploadVO.setPoolYn("Y");
				rsUploadVO.setRsiNo1(rsUploadVO.getRsNo5()+rsUploadVO.getRsNo6());
				rsUploadVO.setRsjNo("999999");
				rsUploadVO.setAppstaCls("20");
				
				// 식별번호 설정
				rsUploadVO.setRsiNo3(rsUploadVO.getRsiNo());
				rsUploadVO.setRsiNo(rsUploadVO.getRsiNo1()+"-"+rsUploadVO.getRsiNo3());
				// 연구코드 설정
				rsUploadVO.setRsCd(rsUploadVO.getRsNo1()+rsUploadVO.getRsNo2()+"-"+rsUploadVO.getRsNo3()+rsUploadVO.getRsNo4()+"-"+rsUploadVO.getRsNo5()+rsUploadVO.getRsNo6());
				rsUploadVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
				// 성별구분 설정
				if(rsUploadVO.getGenYn().equals("M")) {
					rsUploadVO.setGenYn("1");
				}else if(rsUploadVO.getGenYn().equals("F")) {
					rsUploadVO.setGenYn("2");
				}
				
				EgovMap mapRsNo = new EgovMap();
				mapRsNo.put("corpCd",rsUploadVO.getCorpCd());
				mapRsNo.put("rsNo1",rsUploadVO.getRsNo1());
				mapRsNo.put("rsNo2",rsUploadVO.getRsNo2());
				mapRsNo.put("rsNo3",rsUploadVO.getRsNo3());
				mapRsNo.put("rsNo4",rsUploadVO.getRsNo4());
				mapRsNo.put("rsNo5",rsUploadVO.getRsNo5());
				mapRsNo.put("rsNo6",rsUploadVO.getRsNo6());
				
				rs1010mVO = ecr0101DAO.selectEcr0101RsNo(mapRsNo);
				if(rs1010mVO == null ) { // rsNo가 없는 경우 - 연구코드 오기  데이터 검증 필요 
					errmessage = "연구코드 오류입니다. 확인해주세요.";
					errcnt++;
				}else {
					// 연구관리에서 설정해야 한다.
					rsUploadVO.setAppStdt(rs1010mVO.getRsStdt());					
					rsUploadVO.setAppEndt(rs1010mVO.getRsEndt());
					
					String subNo = ecr0101DAO.insertEcr0101RsjUpload(rsUploadVO);
					LOGGER.info("rsUploadVO="+rsUploadVO.toString());
					
					// 연구차수별 연구대상자 추가 필요함
					//RS2000M을 연구번호별 등록한다. - 추가해야 함
					EgovMap map2 = new EgovMap();
					map2.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
					map2.put("rsCd", rsUploadVO.getRsCd());
					List<Rs1000mVO> resultList2 = ech0102DAO.selectEch0102RsList(map2);
					LOGGER.debug("resultList2.size()= "+resultList2.size());
					
					if(resultList2.size() != 0){
						//RS2010M 를 읽는다.
						rs2000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
						rs2000mVO.setRsNo(rs1010mVO.getRsNo());
						rs2000mVO.setSubNo(subNo);
						rs2000mVO = ech0102DAO.selectEch0102(rs2000mVO);
						
						for(Rs1000mVO rs1000mVO : resultList2){
							rs2000mVO.setRsNo(rs1000mVO.getRsNo());
							rs2000mVO.setRsiNo2(rs1000mVO.getRsNo7());
							rs2000mVO.setRsiNo(rs2000mVO.getRsiNo1()+'-'+rs1000mVO.getRsNo7()+'-'+rs2000mVO.getRsiNo3());
							//연구대상자번호, 참여상태, 스크리닝번호 설정 
							
							rs2000mVO.setGenYn(rsUploadVO.getGenYn());
							rs2000mVO.setAge(rsUploadVO.getAge());
							rs2000mVO.setMrsiNo(rsUploadVO.getRsiNo());
							String rsNo2 = ech0102DAO.insertEch0102(rs2000mVO);
							LOGGER.debug("rsNo2= "+rsNo2); 
						}
					}
									
					EgovMap map = new EgovMap();
					map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
					map.put("rsNo", rsUploadVO.getRsNo());
					
					//연구과제의 피험자수를 업데이트한다  RS1000M RS_SCNT
					//RS1010M
					ech0102DAO.updateEch0102RsScnt(map);
					//RS1000M
					ech0102DAO.updateEch0102RsScnt2(map);
					}
			}
			
		}
		
		//작업 로그 등록
		admLogInsert(dspTask, dspCnt, "1010", request);
		
		String message = "등록 완료되었습니다."+errmessage+" 오류건수 : "+errcnt+"건";
		
		return redirectListPage(reda, message, "", chkFlag);
	}	
	
	
	
	//일괄등록 목록 또는 호출한  List화면으로 이동합니다.
	private String redirectListPage(RedirectAttributes reda, String message, String gubun, String flag){
		reda.addFlashAttribute("message", message);
		if(flag.equals("CS")) { // 상담 일괄등록
			reda.addFlashAttribute("flag", "CS");	
		}else if(flag.equals("IN")) { // 입금 일괄등록
			reda.addFlashAttribute("flag", "IN");
		}else if(flag.equals("AST")) { // 자산 일괄등록
			reda.addFlashAttribute("flag", "AST");
		}else if(flag.equals("RS")) { // 연구 일괄등록
			reda.addFlashAttribute("flag", "RS");
		}else if(flag.equals("SJ")) { // 연구대상자 일괄등록
			reda.addFlashAttribute("flag", "SJ"); 
		}
		
		LOGGER.debug("gubun= "+gubun);
		if(gubun.isEmpty()) {
			if(flag.equals("CS")) {
				return "redirect:/qxsepmny/ech0901/ech0901List.do";
			}else if(flag.equals("IN")) {
				return "redirect:/qxsepmny/ech0904/ech0904List.do";
			}else if(flag.equals("AST")) {
				return "redirect:/qxsepmny/ech0905/ech0905List.do";
			}else if(flag.equals("RS")) {
				return "redirect:/qxsepmny/ech0105/ech0105List.do";
			}else if(flag.equals("SJ")) {
				return "redirect:/qxsepmny/ech0211/ech0211List.do";
			}else {
				return "redirect:/qxsepmny/ech0901/ech0901List.do";
			}
		}else {
			return "redirect:/qxsepmny/cmm/CmmUplsUpload"+gubun+".do";
		}
	}	

	//일괄등록 목록 또는 호출한  List화면으로 이동합니다.
	private String redirectListPage2(RedirectAttributes reda, String message, String gubun, String flag){
		reda.addFlashAttribute("message", message);
		if(flag.equals("CS")) {
			reda.addFlashAttribute("flag", "CS");	
		}else if(flag.equals("IN")) {
			reda.addFlashAttribute("flag", "IN");
		}else if(flag.equals("AST")) {
			reda.addFlashAttribute("flag", "AST");
		}else if(flag.equals("RS")) {
			reda.addFlashAttribute("flag", "RS");
		}else if(flag.equals("SJ")) {
			reda.addFlashAttribute("flag", "SJ");
		}
		
		//model.addAttribute("searchVO", searchVO);
		//return "redirect:/qxsepmny/cmm/CmmUplsUpload"+gubun+".do?uploadFlag="+flag;
		return "redirect:/qxsepmny/cmm/CmmUplsUploadErr.do?uploadFlag="+flag;
			
	}
		
	// 일괄업로드 화면 표출 - 1)엑셀파일 업로드 화면 호출 
	@RequestMapping("/qxsepmny/cmm/CmmUplsUploadErr.do")
	public String CmmUplsUploadErr(@ModelAttribute CmmnSearchVO searchVO, Ct7000mVO ct7000mVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda, HttpSession session) throws Exception {
		LOGGER.debug("/qxsepmny/cmm/CmmUplsUploadErr.do - 일괄업로드  에러 화면 표출");
		//회사코드 설정
		searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		LOGGER.debug("uploadFlag= "+request.getParameter("uploadFlag"));
		
		String uploadFlag = request.getParameter("uploadFlag");
				
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		searchVO.setSearchParam2(adminVO.getAdminType());
		
		// 엑셀 데이터 삭제
		session.removeAttribute("insertMemList");
		session.removeAttribute("excelDupMemList");
		
		//양식파일의 ATTACH_NO을 획득한다.
		EgovMap map = new EgovMap();
		if(uploadFlag.equals("CS")) {
			map.put("boardSeq", "CSUPLS");
		}else if(uploadFlag.equals("IN")) {
			map.put("boardSeq", "INUPLS");
		}else if(uploadFlag.equals("AST")) {
			map.put("boardSeq", "ASTUPLS");
		}else if(uploadFlag.equals("RS")) {
			map.put("boardSeq", "RSUPLS");
		}else if(uploadFlag.equals("SJ")) {
			map.put("boardSeq", "SJUPLS");
		}  
		
		map.put("boardType", "UPLS");
		map.put("fileKey", "attachRpt01");
		ct7000mVO = cmmDAO.selectAttachListFileKeyOne(map);
		if(ct7000mVO != null) {
			searchVO.setSearchParam1(ct7000mVO.getAttachNo());
		}
		
		searchVO.setSearchParam3(uploadFlag);
		
		model.addAttribute("searchVO", searchVO);

		return "/adm/cmm/admUplsUpload";
		
	}	
	//-- 데이터일괄등록 끝

}
