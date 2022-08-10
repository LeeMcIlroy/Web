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
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import lcms.adm.cmm.AdmCmmController;
import lcms.valueObject.AttachVO;
import lcms.valueObject.NoticeVO;
import lcms.valueObject.cmm.CmmnListVO;
import lcms.valueObject.cmm.CmmnSearchVO;

@Controller
public class LecNoticeController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(LecNoticeController.class);
	
	@Autowired private LecNoticeDAO lecNoticeDAO;
	@Resource View jsonView;
	
	// 강사 - 공지사항 리스트
	@RequestMapping("/usr/lec/myPage/lecNoticeList.do")
	public String lecNoticeList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/myPage/lecNoticeList.do - 강사 공지사항 목록");
		request.getSession().setAttribute("lecMenuNo", "501");
		
		

		/*// 상단공지 고정으로 인한 리스트 표출숫자 변경  20200312
		int totalCountTop = lecNoticeDAO.selectTopNotiListCnt(searchVO);
		searchVO.setRecordCountPerPage(searchVO.getRecordCountPerPage()-totalCountTop);*/
		
		  PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		  
			CmmnListVO listVO = lecNoticeDAO.selectLecNoticeList(searchVO);
			
			
			paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
			
			model.addAttribute("resultList", listVO.getEgovList());
			model.addAttribute("totalPageCount", paginationInfo.getTotalPageCount());
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("searchVO",searchVO);
			
			// *********** 상단 공지 리스트 20200312 ***********
			List<EgovMap> listTOP = lecNoticeDAO.selectTopNotiList(searchVO);
			model.addAttribute("resultListTOP", listTOP);
		
		return "/usr/lec/myPage/lecNoticeList";
	}
	
	// 강사 - 공지사항 상세
	@RequestMapping("/usr/lec/myPage/lecNoticeView.do")
	public String lecNoticeView(@ModelAttribute CmmnSearchVO searchVO, NoticeVO noticeVO, HttpSession session, HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/usr/lec/myPage/lecNoticeView.do - 강사 공지사항 상세");
		request.getSession().setAttribute("lecMenuNo", "501");
		
		lecNoticeDAO.updateLecNoticeHits(noticeVO.getNoti_seq());
		noticeVO = lecNoticeDAO.selectLecNoticeOne(noticeVO.getNoti_seq());
		
		EgovMap map = new EgovMap();
		map.put("boardSeq", noticeVO.getNoti_seq());
		map.put("boardType", "NOTI");
		
		//첨부파일 데이터 조회
		List<AttachVO> attachList = cmmDAO.selectAttachList(map);
		model.addAttribute("attachList", attachList);
		
		model.addAttribute("pageIndex", searchVO.getPageIndex());
		model.addAttribute("result",noticeVO);
		return "/usr/lec/myPage/lecNoticeView";
	}
	
	
	
}
