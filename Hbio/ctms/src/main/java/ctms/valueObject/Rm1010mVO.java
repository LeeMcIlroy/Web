package ctms.valueObject;

import egovframework.let.utl.fcc.service.EgovStringUtil;

/**
 * @author 개발2
 * 
 * 이메일메시지(예문)VO 2020.12.04
 *
 */
public class Rm1010mVO {

		private String corpCd               = ""; // 회사코드
	    private String emailtNo             = ""; // 이메일예문번호
	    private String title                = ""; // 제목
	    private String cont                 = ""; // 내용
	    private String remk                 = ""; // 비고
	    private String dataRegdt            = ""; // 등록수정일
	    private String dataRegnt            = ""; // 등록수정자
		public String getCorpCd() {
			return corpCd;
		}
		public void setCorpCd(String corpCd) {
			this.corpCd = corpCd;
		}
		public String getEmailtNo() {
			return emailtNo;
		}
		public void setEmailtNo(String emailtNo) {
			this.emailtNo = emailtNo;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
		public String getCont() {
			return cont;
		}
		public void setCont(String cont) {
			this.cont = cont;
		}
		public String getRemk() {
			return remk;
		}
		public void setRemk(String remk) {
			this.remk = remk;
		}
		public String getDataRegdt() {
			return dataRegdt;
		}
		public void setDataRegdt(String dataRegdt) {
			this.dataRegdt = dataRegdt;
		}
		public String getDataRegnt() {
			return dataRegnt;
		}
		public void setDataRegnt(String dataRegnt) {
			this.dataRegnt = dataRegnt;
		}
		@Override
		public String toString() {
			return "Rm1010mVO [corpCd=" + corpCd + ", emailtNo=" + emailtNo + ", title=" + title + ", cont=" + cont
					+ ", remk=" + remk + ", dataRegdt=" + dataRegdt + ", dataRegnt=" + dataRegnt + "]";
		}
	 
	   
	
	
}
