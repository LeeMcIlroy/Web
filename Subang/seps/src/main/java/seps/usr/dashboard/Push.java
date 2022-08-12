package seps.usr.dashboard;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;

public class Push {  
	String            endpoint;  
	List<String>      scope;  
	String            keyFile;  
	String            accessToken;  
	HttpURLConnection http;  
	StringBuffer      responseBody;  

	public Push() throws IOException  {  
//	    this.endpoint = System.getProperty("endpoint");  
//		this.keyFile = System.getProperty("fcm_key");  
		this.endpoint = "https://www.googleapis.com/auth/firebase.messaging";  
		// 구글 콘솔 API 키
//		this.keyFile = "dafad93dbea57f9c77785540a12a009829fb56a2";  
		// 파이어 베이스 API키
//		this.keyFile = "AIzaSyBir0olot88xSKX4-6i-PyYZ0vmGGhv_0M";
	  
//		String tmp[] = System.getProperty("scope").split(",");  
		this.scope = new ArrayList<String>();  
		
		this.scope.add("https://www.googleapis.com/auth/firebase");
		this.scope.add("https://www.googleapis.com/auth/cloud-platform");
		this.scope.add("https://www.googleapis.com/auth/firebase.readonly");
		
//		for (String s : tmp)  
//		{  
//			this.scope.add(s);  
//	    }  
	  
		this.accessToken = getAccessToken(keyFile, scope);
		System.out.println(accessToken);
		responseBody = new StringBuffer();  
	}  

	public String getEndpoint()  
	{  
		return endpoint;  
	}  
  
    public void setEndpoint(String endpoint)  
    {  
		this.endpoint = endpoint;  
	}  
  
	public String getAccessToken()  
	{  
		return accessToken;  
	}  
  
	public void setAccessToken(String accessToken)  
	{  
		this.accessToken = accessToken;  
	}  
  
	public StringBuffer getResponseBody()  
	{  
		return responseBody;  
	}  
	
	public String getUTF8Str(String str) {
		try {
			str = new String(str.getBytes("UTF-8"), "UTF-8"); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return str;
	}
	

	public String send(String userToken, String title, String content) throws IOException  
	{  
		
		URL url = new URL("	https://fcm.googleapis.com/v1/projects/fcmsample-1254d/messages:send");
		HttpURLConnection http = (HttpURLConnection) url.openConnection();
		http.setRequestProperty("Authorization", "Bearer " + getAccessToken());
		http.setRequestProperty("Content-Type", "application/json; UTF-8");
		http.setRequestMethod("POST");  
		http.setDoInput(true);  
		http.setDoOutput(true);  
		
		OutputStream os = http.getOutputStream();  


		String body =  
            "{\n" + "\"message\":{\n" + " \"notification\": {\n" + " \"title\": \" "+title+" \",\n"  
			+ " \"body\": \"" + (content) + "\",\n"  
			+ "  },\n" + " \"token\": \"" + userToken + "\"\n" + "  }\n" + "}\n";  
  
		System.out.println(body);  
		
		body = getUTF8Str(body);
		
//			os.write(body.getBytes());  

		os.write(body.getBytes("UTF-8"));  
		os.flush();  
		os.close();  
  
		System.out.println("* CODE : " + http.getResponseCode());  
		System.out.println("* MSG  : " + http.getResponseMessage());  
  
		if(http.getResponseCode() == 200)  
		{  
			BufferedReader br = new BufferedReader(new InputStreamReader(http.getInputStream(), "UTF8"));  
  
			String line;  
			while ((line = br.readLine()) != null)  
			{  
				responseBody.append(line);  
			}  
  
			br.close();  
		}  
  
		http.disconnect();  
  
		return http.getResponseMessage();  
	}  
	
	public String getAccessToken(String keyFile, List<String> scopes)  throws  IOException  
	{  
		GoogleCredential googleCredential =  GoogleCredential  
			.fromStream(new  FileInputStream("F:/SystemIntegration/2018/seps/workspace/seps/src/main/webapp/assets/key/service-account.json"))  
			.createScoped(scopes);
			
		googleCredential.refreshToken();  
		return googleCredential.getAccessToken();  
	}
}
