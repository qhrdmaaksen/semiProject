package DAO;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class PointDAO extends SuperDAO{
    public int selectExtinctionPoint(String id) {
        String sql = "SELECT SUM(\"po_bal\") AS sum FROM POINT_BALANCE WHERE \"seq_point\" IN(" +
                "SELECT \"seq_point\" FROM points WHERE \"plma\" = 0 AND \"po_date\">? AND \"po_date\"<?) ORDER BY \"seq_point\"";

        conn = null ;
        PreparedStatement pstmt = null ;
        ResultSet rs = null ;
        int result = -1;

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar fromtime = Calendar.getInstance();
        Calendar totime = Calendar.getInstance();
        fromtime.add(Calendar.MONTH, -3);
        totime.add(Calendar.MONTH, -2);

        try {
            conn = super.getConnection() ;
            pstmt = conn.prepareStatement(sql) ;
            pstmt.setDate(1, new java.sql.Date(fromtime.getTimeInMillis()));
            pstmt.setDate(2, new java.sql.Date(totime.getTimeInMillis()));

            rs = pstmt.executeQuery() ;

            while(rs.next()) {
                result = rs.getInt("sum");
            }

            System.out.println("ok");
        } catch (Exception e) {
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

        return result;
    }
}
