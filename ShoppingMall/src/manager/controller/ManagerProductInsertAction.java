package manager.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.controller.AbstractController;
import my.util.MyUtil;
import product.model.*;

public class ManagerProductInsertAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
	    super.getCategoryList(request);	
	    
	    String method = request.getMethod();
	    
	    InterProductDAO pdao = new ProductDAO();

	    String fk_category_num = request.getParameter("fk_category_num");
	    
	    List<HashMap<String, String>> subCategoryList = new ArrayList<>();	      

	    subCategoryList = pdao.getSubCategoryList(fk_category_num);
	    
	    request.setAttribute("subCategoryList", subCategoryList);
	    
	    /*
		
		MultipartRequest mtrequest = null;// 파일업로드, 다운로드 기능을 위한 객체, cos.jar 라이브러리 넣어줌
		
		// 1. 첨부되어진 파일의 업로드 경로 설정
		HttpSession sesssion = request.getSession();
		
		ServletContext svlCtx = sesssion.getServletContext();
		String imagesDir = svlCtx.getRealPath("/images");// /MyMVC/images 는 웹경로
		
		
		try {	
			  // 파일 업로드
			  mtrequest = new MultipartRequest(request, imagesDir, 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy() );
			
	      } catch(IOException e) {
	    	  request.setAttribute("message", "업로드 되어질 경로가 잘못되었거나 또는 최대용량 10MB를 초과하여 파일 업로드에 실패하였습니다.");
	    	  request.setAttribute("loc", request.getContextPath()+"/manager/managerProductInsert.do");
	    	  
	    	  super.setViewPage("/WEB-INF/msg.jsp");
	    	  return;
		  }
		
		  String representative_img = mtrequest.getFilesystemName("representative_img");
		  String detail_img = mtrequest.getFilesystemName("detail_img");
		  
		  
		
		  String fk_category_num = mtrequest.getParameter("fk_category_num");
		  String fk_subcategory_num = mtrequest.getParameter("fk_subcategory_num");
		  String product_name = mtrequest.getParameter("product_name");
		  String unit = mtrequest.getParameter("unit");
		  String packing = mtrequest.getParameter("packing");
		  String origin = mtrequest.getParameter("origin");
		  String price = mtrequest.getParameter("price");
		  String sale = mtrequest.getParameter("sale");
		  String best_point = mtrequest.getParameter("best_point");

		  String seller = mtrequest.getParameter("seller");
		  String seller_phone = mtrequest.getParameter("seller_phone");
		  String stock = mtrequest.getParameter("stock");
		  String explain = mtrequest.getParameter("explain");

		  explain =  MyUtil.replaceParameter(explain);			
		  explain = explain.replaceAll("\r\n", "<br/>");

		  ProductVO pvo = new ProductVO();
		  int pnum = pdao.getPnumOfProduct();


		*/
	   

		  
		
	}

}
