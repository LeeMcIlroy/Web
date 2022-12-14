package lcms.adm.admstr;

import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.excel.ExcelUtil;
import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.web.PaginationController;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import lcms.adm.cmm.AdmCmmController;
import lcms.cmm.CmmDAO;
import lcms.valueObject.AdminVO;
import lcms.valueObject.AttachVO;
import lcms.valueObject.CertiVO;
import lcms.valueObject.DormVO;
import lcms.valueObject.MemberVO;
import lcms.valueObject.NoticeVO;
import lcms.valueObject.PrfSub1VO;
import lcms.valueObject.PrfSub2VO;
import lcms.valueObject.PrfSub3VO;
import lcms.valueObject.PrfSub4VO;
import lcms.valueObject.ScholarVO;
import lcms.valueObject.SemesterVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class AdmAdmstrController extends AdmCmmController {

	private static final Logger LOGGER = LoggerFactory.getLogger(AdmAdmstrController.class);
	@Autowired private AdmAdmstrDAO admAdmstrDAO;
	@Autowired private CmmDAO cmmDAO;
	@Resource private CmmnFileMngUtil fileUtil;
	@Resource private View jsonView;
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	
	// ?????? ????????????????????? ????????????????????????.
	private String redirectProfList(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/admstr/admProfList.do";
	}

	// ????????? ????????????????????? ????????????????????????.
	private String redirectCertiList(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/admstr/admCertiList.do";
	}

	// ********************************(??????) ????????? ????????? ????????????
	@RequestMapping("/qxsepmny/admstr/admCertiList.do")
	public String admCertiList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admCertiList.do - ????????? ????????? ????????????");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "501");
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition2())){
			EgovMap semester = cmmDAO.selectOpenSeme();
			
			searchVO.setSearchCondition2((String) semester.get("semYear"));
			searchVO.setSearchCondition3((String) semester.get("semester"));
		}
		
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition2());
		model.addAttribute("semeList", semeList);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admAdmstrDAO.selectAdmCertiList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/admstr/admCertiList";
	}

	// ????????? ????????? ????????????
	@RequestMapping("/qxsepmny/admstr/admCertiView.do")
	public String admCertiView(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String certiSeq, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admCertiView.do - ????????? ????????? ????????????");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "501");
		
		CertiVO certiVO = new CertiVO();
		
		if(!EgovStringUtil.isEmpty(certiSeq)){
			certiVO = admAdmstrDAO.selectAdmCertiView(certiSeq);
		}
		
		model.addAttribute("certiVO", certiVO);
		
		return "/adm/admstr/admCertiView";
	}
	
	// ????????? ????????? ???????????? ??????
	@RequestMapping("/qxsepmny/admstr/admAjaxSearchComplList.do")
	public View admAjaxSearchComplList(String memberCode, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admAjaxSearchComplList.do - ????????? ????????? ???????????? ??????");
		LOGGER.debug("memberCode = " + memberCode);
		
		List<EgovMap> resultList = admAdmstrDAO.selectAdmAjaxSearchComplList(memberCode);
		
		model.addAttribute("resultList", resultList);
		
		return jsonView;
	}

	// ????????? ????????? ???????????? ??????
	@RequestMapping("/qxsepmny/admstr/admAjaxCertiEtc.do")
	public View admAjaxCertiEtc(String certiSeq, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admAjaxCertiEtc.do - ????????? ????????? ???????????? ??????");
		LOGGER.debug("certiSeq = " + certiSeq);
		
		String certiEtc = admAdmstrDAO.selectAdmAjaxCertiEtc(certiSeq);
		
		model.addAttribute("certiEtc", certiEtc);
		
		return jsonView;
	}

	// ????????? ????????? ??????
	@RequestMapping("/qxsepmny/admstr/admCertiUpdate.do")
	public String admCertiUpdate(@ModelAttribute("certiVO") CertiVO certiVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admCertiUpdate.do - ????????? ????????? ??????");
		LOGGER.debug("certiVO = " + certiVO.toString());
		String message = "";
		
		if(!EgovStringUtil.isEmpty(certiVO.getCertiSeq())){
			admAdmstrDAO.updateAdmCerti(certiVO);
			message = "?????????????????????.";
		}else{
			String cnt = admAdmstrDAO.selectCertiNumCnt(certiVO);
			String certiNum = certiVO.getSemYear() + "-" + certiVO.getCertiType() + "-" + cnt;
			certiVO.setCertiNum(certiNum);
			admAdmstrDAO.insertAdmCerti(certiVO);
			message = "?????????????????????.";
		}
		
		return redirectCertiList(reda, message);
	}

	// ????????? ????????? ?????? ??????
	@RequestMapping("/qxsepmny/admstr/admCertiPop.do")
	public String admCertiPop(String certiSeq, String lectYear, String lectSem, String prtType, String[] mapSeq, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admCertiPop.do - ????????? ????????? ?????? ??????");
		LOGGER.debug("certiSeq = " + certiSeq);
		
		if(!EgovStringUtil.isEmpty(prtType)){
			EgovMap map = new EgovMap();
			map.put("lectYear", lectYear);
			map.put("lectSem", lectSem);
			map.put("mapSeq", mapSeq);
			map.put("certiType", "3");
			
			if("GRADE".equals(prtType)){
				map.put("certiType", "2");
				certiSeq = admAdmstrDAO.insertAdmCertiList(map);
			}else{
				certiSeq = admAdmstrDAO.insertAdmCertiList(map);
				if("ALL".equals(prtType)){
					map.put("certiType", "2");
					admAdmstrDAO.insertAdmCertiList(map);
				}
			}
			List<EgovMap> resultList = admAdmstrDAO.selectAdmPopCertiList(certiSeq);
			
			model.addAttribute("resultList", resultList);
		}else{
			CertiVO certiVO = admAdmstrDAO.selectAdmCertiView(certiSeq);
			EgovMap resultMap = new EgovMap();
			
			if("1".equals(certiVO.getCertiType())){
				resultMap = admAdmstrDAO.selectAdmPopStdShip(certiVO);
			}else if("2".equals(certiVO.getCertiType())){
				resultMap = admAdmstrDAO.selectAdmPopGradeCard(certiVO);
			}else if("3".equals(certiVO.getCertiType())){
				resultMap = admAdmstrDAO.selectAdmPopCertification(certiVO);
			}else if("4".equals(certiVO.getCertiType())){
				resultMap = admAdmstrDAO.selectAdmPopTuition(certiVO);
			}else if("5".equals(certiVO.getCertiType())){
				List<EgovMap> resultList = admAdmstrDAO.selectAdmPopStdShipList(certiVO);
				model.addAttribute("resultList", resultList);
			}else if("6".equals(certiVO.getCertiType())){
				resultMap = admAdmstrDAO.selectAdmPopGradeCardAll(certiVO);
				
				List<EgovMap> resultList = admAdmstrDAO.selectAdmPopGradeCardList(certiVO);
				model.addAttribute("resultList", resultList);
			}
			
			model.addAttribute("certiVO", certiVO);
			model.addAttribute("resultMap", resultMap);
		}
		
		model.addAttribute("prtType", prtType);
		
		return "/adm/admstr/admCertiPop";
	}
	
	// ?????? ????????????????????? ????????????????????????.
	private String redirectScholarList(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/admstr/admScholarList.do";
	}

	// ????????? ??????/?????? ????????????
	@RequestMapping("/qxsepmny/admstr/admScholarList.do")
	public String admScholarList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admScholarList.do - ????????? ??????/?????? ????????????");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "502");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admAdmstrDAO.selectAdmScholarList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/admstr/admScholarList";
	}

	// ????????? ??????/?????? ??????
	@RequestMapping("/qxsepmny/admstr/admScholarPop.do")
	public String admScholarPop(String scholarSeq, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admScholarPop.do - ????????? ??????/?????? ??????");
		LOGGER.debug("scholarSeq = " + scholarSeq);
		
		EgovMap resultMap = admAdmstrDAO.selectAdmScholarPop(scholarSeq);
		model.addAttribute("resultMap", resultMap);
		
		return "/adm/admstr/admScholarPop";
	}

	// ????????? ??????/?????? ?????? ?????? ????????????
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/admstr/admScholarExcel.do")
	public void admScholarExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admScholarExcel.do - ????????? ??????/?????? ?????? ?????? ????????????");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = admAdmstrDAO.selectAdmScholarExcel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName());
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "??????/?????? ?????????", "scholarList", request, response);
	}

	// ??????????????? ??????/?????? ??????&????????????
	@RequestMapping("/qxsepmny/admstr/admScholarModify.do")
	public String admScholarModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String scholarSeq, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admScholarModify.do - ??????????????? ??????/?????? ??????&????????????");
		LOGGER.debug("scholarSeq = " + scholarSeq);
		request.getSession().setAttribute("admMenuNo", "502");
		
		ScholarVO scholarVO = new ScholarVO();
		
		if(!EgovStringUtil.isEmpty(scholarSeq)){
			scholarVO = admAdmstrDAO.selectAdmScholarModify(scholarSeq);
		}
		model.addAttribute("scholarVO", scholarVO);
		
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		
		if(EgovStringUtil.isEmpty(scholarVO.getYear())){
			scholarVO.setYear(yearList.get(0));
		}
		
		List<EgovMap> semeList = cmmDAO.selectSemeList(scholarVO.getYear());
		model.addAttribute("semeList", semeList);
		
		return "/adm/admstr/admScholarModify";
	}

	// ??????????????? ??????/?????? ??????&??????
	@RequestMapping("/qxsepmny/admstr/admScholarSubmit.do")
	public String admScholarSubmit(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ScholarVO scholarVO, RedirectAttributes reda, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admScholarSubmit.do - ??????????????? ??????/?????? ??????&??????");
		LOGGER.debug("scholarVO = " + scholarVO.toString());
		request.getSession().setAttribute("admMenuNo", "502");
		String message = "";
		
		if(!EgovStringUtil.isEmpty(scholarVO.getScholarSeq())){
			String num = admAdmstrDAO.selectAdmScholarNum(scholarVO);
			char type = (char) (Integer.parseInt(scholarVO.getScholarType())+64);
			
			String scholarNum = scholarVO.getYear() + scholarVO.getSemester() + "-" + type + "-" + num;
			scholarVO.setScholarNum(scholarNum);
			
			admAdmstrDAO.updateAdmScholar(scholarVO);
			message = "????????? ?????????????????????.";
		}else{
			String num = admAdmstrDAO.selectAdmScholarNum(scholarVO);
			char type = (char) (Integer.parseInt(scholarVO.getScholarType())+64);
			
			String scholarNum = scholarVO.getYear() + scholarVO.getSemester()  + "-" + type + "-" + num;
			scholarVO.setScholarNum(scholarNum);
			
			admAdmstrDAO.insertAdmScholar(scholarVO);
			message = "????????? ?????????????????????.";
		}
		
		return redirectScholarList(reda, message);
	}

	// ********************************(??????)????????? ????????? ????????????********************************
	// ????????? ??????
	@RequestMapping("/qxsepmny/admstr/admDormList.do")
	public String admDormList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, MemberVO memberVO ,HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admDormList.do - ????????? ????????? ????????????");
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition5())){
			EgovMap semester = cmmDAO.selectRegiSeme();
			searchVO.setSearchCondition5((String) semester.get("semYear"));
			searchVO.setSearchCondition6((String) semester.get("semester"));
		}
	
		// admMenuNo ?????????????????? 503
		request.getSession().setAttribute("admMenuNo", "503");
       PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO = admAdmstrDAO.selectAdmDormList(searchVO);
		
		
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("searchVO",searchVO);
		
		
		 /*
		  * TB_LCMS_SEME?????? ?????? ?????????
		 ????????? ????????? year??? ????????? ?????? ?????? ?????????
		 ?????? ???????????? ?????? ?????? ????????? group by?????? ????????????.
		 */
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition5());
		model.addAttribute("semeList", semeList);
		
		
		return "/adm/admstr/admDormList";
	}

	// ????????? ?????? ????????????
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/admstr/admDormExcel.do")
	public void admDormExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, MemberVO memberVO ,HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admDormExcel.do - ????????? ????????? ?????? ????????????");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = admAdmstrDAO.selectAdmDormExcel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName());
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "????????? ?????????", "dormList", request, response);
	}
	
	// ????????? ?????? ?????????
	@RequestMapping("/qxsepmny/admstr/admDormRegistView.do")
	public String admDormRegistView(HttpServletRequest request,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admDormRegistView.do - ????????? ????????? ????????????");
		
		// admMenuNo ?????????????????? 503
		request.getSession().setAttribute("admMenuNo", "503");
		
		EgovMap semester = cmmDAO.selectRegiSeme();
		model.addAttribute("semester", semester);
		
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		List<EgovMap> semeList = cmmDAO.selectSemeList(yearList.get(0));
		model.addAttribute("semeList", semeList);
		
		return "/adm/admstr/admDormRegist";
	}
	
	// ????????? ????????? ?????? & ???????????? ???????????? 20200309
	@RequestMapping("/qxsepmny/admstr/admDormRegist.do")
	public String admDormRegist(@RequestParam(value="menuType") String menuType, String deleteYn ,@ModelAttribute DormVO dormVO,MemberVO memberVO,MultipartHttpServletRequest request,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admDormRegist.do - ????????? ????????? ????????????");
		
		// admMenuNo ?????????????????? 503
		request.getSession().setAttribute("admMenuNo", "503");
		
		
		
		//  ************* insert regist ?????? + ?????? 20200309*************
		if (menuType.equals("dormInsert")) {
		
			//????????? ????????????
			String dormListCnt = admAdmstrDAO.selectDormRecepNum(dormVO);
			String dormRecepNum = dormVO.getSemYear()+"-"+dormVO.getSemEster()+"-"+dormListCnt;
			dormVO.setDormRecepNum(dormRecepNum);
	
			// ?????? ???????????? ????????? ????????? 
			memberVO = admAdmstrDAO.selectStudents(memberVO);
			dormVO.setMemCode(memberVO.getMemberCode());
			dormVO.setDormSeq(admAdmstrDAO.insertAdmDormRegist(dormVO));
			
		List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "DORM");
		if(fileInfoList != null){
			for(FileInfoVO fileInfoVO : fileInfoList){
				AttachVO attachVO = new AttachVO(fileInfoVO);
				attachVO.setBoardType("DORM");										
				attachVO.setBoardSeq(dormVO.getDormSeq());
				cmmDAO.insertAttachFile(attachVO);
			}
		}
	
		}
		// ************* update view ????????????  + ?????? 20200309*************
		else if (menuType.equals("dormUpdate")) {
			
			admAdmstrDAO.updateAdmDormRegist(dormVO);
			/*
		FileInfoVO fileInfoVO = fileUtil.uploadAttachedFile(multiRequest, "DORM",dormVO.getDormSeq());
			
		if(fileInfoVO != null){
				AttachVO attachVO = new AttachVO(fileInfoVO);
				attachVO.setBoardType("DORM");
				attachVO.setBoardSeq(dormVO.getDormSeq());
				
				if("Y".equals(deleteYn)){
					fileUtil.deleteFile("");
				}
				
				cmmDAO.insertAttachFile(attachVO);
			}*/
			
		}
		return "redirect:/qxsepmny/admstr/admDormList.do";
	}
	
	
	// rowclick ????????? ????????????
	@RequestMapping("/qxsepmny/admstr/admDormView.do")
	public String admDormView(@ModelAttribute DormVO dormVO,HttpServletRequest request,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admDormView.do - ????????? ????????? ??????????????????");
		
		// admMenuNo ?????????????????? 503
		request.getSession().setAttribute("admMenuNo", "503");
		
		// ????????? 1??? ????????? ??????
		dormVO = admAdmstrDAO.selectAdmDormListOne(dormVO.getDormSeq());
		model.addAttribute("result",dormVO);
		
		EgovMap map = new EgovMap();
		map.put("boardSeq", dormVO.getDormSeq());
		map.put("boardType", "DORM");
		
		//???????????? ????????? ??????
		List<AttachVO> attachList = cmmDAO.selectAttachList(map);
		model.addAttribute("attachList", attachList);
		
		return "/adm/admstr/admDormView";
	}
	
	@RequestMapping("/qxsepmny/admstr/findStudents.do")
	public View findStudents(MemberVO memberVO,DormVO dormVO, HttpServletRequest request,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/findStudents.do - ????????? ????????? ??????????????????");
		
		String message = "";
		
		//?????? ????????? ????????????.
		List<MemberVO> resultList = admAdmstrDAO.selectStudentList(memberVO);
		
		if (EgovStringUtil.isEmpty(dormVO.getRenewGubun())) {
			 model.addAttribute("resultList",resultList);
		} else {
		   EgovMap nowDorm = admAdmstrDAO.selectNowResiDorm(memberVO.getMemberCode());
		   model.addAttribute("dormVO",nowDorm);
		   message = "?????? ?????? ???????????? ?????????????????????.";
		}
		model.addAttribute("message",message);
	   
		return jsonView;
	}
	
	@RequestMapping("/qxsepmny/admstr/findResidenceDate.do")
	public View findResidenceDate( SemesterVO semesterVO , DormVO dormVO, HttpServletRequest request,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/findResidenceDate.do - ????????? ???????????? ??????????????????");
	
		semesterVO = admAdmstrDAO.findResidenceDate(semesterVO);
		model.addAttribute("residenceDate", semesterVO);
	   
		return jsonView;
	}

	// ********************************(??????)????????? ?????? ????????????********************************
	@RequestMapping("/qxsepmny/admstr/admProfList.do")
	public String admProfList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admProfList.do - ????????? ?????? ????????????");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "504");
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition1())){
			searchVO.setSearchCondition1("??????");
		}
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admAdmstrDAO.selectAdmProfList(searchVO);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchCondition3())){
			searchVO.setSearchCondition3(yearList.get(0));
		}
		
		List<EgovMap> semeList = cmmDAO.selectSemeList(searchVO.getSearchCondition3());
		model.addAttribute("semeList", semeList);
		
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/adm/admstr/admProfList";
	}
	//????????? ?????? ??????
	@RequestMapping("/qxsepmny/admstr/admAjaxProfSearch.do")
	public View admAjaxProfSearch(String year,String seme,HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admAjaxProfSearch.do - ????????? ?????? ?????? ??????");
		
		EgovMap map = new EgovMap();
		map.put("year", year);
		map.put("seme", seme);
		
		List<EgovMap> profList = admAdmstrDAO.admAjaxProfSearch(map);
		model.addAttribute("profList", profList);
		
		return jsonView;
	}
	// ??????????????? ?????? ??????????????????
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/admstr/admProfExcel.do")
	public void admProfExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admProfExcel.do - ????????? ?????? ??????????????????");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "504");
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = admAdmstrDAO.selectAdmProfExcel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName());
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "?????? ?????????", "profList", request, response);
		
	}

	// ??????????????? ?????? ??????????????????
	@RequestMapping("/qxsepmny/admstr/admAjaxProfDel.do")
	public View admAjaxProfDel(String[] memberCode, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admAjaxProfDel.do - ????????? ?????? ??????");
		LOGGER.debug("memberCode = " + memberCode);
		request.getSession().setAttribute("admMenuNo", "504");
		String status = "true";
		
		for(String mCode : memberCode){
			int cnt = admAdmstrDAO.selectAdmAjaxProfDelChk(mCode);
			if(cnt > 0){
				status = "false";
				break;
			}
		}
		
		if(!"false".equals(status)){
			EgovMap map = new EgovMap();
			map.put("memberCode", memberCode);
			admAdmstrDAO.deleteAdmAjaxProfDel(map);
		}
		
		model.addAttribute("status", status);
		
		return jsonView;
	}
	// ????????? ???????????? ?????? ??????
		@RequestMapping("/qxsepmny/admstr/prfPrtPop.do")
		public String admCertiPop(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String prtType, HttpServletRequest request, ModelMap model, String memberCode
				, String seq, String year, String seme) throws Exception {
			LOGGER.debug("/qxsepmny/admstr/prfPrtPop.do - ????????? ???????????? ?????? ??????");
			LOGGER.debug("searchVO = " + searchVO.toString());
			request.getSession().setAttribute("admMenuNo", "504");
			
			if("PRFLIST".equals(prtType)){
				EgovMap map = new EgovMap();
				map.put("year", year);
				map.put("seme", seme);
				
				List<EgovMap> resultList = admAdmstrDAO.selectAdmPopProfList(map);
				model.addAttribute("resultList", resultList);

				List<EgovMap> semList = admAdmstrDAO.selectAdmPopSeme(map);
				model.addAttribute("semList", semList);

			}else if("RETIR".equals(prtType)){//???????????????
				EgovMap map = new EgovMap();
				map.put("memberCode", memberCode);
				map.put("seq", seq);
				List<EgovMap> resultList = admAdmstrDAO.selectAdmPopRetirement(map);
				model.addAttribute("resultList", resultList);
				List<EgovMap> listVO = admAdmstrDAO.admAjaxProfSubTab1(memberCode); 
				model.addAttribute("appoList", listVO);
			}
			
			model.addAttribute("prtType", prtType);
			 
			return "/adm/admstr/prof/admPrfListPop";
		}
	// ????????? ?????? ??????&?????? ??????
	@RequestMapping("/qxsepmny/admstr/admProfModify.do")
	public String admProfModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, String memberSeq, HttpServletRequest request, ModelMap model, String prfYear, String prfSem) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admProfModify.do - ????????? ?????? ??????&?????? ??????");
		LOGGER.debug("searchVO = " + searchVO.toString());
		request.getSession().setAttribute("admMenuNo", "504");
		MemberVO memberVO = new MemberVO();
		PrfSub1VO prfSub1VO = new PrfSub1VO();
		List<String> yearList = cmmDAO.selectYearList();
		model.addAttribute("yearList", yearList);
		
		String year = "";
		if(!EgovStringUtil.isEmpty(prfSub1VO.getprfFYear())){
			year = prfSub1VO.getprfFYear();
		}else{
			year = yearList.get(0);
		}
		List<EgovMap> semeList = cmmDAO.selectSemeList(year);
		model.addAttribute("semeList", semeList);
		
		String seme = "";
		if(!EgovStringUtil.isEmpty(prfSub1VO.getprfFSem())){
			seme = prfSub1VO.getprfFSem();
		}else if(semeList.size() > 0){
			seme = semeList.get(0).get("semester").toString();
		}
		
		EgovMap map = new EgovMap();
		map.put("year", year);
		map.put("seme", seme);
		List<EgovMap> lectNameList = admAdmstrDAO.admAjaxLectName(map);
		model.addAttribute("lectNameList", lectNameList);
		
		String grade = "";
		if(!EgovStringUtil.isEmpty(prfSub1VO.getprfFGrade())){
			grade = prfSub1VO.getprfFGrade();
		}else if(lectNameList.size() > 0){
			grade = lectNameList.get(0).get("lectName").toString();
		}
		List<EgovMap> diviList = cmmDAO.selectDiviList(grade);
		model.addAttribute("diviList", diviList);
		
		if(!EgovStringUtil.isEmpty(memberSeq)){
			memberVO = admAdmstrDAO.selectAdmMember(memberSeq);
		}
		List<EgovMap> subList = admAdmstrDAO.selectSubTabList(memberSeq);
		model.addAttribute("subList", subList);

		model.addAttribute("memberVO", memberVO);
		model.addAttribute("searchVO", searchVO);
		
		return "/adm/admstr/admProfModify";
	}
	// ????????? ?????? ?????????1
	@RequestMapping("/qxsepmny/admstr/admAjaxProfSubTab1.do")
	public View admAjaxProfSubTab1(String memberCode, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admAjaxProfSubTab1.do - ????????? ?????? ?????????1");
		
		List<EgovMap> listVO = admAdmstrDAO.admAjaxProfSubTab1(memberCode); 
		model.addAttribute("resultList", listVO);
		
		return jsonView;
	}
	// ????????? ?????? ?????????2
	@RequestMapping("/qxsepmny/admstr/admAjaxProfSubTab2.do")
	public View admAjaxProfSubTab2(String memberCode, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admAjaxProfSubTab2.do - ????????? ?????? ?????????2");
		
		List<EgovMap> listVO = admAdmstrDAO.admAjaxProfSubTab2(memberCode); 
		model.addAttribute("resultList", listVO);
		
		return jsonView;
	}
	// ????????? ?????? ?????????3
	@RequestMapping("/qxsepmny/admstr/admAjaxProfSubTab3.do")
	public View admAjaxProfSubTab3(String memberCode, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admAjaxProfSubTab3.do - ????????? ?????? ?????????3");
		
		List<EgovMap> listVO = admAdmstrDAO.admAjaxProfSubTab3(memberCode); 
		model.addAttribute("resultList", listVO);
		
		return jsonView;
	}
	// ????????? ?????? ?????????4
	@RequestMapping("/qxsepmny/admstr/admAjaxProfSubTab4.do")
	public View admAjaxProfSubTab4(String memberCode, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admAjaxProfSubTab4.do - ????????? ?????? ?????????4");
		
		List<EgovMap> listVO = admAdmstrDAO.admAjaxProfSubTab4(memberCode); 
		model.addAttribute("resultList", listVO);
		
		return jsonView;
	}
	// ????????? ?????? ????????? selected
	@RequestMapping("/qxsepmny/admstr/admAjaxProfSubTab1One.do")
	public View admAjaxProfSubTab1One(String memberCode, String seq, String type, HttpServletRequest request, ModelMap model
			, PrfSub1VO sub1vo, PrfSub2VO sub2vo, PrfSub3VO sub3vo, PrfSub4VO sub4vo) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admAjaxProfSubTab1One.do - ????????? ?????? ?????????1");
		
		if(type.equals("F")){
			sub1vo = admAdmstrDAO.admAjaxProfSubTab1SelectOne(seq);
			model.addAttribute("resultList", sub1vo);
		}else if(type.equals("S")){
			sub2vo = admAdmstrDAO.admAjaxProfSubTab2SelectOne(seq);
			model.addAttribute("resultList", sub2vo);
		}else if(type.equals("T")){
			sub3vo = admAdmstrDAO.admAjaxProfSubTab3SelectOne(seq);
			model.addAttribute("resultList", sub3vo);
		}else if(type.equals("P")){
			sub4vo = admAdmstrDAO.admAjaxProfSubTab4SelectOne(seq);
			model.addAttribute("resultList", sub4vo);
		} 
		return jsonView;
	}
	// ????????? ?????? ?????????1 ??????
	@RequestMapping("/qxsepmny/admstr/admAjaxProfSubSave1.do")
	public View admAjaxProfSubSave1( HttpServletRequest request, RedirectAttributes reda, ModelMap model
			,String prfFSeq,String prfFYear,String prfFSem,String prfFSDate,String prfFEDate,String prfFHour,String prfFGrade,String prfFGubun, String memberCode) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admAjaxProfSubSave1.do - ????????? ?????? ?????????1 ??????");
		EgovMap map = new EgovMap();
		map.put("prfFSeq", prfFSeq);
		map.put("prfFYear", prfFYear);
		map.put("prfFSem", prfFSem);
		map.put("prfFSDate", prfFSDate);
		map.put("prfFEDate", prfFEDate);
		map.put("prfFHour", prfFHour);
		map.put("prfFGrade", prfFGrade);
		map.put("prfFGubun", prfFGubun);
		map.put("memberCode", memberCode);
		
		if(prfFSeq == null || prfFSeq == ""){
			admAdmstrDAO.admAjaxProfSubSave1(map); 
		}else{
			admAdmstrDAO.admAjaxProfSubUpdate1(map);
		}
		
		List<EgovMap> listVO = admAdmstrDAO.admAjaxProfSubTab1(memberCode); 
		model.addAttribute("resultList", listVO);
		
		return jsonView;
	}
	// ????????? ?????? ?????????2 ??????
	@RequestMapping("/qxsepmny/admstr/admAjaxProfSubSave2.do")
	public View admAjaxProfSubSave2( HttpServletRequest request, RedirectAttributes reda, ModelMap model
			,String prfSSeq ,String prfSYear,String prfSSem,String prfSStep,String prfSDivi,String prfSSDate,String prfSEDate,String prfSPosition,String memberCode) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admAjaxProfSubSave2.do - ????????? ?????? ?????????2 ??????");
		EgovMap map = new EgovMap();
		map.put("prfSSeq", prfSSeq);
		map.put("prfSYear", prfSYear);
		map.put("prfSSem", prfSSem);
		map.put("prfSStep", prfSStep);
		map.put("prfSDivi", prfSDivi);
		map.put("prfSSDate", prfSSDate);
		map.put("prfSEDate", prfSEDate);
		map.put("prfSPosition", prfSPosition);
		map.put("memberCode", memberCode);
		

		if(prfSSeq == null || prfSSeq == ""){
			admAdmstrDAO.admAjaxProfSubSave2(map); 
		}else{
			admAdmstrDAO.admAjaxProfSubUpdate2(map);
		}
		
		List<EgovMap> listVO = admAdmstrDAO.admAjaxProfSubTab2(memberCode); 
		model.addAttribute("resultList", listVO);
		
		return jsonView;
	}
	// ????????? ?????? ?????????3 ??????
	@RequestMapping("/qxsepmny/admstr/admAjaxProfSubSave3.do")
	public View admAjaxProfSubSave3( HttpServletRequest request, RedirectAttributes reda, ModelMap model
			,String prfTSeq,String prfTYear,String prfTSem,String prfTAnnoDate,String prfTBelong,String prfTPosition,String memberCode) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admAjaxProfSubSave3.do - ????????? ?????? ?????????3 ??????");
		EgovMap map = new EgovMap();
		map.put("prfTSeq", prfTSeq);
		map.put("prfTYear", prfTYear);
		map.put("prfTSem", prfTSem);
		map.put("prfTAnnoDate", prfTAnnoDate);
		map.put("prfTBelong", prfTBelong);
		map.put("prfTPosition", prfTPosition);
		map.put("memberCode", memberCode);

		if(prfTSeq == null || prfTSeq == ""){
			admAdmstrDAO.admAjaxProfSubSave3(map); 
		}else{
			admAdmstrDAO.admAjaxProfSubUpdate3(map);
		}
		
		List<EgovMap> listVO = admAdmstrDAO.admAjaxProfSubTab3(memberCode); 
		model.addAttribute("resultList", listVO);
		
		return jsonView;
	}
	// ????????? ?????? ?????????4 ??????
	@RequestMapping("/qxsepmny/admstr/admAjaxProfSubSave4.do")
	public View admAjaxProfSubSave4( HttpServletRequest request, RedirectAttributes reda, ModelMap model
			,String prfPSeq,String prfPCerti,String prfPIncidental,String prfPCauseIssue,String memberCode) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admAjaxProfSubSave4.do - ????????? ?????? ?????????4 ??????");
		
		String cnt = admAdmstrDAO.admAjaxProfSubTab4Cnt(memberCode);
		Calendar cal = Calendar.getInstance();
		int year = cal.get(Calendar.YEAR);
		String Certitype = "";
		if(prfPCerti.equals("1")){
			Certitype = "A";
		}
		String prfPIssueNum = year + "-" + Certitype + "-" + String.format("%04d", (Integer.parseInt(cnt)+1));
		
		
		EgovMap map = new EgovMap();
		map.put("prfPIssueNum", prfPIssueNum);
		map.put("prfPSeq", prfPSeq);
		map.put("prfPCerti", prfPCerti);
		map.put("prfPIncidental", prfPIncidental);
		map.put("prfPCauseIssue", prfPCauseIssue);
		map.put("memberCode", memberCode);

		if(prfPSeq == null || prfPSeq == ""){
			admAdmstrDAO.admAjaxProfSubSave4(map); 
		}else{
			admAdmstrDAO.admAjaxProfSubUpdate4(map);
		}
		
		List<EgovMap> listVO = admAdmstrDAO.admAjaxProfSubTab4(memberCode); 
		model.addAttribute("resultList", listVO);
		
		return jsonView;
	}
	//????????? ??????
	@RequestMapping("/qxsepmny/admstr/admAjaxProfLectName.do")
	public View admAjaxProfLectName(String year,String seme,HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admAjaxProfLectName.do - ????????? ??????");
		
		EgovMap map = new EgovMap();
		map.put("year", year);
		map.put("seme", seme);
		
		List<EgovMap> lectNameList = admAdmstrDAO.admAjaxLectName(map);
		model.addAttribute("lectNameList", lectNameList);
		
		return jsonView;
	}
	//????????? ??????
	@RequestMapping("/qxsepmny/admstr/admAjaxProfEnterDate.do")
	public View admAjaxProfEnterDate(String year,String seme,HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admAjaxProfEnterDate.do - ????????? ??????");
		
		EgovMap map = new EgovMap();
		map.put("year", year);
		map.put("seme", seme);
		
		List<EgovMap> enterDateList = admAdmstrDAO.admAjaxProfEnterDate(map);
		model.addAttribute("enterDateList", enterDateList);
		
		return jsonView;
	}
	//?????? ??????
	@RequestMapping("/qxsepmny/admstr/ajaxSearchDivi.do")
	public View ajaxSearchDivi(String year,String seme,String name,HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/ajaxSearchDivi.do - ?????? ??????");
		
		EgovMap map = new EgovMap();
		map.put("year", year);
		map.put("seme", seme);
		map.put("name", name);
		
		List<EgovMap> lectDiviList = admAdmstrDAO.ajaxSearchDivi(map);
		model.addAttribute("lectDiviList", lectDiviList);
		
		return jsonView;
	}
	// ????????? ?????? ?????? ????????????
	@RequestMapping("/qxsepmny/admstr/admAjaxProfCheck.do")
	public View admAjaxProfCheck(String memberCode, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admAjaxProfCheck.do - ????????? ?????? ?????? ????????????");
		LOGGER.debug("memberCode = " + memberCode);
		String message = "";
		boolean status = false;
		if(!EgovStringUtil.isEmpty(memberCode)){
			int cnt = admAdmstrDAO.selectAdmAjaxProfCheck(memberCode);
			if(cnt > 0){
				message = "?????? ???????????? ???????????????.";
				status = false;
			}else{
				message = "?????? ????????? ???????????????.";
				status = true;
			}
		}
		
		model.addAttribute("message", message);
		model.addAttribute("status", status);
		
		return jsonView;
	}

	// ????????? ?????? ???????????? ?????????
	@RequestMapping("/qxsepmny/admstr/admAjaxProfClearPw.do")
	public View admAjaxProfClearPw(MemberVO memberVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admAjaxProfClearPw.do - ????????? ?????? ?????? ????????????");
		LOGGER.debug("memberVO = " + memberVO);
		String message = "";
		if(memberVO != null){
			memberVO.setMemberPw(EgovFileScrty.encryptPassword(memberVO.getMemberCode(), memberVO.getMemberCode()));
			admAdmstrDAO.updateAdmAjaxProfClearPw(memberVO);
			message = "??????????????? ????????????????????????.";
		}
		
		model.addAttribute("message", message);
		
		return jsonView;
	}

	// ????????? ?????? ??????&??????
	@RequestMapping("/qxsepmny/admstr/admProfUpdate.do")
	public String admProfUpdate(@ModelAttribute("memberVO") MemberVO memberVO, MultipartHttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admProfUpdate.do - ????????? ?????? ??????&??????");
		LOGGER.debug("memberVO = " + memberVO.toString());
		request.getSession().setAttribute("admMenuNo", "504");
		String message = "";
		
		FileInfoVO fileInfoVO = fileUtil.uploadAttachedImgFile(request, "PRF");
		memberVO.setMemberPw(EgovFileScrty.encryptPassword(memberVO.getMemberCode(), memberVO.getMemberPw()));
		
		if(!EgovStringUtil.isEmpty(memberVO.getMemberSeq())){
			if(fileInfoVO != null){
				if(!EgovStringUtil.isEmpty(memberVO.getImgPath())){
					fileUtil.deleteFile(memberVO.getImgPath());
				}
				memberVO.setImgPath(fileInfoVO.getFilePath());
				memberVO.setImgName(fileInfoVO.getFileName());
				
				admAdmstrDAO.updateProfImg(memberVO);
			}
			admAdmstrDAO.updateProfessor(memberVO);
			message = "????????? ?????????????????????.";
		}else{
			if(fileInfoVO != null){
				if(!EgovStringUtil.isEmpty(memberVO.getImgPath())){
					fileUtil.deleteFile(memberVO.getImgPath());
				}
				memberVO.setImgPath(fileInfoVO.getFilePath());
				memberVO.setImgName(fileInfoVO.getFileName());
				
				admAdmstrDAO.updateProfImg(memberVO);
			}
			admAdmstrDAO.insertProfessor(memberVO);
			message = "????????? ?????????????????????.";
		}
		
		return redirectProfList(reda, message);
	}

	// ********************************(??????) 20200317 ????????? ???????????? ????????????********************************
	@RequestMapping("/qxsepmny/admstr/admNoticeList.do")
	public String admNoticeList(HttpServletRequest request, ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admNoticeList.do - ????????? ???????????? ????????????");
		request.getSession().setAttribute("admMenuNo", "505");

		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		CmmnListVO listVO = admAdmstrDAO.NoticeList(searchVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
	
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("leftMenuType", "505");
		model.addAttribute("topMenuType", "50");

		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		
		
		return "/adm/admstr/admNoticeList";
	}

	// ********************************(??????) 20200317 ????????? ???????????? ????????????********************************
	@RequestMapping("/qxsepmny/admstr/admNoticeView.do")
	public String admNoitceView(@ModelAttribute CmmnSearchVO searchVO , NoticeVO noticeVO, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admNoticeView.do - ????????? ???????????? ????????????");
		request.getSession().setAttribute("admMenuNo", "505");
		
		noticeVO =  admAdmstrDAO.selectNoticeOne(noticeVO.getNoti_seq());
		admAdmstrDAO.updateNoticeHits(noticeVO.getNoti_seq());

		model.addAttribute("leftMenuType", "505");
		model.addAttribute("topMenuType", "50");
		model.addAttribute("result", noticeVO);
		model.addAttribute("pageIndex", searchVO.getPageIndex());
		
		EgovMap map = new EgovMap();
		map.put("boardSeq", noticeVO.getNoti_seq());
		map.put("boardType", "NOTI");
		
		//???????????? ????????? ??????
		List<AttachVO> attachList = cmmDAO.selectAttachList(map);
		model.addAttribute("attachList", attachList);
		
		return "/adm/admstr/admNoticeView";
	}
 
	// ********************************(??????) 20200317 ????????? ???????????? ??????&?????? ??????********************************
	@RequestMapping("/qxsepmny/admstr/admNoticeModify.do")
	public String admNoticeModify(@ModelAttribute("noticeVO") NoticeVO noticeVO, HttpServletRequest request, ModelMap model ) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admNoticeModify.do - ????????? ???????????? ??????&?????? ??????");
		
		request.getSession().setAttribute("admMenuNo", "505");
		model.addAttribute("topMenuType", "50");
		
		//?????? ??????
	AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionLcms");
	
	   //??????????????????
		if (EgovStringUtil.isEmpty(noticeVO.getNoti_seq())) {
			model.addAttribute("adminVO", adminVO);
			model.addAttribute("NotiPageGubun","NotiRegist");
		}
		//?????????????????? 
		if(!EgovStringUtil.isEmpty(noticeVO.getNoti_seq())){
			
		
			noticeVO = admAdmstrDAO.selectNoticeOne(noticeVO.getNoti_seq());
			model.addAttribute("NotiPageGubun","NotiUpdate");
			model.addAttribute("noticeVO", noticeVO);
			
			EgovMap map = new EgovMap();
			map.put("boardSeq", noticeVO.getNoti_seq());
			map.put("boardType", "NOTI");
			
			//???????????? ????????? ??????
			List<AttachVO> attachList = cmmDAO.selectAttachList(map);
			model.addAttribute("attachList", attachList);
			// ?????? ????????? ???????????? ??????
			int attachListCnt = cmmDAO.selectAttachListCnt(noticeVO.getNoti_seq());
			model.addAttribute("attachListCnt",attachListCnt);
		}
		
		//?????? ???????????? ???????????? ??????
		int notiTopCnt = admAdmstrDAO.selectNotiTopCnt();
		model.addAttribute("notiTopCnt",notiTopCnt);
		
		return "/adm/admstr/admNoticeModify";
	}

	// ********************************(??????) 20200317 ????????? ???????????? ?????? ********************************
	@RequestMapping("/qxsepmny/admstr/admSaveNotice.do")
		public String admSaveNoitce(@ModelAttribute("noticeVO") NoticeVO noticeVO, String deleteFileIds, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admSaveNotice.do - ????????? ???????????? ??????");
		String message = "";
		
		//?????? ??????
		AdminVO adminVO = (AdminVO) request.getSession().getAttribute("adminSessionLcms");
		
		if(EgovStringUtil.isEmpty(noticeVO.getNoti_seq())){
		    
			//????????? ?????? ?????? name ??????
			noticeVO.setNoti_writer(adminVO.getName());
			noticeVO.setNoti_seq(admAdmstrDAO.insertNotice(noticeVO));
		    
			
			List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "NOTI");
			if(fileInfoList != null){
				for(FileInfoVO fileInfoVO : fileInfoList){
					AttachVO attachVO = new AttachVO(fileInfoVO);
					attachVO.setBoardType("NOTI");
					attachVO.setBoardSeq(noticeVO.getNoti_seq());
					cmmDAO.insertAttachFile(attachVO);
				}
			}
			message = "????????? ?????????????????????.";
		}else{
			admAdmstrDAO.updateNotice(noticeVO);
			message = "????????? ?????????????????????.";
		
			//?????? ?????????
			List<FileInfoVO> fileInfoList = fileUtil.totUploadFiles(request, "NOTI");
			if(fileInfoList != null){
				for(FileInfoVO fileInfoVO : fileInfoList){
					AttachVO attachVO = new AttachVO(fileInfoVO);
					attachVO.setBoardType("NOTI");
					attachVO.setBoardSeq(noticeVO.getNoti_seq());
					cmmDAO.insertAttachFile(attachVO);
				}
			}
			
		}
		return redirectList(reda, message);

	}
	
	// ********************************(??????) 20200325 ????????? ???????????? ?????? ********************************
		@RequestMapping("/qxsepmny/admstr/admNoticeDelete.do")
			public String admNoticeDelete(@ModelAttribute NoticeVO noticeVO, AttachVO attachVO, String[] delSeqList, MultipartHttpServletRequest request, RedirectAttributes reda,ModelMap model) throws Exception {
			LOGGER.debug("/qxsepmny/admstr/admNoticeDelete.do - ????????? ???????????? ??????");
			String message = "";
			
			//???????????? ??????
			if(!EgovStringUtil.isEmpty(noticeVO.getNoti_seq())){
			
				admAdmstrDAO.deleteNotice(noticeVO);
				
				//???????????? ???????????? ??????
				if(delSeqList != null){
					for(String delSeq : delSeqList){
						 attachVO = cmmDAO.selectAttachOne(delSeq);
						fileUtil.deleteFile(attachVO.getRegFileName());
						cmmDAO.deleteAttachFile(attachVO.getAttachSeq());
					}
				}
				message = "????????? ?????????????????????.";
			}
			return redirectList(reda, message);

		}
	
	
	@RequestMapping("/qxsepmny/admstr/deleteFileUpload.do")
	public View deleteFileUpload( AttachVO attachVO,HttpServletRequest request ,ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/deleteFileUpload.do - ?????? ????????? ??????");
		
		String message = "";
		
		//?????? ?????? path??????
		attachVO = cmmDAO.selectAttachOne(attachVO.getAttachSeq());
		// ???????????? ??????
		fileUtil.deleteFile(attachVO.getRegFileName());
		
		// ????????? ????????? ??????????????? ?????? attachVO.getAttachSeq() ??? ??????????????????.
		cmmDAO.deleteAttachFile(attachVO.getAttachSeq());
		
		message = "??????????????? ?????????????????????.";
		model.addAttribute("message", message);
		
		return jsonView;
	}


	// ?????? ???????????? ???????????????
	private String redirectList(RedirectAttributes reda, String message) {
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/admstr/admNoticeList.do";
	}
	
	/*/????????????****************************************************************************************************************************************************** */
	
	// ????????? ????????? ?????? ?????? ????????????
	@SuppressWarnings("unchecked")
	@RequestMapping("/qxsepmny/admstr/admCertiExcel.do")
	public void admCertiExcel(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admCertiExcel.do - ????????? ????????? ?????? ?????? ????????????");
		LOGGER.debug("searchVO = " + searchVO.toString());
		EgovMap dataMap = new EgovMap();
		
		List<EgovMap> resultList = admAdmstrDAO.selectAdmCertiExcel(searchVO);
		dataMap.put("resultList", resultList);
		
		int num = 1;
		for (EgovMap egovMap : resultList) {
			egovMap.put("number", num);
			num++;
		}
		
		AdminVO sessionVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		dataMap.put("printUser", sessionVO.getName());
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "????????? ?????????", "certiList", request, response);
	}
	
	// ????????? ?????? ????????? ?????? ?????????
	@RequestMapping("/qxsepmny/admstr/admAjaxProfClearLogin.do")
	public View admAjaxProfClearLogin(String memberCode, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/admstr/admAjaxProfClearLogin.do - ????????? ?????? ????????? ?????? ?????????");
		LOGGER.debug("memberCode = " + memberCode);
		String message = "";
		
		admAdmstrDAO.updateLoginFailClear(memberCode);
		message = "????????? ????????? ????????????????????????.";

		model.addAttribute("message", message);
		return jsonView;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping("/test/test.do")
	public void test(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.debug("test");
		EgovMap dataMap = new EgovMap();
		
		dataMap.put("name1", "?????????1");
		dataMap.put("name2", "?????????2");
		dataMap.put("name3", "?????????3");
		dataMap.put("name4", "?????????4");
		dataMap.put("name5", "?????????5");
		
		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.getPerformanceExcel(dataMap, "test", "test", request, response);
	}
}
