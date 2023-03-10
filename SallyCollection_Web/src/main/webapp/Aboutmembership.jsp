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
		<div style="height: 580px;background-color: #d3d1ce; width: 30%;">
		<div style="width: 70%; margin: 30px auto;">
			<a href="<%= request.getContextPath() %>/Aboutmembership.jsp"><span  style="color:#6a4d43;;font-size: 20px;margin-right: 20px;">如何加入會員</span>
			<img id="slideRight" style="width:20%;position: relative;top: 8px;" src="images/arrow-right.png"></a>
		</div>	
		<div style="width: 70%; margin: 30px auto;">
			<a href="<%= request.getContextPath() %>/AboutShoppingProcess.jsp"><span style="color:#6a4d43;;font-size: 20px;margin-right: 20px;">購物流程問題</span>
			<img id="slideRight" style="width:20%;position: relative;top: 8px;" src="images/arrow-right.png"></a>
		</div>	
		<div style="width: 70%; margin: 30px auto;">
			<a href="<%= request.getContextPath() %>/AboutReturnExchange.jsp"><span  style="color:#6a4d43;;font-size: 20px;margin-right: 20px;">退換貨及退款</span>
			<img id="slideRight" style="width:20%;position: relative;top: 8px;" src="images/arrow-right.png"></a>
		</div>	
		</div>
       <!-- 內容 -->
       <div style="display:flex;flex-direction: column;width: 100%;">
       <div class="index_h1">
          <h1>Q1. 註冊會員說明</h1>
          <ul>
		       <li>註冊方式：請您點選右上角「登入/註冊」＞＞註冊會員＞＞填寫會員資訊＞＞點選右下角「註冊」按鈕＞＞完成註冊</li>
		       <li>登入方式：請您點選右上角「登入/註冊」＞＞會員登入＞＞選擇商品＞＞填寫您已註冊過的會員資訊，「身份證」或是「Email」、密碼、驗證碼＞＞點選「登入」按鈕＞＞完成登入自動帶到首頁</li>
          </ul>
       </div>
              <div class="index_h1">
          <h1>Q2. 修改會員資訊說明</h1>
          <ul>
		       <li>註冊方式：請您點選右上角「登入/註冊」＞＞註冊會員＞＞填寫會員資訊＞＞點選右下角「註冊」按鈕＞＞完成註冊</li>
		       <li>登入方式：請您點選右上角「登入/註冊」＞＞會員登入＞＞選擇商品＞＞填寫您已註冊過的會員資訊，「身份證」或是「Email」、密碼、驗證碼＞＞點選「登入」按鈕＞＞完成登入自動帶到首頁</li>
          </ul>
       </div>
       </div>
       		       		<div style="height: 580px;background-color:#d3d1ce; width: 30%;"><img alt="" src="<%= request.getContextPath() %>/images/aboutQA.png" style="width: 80%;position: relative;
    top: 30px;left: 30px;"></div>
</div> 
 
 
 
<%@ include file="/subviews/footer.jsp" %>
</body>
</html> 