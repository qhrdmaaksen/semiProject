package common;


import com.oreilly.servlet.MultipartRequest;
import utility.MainUtility;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(urlPatterns = {"/dodamdodam"},
        initParams = {
                @WebInitParam(name="configFile", value="/WEB-INF/command.txt"),
                @WebInitParam(name="debugMode", value="false")
        })
public class Controller extends HttpServlet {
    private Map<String, SuperController> todolist
            = new HashMap<String, SuperController>();

    private ServletContext application = null;

    //업로드가 되는 실제 경로
    private String uploadedPath = null ;

    public void init(ServletConfig config) throws ServletException {
        super.init();
        String configFile = config.getInitParameter("configFile") ;
        System.out.println("설정 파일 이름 : " + configFile);

        String debugMode = config.getInitParameter("debugMode") ;

        this.application = config.getServletContext() ;

        // 실제 웹 서버 상에 존재하는 설정 파일 이름
        String configFilePath = this.application.getRealPath(configFile);
        this.todolist = MainUtility.getActionMapList(configFilePath) ;

        this.application.setAttribute("debugMode", debugMode);

        // 업로드 폴더가 'upload'라고 가정했습니다.
        this.uploadedPath = this.application.getRealPath("/upload") ;

        this.application.setAttribute("uploadedPath", uploadedPath);
        System.out.println("파일 업로드 경로 : \n" + uploadedPath);
    }

    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String command = request.getParameter("command") ;
        System.out.println("커맨드 파라미터 : " + command);

        if (command==null) {
            //파일 업로드시 여기에 들어옴.
        } else {
            SuperController controller = this.todolist.get(command) ;
            if(controller != null) {
                String method = request.getMethod().toLowerCase();
                if(method.equals("get")) {
                    System.out.println(controller.toString() + " get 호출됨");
                    controller.doGet(request, response);
                }else {
                    System.out.println(controller.toString() + " post 호출됨");
                    controller.doPost(request, response);
                }
            }else {
                System.out.println("command가 널입니다.");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        doProcess(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        doProcess(request, response);
    }
}
