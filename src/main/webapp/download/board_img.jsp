<%@page import="java.io.IOException"%>
<%@page import="java.awt.Image"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.File"%>
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
<table border="1">
<tr>
<%
FileDAO dao = new FileDAO();
boolean isChecked = false;
int count = dao.countContent();
int pageSize = 6;
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
int countline = 0;

for(int i = 0; i < list.size(); i++)
{
	FileBean bb = (FileBean)list.get(i);
	Date date = new Date(bb.getDay().getTime());
	%>
	<td><table>
	<tr>
	<%
	String pictureFormat[] = {"jpg", "png", "bmp", "jpeg", "tiff", "raw"};
	for(int a = 0; a < pictureFormat.length; a++){
	if(bb.getFile().toLowerCase().contains(pictureFormat[a])){
		String path = request.getRealPath("/Upload");

		String oPath = path+"\\"+bb.getFile();
		File oFile = new File(oPath);
		int index = oPath.lastIndexOf(".");
		String ext = oPath.substring(index + 1); // 파일 확장자

		String tPath = oFile.getParent() + File.separator + "t-" + oFile.getName(); // 썸네일저장 경로
		File tFile = new File(tPath);

		double ratio = 2; // 이미지 축소 비율
		BufferedImage oImage = ImageIO.read(oFile);
		int tWidth = 100; // 생성할 썸네일이미지의 너비
		int tHeight = 100; // 생성할 썸네일이미지의 높이
		BufferedImage tImage = new BufferedImage(tWidth, tHeight, BufferedImage.TYPE_3BYTE_BGR); // 썸네일이미지
		Graphics2D graphic = tImage.createGraphics();
		Image image = oImage.getScaledInstance(tWidth, tHeight, Image.SCALE_SMOOTH);
		graphic.drawImage(image, 0, 0, tWidth, tHeight, null);
		graphic.dispose(); // 리소스를 모두 해제
		ImageIO.write(tImage, ext, tFile);
	%>
		<td colspan="2" rowspan="2" class="left"><a href="content.jsp?num=<%=bb.getNum()%>">
		<img src="${pageContext.request.contextPath}/Upload/t-<%=bb.getFile()%>" width="150px" height="150px"></a></td>
	<%
	break;
	}
	else if(!(bb.getFile().contains(pictureFormat[a])) && a == pictureFormat.length-1)
	{%>
		<td colspan="2" rowspan="2" class="left"><a href="content.jsp?num=<%=bb.getNum()%>">
		<img src="../images/no_image.jpg" width="150px" height="150px"></a></td>
	<%
	break;
	}
	}
	%>
	</table>
	<table border="1" style="border: 2px;">
	<tr><td><%=bb.getNum() %></td><td><%=format.format(date)%></td></tr>
	<tr><td><%=bb.getAuthor() %></td><td><%=bb.getFile()%></td></tr>
	</table></td>
	<%
		if(countline == 2)
	{
			countline = 0;
	%>
		</tr><tr>
	<%}
		else
		{
			countline++;
		}
}
	%>
</tr>
</table>
<pre></pre>
<input type="button" name="switch" value="Change board" onclick="location.href='board.jsp'">
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
	%><a href="board_img.jsp?pageNum=<%=startPage-pageBlock%>">Prev</a><%
}
%>
<%
for(int i = startPage; i <= endPage; i++)
{%>
<a href="board_img.jsp?pageNum=<%=i %>"><%=i %></a>
<%}
//다음  끝페이지번호   전체페이지번호
if(endPage < pageCount){
	%><a href="board_img.jsp?pageNum=<%=startPage+pageBlock%>">Next</a><%
}
%>
</div>
<div id="table_search">
<input type="button" value="create" class="btn" onclick="location.href='uploadForm.jsp'">
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
