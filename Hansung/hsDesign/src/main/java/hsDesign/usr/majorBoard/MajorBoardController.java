package hsDesign.usr.majorBoard;

import component.file.CmmnFileMngUtil;
import component.util.ComStringUtil;
import component.web.PaginationController;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import hsDesign.usr.cmm.CmmController;
import hsDesign.usr.cmmBoard.CmmBoardDAO;
import hsDesign.usr.majorBoard.MajorBoardController;
import hsDesign.usr.majorBoard.MajorBoardDAO;
import hsDesign.usr.majorBoard.MajorBoardTeacherDAO;
import hsDesign.valueObject.CmmBoardVO;
import hsDesign.valueObject.MajorBoardVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class MajorBoardController extends CmmController {
	private static final Logger LOGGER = LoggerFactory.getLogger(MajorBoardController.class);

	@Autowired
	private MajorBoardDAO majorBoardDAO;

	@Autowired
	private MajorBoardTeacherDAO teacherDAO;
	@Autowired 
	private CmmBoardDAO cmmBoardDAO;
	@Autowired 
	private CmmnFileMngUtil cmmnFileMngUtil;
	@Resource
	View jsonView;

	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda) {
		reda.addFlashAttribute("message", message);
		reda.addAttribute("menuType", searchVO.getMenuType());
		reda.addAttribute("pageIndex", Integer.valueOf(searchVO.getPageIndex()));
		if (!EgovStringUtil.isEmpty(searchVO.getSearchCondition1()))
			reda.addAttribute("searchCondition1", searchVO.getSearchCondition1());
		if (!EgovStringUtil.isEmpty(searchVO.getSearchWord()))
			reda.addAttribute("searchWord", searchVO.getSearchWord());
		return "redirect:/usr/majorBoard/{dept}/{jspPage}List.do";
	}

	@RequestMapping({ "/usr/majorBoard/{dept}/{jspPage}Info.do" })
	public String majorBoardInfo(@PathVariable("dept") String dept, @PathVariable("jspPage") String jspPage,
			ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) throws Exception {
		LOGGER.info("/usr/majorBoard/{}/{}Info.do - 사용자 전공 > 목록", dept, jspPage);
		LOGGER.debug("searchVO = {}", searchVO.toString());
		String menuNo = "";
		if ("interior".equals(dept)) {
			menuNo = "10101";
		} else if ("visual".equals(dept)) {
			menuNo = "10201";
		} else if ("industrial".equals(dept)) {
			menuNo = "10301";
		} else if ("digitalArt".equals(dept)) {
			menuNo = "10401";
		} else if ("digitalEnt".equals(dept)) {
			menuNo = "10901";
		} else if ("fassion".equals(dept)) {
			menuNo = "10501";
		} else if ("fbusiness".equals(dept)) {
			menuNo = "10601";
		} else if ("beauty".equals(dept)) {
			menuNo = "10701";
		} else if ("beautyOne".equals(dept)) {
			menuNo = "10801";
		}
		session.setAttribute("menuNo", menuNo);
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		return String.format("/usr/majorBoard/%s/%sInfo", new Object[] { dept, jspPage });
	}

	@RequestMapping({ "/usr/majorBoard/{dept}/{jspPage}TeacherList.do" })
	public String majorBoardTeacherList(@PathVariable("dept") String dept, @PathVariable("jspPage") String jspPage,
			ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) throws Exception {
		LOGGER.info("/usr/majorBoard/{}/{}TeacherList.do - 사용자 전공 > 교수소개", dept, jspPage);
		LOGGER.debug("searchVO = {}", searchVO.toString());
		String menuNo = "";
		if ("interior".equals(dept)) {
			menuNo = "10102";
			searchVO.setMenuType("01");
			if (searchVO.getSearchType() == "")
				searchVO.setSearchType("인테리어디자인");
		} else if ("visual".equals(dept)) {
			menuNo = "10202";
			searchVO.setMenuType("02");
			if (searchVO.getSearchType() == "")
				searchVO.setSearchType("시각 패키지디자이너");
		} else if ("industrial".equals(dept)) {
			menuNo = "10302";
			searchVO.setMenuType("03");
			if (searchVO.getSearchType() == "")
				searchVO.setSearchType("제품·리빙디자인");
		} else if ("digitalArt".equals(dept)) {
			menuNo = "10402";
			searchVO.setMenuType("04");
			if (searchVO.getSearchType() == "")
				searchVO.setSearchType("영상디자인");
		} else if ("digitalEnt".equals(dept)) {
			menuNo = "10902";
			searchVO.setMenuType("11");
			if (searchVO.getSearchType() == "")
				searchVO.setSearchType("방송크리에이터");
		} else if ("fassion".equals(dept)) {
			menuNo = "10502";
			searchVO.setMenuType("05");
			if (searchVO.getSearchType() == "")
				searchVO.setSearchType("패션디자인");
		} else if ("fbusiness".equals(dept)) {
			menuNo = "10602";
			searchVO.setMenuType("06");
		} else if ("beauty".equals(dept)) {
			menuNo = "10702";
			searchVO.setMenuType("07");
			if (searchVO.getSearchType() == "")
				searchVO.setSearchType("헤어디자인");
		} else if ("beautyOne".equals(dept)) {
			menuNo = "10802";
			searchVO.setMenuType("08");
			if (searchVO.getSearchType() == "")
				searchVO.setSearchType("헤어디자인");
		}
		session.setAttribute("menuNo", menuNo);
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = this.teacherDAO.selectTeacherList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		return String.format("/usr/majorBoard/%s/%sTeacherList", new Object[] { dept, jspPage });
	}

	@RequestMapping({ "/usr/majorBoard/{dept}/{jspPage}JobList.do" })
	public String majorBoardJobList(@PathVariable("dept") String dept, @PathVariable("jspPage") String jspPage,
			ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) throws Exception {
		LOGGER.info("/usr/majorBoard/{}/{}/{}.do - 사용자 전공 > 진출분야", dept, jspPage);
		LOGGER.debug("searchVO = {}", searchVO.toString());
		String menuNo = "";
		if ("interior".equals(dept)) {
			menuNo = "10103";
		} else if ("visual".equals(dept)) {
			menuNo = "10203";
		} else if ("industrial".equals(dept)) {
			menuNo = "10303";
		} else if ("digitalArt".equals(dept)) {
			menuNo = "10403";
		} else if ("digitalEnt".equals(dept)) {
			menuNo = "10903";
		} else if ("fassion".equals(dept)) {
			menuNo = "10503";
		} else if ("fbusiness".equals(dept)) {
			menuNo = "10603";
		} else if ("beauty".equals(dept)) {
			menuNo = "10703";
		} else if ("beautyOne".equals(dept)) {
			menuNo = "10803";
		}
		session.setAttribute("menuNo", menuNo);
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		return String.format("/usr/majorBoard/%s/%sJobList", new Object[] { dept, jspPage });
	}

	@RequestMapping({ "/usr/majorBoard/{dept}/{jspPage}Course.do" })
	public String majorInteriorCourse(@PathVariable("dept") String dept, @PathVariable("jspPage") String jspPage,
			ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) {
		LOGGER.info("/usr/majorBoard/{}/{}Course.do  - 사용자 > 전공 > 교과과정", dept, jspPage);
		LOGGER.debug("searchVO = " + searchVO.toString());
		String menuNo = "";
		if ("interior".equals(dept)) {
			menuNo = "10104";
		} else if ("visual".equals(dept)) {
			menuNo = "10204";
		} else if ("industrial".equals(dept)) {
			menuNo = "10304";
		} else if ("digitalArt".equals(dept)) {
			menuNo = "10404";
		} else if ("digitalEnt".equals(dept)) {
			menuNo = "10904";
		} else if ("fassion".equals(dept)) {
			menuNo = "10504";
		} else if ("fbusiness".equals(dept)) {
			menuNo = "10604";
		} else if ("beauty".equals(dept)) {
			menuNo = "10704";
		} else if ("beautyOne".equals(dept)) {
			menuNo = "10804";
		}
		session.setAttribute("menuNo", menuNo);
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		return String.format("/usr/majorBoard/%s/%sCourse", new Object[] { dept, jspPage });
	}

	@RequestMapping({ "/usr/majorBoard/{dept}/{jspPage}List.do" })
	public String majorBoardList(@PathVariable("dept") String dept, @PathVariable("jspPage") String jspPage,
			ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, String menuNo)
			throws Exception {
		LOGGER.info("/usr/majorBoard/{}/{}List.do - 사용자 전공 > 게시판 목록", dept, jspPage);
		LOGGER.debug("searchVO = {}", searchVO.toString());
		if ("interior".equals(dept)) {
			searchVO.setMenuType("01");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "10105";
		} else if ("visual".equals(dept)) {
			searchVO.setMenuType("02");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "10205";
		} else if ("industrial".equals(dept)) {
			searchVO.setMenuType("03");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "10305";
		} else if ("digitalArt".equals(dept)) {
			searchVO.setMenuType("04");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "10405";
		} else if ("digitalEnt".equals(dept)) {
			searchVO.setMenuType("11");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "10905";
		} else if ("fassion".equals(dept)) {
			searchVO.setMenuType("05");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "10505";
		} else if ("fbusiness".equals(dept)) {
			searchVO.setMenuType("06");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "10605";
		} else if ("beauty".equals(dept)) {
			searchVO.setMenuType("07");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "10705";
		} else if ("beautyOne".equals(dept)) {
			searchVO.setMenuType("08");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "10805";
		}
		session.setAttribute("menuNo", menuNo);
		String menuName = this.majorBoardDAO.selectMenuNameOne(searchVO.getSearchType());
		model.addAttribute("menuName", menuName);
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO, 10, 5);
		CmmnListVO listVO = this.majorBoardDAO.selectMajorBoardList(searchVO);
		List<EgovMap> menuList = this.majorBoardDAO.selectMajorHeadList(searchVO.getSearchType());
		model.addAttribute("menuList", menuList);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", replaceTag(listVO.getEgovList(), "mb"));
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		return String.format("/usr/majorBoard/%s/%sList", new Object[] { dept, jspPage });
	}

	@RequestMapping({ "/usr/majorBoard/{dept}/{jspPage}View.do" })
	public String majorBoardView(@PathVariable("dept") String dept, @PathVariable("jspPage") String jspPage,
			ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO,  CmmBoardVO cmmBoardVO,HttpSession session,
			@RequestParam("mbSeq") String mbSeq, RedirectAttributes reda, String menuNo) throws Exception {
		LOGGER.info("/usr/majorBoard/{}/{}View.do - 사용자 전공 > 게시판 목록", dept, jspPage);
		LOGGER.debug("searchVO = {}", searchVO.toString());
		if ("interior".equals(dept)) {
			searchVO.setMenuType("01");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "10105";
		} else if ("visual".equals(dept)) {
			searchVO.setMenuType("02");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "10205";
		} else if ("industrial".equals(dept)) {
			searchVO.setMenuType("03");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "10305";
		} else if ("digitalArt".equals(dept)) {
			searchVO.setMenuType("04");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "10405";
		} else if ("digitalEnt".equals(dept)) {
			searchVO.setMenuType("11");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "10905";
		} else if ("fassion".equals(dept)) {
			searchVO.setMenuType("05");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "10505";
		} else if ("fbusiness".equals(dept)) {
			searchVO.setMenuType("06");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "10605";
		} else if ("beauty".equals(dept)) {
			searchVO.setMenuType("07");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "10705";
		} else if ("beautyOne".equals(dept)) {
			searchVO.setMenuType("08");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "10805";
		}
		String menuName = this.majorBoardDAO.selectMenuNameOne(searchVO.getSearchType());
		model.addAttribute("menuName", menuName);
		session.setAttribute("menuNo", menuNo);
		LOGGER.debug("mbSeq = " + mbSeq);
		MajorBoardVO resultVO = this.majorBoardDAO.selectMajorBoardOne(mbSeq);
		if (resultVO == null) {
			String message = "게시글이 존재하지 않습니다.";
			return redirectListPage(message, searchVO, reda);
		}
		searchVO.setMenuType(resultVO.getmCode());
		searchVO.setSearchType(resultVO.getMbGubun1());
		searchVO.setSearchCondition4(mbSeq);
		int pageIndex = searchVO.getPageIndex();
		searchVO.setPageIndex(1);
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO, 4, 1);
		CmmnListVO listVO = this.majorBoardDAO.selectMajorBoardList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("recentList", listVO.getEgovList());
		searchVO.setPageIndex(pageIndex);
		resultVO.setMbContent(ComStringUtil.imgWidthHeightToMaxWidthHeight(resultVO.getMbContent()));
		model.addAttribute("resultVO", resultVO);
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		EgovMap cbUpfileList = majorBoardDAO.selectMajorBoardThumbList(mbSeq);
		model.addAttribute("cbUpfileList", cbUpfileList);

		
		
		return String.format("/usr/majorBoard/%s/%sView", new Object[] { dept, jspPage });
	}

	@RequestMapping({ "/usr/elite/elite.do" })
	public String Infoma(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session)
			throws Exception {
		LOGGER.info("/usr/elite/elite.do - 사용자 일학습엘리트과정이란?");
		LOGGER.debug("searchVO = {}", searchVO.toString());
		String menuNo = "2101";
		session.setAttribute("menuNo", menuNo);
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		return String.format("/usr/elite/elite", new Object[0]);
	}
	////---------------------------------------------------------------------------------------------------------------------------
	////---------------------------------------------------------------------------------------------------------------------------
	////--------------2+2본교연계과정---------------------------------------------------------------------------------------------
	
		//2+2본교연계과정?
	@RequestMapping("/usr/course/courseInfo.do")
	public String CourseInfo(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session)
								throws Exception{
		LOGGER.info("/usr/course/courseInfo.do - 사용자 일학습엘리트과정이란?");
		LOGGER.debug("searchVO = {}", searchVO.toString());
		
		String menuNo = "2400";
	
		session.setAttribute("menuNo", menuNo);
		
		// incLeftMenu 
		model.addAttribute("bcList", selectBoardCodeList());
		
		// 롤링배너 목록
		model.addAttribute("bannerList", selectLeftBannerList());
		
		return String.format("/usr/course/courseInfo");
	}

	
	@RequestMapping({ "/usr/elite/eliteProspect.do" })
	public String eliteProspect(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session)
			throws Exception {
		LOGGER.info("/usr/elite/eliteProspect.do - 사용자 모집요강");
		LOGGER.debug("searchVO = {}", searchVO.toString());
		String menuNo = "201";
		session.setAttribute("menuNo", menuNo);
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		return String.format("/usr/elite/eliteProspect", new Object[0]);
	}

	@RequestMapping({ "/usr/elite/{dept}/{jspPage}Info.do" })
	public String eliteInfo(@PathVariable("dept") String dept, @PathVariable("jspPage") String jspPage, ModelMap model,
			@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) throws Exception {
		LOGGER.info("/usr/elite/{}/{}Info.do - 사용자 전공 > 목록", dept, jspPage);
		LOGGER.debug("searchVO = {}", searchVO.toString());
		String menuNo = "";
		if ("interior".equals(dept)) {
			menuNo = "11001";
		} else if ("digitalArt".equals(dept)) {
			menuNo = "12001";
		} else if ("fbusiness".equals(dept)) {
			menuNo = "13001";
		} 
		
		if("eliteHair".equals(jspPage)){
			menuNo = "14010";
		}
		else if("eliteNato".equals(jspPage)){
			menuNo = "14011";
		}
		else if("eliteBeauty".equals(jspPage)){
			menuNo = "14001";
		}
		session.setAttribute("menuNo", menuNo);
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		return String.format("/usr/elite/%s/%sInfo", new Object[] { dept, jspPage });
	}

	@RequestMapping({ "/usr/elite/{dept}/{jspPage}TeacherList.do" })
	public String eliteTeacherList(@PathVariable("dept") String dept, @PathVariable("jspPage") String jspPage,
			ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) throws Exception {
		LOGGER.info("/usr/elite/{}/{}TeacherList.do - 사용자 전공 > 교수소개", dept, jspPage);
		LOGGER.debug("searchVO = {}", searchVO.toString());
		String menuNo = "";
		if ("interior".equals(dept)) {
			menuNo = "11002";
			searchVO.setMenuType("11");
		} else if ("digitalArt".equals(dept)) {
			menuNo = "12002";
			searchVO.setMenuType("12");
		} else if ("fbusiness".equals(dept)) {
			menuNo = "13002";
			searchVO.setMenuType("13");
		} else if ("beauty".equals(dept) && searchVO.getSearchType() == "하야시두피모발") {
			menuNo = "14002";
			searchVO.setMenuType("15");
		} else if ("beauty".equals(dept)) {
			menuNo = "14002";
			searchVO.setMenuType("14");
		}
		session.setAttribute("menuNo", menuNo);
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = this.teacherDAO.selectTeacherList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		return String.format("/usr/elite/%s/%sTeacherList", new Object[] { dept, jspPage });
	}

	@RequestMapping({ "/usr/elite/{dept}/{jspPage}JobList.do" })
	public String eliteJobList(@PathVariable("dept") String dept, @PathVariable("jspPage") String jspPage,
			ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) throws Exception {
		LOGGER.info("/usr/elite/{}/{}/{}.do - 사용자 전공 > 진출분야", dept, jspPage);
		LOGGER.debug("searchVO = {}", searchVO.toString());
		String menuNo = "";
		if ("interior".equals(dept)) {
			menuNo = "11003";
		} else if ("digitalArt".equals(dept)) {
			menuNo = "12003";
		} else if ("fbusiness".equals(dept)) {
			menuNo = "13003";
		} else if ("beauty".equals(dept)) {
			menuNo = "14003";
		}
		session.setAttribute("menuNo", menuNo);
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		return String.format("/usr/elite/%s/%sJobList", new Object[] { dept, jspPage });
	}

	@RequestMapping({ "/usr/elite/{dept}/{jspPage}Course.do" })
	public String eliteCourse(@PathVariable("dept") String dept, @PathVariable("jspPage") String jspPage,
			ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session) {
		LOGGER.info("/usr/elite/{}/{}Course.do  - 사용자 > 전공 > 교과과정", dept, jspPage);
		LOGGER.debug("searchVO = " + searchVO.toString());
		String menuNo = "";
		if ("interior".equals(dept)) {
			menuNo = "11003";
		} else if ("digitalArt".equals(dept)) {
			menuNo = "12003";
		} else if ("fbusiness".equals(dept)) {
			menuNo = "13003";
		} else if ("beauty".equals(dept)) {
			menuNo = "14003";
		}
		session.setAttribute("menuNo", menuNo);
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		return String.format("/usr/elite/%s/%sCourse", new Object[] { dept, jspPage });
	}

	@RequestMapping({ "/usr/elite/{dept}/{jspPage}List.do" })
	public String eliteList(@PathVariable("dept") String dept, @PathVariable("jspPage") String jspPage, ModelMap model,
			@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, String menuNo) throws Exception {
		LOGGER.info("/usr/elite/{}/{}List.do - 사용자 일학습엘리트과정 > 게시판 목록", dept, jspPage);
		LOGGER.debug("searchVO = {}", searchVO.toString());
		if ("interior".equals(dept)) {
			searchVO.setMenuType("11");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "11004";
		} else if ("digitalArt".equals(dept)) {
			searchVO.setMenuType("12");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "12004";
		} else if ("fbusiness".equals(dept)) {
			searchVO.setMenuType("13");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "13004";
		} else if ("beauty".equals(dept)) {
			searchVO.setMenuType("14");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "14004";
		}
		session.setAttribute("menuNo", menuNo);
		String menuName = this.majorBoardDAO.selectMenuNameOne(searchVO.getSearchType());
		model.addAttribute("menuName", menuName);
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO, 10, 5);
		CmmnListVO listVO = this.majorBoardDAO.selectMajorBoardList(searchVO);
		List<EgovMap> menuList = this.majorBoardDAO.selectMajorHeadList(searchVO.getSearchType());
		model.addAttribute("menuList", menuList);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", replaceTag(listVO.getEgovList(), "mb"));
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		return String.format("/usr/elite/%s/%sList", new Object[] { dept, jspPage });
	}

	@RequestMapping({ "/usr/elite/{dept}/{jspPage}View.do" })
	public String eliteView(@PathVariable("dept") String dept, @PathVariable("jspPage") String jspPage, ModelMap model,
			@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, @RequestParam("mbSeq") String mbSeq,
			RedirectAttributes reda, String menuNo) throws Exception {
		LOGGER.info("/usr/elite/{}/{}View.do - 사용자 일학습엘리트과정 > 게시판 목록", dept, jspPage);
		LOGGER.debug("searchVO = {}", searchVO.toString());
		if ("interior".equals(dept)) {
			searchVO.setMenuType("11");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "11005";
		} else if ("digitalArt".equals(dept)) {
			searchVO.setMenuType("12");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "12005";
		} else if ("fbusiness".equals(dept)) {
			searchVO.setMenuType("13");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "13005";
		} else if ("beauty".equals(dept)) {
			searchVO.setMenuType("14");
			if (EgovStringUtil.isEmpty(menuNo))
				menuNo = "14005";
		}
		String menuName = this.majorBoardDAO.selectMenuNameOne(searchVO.getSearchType());
		model.addAttribute("menuName", menuName);
		session.setAttribute("menuNo", menuNo);
		LOGGER.debug("mbSeq = " + mbSeq);
		MajorBoardVO resultVO = this.majorBoardDAO.selectMajorBoardOne(mbSeq);
		if (resultVO == null) {
			String message = "게시글이 존재하지 않습니다.";
			return redirectListPage(message, searchVO, reda);
		}
		searchVO.setMenuType(resultVO.getmCode());
		searchVO.setSearchType(resultVO.getMbGubun1());
		searchVO.setSearchCondition4(mbSeq);
		int pageIndex = searchVO.getPageIndex();
		searchVO.setPageIndex(1);
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO, 4, 1);
		CmmnListVO listVO = this.majorBoardDAO.selectMajorBoardList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("recentList", listVO.getEgovList());
		searchVO.setPageIndex(pageIndex);
		resultVO.setMbContent(ComStringUtil.imgWidthHeightToMaxWidthHeight(resultVO.getMbContent()));
		model.addAttribute("resultVO", resultVO);
		model.addAttribute("bcList", selectBoardCodeList());
		model.addAttribute("bannerList", selectLeftBannerList());
		return String.format("/usr/elite/%s/%sView", new Object[] { dept, jspPage });
	}

	@RequestMapping({ "/usr/majorBoard/interior/majorInteriorPreView.do" })
	public View majorInteriorPreView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, String mbSeq,
			String mCode, String mbGubun1, String mbGubun2) throws Exception {
		LOGGER.info("/usr/majorBoard/interior/majorInteriorPreView.do - 조회에서 이전글 불러오기");
		LOGGER.debug("mbSeq - " + mbSeq);
		MajorBoardVO majorBoardVO = new MajorBoardVO();
		majorBoardVO.setMbSeq(mbSeq);
		majorBoardVO.setmCode(mCode);
		majorBoardVO.setMbGubun1(mbGubun1);
		majorBoardVO.setMbGubun2(mbGubun2);
		MajorBoardVO resultVO = this.majorBoardDAO.selectMajorBoardPreOne(majorBoardVO);
		searchVO.setMenuType(mCode);
		searchVO.setSearchType(mbGubun1);
		searchVO.setSearchCondition3(mbGubun2);
		searchVO.setSearchCondition4(mbSeq);
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO, 4, 1);
		CmmnListVO listVO = this.majorBoardDAO.selectMajorBoardList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("recentList", listVO.getEgovList());
		model.addAttribute("majorBoardVO", resultVO);
		return this.jsonView;
	}
}
