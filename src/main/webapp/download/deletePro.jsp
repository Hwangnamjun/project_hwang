<%@page import="java.io.File"%>
<%@page import="upload.FileDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>jsp5/deletePro.jsp</h1>
	<%
		//한글처리
	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String file = request.getParameter("file");
	String pass = request.getParameter("pass");
	
	FileDAO fDAO = new FileDAO();
	
	int a = fDAO.deleteContent(num,pass);
	

	if (a == 1) 
	{
		String fileName = file;
		String fileDir = "Upload"; //지울 파일이 존재하는 디렉토리
		String filePath = request.getRealPath(fileDir) + "\\"; //파일이 존재하는 실제경로
		filePath += fileName;

		   File f = new File(filePath); // 파일 객체생성
		   if( f.exists()) f.delete(); // 파일이 존재하면 파일을 삭제한다.
		
		response.sendRedirect("board.jsp");
	} 
	else if(a == 0)
	{
			// "비밀번호 틀림" 뒤로이동
	%>
	<script type="text/javascript">
		alert("비밀번호 틀림");
		history.back();
	</script>
	<%
	}
	else if(a == -1)
	{
		%>
		<script type="text/javascript">
			alert("num 없음");
			history.back();
		</script>
		<%
	}
%>
</body>
</html>