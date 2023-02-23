<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
        <link rel="stylesheet" href="index.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>找不到檔案</title>
		<script src="https://kit.fontawesome.com/e3d7510046.js"></script>
</head>
<body>
<img style="display:block;width:400px;margin:90px auto 0;" src='<%= request.getContextPath()%>/images/error.jpg'>
<div style="text-align: center;margin-bottom:5%">
	<p>無法連到這個網站</p>
	<span>你輸入為 :</span>
	<span style="color:	#680000;font-weight:bolder;"><%=request.getAttribute("javax.servlet.error.request_uri") %></span>
	<span>請檢查是否有錯字</span>
</div>
      <%@ include file="/subviews/footer.jsp" %>
</body>
</html>