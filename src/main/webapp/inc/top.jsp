<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<header>
<%
String id=(String)session.getAttribute("id");
if(id == null)
{%>
<div id="login"><a href="../member/login.jsp">login</a> | <a href="../member/join.jsp">join</a></div>	
<%}
else
{%>
	<div id="login"><%=id %>님 | <a href="../member/updateform.jsp"> 회원정보수정</a>
		<%
	if(id.equals("admin"))
	{%>
		 | <a href="../member/list.jsp">회원목록</a>
	<%}
	%>
	 | <a href="../member/logout.jsp">Logout</a>
	</div>
<%}
%>
<div class="clear"></div>
<!-- 로고들어가는 곳 -->
<div id="logo"><img src="../images/logo.gif" width="260" height="62" alt="Fun Web"></div>
<!-- 로고들어가는 곳 -->
<nav id="top_menu">
<ul>
	<li><a href="../main/main.jsp">HOME</a></li>
	<li><a href="../Guest/welcome.jsp">COMMENT</a></li>
	<%
	if(id != null)
	{%>
	<li><a href="../mail/mailForm.jsp">SEND MAIL</a></li>		
	<%}
	%>
	<li><a href="../center/notice.jsp">CUSTOMER CENTER</a></li>
	<li><a href="../download/board.jsp">DOWNLOAD</a></li>
</ul>
</nav>
</header>
