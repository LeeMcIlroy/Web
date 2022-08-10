package hsDesign.usr.cmmBoard;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.file.CmmnFileMngUtil;
import component.file.FileInfoVO;
import component.util.ComStringUtil;
import component.web.PaginationController;
import egovframework.com.cmm.web.EgovWebUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import hsDesign.adm.cmmBoard.AdmCmmBoardDAO;
import hsDesign.usr.cmm.CmmController;
import hsDesign.valueObject.CBCommentVO;
import hsDesign.valueObject.CBUpfileVO;
import hsDesign.valueObject.CmmBoardVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class CmmBoardController extends CmmController {

	private static final Logger LOGGER = LoggerFactory.getLogger(CmmBoardController.class);
	@Autowired private CmmBoardDAO cmmBoardDAO;
	@Autowired private CmmnFileMngUtil cmmnFileMngUtil;
	@Autowired private AdmCmmBoardDAO admCmmBoardDAO;//첨부파일 업로드 쓰는것 때문에 불러옴
	
	// 검색조건을 가지고 목록으로 이동합니다.
	private String redirectListPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", message);
		reda.addAttribute("menuType", searchVO.getMenuType());
		reda.addAttribute("pageIndex", searchVO.getPageIndex());
		if(!EgovStringUtil.isEmpty(searchVO.getSearchCondition1())) reda.addAttribute("searchCondition1", searchVO.getSearchCondition1());
		if(!EgovStringUtil.isEmpty(searchVO.getSearchWord())) reda.addAttribute("searchWord", searchVO.getSearchWord());
		return "redirect:/usr/{dept1}/{dept2}/{jspPage}List.do";
	}
	
	// 검색조건을 가지고 조회로 이동합니다.
	private String redirectViewPage(String message, CmmnSearchVO searchVO, RedirectAttributes reda, String cbSeq){
		reda.addFlashAttribute("message", message);
		reda.addAttribute("menuType", searchVO.getMenuType());
		reda.addAttribute("pageIndex", searchVO.getPageIndex());
		reda.addAttribute("cbSeq", cbSeq);
		
		CmmBoardVO cmmBoardVO = cmmBoardDAO.selectCmmBoardOne(cbSeq);
		reda.addFlashAttribute("cbPassword", cmmBoardVO.getCbPassword());
		if(!EgovStringUtil.isEmpty(searchVO.getSearchCondition1())) reda.addAttribute("searchCondition1", searchVO.getSearchCondition1());
		if(!EgovStringUtil.isEmpty(searchVO.getSearchWord())) reda.addAttribute("searchWord", searchVO.getSearchWord());
		return "redirect:/usr/{dept1}/{dept2}/{jspPage}View.do";
	}
	
	// 목록
	@RequestMapping("/usr/{dept1}/{dept2}/{jspPage}List.do")
	public String cmmBoardList(
								@PathVariable("dept1") String dept1, @PathVariable("dept2") String dept2, @PathVariable("jspPage") String jspPage
								, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, CmmBoardVO cmmBoardVO
							) throws Exception {
		LOGGER.info("/usr/{}/{}/{}.do - 사용자 공통 > 목록", dept1, dept2, jspPage);
		LOGGER.debug("searchVO = {}", searchVO.toString());
		
		// menuNo & cmmListVO set
		String menuNo = "";
		CmmnListVO listVO = null;
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO , 10, 5);
		if("enter".equals(dept1) && "consult".equals(dept2)){
			menuNo = "205";
			searchVO.setMenuType("01");
			
			searchVO.setSearchType("Y");
			CmmnListVO ntListVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			model.addAttribute("ntResultList", replaceTag(ntListVO.getEgovList(),"cb"));
			
			searchVO.setSearchType("N");
			listVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			
		}else if("community".equals(dept1) && "faq".equals(dept2)) {
			menuNo = "305";
			searchVO.setMenuType("0301");
			
			searchVO.setSearchType("Y");
			CmmnListVO ntListVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			model.addAttribute("ntResultList", replaceTag(ntListVO.getEgovList(),"cb"));
			
			searchVO.setSearchType("N");
			listVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			
		}else if("community".equals(dept1) && "qna".equals(dept2)) {
			menuNo = "306";
			searchVO.setMenuType("0201");
			
			searchVO.setSearchType("Y");
			CmmnListVO ntListVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			model.addAttribute("ntResultList", replaceTag(ntListVO.getEgovList(),"cb"));
			
			searchVO.setSearchType("N");
			listVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			
		}else if("community".equals(dept1) && "smg".equals(dept2)) {
			menuNo = "307";
			searchVO.setMenuType("1001");
			
			searchVO.setSearchType("Y");
			CmmnListVO ntListVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			model.addAttribute("ntResultList", replaceTag(ntListVO.getEgovList(),"cb"));
			
			searchVO.setSearchType("N");
			listVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			
		}else if("hdaCampus".equals(dept1) && "form".equals(dept2)) {
			menuNo = "304";
			searchVO.setMenuType("0401");
			
			searchVO.setSearchType("Y");
			CmmnListVO ntListVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			model.addAttribute("ntResultList", replaceTag(ntListVO.getEgovList(),"cb"));
			
			searchVO.setSearchType("N");
			listVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			
		}else if("community".equals(dept1) && "notice".equals(dept2)) {
			menuNo = "308";
			searchVO.setMenuType("0501");
			
			searchVO.setSearchType("Y");
			CmmnListVO ntListVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			model.addAttribute("ntResultList", replaceTag(ntListVO.getEgovList(),"cb"));
			
			searchVO.setSearchType("N");
			listVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			
		}else if("community".equals(dept1) && "proud".equals(dept2)) {
			menuNo = "4011";
			searchVO.setMenuType("0601");
			
			listVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			
		}else if("community".equals(dept1) && "festival".equals(dept2)) {
			menuNo = "4013";
			searchVO.setMenuType("0701");
			
			listVO = cmmBoardDAO.selectCmmBoardList(searchVO);
		
		}else if("community".equals(dept1) && "ucc".equals(dept2)) {
			menuNo = "16001";
			searchVO.setMenuType("0801");
			
			paginationInfo = PaginationController.getPaginationInfo(searchVO , 4, 5);
			
			listVO = cmmBoardDAO.selectCmmBoardList(searchVO);

			// 첨부파일
			List<String> cbSeqList = new ArrayList<>(); //게시물별 cbSeq 값만 담기
			List<List<EgovMap>> fileList = new ArrayList<List<EgovMap>>();
			 
			for (int i = 0; i < listVO.getEgovList().size(); i++) {
				String cbSeq = String.valueOf(listVO.getEgovList().get(i).get("cbSeq"));
				cbSeqList.add(cbSeq); //리스트별 cbSeq 값만 담았다!
			}
			for (String seq : cbSeqList) { //cbSeq 값 하나씩 빼서 반복문 돌리기 
				List<EgovMap> cbUpfileList = cmmBoardDAO.selectCmmBoardUpfileList(seq);
				if (!cbUpfileList.isEmpty()) { // 조회한 cbUpfileList가 비어있지 않다면
					fileList.add(cbUpfileList);
				}
			}

			model.addAttribute("fileList", fileList);
			
//		}else if("community".equals(dept1) && "webtoon".equals(dept2)) {
//			menuNo = "16002";
//			searchVO.setMenuType("0802");
//			
//			paginationInfo = PaginationController.getPaginationInfo(searchVO , 4, 5);
//			
//			listVO = cmmBoardDAO.selectCmmBoardList(searchVO);
//			
		}else if("general".equals(dept1) && "request".equals(dept2)){
			menuNo = "802";
			searchVO.setMenuType("0901");
			
			searchVO.setSearchType("Y");
			CmmnListVO ntListVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			model.addAttribute("ntResultList", replaceTag(ntListVO.getEgovList(),"cb"));
			
			searchVO.setSearchType("N");
			listVO = cmmBoardDAO.selectCmmBoardList(searchVO);
		}else if("general".equals(dept1) && "question".equals(dept2)){
			menuNo = "806";
			searchVO.setMenuType("0902");
			
			searchVO.setSearchType("Y");
			CmmnListVO ntListVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			model.addAttribute("ntResultList", replaceTag(ntListVO.getEgovList(),"cb"));
			
			searchVO.setSearchType("N");
			listVO = cmmBoardDAO.selectCmmBoardList(searchVO);
//		200407추가
		}else if("community".equals(dept1) && "ass".equals(dept2)){
			menuNo = "701";
			searchVO.setMenuType("0605");
			
			searchVO.setSearchType("Y");
			CmmnListVO ntListVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			model.addAttribute("ntResultList", replaceTag(ntListVO.getEgovList(),"cb"));
			
			searchVO.setSearchType("N");
			listVO = cmmBoardDAO.selectCmmBoardList(searchVO);

//		200408추가
		}else if("community".equals(dept1) && "overseas".equals(dept2)){
			menuNo = "40231";
			searchVO.setMenuType("0603");
			
			searchVO.setSearchType("Y");
			CmmnListVO ntListVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			model.addAttribute("ntResultList", replaceTag(ntListVO.getEgovList(),"cb"));
				
			searchVO.setSearchType("N");
			listVO = cmmBoardDAO.selectCmmBoardList(searchVO);

			// 첨부파일
			List<String> cbSeqList = new ArrayList<>(); //게시물별 cbSeq 값만 담기
			List<List<EgovMap>> fileList = new ArrayList<List<EgovMap>>();
			 
			for (int i = 0; i < listVO.getEgovList().size(); i++) {
				String cbSeq = String.valueOf(listVO.getEgovList().get(i).get("cbSeq"));
				cbSeqList.add(cbSeq); //리스트별 cbSeq 값만 담았다!
			}
			for (String seq : cbSeqList) { //cbSeq 값 하나씩 빼서 반복문 돌리기 
				List<EgovMap> cbUpfileList = cmmBoardDAO.selectCmmBoardUpfileList(seq);
				if (!cbUpfileList.isEmpty()) { // 조회한 cbUpfileList가 비어있지 않다면
					fileList.add(cbUpfileList);
				}
				model.addAttribute("fileList", fileList);
			}
			
		}else if("info".equals(dept1) && "brodata".equals(dept2)) {
			menuNo = "16003";
			searchVO.setMenuType("0602");
			
			searchVO.setSearchType("Y");
			CmmnListVO ntListVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			model.addAttribute("ntResultList", replaceTag(ntListVO.getEgovList(),"cb"));
				
			searchVO.setSearchType("N");
			
			listVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			
		}else if("community".equals(dept1) && "employment".equals(dept2)) {
			menuNo = "606";
			searchVO.setMenuType("0604");
			
			searchVO.setSearchType("Y");
			CmmnListVO ntListVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			model.addAttribute("ntResultList", replaceTag(ntListVO.getEgovList(),"cb"));
			
			searchVO.setSearchType("N");
		
			listVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			
			

//			200420추가
		}else if("community".equals(dept1) && "oveServ".equals(dept2)){
			menuNo = "40233";
			searchVO.setMenuType("0611");
			
			searchVO.setSearchType("Y");
			CmmnListVO ntListVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			model.addAttribute("ntResultList", replaceTag(ntListVO.getEgovList(),"cb"));
					
			searchVO.setSearchType("N");
			listVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			

			// 첨부파일
			List<String> cbSeqList = new ArrayList<>(); //게시물별 cbSeq 값만 담기
			List<List<EgovMap>> fileList = new ArrayList<List<EgovMap>>();
			 
			for (int i = 0; i < listVO.getEgovList().size(); i++) {
				String cbSeq = String.valueOf(listVO.getEgovList().get(i).get("cbSeq"));
				cbSeqList.add(cbSeq); //리스트별 cbSeq 값만 담았다!
			}
			for (String seq : cbSeqList) { //cbSeq 값 하나씩 빼서 반복문 돌리기 
				List<EgovMap> cbUpfileList = cmmBoardDAO.selectCmmBoardUpfileList(seq);
				if (!cbUpfileList.isEmpty()) { // 조회한 cbUpfileList가 비어있지 않다면
					fileList.add(cbUpfileList);
				}
				model.addAttribute("fileList", fileList);
			}
			
		}else if("community".equals(dept1) && "oveStud".equals(dept2)){
			menuNo = "23002";
			searchVO.setMenuType("0610");
			
			searchVO.setSearchType("Y");
			CmmnListVO ntListVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			model.addAttribute("ntResultList", replaceTag(ntListVO.getEgovList(),"cb"));
					
			searchVO.setSearchType("N");
			listVO = cmmBoardDAO.selectCmmBoardList(searchVO);

			// 첨부파일
			List<String> cbSeqList = new ArrayList<>(); //게시물별 cbSeq 값만 담기
			List<List<EgovMap>> fileList = new ArrayList<List<EgovMap>>();
			 
			for (int i = 0; i < listVO.getEgovList().size(); i++) {
				String cbSeq = String.valueOf(listVO.getEgovList().get(i).get("cbSeq"));
				cbSeqList.add(cbSeq); //리스트별 cbSeq 값만 담았다!
			}
			for (String seq : cbSeqList) { //cbSeq 값 하나씩 빼서 반복문 돌리기 
				List<EgovMap> cbUpfileList = cmmBoardDAO.selectCmmBoardUpfileList(seq);
				if (!cbUpfileList.isEmpty()) { // 조회한 cbUpfileList가 비어있지 않다면
					fileList.add(cbUpfileList);
				}
				model.addAttribute("fileList", fileList);
			}
		}
		
		
		session.setAttribute("menuNo", menuNo);
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", replaceTag(listVO.getEgovList(),"cb"));
		
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		
		model.addAttribute("bannerList", selectLeftBannerList());

		return String.format("/usr/%s/%s/%sList", dept1, dept2, jspPage);
	}
	
	// 등록 & 수정화면
	@RequestMapping("/usr/{dept1}/{dept2}/{jspPage}Modify.do")
	public String cmmBoardModify(
								@PathVariable("dept1") String dept1, @PathVariable("dept2") String dept2, @PathVariable("jspPage") String jspPage
								, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, String cbSeq
							) throws Exception {
		LOGGER.info("/usr/{}/{}/{}.do - 사용자 공통 > 등록 & 수정화면", dept1, dept2, jspPage);
		LOGGER.debug("searchVO = {}", searchVO.toString());
		LOGGER.debug("cbSeq = "+cbSeq);
		
		CmmBoardVO cmmBoardVO = null;
		if("enter".equals(dept1) && "consult".equals(dept2)){
			searchVO.setMenuType("0101");
			
		}else if("transfer".equals(dept1) && "consult".equals(dept2)) {
			searchVO.setMenuType("0102");
			
		}else if("hdaCampus".equals(dept1) && "qna".equals(dept2)) {
			searchVO.setMenuType("0201");
			
		}else if("general".equals(dept1) && "request".equals(dept2)){
			searchVO.setMenuType("0901");
			
		}else if("general".equals(dept1) && "question".equals(dept2)){
			searchVO.setMenuType("0902");
			
		}else if("commmunity".equals(dept1) && "smg".equals(dept2)) {
			searchVO.setMenuType("1001");
			
		}
		
		if(EgovStringUtil.isEmpty(cbSeq)) {
			//등록
			
			cmmBoardVO = new CmmBoardVO();
		}else {
			//수정
			cmmBoardVO = cmmBoardDAO.selectCmmBoardOne(cbSeq);	
			
			// 첨부파일
			CmmnListVO cbUpfileListVO = admCmmBoardDAO.selectCmmBoardUpfileList(cbSeq);
			model.addAttribute("cbUpfileListVO", cbUpfileListVO);
			
		}
		
		model.addAttribute("cmmBoardVO", cmmBoardVO);
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		
		
		model.addAttribute("bannerList", selectLeftBannerList());

		return String.format("/usr/%s/%s/%sModify", dept1, dept2, jspPage);
	}
	
	// 조회
	@RequestMapping("/usr/{dept1}/{dept2}/{jspPage}View.do")
	public String cmmBoardView(
								@PathVariable("dept1") String dept1, @PathVariable("dept2") String dept2, @PathVariable("jspPage") String jspPage
								, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, CmmBoardVO cmmBoardVO, RedirectAttributes reda
							) throws Exception {
		LOGGER.info("/usr/{}/{}/{}.do - 사용자 공통 > 조회", dept1, dept2, jspPage);
		LOGGER.debug("searchVO = {}", searchVO.toString());
		LOGGER.debug("cmmBoardVO = {}", cmmBoardVO.toString());
		
		
		String menuNo = "";
		if("enter".equals(dept1) && "consult".equals(dept2)){
			menuNo = "205";
		}else if("community".equals(dept1) && "faq".equals(dept2)) {
			menuNo = "305";
		}else if("community".equals(dept1) && "qna".equals(dept2)) {
			menuNo = "306";
		}else if("community".equals(dept1) && "smg".equals(dept2)) {
			menuNo = "307";
		}else if("hdaCampus".equals(dept1) && "form".equals(dept2)) {
			menuNo = "304";
		}else if("community".equals(dept1) && "notice".equals(dept2)) {
			menuNo = "308";
		}else if("community".equals(dept1) && "proud".equals(dept2)) {
			menuNo = "4011";
		}else if("community".equals(dept1) && "festival".equals(dept2)) {
			menuNo = "4011";
		}else if("community".equals(dept1) && "ucc".equals(dept2)) {
			menuNo = "15001";
		}else if("community".equals(dept1) && "ass".equals(dept2)){
			menuNo = "701";
		}else if("general".equals(dept1) && "request".equals(dept2)){
			menuNo = "802";
		}else if("general".equals(dept1) && "question".equals(dept2)){
			menuNo = "806";
//			200408추가
		}else if("community".equals(dept1) && "overseas".equals(dept2)) {
			menuNo = "23001";
		}else if("info".equals(dept1) && "brodata".equals(dept2)) {
			menuNo = "16003";
		}else if("community".equals(dept1) && "employment".equals(dept2)) {
			menuNo = "606";
//			200420추가
		}else if("community".equals(dept1) && "oveStud".equals(dept2)) {
			menuNo = "23002";
		}else if("community".equals(dept1) && "oveServ".equals(dept2)) {
			menuNo = "23003";
		}
		
		session.setAttribute("menuNo", menuNo);
		
		// menuNo & cmmListVO set
		CmmBoardVO resultVO = cmmBoardDAO.selectCmmBoardOne(cmmBoardVO.getCbSeq());
		
		
		if(resultVO == null) {
			LOGGER.debug("게시글이 존재하지 않습니다.");
			return redirectListPage("게시글이 존재하지 않습니다.", searchVO, reda);
		}
		
		if(resultVO.getCbSecretYn().equals("Y")) {
			/*
			String encryptPw = cmmBoardVO.getCbPassword();
			*/
			String encryptPw = EgovFileScrty.encryptPassword(cmmBoardVO.getCbPassword(), resultVO.getRegName());
			//LOGGER.debug("encrypt = {}",encryptPw);
			
			if(!resultVO.getCbPassword().equals(encryptPw)) {
				LOGGER.debug("비밀번호가 틀렸습니다.");
				return redirectListPage("비밀번호가 틀렸습니다.", searchVO, reda); 
				
			}
			
		}
		
		// 사용자가 작성한글에 대한 개행
		if( 
				(
					("enter".equals(dept1) && "consult".equals(dept2)) 		|| 
					("transfer".equals(dept1) && "consult".equals(dept2)) 	||
					("hdaCampus".equals(dept1) && "qna".equals(dept2)) 		||
					("general".equals(dept1) && "request".equals(dept2))	||
					("general".equals(dept1) && "question".equals(dept2))
				)	&& (resultVO.getCbNoticeYn().equals("N") )
				
		){
			resultVO.setCbContent(resultVO.getCbContent().replaceAll("\r\n", "<br>"));
		}else{
			resultVO.setCbContent(resultVO.getCbContent());
		}
		
		
		//resultVO.setCbContent(EgovWebUtil.removeImgStyle(resultVO.getCbContent())); // style 제거
		resultVO.setCbContent(ComStringUtil.imgWidthHeightToMaxWidthHeight(resultVO.getCbContent())); // width, height 변경
		
		
		List<EgovMap> cbUpfileList = cmmBoardDAO.selectCmmBoardUpfileList(cmmBoardVO.getCbSeq());
		
		searchVO.setSearchCondition2(cmmBoardVO.getCbSeq());
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO , 10, 10);
		
		CmmnListVO listVO = cmmBoardDAO.selectCmmBoardCommentList(searchVO);
		
		for(EgovMap list : listVO.getEgovList()) {
			list.put("cbcoContent", list.get("cbcoContent").toString().replaceAll("\r\n", "<br>"));
			
		}
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("cbCommentList", listVO.getEgovList());
		
		model.addAttribute("cmmBoardVO", resultVO);
		model.addAttribute("cbUpfileList", cbUpfileList);
		model.addAttribute("bannerList", selectLeftBannerList());
		
		// 관련글
		if("community".equals(dept1) && "proud".equals(dept2)) {
			searchVO.setMenuType("0601");
			searchVO.setSearchCondition4(cmmBoardVO.getCbSeq());
			int pageIndex = searchVO.getPageIndex();
			searchVO.setPageIndex(1);
			paginationInfo = PaginationController.getPaginationInfo(searchVO , 4, 1);
			
			listVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			searchVO.setPageIndex(pageIndex);
			model.addAttribute("recentList", listVO.getEgovList());
			
		}else if("community".equals(dept1) && "festival".equals(dept2)) {
			searchVO.setMenuType("0701");
			searchVO.setSearchCondition4(cmmBoardVO.getCbSeq());
			int pageIndex = searchVO.getPageIndex();
			searchVO.setPageIndex(1);
			paginationInfo = PaginationController.getPaginationInfo(searchVO , 4, 1);
			
			listVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			searchVO.setPageIndex(pageIndex);
			model.addAttribute("recentList", listVO.getEgovList());
			
		}else if("community".equals(dept1) && "ucc".equals(dept2)) {
			searchVO.setMenuType("0801");
			searchVO.setSearchCondition4(cmmBoardVO.getCbSeq());
			int pageIndex = searchVO.getPageIndex();
			searchVO.setPageIndex(1);
			paginationInfo = PaginationController.getPaginationInfo(searchVO , 4, 1);
			
			listVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			searchVO.setPageIndex(pageIndex);
			model.addAttribute("recentList", listVO.getEgovList());
			
			// 첨부파일
			List<String> cbSeqList = new ArrayList<>(); //게시물별 cbSeq 값만 담기
			List<List<EgovMap>> fileList = new ArrayList<List<EgovMap>>();
			 
			for (int i = 0; i < listVO.getEgovList().size(); i++) {
				String cbSeq = String.valueOf(listVO.getEgovList().get(i).get("cbSeq"));
				cbSeqList.add(cbSeq); //리스트별 cbSeq 값만 담았다!
			}
			for (String seq : cbSeqList) { //cbSeq 값 하나씩 빼서 반복문 돌리기 
				List<EgovMap> recentfileList = cmmBoardDAO.selectCmmBoardUpfileList(seq);
				if (!recentfileList.isEmpty()) { // 조회한 cbUpfileList가 비어있지 않다면
					fileList.add(recentfileList);
				}
			}

			model.addAttribute("fileList", fileList);
		
		}else if("webtoon".equals(dept1)) {
			searchVO.setMenuType("0802");
			searchVO.setSearchCondition4(cmmBoardVO.getCbSeq());
			int pageIndex = searchVO.getPageIndex();
			searchVO.setPageIndex(1);
			paginationInfo = PaginationController.getPaginationInfo(searchVO , 4, 1);
			
			listVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			searchVO.setPageIndex(pageIndex);
			model.addAttribute("recentList", listVO.getEgovList());
			
//			200408추가
		}else if("info".equals(dept1) && "brodata".equals(dept2)) {
			searchVO.setMenuType("0602");
			searchVO.setSearchCondition4(cmmBoardVO.getCbSeq());
			int pageIndex = searchVO.getPageIndex();
			searchVO.setPageIndex(1);
			paginationInfo = PaginationController.getPaginationInfo(searchVO , 4, 1);
			
			listVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			searchVO.setPageIndex(pageIndex);
			model.addAttribute("recentList", listVO.getEgovList());
		}else if("community".equals(dept1) && "employment".equals(dept2)) {
			searchVO.setMenuType("0604");
			searchVO.setSearchCondition4(cmmBoardVO.getCbSeq());
			int pageIndex = searchVO.getPageIndex();
			searchVO.setPageIndex(1);
			paginationInfo = PaginationController.getPaginationInfo(searchVO , 4, 1);
			
			listVO = cmmBoardDAO.selectCmmBoardList(searchVO);
			searchVO.setPageIndex(pageIndex);
			model.addAttribute("recentList", listVO.getEgovList());
		
		} 
		
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());

		return String.format("/usr/%s/%s/%sView", dept1, dept2, jspPage);
	}
		
	// 등록 & 수정
	@RequestMapping("/usr/{dept1}/{dept2}/{jspPage}Update.do")
	public String cmmBoardUpdate(
								@PathVariable("dept1") String dept1, @PathVariable("dept2") String dept2, @PathVariable("jspPage") String jspPage
								, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, CmmBoardVO cmmBoardVO, RedirectAttributes reda
								, String[] cbUpfileDelChk, MultipartHttpServletRequest multiRequest) throws Exception {
		LOGGER.info("/usr/{}/{}/{}.do - 사용자 공통 > 등록 & 수정", dept1, dept2, jspPage);
		LOGGER.debug("searchVO = {}", searchVO.toString());
		LOGGER.debug("cmmBoardVO = {}", cmmBoardVO.toString());

		String cbSeq = "";
		
		String message = "오류가 발생하였습니다.";
		if(EgovStringUtil.isEmpty(cmmBoardVO.getCbContent().trim())) {
			LOGGER.debug("내용이 존재하지 않습니다.");
			message = "내용이 존재하지 않습니다.";     
			return redirectListPage(message, searchVO, reda);
		}else if(EgovStringUtil.isEmpty(cmmBoardVO.getRegName().trim())) {
			LOGGER.debug("이름이 존재하지 않습니다.");
			message = "이름이 존재하지 않습니다.";
			return redirectListPage(message, searchVO, reda);
		}else if(EgovStringUtil.isEmpty(cmmBoardVO.getCbPassword().trim())) {
			LOGGER.debug("비밀번호가 존재하지 않습니다.");
			message = "비밀번호가 존재하지 않습니다.";
			return redirectListPage(message, searchVO, reda);
		}else if(EgovStringUtil.isEmpty(cmmBoardVO.getCbTitle().trim())) {
			LOGGER.debug("제목이 존재하지 않습니다.");
			message = "제목이 존재하지 않습니다.";
			return redirectListPage(message, searchVO, reda);
		}
		cmmBoardVO.setCbContent(EgovWebUtil.clearXSSMinimum(cmmBoardVO.getCbContent()));
		cmmBoardVO.setCbTitle(EgovWebUtil.clearXSSMinimum(cmmBoardVO.getCbTitle()));
		
		if("enter".equals(dept1) && "consult".equals(dept2)){
			cmmBoardVO.setCbSecretYn("Y");
			cmmBoardVO.setCbNoticeYn("N");
		}else if("transfer".equals(dept1) && "consult".equals(dept2)){
			cmmBoardVO.setCbType("0102");
			
			cmmBoardVO.setCbSecretYn("Y");
			cmmBoardVO.setCbNoticeYn("N");
		}else if("community".equals(dept1) && "qna".equals(dept2)){
			cmmBoardVO.setCbType("0201");
			
			cmmBoardVO.setCbSecretYn("Y");
			cmmBoardVO.setCbNoticeYn("N");
		}else if("general".equals(dept1) && "request".equals(dept2)){
			cmmBoardVO.setCbType("0901");
			
			cmmBoardVO.setCbSecretYn("Y");
			cmmBoardVO.setCbNoticeYn("N");
		}else if("general".equals(dept1) && "question".equals(dept2)){
			cmmBoardVO.setCbType("0902");
			
			cmmBoardVO.setCbSecretYn("Y");
			cmmBoardVO.setCbNoticeYn("N");
		}else if("community".equals(dept1) && "smg".equals(dept2)){
			cmmBoardVO.setCbType("1001");
			
			cmmBoardVO.setCbSecretYn("Y");
			cmmBoardVO.setCbNoticeYn("N");
		}
		
		String encryptPw = EgovFileScrty.encryptPassword(cmmBoardVO.getCbPassword(), cmmBoardVO.getRegName());
		cmmBoardVO.setCbPassword(encryptPw);
		
		/*if(EgovStringUtil.isEmpty(cmmBoardVO.getCbSeq())) {
			// 등록
			cmmBoardDAO.insertCmmBoardOne(cmmBoardVO);
			message = "등록되었습니다.";
		}else {
			// 수정
			cmmBoardDAO.updateCmmBoardOne(cmmBoardVO);
			message = "수정되었습니다.";
		}*/
		
		//추가
		if(EgovStringUtil.isEmpty(cmmBoardVO.getCbSeq())){
			cmmBoardVO.setCbTitle(EgovWebUtil.clearXSSMinimum(cmmBoardVO.getCbTitle()));
			cbSeq = cmmBoardDAO.insertCmmBoardOne(cmmBoardVO);
			message = "등록되었습니다.";
		}else{
			// 수정
			if(cbUpfileDelChk != null){
				// 첨부파일 삭제
				if(cbUpfileDelChk.length > 0){
					for (int i = 0; i < cbUpfileDelChk.length; i++) {
						CBUpfileVO cbUpfileVO = admCmmBoardDAO.selectCmmBoardUpfileOne(cbUpfileDelChk[i]);
						// 원본파일 삭제
						cmmnFileMngUtil.deleteFile(cbUpfileVO.getCbupSaveFilepath());
						// DB 삭제
						admCmmBoardDAO.cmmBoardUpfileDelete(cbUpfileDelChk[i]);			
					}
				}
			}
			
			cmmBoardVO.setCbTitle(EgovWebUtil.clearXSSMinimum(cmmBoardVO.getCbTitle()));
			cmmBoardDAO.updateCmmBoardOne(cmmBoardVO);
			cbSeq = cmmBoardVO.getCbSeq();
			message = "수정되었습니다.";
		}
		
		// 첨부파일 등록
		List<FileInfoVO> fileInfoList = cmmnFileMngUtil.totUploadFiles(multiRequest, "CMMBOARD");
		if(fileInfoList != null){
			for(FileInfoVO fileInfoVO : fileInfoList){
				admCmmBoardDAO.cmmBoardUpfileInsert(fileInfoVO, cbSeq);
			}
		}
		////추가
		
		
		return redirectListPage(message, searchVO, reda);
	}
	
	// 삭제
	@RequestMapping("/usr/{dept1}/{dept2}/{jspPage}Delete.do")
	public String cmmBoardDelete(
								@PathVariable("dept1") String dept1, @PathVariable("dept2") String dept2, @PathVariable("jspPage") String jspPage
								, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, String cbSeq, RedirectAttributes reda
							) throws Exception {
		LOGGER.info("/usr/{}/{}/{}.do - 사용자 공통 > 삭제", dept1, dept2, jspPage);
		LOGGER.debug("searchVO = {}", searchVO.toString());
		LOGGER.debug("cbSeq = {}", cbSeq);
		
		cmmBoardDAO.deleteCmmBoardOne(cbSeq);
		cmmBoardDAO.deleteCmmBoardCommentOne(cbSeq);
		
		return redirectListPage("삭제되었습니다.", searchVO, reda);
	}
	
	@Resource View jsonView;
	// 댓글 등록
	@RequestMapping("/usr/{dept1}/{dept2}/{jspPage}CommentUpdate.do")
	public View cmmBoardCommentUpdate(
								@PathVariable("dept1") String dept1, @PathVariable("dept2") String dept2, @PathVariable("jspPage") String jspPage
								, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, CBCommentVO cbCommentVO, RedirectAttributes reda
							) throws Exception {
		LOGGER.info("/usr/{}/{}/{}.do - 사용자 공통 > 댓글 등록 & 수정", dept1, dept2, jspPage);
		LOGGER.debug("searchVO = {}", searchVO.toString());
		LOGGER.debug("CBCommentVO = {}", cbCommentVO.toString());
		
		if(EgovStringUtil.isEmpty(cbCommentVO.getCbSeq())){
			LOGGER.debug("/usr/{dept1}/{dept2}/{jspPage}CommentUpdate.do - 오류발생(-2) : cbCommentVO.getCbSeq() is empty", dept1, dept2, jspPage);
		}
		
		if(EgovStringUtil.isEmpty(cbCommentVO.getCbcoContent().trim())) {
			LOGGER.debug("내용이 존재하지 않습니다.");
			
		}else {
			
			cbCommentVO.setCbcoContent(EgovWebUtil.clearXSSMinimum(cbCommentVO.getCbcoContent()));
			
			// 등록
			cmmBoardDAO.cmmBoardCommentInsert(cbCommentVO);
		}
			
		
		searchVO.setSearchCondition2(cbCommentVO.getCbSeq());
		
		CmmnListVO listVO = cmmBoardDAO.selectCmmBoardCommentList(searchVO);
		for(EgovMap list : listVO.getEgovList()) {
			list.put("cbcoContent", list.get("cbcoContent").toString().replaceAll("\r\n", "<br>"));
			
		}
		
		model.addAttribute("cbCommentList", listVO.getEgovList());
	
		
		return jsonView;
	}
	
	// 댓글 삭제
	@RequestMapping("/usr/{dept1}/{dept2}/{jspPage}CommentDelete.do")
	public View cmmBoardCommentDelete(
								@PathVariable("dept1") String dept1, @PathVariable("dept2") String dept2, @PathVariable("jspPage") String jspPage
								, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, CBCommentVO cbCommentVO, RedirectAttributes reda
							) throws Exception {
		LOGGER.info("/usr/{}/{}/{}.do - 사용자 공통 > 댓글 삭제", dept1, dept2, jspPage);
		LOGGER.debug("searchVO = {}", searchVO.toString());
		
		if(EgovStringUtil.isEmpty(cbCommentVO.getCbSeq())){
			LOGGER.debug("/usr/{dept1}/{dept2}/{jspPage}CommentDelete.do - 오류발생(-2) : cbCommentVO.getCbSeq() is empty", dept1, dept2, jspPage);
		}
		cmmBoardDAO.cmmBoardCommentDelete(cbCommentVO.getCbcoSeq());
		
		searchVO.setSearchCondition2(cbCommentVO.getCbSeq());
		
		CmmnListVO listVO = cmmBoardDAO.selectCmmBoardCommentList(searchVO);
		for(EgovMap list : listVO.getEgovList()) {
			list.put("cbcoContent", list.get("cbcoContent").toString().replaceAll("\r\n", "<br>"));
			
		}
		
		model.addAttribute("cbCommentList", listVO.getEgovList());
		
		return jsonView;
	}
	
	//이전글
	
	@RequestMapping("/usr/{dept1}/{dept2}/{jspPage}PreView.do")
	public View cmmBoardPreView(@PathVariable("dept1") String dept1, @PathVariable("dept2") String dept2, @PathVariable("jspPage") String jspPage,
								@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, String cbSeq, String cbType) throws Exception {
		LOGGER.info("/usr/news/interior/cmmBoardPreView.do - 조회에서 이전글 불러오기");
		LOGGER.debug("cbSeq - "+cbSeq);
		LOGGER.debug("cbType - "+cbType);
		
		CmmBoardVO cmmBoardVO = new CmmBoardVO();
		
		cmmBoardVO.setCbSeq(cbSeq);
		cmmBoardVO.setCbType(cbType);
		
		CmmBoardVO resultVO = cmmBoardDAO.selectCmmBoardPreOne(cmmBoardVO);
			
		// 관련 글 4개
		searchVO.setMenuType(cbType);
		searchVO.setSearchCondition4(cbSeq);
		
		PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO,4,1);
		CmmnListVO listVO = cmmBoardDAO.selectCmmBoardList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("recentList", listVO.getEgovList());
		
		model.addAttribute("cmmBoardVO", resultVO);

		return jsonView;
	}

	// 자주하는 질문
	@RequestMapping("/usr/enter/faq/faqList.do")
	public String cmmBoardAppliForm(
								@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session
							) throws Exception {
		LOGGER.info("/usr/enter/faq/faqList.do - 사용자 공통 > 자주하는질문");
		LOGGER.debug("searchVO = {}", searchVO.toString());
		session.setAttribute("menuNo", "206");
		
		model.addAttribute("bcList", selectBoardCodeList());
		
		
		model.addAttribute("bannerList", selectLeftBannerList());

		return String.format("/usr/enter/faq/faqList");
	}
	
	// 해외인턴십
		@RequestMapping("/usr/community/overseas/overseas.do")
		public String overseas(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
			LOGGER.info("/usr/community/overseas/overseas.do - 해외인턴십 > 해외인턴십 안내");
			LOGGER.debug("searchVO = {}", searchVO.toString());
			session.setAttribute("menuNo", "40231");
			
			model.addAttribute("bcList", selectBoardCodeList());
			model.addAttribute("bannerList", selectLeftBannerList());

			return String.format("/usr/community/overseas/overseas");
		}
		// 해외연수
		@RequestMapping("/usr/community/oveStud/oveStud.do")
		public String oveStud(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
			LOGGER.info("/usr/community/oveStud/oveStud.do - 해외연수 > 해외연수 안내");
			LOGGER.debug("searchVO = {}", searchVO.toString());
			session.setAttribute("menuNo", "40232");
			
			model.addAttribute("bcList", selectBoardCodeList());
			model.addAttribute("bannerList", selectLeftBannerList());

			return String.format("/usr/community/oveStud/oveStud");
		}
		// 해외봉사
		@RequestMapping("/usr/community/oveServ/oveServ.do")
		public String oveServ(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
			LOGGER.info("/usr/community/oveServ/oveServ.do - 해외봉사 > 해외봉사 안내");
			LOGGER.debug("searchVO = {}", searchVO.toString());
			session.setAttribute("menuNo", "40233");
			
			model.addAttribute("bcList", selectBoardCodeList());
			model.addAttribute("bannerList", selectLeftBannerList());

			return String.format("/usr/community/oveServ/oveServ");
		}
	
/*
	// 비밀글 암호화
	@RequestMapping("/usr/enter/encrypt.do")
	public String encrypt(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/enter/encrypt - 암호화");
		
		List<CmmBoardVO> passwordList = cmmBoardDAO.selectPasswordList();
		CmmBoardVO cmmBoardVO = new CmmBoardVO();
		
		SqlMapClient smc = cmmBoardDAO.getSqlMapClient();

		smc.startTransaction();
		smc.startBatch();
		
		for(int i=0;i<passwordList.size();i++) {
			
			String encryptPw = EgovFileScrty.encryptPassword(passwordList.get(i).getCbPassword(), passwordList.get(i).getRegName());
			cmmBoardVO.setCbPassword(encryptPw);
			cmmBoardVO.setCbSeq(passwordList.get(i).getCbSeq());
			
			cmmBoardDAO.updatePasswordList(cmmBoardVO);
			// 1000건 단위로 끊어서 배치 실행
	        if (i % 1000 == 0) {
	            smc.executeBatch();
	            smc.startBatch();
	        }


		}
		
		
		smc.executeBatch();
		smc.commitTransaction();
		smc.endTransaction();


		
		return "/usr/main/index";
	}
	*/
}
