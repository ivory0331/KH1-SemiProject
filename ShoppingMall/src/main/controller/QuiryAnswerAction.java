package main.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import main.model.IndexDAO;
import main.model.InterIndexDAO;
import main.model.OneInquiryVO;
import main.model.ProductInquiryVO;
import my.util.MyUtil;

public class QuiryAnswerAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		String quiry_num = request.getParameter("quiry_num");
		String type = request.getParameter("type");
		ProductInquiryVO pvo = null;
		OneInquiryVO ovo = null;
		
		InterIndexDAO dao = new IndexDAO();
		System.out.println("type:"+type);
		if("get".equalsIgnoreCase(method)) {
			
			request.setAttribute("type", type);
			
			if("product".equals(type)) {
				pvo = dao.inquiryOneSelect(quiry_num);
				request.setAttribute("inquiry", pvo);
			}
			else {
				ovo = dao.oneInquirySelect(quiry_num);	
				request.setAttribute("inquiry", ovo);
			}
			
			super.setViewPage("/WEB-INF/manager/managerAnswer.jsp");
			return;
		}
		else {
			String answer = request.getParameter("answer");
			Map<String, String>paraMap = new HashMap<String, String>();
			
			answer = MyUtil.replaceParameter(answer);
			
			paraMap.put("answer", answer);
			paraMap.put("type",type);
			paraMap.put("quiry_num", quiry_num);
			
			int result = dao.answerWrite(paraMap);
			
			String message = "문의 답변을 등록하는 도중 오류가 발생했습니다.";
			String loc = request.getContextPath();
			if("product".equals(type)) {
				loc +="/manager/managerProductInquiryList.do";
			}
			else {
				loc += "/manager/managerOneInquiryList.do";
			}
			
			if(result != 0) message = "문의 답변을 등록했습니다.";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
			
		}
		
	}

}
