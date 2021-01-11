package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import VO.AskedVO;

public class AskedDAO extends SuperDAO{

	public List<AskedVO> SelectDataList(int pageNumber, int beginRow, int endRow, String mode, String keyword) {
		Connection conn = null ;
		PreparedStatement pstmt = null ; 
		ResultSet rs = null ; 
		
		int cnt = -999999 ; 
		
		String sql = " select no, subject, writer, password, content, readhit, regdate, groupno, orderno, depth, remark  " ;
		sql += " from ( " ;
		sql += " select no, subject, writer, password, content, readhit, regdate, groupno, orderno, depth, remark,  " ;
		sql += " rank() over(order by groupno desc, orderno asc) as ranking " ;
		sql += " from asked " ;
		
		if(mode.equalsIgnoreCase("all") == false) {
			sql += " where " + mode + " like '" + keyword + "' " ;  
		}
		
		sql += " ) " ;
		sql += " where ranking between ?  and ?  " ;
		
		List<AskedVO> lists = new ArrayList<AskedVO>() ;
		
		try {
			conn = super.getConnection() ; 
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, beginRow);
			pstmt.setInt(2, endRow);
			
			rs = pstmt.executeQuery() ; 
			
			while ( rs.next()) {
				AskedVO bean = new AskedVO() ; 
				
				bean.setContent(rs.getString("content"));
				bean.setDepth(rs.getInt("depth"));
				bean.setGroupno(rs.getInt("groupno"));
				bean.setNo(rs.getInt("no"));
				bean.setOrderno(rs.getInt("orderno"));
				bean.setPassword(rs.getString("password"));
				bean.setReadhit(rs.getInt("readhit"));
				bean.setRegdate(String.valueOf(rs.getString("regdate")));
				bean.setSubject(rs.getString("subject"));
				bean.setWriter(rs.getString("writer"));
				bean.setRemark(rs.getString("remark"));
				
				lists.add(bean) ;
			}
		} catch (Exception e) {
			SQLException err = (SQLException)e ; 
			cnt = -err.getErrorCode() ; 
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
		return lists;
	}

	public int SelectTotalCount(String mode, String keyword) {
		Connection conn = null ; 
		PreparedStatement pstmt = null ; 
		ResultSet rs = null ; 
		
		String sql = " select count(*) as cnt from asked " ;
		if (mode.equalsIgnoreCase("all") == false) {
			sql += " where " + mode + " like '" + keyword + "' " ;
		}
		
		int cnt = -999999 ;
		
		try {
			conn = super.getConnection() ; 
			pstmt = conn.prepareStatement(sql) ;
			
			rs = pstmt.executeQuery() ; 
			
			if ( rs.next()) {
				cnt = rs.getInt("cnt") ;
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
		} finally {
			try {
				if( rs != null) {rs.close();}
				if( pstmt != null) {pstmt.close();}
				if( conn != null) {conn.close();}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return cnt ;
	}

	public int InsertData(AskedVO bean) {
		// 넘겨진 Bean 데이터를 이용하여 추가합니다.
		String sql = " insert into asked(no, subject, writer, password, content,  " ;
		sql += " readhit, regdate, groupno, orderno, depth)  ";		
		sql += " values(myasked.nextval, ?, ?, ?, ?, default, to_date(?, 'yyyy/MM/dd'), myasked.currval, default, default) " ;
		
		Connection conn = null ; 
		PreparedStatement pstmt = null ; 
		
		int cnt = -999999 ; 
		
		try {
			conn = super.getConnection() ; 
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, bean.getSubject());
			pstmt.setString(2, bean.getWriter());
			pstmt.setString(3, bean.getPassword());
			pstmt.setString(4, bean.getContent());
			pstmt.setString(5, bean.getRegdate());
			
			cnt = pstmt.executeUpdate() ;
			conn.commit();

		} catch (Exception e) {
			SQLException err = (SQLException)e;
			cnt = -err.getErrorCode() ; 
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}finally {
			try {
				if( pstmt != null) { pstmt.close();}
				if( conn != null) { conn.close();}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return cnt;
	}
	
}
