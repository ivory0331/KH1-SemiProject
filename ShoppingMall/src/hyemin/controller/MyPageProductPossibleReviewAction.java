package hyemin.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import hyemin.model.InterReviewDAO;
import hyemin.model.ReviewDAO;
import main.model.OrderProductVO;
import member.model.MemberVO;

public class MyPageProductPossibleReviewAction extends AbstractController {

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
			
			InterReviewDAO rdao = new ReviewDAO();
			
			// *** 페이징처리를 안 한, 특정 회원의 모든 작성가능 후기내역 보여주기 *** //
		//	List<OrderProductVO> possibleReviewList = rdao.selectPossibleReview(loginuser.getMember_num());
			

			// *** 페이징처리를 한, 특정 회원의 모든 작성가능 후기내역 보여주기 *** //
			String currentShowPageNo = request.getParameter("currentShowPageNo");
						
			String sizePerPage = request.getParameter("sizePerPage");
			
			if(currentShowPageNo == null)
				currentShowPageNo = "1";
			
			if(sizePerPage == null)
				sizePerPage = "5";
			
			int member_num = loginuser.getMember_num();
			
			HashMap<String,String> paraMap = new HashMap<>();			
			paraMap.put("currentShowPageNo", currentShowPageNo);
			paraMap.put("sizePerPage", sizePerPage);
			
			///////////////////////////////////////////////////////////////	
						
			List<OrderProductVO> possibleReviewList = rdao.selectPagingPossibleReview(paraMap, member_num);				
			
			request.setAttribute("possibleReviewList", possibleReviewList);
			request.setAttribute("sizePerPage", sizePerPage);
			
			
			// 특정 회원의 작성가능 후기 내역 개수 알아보기
			int pReviewCount = rdao.selectPossibleReviewCount(loginuser.getMember_num());
			
			// 특정 회원의 작성완료 후기 내역 개수 알아보기
			int cReviewCount = rdao.selectCompleteReviewCount(loginuser.getMember_num());
		
			request.setAttribute("possibleReviewList", possibleReviewList);
			request.setAttribute("pReviewCount", pReviewCount);
			request.setAttribute("cReviewCount", cReviewCount);
			
			// 페이징처리를 위한 특정 회원의 작성가능 후기 내역에 대한 총페이지갯수 알아오기(select)
			int totalPage = rdao.getPossibleReviewTotalPage(paraMap, member_num);
			
			int pageNo = 1;
			int blockSize = 10;
			int loop = 1;
			
			pageNo = ( (Integer.parseInt(currentShowPageNo) - 1)/blockSize )*blockSize + 1;
			
			String pageBar = "";
			
			// *** [이전] 만들기 *** //
			if( pageNo != 1 ) {
				pageBar += "&nbsp;<a href='myPageProductPossibleReview.do?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"'>[이전]</a>&nbsp;";
			}
			
			while( !(loop > blockSize || pageNo > totalPage) ) {
				
				if(pageNo == Integer.parseInt(currentShowPageNo) ) {
					pageBar += "&nbsp;<span style='color: red; border: solid 1px gray; padding: 2px 4px;'>"+pageNo+"</span>&nbsp;";	
				}
				else {
					pageBar += "&nbsp;<a href='myPageProductPossibleReview.do?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>"+pageNo+"</a>&nbsp;";
				}
				
				pageNo++;
				loop++;				
			}
			
			// *** [다음] 만들기 *** //
			if( !(pageNo > totalPage) ) {
				pageBar += "&nbsp;<a href='myPageProductPossibleReview.do?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>[다음]</a>&nbsp;";
			}
			
			request.setAttribute("pageBar", pageBar);
			
		//	super.setRedirect(false);	
			super.setViewPage("/WEB-INF/member/myPageProductPossibleReview.jsp");
		}		
		
	}

}
















