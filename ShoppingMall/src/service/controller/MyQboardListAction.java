package service.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import main.model.IndexDAO;
import main.model.InterIndexDAO;
import main.model.NoticeVO;
import main.model.OneInquiryVO;
import member.model.MemberVO;
import service.model.InterServiceDAO;
import service.model.ServiceDAO;

public class MyQboardListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		InterServiceDAO dao = new ServiceDAO();
		InterIndexDAO idao = new IndexDAO();
		
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser == null) {
			String message = "로그인이 필요한 기능입니다.";
			String loc = request.getContextPath()+"/member/login.do";
			String goBackURL = request.getContextPath()+"/service/MyQue.do";
			
			session.setAttribute("goBackURL", goBackURL);
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		Map<String, Integer> paraMap = new HashMap<String, Integer>();
		
		
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		int sizePerPage = 15;
		if(currentShowPageNo==null) { currentShowPageNo="1"; }
		
		
    	paraMap.put("currentShowPageNo", Integer.parseInt(currentShowPageNo));
    	paraMap.put("sizePerPage", sizePerPage);
		
    	int beforPageNum = Integer.parseInt(currentShowPageNo)-1;
		int type = 1;
		
		paraMap.put("type", type);
		paraMap.put("beforPage", beforPageNum);
		paraMap.put("member_num", loginuser.getMember_num());
		
		int answerSum = idao.answerCall(paraMap);
		System.out.println("지금 페이지까지 답변이 있는 행의 갯수:"+answerSum);
		
		int start = Integer.parseInt(currentShowPageNo)*sizePerPage - (sizePerPage-1) - answerSum;
		int end = start + (sizePerPage-1);
		
		paraMap.put("start", start);
		paraMap.put("end", end);
		
		int answerCount = idao.answerCall(paraMap);
		System.out.println("지금 페이지에서 답변이 있는 행의 갯수:"+answerCount);
		
		paraMap.put("end", end-answerCount);
		
	   	List<OneInquiryVO> oneInquiryList = dao.selectOneInquiry(paraMap);
   	 
	   	
    	
	    // 총페이지갯수 알아오기(select)	 
	   	int totalPage = idao.totalPage(paraMap);
		System.out.println("전체 페이지:"+totalPage);
	   	 
	   	 
	   	 
	   	 int pageNo = 1; // 페이지바의 첫 번째	    	 
	   	 
	   	 int loop = 1; // 페이지 순서 증가 1 2 3 ...
	   	 
	   	 int blockSize = 10; // 페이지바 크기
	   	 
	   	 
	   	 // pageNo 구하기
	   	 pageNo = ((Integer.parseInt(currentShowPageNo)-1)/blockSize)*blockSize+1;	    	 
	   	 
	   	 String pageBar="";	    	 
	   	 
	   	 // [이전]
	   	 if(pageNo!=1) {
	   		 pageBar += "&nbsp;<a href='"+request.getContextPath()+"/service/MyQue.do?currentShowPageNo="+(pageNo-1)+"'>[이전]</a>&nbsp;";
	   	 }
	   	 
	   	 // 페이지바
	   	 while(!(loop > blockSize || pageNo > totalPage)) {
	  		  
		   		  if(pageNo == Integer.parseInt(currentShowPageNo)) {
		   			  pageBar += "&nbsp;<span style='color: red; padding: 2px 4px'>" + pageNo + "</span>&nbsp;";			  
		   		  } else {	
		   			  pageBar += "&nbsp;<a href='"+request.getContextPath()+"/service/MyQue.do?currentShowPageNo="+pageNo+"'>"+pageNo+"</a>&nbsp;";
		   		  }
	
		   		  pageNo++;	// 1 2 3 4 5... (pageNo이 1이라면).... 40 41 42
		   		  loop++;	// 1 2 3 4 5 6 7 8 9 10
	  		  
	  	     }
	   	 
	   	 // [다음]
	   	 if(!(pageNo > totalPage)) {
		    	 pageBar += "&nbsp;<a href='"+request.getContextPath()+"/service/MyQue.do?currentShowPageNo="+pageNo+"'>[다음]</a>&nbsp;";
	   	 }
	   	 
	   	 
	   	 request.setAttribute("pageBar", pageBar);	  
	   	 request.setAttribute("oneInquiryList", oneInquiryList);
	   	 request.setAttribute("sizePerPage", sizePerPage);
		
		
		super.setViewPage("/WEB-INF/service/serviceCenterMyQboardList.jsp");
		
	}

}
