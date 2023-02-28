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
	</head>

    
<body>

   <jsp:include page="/subviews/header.jsp" />  
   <jsp:include page="/subviews/nav.jsp" />
       
       

       <div class="bg_img">
          <div class="bg_txt">
            <h1>New arrivals</h1>
            <p>What you waiting for ? &nbsp; Check out what we made for you !</p>
            <br>
            <a href="products_list.jsp">shop now &nbsp;&nbsp;<i class="fa-solid fa-arrow-right"></i></a>
          </div>
       </div>

       <!-- 內容 -->
       <div class="index_h1">
          <h1>Made by Korea just for you.</h1>
          <p>
          歡迎Lorem ipsum dolor sit amet consectetur adipisicing elit. Praesentium accusantium culpa, maiores commodi iste dolorum. Numquam, alias excepturi. Hic, dolores aperiam enim sit architecto dolor animi? Tempore magni dolorum distinctio?
          </p>
       </div>
        <img src="images/indexdetai.jpg"style="width: 100vw;height: 600px;">       
       <img src="images/hackimg.jpg" style="margin: 0 auto;display: block;">
       <div style="text-align:center">
              <h1>SHOP WITH SALLY</h1>
       <i class="fa-solid fa-truck-fast"style="font-size:60px"></i>
      		 <p>Free express delivery</p>
			 <span>Delivery is free for orders over $150.
		Your products are sent within 1-2 working days.</span>
		<br>
       <i class="fa-solid fa-box-open" style="font-size:60px;margin-top:50px"></i>
              <p>Easy Returns</p>
			  <span>Shop with peace of mind. 14 day returns.</span>
		<br>
       <i class="fa-solid fa-circle-check"style="font-size:60px;margin-top:50px"></i>
              <p>Quality Guarantee</p>
			  <span>We inspect every products before sending your order.</span>
       </div>

        <img src="images/homedetail.jpg" style="margin: 0 auto;display: block;">

<%@ include file="/subviews/footer.jsp" %>
</body>
</html> 