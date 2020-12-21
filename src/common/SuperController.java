package common;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public interface SuperController {
    public void doGet(HttpServletRequest request,
                      HttpServletResponse response)
            throws ServletException, IOException;

    public void doPost(HttpServletRequest request,
                       HttpServletResponse response)
            throws ServletException, IOException ;
}
