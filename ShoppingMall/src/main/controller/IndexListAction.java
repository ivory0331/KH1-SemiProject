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
		
		// request로 담는 내용에 따라 보여주는 결과물이 다르도록 내용 실행 //
		String type = request.getParameter("type");
		String category = request.getParameter("category");
		
		List<String> product_numArr = new ArrayList<String>();
		
		Map<String,String> paraMap = new HashMap<String, String>();
		paraMap.put("type", type);
		InterIndexDAO idao = new IndexDAO();
		
		// MD추천에 사용되는 category 값이 있는지 없는지 유무 확인
		if(category != null) paraMap.put("category",category); 
		
		// type = "random"일 경우 random을 사용하여 임의의 번호를 갖고온다.
		if("random".equals(type)) {
			product_numArr = idao.product_numFind(); // DB에서 모든 상품의 번호를 선정.    
			boolean check = true;
			System.out.println("사이즈:"+product_numArr.size());
			String[] randomArr = {"-1","-1","-1","-1","-1","-1","-1","-1"}; // 상품의 번호가 아닌 -1로 초기값 설정
			
			// 반복을 통해 임의의 번호값을 갖고 온다.(한번 임의의 번호를 갖고 올때마다 이미 뽑은 값인지 확인)
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
			}
			String random = String.join(",", randomArr);
			paraMap.put("random",random);
		}
		
		
		// 위에서 선정된 조건으로 상품을 조회
		 List<ProductVO> productList = idao.listCall(paraMap);
		
		Gson gson = new Gson();
		String json = gson.toJson(productList);
		request.setAttribute("json", json);	
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}
