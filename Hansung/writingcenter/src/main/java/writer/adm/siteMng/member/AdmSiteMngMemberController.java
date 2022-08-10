package writer.adm.siteMng.member;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.web.PaginationController;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import writer.adm.cmm.AdmCmmLogDAO;
import writer.valueObject.AdminVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Controller
public class AdmSiteMngMemberController{

	private final static Logger LOGGER = LoggerFactory.getLogger(AdmSiteMngMemberController.class);
	@Autowired private AdmSiteMngMemberDAO admMemberMngDAO;
	
	@Autowired private AdmCmmLogDAO admCmmLogDAO; 
	
	// 검색 조건을 가지고 목록페이지(조회_주제목록)로 이동합니다.
	private String redirectListPage(CmmnSearchVO searchVO, RedirectAttributes reda){
		reda.addFlashAttribute("message", searchVO.getMessage());
		reda.addFlashAttribute("searchVO", searchVO);
		
		String redirectPage = "";
		redirectPage = "redirect:/xabdmxgr/siteMng/member/admSiteMngMemberList.do";		// 목록
		
		return redirectPage;
		
	}
	
	
	//회원관리 목록
	@RequestMapping("/xabdmxgr/siteMng/member/admSiteMngMemberList.do")
	public String admSiteMngMemberList(ModelMap model, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request)throws Exception{
		request.getSession().setAttribute("admMenuNo", "601");
		LOGGER.info("/xabdmxgr/siteMng/Member/admSiteMngMemberList.do - 관리자 > 사이트관리 > 회원관리 목록");
		LOGGER.debug("searchVO - "+searchVO.toString());
		
		PaginationInfo paginationInfo=PaginationController.getPaginationInfo(searchVO);
		
		CmmnListVO listVO=admMemberMngDAO.selectSiteMngMemberList(searchVO);
		
		paginationInfo.setTotalRecordCount(listVO.getTotalRecordCount());
		model.addAttribute("paginationInfo",paginationInfo);
		model.addAttribute("listVO",listVO.getEgovList());
		
		
		return "/adm/siteMng/member/admSiteMngMemberList";
	}
	
	//등록 & 수정 화면
	@RequestMapping("/xabdmxgr/siteMng/member/admSiteMngMemberModifyView.do")
	public String admSiteMngMemberModifyView(ModelMap model, @RequestParam("memSeq")String memSeq,  @ModelAttribute("searchVO") CmmnSearchVO searchVO, RedirectAttributes reda)throws Exception{
		LOGGER.info("/xabdmxgr/siteMng/member/admSiteMngMemberModifyView.do - 관리자 > 사이트관리 > 회원관리 등록 & 수정 화면");
		LOGGER.debug("memSeq="+memSeq);
		
		AdminVO adminVO=null;
		if (EgovStringUtil.isEmpty(memSeq)) {
			// 등록화면
			adminVO = new AdminVO();
		}else{
			// 수정화면
			adminVO = admMemberMngDAO.selectSiteMngMemberOne(memSeq);
			if(adminVO==null){
				searchVO.setMessage("회원이 존재하지 않습니다.");
				LOGGER.debug("message - "+searchVO.getMessage());
				return redirectListPage(searchVO, reda);
			}
		}
		
		model.addAttribute("adminVO", adminVO);
		
		return "/adm/siteMng/member/admSiteMngMemberModify";
	}
	
	//등록 & 수정
	@RequestMapping("/xabdmxgr/siteMng/member/admSiteMngMemberModify.do")
	public String admSiteMngMemberModify(ModelMap model, AdminVO adminVO, RedirectAttributes reda, @ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request)throws Exception{
		LOGGER.info("/xabdmxgr/siteMng/member/admSiteMngMemberModify.do - 관리자 > 사이트관리 > 회원관리 등록 & 수정");
		LOGGER.debug("adminVO - "+adminVO.toString());
		LOGGER.debug("searchVO - "+searchVO.toString());
		
		if("".equals(adminVO.getMemCode()) || adminVO.getMemCode()==null){
			searchVO.setMessage("사번이 없습니다.");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		if("".equals(adminVO.getMemName()) || adminVO.getMemName()==null){
			searchVO.setMessage("이름이 없습니다.");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		if("".equals(adminVO.getMemEmail1()) || adminVO.getMemEmail1()==null){
			searchVO.setMessage("이메일이 없습니다.");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		if("".equals(adminVO.getMemEmail2()) || adminVO.getMemEmail2()==null){
			searchVO.setMessage("이메일이 없습니다.");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		if("".equals(adminVO.getMemMphone2()) || adminVO.getMemMphone2()==null){
			searchVO.setMessage("연락처가 없습니다.");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		if("".equals(adminVO.getMemMphone3()) || adminVO.getMemMphone3()==null){
			searchVO.setMessage("연락처가 없습니다.");
			LOGGER.debug(searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		
		String memEmail=adminVO.getMemEmail1()+"@"+adminVO.getMemEmail2();
		String memMphone=adminVO.getMemMphone1()+"-"+adminVO.getMemMphone2()+"-"+adminVO.getMemMphone3();
		adminVO.setMemEmail(memEmail);
		adminVO.setMemMphone(memMphone);
		
		String rsMemSeq="";

		// 로그 set
		String logJob = "";
		String ip = (!EgovStringUtil.isEmpty(request.getHeader("X-FORWARDED-FOR")))? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
		
		if (EgovStringUtil.isEmpty(adminVO.getMemSeq())) {
			// 등록
			rsMemSeq = admMemberMngDAO.insertSiteMngMemberOne(adminVO);
			
			// 메뉴 권한 등록
			admMemberMngDAO.insertMenuAthr(rsMemSeq, adminVO.getMemLevel());
			
			logJob="사이트 관리 > 회원 관리 > 회원 등록("+adminVO.getMemCode()+")";
			searchVO.setMessage("등록되었습니다.");
		}else {
			// 수정
			if(adminVO.getMemUpdtYn().equals("N")){
				admMemberMngDAO.deleteClsAthrOne(adminVO.getMemSeq());
			}
			
			admMemberMngDAO.updateSiteMngMemberOne(adminVO);
			
			/* 메뉴권한
			 * 	1. 기존권한 삭제
			 * 	2. 신규권한 등록
			 */
			
			// 기존권한 삭제
			admMemberMngDAO.deleteMenuAthr(adminVO.getMemSeq());
			// 신규권한 등록
			admMemberMngDAO.insertMenuAthr(adminVO.getMemSeq(), adminVO.getMemLevel());
			
			logJob="사이트 관리 > 회원 관리 > 회원정보 수정("+adminVO.getMemSeq()+")";
			
			searchVO.setMessage("수정되었습니다.");
		}
		
		// 로그 등록
		admCmmLogDAO.insertLogOne(logJob, ip);
		
		return redirectListPage(searchVO, reda);
	}
	
	//삭제
	@RequestMapping("/xabdmxgr/siteMng/member/admSiteMngMemberDelete.do")
	public String admSiteMngMemberDelete(ModelMap model, String memSeq, RedirectAttributes reda, @ModelAttribute("searchVO")CmmnSearchVO searchVO, HttpServletRequest request)throws Exception{
		LOGGER.info("/xabdmxgr/siteMng/member/admSiteMngMemberDelete.do - 관리자 > 사이트관리 > 회원관리 회원 삭제");
		LOGGER.debug("memSeq - "+memSeq);
		LOGGER.debug("searchVO"+searchVO.toString());

		String ip = (!EgovStringUtil.isEmpty(request.getHeader("X-FORWARDED-FOR")))? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
		String memSeqs[]=memSeq.split(",");
		for(int i=0; i < memSeqs.length; i++){
			LOGGER.debug("memSeqs - "+memSeqs[i]);
			
			// 반_교수 권한 삭제
			admMemberMngDAO.deleteClsAthrOne(memSeqs[i]);

			// 메뉴 권한 삭제
			admMemberMngDAO.deleteMenuAthr(memSeqs[i]);
			
			// 회원 삭제
			admMemberMngDAO.deleteSiteMngMemberOne(memSeqs[i]);
			
			admCmmLogDAO.insertLogOne("사이트 관리 > 회원 관리 > 회원정보 삭제("+memSeq+")", ip);
		}
		
		searchVO.setMessage("삭제되었습니다.");
		
		
		return redirectListPage(searchVO, reda);
	}
	
	//조회
	@RequestMapping("/xabdmxgr/siteMng/member/admSiteMngMemberView.do")
	public String admSiteMngMemberView(ModelMap model, String memSeq, RedirectAttributes reda, @ModelAttribute("searchVO") CmmnSearchVO searchVO, HttpServletRequest request)throws Exception{
		LOGGER.info("/xabdmxgr/siteMng/member/admSiteMngMemberView.do - 관리자 > 사이트관리 > 회원관리 회원 조회");	
		LOGGER.debug("memSeq - "+memSeq);
		LOGGER.debug("searchVO"+searchVO.toString());
		
		AdminVO adminVO=admMemberMngDAO.selectSiteMngMemberOne(memSeq);
		if(adminVO==null){
			searchVO.setMessage("회원이 존재하지 않습니다.");
			LOGGER.debug("message - "+searchVO.getMessage());
			return redirectListPage(searchVO, reda);
		}
		
		model.addAttribute("adminVO",adminVO);

		// 로그 등록
		String ip = (!EgovStringUtil.isEmpty(request.getHeader("X-FORWARDED-FOR")))? request.getHeader("X-FORWARDED-FOR") : request.getRemoteAddr();
		admCmmLogDAO.insertLogOne("사이트 관리 > 회원 관리 > 회원정보 조회("+memSeq+")", ip);
		return "/adm/siteMng/member/admSiteMngMemberView";
	}
}
