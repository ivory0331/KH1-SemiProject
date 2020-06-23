package main.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import common.controller.AbstractController;

public class InBasketAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		System.out.println(request.getParameter("product_num")+"/"+ request.getParameter("price")+"/"+request.getParameter("count"));
		List<Map<String, String>> basketNum = null;
		boolean check = true;
		String message="";
		Map<String, String> orderMap = new HashMap<String, String>();
		orderMap.put("product_num", request.getParameter("product_num"));
		orderMap.put("price", request.getParameter("price"));
		orderMap.put("count", request.getParameter("count"));
		
		if(session.getAttribute("basket")==null) {
			basketNum = new ArrayList<Map<String, String>>();
		}
		else {
			basketNum = (List<Map<String, String>>) session.getAttribute("basket");
			for(int i=0; i<basketNum.size(); i++) {
				if(request.getParameter("product_num").equals(basketNum.get(i).get("product_num"))) {
					check = false;
					break;
				}
			}
		}
		
		if(check) {
			basketNum.add(orderMap);
			session.setAttribute("basket", basketNum);
			message="상품을 장바구니에 담았습니다.";
		}else {
			message="이미 동일한 상품이 장바구니에 담아져 있습니다.";
		}
		
		JSONObject jobj = new JSONObject();
		jobj.put("message", message);
		jobj.put("cnt", String.valueOf(basketNum.size()));
		String json = jobj.toString();
		
		request.setAttribute("json", json);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}
