package common.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import manager.model.*;

import member.model.MemberVO;


public abstract class AbstractController implements InterCommand { 

   /*
       === 다음의 나오는 것은 우리끼리한 약속이다. ===
   
       ※ view 단 페이지(.jsp)로 이동시 forward 방법(dispatcher)으로 이동시키고자 한다라면 
          자식클래스에서는 부모클래스에서 생성해둔 메소드 호출시 아래와 같이 하면 되게끔 한다.
        
       super.setRedirect(false); 
       super.setViewPage("/WEB-INF/index.jsp");
       
       
             ※ URL 주소를 변경하여 페이지 이동시키고자 한다라면
             즉, sendRedirect 를 하고자 한다라면    
             자식클래스에서는 부모클래스에서 생성해둔 메소드 호출시 아래와 같이 하면 되게끔 한다.
             
       super.setRedirect(true);
       super.setViewPage("registerMember.up");               
   */
   
   private boolean isRedirect = false;
   private String viewPage;
   
   public boolean isRedirect() {
      return isRedirect;
   }
   
   public void setRedirect(boolean isRedirect) {
      this.isRedirect = isRedirect;
   }
   
   public String getViewPage() {
      return viewPage;
   }
   
   public void setViewPage(String viewPage) {
      this.viewPage = viewPage;
   }
   
   /////////////////////////////////////////////////
   // 로그인 유무를 검사해서 로그인 했으면 true 를 리턴해주고
   // 로그인 안 했으면 false 를 리턴해주도록 한다.
   public boolean checkLogin(HttpServletRequest request) {
      
      HttpSession session = request.getSession();
      MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
      
      if(loginuser != null)
         return true;
      else
         return false;      
   }
   
   
   //카테고리를 보여줄 메소드 생성
   public void getCategoryList(HttpServletRequest request) throws SQLException {
      
      InterProductDAO pdao = new ProductDAO();
      
      List<HashMap<String,String>> categoryList = pdao.getCategoryList();
      
      request.setAttribute("categoryList", categoryList);
   
   }
   
   
   
   
   
}