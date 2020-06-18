package main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import common.controller.AbstractController;
import main.model.IndexDAO;
import main.model.InterIndexDAO;
import main.model.ProductVO;

public class IndexListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String type = request.getParameter("type");
		String category = request.getParameter("category");
		String random = "";
		
		System.out.println("type=>"+type+"/ category=>"+category);
		
		Map<String,String> paraMap = new HashMap<String, String>();
		paraMap.put("type", type);
		if(category != null) paraMap.put("category",category);
		
		InterIndexDAO idao = new IndexDAO();
		
		List<ProductVO> productList = idao.listCall(paraMap);
		
		Gson gson = new Gson();
		String json = gson.toJson(productList);
		request.setAttribute("json", json);	
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}
