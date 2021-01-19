package DAO;

import VO.CouponVO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CouponDAO extends SuperDAO{
    public int CountCoupons(String id) {
        conn = null ;
        PreparedStatement pstmt = null ;
        ResultSet rs = null ;

        String sql = "SELECT COUNT(*) AS cnt FROM COUPONS WHERE \"id\" IN(?) AND \"use\" = 0 ";
        int cnt = -999999 ;

        try {
            conn = super.getConnection() ;
            pstmt = conn.prepareStatement(sql) ;

            pstmt.setString(1, id);

            rs = pstmt.executeQuery() ;

            if ( rs.next() ) {
                cnt = rs.getInt("cnt");
            }

        } catch (SQLException e) {
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

    public List<CouponVO> SelectCoupons(String id, int used, int beginRow, int endRow) {
        conn = null ;
        PreparedStatement pstmt = null ;
        ResultSet rs = null ;

        String sql = "SELECT * FROM (SELECT \"no\", \"name\", \"kind\", \"discount\", \"exp\", RANK() OVER(ORDER BY \"no\" DESC) AS rank FROM coupons WHERE \"id\" IN(?) AND \"use\" = ? ) WHERE rank BETWEEN ? AND ? ";

        List<CouponVO> lists = new ArrayList<CouponVO>();
        System.out.println("id : "+id+",used : "+used+",beginRow : "+beginRow+ ",endRow : "+endRow);
        try {
            conn = super.getConnection() ;
            pstmt = conn.prepareStatement(sql) ;

            pstmt.setString(1, id);
            pstmt.setInt(2, used);
            pstmt.setInt(3, beginRow);
            pstmt.setInt(4, endRow);

            rs = pstmt.executeQuery() ;
            while( rs.next() ){
                CouponVO coupon = new CouponVO();
                coupon.setNo(rs.getString("no"));
                coupon.setName(rs.getString("name"));
                coupon.setDiscount(rs.getFloat("discount"));
                coupon.setExp(rs.getDate("exp"));
                coupon.setKind(rs.getInt("kind"));

                lists.add(coupon) ;
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

        return lists ;
    }
    
    public List<CouponVO> selectAllCoupons(String id) {
		Connection conn = null ;
		PreparedStatement pstmt = null ;
		ResultSet rs = null ;
		
		int cnt = -99999;
	    String sql = "select * from COUPONS where \"id\"=? AND \"use\" = 0";
		List<CouponVO> lists = new ArrayList<CouponVO>();

		try {
			conn = super.getConnection() ;
			pstmt = conn.prepareStatement(sql) ;
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery() ;			
			while( rs.next() ){
				CouponVO coupon = new CouponVO();
                coupon.setNo(rs.getString("no"));
                coupon.setName(rs.getString("name"));
                coupon.setDiscount(rs.getFloat("discount"));
                coupon.setExp(rs.getDate("exp"));
                coupon.setKind(rs.getInt("kind"));
				
				lists.add(coupon) ;
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
