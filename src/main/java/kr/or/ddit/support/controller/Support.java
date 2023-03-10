package kr.or.ddit.support.controller;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.http.exceptions.UnirestException;

import kr.or.ddit.support.model.ItemsVo;

/**
* Support.java
*
* @author 유민하
* @version 1.0
* @see
*
* <pre>
* << 개정이력(Modification Information) >>
*
* 수정자 수정내용
* ------ ------------------------
* 유민하 최초 생성
*
* </pre>
*/
public class Support {
	
	/**
	* Method : policy
	* 작성자 : 유민하
	* 변경이력 :
	* @return
	* Method 설명 : 정책자금 시책 가져오기
	*/
	public static  List<ItemsVo> policy() {
		List<ItemsVo> itemsList = new ArrayList<ItemsVo>();

		try { // try-catch필요
			// postman에서 code를 복사-붙여넣기
			HttpResponse<String> response = Unirest.get("http://www.sbiz.or.kr/sup/policy/json/policyfound.do")
					  .header("User-Agent", "PostmanRuntime/7.15.2")
					  .header("Accept", "*/*")
					  .header("Cache-Control", "no-cache")
					  .header("Postman-Token", "e2c06be3-7aec-4235-ba33-3103ebdd94a1,e50b2e4d-8965-41f4-ad0c-b1687bac7b70")
					  .header("Host", "www.sbiz.or.kr")
					  .header("Cookie", "WMONID=QtfTYOutlN_; JSESSIONID=64pwd3qhFsX1SbxX9grHvflvl3hMD77QCJJ52LMVchxPXJfp4m4Q!2099542435")
					  .header("Accept-Encoding", "gzip, deflate")
					  .header("Connection", "keep-alive")
					  .header("cache-control", "no-cache")
					  .asString();

			String body = response.getBody(); // 결과값 가져오기
			JSONObject obj = new JSONObject(body); //json 형태 변수 담기

			JSONArray item = obj.getJSONArray("item"); // item 배열이니까 JSONArray
			for(int i = 0; i < item.length(); i++) {
				JSONObject obj2 = item.getJSONObject(i); //배열의 i번째 object추출
				
				//대전지역 정보만 가져오기
				if(obj2.get("areaNo").equals("4")) {
					JSONArray items = obj2.getJSONArray("items");
					for (int j = 0; j < items.length(); j++) {
						
						JSONObject obj3 = items.getJSONObject(j); // 배열의 i번째 Object추출
						
						String year = obj3.getString("year");
						String url = obj3.getString("url");
						String title = obj3.getString("title");
						
						itemsList.add(new ItemsVo(year,url,title));
					}
				}
			}

		} catch (UnirestException e) {
			e.printStackTrace();
		}
		
		return itemsList;

	}
	
	/**
	* Method : growth
	* 작성자 : 유민하
	* 변경이력 :
	* @return
	* Method 설명 : 성장지원 시책 가져오기
	*/
	public static  List<ItemsVo> growth() {
		List<ItemsVo> itemsList = new ArrayList<ItemsVo>();

		try { // try-catch필요
			// postman에서 code를 복사-붙여넣기
			HttpResponse<String> response = Unirest.get("http://www.sbiz.or.kr/sup/policy/json/policygrow.do")
					  .header("User-Agent", "PostmanRuntime/7.15.2")
					  .header("Accept", "*/*")
					  .header("Cache-Control", "no-cache")
					  .header("Postman-Token", "54918879-9b8e-48a6-8486-1bce7401d540,2ba3ff2e-2dd6-491d-8816-929003470a67")
					  .header("Host", "www.sbiz.or.kr")
					  .header("Cookie", "WMONID=QtfTYOutlN_; JSESSIONID=hbPDd42KlpVq7fgnMwK2Dp5ZTfhfmL3RtDDx9pfShXpXhm5tQxt2!2099542435")
					  .header("Accept-Encoding", "gzip, deflate")
					  .header("Connection", "keep-alive")
					  .header("cache-control", "no-cache")
					  .asString();

			String body = response.getBody(); // 결과값 가져오기
			JSONObject obj = new JSONObject(body); //json 형태 변수 담기

			JSONArray item = obj.getJSONArray("item"); // item 배열이니까 JSONArray
			for(int i = 0; i < item.length(); i++) {
				JSONObject obj2 = item.getJSONObject(i); //배열의 i번째 object추출
				
				//대전지역 정보만 가져오기
				if(obj2.get("areaNo").equals("4")) {
					JSONArray items = obj2.getJSONArray("items");
					for (int j = 0; j < items.length(); j++) {
						
						JSONObject obj3 = items.getJSONObject(j); // 배열의 i번째 Object추출
						
						String year = obj3.getString("year");
						String url = obj3.getString("url");
						String title = obj3.getString("title");
						
						itemsList.add(new ItemsVo(year,url,title));
					}
				}
			}

		} catch (UnirestException e) {
			e.printStackTrace();
		}
		
		return itemsList;

	}
	
	/**
	* Method : comeback
	* 작성자 : 유민하
	* 변경이력 :
	* @return
	* Method 설명 : 재기지원 시책 가져오기
	*/
	public static  List<ItemsVo> comeback() {
		List<ItemsVo> itemsList = new ArrayList<ItemsVo>();

		try { // try-catch필요
			// postman에서 code를 복사-붙여넣기
			HttpResponse<String> response = Unirest.get("http://www.sbiz.or.kr/sup/policy/json/policycomeback.do")
					  .header("User-Agent", "PostmanRuntime/7.15.2")
					  .header("Accept", "*/*")
					  .header("Cache-Control", "no-cache")
					  .header("Postman-Token", "b7e3b43f-c971-41e9-83f3-98bdb2fd2f9f,91dddaf1-1f11-4427-ab9c-3b4372d2cb6b")
					  .header("Host", "www.sbiz.or.kr")
					  .header("Cookie", "WMONID=QtfTYOutlN_; JSESSIONID=hbPDd42KlpVq7fgnMwK2Dp5ZTfhfmL3RtDDx9pfShXpXhm5tQxt2!2099542435")
					  .header("Accept-Encoding", "gzip, deflate")
					  .header("Connection", "keep-alive")
					  .header("cache-control", "no-cache")
					  .asString();

			String body = response.getBody(); // 결과값 가져오기
			JSONObject obj = new JSONObject(body); //json 형태 변수 담기

			JSONArray item = obj.getJSONArray("item"); // item 배열이니까 JSONArray
			for(int i = 0; i < item.length(); i++) {
				JSONObject obj2 = item.getJSONObject(i); //배열의 i번째 object추출
				
				//대전지역 정보만 가져오기
				if(obj2.get("areaNo").equals("4")) {
					JSONArray items = obj2.getJSONArray("items");
					for (int j = 0; j < items.length(); j++) {
						
						JSONObject obj3 = items.getJSONObject(j); // 배열의 i번째 Object추출
						
						String year = obj3.getString("year");
						String url = obj3.getString("url");
						String title = obj3.getString("title");
						
						itemsList.add(new ItemsVo(year,url,title));
					}
				}
			}

		} catch (UnirestException e) {
			e.printStackTrace();
		}
		
		return itemsList;

	}
	
	/**
	* Method : foundation
	* 작성자 : 유민하
	* 변경이력 :
	* @return
	* Method 설명 : 창업지원 시책 가져오기
	*/
	public static  List<ItemsVo> foundation() {
		List<ItemsVo> itemsList = new ArrayList<ItemsVo>();

		try { // try-catch필요
			// postman에서 code를 복사-붙여넣기
			HttpResponse<String> response = Unirest.get("http://www.sbiz.or.kr/sup/policy/json/policystartup.do")
					  .header("User-Agent", "PostmanRuntime/7.15.2")
					  .header("Accept", "*/*")
					  .header("Cache-Control", "no-cache")
					  .header("Postman-Token", "89515c2c-b72e-43c2-832a-a2bc701643d5,e1e6ae73-2ea1-452c-8842-55ec2c5c5133")
					  .header("Host", "www.sbiz.or.kr")
					  .header("Cookie", "WMONID=QtfTYOutlN_; JSESSIONID=hbPDd42KlpVq7fgnMwK2Dp5ZTfhfmL3RtDDx9pfShXpXhm5tQxt2!2099542435")
					  .header("Accept-Encoding", "gzip, deflate")
					  .header("Connection", "keep-alive")
					  .header("cache-control", "no-cache")
					  .asString();

			String body = response.getBody(); // 결과값 가져오기
			JSONObject obj = new JSONObject(body); //json 형태 변수 담기

			JSONArray item = obj.getJSONArray("item"); // item 배열이니까 JSONArray
			for(int i = 0; i < item.length(); i++) {
				JSONObject obj2 = item.getJSONObject(i); //배열의 i번째 object추출
				
				//대전지역 정보만 가져오기
				if(obj2.get("areaNo").equals("4")) {
					JSONArray items = obj2.getJSONArray("items");
					for (int j = 0; j < items.length(); j++) {
						
						JSONObject obj3 = items.getJSONObject(j); // 배열의 i번째 Object추출
						
						String year = obj3.getString("year");
						String url = obj3.getString("url");
						String title = obj3.getString("title");
						
						itemsList.add(new ItemsVo(year,url,title));
					}
				}
			}

		} catch (UnirestException e) {
			e.printStackTrace();
		}
		
		return itemsList;

	}
	
	
	/**
	* Method : market
	* 작성자 : 유민하
	* 변경이력 :
	* @return
	* Method 설명 : 전통시장 활성화 시책 가져오기
	*/
	public static  List<ItemsVo> market() {
		List<ItemsVo> itemsList = new ArrayList<ItemsVo>();

		try { // try-catch필요
			// postman에서 code를 복사-붙여넣기
			HttpResponse<String> response = Unirest.get("http://www.sbiz.or.kr/sup/policy/json/policymarket.do")
					  .header("User-Agent", "PostmanRuntime/7.15.2")
					  .header("Accept", "*/*")
					  .header("Cache-Control", "no-cache")
					  .header("Postman-Token", "34cf1dbb-8900-4224-a49f-c3a651408088,20b12aa3-ac7a-4d07-8e3c-5bb5c14271c6")
					  .header("Host", "www.sbiz.or.kr")
					  .header("Cookie", "WMONID=QtfTYOutlN_; JSESSIONID=hbPDd42KlpVq7fgnMwK2Dp5ZTfhfmL3RtDDx9pfShXpXhm5tQxt2!2099542435")
					  .header("Accept-Encoding", "gzip, deflate")
					  .header("Connection", "keep-alive")
					  .header("cache-control", "no-cache")
					  .asString();

			String body = response.getBody(); // 결과값 가져오기
			JSONObject obj = new JSONObject(body); //json 형태 변수 담기

			JSONArray item = obj.getJSONArray("item"); // item 배열이니까 JSONArray
			for(int i = 0; i < item.length(); i++) {
				JSONObject obj2 = item.getJSONObject(i); //배열의 i번째 object추출
				
				//대전지역 정보만 가져오기
				if(obj2.get("areaNo").equals("4")) {
					JSONArray items = obj2.getJSONArray("items");
					for (int j = 0; j < items.length(); j++) {
						
						JSONObject obj3 = items.getJSONObject(j); // 배열의 i번째 Object추출
						
						String year = obj3.getString("year");
						String url = obj3.getString("url");
						String title = obj3.getString("title");
						
						itemsList.add(new ItemsVo(year,url,title));
					}
				}
			}

		} catch (UnirestException e) {
			e.printStackTrace();
		}
		
		return itemsList;

	}
	
	/**
	* Method : guarantee
	* 작성자 : 유민하
	* 변경이력 :
	* @return
	* Method 설명 : 보증지원 시책 가져오기
	*/
	public static  List<ItemsVo> guarantee() {
		List<ItemsVo> itemsList = new ArrayList<ItemsVo>();
		
		try { // try-catch필요
			// postman에서 code를 복사-붙여넣기
			HttpResponse<String> response = Unirest.get("http://www.sbiz.or.kr/sup/policy/json/policygrnty.do")
					  .header("User-Agent", "PostmanRuntime/7.15.2")
					  .header("Accept", "*/*")
					  .header("Cache-Control", "no-cache")
					  .header("Postman-Token", "7a8e9592-44ff-44cb-a64b-d231815c0ed2,b445cbf7-4488-44e2-9437-d9952986e936")
					  .header("Host", "www.sbiz.or.kr")
					  .header("Cookie", "WMONID=QtfTYOutlN_; JSESSIONID=hbPDd42KlpVq7fgnMwK2Dp5ZTfhfmL3RtDDx9pfShXpXhm5tQxt2!2099542435")
					  .header("Accept-Encoding", "gzip, deflate")
					  .header("Connection", "keep-alive")
					  .header("cache-control", "no-cache")
					  .asString();
			
			String body = response.getBody(); // 결과값 가져오기
			JSONObject obj = new JSONObject(body); //json 형태 변수 담기
			
			JSONArray item = obj.getJSONArray("item"); // item 배열이니까 JSONArray
			for(int i = 0; i < item.length(); i++) {
				JSONObject obj2 = item.getJSONObject(i); //배열의 i번째 object추출
				
				//대전지역 정보만 가져오기
				if(obj2.get("areaNo").equals("4")) {
					JSONArray items = obj2.getJSONArray("items");
					for (int j = 0; j < items.length(); j++) {
						
						JSONObject obj3 = items.getJSONObject(j); // 배열의 i번째 Object추출
						
						String year = obj3.getString("year");
						String url = obj3.getString("url");
						String title = obj3.getString("title");
						
						itemsList.add(new ItemsVo(year,url,title));
					}
				}
			}
			
		} catch (UnirestException e) {
			e.printStackTrace();
		}
		
		return itemsList;
		
	}

}
