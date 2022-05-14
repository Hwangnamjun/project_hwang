<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.List"%>
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
int num = Integer.parseInt(request.getParameter("num"));
String id=(String)session.getAttribute("id");
GuestBookBean gb = new GuestBookBean();
GuestBookDAO dao = new GuestBookDAO();

gb = dao.content(num);

SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
%>
<table border="1">
<tr>
<td>번호:<%=gb.getNum()%></td><td>날짜:<%=gb.getDate() %></td>
</tr>
<tr>
<td>아이디:<%=gb.getId()%></td><td>제목:<%=gb.getSubject() %></td>
</tr>
<tr>
<td colspan="2"><textarea style="width:650px;height:50px;resize: none;" readonly="readonly"><%=gb.getContent() %></textarea></td>
</tr>
</table>
<%
List<GuestBookBean> lgb = dao.getComment(num);

for(int i = 0; i < lgb.size(); i++)
{
	GuestBookBean gbb = (GuestBookBean)lgb.get(i);
	Date date = new Date(gbb.getDate().getTime());
	String splitNum = gbb.getSubject();
	String arry[] = splitNum.split("_");
	int change = Integer.parseInt(arry[1]);
%>
<table>
<tr>
<td>No.<%=change%></td><td><%=gbb.getId()%></td><td><%=gbb.getDate() %></td>
<%
if(id != null)
{
	if(id.equals(gbb.getId()))
	{
%>
<td>
<input type="button" value="delete" onclick="location.href='comm_delete.jsp?num=<%=gbb.getNum() %>&a=<%=num%>'">
</td>
<%}} %>
</tr>
</table>
<p style="font-size: 15px; color: blue;">
<%=gbb.getContent() %>
</p>
<!-- <textarea style="width:650px;height:50px;resize: none;" readonly="readonly"></textarea> -->
<%} %>
<form action="comm_add.jsp" method="post">
<%
if(id != null)
{%>
<table border="1">
<tr>
	<td>작성자</td><td><input type="text" name="comm_id" value="<%=id %>" readonly="readonly"></td>
</tr>
<tr>
<td>내용</td><td><textarea style="width:596px;height:50px;resize: none;" name="comm_content"></textarea></td>
</tr>
<tr>
<td><input type="hidden" name="num" value="<%=gb.getNum() %>"><input type="submit" name="add" value="add"></td>
</tr>
</table>
<%}%>
</form>
</body>
</html>