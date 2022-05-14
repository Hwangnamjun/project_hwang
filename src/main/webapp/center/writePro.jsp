<%@page import="board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="board.BoardBean"%>
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
</head>
<body>
<h1>jsp5/writePro.jsp</h1>
<%
//한글처리
request.setCharacterEncoding("utf-8");

BoardBean bb = new BoardBean();
//name pass subject content 파라미터 가져오기
bb.setName(request.getParameter("name"));
bb.setPass(request.getParameter("pass"));
bb.setSubject(request.getParameter("subject"));
bb.setContent(request.getParameter("content"));
bb.setReadcount(0);
bb.setDate(new Timestamp(System.currentTimeMillis()));

BoardDAO bDAO = new BoardDAO();

bDAO.insertBoard(bb);

//list.jsp 글목록 이동
response.sendRedirect("notice.jsp");
%>

</body>
</html>






