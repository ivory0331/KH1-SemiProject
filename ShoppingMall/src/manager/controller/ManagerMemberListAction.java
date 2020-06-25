package manager.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;

public class ManagerMemberListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		
		 InterMemberDAO memberdao = new MemberDAO();
    	 
	    	 
    	 // 페이징 처리
    	 String currentShowPageNo = request.getParameter("currentShowPageNo");
    	 String sizePerPage = request.getParameter("sizePerPage"); // 10 5 3 null(select는 change 이벤트로 안 하면 값이 null이다)
    	 
    	 	    	 
    	 if(currentShowPageNo==null) { currentShowPageNo="1"; }	    	 
    	 if(sizePerPage==null || !("3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage)) ) { sizePerPage="10"; }
    	 

    	 HashMap<String, String> paraMap = new HashMap<>();
    	 
    	 
    	 paraMap.put("currentShowPageNo", currentShowPageNo);
    	 paraMap.put("sizePerPage", sizePerPage);
    	 
    	 
    	 // 검색	    	 
    	 String searchType = request.getParameter("searchType");
    	 String searchWord = request.getParameter("searchWord");
    	 
    	 
    	 System.out.println("액션 searchType : "+searchType);
    	 System.out.println("액션 searchWord : "+searchWord);
    	 System.out.println("액션 sizePerPage : "+sizePerPage);
    	 
    	 if(searchWord !=null && !searchWord.trim().isEmpty()) {
    		 paraMap.put("searchType", searchType);
    		 paraMap.put("searchWord", searchWord);
    	 }
    	 
	//     List<MemberVO> memberList = memberdao.selectAllMember(); //전체 회원 
    	 List<MemberVO> memberAllList = memberdao.selectAllMember(); //전체 회원 

	     List<MemberVO> memberList = memberdao.selectPagingMember(paraMap);
	     
    	 
    	 request.setAttribute("all", memberAllList.size());
    	 request.setAttribute("memberList", memberList);
    	 request.setAttribute("sizePerPage", sizePerPage);     	    	 
    	 
    	 
    	 
		 // 총페이지갯수 알아오기(select)	 
    	 int totalPage = memberdao.getTotalPage(paraMap);
    	 
    	 
    	 
    	 int pageNo = 1; // 페이지바의 첫 번째	    	 
    	 
    	 int loop = 1; // 페이지 순서 증가 1 2 3 ...
    	 
    	 int blockSize = 10; // 페이지바 크기
    	 
    	 
    	 // pageNo 구하기
    	 pageNo = ((Integer.parseInt(currentShowPageNo)-1)/blockSize)*blockSize+1;	    	 
    	 
    	 String pageBar="";	    	 
    	 
    	 // [이전]
    	 if(pageNo!=1) {
    		 pageBar += "&nbsp;<a href='managerMemberList.do?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[이전]</a>&nbsp;";
    	 }
    	 
    	 // 페이지바
    	 while(!(loop > blockSize || pageNo > totalPage)) {
   		  
	   		  if(pageNo == Integer.parseInt(currentShowPageNo)) {
	   			  pageBar += "&nbsp;<span style='color: red; padding: 2px 4px'>" + pageNo + "</span>&nbsp;";			  
	   		  } else {	
	   			  if(searchType==null) { //널이면 주소에 글자 'null'로 들어가기 때문에 공백 설정을 해줘야함
	   				  searchType="";
	   				  searchWord="";
	   			  }
	   			  pageBar += "&nbsp;<a href='managerMemberList.do?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a>&nbsp;";
	   		  }

	   		  pageNo++;	// 1 2 3 4 5... (pageNo이 1이라면).... 40 41 42
	   		  loop++;	// 1 2 3 4 5 6 7 8 9 10
   		  
   	     }
    	 
    	 // [다음]
    	 if(!(pageNo > totalPage)) {
	    	 pageBar += "&nbsp;<a href='managerMemberList.do?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>[다음]</a>&nbsp;";
    	 }
    	 
    	 
    	 request.setAttribute("pageBar", pageBar);	  
    	 request.setAttribute("searchWord", searchWord);	    	 
    	 request.setAttribute("searchType", searchType);	 
	
	
         super.setViewPage("/WEB-INF/manager/managerMemberList.jsp");

        
	}

}
