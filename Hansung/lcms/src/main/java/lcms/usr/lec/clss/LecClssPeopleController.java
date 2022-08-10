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
import org.springframework.web.servlet.View;

import component.web.PaginationController;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import lcms.adm.cmm.AdmCmmController;
import lcms.valueObject.MemberVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class LecClssPeopleController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(LecClssPeopleController.class);
	
	@Autowired private LecClssPeopleDAO lecClssPeopleDAO;
	@Resource View jsonView;
	
	// 강사 - 수업 - 수강인원 목록
	@RequestMapping("/usr/lec/clss/lecClssPeopleList.do")
	public String lecClssPeopleList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecClssPeopleList.do - 강사 -수업-수강인원 목록");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("lecMenuNo", "103");
		
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		searchVO.setMenuType(selLectCode);

		EgovMap semester = cmmDAO.selectOpenSeme();
		searchVO.setSearchCondition1((String) semester.get("semYear"));
		searchVO.setSearchCondition2((String) semester.get("semester"));
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = lecClssPeopleDAO.selectLecClssPeopleList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/usr/lec/clss/lecClssPeopleList";
	}
	
// 교사 강의 학생명단 인쇄 팝업
	@RequestMapping("/usr/lec/clss/usrStdPop.do")
	public String admCertiPop(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String lectYear, String lectSem, String prtType, HttpServletRequest request
			, ModelMap model, String lectSeq) throws Exception {
		LOGGER.debug("/usr/lec/clss/usrStdPop.do - 교사 강의 학생명단 인쇄 팝업");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "401");
		
		if("STDLIST".equals(prtType)){
			String selLectCode = (String) request.getSession().getAttribute("selLectCode");
			searchVO.setMenuType(selLectCode);
			
			PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
			CmmnListVO listVO = lecClssPeopleDAO.selectLecClssPeoplePrtList(searchVO);
			paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
			
			model.addAttribute("resultList", listVO.getEgovList());
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		}else if("ABSWRN".equals(prtType)){
			EgovMap semester = cmmDAO.selectOpenSeme();
			searchVO.setSearchCondition1((String) semester.get("semYear"));
			searchVO.setSearchCondition2((String) semester.get("semester"));
			
			CmmnListVO listVO = lecClssPeopleDAO.selectPopWrnList(searchVO);
			model.addAttribute("resultList", listVO.getEgovList());
			
		}
		
		model.addAttribute("prtType", prtType);
		
		return "/usr/lec/clss/usrStdPop";
	}
	@RequestMapping("/usr/lec/clss/usrAjaxChk.do")
	public View usrAjaxChk(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String memberCode, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/clss/usrAjaxChk.do");
		
		EgovMap semester = cmmDAO.selectOpenSeme();
		searchVO.setSearchCondition1((String) semester.get("semYear"));
		searchVO.setSearchCondition2((String) semester.get("semester"));
		
		CmmnListVO listVO = lecClssPeopleDAO.selectPopWrnList(searchVO);
		model.addAttribute("resultList", listVO.getEgovList());
		
		return jsonView;
	}	
	
	
	// 강사 - 수업 - 수강인원 학생 상세 화면
	@RequestMapping("/usr/lec/clss/lecClssPeopleView.do")
	public String lecClssPeopleView(@ModelAttribute("memberVO") MemberVO memberVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/clss/lecClssPeopleView.do - 강사>수업 >수강인원 학생 상세 화면");
		request.getSession().setAttribute("lecMenuNo", "103");
		
		String memberSeq = memberVO.getMemberSeq();
		
		if(!EgovStringUtil.isEmpty(memberSeq)){
			memberVO = lecClssPeopleDAO.selectLecClssPeopleView(memberSeq);
			model.addAttribute("memberVO", memberVO);
			List<EgovMap> lectList = lecClssPeopleDAO.selectStudLectList(memberVO);
			model.addAttribute("lectList", lectList);
			List<EgovMap> regiList = lecClssPeopleDAO.selectStudRegiList(memberVO);
			model.addAttribute("regiList", regiList);
			List<EgovMap> gradeList = lecClssPeopleDAO.selectGradeList(memberVO);
			model.addAttribute("gradeList", gradeList);
			List<EgovMap> consulList = lecClssPeopleDAO.selectStudConsulList(memberVO);
			model.addAttribute("consulList", consulList);
			
		}
		
		return "/usr/lec/clss/lecClssPeopleView";
	}
}
