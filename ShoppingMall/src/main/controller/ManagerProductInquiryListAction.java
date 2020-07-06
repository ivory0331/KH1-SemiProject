package main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import main.model.IndexDAO;
import main.model.InterIndexDAO;
import main.model.OneInquiryVO;
import main.model.ProductInquiryVO;
import member.model.MemberVO;
import my.util.MyUtil;

public class ManagerProductInquiryListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(loginuser== null || loginuser.getStatus()!=2) {
			String message = "관리자가 아닌 사용자는 접속할 수 없습니다.";
			String loc = request.getContextPath()+"/index.do";
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		
		String goBackURL = MyUtil.getCurrentURL(request);
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		String sizePerPage = "15";
		if(currentShowPageNo==null) { currentShowPageNo="1"; }
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("currentShowPageNo", currentShowPageNo);
		paraMap.put("sizePerPage", sizePerPage);
		
		String searchCategory = request.getParameter("searchCategory");
		String searchSubcategory = request.getParameter("searchSubcategory");
	   	String searchWord = request.getParameter("searchWord");
	   	String searchType = request.getParameter("searchType");
	   	
		if(searchWord !=null && !searchWord.trim().isEmpty()) {
	   		paraMap.put("searchWord", searchWord);
	   		paraMap.put("searchType", searchType);
	    }
		
		if(!"0".equals(searchCategory) && searchCategory != null) {
			paraMap.put("searchCategory", searchCategory);
		}
		
		if(!"0".equals(searchSubcategory) && searchSubcategory != null) {
			paraMap.put("searchSubcategory", searchSubcategory);
		}
	   	
		InterIndexDAO dao = new IndexDAO();
		List<ProductInquiryVO> inquiryList = dao.allProductInquirySelect(paraMap);
		List<Map<String,String>> categoryList = dao.productInquiryCategroySelect();
		List<Map<String,String>> subCategoryList = null;
		
		if(searchCategory!=null && !"0".equals(searchCategory)) {
			subCategoryList = dao.productInquirySubcategroySelect(searchCategory);
		}
		
		// 총페이지갯수 알아오기(select)	 
	   	 int totalPage = dao.getTotalPageProductInquiry(paraMap);
	   	 
	   	 
	   	 int pageNo = 1; // 페이지바의 첫 번째	    	 
	   	 
	   	 int loop = 1; // 페이지 순서 증가 1 2 3 ...
	   	 
	   	 int blockSize = 10; // 페이지바 크기
	   	 
	   	 
	   	 // pageNo 구하기
	   	 pageNo = ((Integer.parseInt(currentShowPageNo)-1)/blockSize)*blockSize+1;	    	 
	   	 
	   	 String pageBar="";	  
	   	 
	   	if(searchType==null) { //널이면 주소에 글자 'null'로 들어가기 때문에 공백 설정을 해줘야함
		      searchWord="";
		      searchType="";
		      searchCategory="0";
	   	}
	   	 // [이전]
	   	 if(pageNo!=1) {
	   		 pageBar += "&nbsp;<a href='"+request.getContextPath()+"/manager/managerProductInquiryList.do?currentShowPageNo="+(pageNo-1)+"&searchWord="+searchWord+"&searchType="+searchType+"&searchCategory="+searchCategory+"'>[이전]</a>&nbsp;";
	   	 }
	   	 
	   	 // 페이지바
	   	 while(!(loop > blockSize || pageNo > totalPage)) {
	  		  
		   		  if(pageNo == Integer.parseInt(currentShowPageNo)) {
		   			  pageBar += "&nbsp;<span style='color: red; padding: 2px 4px'>" + pageNo + "</span>&nbsp;";			  
		   		  } else {	
		   			  pageBar += "&nbsp;<a href='"+request.getContextPath()+"/manager/managerProductInquiryList.do?currentShowPageNo="+pageNo+"&searchWord="+searchWord+"&searchType="+searchType+"&searchCategory="+searchCategory+"'>"+pageNo+"</a>&nbsp;";
		   		  }
	
		   		  pageNo++;	// 1 2 3 4 5... (pageNo이 1이라면).... 40 41 42
		   		  loop++;	// 1 2 3 4 5 6 7 8 9 10
	  		  
	  	     }
	   	 
	   	 // [다음]
	   	 if(!(pageNo > totalPage)) {
		    	 pageBar += "&nbsp;<a href='"+request.getContextPath()+"/manager/managerProductInquiryList.do?currentShowPageNo="+pageNo+"&searchWord="+searchWord+"&searchType="+searchType+"&searchCategory="+searchCategory+"'>[다음]</a>&nbsp;";
	   	 }
		
		
		System.out.println("pageBar"+pageBar);
		
		request.setAttribute("inquiryList", inquiryList);
		request.setAttribute("categoryList", categoryList);
		request.setAttribute("searchType", searchType);
		request.setAttribute("searchWord", searchWord);
		request.setAttribute("pageBar", pageBar);
		
		if(searchSubcategory!=null && !"0".equals(searchSubcategory)) {
			request.setAttribute("searchSubcategory", searchSubcategory);
		}
		
		if(searchCategory!=null && !"0".equals(searchCategory)) {
			request.setAttribute("searchCategory", searchCategory);
			request.setAttribute("subcategoryList", subCategoryList);
			request.setAttribute("searchSubcategory", searchSubcategory);
			
		}
		
		super.setViewPage("/WEB-INF/manager/managerProductInquiry.jsp");
		
	}

}
