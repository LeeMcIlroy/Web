package ctms.adm.ech0301;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.tribes.util.Arrays;
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
import component.file.CmmnFileController;
import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.util.ComStringUtil;
import component.web.PaginationController;
import ctms.adm.cmm.AdmCmmController;
import ctms.adm.ech0101.Ech0101DAO;
import ctms.adm.ech0102.Ech0102DAO;
import ctms.adm.ech1001.Ech1001DAO;
import ctms.cmm.CmmDAO;
import ctms.valueObject.AdminVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Rm2000mVO;
import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.Rs2000mVO;
import ctms.valueObject.Sb1000mVO;
import ctms.valueObject.Sb1010mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class Ech0301Controller extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0301Controller.class);
	@Autowired private Ech0101DAO ech0101DAO;
	@Autowired private Ech0102DAO ech0102DAO;
	@Autowired private Ech1001DAO ech1001DAO;
	@Autowired private Ech0301DAO ech0301DAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private View jsonView;
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
			
	
	//로그인화면으로 리다이렉트합니다.
	//private String redirectLoginView(RedirectAttributes reda, String message){
	//	reda.addFlashAttribute("message", message);
	//	return "redirect:/qxsepmny/lgn/admLoginView.do";
	//}
	
	/**
	 * 관리자 코딩 화면으로 이동합니다.
	 * @param model
	 * @return 코딩 화면
	 * @throws Exception
	 */
	
	
	// ********************************(피험자관리) 20201203 관리자 피험자관리 목록화면********************************
	@RequestMapping("/qxsepmny/ech0301/ech0301List.do")	
	public String ech0301List(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.debug("/qxsepmny/ech0301/ech0301List.do - 피험자관리 피험자관리 목록화면");
		LOGGER.debug("searchVO="+searchVO.toString());
		//request.getSession().setAttribute("admMenuNo", "703");
				
		//회사코드 설정 
		searchVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());

		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		//엑셀다운로드 권한 설정 Y 허용  N 허용안함 
		model.addAttribute("exauth", adminVO.getExauth());
		model.addAttribute("adminType", adminVO.getAdminType());
		
		//검색조건 설정 
		//검색기간에 from 이번주 월요일  to 오늘일자 설정 
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition2())){
			if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
				
				String rtnStr = null;
				
				// 문자열로 변환하기 위한 패턴 설정(년도-월-일)
				String pattern = "yyyy-MM-dd";
			
				SimpleDateFormat sdfCurrent = new SimpleDateFormat(pattern, Locale.KOREA);
			    Timestamp ts = new Timestamp(System.currentTimeMillis());
			    
			    rtnStr = sdfCurrent.format(ts.getTime()+(1000*60*60*24*-7));
					
			    searchVO.setSearchCondition1(EgovStringUtil.getCurMonday());
			}
		}
	
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition2())){
			String nowDate = EgovStringUtil.getDateMinus();			
			searchVO.setSearchCondition2(nowDate);
			
			//월요일이 현재일자보고 큰 경우 현재일자를 동일하게 설정
			if((EgovStringUtil.getCurMonday().compareTo(EgovStringUtil.getDateMinus()))>0) {
				searchVO.setSearchCondition1(searchVO.getSearchCondition2());
			}
		}
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition4())){
			searchVO.setSearchCondition4("1"); // 접수일자 설정
		}

		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = ech0301DAO.selectEch0301List(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
	
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
				
		return "/adm/ech0301/ech0301List";
	}
	
	// ********************************(피험자관리) 20201128 관리자 피험자관리 상세보기화면********************************
	@RequestMapping("/qxsepmny/ech0301/ech0301View.do")
	public String ech0301View(@ModelAttribute CmmnSearchVO searchVO , Sb1000mVO sb1000mVO, Sb1010mVO sb1010mVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0301/ech0301View.do - 피험자관리 피험자관리 상세보기화면");
		//request.getSession().setAttribute("admMenuNo", "703");
	
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		model.addAttribute("adminType", adminVO.getAdminType());		

		sb1000mVO =  ech0301DAO.selectEch0301View(sb1000mVO);
		
		sb1010mVO =  ech0301DAO.selectEch0301ResearchCls(sb1010mVO);
				
		model.addAttribute("sb1000mVO", sb1000mVO);
		model.addAttribute("sb1010mVO", sb1010mVO);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("pageIndex", searchVO.getPageIndex());
		
		//예약현황 목록
		List<EgovMap> mtList = ech0301DAO.selectEch0301MtList(sb1000mVO);
		model.addAttribute("mtList", mtList);
		
		//참여현황 목록
		List<EgovMap> jnList = ech0301DAO.selectEch0301JnList(sb1000mVO);
		model.addAttribute("jnList", jnList);
		
		EgovMap map = new EgovMap();
		map.put("boardSeq", sb1000mVO.getCorpCd()+sb1000mVO.getRsjNo());
		map.put("boardType", "RSBJ");
		List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
		model.addAttribute("attachList", attachList);
		
		EgovMap attachMap = new EgovMap();
		
		for(Ct7000mVO attach : attachList){
			attachMap.put(attach.getFileKey(), attach);
		}
		
		model.addAttribute("attachMap", attachMap);
					
		return "/adm/ech0301/ech0301View";
	}	

	// ********************************(피험자관리) 20201128 관리자 피험자관리 등록&수정 화면********************************
	@RequestMapping("/qxsepmny/ech0301/ech0301Modify.do")
	public String ech0301Modify(@ModelAttribute("sb1000mVO") Sb1000mVO sb1000mVO, Sb1010mVO sb1010mVO, CmmnSearchVO searchVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0301/ech0301Modify.do - 관리자 피험자관리 등록&수정 화면");
		String message = "";
				
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		// 회사코드 설정 
		sb1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		//지사명  목록 
		List<EgovMap> branch = cmmDAO.selectBranchList(sb1000mVO.getCorpCd());
		model.addAttribute("branch", branch);
		
		//사원구분(공통코드) 목록 CT1010			
		List<EgovMap> ct1010 = cmmDAO.selectCmmCdList(sb1000mVO.getCorpCd(), "CT1010");
		model.addAttribute("ct1010", ct1010);
		
		model.addAttribute("searchVO", searchVO);

		//등록화면으로
		if (EgovStringUtil.isEmpty(sb1000mVO.getRsjNo())) {
			
			// 등록일자-오늘일자 초기 설정 
			String nowDate = EgovStringUtil.getDateMinus();
			sb1000mVO.setRegDt(nowDate);
						
			//model.addAttribute("adminVO", adminVO);
			model.addAttribute("NotiPageGubun","NotiRegist");
		}
		
		//수정화면으로 
		if(!EgovStringUtil.isEmpty(sb1000mVO.getRsjNo())){
					
			sb1000mVO = ech0301DAO.selectEch0301View(sb1000mVO);
			
			//연구대상자를 등록한 지사소속만 수정 가능함, 관리자권한은 예외
			if(adminVO.getAdminType().equals("2")) {
				if(!EgovUserDetailsHelper.getAuthenticatedAdminBranchCd().equals(sb1000mVO.getBranchCd())){
					
					model.addAttribute("sb1000mVO", sb1000mVO);
					model.addAttribute("sb1010mVO", sb1010mVO);
					
					message = "관리자권한이 없거나 연구대상자의 소속지사가 아니어서 수정권한이 없습니다.";
					
					return redirectView(reda, message, sb1000mVO, sb1010mVO );
				}	
			}

			sb1010mVO = ech0301DAO.selectEch0301ResearchCls(sb1010mVO);
			
			//주민번호 분리하기
			if (!EgovStringUtil.isEmpty(sb1000mVO.getJregNo())) {
				//주민번호 복호화		
				String jreNo = EgovFileScrty.decode(sb1000mVO.getJregNo());
				
				String[] spjreNo = jreNo.split("-");
				sb1000mVO.setRegNo1(spjreNo[0].toString());
				sb1000mVO.setRegNo2(spjreNo[1].toString());
			}	
			
			// 핸드폰 번호을 3-4-4 형식으로 나눈다. 핸드폰번호는 - 없이 저장
			if (!EgovStringUtil.isEmpty(sb1000mVO.getHpNo())) {
				
				String hpNo = sb1000mVO.getHpNo();
				sb1000mVO.setMobile1(hpNo.substring(0, 3)); // 핸드폰번호1 3자리
				sb1000mVO.setMobile2(hpNo.substring(3, 7)); // 핸드폰번호2 4자리
				//sb1000mVO.setMobile3(hpNo.substring(7, 4)); // 핸드폰번호2 4자리
				sb1000mVO.setMobile3(hpNo.substring(hpNo.length()-4, hpNo.length())); // 핸드폰번호3 4자리
			}
				
			//생년월일 분리하기
			if (!EgovStringUtil.isEmpty(sb1000mVO.getBrDt())) {
				String brDt = sb1000mVO.getBrDt();
				
				String[] spbrDt = brDt.split("-");
				sb1000mVO.setBrDtY(spbrDt[0].toString());
				sb1000mVO.setBrDtM(spbrDt[1].toString());
				sb1000mVO.setBrDtD(spbrDt[2].toString());
			}	
			
			//이메일 분리하기
			if (!EgovStringUtil.isEmpty(sb1000mVO.getEmail())) {
				String email = sb1000mVO.getEmail();
				
				String[] spemail = email.split("@");
				sb1000mVO.setEmailId(spemail[0].toString());
				sb1000mVO.setEmailAdr(spemail[1].toString());
			}
			
			//계좌번호 복호화
			if (!EgovStringUtil.isEmpty(sb1000mVO.getAcctNo())) {
				sb1000mVO.setAcctNo(EgovFileScrty.decode(sb1000mVO.getAcctNo()));
			}
						
			model.addAttribute("NotiPageGubun","NotiUpdate");
			model.addAttribute("sb1000mVO", sb1000mVO);
			model.addAttribute("sb1010mVO", sb1010mVO); // 연구대상자(피험자) 유형
			
			EgovMap map = new EgovMap();
			map.put("boardSeq", sb1000mVO.getCorpCd()+sb1000mVO.getRsjNo());
			map.put("boardType", "RSBJ");
			List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
			model.addAttribute("attachList", attachList);
			
			EgovMap attachMap = new EgovMap();
			
			for(Ct7000mVO attach : attachList){
				attachMap.put(attach.getFileKey(), attach);
			}
			
			model.addAttribute("attachMap", attachMap);
			
			
			//String purpose = "branch_no";
			//List<EgovMap> rsubjctNo = cmmDAO.selectBranchList();
			//model.addAttribute("RsubjctNo", rsubjctNo);
			
			// 파일첨부 설정 - 변경해야함
			//EgovMap map = new EgovMap();
			//map.put("boardNo", sb1000mVO.getRsubjctNo());
			//map.put("boardType", "RSBJ");			
			
			//첨부파일 데이터 조회
			//List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
			//model.addAttribute("attachList", attachList);
			// 해당 게시판 첨부파일 개수
			//int attachListCnt = cmmDAO.selectAttachListCnt(sb1000mVO.getRsubjctNo());
			//model.addAttribute("attachListCnt",attachListCnt);	
		}
		
		//개인정보처리 로그 등록 
		admLogInsert("연구대상자 > 연구대상자 상세정보조회", sb1000mVO.getRsjNo(), sb1000mVO.getRsjName(), request);
		
		return "/adm/ech0301/ech0301Modify";
	}

		// ********************************(피험자관리) 20201128 관리자 피험자관리 저장 ********************************
		@RequestMapping("/qxsepmny/ech0301/ech0301Update.do")
		public String ech0301Save(@ModelAttribute("sb1000mVO") Sb1000mVO sb1000mVO, Sb1010mVO sb1010mVO, String deleteFileIds, String[] delFile,MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0301/ech0301Update.do - 관리자 피험자관리 저장");
		String message = "";
		
		//세션 호출
		//AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionLcms");
		
		// 회사코드(CTMS운영) 설정
		sb1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		sb1010mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		//등록자 설정 - 아이디가 아니고 EMP_NO ? USRE_ID는 변경 가능함  
		//getAuthenticatedAdminEmpNo()
		sb1000mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
		sb1010mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
		
		//주민번호 합치기
		if (!EgovStringUtil.isEmpty(sb1000mVO.getRegNo1())) {
			sb1000mVO.setJregNo(sb1000mVO.getRegNo1()+"-"+sb1000mVO.getRegNo2()); 
		}
		
		//핸드폰 합치기 - 는 사용하지 않음
		if (!EgovStringUtil.isEmpty(sb1000mVO.getMobile2())) {
			sb1000mVO.setHpNo(sb1000mVO.getMobile1()+sb1000mVO.getMobile2()+sb1000mVO.getMobile3());
		}
		
		//생년월일 합치기
		if (!EgovStringUtil.isEmpty(sb1000mVO.getBrDtY())) {
			sb1000mVO.setBrDt(sb1000mVO.getBrDtY()+"-"+sb1000mVO.getBrDtM()+"-"+sb1000mVO.getBrDtD());
		}
		
		//이메일 합치기
		if (!EgovStringUtil.isEmpty(sb1000mVO.getEmailId())) {
			sb1000mVO.setEmail(sb1000mVO.getEmailId()+"@"+sb1000mVO.getEmailAdr());
		}

		//주민번호 암호화
		if (!EgovStringUtil.isEmpty(sb1000mVO.getJregNo())) {
			sb1000mVO.setJregNo(EgovFileScrty.encode(sb1000mVO.getJregNo()));
		}
		
		//계좌번호 암호화
		if (!EgovStringUtil.isEmpty(sb1000mVO.getAcctNo())) {
			sb1000mVO.setAcctNo(EgovFileScrty.encode(sb1000mVO.getAcctNo()));
		}
		
		if(EgovStringUtil.isEmpty(sb1000mVO.getRsjNo())){
			
			ech0301DAO.insertEch0301(sb1000mVO);
			
			// 연구대상자(피험자) 유형 등록 - 1:1			
			sb1010mVO.setRsjNo(sb1000mVO.getRsjNo());
			ech0301DAO.insertEch0301ResearchCls(sb1010mVO);

			EgovMap map = new EgovMap();
			map.put("boardSeq", sb1000mVO.getCorpCd()+sb1000mVO.getRsjNo());
			map.put("boardType", "RSBJ");
			List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
			model.addAttribute("attachList", attachList);
			
			EgovMap attachMap = new EgovMap();
			
			for(Ct7000mVO attach : attachList){
				attachMap.put(attach.getFileKey(), attach);
			}
			
			model.addAttribute("attachMap", attachMap);
			
			
			// 첨부파일 등록
			//List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "RSBJ");
			//if(fileInfoList != null){
				//for(FileInfoVO fileInfoVO : fileInfoList){
					//Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
					//attachVO.setBoardType("RSBJ");
					//attachVO.setBoardNo(sb1000mVO.getRsjNo());
					//cmmDAO.insertAttachFile(attachVO);
				//}
			//}
			message = "등록이 완료되었습니다.";
			
			//개인정보처리 로그 등록 
			admLogInsert("연구대상자 > 연구대상자 등록", sb1000mVO.getRsjNo(), sb1000mVO.getRsjName(), request);
		}else{
			
			// 연구대상자 수정
			ech0301DAO.updateEch0301(sb1000mVO);
			
			// 연구대상자 유형 수정
			ech0301DAO.updateEch0301ResearchCls(sb1010mVO);
			
			//파일 업로드
			//List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "RSBJ");
			//if(fileInfoList != null){
				//for(FileInfoVO fileInfoVO : fileInfoList){
					//Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
					//attachVO.setBoardType("RSBJ");
					//attachVO.setBoardNo(sb1000mVO.getRsubjctNo());
					//cmmDAO.insertAttachFile(attachVO);
				//}
			//}
			if(delFile != null){
				for(String seq : delFile){
					System.out.println(seq);
					Ct7000mVO delAttach = cmmDAO.selectAttachOne(seq);
					cmmDAO.deleteAttachFile(delAttach.getAttachNo());
					fileUtil.deleteFile(delAttach.getRegFileName());
				}
			}
			message = "수정이 완료되었습니다.";
			
			//개인정보처리 로그 등록 
			admLogInsert("연구대상자 > 연구대상자 수정", sb1000mVO.getRsjNo(), sb1000mVO.getRsjName(), request);
		}

		List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "RSBJ");
		if(fileInfoList != null){
			for(FileInfoVO fileInfoVO : fileInfoList){
				LOGGER.debug("----- fileKey = " + fileInfoVO.getFileKey() + " -----");
				Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
				attachVO.setBoardNo(String.valueOf(sb1000mVO.getCorpCd()+sb1000mVO.getRsjNo())); //회사코드+연구대상자번호 
				attachVO.setBoardType("RSBJ");//폴더명
				//attachVO.setFileKey(fileInfoVO.getFileKey()); //파일명 네임값도 컬럼에넣기(삭제하거나 리스트출력시 키값사용)
				
				cmmDAO.insertAttachFile(attachVO);				
				
			}
		}
		
		// 1. 파일 암호화
		//String sfile = "D:\\WAS\\2020\\ctms\\upload\\attach\\RSBJ\\1.docx";
		//String tfile = "D:\\WAS\\2020\\ctms\\upload\\attach\\RSBJ\\encode.docx";
		//LOGGER.debug("sfile = "+sfile);
		//LOGGER.debug("tfile = "+tfile);
		//String source = sfile;
		//String target = tfile;
		//String source = request.getParameter(sfile);
		//String target = request.getParameter(tfile);
		//boolean result = false;
		//if (sfile != null && source.length() > 0
			//&& target != null && target.length() > 0) {
			//LOGGER.debug("encryptFile1 = ");
			//result = EgovFileScrty.encryptFile(source, target);
			//LOGGER.debug("encryptFile2 = "+result);
		//}
		
		// 2. 파일 복호화
		
		//String source2 = "D:\\WAS\\2020\\ctms\\upload\\attach\\RSBJ\\encode.docx"; 
		//String target2 = "D:\\WAS\\2020\\ctms\\upload\\attach\\RSBJ\\decode.docx"; 
		//String source = request.getParameter("file1"); 
		//String target = request.getParameter("file2"); 
		//boolean result2 = false; 
		//if (source2 != null && source2.length() > 0 
			//&& target2 != null && target2.length() > 0) { 
			//result2 = EgovFileScrty.decryptFile(source2, target2);
			//LOGGER.debug("encryptFile3 = "+result2); 
		//}
		 
		
		return redirectList(reda, message);

	}
	// ********************************(피험자관리) 20201128 관리자 피험자관리 삭제 ********************************
	@RequestMapping("/qxsepmny/ech0301/ech0301Delete.do")
	public String ech0301Delete(@ModelAttribute Sb1000mVO sb1000mVO, Sb1010mVO sb1010mVO, String[] delSeqList, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
	LOGGER.debug("/qxsepmny/ech0301/ech0301Delete.do - 관리자 피험자관리 삭제");
	String message = "";
	
	LOGGER.debug("sb1000mVO="+sb1000mVO.toString());
	
	//연구대상자로 사용된 경우 삭제 불가 
	EgovMap map = new EgovMap();
	map.put("corpCd", sb1000mVO.getCorpCd());
	map.put("rsjNo", sb1000mVO.getRsjNo());
	int chk1 = ech0301DAO.select0301ChkDelCnt(map);
	
	if(chk1 > 0) {
		message = "임상시험 참여정보가 있어 삭제할 수 없습니다.";
		return redirectList(reda, message);
	}
	
	//피험자관리 삭제
	if(!EgovStringUtil.isEmpty(sb1000mVO.getRsjNo())){
		
		// 삭제전 대상자의 정보를 설정한다. 번호,아이디,이름,생년월일 설정
		sb1000mVO = ech0301DAO.selectEch0301View(sb1000mVO);
		String trsjNo = sb1000mVO.getRsjNo();
		String tuserId = sb1000mVO.getUserId();
		String trsjName = sb1000mVO.getRsjName();
		String tbrDt = sb1000mVO.getBrDt();
		
		ech0301DAO.deleteEch0301(sb1000mVO);
		
		sb1010mVO.setCorpCd(sb1000mVO.getCorpCd());
		sb1010mVO.setRsjNo(sb1000mVO.getRsjNo());
		
		ech0301DAO.deleteEch0301ResearchCls(sb1010mVO);
	
		EgovMap map1 = new EgovMap();
		map1.put("boardSeq", sb1000mVO.getCorpCd()+sb1000mVO.getRsjNo());
		map1.put("boardType", "RSBJ");
		List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
		
		for(Ct7000mVO attachVO : attachList){
			cmmDAO.deleteAttachFile(attachVO.getAttachNo());
			fileUtil.deleteFile(attachVO.getRegFileName());
		}
		
		message = "피험자정보가 삭제되었습니다.";
		
		//개인정보처리 로그 등록 
		admLogInsert("연구대상자 > 연구대상자 삭제"+tuserId+","+tbrDt, trsjNo, trsjName, request);
	}
	return redirectList(reda, message);

	}


	// 피험자관리 리스트로 리다이렉트
	private String redirectList(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		
		return "redirect:/qxsepmny/ech0301/ech0301List.do";
	}

	// 피험자관리 상세보기로 리다이렉트
	private String redirectView(RedirectAttributes reda, String message, Sb1000mVO sb1000mVO, Sb1010mVO sb1010mVO) {
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("sb1000mVO", sb1000mVO);
		reda.addFlashAttribute("sb1010mVO", sb1010mVO);
		
		return "redirect:/qxsepmny/ech0301/ech0301View.do";
	}
	
	// 피험자관리 목록 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0301/ech0301Excel.do")
	public void ech0301Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0301/ech0301Excel.do - 피험자관리 목록 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0301DAO.selectEch0301Excel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName()+"("+sessionVO.getAdminId()+")");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "연구대상자 리스트", "ech0301", request, response);
		
		//개인정보처리 로그 등록 
		String datetype = "";
		if("1".equals(searchVO.getSearchCondition4())) {
			datetype = "가입일자";
		} else {
			datetype = "관리자확인일자";
		}
		String tmpLogCont = "연구대상자 > 연구대상자 엑셀다운로드 "+datetype+" 시작일자"+searchVO.getSearchCondition1();
		tmpLogCont = tmpLogCont + ", 종료일자"+searchVO.getSearchCondition2();
		admLogInsert(tmpLogCont, "엑셀다운로드", "검색조건", request);
		
	}
		

	// 연구대상자 - 관리자확인일자 일괄등록
	@RequestMapping("/qxsepmny/ech0301/ech0301AjaxSaveCfmDt.do")
	public View ech0301AjaxSaveCfmDt(String corpCd,String rsNo, String step1,String step2, String[] rsjSeq, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0301/ech0301AjaxSaveCfmDt.do - 연구대상자 관리자확인일자 일괄등록");
		String message = "";
		
		EgovMap map = new EgovMap();
		
		// 회사코드 설정 
		//sb1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("rsNo", rsNo);
		map.put("step1", step1);
		// 등록수정자 설정
		map.put("step2", EgovUserDetailsHelper.getAuthenticatedAdminId());
		map.put("rsjSeq", rsjSeq);
		
		ech0301DAO.updateEch0301AjaxSaveCfmDt(map);
		
		message = "저장되었습니다.";
		model.addAttribute("message", message);
		
		//개인정보처리 로그 등록
				
		String trsjSeq = Arrays.toString(rsjSeq);
		
		admLogInsert("연구대상자 > 연구대상자 관리자확인일자 등록,확인일자="+step1, "확인일자등록", trsjSeq, request);
		
		return jsonView;
		
	}
	
	// 연구대상자 비밀번호 재설정
	@RequestMapping("/qxsepmny/ech0301/ech0301AjaxProfClearPw.do")
	public View ech0301AjaxProfClearPw(Sb1000mVO sb1000mVO, HttpServletRequest request, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0301/ech0301AjaxProfClearPw.do - 연구대상자 비밀번호 재설정");
		LOGGER.debug("sb1000mVO = " + sb1000mVO);
		String message = "";
		
		if(sb1000mVO !=null){
			//아이디를 비밀번호로 설정
			sb1000mVO.setPwNo(EgovFileScrty.encryptPassword(sb1000mVO.getUserId(), sb1000mVO.getUserId()));
			
			ech0301DAO.updateEch0301AjaxProfClearPw(sb1000mVO);
			message = "비밀번호가 초기화되었습니다.";
		}
		
		model.addAttribute("message", message);
		
		return jsonView;
	}
	
	// 연구대상자 로그인 횟수 초기화
	@RequestMapping("/qxsepmny/ech0301/ech0301AjaxClearLgnFail.do")
	public View ech0301AjaxClearLgnFail(String adminId, HttpServletRequest request, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0301/ech0301AjaxClearLgnFail.do - 연구대상자 로그인 횟수 초기화");
		LOGGER.debug("adminId = " + adminId);
		String message = "";
		
		//세션 호출
		//AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("adminId", adminId);
		
		if(!EgovStringUtil.isEmpty(adminId)){ 
			ech0301DAO.updateEch0301AjaxClearLgnFail(map);
			message = "로그인 횟수가 초기화되었습니다.";
		}
		
		model.addAttribute("message", message);
		
		return jsonView;
	}
	
	// 연구대상자 아이디 일괄 설정
	@RequestMapping("/qxsepmny/ech0301/ech0301AjaxSaveFirst.do")
	public View ech0301AjaxSaveFirst(String corpCd,String rsNo, String step1,String step2, String[] rsjSeq, Sb1000mVO sb1000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0301/ech0301AjaxSaveFirst.do - 관리자 연구대상자 아이디 일괄 설정");
		String message = "";
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		EgovMap map = new EgovMap();
		
		//map.put("rsNo", rsNo);
		//map.put("step1", step1);
		//map.put("step2", step2);
		String[] rsjSeqT = rsjSeq;		
		
		String nowDate = EgovStringUtil.getDateMinus();
		String regDtY = nowDate.substring(0, 4); //현재년도를 기준으로 산출
		LOGGER.debug("regDtY="+regDtY);
		String rsNo1 = adminVO.getRsNo1();
		LOGGER.debug("rsNo1="+rsNo1);
		
		for(int i=0;i<rsjSeqT.length;i++) {
			//아이디를 획득한다. 아이디는 HNB+년도(2)+0000(일련번호), HNB210001
			
			//아이디를 등록한다.
			//String getUserid = "celldio5";
			
			//map.put("userId", getUserid);
			//비밀번호를 암호화한다
			//map.put("pwNo", EgovFileScrty.encryptPassword(getUserid, getUserid));
			// 회사코드(CTMS운영) 설정
			//map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			//map.put("rsjNo", rsjSeqT[i]);
			//LOGGER.debug("/rsjNo="+rsjSeqT[i]);
			//map.put("dataRegnt", EgovUserDetailsHelper.getAuthenticatedAdminEmpNo());
			
			//아이디 획득   아이디는 HBS+년도(4)+0000(일련번호), HBS20210001                                                      
			map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			map.put("regDtY", regDtY);  
			map.put("rsNo1", rsNo1);
			String getUserid = ech0301DAO.selectEch0301GetId(map);
			LOGGER.debug("getUserid="+getUserid);

			//비밀번호 암호화
			sb1000mVO.setPwNo(EgovFileScrty.encryptPassword(getUserid, getUserid));
						
			//아이디 설정
			sb1000mVO.setUserId(getUserid);
			sb1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			sb1000mVO.setRsjNo(rsjSeqT[i]);
			sb1000mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminEmpNo());
			ech0301DAO.updateEch0301AjaxSaveFirst(sb1000mVO);
		}
		
		message = "저장되었습니다.";
		model.addAttribute("message", message);
		
		return jsonView;
		
	}
	
	// 연구대상자상세보기 아이디 설정
	@RequestMapping("/qxsepmny/ech0301/ech0301AjaxSaveFirstOne.do")
	public View ech0301AjaxSaveFirstOne(String corpCd,String rsjNo, Sb1000mVO sb1000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0301/ech0301AjaxSaveFirstOne.do - 연구대상자상세보기 아이디 설정 ");
		String message = "";
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		LOGGER.debug("corpCd="+corpCd);
		LOGGER.debug("rsjNo="+rsjNo);
		
		String nowDate = EgovStringUtil.getDateMinus();
		String regDtY = nowDate.substring(0, 4); //현재년도를 기준으로 산출
		String rsNo1 = adminVO.getRsNo1();

		//아이디 획득   아이디는 HBS+년도(4)+0000(일련번호), HBS20210001
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("regDtY", regDtY);  
		map.put("rsNo1", rsNo1);
		String getUserid = ech0301DAO.selectEch0301GetId(map);
		LOGGER.debug("getUserid="+getUserid);
		
		//비밀번호 암호화
		sb1000mVO.setPwNo(EgovFileScrty.encryptPassword(getUserid, getUserid));
		//아이디 설정
		sb1000mVO.setUserId(getUserid);
		sb1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		sb1000mVO.setRsjNo(rsjNo);
		sb1000mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminEmpNo());
		ech0301DAO.updateEch0301AjaxSaveFirst(sb1000mVO);
		
		message = "저장되었습니다.";
		model.addAttribute("message", message);
		
		return jsonView;
		
	}
	
	// 일괄SMS발송 팝업
	@RequestMapping("/qxsepmny/ech0301/ech0301SmsAllPop.do")
	public String ech0301SmsAllPop(String corpCd, String rsNo, String resrNo,  String[] rsjSeq, Rm2000mVO rm2000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0301/ech0301SmsAllPop.do - 연구대상자별 일괄SMS발송");
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");

	 	// 회사코드 설정 
		rm2000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		EgovMap map = new EgovMap();
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("rsjSeq", rsjSeq);

		List<EgovMap> resultList = ech0301DAO.selectEch0301SendList(map);
		
		//SMS예시 문항 목록을 구성한다.
		List<EgovMap> smsList = cmmDAO.selectSmsSplList(map);

		//접수일자에 현재일자 설정
		rm2000mVO.setRecsDt(EgovStringUtil.getDateMinus());
		
		model.addAttribute("smsList", smsList);
		model.addAttribute("resultList", resultList);
		model.addAttribute("adminVO", adminVO);
		model.addAttribute("NotiPageGubun","NotiUpdate");
		model.addAttribute("rm2000mVO", rm2000mVO);
		
		return "/adm/cmm/admSmsAllPop";
		
	}
	
	// 연구대상자 - 스크리닝대상자 확정 등록
	@RequestMapping("/qxsepmny/ech0301/ech0301AjaxSaveFirstSt.do")
	public View ech0301AjaxSaveFirstSt(String corpCd,String rsNo, String step3,String step4, String[] rsjSeq, Rs1000mVO rs1000mVO, Rs2000mVO rs2000mVO, Sb1000mVO sb1000mVO, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/ech0301/ech0301AjaxSaveFirstSt.do - 연구대상자 - 스크리닝대상자 확정 등록");
		String message = "";
		
		LOGGER.debug("rsjSeq.toString()="+rsjSeq.toString());
		
		EgovMap map = new EgovMap();
		
		// 회사코드 설정		
		map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		map.put("rsNo", rsNo);
		map.put("rsCd", step3); //연구코드
		map.put("dataRegnt", EgovUserDetailsHelper.getAuthenticatedAdminId()); // 등록수정자 설정
		map.put("rsjSeq", rsjSeq.toString());
		
		
		//연구과제를 확인한다.
		rs1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		rs1000mVO.setRsCd(step3);
		rs1000mVO =  ech0301DAO.selectEch0301RsView(rs1000mVO);
		
		if(rs1000mVO !=null) {
			//선택한 연구대상자가 연구과제에 이미 등록되여 있는지 확인한다.
			String trsjNo = "";
			for(int i=0;i<rsjSeq.length;i++) {
				trsjNo = rsjSeq[i];
			}
			map.put("rsjNo", trsjNo);
			map.put("rsNo", rs1000mVO.getRsNo());
			int chkcnt = ech0301DAO.selectEch0301RsjCnt(map);
			if(chkcnt > 0) {
				message = "이미 연구과제에 피험자로 선정된 연구대상자입니다.";
				model.addAttribute("message", message);
			}else {
				//등록되지 않은 경우 피험자등록 - APP_YN 지원자 설정, FIRST_ST 스크리닝대상자선정, FIRST_ST_NO 스크리닝번호 부여 
				// 연구대상자를 피험자로 등록
				rs2000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				rs2000mVO.setRsNo(rs1000mVO.getRsNo());
				rs2000mVO.setAppYn("Y");
				rs2000mVO.setFirstSt("Y");
				rs2000mVO.setCfmYn("N");					
				rs2000mVO.setPoolYn("N");
				rs2000mVO.setRsiNo1(rs1000mVO.getRsNo5()+rs1000mVO.getRsNo6());
				rs2000mVO.setRsiNo2(rs1000mVO.getRsNo7());
				rs2000mVO.setRsjNo(trsjNo);
				rs2000mVO.setAppstaCls("10");
				rs2000mVO.setAppStdt(rs1000mVO.getRsStdt());
				rs2000mVO.setAppEndt(rs1000mVO.getRsEndt());
				rs2000mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
				//동일 RS_NO내에서 FIRST_ST_NO 순번으로 일련번호를 산출한다.
				String totCnt = ech0102DAO.selectEch0102StNoCnt(rs2000mVO);
				//스크리닝번호를 설정
				rs2000mVO.setFirstStNo(totCnt);
				LOGGER.debug("getFirstStNo()="+rs2000mVO.getFirstStNo());
				ech0301DAO.insertEch0301Sub(rs2000mVO);
				//연구대상자 정보 등록단계를 '2'로 변경한다
				sb1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				sb1000mVO.setRsjNo(rs2000mVO.getRsjNo());
				sb1000mVO.setRegLv("2"); //정보등록 2단계 - 회원 임상시험지원 가능 
				sb1000mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
				ech0301DAO.updateEch0301RegLv(sb1000mVO);
				
				//ech0301DAO.updateEch0301AjaxSaveCfmDt(map);
				
				message = "스크리닝대상자로 저장되었습니다.방문예약은 연구관리>피험자선정 메뉴를 이용하시면 됩니다";
				model.addAttribute("message", message);
				
				//개인정보처리 로그 등록					
				//String trsjSeq = Arrays.toString(rsjSeq);
				String trsjSeq = sb1000mVO.getRsjName();
				admLogInsert("연구대상자 > 연구대상자 스크리닝대상자 등록,연구코드="+step3, "스크리닝등록", trsjSeq, request);
			}
			
			
		}else{
			message = "등록되지 않은 연구코드입니다.";
			model.addAttribute("message", message);
		}
				
		return jsonView;
		
	}
	
	//핸드폰번호 중복확인
	@RequestMapping("/qxsepmny/ech0301/ech0301AjaxHpNoCheck.do")
	public View ech0301AjaxHpNoCheck(String mobile1, String mobile2, String mobile3, String rsjNo, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0301/ech0301AjaxHpNoCheck.do - 핸드폰번호 중복확인");
		LOGGER.debug("mobile1 = " + mobile1);
		LOGGER.debug("mobile2 = " + mobile2);
		LOGGER.debug("mobile3 = " + mobile3);
		LOGGER.debug("rsjNo = " + rsjNo);
		String message = "";
		boolean status = false;
		
		//세션 호출
	 	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		String mobile = mobile1 + mobile2 + mobile3;
		if(!EgovStringUtil.isEmpty(mobile2)){
			
			EgovMap map = new EgovMap();
			//회사코드(CTMS운영) 설정
			map.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			map.put("mobile", mobile);
			
			int cnt = ech0301DAO.selectEch0301AjaxHpNoCheck(map);
			
			if(cnt > 0){
				message = "이미 사용중인 핸드폰번호입니다.";
				status = false;
			}else{
				message = "사용 가능한 핸드폰번호입니다.";
				status = true;
			}
		}
		
		model.addAttribute("message", message);
		model.addAttribute("status", status);
		
		return jsonView;
	}
	
}
