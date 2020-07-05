package hyemin.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.*;
import javax.sql.DataSource;

import main.model.*;
import member.model.MemberVO;
import util.security.AES256;

public class OrderDAO implements InterOrderDAO {
	
	private DataSource ds;		// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다. 	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes = null;
	
	// 생성자 
	public OrderDAO() {
		// 암호화/복호화 키 (양방향암호화) ==> 이메일,휴대폰의 암호화/복호화
		String key = EncryptMyKey.KEY;
		
		try {
		    Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/semiProject");
			aes = new AES256(key);
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}	
	}
	
	// 사용한 자원을 반납하는 close() 메소드 생성하기
	public void close() {
		try {
			if(rs != null) { rs.close(); rs=null; }
			if(pstmt != null) { pstmt.close(); pstmt=null; } 
			if(conn != null) { conn.close(); conn=null; }
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	
	// 페이징처리를 안 한, 특정 회원의 모든 주문내역 보여주기
	@Override
	public List<OrderHistoryVO> selectOneMemberAllOrder(int member_num) throws SQLException {
		
		List<OrderHistoryVO> orderHistoryList= new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select O.order_num " + 
						 "      , to_char(O.order_date,'yyyy.mm.dd hh24:mi:ss') " + 
						 "      , O.price " + 
						 "      , OP.fk_product_num "+ 
						 "      , P.product_name " + 
						 "      , P.representative_img " + 
						 "      , OS.order_state " + 
						 " from order_table O " +
						 " join order_product_table OP " +
						 " on O.order_num = OP.fk_order_num " +
						 " join order_state_table OS " + 
						 " on O.fk_category_num = OS.category_num join product_table P " + 
						 " on OP.fk_product_num = P.product_num " + 
						 " where O.fk_member_num = ? " + 
						 " order by O.order_num desc ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			
			rs = pstmt.executeQuery();

			while(rs.next()) {
				
				OrderHistoryVO ohvo = new OrderHistoryVO();
				ohvo.setOrder_num(rs.getInt(1));
				ohvo.setOrder_date(rs.getString(2));
				ohvo.setPrice(rs.getInt(3));
				ohvo.setFk_product_num(rs.getInt(4));
				ohvo.setProduct_name(rs.getString(5));
				ohvo.setRepresentative_img(rs.getString(6));
				ohvo.setOrder_state(rs.getString(7));

				orderHistoryList.add(ohvo);
			}	
			
		rs.close();
		
		sql = " select count(*) from order_product_table where fk_order_num = ? ";
		
		pstmt = conn.prepareStatement(sql);
		
		for(int i=0; i<orderHistoryList.size(); i++) {		
			
			pstmt.setInt(1, orderHistoryList.get(i).getOrder_num());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				orderHistoryList.get(i).setProduct_cnt(rs.getInt(1));
			}			
		}

		} catch( Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return orderHistoryList;
	}

	
	// order_num 값을 입력받아서 특정 주문 내역의 상품정보를 알아오기(select)
	@Override
	public List<OrderHistoryDetailVO> OneOrderProductsDetail(String order_num) throws SQLException {

		List<OrderHistoryDetailVO> OrderProductsList = new ArrayList<>();
		
		try {				
			conn = ds.getConnection();		
			
			String sql = " select P.representative_img, P.product_name, OP.price, OP.product_count, " + 
						 "	      OS.order_state, OP.reviewFlag, P.product_num " + 
						 " from product_table P join order_product_table OP " + 
						 " on P.product_num = OP.fk_product_num " + 
						 " join order_table O " + 
						 " on OP.fk_order_num = O.order_num " + 
						 " join order_state_table OS " + 
						 " on O.fk_category_num = OS.category_num " + 
						 " where OP.fk_order_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, order_num);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				OrderHistoryDetailVO ohdvo = new OrderHistoryDetailVO();
				ohdvo.setRepresentative_img(rs.getString(1));
				ohdvo.setProduct_name(rs.getString(2));
				ohdvo.setPrice(rs.getInt(3));
				ohdvo.setProduct_count(rs.getInt(4));
				ohdvo.setOrder_state(rs.getString(5));
				ohdvo.setReviewFlag(rs.getInt(6));
				ohdvo.setProduct_num(rs.getInt(7));

				OrderProductsList.add(ohdvo);				
			}
		
		} finally {
			close();
		}
		
		return OrderProductsList;
	}

	
	// order_num 값을 입력받아서 특정 주문 내역의 상세정보를 알아오기(select)
	@Override
	public OrderVO OneOrderInfoDetail(String order_num) throws SQLException {

		OrderVO ovo = null;
		
		try {				
			conn = ds.getConnection();			
			
			String sql = " select O.price, " + 
						 "        M.name, to_char(O.order_date, 'yyyy-mm-dd hh24:mi:ss'), OS.order_state, " + 
						 "        O.recipient, O.recipient_mobile, O.recipient_postcode, O.recipient_address, O.recipient_detailaddress, O.memo, O.fk_category_num " + 
						 " from order_table O join member_table M " + 
						 " on O.fk_member_num = M.member_num " + 
						 " join order_state_table OS " + 
						 " on O.fk_category_num = OS.category_num " + 
						 " where O.order_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, order_num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				int price = rs.getInt(1);
				String name = rs.getString(2);
				String order_date = rs.getString(3);
				String order_state = rs.getString(4);
				String recipient = rs.getString(5);
				String recipient_mobile = rs.getString(6);
				String recipient_postcode = rs.getString(7);
				String recipient_address = rs.getString(8);
				String recipient_detailaddress = rs.getString(9);
				String memo = rs.getString(10);
				int category_num = rs.getInt(11);
				
				MemberVO mvo = new MemberVO();
				mvo.setName(name);
				
				ovo = new OrderVO();
				ovo.setPrice(price);
				ovo.setOrder_date(order_date);
				ovo.setOrder_state(order_state);
				ovo.setRecipient(recipient);
				ovo.setRecipient_mobile(recipient_mobile);
				ovo.setRecipient_postcode(recipient_postcode);
				ovo.setRecipient_address(recipient_address);
				ovo.setRecipient_detailAddress(recipient_detailaddress);
				ovo.setMemo(memo);
				ovo.setMember(mvo);
				ovo.setFk_category_num(category_num);

			}// end of while----------------------------------
			
		} finally {
			close();
		}
		
		return ovo;
	}

	
	// 페이징처리를 한, 특정 회원의 모든 주문내역 보여주기
	@Override
	public List<OrderHistoryVO> selectPagingOneMemberAllOrder(HashMap<String, String> paraMap, int member_num, int option) throws SQLException {
		
		List<OrderHistoryVO> orderHistoryList= new ArrayList<>();
		
		try {
			conn = ds.getConnection();		
			
	        String sql= " select RNO, order_num, order_date, price, order_state " + 
		                " from " + 
		                " (  " + 
		                "    select rownum AS RNO, order_num, order_date, price, order_state " + 
		                "    from " + 
		                "    (select O.order_num " + 
		                "          , to_char(O.order_date,'yyyy.mm.dd hh24:mi:ss') as order_date " + 
		                "          , O.price, OS.order_state " + 
		                " 	  from order_table O join order_state_table OS " + 
		                " 	  on O.fk_category_num = OS.category_num " + 
		                "	  where fk_member_num = ? ";
			
	        int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));	    
			
			String term = paraMap.get("term");
			int colname = 0;
			
			if ("all".equals(term) ) {
				sql += " ";
			}
			
			else if(  (Integer.toString(option)).equals(term) ) {
				colname = option;
				sql += " and to_char(O.order_date,'yyyy') = "+colname+" ";
			}					
			
			else if( (Integer.toString(option-1)).equals(term) ) {
				colname = option-1;
				sql += " and to_char(O.order_date,'yyyy') = "+colname+" ";
			}
			
			else if( (Integer.toString(option-2)).equals(term) ) {
				colname = option-2;		
				sql += " and to_char(O.order_date,'yyyy') = "+colname+" ";
			}
										
			else {
				sql += " ";
			}
			
			sql +=  "	  order by order_num desc " + 
	                "    ) V " + 
	                " ) T " + 
	                " where T.RNO between ? and ? ";
	        
			pstmt = conn.prepareStatement(sql);
			System.out.println("~~~~확인용 : "+sql);
			pstmt.setInt(1, member_num);
			pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1) ); // 공식
			pstmt.setInt(3, (currentShowPageNo * sizePerPage) ); // 공식 
			
			rs = pstmt.executeQuery();

			while(rs.next()) {
				
				OrderHistoryVO ohvo = new OrderHistoryVO();
				ohvo.setOrder_num(rs.getInt(2));
				ohvo.setOrder_date(rs.getString(3));
				ohvo.setPrice(rs.getInt(4));
				ohvo.setOrder_state(rs.getString(5));			

				orderHistoryList.add(ohvo);
			}	
			
		rs.close();
		
		sql = " select P.product_name, P.representative_img "
			+ " from order_product_table OP join product_table P "
			+ " on OP.fk_product_num = P.product_num "
			+ " where OP.fk_order_num = ? ";
		
		pstmt = conn.prepareStatement(sql);
		
		System.out.println(orderHistoryList.size());
		for(int i=0; i<orderHistoryList.size(); i++) {		
			
			pstmt.setInt(1, orderHistoryList.get(i).getOrder_num());
			
			rs = pstmt.executeQuery();
			
			int count = 0;
			if(rs.next()) {
				orderHistoryList.get(i).setProduct_name(rs.getString(1));
				orderHistoryList.get(i).setRepresentative_img(rs.getString(2));
			}	
			while (rs.next()) {
	            count++;
	        }
			orderHistoryList.get(i).setProduct_cnt(count);
		}

		} catch( Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return orderHistoryList;
	}

	
	// 페이징처리를 위한 특정 회원의 모든 주문내역에 대한 총페이지갯수 알아오기(select)
	@Override
	public int getPossibleReviewTotalPage(HashMap<String, String> paraMap, int member_num, int option) throws SQLException {
		
		int totalpage = 0;
		String sql = "";
		   
	    try {
	        conn = ds.getConnection();
	      
	        sql = " select ceil( count(*)/? ) from( select O.order_num " + 
	        		"	, to_char(O.order_date,'yyyy.mm.dd hh24:mi:ss') as order_date " + 
	        		"	, O.price " + 
	        		"	from order_table O " + 
	        		"	where O.fk_member_num = ? ";
	        		
	        String term = paraMap.get("term");
			int colname = 0;
			
			if ("all".equals(term) ) {
				sql += " ";
			}
			
			else if(  (Integer.toString(option)).equals(term) ) {
				colname = option;
				sql += " and to_char(O.order_date,'yyyy') = "+colname+" ";
			}					
			
			else if( (Integer.toString(option-1)).equals(term) ) {
				colname = option-1;
				sql += " and to_char(O.order_date,'yyyy') = "+colname+" ";
			}
			
			else if( (Integer.toString(option-2)).equals(term) ) {
				colname = option-2;		
				sql += " and to_char(O.order_date,'yyyy') = "+colname+" ";
			}
										
			else {
				sql += " ";
			}
    
	        sql += "	order by O.order_num desc ) ";
	         
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, Integer.parseInt(paraMap.get("sizePerPage")) );
	        pstmt.setInt(2, member_num);
	                                 
	        rs = pstmt.executeQuery();
	      
	        rs.next();
	      
	        totalpage = rs.getInt(1);
	      
	    } finally {
	      close();
	    }
	   
	   return totalpage;
		
	}

	
	// 기간의 옵션 값 구하기
	@Override
	public int termOption() throws SQLException {
		
		int term = 0;
		
		try {
	        conn = ds.getConnection();
	      
	        String sql = " select extract(year from sysdate) from dual ";
	         
	        pstmt = conn.prepareStatement(sql);
	                                 
	        rs = pstmt.executeQuery();
	      
	        rs.next();
	      
	        term = rs.getInt(1);
	      
	    } finally {
	      close();
	    }		
		
		return term;
	}

	

	
}


























