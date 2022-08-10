package writer.adm.cmm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import writer.valueObject.AdminVO;
import writer.valueObject.DepartmentVO;
import writer.valueObject.SemesterVO;
import writer.valueObject.cmmn.CmmnSearchVO;

@Repository
public class AdmCmmDAO extends EgovAbstractDAO {
	
	// 학기강의실 목록
	@SuppressWarnings("unchecked")
	public List<SemesterVO>	selectSmtrList(){
		return (List<SemesterVO>) list("AdmCmmDAO.selectSmtrList");
	}
	@SuppressWarnings("unchecked")
	public List<SemesterVO>	selectSmtrList(CmmnSearchVO searchVO){
		return (List<SemesterVO>) list("AdmCmmDAO.selectSmtrList", searchVO);
	}
	
	// 계열 목록
	@SuppressWarnings("unchecked")
	public List<DepartmentVO> selectDeptList(){
		return (List<DepartmentVO>) list("AdmCmmDAO.selectDeptList");
	}
	@SuppressWarnings("unchecked")
	public List<DepartmentVO> selectDeptList(CmmnSearchVO searchVO){
		return (List<DepartmentVO>) list("AdmCmmDAO.selectDeptList", searchVO);
	}
	
	// 반_교수 조회
	public EgovMap selectClassOne(String clsSeq){
		return (EgovMap) select("AdmCmmDAO.selectClassOne", clsSeq);
	}
	
	// 반_교수 나의 목록
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectMyClassList(CmmnSearchVO searchVO){
		AdminVO adminVO = (AdminVO) EgovUserDetailsHelper.getAuthenticatedAdmin();
		Map<String, Object> map = new HashMap<>();
		map.put("adminVO", adminVO);
		map.put("searchVO", searchVO);
		return (List<EgovMap>) list("AdmCmmDAO.selectMyClassList", map);
	}
	
	// 회원 목록
	@SuppressWarnings("unchecked")
	public List<AdminVO> selectAdmList(){
		return (List<AdminVO>) list("AdmCmmDAO.selectAdmList");
	}
	@SuppressWarnings("unchecked")
	public List<AdminVO> selectAdmList(String clsSeq){
		return (List<AdminVO>) list("AdmCmmDAO.selectAdmList", clsSeq);
	}
	
}
