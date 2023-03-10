
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="uuu.ksc.entity.Customer"%>
<html>
<head>
    <link rel="stylesheet" href="index.css">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta charset="UTF-8">
	<title>會員註冊成功</title>
	<script src="https://kit.fontawesome.com/e3d7510046.js"></script>
	<meta http-equiv="refresh" content="5; url=./login.jsp#tab1">	
</head>
<style>
	img{width:100vw;height:100vh}
	h1{    
		position: absolute;
	    top: 0;
	    left: 45%;
	    }
	    a:visited {
	    color:red
	    }
</style>
<body>
<img alt="" src="images/loadingimg.gif">
	<% //Customer member= (Customer)session.getAttribute("member"); 
/* 	String msg =(String)request.getAttribute("msg"); */
	%>
	<header>
			<h1>${requestScope.member.getName()} ${requestScope.msg?"尚未":requestScope.msg}成功</h1>
			<span style="position: absolute;top: 2.5em;left: 55%;">5秒後將自動跳轉<a href='login.jsp#tab1'>登入頁面</a></span>
	</header>

	<article>		
		<%-- <h2><%= member==null?"尚未登入":member.getName() %><%= msg!=null?msg:"" %>成功</h2> --%>
	</article>
</body>
</html>