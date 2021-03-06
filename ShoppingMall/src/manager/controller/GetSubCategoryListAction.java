package manager.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import common.controller.AbstractController;
import manager.model.InterProductDAO;
import manager.model.ProductDAO;

public class GetSubCategoryListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		
		  String fk_category_num = request.getParameter("fk_category_num");
		  
		  
		  if(fk_category_num==null) {
			  fk_category_num="";			  
		  }		  
		 	  
		  InterProductDAO dao = new ProductDAO(); 
		  
		  List<HashMap<String,String>> subCategoryList = dao.getSubCategoryList(fk_category_num);
		  
		  
		  Gson gson = new Gson();
		  
		  
		  String json = gson.toJson(subCategoryList);
		  System.out.println(json);
		  request.setAttribute("json",json);
		  
		  super.setViewPage("/WEB-INF/jsonview.jsp");
		  
		  
		 
	}
}
