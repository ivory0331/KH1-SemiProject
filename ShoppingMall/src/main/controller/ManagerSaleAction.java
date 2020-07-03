package main.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import main.model.IndexDAO;
import main.model.InterIndexDAO;
import member.model.MemberVO;

public class ManagerSaleAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String type = request.getParameter("type");
		if(type==null || type.trim().isEmpty()) type="year";
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(loginuser== null || loginuser.getStatus()!=2) {
			String message = "관리자가 아닌 사용자는 접속할 수 없습니다.";
			String loc = request.getContextPath()+"/index.do";
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		InterIndexDAO dao = new IndexDAO();
		List<Map<String,String>>salesList = dao.allSalesSelect(type);
		request.setAttribute("salesList", salesList);
		request.setAttribute("type", type);
		super.setViewPage("/WEB-INF/manager/managerSales.jsp");
	}

}
