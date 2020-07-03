package product.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.*;

public class RecommendProductAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InterProductDAO productdao = new ProductDAO();
		
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		if(currentShowPageNo == null)
			currentShowPageNo = "1";
		
		HashMap<String,String> paraMap = new HashMap<>();
		paraMap.put("currentShowPageNo", currentShowPageNo);
		paraMap.put("recommend", "recommend");
		
		List<ProductVO> recommendProduct = productdao.recommendList(paraMap);
		
		int totalPage = productdao.getTotalpage(paraMap);
		int pageNo = 1;
		int blockSize = 10;
		int loop = 1; 
		
		pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1) / blockSize ) * blockSize + 1;
		
		
		String pageBar = "<nav aria-label='Page navigation'>"
					   + "<ul class='pagination'>"
					   + "<li class=disabled>";
		
		// *** [이전] 만들기 *** //
		if( pageNo != 1 ) {
			pageBar += "&nbsp;<a aria-label='Previous' href='recommendProduct.do?currentShowPageNo="+(pageNo-1)+"'><span aria-hidden='true'>«</span></a></li>&nbsp;";
		}
				
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == Integer.parseInt(currentShowPageNo)) {
				pageBar += "&nbsp;<li class='active'><span style='color:#5F0080; border: solid 0.5px #e6e6e6; background-color:#f2f2f2;'>"+pageNo+"</span></li>&nbsp;";
			}
			else {
				pageBar += "&nbsp;<li><a href='recommendProduct.do?currentShowPageNo="+pageNo+"'><span style='color:#333;'>"+pageNo+"</span></a></li>&nbsp;";
			}		
			pageNo++; // 1 2 3 4 5 6 7 8 9 10 11 12 13 14 ... 40 41 42
			loop++;	  // 1 2 3 4 5 6 7 8 9 10
		}

		
		// *** [다음] 만들기 *** //
		if( !(pageNo > totalPage) ) {
			pageBar += "&nbsp;<li><a aria-label='Next' href='recommendProduct.do?currentShowPageNo="+pageNo+"'><span aria-hidden='true'>»</span></a></li>&nbsp;";
		}
		
		pageBar += "</li></ul></nav>";
		
		request.setAttribute("recommendProduct", recommendProduct);
		request.setAttribute("pageBar", pageBar);
		
		super.setViewPage("/WEB-INF/main/recommendList.jsp");

		
	}

}
