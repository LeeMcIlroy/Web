package component.graph;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import egovframework.let.utl.fcc.service.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@SuppressWarnings("serial")
public class GraphTagScatters extends TagSupport {
	private String id = "";
	private List<List<EgovMap>> dataList = new ArrayList<>();
	private List<String> titleList = new ArrayList<>();
	private String xLabel = "";
	private String yLabel = "";
	public void setId(String id) {
		this.id = id;
	}
	public void setDataList(List<List<EgovMap>> dataList) {
		this.dataList = dataList;
	}
	public void setTitleList(List<String> titleList) {
		this.titleList = titleList;
	}
	public void setxLabel(String xLabel) {
		this.xLabel = xLabel;
	}
	public void setyLabel(String yLabel) {
		this.yLabel = yLabel;
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
			sb.append("		, data : {	\n");
			sb.append("			xs : {	\n");
			
			for(int i = 0; i < titleList.size(); i++){
				if(i != 0) sb.append(", ");
				sb.append(String.format("data%d : 'data%d_x'", i, i));
			}
			
			sb.append("			}	\n");
			sb.append("			, columns : [	\n");

			for(int i = 0; i < titleList.size(); i++){
				if(dataList.get(i) != null){
					if(i != 0) sb.append(", ");
					sb.append("[");
					sb.append("'data"+i+"'");
					for(EgovMap vo : dataList.get(i)){
						sb.append(String.format(", %s", vo.get("data").toString()));
					}
					sb.append("]\n");
					sb.append(", [");
					sb.append("'data"+i+"_x'");
					for(EgovMap vo : dataList.get(i)){
						sb.append(String.format(", %s", vo.get("dataX").toString()));
					}
					sb.append("]\n");
				}
			}
			
			sb.append("			]\n");
			sb.append("			, type : 'scatter'	\n");
			
			sb.append("			, names : { \n");
			
			for(int i = 0; i < titleList.size(); i++){
				if(i != 0) sb.append(", ");
				sb.append(String.format("data%d : '%s'", i, titleList.get(i).toString()));
			}
			
			sb.append("			}	\n");
			sb.append("		}	\n");
			//sb.append("		, legend : { show : false }	\n");
			
			sb.append("		, axis: {	\n");
			sb.append("			x: {	\n");
			sb.append("				label: '"+(EgovStringUtil.isEmpty(xLabel)? "data":xLabel)+"'	\n");
			sb.append("			}	\n");
			sb.append("			, y: {	\n");
			sb.append("				label: '"+(EgovStringUtil.isEmpty(yLabel)? "data_x":yLabel)+"'	\n");
			sb.append("			}	\n");
			sb.append("		}	\n");
			sb.append("		, tooltip: { \n");
			sb.append("			format: { \n");
			//sb.append("				title: function (d) { return '"+String.format("%s|%s", yLabel, xLabel)+"'; } \n");
			sb.append("				title: function (d) { \n");
			sb.append("					tmp = d;\n");
			sb.append("					return 'x | y'; \n");
			sb.append("				} \n");
			sb.append("				, value: function (value, ratio, id) { \n");
			sb.append("					return value; \n");
			sb.append("				} \n");
			sb.append("				, name: function (name, ratio, id, index) { \n");
			sb.append("					return tmp; \n");
			sb.append("				} \n");
			sb.append("			} \n");
			sb.append("		}	\n");
			sb.append("		, grid : { x : {show: true}, y: {show: true} }	\n");
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
