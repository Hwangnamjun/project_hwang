<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
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
<h1>Notice</h1>
<table id="notice">
<tr><th class="tno">No.</th>
    <th class="ttitle">Title</th>
    <th class="twrite">Writer</th>
    <th class="tdate">Date</th>
    <th class="tread">Read</th></tr>
    <%
    String search = request.getParameter("search");

	BoardDAO bDAO = new BoardDAO();
    int count = bDAO.countContent(search);
    int pageSize = 3;
    String pageNum = request.getParameter("pageNum");
    if(pageNum == null)
    {
    	pageNum = "1";
    }
    int currentPage = Integer.parseInt(pageNum);
    
    int startRow = (currentPage-1)*pageSize+1;
    int endRow = currentPage * pageSize;
    
    
    List<BoardBean> boardList = bDAO.getBoardList(startRow,pageSize,search);
    
    SimpleDateFormat format = new SimpleDateFormat("yy/MM/dd");
    for(int i = 0; i < boardList.size(); i++)
    {
		BoardBean bb = (BoardBean)boardList.get(i);
		Date date = new Date(bb.getDate().getTime());
		%>
		<tr>
		<td><%=bb.getNum()%></td>
		<td class="left"><a href="content.jsp?num=<%=bb.getNum()%>"><%=bb.getSubject() %></a></td>
		<td><%=bb.getName() %></td>
		<td><%=format.format(date)%></td>
		<td><%=bb.getReadcount() %></td>
		</tr>
		<%
	}
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
	%><a href="notice.jsp?pageNum=<%=startPage-pageBlock%>">Prev</a><%
}
%>
<%
for(int i = startPage; i <= endPage; i++)
{%>

<a href="notice.jsp?pageNum=<%=i %>"><%=i %></a>

<%}
//다음  끝페이지번호   전체페이지번호
if(endPage < pageCount){
	%><a href="notice.jsp?pageNum=<%=startPage+pageBlock%>">Next</a><%
}
%>
</div>
<div id="table_search">
<form action="notice.jsp" method="post">
<input type="text" name="search" class="input_box">
<input type="submit" value="search" class="btn">
</form>
<%
String id=(String)session.getAttribute("id");
if(id != null)
{%>
<input type="button" value="create" class="btn" onclick="location.href='writeForm.jsp'">	
<%}
%>
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