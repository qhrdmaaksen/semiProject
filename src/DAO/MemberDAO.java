package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import VO.MemberVO;

public class MemberDAO extends SuperDAO {


	public MemberVO Insertdate(String id, String password) {

		MemberVO bean = null;
		
		String sql = "select * from members where id = ? and password = ? " ;
		
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
				bean.setId(rs.getString("id"));
				bean.setPassword(rs.getString("password"));
				bean.setCoupon(rs.getInt("coupon"));
				bean.setDate(rs.getInt("date"));
				bean.setLevel(rs.getString("level"));
				bean.setName(rs.getString("name"));
				bean.setPhone(rs.getString("phone"));
				bean.setPicture(rs.getString("picture"));
				bean.setPoint(rs.getInt("point"));
				
			}
			
			System.out.println("성공");
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
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

}
