<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">Notice</a></li>
<li><a href="#">Public News</a></li>
<li><a href="#">Driver Download</a></li>
<li><a href="#">Service Policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<article>
<h1>Content</h1>
<%
String id=(String)session.getAttribute("id");
// int num = num파라미터 가져오기
int num =Integer.parseInt(request.getParameter("num"));

BoardBean bb = new BoardBean();
BoardDAO bDAO = new BoardDAO();

bb = bDAO.contentview(num);

%>
	<table border="1" id="content_table">
<tr><td>글번호</td><td><%=num %></td>
    <td>조회수</td><td><%=bb.getReadcount() %></td></tr>
<tr><td>글쓴이</td><td><%=bb.getName() %></td>
    <td>작성일</td><td><%=bb.getDate() %></td></tr>
<tr><td>글제목</td><td colspan="3"><%=bb.getSubject() %></td></tr>
<tr><td>내용</td><td colspan="3" id="content"><%=bb.getContent() %></td></tr>
<tr><td colspan="4">
<%
if(id !=null && id.equals(bb.getName()))
{%>
<input type="button" value="update" 
onclick="location.href='updateForm.jsp?num=<%=bb.getNum()%>'">
<input type="button" value="delete" 
onclick="location.href='deleteForm.jsp?num=<%=bb.getNum()%>'">
<%} %>
<input type="button" value="list" 
onclick="location.href='notice.jsp'"></td></tr>
</table>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>





