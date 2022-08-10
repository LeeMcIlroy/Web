/**
 * 트위터 로그인
 */

function fn_twitterLogin(){
		<%
    	final String CONSUMER_KEY = "aLKERRab7M6DqWXsXx7gQ7Sch"; //APP등록 후 받은 consumer key
    	final String CONSUMER_SECRET = "HMHfa73rtxcU4ajammkspYaj4ei7dyOW63mJ5Mhvz0pqUf1Rv6"; //APP등록 후 받은 consumer secret
    	//트위터 인스턴스 생성
    	Twitter twitter = new TwitterFactory().getInstance();
    	//키 등록
    	twitter.setOAuthConsumer(CONSUMER_KEY, CONSUMER_SECRET);
    	//인증 요청 토큰 생성
    	RequestToken reqToken = twitter.getOAuthRequestToken();
    	String tokenSecret = reqToken.getTokenSecret();
    	String token = reqToken.getToken();
    	
    	//CallBack 페이지에서 이용하기 위하여 토큰 비밀번호를 세션에 저장한다.
    	session.setAttribute("tokenSecret", reqToken.getTokenSecret());
    	session.setAttribute("requestToken", reqToken);
    	//인증 URL 생성 (이걸 클릭하면, 트위터 인증 페이지로 넘어간다.
   		 %>
		window.open("<%=reqToken.getAuthorizationURL() %>", "", "width=600 height=600")
    	
	}