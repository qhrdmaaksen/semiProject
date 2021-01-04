package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import VO.MemberVO;
import VO.PreviewVO;

public class PreviewDAO extends SuperDAO{
	
	HttpServletRequest request; //null
	
	
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

	public List<PreviewVO> listsSelect() {
			PreviewVO bean = null;
			Connection conn = null ;
			PreparedStatement pstmt = null ;
			ResultSet rs = null ;
			
			String sql = "select * from p_review order by \"seq_review\"";
			int result = 0;
			
			List<PreviewVO> lists = new ArrayList<PreviewVO>() ;
		try {
			conn = super.getConnection() ;
			pstmt = conn.prepareStatement(sql) ;
			
			rs = pstmt.executeQuery() ;
			while(rs.next()) {
				bean = new PreviewVO();
				bean.setReviewno(rs.getInt("seq_review")); 
				bean.setId(rs.getString("id")); 
				bean.setContent(rs.getString("content")); 
			    bean.setPostdate(rs.getString("postdate")); 
				bean.setGrade(rs.getInt("grade"));
				lists.add(bean) ;
			}
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
		return lists;
	}

	public int UpdateData(PreviewVO bean) {
		String sql = " update p_review set  ";
		sql += " seq_review=?, id=?, content=?, postdate=? " ;
		sql += " where seq_review = ? " ;    
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		int cnt = -999999 ;

		try {
			conn = super.getConnection() ;
			pstmt = conn.prepareStatement(sql) ;

			// placeholder
			pstmt.setInt(1, bean.getReviewno());
			pstmt.setString(2, bean.getId());
			pstmt.setString(3, bean.getContent());
			pstmt.setString(4, bean.getPostdate());
			
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

	public PreviewVO selectdatabypk(int no) {
		// 해당 게시물 번호의 Bean 객체를 구합니다.
				PreviewVO bean = null ;
				
				String sql = " select * from p_review ";
				sql += " where seq_review = ? " ;
				
				Connection conn = null ;
				PreparedStatement pstmt = null ;
				ResultSet rs = null ;
				
				try {
					conn = super.getConnection() ;
					pstmt = conn.prepareStatement(sql) ;

					// placeholder		
					pstmt.setInt(1, no);
								
					rs = pstmt.executeQuery() ;
					
					while(rs.next()) {
						bean = new PreviewVO() ;
						bean.setReviewno(rs.getInt("seq_review")); 
						bean.setSearchno(rs.getInt("seq_index")); 
						bean.setContent(rs.getString("content")); 				
						bean.setGrade(rs.getInt("grade")); 				
						bean.setPostdate(String.valueOf(rs.getDate("postdate"))); 				
						bean.setId(rs.getString("id")); 
					}
					
					System.out.println("ok");
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
}
