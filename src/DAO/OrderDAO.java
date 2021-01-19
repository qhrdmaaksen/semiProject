package DAO;

import VO.OrderVO;
import VO.ProductVO;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO extends SuperDAO {
    // index에서 사용할 판매량 가장많은 4개 상품을 출력
    public List<ProductVO> SelectTop4Lists(){
        PreparedStatement pstmt = null ;
        ResultSet rs = null ;

        String sql = "SELECT * FROM (" +
                "SELECT \"productcode\", \"sum\", rank() over (order by \"sum\" desc) as \"ranking\" FROM (" +
                "SELECT \"productcode\",SUM(\"qty\") AS \"sum\" FROM DETAIL_ORDER WHERE \"ordernumber\" IN (" +
                "SELECT \"ordernumber\" FROM ORDERS WHERE \"orderdate\" BETWEEN (" +
                "SELECT TRUNC(TRUNC(SYSDATE, 'MM')-1, 'MM') FROM DUAL) AND (" +
                "SELECT TRUNC(SYSDATE, 'MM')-1 FROM DUAL))  GROUP BY \"productcode\")) WHERE \"ranking\" BETWEEN 1 AND 5";

        List<ProductVO> lists = new ArrayList<ProductVO>();

        try {
            super.conn = super.getConnection() ;
            pstmt = super.conn.prepareStatement(sql) ;

            rs = pstmt.executeQuery() ;
            ProductDAO pdao = new ProductDAO();
            while (lists.size()<4){
                rs.next();
                ProductVO product = pdao.SelectDataByPk(rs.getInt("productcode"));
                lists.add(product);
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

    public void insertOrder(OrderVO order) {
        String sql = "insert into ORDERS(\"ordernumber\", \"id\", \"seq_add\", \"paykind\", \"shippingstatus\", \"invoice\", \"orderdate\") values(?, ?, ?, ?, default, ?, ?)";
        conn = null ;
        PreparedStatement pstmt = null ;
        int cnt = -999999 ;

        try {
            conn = super.getConnection() ;
            pstmt = conn.prepareStatement(sql) ;

            pstmt.setInt(1, order.getOrdernumber());
            pstmt.setString(2, order.getId());
            pstmt.setInt(3, order.getSeq_add());
            pstmt.setInt(4, order.getPaykind());
            pstmt.setString(5, order.getInvoice());
            pstmt.setDate(6, new java.sql.Date(order.getOrderdate().getTime()));

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
