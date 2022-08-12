package component.graph;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@SuppressWarnings("serial")
public class GraphTagScatter extends TagSupport {
	private String id = "";
	private List<EgovMap> dataList = new ArrayList<>();
	private String xLabel = "";
	private String yLabel = "";
	
	private List<String> regrAnalData = new ArrayList<>();
	
	public void setId(String id) {
		this.id = id;
	}
	public void setDataList(List<EgovMap> dataList) {
		this.dataList = dataList;
	}
	public void setxLabel(String xLabel) {
		this.xLabel = xLabel;
	}
	public void setyLabel(String yLabel) {
		this.yLabel = yLabel;
	}
	public void setRegrAnalData(List<String> regrAnalData) {
		this.regrAnalData = regrAnalData;
	}
	@Override
	public int doEndTag() throws JspException {
		try {
			pageContext.getOut().write(setGraphScript());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}
	private String setGraphScript(){
		StringBuilder sb = new StringBuilder();
		try {
			sb.append("<div id=\""+id+"\"></div>");
			sb.append("<script type=\"text/javascript\">\n");
			sb.append("var "+id+";\n");
			sb.append("var tmp = '';\n");
			sb.append("$(function(){	\n");
			sb.append(id+" = c3.generate({	\n");
			sb.append("		bindto : '#"+id+"'	\n");
			sb.append("		, color : { pattern: ['#169c70', '#cbd018', '#f65319'] }	\n");
			sb.append("		, data : {	\n");
			sb.append("			x : 'data_x'	\n");
			sb.append("			, xs : {	\n");
			sb.append("				data : 'data_x'\n");
			sb.append("			}	\n");
			sb.append("			, columns : [	\n");

			sb.append("							[");
			sb.append("								'data', ");
			
			for(int i = 0; i < dataList.size(); i++){
				if(i != 0) sb.append(", ");
				sb.append(dataList.get(i).get("data").toString());
			}
/*
			// y축 최대값, 최소값 set param
			double yValueMaxNum = 0;
			double yValueMinNum = 0;
			for(int i = 0; i < dataList.size(); i++){
				if(i != 0) sb.append(", ");
				sb.append(dataList.get(i).get("data").toString());
				
				// 최대값 설정
				if(Double.parseDouble(dataList.get(i).get("data").toString()) > yValueMaxNum){
					yValueMaxNum = Double.parseDouble(dataList.get(i).get("data").toString());
				}
				
				// 최소값 설정
				if(i == 0) yValueMinNum = Double.parseDouble(dataList.get(i).get("data").toString());
				if(yValueMinNum > Double.parseDouble(dataList.get(i).get("data").toString())){
					yValueMinNum = Double.parseDouble(dataList.get(i).get("data").toString());
				}
			}
			
			int yStep = 0;
			int yNum = 1;
			double yDiff = yValueMaxNum - yValueMinNum; 
			while( yDiff >= yNum ){
				yNum *= 10;
			}
			yStep = yNum/100;
*/
			
			sb.append("							]\n");
			sb.append("							, [");
			sb.append("								'data_x', ");
			
			// x축 최대값, 최소값, 합계 set param
			double xValueMaxNum = 0;
			double xValueMinNum = 0;
			double xSum = 0;
			for(int i = 0; i < dataList.size(); i++){
				if(i != 0) sb.append(", ");
				sb.append(dataList.get(i).get("dataX").toString());
				
				// 최대값 설정
				if(Double.parseDouble(dataList.get(i).get("dataX").toString()) > xValueMaxNum){
					xValueMaxNum = Double.parseDouble(dataList.get(i).get("dataX").toString());
				}
				
				// 최소값 설정
				if(i == 0) xValueMinNum = Double.parseDouble(dataList.get(i).get("dataX").toString());
				if(xValueMinNum > Double.parseDouble(dataList.get(i).get("dataX").toString())){
					xValueMinNum = Double.parseDouble(dataList.get(i).get("dataX").toString());
				}
				
				xSum += Double.parseDouble(dataList.get(i).get("dataX").toString());
			}
			
			// x 평균
			double xAvg = xSum / dataList.size();
			
			double xSum2 = 0;
			for(EgovMap vo :dataList){
				xSum2 += Math.pow((Double.parseDouble(vo.get("dataX").toString())-xAvg), 2);
			}
			
			// 표준편차
			int xSdm = (int) Math.sqrt(xSum2/dataList.size()-1);
/*
			LOGGER.debug("**********************************************************");
			LOGGER.debug("**********************************************************");
			LOGGER.debug(String.format("id = %s, xSdm = %d", id, xSdm));
			LOGGER.debug("**********************************************************");
			LOGGER.debug("**********************************************************");
*/
			sb.append("							]\n");
			
			if(regrAnalData.size() > 0){
				sb.append("							, [");
				sb.append("								'data1'");
				for(String str : regrAnalData){
					sb.append(String.format(", %s", str));
				}
				sb.append("							]\n");
			}
			
			sb.append("			]\n");
			sb.append("		, type : 'scatter'	\n");
			sb.append("		, types : { data1 : 'line' }	\n");
			sb.append("		, colors: { data1 : '#aaa' }	\n");
			//sb.append("		, names : {data : '"+String.format("%s|%s", yLabel, xLabel)+"'}	\n");
			sb.append("		}	\n");
			sb.append("		, point : { show : false }	\n");
			sb.append("		, legend : { show : false }	\n");
			sb.append("		, axis: {	\n");
			sb.append("			x: {	\n");
			//sb.append("				label: '"+(EgovStringUtil.isEmpty(xLabel)? "data":xLabel)+"'	\n");
/*			
			If it's horizontal axis:

			inner-right [default]
			inner-center
			inner-left
			outer-right
			outer-center
			outer-left
*/
			sb.append("				label: {	\n");
			sb.append("					text : '"+(EgovStringUtil.isEmpty(xLabel)? "data":xLabel)+"'	\n");
			sb.append("					, position : 'outer-center'	\n");
			sb.append("				}	\n");
			sb.append("				, padding: { left: 0 }	\n");
			
			
			
			if(xSdm != 0){
				sb.append("				, tick : {	\n");
				sb.append("					values : [	\n");
				for(int i = (int) xValueMinNum; i < xValueMaxNum; i+=xSdm){
					sb.append(String.format("%d, ", i));
				}
				sb.append("					]	\n");
				sb.append("					, format : d3.format(',')	\n");
				sb.append("				}	\n");
			}
			
			
			sb.append("			}	\n");
			sb.append("			, y: {	\n");
			//sb.append("				label: '"+(EgovStringUtil.isEmpty(yLabel)? "data_x":yLabel)+"'	\n");
/*
			If it's vertical axis:

			inner-top [default]
			inner-middle
			inner-bottom
			outer-top
			outer-middle
			outer-bottom
*/
			
			sb.append("				label: {	\n");
			sb.append("					text : '"+(EgovStringUtil.isEmpty(yLabel)? "data_x":yLabel)+"'	\n");
			sb.append("					, position : 'outer-middle'	\n");
			sb.append("				}	\n");
			
			sb.append("				, tick : { format : d3.format(',') }	\n");
			
			sb.append("			}	\n");
			sb.append("		}	\n");
			sb.append("		, tooltip: { \n");
			sb.append("			format: { \n");
			//sb.append("				title: function (d) { return '"+String.format("%s|%s", yLabel, xLabel)+"'; } \n");
			sb.append("				title: function (d) { \n");
			sb.append("					tmp = d;\n");
			sb.append("					return 'x | y'; \n");
			sb.append("				} \n");
			sb.append("				, value: d3.format(',') \n");
			/*
			sb.append("				, value: function (value, ratio, id) { \n");
			sb.append("					return value; \n");
			sb.append("				} \n");
			*/
			sb.append("				, name: function (name, ratio, id, index) { \n");
			sb.append("					return d3.format(',')(tmp); \n");
			sb.append("				} \n");
			sb.append("			} \n");
			sb.append("		}	\n");
			
			sb.append("		, grid : {	\n");
			sb.append("			x : {	\n");
			
			if(xSdm != 0){
				sb.append("				lines : [	\n");
				for(int i = (int) xValueMinNum; i < xValueMaxNum; i+=xSdm){
					sb.append(String.format("{value : %d, class : 'scatter_x_label'}, ", i));
				}
				sb.append("				]	\n");
			}else{
				sb.append("				show : true \n");
			}
			
			sb.append("			}	\n");
			
			sb.append("			, y : {	\n");
			sb.append("				show : true \n");
			/*
			sb.append("				lines : [	\n");
			
			for(int i = (int) yValueMinNum; i < yValueMaxNum; i+=yStep){
				sb.append(String.format("{value : %d, class : 'scatter_y_label'}, ", i));
			}
			sb.append("				]	\n");
			*/
			sb.append("			}	\n");
			sb.append("		}	\n");
			sb.append("	});	\n");
			sb.append("});</script>");
		
		} catch (Exception e) {
			e.printStackTrace();
			sb.setLength(0);
			sb.append("데이터가 존재하지 않습니다.");
		}
		
		return sb.toString();
	}
	
}
