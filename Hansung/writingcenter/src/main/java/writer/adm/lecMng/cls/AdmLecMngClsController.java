package writer.adm.lecMng.cls;

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
import writer.adm.cmm.AdmCmmDAO;
import writer.adm.cmm.AdmCmmLogDAO;
import writer.valueObject.ClassVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Controller
public class AdmLecMngClsController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AdmLecMngClsController.class);
	
	@Autowired private AdmLecMngClsDAO admLecMngClsDAO;
	
	@Autowired private AdmCmmDAO admCmmDAO;
	
	@Autowired private AdmCmmLogDAO admCmmLogDAO;
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("searchVO", searchVO);
		reda.addFlashAttribute("message", searchVO.getMessage());
		return "redirect:/xabdmxgr/lecMng/cls/admLecMngClassList.do";
	}
	
	// 목록
	@RequestMapping("/xabdmxgr/lecMng/cls/admLecMngClassList.do")
	public String admLecMngClassList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/xabdmxgr/lecMng/cls/admLecMngClassList.do - 관리자 > 강의실 관리 > 교수님 생성 > 목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// 메뉴 코드
		session.setAttribute("admMenuNo", "502");

		// 학기 목록
		model.addAttribute("smtrList", admCmmDAO.selectSmtrList());
		
		// 계열 목록
		model.addAttribute("deptList", admCmmDAO.selectDeptList());
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO = admLecMngClsDAO.selectLecMngClsList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		return "/adm/lecMng/cls/admLecMngClassList";
	}
	
	// 등록&수정화면
	@RequestMapping("/xabdmxgr/lecMng/cls/admLecMngClassModify.do")
	public String admLecMngClassModify(String clsSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model) throws Exception {
		LOGGER.info("/xabdmxgr/lecMng/cls/admLecMngClassModify.do - 관리자 > 강의실 관리 > 교수님 생성 > 등록&수정화면");
		LOGGER.debug("clsSeq = "+clsSeq);
		
		ClassVO classVO = null;
		if (EgovStringUtil.isEmpty(clsSeq)) {
			// 등록화면
			classVO = new ClassVO();
			// 회원 목록
			model.addAttribute("memList", admCmmDAO.selectAdmList());
		}else{
			// 수정화면
			classVO = admLecMngClsDAO.selectLecMngClsOne(clsSeq);
			
			// 회원 목록
			model.addAttribute("memList", admCmmDAO.selectAdmList(clsSeq));
		}
		model.addAttribute("classVO", classVO);

		// 학기 목록
		model.addAttribute("smtrList", admCmmDAO.selectSmtrList());
		// 계열 목록
		model.addAttribute("deptList", admCmmDAO.selectDeptList());
		
		return "/adm/lecMng/cls/admLecMngClassModify";
	}
	
	// 등록&수정
	@RequestMapping("/xabdmxgr/lecMng/cls/admLecMngClassUpdate.do")
	public String admLecMngClassUpdate(ClassVO classVO, String memSeqChk, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/xabdmxgr/lecMng/cls/admLecMngClassUpdate.do - 관리자 > 강의실 관리 > 교수님 생성 > 등록&수정");
		LOGGER.debug("classVO = "+classVO.toString());
		LOGGER.debug("memSeqChk = "+memSeqChk);
		
		// 로그 set
		String logJob = "";
		String ip = (!EgovStringUtil.isEmpty(request.getHeader("X-FORWARDED-FOR")))? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
		
		if (EgovStringUtil.isEmpty(classVO.getClsSeq())) {
			// 등록
			String rsClsSeq = admLecMngClsDAO.lecMngClsInsert(classVO);
			// 권한 등록
			lecMngClsAthrReg(rsClsSeq, memSeqChk, ip);
			
			logJob = "강의실 관리 > 교수님 생성 > 등록()";
			
			searchVO.setMessage("등록되었습니다.");
		}else{
			// 수정
			admLecMngClsDAO.lecMngClsUpdate(classVO);
			// 기존권한 삭제
			admLecMngClsDAO.lecMngClsAthrDelete(classVO.getClsSeq());
			// 권한 등록
			lecMngClsAthrReg(classVO.getClsSeq(), memSeqChk, ip);
			
			logJob = "강의실 관리 > 교수님 생성 > 수정("+classVO.getClsSeq()+")";
			
			searchVO.setMessage("수정되었습니다.");
		}
		
		// 로그 등록        
		admCmmLogDAO.insertLogOne(logJob, ip);
		return redirectListPage(searchVO, reda);
	}
	
	// 삭제
	@RequestMapping("/xabdmxgr/lecMng/cls/admLecMngClassDelete.do")
	public String admLecMngClassDelete(@RequestParam String clsSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/xabdmxgr/lecMng/cls/admLecMngClassDelete.do - 관리자 > 강의실 관리 > 교수님 생성 > 삭제");
		LOGGER.debug("clsSeq = "+clsSeq);
		
		int notiCnt=admLecMngClsDAO.lecMngClsNotiCnt(clsSeq);
		int sbjtCnt=admLecMngClsDAO.lecMngClsSbjtCnt(clsSeq);
		int myClsCnt=admLecMngClsDAO.lecMngClsMyClsCnt(clsSeq);
		
		if(notiCnt > 0 || sbjtCnt > 0 || myClsCnt > 0){
			searchVO.setMessage("삭제할 수 없습니다.");
			LOGGER.debug("message - "+searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		
		String logJob = "";
		
		// 권한 삭제
		admLecMngClsDAO.lecMngClsAthrDelete(clsSeq);
		// 로그 등록
        String ip = (!EgovStringUtil.isEmpty(request.getHeader("X-FORWARDED-FOR")))? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
		admCmmLogDAO.insertLogOne("강의실 관리 > 교수님 생성 > 반_교수 권한 삭제("+clsSeq+")", ip);

		// 반 삭제
		admLecMngClsDAO.lecMngClsDelete(clsSeq);
		// 로그 등록
		admCmmLogDAO.insertLogOne("강의실 관리 > 교수님 생성 > 삭제("+clsSeq+")", ip);
		
		searchVO.setMessage("삭제되었습니다.");
		return redirectListPage(searchVO, reda);
	}
	
	// 권한 등록
	private void lecMngClsAthrReg(String clsSeq, String memSeqChk, String ip){
		String logJob = "";
		if (!EgovStringUtil.isEmpty(memSeqChk)) {
			if (memSeqChk.contains(",")) {
				String[] arrMemSeq = memSeqChk.split(",");
				for(String memSeq : arrMemSeq){
					admLecMngClsDAO.lecMngClsAthrInsert(clsSeq, memSeq);
					logJob = "강의실 관리 > 교수님 생성 > 반_교수 권한 등록("+clsSeq+")";
					admCmmLogDAO.insertLogOne(logJob, ip);
				}
			}else{
				admLecMngClsDAO.lecMngClsAthrInsert(clsSeq, memSeqChk);
				logJob = "강의실 관리 > 교수님 생성 > 반_교수 권한 등록("+clsSeq+")";
				admCmmLogDAO.insertLogOne(logJob, ip);
			}
		}
	}
}
