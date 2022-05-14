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
// int num  num파라미터 가져오기
int num = Integer.parseInt(request.getParameter("num"));

BoardBean bb = new BoardBean();
BoardDAO bDAO = new BoardDAO();

bb = bDAO.checkContent(num);

// 5단계 rs 다음행으로 이동 name,subject,content
%>
<form action="updatePro.jsp" method="post">
<input type="hidden" name="num" value="<%=num%>">
<table border="1" id="content_table">
<tr><td>글쓴이</td><td><input type="text" name="name" value="<%=bb.getName()%>"></td></tr>
<tr><td>비밀번호</td><td><input type="password" name="pass"></td></tr>
<tr><td>제목</td><td><input type="text" name="subject" value="<%=bb.getSubject()%>"></td></tr>
<tr><td>내용</td>
<td><textarea rows="20" cols="30" style="width:530px;height:400px;resize: none;" name="content" id="content_area"><%=bb.getContent()%></textarea></td></tr>
<tr><td colspan="2"><input type="submit" value="update"><input type="button" value="cancle" onclick="location.href='content.jsp?num=<%=num %>'"></td></tr>
</table>
</form>
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

