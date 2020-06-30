package manager.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import manager.model.*;
import product.model.ProductVO;


// 진하
public class ManagerProductListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
	    
   	 	InterProductDAO productDAO = new ProductDAO();
   	 	
		
   	 	String currentShowPageNo = request.getParameter("currentShowPageNo");
   	 	String sizePerPage = request.getParameter("sizePerPage"); // 10 5 3 null(select는 change 이벤트로 안 하면 값이 null이다)

   	 	//첫 페이지 설정
   	 	if(currentShowPageNo==null) { currentShowPageNo="1"; }	 
   	 	if(sizePerPage==null || !("3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage)) ) { sizePerPage="10"; }
   	 	
   	 	HashMap<String, String> paraMap = new HashMap<>();

	    paraMap.put("currentShowPageNo", currentShowPageNo);
	    paraMap.put("sizePerPage", sizePerPage);	    
	    
	    
	    // 검색	    	 
	   	String fk_category_num = request.getParameter("fk_category_num");
	   	String fk_subcategory_num = request.getParameter("fk_subcategory_num");
	   	String searchWord = request.getParameter("searchWord");
	   	
	   	
	   	
	   	if(fk_category_num ==null) {
	   		fk_category_num = "0";
	    }
	    paraMap.put("fk_category_num", fk_category_num);

	   	
	   	if(fk_subcategory_num ==null) {
	   		fk_subcategory_num = "0";
	    }
	    paraMap.put("fk_subcategory_num", fk_subcategory_num);



	    if(searchWord !=null && !searchWord.trim().isEmpty()) {
		    paraMap.put("searchWord", searchWord);
	    }
	    
	    System.out.println(fk_category_num);
	   	System.out.println(fk_subcategory_num);
	   	System.out.println(searchWord);

	    
	    List<ProductVO> productList = productDAO.selectPagingProduct(paraMap);
		
		request.setAttribute("productList", productList);
		request.setAttribute("sizePerPage", sizePerPage);     	    	
		 
	    
	    int totalPage = productDAO.getTotalPage(paraMap);
   	 
	    int pageNo = 1; // 페이지바의 첫 번째	    	 
   	 
	    int loop = 1; // 페이지 순서 증가 1 2 3 ...
	   	 
	    int blockSize = 10; // 페이지바 크기
	    
	    
	    pageNo = ((Integer.parseInt(currentShowPageNo)-1)/blockSize)*blockSize+1;	    	 
	   	 
	    String pageBar="";	  	    
	   	 
	    // [이전]
	    if(pageNo!=1) {
	    	pageBar += "&nbsp;<a href='managerProductList.do?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&fk_category_num="+fk_category_num+"&fk_subcategory_num="+fk_subcategory_num+"&searchWord="+searchWord+"'>[이전]</a>&nbsp;";
	   	}
	   	 
	   	// 페이지바
	   	while(!(loop > blockSize || pageNo > totalPage)) {
	  		  
	   		if(pageNo == Integer.parseInt(currentShowPageNo)) {
	   			  pageBar += "&nbsp;<span style='color: red; padding: 2px 4px'>" + pageNo + "</span>&nbsp;";			  
   		    } else {
   		    	  if(searchWord==null) {
   		    		searchWord="";
   		    	  }
   		    	  pageBar += "&nbsp;<a href='managerProductList.do?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&fk_category_num="+fk_category_num+"&fk_subcategory_num="+fk_subcategory_num+"&searchWord="+searchWord+"'>"+pageNo+"</a>&nbsp;";
	   		}
	   		pageNo++;	
	   		loop++;	  		  
  	     }
	   	
	   	 
	   	 // [다음]
	   	 if(!(pageNo > totalPage)) {
		    	 pageBar += "&nbsp;<a href='managerProductList.do?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&fk_category_num="+fk_category_num+"&fk_subcategory_num="+fk_subcategory_num+"&searchWord="+searchWord+"'>[다음]</a>&nbsp;";
	   	 }
	   	 
		 super.getCategoryList(request);

	   	 request.setAttribute("pageBar", pageBar);	  
	   	 request.setAttribute("searchWord", searchWord);	    	 

	   	
	     super.setViewPage("/WEB-INF/manager/managerProductList.jsp");
	        
		    
	    
	    
	    
	}

}
