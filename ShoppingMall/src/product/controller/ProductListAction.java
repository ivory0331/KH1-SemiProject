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
		
		String fk_category_num = request.getParameter("fk_category_num");
		String fk_subcategory_num = request.getParameter("fk_subcategory_num");
		
		if(fk_subcategory_num == "")
			fk_subcategory_num = null;
		
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		if(currentShowPageNo == null)
			currentShowPageNo = "1";
		
		String optionSelect = request.getParameter("optionSelect");
		
		if(optionSelect == null) {
			optionSelect = "registerdate";
		}

	//	String fk_category_num = "4";
	//	String fk_subcategory_num = "41";
		
		HashMap<String,String> paraMap = new HashMap<>();
		paraMap.put("currentShowPageNo", currentShowPageNo);
		paraMap.put("fk_category_num", fk_category_num);
		paraMap.put("fk_subcategory_num", fk_subcategory_num);
		paraMap.put("optionSelect", optionSelect);
		
	//	List<ProductVO> productList = productdao.selectProductList(paraMap);
		String categoryInfo = productdao.categoryInfo(fk_category_num);
		List<ProductVO> subcategoryList = productdao.subcategoryList(fk_category_num);
		
		List<ProductVO> productList = productdao.selectOption(paraMap);
		
		int totalPage = productdao.getTotalpage(paraMap);
		int pageNo =1;
		int blockSize = 10;
		int loop = 1;
		
		pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1) / blockSize ) * blockSize + 1;
		
		
		String pageBar = "<nav aria-label='Page navigation'>"
					   + "<ul class='pagination'>"
					   + "<li class=disabled>";
		
		// *** [이전] 만들기 *** //
		if( pageNo != 1 ) {
			if(fk_subcategory_num == null) {
				pageBar += "&nbsp;<a aria-label='Previous' href='productList.do?fk_category_num="+fk_category_num+"&optionSelect="+optionSelect+"&currentShowPageNo="+(pageNo-1)+"'><span aria-hidden='true'>«</span></a></li>&nbsp;";
			} else
			pageBar += "&nbsp;<a aria-label='Previous' href='productList.do?fk_category_num="+fk_category_num+"&fk_subcategory_num="+fk_subcategory_num+"&optionSelect="+optionSelect+"&currentShowPageNo="+(pageNo-1)+"'><span aria-hidden='true'>«</span></a></li>&nbsp;";
		}
				
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == Integer.parseInt(currentShowPageNo)) {
				pageBar += "&nbsp;<li class='active'><span style='color:#5F0080; border: solid 0.5px #e6e6e6; background-color:#f2f2f2;'>"+pageNo+"</span></li>&nbsp;";
			}
			else {
				if(fk_subcategory_num == null) {
					pageBar += "&nbsp;<li><a href='productList.do?fk_category_num="+fk_category_num+"&optionSelect="+optionSelect+"&currentShowPageNo="+pageNo+"'><span style='color:#333;'>"+pageNo+"</span></a></li>&nbsp;";
				} else
				pageBar += "&nbsp;<li><a href='productList.do?fk_category_num="+fk_category_num+"&fk_subcategory_num="+fk_subcategory_num+"&optionSelect="+optionSelect+"&currentShowPageNo="+pageNo+"'><span style='color:#333;'>"+pageNo+"</span></a></li>&nbsp;";
			}		
			pageNo++; // 1 2 3 4 5 6 7 8 9 10 11 12 13 14 ... 40 41 42
			loop++;	  // 1 2 3 4 5 6 7 8 9 10
		}

		
		// *** [다음] 만들기 *** //
		if( !(pageNo > totalPage) ) {
			if(fk_subcategory_num == null) {
				pageBar += "&nbsp;<li><a aria-label='Next' href='productList.do?fk_category_num="+fk_category_num+"&optionSelect="+optionSelect+"&currentShowPageNo="+pageNo+"'><span aria-hidden='true'>»</span></a></li>&nbsp;";
			} else
				pageBar += "&nbsp;<li><a aria-label='Next' href='productList.do?fk_category_num="+fk_category_num+"&fk_subcategory_num="+fk_subcategory_num+"&optionSelect="+optionSelect+"&currentShowPageNo="+pageNo+"'><span aria-hidden='true'>»</span></a></li>&nbsp;";
		}
		
		pageBar += "</li></ul></nav>";
		
		request.setAttribute("pageBar", pageBar);
		
		request.setAttribute("productList", productList);
		
		request.setAttribute("categoryInfo", categoryInfo);
		request.setAttribute("subcategoryList", subcategoryList);
		request.setAttribute("fk_category_num", fk_category_num);
		request.setAttribute("fk_subcategory_num", fk_subcategory_num);
		request.setAttribute("optionSelect", optionSelect);
		
		super.setViewPage("/WEB-INF/main/productList.jsp");
		
		
	}

}
