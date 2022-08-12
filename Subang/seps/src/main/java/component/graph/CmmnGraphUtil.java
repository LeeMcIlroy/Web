package component.graph;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;

import valueObject.GraphVO;

public class CmmnGraphUtil {

	private static final Logger LOGGER = LoggerFactory.getLogger(CmmnGraphUtil.class);
	
	/**
	 * 그래프 param set
	 * 
	 * @param bindto 타켓
	 * @param width	넓이
	 * @param height 높이
	 * @param data_xFormat x 데이터 포맷
	 * @param data_type 그래프 타입(spline 곡선, bar 막대, ...)
	 * @param data_colums_x x축 값
	 * @param dataList 데이터
	 * @param axis_x_type x축 타입(timeseries 시간..)
	 * @param axis_x_tick_format x축 표현 포맷
	 */
	public static void setGraphData(
			String bindto, String width, String height, String data_xFormat, String data_type, List<String> data_colums_x, List<String>[] dataList
			, String axis_x_type, String axis_x_tick_format, ModelMap model
	){
		model.addAttribute("bindto", bindto);
		model.addAttribute("width", width);
		model.addAttribute("height", height);
		model.addAttribute("data_xFormat", data_xFormat);
		model.addAttribute("data_type", data_type);
		model.addAttribute("data_colums_x", data_colums_x);
		model.addAttribute("dataList", dataList);
		model.addAttribute("axis_x_type", axis_x_type);
		model.addAttribute("axis_x_tick_format", axis_x_tick_format);
	}
	
	/**
	 * 제목, 데이터 합병
	 * 
	 * @param titleList 제목 목록
	 * @param dataList 데이터 목록..
	 */
	@SafeVarargs
	@SuppressWarnings("unchecked")
	public static List<String>[] setGraphDataAndTitleMerge(List<String> titleList, List<String> ... dataList){
		
		if(titleList.size() != dataList.length){
			LOGGER.error("title count 와 data count 불일치");
			return null;
		}
		
		for(int i = 0; i < dataList.length; i++){
			dataList[i].add(0, titleList.get(i).toString());
			LOGGER.debug("\ndataList[i = {}, titleList.get(i).toString() = {}]", i, titleList.get(i).toString());
		}
		
		return dataList;
	}
	public static List<List<String>> setGraphDataAndTitleMerge2(List<String> titleList, List<String> ... dataList){
		
		List<List<String>> resultList = new ArrayList<>();
		
		if(titleList.size() != dataList.length){
			LOGGER.error("title count 와 data count 불일치");
			return null;
		}
		
		for(int i = 0; i < dataList.length; i++){
			dataList[i].add(0, titleList.get(i).toString());
			resultList.add(dataList[i]);
			LOGGER.debug("\ndataList[i = {}, titleList.get(i).toString() = {}]", i, titleList.get(i).toString());
		}
		
		return resultList;
	}
	
	/**
	 * 제목 리스트 set
	 * 
	 * @param title 제목 목록..
	 */
	public static List<String> setGraphDataTitle(String ... title){
		List<String> titleList = null;
		
		if(title.length > 0){
			titleList = new ArrayList<>();
			for(String t : title){
				titleList.add(t);
			}
		}
		
		return titleList;
	}
	
	/**
	 * 타켓의 평균을 구한다
	 * 
	 * @param dataList 데이터
	 * @param avgType 평균을 구해야하는 타겟
	 */
	public static double setGraphDataAvg(List<String>[] dataList, String avgType){
		double total = 0;
		double size = 0;
		for(List<String> data : dataList){
			if(data.contains(avgType)){
				LOGGER.debug(data.toString());
				size = data.size();
				for(int i = 1; i < data.size() ; i++){
					total += Integer.parseInt(data.get(i));
				}
			}
		}
		double avg = Double.parseDouble(String.format("%.2f", total/(size-1)));
		LOGGER.debug("avg = {}", avg);
		return avg;
	}
	
	/********************************************************** test **********************************************************/
	private static List<String> xColList = null;
	private static List<String> xValList = null;
	public static List<String> getxColList() {
		return xColList;
	}
	public static List<String> getxValList() {
		return xValList;
	}

	public static void setDataList(List<GraphVO> dataList) {
		xColList = new ArrayList<>();
		xValList = new ArrayList<>();
		LOGGER.debug("dataList.size() = "+dataList.size());
		if(dataList.size() > 0){
			for(GraphVO vo : dataList){
				xColList.add(vo.getxCol());
				xValList.add(vo.getxVal());
			}
			
			if(xColList.get(0).length() == 4){ //연도별일때
				int tmpLimit = Integer.parseInt(xColList.get(0));
				for(int i = (Integer.parseInt(xColList.get(0))-4); i < tmpLimit; i++){
					String tmp = String.format("%d", i);
					xColList.add(0, tmp);
					xValList.add(0, "0");
				}
			}else{ //그 외 일때
				if(!xColList.get(0).equals("00")){
					for(int i = Integer.parseInt(xColList.get(0))-1; i >= 0; i--){
						String tmp = String.format("0%d", i);
						xColList.add(0, tmp.substring(tmp.length()-2, tmp.length()));
						xValList.add(0, "0");
					}
				}
			}
		}
	}
	
	public static void setDataList2(List<GraphVO> dataList) {
		xColList = new ArrayList<>();
		xValList = new ArrayList<>();
		if(dataList.size() > 0){
			for(GraphVO vo : dataList){
				xColList.add(vo.getxCol());
				xValList.add(vo.getxVal());
			}
		}
	}
	
	public static List<GraphVO> setDataList3(List<GraphVO> dataList) {
		LOGGER.debug("dataList.size() = "+dataList.size());
		List<GraphVO> resultList = null;
		
		if(dataList.size() > 0){
			resultList = new ArrayList<>();
			if(!"00".equals(dataList.get(0).getxCol())){
				GraphVO tmpVO1 = null;
				for(int i = Integer.parseInt(dataList.get(0).getxCol())-1; i >=0; i--){
					tmpVO1 = new GraphVO();
					String tmpCol = String.format("0%d", i);
					tmpCol = tmpCol.substring(tmpCol.length()-2, tmpCol.length());
					tmpVO1.setxCol(tmpCol);
					tmpVO1.setxVal("null");
					resultList.add(0, tmpVO1);
				}
			}
			
			for(GraphVO vo : dataList){
				resultList.add(vo);
			}

			if(!"23".equals(dataList.get(dataList.size()-1).getxCol())){
				GraphVO tmpVO2 = null;
				for(int i = Integer.parseInt(dataList.get(dataList.size()-1).getxCol())+1; i < 24; i++){
					tmpVO2 = new GraphVO();
					String tmpCol = String.format("0%d", i);
					tmpCol = tmpCol.substring(tmpCol.length()-2, tmpCol.length());
					tmpVO2.setxCol(tmpCol);
					tmpVO2.setxVal("null");
					resultList.add(resultList.size(), tmpVO2);
				}
			}

		}
		return resultList;
	}
}
