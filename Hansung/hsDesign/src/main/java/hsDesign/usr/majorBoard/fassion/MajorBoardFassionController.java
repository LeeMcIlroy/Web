/*package hsDesign.usr.majorBoard.fassion;

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
public class MajorBoardFassionController extends CmmController{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(MajorBoardFassionController.class);
	@Autowired private MajorBoardDAO majorBoardDAO;
	@Autowired private MajorBoardTeacherDAO teacherDAO;
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda) {
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/usr/majorBoard/fassion/majorFassionList.do";
	}
	
	// 전공안내
	@RequestMapping("/usr/majorBoard/fassion/majorFassionInfo.do")
	public String majorFassionInfo(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) {
		LOGGER.info("/usr/majorBoard/fassion/majorFassionInfo.do - 사용자 > 전공 > 패션디자인 > 전공안내");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// incLeft 메뉴
		session.setAttribute("menuNo", "10501");
		
		// incLeftMenu 
		model.addAttribute("bcList", selectBoardCodeList());
		
		// 롤링배너 목록
		model.addAttribute("bannerList", selectLeftBannerList());
		
		return "/usr/majorBoard/fassion/majorFassionInfo";
	}
	
	// 교수소개
	@RequestMapping("/usr/majorBoard/fassion/majorFassionTeacherList.do")
	public String majorFassionTeacherList(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) {
		LOGGER.info("/usr/majorBoard/fassion/majorFassionTeacherList.do - 사용자 > 전공 > 패션디자인 > 교수소개");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// incLeft 메뉴
		session.setAttribute("menuNo", "10502");
		searchVO.setMenuType("05");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = teacherDAO.selectTeacherList(searchVO);
		
		
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		// incLeftMenu 
		model.addAttribute("bcList", selectBoardCodeList());
		
		// 롤링배너 목록
		model.addAttribute("bannerList", selectLeftBannerList());
		
		return "/usr/majorBoard/fassion/majorFassionTeacherList";
	}
	
	// 진출분야
	@RequestMapping("/usr/majorBoard/fassion/majorFassionJobList.do")
	public String majorFassionJobList(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) {
		LOGGER.info("/usr/majorBoard/fassion/majorFassionJobList.do - 사용자 > 전공 > 패션디자인 > 진출분야");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// incLeft 메뉴
		session.setAttribute("menuNo", "10503");
		
		// incLeftMenu 
		model.addAttribute("bcList", selectBoardCodeList());
		
		// 롤링배너 목록
		model.addAttribute("bannerList", selectLeftBannerList());
		
		return "/usr/majorBoard/fassion/majorFassionJobList";
	}
	
	// 교과과정
	@RequestMapping("/usr/majorBoard/fassion/majorFassionCourse.do")
	public String majorFassionCourse(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) {
		LOGGER.info("/usr/majorBoard/fassion/majorFassionCourse.do - 사용자 > 전공 > 실내디자인 > 교과과정");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// incLeft 메뉴
		session.setAttribute("menuNo", "10504");
				
		// incLeftMenu 
		model.addAttribute("bcList", selectBoardCodeList());
		
		// 롤링배너 목록
		model.addAttribute("bannerList", selectLeftBannerList());
		
		
		return "/usr/majorBoard/fassion/majorFassionCourse";
	}
	
	
	// 목록
	@RequestMapping("/usr/majorBoard/fassion/majorFassionList.do")
	public String majorFassionList(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, String menuNo) {
		LOGGER.info("/usr/majorBoard/fassion/majorFassionList.do - 사용자 > 전공관리 > 목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		
		// incLeft 메뉴
		session.setAttribute("menuNo", menuNo);
		searchVO.setMenuType("05");
		
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
		
		
		return "/usr/majorBoard/fassion/majorFassionList";
	}
	
	
	// 조회
	@RequestMapping("/usr/majorBoard/fassion/majorFassionView.do")
	public String MajorFassionView(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, @RequestParam("mbSeq") String mbSeq, RedirectAttributes reda) {
		LOGGER.info("/usr/majorBoard/fassion/majorFassionView.do - 사용자 > 전공 > 조회");
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
		
		return "/usr/majorBoard/fassion/majorFassionView";
	}
		
	//이전글
	@Resource View jsonView;
	@RequestMapping("/usr/majorBoard/fassion/majorFassionPreView.do")
	public View majorFassionPreView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, String mbSeq, String mCode, String mbGubun1, String mbGubun2) throws Exception {
		LOGGER.info("/usr/majorBoard/fassion/majorFassionPreView.do - 조회에서 이전글 불러오기");
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