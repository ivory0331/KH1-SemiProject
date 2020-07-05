package main.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import hyemin.model.InterOrderDAO;
import hyemin.model.OrderDAO;
import main.model.OrderHistoryDetailVO;
import main.model.OrderVO;

public class ManagerOrderDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String order_num = request.getParameter("order_num");
		InterOrderDAO odao = new OrderDAO();
		List<OrderHistoryDetailVO> OrderProductsList = odao.OneOrderProductsDetail(order_num);
		
		OrderVO OrderInfoDetail = odao.OneOrderInfoDetail(order_num);
		String name = OrderInfoDetail.getMember().getName();
				
		request.setAttribute("order_num", order_num);
		request.setAttribute("name", name);
		request.setAttribute("OrderProductsList", OrderProductsList);
		request.setAttribute("OrderInfoDetail", OrderInfoDetail);
		
		super.setViewPage("/WEB-INF/manager/managerOrderDetail.jsp");

	}

}
