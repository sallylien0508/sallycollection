<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="uuu.ksc.entity.Customer"%>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta charset="UTF-8">
	<title>會員註冊成功</title>
	<link rel="stylesheet" href="css/vgb.css">
	<meta http-equiv="refresh" content="5; url=./">	
</head>
<body>
	<header>
			<h1>
				<a href='./'>非常好書</a> 
				<sub>註冊成功</sub>
			</h1>
	</header>
	<nav>
		<hr>
	</nav>
	<article>		
		<% 
		Customer rmember = (Customer)request.getAttribute("rmember");
		String rmsg = (String)request.getAttribute("rmsg");
		%>
		<h2><%= rmember==null?"尚未註冊":rmember.getName() %> <%= rmsg!=null?rmsg:"" %>成功</h2>
		<p>5秒後將自動跳轉<a href='index.html'>首頁</a></p>
	</article>
	<footer>
		<hr>
		<div class='copyRightDiv'>非常好書&copy;版權所有 2023-01~</div>
	</footer>
</body>
</html>