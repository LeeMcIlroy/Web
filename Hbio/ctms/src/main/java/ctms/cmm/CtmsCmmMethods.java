package ctms.cmm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import ctms.adm.ech0101.Ech0101DAO;

import ctms.valueObject.cmm.CmmnSearchVO;
import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Component
public class CtmsCmmMethods {

	private static final Logger LOGGER = LoggerFactory.getLogger(CtmsCmmMethods.class);
	//public final static String redirectProfileView = "redirect:/crm/cmm/profileView.do";
	public final static String redirectLoginView = "redirect://qxsepmny/lgn/admLoginView.do";

	private static Ech0101DAO memDaoInstance;
	private static CmmDAO cmmDAOInstance;
	public static Map<String, EgovMap> menuMap = new HashMap<>();

	@Autowired
	private Ech0101DAO memberDAO;
	@Autowired
	private CmmDAO cmmDAO;

	
	@PostConstruct
	private void init() {
		memDaoInstance = memberDAO;
		cmmDAOInstance = cmmDAO;
		// 전체 메뉴 메모리 저장.
		//for(EgovMap menu : cmmDAOInstance.selectCmmMenuAthrList()) {
			//menuMap.put(menu.get("key").toString(), menu);
		//}
	}
	
	// 접근 권한 거부로 인해, 리다이렉트된 메시지 처리.
	public static void initMessage(HttpSession session, ModelMap model) {
		String message = (String)session.getAttribute("message");
		if(!EgovStringUtil.isEmpty(message)) {
			model.addAttribute("message", message);
			session.removeAttribute("message");
		}
	}
	
	// CSRF 토큰 공유
	public static void setCsrfToken(HttpSession session) {
		session.setAttribute("csrfToken", UUID.randomUUID().toString());
	}
	
	// CSRF 토큰 검사.
	public static boolean isCsrfToken(HttpServletRequest request, RedirectAttributes reda) {
		
		String reqMethod = request.getMethod();
		String sessionCsrfToken = (String)request.getSession().getAttribute("csrfToken");
		String formCsrfToken = request.getParameter("csrfToken");
		
		// GET 요청은 무시
		boolean isValid = true;
		if( EgovStringUtil.isEmpty(sessionCsrfToken)
			   ||
			("POST".equals(reqMethod) 
			&& !sessionCsrfToken.equals(formCsrfToken))
		  ) {
			isValid = false;
			if(reda !=null) {
				reda.addFlashAttribute("message", "접근 권한이 없습니다.(-4)");
			}
		}
		return isValid;
		
	}
	
		
}



