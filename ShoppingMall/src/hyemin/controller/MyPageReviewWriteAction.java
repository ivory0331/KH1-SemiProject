package hyemin.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import main.model.IndexDAO;
import main.model.InterIndexDAO;
import main.model.OrderProductVO;
import member.model.MemberVO;

public class MyPageReviewWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		String product_num = request.getParameter("product_num");
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		Map<String, String> paraMap = new HashMap<String, String>();
		
		
		
		if("get".equalsIgnoreCase(method)) { //작성페이지로 이동할 때
			System.out.println("확인용 => product_num:"+product_num);
			InterIndexDAO dao = new IndexDAO();
			
			String message = "로그인이 필요한 기능입니다.";
			String loc = request.getContextPath()+"/member/login.do";
			String goBackURL = request.getContextPath()+"/member/myPageReviewWrite.do?product_num="+product_num;
			
			
			if(loginuser==null) {
				session.setAttribute("goBackURL", goBackURL);
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				super.setViewPage("/WEB-INF/msg.jsp");
				
				return;
			}
			
			// 로그인 되었을 경우
			
			paraMap.put("member_num", String.valueOf(loginuser.getMember_num()));
			paraMap.put("product_num", product_num);
			OrderProductVO product = dao.productReviewFind(paraMap);
			
			if(product == null) {
				message = "후기는 상품을 구매하고 배송완료된 상품만 가능합니다.";
				loc = request.getContextPath()+"/detail.do?product_num="+product_num;
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				super.setViewPage("/WEB-INF/msg.jsp");
				return;
			}
			else {
				request.setAttribute("product", product);
				super.setViewPage("/WEB-INF/member/myPageReviewWrite.jsp");
			}
		}
		
		
		

	}

}
