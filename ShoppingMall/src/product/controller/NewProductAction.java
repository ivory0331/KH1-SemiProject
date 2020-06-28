package product.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model.*;

public class NewProductAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InterProductDAO productdao = new ProductDAO();
		
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		if(currentShowPageNo == null)
			currentShowPageNo = "1";
		
		HashMap<String,String> paraMap = new HashMap<>();
		paraMap.put("currentShowPageNo", currentShowPageNo);
		
		List<ProductVO> newprodList = productdao.selectNewList(paraMap);
		
		int totalPage = productdao.getTotalpage(paraMap);
		int pageNo =1;
		int blockSize = 10;
		int loop = 1;
		
		pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1) / blockSize ) * blockSize + 1;
		
		
		String pageBar = "";
		
		// *** [이전] 만들기 *** //
		if( pageNo != 1 ) {
			pageBar += "&nbsp;<a href='newProduct.do?currentShowPageNo="+(pageNo-1)+"'>[이전]</a>&nbsp;";
		}
				
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == Integer.parseInt(currentShowPageNo)) {
				pageBar += "&nbsp;<span style='color: red; border: solid 1px gray; padding: 2px 4px;'>"+pageNo+"</span>&nbsp;";
			}
			else {
				pageBar += "&nbsp;<a href='newProduct.do?currentShowPageNo="+pageNo+"'>"+pageNo+"</a>&nbsp;";
			}		
			pageNo++; // 1 2 3 4 5 6 7 8 9 10 11 12 13 14 ... 40 41 42
			loop++;	  // 1 2 3 4 5 6 7 8 9 10
		}

		
		// *** [다음] 만들기 *** //
		if( !(pageNo > totalPage) ) {
			pageBar += "&nbsp;<a href='newProduct.do?currentShowPageNo="+pageNo+"'>[다음]</a>&nbsp;";
		}
		
		request.setAttribute("newprodList", newprodList);
		request.setAttribute("pageBar", pageBar);
		
		super.setViewPage("/WEB-INF/main/newProdList.jsp");
		
	}

}
