package writer.usr.cntst;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.web.PaginationController;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import writer.usr.cmm.CmmnBoardDAO;
import writer.valueObject.BoardVO;
import writer.valueObject.CntstApplyVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Controller
public class CntstController {

	private final static Logger LOGGER = LoggerFactory.getLogger(CntstController.class);
	@Autowired CmmnBoardDAO cmmnBoardDAO;
	
	/************************************************* 공통 *************************************************/
	// 검색 조건을 가지고 목록페이지(조회_주제목록)로 이동합니다.
	private String redirectListPage(CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", searchVO.getMessage());
		reda.addFlashAttribute("searchVO", searchVO);
		
		String redirectPage = "";
		redirectPage = "redirect:/usr/cntst/cntstDataList.do";		// 목록
		
		return redirectPage;
		
	}

	private String redirectWriteListPage(CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", searchVO.getMessage());
		reda.addFlashAttribute("searchVO", searchVO);
		
		String redirectPage = "";
		redirectPage = "redirect:/usr/cntst/cntstWriteComList.do";		// 목록
		
		return redirectPage;
		
	}

	// 대회 > 한성인 글쓰기 대회
	@RequestMapping("/usr/cntst/cntstWriteView.do")
	public String cntstWriteView(HttpSession session) throws Exception {
		LOGGER.info("/usr/cntst/cntstWriteView.do - 사용자 > 대회 > 한성인 글쓰기 대회");
		session.setAttribute("menuNo", "501");
		return "/usr/cntst/cntstWriteView";
	}
	
	// 대회 > 한성인 프레젠테이션 대회
	@RequestMapping("/usr/cntst/cntstPresentationView.do")
	public String cntstPresentationView(HttpSession session) throws Exception {
		LOGGER.info("/usr/cntst/cntstWriteView.do - 사용자 > 대회 > 한성인 글쓰기 대회");
		session.setAttribute("menuNo", "502");
		return "/usr/cntst/cntstPresentationView";
	}
	
	
	/************************************************* 대회자료실 *************************************************/
	// 목록
	@RequestMapping("/usr/cntst/cntstDataList.do")
	public String cnstDataList(ModelMap model, HttpServletRequest request, @ModelAttribute("searchVO")CmmnSearchVO searchVO)throws Exception{
		LOGGER.info("/usr/cntst/cntstDataList.do - 사용자 > 대회 > 대회자료실 목록");
		LOGGER.debug("searchVO - "+searchVO.toString());
		request.getSession().setAttribute("menuNo", "503");
		
		searchVO.setSearchType("CNTST");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO=cmmnBoardDAO.selectCmmnBoardList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo",paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		List<EgovMap> noticeListVO = cmmnBoardDAO.selectCmmnBoardNoticeList(searchVO.getSearchType());
		model.addAttribute("resultList_notice", noticeListVO);
		
		return "/usr/cntst/cntstDataList";
	}
	
	// 조회
	@RequestMapping("/usr/cntst/cntstDataView.do")
	public String cnstDataView(ModelMap model, String brdSeq, @ModelAttribute("searchVO")CmmnSearchVO searchVO, RedirectAttributes reda)throws Exception{
		LOGGER.info("/usr/cntst/cntstDataView.do - 사용자 > 대회 > 대회자료실 조회");
		LOGGER.debug("brdSeq"+brdSeq);
		
		BoardVO boardVO=cmmnBoardDAO.selectCmmnBoardOne(brdSeq);
		List<EgovMap> upfileList=cmmnBoardDAO.selectCmmnBoardUpfileList(brdSeq);
		if(boardVO==null){
			searchVO.setMessage("게시글이 없습니다.");
			LOGGER.debug("message-"+searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		model.addAttribute("boardVO",boardVO);
		model.addAttribute("upfileList", upfileList);
		return "/usr/cntst/cntstDataView";
	}

	/************************************************* 제15회 한성인 글쓰기 대회 *************************************************/
	// 목록
	@RequestMapping("/usr/cntst/cntstWriteComList.do")
	public String cntstWriteComList(ModelMap model, HttpServletRequest request, @ModelAttribute("searchVO")CmmnSearchVO searchVO)throws Exception{
		LOGGER.info("/usr/cntst/cntstWriteComList.do - 사용자 > 대회 > 제15회 한성인 글쓰기 대회 목록");
		LOGGER.debug("searchVO - "+searchVO.toString());
//		request.getSession().setAttribute("menuNo", "504");
		request.getSession().setAttribute("menuNo", "501");
		
		searchVO.setSearchType("WRITE");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO=cmmnBoardDAO.selectCmmnBoardList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo",paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		List<EgovMap> noticeListVO = cmmnBoardDAO.selectCmmnBoardNoticeList(searchVO.getSearchType());
		model.addAttribute("resultList_notice", noticeListVO);
		
		return "/usr/cntst/cntstWriteComList";
	}
	
	// 조회
	@RequestMapping("/usr/cntst/cntstWriteComView.do")
	public String cntstWriteComView(ModelMap model, String brdSeq, @ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request, RedirectAttributes reda)throws Exception{
		LOGGER.info("/usr/cntst/cntstWriteComView.do - 사용자 > 대회 > 제15회 한성인 글쓰기 대회 조회");
		LOGGER.debug("brdSeq"+brdSeq);
		request.getSession().setAttribute("menuNo", "501");
		
		if(!EgovUserDetailsHelper.isAuthenticatedUser()){
			searchVO.setMessage("로그인이 필요한 페이지입니다.");
			LOGGER.debug("message-"+searchVO.getMessage());
			return redirectWriteListPage(searchVO, reda);
		}
		
		BoardVO boardVO=cmmnBoardDAO.selectCmmnBoardOne(brdSeq);
		List<EgovMap> upfileList=cmmnBoardDAO.selectCmmnBoardUpfileList(brdSeq);
		if(boardVO==null){
			searchVO.setMessage("게시글이 없습니다.");
			LOGGER.debug("message-"+searchVO.getMessage());
			return redirectWriteListPage(searchVO, reda);
		}
		model.addAttribute("boardVO",boardVO);
		model.addAttribute("upfileList", upfileList);
		return "/usr/cntst/cntstWriteComView";
	}

	// 목록
	@RequestMapping("/usr/cntst/cntstPptComList.do")
	public String cntstPptComList(ModelMap model, HttpServletRequest request, @ModelAttribute("searchVO")CmmnSearchVO searchVO)throws Exception{
		LOGGER.info("/usr/cntst/cntstPptComList.do - 사용자 > 대회 > 프레젠테이션 대회 목록");
		LOGGER.debug("searchVO - "+searchVO.toString());
//		request.getSession().setAttribute("menuNo", "504");
		request.getSession().setAttribute("menuNo", "502");
		
		searchVO.setSearchType("PPT");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO=cmmnBoardDAO.selectCmmnBoardList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo",paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		List<EgovMap> noticeListVO = cmmnBoardDAO.selectCmmnBoardNoticeList(searchVO.getSearchType());
		model.addAttribute("resultList_notice", noticeListVO);
		
		return "/usr/cntst/cntstPptComList";
	}
	
	// 조회
	@RequestMapping("/usr/cntst/cntstPptComView.do")
	public String cntstPptComView(ModelMap model, String brdSeq, @ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request, RedirectAttributes reda)throws Exception{
		LOGGER.info("/usr/cntst/cntstPptComView.do - 사용자 > 대회 > 프레젠테이션 대회 조회");
		LOGGER.debug("brdSeq"+brdSeq);
		request.getSession().setAttribute("menuNo", "502");
		
		if(!EgovUserDetailsHelper.isAuthenticatedUser()){
			searchVO.setMessage("로그인이 필요한 페이지입니다.");
			LOGGER.debug("message-"+searchVO.getMessage());
			return redirectWriteListPage(searchVO, reda);
		}
		
		BoardVO boardVO=cmmnBoardDAO.selectCmmnBoardOne(brdSeq);
		List<EgovMap> upfileList=cmmnBoardDAO.selectCmmnBoardUpfileList(brdSeq);
		if(boardVO==null){
			searchVO.setMessage("게시글이 없습니다.");
			LOGGER.debug("message-"+searchVO.getMessage());
			return redirectWriteListPage(searchVO, reda);
		}
		model.addAttribute("boardVO",boardVO);
		model.addAttribute("upfileList", upfileList);
		return "/usr/cntst/cntstPptComView";
	}
	
	/************************* 20200731 한성인 대회접수 페이지 START *************************/
	@SuppressWarnings("unchecked")
	// 한성인 글쓰기 대회 접수 페이지
	@RequestMapping("/usr/cntst/cntstContestApply.do")
	public String cntstWriteRegiModify(@ModelAttribute("searchVO")CmmnSearchVO searchVO, ModelMap model, HttpServletRequest request, RedirectAttributes reda)throws Exception{
		LOGGER.info("/usr/cntst/cntstWriteRegiModify.do - 사용자 > 대회 > 한성인 대회접수페이지");
		request.getSession().setAttribute("menuNo", "501");
		
		String param = "CONWRITE";
		
		EgovMap resultMap = cmmnBoardDAO.selectContestBoardOne(param);
		
		if(resultMap == null){
			reda.addFlashAttribute("message", "대회신청 기간이 아닙니다.");
			return "redirect:/usr/cntst/cntstWriteView.do";
		}
		
		if(resultMap.get("brdContent") instanceof java.sql.Clob){
			resultMap.put("brdContent", EgovStringUtil.clobToString((java.sql.Clob) resultMap.get("brdContent")));
		}
		
		Map<String, String> usrVO = (Map<String, String>) EgovUserDetailsHelper.getAuthenticatedUser();
		usrVO.put("openYear", (String) resultMap.get("openYear"));
		usrVO.put("brdSeq", ((BigDecimal) resultMap.get("brdSeq")).toString());
		usrVO.put("aplyType", "WRITE");
		
		CntstApplyVO cntstApplyVO = cmmnBoardDAO.selectCntstApplyOne(usrVO);
		
		if(cntstApplyVO == null){
			cntstApplyVO = new CntstApplyVO();
		}

		model.addAttribute("resultMap", resultMap);
		model.addAttribute("cntstApplyVO", cntstApplyVO);
		
		return "/usr/cntst/cntstContestApply";
	}

	// 한성인 프레젠테이션 대회 접수 페이지
	@SuppressWarnings("unchecked")
	@RequestMapping("/usr/cntst/cntstContestPptApply.do")
	public String cntstContestPptApply(@ModelAttribute("searchVO")CmmnSearchVO searchVO, ModelMap model, HttpServletRequest request, RedirectAttributes reda)throws Exception{
		LOGGER.info("/usr/cntst/cntstContestPptApply.do - 사용자 > 대회 > 한성인 프레젠테이션 대회 접수페이지");
		request.getSession().setAttribute("menuNo", "502");
		
		String param = "CONPPT";
		
		EgovMap resultMap = cmmnBoardDAO.selectContestBoardOne(param);
		
		if(resultMap == null){
			reda.addFlashAttribute("message", "대회신청 기간이 아닙니다.");
			return "redirect:/usr/cntst/cntstPresentationView.do";
		}
		
		if(resultMap.get("brdContent") instanceof java.sql.Clob){
			resultMap.put("brdContent", EgovStringUtil.clobToString((java.sql.Clob) resultMap.get("brdContent")));
		}
		
		Map<String, String> usrVO = (Map<String, String>) EgovUserDetailsHelper.getAuthenticatedUser();
		usrVO.put("openYear", (String) resultMap.get("openYear"));
		usrVO.put("brdSeq", ((BigDecimal) resultMap.get("brdSeq")).toString());
		usrVO.put("aplyType", "PPT");
		
		CntstApplyVO cntstApplyVO = cmmnBoardDAO.selectCntstApplyOne(usrVO);
		
		if(cntstApplyVO == null){
			cntstApplyVO = new CntstApplyVO();
		}
		
		model.addAttribute("resultMap", resultMap);
		model.addAttribute("cntstApplyVO", cntstApplyVO);
		
		return "/usr/cntst/cntstContestPptApply";
	}
	
	// 한성인 글쓰기 대회 접수
	@RequestMapping("/usr/cntst/cntstContestUpdate.do")
	public String cntstContestUpdate(@ModelAttribute("searchVO")CmmnSearchVO searchVO, CntstApplyVO cntstApplyVO, ModelMap model, HttpServletRequest request, RedirectAttributes reda)throws Exception{
		LOGGER.info("/usr/cntst/cntstContestUpdate.do - 사용자 > 대회 > 한성인 대회 접수");
		
		if(EgovStringUtil.isEmpty(cntstApplyVO.getAplySeq())){
			String aplyMphone = cntstApplyVO.getAplyMphone_1()+"-"+cntstApplyVO.getAplyMphone_2()+"-"+cntstApplyVO.getAplyMphone_3();
			cntstApplyVO.setAplyMphone(aplyMphone);
			
			String aplyEmail = cntstApplyVO.getAplyEmail_1()+"@"+cntstApplyVO.getAplyEmail_2();
			cntstApplyVO.setAplyEmail(aplyEmail);
			
			cmmnBoardDAO.insertContestBoard(cntstApplyVO);
			reda.addFlashAttribute("message", "접수가 완료되었습니다.");
		}
		
		return "redirect:/usr/cntst/cntstWriteView.do";
	}

	// 한성인 프레젠테이션 대회 접수
	@RequestMapping("/usr/cntst/cntstContestPptUpdate.do")
	public String cntstContestPptUpdate(@ModelAttribute("searchVO")CmmnSearchVO searchVO, CntstApplyVO cntstApplyVO, ModelMap model, HttpServletRequest request, RedirectAttributes reda)throws Exception{
		LOGGER.info("/usr/cntst/cntstContestPptUpdate.do - 사용자 > 대회 > 한성인 프레젠테이션 대회 접수");
		
		if(EgovStringUtil.isEmpty(cntstApplyVO.getAplySeq())){
			String aplyMphone = cntstApplyVO.getAplyMphone_1()+"-"+cntstApplyVO.getAplyMphone_2()+"-"+cntstApplyVO.getAplyMphone_3();
			cntstApplyVO.setAplyMphone(aplyMphone);
			
			String aplyEmail = cntstApplyVO.getAplyEmail_1()+"@"+cntstApplyVO.getAplyEmail_2();
			cntstApplyVO.setAplyEmail(aplyEmail);
			
			if(!EgovStringUtil.isEmpty(cntstApplyVO.getAplyMphone2_1()) && !EgovStringUtil.isEmpty(cntstApplyVO.getAplyMphone2_2()) && !EgovStringUtil.isEmpty(cntstApplyVO.getAplyMphone2_3())){
				String aplyMphone2 = cntstApplyVO.getAplyMphone2_1()+"-"+cntstApplyVO.getAplyMphone2_2()+"-"+cntstApplyVO.getAplyMphone2_3();
				cntstApplyVO.setAplyMphone2(aplyMphone2);
				
				String aplyEmail2 = cntstApplyVO.getAplyEmail2_1()+"@"+cntstApplyVO.getAplyEmail2_2();
				cntstApplyVO.setAplyEmail2(aplyEmail2);
			}
			
			if(!EgovStringUtil.isEmpty(cntstApplyVO.getAplyMphone3_1()) && !EgovStringUtil.isEmpty(cntstApplyVO.getAplyMphone3_2()) && !EgovStringUtil.isEmpty(cntstApplyVO.getAplyMphone3_3())){
				String aplyMphone3 = cntstApplyVO.getAplyMphone3_1()+"-"+cntstApplyVO.getAplyMphone3_2()+"-"+cntstApplyVO.getAplyMphone3_3();
				cntstApplyVO.setAplyMphone3(aplyMphone3);
				
				String aplyEmail3 = cntstApplyVO.getAplyEmail3_1()+"@"+cntstApplyVO.getAplyEmail3_2();
				cntstApplyVO.setAplyEmail3(aplyEmail3);
			}
			
			cmmnBoardDAO.insertContestBoard(cntstApplyVO);
			reda.addFlashAttribute("message", "접수가 완료되었습니다.");
		}
		
		return "redirect:/usr/cntst/cntstPresentationView.do";
	}

	// 한성인 글쓰기 대회 취소
	@RequestMapping("/usr/cntst/cntstContestDelete.do")
	public String cntstContestDelete(@ModelAttribute("searchVO")CmmnSearchVO searchVO, String aplySeq, ModelMap model, HttpServletRequest request, RedirectAttributes reda)throws Exception{
		LOGGER.info("/usr/cntst/cntstContestDelete.do - 사용자 > 대회 > 한성인 대회 취소");
		
		if(!EgovStringUtil.isEmpty(aplySeq)){
			cmmnBoardDAO.updateContestBoardCancel(aplySeq);
			reda.addFlashAttribute("message", "접수취소가 완료되었습니다.");
		}
		
		return "redirect:/usr/cntst/cntstWriteView.do";
	}

	// 한성인 프레젠테이션 대회 취소
	@RequestMapping("/usr/cntst/cntstContestPptDelete.do")
	public String cntstContestPptDelete(@ModelAttribute("searchVO")CmmnSearchVO searchVO, String aplySeq, ModelMap model, HttpServletRequest request, RedirectAttributes reda)throws Exception{
		LOGGER.info("/usr/cntst/cntstContestPptDelete.do - 사용자 > 대회 > 한성인 프레젠테이션 대회 취소");
		
		if(!EgovStringUtil.isEmpty(aplySeq)){
			cmmnBoardDAO.updateContestBoardCancel(aplySeq);
			reda.addFlashAttribute("message", "접수취소가 완료되었습니다.");
		}
		
		return "redirect:/usr/cntst/cntstPresentationView.do";
	}
	/************************* 20200731 한성인 대회접수 페이지 END *************************/
}
