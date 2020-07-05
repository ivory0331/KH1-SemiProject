package main.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import main.model.IndexDAO;
import main.model.InterIndexDAO;

public class ManagerOrderStateChangeAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String state = request.getParameter("state");
		String value = request.getParameter("value");
		
		Map<String,String> paraMap = new HashMap<String, String>();
		paraMap.put("state", state);
		paraMap.put("value",value);
		
		InterIndexDAO dao = new IndexDAO();
		int result = dao.orderStateChane(paraMap);
		String message = "선택한 주문의 배송상태를 변경했습니다.";
		if(result == 0) {
			message = " 배송상태를 변경하는 도중 오류가 발생했습니다. ";
		}
		
		JSONObject jobj = new JSONObject();
		jobj.put("message", message);
		String json = jobj.toString();
		request.setAttribute("json", json);
		
		super.setViewPage("/WEB-INF/jsonview.jsp");
		

	}

}
