<%@page import="comment.GuestBookDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
int num = Integer.parseInt(request.getParameter("num"));

int a = new GuestBookDAO().delete(num);
if(a == 1)
{
	response.sendRedirect("welcome.jsp");
}
else
{
	%>
	<script type="text/javascript">
		alert("오류발생");
		history.back();
	</script>
	<%
}
%>
</body>
</html>