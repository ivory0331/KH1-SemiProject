package main.controller;

import java.io.File;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.controller.AbstractController;
import main.model.IndexDAO;
import main.model.InterIndexDAO;
import main.model.ProductVO;
import member.model.MemberVO;
import my.util.MyUtil;

public class ProductQwriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		String product_num = request.getParameter("product_num");
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		
		
		if("get".equalsIgnoreCase(method)) { //작성페이지로 이동할 때
			System.out.println("확인용 => product_num:"+product_num);
			InterIndexDAO dao = new IndexDAO();
			ProductVO product = dao.productDetail(product_num);
			
			String message = "로그인이 필요한 기능입니다.";
			String loc = request.getContextPath()+"/member/login.do";
			String goBackURL = request.getContextPath()+"/productQwrite.do?product_num="+product_num;
			
			
			if(loginuser==null) {
				session.setAttribute("goBackURL", goBackURL);
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				super.setViewPage("/WEB-INF/msg.jsp");
				
				return;
			}
			
			
			if(product == null) { //장난질 할 경우
				message = "등록된 상품이 없습니다.";
				loc = request.getContextPath()+"/index.do";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				super.setViewPage("/WEB-INF/msg.jsp");
				return;
			}
			else {
				super.setViewPage("/WEB-INF/main/productQwrite.jsp");
			}
		}
		else { // 작성페이지에서 내용 작성 후 DB등록 할 때
			InterIndexDAO dao = new IndexDAO();
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
			
			
			
			String fileName = null;
			String title = multi.getParameter("title");
			String emailFlag = multi.getParameter("emailComment");
			String smsFlag = multi.getParameter("mobileComment");
			String secretFlag = multi.getParameter("secretFlag");
			int arrCnt = 0;
			
			String content = multi.getParameter("contents");
			product_num = multi.getParameter("product_num");
			int cnt = 0;
			
			if(multi.getParameterValues("fileName")!=null) arrCnt = multi.getParameterValues("fileName").length;
			System.out.println("확인용 새로운 파일타입 input갯수 : "+arrCnt);
			
			String[] fileNameArr = null;
			if(arrCnt > 0) fileNameArr = new String[arrCnt];
			
			if(fileNameArr != null) {
				Enumeration<String> files= multi.getFileNames();
				while(files.hasMoreElements()) {
					String name = files.nextElement();
					System.out.println("name:"+name);
					if(multi.getFilesystemName(name) != null) {
						fileNameArr[cnt] = multi.getFilesystemName(name);
						System.out.println("파일명:"+fileNameArr[cnt]);
						cnt++;
					}
					
				}
				
				String[] resultFileNameArr = new String[cnt];
				
				for(int i=0; i<cnt; i++) {
					resultFileNameArr[i] = fileNameArr[i];
				}
				if(resultFileNameArr != null) fileName = String.join(",", resultFileNameArr);
			}
			
			
			
			
			content = MyUtil.replaceParameter(content);
			
			
			System.out.println(content);
			
			if(emailFlag==null) emailFlag="0";
			if(smsFlag == null) smsFlag="0";
			if(secretFlag == null) secretFlag="0";
			
			
			System.out.println(emailFlag+"/"+smsFlag+"/"+secretFlag+"/"+fileName+"/"+content);
			
			
			Map<String,String> paraMap = new HashMap<String, String>();
			paraMap.put("subject", title);
			paraMap.put("content",content);
			paraMap.put("emailFlag", emailFlag);
			paraMap.put("smsFlag",smsFlag);
			paraMap.put("secretFlag", secretFlag);
			paraMap.put("product_num", product_num);
			paraMap.put("member_num", String.valueOf(loginuser.getMember_num()));
			paraMap.put("fileName", fileName);
			
			int result = dao.productQwrite(paraMap);
			String message = "상품문의를 작성했습니다.";
			String loc = request.getContextPath()+"/detail.do?product_num="+product_num;
			
			if(result==0) {
				message = "상품문의 작성 도중 오류가 발생했습니다.";
				loc="javascript:history.go(0)";
				
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
			
	}

}
