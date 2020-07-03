package main.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;


import common.controller.AbstractController;
import main.model.IndexDAO;
import main.model.InterIndexDAO;
import member.model.MemberVO;

public class BasketCntAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		InterIndexDAO dao = new IndexDAO();
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		int basketCnt = 0;
		if(loginuser!=null) {
			basketCnt = dao.basketCnt(loginuser.getMember_num());
		}
		
		
		JSONObject obj = new JSONObject();
		obj.put("basketCnt", basketCnt);
		String json = obj.toString();
		
		request.setAttribute("json", json);
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
	}

}
