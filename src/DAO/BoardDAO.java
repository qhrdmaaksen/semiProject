package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import VO.BbsPostVo;


public class BoardDAO  extends SuperDAO {

	public int SelectTotalCount(String mode, String keyword) {
		// 해당 모드와 키워드를 이용하여 조건에 맞는 데이터의 건수를 구해줍니다. 
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;		
		
		String sql = " select count(*) as cnt from BBS_POST " ;  
		
		if(mode.equalsIgnoreCase("all")==false) {
			// 전체 검색이 아니면 
			sql += " where " + mode + " like '" + keyword + "%' " ;
		}
			
		int cnt = -999999 ;
 
		try {
			conn = super.getConnection() ;
			pstmt = conn.prepareStatement(sql) ;
			

			rs = pstmt.executeQuery() ; 
			
			if ( rs.next() ) { 
				cnt = rs.getInt("cnt"); // 가져와서 객체 cnt 에넣어줘야 하니까 alias 한 "cnt" 를 넣어준다.
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

	public List<BbsPostVo> SelectDataList(int beginRow, int endRow, String mode, String keyword) {
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		
		int cnt = -99999;
	      String sql = " select seq_index, id, title, content, postdate, likenumber " ;
	      sql += " from ( " ;
	      sql += " select seq_index, id, title, content, postdate, likenumber " ;
	      sql += " rank() over( order by groupno desc, orderno asc) as ranking " ;
	      sql += " from BBS_POST " ;
	      
	      if(mode.equalsIgnoreCase("all")== false) {
	    	  sql+= " where " + mode + " like '"+ keyword +"%' " ; 
	    	  System.out.println(sql);
	      }
	      
	      sql += " ) " ;
	      sql += " where ranking between ?  and ?  " ; 
		
		List<BbsPostVo> lists = new ArrayList<BbsPostVo>();

		try {
			conn = super.getConnection() ;
			pstmt = conn.prepareStatement(sql) ;

			// placeholder1
				
			pstmt.setInt(1, beginRow);
			pstmt.setInt(2, endRow);
			
			
			
			rs = pstmt.executeQuery() ;			
			while( rs.next() ){
				BbsPostVo bean = new BbsPostVo();
				bean.setContent(rs.getString("content"));
				bean.setId(rs.getString("id"));
				bean.setLikenumber(rs.getInt("likenumber"));
				bean.setNum(rs.getInt("num"));
				bean.setPostdate(String.valueOf(rs.getString("postdate")));
				bean.setTitle(rs.getString("title"));
				
				
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

	public int InsertData(BbsPostVo bean) {
		String sql = " insert into BBS_POST (seq_index, id, title, content, postdate, likenumber ) " ;
		sql += " values(seq_BP_index.nextval,?,?,?,to_date(?, 'yyyy/MM/dd'), default ) " ;
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		int cnt = -999999 ;

		try {
			conn = super.getConnection() ;
			pstmt = conn.prepareStatement(sql) ;

			// placeholder
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getTitle());
			pstmt.setString(3, bean.getContent());
			
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
}