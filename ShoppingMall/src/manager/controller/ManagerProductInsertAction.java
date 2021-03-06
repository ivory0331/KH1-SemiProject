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
import product.model.ProductVO;
import manager.model.*;
import member.model.MemberVO;

public class ManagerProductInsertAction extends AbstractController {


   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
      
      // 1. 로그인 해야 가능      
      if(!super.checkLogin(request)) {
         
          String message = "먼저 로그인 해야 가능합니다.";
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
               String message = "관리자만 접근이 가능합니다.";
               String loc = "javascript:history.back()";
               
               request.setAttribute("message", message);
               request.setAttribute("loc", loc);
               
               super.setRedirect(false);
               super.setViewPage("/WEB-INF/msg.jsp");
               
               return;
            }
            
         }
      
      
       super.getCategoryList(request);   
       
       String method = request.getMethod();
       
       InterProductDAO pdao = new ProductDAO();

       
       if(!"POST".equalsIgnoreCase(method)) {
            // GET 이라면
          int product_num = pdao.getPnumOfProduct();
           request.setAttribute("product_num", product_num);
           super.setViewPage("/WEB-INF/manager/managerProductInsert.jsp");            
       }else {
          
         MultipartRequest mtrequest = null;// 파일업로드, 다운로드 기능을 위한 객체, cos.jar 라이브러리 넣어줌
         
         // 1. 첨부되어진 파일의 업로드 경로 설정
         HttpSession sesssion = request.getSession();
         
         ServletContext svlCtx = sesssion.getServletContext();
         String imagesDir = svlCtx.getRealPath("/images");// 웹경로
         // 절대경로 => C:\myjsp\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\ShoppingMall\images
         
         
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
   
           ProductVO pvo = new ProductVO();
           
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

           int n = pdao.productInsert(pvo);
           
           
           int product_num = pdao.getPnumOfProduct();
           product_num -=1;

           
          // 상품 상세 이미지 업로드 
           int m = 0; 
           if(n==1) {
              for(int i=0; i<3; i++) {
            	  String detail_img = null;
            	  if(mtrequest.getFilesystemName("detail_img"+(i+1)) != null) {
            		  detail_img = mtrequest.getFilesystemName("detail_img"+(i+1));
            	  }
                 m = pdao.productImageInsert(product_num, detail_img);    
              }              
           }
          
           
           String message = "";
           String loc = "";
           
           if(m==1) {      
              
              message = "제품등록 성공!!";
              loc = request.getContextPath()+"/manager/managerProductList.do";              
              
           }
           else {
              message = "제품등록 실패!!";
              loc = request.getContextPath()+"/manager/managerProductList.do";
           }
           
           request.setAttribute("message", message);
           request.setAttribute("loc", loc);
           
           super.setViewPage("/WEB-INF/msg.jsp");
       }
              
      
   }


}
