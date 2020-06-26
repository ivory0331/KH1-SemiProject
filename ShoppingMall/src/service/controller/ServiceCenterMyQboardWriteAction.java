package service.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class ServiceCenterMyQboardWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
				
		//로그인 되었는지 확인 -> get or post방식 확인 
		super.setViewPage("/WEB-INF/service/serviceCenterMyQboardWrite.jsp");
		
		
	}

}
