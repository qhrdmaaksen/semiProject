package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import VO.AddressVO;


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

	

	public int InsertData(AddressVO bean) {
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
			pstmt.setString(6, bean.getPhone());
			
			
			
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
	
	public AddressVO SelectDateByPK(String id) {
		String sql = "select \"seq_add\", \"id\", \"shippingname\", \"name\", \"address1\", \"address2\", \"phone\" from ("
				+ "select \"seq_add\", \"id\", \"shippingname\", \"name\", \"address1\", \"address2\", \"phone\", rank() over (order by \"seq_add\" desc) ranking from ADDRESSES where \"id\"=? order by \"seq_add\""
				+ ") where ranking in(1)";
		
		conn = null ;
        PreparedStatement pstmt = null ;
        ResultSet rs = null ;

        AddressVO address = new AddressVO();
        try {
            conn = super.getConnection() ;
            pstmt = conn.prepareStatement(sql) ;

            pstmt.setString(1, id);

            rs = pstmt.executeQuery() ;
            while( rs.next() ){
            	address.setSeq_add(rs.getInt("seq_add"));
            	address.setId(rs.getString("id"));
            	address.setShippingname(rs.getString("shippingname"));
            	address.setName(rs.getString("name"));
            	address.setAddress1(rs.getString("address1"));
            	address.setAddress2(rs.getString("address2"));
            	address.setPhone(rs.getString("phone"));
            }
        } catch (Exception e) {
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
        return address ;
	}





	public List<AddressVO> selectAllAddress(String id) {
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		
		int cnt = -99999;
	      String sql = " select * from \"ADDRESSES\" where \"id\"=? ";
		List<AddressVO> lists = new ArrayList<AddressVO>();

		try {
			conn = super.getConnection() ;
			pstmt = conn.prepareStatement(sql) ;
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery() ;			
			while( rs.next() ){
				AddressVO bean = new AddressVO();
				bean.setSeq_add(rs.getInt("seq_add"));
				bean.setAddress1(rs.getString("address1"));
				bean.setAddress2(rs.getString("address2"));
				bean.setId(rs.getString("id"));
				bean.setName(rs.getString("name"));
				bean.setPhone(rs.getString("phone"));
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

	public List<AddressVO> SelectDataList(String id, int beginRow, int endRow, String mode, String keyword) {
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
	      
		List<AddressVO> lists = new ArrayList<AddressVO>();

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
				AddressVO bean = new AddressVO();
				bean.setAddress1(rs.getString("address1"));
				bean.setAddress2(rs.getString("address2"));
				bean.setId(rs.getString("id"));
				bean.setName(rs.getString("name"));
				bean.setPhone(rs.getString("phone"));
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