<%@page import="member.MemberBean"%>
<%@page import="java.util.List"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style type="text/css">
 table, th, td {
    border:1px solid #35a;
   }

 table {
  width:500px; 
  height:300px;
  text-align: center;
 }
 .title{
  font-weight: bold;
  font-size: 17px;
 }
 </style>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">

</head>
<body>
<div id="wrap">
<!-- 헤더가 들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더가 들어가는 곳 -->

<!-- 본문 들어가는 곳 -->
<!-- 서브페이지 메인이미지 -->
<div id="sub_img"></div>
<article>
<h1>List</h1>
<%
MemberDAO mDAO = new MemberDAO();

List<Object> memberList = mDAO.getMemberList();

%>
<table border="1">
<tr class="title"><td>아이디</td><td>비밀번호</td><td>이름</td><td>가입날짜</td><td>회원삭제</td></tr>
<%
for(int i = 0; i < memberList.size(); i++)
{	
	MemberBean mb = (MemberBean)memberList.get(i);
%>
<tr><td><%=mb.getId() %></td><td><%=mb.getPass() %></td><td><%=mb.getName() %></td><td><%=mb.getReg_data() %></td><td><a href="listDel.jsp?id=<%=mb.getId()%>">삭제</a></td></tr>
<%
}
%>
</table>
</article>
<!-- 내용 -->
<!-- 본문 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>



    