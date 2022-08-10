package lcms.usr.lec.myPage;

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
import lcms.valueObject.SemesterVO;
import lcms.valueObject.UsrVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class LecScheduleController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(LecScheduleController.class);
	
	@Autowired private LecScheduleDAO lecScheduleDAO;
	@Resource View jsonView;
	
	// 강사 - 강의시간표 목록
	@RequestMapping("/usr/lec/myPage/lecScheduleList.do")
	public String lecScheduleList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model, SemesterVO semesterVO) throws Exception {
		LOGGER.debug("/usr/lec/myPage/lecScheduleList.do - 강사 강의시간표 목록");
		request.getSession().setAttribute("lecMenuNo", "502");
		
		//세션값
		UsrVO usrVO = ((UsrVO)session.getAttribute("usrSession")!=null)?(UsrVO)session.getAttribute("usrSession"):null;
		searchVO.setSearchMemberCode(usrVO.getMemberCode());
		
		String lectSeq = (String) session.getAttribute("selLectCode");
		searchVO.setSearchLecture(lectSeq);
		
		String nowDate = EgovStringUtil.getDateMinus();
		searchVO.setSearchDate(nowDate);
		
		/**
		 * 1. 학기 정보 조회(년도) 
		 * 2. 학기 정보 조회(학기명)
		 * 2. 강의정보 조회
		 */
		/*학기 셀럭트 박스*/
		EgovMap semester = cmmDAO.selectOpenSeme();
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition5())){
			searchVO.setSearchCondition5((String) semester.get("semYear"));
			searchVO.setSearchCondition6((String) semester.get("semester"));
		}
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition5());
		model.addAttribute("semeList", semeList);
		
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO = lecScheduleDAO.LectList(searchVO); 
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
        
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("searchVO",searchVO);
		
		List<EgovMap> scheList = lecScheduleDAO.selectScheList(searchVO);
		model.addAttribute("scheList", scheList);
		
		List<EgovMap> clssRoomList = lecScheduleDAO.selectClssRoomList(searchVO);
		model.addAttribute("clssRoomList", clssRoomList);
		
		return "/usr/lec/myPage/lecScheduleList";
	}

	
	
	
}
