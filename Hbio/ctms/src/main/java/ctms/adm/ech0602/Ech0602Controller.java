package ctms.adm.ech0602;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import component.util.ComStringUtil;
import component.web.PaginationController;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import ctms.adm.cmm.AdmCmmController;
import ctms.cmm.CmmDAO;
import ctms.valueObject.AdminVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Rm1000mVO;
import ctms.valueObject.Rm1020mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;

@Controller
public class Ech0602Controller extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0602Controller.class);
	@Autowired private Ech0602DAO ech0602DAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private View jsonView;
	@Resource private MailSendUtil mailUtil;
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
	
	
	// ********************************(이메일발송관리) 20201203 관리자 이메일발송관리 목록화면********************************
	@RequestMapping("/qxsepmny/ech0602/ech0602List.do")	
	public String ech0602List(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.debug("/qxsepmny/ech0602/ech0602List.do - 이메일발송관리 이메일발송관리 목록화면");
		//request.getSession().setAttribute("admMenuNo", "703");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");

		//엑셀다운로드 권한 설정 Y 허용  N 허용안함 
		model.addAttribute("exauth", adminVO.getExauth());		

		//회사코드 설정
		searchVO.setCorpCd(adminVO.getCorpCd());
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = ech0602DAO.selectEch0602List(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
	
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
			
		
		return "/adm/ech0602/ech0602List";
	}
	
	// ********************************(이메일발송관리) 20201128 관리자 이메일발송관리 상세보기화면********************************
	@RequestMapping("/qxsepmny/ech0602/ech0602View.do")
	public String ech0602View(@ModelAttribute CmmnSearchVO searchVO , Rm1000mVO rm1000mVO, Rm1020mVO rm1020mVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0602/ech0602View.do - 이메일발송관리 이메일발송관리 상세보기화면");
		//request.getSession().setAttribute("admMenuNo", "703");
	
		rm1000mVO =  ech0602DAO.selectEch0602View(rm1000mVO);
		if (!EgovStringUtil.isEmpty(rm1000mVO.getFileNames())) {
			String[] spmapfileNames = rm1000mVO.getFileNames().split(",");
			int spLength = spmapfileNames.length;
			if(spLength == 1) {
				rm1000mVO.setFileNames1(spmapfileNames[0].toString());
				rm1000mVO.setFileNames2("0");
			} else {
				if(spLength == 2) {
					rm1000mVO.setFileNames1(spmapfileNames[0].toString());
					rm1000mVO.setFileNames2(spmapfileNames[1].toString());
				}
			}
		} else {
			rm1000mVO.setFileNames1("");
			rm1000mVO.setFileNames2("");
		}
		
		EgovMap map = new EgovMap();
		map.put("corpCd", rm1000mVO.getCorpCd());
		map.put("orecmNo", rm1000mVO.getRecmNo());
		
		List<EgovMap> resendList = ech0602DAO.selectEch06020ResendList(map);
		
		model.addAttribute("rm1000mVO", rm1000mVO);
		model.addAttribute("resendList", resendList);
		model.addAttribute("pageIndex", searchVO.getPageIndex());
		
		EgovMap map1 = new EgovMap();
		map1.put("boardSeq", rm1000mVO.getCorpCd()+rm1000mVO.getRecmNo());
		map1.put("boardType", "EATF");
		List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map1);
		model.addAttribute("attachList", attachList);
		
		EgovMap attachMap = new EgovMap();
		
		for(Ct7000mVO attach : attachList){
			attachMap.put(attach.getFileKey(), attach);
		}
		
		model.addAttribute("attachMap", attachMap);
		
		
		// 첨부파일 확인
		//EgovMap map = new EgovMap();
		//map.put("boardNo", rm1000mVO.getRecmNo());
		//map.put("boardType", "EATF");
				
		//첨부파일 데이터 조회
		//List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
		//model.addAttribute("attachList", attachList);
				
		return "/adm/ech0602/ech0602View";
	}	

	// ********************************(이메일발송관리) 20201128 관리자 이메일발송관리 등록&수정 화면********************************
	@RequestMapping("/qxsepmny/ech0602/ech0602Modify.do")
	public String ech0602Modify(@ModelAttribute("rm1000mVO") Rm1000mVO rm1000mVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/ech0602/ech0602Modify.do - 관리자 이메일발송관리 등록&수정 화면");
		
		//request.getSession().setAttribute("admMenuNo", "505");
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionLcms");

		// 회사코드 설정 
		rm1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		//전송상태(공통코드) 목록 CM1310			
		List<EgovMap> cm1310 = cmmDAO.selectCmmCdList(rm1000mVO.getCorpCd(), "CM1310");
		model.addAttribute("cm1310", cm1310);

		//전송결과(공통코드) 목록 CM1320			
		List<EgovMap> cm1320 = cmmDAO.selectCmmCdList(rm1000mVO.getCorpCd(), "CM1320");
		model.addAttribute("cm1320", cm1320);

		//SMS예시 문항 목록을 구성한다.
		EgovMap map1 = new EgovMap();
		map1.put("corpCd", rm1000mVO.getCorpCd());
		List<EgovMap> smsList = cmmDAO.selectSmsSplList(map1);
		model.addAttribute("smsList", smsList);
		
		//이메일예시 문항 목록을 구성한다.
		List<EgovMap> emailList = cmmDAO.selectMailSplList(map1);
		model.addAttribute("emailList", emailList);
		
		//등록화면으로
		if (EgovStringUtil.isEmpty(rm1000mVO.getRecmNo())) {
			//지사이름
			
			rm1000mVO.setRecmDt(EgovStringUtil.getDateMinus());
			model.addAttribute("rm1000mVO", rm1000mVO);
			model.addAttribute("adminVO", adminVO);
			model.addAttribute("NotiPageGubun","NotiRegist");
		}
		//수정화면으로 
		if(!EgovStringUtil.isEmpty(rm1000mVO.getRecmNo())){
					
			rm1000mVO = ech0602DAO.selectEch0602View(rm1000mVO);
			
			if (!EgovStringUtil.isEmpty(rm1000mVO.getFileNames())) {
				String[] spmapfileNames = rm1000mVO.getFileNames().split(",");
				int spLength = spmapfileNames.length;
				if(spLength == 1) {
					rm1000mVO.setFileNames1(spmapfileNames[0].toString());
					rm1000mVO.setFileNames2("0");
				} else {
					if(spLength == 2) {
						rm1000mVO.setFileNames1(spmapfileNames[0].toString());
						rm1000mVO.setFileNames2(spmapfileNames[1].toString());
					}
				}
			} else {
				rm1000mVO.setFileNames1("");
				rm1000mVO.setFileNames2("");
			}
				
			model.addAttribute("NotiPageGubun","NotiUpdate");
			model.addAttribute("rm1000mVO", rm1000mVO);
			
			EgovMap map = new EgovMap();
			map.put("boardSeq", rm1000mVO.getCorpCd()+rm1000mVO.getRecmNo());
			map.put("boardType", "EATF");
			List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
			model.addAttribute("attachList", attachList);
			
			EgovMap attachMap = new EgovMap();
			
			for(Ct7000mVO attach : attachList){
				attachMap.put(attach.getFileKey(), attach);
			}
			
			model.addAttribute("attachMap", attachMap);
			
			
			// 파일첨부 설정
			//EgovMap map = new EgovMap();
			//map.put("boardNo", rm1000mVO.getRecmNo());
			//map.put("boardType", "EATF");			
			
			//첨부파일 데이터 조회
			//List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
			//model.addAttribute("attachList", attachList);
			// 해당 게시판 첨부파일 개수
			//int attachListCnt = cmmDAO.selectAttachListCnt(rm1000mVO.getRecmNo());
			//model.addAttribute("attachListCnt",attachListCnt);	
		}
		
		return "/adm/ech0602/ech0602Modify";
	}

		// ********************************(이메일발송관리) 20201128 관리자 이메일발송관리 저장 ********************************
		@RequestMapping("/qxsepmny/ech0602/ech0602Update.do")
		public String ech0602Save(@ModelAttribute("rm1000mVO") Rm1000mVO rm1000mVO, String deleteFileIds, String[] delFile, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0602/ech0602Update.do - 관리자 이메일발송관리 저장");
		String message = "";
		
		LOGGER.debug("rm1000mVO.toString()"+rm1000mVO.toString());
		
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		
		// 회사코드(CTMS운영) 설정
		rm1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		rm1000mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());
		rm1000mVO.setSendEmail("send@hnbsrc.com");
		
		//지사코드가 없다
		LOGGER.debug("rm1000mVO.getBranchCd()"+rm1000mVO.getBranchCd());
		
		//등록 SENDM_CLS 1 즉시발송인 경우 메일 발송  
		if(EgovStringUtil.isEmpty(rm1000mVO.getRecmNo())){
		    
			//작성자 안에 세션 name 입력
//				noticeVO.setNoti_writer(adminVO.getName());

			// 회사번호 설정
			//rm1000mVO.setBuso("임상시험부");
			//rm1000mVO.setEmail("hjk114@naver.com");
			//rm1000mVO.setRsubjctNo(ech0602DAO.insertEch0602(rm1000mVO));
			
			
			//현재일시 산출
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = new Date();        
			String dateToStr = dateFormat.format(date);
			LOGGER.debug("dateToStr"+dateToStr);
			
			//RECM_DT에 접수일자가 들어감 
			//예약발송 설정  SENDM_CLS 2 
			if(rm1000mVO.getSendmCls().equals("2")) {
				rm1000mVO.setTsenCls("900"); // 전송결과 전송대기
				rm1000mVO.setTstaCls("10"); // 전송상태 접수
				rm1000mVO.setAccpDt(dateToStr); // 접수일시 현재일시 설정
				rm1000mVO.setSendDt(null); // 발송일시 미설정
				rm1000mVO.setRetnDt(null); // 전송결과수신일시 미설정
			} else { // 즉시발송인 경우 SENDM_CLS 1 
				rm1000mVO.setTsenCls("100"); // 전송결과 전송완료
				rm1000mVO.setTstaCls("30"); // 전송상태 처리완료
				rm1000mVO.setAccpDt(dateToStr); // 접수일시 설정
				rm1000mVO.setSendDt(dateToStr); // 발송일시 설정
				rm1000mVO.setRetnDt(dateToStr); // 전송결과수신일시 설정
			}
			
			//발송내역 등록
			ech0602DAO.insertEch0602(rm1000mVO);			
			
			
			EgovMap map = new EgovMap();
			map.put("boardSeq", rm1000mVO.getCorpCd()+rm1000mVO.getRecmNo());
			map.put("boardType", "EATF");
			List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
			model.addAttribute("attachList", attachList);
			
			EgovMap attachMap = new EgovMap();
			
			for(Ct7000mVO attach : attachList){
				attachMap.put(attach.getFileKey(), attach);
			}
			
			model.addAttribute("attachMap", attachMap);
			
			// 첨부파일 등록
			//List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "EATF");
			//if(fileInfoList != null){
				//for(FileInfoVO fileInfoVO : fileInfoList){
					//Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
					//attachVO.setBoardType("RSBJ");
					//attachVO.setBoardNo(rm1000mVO.getRecmNo());
					//cmmDAO.insertAttachFile(attachVO);
				//}
			//}
			
			// 첨부파일 서버 저장
		    List<FileInfoVO> fileList = fileUtil.totUploadFiles(request, "EATF");
		    if(fileList != null){
				for(FileInfoVO fileInfoVO : fileList){
					LOGGER.debug("----- fileKey = " + fileInfoVO.getFileKey() + " -----");
					Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
					attachVO.setBoardNo(String.valueOf(rm1000mVO.getCorpCd()+rm1000mVO.getRecmNo())); //회사코드+발송번호
					attachVO.setBoardType("EATF");//폴더명
					//attachVO.setFileKey(fileInfoVO.getFileKey()); //파일명 네임값도 컬럼에넣기(삭제하거나 리스트출력시 키값사용)
					
					cmmDAO.insertAttachFile(attachVO);
				}
		    }
			
			message = "예약전송 등록이 완료되었습니다.";
			
			//메일서버 정보 획득 즉시발송인 경우 메일 발송  
			if(rm1000mVO.getSendmCls().equals("1")) {
				EgovMap map1 = new EgovMap();
				map1.put("corpCd", EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
				String mailHost = cmmDAO.selectMailHost(map1);
				String[] spmailhost = mailHost.split(",");
				String thost	 = spmailhost[0].toString(); //host
				String tpassword = EgovFileScrty.decode(spmailhost[1].toString()); //password
				String tusername = spmailhost[2].toString(); //username
	
				//메일전송정보 설정
			    String usrEmail = rm1000mVO.getReceEmail(); //수신이메일
			    String usrName = "고객님"; //수신자명
			    String title = rm1000mVO.getTitle();
			    String cont = rm1000mVO.getCont();
			    
			    String afterPwd = ComStringUtil.createPassword(6);
			    
			    // 첨부파일 저장 
			    // 해당 코드 위에서 첨부파일 서버 저장 후 파일 path를 넣어줘야함.
			    // 파일path가 피어있는 경우 첨부파일 없이 메일전송됨.
	
			    // 첨부파일 서버 저장
				/*
				 * List<FileInfoVO> fileList = fileUtil.totUploadFiles(request, "EATF");
				 * if(fileList != null){ for(FileInfoVO fileInfoVO : fileList){
				 * LOGGER.debug("----- fileKey = " + fileInfoVO.getFileKey() + " -----");
				 * Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
				 * attachVO.setBoardNo(String.valueOf(rm1000mVO.getCorpCd()+rm1000mVO.getRecmNo(
				 * ))); //회사코드+발송번호 attachVO.setBoardType("EATF");//폴더명
				 * //attachVO.setFileKey(fileInfoVO.getFileKey()); //파일명 네임값도 컬럼에넣기(삭제하거나 리스트출력시
				 * 키값사용)
				 * 
				 * cmmDAO.insertAttachFile(attachVO); } }
				 */		    
			    
			    //첨부파일을 획득한다. 폴더 EATF
        		final String UPLOAD_HOME = propertyService.getString("Globals.fileStorePath.attachedFile");
        		List<FileInfoVO> fileInfoList = new ArrayList<>();
        		
        		EgovMap mapAttach = new EgovMap();
        		//mapAttach.put("boardSeq", "HNBSRC"+map.get("recmNo"));
        		mapAttach.put("boardSeq", "HNBSRC"+rm1000mVO.getRecmNo());
        		mapAttach.put("boardType", "EATF");
    			List<Ct7000mVO> attachList2 = cmmDAO.selectAttachList(mapAttach);
          		LOGGER.debug("attachList2="+attachList2.toString());
    			
    			EgovMap attachMap2 = new EgovMap();
    			for(Ct7000mVO attach : attachList2){
    				String fileName = attach.getOrgFileName(); //파일명
    				//String fileExt = fileName.substring(fileName.lastIndexOf(".")+1); // 확장자(ex> jpg | fileName.substring(fileName.lastIndexOf(".")) = .jpg);
    				//String fileNm = EgovStringUtil.getTimeStamp() + "." + fileExt;
    				String filePath = attach.getRegFileName();
    				//String filePath = File.separator + "EATF" + File.separator + fileNm;
    				
    				FileInfoVO fileInfoVO = new FileInfoVO();
    				fileInfoVO.setFileName(fileName);
    				fileInfoVO.setFilePath(filePath);
              		LOGGER.debug("fileInfoVO="+fileInfoVO.toString());
    				
    				fileInfoList.add(fileInfoVO);
    			}
        		
    			//선택한 보고서가 있으면 첨부파일에 추가한다  1 초안보고서 2 최종보고서 
    			mapAttach.put("boardSeq", rm1000mVO.getRsNo()); //연구과제번호
        		mapAttach.put("boardType", "REPORT");
    			List<Ct7000mVO> attachList3 = cmmDAO.selectAttachList(mapAttach);
    			
    			EgovMap attachMap3 = new EgovMap();
    			for(Ct7000mVO attach : attachList3){
    				String fileName = attach.getOrgFileName(); //파일명
    				//String fileExt = fileName.substring(fileName.lastIndexOf(".")+1); // 확장자(ex> jpg | fileName.substring(fileName.lastIndexOf(".")) = .jpg);
    				//String fileNm = EgovStringUtil.getTimeStamp() + "." + fileExt;
    				String filePath = attach.getRegFileName();
    				//String filePath = File.separator + "EATF" + File.separator + fileNm;
    				
    				//보고서를 첨부했는지 확인한다 1 초안보고서 2 최종보고서 2개 모두 선택 가능함 
    				//String mapfileNames = (String) map.get("fileNames");
    				String mapfileNames = rm1000mVO.getFileNames();
    				String sp1 = "0";
    				String sp2 = "0";
    				String[] spmapfileNames = mapfileNames.split(",");
    				int spLength = spmapfileNames.length;
    				if(spLength == 1) {
    					sp1 = spmapfileNames[0].toString();
    					sp2 = "0";
    				} else {
    					if(spLength == 2) {
        					sp1 = spmapfileNames[0].toString();
        					sp2 = spmapfileNames[1].toString();
        				}
    				}
    				
    				if(sp1.equals("1")) {
    					if(attach.getFileKey().equals("draftRpt")) { //초안보고서
        					FileInfoVO fileInfoVO = new FileInfoVO();
            				fileInfoVO.setFileName(fileName);
            				fileInfoVO.setFilePath(filePath);
                      		LOGGER.debug("fileInfoVO draftRpt="+fileInfoVO.toString());
            				
            				fileInfoList.add(fileInfoVO);	
        				}	
    				}else {
    					if(sp1.equals("2")) {
    						if(attach.getFileKey().equals("finalRpt")) { //최종보고서
    	    					FileInfoVO fileInfoVO = new FileInfoVO();
    	        				fileInfoVO.setFileName(fileName);
    	        				fileInfoVO.setFilePath(filePath);
    	                  		LOGGER.debug("fileInfoVO finalRpt="+fileInfoVO.toString());
    	        				
    	        				fileInfoList.add(fileInfoVO);
    	    				}
    					}
    				}
    				
    				if(sp2.equals("1")) {
    					if(attach.getFileKey().equals("draftRpt")) { //초안보고서
        					FileInfoVO fileInfoVO = new FileInfoVO();
            				fileInfoVO.setFileName(fileName);
            				fileInfoVO.setFilePath(filePath);
                      		LOGGER.debug("fileInfoVO draftRpt="+fileInfoVO.toString());
            				
            				fileInfoList.add(fileInfoVO);	
        				}	
    				}else {
    					if(sp2.equals("2")) {
    						if(attach.getFileKey().equals("finalRpt")) { //최종보고서
    	    					FileInfoVO fileInfoVO = new FileInfoVO();
    	        				fileInfoVO.setFileName(fileName);
    	        				fileInfoVO.setFilePath(filePath);
    	                  		LOGGER.debug("fileInfoVO finalRpt="+fileInfoVO.toString());
    	        				
    	        				fileInfoList.add(fileInfoVO);
    	    				}
    					}
    				}
    			}
			    
			    //mailUtil.sendEmail(usrEmail, usrName, afterPwd, title, cont, thost, tusername, tpassword, fileList);
			    mailUtil.sendEmail(usrEmail, usrName, afterPwd, title, cont, thost, tusername, tpassword, fileInfoList);
			    message = "메일이 발송되었습니다.";
			}
		    
			
		}else{
			ech0602DAO.updateEch0602(rm1000mVO);
			if(delFile != null){
				for(String seq : delFile){
					System.out.println(seq);
					Ct7000mVO delAttach = cmmDAO.selectAttachOne(seq);
					cmmDAO.deleteAttachFile(delAttach.getAttachNo());
					fileUtil.deleteFile(delAttach.getRegFileName());
				}
			}
		
			List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "EATF");
			if(fileInfoList != null){
				for(FileInfoVO fileInfoVO : fileInfoList){
					LOGGER.debug("----- fileKey = " + fileInfoVO.getFileKey() + " -----");
					Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
					attachVO.setBoardNo(String.valueOf(rm1000mVO.getCorpCd()+rm1000mVO.getRecmNo())); //회사코드+발송번호
					attachVO.setBoardType("EATF");//폴더명
					//attachVO.setFileKey(fileInfoVO.getFileKey()); //파일명 네임값도 컬럼에넣기(삭제하거나 리스트출력시 키값사용)
					
					cmmDAO.insertAttachFile(attachVO);
				}
			}
			
			message = "수정이 완료되었습니다.";
		}

		return redirectList(reda, message);

	}
	// ********************************(이메일발송관리) 20201128 관리자 이메일발송관리 삭제 ********************************
	@RequestMapping("/qxsepmny/ech0602/ech0602Delete.do")
	public String ech0602Delete(@ModelAttribute Rm1000mVO rm1000mVO, String[] delSeqList, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
	LOGGER.debug("/qxsepmny/ech0602/ech0602Delete.do - 관리자 이메일발송관리 삭제");
	String message = "";
	
	//이메일발송관리 삭제
	//메일이 발송된 경우 삭제할 수 없다. 
	if(!EgovStringUtil.isEmpty(rm1000mVO.getRecmNo())){
	
		ech0602DAO.deleteEch0602(rm1000mVO);
	
		EgovMap map = new EgovMap();
		map.put("boardSeq", rm1000mVO.getCorpCd()+rm1000mVO.getRecmNo());
		map.put("boardType", "RPTFORM");
		List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
		
		for(Ct7000mVO attachVO : attachList){
			cmmDAO.deleteAttachFile(attachVO.getAttachNo());
			fileUtil.deleteFile(attachVO.getRegFileName());
		}
		
		//이메일발송 첨부파일 삭제(추가첨부파일)
		//if(delSeqList != null){
			//for(String delSeq : delSeqList){
				 //attachVO = cmmDAO.selectAttachOne(delSeq);
				//fileUtil.deleteFile(attachVO.getRegFileName());
				//cmmDAO.deleteAttachFile(attachVO.getAttachNo());
			//}
		//}
		
		message = "이메일발송정보가 삭제되었습니다.";
	}
	return redirectList(reda, message);

	}


	// 이메일발송관리 리스트로 리다이렉트
	private String redirectList(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/ech0602/ech0602List.do";
	}

	// 이메일발송관리 목록 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/ech0602/ech0602Excel.do")
	public void ech0602Excel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0602/ech0602Excel.do - 이메일발송관리 목록 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = ech0602DAO.selectEch0602Excel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		//dataMap.put("printUser", sessionVO.getName());
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "이메일발송 리스트", "ech0602", request, response);
	}
		
		
}
