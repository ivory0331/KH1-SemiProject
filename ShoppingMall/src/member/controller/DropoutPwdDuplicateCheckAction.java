package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.*;

public class DropoutPwdDuplicateCheckAction extends AbstractController {
   
   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
      String pwd =  request.getParameter("password");  
      InterMemberDAO memberdao = new MemberDAO();
      
      boolean equalPwd = memberdao.dropoutPwdDuplicateCheck(pwd);
      
      JSONObject jsonObj = new JSONObject();
      jsonObj.put("equalPwd", equalPwd);	// equalPwd: true(동일하지 않은 비밀번호)/false 
      
      String json = jsonObj.toString();		// -> toString() => {"isUse":true}
      request.setAttribute("json", json);	
      
      super.setViewPage("/WEB-INF/jsonview.jsp");
   }

}