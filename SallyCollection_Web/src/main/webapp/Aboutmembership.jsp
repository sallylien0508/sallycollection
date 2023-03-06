<%@page import="uuu.ksc.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
        <link rel="stylesheet" href="index.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>sally's collection</title>
        <script src="https://kit.fontawesome.com/e3d7510046.js"></script>
        <script src="https://code.jquery.com/jquery-3.0.0.js" integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" crossorigin="anonymous"></script>
	<script>
		$(document).ready(function(){
		  $("#memberName").click(function(){
		   /*  $(".sidebar").toggle(); */
		  $(".sidebar").slideToggle();
		   
		  });
		});
</script>
<style>
.index_h1{
    margin: 0 10%;
    width: 80%;
    text-align: left;
}
</style>
	</head>

    
<body>

   <jsp:include page="/subviews/header.jsp" />  
   <jsp:include page="/subviews/nav.jsp" />
      <p style="margin: 120px auto 2px;width: 50%;border-bottom: #111010f0 dotted;">About Us</p>
<div style="display:flex">     
		<div style="height: 580px;background-color: #9c898361; width: 30%;">
		<div style="width: 50%; margin: 30px auto;">
			<a><span>如何加入會員</span></a>
			<img id="slideRight" style="width:20%" src="images/arrow-right.png">
		</div>	
		<div style="width: 50%; margin: 30px auto;">
			<a><span>購物流程問題</span></a>
			<img id="slideRight" style="width:20%" src="images/arrow-right.png">
		</div>	
		<div style="width: 50%; margin: 30px auto;">
			<a><span>退換貨及退款</span></a>
			<img id="slideRight" style="width:20%" src="images/arrow-right.png">
		</div>	
		</div>
       <!-- 內容 -->
       <div style="display:flex;flex-direction: column;">
       
       <div class="index_h1">
          <h1>Made by Korea just for you.</h1>
         
       </div>
       </div>
       		<div style="height: 580px;background-color: #9c898361; width: 30%;"></div>
</div> 
 
 
 
<%@ include file="/subviews/footer.jsp" %>
</body>
</html> 