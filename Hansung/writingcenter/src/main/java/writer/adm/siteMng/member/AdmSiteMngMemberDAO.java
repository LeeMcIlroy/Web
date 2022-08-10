package writer.adm.siteMng.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import writer.valueObject.AdminVO;
import writer.valueObject.cmmn.CmmnListVO;
import writer.valueObject.cmmn.CmmnSearchVO;


@Repository
public class AdmSiteMngMemberDAO extends EgovAbstractDAO {
	

	/* 회원관리 목록 */
	public CmmnListVO selectSiteMngMemberList(CmmnSearchVO searchVO){
		@SuppressWarnings("unchecked")
		List<EgovMap> egovList=(List<EgovMap>) list("AdmSiteMngMemberDAO.selectSiteMngMemberList", searchVO);
		int totalRecordCount=(int) select("AdmSiteMngMemberDAO.selectSiteMngMemberListCnt", searchVO);
		return new CmmnListVO(totalRecordCount, egovList);
	}
	
	/* 회원 입력 */
	public String insertSiteMngMemberOne(AdminVO memberVO){
		return (String) insert("admSiteMngMemberDAO.insertSiteMngMemberOne", memberVO);
	}
	
	/* 회원 삭제 */
	public void deleteSiteMngMemberOne(String memSeq){
		delete("admSiteMngMemberDAO.deleteSiteMngMemberOne", memSeq);
	}
	
	/* 회원 조회 */
	public AdminVO selectSiteMngMemberOne(String memSeq){
		return (AdminVO) select("admSiteMngMemberDAO.selectSiteMngMemberOne", memSeq);
	}
	
	/* 회원 수정 */
	public void updateSiteMngMemberOne(AdminVO adminVO){
		update("admSiteMngMemberDAO.updateSiteMngMemberOne", adminVO);
	}
	
	/* 첨삭 수정여부에따른 권한 삭제 */
	public void deleteClsAthrOne(String memSeq){
		delete("admSiteMngMemberDAO.deleteClsAthrOne", memSeq);
	}

	/* 권한 등록 */
	public void insertMenuAthr(String memSeq, String memLevel){
		Map<String, String> map = new HashMap<>();
		map.put("memSeq", memSeq);
		map.put("memLevel", memLevel);
		insert("admSiteMngMemberDAO.insertMenuAthr", map);
	}
	
	/* 권한 삭제 */
	public void deleteMenuAthr(String memSeq){
		delete("admSiteMngMemberDAO.deleteMenuAthr", memSeq);
	}
}
