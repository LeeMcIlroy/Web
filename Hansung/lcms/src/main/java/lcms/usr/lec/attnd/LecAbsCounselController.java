package lcms.usr.lec.attnd;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

import component.excel.ExcelUtil;
import component.web.PaginationController;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import lcms.adm.cmm.AdmCmmController;
import lcms.valueObject.AbsentConsultVO;
import lcms.valueObject.UsrVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class LecAbsCounselController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(LecAbsCounselController.class);
	
	@Autowired private LecAbsCounselDAO lecAbsCounselDAO;
	@Resource View jsonView;
	
	// 강사 결석자상담 목록 리다이렉트
	private String redirectLecAttndList(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/usr/lec/attnd/lecAbsCounselList.do";
	}
	
	// 강사 결석자상담 목록
	@RequestMapping("/usr/lec/attnd/lecAbsCounselList.do")
	public String lecAbsCounselList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/attnd/lecAbsCounselList.do - 강사 결석자상담 목록");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("lecMenuNo", "302");
		
		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		searchVO.setSearchLecture(selLectCode);
		
		// 첫화면 로드 시 출석일자 세팅
		if(EgovStringUtil.isEmpty(searchVO.getStartDate())){
			searchVO.setStartDate(EgovStringUtil.getCurMonday());
			searchVO.setEndDate(EgovStringUtil.getCurFriday());
		}
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = lecAbsCounselDAO.selectLecAbsCounselList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/usr/lec/attnd/lecAbsCounselList";
	}
	
	// 강사 결석자상담 등록&수정 화면
	@RequestMapping("/usr/lec/attnd/lecAbsCounselModify.do")
	public String lecAbsCounselModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String attDate, String memberCode, String absentSeq, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/attnd/lecAbsCounselModify.do - 강사 결석자상담 등록&수정 화면");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("lecMenuNo", "302");
		
		AbsentConsultVO absentConsultVO = new AbsentConsultVO();
		
		if(!EgovStringUtil.isEmpty(absentSeq)){
			// 상담내용 조회
			absentConsultVO = lecAbsCounselDAO.selectLecAbsCounselModify(absentSeq);
		}else{
			String selLectCode = (String) request.getSession().getAttribute("selLectCode");
			
			EgovMap map = new EgovMap();
			map.put("attDate", attDate);
			map.put("memberCode", memberCode);
			map.put("lectSeq", selLectCode);
			// 학생 및 결석정보 조회
			absentConsultVO = lecAbsCounselDAO.selectLecAbsCounselNew(map);
		}
		
		if(EgovStringUtil.isEmpty(absentConsultVO.getFirstSelorCode())){
			UsrVO sessionVO = (UsrVO) request.getSession().getAttribute("usrSession");
			absentConsultVO.setFirstSelorCode(sessionVO.getMemberCode());
			absentConsultVO.setFirstSelorName(sessionVO.getName());
		}
		
		model.addAttribute("absentConsultVO", absentConsultVO);
		
		return "/usr/lec/attnd/lecAbsCounselModify";
	}

	// 강사 결석자상담 등록&수정
	@RequestMapping("/usr/lec/attnd/lecAbsCounselSubmit.do")
	public String lecAbsCounselSubmit(@ModelAttribute("absentConsultVO") AbsentConsultVO absentConsultVO, HttpSession session, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/usr/lec/attnd/lecAbsCounselSubmit.do - 강사 결석자상담 등록&수정");
		LOGGER.debug("absentConsultVO = " + absentConsultVO.toString());
		request.getSession().setAttribute("lecMenuNo", "302");
		String message = "";
		
		UsrVO sessionVO = (UsrVO) request.getSession().getAttribute("usrSession");
		absentConsultVO.setFirstSelorCode(sessionVO.getMemberCode());
		absentConsultVO.setFirstSelorName(sessionVO.getName());
		
		if(!EgovStringUtil.isEmpty(absentConsultVO.getAbsentSeq())){
			lecAbsCounselDAO.updateLecAbsCounselSubmit(absentConsultVO);
			message = "수정이 완료되었습니다.";
		}else{
			lecAbsCounselDAO.insertLecAbsCounselSubmit(absentConsultVO);
			message = "등록이 완료되었습니다.";
		}
		
		
		return redirectLecAttndList(reda, message);
	}
	

	// 교사 결석자상담 엑셀 다운로드
	@SuppressWarnings("unchecked")
	@RequestMapping("/usr/lec/attnd/lecAbsCounselExcel.do")
	public void lecAbsCounselExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes reda, ModelMap model
			, HttpSession session, UsrVO usrVO) throws Exception {
		LOGGER.debug("/usr/lec/attnd/lecAbsCounselExcel.do - 교사 결석자상담 엑셀 다운로드");
		LOGGER.debug("searchVO = " + searchVO.toString());
		LOGGER.debug("usrVO = " + usrVO.toString());
		searchVO.setSearchType("1");
		EgovMap dataMap = new EgovMap();

		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		searchVO.setSearchLecture(selLectCode);
		List<EgovMap> resultList = lecAbsCounselDAO.lecAbsCounselExcel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}

		UsrVO resultVO = (UsrVO)request.getSession().getAttribute("usrSession");
		dataMap.put("printUser", resultVO.getName());
		
		List<EgovMap> lectInfo = lecAbsCounselDAO.lecAbsCounselLect(searchVO);
		dataMap.put("lectGrade", lectInfo.get(0).get("lectGrade").toString());
		dataMap.put("lectDivi", lectInfo.get(0).get("lectDivi").toString());
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "결석자상담 리스트", "complAbsList", request, response);
	}
	
	
}
