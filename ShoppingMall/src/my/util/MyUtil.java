package my.util;

import javax.servlet.http.HttpServletRequest;

public class MyUtil {

	
	// *** ? 다음의 데이터까지 포함한 URL 주소를 알아오는 메소드 생성 *** //
	public static String getCurrentURL(HttpServletRequest request) {
		
		String currentURL = request.getRequestURL().toString();
		// http://localhost:9090/MyMVC/shop/prodView.up
		
		String queryString = request.getQueryString();
		// pnum=1
		
		currentURL += "?"+queryString;
		
		String ctxPath = request.getContextPath();
		//     /MyMVC
		
		int beginIndex = currentURL.indexOf(ctxPath)+ctxPath.length();
		//      27	   =			   21			+	   6
		
		currentURL = currentURL.substring(beginIndex+1);
		//					28
		// shop/prodView.up?pnum=1
		
		return currentURL;
	}
		
}
