<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
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
<h1>jsp5/updatePro.jsp</h1>
<%
//한글처리
request.setCharacterEncoding("utf-8");

BoardBean bb = new BoardBean();

bb.setNum(Integer.parseInt(request.getParameter("num")));
bb.setName(request.getParameter("name"));
bb.setPass(request.getParameter("pass"));
bb.setSubject(request.getParameter("subject"));
bb.setContent(request.getParameter("content"));

BoardDAO bDAO = new BoardDAO();

int a = bDAO.updateContent(bb);

	if(a == 1)
	{
		response.sendRedirect("content.jsp?num=" + bb.getNum());
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


