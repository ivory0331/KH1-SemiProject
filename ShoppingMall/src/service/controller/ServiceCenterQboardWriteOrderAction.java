package service.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import common.controller.AbstractController;
import main.model.OrderHistoryVO;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;


public class ServiceCenterQboardWriteOrderAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		boolean isLogIn = super.checkLogin(request);

		if (!isLogIn) {

			request.setAttribute("message", "로그인 후 이용가능합니다");
			request.setAttribute("loc", request.getContextPath() + "/member/login.do");

			super.setViewPage("/WEB-INF/msg.jsp");
		} else {

			// 로그인 했고 자신의 회원번호(member_num)를 사용하려는 경우
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

			InterMemberDAO orderdao = new MemberDAO();

			String currentShowPageNo = request.getParameter("currentShowPageNo");
		    if(currentShowPageNo == null)
		        currentShowPageNo = "1";
		    
		    HashMap<String,String> paraMap = new HashMap<>();
		    paraMap.put("currentShowPageNo", currentShowPageNo);
		    paraMap.put("loginuserGetMemberNum", String.valueOf(loginuser.getMember_num()));
		    
			// *** 페이징처리 한, 특정 회원의 모든 주문내역 보여주기 *** //
			List<OrderHistoryVO> orderHistoryList = orderdao.selectOneMemberOrderList(paraMap);

			int totalPage = orderdao.getTotalpage(paraMap);
		    int pageNo = 1;
		    int blockSize = 5;
		    int loop = 1; 
		      
		    pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1) / blockSize ) * blockSize + 1;
		      
		      
		      String pageBar = "<nav aria-label='Page navigation'>"
		                  + "<ul class='pagination'>"
		                  + "<li class=disabled>";
		      
		      // *** [이전] 만들기 *** //
		      
		      pageBar += "&nbsp;<a aria-label='Previous' href='serviceCenterMyQboardWrite.do?currentShowPageNo="+(pageNo-1)+"'><span aria-hidden='true'>«</span></a></li>&nbsp;";
		      
		            
		      while( !(loop > blockSize || pageNo > totalPage) ) {
		         
		         if(pageNo == Integer.parseInt(currentShowPageNo)) {
		            pageBar += "&nbsp;<li class='active'><span style='color:#5F0080; border: solid 0.5px #e6e6e6; background-color:#f2f2f2;'>"+pageNo+"</span></li>&nbsp;";
		         }
		         else {
		            pageBar += "&nbsp;<li><a href='serviceCenterMyQboardWrite.do?currentShowPageNo="+pageNo+"'><span style='color:#333;'>"+pageNo+"</span></a></li>&nbsp;";
		         }      
		         pageNo++; // 1 2 3 4 5 6 7 8 9 10 11 12 13 14 ... 40 41 42
		         loop++;     // 1 2 3 4 5 6 7 8 9 10
		      }

		      
		      // *** [다음] 만들기 *** //
		      if( !(pageNo > totalPage)) {
			    	  pageBar += "&nbsp;<li><a aria-label='Next' href='serviceCenterMyQboardWrite.do?currentShowPageNo="+pageNo+"'><span aria-hidden='true'>»</span></a></li>&nbsp;";
			      }
		      else {
		    	  pageBar += "&nbsp;<li><a style='pointer-events : none; color:#777;' aria-label='Next' href='serviceCenterMyQboardWrite.do?currentShowPageNo="+pageNo+"'><span aria-hidden='true'>»</span></a></li>&nbsp;";   
		      }
		      pageBar += "</li></ul></nav>";
		      
		      request.setAttribute("pageBar", pageBar);		      
		      request.setAttribute("orderHistoryList", orderHistoryList);

			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/service/serviceCenterQboardWriteOrder.jsp");

		}

	}

}
