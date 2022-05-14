<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.sql.Timestamp"%>
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
String pass = request.getParameter("pass");
String pass2 = request.getParameter("pass2");
String name = request.getParameter("name");
Timestamp reg_data = new Timestamp(System.currentTimeMillis());
String address = request.getParameter("address");
String phone = request.getParameter("phone");
String mobile = request.getParameter("mobile");
String email = request.getParameter("email");
String email2 = request.getParameter("email2");
if(!pass.equals(pass2))
{%>
	<script type="text/javascript">
alert("비밀번호가 일치하지 않습니다");
location.href="join.jsp";
</script>
<%}
else if(!email.equals(email2))
{%>
<script type="text/javascript">
alert("이메일이 일치하지 않습니다");
location.href="join.jsp";
</script>
<%}
MemberBean mb = new MemberBean();
mb.setId(id);
mb.setName(name);
mb.setPass(pass);
mb.setReg_data(reg_data);
mb.setAddress(address);
mb.setPhone(phone);
mb.setMobile(mobile);
mb.setEmail(email);

MemberDAO member_D = new MemberDAO();
member_D.insertMember(mb);
%>
<script type="text/javascript">
alert("회원가입완료");
location.href="login.jsp";
</script>
</body>
</html>