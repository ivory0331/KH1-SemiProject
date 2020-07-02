package main.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
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
import main.model.ProductInquiryVO;
import member.model.MemberVO;

public class InquiryUpAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String method = request.getMethod();
		
		if("get".equalsIgnoreCase(method)) {
			String member_num = request.getParameter("member_num");
			if(loginuser.getMember_num() != Integer.parseInt(member_num)) {
				String message = "정상적인 접속방법이 아닙니다.";
				String loc = "javascript:history.back()";
				request.setAttribute("messge", message);
				request.setAttribute("loc", loc);
				super.setViewPage("/WEB-INF/msg.jsp");
				return;
			}
			
			String inquiry_num = request.getParameter("inquiry_num");
			InterIndexDAO dao = new IndexDAO();
			ProductInquiryVO pivo = dao.inquiryOneSelect(inquiry_num);
			String content = pivo.getContent();
			
			content = content.replaceAll("&lt;", "<");
			content = content.replaceAll("&gt;", ">");
			content = content.replaceAll("<br/>", "\r\n");
			content = content.replaceAll("&amp;","&");
			content = content.replaceAll("&quot;","\"");
			
			
			pivo.setContent(content);
			
			request.setAttribute("pivo", pivo);
			super.setViewPage("/WEB-INF/main/productQupdate.jsp");
		}
		else {
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
			
			
			
			String[] oldFileNameArr = multi.getParameterValues("oldFileName");
			String content = multi.getParameter("contents");
			String inquiry_num = multi.getParameter("inquiry_num");
			String product_num = multi.getParameter("product_num");
			int cnt = 0;
			
			System.out.println("기존내용:"+String.join(",", oldFileNameArr));
			
			
			// 상품문의 이미지 테이블에 기존에 있던 사진 조회 및 삭제
			List<String> delFileName = dao.inquiryImgDel(inquiry_num, oldFileNameArr);
					
			
			//실제 경로에서도 이미지 삭제
			if(delFileName.size()>0) {
				for(int i=0; i<delFileName.size(); i++) {
					realPath+=delFileName.get(i);
					File file = new File(realPath);
					if(file.exists()){
						file.delete();
					}
					else {
						System.out.println("이미 삭제된 파일");
					}
				}
			}
			
			
			if(multi.getParameterValues("fileName")!=null) arrCnt = multi.getParameterValues("fileName").length;
			System.out.println("확인용 새로운 파일타입 input갯수 : "+arrCnt);
			if(arrCnt == 0) arrCnt = multi.getParameterValues("oldFileName").length;
			String[] fileNameArr = new String[arrCnt];
			
			// null이 아닌 것만 업로드
			
			
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
			
			
			content = content.replaceAll("<", "&lt;");
			content = content.replaceAll(">", "&gt;");
			content = content.replaceAll("\r\n", "<br/>");
			content = content.replaceAll("&","&amp;");
			content = content.replaceAll("\"","&quot");
			
			
			System.out.println(content);
			
			if(emailFlag==null) emailFlag="0";
			if(smsFlag == null) smsFlag="0";
			if(secretFlag == null) secretFlag="0";
			if(resultFileNameArr != null) fileName = String.join(",", resultFileNameArr);
			
			System.out.println(emailFlag+"/"+smsFlag+"/"+secretFlag+"/"+fileName+"/"+content);
			
			
			
			Map<String,String> paraMap = new HashMap<String, String>();
			paraMap.put("subject", title);
			paraMap.put("content",content);
			paraMap.put("emailFlag", emailFlag);
			paraMap.put("smsFlag",smsFlag);
			paraMap.put("secretFlag", secretFlag);
			paraMap.put("inquiry_num", inquiry_num);
			paraMap.put("member_num", String.valueOf(loginuser.getMember_num()));
			paraMap.put("fileName", fileName);
			
			int result = dao.productQupdate(paraMap);
			String message = "상품문의를 수정했습니다.";
			String loc = request.getContextPath()+"/detail.do?product_num="+product_num;
			
			if(result==0) {
				message = "상품문의 수정 도중 오류가 발생했습니다.";
				loc="javascript:history.go(0)";
				
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}

}
