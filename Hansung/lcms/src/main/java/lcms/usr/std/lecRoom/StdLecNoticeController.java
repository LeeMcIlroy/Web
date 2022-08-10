package lcms.usr.std.lecRoom;

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
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import lcms.adm.cmm.AdmCmmController;
import lcms.usr.lec.com.LecComDAO;
import lcms.valueObject.AttachVO;
import lcms.valueObject.LecClssNoticeVO;
import lcms.valueObject.UsrVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class StdLecNoticeController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(StdLecNoticeController.class);
	
	@Autowired private StdLecNoticeDAO stdLecNoticeDAO;
	@Autowired private LecComDAO lecComDAO;
	@Resource View jsonView;
	
	// 학생 - 강의실 공지사항 리스트
	@RequestMapping("/usr/std/lecRoom/stdLecNoticeList.do")
	public String stdLecNoticeList(@ModelAttribute("lecClssNoticeVO") LecClssNoticeVO lecClssNoticeVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/std/lecRoom/stdLecNoticeList.do - 학생 강의실 공지사항 리스트");
		request.getSession().setAttribute("stdMenuNo", "101");

		String selLectCode = (String) request.getSession().getAttribute("selLectCode");
		request.getSession().setAttribute("selLectCode", selLectCode);
		lecClssNoticeVO.setLectCode(selLectCode);
		
		EgovMap lecSession = (EgovMap)session.getAttribute("lecSession");
		String lectYear = ((String)lecSession.get("lectYear"));
		String lectSemNm = (((String)lecSession.get("lectSem")).equals("1")?"봄학기":((String)lecSession.get("lectSem")).equals("2")?"여름학기":((String)lecSession.get("lectSem")).equals("3")?"가을학기":"겨울학기");
		String lectName = ((String)lecSession.get("lectName"));
		String lectDivi = ((String)lecSession.get("lectDivi"));
		
		model.addAttribute("lectYear", lectYear);
		model.addAttribute("lectSemNm", lectSemNm);
		model.addAttribute("lectName", lectName);
		model.addAttribute("lectDivi", lectDivi);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(lecClssNoticeVO);
		CmmnListVO listVO = stdLecNoticeDAO.selectStdLecNoticeList(lecClssNoticeVO); 
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
				
		model.addAttribute("resultList", listVO.getEgovList());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalCount", paginationInfo.getTotalRecordCount());
		model.addAttribute("currentPageNo", paginationInfo.getCurrentPageNo());
		model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
		
		return "/usr/std/lecRoom/stdLecNoticeList";
	}
	
	// 학생 - 강의실 공지사항 상세
	@RequestMapping("/usr/std/lecRoom/stdLecNoticeView.do")
	public String stdLecNoticeView(HttpSession session, HttpServletRequest request, ModelMap model, LecClssNoticeVO lecClssNoticeVO) throws Exception {
		LOGGER.debug("/usr/std/lecRoom/stdLecNoticeView.do - 학생 강의실 공지사항 상세");
		request.getSession().setAttribute("stdMenuNo", "101");
		
		String lcnotiSeq = lecClssNoticeVO.getLcnotiSeq();
		
		EgovMap noticeMap = stdLecNoticeDAO.selectstdnoticeOne(lcnotiSeq);

		model.addAttribute("leftMenuType", "101");
		model.addAttribute("topMenuType", "10");
		model.addAttribute("result", noticeMap);
		
		if(!EgovStringUtil.isEmpty(lcnotiSeq)){
			lcnotiSeq = lecClssNoticeVO.getLcnotiSeq();
			
			EgovMap map = new EgovMap();
			map.put("boardSeq", lcnotiSeq);
			map.put("boardType", "LEC");
			List<AttachVO> attachList = cmmDAO.selectAttachList(map);
					
			model.addAttribute("attachList", attachList);
			
		}
		
		return "/usr/std/lecRoom/stdLecNoticeView";
	}
	
	//강의실 변경
	@RequestMapping("/usr/std/lecRoom/changeLect.do")
	public String changeLect(HttpServletRequest request, ModelMap model, RedirectAttributes reda ) throws Exception {
		LOGGER.debug("/usr/login/changeLect.do - 사용자 강의실 변경");
		
		String returnUrl = "";
		
		returnUrl = "redirect:/usr/std/lecRoom/stdLecNoticeList.do";

		String selLectCode = request.getParameter("selLectCode");
		String selLectName = request.getParameter("selLectName");
			
		EgovMap lectMap = lecComDAO.SelectLectMap(selLectCode); //강의정보 조회
			
		request.getSession().setAttribute("selLectCode", selLectCode);//선택 강의코드
		request.getSession().setAttribute("selLectName", selLectName);//선택 강의이름
		request.getSession().setAttribute("lecSession", lectMap);//강의정보 세션 등록
			
		return redirectIndex(returnUrl);
	
}
	private String redirectIndex(String returnUrl){
		return returnUrl;
	}
}
