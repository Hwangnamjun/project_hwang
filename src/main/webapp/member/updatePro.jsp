<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
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
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
String pass = request.getParameter("pass");
String pass2 = request.getParameter("pass2");
String name = request.getParameter("name");
String id = (String)session.getAttribute("id");
String email = request.getParameter("email");
String address  = request.getParameter("address");
String phone = request.getParameter("phone");
String mobile = request.getParameter("mobile");

MemberDAO mDAO = new MemberDAO();
int check = mDAO.usercheck(id, pass2);
MemberBean mb = new MemberBean();
mb.setId(id);
mb.setPass(pass);
mb.setName(name);
mb.setEmail(email);
mb.setAddress(address);
mb.setPhone(phone);
mb.setMobile(mobile);

if(check == 1)
{
	mDAO.updateMember(mb);
	out.println("<script>alert('수정이 완료되었습니다'); location.href='../main/main.jsp';</script>");
}
else if(check == 0)
{
	//비밀번호 틀림 뒤로이동
	%>
	<script type="text/javascript">
		alert("비밀번호가 틀렸습니다");
			history.back();
	</script>
	<%
}
else if(check == -1)
{
	//아이디틀림 뒤로이동
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