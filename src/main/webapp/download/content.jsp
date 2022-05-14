<%@page import="upload.FileDAO"%>
<%@page import="upload.FileBean"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
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
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">Notice</a></li>
<li><a href="#">Public News</a></li>
<li><a href="#">Driver Download</a></li>
<li><a href="#">Service Policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<article>
<h1>downLoad</h1>
<%
String id=(String)session.getAttribute("id");
// int num = num파라미터 가져오기
int num = Integer.parseInt(request.getParameter("num"));

FileBean bb = new FileBean();
FileDAO fDAO = new FileDAO();

bb = fDAO.contentview(num);

String format[] = {"jpg", "png", "bmp", "jpeg", "tiff", "raw"};
boolean checkImg = false;
for(int a = 0; a < format.length; a++)
{
	if(bb.getFile().contains(format[a]))
	{
		checkImg = true;
	}
}
%>
	<table border="1" id="content_table">
<tr><td>글번호</td><td><%=num %></td></tr>
<tr><td>글쓴이</td><td><%=bb.getAuthor() %></td></tr>
<tr><td>작성일</td><td><%=bb.getDay() %></td></tr>
<tr><td>글제목</td><td><%=bb.getTitle() %></td></tr>
<tr><td>다운로드</td><td width="300px"><a href="fileCheck.jsp?file=<%=bb.getFile()%>"><%=bb.getFile() %></a></td></tr>
<tr><td colspan="4">
<%
if(checkImg)
{%>
<input type="button" value="imagePreview" 
onclick="window.open('preview.jsp?file=<%=bb.getFile() %>','preview','width=800px,height=700px')">
<%}

if(id != null && id.equals(bb.getAuthor()))
{
%>
<input type="button" value="delete" 
onclick="location.href='deleteForm.jsp?num=<%=bb.getNum()%>&file=<%=bb.getFile() %>'">
<%} %>
<input type="button" value="list" onclick="goBack()"></td></tr>
</table>
<script type="text/javascript">
function goBack() {
	window.history.back();
}
</script>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>





