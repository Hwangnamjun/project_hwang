package upload;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class UploadService
 */
@WebServlet("/UploadService")
public class UploadService extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String fileName = request.getParameter("file");
		System.out.println(fileName);
		ServletContext context = getServletContext(); // 어플리케이션에 대한 정보를 ServletContext 객체가 갖게 됨.
		File targetDir = new File(context.getRealPath("Upload"));  
		
		if(!targetDir.exists()) {    //디렉토리 없으면 생성.
			targetDir.mkdirs();
		}
		String saveDir = context.getRealPath("Upload"); // 절대경로를 가져옴


		int maxSize = 3 * 1024 * 1024; // 3MB
		String encoding = "UTF-8";
		System.out.println("절대경로 >> " + saveDir);

		boolean isMulti = ServletFileUpload.isMultipartContent(request);// boolean타입. ??????
        if (isMulti) {
              MultipartRequest multi = new MultipartRequest(request, saveDir, maxSize, encoding,
                          new DefaultFileRenamePolicy());
              FileDAO dao = new FileDAO();
              String author = multi.getParameter("author");
              String title = multi.getParameter("title");
              String file = multi.getFilesystemName("file");
              String pass = multi.getParameter("pass");
              try {
                    int result = dao.uploadFile(author, title, file, pass);
                    if (result > 0) {
                          System.out.println("저장완료");
                          response.sendRedirect("download/board.jsp");
                    } else {
                          System.out.println("저장실패");
                          response.sendRedirect("download/uploadForm.jsp");
                    }

              } catch (Exception e) {
                    e.printStackTrace();
              }
        } else {
              System.out.println("일반 전송 form 입니다.");
        }
	}

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UploadService() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
