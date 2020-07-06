package service.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import main.model.NoticeVO;
import my.util.MyUtil;
import service.model.InterServiceDAO;
import service.model.ServiceDAO;

public class BoardListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		InterServiceDAO dao = new ServiceDAO();
		
		String goBackURL = MyUtil.getCurrentURL(request);
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		String sizePerPage = "15";
		if(currentShowPageNo==null) { currentShowPageNo="1"; }
		
		HashMap<String, String> paraMap = new HashMap<>();
    	 
    	 
    	paraMap.put("currentShowPageNo", currentShowPageNo);
    	paraMap.put("sizePerPage", sizePerPage);
		
    	// 검색	    	 
	   	String[] searchType = request.getParameterValues("searchType");
	   	String searchWord = request.getParameter("searchWord");
	   	if(searchType!=null) System.out.println("searchType:"+String.join(",",searchType));
	   	
	   	String searchType1 = "";
	   	String searchType2 = "";
	   	
	   	System.out.println("액션 searchType : "+searchType);
	   	System.out.println("액션 searchWord : "+searchWord);
	   	System.out.println("액션 sizePerPage : "+sizePerPage);
	   	
	   	if(searchWord !=null && !searchWord.trim().isEmpty()) {
	   		if(searchType.length>1) 
	   			paraMap.put("searchType", String.join(",", searchType));
	   		else 
	   			paraMap.put("searchType", searchType[0]);
	   		paraMap.put("searchWord", searchWord);
	   		for(int i=0; i<searchType.length; i++) {
	   			if(i==0) searchType1=searchType[i];
	   			else searchType2 = searchType[i];
	   		}
	    }
    	
	   	
	   	List<NoticeVO> noticeList = dao.selectPagingMember(paraMap);
   	 
   	 
	   	request.setAttribute("noticeList", noticeList);
	   	request.setAttribute("sizePerPage", sizePerPage);
    	
	    // 총페이지갯수 알아오기(select)	 
	   	 int totalPage = dao.getTotalPage(paraMap);
	   	 
	   	 
	   	 
	   	 int pageNo = 1; // 페이지바의 첫 번째	    	 
	   	 
	   	 int loop = 1; // 페이지 순서 증가 1 2 3 ...
	   	 
	   	 int blockSize = 10; // 페이지바 크기
	   	 
	   	 
	   	 // pageNo 구하기
	   	 pageNo = ((Integer.parseInt(currentShowPageNo)-1)/blockSize)*blockSize+1;	    	 
	   	 
	   	String pageBar = "<nav aria-label='Page navigation'>"
				   + "<ul class='pagination'>"
				   + "<li class=disabled>";    	 
	   	 
	   	 // [이전]
	   	 if(pageNo!=1) {
	   		 pageBar += "&nbsp;<a aria-label='Previous' href='"+request.getContextPath()+"/service/board.do?currentShowPageNo="+(pageNo-1)+"&searchType="+searchType1+"&searchType="+searchType2+"&searchWord="+searchWord+"'><span aria-hidden='true'>«</span></a></li>&nbsp;";
	   	 }
	   	 
	   	 // 페이지바
	   	 while(!(loop > blockSize || pageNo > totalPage)) {
	  		  
		   		  if(pageNo == Integer.parseInt(currentShowPageNo)) {
		   			  pageBar += "&nbsp;<li class='active'><span style='color:#5F0080; border: solid 0.5px #e6e6e6; background-color:#f2f2f2;'>"+pageNo+"</span></li>&nbsp;";			  
		   		  } else {	
		   			  if(searchType==null) { //널이면 주소에 글자 'null'로 들어가기 때문에 공백 설정을 해줘야함
					      searchType1="";
					      searchType2="";
		   				  searchWord="";
		   			  }
		   			  pageBar += "&nbsp;<li><a href='"+request.getContextPath()+"/service/board.do?currentShowPageNo="+pageNo+"&searchType="+searchType1+"&searchType="+searchType2+"&searchWord="+searchWord+"'><span style='color:#333;'>"+pageNo+"</span></a></li>&nbsp";
		   		  }
	
		   		  pageNo++;	// 1 2 3 4 5... (pageNo이 1이라면).... 40 41 42
		   		  loop++;	// 1 2 3 4 5 6 7 8 9 10
	  		  
	  	     }
	   	 
	   	 // [다음]
	   	 if(!(pageNo > totalPage)) {
		    	 pageBar += "&nbsp;<li><a aria-label='Next' href='"+request.getContextPath()+"/service/board.do?currentShowPageNo="+pageNo+"&searchType="+searchType1+"&searchType="+searchType2+"&searchWord="+searchWord+"'><span aria-hidden='true'>»</span></a></li>&nbsp;";
	   	 }
	   	 
	   	pageBar += "</li></ul></nav>";
	   	 
	   	 request.setAttribute("pageBar", pageBar);	  
	   	 request.setAttribute("searchWord", searchWord);	    	 
	   	 request.setAttribute("searchType", searchType);
	   	 
	   	 // 리스트 경로 저장
	   	 HttpSession session = request.getSession();
	   	 session.setAttribute("serviceGoBackURL", goBackURL);
	   	
	   	
		super.setViewPage("/WEB-INF/service/serviceCenterBoardList.jsp");
	}

}
