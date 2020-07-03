package my.util;

import javax.servlet.http.HttpServletRequest;

public class MyUtil {
	
		// *** 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어코드)를 작성해주는 메소드 생성 *** // 
		public static String replaceParameter(String param) {
			String result = param;
			
			if(param != null) {
				result = result.replaceAll("<", "&lt;");
				result = result.replaceAll(">", "&gt;");
			//	result = result.replaceAll("\r\n", "<br>");
			//	result = result.replaceAll("&", "&amp;");
			//	result = result.replaceAll("\"", "&quot;");
			}

			return result;
			 
		}
		
		
		
		public static String getCurrentURL(HttpServletRequest request) {			
			
			// ? 다음의 데이터까지 포함한  url 주소를 알아오는 메소드 생성
			String currentURL = request.getRequestURL().toString(); //물음표 이전 http://localhost:9090~prodView.up			
			String queryString = request.getQueryString();//물음표다음 pnum=3			
			currentURL += "?" + queryString;
			
			String ctxPath = request.getContextPath();			
			int beginIndex = currentURL.indexOf(ctxPath)+ctxPath.length();			
			String goBackURL = currentURL.substring(beginIndex+1);//28번째부터 끝까지 shop/prodView.up? pnum=3
			
			return goBackURL;
			
		}

	
}
