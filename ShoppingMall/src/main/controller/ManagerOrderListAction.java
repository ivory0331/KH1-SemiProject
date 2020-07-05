package main.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import main.model.FAQtableVO;
import main.model.IndexDAO;
import main.model.InterIndexDAO;
import main.model.OrderHistoryVO;
import main.model.OrderVO;
import member.model.MemberVO;

public class ManagerOrderListAction extends AbstractController {

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
		
		InterIndexDAO dao = new IndexDAO();


		String currentShowPageNo = request.getParameter("currentShowPageNo");
		String sizePerPage = "15";
		String orderState = request.getParameter("orderState");
		System.out.println(orderState);
		if(currentShowPageNo==null) { currentShowPageNo="1"; }
		
		HashMap<String, String> paraMap = new HashMap<>();
    	 
    	 
    	paraMap.put("currentShowPageNo", currentShowPageNo);
    	paraMap.put("sizePerPage", sizePerPage);
    	if(orderState != null && !("-1".equals(orderState))) {paraMap.put("orderState", orderState);}
		
    	// 검색	    	 
	   	String searchWord = request.getParameter("searchWord");
	    String searchType = request.getParameter("searchType");
	   	
	   	if(searchWord !=null && !searchWord.trim().isEmpty()) {
	   		paraMap.put("searchWord", searchWord);
	   		paraMap.put("searchType", searchType);
	    }
		
	   	List<OrderVO> orderList = dao.selectOrder(paraMap);
		
	   	
	   	// 총페이지갯수 알아오기(select)	 
	   	 int totalPage = dao.getTotalPageOrder(paraMap);
	   	
	   	List<Map<String,String>> stateList = dao.getOrderStateList();
	   	
	    int pageNo = 1; // 페이지바의 첫 번째	    	 
	   	 
	   	 int loop = 1; // 페이지 순서 증가 1 2 3 ...
	   	 
	   	 int blockSize = 10; // 페이지바 크기
	   	 
	   	 
	   	 // pageNo 구하기
	   	 pageNo = ((Integer.parseInt(currentShowPageNo)-1)/blockSize)*blockSize+1;	    	 
	   	 
	   	 String pageBar="";	    	 
	   	 
	   	 // [이전]
	   	 if(pageNo!=1) {
	   		 pageBar += "&nbsp;<a href='"+request.getContextPath()+"/manager/managerOrderList.do?currentShowPageNo="+(pageNo-1)+"&searchWord="+searchWord+"&orderState="+orderState+"'>[이전]</a>&nbsp;";
	   	 }
	   	 
	   	 // 페이지바
	   	 while(!(loop > blockSize || pageNo > totalPage)) {
	  		  
		   		  if(pageNo == Integer.parseInt(currentShowPageNo)) {
		   			  pageBar += "&nbsp;<span style='color: red; padding: 2px 4px'>" + pageNo + "</span>&nbsp;";			  
		   		  } else {	
		   			  pageBar += "&nbsp;<a href='"+request.getContextPath()+"/manager/managerOrderList.do?currentShowPageNo="+pageNo+"&searchWord="+searchWord+"&orderState="+orderState+"'>"+pageNo+"</a>&nbsp;";
		   		  }
	
		   		  pageNo++;	// 1 2 3 4 5... (pageNo이 1이라면).... 40 41 42
		   		  loop++;	// 1 2 3 4 5 6 7 8 9 10
	  		  
	  	     }
	   	 
	   	 // [다음]
	   	 if(!(pageNo > totalPage)) {
		    	 pageBar += "&nbsp;<a href='"+request.getContextPath()+"/service/FAQ.do?currentShowPageNo="+pageNo+"&searchWord="+searchWord+"&orderState="+orderState+"'>[다음]</a>&nbsp;";
	   	 }
	   	
	   	request.setAttribute("orderList", orderList);
	   	request.setAttribute("sizePerPage", sizePerPage);
	   	request.setAttribute("stateList", stateList);
	   	request.setAttribute("searchWord", searchWord);
	   	request.setAttribute("pageBar", pageBar);
	   	request.setAttribute("searchType", searchType);
	   	request.setAttribute("orderState", orderState);
	   	
		super.setViewPage("/WEB-INF/manager/managerOrderList.jsp");
		
	}

}
