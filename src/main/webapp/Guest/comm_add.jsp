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
String id = (String)session.getAttribute("id");
if(session.getAttribute("id") == null)
{
	id = request.getParameter("comm_id");
}
String content = request.getParameter("comm_content");
int num = Integer.parseInt(request.getParameter("num"));

GuestBookBean gb = new GuestBookBean();
gb.setId(id);
gb.setContent(content);
gb.setNum(num);
GuestBookDAO dao = new GuestBookDAO();

int a = dao.addComm(gb);
if(a == 1)
{
	response.sendRedirect("comment.jsp?num=" + num);
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

