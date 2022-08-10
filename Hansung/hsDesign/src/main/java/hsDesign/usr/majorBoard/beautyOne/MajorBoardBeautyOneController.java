package hsDesign.usr.majorBoard.beautyOne;

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
public class MajorBoardBeautyOneController extends CmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(MajorBoardBeautyOneController.class);
	@Autowired private MajorBoardDAO majorBoardDAO;
	@Autowired private MajorBoardTeacherDAO teacherDAO;
	
		
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda) {
		reda.addFlashAttribute("message", message);
		reda.addFlashAttribute("searchVO", searchVO);
		return "redirect:/usr/majorBoard/beautyOneOne/majorBeautyOneOneList.do";
	}
	

	// 전공안내
	@RequestMapping("/usr/majorBoard/beautyOne/majorBeautyOneInfo.do")
	public String majorBeautyOneInfo(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) {
		LOGGER.info("/usr/majorBoard/beautyOne/majorBeautyOneInfo.do - 사용자 > 전공 > 미용학(one-day) > 전공안내");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// incLeft 메뉴
		session.setAttribute("menuNo", "10801");
		
		// incLeftMenu 
		model.addAttribute("bcList", selectBoardCodeList());
		
		// 롤링배너 목록
		model.addAttribute("bannerList", selectLeftBannerList());
		
		return "/usr/majorBoard/beautyOne/majorBeautyOneInfo";
	}
	
	// 교수소개
	@RequestMapping("/usr/majorBoard/beautyOne/majorBeautyOneTeacherList.do")
	public String majorBeautyOneTeacherList(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) {
		LOGGER.info("/usr/majorBoard/beautyOne/majorBeautyOneTeacherList.do - 사용자 > 전공 > 미용학(one-day) > 교수소개");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// incLeft 메뉴
		session.setAttribute("menuNo", "10802");
		searchVO.setMenuType("08");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = teacherDAO.selectTeacherList(searchVO);
		
		
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		// incLeftMenu 
		model.addAttribute("bcList", selectBoardCodeList());
		
		// 롤링배너 목록
		model.addAttribute("bannerList", selectLeftBannerList());
		
		return "/usr/majorBoard/beautyOne/majorBeautyOneTeacherList";
	}
	
	// 진출분야
	@RequestMapping("/usr/majorBoard/beautyOne/majorBeautyOneJobList.do")
	public String majorBeautyOneJobList(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) {
		LOGGER.info("/usr/majorBoard/beautyOne/majorBeautyOneJobList.do - 사용자 > 전공 > 미용학(one-day) > 진출분야");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// incLeft 메뉴
		session.setAttribute("menuNo", "10803");
		
		// incLeftMenu 
		model.addAttribute("bcList", selectBoardCodeList());
		
		// 롤링배너 목록
		model.addAttribute("bannerList", selectLeftBannerList());
		
		return "/usr/majorBoard/beautyOne/majorBeautyOneJobList";
	}
	
	// 교과과정
	@RequestMapping("/usr/majorBoard/beautyOne/majorBeautyOneCourse.do")
	public String majorBeautyOneCourse(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) {
		LOGGER.info("/usr/majorBoard/beautyOne/majorBeautyOneCourse.do - 사용자 > 전공 > 실내디자인 > 교과과정");
		LOGGER.debug("searchVO = "+searchVO.toString());
		// incLeft 메뉴
		session.setAttribute("menuNo", "10804");
				
		// incLeftMenu 
		model.addAttribute("bcList", selectBoardCodeList());
		
		// 롤링배너 목록
		model.addAttribute("bannerList", selectLeftBannerList());
		
		
		return "/usr/majorBoard/beautyOne/majorBeautyOneCourse";
	}
	
	// 목록
	@RequestMapping("/usr/majorBoard/beautyOne/majorBeautyOneList.do")
	public String majorBeautyOneList(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, String menuNo) {
		LOGGER.info("/usr/majorBoard/beautyOne/majorBeautyOneList.do - 사용자 > 전공관리 > 목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		
		// incLeft 메뉴
		session.setAttribute("menuNo", menuNo);
		searchVO.setMenuType("08");
		
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
		
		
		return "/usr/majorBoard/beautyOne/majorBeautyOneList";
	}
	
	
	// 조회
	@RequestMapping("/usr/majorBoard/beautyOne/majorBeautyOneView.do")
	public String MajorBeautyOneView(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, @RequestParam("mbSeq") String mbSeq, RedirectAttributes reda) {
		LOGGER.info("/usr/majorBoard/beautyOne/majorBeautyOneView.do - 사용자 > 전공 > 조회");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("mbSeq = "+mbSeq);
		
		
		MajorBoardVO resultVO = majorBoardDAO.selectMajorBoardOne(mbSeq);
		
		// incLeftMenu 
		model.addAttribute("bcList", selectBoardCodeList());
		
		if(resultVO == null) {
			String message = "게시글이 존재하지 않습니다.";
			return redirectListPage(message, searchVO, reda);
		}

		//	관련글
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
		
		return "/usr/majorBoard/beautyOne/majorBeautyOneView";
	}
		
	
	//이전글
	@Resource View jsonView;
	@RequestMapping("/usr/majorBoard/beautyOne/majorBeautyOnePreView.do")
	public View majorBeautyOnePreView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, String mbSeq, String mCode, String mbGubun1, String mbGubun2) throws Exception {
		LOGGER.info("/usr/majorBoard/beautyOne/majorBeautyOnePreView.do - 조회에서 이전글 불러오기");
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
