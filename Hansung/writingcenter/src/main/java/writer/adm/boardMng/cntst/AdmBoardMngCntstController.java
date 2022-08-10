package writer.adm.boardMng.cntst;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import writer.adm.cmm.AdmCmmLogDAO;
import writer.adm.cmm.AdmCmmnBoardDAO;
import writer.valueObject.BoardVO;
import writer.valueObject.CntstApplyVO;
import writer.valueObject.ContestVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Controller
public class AdmBoardMngCntstController {
private static final Logger LOGGER = LoggerFactory.getLogger(AdmBoardMngCntstController.class);
	
	private String logJob;
	@Autowired private AdmCmmLogDAO admCmmLogDAO;
	@Autowired private AdmCmmnBoardDAO admBoardDAO;
	@Autowired private CmmnFileMngUtil cmmnFileMngUtil;
	
	/*********************************** 공통 ***********************************/
	// 검색 조건을 가지고 목록페이지(조회_주제목록)로 이동합니다.
	private String redirectListPage(CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", searchVO.getMessage());
		reda.addFlashAttribute("searchVO", searchVO);
		
		String redirectPage = "";
		redirectPage = "redirect:/xabdmxgr/boardMng/cntst/admBoardMngCntstList.do";		// 목록
		
		return redirectPage;
		
	}
	
	/* ************************************ 대회자료실 START ************************************ */
	//목록
	@RequestMapping("/xabdmxgr/boardMng/cntst/admBoardMngCntstList.do")
	public String admBoardMngCntstList(ModelMap model, HttpServletRequest request, @ModelAttribute("searchVO") CmmnSearchVO searchVO)throws Exception{
		LOGGER.info("/xabdmxgr/boardMng/cntst/admBoardMngCntstList.do - 관리자 > 게시판관리 > 대회자료실 목록");
		LOGGER.debug("searchVO - "+searchVO);
		request.getSession().setAttribute("admMenuNo", "403");
		
		searchVO.setSearchType("CNTST");
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO=admBoardDAO.selectCmmnBoardList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo",paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		List<EgovMap> noticeListVO = admBoardDAO.selectCmmnBoardNoticeList(searchVO.getSearchType());
		model.addAttribute("resultList_notice", noticeListVO);
		
		return "/adm/boardMng/cntst/admBoardMngContestList";
	}
	

	//글쓰기 & 수정 화면
	@RequestMapping("/xabdmxgr/boardMng/cntst/admBoardMngCntstModifyView.do")
	public String admBoardMngCntstModify(ModelMap model, @RequestParam("brdSeq")String brdSeq,  @ModelAttribute("searchVO") CmmnSearchVO searchVO)throws Exception{
		LOGGER.info("/xabdmxgr/boardMng/cntst/admBoardMngCntstModifyView.do - 관리자 > 게시판관리 > 대회자료실 글쓰기 & 화면");
		LOGGER.debug("brdSeq="+brdSeq);
		LOGGER.debug("searchVO - "+searchVO);
		
		BoardVO boardVO = null;
		if (EgovStringUtil.isEmpty(brdSeq)) {
			// 등록화면
			boardVO = new BoardVO();
		}else {
			// 수정화면
			boardVO=admBoardDAO.selectCmmnBoardOne(brdSeq);
			model.addAttribute("boardUpfileList",admBoardDAO.selectCmmnBoardUpfileList(brdSeq));
			
		}
		
		model.addAttribute("boardVO", boardVO);
		
		return "/adm/boardMng/cntst/admBoardMngContestModify";
	}
	
	
	//글쓰기 & 수정
	@RequestMapping("/xabdmxgr/boardMng/cntst/admBoardMngCntstModify.do")
	public String admBoardMngCntstModify(ModelMap model, BoardVO boardVO, @ModelAttribute("searchVO") CmmnSearchVO searchVO, MultipartHttpServletRequest multiRequest, HttpServletRequest request, RedirectAttributes reda)throws Exception{
		LOGGER.info("/xabdmxgr/boardMng/cntst/admBoardMngCntstModify.do - 관리자 > 게시판관리 > 대회자료실 글쓰기 $ 수정");
		LOGGER.debug("boardVO - "+boardVO.toString());
		LOGGER.debug("searchVO - "+searchVO.toString());
		
		//제목 여부 및 공개여부 체크 확인
		if("".equals(boardVO.getBrdTitle()) || boardVO.getBrdTitle()==null){
			searchVO.setMessage("제목이 없습니다");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		if("".equals(boardVO.getBrdNoticeYn()) || boardVO.getBrdNoticeYn()==null){
			searchVO.setMessage("공개여부가 없습니다");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		
		// 첨부파일 조건확인
		boolean flag = cmmnFileMngUtil.uploadFileCheck(multiRequest);
		if(!flag){
			LOGGER.debug("첨부된 파일이 잘못되었습니다.");
			searchVO.setMessage("첨부된 파일이 잘못되었습니다.");
			return redirectListPage(searchVO, reda);
		}
		
		boardVO.setBrdType("CNTST");
		
		String rsBrdSeq = "";
		String brdType = "";
		String brdSeq = "";
		String logJob = "";
		if (EgovStringUtil.isEmpty(boardVO.getBrdSeq())) {
			// 등록
			rsBrdSeq=admBoardDAO.insertCmmnBoardOne(boardVO);
			
			// 로그 set
			brdType = boardVO.getBrdType();
			brdSeq = boardVO.getBrdTitle();
			logJob = "게시글 등록";
			
			searchVO.setMessage("등록되었습니다.");
		}else {
			// 수정
			admBoardDAO.updateCmmnBoardOne(boardVO, searchVO.getSearchType());
			
			// 로그 set
			brdType = boardVO.getBrdType();
			brdSeq = boardVO.getBrdSeq();
			logJob = "게시글 수정";
			
			rsBrdSeq=boardVO.getBrdSeq();
			searchVO.setMessage("수정되었습니다.");
		}
		
		// 첨부파일
		List<FileInfoVO> fileInfoList = cmmnFileMngUtil.uploadAttachedFiles(multiRequest, "CNTST");
		for(FileInfoVO vo : fileInfoList){
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("fileInfoVO", vo);
			map.put("brdSeq", rsBrdSeq);
			admBoardDAO.insertCmmnBoardUpfileOne(map);
		}
		// 첨부파일 삭제
		if (!EgovStringUtil.isEmpty(boardVO.getFileDeleteChk())) {
			String[] arrUpSeq = (boardVO.getFileDeleteChk()).split(",");
			List<String> upSeqList = new ArrayList<>();
			for(String upSeq : arrUpSeq){
				EgovMap upfile = admBoardDAO.selectCmmnBoardUpfileOne(upSeq);
				cmmnFileMngUtil.deleteFile(upfile.get("upSaveFilePath").toString());	// 파일 삭제
				upSeqList.add(upSeq);
			}
			admBoardDAO.deleteCmmnBoardUpfileList(upSeqList); // 데이터 삭제
		}
	
		// 로그 등록
		String ip = request.getHeader("X-FORWARDED-FOR");
        if (ip == null) ip = request.getRemoteAddr();
        admCmmLogDAO.insertLogOne_cmm(brdType, brdSeq, logJob, ip);
        
		return redirectListPage(searchVO, reda);
	}
	
	//조회
	@RequestMapping("/xabdmxgr/boardMng/cntst/admBoardMngCntstView.do")
	public String admBoardMngCntstView(ModelMap model, @RequestParam("brdSeq")String brdSeq, @ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request, RedirectAttributes reda)throws Exception{
		LOGGER.info("/xabdmxgr/boardMng/cntst/admBoardMngCntstView.do - 관리자 > 게시판관리 > 대회자료실 조회");
		LOGGER.debug("brdSeq - "+brdSeq);
		LOGGER.debug("searchVO - "+searchVO);
		
		BoardVO boardVO=admBoardDAO.selectCmmnBoardOne(brdSeq);
		
		// 로그 등록
		String ip = request.getHeader("X-FORWARDED-FOR");
        if (ip == null) ip = request.getRemoteAddr();
		admCmmLogDAO.insertLogOne_cmm(searchVO.getSearchType(), brdSeq, "게시글 조회", ip);
		List<EgovMap> listVO=admBoardDAO.selectCmmnBoardUpfileList(brdSeq);
		
		if (boardVO == null) {
			searchVO.setMessage("선택한글이 없습니다.");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		
		model.addAttribute("listVO",listVO);
		model.addAttribute("boardVO",boardVO);
		
		return "/adm/boardMng/cntst/admBoardMngContestView";
	}
	
	//삭제
	@RequestMapping("/xabdmxgr/boardMng/cntst/admBoardMngCntstDelete.do")
	public String admBoardMngCntstDelete(ModelMap model, RedirectAttributes reda, @ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request, String brdSeq)throws Exception{
		LOGGER.info("/xabdmxgr/boardMng/cntst/admBoardMngCntstDelete.do - 관리자 > 게시판관리 > 대회자료실 삭제");
		LOGGER.debug("searchVO - "+searchVO);
		LOGGER.debug("brdSeq - "+brdSeq);
		
		String brdSeqs[]=brdSeq.split(",");
		// 첨부파일 삭제
		for(int i=0;i<brdSeqs.length;i++){
			LOGGER.debug("brdSeqs - "+brdSeqs[i]);
			
			List<EgovMap> upfileList = admBoardDAO.selectCmmnBoardUpfileList(brdSeqs[i]);
			if(!(upfileList.size()==0 || upfileList==null)){
				List<String> upSeqList = new ArrayList<>();
				for(EgovMap upfile : upfileList){
					cmmnFileMngUtil.deleteFile(upfile.get("upSaveFilePath").toString());	// 파일 삭제
					upSeqList.add(upfile.get("upSeq").toString());
				}
				admBoardDAO.deleteCmmnBoardUpfileList(upSeqList); // 데이터 삭제
			}
			admBoardDAO.deleteCmmnBoardOne(brdSeqs[i]);        // 주제 삭제
			
			// 로그 등록
			String ip = request.getHeader("X-FORWARDED-FOR");
	        if (ip == null) ip = request.getRemoteAddr();
			admCmmLogDAO.insertLogOne_cmm(searchVO.getSearchType(), brdSeq, "게시글 삭제", ip);
		}
		
		searchVO.setMessage("삭제되었습니다.");
		
		return redirectListPage(searchVO, reda);
	}
	/* ************************************ 대회자료실 END ************************************ */
	
	/* ************************************ 대회관리 START ************************************ */
	private String redirectMngListPage(CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("searchVO", searchVO);
		
		String redirectPage = "";
		redirectPage = "redirect:/xabdmxgr/boardMng/cntst/admBoardMngContestMngList.do";		// 목록
		
		return redirectPage;
	}
	
	@RequestMapping("/xabdmxgr/boardMng/cntst/admBoardMngContestMngList.do")
	public String admBoardMngContestMngList(@ModelAttribute("searchVO") CmmnSearchVO searchVO,ModelMap model, HttpServletRequest request )throws Exception{
		LOGGER.info("/xabdmxgr/boardMng/cntst/admBoardMngContestMngList.do - 관리자 > 게시판관리 > 대회관리 목록");
		LOGGER.debug("searchVO - "+searchVO);
		request.getSession().setAttribute("admMenuNo", "409");
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchType())){
			searchVO.setSearchType("CONWRITE");
		}
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO=admBoardDAO.selectCmmnBoardList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo",paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		return "/adm/boardMng/cntst/admBoardMngContestMngList";
	}
	
	@RequestMapping("/xabdmxgr/boardMng/cntst/admBoardMngContestMngModify.do")
	public String admBoardMngContestMngModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpServletRequest request, String brdSeq)throws Exception{
		LOGGER.info("/xabdmxgr/boardMng/cntst/admBoardMngContestMngModify.do - 관리자 > 게시판관리 > 대회관리등록화면");
		LOGGER.info("brdSeq = " + brdSeq);
		
		BoardVO boardVO = new BoardVO();
		
		if(!EgovStringUtil.isEmpty(brdSeq)){
			boardVO = admBoardDAO.selectCmmnBoardOne(brdSeq);
		}
		
		model.addAttribute("boardVO", boardVO);
		
		return "/adm/boardMng/cntst/admBoardMngContestMngModify";
	}

	@RequestMapping("/xabdmxgr/boardMng/cntst/admBoardMngContestMngUpdate.do")
	public String admBoardMngContestMngUpdate(@ModelAttribute("searchVO") CmmnSearchVO searchVO, BoardVO boardVO, ModelMap model, HttpServletRequest request, RedirectAttributes reda)throws Exception{
		LOGGER.info("/xabdmxgr/boardMng/cntst/admBoardMngContestMngUpdate.do - 관리자 > 게시판관리 > 대회관리등록");
		LOGGER.info("boardVO = " + boardVO.toString());
		String message = "";
		
		if(!EgovStringUtil.isEmpty(boardVO.getBrdSeq())){
			admBoardDAO.updateCmmnBoardOne(boardVO, boardVO.getBrdType());
			message = "수정이 완료되었습니다.";
		}else{
			admBoardDAO.insertCmmnBoardOne(boardVO);
			message = "등록이 완료되었습니다.";
		}
		
		searchVO.setMessage(message);
		return redirectMngListPage(searchVO, reda);
	}
	
	private String redirectWriteListPage(CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("searchVO", searchVO);
		
		String redirectPage = "";
		redirectPage = "redirect:/xabdmxgr/boardMng/cntst/admBoardMngWriteAplyList.do";		// 목록
		
		return redirectPage;
	}

	private String redirectPptListPage(CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("searchVO", searchVO);
		
		String redirectPage = "";
		redirectPage = "redirect:/xabdmxgr/boardMng/cntst/admBoardMngPptAplyList.do";		// 목록
		
		return redirectPage;
	}
	
	@RequestMapping("/xabdmxgr/boardMng/cntst/admBoardMngWriteAplyList.do")
	public String admBoardMngWriteAplyList(@ModelAttribute("searchVO") CmmnSearchVO searchVO,ModelMap model, HttpServletRequest request )throws Exception{
		LOGGER.info("/xabdmxgr/boardMng/cntst/admBoardMngWriteAplyList.do - 관리자 > 게시판관리 > 신청자(글쓰기대회) 목록");
		LOGGER.debug("searchVO - "+searchVO);
		request.getSession().setAttribute("admMenuNo", "406");
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchType())){
			searchVO.setSearchType("WRITE");
		}
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO=admBoardDAO.selectCmmnBoardAplyList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo",paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		return "/adm/boardMng/cntst/admBoardMngWriteAplyList";
	}

	@RequestMapping("/xabdmxgr/boardMng/cntst/admBoardMngPptAplyList.do")
	public String admBoardMngPptAplyList(@ModelAttribute("searchVO") CmmnSearchVO searchVO,ModelMap model, HttpServletRequest request )throws Exception{
		LOGGER.info("/xabdmxgr/boardMng/cntst/admBoardMngPptAplyList.do - 관리자 > 게시판관리 > 신청자(PT대회) 목록");
		LOGGER.debug("searchVO - "+searchVO);
		request.getSession().setAttribute("admMenuNo", "407");
		
		if(EgovStringUtil.isEmpty(searchVO.getSearchType())){
			searchVO.setSearchType("PPT");
		}
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO=admBoardDAO.selectCmmnBoardAplyList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo",paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		return "/adm/boardMng/cntst/admBoardMngPptAplyList";
	}
	
	//조회
	@RequestMapping("/xabdmxgr/boardMng/cntst/admBoardMngWriteAplyView.do")
	public String admBoardMngWriteAplyView(ModelMap model, @RequestParam("aplySeq")String aplySeq, @ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request, RedirectAttributes reda)throws Exception{
		LOGGER.info("/xabdmxgr/boardMng/cntst/admBoardMngWriteAplyView.do - 관리자 > 게시판관리 > 신청자(글쓰기대회) 조회");
		LOGGER.debug("aplySeq - "+aplySeq);
		LOGGER.debug("searchVO - "+searchVO);
		
		CntstApplyVO cntstApplyVO=admBoardDAO.selectCmmnBoardAplyOne(aplySeq);
		
		if (cntstApplyVO == null) {
			searchVO.setMessage("선택한글이 없습니다.");
			LOGGER.debug(searchVO.getMessage());
			return redirectWriteListPage(searchVO, reda);
		}
		
		model.addAttribute("cntstApplyVO",cntstApplyVO);
		
		return "/adm/boardMng/cntst/admBoardMngWriteAplyView";
	}

	//조회
	@RequestMapping("/xabdmxgr/boardMng/cntst/admBoardMngPptAplyView.do")
	public String admBoardMngPptAplyView(ModelMap model, @RequestParam("aplySeq")String aplySeq, @ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request, RedirectAttributes reda)throws Exception{
		LOGGER.info("/xabdmxgr/boardMng/cntst/admBoardMngPptAplyView.do - 관리자 > 게시판관리 > 신청자(PT대회) 조회");
		LOGGER.debug("aplySeq - "+aplySeq);
		LOGGER.debug("searchVO - "+searchVO);
		
		CntstApplyVO cntstApplyVO=admBoardDAO.selectCmmnBoardAplyOne(aplySeq);
		
		BoardVO boardVO = admBoardDAO.selectCmmnBoardOne(cntstApplyVO.getBrdSeq());
		model.addAttribute("boardVO", boardVO);
		
		if (cntstApplyVO == null) {
			searchVO.setMessage("선택한글이 없습니다.");
			LOGGER.debug(searchVO.getMessage());
			return redirectWriteListPage(searchVO, reda);
		}
		
		model.addAttribute("cntstApplyVO",cntstApplyVO);
		
		return "/adm/boardMng/cntst/admBoardMngPptAplyView";
	}

	@RequestMapping("/xabdmxgr/boardMng/cntst/admBoardMngWriteAplyDelete.do")
	public String admBoardMngWriteAplyDelete(ModelMap model, @RequestParam("aplySeq")String aplySeq, @ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request, RedirectAttributes reda)throws Exception{
		LOGGER.info("/xabdmxgr/boardMng/cntst/admBoardMngWriteAplyDelete.do - 관리자 > 게시판관리 > 신청자(글쓰기대회) 삭제");
		LOGGER.debug("aplySeq - "+aplySeq);
		LOGGER.debug("searchVO - "+searchVO);
		
		admBoardDAO.selectCmmnBoardAplyDelete(aplySeq);
		
		searchVO.setMessage("삭제되었습니다.");
		
		return redirectWriteListPage(searchVO, reda);
	}

	@RequestMapping("/xabdmxgr/boardMng/cntst/admBoardMngPptAplyDelete.do")
	public String admBoardMngPptAplyDelete(ModelMap model, @RequestParam("aplySeq")String aplySeq, @ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request, RedirectAttributes reda)throws Exception{
		LOGGER.info("/xabdmxgr/boardMng/cntst/admBoardMngPptAplyDelete.do - 관리자 > 게시판관리 > 신청자(PT대회) 삭제");
		LOGGER.debug("aplySeq - "+aplySeq);
		LOGGER.debug("searchVO - "+searchVO);
		
		admBoardDAO.selectCmmnBoardAplyDelete(aplySeq);
		
		searchVO.setMessage("삭제되었습니다.");
		
		return redirectPptListPage(searchVO, reda);
	}
	
	// 엑셀 다운로드
	@RequestMapping("/xabdmxgr/boardMng/cntst/admBoardMngWriteAplyExcel.do")
	public View admBoardMngWriteAplyExcel(@ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.info("/xabdmxgr/boardMng/cntst/admBoardMngWriteAplyExcel.do - 관리자 > 게시판관리 > 신청자(글쓰기대회) 상담완료 엑셀 다운로드");
		
		searchVO.setSearchType("WRITE");
		
		List<EgovMap> resultList = admBoardDAO.selectCmmnBoardAplyExcel(searchVO);
		
		model.addAttribute("resultList", resultList);
		// jquery.fileDownload set
		response.setHeader("Set-Cookie","fileDownload=true; path=/");
		return new ExcelUtil("contestWriteList");
	}

	// 엑셀 다운로드
	@RequestMapping("/xabdmxgr/boardMng/cntst/admBoardMngPptAplyExcel.do")
	public View admBoardMngPptAplyExcel(@ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletResponse response, ModelMap model) throws Exception {
		LOGGER.info("/xabdmxgr/boardMng/cntst/admBoardMngPptAplyExcel.do - 관리자 > 게시판관리 > 신청자(PT대회) 엑셀 다운로드");
		
		searchVO.setSearchType("PPT");
		
		List<EgovMap> resultList = admBoardDAO.selectCmmnBoardAplyExcel(searchVO);
		
		model.addAttribute("resultList", resultList);
		// jquery.fileDownload set
		response.setHeader("Set-Cookie","fileDownload=true; path=/");
		return new ExcelUtil("contestPptList");
	}
	
	
	/* ************************************ 대회관리 END ************************************ */
}
