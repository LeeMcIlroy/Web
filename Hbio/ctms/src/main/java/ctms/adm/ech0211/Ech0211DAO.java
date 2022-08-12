
package ctms.adm.ech0211;
 
import java.util.List;
 
import org.springframework.stereotype.Repository;

import ctms.valueObject.Cr2110mVO;
import ctms.valueObject.Cr3200mVO;
import ctms.valueObject.Cr2020mVO;
import ctms.valueObject.Cr2100mVO;
import ctms.valueObject.Rs1000mVO;
import ctms.valueObject.cmm.CmmnListVO;
import ctms.valueObject.cmm.CmmnSearchVO; 
import egovframework.rte.psl.dataaccess.EgovAbstractDAO; 
import egovframework.rte.psl.dataaccess.util.EgovMap; 
 
@Repository 
public class Ech0211DAO extends EgovAbstractDAO {
 
    @SuppressWarnings("unchecked")
    public CmmnListVO selectech0211List(CmmnSearchVO searchVO) throws Exception {
        int totalRecordCount = (Integer) select("ech0211.selectech0211ListCnt", searchVO);
        List<EgovMap> resultList = (List<EgovMap>) list("ech0211.selectech0211List", searchVO);
 
        return new CmmnListVO(totalRecordCount, resultList);
    }
    
    public Rs1000mVO selectech0211View(EgovMap paramMap) throws Exception {
        return (Rs1000mVO) select("ech0211.selectech0211View", paramMap);
    }
    
    public String insertech0211(Cr2020mVO cr2020mVO) throws Exception {
        return (String) insert("ech0211.insertech0211", cr2020mVO);
    }
     
    public void updateech0211(Rs1000mVO rs1000mVO) throws Exception {
        update("ech0211.updateech0211", rs1000mVO);
    }
     
    @SuppressWarnings("unchecked")
    public List<EgovMap> selectech0211Excel(CmmnSearchVO searchVO) throws Exception {
        return (List<EgovMap>) list("ech0211.selectech0211Excel", searchVO);
    }

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0211TempList(EgovMap paramMap) throws Exception {
		return (List<EgovMap>) list("ech0211.selectEch0211TempList", paramMap);
	}

	public String insertech0211eCRF(Cr2110mVO cr2110mVO) throws Exception {
		return (String) insert("ech0211.insertech0211eCRF", cr2110mVO);
	}

	public void deleteech0211eCRF(EgovMap paramMap) throws Exception {
		delete("ech0211.deleteech0211eCRF", paramMap);
	}

	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0211eCrfList(EgovMap paramMap) throws Exception {
		return (List<EgovMap>) list("ech0211.selectEch0211eCrfList", paramMap);
	}
	
	// CRF작성 총구성쪽수 cnt
	public int selectEcr0211TUsePageCnt(EgovMap answMap) throws Exception {
		return (int) select("Ecr0211DAO.selectEcr0211TUsePageCnt", answMap);		
	}

	// CRF 총구성쪽수 update
	public void updateEch0211TpageCnt(Rs1000mVO rs1000mVO) throws Exception {
        update("Ecr0211DAO.updateEch0211TpageCnt", rs1000mVO);
    }
	
	// 연구과제  CRF 리스트 
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0211CrfList(EgovMap paramMap) throws Exception {
		return (List<EgovMap>) list("ech0211.selectEch0211eCrfList", paramMap);
	}
	
	// CRF 시작번호 update
	public void updateEch0211SpageCnt(EgovMap paramMap) throws Exception {
        update("Ecr0211DAO.updateEch0211SpageCnt", paramMap);
    }
	
	// CRF 템플릿 등록여부 확인
	public int selectEch0211TempCnt(Cr2100mVO cr2100mVO) throws Exception {
		int totalRecordCount  = (int) select("Ech0211DAO.selectEch0211TempCnt", cr2100mVO);
		return totalRecordCount;
	}
	
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0211TempList2(EgovMap paramMap) throws Exception {
		return (List<EgovMap>) list("ech0211.selectEch0211TempList2", paramMap);
	}
	
	// 연구종료확인서 설정체크 cnt
	public int selectEch0211RsFinSetChkCnt(EgovMap map) throws Exception {
		int totalRecordCount  = (int) select("Ech0211DAO.selectEch0211RsFinSetChkCnt", map);
		return totalRecordCount;
	}
	
	// CRF삭제
	public void deleteEch0211AjaxDelCrf(EgovMap map) throws Exception {
		delete("Ech0211DAO.deleteEch0211AjaxDelCrf", map);
	}
	
	// CRF작성 여부 작성 cnt
	public int selectEcr0211MkCrfCnt(EgovMap map) throws Exception {
		return (int) select("Ecr0211DAO.selectEcr0211MkCrfCnt", map);		
	}
	
	// 연구관리 CRF상태 저장 - 대기, 작성중, 확정 - '확정'상태만 CRF 작성설정 가능
	public void updateEch0211CrfState(EgovMap map) throws Exception {
        update("Ecr0211DAO.updateEch0211CrfState", map);
    }
	
	//템플릿작성타입, 템플릿번호 조회
	public Cr2100mVO selectEch0211MkType(EgovMap map) throws Exception {
		return (Cr2100mVO) select("Ech0211DAO.selectEch0211MkType", map);		
	}
	
	// CRF작성차수 등록여부 확인 cnt
	public int selectEch0211SvSeqCnt(EgovMap map) throws Exception {
		return (int) select("Ech0211DAO.selectEch0211SvSeqCnt", map);		
	}
	
	// CRF작성차수 재설정
	public void updateEch0211ResetSvSeq(EgovMap map) throws Exception {
        update("Ech0211DAO.updateEch0211ResetSvSeq", map);
    }
	
	//CRF설정정보 상세조회
	public Cr2110mVO selectEch0211CrfDetail(EgovMap map) throws Exception {
		return (Cr2110mVO) select("Ech0211DAO.selectEch0211CrfDetail", map);		
	}
	
	@SuppressWarnings("unchecked")
	public List<EgovMap> selectEch0211RsNoMtlList(EgovMap map) throws Exception {
		return (List<EgovMap>) list("Ech0211DAO.selectEch0211RsNoMtlList", map);
	}
	
	// 작성차수 순번 설정
	public int selectEch0211NextSvSeq(EgovMap map) throws Exception {
		return (int) select("Ech0211DAO.selectEch0211NextSvSeq", map);		
	}
	
	//템플릿구분 조회
	public String selectEch0211TempType(EgovMap map) throws Exception {
		return (String) select("Ech0211DAO.selectEch0211TempType", map);
	}
	
	// CRF설정 작성차수 등록여부 확인 cnt
	public int selectEch0211ChkSvSeqCnt(EgovMap map) throws Exception {
		return (int) select("Ech0211DAO.selectEch0211ChkSvSeqCnt", map);		
	}
	
}