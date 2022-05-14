<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ImagePreview</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String file = request.getParameter("file");

String root = request.getSession().getServletContext().getRealPath("/");
String img = root + "Upload\\" + file;
%>
<img src="${pageContext.request.contextPath}/Upload/<%=file %>" alt="<%=file%>" width="800px" height="700px">
</body>
</html>