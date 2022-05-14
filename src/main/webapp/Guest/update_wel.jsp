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
String subject = request.getParameter("subject");
String content = request.getParameter("content");
int num = Integer.parseInt(request.getParameter("num"));

int a = new GuestBookDAO().update(subject,content,num);
if(a == 1)
{%>
	<script type="text/javascript">
	alert("수정완료");
	opener.document.location.reload();

	self.close();

	</script>
<%
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