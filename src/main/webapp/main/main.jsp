<%@page import="service.weather"%>
<%@page import="java.util.ArrayList"%>
<%@page import="comment.GuestBookBean"%>
<%@page import="comment.GuestBookDAO"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
<link href="../css/front.css" rel="stylesheet" type="text/css">

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
 <script>
 function mover() {
	 var check;
	 
	check = document.getElementById("weatherTable");
	check.style.display="block";
}
 function outter() {
	 var check;
	 
	check = document.getElementById("weatherTable");
	check.style.display="none";
}
 </script>
</head>
<style>
#main_img{width: 971px; height: 308px;
background-image:url("../images/img_back.png");
background-repeat: no-repeat;
background-position: center top;
transition: all ease 0.5s;
transform-origin: left bottom; 
}
#main_img:hover{
  opacity: 0.5;
  transform:rotateY(45deg); 
  -webkit-transform: rotateY(45deg);
}
/*너비 971px 높이 308px 
배경이미지 img_back.png 반복 no 위치 가운데 위*/
#main_img img{margin: 9px 0 0 0;
 }
</style>
<body>

<div id="wrap">
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더파일들어가는 곳 -->
<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>
<div id="main_img"><img src="../images/main_img2.jpg" width="971" height="282" onmouseover="mover()" onmouseout="outter()">
</div>
<!-- 메인이미지 들어가는곳 -->
<%
request.setCharacterEncoding("utf-8");
weather weaderD = new weather();
// 시간,기온,풍속,강수량,습도
List<String> a = weaderD.checkWeather();
%>
<!-- position: absolute; right:500px; bottom: 650px; -->
<div style="position: absolute; right:500px; bottom: 600px;">
 <table border='1' id='weatherTable' style="display: none;">
 <tr><th colspan="2" style="text-align: center;">어제의 날씨</th></tr>
 <tr><td>시간</td><td><%=a.get(0) %></td></tr>
 <tr><td>기온</td><td><%=a.get(1) %>ºC</td></tr>
 <tr><td>풍속</td><td><%=a.get(2) %>m/s</td></tr>
 <tr><td>강수량</td><td><%=a.get(3) %>mm</td></tr>
 <tr><td>상대습도</td><td><%=a.get(4) %>%</td></tr> 
 </table>
 </div>
<!-- 메인 콘텐츠 들어가는 곳 -->
<article id="front">
<div id="solution">
<div id="hosting">
<h3>Java Programing</h3>
<p>자바는 썬 마이크로시스템즈의 제임스 고슬링과 다른 연구원들이 개발한 객체 지향적 프로그래밍 언어이다. 
</p>
</div>
<div id="security">
<h3>JSP(Java Server Pages)</h3>
<p>Java 언어를 기반으로 하는 Server Side 스크립트 언어이다.</p>
</div>
<div id="payment">
<h3>MySQL</h3>
<p>MySQL은 세계에서 가장 많이 쓰이는 오픈 소스의 관계형 데이터베이스 관리 시스템(RDBMS)이다.</p>
</div>
</div>
<div class="clear"></div>
<div id="sec_news">
<h3>&nbsp;&nbsp;&nbsp;&nbsp;<span class="orange">Comment</span></h3>
<%
GuestBookDAO dao = new GuestBookDAO();
List<GuestBookBean> list = new ArrayList<GuestBookBean>();
list = dao.main();
for(int i = 0; i < list.size(); i++)
{
	GuestBookBean gb = new GuestBookBean();
	gb = list.get(i);
	%>
	<dl>
	<dt><%=gb.getSubject() %></dt>
	<dd><%=gb.getContent() %></dd>
</dl>
<%} %>
</div>
<div id="news_notice">
<h3 class="brown">News &amp; Notice</h3>

<table>
    <%

	BoardDAO bDAO = new BoardDAO();
    List<BoardBean> boardList = bDAO.getMainList();
    
    SimpleDateFormat format = new SimpleDateFormat("yy/mm/dd");
    for(int i = 0; i < boardList.size(); i++)
    {
		BoardBean bb = (BoardBean)boardList.get(i);
		Date date = new Date(bb.getDate().getTime());
		%>
		<tr><td class="contxt"><a href="../center/content.jsp?num=<%=bb.getNum()%>"><%=bb.getSubject() %></a></td>
    	<td><%=format.format(date)%></td></tr>
	<%
	}
    %>
</table>
</div>
</article>
<!-- 메인 콘텐츠 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>