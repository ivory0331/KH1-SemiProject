package product.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.*;

public class SelectOptionAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InterProductDAO pdao = new ProductDAO();
		
		String optionSelect = request.getParameter("optionSelect");
		String cate = request.getParameter("cate"); // fk_category_num
		String subcate = request.getParameter("subcate"); // fk_subcategory_num
		
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		if(currentShowPageNo == null)
			currentShowPageNo = "1";
		
		HashMap<String,String> paraMap = new HashMap<>();
		paraMap.put("currentShowPageNo", currentShowPageNo);
		paraMap.put("fk_category_num", cate);
		paraMap.put("fk_subcategory_num", subcate);
		paraMap.put("optionSelect", optionSelect);
		
		String categoryInfo = pdao.categoryInfo(cate);
		List<ProductVO> subcategoryList = pdao.subcategoryList(cate);
		List<ProductVO> selectOption = pdao.selectOption(paraMap);
		
		int totalPage = pdao.getTotalpage(paraMap);
		int pageNo =1;
		int blockSize = 10;
		int loop = 1;
		
		pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1) / blockSize ) * blockSize + 1;
		
		
		String pageBar = "";
		
		// *** [이전] 만들기 *** //
		if( pageNo != 1 ) {
			if(subcate == null) {
				pageBar += "&nbsp;<a href='productList.do?fk_category_num="+cate+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a>&nbsp;";
			} else
			pageBar += "&nbsp;<a href='productList.do?fk_category_num="+cate+"&fk_subcategory_num="+subcate+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a>&nbsp;";
		}
				
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == Integer.parseInt(currentShowPageNo)) {
				pageBar += "&nbsp;<span style='color: red; border: solid 1px gray; padding: 2px 4px;'>"+pageNo+"</span>&nbsp;";
			}
			else {
				if(subcate == null) {
					pageBar += "&nbsp;<a href='productList.do?fk_category_num="+cate+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a>&nbsp;";
				} else
				pageBar += "&nbsp;<a href='productList.do?fk_category_num="+cate+"&fk_subcategory_num="+subcate+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a>&nbsp;";
			}		
			pageNo++; // 1 2 3 4 5 6 7 8 9 10 11 12 13 14 ... 40 41 42
			loop++;	  // 1 2 3 4 5 6 7 8 9 10
		}

		
		// *** [다음] 만들기 *** //
		if( !(pageNo > totalPage) ) {
			if(subcate == null) {
				pageBar += "&nbsp;<a href='productList.do?fk_category_num="+cate+"&currentShowPageNo="+pageNo+"'>[다음]</a>&nbsp;";
			} else
				pageBar += "&nbsp;<a href='productList.do?fk_category_num="+cate+"&fk_subcategory_num="+subcate+"&currentShowPageNo="+pageNo+"'>[다음]</a>&nbsp;";
		}
		
		request.setAttribute("pageBar", pageBar);

		request.setAttribute("productList", selectOption);

		request.setAttribute("categoryInfo", categoryInfo);
		request.setAttribute("subcategoryList", subcategoryList);
		request.setAttribute("fk_category_num", cate);
		request.setAttribute("fk_subcategory_num", subcate);
		
		
		super.setViewPage("/WEB-INF/main/productList.jsp");
	}

}
