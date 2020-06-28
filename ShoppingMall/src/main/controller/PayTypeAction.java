package main.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;

public class PayTypeAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		if("get".equalsIgnoreCase(method)) {
			setViewPage("/WEB-INF/main/pay.jsp");
		}
		else {
			System.out.println(request.getAttribute("cartList"));
		}
		
	}

}
