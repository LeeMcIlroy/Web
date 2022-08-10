package lcms.adm.entran;

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
import component.web.PaginationController;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import lcms.adm.cmm.AdmCmmController;
import lcms.cmm.CmmDAO;
import lcms.valueObject.AdminVO;
import lcms.valueObject.AttachVO;
import lcms.valueObject.EnterVO;
import lcms.valueObject.MemberVO;
import lcms.valueObject.SemesterVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class AdmEntranController extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(AdmEntranController.class);
	@Autowired private AdmEntranDAO admEntranDAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource View jsonView;
	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	
	// 관리자 신입학 목록화면 리다이렉트
	private String redirectList(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/entran/admEntranList.do";
	}

	// 관리자 신입학 수정화면 리다이렉트
	private String redirectModify(RedirectAttributes reda, String message, String enterSeq){
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("enterSeq", enterSeq);
		return "redirect:/qxsepmny/entran/admEntranModify.do";
	}

	// 관리자 재등록 등록화면 리다이렉트
	private String redirectRereModify(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/entran/admReregModify.do";
	}
	
	// 관리자 신입학 목록화면 리다이렉트
	private String redirectDelayList(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/entran/admDelayList.do";
	}
	
	// 관리자 신입학 목록화면
	@RequestMapping("/qxsepmny/entran/admEntranList.do")
	public String admEntranList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/entran/admEntranList.do - 관리자 신입학 목록화면");
		LOGGER.debug("searchVO = "+searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "101");
		searchVO.setSearchType("1");
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			EgovMap semester = cmmDAO.selectRegiSeme();
			searchVO.setSearchCondition1((String) semester.get("semYear")); 
			searchVO.setSearchCondition2((String) semester.get("semester")); 
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition1());
		
		model.addAttribute("yearList", yearList);
		model.addAttribute("semeList", semeList);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admEntranDAO.selectAdmEntranList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/entran/admEntranList";
	}
	
	// 관리자 신입학 일괄 합격&불합격 처리
	@RequestMapping("/qxsepmny/entran/admAjaxEntranBatch.do")
	public View admAjaxEntranBatch(String[] enterSeq, String status, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/entran/admAjaxEntranBatch.do - 관리자 신입학 일괄 합격&불합격 처리");
		LOGGER.debug("status = " + status);
		String message = "";
		
		EgovMap map = new EgovMap();
		
		map.put("enterSeq", enterSeq);
		map.put("status", status);
		
		admEntranDAO.updateAdmAjaxEntranBatch(map);
		
		if("2".equals(status)){
			message = "합격처리가 완료되었습니다.";
		}else{
			message = "불합격처리가 완료되었습니다.";
		}
		
		model.addAttribute("message", message);
		
		return jsonView;
	}
	
	// 관리자 신입학 이력 조회
	@RequestMapping("/qxsepmny/entran/admAjaxEnterReco.do")
	public View admAjaxEnterReco(String enterSeq, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/entran/admAjaxEnterReco.do - 관리자 신입학 이력 조회");
		LOGGER.debug("enterSeq = " + enterSeq);
		
		EnterVO enterVO = admEntranDAO.selectAdmEntranModify(enterSeq);
		List<EgovMap> recoList = admEntranDAO.selectRecoList(enterVO);
		
		model.addAttribute("enterVO", enterVO);
		model.addAttribute("recoList", recoList);
		
		return jsonView;
	}

	// 관리자 신입학 비고 저장
	@RequestMapping("/qxsepmny/entran/admAjaxSaveEtc.do")
	public View admAjaxSaveEtc(String enterSeq, String enterEtc, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/entran/admAjaxSaveEtc.do - 관리자 신입학 비고 저장");
		LOGGER.debug("enterSeq = " + enterSeq);
		LOGGER.debug("enterEtc = " + enterEtc);
		
		boolean status = false;
		
		if(!EgovStringUtil.isEmpty(enterSeq) && !EgovStringUtil.isEmpty(enterEtc)){
			EgovMap map = new EgovMap();
			map.put("enterSeq", enterSeq);
			map.put("enterEtc", enterEtc);
			
			admEntranDAO.updateAdmAjaxSaveEtc(map);
			status = true;
		}
		
		model.addAttribute("status", status);
		
		return jsonView;
	}

	// 관리자 신입학 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/entran/admEntranExcel.do")
	public void admEntranExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/entran/admEntranExcel.do - 관리자 신입학 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		searchVO.setSearchType("1");
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = admEntranDAO.selectAdmEntranExcel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName());
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "신입학 리스트", "entranList", request, response);
	}

	// 관리자 신입학 등록&수정 화면
	@RequestMapping("/qxsepmny/entran/admEntranModify.do")
	public String admEntranModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO,@ModelAttribute("enterSeq") String enterSeq, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/entran/admEntranModify.do - 관리자 신입학 등록&수정 화면");
		LOGGER.debug("enterSeq = " + enterSeq);
		request.getSession().setAttribute("admMenuNo", "101");
		
		EnterVO enterVO = new EnterVO();
		
		if(!EgovStringUtil.isEmpty(enterSeq)){
			enterVO = admEntranDAO.selectAdmEntranModify(enterSeq);
			
			String[] birthSplit = enterVO.getEnterBirth().split("-");
			
			enterVO.setEnterBtYear(birthSplit[0]);
			enterVO.setEnterBtMonth(birthSplit[1]);
			enterVO.setEnterBtDay(birthSplit[2]);
			
			EgovMap map = new EgovMap();
			map.put("boardSeq", enterSeq);
			map.put("boardType", "ENTR");
			List<AttachVO> attachList = cmmDAO.selectAttachList(map);
			model.addAttribute("attachList", attachList);
			
			List<EgovMap> recoList = admEntranDAO.selectRecoList(enterVO);
			model.addAttribute("recoList", recoList);
		}else{
			EgovMap semester = cmmDAO.selectRegiSeme();
			enterVO.setEnterYear((String) semester.get("semYear"));
			enterVO.setEnterSeme((String) semester.get("semester"));
			enterVO.setEnterDate(EgovStringUtil.getDateMinus());
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		List<EgovMap> semeList = cmmDAO.selectSemeList(enterVO.getEnterYear());
		
		model.addAttribute("yearList", yearList);
		model.addAttribute("semeList", semeList);
		
		String purpose = "nation";
		List<EgovMap> nationList = cmmDAO.cName(purpose);
		model.addAttribute("nationList", nationList);
		
		model.addAttribute("enterVO", enterVO);
		
		return "/adm/entran/admEntranModify";
	}

	// 관리자 신입학 국적 등록
	@RequestMapping("/qxsepmny/entran/admAjaxNationUpdate.do")
	public View admAjaxNationUpdate(String newNation, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/entran/admAjaxNationUpdate.do - 관리자 신입학 국적 등록");
		
		EgovMap map = new EgovMap();
		map.put("purpose", "nation");
		map.put("newNation", newNation);
		
		cmmDAO.insertCode(map);
		
		String purpose = "nation";
		List<EgovMap> nationList = cmmDAO.cName(purpose);
		model.addAttribute("nationList", nationList);
		
		return jsonView;
	}
	
	// 관리자 신입학 등록&수정
	@RequestMapping("/qxsepmny/entran/admEntranUpdate.do")
	public String admEntranUpdate(@ModelAttribute("enterVO") EnterVO enterVO, String deleteFile, MultipartHttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/entran/admEntranUpdate.do - 관리자 신입학 등록&수정");
		LOGGER.debug("enterVO = " + enterVO.toString());
		LOGGER.debug("deleteFile = " + deleteFile);
		String message = "";
		
		String enterBirth = enterVO.getEnterBtYear() + "-" + enterVO.getEnterBtMonth() + "-" + enterVO.getEnterBtDay();
		
		enterVO.setEnterBirth(enterBirth);
		
		if(!EgovStringUtil.isEmpty(enterVO.getEnterSeq())){
			if("Y".equals(enterVO.getDelayYn())){
				EnterVO resultVO = admEntranDAO.selectAdmEntranModify(enterVO.getEnterSeq());
				if(!EgovStringUtil.isEmpty(resultVO.getEnterCode())){
					String deleteYn = admEntranDAO.selectAdmMemberDelYn(resultVO.getEnterCode());
					if("Y".equals(deleteYn)){
						admEntranDAO.deleteAdmMember(resultVO.getEnterCode()); // 학생 데이터 삭제
						
						resultVO.setEnterCode("");
						admEntranDAO.updateAdmEntranEnterCode(enterVO); // 학번 제거
					}else{
						message = "수강신청이 되어있는 학생입니다.";
						return redirectModify(reda, message, enterVO.getEnterSeq());
					}
				}
			}
			
			admEntranDAO.updateAdmEntran(enterVO);
			
			FileInfoVO fileInfoVO = fileUtil.uploadAttachedFile(request, "ENTR", enterVO.getEnterSeq());
			
			if(fileInfoVO != null){
				if(!EgovStringUtil.isEmpty(deleteFile)){
					AttachVO delAttach = cmmDAO.selectAttachOne(deleteFile);
					fileUtil.deleteFile(delAttach.getRegFileName());
					cmmDAO.deleteAttachFile(delAttach.getAttachSeq());
				}
				
				AttachVO attachVO = new AttachVO(fileInfoVO);
				attachVO.setBoardType("ENTR");
				attachVO.setBoardSeq(enterVO.getEnterSeq());
				
				cmmDAO.insertAttachFile(attachVO);
			}
			
			if(!EgovStringUtil.isEmpty(enterVO.getEnterCode())){
				EnterVO insertVO = admEntranDAO.selectAdmDelayModify(enterVO.getEnterSeq());
				
				if(EgovStringUtil.isEmpty(insertVO.getEnterCode())){
					String date = EgovStringUtil.getDateMinus();
					
					insertVO.setEnterDate(date);
					insertVO.setEnterCode(enterVO.getEnterCode());
					
					MemberVO memberVO = new MemberVO(insertVO);
					memberVO.setMemberPw(EgovFileScrty.encryptPassword(memberVO.getMemberCode(), memberVO.getMemberCode()));
					
					// 학생 등록
					admEntranDAO.insertAdmEntToMem(memberVO);
					
					// 학번 입력
					admEntranDAO.updateAdmEntranEnterCode(insertVO);
					
					// 가상계좌 수정 (등록번호 -> 학번)
					admEntranDAO.updateAdmEntranAccountCode(insertVO);
				}
			}
			
			message = "수정이 완료되었습니다.";
			admLogInsert("운영담당자 > 입학 > 신입학 : 신입학 수정", enterVO.getEnterCode(), request);
		}else{
			
			String totCnt = admEntranDAO.selectAdmEntranTotCnt(enterVO);
			
			String enterCode = enterVO.getEnterYear().substring(2)+"K"+enterVO.getEnterStdType()+totCnt.substring(1);
			enterVO.setEnterCode(enterCode);
			
			String enterNum = enterVO.getEnterYear()+enterVO.getEnterSeme()+"-"+totCnt;
			enterVO.setEnterNum(enterNum);
			
			enterVO.setEnterSeq(admEntranDAO.insertAdmEntran(enterVO));
			
			FileInfoVO fileInfoVO = fileUtil.uploadAttachedFile(request, "ENTR", enterVO.getEnterSeq());
			
			if(fileInfoVO != null){
				AttachVO attachVO = new AttachVO(fileInfoVO);
				attachVO.setBoardType("ENTR");
				attachVO.setBoardSeq(enterVO.getEnterSeq());
				cmmDAO.insertAttachFile(attachVO);
			}

			message = "등록이 완료되었습니다.";
			admLogInsert("운영담당자 > 입학 > 신입학 : 신입학 등록", enterVO.getEnterCode(), request);
		}
		
		return redirectList(reda, message);
	}
	@RequestMapping("/qxsepmny/entran/admEntranDelete.do")
	public String admEntranDelete(@ModelAttribute("enterVO") EnterVO enterVO, String deleteFile, MultipartHttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/entran/admEntranUpdate.do - 관리자 신입학 useYn설정");
		LOGGER.debug("enterVO = " + enterVO.toString());
		LOGGER.debug("deleteFile = " + deleteFile);
		String message = "";

		if(!EgovStringUtil.isEmpty(enterVO.getEnterSeq())){
			if("N".equals(enterVO.getUseYn())){
				admEntranDAO.updateAdmEntranUseYn(enterVO);
			}
			
			message = "삭제처리되었습니다.";
			admLogInsert("운영담당자 > 입학 > 신입학 : 신입학 사용여부설정", enterVO.getEnterCode(), request);
		}
		
		return redirectList(reda, message);
	}
	// 관리자 신입학 합격자 학번일괄등록
	@RequestMapping("/qxsepmny/entran/admEntranCodeBat.do")
	public String admEntranCodeBat(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String[] enterSeq,  HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/entran/admEntranCodeBat.do - 관리자 신입학 합격자 학번일괄등록");
		LOGGER.debug("searchVO = " + searchVO.toString());
		String date = EgovStringUtil.getDateMinus();
		String message = "";
		
		EgovMap paramMap = new EgovMap();
		paramMap.put("enterSeq", enterSeq);
		
		List<EnterVO> resultList = admEntranDAO.selectAdmEntranCodeBat(paramMap);
		if(resultList.size() != 0){
			for(EnterVO enterVO : resultList){
				if(EgovStringUtil.isEmpty(enterVO.getEnterCode())){
					enterVO.setEnterDate(date);
					String totCnt = admEntranDAO.selectAdmMCodeCnt(enterVO);
					String memberCode = date.substring(2,4)+"K"+enterVO.getEnterStdType()+totCnt;
					enterVO.setEnterCode(memberCode);
					
					MemberVO memberVO = new MemberVO(enterVO);
					memberVO.setMemberPw(EgovFileScrty.encryptPassword(memberVO.getMemberCode(), memberVO.getMemberCode()));
					
					// 학생 등록
					admEntranDAO.insertAdmEntToMem(memberVO);
					
					// 학번 입력
					admEntranDAO.updateAdmEntranEnterCode(enterVO);
					
					// 등록금 고지에 학번 업데이트
					admEntranDAO.updateAdmRegistMemberCode(enterVO);
					
					// 가상계좌 수정 (등록번호 -> 학번)
					admEntranDAO.updateAdmEntranAccountCode(enterVO);
					
					// 가상계좌 EMR 수정

					admEntranDAO.updateAdmEntranAccEmr(enterVO);
					
					message = "일괄등록이 완료되었습니다.";
				}
			}
		}else{
			message = "학번을 등록 할 인원이 없습니다.";
		}
		
		return redirectList(reda, message);
	}
	
	// 관리자 재등록 목록화면 리다이렉트
	private String redirectListregi(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/entran/admReregList.do";
	}
	
	// 관리자 재등록 목록화면
	@RequestMapping("/qxsepmny/entran/admReregList.do")
	public String admReregList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/entran/admReregList.do - 관리자 재등록 목록화면");
		request.getSession().setAttribute("admMenuNo", "102");
		searchVO.setSearchType("2");
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			EgovMap semester = cmmDAO.selectRegiSeme();
			searchVO.setSearchCondition1((String) semester.get("semYear")); 
			searchVO.setSearchCondition2((String) semester.get("semester")); 
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition1());
		
		model.addAttribute("yearList", yearList);
		model.addAttribute("semeList", semeList);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admEntranDAO.selectAdmRegistList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/entran/admReregList";
	}

	// 관리자 재등록 등록&수정 화면
	@RequestMapping("/qxsepmny/entran/admReregModify.do")
	public String admReregModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, SemesterVO semesterVO, String enterSeq, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/entran/admReregModify.do - 관리자 재등록 등록&수정 화면");
		request.getSession().setAttribute("admMenuNo", "102");
		
		EnterVO enterVO = new EnterVO();
		
		if(!EgovStringUtil.isEmpty(enterSeq)){
			enterVO = admEntranDAO.selectAdmReistModify(enterSeq);
			
			EgovMap map = new EgovMap();
			map.put("boardSeq", enterSeq);
			map.put("boardType", "RERE");
			List<AttachVO> attachList = cmmDAO.selectAttachList(map);
			model.addAttribute("attachList", attachList);
			
			List<EgovMap> recoList = admEntranDAO.selectRegiRecoList(enterVO);
			model.addAttribute("recoList", recoList);

		}else{
			EgovMap semester = cmmDAO.selectRegiSeme();
			enterVO.setEnterYear((String) semester.get("semYear"));
			enterVO.setEnterSeme((String) semester.get("semester"));
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		List<EgovMap> semeList = cmmDAO.selectSemeList(enterVO.getEnterYear());
		
		model.addAttribute("yearList", yearList);
		model.addAttribute("semeList", semeList);
		
		List<String> nationList = cmmDAO.selectNationList();
		model.addAttribute("nationList", nationList);
		
		model.addAttribute("enterVO", enterVO);

		return "/adm/entran/admReregModify";
	}
	
	// 관리자 재등록/수정
	@RequestMapping("/qxsepmny/entran/admReregUpdate.do")
	public String admRegistUpdate(@ModelAttribute("enterVO") EnterVO enterVO, MemberVO memberVO, String deleteFile, MultipartHttpServletRequest request, RedirectAttributes reda) throws Exception{
		LOGGER.debug("/qxsepmny/entran/admReregUpdate.do - 관리자 재등록 & 수정");
		LOGGER.debug("enterVO = " + enterVO.toString());

		String message = "";
		if(!EgovStringUtil.isEmpty(enterVO.getEnterSeq())){
			admEntranDAO.updateAdmRegist(enterVO);
			FileInfoVO fileInfoVO = fileUtil.uploadAttachedFile(request, "RERE", enterVO.getEnterSeq());
			
			if(fileInfoVO != null){
				if(!EgovStringUtil.isEmpty(deleteFile)){
					AttachVO delAttach = cmmDAO.selectAttachOne(deleteFile);
					fileUtil.deleteFile(delAttach.getRegFileName());
					cmmDAO.deleteAttachFile(delAttach.getAttachSeq());
				}
				
				AttachVO attachVO = new AttachVO(fileInfoVO);
				attachVO.setBoardType("RERE");
				attachVO.setBoardSeq(enterVO.getEnterSeq());
				
				cmmDAO.insertAttachFile(attachVO);
			}
			message = "수정이 완료되었습니다.";
			admLogInsert("운영담당자 > 입학 > 재등록 : 재등록 수정", enterVO.getEnterCode(), request);
		}else{
			String overYn = admEntranDAO.selectAdmReistOverYn(enterVO);
			
			if("Y".equals(overYn)){
				message = "이미 해당학기에 재등록된 학생입니다.";
				return redirectRereModify(reda, message);
			}
			
			String totCnt = admEntranDAO.selectAdmReistTotCnt(enterVO);
							
			String enterNum = enterVO.getEnterYear()+enterVO.getEnterSeme()+"-"+totCnt;		  
			enterVO.setEnterNum(enterNum);
			
			admEntranDAO.insertAdmRegist(enterVO);
			
			FileInfoVO fileInfoVO = fileUtil.uploadAttachedFile(request, "RERE", enterVO.getEnterSeq());
			
			if(fileInfoVO != null){
				AttachVO attachVO = new AttachVO(fileInfoVO);
				attachVO.setBoardType("RERE");
				attachVO.setBoardSeq(enterVO.getEnterSeq());
				cmmDAO.insertAttachFile(attachVO);
			}

			message = "등록이 완료 되었습니다.";
			admLogInsert("운영담당자 > 입학 > 재등록 : 재등록 등록", enterVO.getEnterCode(), request);
		}
		return redirectListregi(reda,message);
	}

	// 관리자 재등록 학생찾기
	@RequestMapping("/qxsepmny/entran/admAjaxSearchStdRegiList.do")
	public View admAjaxSearchStd(String searchWord, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/cmm/admAjaxSearchStd.do - 관리자 재등록 학생 조회");
		LOGGER.debug("searchWord = " + searchWord);
		
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		
		EgovMap map = new EgovMap();
		map.put("searchWord", searchWord);
		map.put("selLectCode", selLectCode);
		
		List<EgovMap> resultList = admEntranDAO.selectAdmAjaxStdRegiList(map);
		model.addAttribute("resultList", resultList);
		
		return jsonView;
	}
	
	
	// 관리자 재등록 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/entran/admRegistExcel.do")
	public void admRegistExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/entran/admRegistExcel.do - 관리자 재등록 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		searchVO.setSearchType("2");
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = admEntranDAO.selectAdmRegistExcel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName());
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "재등록 리스트", "registList", request, response);
	}
	
	
	// 관리자 학생명단 목록화면
	@RequestMapping("/qxsepmny/entran/admStudentList.do")
	public String admStudentList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/entran/admStudentList.do - 관리자 학생명단 목록화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "103");
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			EgovMap semester = cmmDAO.selectRegiSeme();
			searchVO.setSearchCondition1((String) semester.get("semYear"));
			searchVO.setSearchCondition2((String) semester.get("semester"));
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition1());
		
		model.addAttribute("yearList", yearList);
		model.addAttribute("semeList", semeList);

		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admEntranDAO.selectAdmEntranStdList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		
		return "/adm/entran/admStudentList";
	}
	
	// 관리자 학생명단 이력조회 
	@RequestMapping("/qxsepmny/entran/admAjaxStdReco.do")
	public View admAjaxStdReco(String enterSeq, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/entran/admAjaxStdReco.do - 관리자 학생명단 이력조회");
		LOGGER.debug("enterSeq = " + enterSeq);
		
		EnterVO enterVO = admEntranDAO.selectAdmStdModify(enterSeq);
		List<EgovMap> recoList = admEntranDAO.selectStdRecoList(enterVO);
		
		model.addAttribute("enterVO", enterVO);
		model.addAttribute("recoList", recoList);
		
		return jsonView;
		
	}

	// 관리자 신입학 급수일괄등록 
	@RequestMapping("/qxsepmny/entran/admAjaxSaveStep.do")
	public View admAjaxSaveStep(String step, String[] enterSeq, HttpServletRequest request, RedirectAttributes reda, ModelMap model) throws Exception{
		LOGGER.debug("/qxsepmny/entran/admAjaxSaveStep.do - 관리자 신입학 급수일괄등록");
		LOGGER.debug("step = " + step);
		String message = "";
		
		EgovMap map = new EgovMap();
		map.put("step", step);
		map.put("enterSeq", enterSeq);
		
		admEntranDAO.updateAdmAjaxSaveStep(map);
		admEntranDAO.updateAdmAjaxSaveStepEnter(map);
		
		message = "저장되었습니다.";
		model.addAttribute("message", message);
		
		return jsonView;
		
	}
	
	
	// 관리자 학생명단 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/entran/admStdListExcel.do")
	public void admStdListExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/entran/admStdListExcel.do - 관리자 학생명단 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = admEntranDAO.selectAdmStdListExcel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName());
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "학생명단 리스트", "studentList", request, response);
	}

	// 관리자 재등록 일괄등록 팝업
	@RequestMapping("/qxsepmny/entran/admAjaxSelectStdList.do")
	public View admAjaxSelectStdList(String searchType, String searchWord, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/entran/admAjaxSelectStdList.do - 관리자 학생명단 엑셀 다운로드");
		LOGGER.debug("searchType = " + searchType + "searchWord = " + searchWord);
		
		EgovMap semester = cmmDAO.selectRegiSeme();
		
		String regYear = (String) semester.get("semYear");
		String regSeme = (String) semester.get("semester");
		String openYear = "";
		String openSeme = "";
		
		if("1".equals(regSeme)){
			openYear = String.valueOf((Integer.parseInt(regYear)-1));
			openSeme = "4";
		}else{
			openYear = regYear;
			openSeme = String.valueOf((Integer.parseInt(regSeme)-1));
		}
		
		EgovMap paramMap = new EgovMap();
		paramMap.put("regYear", regYear);
		paramMap.put("regSeme", regSeme);
		paramMap.put("openYear", openYear);
		paramMap.put("openSeme", openSeme);
		paramMap.put("searchType", searchType);
		paramMap.put("searchWord", searchWord);
		
		List<EgovMap> resultList = admEntranDAO.selectAdmAjaxSelectStdList(paramMap);
		
		model.addAttribute("resultList", resultList);
		
		return jsonView;
	}

	// 관리자 재등록 일괄등록
	@RequestMapping("/qxsepmny/entran/admAjaxSaveRereg.do")
	public View admAjaxSaveRereg(String enterDate, String[] memberCode, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/entran/admAjaxSaveRereg.do - 관리자 학생명단 엑셀 다운로드");
		LOGGER.debug("enterDate = " + enterDate + "memberCode = " + memberCode);
		String message = "";
		if(memberCode.length == 0){
			message = "선택된 학생이 존재하지 않습니다.";
		}else{
			EgovMap semester = cmmDAO.selectRegiSeme();
			EgovMap paramMap = new EgovMap();
			paramMap.put("enterDate", enterDate);
			paramMap.put("enterYear", semester.get("semYear"));
			paramMap.put("enterSeme", semester.get("semester"));
			paramMap.put("memberCode", memberCode);
			
			admEntranDAO.insertAdmAjaxSaveRereg(paramMap);
			
			message = "등록이 완료되었습니다.";
		}
		
		model.addAttribute("message", message);
		
		return jsonView;
	}
	
	// 관리자 입학연기 목록화면
	@RequestMapping("/qxsepmny/entran/admDelayList.do")
	public String admDelayList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/entran/admDelayList.do - 관리자 입학연기 목록화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "104");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admEntranDAO.selectAdmDelayList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		
		return "/adm/entran/admDelayList";
	}
	
	// 관리자 입학연기 등록&수정 화면
	@RequestMapping("/qxsepmny/entran/admDelayModify.do")
	public String admDelayModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO,@ModelAttribute("enterSeq") String enterSeq, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/entran/admDelayModify.do - 관리자 입학연기 등록&수정 화면");
		LOGGER.debug("enterSeq = " + enterSeq);
		request.getSession().setAttribute("admMenuNo", "104");
		
		EnterVO enterVO = admEntranDAO.selectAdmDelayModify(enterSeq);
		
		EgovMap map = new EgovMap();
		map.put("boardSeq", enterSeq);
		map.put("boardType", "ENTR");
		List<AttachVO> attachList = cmmDAO.selectAttachList(map);
		model.addAttribute("attachList", attachList);
		
		List<EgovMap> recoList = admEntranDAO.selectRecoList(enterVO);
		model.addAttribute("recoList", recoList);
		
		EgovMap registFee = admEntranDAO.selectAdmRegistFee(enterVO.getEnterNum());
		model.addAttribute("registFee", registFee);
		
		List<String> yearList = cmmDAO.selectYearList();
		
		if(EgovStringUtil.isEmpty(enterVO.getDelayEntrYear())){
			enterVO.setDelayEntrYear(yearList.get(0));
		}
		
		List<EgovMap> semeList = cmmDAO.selectSemeList(enterVO.getDelayEntrYear());
		
		model.addAttribute("yearList", yearList);
		model.addAttribute("semeList", semeList);
		
		model.addAttribute("enterVO", enterVO);
		
		return "/adm/entran/admDelayModify";
	}

	// 관리자 입학연기 등록&수정
	@RequestMapping("/qxsepmny/entran/admDelayUpdate.do")
	public String admDelayUpdate(@ModelAttribute("enterVO") EnterVO enterVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/entran/admDelayUpdate.do - 관리자 입학연기 등록&수정");
		LOGGER.debug("enterVO = " + enterVO.toString());
		request.getSession().setAttribute("admMenuNo", "104");
		String message = "";
		
		admEntranDAO.updateAdmDelayUpdate(enterVO);
		
	
		message = "등록이 완료되었습니다.";
		
		return redirectDelayList(reda, message);
	}
	
	// 관리자 입학연기 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/entran/admDelayExcel.do")
	public void admDelayExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/entran/admDelayExcel.do - 관리자 입학연기 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = admEntranDAO.selectAdmDelayExcel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName());
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "입학연기 리스트", "delayList", request, response);
	}
	
	// 관리자 재등록 취소
	@RequestMapping("/qxsepmny/entran/admReregDel.do")
	public String admReregDel(@ModelAttribute("enterVO") EnterVO enterVO, MultipartHttpServletRequest request, RedirectAttributes reda) throws Exception{
		LOGGER.debug("/qxsepmny/entran/admReregDel.do - 관리자 재등록 취소");
		LOGGER.debug("enterVO = " + enterVO.toString());
		
		String message = "";
		
		String enroYn = admEntranDAO.selectAdmEnroYn(enterVO);
		
		if("Y".equals(enroYn)){
			message = "수강신청 내역이 존재합니다.";
		}else{
			admEntranDAO.deleteAdmRereg(enterVO.getEnterSeq());
			message = "취소가 완료되었습니다.";
		}

		return redirectListregi(reda,message);
	}
	
}
