
package service.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import main.model.FAQtableVO;

import service.model.InterServiceDAO;
import service.model.ServiceDAO;

public class QboardListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	 
		InterServiceDAO dao = new ServiceDAO();


		String currentShowPageNo = request.getParameter("currentShowPageNo");
		String sizePerPage = "15";
		String category = request.getParameter("favoriteQ_Category");
		System.out.println(category);
		if(currentShowPageNo==null) { currentShowPageNo="1"; }
		
		HashMap<String, String> paraMap = new HashMap<>();
    	 
    	 
    	paraMap.put("currentShowPageNo", currentShowPageNo);
    	paraMap.put("sizePerPage", sizePerPage);
    	if(category != null && !("0".equals(category))) {paraMap.put("category", category);}
		
    	// 검색	    	 
	   	String searchWord = request.getParameter("searchWord");
	   
	   	
	   	if(searchWord !=null && !searchWord.trim().isEmpty()) {
	   		paraMap.put("searchWord", searchWord);
	    }
    	
	   	
	   	List<FAQtableVO> faqList = dao.selectFAQ(paraMap);
   	 
   	 
	   	request.setAttribute("FAQList", faqList);
	   	request.setAttribute("sizePerPage", sizePerPage);
    	
	    // 총페이지갯수 알아오기(select)	 
	   	 int totalPage = dao.getTotalPageFAQ(paraMap);
	   	 
	   	 List<Map<String,String>> categoryList = dao.getFAQcategory();
	   	 
	   	 
	   	 int pageNo = 1; // 페이지바의 첫 번째	    	 
	   	 
	   	 int loop = 1; // 페이지 순서 증가 1 2 3 ...
	   	 
	   	 int blockSize = 10; // 페이지바 크기
	   	 
	   	 
	   	 // pageNo 구하기
	   	 pageNo = ((Integer.parseInt(currentShowPageNo)-1)/blockSize)*blockSize+1;	    	 
	   	 
	   	 String pageBar = "<nav aria-label='Page navigation'>"    	 
	   	 				+ "<ul class='pagination'>"
	   	 				+ "<li class=disabled>";
	   	 if(pageNo!=1) {
	   		 pageBar += "&nbsp;<a aria-label='Previous' href='"+request.getContextPath()+"/service/FAQ.do?currentShowPageNo="+(pageNo-1)+"&searchWord="+searchWord+"&category="+category+"'><span aria-hidden='true'>«</span></a></li>&nbsp;";
	   	 }
	   	 
	   	 // 페이지바
	   	 while(!(loop > blockSize || pageNo > totalPage)) {
	  		  
		   		  if(pageNo == Integer.parseInt(currentShowPageNo)) {
		   			  pageBar += "&nbsp;<li class='active'><span style='color:#5F0080; border: solid 0.5px #e6e6e6; background-color:#f2f2f2;'>"+pageNo+"</span></li>&nbsp;";			  
		   		  } else {	
		   			  if(category==null) { //널이면 주소에 글자 'null'로 들어가기 때문에 공백 설정을 해줘야함
		   				  searchWord="";
		   			  }
		   			  pageBar += "&nbsp;<li><a href='"+request.getContextPath()+"/service/FAQ.do?currentShowPageNo="+pageNo+"&searchWord="+searchWord+"&category="+category+"'><span style='color:#333;'>"+pageNo+"</span></a></li>&nbsp;";
		   		  }
	
		   		  pageNo++;	// 1 2 3 4 5... (pageNo이 1이라면).... 40 41 42
		   		  loop++;	// 1 2 3 4 5 6 7 8 9 10
	  		  
	  	     }
	   	 
	   	 // [다음]
	   	 if(!(pageNo > totalPage)) {
		    	 pageBar += "&nbsp;<li><a aria-label='Next' href='"+request.getContextPath()+"/service/FAQ.do?currentShowPageNo="+pageNo+"&searchWord="+searchWord+"&category="+category+"'>»</span></a></li>&nbsp;";
	   	 }
	   	 
	   	pageBar += "</li></ul></nav>";
	   	 
	   	 request.setAttribute("pageBar", pageBar);	  
	   	 request.setAttribute("searchWord", searchWord);	    	 
	   	 request.setAttribute("category", category);
	   	 request.setAttribute("FAQList", faqList);
	   	 request.setAttribute("categoryList", categoryList);
		
		super.setViewPage("/WEB-INF/service/serviceCenterQboardList.jsp");

	}
}

