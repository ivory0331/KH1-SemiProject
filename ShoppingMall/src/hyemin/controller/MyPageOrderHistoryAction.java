package hyemin.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import hyemin.model.InterOrderDAO;
import hyemin.model.OrderDAO;
import main.model.OrderHistoryVO;
import member.model.MemberVO;


public class MyPageOrderHistoryAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {		
		
		boolean isLogIn = super.checkLogin(request);
		
		if(!isLogIn) {
			// 로그인을 하지 않았을 경우
			
			String loc = request.getContextPath()+"/member/login.do";
			
			request.setAttribute("message", "로그인하셔야 본 서비스를 이용하실 수 있습니다.");
			request.setAttribute("loc", loc);
			
			//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		else {
			// 로그인 했고 자신의 회원번호(member_num)를 사용하려는 경우
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			InterOrderDAO orderdao = new OrderDAO();			
			
			// 기간의 옵션 값 구하기
			int option = orderdao.termOption();
			request.setAttribute("option", option);
			
			// *** 페이징처리를 안 한, 특정 회원의 모든 주문내역 보여주기 *** //
		//	List<OrderHistoryVO> orderHistoryList = orderdao.selectOneMemberAllOrder(loginuser.getMember_num());

			
			// *** 페이징처리를 한, 특정 회원의 모든 주문내역 보여주기 *** //
			String currentShowPageNo = request.getParameter("currentShowPageNo");

			String sizePerPage = request.getParameter("sizePerPage");
			
			String term = request.getParameter("term");
			
			if(currentShowPageNo == null)
				currentShowPageNo = "1";
			
			if(sizePerPage == null)
				sizePerPage = "3";	
			
			if(term == null || term.trim().isEmpty() ||
				!("all".equals(term) || (Integer.toString(option)).equals(term)  || (Integer.toString(option-1)).equals(term)  || (Integer.toString(option-2)).equals(term) ))
				term = "all";
		
			int member_num = loginuser.getMember_num();
			
			HashMap<String,String> paraMap = new HashMap<>();			
			paraMap.put("currentShowPageNo", currentShowPageNo);
			paraMap.put("sizePerPage", sizePerPage);
			paraMap.put("term", term);			
			
			///////////////////////////////////////////////////////////////	
			
			List<OrderHistoryVO> orderHistoryList = orderdao.selectPagingOneMemberAllOrder(paraMap, member_num, option);
			
			request.setAttribute("orderHistoryList", orderHistoryList);
			request.setAttribute("sizePerPage", sizePerPage);
			
			// 페이징처리를 위한 특정 회원의 모든 주문내역에 대한 총페이지갯수 알아오기(select)
			int totalPage = orderdao.getPossibleReviewTotalPage(paraMap, member_num, option);
			
			int pageNo = 1;
			int blockSize = 10;
			int loop = 1;
			
			pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize )*blockSize + 1;
			
		    String pageBar = "<nav aria-label='Page navigation'>"
			                  + "<ul class='pagination'>"
			                  + "<li class=disabled>";
			
		    // *** [이전] 만들기 *** //
 			if( pageNo != 1 ) {
 				pageBar += "&nbsp;<a aria-label='Previous' href='myPageOrderHistory.do?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&term="+term+"'><span aria-hidden='true'>«</span></a></li>&nbsp;";
 			}
 			
 			while( !(loop > blockSize || pageNo > totalPage) ) {
	
				if(pageNo == Integer.parseInt(currentShowPageNo) ) {
					pageBar += "&nbsp;<li class='active'><span style='color:#5F0080; border: solid 0.5px #e6e6e6; background-color:#f2f2f2;'>"+pageNo+"</span></li>&nbsp;";	
				}
				else {
					pageBar += "&nbsp;<li><a href='myPageOrderHistory.do?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&term="+term+"'><span style='color:#333;'>"+pageNo+"</span></a></li>&nbsp;";
				}
				
				pageNo++;
				loop++;				
			}
			
			// *** [다음] 만들기 *** //
			if( !(pageNo > totalPage) ) {
				pageBar += "&nbsp;<li><a aria-label='Next' href='myPageOrderHistory.do?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&term="+term+"'><span aria-hidden='true'>»</span></a></li>&nbsp;";
			}
			
			pageBar += "</li></ul></nav>";
			
			request.setAttribute("pageBar", pageBar);
			
			request.setAttribute("term", term);
			
		//	super.setRedirect(false);	
			super.setViewPage("/WEB-INF/member/myPageOrderHistory.jsp");
		}

	}

}
