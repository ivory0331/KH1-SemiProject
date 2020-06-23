package hyemin.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.*;
import javax.sql.DataSource;

import project.util.security.AES256;

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
			ds = (DataSource)envContext.lookup("jdbc/myoracle");
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
	public List<OrderVO> selectOneMemberAllOrder(String member_num) throws SQLException {
		
		List<OrderVO> orderList= new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select P.fk_order_num, O.to_char(order_date,'yyyy.mm.dd (hh24시 mi분)') as order_date, O.price,P.product_count, Q.product_name, S.order_state "+
						 " from order_table O join order_product_table P on O.order_num = P.fk_order_num "+
						 " join product_table Q on P.fk_product_num = Q.product_num "+
						 " join order_state_table S on O.fk_category_num = S.category_num "+
						 " where O.fk_member_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member_num);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				OrderVO ovo = new OrderVO();				
				ovo.setOrder_num(rs.getInt(1));
				ovo.setOrder_date(rs.getString(2));
				ovo.setPrice(rs.getInt(3));
				
				OrderProductVO opvo = new OrderProductVO();
				opvo.setProduct_count(rs.getInt(4));							
				ovo.setOrderProduct(opvo);
				
				ProductVO pvo = new ProductVO();
				pvo.setProduct_name(rs.getString(5));
				ovo.setProduct(pvo);
				
				OrderStateVO osvo = new OrderStateVO();
				osvo.setOrder_state(rs.getString(6));
				ovo.setOrderState(osvo);
				
				orderList.add(ovo);
			
			}// end of while(rs.next())---------------------------------

		} finally {
			close();  
		}
		
		return orderList;
	}

	
	// 주문 내역 상세 정보 보여주기
	@Override
	public OrderVO oneOrderDetail(String order_num) throws SQLException {
		
		
		
		return null;
	}
		
		
}
