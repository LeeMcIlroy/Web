package ctms.adm.login;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import component.util.ComStringUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import ctms.adm.cmm.AdmCmmController;
import ctms.valueObject.AdminVO;

@Controller
public class AdmLoginController extends AdmCmmController{

	private static final Logger LOGGER = LoggerFactory.getLogger(AdmLoginController.class);
	@Autowired private AdmLoginDAO admLoginDAO;

	
	@Resource(name = "propertiesService") protected EgovPropertyService propertyService;
	
	//로그인화면으로 리다이렉트합니다.
	private String redirectLoginView(RedirectAttributes reda, String message){
		reda.addFlashAttribute("message", message);
		return "redirect:/qxsepmny/lgn/admLoginView.do";
	}

	//로그인후 초기화면으로 리다이렉트합니다.
	private String redirectIndex(){
		return "redirect:/qxsepmny/ech0105/ech0105List.do";
	}
	
	//로그인후 초기화면으로 리다이렉트합니다.
	private String redirectIndex2(){
		return "redirect:/qxsepmny/ecr0101/ecr0101List.do";
	}
	
	/**
	 * 관리자 로그인 화면으로 이동합니다.
	 * 이미 로그인 되어 있는 경우 첫페이지로 이동합니다.
	 * @param model
	 * @return 로그인화면
	 * @throws Exception
	 */
	@RequestMapping("/qxsepmny/lgn/admLoginView.do")
	public String admLoginView(HttpServletRequest request, ModelMap model) throws Exception {
		LOGGER.debug("/qxsepmny/lgn/admLoginView.do - 관리자 로그인 화면");
		
		model.addAttribute("adminVO", new AdminVO());
		
		return "/adm/login/admLoginView";
	}
	
	// 관리자 로그인
	@RequestMapping("/qxsepmny/lgn/admLoginProc.do")
	public String admLoginProc(AdminVO adminVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/lgn/admLoginProc.do - 관리자 로그인");
		
		String message = "";
		
		/*
		 * LOGGER.debug("getAdminPw"+adminVO.getAdminPw());
		 * LOGGER.debug("getAdminId"+adminVO.getAdminId());
		 */	
		
		
		//return redirectIndex();
		
		if(adminVO != null){
			//비밀번호 암호 인코딩 
			
			adminVO.setAdminPw(EgovFileScrty.encryptPassword(adminVO.getAdminPw(), adminVO.getAdminId()));
			/* LOGGER.debug("adminVO"+adminVO.getAdminPw()); */
			
			AdminVO resultVO = admLoginDAO.selectAdmLoginProc(adminVO);
			if(resultVO == null){
				message = "로그인 정보가 올바르지 않습니다.";
				return redirectLoginView(reda, message);
			}
						
			if(resultVO != null){
				
				// 사용 
				if("1".equals(resultVO.getUseYn())){
					if(adminVO.getAdminPw().equals(resultVO.getAdminPw())){
						if(5 > Integer.parseInt(resultVO.getLoginFail())){
							String clientIp = ComStringUtil.getClientIP(request);
							/* LOGGER.debug("clientIp"+clientIp); */
							if(!clientIp.equals(resultVO.getAcceIp()) && (!"Y".equals(resultVO.getIpAllYn()))){
								message = "허용된 IP가 아닙니다.";
							}else{
								resultVO.setLoginFail("0");
								admLoginDAO.updateAdmLoginFail(resultVO);
								admLoginDAO.updateAdmLoginDateTime(resultVO);
								resultVO = admLoginDAO.selectAdmLoginProc(adminVO);
								request.getSession().setAttribute("adminSessionCtms", resultVO);
								
								//접속로그 등록
								EgovMap map = new EgovMap();
								
								map.put("corpCd", resultVO.getCorpCd());
								map.put("branchCd", resultVO.getBranchCd());
								map.put("empNo", resultVO.getEmpNo());
								map.put("loginId", resultVO.getAdminId());
								map.put("name", resultVO.getName());
								//직원구분을 설정할 것 CM1230 10 직원  20 협력 90 유지보수
								map.put("loginType", "10");
								map.put("acceIp", clientIp);
															
								cmmDAO.insertLoginLog(map);
								
								return redirectIndex();
							}
						}else{
							message = "사용이 중지된 계정입니다.\r\n관리자에게 문의하세요.";
						}
					}else if("2".equals(resultVO.getAdminType())){ //
						resultVO.setLoginFail(String.valueOf(Integer.parseInt(resultVO.getLoginFail())+1));
						admLoginDAO.updateAdmLoginFail(resultVO);
						message = "로그인 정보가 올바르지 않습니다.\r\n5회 이상 실패시 로그인하실 수 없습니다.\r\n"+resultVO.getLoginFail()+"회 실패하였습니다.";
					}else{
						message = "로그인 정보가 올바르지 않습니다.";
					}
				}else{
					// 로그인 중지 
					message = "유효하지 않은 아이디입니다.";
				}
			}else{
				message = "로그인 정보가 올바르지 않습니다.";
			}
		}
		
		return redirectLoginView(reda, message);
	}
	
	// 관리자 로그인-eCRF작성
	@RequestMapping("/qxsepmny/lgn/admLoginProc2.do")
	public String admLoginProc2(AdminVO adminVO, HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/lgn/admLoginProc2.do - 관리자 로그인-eCRF 작성");
		
		String message = "";
		
		/*
		 * LOGGER.debug("getAdminPw"+adminVO.getAdminPw());
		 * LOGGER.debug("getAdminId"+adminVO.getAdminId());
		 */	
		
		
		//return redirectIndex();
		
		if(adminVO != null){
			//비밀번호 암호 인코딩 
			
			adminVO.setAdminPw(EgovFileScrty.encryptPassword(adminVO.getAdminPw(), adminVO.getAdminId()));
			/* LOGGER.debug("adminVO"+adminVO.getAdminPw()); */
			
			AdminVO resultVO = admLoginDAO.selectAdmLoginProc(adminVO);
			if(resultVO == null){
				message = "로그인 정보가 올바르지 않습니다.";
				return redirectLoginView(reda, message);
			}
						
			if(resultVO != null){
				
				// 사용 
				if("1".equals(resultVO.getUseYn())){
					if(adminVO.getAdminPw().equals(resultVO.getAdminPw())){
						if(5 > Integer.parseInt(resultVO.getLoginFail())){
							String clientIp = ComStringUtil.getClientIP(request);
							/* LOGGER.debug("clientIp"+clientIp); */
							if(!clientIp.equals(resultVO.getAcceIp()) && (!"Y".equals(resultVO.getIpAllYn()))){
								message = "허용된 IP가 아닙니다.";
							}else{
								resultVO.setLoginFail("0");
								admLoginDAO.updateAdmLoginFail(resultVO);
								admLoginDAO.updateAdmLoginDateTime(resultVO);
								resultVO = admLoginDAO.selectAdmLoginProc(adminVO);
								request.getSession().setAttribute("adminSessionCtms", resultVO);
								
								//접속로그 등록
								EgovMap map = new EgovMap();
								
								map.put("corpCd", resultVO.getCorpCd());
								map.put("branchCd", resultVO.getBranchCd());
								map.put("empNo", resultVO.getEmpNo());
								map.put("loginId", resultVO.getAdminId());
								map.put("name", resultVO.getName());
								//직원구분을 설정할 것 CM1230 10 직원  20 협력 90 유지보수
								map.put("loginType", "10");
								map.put("acceIp", clientIp);
															
								cmmDAO.insertLoginLog(map);
								
								return redirectIndex2(); //eCRF작성화면
							}
						}else{
							message = "사용이 중지된 계정입니다.\r\n관리자에게 문의하세요.";
						}
					}else if("2".equals(resultVO.getAdminType())){ //
						resultVO.setLoginFail(String.valueOf(Integer.parseInt(resultVO.getLoginFail())+1));
						admLoginDAO.updateAdmLoginFail(resultVO);
						message = "로그인 정보가 올바르지 않습니다.\r\n5회 이상 실패시 로그인하실 수 없습니다.\r\n"+resultVO.getLoginFail()+"회 실패하였습니다.";
					}else{
						message = "로그인 정보가 올바르지 않습니다.";
					}
				}else{
					// 로그인 중지 
					message = "유효하지 않은 아이디입니다.";
				}
			}else{
				message = "로그인 정보가 올바르지 않습니다.";
			}
		}
		
		return redirectLoginView(reda, message);
	}
	
	
	// 관리자 로그아웃
	@RequestMapping("/qxsepmny/lgn/admLogout.do")
	public String admLogout(HttpServletRequest request, ModelMap model, RedirectAttributes reda) throws Exception {
		LOGGER.debug("/qxsepmny/lgn/admLogout.do - 관리자 로그아웃");
		
		String message = "로그아웃 되었습니다.";
		request.getSession().removeAttribute("adminSessionCtms");
		
		return redirectLoginView(reda, message);
	}
	
}
