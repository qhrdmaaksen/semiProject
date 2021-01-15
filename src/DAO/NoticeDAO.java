package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import VO.NoticeVO;

public class NoticeDAO extends SuperDAO{
	public NoticeDAO() {
	}
	HttpServletRequest request ; 
	
	public NoticeDAO(HttpServletRequest request) {
		this.request = request ; 
	}

	public int SelectTotalCount(String mode, String keyword) {
		// 해당 모드와 키워드를 이용하여 조건에 맞는 데이터의 건수를 구해줍니다.
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;		
		
		String sql = " select count(*) as cnt from customer_center_post " ; 
		if (mode.equalsIgnoreCase("all") == false) {
			//전체 검색이 아니면
			sql += " where \"" + mode + "\" like '%"+keyword+"'";
		}
		
		int cnt = -999999 ;

		try {
			conn = super.getConnection() ;
			pstmt = conn.prepareStatement(sql) ;
			
			// placeholder 

			rs = pstmt.executeQuery() ; 
			
			if ( rs.next() ) { 
				cnt = rs.getInt("cnt");
			}
			
		} catch (SQLException e) {			
			SQLException err = (SQLException)e ;			
			cnt = - err.getErrorCode() ;			
			e.printStackTrace();
			try {
				conn.rollback(); 
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		} finally{
			try {
				if( rs != null){ rs.close(); } 
				if( pstmt != null){ pstmt.close(); } 
				if(conn != null){conn.close();}
			} catch (Exception e2) {
				e2.printStackTrace(); 
			}
		} 		
		return cnt  ; 
	}

	public List<NoticeVO> SelectDataList(int pageNumber,int beginRow, int endRow, String mode, String keyword) {
		// 랭킹을 이용하여 해당 페이지의 데이터를 컬렉션으로 반환합니다.
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;

		int cnt = -99999 ;
		
		String sql = " select \"seq_index\" , \"category\" , \"title\" , \"content\" , \"id\" " ;
		sql += " from (  select \"seq_index\" , \"category\" , \"title\" , \"content\" , \"id\", " ;
		sql += " rank() over(order by \"seq_index\" desc) as ranking  from customer_center_post  " ;
		
		if(mode.equalsIgnoreCase("all") == false) {
			sql += " where \"" + mode + "\" like '%" + keyword + "' " ;  
		}
		
		sql += " ) " ;
		sql += " where ranking between ?  and ? " ; 
		
		List<NoticeVO> lists = new ArrayList<NoticeVO>();

		try {
			conn = super.getConnection() ;
			pstmt = conn.prepareStatement(sql) ;

			// placeholder
			pstmt.setInt(1, beginRow);
			pstmt.setInt(2, endRow);

			rs = pstmt.executeQuery() ;	
			
			while( rs.next() ){
				NoticeVO bean = new NoticeVO();
				
				bean.setSeq_index(rs.getInt("seq_index")); 
				bean.setCategory(rs.getString("category")); 				
				bean.setTitle(rs.getString("title")); 
				bean.setContent(rs.getString("content")); 				
				bean.setId(rs.getString("id")); 
				
				lists.add( bean ) ;
			}
		} catch (Exception e) {
			SQLException err = (SQLException)e ;			
			cnt = - err.getErrorCode() ;			
			e.printStackTrace();
			try {
				conn.rollback(); 
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		} finally{
			try {
				if(rs != null){ rs.close(); }
				if(pstmt != null){ pstmt.close(); }
				if(conn != null){conn.close();}
			} catch (Exception e2) {
				e2.printStackTrace();  
			}
		}
		
		return lists ;
	}
	public int InsertData(NoticeVO bean) {
		// 넘겨진 Bean 데이터를 이용하여 추가합니다.
		String sql = " insert into customer_center_post(\"seq_index\", \"category\", \"title\",\"content\", \"id\" )  " ;
		sql += " values(seq_index.nextval, ?, ?, ?, ?) " ;    
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		int cnt = -999999 ;

		try {
			conn = super.getConnection() ;
			pstmt = conn.prepareStatement(sql) ;
			
			// placeholder
			
			pstmt.setString(1, bean.getCategory());
			pstmt.setString(2, bean.getTitle());
			pstmt.setString(3, bean.getContent());
			pstmt.setString(4, bean.getId());
			
			cnt = pstmt.executeUpdate() ; 
			conn.commit(); 

		} catch (Exception e) {
			SQLException err = (SQLException)e ;			
			cnt = - err.getErrorCode() ;			
			e.printStackTrace();
			try {
				conn.rollback(); 
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		} finally{
			try {
				if(pstmt != null){pstmt.close();}
				if(conn != null){conn.close();}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return cnt ;
	}

	public NoticeVO SelectDataByPk(int seq_index) {
		// 해당 게시물 번호의 Bean 객체를 구합니다.
		NoticeVO bean = null ;
		
		String sql = " select * from customer_center_post ";
		sql += " where \"seq_index\" = ? " ;
		
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		
		try {
			conn = super.getConnection() ;
			pstmt = conn.prepareStatement(sql) ;

			// placeholder		
			pstmt.setInt(1, seq_index);
						
			rs = pstmt.executeQuery() ;
			
			while(rs.next()) {
				bean = new NoticeVO() ;
				
				bean.setSeq_index(rs.getInt("seq_index")); 
				bean.setCategory(rs.getString("category")); 				
				bean.setTitle(rs.getString("title")); 
				bean.setContent(rs.getString("content")); 
				bean.setId(rs.getString("id")); 
			}
			
		} catch (Exception e) {
			SQLException err = (SQLException)e ;
			e.printStackTrace();
			try {
				conn.rollback(); 
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		} finally {
			try {
				if(rs != null) {rs.close();}
				if(pstmt != null) {pstmt.close();}
				if(conn != null) {conn.close();}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return bean  ;
	}

	public int UpdateData(NoticeVO bean) {
		// 해당 게시물을 수정합니다.
		String sql = " update customer_center_post set  ";
		sql += " \"category\"=?, \"title\"=?, \"content\"=?, \"id\" = ? " ;
		sql += " where \"seq_index\" = ? " ;    
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		int cnt = -999999 ;

		try {
			conn = super.getConnection() ;
			pstmt = conn.prepareStatement(sql) ;

			// placeholder
			pstmt.setString(1, bean.getCategory());
			pstmt.setString(2, bean.getTitle());
			pstmt.setString(3, bean.getContent());
			pstmt.setString(4, bean.getId());
			pstmt.setInt(5, bean.getSeq_index());
			
			
			cnt = pstmt.executeUpdate() ; 
			conn.commit(); 

		} catch (Exception e) {
			SQLException err = (SQLException)e ;			
			cnt = - err.getErrorCode() ;			
			e.printStackTrace();
			try {
				conn.rollback(); 
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		} finally{
			try {
				if(pstmt != null){pstmt.close();}
				if(conn != null){conn.close();}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return cnt ;
	}
	public int DeleteData(int seq_index) {
		String sql = " delete from customer_center_post where \"seq_index\" = ? " ;
		PreparedStatement pstmt = null ;
		int cnt = -99999 ;
		try {
			if( conn == null ){ super.conn = super.getConnection() ; }
			conn.setAutoCommit( false );
			pstmt = super.conn.prepareStatement(sql) ;
			pstmt.setInt(1, seq_index);
			
			cnt = pstmt.executeUpdate() ; 
			conn.commit(); 
		} catch (Exception e) {
			SQLException err = (SQLException)e ;			
			cnt = - err.getErrorCode() ;			
			e.printStackTrace();
			try {
				conn.rollback(); 
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		} finally{
			try {
				if( pstmt != null ){ pstmt.close(); }
				super.closeConnection(); 
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return cnt ;
	}

}
