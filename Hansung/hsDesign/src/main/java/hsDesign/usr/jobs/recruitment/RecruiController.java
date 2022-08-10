//0410추가
//0413수정//0414수정//0416수정//0417수정//0421수정
package hsDesign.usr.jobs.recruitment;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sound.sampled.AudioFormat.Encoding;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.json.JSONArray;
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
import egovframework.rte.fdl.string.EgovStringUtil;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import hsDesign.usr.enter.admission.AdmissionController;
import hsDesign.valueObject.cmm.CmmnSearchVO;

//채용정보
//@WebServlet("/RecruitmentOpenApi.do")
@Controller
public class RecruiController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(AdmissionController.class);
	
	public static int INDENT_FACTOR = 4;
	
	@Resource View jsonView;
	
	@RequestMapping("/usr/jobs/worknet/recruitment/recruList.do")
	public String broDataList(@ModelAttribute("searchVO") CmmnSearchVO searchVO, ModelMap model, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
			LOGGER.info("/usr/jobs/worknet/recruitment/recruList.do - 취업센터 > 채용공고 > 목록");
			session.setAttribute("menuNo", "26001");
			
			if(EgovStringUtil.isEmpty(searchVO.getSearchCondition2())){
				searchVO.setSearchCondition2("실내디자인");
			}
			
			/*List<String> occupationList = new ArrayList<String>();*/
			String occupation = "";
			String mainOccupation = "";

			/*
			 * 학과별 검색
			 */
			
			switch (searchVO.getSearchCondition2()) {
			case "실내디자인":
			
				mainOccupation="10003&10006&10021";
				occupation = "1000017&1000018&1000019&1000020&1000037&1000141&1000142";
				break;
			case "시각디자인":
				mainOccupation="10005&10007&10013&10016&10019&10020";
				occupation = "1000030&1000032&1000034&1000035&1000039&1000040&1000041&1000046&1000071&1000072&1000098&1000099&1000103&1000104&1000105&1000107&1000122&1000123&1000132&1000137";
				break;
			case "산업디자인":
				mainOccupation="10009&10018&10019";
				occupation = "1000055&1000056&1000115";
				break;
			case "디지털아트(디자인)":
				mainOccupation="10005&10007&10016&10019&10020";
				occupation = "1000030&1000040&1000094&1000107&1000108&1000122&1000125&1000130&1000131&1000133";
				break;
			case "디지털아트(게임)":
				mainOccupation="10005&10007&10016&10019&10020";
				occupation = "1000030&1000040&1000094&1000107&1000108&1000122&1000125&1000130&1000131&1000133";
				break;
			case "패션디자인":
				mainOccupation="10007&10009&10019";
				occupation = "1000040&1000058&1000128";
				break;
			case "미용학":
				mainOccupation="10001&10022";
				occupation = "1000004&1000148";
				break;
			}
			
			/*
				// 실내디자인
				occupation += "701603|415103|415302|415300|415301|159100|415102|024402|024401|013600|214401|214302|214202|";
				
				// 디지털아트
				occupation += "414300|414301|414302|417100|415500|415502|415503|415504|415505|416100|416303|416400|416500|416600|416900|416901|";
				
				// 패션디자인& 패션비즈니스
				occupation += "415203|415201|415202|415200|614000|615106|615100|615104|024102|024302|024301|";
				
				// 산업디자인
				occupation += "415103|415203|415405|415100|415102|415104|415504|415501|023400|023402|023401|024102|024302|024301|024402|211200|212105|212108|214401|214400|214302|883100|883101|883102|883200|883300|884100|884200|159105|612300|";
				
				// 시각디자인
				occupation += "415401|415406|415405|415400|415403|415402|415404|415504|415503|415500|415501|411300|026102|024101|133207|133302|";
				
				// 미용학
				occupation += "511900|511302|511400|511401|511200|511301|511402|511100|511300|211200|212100|029210|415405|415505|415503";
			*/
			
			List<EgovMap> resultList = new ArrayList<EgovMap>();
			int totRec = 0;
			
			DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder documentBuilder = documentBuilderFactory.newDocumentBuilder();
            Document xml = null;
//            xml = documentBuilder.parse("http://openapi.work.go.kr/opi/opi/opia/wantedApi.do?authKey=WNK8GM601UJ0HX7PYLEMY2VR1HK&callTp=L&returnType=XML&startPage="+searchVO.getPageIndex()
//            	+"&display="+searchVO.getRecordCountPerPage()+"&occupation="+occupation+"&region=11000&empTpCd=10|11|20|21&keyword="+searchVO.getSearchWord());
//            	/*+"&display="+searchVO.getRecordCountPerPage()+"&occupation=05|511900|511302|511400|511401|511200|511402|511100|511300&region=11000&empTpCd=10|11|20|21&keyword="+searchVO.getSearchWord());*/
         
            xml = documentBuilder.parse("http://www.jobkorea.co.kr/Service_JK/Data/JK_Starter_XML_List.asp?api=681&size="+searchVO.getRecordCountPerPage()+"&page="+searchVO.getPageIndex()+"&area=I000&rbcd="+mainOccupation+"&rpcd="+occupation+"&coname="+URLEncoder.encode(searchVO.getSearchWord(),"euc-kr"));
            //&size="+searchVO.getRecordCountPerPage()+"&page="+searchVO.getPageIndex()+"&rbcd=10001&area=I000&Jtype=1&keyword="+searchVO.getSearchWord());
            Element element = xml.getDocumentElement();
            NodeList list = element.getChildNodes();
            for(int i=2; i<list.getLength(); i++) {
            	EgovMap map = new EgovMap();
            	NodeList list2 = list.item(i).getChildNodes();
	                for(int j=0;j<list2.getLength();j++) {
	                    String content = list2.item(j).getTextContent();

	                   content = content.replaceAll("\n", "");
	                    map.put(list2.item(j).getNodeName(), content);
	                }
	                resultList.add(map);
            	
            }
        /*    Element element = xml.getDocumentElement();
            NodeList list = element.getChildNodes();
            for(int i=0; i<list.getLength(); i++) {
            	EgovMap map = new EgovMap();
            	NodeList list2 = list.item(i).getChildNodes();
            	if(list.item(i).getNodeName().equals("wanted")) {
	                for(int j=0;j<list2.getLength();j++) {
	                    String content = list2.item(j).getTextContent();
	                    content = content.replaceAll("\n", "");
	                    map.put(list2.item(j).getNodeName(), content);
	                }
	                resultList.add(map);
            	}
            }*/
            
            totRec = totRec + Integer.parseInt(list.item(0).getTextContent());
            
	        PaginationInfo paginationInfo = PaginationController.getPaginationInfo(searchVO, 10, 10);
	        paginationInfo.setTotalRecordCount(totRec);
			model.addAttribute("paginationInfo", paginationInfo);
			
			model.addAttribute("resultList", resultList);
			model.addAttribute("totRec",totRec);
			
	        return "/usr/jobs/worknet/recruitment/recruList";
	    }
	
	// 조회
	/*@RequestMapping("/usr/jobs/worknet/recruitment/recruView.do")
	public String recruView(String wantedAuthNo, ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		LOGGER.debug("/usr/jobs/worknet/recruitment/recruView.do - 취업센터  > 채용공고  > 상세보기");
		
		model.addAttribute("wantedAuthNo", wantedAuthNo);
		
		return "/usr/jobs/worknet/recruitment/recruView";
	}*/
	@RequestMapping("/usr/jobs/worknet/recruitment/recruView.do")
	public String recruView(String giNo, ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		LOGGER.debug("/usr/jobs/worknet/recruitment/recruView.do - 취업센터  > 채용공고  > 상세보기");
		
		model.addAttribute("giNo", giNo);
		
		return "/usr/jobs/worknet/recruitment/recruView";
	}
	
	/*@RequestMapping(value="/usr/jobs/worknet/recruitment/AjaxRecruList.do", produces="text/plain;charset=UTF-8")
	public View AjaxRecruList(ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		LOGGER.info("/usr/jobs/worknet/recruitment/AjaxRecruList.do - 취업센터  > 채용공고 > 리스트 ajax");
		
		HttpURLConnection conn = (HttpURLConnection) new URL("http://openapi.work.go.kr/opi/opi/opia/wantedApi.do?authKey=WNK8GM601UJ0HX7PYLEMY2VR1HK"
				+ "&callTp=L&returnType=XML&startPage=1&display=10"
				+ "&occupation=05&region=11000" //occupation : 직종코드(05:예술·디자인·방송·스포츠) //region : 근무지역코드(11000:서울)
				+ "&empTpCd=10|11|20|21").openConnection();
//		http://openapi.work.go.kr/opi/opi/opia/wantedApi.do?authKey=WNK8GM601UJ0HX7PYLEMY2VR1HK&callTp=L&returnType=XML&startPage=1&display=10&occupation=05&region=11000&empTpCd=10|11|20|21
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
	}*/
	
	
	/*@RequestMapping(value="/usr/jobs/worknet/recruitment/AjaxRecruView.do", produces="text/plain;charset=UTF-8")
	public View AjaxRecruView(@RequestParam String wantedAuthNo,ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		LOGGER.info("/usr/jobs/worknet/recruitment/AjaxRecruView.do - 취업센터  > 채용공고 > 상세보기 ajax");
		
		 HttpURLConnection conn = (HttpURLConnection) new URL("http://openapi.work.go.kr/opi/opi/opia/wantedApi.do?authKey=WNK8GM601UJ0HX7PYLEMY2VR1HK"
	        		+ "&callTp=D&returnType=XML&wantedAuthNo="+ wantedAuthNo +"&infoSvc=VALIDATION").openConnection();
//		 http://openapi.work.go.kr/opi/opi/opia/wantedApi.do?authKey=WNK8GM601UJ0HX7PYLEMY2VR1HK&callTp=D&returnType=XML&wantedAuthNo="+ wantedAuthNo +"&infoSvc=VALIDATION
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
	}*/
	@RequestMapping(value="/usr/jobs/worknet/recruitment/AjaxRecruView.do", produces="text/plain;charset=UTF-8")
	public View AjaxRecruView(@RequestParam String giNo,ModelMap model, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		LOGGER.info("/usr/jobs/worknet/recruitment/AjaxRecruView.do - 취업센터  > 채용공고 > 상세보기 ajax");
		
		 HttpURLConnection conn = (HttpURLConnection) new URL("http://www.jobkorea.co.kr/Recruit/GI_Read/"+giNo+"?Oem_Code=C900&PageGbn=ST&api=681").openConnection();

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
	public static EgovMap toMap(JSONObject object) throws Exception {
		EgovMap map = new EgovMap();
        Iterator keys = object.keys();
        while (keys.hasNext()) {
            String key = (String) keys.next();
            map.put(key, fromJson(object.get(key)));
        }
        return map;
    }

    public static List<EgovMap> toList(JSONArray array) throws Exception {
        List<EgovMap> list = new ArrayList<EgovMap>();
        for (int i = 0; i < array.length(); i++) {
            list.add((EgovMap) fromJson(array.get(i)));
        }
        return list;
    }

    private static Object fromJson(Object json) throws Exception {
        if (json == JSONObject.NULL) {
            return null;
        } else if (json instanceof JSONObject) {
            return toMap((JSONObject) json);
        } else if (json instanceof JSONArray) {
            return toList((JSONArray) json);
        } else {
            return json;
        }
    }
}
