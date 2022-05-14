<%@page import="comment.GuestBookDAO"%>
<%@page import="comment.GuestBookBean"%>
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

GuestBookBean gb = new GuestBookBean();
String id=(String)session.getAttribute("id");

String subject = request.getParameter("subject");
String content = request.getParameter("content");
gb.setId(id);
gb.setSubject(subject);
gb.setContent(content);
GuestBookDAO dao = new GuestBookDAO();
int a = dao.insert(gb);

if(a == 1)
{
	%>
	<script type="text/javascript">
		alert("작성완료");
		location.href="welcome.jsp";
	</script>
	<%
}
else
{
	%>
	<script type="text/javascript">
		alert("오류발생");
		location.href="welcome.jsp";
	</script>
	<%
}
%>
</body>
</html>