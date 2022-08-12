package valueObject;

public class GraphVO {
	private String xCol = "";
	private String xVal = "";
	public String getxCol() {
		return xCol;
	}
	public void setxCol(String xCol) {
		this.xCol = xCol;
	}
	public String getxVal() {
		return xVal;
	}
	public void setxVal(String xVal) {
		this.xVal = xVal;
	}
	@Override
	public String toString() {
		return "GraphVO [\nxCol=" + xCol + "\n, xVal=" + xVal + "\n]";
	}
}
