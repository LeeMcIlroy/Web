package hsDesign.valueObject.cmm;

public class CmmnSearchVO {

	/** 타입 */
	private String searchType = "";
	public String getSearchType() { return searchType; }
	public void setSearchType(String searchType) { this.searchType = searchType; }
	
	/** 메뉴 타입*/
	private String menuType = "";
	public String getMenuType() { return menuType; }
	public void setMenuType(String menuType) { this.menuType = menuType; }

	/** 검색 조건1 */
	private String searchCondition1 = "";
	public String getSearchCondition1() { return searchCondition1; }
	public void setSearchCondition1(String searchCondition1) { this.searchCondition1 = searchCondition1; }
	
	/** 검색 조건2 */
	private String searchCondition2 = "";
	public String getSearchCondition2() { return searchCondition2; }
	public void setSearchCondition2(String searchCondition2) { this.searchCondition2 = searchCondition2; }
	
	/** 검색 조건3 */
	private String searchCondition3 = "";
	public String getSearchCondition3() { return searchCondition3; }
	public void setSearchCondition3(String searchCondition3) { this.searchCondition3 = searchCondition3; }
	
	/** 검색 조건4 */
	private String searchCondition4 = "";
	public String getSearchCondition4() { return searchCondition4; }
	public void setSearchCondition4(String searchCondition4) { this.searchCondition4 = searchCondition4; }
	
	/** 검색 단어 */
	private String searchWord = "";
	public String getSearchWord() { return searchWord; }
	public void setSearchWord(String searchWord) { this.searchWord = searchWord; }

	/** 날짜 */
	private String startDate = "";
	private String endDate = "";
	public String getStartDate() { return startDate; }
	public void setStartDate(String startDate) { this.startDate = startDate; }
	public String getEndDate() { return endDate; }
	public void setEndDate(String endDate) { this.endDate = endDate; }
	
	private String searchDate = "";
	public String getSearchDate() { return searchDate; }
	public void setSearchDate(String searchDate) { this.searchDate = searchDate; }
	
	/** 메세지 */
	private String message = "";

	/** 현재페이지 */
	private int pageIndex = 1;

	/** firstIndex */
	private int firstIndex = 1;

	/** lastIndex */
	private int lastIndex = 1;

	/** recordCountPerPage */
	private int recordCountPerPage = 10;

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public int getFirstIndex() {
		return firstIndex;
	}

	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	public int getLastIndex() {
		return lastIndex;
	}

	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}
	@Override
	public String toString() {
		return "CmmnSearchVO [\r\nsearchType=" + searchType + "\r\n menuType=" + menuType + "\r\n searchCondition1="
				+ searchCondition1 + "\r\n searchCondition2=" + searchCondition2 + "\r\n searchCondition3=" + searchCondition3
				+ "\r\n searchCondition4=" + searchCondition4 + "\r\n searchWord=" + searchWord + "\r\n startDate=" + startDate
				+ "\r\n endDate=" + endDate + "\r\n searchDate=" + searchDate + "\r\n message=" + message + "\r\n pageIndex="
				+ pageIndex + "\r\n firstIndex=" + firstIndex + "\r\n lastIndex=" + lastIndex + "\r\n recordCountPerPage="
				+ recordCountPerPage + "\r\n]";
	}
}