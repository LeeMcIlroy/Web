package writer.adm.lecMng.smtr;

import java.net.UnknownHostException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import writer.adm.cmm.AdmCmmLogDAO;
import writer.valueObject.AdminVO;
import writer.valueObject.SemesterVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Repository
public class AdmLecMngSmtrDAO extends EgovAbstractDAO {
	

	// 목록
	@SuppressWarnings("unchecked")
	public CmmnListVO selectLecMngSmtrList(CmmnSearchVO searchVO){
		int totalRecordCount = (int) select("AdmLecMngSmtrDAO.selectLecMngSmtrListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmLecMngSmtrDAO.selectLecMngSmtrList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}
	
	// 조회
	public SemesterVO selectLecMngSmtrOne(String smtrSeq){
		return (SemesterVO) select("AdmLecMngSmtrDAO.selectLecMngSmtrOne", smtrSeq);
	}
	
	// 등록
	public void lecMngSmtrInsert(SemesterVO semesterVO){
		AdminVO adminVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		semesterVO.setRegId(adminVO.getMemCode());
		semesterVO.setRegName(adminVO.getMemName());
		
		insert("AdmLecMngSmtrDAO.lecMngSmtrInsert", semesterVO);
	}

	// 수정
	public void lecMngSmtrUpdate(SemesterVO semesterVO) throws UnknownHostException{
		update("AdmLecMngSmtrDAO.lecMngSmtrUpdate", semesterVO);
	}
	
	// 삭제
	public void lecMngSmtrDelete(String smtrSeq) throws UnknownHostException{
		delete("AdmLecMngSmtrDAO.lecMngSmtrDelete", smtrSeq);
	}
	
	// 데이터 존재유무 확인
	public int lecMngSmtrCnt(String smtrSeq){
		return (int) select("AdmLecMngSmtrDAO.lecMngSmtrCnt", smtrSeq);
	}
}
