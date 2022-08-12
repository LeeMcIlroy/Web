package ctms.adm.ech0701;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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

import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.util.ComStringUtil;
import component.web.PaginationController;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import ctms.adm.cmm.AdmCmmController;
import ctms.adm.ech0701.Ech0701Controller;
import ctms.adm.ech0701.Ech0701DAO;
import ctms.cmm.CmmDAO;
import ctms.valueObject.AdminVO;
import ctms.valueObject.Ct7000mVO;
import ctms.valueObject.Ct1000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO;

@Controller
public class Ech0701Controller extends AdmCmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(Ech0701Controller.class);
	@Autowired private Ech0701DAO ech0701DAO;
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
	
	// ********************************(기준정보관리) 202011228 CTMS운영사관리 상세보기화면********************************
	@RequestMapping("/qxsepmny/ech0701/ech0701View.do")
	public String ech0701View(@ModelAttribute CmmnSearchVO searchVO , Ct1000mVO ct1000mVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/ech0701/ech0701View.do - 기준정보관리 CTMS운영사관리 상세보기화면");
		//request.getSession().setAttribute("admMenuNo", "703");
	
		//세션 호출
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
		//어드민타입 1 어드민 2 일반사용자 
		model.addAttribute("admintype", adminVO.getAdminType());	
		// 회사코드(CTMS운영) 설정  
		ct1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
		
		ct1000mVO =  ech0701DAO.selectEch0701View(ct1000mVO);
		
		// 사업자번호를 3-2-5 형식으로 나눈다.
		if (!EgovStringUtil.isEmpty(ct1000mVO.getBregRsno())) {
			String bregRsno = ct1000mVO.getBregRsno();
			ct1000mVO.setRegno1(bregRsno.substring(0, 3)); // 사업자번호1 3자리
			ct1000mVO.setRegno2(bregRsno.substring(3, 5)); // 사업자번호2 2자리
			ct1000mVO.setRegno3(bregRsno.substring(bregRsno.length()-5, bregRsno.length())); // 사업자번호3 5자리
		}
		
		model.addAttribute("ct1000mVO", ct1000mVO);
		model.addAttribute("pageIndex", searchVO.getPageIndex());
		
		//첨부파일 확인
		EgovMap map = new EgovMap();
		//primary Key 입력 - 회사코드 CORP_CD
		map.put("boardSeq", ct1000mVO.getCorpCd());
		map.put("boardType", "SYSP");
		List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
		model.addAttribute("attachList", attachList);
		
		EgovMap attachMap = new EgovMap();
		
		for(Ct7000mVO attach : attachList){
			attachMap.put(attach.getFileKey(), attach);
		}
		
		model.addAttribute("attachMap", attachMap);

		//첨부파일 데이터 조회 설정 - 설정해서 사용해야 됨
		//EgovMap map = new EgovMap();
		//map.put("boardNo", ct1000mVO.getCorpCd());  // String to int error, BoardNo 을 String type으로 변경해야 함 
		//map.put("boardType", "SYSP");
		//map.put("file_key", "????"); // 뭘 설정해야 하나?
		
		//첨부파일 데이터 조회 설정
		//List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
		//model.addAttribute("attachList", attachList);
						
		return "/adm/ech0701/ech0701View";
	}	

	// ********************************(기준정보관리) 20201125 관리자 고객사관리 등록&수정 화면********************************
		@RequestMapping("/qxsepmny/ech0701/ech0701Modify.do")
		public String ech0701Modify(@ModelAttribute("ct1000mVO") Ct1000mVO ct1000mVO, HttpServletRequest request, ModelMap model ) throws Exception {
			LOGGER.debug("/qxsepmny/ech0701/ech0701Modify.do - 관리자 CTMS운영사관리 등록&수정 화면");
			
			//request.getSession().setAttribute("admMenuNo", "505");
			
			//세션 호출
			AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
			//어드민타입 1 어드민 2 일반사용자 
			model.addAttribute("admintype", adminVO.getAdminType());
			
			// 회사코드(CTMS운영) 설정  
			ct1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			
			//등록화면으로
			if (EgovStringUtil.isEmpty(ct1000mVO.getCorpCd())) {
				model.addAttribute("adminVO", adminVO);
				model.addAttribute("NotiPageGubun","NotiRegist");
			}
			//수정화면으로 
			if(!EgovStringUtil.isEmpty(ct1000mVO.getCorpCd())){
						
				ct1000mVO = ech0701DAO.selectEch0701View(ct1000mVO);
				
				// 이메일 설정 이메일 변화 id @ adr -> email
				if (!EgovStringUtil.isEmpty(ct1000mVO.getEmail())) {
					String email = ct1000mVO.getEmail();
					
					String[] spEmail = email.split("@");

					ct1000mVO.setEmailId(spEmail[0]);
					ct1000mVO.setEmailAdr(spEmail[1]);
				}
				
				// 사업자번호를 3-2-5 형식으로 나눈다.
				if (!EgovStringUtil.isEmpty(ct1000mVO.getBregRsno())) {
					String bregRsno = ct1000mVO.getBregRsno();	
				
					ct1000mVO.setRegno1(bregRsno.substring(0, 3)); // 사업자번호1 3자리
					ct1000mVO.setRegno2(bregRsno.substring(3, 5)); // 사업자번호2 2자리
					ct1000mVO.setRegno3(bregRsno.substring(bregRsno.length()-5, bregRsno.length())); // 사업자번호3 5자리
				}
								
				model.addAttribute("NotiPageGubun","NotiUpdate");
				model.addAttribute("ct1000mVO", ct1000mVO);
				
				//첨부파일 확인 
				EgovMap map = new EgovMap();
				map.put("boardSeq", ct1000mVO.getCorpCd());
				map.put("boardType", "SYSP");
				List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
				model.addAttribute("attachList", attachList);
				
				EgovMap attachMap = new EgovMap();
				
				for(Ct7000mVO attach : attachList){
					attachMap.put(attach.getFileKey(), attach);
				}
				
				model.addAttribute("attachMap", attachMap);
				
				//첨부파일 데이터 조회 설정 - 설정해서 사용해야 됨
				//EgovMap map = new EgovMap();
				//map.put("boardNo", ct1000mVO.getCorpCd());
				//map.put("boardType", "SYSP");
								
				//첨부파일 데이터 조회
				//List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
				//model.addAttribute("attachList", attachList);
				// 해당 게시판 첨부파일 개수
				//int attachListCnt = cmmDAO.selectAttachListCnt(ct1000mVO.getCorpCd());
				//model.addAttribute("attachListCnt",attachListCnt);
				
			}
			
			return "/adm/ech0701/ech0701Modify";
		}

		// ********************************(기준정보관리) 20201128 관리자 CTMS운영사관리  저장 ********************************
		@RequestMapping("/qxsepmny/ech0701/ech0701Update.do")
			public String ech0701Save(@ModelAttribute("ct1000mVO") Ct1000mVO ct1000mVO, String deleteFileIds, String[] delFile, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
			LOGGER.debug("/qxsepmny/ech0701/ech0701Save.do - 관리자 CTMS운영사관리 저장");
			String message = "";
			
			//세션 호출
			AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionCtms");
			
			// 회사코드(CTMS운영) 설정
			ct1000mVO.setCorpCd(EgovUserDetailsHelper.getAuthenticatedAdminCorpCd());
			// 회사코드(CTMS운영) 설정
			ct1000mVO.setDataRegnt(EgovUserDetailsHelper.getAuthenticatedAdminId());  			
			
			// 이메일 변화 id @ adr
			if (!EgovStringUtil.isEmpty(ct1000mVO.getEmailId())) {
				String email = ct1000mVO.getEmailId() + "@" + ct1000mVO.getEmailAdr();
				ct1000mVO.setEmail(email);					
			}			
			
			// 사업자등록번호 3-2-5 -> 10자리로			
			if (!EgovStringUtil.isEmpty(ct1000mVO.getRegno1())) {
				ct1000mVO.setBregRsno(ct1000mVO.getRegno1()+ct1000mVO.getRegno2()+ct1000mVO.getRegno3());
			}
			
			if(EgovStringUtil.isEmpty(ct1000mVO.getCorpCd())){
			    
				//작성자 안에 세션 name 입력
//				noticeVO.setNoti_writer(adminVO.getName());
				
//				ct1000mVO.setCorpCd(ech0701DAO.selectEch0701Max(ct1000mVO));
//				ct1000mVO.setMng_name("임상시험담당");
//				ct1000mVO.setBuso("임상시험부");
//				ct1000mVO.setEmail("hjk114@naver.com");
//				ct1000mVO.setCorpCd(ech0701DAO.insertEch0701(ct1000mVO));
				
				
				ech0701DAO.insertEch0701(ct1000mVO);
				
				//첨부파일 등록
				EgovMap map = new EgovMap();
				map.put("boardSeq", ct1000mVO.getCorpNo());
				map.put("boardType", "SYSP");
				List<Ct7000mVO> attachList = cmmDAO.selectAttachList(map);
				model.addAttribute("attachList", attachList);
				
				EgovMap attachMap = new EgovMap();
				
				for(Ct7000mVO attach : attachList){
					attachMap.put(attach.getFileKey(), attach);
				}
				
				model.addAttribute("attachMap", attachMap);
				
				// 첨부파일 등록
				//List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "SYSP");
				//if(fileInfoList != null){
					//for(FileInfoVO fileInfoVO : fileInfoList){
						//Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
						//attachVO.setBoardType("SYSP");
						//attachVO.setBoardNo(ct1000mVO.getCorpCd());
						//cmmDAO.insertAttachFile(attachVO);
					//}
				//}
				
				message = "등록이 완료되었습니다.";
			}else{
				ech0701DAO.updateEch0701(ct1000mVO);
				message = "수정이 완료되었습니다.";
				
				if(delFile != null){
					for(String seq : delFile){
						System.out.println(seq);
						Ct7000mVO delAttach = cmmDAO.selectAttachOne(seq);
						cmmDAO.deleteAttachFile(delAttach.getAttachNo());
						fileUtil.deleteFile(delAttach.getRegFileName());
					}
				
				}
				
				
				//파일 업로드
				//List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "SYSP");
				//if(fileInfoList != null){
					//for(FileInfoVO fileInfoVO : fileInfoList){
						//Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
						//attachVO.setBoardType("SYSP");
						//attachVO.setBoardNo(ct1000mVO.getCorpCd());
						//cmmDAO.insertAttachFile(attachVO);
					//}
				//}					
				
			}

				List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "SYSP");
				if(fileInfoList != null){
					for(FileInfoVO fileInfoVO : fileInfoList){
						LOGGER.debug("----- fileKey = " + fileInfoVO.getFileKey() + " -----");
						Ct7000mVO attachVO = new Ct7000mVO(fileInfoVO);
						attachVO.setBoardNo(String.valueOf(ct1000mVO.getCorpCd())); //회사코드 
						attachVO.setBoardType("SYSP");//폴더명
						//attachVO.setFileKey(fileInfoVO.getFileKey()); //파일명 네임값도 컬럼에넣기(삭제하거나 리스트출력시 키값사용)
						
						cmmDAO.insertAttachFile(attachVO);
					}
				}	
				
			return redirectList(reda, message);

		}
		// ********************************(기준정보관리) 20201126 관리자 CTMS운영사관리 삭제 ********************************
		@RequestMapping("/qxsepmny/ech0701/ech0701Delete.do")
			public String ech0701Delete(@ModelAttribute Ct1000mVO ct1000mVO, Ct7000mVO attachVO, String[] delSeqList, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
			LOGGER.debug("/qxsepmny/ech0701/ech0701Delete.do - 관리자 CTMS운영사관리 삭제");
			String message = "";
			
			//회사관리 삭제
			if(!EgovStringUtil.isEmpty(ct1000mVO.getCorpCd())){
			
				ech0701DAO.deleteEch0701(ct1000mVO);
			
										
				//회사관리 첨부파일 삭제
				if(delSeqList != null){
					for(String delSeq : delSeqList){
						 attachVO = cmmDAO.selectAttachOne(delSeq);
						fileUtil.deleteFile(attachVO.getRegFileName());
						cmmDAO.deleteAttachFile(attachVO.getAttachNo());
					}
				}
										
				message = "CTMS운영사정보가 삭제되었습니다.";
			}
			return redirectList(reda, message);

		}
		
		

		// CTMS운영사관리 상세보기로 리다이렉트
		private String redirectList(RedirectAttributes reda, String message) {
			reda.addFlashAttribute("message", message);
			return "redirect:/qxsepmny/ech0701/ech0701View.do";
		}
		
		// ********************************(기준정보관리) 20201126 관리자 첨부파일삭제 ********************************
		@RequestMapping("/qxsepmny/ech0701/deleteFileUpload.do")
		public View deleteFileUpload( Ct7000mVO attachVO,HttpServletRequest request ,ModelMap model) throws Exception {
			LOGGER.debug("/qxsepmny/ech0701/deleteFileUpload.do - 파일 업로드 제거");
			
			String message = "";
			
			//파일 저장 path조회
			attachVO = cmmDAO.selectAttachOne(attachVO.getAttachNo());
			// 원본파일 삭제
			fileUtil.deleteFile(attachVO.getRegFileName());
			
			// 데이터 베이스 파일업로드 삭제 attachVO.getAttachNo() 를 사용해야한다.
			cmmDAO.deleteAttachFile(attachVO.getAttachNo());
			
			message = "첨부파일이 삭제되었습니다.";
			model.addAttribute("message", message);
			
			return jsonView;
		}
		
		
}