<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.util.List, egovframework.rte.psl.dataaccess.util.EgovMap"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String menuNo = ((String)session.getAttribute("menuNo")!=null)?(String)session.getAttribute("menuNo"):"";
	List<EgovMap> bcList = (List<EgovMap>)request.getAttribute("bcList");
	String titleName ="";
	if( menuNo.indexOf("101")==0 ){ 
		titleName = "실내디자인";
		if( menuNo.indexOf("10101")==0 ){
			titleName = titleName + " 전공안내";
		}
		if( menuNo.indexOf("10102")==0 ){
			titleName = titleName + " 교수소개";
		}
		if( menuNo.indexOf("10103")==0 ){
			titleName = titleName + " 진출분야";
		}
		if( menuNo.indexOf("10104")==0 ){
			titleName = titleName + " 교과과정";
		}
		if( menuNo.indexOf("10105")==0 ){
			titleName = titleName + " 편입사례";
		}
		int num = 5;
		for(int i=0; i<bcList.size(); i++){
			if("01".equals(bcList.get(i).get("mCode"))){
				num++;
				String menuNum = "1010"+String.valueOf(num);
				if(menuNo.equals(menuNum)){
					titleName = titleName + " " + bcList.get(i).get("bcName");
				}
			}
		}
	} else if( menuNo.indexOf("102")==0 ){
		titleName = "시각디자인학";
		if( menuNo.indexOf("10201")==0 ){
			titleName = titleName + " 전공안내";
		}
		if( menuNo.indexOf("10202")==0 ){
			titleName = titleName + " 교수소개";
		}
		if( menuNo.indexOf("10203")==0 ){
			titleName = titleName + " 진출분야";
		}
		if( menuNo.indexOf("10204")==0 ){
			titleName = titleName + " 교과과정";
		}
		int num = 4;
		for(int i=0; i<bcList.size(); i++){
			if("02".equals(bcList.get(i).get("mCode"))){
				num++;
				String menuNum = "1020"+String.valueOf(num);
				if(menuNo.equals(menuNum)){
					titleName = titleName + " " + bcList.get(i).get("bcName");
				}
			}
		}
	} else if( menuNo.indexOf("103")==0 ){
		titleName = "산업디자인";
		if( menuNo.indexOf("10301")==0 ){
			titleName = titleName + " 전공안내";
		}
		if( menuNo.indexOf("10302")==0 ){
			titleName = titleName + " 교수소개";
		}
		if( menuNo.indexOf("10303")==0 ){
			titleName = titleName + " 진출분야";
		}
		if( menuNo.indexOf("10304")==0 ){
			titleName = titleName + " 교과과정";
		}
		int num = 4;
		for(int i=0; i<bcList.size(); i++){
			if("03".equals(bcList.get(i).get("mCode"))){
				num++;
				String menuNum = "1030"+String.valueOf(num);
				if(menuNo.equals(menuNum)){
					titleName = titleName + " " + bcList.get(i).get("bcName");
				}
			}
		}
	} else if( menuNo.indexOf("104")==0 ){
		titleName = "디지털아트학(디자인)";
		if( menuNo.indexOf("10401")==0 ){
			titleName = titleName + " 전공안내";
		}
		if( menuNo.indexOf("10402")==0 ){
			titleName = titleName + " 교수소개";
		}
		if( menuNo.indexOf("10403")==0 ){
			titleName = titleName + " 진출분야";
		}
		if( menuNo.indexOf("10404")==0 ){
			titleName = titleName + " 교과과정";
		}
		int num = 4;
		for(int i=0; i<bcList.size(); i++){
			if("04".equals(bcList.get(i).get("mCode"))){
				num++;
				String menuNum = "1040"+String.valueOf(num);
				if(menuNo.equals(menuNum)){
					titleName = titleName + " " + bcList.get(i).get("bcName");
				}
			}
		}
	} else if( menuNo.indexOf("105")==0 ){
		titleName = "패션디자인학";
		if( menuNo.indexOf("10501")==0 ){
			titleName = titleName + " 전공안내";
		}
		if( menuNo.indexOf("10502")==0 ){
			titleName = titleName + " 교수소개";
		}
		if( menuNo.indexOf("10503")==0 ){
			titleName = titleName + " 진출분야";
		}
		if( menuNo.indexOf("10504")==0 ){
			titleName = titleName + " 교과과정";
		}
		int num = 4;
		for(int i=0; i<bcList.size(); i++){
			if("05".equals(bcList.get(i).get("mCode"))){
				num++;
				String menuNum = "1050"+String.valueOf(num);
				if(menuNo.equals(menuNum)){
					titleName = titleName + " " + bcList.get(i).get("bcName");
				}
			}
		}
	} else if( menuNo.indexOf("109")==0 ){
		titleName = "디지털아트학(엔터)";
		if( menuNo.indexOf("10901")==0 ){
			titleName = titleName + " 전공안내";
		}
		if( menuNo.indexOf("10902")==0 ){
			titleName = titleName + " 교수소개";
		}
		if( menuNo.indexOf("10903")==0 ){
			titleName = titleName + " 진출분야";
		}
		if( menuNo.indexOf("10904")==0 ){
			titleName = titleName + " 교과과정";
		}
		int num = 4;
		for(int i=0; i<bcList.size(); i++){
			if("09".equals(bcList.get(i).get("mCode"))){
				num++;
				String menuNum = "1090"+String.valueOf(num);
				if(menuNo.equals(menuNum)){
					titleName = titleName + " " + bcList.get(i).get("bcName");
				}
			}
		}
	} else if( menuNo.indexOf("106")==0 ){
		titleName = "패션비즈니스";
		if( menuNo.indexOf("10601")==0 ){
			titleName = titleName + " 전공안내";
		}
		if( menuNo.indexOf("10602")==0 ){
			titleName = titleName + " 교수소개";
		}
		if( menuNo.indexOf("10603")==0 ){
			titleName = titleName + " 진출분야";
		}
		if( menuNo.indexOf("10604")==0 ){
			titleName = titleName + " 교과과정";
		}
		int num = 4;
		for(int i=0; i<bcList.size(); i++){
			if("06".equals(bcList.get(i).get("mCode"))){
				num++;
				String menuNum = "1060"+String.valueOf(num);
				if(menuNo.equals(menuNum)){
					titleName = titleName + " " + bcList.get(i).get("bcName");
				}
			}
		}
	} else if( menuNo.indexOf("107")==0 ){
		titleName = "미용학";
		if( menuNo.indexOf("10701")==0 ){
			titleName = titleName + " 전공안내";
		}
		if( menuNo.indexOf("10702")==0 ){
			titleName = titleName + " 교수소개";
		}
		if( menuNo.indexOf("10703")==0 ){
			titleName = titleName + " 진출분야";
		}
		if( menuNo.indexOf("10704")==0 ){
			titleName = titleName + " 교과과정";
		}
		int num = 4;
		for(int i=0; i<bcList.size(); i++){
			if("07".equals(bcList.get(i).get("mCode"))){
				num++;
				String menuNum = "1070"+String.valueOf(num);
				if(menuNo.equals(menuNum)){
					titleName = titleName + " " + bcList.get(i).get("bcName");
				}
			}
		}
	} else if( menuNo.indexOf("108")==0 ){
		titleName = "미용학(one-day)";
		if( menuNo.indexOf("10801")==0 ){
			titleName = titleName + " 전공안내";
		}
		if( menuNo.indexOf("10802")==0 ){
			titleName = titleName + " 교수소개";
		}
		if( menuNo.indexOf("10803")==0 ){
			titleName = titleName + " 진출분야";
		}
		if( menuNo.indexOf("10804")==0 ){
			titleName = titleName + " 교과과정";
		}
		int num = 4;
		for(int i=0; i<bcList.size(); i++){
			if("08".equals(bcList.get(i).get("mCode"))){
				num++;
				String menuNum = "1080"+String.valueOf(num);
				if(menuNo.equals(menuNum)){
					titleName = titleName + " " + bcList.get(i).get("bcName");
				}
			}
		}
	} else if( menuNo.indexOf("20")==0 ){
		titleName = "입학안내";
		if( menuNo.indexOf("201")==0 ){
			titleName = titleName + " 모집요강";
		}
		if( menuNo.indexOf("202")==0 ){
			titleName = titleName + " 원서접수";
		}
		if( menuNo.indexOf("203")==0 ){
			titleName = titleName + " 원서접수확인";
		}
		if( menuNo.indexOf("204")==0 ){
			titleName = titleName + " 합격자, 등록금 조회";
		}
		if( menuNo.indexOf("205")==0 ){
			titleName = titleName + " 입학상담";
		}
		if( menuNo.indexOf("206")==0 ){
			titleName = titleName + " 자주하는질문";
		}
		if( menuNo.indexOf("207")==0 ){
			titleName = titleName + " 브로셔신청";
		}
	} else if( menuNo.indexOf("30")==0 ){
		titleName = "캠퍼스생활";
		if( menuNo.indexOf("301")==0 ){
			titleName = titleName + " 학사일정";
		}
		if( menuNo.indexOf("302")==0 ){
			titleName = titleName + " 학사안내";
		}
		if( menuNo.indexOf("303")==0 ){
			titleName = titleName + " 장학제도";
		}
		if( menuNo.indexOf("304")==0 ){
			titleName = titleName + " 양식자료실";
		}
		if( menuNo.indexOf("409")==0 ){
			titleName = titleName + " 보유과목안내";
		}
	} else if( menuNo.indexOf("40")==0 ){
		titleName = "한디원소개";
		if( menuNo.indexOf("401")==0 ){
			titleName = titleName + " 한디원소개";
		}
		if( menuNo.indexOf("402")==0 ){
			titleName = titleName + " 총장인사말";
		}
		if( menuNo.indexOf("403")==0 ){
			titleName = titleName + " 원장인사말";
		}
		if( menuNo.indexOf("404")==0 ){
			titleName = titleName + " 오시는길";
		}
		if( menuNo.indexOf("405")==0 ){
			titleName = titleName + " 조직및연락처";
		}
		if( menuNo.indexOf("407")==0 ){
			titleName= " 학점은행제 알리미";
		}
	} else if( menuNo.indexOf("50")==0 ){
		if( menuNo.indexOf("5090")==0 ){
			titleName = "행사";
			if( menuNo.indexOf("50901")==0 ){
				titleName = titleName + " 행사참가신청";
			}
			if( menuNo.indexOf("50902")==0 ){
				titleName = titleName + " 행사참가비확인";
			}
			if( menuNo.indexOf("50903")==0 ){
				titleName = titleName + " 행사참가 취소신청";
			}
		} else {
			titleName = "커뮤니티";
			if( menuNo.indexOf("501")==0 ){
				titleName = titleName + " 자랑스런 한디원";
			}
			if( menuNo.indexOf("23001")==0 ){
				titleName = titleName + " 해외프로그램";
			}
			if( menuNo.indexOf("702")==0 ){
				titleName = titleName + " 기업연계수업";
			}
			if( menuNo.indexOf("701")==0 ){
				titleName = titleName + " 기업연계수업";
			}
			if( menuNo.indexOf("16001")==0 ){
				titleName = titleName + " 동영상&UCC ";
			}
			if( menuNo.indexOf("16003")==0 ){
				titleName = titleName + " 작품자료실";
			}
			if( menuNo.indexOf("16002")==0 ){
				titleName = titleName + " 한툰";
			}
			if( menuNo.indexOf("504")==0 ){
				titleName = titleName + " 공모전 수상내역";
			}
			if( menuNo.indexOf("505")==0 ){
				titleName = titleName + " 취업센터";
			}
			if( menuNo.indexOf("305")==0 ){
				titleName = titleName + " 학사FAQ";
			}
			if( menuNo.indexOf("306")==0 ){
				titleName = titleName + " 학사Q&A";
			}
			if( menuNo.indexOf("307")==0 ){
				titleName = titleName + " 한디원신문고";
			}
			if( menuNo.indexOf("308")==0 ){
				titleName = titleName + " 공지사항";
			}
		}
	} else if( menuNo.indexOf("60")==0 ){
		titleName = "취업센터";
		if( menuNo.indexOf("601")==0 ){
			titleName = titleName + " 취업현황";
		}
		if( menuNo.indexOf("602")==0 ){
			titleName = titleName + " 진학현황";
		}
		if( menuNo.indexOf("603")==0 ){
			titleName = titleName + " 성공취업인터뷰";
		}
		if( menuNo.indexOf("604")==0 ){
			titleName = titleName + " 함께하는기업들";
		}
	} else if( menuNo.indexOf("80")==0 || menuNo.indexOf("220") == 0){
		titleName = "D-School";
		if( menuNo.indexOf("801")==0 ){
			titleName = titleName + " 과정안내";
		}
		if( menuNo.indexOf("802")==0 ){
			titleName = titleName + " D-School Q&A";
		}
		if( menuNo.indexOf("806")==0 ){
			titleName = titleName + " 공지사항";
		}
		if( menuNo.indexOf("22001")==0 ){
			titleName = titleName + " 진로체험안내";
		}
		if( menuNo.indexOf("22002")==0 ){
			titleName = titleName + " 진로체험신청";
		}
		if( menuNo.equals("22003")){
			titleName = titleName + " 진로체험소식";
		}
	} else if( menuNo.indexOf("21")==0 ){
		titleName = "일학습엘리트 과정";
		if( menuNo.indexOf("2101")==0 ){
			titleName = titleName + " 일학습엘리트과정이란?";
		}
		if( menuNo.indexOf("208")==0 ){
			titleName = titleName + " 모집요강";
		}
	} else if( menuNo.indexOf("110")==0 ){
		titleName = "타일디자인시공";
		if( menuNo.indexOf("11001")==0 ){
			titleName = titleName + " 전공안내";
		}
		if( menuNo.indexOf("11002")==0 ){
			titleName = titleName + " 교수소개";
		}
		if( menuNo.indexOf("11003")==0 ){
			titleName = titleName + " 교과과정";
		}
		int num = 3;
		for(int i=0; i<bcList.size(); i++){
			if("11".equals(bcList.get(i).get("mCode"))){
				num++;
				String menuNum = "1100"+String.valueOf(num);
				if(menuNo.equals(menuNum)){
					titleName = titleName + " " + bcList.get(i).get("bcName");
				}
			}
		}
	} else if( menuNo.indexOf("120")==0 ){
		titleName = "성우콘텐츠크리에이터";
		if( menuNo.indexOf("12001")==0 ){
			titleName = titleName + " 전공안내";
		}
		if( menuNo.indexOf("12002")==0 ){
			titleName = titleName + " 교수소개";
		}
		if( menuNo.indexOf("12003")==0 ){
			titleName = titleName + " 교과과정";
		}
		int num = 3;
		for(int i=0; i<bcList.size(); i++){
			if("12".equals(bcList.get(i).get("mCode"))){
				num++;
				String menuNum = "1200"+String.valueOf(num);
				if(menuNo.equals(menuNum)){
					titleName = titleName + " " + bcList.get(i).get("bcName");
				}
			}
		}
	} else if( menuNo.indexOf("130")==0 ){
		titleName = "글로벌패션창업";
		if( menuNo.indexOf("13001")==0 ){
			titleName = titleName + " 전공안내";
		}
		if( menuNo.indexOf("13002")==0 ){
			titleName = titleName + " 교수소개";
		}
		if( menuNo.indexOf("13003")==0 ){
			titleName = titleName + " 교과과정";
		}
		int num = 3;
		for(int i=0; i<bcList.size(); i++){
			if("13".equals(bcList.get(i).get("mCode"))){
				num++;
				String menuNum = "1300"+String.valueOf(num);
				if(menuNo.equals(menuNum)){
					titleName = titleName + " " + bcList.get(i).get("bcName");
				}
			}
		}
	} else if( menuNo.indexOf("140")==0 ){
		titleName = "뷰티 교육자ㆍ엘리트";
		if( menuNo.indexOf("14001")==0 ){
			titleName = titleName + " 전공안내";
		}
		if( menuNo.indexOf("14002")==0 ){
			titleName = titleName + " 교수소개";
		}
		if( menuNo.indexOf("14003")==0 ){
			titleName = titleName + " 교과과정";
		}
		int num = 3;
		for(int i=0; i<bcList.size(); i++){
			if("14".equals(bcList.get(i).get("mCode"))){
				num++;
				String menuNum = "1400"+String.valueOf(num);
				if(menuNo.equals(menuNum)){
					titleName = titleName + " " + bcList.get(i).get("bcName");
				}
			}
		}
	}
	
	if(!"0".equals(menuNo))	titleName = titleName + " | ";
	session.setAttribute("titleName", titleName);
%>