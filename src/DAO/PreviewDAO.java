package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import VO.MemberVO;

public class PreviewDAO extends SuperDAO{
	
	HttpServletRequest request;
	
	public PreviewDAO(HttpServletRequest request) {
		this.request = request;
	}
	
	public int addReview() {
		
		MemberVO bean = null;
		
		String sql = "insert into p_review values(seq_review.nextval,1,?,?,sysdate,?)" ;
		Connection conn = null ; 
		PreparedStatement pstmt = null ;
		int result = 0;

		try {
			System.out.println("content : "+request.getParameter("content").toString());
			System.out.println("grade : "+request.getParameter("grade").toString());
			System.out.println("id : "+request.getParameter("id").toString());
			conn = super.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, request.getParameter("content").toString());
			pstmt.setString(2, request.getParameter("grade").toString());
			pstmt.setString(3, request.getParameter("id").toString());
			result = pstmt.executeUpdate();
			conn.commit(); 
			
		} catch (Exception e) {
			SQLException err = (SQLException)e ;			
			result = err.getErrorCode() ;			
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
		return result;
	}
}
