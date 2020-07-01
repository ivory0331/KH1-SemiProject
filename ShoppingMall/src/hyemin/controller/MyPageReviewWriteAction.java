package hyemin.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.controller.AbstractController;
import hyemin.model.InterReviewDAO;
import hyemin.model.ReviewDAO;
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
			
			Map<String, String> paraMap = new HashMap<String, String>();
			paraMap.put("member_num", String.valueOf(loginuser.getMember_num()));
			paraMap.put("product_num", product_num);
			OrderProductVO product = dao.productReviewFind(paraMap);
			
			if(product == null) {
				message = "후기는 상품을 구매하고 배송완료된 상품만 가능합니다.";
				loc = "javascript:history.back();";
				
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
		
		else {	// 작성페이지에서 내용 작성 후 DB등록 할 때
			InterReviewDAO rdao = new ReviewDAO();
			ServletContext context = request.getSession().getServletContext();
			String realPath = context.getRealPath("Upload");
			System.out.println("실제경로:"+realPath);
			
			// 업로드 경로에 폴더 없을 시 폴더 생성
			File dir = new File(realPath);
			if(!dir.isDirectory()){
				dir.mkdir();//.mkdirs차이
			}
			int maxsize = 10*1024*1024; 
			String encoding = "UTF-8";
			
			MultipartRequest multi = new MultipartRequest(request, realPath, maxsize, encoding, new DefaultFileRenamePolicy());			
			
			
			String subject = multi.getParameter("subject");
			String content = multi.getParameter("content");
			String image = multi.getParameter("fileName");
			String order_num = multi.getParameter("order_num");
			String member_num = String.valueOf(loginuser.getMember_num());	
			product_num = multi.getParameter("product_num");
			
			subject = subject.replaceAll("<", "&lt;");
			subject = subject.replaceAll(">", "&gt;");
			subject = subject.replaceAll("\r\n", "<br/>");
			subject = subject.replaceAll("&","&amp;");
			subject = subject.replaceAll("\"","&quot");
			
			content = content.replaceAll("<", "&lt;");
			content = content.replaceAll(">", "&gt;");
			content = content.replaceAll("\r\n", "<br/>");
			content = content.replaceAll("&","&amp;");
			content = content.replaceAll("\"","&quot");
			
			System.out.println(subject+"/"+content+"/"+image+"/"+order_num+"/"+member_num+"/"+product_num);
			
			Map<String,String> paraMap = new HashMap<String, String>();
			paraMap.put("subject", subject);
			paraMap.put("content",content);
			paraMap.put("image", image);
			paraMap.put("order_num", order_num);
			paraMap.put("member_num", member_num);
			paraMap.put("product_num", product_num);
			
			int result = rdao.writeReview(paraMap);			
			String message = "상품 후기가 작성되었습니다.";
			String loc = request.getContextPath()+"/member/myPageProductCompleteReview.do";
			
			if(result==0) {
				message = "상품 후기 작성 도중 오류가 발생했습니다.";
				loc="javascript:history.go(0)";
				
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
	}
	
}




















