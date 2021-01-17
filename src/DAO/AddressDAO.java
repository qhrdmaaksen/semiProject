package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import VO.AddressVo;
import VO.BbsPostVo;


public class AddressDAO  extends SuperDAO {

	public int SelectTotalCount(String mode, String keyword) {
		// 해당 모드와 키워드를 이용하여 조건에 맞는 데이터의 건수를 구해줍니다. 
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;		
		
		String sql = " select count(*) as cnt from \"ADDRESSES\" " ;  
		
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

	

	public int InsertData(AddressVo bean) {
		String sql = " insert into \"ADDRESSES\" (\"seq_add\", \"id\", \"shippingname\", \"name\", \"address1\", \"address2\", \"phone\" ) " ;
		sql += " values(seq_BP_index.nextval,?,?,?,?,?,? ) " ;
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		int cnt = -999999 ;

		try {
			conn = super.getConnection() ;
			pstmt = conn.prepareStatement(sql) ;

			// placeholder
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getShippingname());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getAddress1());
			pstmt.setString(5, bean.getAddress2());
			pstmt.setInt(6, bean.getPhone());
			
			
			
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

	public BbsPostVo SelctDataByPK(int no) {
		// 해당 게시물 번호의 Bean 객체를 구합니다. 
		BbsPostVo bean = null ;
		
		String sql = " select * from \"BBS_POST\" ";
		sql+= " where \"NO\" = ?" ;
	
				
				Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		
		try {
			conn = super.getConnection() ;
			pstmt = conn.prepareStatement(sql) ;

			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery() ;
			
			while(rs.next()) {
				bean = new BbsPostVo() ;
				
				bean.setContent(rs.getString("content"));
				bean.setId(rs.getString("id"));
				bean.setLikenumber(rs.getInt("likenumber"));
				bean.setNo(rs.getInt("no"));
				bean.setPostdate(rs.getDate("postdate"));
				bean.setTitle(rs.getString("title"));
				bean.setImage(rs.getString("image"));		
				
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

	public int UpdateReadhit(int num) {
		String sql = " update \"bbs_post\" set likenumber = likenumber + 1 ";
		sql += " where no = ? ";    
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		int cnt = -999999 ;

		try {
			conn = super.getConnection() ;
			pstmt = conn.prepareStatement(sql) ;

			pstmt.setInt(1, num);
			
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

	public int DeleteData(int no) {
		String sql = " delete from \"BBS_POST\" where no = ? " ;
		
		PreparedStatement pstmt = null ;
		int cnt = -99999 ;
		try {
			if( conn == null ){ super.conn = super.getConnection() ; }
			conn.setAutoCommit( false );
			pstmt = super.conn.prepareStatement(sql) ;
			
			pstmt.setInt(1, no);
			
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


	public int UpdateData(BbsPostVo bean) {
		// 해당 게시물을 수정합니다. 
		String sql = " update \"BBS_POST\" set ";
		sql += " \"content\" = ?, \"likenumber\" = ?, \"title\" = ?, \"id\" = ?, \"IMAGE\" = ?  ";
		sql += " where no = ? ";
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		int cnt = -999999 ;

		try {
			conn = super.getConnection() ;
			pstmt = conn.prepareStatement(sql) ;

			pstmt.setString(1, bean.getContent());
			pstmt.setInt(2, bean.getLikenumber());
			pstmt.setString(3, bean.getTitle());
			pstmt.setString(4, bean.getId());
			pstmt.setString(5, bean.getImage());
			pstmt.setInt(6, bean.getNo());
			
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



	public List<AddressVo> SelectDataList(String id, int beginRow, int endRow, String mode, String keyword) {
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		
		int cnt = -99999;
	      String sql = " select \"seq_add\", \"id\", \"shippingname\", \"name\", \"address1\", \"address2\", \"phone\" " ;
	      sql += " from \"ADDRESSES\" " ;
	      sql += " where \"id\" = ? ";
	      
			/*
			 * if(mode.equalsIgnoreCase("all")== false) { sql+= " where " + mode +
			 * " like '"+ keyword +"%' " ; System.out.println(sql); }
			 * 
			 * sql += " ) " ; sql += " where ranking between ?  and ?  " ;
			 */
	      
		List<AddressVo> lists = new ArrayList<AddressVo>();

		try {
			conn = super.getConnection() ;
			pstmt = conn.prepareStatement(sql) ;

			// placeholder1
			/*
			 * pstmt.setInt(1, beginRow); pstmt.setInt(2, endRow);
			 */
			
			pstmt.setString(1, id);
			
			
			rs = pstmt.executeQuery() ;			
			while( rs.next() ){
				AddressVo bean = new AddressVo();
				bean.setAddress1(rs.getString("address1"));
				bean.setAddress2(rs.getString("address2"));
				bean.setId(rs.getString("id"));
				bean.setName(rs.getString("name"));
				bean.setPhone(rs.getInt("phone"));
				bean.setSeq_add(rs.getInt("seq_add"));
				bean.setShippingname(rs.getString("shippingname"));
				
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
}