package hsDesign.usr.enter.brochure;

import javax.annotation.Resource;
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

import egovframework.let.utl.fcc.service.EgovStringUtil;
import hsDesign.usr.cmm.CmmController;
import hsDesign.valueObject.BrochureVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Controller
public class BrochureController extends CmmController {

	private static final Logger LOGGER = LoggerFactory.getLogger(BrochureController.class);
	
	private static final String APIKEY = "f3147db9bda96d7107dc3860cb4817a6";
	
	@Autowired private BrochureDAO brochureDAO;
	@Resource View jsonView;
	
	/***
	 * 추가개발>
	 * 			추후 회원가입한 뒤 자기 목록 가져오는?
	 * 
	 * 
	 */
	
	// 신청화면
	@RequestMapping("/usr/enter/brochure/brochureModify.do")
	public String brochureModify(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session) throws Exception {
		LOGGER.info("/usr/enter/brochure/brochureModify.do - 사용자 > 입학 > 브로셔신청 > 신청화면");
		LOGGER.debug("searchVO = {}", searchVO.toString());
		// menuNo
		session.setAttribute("menuNo", "207");
		
		//inctopnav
		model.addAttribute("bcList", selectBoardCodeList());
		
		model.addAttribute("bannerList", selectLeftBannerList());
		
		return "/usr/enter/brochure/brochureModify";
	}
	
	// 신청
	@RequestMapping("/usr/enter/brochure/brochureUpdate.do")
	public String brochureUpdate(BrochureVO brochureVO, @ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.info("/usr/enter/brochure/brochureUpdate.do - 사용자 > 입학 > 브로셔신청 > 신청하기");
		LOGGER.debug("brochureVO = {}", brochureVO.toString());
		
		if(
			EgovStringUtil.isEmpty(brochureVO.getBrcName()) || EgovStringUtil.isEmpty(brochureVO.getBrcSchool()) || EgovStringUtil.isEmpty(brochureVO.getBrcTel1()) ||
			EgovStringUtil.isEmpty(brochureVO.getBrcTel2()) || EgovStringUtil.isEmpty(brochureVO.getBrcTel3()) || EgovStringUtil.isEmpty(brochureVO.getBrcMajor()) ||
			EgovStringUtil.isEmpty(brochureVO.getBrcZipcode()) || EgovStringUtil.isEmpty(brochureVO.getBrcAddr1())
		){
			LOGGER.warn("오류발생(-1). 정보를 정확히 입력하지 않았습니다.");
			reda.addFlashAttribute("message", "오류발생(-1)");
			return "redirect:/usr/enter/brochure/brochureModify.do";
			
		}
		
		// 연락처 set
		brochureVO.setBrcTel(brochureVO.getBrcTel1()+"-"+brochureVO.getBrcTel2()+"-"+brochureVO.getBrcTel3());
		
		brochureDAO.brochureInsert(brochureVO);
		reda.addFlashAttribute("message", "브로셔신청이 완료되었습니다.");
		return "redirect:/usr/enter/brochure/brochureModify.do";
	}

/*	
	// 고등학교 검색 api
	@RequestMapping("/usr/enter/brochure/middleSchoolSearchAjax.do")
	public View middleSchoolSearchAjax(ModelMap model) throws Exception {
		LOGGER.info("/usr/enter/brochure/middleSchoolSearchAjax.do - 사용자 > 입학 > 브로셔신청 > 고등학교 검색");
		
		URL url = new URL("http://www.career.go.kr/cnet/openapi/getOpenApi?apiKey="+APIKEY+"&svcType=api&svcCode=SCHOOL&contentType=json&gubun=high_list");
		HttpURLConnection urlConn = (HttpURLConnection) url.openConnection();
		urlConn.setRequestMethod("GET");
		//urlConn.setDoOutput(true);
		urlConn.setRequestProperty("Content-Type", "application/json");
		urlConn.connect();
		
		//OutputStreamWriter urlOutput = new OutputStreamWriter(urlConn.getOutputStream());
		
		BufferedReader urlInput = new BufferedReader(new InputStreamReader(urlConn.getInputStream(), "UTF-8"));
		String str = "";
		str = urlInput.readLine();
		urlInput.close();
		model.addAttribute("data", str);
		
		return jsonView;
	}
*/
}