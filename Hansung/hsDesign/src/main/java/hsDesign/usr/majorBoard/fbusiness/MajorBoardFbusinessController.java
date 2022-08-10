/*package hsDesign.usr.majorBoard.fbusiness;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.util.ComStringUtil;
import component.web.PaginationController;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import hsDesign.usr.cmm.CmmController;
import hsDesign.usr.majorBoard.MajorBoardDAO;
import hsDesign.usr.majorBoard.MajorBoardTeacherDAO;
import hsDesign.valueObject.MajorBoardVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class MajorBoardFbusinessController extends CmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(MajorBoardFbusinessController.class);
	@Autowired private MajorBoardDAO majorBoardDAO;
	@Autowired private MajorBoardTeacherDAO teacherDAO;
		
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda) {
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/usr/majorBoard/fbusiness/majorFbusinessList.do";
	}
	
	// 전공안내
	@RequestMapping("/usr/majorBoard/fbusiness/majorFbusinessInfo.do")
	public String majorFbusinessInfo(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) {
		LOGGER.info("/usr/majorBoard/fbusiness/majorFbusinessInfo.do - 사용자 > 전공 > 패션비즈니스 > 전공안내");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// incLeft 메뉴
		session.setAttribute("menuNo", "10601");
		
		// incLeftMenu 
		model.addAttribute("bcList", selectBoardCodeList());
		
		// 롤링배너 목록
		model.addAttribute("bannerList", selectLeftBannerList());
		
		return "/usr/majorBoard/fbusiness/majorFbusinessInfo";
	}
	
	// 교수소개
	@RequestMapping("/usr/majorBoard/fbusiness/majorFbusinessTeacherList.do")
	public String majorFbusinessTeacherList(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) {
		LOGGER.info("/usr/majorBoard/fbusiness/majorFbusinessTeacherList.do - 사용자 > 전공 > 패션비즈니스 > 교수소개");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// incLeft 메뉴
		session.setAttribute("menuNo", "10602");
		searchVO.setMenuType("06");
		

		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = teacherDAO.selectTeacherList(searchVO);
		
		
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		// incLeftMenu 
		model.addAttribute("bcList", selectBoardCodeList());
		
		// 롤링배너 목록
		model.addAttribute("bannerList", selectLeftBannerList());
		
		return "/usr/majorBoard/fbusiness/majorFbusinessTeacherList";
	}
	
	// 진출분야
	@RequestMapping("/usr/majorBoard/fbusiness/majorFbusinessJobList.do")
	public String majorFbusinessJobList(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) {
		LOGGER.info("/usr/majorBoard/fbusiness/majorFbusinessJobList.do - 사용자 > 전공 > 패션비즈니스 > 진출분야");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// incLeft 메뉴
		session.setAttribute("menuNo", "10603");
		
		// incLeftMenu 
		model.addAttribute("bcList", selectBoardCodeList());
		
		// 롤링배너 목록
		model.addAttribute("bannerList", selectLeftBannerList());
		
		return "/usr/majorBoard/fbusiness/majorFbusinessJobList";
	}
	
	// 교과과정
	@RequestMapping("/usr/majorBoard/fbusiness/majorFbusinessCourse.do")
	public String majorFbusinessCourse(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) {
		LOGGER.info("/usr/majorBoard/fbusiness/majorFbusinessCourse.do - 사용자 > 전공 > 실내디자인 > 교과과정");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// incLeft 메뉴
		session.setAttribute("menuNo", "10604");
				
		// incLeftMenu 
		model.addAttribute("bcList", selectBoardCodeList());
		
		// 롤링배너 목록
		model.addAttribute("bannerList", selectLeftBannerList());
		
		
		return "/usr/majorBoard/fbusiness/majorFbusinessCourse";
	}
	
	
	// 목록
	@RequestMapping("/usr/majorBoard/fbusiness/majorFbusinessList.do")
	public String majorFbusinessList(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, String menuNo) {
		LOGGER.info("/usr/majorBoard/fbusiness/majorFbusinessList.do - 사용자 > 전공관리 > 목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		
		// incLeft 메뉴
		session.setAttribute("menuNo", menuNo);
		searchVO.setMenuType("06");
		
		// incLeftMenu 
		model.addAttribute("bcList", selectBoardCodeList());
		
		// 메뉴명
		String menuName = majorBoardDAO.selectMenuNameOne(searchVO.getSearchType());	
		model.addAttribute("menuName", menuName);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO, 10, 5);
		CmmnListVO listVO = majorBoardDAO.selectMajorBoardList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		// 목록 태그 치환
		model.addAttribute("resultList", replaceTag(listVO.getEgovList(),"mb"));
		
		// 롤링배너 목록
		model.addAttribute("bannerList", selectLeftBannerList());		
		
		
		return "/usr/majorBoard/fbusiness/majorFbusinessList";
	}
	
	
	// 조회
	@RequestMapping("/usr/majorBoard/fbusiness/majorFbusinessView.do")
	public String MajorFbusinessView(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, @RequestParam("mbSeq") String mbSeq, RedirectAttributes reda) {
		LOGGER.info("/usr/majorBoard/fbusiness/majorFbusinessView.do - 사용자 > 전공 > 조회");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("mbSeq = "+mbSeq);
		
		
		MajorBoardVO resultVO = majorBoardDAO.selectMajorBoardOne(mbSeq);
		
		// incLeftMenu 
		model.addAttribute("bcList", selectBoardCodeList());
		
		if(resultVO == null) {
			String message = "게시글이 존재하지 않습니다.";
			return redirectListPage(message, searchVO, reda);
		}
		
		// 관련글
		searchVO.setMenuType(resultVO.getmCode());
		searchVO.setSearchType(resultVO.getMbGubun1());
		searchVO.setSearchCondition3(resultVO.getMbGubun2());
		searchVO.setSearchCondition4(mbSeq);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO,4,1);
		CmmnListVO listVO = majorBoardDAO.selectMajorBoardList(searchVO);
		
		
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("recentList", listVO.getEgovList());
		
		// 롤링배너 목록
		model.addAttribute("bannerList", selectLeftBannerList());
		
		resultVO.setMbContent(ComStringUtil.imgWidthHeightToMaxWidthHeight(resultVO.getMbContent()));	// style 제거
		model.addAttribute("resultVO", resultVO);
		
		return "/usr/majorBoard/fbusiness/majorFbusinessView";
	}
		

	//이전글
	@Resource View jsonView;
	@RequestMapping("/usr/majorBoard/fbusiness/majorFbusinessPreView.do")
	public View majorFbusinessPreView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, String mbSeq, String mCode, String mbGubun1, String mbGubun2) throws Exception {
		LOGGER.info("/usr/majorBoard/fbusiness/majorFbusinessPreView.do - 조회에서 이전글 불러오기");
		LOGGER.debug("mbSeq - "+mbSeq);
		
		MajorBoardVO majorBoardVO = new MajorBoardVO();
		
		majorBoardVO.setMbSeq(mbSeq);
		majorBoardVO.setmCode(mCode);
		majorBoardVO.setMbGubun1(mbGubun1);
		majorBoardVO.setMbGubun2(mbGubun2);
		
		
		MajorBoardVO resultVO = majorBoardDAO.selectMajorBoardPreOne(majorBoardVO);

			
		// 관련 글 4개
		searchVO.setMenuType(mCode);
		searchVO.setSearchType(mbGubun1);
		searchVO.setSearchCondition3(mbGubun2);
		searchVO.setSearchCondition4(mbSeq);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO,4,1);
		CmmnListVO listVO = majorBoardDAO.selectMajorBoardList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("recentList", listVO.getEgovList());
		
		model.addAttribute("majorBoardVO", resultVO);

		return jsonView;
	}
		
			
		

		
	
	
	
	
}
*/