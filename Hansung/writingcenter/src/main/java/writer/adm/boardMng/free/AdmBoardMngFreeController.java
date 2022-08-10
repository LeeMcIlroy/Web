package writer.adm.boardMng.free;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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

import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.web.PaginationController;
import egovframework.com.cmm.web.EgovWebUtil;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import writer.adm.cmm.AdmCmmCmmtDAO;
import writer.adm.cmm.AdmCmmLogDAO;
import writer.adm.cmm.AdmCmmnBoardDAO;
import writer.valueObject.BoardVO;
import writer.valueObject.cmmn.CmmnCommentVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Controller
public class AdmBoardMngFreeController {

private static final Logger LOGGER = LoggerFactory.getLogger(AdmBoardMngFreeController.class);
	
	private String logJob;
	@Autowired private AdmCmmLogDAO admCmmLogDAO;
	@Autowired private AdmCmmnBoardDAO admBoardDAO;
	@Autowired private CmmnFileMngUtil cmmnFileMngUtil;
	@Autowired private AdmCmmCmmtDAO admCmmCmmtDAO;
	@Resource View jsonView;
	
	/*********************************** 공통 ***********************************/
	// 검색 조건을 가지고 목록페이지(조회_주제목록)로 이동합니다.
	private String redirectListPage(CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", searchVO.getMessage());
		reda.addFlashAttribute("searchVO", searchVO);
		
		String redirectPage = "";
		redirectPage = "redirect:/xabdmxgr/boardMng/free/admBoardMngFreeList.do";		// 목록
		
		return redirectPage;
		
	}
	
	/*********************************** 자유게시판 ***********************************/
	
	//목록
	@RequestMapping("/xabdmxgr/boardMng/free/admBoardMngFreeList.do")
	public String admBoardMngFreeList(ModelMap model, HttpServletRequest request, @ModelAttribute("searchVO") CmmnSearchVO searchVO)throws Exception{
		searchVO.setSearchType("FREE");
		LOGGER.info("/xabdmxgr/boardMng/free/admBoardMngFreeList.do - 관리자 > 게시판관리 > 자유게시판 목록");
		LOGGER.debug("searchVO - "+searchVO);
		request.getSession().setAttribute("admMenuNo", "404");
		
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO=admBoardDAO.selectCmmnBoardList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo",paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		return "/adm/boardMng/free/admBoardMngFreeList";
	}
	

	//글쓰기 & 수정 화면
	@RequestMapping("/xabdmxgr/boardMng/free/admBoardMngFreeModifyView.do")
	public String admBoardMngFreeModifyView(ModelMap model, @RequestParam("brdSeq")String brdSeq,  @ModelAttribute("searchVO") CmmnSearchVO searchVO)throws Exception{
		LOGGER.info("/xabdmxgr/boardMng/free/admBoardMngFreeModifyView.do - 관리자 > 게시판관리 > 자유게시판 글쓰기 & 화면");
		LOGGER.debug("brdSeq="+brdSeq);
		LOGGER.debug("searchVO - "+searchVO);
		BoardVO boardVO = null;
		if (EgovStringUtil.isEmpty(brdSeq)) {
			// 등록화면
			boardVO = new BoardVO();
		}else {
			// 수정화면
			boardVO = admBoardDAO.selectCmmnBoardOne(brdSeq);
			model.addAttribute("boardUpfileList",admBoardDAO.selectCmmnBoardUpfileList(brdSeq));
		}
		
		model.addAttribute("boardVO", boardVO);
		
		return "/adm/boardMng/free/admBoardMngFreeModify";
	}
	
	
	//글쓰기 & 수정
	@RequestMapping("/xabdmxgr/boardMng/free/admBoardMngFreeModify.do")
	public String admFreeUpdate(ModelMap model, BoardVO boardVO, @ModelAttribute("searchVO") CmmnSearchVO searchVO, MultipartHttpServletRequest multiRequest, HttpServletRequest request, RedirectAttributes reda)throws Exception{
		LOGGER.info("/xabdmxgr/boardMng/free/admBoardMngFreeModify.do - 관리자 > 게시판관리 > 자유게시판 글쓰기 수정");
		LOGGER.debug("boardVO - "+boardVO.toString());
		LOGGER.debug("searchVO - "+searchVO.toString());
		//제목 및 내용 입력여부 확인
		if(EgovStringUtil.isEmpty(boardVO.getBrdTitle()) || EgovStringUtil.isEmpty(boardVO.getBrdContent())){
			searchVO.setMessage("제목 또는 내용이 없습니다");
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

		boardVO.setBrdType("FREE");
		boardVO.setBrdNoticeYn("N");
		
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
		List<FileInfoVO> fileInfoList = cmmnFileMngUtil.uploadAttachedFiles(multiRequest, "FREE");
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
	@RequestMapping("/xabdmxgr/boardMng/free/admBoardMngFreeView.do")
	public String admBoardMngFreeView(ModelMap model, @RequestParam("brdSeq")String brdSeq, @RequestParam(defaultValue="1") String pageCmmtIndex, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, RedirectAttributes reda)throws Exception{
		LOGGER.info("/xabdmxgr/boardMng/free/admBoardMngFreeView.do - 관리자 > 게시판관리 > 자유게시판 조회");
		LOGGER.debug("brdSeq - "+brdSeq);
		LOGGER.debug("searchVO - "+searchVO);
		
		BoardVO boardVO=admBoardDAO.selectCmmnBoardOne(brdSeq);
		
		List<EgovMap> listVO=admBoardDAO.selectCmmnBoardUpfileList(brdSeq);
		
		if (boardVO == null) {
			searchVO.setMessage("선택한글이 없습니다.");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		
		boardVO.setBrdContent(EgovWebUtil.clearXSSMinimum(boardVO.getBrdContent()).replaceAll("\r\n", "<br/>"));
		model.addAttribute("boardVO", boardVO);
		
		// 댓글
		CmmnListVO cmmtListVO = admCmmCmmtDAO.selectBoardMngFreeCommentList(brdSeq, pageCmmtIndex);
		model.addAttribute("cmmtListCnt", cmmtListVO.getTotalRecordCount());
		
		for(EgovMap vo : cmmtListVO.getEgovList()){
			vo.put("cmtContent", (EgovWebUtil.clearXSSMinimum(vo.get("cmtContent").toString()).replaceAll("\r\n", "<br>")));
		}
				
		model.addAttribute("cmmtList", cmmtListVO.getEgovList());
		
		model.addAttribute("listVO",listVO);
		
		// 로그 등록
		String ip = request.getHeader("X-FORWARDED-FOR");
	    if (ip == null) ip = request.getRemoteAddr();
		admCmmLogDAO.insertLogOne_cmm(searchVO.getSearchType(), brdSeq, "게시글 조회", ip);
		
		return "/adm/boardMng/free/admBoardMngFreeView";
	}
	
	//삭제
	@RequestMapping("/xabdmxgr/boardMng/free/admBoardMngFreeDelete.do")
	public String admBoardMngFreeDelete(ModelMap model, RedirectAttributes reda, @ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request, String brdSeq)throws Exception{
		LOGGER.info("/xabdmxgr/boardMng/free/admBoardMngFreeDelete.do - 관리자 > 게시판관리 > 자유게시판 삭제");
		LOGGER.debug("searchVO - "+searchVO);
		LOGGER.debug("brdSeq - "+brdSeq);
		
		String brdSeqs[]=brdSeq.split(",");
		// 첨부파일 삭제
		for(int i=0;i<brdSeqs.length;i++){
			LOGGER.debug("brdSeqs - "+brdSeqs[i]);
			admBoardDAO.deleteCmmnBoardOne(brdSeqs[i]);        // 주제 삭제
			
			// 로그 등록
			String ip = request.getHeader("X-FORWARDED-FOR");
		    if (ip == null) ip = request.getRemoteAddr();
			admCmmLogDAO.insertLogOne_cmm(searchVO.getSearchType(), brdSeq, "게시글 삭제", ip);
		}
		
		searchVO.setMessage("삭제되었습니다.");
		
		return redirectListPage(searchVO, reda);
	}
	// 과제 댓글 더보기
	@RequestMapping("/xabdmxgr/boardMng/free/boardMngFreeCommentAddList.do")
	public View boardMngFreeCommentAddList(@RequestParam String brdSeq, @RequestParam String pageCmmtIndex, ModelMap model) throws Exception {
		LOGGER.info("/xabdmxgr/boardMng/free/boardMngFreeCommentAddList.do - 자유게시판 > 댓글 더보기");
		LOGGER.debug("hmwkSeq = "+brdSeq+", pageCmmtIndex = "+pageCmmtIndex);
		
		CmmnListVO cmmtListVO = admCmmCmmtDAO.selectBoardMngFreeCommentList(brdSeq, pageCmmtIndex);
		model.addAttribute("cmmtList", cmmtListVO.getEgovList());
		return jsonView;
	}
	
	// 과제 댓글 등록
	@RequestMapping("/xabdmxgr/boardMng/free/boardMngFreeCommentInsert.do")
	public String boardMngFreeCommentInsert(CmmnCommentVO commentVO, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda, HttpServletRequest request) throws Exception {
		LOGGER.info("/xabdmxgr/boardMng/free/boardMngFreeCommentInsert.do - 자유게시판 > 댓글 등록");
		LOGGER.debug("commentVO = "+commentVO.toString());
		
		if (EgovStringUtil.isEmpty(commentVO.getCmtContent()) || EgovStringUtil.isEmpty(commentVO.getBrdSeq())) {
			searchVO.setMessage("내용 또는 원글 번호가 없습니다.(cmtContent = "+commentVO.getCmtContent()+", BrdSeq = "+commentVO.getBrdSeq()+")");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		// 등록
		admCmmCmmtDAO.boardMngFreeCommentInsert(commentVO);
		
		// 로그 등록
		String ip = request.getHeader("X-FORWARDED-FOR");
        if (ip == null) ip = request.getRemoteAddr();
		logJob="자유게시판 댓글 등록";
		admCmmLogDAO.insertLogOne(logJob, ip);
		reda.addFlashAttribute("message", "댓글이 등록되었습니다.");
		reda.addFlashAttribute("searchVO", searchVO);
		reda.addAttribute("brdSeq", commentVO.getBrdSeq());
		return "redirect:/xabdmxgr/boardMng/free/admBoardMngFreeView.do";
	}
	
	
	// 과제 댓글 삭제
	@RequestMapping("/xabdmxgr/boardMng/free/boardMngFreeCommentDelete.do")
	public String boardMngFreeCommentDelete(@RequestParam String cmtSeq, @RequestParam String brdSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request, RedirectAttributes reda) throws Exception {
		LOGGER.info("/xabdmxgr/boardMng/free/boardMngFreeCommentDelete.do - 자유게시판 > 댓글 삭제");
		LOGGER.debug("cmtSeq = "+cmtSeq+", brdSeq = "+brdSeq);
		
		// 삭제
		admCmmCmmtDAO.boardMngFreeCommentDelete(cmtSeq);
		
		// 로그 등록
		String ip = request.getHeader("X-FORWARDED-FOR");
        if (ip == null) ip = request.getRemoteAddr();
		logJob="과제 댓글 삭제("+cmtSeq+")";
		admCmmLogDAO.insertLogOne(logJob, ip);
		reda.addFlashAttribute("message", "댓글이 삭제되었습니다.");
		reda.addFlashAttribute("searchVO", searchVO);
		reda.addAttribute("brdSeq", brdSeq);
		return "redirect:/xabdmxgr/boardMng/free/admBoardMngFreeView.do";		
	}
}

