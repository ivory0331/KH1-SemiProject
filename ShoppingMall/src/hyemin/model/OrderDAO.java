package hyemin.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.*;
import javax.sql.DataSource;

import main.model.OrderHistoryVO;
import main.model.OrderVO;
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
	public List<OrderHistoryVO> selectOneMemberAllOrder(String member_num) throws SQLException {
		
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
						 " from order_table O join order_product_table OP " + 
						 " on O.order_num = OP.fk_order_num join order_state_table OS " + 
						 " on O.fk_category_num = OS.category_num join product_table P " + 
						 " on OP.fk_product_num = P.product_num " + 
						 " where O.fk_member_num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(member_num));
			
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

	
	// order_num 값을 입력받아서 특정 주문 내역의 상세정보를 알아오기(select)
	@Override
	public OrderVO OrderOneDetail(String order_num) throws SQLException {

		
		
		return null;
	}


		
}


























