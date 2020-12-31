package DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import VO.MemberVO;

public class MemberDAO extends SuperDAO {


	public MemberVO selectMember(String id, String password) throws NoSuchFieldException {
		MemberVO bean = null;
		
		String sql = "select * from members where \"id\" = ? and \"password\" = ? " ;
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null;

		try {
			conn = super.getConnection();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, id);
			pstmt.setString(2, password);

			rs = pstmt.executeQuery();

			if(rs.next()) {
				bean = new MemberVO();
				bean.setId(rs.getString("id"));
				bean.setPassword(rs.getString("password"));
				bean.setBirth(rs.getDate("birth"));
				bean.setLevel(rs.getString("level"));
				bean.setName(rs.getString("name"));
				bean.setPhone(rs.getString("phone"));
				bean.setPicture(rs.getString("picture"));
				bean.setPoint(rs.getInt("point"));
			}else {
				throw new NoSuchFieldException("로그인에 실패함!");
			}
			System.out.println(bean);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) {rs.close();}
				if(pstmt != null) {pstmt.close();}
				if(conn != null) {conn.close();}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return bean;
	}

	
	public int NewData(MemberVO bean) {
		System.out.println( bean.toString() ); 
		String sql = "insert into members (\"id\", \"password\", \"name\", \"birth\", \"phone\", \"level\", \"point\", \"picture\")" +
				" values(?,?,?,?,?,default,default,'default.jpg')" ;

		PreparedStatement pstmt = null ;
		int cnt = -99999 ;
		try {
			conn = super.getConnection() ;
			conn.setAutoCommit( false );
			pstmt = super.conn.prepareStatement(sql) ;

			pstmt.setString(1, bean.getId() );
			pstmt.setString(2, bean.getPassword());
			pstmt.setString(3, bean.getName() );
			pstmt.setDate(4, new java.sql.Date(bean.getBirth().getTime()));
			pstmt.setString(5, bean.getPhone());
			
			cnt = pstmt.executeUpdate() ; 
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback(); 
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		} finally{
			try {
				if( pstmt != null ){ pstmt.close(); }
				if(conn != null){conn.close();} 
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return cnt ;
	}	
		
		



}
