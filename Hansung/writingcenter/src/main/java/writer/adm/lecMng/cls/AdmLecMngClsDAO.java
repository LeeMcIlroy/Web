package writer.adm.lecMng.cls;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import writer.valueObject.AdminVO;
import writer.valueObject.ClassVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Repository
public class AdmLecMngClsDAO extends EgovAbstractDAO {
	
	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectLecMngClsList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmLecMngClsDAO.selectLecMngClsListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmLecMngClsDAO.selectLecMngClsList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 조회
	public ClassVO selectLecMngClsOne(String clsSeq){
		return (ClassVO) select("AdmLecMngClsDAO.selectLecMngClsOne", clsSeq);
	}
	
	// 등록
	public String lecMngClsInsert(ClassVO classVO){
		AdminVO adminVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		classVO.setRegId(adminVO.getMemCode());
		classVO.setRegName(adminVO.getMemName());
		
		return (String) insert("AdmLecMngClsDAO.lecMngClsInsert", classVO);
	}
	
	// 수정
	public void lecMngClsUpdate(ClassVO classVO){
		update("AdmLecMngClsDAO.lecMngClsUpdate", classVO);
	}
	
	// 삭제
	public void lecMngClsDelete(String clsSeq){
		delete("AdmLecMngClsDAO.lecMngClsDelete", clsSeq);
	}
	
	/**************************************** 반_교수 권한(주제 및 첨삭) *****************************************/
	// 등록
	public void lecMngClsAthrInsert(String clsSeq, String memSeq){
		Map<String, String> map = new HashMap<>();
		map.put("clsSeq", clsSeq);
		map.put("memSeq", memSeq);
		
		insert("AdmLecMngClsDAO.lecMngClsAthrInsert", map);
	}
	//데이터유무 확인
	public int lecMngClsNotiCnt(String clsSeq){
		return (int) select("AdmLecMngClsDAO.lecMngClsNotiCnt",clsSeq);
	}
	public int lecMngClsSbjtCnt(String clsSeq){
		return (int) select("AdmLecMngClsDAO.lecMngClsSbjtCnt",clsSeq);
	}
	public int lecMngClsMyClsCnt(String clsSeq){
		return (int) select("AdmLecMngClsDAO.lecMngClsMyClsCnt",clsSeq);
	}
	
	
	// 삭제
	public void lecMngClsAthrDelete(String clsSeq){
		delete("AdmLecMngClsDAO.lecMngClsAthrDelete", clsSeq);
	}
}
