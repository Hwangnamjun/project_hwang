<%@page import="member.MemberDAO"%>
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
<h1>jsp4/loginPro.jsp</h1>
<%
// String id pass 파라미터 가져오기
String id=request.getParameter("id");
String pass=request.getParameter("pass");
int check = -1;
MemberDAO mDAO = new MemberDAO();
check = mDAO.usercheck(id,pass);
//usercheck함수 만들고 호출

	if(check == 1)
	{
		session.setAttribute("id", id);
		// main.jsp 이동
		response.sendRedirect("../main/main.jsp");
	}
	else if(check == 0)
	{
		check = 0;
		%>
		<script type="text/javascript">
			alert("비밀번호가 틀렸습니다");
 			history.back();
		</script>
		<%
	}
	else if(check == -1)
	{
		%>
			<script type="text/javascript">
			alert("아이디를 확인하세요");
			history.back();
			</script>
		<%
	}
%>
</body>
</html>
