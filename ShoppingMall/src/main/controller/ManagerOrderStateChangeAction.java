package main.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		
		

	}

}
