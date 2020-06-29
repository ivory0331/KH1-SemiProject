package hyemin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import hyemin.model.InterOrderDAO;
import hyemin.model.InterReviewDAO;
import hyemin.model.ReviewDAO;
import main.model.ReviewVO;
import member.model.MemberVO;

public class MyPageProductCompleteReviewAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		boolean isLogIn = super.checkLogin(request);
		
		if(!isLogIn) {
			// 로그인을 하지 않았을 경우
			
			request.setAttribute("message", "로그인하셔야 본 서비스를 이용하실 수 있습니다.");
			request.setAttribute("loc", "javascript:history.back()");
			
			//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		else {
			// 로그인 했고 자신의 회원번호(member_num)를 사용하려는 경우
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
			InterReviewDAO rdao = new ReviewDAO();
			
			// *** 페이징처리를 안 한, 특정 회원의 모든 작성완료 후기내역 보여주기 *** //
			List<ReviewVO> completeReviewList = rdao.selectCompleteReview(loginuser.getMember_num());
			
			// 특정 회원의 작성가능 후기 내역 개수 알아보기
			int pReviewCount = rdao.selectPossibleReviewCount(loginuser.getMember_num());
			
			// 특정 회원의 작성완료 후기 내역 개수 알아보기
			int cReviewCount = rdao.selectCompleteReviewCount(loginuser.getMember_num());
		
			request.setAttribute("completeReviewList", completeReviewList);
			request.setAttribute("pReviewCount", pReviewCount);
			request.setAttribute("cReviewCount", cReviewCount);
			
		//	super.setRedirect(false);	
			super.setViewPage("/WEB-INF/member/myPageProductCompleteReview.jsp");
		}

	}

}
