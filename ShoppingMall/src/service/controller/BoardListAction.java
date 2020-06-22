package service.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class BoardListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
<<<<<<< HEAD
		//super.setViewPage("/WEB-INF/service/serviceCenterBoardList.jsp");
		super.setViewPage("/WEB-INF/error.jsp");
=======
		super.setViewPage("/WEB-INF/service/serviceCenterBoardList.jsp");
		
>>>>>>> origin/sanga
	}

}
