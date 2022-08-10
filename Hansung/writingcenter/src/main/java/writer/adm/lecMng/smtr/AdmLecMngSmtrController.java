package writer.adm.lecMng.smtr;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.web.PaginationController;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import writer.adm.cmm.AdmCmmLogDAO;
import writer.valueObject.SemesterVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Controller
public class AdmLecMngSmtrController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AdmLecMngSmtrController.class);
	
	@Autowired private AdmLecMngSmtrDAO admLecMngSmtrDAO;
	
	@Autowired private AdmCmmLogDAO admCmmLogDAO;

	
	// 검색조건을 가지고 목록으로 이동
	private String redirectListPage(CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", searchVO.getMessage());
		return "redirect:/xabdmxgr/lecMng/smtr/admLecMngSemesterList.do";
	}
	
	// 학기 강의실 목록
	@RequestMapping("/xabdmxgr/lecMng/smtr/admLecMngSemesterList.do")
	public String admLecMngSemesterList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/xabdmxgr/lecMng/smtr/admLecMngSemesterList.do - 관리자 > 강의실 관리 > 학기강의실 생성 > 목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// 메뉴 코드
		session.setAttribute("admMenuNo", "501");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO = admLecMngSmtrDAO.selectLecMngSmtrList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		return "/adm/lecMng/smtr/admLecMngSemesterList";
	}
	
	// 학기 강의실 등록&수정화면
	@RequestMapping("/xabdmxgr/lecMng/smtr/admLecMngSemesterModify.do")
	public String admLecMngSemesterModify(String smtrSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model) throws Exception {
		LOGGER.info("/xabdmxgr/lecMng/smtr/admLecMngSemesterModify.do - 관리자 > 강의실 관리 > 학기강의실 생성 > 등록&수정화면");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("smtrSeq = "+smtrSeq);
		
		SemesterVO semesterVO = null;
		if (EgovStringUtil.isEmpty(smtrSeq)) {
			// 등록화면
			semesterVO = new SemesterVO();
		}else {
			// 수정화면
			semesterVO = admLecMngSmtrDAO.selectLecMngSmtrOne(smtrSeq);
		}
		model.addAttribute("semesterVO", semesterVO);
		
		return "/adm/lecMng/smtr/admLecMngSemesterModify";
	}
	
	// 학기 강의실 등록&수정
	@RequestMapping("/xabdmxgr/lecMng/smtr/admLecMngSemesterUpdate.do")
	public String admLecMngSemesterUpdate(SemesterVO semesterVO, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.info("/xabdmxgr/lecMng/smtr/admLecMngSemesterUpdate.do - 관리자 > 강의실 관리 > 학기강의실 생성 > 등록&수정");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("semesterVO = "+semesterVO.toString());
		
		String logJob = "";
		if (EgovStringUtil.isEmpty(semesterVO.getSmtrSeq())) {
			// 등록
			admLecMngSmtrDAO.lecMngSmtrInsert(semesterVO);
			
			logJob = "강의실 관리 > 학기강의실 생성 > 등록";
			
			searchVO.setMessage("등록되었습니다.");
		}else {
			// 수정
			admLecMngSmtrDAO.lecMngSmtrUpdate(semesterVO);
			
			logJob = "강의실 관리 > 학기강의실 생성 > 수정("+semesterVO.getSmtrSeq()+")";
			
			searchVO.setMessage("수정되었습니다.");
		}
		
		// 로그 등록
		String ip = (!EgovStringUtil.isEmpty(request.getHeader("X-FORWARDED-FOR")))? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
		admCmmLogDAO.insertLogOne(logJob, ip);
		return redirectListPage(searchVO, reda);
	}
	
	// 학기 강의실 삭제
	@RequestMapping("/xabdmxgr/lecMng/smtr/admLecMngSemesterDelete.do")
	public String admLecMngSemesterDelete(@RequestParam String smtrSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/xabdmxgr/lecMng/smtr/admLecMngSemesterDelete.do - 관리자 > 강의실 관리 > 학기강의실 생성 > 삭제");
		LOGGER.debug("smtrSeq = "+smtrSeq);
		
		int clsCnt=admLecMngSmtrDAO.lecMngSmtrCnt(smtrSeq);
		if(clsCnt>0){
			searchVO.setMessage("삭제할 수 없습니다.");
			LOGGER.debug("searchVO - "+searchVO.toString());
			return redirectListPage(searchVO, reda);
		}
		
		admLecMngSmtrDAO.lecMngSmtrDelete(smtrSeq);
		
		// 로그 등록
		String ip = (!EgovStringUtil.isEmpty(request.getHeader("X-FORWARDED-FOR")))? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
		admCmmLogDAO.insertLogOne("강의실 관리 > 학기강의실 생성 > 삭제("+smtrSeq+")", ip);
		
		searchVO.setMessage("삭제되었습니다.");
		return redirectListPage(searchVO, reda);
	}
}
