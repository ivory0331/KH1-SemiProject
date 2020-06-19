package main.controller;

import java.math.MathContext;
import java.util.ArrayList;
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
		List<String> product_numArr = new ArrayList<String>();
		System.out.println("type=>"+type+"/ category=>"+category);
		
		Map<String,String> paraMap = new HashMap<String, String>();
		paraMap.put("type", type);
		InterIndexDAO idao = new IndexDAO();
		
		// MD추천에 사용되는 category 값이 있는지 없는지 유무 확인
		if(category != null) paraMap.put("category",category);
		
		if("random".equals(type)) {
			product_numArr = idao.product_numFind();
			boolean check = true;
			System.out.println("사이즈:"+product_numArr.size());
			String[] randomArr = {"-1","-1","-1","-1","-1","-1","-1","-1"};
			for(int i=0; i<randomArr.length; i++) {
				int num = (int)(Math.random()*(product_numArr.size()-1)-0+1)+0;
				for(int j=0; j<randomArr.length; j++) {
					if(randomArr[j].equals(product_numArr.get(num))) {
						i--;
						check=false;
						break;
					}
				}
				if(check) {
					randomArr[i] = product_numArr.get(num);
				}
				else {
					check = true;
				}
				System.out.println((i+1)+"번째 item번호:"+randomArr[i]+"/난수 num="+num);
			}
			String random = String.join(",", randomArr);
			paraMap.put("random",random);
		}
		
		
		
		 List<ProductVO> productList = idao.listCall(paraMap);
		
		Gson gson = new Gson();
		String json = gson.toJson(productList);
		request.setAttribute("json", json);	
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}
