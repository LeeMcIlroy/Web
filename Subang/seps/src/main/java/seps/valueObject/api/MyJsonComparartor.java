package seps.valueObject.api;

import java.util.Comparator;

import org.json.simple.JSONObject;

 public class MyJsonComparartor implements Comparator<JSONObject> {

    	@Override
    	public int compare(JSONObject o1, JSONObject o2) {
    	    String v1 = (String) o1.get("fcstTime").toString();
    	    String v3 = (String) o2.get("fcstTime").toString();
    	    return v1.compareTo(v3);
    	}
    }