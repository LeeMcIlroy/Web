package writer.adm.cmm;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import writer.valueObject.AdminVO;

@Repository
public class AdmCmmLogDAO extends EgovAbstractDAO{

	/* 관리자 로그 기록*/
	public void insertLogOne(String logJob, String ip){
				
		AdminVO adminVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("logId", "admin");
		map.put("logIp", ip);
		map.put("logJob", logJob);
		
		insert("AdmCmmLogDAO.insertCmmLogOne",map);
		
	}
	
	/* 공통게시판 타입 구분*/
	public void insertLogOne_cmm(String brdType, Object brdSeq, String log_mid, String ip){
		System.out.println("-------------------------"+brdType);
		String logJob="";
		if("EXCLNT".equals(brdType)){
			logJob+="글쓰기길잡이 > 우수과제";
		}else if("WINFO".equals(brdType)){
			logJob+="글쓰기길잡이 > 글쓰기정보";
		}else if("NOTI".equals(brdType)){
			logJob+="게시판관리 > 공지사항";
		}else if("CNTST".equals(brdType)){
			logJob+="게시판관리 > 대회자료실";
		}else if("FREE".equals(brdType)){
			logJob+="게시판관리 > 자유게시판";
		}
		
		logJob += log_mid +"("+brdSeq+")";
		
		insertLogOne(logJob, ip);
	}

	
}
