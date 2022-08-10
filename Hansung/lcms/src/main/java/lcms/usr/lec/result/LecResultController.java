package lcms.usr.lec.result;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.web.PaginationController;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import lcms.adm.cmm.AdmCmmController;
import lcms.cmm.CmmDAO;
import lcms.usr.lec.com.LecComDAO;
import lcms.valueObject.GradeVO;
import lcms.valueObject.UsrVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class LecResultController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(LecResultController.class);
	
	@Autowired private LecResultDAO lecResultDAO;
	@Autowired private LecComDAO lecComDAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource View jsonView;
	
	// 강사 - 성적 목록화면으로 리다이렉트합니다.
	private String redirectLecResultList(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/usr/lec/result/lecResultList.do";
	}
	
	// 강사 - 성적 목록
	@RequestMapping("/usr/lec/result/lecResultList.do")
	public String lecResultList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/result/lecResultList.do - 강사 - 성적 목록");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("lecMenuNo", "401");
		
		EgovMap sessionSem = (EgovMap) request.getSession().getAttribute("semester");
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			searchVO.setSearchCondition1((String) sessionSem.get("semYear"));
		}
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition2())){
			searchVO.setSearchCondition2((String) sessionSem.get("semester"));
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition1());
		model.addAttribute("semeList", semeList);
		
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		searchVO.setMenuType(selLectCode);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = lecResultDAO.LecResultList(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/usr/lec/result/lecResultList";
	}
	
	// 강사 - 성적 상세
	@RequestMapping("/usr/lec/result/lecResultView.do")
	public String lecResultView(@ModelAttribute("gradeVO") GradeVO gradeVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/result/lecResultView.do - 강사 - 성적 상세");
		request.getSession().setAttribute("lecMenuNo", "401");
		
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		
		gradeVO.setLectCode(selLectCode);
		
		if(EgovStringUtil.isEmpty(gradeVO.getGradeGubun())){
			gradeVO.setGradeGubun("1");
		}
		
		List<EgovMap> resultList = lecResultDAO.selectLecResultViewList(gradeVO);
		
		model.addAttribute("gradeVO", gradeVO);
		model.addAttribute("resultList", resultList);
		
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		List<EgovMap> semeList = cmmDAO.selectSemeList(yearList.get(0));
		model.addAttribute("semeList", semeList);
		
		return "/usr/lec/result/lecResultView";
	}

	// 강사 - 성적 저장&수정
	@RequestMapping("/usr/lec/result/lecResultUpdate.do")
	public String lecResultUpdate(@ModelAttribute("gradeVO") GradeVO gradeVO, HttpSession session, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/usr/lec/result/lecResultUpdate.do - 강사 - 성적 저장&수정");
		LOGGER.debug("gradeVO = " + gradeVO.toString());
		request.getSession().setAttribute("lecMenuNo", "401");
		
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		UsrVO sessionVO = (UsrVO) EgovUserDetailsHelper.getAuthenticatedUser();
		String message = "";
		
		for(GradeVO resultVO : gradeVO.getGradeList()){
			resultVO.setLectCode(selLectCode);
			resultVO.setGradeLec(sessionVO.getMemberCode());
			resultVO.setSemYear(gradeVO.getSemYear());
			resultVO.setSemEster(gradeVO.getSemEster());
			resultVO.setGradeGubun(gradeVO.getGradeGubun());
			
			if(!EgovStringUtil.isEmpty(resultVO.getGradeSeq())){
				lecResultDAO.updateLecResult(resultVO);
			}else{
				lecResultDAO.insertLecResult(resultVO);
			}
		}
		message = "저장이 완료되었습니다.";
		
		return redirectLecResultList(reda, message);
	}

	// 강사 - 성적 저장&수정
	@RequestMapping("/usr/lec/result/lecGradeSubmis.do")
	public String lecGradeSubmis(HttpSession session, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/usr/lec/result/lecGradeSubmis.do - 강사 - 성적 저장&수정");
		String message = "";
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		
		String resultYn = lecResultDAO.selectLecGradeYn(selLectCode);
		
		if("N".equals(resultYn)){
			message = "성적이 입력되지 않은 학생이 존재합니다.";
		}else{
			String memberCode = EgovUserDetailsHelper.getAuthenticatedUserId();
			
			EgovMap map = new EgovMap();
			map.put("memberCode", memberCode);
			map.put("selLectCode", selLectCode);
			
			lecResultDAO.updateLecGradeYn(map);
			EgovMap lectMap = lecComDAO.SelectLectMap(selLectCode); //강의정보 조회
			request.getSession().setAttribute("lecSession", lectMap);//강의정보 세션 등록
			message = "성적 제출이 완료되었습니다.";
		}
		
		return redirectLecResultList(reda, message);
	}
}
