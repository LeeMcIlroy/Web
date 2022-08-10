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
import lcms.valueObject.EvalVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class LecClssAppraiseController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(LecClssAppraiseController.class);
	
	@Autowired private LecClssAppraiseDAO lecClssAppraiseDAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource View jsonView;
	
	// 강사 - 수업 - 학생평가 목록 화면으로 리다이렉트합니다.
	private String redirectLecClssAppraiseList(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/usr/lec/clss/lecClssAppraiseList.do";
	}
	
	// 강사 - 수업 - 학생평가 목록
	@RequestMapping("/usr/lec/clss/lecClssAppraiseList.do")
	public String lecClssAppraiseList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecClssAppraiseList.do - 강사 -수업-학생평가 목록");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("lecMenuNo", "105");
		
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		searchVO.setSearchLecture(selLectCode);
		
		EgovMap resultMap = lecClssAppraiseDAO.selectLecClssAppraiseStat(searchVO);
		model.addAttribute("resultMap", resultMap);
		
		List<EgovMap> resultList = lecClssAppraiseDAO.selectLecClssAppraiseList(searchVO);
		
		model.addAttribute("resultList", resultList);
		
		return "/usr/lec/clss/lecClssAppraiseList";
	}
	
	// 강사 - 수업 - 학생평가 상세
	@RequestMapping("/usr/lec/clss/lecClssAppraiseView.do")
	public String lecClssAppraiseView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String evalSeq, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecClssAppraiseView.do - 강사 -수업-학생평가 상세");
		LOGGER.debug("evalSeq = " + evalSeq);
		request.getSession().setAttribute("lecMenuNo", "105");
		
		EvalVO evalVO = lecClssAppraiseDAO.selectLecClssAppraiseView(evalSeq);
		
		EgovMap map = new EgovMap();
		map.put("boardSeq", evalSeq);
		map.put("boardType", "EVAL");
		
		List<AttachVO> attachList = cmmDAO.selectAttachList(map);
		
		model.addAttribute("evalVO", evalVO);
		model.addAttribute("attachList", attachList);
		
		return "/usr/lec/clss/lecClssAppraiseView";
	}
	
	// 강사 - 수업 - 학생평가 등록/수정 화면
	@RequestMapping("/usr/lec/clss/lecClssAppraiseModify.do")
	public String lecClssAppraiseModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String evalSeq, String memberCode, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecClssAppraiseModify.do - 강사 -수업-학생평가 등록/수정 화면");
		request.getSession().setAttribute("lecMenuNo", "105");
		
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		EvalVO evalVO = new EvalVO();
		
		if(!EgovStringUtil.isEmpty(evalSeq)){
			evalVO = lecClssAppraiseDAO.selectLecClssAppraiseOne(evalSeq);
			
			EgovMap map = new EgovMap();
			map.put("boardSeq", evalSeq);
			map.put("boardType", "EVAL");
			
			List<AttachVO> attachList = cmmDAO.selectAttachList(map);
			model.addAttribute("attachList", attachList);
		}else if(!EgovStringUtil.isEmpty(memberCode)){
			evalVO = lecClssAppraiseDAO.selectLecClssMember(memberCode);
		}
		List<EgovMap> profList = cmmDAO.selectProfList(selLectCode);
		model.addAttribute("profList", profList);
		
		model.addAttribute("evalVO", evalVO);
		
		return "/usr/lec/clss/lecClssAppraiseModify";
	}

	// 강사 - 수업 - 학생평가 등록/수정
	@RequestMapping("/usr/lec/clss/lecClssAppraiseUpdate.do")
	public String lecClssAppraiseUpdate(@ModelAttribute("evalVO") EvalVO evalVO, String[] delSeqList, HttpSession session, MultipartHttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecClssAppraiseUpdate.do - 강사 -수업-학생평가 등록/수정");
		LOGGER.debug("evalVO = " + evalVO.toString());
		request.getSession().setAttribute("lecMenuNo", "105");
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		String message = "";
		
		evalVO.setLectSeq(selLectCode);
		
		if(!EgovStringUtil.isEmpty(evalVO.getEvalSeq())){
			lecClssAppraiseDAO.updateLecClssAppraise(evalVO);
			
			if(delSeqList != null){
				for(String delSeq : delSeqList){
					AttachVO delAttach = cmmDAO.selectAttachOne(delSeq);
					fileUtil.deleteFile(delAttach.getRegFileName());
					cmmDAO.deleteAttachFile(delAttach.getAttachSeq());
				}
			}
		}else{
			lecClssAppraiseDAO.insertLecClssAppraise(evalVO);
		}
		
		List<FileInfoVO> fileInfoList = fileUtil.uploadAttachedFiles(request, "EVAL");
		if(fileInfoList != null){
			for(FileInfoVO fileInfoVO : fileInfoList){
				AttachVO attachVO = new AttachVO(fileInfoVO);
				attachVO.setBoardType("EVAL");
				attachVO.setBoardSeq(evalVO.getEvalSeq());
				cmmDAO.insertAttachFile(attachVO);
			}
		}
		
		message = "등록이 완료되었습니다.";
		
		return redirectLecClssAppraiseList(reda, message);
	}
	
	// 강사 - 수업 - 평가 이력
	@RequestMapping("/usr/lec/clss/lecClssAppraisePop.do")
	public String lecClssAppraisePop(String memberCode, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecClssAppraisePop.do - 강사 -수업-평가 이력");
		LOGGER.debug("memberCode = " + memberCode);
		
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		
		EgovMap map = new EgovMap();
		map.put("lectSeq", selLectCode);
		map.put("memberCode", memberCode);
		
		List<EgovMap> resultList = lecClssAppraiseDAO.lecClssAppraisePop(map);
		model.addAttribute("resultList", resultList);
		
		return "/usr/lec/clss/lecClssAppraisePop";
	}

	// 강사 - 학생평가 - 미리보기
	@RequestMapping("/usr/lec/clss/lecClssAppraisePre.do")
	public String lecClssAppraisePre(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecClssAppraisePre.do - 강사 - 학생평가 - 미리보기");
		LOGGER.debug("searchVO = " + searchVO.toString());
		
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		
		List<EgovMap> resultList = lecClssAppraiseDAO.lecClssAppraisePre(selLectCode);
		model.addAttribute("resultList", resultList);
		
		return "/usr/lec/clss/lecClssAppraisePre";
	}
	
}
