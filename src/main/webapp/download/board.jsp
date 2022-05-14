<%@page import="java.util.List"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="upload.FileDAO"%>
<%@page import="upload.FileBean"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
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
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<!-- <nav id="sub_menu"> -->
<!-- <ul> -->
<!-- <li><a href="#">Notice</a></li> -->
<!-- <li><a href="#">Public News</a></li> -->
<!-- <li><a href="#">Driver Download</a></li> -->
<!-- <li><a href="#">Service Policy</a></li> -->
<!-- </ul> -->
<!-- </nav> -->
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<article>
<h1>Download</h1>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">Title</th>
    <th class="twrite">Writer</th>
    <th class="tdate">Date</th>
    <th class="tread">fileName</th></tr>
<%
FileDAO dao = new FileDAO();
boolean isChecked = false;
int count = dao.countContent();
int pageSize = 3;
String pageNum = request.getParameter("pageNum");
if(pageNum == null)
{
	pageNum = "1";
}
int currentPage = Integer.parseInt(pageNum);

int startRow = (currentPage-1)*pageSize+1;
int endRow = currentPage * pageSize;

ArrayList<FileBean> list = dao.selectAll(startRow,pageSize);
SimpleDateFormat format = new SimpleDateFormat("yy/MM/dd");

for(int i = 0; i < list.size(); i++)
{
	FileBean bb = (FileBean)list.get(i);
	Date date = new Date(bb.getDay().getTime());
	%>
	<tr>
	<td><%=bb.getNum()%></td>
	<td class="left"><a href="content.jsp?num=<%=bb.getNum()%>"><%=bb.getTitle() %></a></td>
	<td><%=bb.getAuthor() %></td>
	<td><%=format.format(date)%></td>
	<td><%=bb.getFile()%></td>	
	</tr>
	<%
}
%>
</table>
<pre></pre>
<input type="button" name="switch" value="Change board" onclick="location.href='board_img.jsp'">
<%
int pageCount = count/pageSize+(count%pageSize==0?0:1);
int pageBlock = 2;

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
	%><a href="board.jsp?pageNum=<%=startPage-pageBlock%>">Prev</a><%
}
%>
<%
for(int i = startPage; i <= endPage; i++)
{%>
<a href="board.jsp?pageNum=<%=i %>"><%=i %></a>

<%}
//다음  끝페이지번호   전체페이지번호
if(endPage < pageCount){
	%><a href="board.jsp?pageNum=<%=startPage+pageBlock%>">Next</a><%
}
%>
</div>
<div id="table_search">
<%
String id=(String)session.getAttribute("id");
if(id != null)
{%>
<input type="button" value="create" class="btn" onclick="location.href='uploadForm.jsp'">
<%}%>
</div>
<div class="clear"></div>

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
