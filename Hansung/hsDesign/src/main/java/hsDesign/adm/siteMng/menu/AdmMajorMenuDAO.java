package hsDesign.adm.siteMng.menu;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import hsDesign.valueObject.MenuVO;
import hsDesign.valueObject.cmm.CmmnListVO;
import hsDesign.valueObject.cmm.CmmnSearchVO;

@Repository
public class AdmMajorMenuDAO extends EgovAbstractDAO {

	//전공메뉴관리 목록
	public CmmnListVO selectAdmMenuList(CmmnSearchVO searchVO) {
		int totalRecordCount = (int) select("AdmMajorMenuDAO.selectAdmMenuListCnt", searchVO);
		List<EgovMap> resultList = (List<EgovMap>) list("AdmMajorMenuDAO.selectAdmMenuList", searchVO);
		return new CmmnListVO(totalRecordCount, resultList);
	}

	//전공메뉴 조회
	public MenuVO selectAdmMenuOne(String mmSeq){
		return (MenuVO) select("AdmMajorMenuDAO.selectAdmMenuOne", mmSeq);
	}
	
	
	//전공메뉴 등록
	public String insertAdmMenu(MenuVO paramVO) {
		return (String) insert("AdmMajorMenuDAO.insertAdmMenu", paramVO);
	}

	//전공메뉴 수정
	public void updateAdmMenu(MenuVO paramVO) {
		update("AdmMajorMenuDAO.updateAdmMenu", paramVO);
	}

	//전공불러오기
	public List<EgovMap> selectAdmMajorList() {
		return (List<EgovMap>) list("AdmMajorMenuDAO.selectAdmMajorList");
	}

	//게시판이름 불러오기
	public List<EgovMap> selectMajorMenuBoardList(){
		return (List<EgovMap>) list("AdmMajorMenuDAO.selectMajorMenuBoardList");
	}
	
	//말머리 불러오기
	public List<EgovMap> selectMajorMenuHeaderList(){
		return (List<EgovMap>) list("AdmMajorMenuDAO.selectMajorMenuHeaderList");
	}

	//말머리 등록하기
	public void insertAdmMenuHead(Map<String, String> paramMap) {
		insert("AdmMajorMenuDAO.insertAdmMenuHead", paramMap);
	}

	//말머리 삭제
	public void deleteAdmMenuHead(String mmSeq) {
		delete("AdmMajorMenuDAO.deleteAdmMenuHead", mmSeq);
	}
}
