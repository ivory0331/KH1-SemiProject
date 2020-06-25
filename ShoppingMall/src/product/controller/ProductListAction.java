package product.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.*;

public class ProductListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		InterProductDAO productdao = new ProductDAO();
		
	//	String fk_category_num = request.getParameter("fk_category_num");
		String fk_subcategory_num = request.getParameter("fk_subcategory_num");
		
		
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		if(currentShowPageNo == null)
			currentShowPageNo = "1";
		
		String fk_category_num = "1";
	//	String fk_subcategory_num = "41";
		
		HashMap<String,String> paraMap = new HashMap<>();
		paraMap.put("currentShowPageNo", currentShowPageNo);
		paraMap.put("fk_category_num", fk_category_num);
		paraMap.put("fk_subcategory_num", fk_subcategory_num);
		
	//	List<ProductVO> productList = productdao.selectProductList(paraMap);
		String categoryInfo = productdao.categoryInfo(fk_category_num);
		List<ProductVO> categoryList = productdao.categoryList(fk_category_num);
		
		List<ProductVO> productList = productdao.selectPagingProduct(paraMap);
		
		int totalPage = productdao.getTotalpage(paraMap);
		int pageNo =1;
		int blockSize = 10;
		int loop = 1;
		
		pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1) / blockSize ) * blockSize + 1;
		
		
		String pageBar = "";
		
		// *** [이전] 만들기 *** //
		if( pageNo != 1 ) {
			if(fk_subcategory_num == null) {
				pageBar += "&nbsp;<a href='productList.do?fk_category_num="+fk_category_num+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a>&nbsp;";
			} else
			pageBar += "&nbsp;<a href='productList.do?fk_category_num="+fk_category_num+"&fk_subcategory_num="+fk_subcategory_num+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a>&nbsp;";
		}
				
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == Integer.parseInt(currentShowPageNo)) {
				pageBar += "&nbsp;<span style='color: red; border: solid 1px gray; padding: 2px 4px;'>"+pageNo+"</span>&nbsp;";
			}
			else {
				if(fk_subcategory_num == null) {
					pageBar += "&nbsp;<a href='productList.do?fk_category_num="+fk_category_num+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a>&nbsp;";
				} else
				pageBar += "&nbsp;<a href='productList.do?fk_category_num="+fk_category_num+"&fk_subcategory_num="+fk_subcategory_num+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a>&nbsp;";
			}		
			pageNo++; // 1 2 3 4 5 6 7 8 9 10 11 12 13 14 ... 40 41 42
			loop++;	  // 1 2 3 4 5 6 7 8 9 10
		}

		
		// *** [다음] 만들기 *** //
		if( !(pageNo > totalPage) ) {
			if(fk_subcategory_num == null) {
				pageBar += "&nbsp;<a href='productList.do?fk_category_num="+fk_category_num+"&currentShowPageNo="+pageNo+"'>[다음]</a>&nbsp;";
			} else
				pageBar += "&nbsp;<a href='productList.do?fk_category_num="+fk_category_num+"&fk_subcategory_num="+fk_subcategory_num+"&currentShowPageNo="+pageNo+"'>[다음]</a>&nbsp;";
		}
		
		request.setAttribute("pageBar", pageBar);
		
		request.setAttribute("productList", productList);
		
		request.setAttribute("categoryInfo", categoryInfo);
		request.setAttribute("categoryList", categoryList);
		request.setAttribute("fk_category_num", fk_category_num);
		
		super.setViewPage("/WEB-INF/main/productList.jsp");
		
		
	}

}
