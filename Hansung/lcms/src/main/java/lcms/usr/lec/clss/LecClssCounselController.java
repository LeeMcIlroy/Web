package lcms.usr.lec.clss;

import java.util.List;

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

import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.web.PaginationController;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import lcms.adm.cmm.AdmCmmController;
import lcms.cmm.CmmDAO;
import lcms.valueObject.AttachVO;
import lcms.valueObject.ConsultVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class LecClssCounselController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(LecClssCounselController.class);
	
	@Autowired private LecClssCounselDAO lecClssCounselDAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource View jsonView;
	
	// 강사 - 수업 - 상담 목록 화면으로 리다이렉트합니다.
	private String redirectLecClssCounselList(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/usr/lec/clss/lecClssCounselList.do";
	}
	
	// 강사 - 수업 - 상담 목록 화면
	@RequestMapping("/usr/lec/clss/lecClssCounselList.do")
	public String lecClssCounselList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecClssCounselList.do - 강사 -수업-상담 목록 화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("lecMenuNo", "104");
		
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		searchVO.setSearchLecture(selLectCode);
		
		EgovMap resultMap = lecClssCounselDAO.selectLecClssCounselStat(searchVO);
		model.addAttribute("resultMap", resultMap);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = lecClssCounselDAO.selectLecClssCounselList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/usr/lec/clss/lecClssCounselList";
	}

	// 강사 - 수업 - 상담 이력
	@RequestMapping("/usr/lec/clss/lecClssCounselPop.do")
	public String lecClssCounselPop(String memberCode, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecClssCounselPop.do - 강사 -수업-상담 이력");
		LOGGER.debug("memberCode = " + memberCode);
		
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		
		EgovMap map = new EgovMap();
		map.put("lectSeq", selLectCode);
		map.put("memberCode", memberCode);
		
		List<EgovMap> resultList = lecClssCounselDAO.lecClssCounselPop(map);
		model.addAttribute("resultList", resultList);
		
		return "/usr/lec/clss/lecClssCounselPop";
	}
	
	// 강사 - 수업 - 상담 상세 화면
	@RequestMapping("/usr/lec/clss/lecClssCounselView.do")
	public String lecClssCounselView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String consultSeq, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecClssCounselView.do - 강사 -수업-상담 상세 화면");
		LOGGER.debug("consultSeq = " + consultSeq);
		request.getSession().setAttribute("lecMenuNo", "104");
		
		ConsultVO consultVO = lecClssCounselDAO.selectLecClssCounselView(consultSeq);
		model.addAttribute("consultVO", consultVO);
		
		EgovMap map = new EgovMap();
		map.put("boardSeq", consultSeq);
		map.put("boardType", "CONS");
		
		List<AttachVO> attachList = cmmDAO.selectAttachList(map);
		model.addAttribute("attachList", attachList);
		
		return "/usr/lec/clss/lecClssCounselView";
	}
	
	// 강사 - 수업 - 상담 등록/수정 화면
	@RequestMapping("/usr/lec/clss/lecClssCounselModify.do")
	public String lecClssCounselModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String consultSeq, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecClssCounselModify.do - 강사 -수업-상담 등록/수정 화면");
		request.getSession().setAttribute("lecMenuNo", "104");
		
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		ConsultVO consultVO = new ConsultVO();
		
		if(!EgovStringUtil.isEmpty(consultSeq)){
			consultVO = lecClssCounselDAO.selectLecClssCounselOne(consultSeq);
		}
		model.addAttribute("consultVO", consultVO);
		
		EgovMap map = new EgovMap();
		map.put("boardSeq", consultSeq);
		map.put("boardType", "CONS");
		
		List<AttachVO> attachList = cmmDAO.selectAttachList(map);
		model.addAttribute("attachList", attachList);
		
		List<EgovMap> profList = cmmDAO.selectProfList(selLectCode);
		model.addAttribute("profList", profList);
		
		return "/usr/lec/clss/lecClssCounselModify";
	}

	// 강사 - 수업 - 상담 등록/수정
	@RequestMapping("/usr/lec/clss/lecClssCounselUpdate.do")
	public String lecClssCounselUpdate(@ModelAttribute("consultVO") ConsultVO consultVO, String[] delSeqList, HttpSession session, MultipartHttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecClssCounselUpdate.do - 강사 -수업-상담 등록/수정");
		LOGGER.debug("consultVO = " + consultVO.toString());
		request.getSession().setAttribute("lecMenuNo", "104");
		EgovMap lecSession = (EgovMap) request.getSession().getAttribute("lecSession");
		String message = "";
		
		consultVO.setLectSeq(Integer.toString((int) lecSession.get("lectSeq")));
		consultVO.setYear((String) lecSession.get("lectYear"));
		consultVO.setSemester((String) lecSession.get("lectSem"));
		
		if(!EgovStringUtil.isEmpty(consultVO.getConsultSeq())){
			lecClssCounselDAO.updateLecClssCounsel(consultVO);
			
			if(delSeqList != null){
				for(String delSeq : delSeqList){
					AttachVO delAttach = cmmDAO.selectAttachOne(delSeq);
					fileUtil.deleteFile(delAttach.getRegFileName());
					cmmDAO.deleteAttachFile(delAttach.getAttachSeq());
				}
			}
		}else{
			lecClssCounselDAO.insertLecClssCounsel(consultVO);
		}
		
		List<FileInfoVO> fileInfoList = fileUtil.uploadAttachedFiles(request, "CONS");
		if(fileInfoList != null){
			for(FileInfoVO fileInfoVO : fileInfoList){
				AttachVO attachVO = new AttachVO(fileInfoVO);
				attachVO.setBoardType("CONS");
				attachVO.setBoardSeq(consultVO.getConsultSeq());
				cmmDAO.insertAttachFile(attachVO);
			}
		}
		
		return redirectLecClssCounselList(reda, message);
	}
	
	
	
	
}
