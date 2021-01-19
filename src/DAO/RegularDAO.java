package DAO;

import VO.RegularOrderVO;

import java.sql.PreparedStatement;

public class RegularDAO extends SuperDAO{
    public void insertOrder(RegularOrderVO regularorder) {
        String sql = "insert into REGULAR_ORDER(\"ordernumber\", \"id\", \"seq_add\", \"paykind\", \"shippingstatus\", \"invoice\", \"orderdate\") values(?, ?, ?, ?, default, ?, ?)";
        conn = null ;
        PreparedStatement pstmt = null ;
        int cnt = -999999 ;

        try {
            conn = super.getConnection() ;
            pstmt = conn.prepareStatement(sql) ;

            pstmt.setInt(1, regularorder.getOrdernumber());
            pstmt.setString(2, regularorder.getId());
            pstmt.setInt(3, regularorder.getSeq_add());
            pstmt.setInt(4, regularorder.getPaykind());
            pstmt.setString(5, regularorder.getInvoice());
            pstmt.setDate(6, new java.sql.Date(regularorder.getOrderdate().getTime()));

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
                if(pstmt != null){pstmt.close();}
                if(conn != null){conn.close();}
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }
}
