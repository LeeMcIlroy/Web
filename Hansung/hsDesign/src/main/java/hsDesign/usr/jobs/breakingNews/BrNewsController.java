//0410추가
//0413수정//0414수정//0416수정//0417수정//0421수정
package hsDesign.usr.jobs.breakingNews;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.json.JSONObject;
import org.json.XML;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import component.web.PaginationController;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import hsDesign.usr.enter.admission.AdmissionController;
import hsDesign.valueObject.cmm.CmmnSearchVO;

//채용정보
//@WebServlet("/breakingNewsOpenApi.do")
@Controller
public class BrNewsController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AdmissionController.class);
	
	public static int INDENT_FACTOR = 4;
	
	@Resource View jsonView;
	
	@RequestMapping("/usr/jobs/worknet/breakingNews/brNewsList.do")
	public String broDataList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
			LOGGER.info("/usr/jobs/worknet/breakingNews/brNewsList.do - 취업센터 > 공채속보 > 목록");
			session.setAttribute("menuNo", "26002");
			
			DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder documentBuilder = documentBuilderFactory.newDocumentBuilder();
            Document xml = null;
            xml = documentBuilder.parse("http://openapi.work.go.kr/opi/opi/opia/dhsOpenEmpInfoAPI.do?authKey=WNK8GM601UJ0HX7PYLEMY2VR1HK"
    				+ "&callTp=L&returnType=XML&startPage=1&display=10&jobsCd=05&empWantedTitle="+searchVO.getSearchWord());
            Element element = xml.getDocumentElement();
            NodeList list = element.getChildNodes();
            List<EgovMap> resultList = new ArrayList<EgovMap>();
            for(int i=0; i<list.getLength(); i++) {
            	EgovMap map = new EgovMap();
            	NodeList list2 = list.item(i).getChildNodes();
            	if(list.item(i).getNodeName().equals("dhsOpenEmpInfo")) {
	                for(int j=0;j<list2.getLength();j++) {
	                    String content = list2.item(j).getTextContent();
	                    content = content.replaceAll("\n", "");
	                    map.put(list2.item(j).getNodeName(), content);
	                }
	                resultList.add(map);
            	}
            }
            
            int totRec = Integer.parseInt(list.item(0).getTextContent());
            
	        PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO, 10, 10);
	        paginationInfo.setTotalRecordCount(totRec);
			model.addAttribute("paginationInfo", paginationInfo);
			
			model.addAttribute("resultList", resultList);
			model.addAttribute("totRec",totRec);
	        
	        return "/usr/jobs/worknet/breakingNews/brNewsList";
	    }
	
	/*@RequestMapping(value="/usr/jobs/worknet/breakingNews/AjaxbrNewsList.do", produces="text/plain;charset=UTF-8")
	public View AjaxbrNewsList(ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		LOGGER.info("/usr/jobs/worknet/breakingNews/AjaxbrNewsList.do - 취업센터  > 공채속보 > 리스트 ajax");
		
		HttpURLConnection conn = (HttpURLConnection) new URL("http://openapi.work.go.kr/opi/opi/opia/dhsOpenEmpInfoAPI.do?authKey=WNK8GM601UJ0HX7PYLEMY2VR1HK"
				+ "&callTp=L&returnType=XML&startPage=1&display=10&jobsCd=05").openConnection();
//		http://openapi.work.go.kr/opi/opi/opia/dhsOpenEmpInfoAPI.do?authKey=WNK8GM601UJ0HX7PYLEMY2VR1HK&callTp=L&returnType=XML&startPage=1&display=10&jobsCd=05&region=11000&empTpCd=10|11|20|21
		conn.connect();
		
		BufferedInputStream bis = new BufferedInputStream(conn.getInputStream());
		BufferedReader reader = new BufferedReader(new InputStreamReader(bis));
		StringBuffer st = new StringBuffer();
		String line;
		while ((line = reader.readLine()) != null) {
			st.append(line);
		}
		
		JSONObject xmlJSONObj = XML.toJSONObject(st.toString());
		String jsonPrettyPrintString = xmlJSONObj.toString(INDENT_FACTOR);

//		JSONObject dhsOpenEmpInfoList = (JSONObject)xmlJSONObj.get("dhsOpenEmpInfoList");
		
		model.addAttribute("resultList", jsonPrettyPrintString);
		
		return jsonView;
	}*/
	
	
	// 조회
	@RequestMapping("/usr/jobs/worknet/breakingNews/brNewsView.do")
	public String brNewsView(String empSeqno, ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		LOGGER.debug("/usr/jobs/worknet/breakingNews/brNewsView.do - 취업센터  > 공채속보  > 상세보기");

		model.addAttribute("empSeqno", empSeqno);
	       	 
		return "/usr/jobs/worknet/breakingNews/brNewsView";
	}
	
	
	@RequestMapping(value="/usr/jobs/worknet/breakingNews/AjaxbrNewsView.do", produces="text/plain;charset=UTF-8")
	public View AjaxbrNewsView(@RequestParam String empSeqno,ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		LOGGER.info("/usr/jobs/worknet/breakingNews/AjaxbrNewsView.do - 취업센터  > 공채속보 > 상세보기 ajax");
		
		 HttpURLConnection conn = (HttpURLConnection) new URL("http://openapi.work.go.kr/opi/opi/opia/dhsOpenEmpInfoAPI.do?authKey=WNK8GM601UJ0HX7PYLEMY2VR1HK"
	        		+ "&returnType=XML&callTp=D&empSeqno="+empSeqno).openConnection();

		 conn.connect();
	        BufferedInputStream bis = new BufferedInputStream(conn.getInputStream());
	        BufferedReader reader = new BufferedReader(new InputStreamReader(bis));
	        StringBuffer st = new StringBuffer();
	        String line;
	        while ((line = reader.readLine()) != null) {
	            st.append(line);
	        }
	 
	        JSONObject xmlJSONObj = XML.toJSONObject(st.toString());
	        String jsonPrettyPrintString = xmlJSONObj.toString(INDENT_FACTOR);

			model.addAttribute("resultList", jsonPrettyPrintString);

		return jsonView;
	}
	
	
}
