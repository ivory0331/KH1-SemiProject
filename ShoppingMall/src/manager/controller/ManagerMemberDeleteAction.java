package manager.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.*;

public class ManagerMemberDeleteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String[] member_num = request.getParameterValues("member_num");
		
		InterMemberDAO mdao = new MemberDAO();				
		
		int sum=0;		
		for(int i=0; i<member_num.length; i++) {
				int n = mdao.memberDelete(member_num[i]);
				sum+=n;			
		}
		
		if(sum==member_num.length) {			
			 response.sendRedirect("managerMemberList.do");

		}
				
		
	}

}
