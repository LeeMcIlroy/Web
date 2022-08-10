package lcms.adm.cmm;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;

import component.util.ComStringUtil;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import lcms.cmm.CmmDAO;
import lcms.valueObject.LogVO;

public class AdmCmmController {
	@Autowired protected CmmDAO cmmDAO;
	
	// 로그 등록
	protected void admLogInsert(String logCont, String memberCode, HttpServletRequest request) throws Exception{
		String acceIp = ComStringUtil.getClientIP(request);
		String regId = EgovUserDetailsHelper.getAuthenticatedAdminId();
		LogVO logVO = new LogVO(regId, memberCode, logCont, acceIp);
		cmmDAO.insertAdmLog(logVO);
	}
}
