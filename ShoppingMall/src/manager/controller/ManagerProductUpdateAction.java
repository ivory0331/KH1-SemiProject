package manager.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.controller.AbstractController;
import manager.model.InterProductDAO;
import manager.model.ProductDAO;
import member.model.MemberVO;
import my.util.MyUtil;
import product.model.ProductVO;

public class ManagerProductUpdateAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		// 1. 로그인 해야 가능		
		if(!super.checkLogin(request)) {
			
			 String message = "로그인 하세요.";
	         String loc = "/ShoppingMall/member/login.do";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");
	         
	         return;	         
		}
		
		//2. 관리자로 로그인 해야 가능
		else {
	    	 HttpSession session = request.getSession();
	    	 MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
	         int status = loginuser.getStatus();
	         
	         if(status!=2) {
	        	String message = "권한이 없습니다.";
	            String loc = "/ShoppingMall/index.do";
	            
	            request.setAttribute("message", message);
	            request.setAttribute("loc", loc);
	            
	            super.setRedirect(false);
	            super.setViewPage("/WEB-INF/msg.jsp");
	            
	            return;
	         }
	         
	      }			
		
		String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) { 
			
			String message = "비정상적인 경로입니다.";
	        String loc = "javascript:history.back()";
	         
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	         
	        super.setViewPage("/WEB-INF/msg.jsp");
	        return;
	        
	        
	        
		}else {
			
			  MultipartRequest mtrequest = null;
			  HttpSession sesssion = request.getSession();
			
			  ServletContext svlCtx = sesssion.getServletContext();
			  String imagesDir = svlCtx.getRealPath("/images");
			
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

			  int product_num = Integer.parseInt(mtrequest.getParameter("product_num"));
			  int fk_category_num = Integer.parseInt(mtrequest.getParameter("fk_category_num"));
			  int fk_subcategory_num = Integer.parseInt(mtrequest.getParameter("fk_subcategory_num"));
			  String product_name = mtrequest.getParameter("product_name");
			  String unit = mtrequest.getParameter("unit");
			  String packing = mtrequest.getParameter("packing");
			  String origin = mtrequest.getParameter("origin");			 
			  String shelf = mtrequest.getParameter("shelf");
			  String weight = mtrequest.getParameter("weight");
			  String information = mtrequest.getParameter("information");
			  int price = Integer.parseInt(mtrequest.getParameter("price"));
			  
			  String getSale = mtrequest.getParameter("sale");
			  
			  if("".equals(getSale)) {
				  getSale="0";
			  }

			  int sale = Integer.parseInt(getSale);			  
			  
			  String getBest_point = mtrequest.getParameter("best_point");
			  if(getBest_point.isEmpty()) {
				  getBest_point="0";
			  }
			  
			  int best_point = Integer.parseInt(getBest_point);
			  String seller = mtrequest.getParameter("seller");
			  String seller_phone = mtrequest.getParameter("seller_phone");
			  int stock = Integer.parseInt(mtrequest.getParameter("stock"));
			  String explain = mtrequest.getParameter("explain");
	
			  information = MyUtil.replaceParameter(information);
			  information = information.replaceAll("\r\n", "<br>");
			  
			  explain =  MyUtil.replaceParameter(explain);			
			  explain = explain.replaceAll("\r\n", "<br>");
			  
			  InterProductDAO pdao = new ProductDAO();
			  ProductVO pvo = new ProductVO();
			  
			  pvo.setProduct_num(product_num);
			  pvo.setRepresentative_img(representative_img);
			  pvo.setFk_category_num(fk_category_num);
			  pvo.setFk_subcategory_num(fk_subcategory_num);
			  pvo.setProduct_name(product_name);
			  pvo.setUnit(unit);
			  pvo.setPacking(packing);
			  pvo.setOrigin(origin);
			  pvo.setPrice(price);
			  pvo.setSale(sale);
			  pvo.setBest_point(best_point);
			  pvo.setSeller(seller);
			  pvo.setSeller_phone(seller_phone);
			  pvo.setStock(stock);
			  pvo.setExplain(explain);
			  pvo.setShelf(shelf);
			  pvo.setWeight(weight);
			  pvo.setInformation(information);

			  int n = pdao.productUpdate(pvo);
			  			  
			  
			 // 상품 상세 이미지 업로드 
			  int m = 0; 
			  
			  if(n==1) {
				  for(int i=0; i<3; i++) {
					  
					  if(mtrequest.getFilesystemName("detail_img"+(i+1))!=null) {
						  String detail_img = mtrequest.getFilesystemName("detail_img"+(i+1));
						  String old_name = mtrequest.getParameter("old_name"+(i+1));
						  System.out.println(">>>>>>> 위치값"+old_name);
						  
						  if("".equals(old_name)) {
		                       old_name="no_image";
		                       System.out.println(">>>>>>>>>>>>>>>>>>>>>>old_name : "+old_name);
		                    }
		                    
		                    if("no_image".equals(old_name)) {
		                       m=pdao.productImageInsert(product_num, detail_img);
		                    }else {
		                     // 교체 및 새등록
		                       m = pdao.productImageReplace(detail_img, old_name);   
		                    }
	
						  
					  }else { //삭제
						  if(("이미지 선택"+(i+1)).equals(mtrequest.getParameter("upload_name"+(i+1)))) {
							  String old_name = mtrequest.getParameter("old_name"+(i+1));
							  m= pdao.productImageDelete(old_name);
						  }
						  
					  }
					  
				  }
			  }else {
				  m=2;		  
			  }
			  
			  String message = "";
			  String loc = "";
			  
			  if(n==1) {
				  
				  message = "제품 수정이 완료되었습니다.";
				  loc = request.getContextPath()+"/manager/managerProductList.do";				  
				  
			  }
			  else {
				  message = "제품 수정에 실패했습니다.";
				  loc = request.getContextPath()+"/manager/managerProductList.do";
			  }
			  
			  super.getCategoryList(request);
			  request.setAttribute("message", message);
			  request.setAttribute("loc", loc);
			  
			  super.setViewPage("/WEB-INF/msg.jsp");
			
			  
		
		}
		
		
		
		
		
	}

}
