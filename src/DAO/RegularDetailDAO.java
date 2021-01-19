package DAO;

import VO.OrderdetailVO;
import VO.RegularDetailVO;

import java.sql.PreparedStatement;

public class RegularDetailDAO extends SuperDAO{
    public void insertOrder(RegularDetailVO detailregular) {
        String sql = "insert into DETAIL_REGULAR_ORDER(\"ordernumber\", \"productcode\", \"amount\", \"orderclosing\") values(?, ?, ?, ?)";
        conn = null ;
        PreparedStatement pstmt = null ;
        int cnt = -999999 ;

        try {
            conn = super.getConnection() ;
            pstmt = conn.prepareStatement(sql) ;

            pstmt.setInt(1, detailregular.getOrdernumber());
            pstmt.setInt(2, detailregular.getProductcode());
            pstmt.setInt(3, detailregular.getAmount());
            pstmt.setDate(4, new java.sql.Date(detailregular.getOrderclosing().getTime()));

            pstmt.executeUpdate() ;
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
                if(pstmt != null){pstmt.close();}
                if(conn != null){conn.close();}
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }
}
