<%@page import="board.BoardDAO"%>
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
	String pass = request.getParameter("pass");
	
	BoardDAO bDAO = new BoardDAO();
	
	int a = bDAO.deleteContent(num,pass);
	

	if (a == 1) 
	{
		response.sendRedirect("notice.jsp");
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