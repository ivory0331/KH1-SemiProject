package service.model;

<<<<<<< HEAD
public class ServiceDAO implements InterServiceDAO {

=======
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import main.model.EncryptMyKey;
import main.model.NoticeVO;
import util.security.AES256;

public class ServiceDAO implements InterServiceDAO {

	private DataSource ds; 
	// DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다. 
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private AES256 aes = null;
	
	// 생성자 
	public ServiceDAO() {
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
	
	
	// 공지사항 리스트 조회
	@Override
	public List<NoticeVO> selectPagingMember(HashMap<String, String> paraMap) throws SQLException {
		List<NoticeVO> noticeList = new ArrayList<NoticeVO>();
		try {		
				conn = ds.getConnection();
				String[] searchTypeArr = null;
				String sql = " select RNO, notice_num, subject, content, write_date, hits "
							+" from "
							+" ( select rownum AS RNO, notice_num, subject, content,  write_date, hits "
							+"   from "
							+"     ( select notice_num, subject, content, to_char(write_date,'yyyy-mm-dd')as write_date, hits "
							+"       from notice_table ";
							
				String searchWord = paraMap.get("searchWord");
				String searchType = paraMap.get("searchType");
					
				if(searchWord != null && !searchWord.trim().isEmpty()) {      
			            if(searchType.indexOf(",")==-1) {
			            	sql += " where "+searchType+" like '%'||?||'%' "; 
			            }
			            else {
			            	searchTypeArr = searchType.split(",");
			            	sql += " where "+searchTypeArr[0]+" like '%'||?||'%' "; 
			            	if(!searchTypeArr[1].trim().isEmpty()) sql += " or "+searchTypeArr[1]+" like '%'||?||'%' ";
			            }
			                             
			    }
			         
			    sql +=    "       order by notice_num desc "
			           +"     )V "
			           +" )T "
			           +" where T.RNO between ? and ? ";     				
				
				pstmt = conn.prepareStatement(sql);	
				
				System.out.println("sql:"+sql);
				
				int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
				int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
				
				if(searchWord != null && !searchWord.trim().isEmpty()) {	
					if(searchTypeArr == null) {
						pstmt.setString(1, searchWord);
						pstmt.setInt(2, (currentShowPageNo*sizePerPage)-sizePerPage+1);
						pstmt.setInt(3, (currentShowPageNo*sizePerPage) );
					}
					else if(searchTypeArr[1].trim().isEmpty()) {
						pstmt.setString(1, searchWord);
						pstmt.setInt(2, (currentShowPageNo*sizePerPage)-sizePerPage+1);
						pstmt.setInt(3, (currentShowPageNo*sizePerPage) );
					}
					else {
						pstmt.setString(1, searchWord);
						pstmt.setString(2, searchWord);
						pstmt.setInt(3, (currentShowPageNo*sizePerPage)-sizePerPage+1);
						pstmt.setInt(4, (currentShowPageNo*sizePerPage) );
					}
					
					
				}else {
					
					pstmt.setInt(1, (currentShowPageNo*sizePerPage)-sizePerPage+1);
					pstmt.setInt(2, (currentShowPageNo*sizePerPage) );
				}
			
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					NoticeVO nvo = new NoticeVO();
					nvo.setNotice_num(rs.getInt("notice_num"));
					nvo.setSubject(rs.getString("subject"));
					nvo.setContent(rs.getString("content"));
					nvo.setWrite_date(rs.getString("write_date"));
					nvo.setHit(rs.getInt("hits"));
					noticeList.add(nvo);
				}
				
		}
		finally {
			close();
		}
		return noticeList;
	}


	// 공지사항 게시글 수 조회
	@Override
	public int getTotalPage(HashMap<String, String> paraMap) throws SQLException {
		int totalPage = 0;
		
		try {
			conn=ds.getConnection();
			
			String sql = " select ceil(count(*)/?) as totalPage "
						+" from notice_table ";
			
			String searchWord = paraMap.get("searchWord");
			String searchType = paraMap.get("searchType");
			String[] searchTypeArr = null;
			
			
			if(searchWord !=null && !searchWord.trim().isEmpty()) {		
				if(searchType.indexOf(",")!=-1) {
					searchTypeArr = searchType.split(",");
					sql += " where "+searchTypeArr[0]+" like '%'||?||'%'";
					if(!searchTypeArr[1].trim().isEmpty()) sql += " or "+searchTypeArr[1]+" like '%'||?||'%' ";
				}
				
				else {
						sql += " where "+searchType+" like '%'||?||'%'";
				}	
										
			}
			
			
			pstmt = conn.prepareStatement(sql);
			
			
			if(searchWord !=null && !searchWord.trim().isEmpty()) {		
				
				if(searchTypeArr == null) {
					pstmt.setInt(1, Integer.parseInt(paraMap.get("sizePerPage")));
					pstmt.setString(2, searchWord);
				}
				else if(searchTypeArr[1].trim().isEmpty()) {
					pstmt.setInt(1, Integer.parseInt(paraMap.get("sizePerPage")));
					pstmt.setString(2, searchWord);
				}
				else {
					pstmt.setInt(1, Integer.parseInt(paraMap.get("sizePerPage")));
					pstmt.setString(2, searchWord);
					pstmt.setString(3, searchWord);
				}
								
			}else {
				pstmt.setInt(1, Integer.parseInt(paraMap.get("sizePerPage")));
			}
			
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalPage = rs.getInt(1);
			
			System.out.println("totalPage : "+totalPage);
			
		}catch(Exception e){
			e.printStackTrace();
		} finally {
			close();
		}
		
		return totalPage;
	}

>>>>>>> 7071bca5fc7ada42f6267a1c97b9b4b2490bd4e7
}
