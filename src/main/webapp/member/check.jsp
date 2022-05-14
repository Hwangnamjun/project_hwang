<%@page import="member.MemberDAO"%>
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

String id = request.getParameter("id");
MemberDAO mDAO = new MemberDAO();

boolean a = mDAO.checkID(id);

if(id != "" && a == true)
{
%>
	<script type="text/javascript">
	var sendId = "<%=id %>";
	opener.setIdValue(sendId);
		alert("유효한 아이디입니다");
		window.close();
		</script>
		<%}	
	else
		{%>
	<script>
	alert("유효 하지 않은 아이디입니다");
	history.back();
	</script>
<%}%>
</body>
</html>