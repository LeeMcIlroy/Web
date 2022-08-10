package hsDesign.adm.cmmBoard;


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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.util.ComStringUtil;
import component.web.PaginationController;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.cmm.web.EgovWebUtil;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import hsDesign.adm.cmm.AdmCmmController;
import hsDesign.adm.majorBoard.AdmMajorBoardDAO;
import hsDesign.valueObject.CBCommentVO;
import hsDesign.valueObject.CBUpfileVO;
import hsDesign.valueObject.CmmBoardVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class AdmCmmBoardController extends AdmCmmController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AdmCmmBoardController.class);
	
	@Autowired private AdmCmmBoardDAO admCmmBoardDAO;
	@Autowired private AdmMajorBoardDAO admMajorBoardDAO ;
	@Autowired private CmmnFileMngUtil cmmnFileMngUtil;
	
	@Resource View jsonView;
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", message);
		reda.addAttribute("menuType", searchVO.getMenuType());
		reda.addAttribute("pageIndex", searchVO.getPageIndex());
		if(!EgovStringUtil.isEmpty(searchVO.getSearchCondition1())) reda.addAttribute("searchCondition1", searchVO.getSearchCondition1());
		if(!EgovStringUtil.isEmpty(searchVO.getSearchWord())) reda.addAttribute("searchWord", searchVO.getSearchWord());
		return "redirect:/qxerpynm/cmmBoard/admCmmBoardList.do";
	}
	
	// 검색조건을 가지고 조회로 이동합니다.
	private String redirectViewPage(String message, String cbSeq, CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", message);
		reda.addAttribute("menuType", searchVO.getMenuType());
		reda.addAttribute("pageIndex", searchVO.getPageIndex());
		reda.addAttribute("cbSeq", cbSeq);
		if(!EgovStringUtil.isEmpty(searchVO.getSearchCondition1())) reda.addAttribute("searchCondition1", searchVO.getSearchCondition1());
		if(!EgovStringUtil.isEmpty(searchVO.getSearchWord())) reda.addAttribute("searchWord", searchVO.getSearchWord());
		return "redirect:/qxerpynm/cmmBoard/admCmmBoardView.do";
	}
	
	// 페이지 설정
	private String setJspPath(String type, CmmnSearchVO searchVO, HttpSession session){
		String jspPath = "/";
		
		if("01".equals(searchVO.getMenuType()) || "0101".equals(searchVO.getMenuType()) || "0102".equals(searchVO.getMenuType())){
			if(session != null) session.setAttribute("admMenuNo", "201");
			jspPath = "/adm/enter/consult/admConsult"+type;
		}else if("02".equals(searchVO.getMenuType())){
			if(session != null) session.setAttribute("admMenuNo", "302");
			jspPath = "/adm/hdaCampus/qna/admQna"+type;
		}else if("0301".equals(searchVO.getMenuType())){
			if(session != null) session.setAttribute("admMenuNo", "301");
			jspPath = "/adm/hdaCampus/faq/admFaq"+type;
		}else if("0401".equals(searchVO.getMenuType())){
			if(session != null) session.setAttribute("admMenuNo", "304");
			jspPath = "/adm/hdaCampus/form/admForm"+type;
		}else if("0501".equals(searchVO.getMenuType())){
			if(session != null) session.setAttribute("admMenuNo", "305");
			jspPath = "/adm/news/notice/admNotice"+type;
		}else if("0601".equals(searchVO.getMenuType())){
			if(session != null) session.setAttribute("admMenuNo", "402");
			jspPath = "/adm/news/proud/admProud"+type;
		}else if("0701".equals(searchVO.getMenuType())){
			if(session != null) session.setAttribute("admMenuNo", "403");
			jspPath = "/adm/news/festival/admFestival"+type;
		}else if("0801".equals(searchVO.getMenuType())){
			if(session != null) session.setAttribute("admMenuNo", "404");
			jspPath = "/adm/news/ucc/admUcc"+type;
		}else if("0901".equals(searchVO.getMenuType())){
			if(session != null) session.setAttribute("admMenuNo", "502");
			jspPath = "/adm/general/request/admRequest"+type;
		}else if("0902".equals(searchVO.getMenuType())){
			if(session != null) session.setAttribute("admMenuNo", "507");
			jspPath = "/adm/general/question/admQuestion"+type;
		}else if("1001".equals(searchVO.getMenuType())){
			if(session != null) session.setAttribute("admMenuNo", "303");
			jspPath = "/adm/hdaCampus/smg/admSmg"+type;
		}else if("1101".equals(searchVO.getMenuType())){
			if(session != null) session.setAttribute("admMenuNo", "10A");
			jspPath = "/adm/customer/admCustomer"+type;
		
//	200408추가
		}else if("0602".equals(searchVO.getMenuType())){
			if(session != null) session.setAttribute("admMenuNo", "406");
			jspPath = "/adm/news/archive/admArchive"+type;
		}else if("0603".equals(searchVO.getMenuType())){
			if(session != null) session.setAttribute("admMenuNo", "407");
			jspPath = "/adm/news/overseas/admOverseas"+type;
		}else if("0604".equals(searchVO.getMenuType())){
			if(session != null) session.setAttribute("admMenuNo", "408");
			jspPath = "/adm/news/employment/admEmploy"+type;
		}else if("0605".equals(searchVO.getMenuType())){
			if(session != null) session.setAttribute("admMenuNo", "409");
			jspPath = "/adm/news/linked/admLinked"+type;
//		200420추가
		}else if("0610".equals(searchVO.getMenuType())){
			if(session != null) session.setAttribute("admMenuNo", "4010");
			jspPath = "/adm/news/oveStud/admOveStud"+type;
		}else if("0611".equals(searchVO.getMenuType())){
			if(session != null) session.setAttribute("admMenuNo", "4011");
			jspPath = "/adm/news/oveServ/admOveServ"+type;
		}
		return jspPath;
	}
	
	// 목록
	@RequestMapping("/qxerpynm/cmmBoard/admCmmBoardList.do")
	public String admCmmBoardList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request) throws Exception {
		LOGGER.debug("/qxerpynm/cmmBoard/admCmmBoardList.do - 관리자 > 공통 게시판 > 목록");
		LOGGER.debug("searchVO = "+searchVO.toString());
		
		// 페이지 설정
		String jspPath = setJspPath("List", searchVO, session);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO , 10, 10);
		if(EgovStringUtil.isEmpty(searchVO.getSearchWord())){
			if(
				"01".equals(searchVO.getMenuType()) || "0101".equals(searchVO.getMenuType()) || "0102".equals(searchVO.getMenuType()) ||
				"02".equals(searchVO.getMenuType()) || "0501".equals(searchVO.getMenuType()) || "1001".equals(searchVO.getMenuType())
			){
				searchVO.setSearchType("Y");
				CmmnListVO ntListVO = admCmmBoardDAO.selectCmmBoardList(searchVO);
				model.addAttribute("ntResultList", ntListVO.getEgovList());
				
				searchVO.setSearchType("N");
			}
		}
		
		CmmnListVO listVO = admCmmBoardDAO.selectCmmBoardList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", listVO.getEgovList());
		
		// 로그등록
		String logPath = "";
		if("01".equals(searchVO.getMenuType()) || "0101".equals(searchVO.getMenuType()) || "0102".equals(searchVO.getMenuType())){
			logPath = "입학상담";
		}else if("02".equals(searchVO.getMenuType())){
			logPath = "학사QNA";
		}else if("0301".equals(searchVO.getMenuType())){
			logPath = "학사FAQ";
		}else if("0401".equals(searchVO.getMenuType())){
			logPath = "양식자료실";
		}else if("0501".equals(searchVO.getMenuType())){
			logPath = "공지사항";
		}else if("0601".equals(searchVO.getMenuType())){
			logPath = "한디원 이슈";
		}else if("0701".equals(searchVO.getMenuType())){
			logPath = "한디원행사";
		}else if("0801".equals(searchVO.getMenuType())){
			logPath = "작품동영상&UCC";
		}else if("0901".equals(searchVO.getMenuType())){
			logPath = "교양수강문의";
		}else if("0902".equals(searchVO.getMenuType())){
			logPath = "교양개설문의";
		}else if("1001".equals(searchVO.getMenuType())){
			logPath = "한디원신문고";
		}else if("1101".equals(searchVO.getMenuType())){
			logPath = "고객센터";
		}else if("1201".equals(searchVO.getMenuType())){
			logPath = "기업연계수업";
			
//		200408추가
		}else if("0602".equals(searchVO.getMenuType())){
			logPath = "작품자료실";
		}else if("0603".equals(searchVO.getMenuType())){
			logPath = "해외인턴십";
		}else if("0604".equals(searchVO.getMenuType())){
			logPath = "취업프로그램";
		}else if("0605".equals(searchVO.getMenuType())){
			logPath = "기업 · 지역연계수업 현황";
			
//			200420추가
		}else if("0610".equals(searchVO.getMenuType())){
			logPath = "해외연수";
		}else if("0611".equals(searchVO.getMenuType())){
			logPath = "해외봉사";
		}

		admLogInsert(null, "공통게시판-"+logPath, "목록", request);
		
		return jspPath;
	}
	
	// 조회
	@RequestMapping("/qxerpynm/cmmBoard/admCmmBoardView.do")
	public String admCmmBoardView(@RequestParam String cbSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda, HttpServletRequest request) throws Exception {
		LOGGER.debug("/qxerpynm/cmmBoard/admCmmBoardView.do - 관리자 > 공통게시판 > 조회");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("cbSeq = "+cbSeq);
		
		// 페이지 설정
		String jspPath = setJspPath("View", searchVO, null);
		
		// 글 조회
		CmmBoardVO cmmBoardVO = admCmmBoardDAO.selectCmmBoardOne(cbSeq);
		
		//컨텐트 뷰로 뿌려줘야하니까
		if(cmmBoardVO == null){
			LOGGER.debug("/qxerpynm/cmmBoard/admCmmBoardView.do - 오류발생(-1) : cmmBoardVO == null");
			return redirectListPage("오류발생(-1)", searchVO, reda);
		}
		
		cmmBoardVO.setCbContent(ComStringUtil.imgWidthHeightToMaxWidthHeight(cmmBoardVO.getCbContent())); // width, height 변경
		
		// 사용자가 작성한글에 대한 개행
		if(
				(
					"02".equals(searchVO.getMenuType())   ||
					"01".equals(searchVO.getMenuType())   || 
					"0101".equals(searchVO.getMenuType()) || 
					"0102".equals(searchVO.getMenuType()) ||
					"0901".equals(searchVO.getMenuType()) ||
					"0902".equals(searchVO.getMenuType()) 
				) && cmmBoardVO.getCbNoticeYn().equals("N")
		) {
			
			cmmBoardVO.setCbContent(cmmBoardVO.getCbContent().replaceAll("\r\n", "<br>"));
		}
				
		model.addAttribute("cmmBoardVO", cmmBoardVO);
		
		// 첨부파일
		CmmnListVO cbUpfileListVO = admCmmBoardDAO.selectCmmBoardUpfileList(cbSeq);
		model.addAttribute("cbUpfileList", cbUpfileListVO.getEgovList());
	
		// 댓글 목록
		CmmnSearchVO cmmtSearchVO = new CmmnSearchVO();
		cmmtSearchVO.setSearchWord(cmmBoardVO.getCbSeq());
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(cmmtSearchVO , 5, 5);
		CmmnListVO cmmtListVO = admCmmBoardDAO.selectCmmBoardCommentList(cmmtSearchVO);
		
		for(EgovMap list : cmmtListVO.getEgovList()) {
			list.put("cbcoContent", list.get("cbcoContent").toString().replaceAll("\r\n", "<br>"));
			
		}
		
		
		paginationInfo.setTotalRecordCount(cmmtListVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("cmmtResultList", cmmtListVO.getEgovList());
		
		model.addAttribute("cmmtSearchVO", cmmtSearchVO);
		
		// 로그등록
		String logPath = "";
		if("01".equals(searchVO.getMenuType()) || "0101".equals(searchVO.getMenuType()) || "0102".equals(searchVO.getMenuType())){
			logPath = "입학상담";
		}else if("02".equals(searchVO.getMenuType())){
			logPath = "학사QNA";
		}else if("0301".equals(searchVO.getMenuType())){
			logPath = "학사FAQ";
		}else if("0401".equals(searchVO.getMenuType())){
			logPath = "양식자료실";
		}else if("0501".equals(searchVO.getMenuType())){
			logPath = "공지사항";
		}else if("0601".equals(searchVO.getMenuType())){
			logPath = "자랑스러운 한디원";
		}else if("0701".equals(searchVO.getMenuType())){
			logPath = "한디원행사";
		}else if("0801".equals(searchVO.getMenuType())){
			logPath = "작품동영상&UCC";
		}else if("0901".equals(searchVO.getMenuType())){
			logPath = "교양수강문의";
		}else if("0902".equals(searchVO.getMenuType())){
			logPath = "교양개설문의";
		}else if("1001".equals(searchVO.getMenuType())){
			logPath = "한디원신문고";
		}else if("1101".equals(searchVO.getMenuType())){
			logPath = "고객센터";
		}else if("1201".equals(searchVO.getMenuType())){
			logPath = "기업연계수업";
			
//			200408추가
		}else if("0602".equals(searchVO.getMenuType())){
			logPath = "작품자료실";
		}else if("0603".equals(searchVO.getMenuType())){
			logPath = "해외인턴십";
		}else if("0604".equals(searchVO.getMenuType())){
			logPath = "취업프로그램";
		}else if("0605".equals(searchVO.getMenuType())){
			logPath = "기업 · 지역연계수업 현황";

//			200420추가
		}else if("0610".equals(searchVO.getMenuType())){
			logPath = "해외연수";
		}else if("0611".equals(searchVO.getMenuType())){
			logPath = "해외봉사";
		}
		
		admLogInsert(null, "공통게시판-"+logPath, cbSeq, request);
		
		return jspPath;
	}
	
	// 등록&수정화면
	@RequestMapping("/qxerpynm/cmmBoard/admCmmBoardModify.do")
	public String admCmmBoardModify(String cbSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpServletRequest request) throws Exception {
		LOGGER.debug("/qxerpynm/cmmBoard/admCmmBoardModify.do - 관리자 > 공통게시판 > 등록&수정화면");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("cbSeq = "+cbSeq);
		
		// 페이지 설정
		String jspPath = setJspPath("Modify", searchVO, null);
		
		CmmBoardVO cmmBoardVO = null;
		if(EgovStringUtil.isEmpty(cbSeq)){
			// 등록
			cmmBoardVO = new CmmBoardVO();
		}else{
			// 수정
			cmmBoardVO = admCmmBoardDAO.selectCmmBoardOne(cbSeq);
			
			// 첨부파일
			CmmnListVO cbUpfileListVO = admCmmBoardDAO.selectCmmBoardUpfileList(cbSeq);
			model.addAttribute("cbUpfileListVO", cbUpfileListVO);
		}

		List<EgovMap> majorList = admMajorBoardDAO.selectMajorList();
		model.addAttribute("majorList", majorList);
		
		model.addAttribute("cmmBoardVO", cmmBoardVO);
		return jspPath;
	}
	
	// 등록&수정
	@RequestMapping("/qxerpynm/cmmBoard/admCmmBoardUpdate.do")
	public String admCmmBoardUpdate(CmmBoardVO cmmBoardVO, String[] cbUpfileDelChk, String[] cbThImgDelChk, @ModelAttribute("searchVO") CmmnSearchVO searchVO, MultipartHttpServletRequest multiRequest, ModelMap model
				, RedirectAttributes reda, HttpServletRequest request) throws Exception {
		LOGGER.debug("/qxerpynm/cmmBoard/admCmmBoardUpdate.do - 관리자 > 공통게시판 > 등록&수정");
		LOGGER.debug("cmmBoardVO = "+cmmBoardVO.toString());
		
		String message = "";
		String rsCbSeq = "";
		if(EgovStringUtil.isEmpty(cmmBoardVO.getCbTitle().trim())) {
			LOGGER.debug("제목이 존재하지 않습니다.");
			message = "제목이 존재하지 않습니다.";
			return redirectListPage(message, searchVO, reda);
			
		}else if(EgovStringUtil.isEmpty(cmmBoardVO.getCbContent().trim())) {
			LOGGER.debug("내용이 존재하지 않습니다.");
			message = "내용이 존재하지 않습니다.";
			return redirectListPage(message, searchVO, reda);
		}
		
		
		// 파일 용량 검사
		if(!"0801".equals(searchVO.getMenuType())){
			if(!cmmnFileMngUtil.uploadFileSizeChk(multiRequest)){
				LOGGER.debug("/qxerpynm/cmmBoard/admCmmBoardUpdate.do - 오류발생(-4) : fileSize check...");
				return redirectListPage("오류발생(-4)", searchVO, reda);
			}
		}
		
		// 파일 확장자 검사
		if(!cmmnFileMngUtil.uploadFileExtChk(multiRequest)){
			LOGGER.debug("/qxerpynm/cmmBoard/admCmmBoardUpdate.do - 오류발생(-5) : fileExt check...");
			return redirectListPage("오류발생(-5)", searchVO, reda);
		}
		
		
		// 로그등록
		String logPath = "";
		if("01".equals(searchVO.getMenuType()) || "0101".equals(searchVO.getMenuType()) || "0102".equals(searchVO.getMenuType())){
			logPath = "입학상담";
		}else if("02".equals(searchVO.getMenuType())){
			logPath = "학사QNA";
		}else if("0301".equals(searchVO.getMenuType())){
			logPath = "학사FAQ";
		}else if("0401".equals(searchVO.getMenuType())){
			logPath = "양식자료실";
		}else if("0501".equals(searchVO.getMenuType())){
			logPath = "공지사항";
		}else if("0601".equals(searchVO.getMenuType())){
			logPath = "자랑스러운 한디원";
		}else if("0701".equals(searchVO.getMenuType())){
			logPath = "한디원행사";
		}else if("0801".equals(searchVO.getMenuType())){
			logPath = "작품동영상&UCC";
		}else if("0901".equals(searchVO.getMenuType())){
			logPath = "교양수강문의";
		}else if("0902".equals(searchVO.getMenuType())){
			logPath = "교양개설문의";
		}else if("1001".equals(searchVO.getMenuType())){
			logPath = "한디원신문고";
		}else if("1101".equals(searchVO.getMenuType())){
			logPath = "고객센터";
		}else if("1201".equals(searchVO.getMenuType())){
			logPath = "기업연계수업";
			
//		200408추가
		}else if("0602".equals(searchVO.getMenuType())){
			logPath = "작품자료실";
		}else if("0603".equals(searchVO.getMenuType())){
			logPath = "해외인턴십";
		}else if("0604".equals(searchVO.getMenuType())){
			logPath = "취업프로그램";
		}else if("0605".equals(searchVO.getMenuType())){
			logPath = "기업 · 지역연계수업 현황";

//			200420추가
		}else if("0610".equals(searchVO.getMenuType())){
			logPath = "해외연수";
		}else if("0611".equals(searchVO.getMenuType())){
			logPath = "해외봉사";
			
		}
		
		if(EgovStringUtil.isEmpty(cmmBoardVO.getCbSeq())){
			// 등록
			cmmBoardVO.setCbTitle(EgovWebUtil.clearXSSMinimum(cmmBoardVO.getCbTitle()));
			rsCbSeq = admCmmBoardDAO.cmmBoardInsert(cmmBoardVO);
			message = "등록되었습니다.";
			
			admLogInsert(null, "공통게시판-"+logPath, "등록", request);
			
		}else{
			// 수정
			//썸네일 사진 보이는 리스트
			if("0601".equals(searchVO.getMenuType()) || "0701".equals(searchVO.getMenuType()) || "1201".equals(searchVO.getMenuType())
				//200408 추가
				|| "0602".equals(searchVO.getMenuType()) || "0604".equals(searchVO.getMenuType()) || "0605".equals(searchVO.getMenuType())
					){

					if(!EgovStringUtil.isEmpty(cmmBoardVO.getCbThUrl()) && !cmmnFileMngUtil.uploadFileRegiChk(multiRequest) ||
						EgovStringUtil.isEmpty(cmmBoardVO.getCbThUrl()) && cmmnFileMngUtil.uploadFileRegiChk(multiRequest)){
						// 동영상 입력 || 첨부파일 신규등록
						
						CmmBoardVO rsCmmBoardVO = admCmmBoardDAO.selectCmmBoardOne(cmmBoardVO.getCbSeq());
						
						// 기존 파일 삭제 (기존 저장되있는 타입이 이미지일 경우)
						if("IMG".equals(rsCmmBoardVO.getCbThType())){
							cmmnFileMngUtil.deleteFile(rsCmmBoardVO.getCbThImgPath());
							
							// thumbnail 삭제
							if(!EgovStringUtil.isEmpty(rsCmmBoardVO.getCbThImgPath())){
								String fileExt = rsCmmBoardVO.getCbThImgPath().substring(rsCmmBoardVO.getCbThImgPath().lastIndexOf(".")+1);
								if(cmmnFileMngUtil.fileExtCheck(fileExt, "IMG")){
									String filePath = rsCmmBoardVO.getCbThImgPath().substring(0, rsCmmBoardVO.getCbThImgPath().lastIndexOf("."));
									String fileThumbPath = filePath.concat("_thumbnail").concat(".").concat(fileExt);
									cmmnFileMngUtil.deleteFile(fileThumbPath);
								}
							}
						}
						// 첨부파일 DB정보 삭제
						admCmmBoardDAO.cmmBoardThumbFileUpdate(new FileInfoVO("", ""), cmmBoardVO.getCbSeq());
	/*
					}else if(EgovStringUtil.isEmpty(cmmBoardVO.getCbThUrl()) && !cmmnFileMngUtil.uploadFileRegiChk(multiRequest)){
						// 기존 정보 변경 안함
	*/
					}
			//썸네일 사진 보이는 리스트 + 첨부파일기능
			}else if("0603".equals(searchVO.getMenuType()) || "0610".equals(searchVO.getMenuType()) || "0611".equals(searchVO.getMenuType())){
				if(cbThImgDelChk != null){
					if(!EgovStringUtil.isEmpty(cmmBoardVO.getCbThUrl()) && !cmmnFileMngUtil.uploadFileRegiChk(multiRequest) || 
						EgovStringUtil.isEmpty(cmmBoardVO.getCbThUrl()) && cmmnFileMngUtil.uploadFileRegiChk(multiRequest)){
						// 동영상 입력 || 첨부파일 신규등록
						CmmBoardVO rsCmmBoardVO = admCmmBoardDAO.selectCmmBoardOne(cmmBoardVO.getCbSeq());
						// 기존 파일 삭제 (기존 저장되있는 타입이 이미지일 경우)
							if("IMG".equals(rsCmmBoardVO.getCbThType())){
								cmmnFileMngUtil.deleteFile(rsCmmBoardVO.getCbThImgPath());
								// thumbnail 삭제
								if(!EgovStringUtil.isEmpty(rsCmmBoardVO.getCbThImgPath())){
									String fileExt = rsCmmBoardVO.getCbThImgPath().substring(rsCmmBoardVO.getCbThImgPath().lastIndexOf(".")+1);
									if(cmmnFileMngUtil.fileExtCheck(fileExt, "IMG")){
										String filePath = rsCmmBoardVO.getCbThImgPath().substring(0, rsCmmBoardVO.getCbThImgPath().lastIndexOf("."));
										String fileThumbPath = filePath.concat("_thumbnail").concat(".").concat(fileExt);
										cmmnFileMngUtil.deleteFile(fileThumbPath);
									}
								}
							}
						}
						// 첨부파일 DB정보 삭제
					admCmmBoardDAO.cmmBoardThumbFileUpdate(new FileInfoVO("", ""), cmmBoardVO.getCbSeq());
				}
				if(cbUpfileDelChk != null){
					// 첨부파일 삭제
					if(cbUpfileDelChk.length > 0){
						for (int i = 0; i < cbUpfileDelChk.length; i++) {
							CBUpfileVO cbUpfileVO = admCmmBoardDAO.selectCmmBoardUpfileOne(cbUpfileDelChk[i]);
							// 원본파일 삭제
							cmmnFileMngUtil.deleteFile(cbUpfileVO.getCbupSaveFilepath());
							
							// thumbnail 삭제
							String fileExt = cbUpfileVO.getCbupSaveFilepath().substring(cbUpfileVO.getCbupSaveFilepath().lastIndexOf(".")+1);
							if(cmmnFileMngUtil.fileExtCheck(fileExt, "IMG")){
								String filePath = cbUpfileVO.getCbupSaveFilepath().substring(0, cbUpfileVO.getCbupSaveFilepath().lastIndexOf("."));
								String fileThumbPath = filePath.concat("_thumbnail").concat(".").concat(fileExt);
								cmmnFileMngUtil.deleteFile(fileThumbPath);
							}
							
							// DB 삭제
							admCmmBoardDAO.cmmBoardUpfileDelete(cbUpfileDelChk[i]);			
						}
					}
				}
			//일반 리스트
			}else{
				if(cbUpfileDelChk != null){
					// 첨부파일 삭제
					if(cbUpfileDelChk.length > 0){
						for (int i = 0; i < cbUpfileDelChk.length; i++) {
							CBUpfileVO cbUpfileVO = admCmmBoardDAO.selectCmmBoardUpfileOne(cbUpfileDelChk[i]);
							// 원본파일 삭제
							cmmnFileMngUtil.deleteFile(cbUpfileVO.getCbupSaveFilepath());
							
							// thumbnail 삭제
							String fileExt = cbUpfileVO.getCbupSaveFilepath().substring(cbUpfileVO.getCbupSaveFilepath().lastIndexOf(".")+1);
							if(cmmnFileMngUtil.fileExtCheck(fileExt, "IMG")){
								String filePath = cbUpfileVO.getCbupSaveFilepath().substring(0, cbUpfileVO.getCbupSaveFilepath().lastIndexOf("."));
								String fileThumbPath = filePath.concat("_thumbnail").concat(".").concat(fileExt);
								cmmnFileMngUtil.deleteFile(fileThumbPath);
							}
							
							// DB 삭제
							admCmmBoardDAO.cmmBoardUpfileDelete(cbUpfileDelChk[i]);			
						}
					}
				}
			}
			
			
			cmmBoardVO.setCbTitle(EgovWebUtil.clearXSSMinimum(cmmBoardVO.getCbTitle()));
			admCmmBoardDAO.cmmBoardUpdate(cmmBoardVO);
			
			rsCbSeq = cmmBoardVO.getCbSeq();
			
			message = "수정되었습니다.";
			
			admLogInsert(null, "공통게시판-"+logPath+" 수정", rsCbSeq, request);
		}
		
		// 첨부파일 등록
		List<FileInfoVO> fileInfoList = cmmnFileMngUtil.totUploadFiles(multiRequest, "CMMBOARD");
		if(fileInfoList != null){
			for(FileInfoVO fileInfoVO : fileInfoList){
				if("0601".equals(searchVO.getMenuType()) || "0701".equals(searchVO.getMenuType()) || "1201".equals(searchVO.getMenuType())	
						|| "0602".equals(searchVO.getMenuType())|| "0604".equals(searchVO.getMenuType())	|| "0605".equals(searchVO.getMenuType())	){
					admCmmBoardDAO.cmmBoardThumbFileUpdate(fileInfoVO, rsCbSeq);
				}else if("0603".equals(searchVO.getMenuType()) || "0610".equals(searchVO.getMenuType()) || "0611".equals(searchVO.getMenuType())){
					String fileExt = fileInfoVO.getFilePath().substring(fileInfoVO.getFilePath().lastIndexOf(".")+1);
					if(cmmnFileMngUtil.fileExtCheck(fileExt, "IMG")){
						admCmmBoardDAO.cmmBoardThumbFileUpdate(fileInfoVO, rsCbSeq);
					}else{
						admCmmBoardDAO.cmmBoardUpfileInsert(fileInfoVO, rsCbSeq);
					}
				}else{
					admCmmBoardDAO.cmmBoardUpfileInsert(fileInfoVO, rsCbSeq);
				}
			}
		}
		
		return redirectListPage(message, searchVO, reda);
	}
	
	// 삭제
	@RequestMapping("/qxerpynm/cmmBoard/admCmmBoardDelete.do")
	public String admCmmBoardDelete(@RequestParam String cbSeq, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda, HttpServletRequest request) throws Exception {
		LOGGER.debug("/qxerpynm/cmmBoard/admCmmBoardDelete.do - 관리자 > 공통게시판 > 삭제");
		LOGGER.debug("searchVO = "+searchVO.toString());
		LOGGER.debug("cbSeq = "+cbSeq);
		
		if("0601".equals(searchVO.getMenuType()) || "0701".equals(searchVO.getMenuType()) 
				//200408추가
				|| "0602".equals(searchVO.getMenuType()) || "0604".equals(searchVO.getMenuType()) || "0605".equals(searchVO.getMenuType())){
			CmmBoardVO rsCmmBoardVO = admCmmBoardDAO.selectCmmBoardOne(cbSeq);
			
			// 기존 파일 삭제 (기존 저장되있는 타입이 이미지일 경우)
			if("IMG".equals(rsCmmBoardVO.getCbThType())){
				cmmnFileMngUtil.deleteFile(rsCmmBoardVO.getCbThImgPath());
				
				// thumbnail 삭제
				String fileExt = rsCmmBoardVO.getCbThImgPath().substring(rsCmmBoardVO.getCbThImgPath().lastIndexOf(".")+1);
				if(cmmnFileMngUtil.fileExtCheck(fileExt, "IMG")){
					String filePath = rsCmmBoardVO.getCbThImgPath().substring(0, rsCmmBoardVO.getCbThImgPath().lastIndexOf("."));
					String fileThumbPath = filePath.concat("_thumbnail").concat(".").concat(fileExt);
					cmmnFileMngUtil.deleteFile(fileThumbPath);
				}
			}
		}else if("0603".equals(searchVO.getMenuType()) || "0610".equals(searchVO.getMenuType()) || "0611".equals(searchVO.getMenuType()) ){
			CmmBoardVO rsCmmBoardVO = admCmmBoardDAO.selectCmmBoardOne(cbSeq);
			// 기존 파일 삭제 (기존 저장되있는 타입이 이미지일 경우)
			if("IMG".equals(rsCmmBoardVO.getCbThType())){
				cmmnFileMngUtil.deleteFile(rsCmmBoardVO.getCbThImgPath());
				// thumbnail 삭제
				String fileExt = rsCmmBoardVO.getCbThImgPath().substring(rsCmmBoardVO.getCbThImgPath().lastIndexOf(".")+1);
				if(cmmnFileMngUtil.fileExtCheck(fileExt, "IMG")){
					String filePath = rsCmmBoardVO.getCbThImgPath().substring(0, rsCmmBoardVO.getCbThImgPath().lastIndexOf("."));
					String fileThumbPath = filePath.concat("_thumbnail").concat(".").concat(fileExt);
					cmmnFileMngUtil.deleteFile(fileThumbPath);
				}
			}
			// 첨부파일 삭제
			CmmnListVO upFileListVO = admCmmBoardDAO.selectCmmBoardUpfileList(cbSeq);
			for(EgovMap upFile : upFileListVO.getEgovList()){
				// 원본파일 삭제
				String cbupSaveFilepath = upFile.get("cbupSaveFilepath").toString();
				cmmnFileMngUtil.deleteFile(cbupSaveFilepath);
				// thumbnail 삭제
				String fileExt = cbupSaveFilepath.substring(cbupSaveFilepath.lastIndexOf(".")+1);
				if(cmmnFileMngUtil.fileExtCheck(fileExt, "IMG")){
					String filePath = cbupSaveFilepath.substring(0, cbupSaveFilepath.lastIndexOf("."));
					String fileThumbPath = filePath.concat("_thumbnail").concat(".").concat(fileExt);
					cmmnFileMngUtil.deleteFile(fileThumbPath);
				}
				// DB 삭제
				admCmmBoardDAO.cmmBoardUpfileDelete(upFile.get("cbupSeq").toString());
			}
		}else{
			// 첨부파일 삭제
			CmmnListVO upFileListVO = admCmmBoardDAO.selectCmmBoardUpfileList(cbSeq);
			for(EgovMap upFile : upFileListVO.getEgovList()){
				// 원본파일 삭제
				String cbupSaveFilepath = upFile.get("cbupSaveFilepath").toString();
				cmmnFileMngUtil.deleteFile(cbupSaveFilepath);
				
				// thumbnail 삭제
				String fileExt = cbupSaveFilepath.substring(cbupSaveFilepath.lastIndexOf(".")+1);
				if(cmmnFileMngUtil.fileExtCheck(fileExt, "IMG")){
					String filePath = cbupSaveFilepath.substring(0, cbupSaveFilepath.lastIndexOf("."));
					String fileThumbPath = filePath.concat("_thumbnail").concat(".").concat(fileExt);
					cmmnFileMngUtil.deleteFile(fileThumbPath);
				}
				
				// DB 삭제
				admCmmBoardDAO.cmmBoardUpfileDelete(upFile.get("cbupSeq").toString());
			}
		}
		
		// 글 삭제
		admCmmBoardDAO.cmmBoardDelete(cbSeq);
		
		// 로그등록
		String logPath = "";
		if("01".equals(searchVO.getMenuType()) || "0101".equals(searchVO.getMenuType()) || "0102".equals(searchVO.getMenuType())){
			logPath = "입학상담";
		}else if("02".equals(searchVO.getMenuType())){
			logPath = "학사QNA";
		}else if("0301".equals(searchVO.getMenuType())){
			logPath = "학사FAQ";
		}else if("0401".equals(searchVO.getMenuType())){
			logPath = "양식자료실";
		}else if("0501".equals(searchVO.getMenuType())){
			logPath = "공지사항";
		}else if("0601".equals(searchVO.getMenuType())){
			logPath = "자랑스러운 한디원";
		}else if("0701".equals(searchVO.getMenuType())){
			logPath = "한디원행사";
		}else if("0801".equals(searchVO.getMenuType())){
			logPath = "작품동영상&UCC";
		}else if("0901".equals(searchVO.getMenuType())){
			logPath = "교양수강문의";
		}else if("0902".equals(searchVO.getMenuType())){
			logPath = "교양개설문의";
		}else if("1001".equals(searchVO.getMenuType())){
			logPath = "한디원신문고";
		}else if("1101".equals(searchVO.getMenuType())){
			logPath = "고객센터";
			
//			200408추가
		}else if("0602".equals(searchVO.getMenuType())){
			logPath = "작품자료실";
		}else if("0603".equals(searchVO.getMenuType())){
			logPath = "해외인턴십";
		}else if("0604".equals(searchVO.getMenuType())){
			logPath = "취업프로그램";
		}else if("0605".equals(searchVO.getMenuType())){
			logPath = "기업 · 지역연계수업 현황";
			
//			200420추가
		}else if("0610".equals(searchVO.getMenuType())){
			logPath = "해외연수";
		}else if("0611".equals(searchVO.getMenuType())){
			logPath = "해외봉사";
			
		}
		
		admLogInsert(null, "공통게시판-"+logPath+" 삭제", cbSeq, request);
		
		return redirectListPage("삭제되었습니다.", searchVO, reda);
	}
	//*************** 여기서부터 답글 등록 추가 *************************************************

	@RequestMapping("/qxerpynm/cmmBoard/admCmmBoardContentReply.do")
	public String admCmmBoardContentReply(CmmBoardVO CmmBoardVO, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda, HttpServletRequest request) throws Exception {
		LOGGER.debug("/qxerpynm/cmmBoard/admCmmBoardContentReply.do - 관리자 > 교양수강문의 > 답글 등록");
		LOGGER.debug("CmmBoardVO = "+CmmBoardVO.toString());
		
		String cbContentReply = request.getParameter("cbContentReply"); //답변 글
		String cbSeq = request.getParameter("cbSeq");

		if(EgovStringUtil.isEmpty(CmmBoardVO.getCbSeq())){
			LOGGER.debug("/qxerpynm/cmmBoard/admCmmBoardContentReply.do - 오류발생(-2) : CmmBoardVO.getCbSeq() is empty");
			return redirectListPage("오류발생(-2)", searchVO, reda);
		}if(EgovStringUtil.isEmpty(CmmBoardVO.getCbContentReply().trim())){
			LOGGER.debug("/qxerpynm/cmmBoard/admCmmBoardContentReply.do - 오류발생(-3) : CmmBoardVO.cbContentReply() is empty");
			return redirectListPage("오류발생(-3)", searchVO, reda);
		}
		
//		CmmBoardVO.setCbContentReply(EgovWebUtil.clearXSSMinimum(CmmBoardVO.getCbContentReply()));
//		String rsCbSeq = admCmmBoardDAO.cmmBoardContentReply(CmmBoardVO);
	
		// 이값을 가지고 1 서비스 쪽으로 가야지 그리고 이 값을 2 MAPPER를 통해 등록시킨후에 VIEW로
         CmmBoardVO.setCbContentReply(cbContentReply);
         CmmBoardVO.setCbSeq(cbSeq);
		admCmmBoardDAO.cmmBoardContentReply(CmmBoardVO);

		return redirectViewPage("답글이 등록되었습니다.", CmmBoardVO.getCbSeq(), searchVO, reda);
	}
	
	//*************** 끝 답글 등록 추가 *************************************************

	/***************************************************** 댓글 *****************************************************/
	// 목록 - 더보기
	@RequestMapping("/qxerpynm/cmmBoard/admCmmBoardCmmtAddList.do")
	public View admCmmBoardCmmtAddList(@RequestParam String cbSeq, @RequestParam String cmmtPageIndex, ModelMap model, HttpServletRequest request) throws Exception {
		LOGGER.debug("/qxerpynm/cmmBoard/admCmmBoardCmmtAddList.do - 관리자 > 공통게시판 > 댓글 목록 더보기");
		LOGGER.debug("cmmtPageIndex = "+cmmtPageIndex+"\ncbSeq = "+cbSeq);

		CmmnSearchVO cmmtSearchVO = new CmmnSearchVO();
		cmmtSearchVO.setPageIndex(Integer.parseInt(cmmtPageIndex));
		cmmtSearchVO.setSearchWord(cbSeq);
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(cmmtSearchVO , 5, 5);
		CmmnListVO cmmtListVO = admCmmBoardDAO.selectCmmBoardCommentList(cmmtSearchVO);
		
		for(EgovMap list : cmmtListVO.getEgovList()) {
			list.put("cbcoContent", list.get("cbcoContent").toString().replaceAll("\r\n", "<br>"));
			
		}
		
		model.addAttribute("cmmtResultList", cmmtListVO.getEgovList());
		
		
		// 로그등록
		
		admLogInsert(null, "공통게시판 댓글 목록", cbSeq, request);
		return jsonView;
	}
	
	// 등록
	@RequestMapping("/qxerpynm/cmmBoard/admCmmBoardCmmtInsert.do")
	public String admCmmBoardCmmtInsert(CBCommentVO cbCommentVO, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda, HttpServletRequest request) throws Exception {
		LOGGER.debug("/qxerpynm/cmmBoard/admCmmBoardCmmtInsert.do - 관리자 > 공통게시판 > 댓글 등록");
		LOGGER.debug("cbCommentVO = "+cbCommentVO.toString());
		
		if(EgovStringUtil.isEmpty(cbCommentVO.getCbSeq())){
			LOGGER.debug("/qxerpynm/cmmBoard/admCmmBoardCmmtInsert.do - 오류발생(-2) : cbCommentVO.getCbSeq() is empty");
			return redirectListPage("오류발생(-2)", searchVO, reda);
		}if(EgovStringUtil.isEmpty(cbCommentVO.getCbcoContent().trim())){
			LOGGER.debug("/qxerpynm/cmmBoard/admCmmBoardCmmtInsert.do - 오류발생(-3) : cbCommentVO.getCbcoContent() is empty");
			return redirectListPage("오류발생(-3)", searchVO, reda);
		}
		cbCommentVO.setCbcoContent(EgovWebUtil.clearXSSMinimum(cbCommentVO.getCbcoContent()));
		String rsCbcoSeq = admCmmBoardDAO.cmmBoardCommentInsert(cbCommentVO);
		
		CBCommentVO rsCbCommentVO = admCmmBoardDAO.selectCmmBoardCommentOne(rsCbcoSeq);
		model.addAttribute("rsCbCommentVO", rsCbCommentVO);
		
		// 로그등록
		
		admLogInsert(null, "공통게시판 댓글 등록", rsCbcoSeq, request);
			
		return redirectViewPage("댓글이 등록되었습니다.", cbCommentVO.getCbSeq(), searchVO, reda);
	}

	// 삭제
	@RequestMapping("/qxerpynm/cmmBoard/admCmmBoardCmmtDelete.do")
	public String admCmmBoardCmmtDelete(CBCommentVO cbCommentVO, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda, HttpServletRequest request) throws Exception {
		LOGGER.debug("/qxerpynm/cmmBoard/admCmmBoardCmmtDelete.do - 관리자 > 공통게시판 > 댓글 삭제");
		LOGGER.debug("cbCommentVO = "+cbCommentVO.toString());
		
		if(EgovStringUtil.isEmpty(cbCommentVO.getCbcoSeq()) || EgovStringUtil.isEmpty(cbCommentVO.getCbSeq())){
			LOGGER.debug("/qxerpynm/cmmBoard/admCmmBoardCmmtDelete.do - 오류발생(-3) : cbCommentVO.getCbCoSeq() or cbCommentVO.getCbSeq() is empty");
			return redirectListPage("오류발생(-3)", searchVO, reda);
		}
		
		admCmmBoardDAO.cmmBoardCommentDelete(cbCommentVO.getCbcoSeq());
		
		// 로그등록
		
		admLogInsert(null, "공통게시판 댓글 삭제", cbCommentVO.getCbcoSeq(), request);
		
		return redirectViewPage("댓글이 삭제되었습니다.", cbCommentVO.getCbSeq(), searchVO, reda);
	}
}
