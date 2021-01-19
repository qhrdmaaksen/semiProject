package DAO;


import VO.OrderdetailVO;

import java.sql.PreparedStatement;

public class OrderdetailDao extends SuperDAO {
    public void insertOrder(OrderdetailVO detailorder) {
        String sql = "insert into DETAIL_ORDER(\"ordernumber\", \"productcode\", \"qty\", \"amount\") values(?, ?, ?, ?)";
        conn = null ;
        PreparedStatement pstmt = null ;
        int cnt = -999999 ;

        try {
            conn = super.getConnection() ;
            pstmt = conn.prepareStatement(sql) ;

            pstmt.setInt(1, detailorder.getOrdernumber());
            pstmt.setInt(2, detailorder.getProductcode());
            pstmt.setInt(3, detailorder.getQty());
            pstmt.setInt(4, detailorder.getAmount());

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
