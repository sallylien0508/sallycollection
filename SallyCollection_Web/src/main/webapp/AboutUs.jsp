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
			<a href="<%= request.getContextPath() %>/Aboutmembership.jsp"><span>如何加入會員</span></a>
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
          <h1>Nice To Meet Sally's Collection?</h1>
          <p>
       Sally's Collection 由 Sally 於 2023 年創建。 我們是一群在首爾開始我們旅程的韓國時尚愛好者。 多年來，Sally's Collection 與世界各地的 K-fashion 愛好者建立了聯繫。
          </p>
       </div>
       <div class="index_h1">
          <h1>Made by Korea just for you.</h1>
          <p>
          “Nice to meet  Sally's Collection” Sally's Collection 向世界介紹了韓國時尚，為您的衣櫥帶來一股清新的空氣。獨特的剪裁、吸睛的圖案、奇特的造型，每一件單品都為升級版的自己而生！你準備好與眾不同了嗎？
          </p>
       </div>
       </div>
       		<div style="height: 580px;background-color: #9c898361; width: 30%;"></div>
</div> 
 
 
 
<%@ include file="/subviews/footer.jsp" %>
</body>
</html> 