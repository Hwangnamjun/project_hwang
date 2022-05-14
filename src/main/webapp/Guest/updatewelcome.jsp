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
int num = Integer.parseInt(request.getParameter("num"));

GuestBookBean gb = new GuestBookBean();
gb = new GuestBookDAO().check(num);
%>
<form action="update_wel.jsp" method="post">
<table border="1">
<tr>
<td><%=gb.getNum() %></td><td>날짜:<%=gb.getDate() %></td>
</tr>
<tr>
<td><%=gb.getId() %></td><td>제목:<input type="text" name="subject" value="<%=gb.getSubject() %>"></td>
</tr>
<tr>
<td>내용</td><td><textarea style="width:605px;height:50px;resize: none;" name="content"><%=gb.getContent() %></textarea></td>
</tr>
</table>
<input type="hidden" name="num" value="<%=num %>">
<input type="submit" value="submit">
</form>
</body>
</html>