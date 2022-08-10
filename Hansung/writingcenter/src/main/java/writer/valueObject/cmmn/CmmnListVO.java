package writer.valueObject.cmmn;

import java.util.List;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public class CmmnListVO {
	
	private int totalRecordCount = 0;
	private List<EgovMap> egovList = null;
	
	public CmmnListVO(int totalRecordCount, List<EgovMap> egovList) {
		this.totalRecordCount = totalRecordCount;
		this.egovList = egovList;
	}
	
	public int getTotalRecordCount() {
		return totalRecordCount;
	}
	public void setTotalRecordCount(int totalRecordCount) {
		this.totalRecordCount = totalRecordCount;
	}
	public List<EgovMap> getEgovList() {
		return egovList;
	}
	public void setEgovList(List<EgovMap> egovList) {
		this.egovList = egovList;
	}
	
	

}
