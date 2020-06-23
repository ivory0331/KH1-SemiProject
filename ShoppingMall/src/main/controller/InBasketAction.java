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
import main.model.IndexDAO;
import main.model.InterIndexDAO;
import member.model.MemberVO;

public class InBasketAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		System.out.println(request.getParameter("product_num")+"/"+ request.getParameter("price")+"/"+request.getParameter("count"));
		List<Map<String, String>> basketNum = null;
		boolean check = true;
		String message="";
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		
		Map<String, String> orderMap = new HashMap<String, String>();
		orderMap.put("product_num", request.getParameter("product_num"));
		orderMap.put("price", request.getParameter("price"));
		orderMap.put("count", request.getParameter("count"));
		orderMap.put("member_num",String.valueOf(loginuser.getMember_num()));
		
		InterIndexDAO dao = new IndexDAO();
		check = dao.basketSelect(orderMap);
		
		if(check) {
			int n = dao.basketInsert(orderMap);
			if(n==1) message="상품을 장바구니에 담았습니다.";
			else message="상품을 장바구니에 담는 도중 오류가 발생했습니다.";
		}else {
			message="이미 동일한 상품이 장바구니에 담아져 있습니다.";
		}
		
		JSONObject jobj = new JSONObject();
		jobj.put("message", message);
		String json = jobj.toString();
		
		request.setAttribute("json", json);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}
