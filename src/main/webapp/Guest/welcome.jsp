<%@page import="java.sql.Date"%>
<%@page import="comment.GuestBookDAO"%>
<%@page import="comment.GuestBookBean"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<style>
.last{
padding-bottom: 200%;
border-bottom: 200%;
}
</style>
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->

<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
 
</head>
<body>
<div id="wrap">
<!-- 헤더가 들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더가 들어가는 곳 -->

<!-- 본문 들어가는 곳 -->
<!-- 서브페이지 메인이미지 -->
<div id="sub_img"></div>
<!-- 서브페이지 메인이미지 -->
<!-- 왼쪽메뉴 -->
<!-- <nav id="sub_menu"> -->
<!-- <ul> -->
<!-- <li><a href="#">Welcome</a></li> -->
<!-- <li><a href="#">History</a></li> -->
<!-- <li><a href="#">Newsroom</a></li> -->
<!-- <li><a href="#">Public Policy</a></li> -->
<!-- </ul> -->
<!-- </nav> -->
<!-- 왼쪽메뉴 -->
<!-- 내용 -->
<article>
<h1>Guest</h1>
<%
String id=(String)session.getAttribute("id");
if(id != null)
{
%>
<form action="update.jsp" method="post">
<table>
<tr>
<th>제목</th><td><input type="text" name="subject" value="">&nbsp;<input type="submit" value="submit"></td>
</tr>
<tr>
<th>내용</th>
<td><textarea rows="20" cols="30" style="width:530px;height:50px;resize: none;
" name="content" id="content_area"></textarea></td>
</tr>
</table>
</form>
<%} %>
<table border="1">
<%
GuestBookDAO dao = new GuestBookDAO();
int count = dao.getCount();
int pageSize = 3;
String pageNum = request.getParameter("pageNum");
if(pageNum == null)
{
	pageNum = "1";
}
int currentPage = Integer.parseInt(pageNum);

int startRow = (currentPage-1)*pageSize+1;
int endRow = currentPage * pageSize;

List<GuestBookBean> guestList = dao.getlist(startRow,pageSize);

SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
for(int i = 0; i < guestList.size(); i++)
{
	GuestBookBean gb = (GuestBookBean)guestList.get(i);
	Date date = new Date(gb.getDate().getTime());
	int a = new GuestBookDAO().checkCommNum(gb.getNum());
	%>
	<tr>
	<td>번호</td><td><%=gb.getNum()%></td>
	<td>제목</td><td><%=gb.getSubject()%></td>
	<td>아이디</td><td><%=gb.getId()%></td>
	<td>날짜</td><td><%=format.format(date)%></td>
	</tr>
	<tr>
		<td colspan="8" width="550" height="50"><%=gb.getContent() %></td>
	</tr>
	     <tr id= "last">
	     <td>댓글(<%=a %>)</td>
	     <td colspan="7">
	     	<input type="button" value="comment" onclick="window.open('comment.jsp?num=<%=gb.getNum()%>','comment','width=700px,height=600px')">
	     <%
	     if(id != null && id.equals(gb.getId()))
	     {%>
	    	<input type="button" value="update" onclick="window.open('updatewelcome.jsp?num=<%=gb.getNum()%>','comment','width=700px,height=600px')"> 
	   		<input type="button" value="delete" onclick="location.href='deletewelcome.jsp?num=<%=gb.getNum() %>'"> 
	     <%}
	     %>
	     </td>
	     </tr>
	<%}
     %>
</table>
<%
int pageCount = count/pageSize+(count%pageSize==0?0:1);
int pageBlock = 3;

int startPage = (currentPage-1)/pageBlock * pageBlock + 1;

int endPage = startPage + pageBlock -1;

if(endPage > pageCount)
{
	endPage = pageCount;
}
%>
<div id="page_control">
<%
if(startPage > pageBlock){
	%><a href="welcome.jsp?pageNum=<%=startPage-pageBlock%>">Prev</a><%
}
%>
<%
for(int i = startPage; i <= endPage; i++)
{%>

<a href="welcome.jsp?pageNum=<%=i %>"><%=i %></a>

<%}
//다음  끝페이지번호   전체페이지번호
if(endPage < pageCount){
	%><a href="welcome.jsp?pageNum=<%=startPage+pageBlock%>">Next</a><%
}
%>
</div>
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



    