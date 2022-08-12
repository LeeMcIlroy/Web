package seps.valueObject.api;

public class WeatherVO {
	/** std data */
	private String shpId = "";
	public String getShpId() {
		return shpId;
	}
	public void setShpId(String shpId) {
		this.shpId = shpId;
	}
	
	/** weather data */
	private String baseDate = "";
	private String baseTime = "";
	
	private String T1H = "0";
	private String RN1 = "0";
	private String SKY = "0";
	private String UUU = "0";
	private String VVV = "0";
	private String REH = "0";
	private String PTY = "0";
	private String LGT = "0";
	private String VEC = "0";
	private String WSD = "0";
	private String TMP = "0";
	private String SNO = "0";
	private String PCP = "0";

	/*동네예보용 변수*/
	private String fcstDate = "";
	private String fcstTime = "";
	private String POP = "0";
	private String R06 = "0";
	private String S06 = "0";
	private String T3H = "0";
	private String TMX = "0";
	private String TMN = "0";
	private String WAV = "0";

	//초단기예보 구분
	private String prevYn = "";
	
	public String getPrevYn() {
		return prevYn;
	}
	public void setPrevYn(String prevYn) {
		this.prevYn = prevYn;
	}
	public String getBaseDate() {
		return baseDate;
	}
	public void setBaseDate(String baseDate) {
		this.baseDate = baseDate;
	}
	public String getBaseTime() {
		return baseTime;
	}
	public void setBaseTime(String baseTime) {
		this.baseTime = baseTime;
	}
	public String getT1H() {
		return T1H;
	}
	public void setT1H(String t1h) {
		T1H = t1h;
	}
	public String getRN1() {
		return RN1;
	}
	public void setRN1(String rN1) {
		RN1 = rN1;
	}
	public String getSKY() {
		return SKY;
	}
	public void setSKY(String sKY) {
		SKY = sKY;
	}
	public String getUUU() {
		return UUU;
	}
	public void setUUU(String uUU) {
		UUU = uUU;
	}
	public String getVVV() {
		return VVV;
	}
	public void setVVV(String vVV) {
		VVV = vVV;
	}
	public String getREH() {
		return REH;
	}
	public void setREH(String rEH) {
		REH = rEH;
	}
	public String getPTY() {
		return PTY;
	}
	public void setPTY(String pTY) {
		PTY = pTY;
	}
	public String getLGT() {
		return LGT;
	}
	public void setLGT(String lGT) {
		LGT = lGT;
	}
	public String getVEC() {
		return VEC;
	}
	public void setVEC(String vEC) {
		VEC = vEC;
	}
	public String getWSD() {
		return WSD;
	}
	public void setWSD(String wSD) {
		WSD = wSD;
	}
	
	public String getPOP() {
		return POP;
	}
	public void setPOP(String pOP) {
		POP = pOP;
	}
	public String getR06() {
		return R06;
	}
	public void setR06(String r06) {
		R06 = r06;
	}
	public String getS06() {
		return S06;
	}
	public void setS06(String s06) {
		S06 = s06;
	}
	public String getT3H() {
		return T3H;
	}
	public void setT3H(String t3h) {
		T3H = t3h;
	}
	public String getFcstDate() {
		return fcstDate;
	}
	public void setFcstDate(String fcstDate) {
		this.fcstDate = fcstDate;
	}
	public String getFcstTime() {
		return fcstTime;
	}
	public void setFcstTime(String fcstTime) {
		this.fcstTime = fcstTime;
	}
	public String getTMX() {
		return TMX;
	}
	public void setTMX(String tMX) {
		TMX = tMX;
	}
	public String getTMN() {
		return TMN;
	}
	public void setTMN(String tMN) {
		TMN = tMN;
	}
	public String getWAV() {
		return WAV;
	}
	public void setWAV(String wAV) {
		WAV = wAV;
	}
	
	public String getTMP() {
		return TMP;
	}
	public void setTMP(String tMP) {
		TMP = tMP;
	}
	public String getSNO() {
		return SNO;
	}
	public void setSNO(String sNO) {
		SNO = sNO;
	}
	public String getPCP() {
		return PCP;
	}
	public void setPCP(String pCP) {
		PCP = pCP;
	}
	@Override
	public String toString() {
		return "WeatherVO [shpId=" + shpId + ", baseDate=" + baseDate + ", baseTime=" + baseTime + ", T1H=" + T1H
				+ ", RN1=" + RN1 + ", SKY=" + SKY + ", UUU=" + UUU + ", VVV=" + VVV + ", REH=" + REH + ", PTY=" + PTY
				+ ", LGT=" + LGT + ", VEC=" + VEC + ", WSD=" + WSD + ", TMP=" + TMP + ", SNO=" + SNO + ", PCP=" + PCP
				+ ", fcstDate=" + fcstDate + ", fcstTime=" + fcstTime + ", POP=" + POP + ", R06=" + R06 + ", S06=" + S06
				+ ", T3H=" + T3H + ", TMX=" + TMX + ", TMN=" + TMN + ", WAV=" + WAV + ", prevYn=" + prevYn + "]";
	}

	
}
