<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
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
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">Join us</a></li>
<li><a href="#">Privacy policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>Update</h1>
<script type="text/javascript">
function setChildValue(name){

    document.getElementById("childValue").value = name;

}
function setIdValue(id) {
	console.log(id);
    document.getElementById("checkedID").value = id;
}
</script>
<%
String id=(String)session.getAttribute("id");

request.setCharacterEncoding("utf-8");
MemberDAO mDAO = new MemberDAO();
MemberBean mb = mDAO.getMember(id);
%>
<form action="updatePro.jsp" id="join" method="post">
<fieldset>
<legend>Basic Info</legend>
<label>User ID</label>
<input type="text" name="id" value=<%=id %> readonly="readonly"><br>
<label>new Password</label>
<input type="password" name="pass"><br>
<div class="clear"></div>
<label>Name</label>
<input type="text" name="name" value=<%=mb.getName() %>><br>
<label>E-Mail</label>
<input type="email" name="email" value=<%=mb.getEmail() %>><br>
</fieldset>

<fieldset>
<legend>Optional</legend>
<label>Address</label>
<textarea rows="1" cols="40" id="childValue" name="address"  readonly="readonly" style="resize: none;"><%=mb.getAddress() %></textarea>
<input type="button" value="Search" class="dup" onclick="window.open('Search.jsp','preview','width=400px,height=200px')"><br>
<label>Phone Number</label>
<input type="text" name="phone" value=<%=mb.getPhone() %>><br>
<label>Mobile Phone Number</label>
<input type="text" name="mobile" value=<%=mb.getMobile() %>><br>
</fieldset>

<fieldset>
<legend>Checked</legend>
<label>checked Password</label>
<input type="password" name="pass2"><br>
<div class="clear"></div>
</fieldset>

<div id="buttons">
<input type="submit" value="Submit" class="submit">
<input type="button" value="Cancel" class="cancel" onclick="location.href='../main/main.jsp';">
</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>